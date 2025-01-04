#version 450
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

layout(std140, binding = 1) buffer Block
{
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(1.0, -6.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(0.0, -6.0, -1.0, 7.0));
}
#version 450
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

	var[0] = (vec4(-1.0, 9.0, -3.0, 7.0));
	var[1] = (vec4(1.0, -1.0, 6.0, 9.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], 6.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-6.0, 0.0, 1.0, 2.0));
	var[1] = (vec4(6.0, -4.0, 2.0, -7.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-2.0, 4.0, 1.0, -8.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(9.0, 0.0));
	var[1] = (vec2(-3.0, -2.0));
	var[2] = (vec2(-8.0, -6.0));
}
#version 450
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

	var[0] = (vec2(-9.0, 8.0));
	var[1] = (vec2(0.0, 8.0));
	var[2] = (vec2(-7.0, -2.0));
}
#version 450
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

	var[0] = (vec4(5.0, 8.0, -6.0, 0.0));
	var[1] = (vec4(6.0, -2.0, 8.0, -8.0));
	var[2] = (vec4(4.0, -8.0, -3.0, -9.0));
}
#version 450
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

	var = (mat3x4(3.0, -9.0, -2.0, 8.0, -8.0, -1.0, 8.0, 1.0, -5.0, -8.0, -1.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(-4.0, 8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(4.0, 9.0, 2.0, 7.0, -6.0, -9.0, 2.0, -3.0, 1.0, 4.0, 3.0, 2.0));
}
#version 450
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

	var[0] = (vec4(9.0, 0.0, -4.0, 9.0));
	var[1] = (vec4(-6.0, 6.0, -7.0, -9.0));
	var[2] = (vec4(-7.0, 0.0, -5.0, -8.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(6.0, 4.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(5.0, -5.0));
	var[1] = (vec2(-3.0, 5.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var[0] = (vec4(3.0, 5.0, -1.0, -5.0));
	var[1] = (vec4(4.0, 2.0, 8.0, -7.0));
	var[2] = (vec4(-2.0, 6.0, -3.0, -1.0));
	var[3] = (vec4(-2.0, 5.0, 7.0, 1.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 4.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-3.0, -5.0, -7.0));
	var[1] = (vec3(-3.0, 1.0, -6.0));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(5.0, 3.0, -9.0, 3.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(0.0, -4.0, -4.0, 3.0, -2.0, 8.0));
}
#version 450
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

	var = (mat2x4(1.0, -8.0, -5.0, -2.0, 9.0, 1.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-5.0, 5.0, 7.0, -1.0, -3.0, 6.0, 9.0, -7.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], 8.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-5.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(9.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(1.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(0.0, 7.0, -1.0, 6.0, -7.0, 7.0, -9.0, -9.0, 4.0, 1.0, 2.0, -2.0));
}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], -3.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_float(var[2][3], -1.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], 9.0) && allOk;
	allOk = compare_float(var[3][3], 8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, -3.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-4.0, 5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var = (mat4(-2.0, 8.0, -6.0, -2.0, -6.0, 7.0, 0.0, -1.0, 4.0, -8.0, 7.0, -1.0, -3.0, -6.0, -5.0, -3.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[2][0], 0.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0] = (vec2(3.0, -8.0));
	var[1] = (vec2(-8.0, -6.0));
	var[2] = (vec2(2.0, -7.0));
}
#version 450
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
	uint16_t var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = uint16_t(9u);
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(5.0, -4.0));
	var[0][1] = (vec2(5.0, 1.0));
	var[1][0] = (vec2(-8.0, -1.0));
	var[1][1] = (vec2(9.0, -8.0));
	var[2][0] = (vec2(5.0, -4.0));
	var[2][1] = (vec2(5.0, -2.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
}
#version 450
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
	highp vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[2] = (vec4(5.0, -9.0, 4.0, -1.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2(var[0], mat2(3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(2.0, 1.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, 4.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0] = (vec2(-4.0, 5.0));
	var[0][1] = (vec2(1.0, -8.0));
	var[1][0] = (vec2(-1.0, 9.0));
	var[1][1] = (vec2(-8.0, 5.0));
	var[2][0] = (vec2(-4.0, 5.0));
	var[2][1] = (vec2(-2.0, 9.0));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(2.0, -3.0, -5.0, -8.0, -3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-6.0, 9.0, 2.0, -1.0, 8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-7.0, -3.0, 8.0, 0.0, -1.0, -5.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (mat2x4(2.0, -2.0, 9.0, -4.0, 3.0, 2.0, -4.0, 0.0));
	var[1] = (mat2x4(6.0, 0.0, -1.0, -8.0, 7.0, 4.0, -8.0, 2.0));
	var[2] = (mat2x4(5.0, 4.0, -3.0, 4.0, 8.0, 2.0, 4.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0] = (vec2(-2.0, 2.0));
	var[0][1] = (vec2(8.0, -5.0));
	var[0][2] = (vec2(3.0, -1.0));
	var[0][3] = (vec2(-7.0, 4.0));
	var[1][0] = (vec2(2.0, -4.0));
	var[1][1] = (vec2(8.0, 3.0));
	var[1][2] = (vec2(8.0, -1.0));
	var[1][3] = (vec2(6.0, -8.0));
	var[2][0] = (vec2(2.0, -5.0));
	var[2][1] = (vec2(5.0, -4.0));
	var[2][2] = (vec2(-9.0, 0.0));
	var[2][3] = (vec2(4.0, 8.0));
}
#version 450
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
	highp float var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0]), 7.0) && allOk;
	allOk = compare_float((var[1]), -1.0) && allOk;
	allOk = compare_float((var[2]), -6.0) && allOk;
	allOk = compare_float((var[3]), 0.0) && allOk;
	allOk = compare_float((var[4]), -7.0) && allOk;
	allOk = compare_float((var[5]), 5.0) && allOk;
	allOk = compare_float((var[6]), 4.0) && allOk;
	allOk = compare_float((var[7]), 2.0) && allOk;
	allOk = compare_float((var[8]), -1.0) && allOk;
	allOk = compare_float((var[9]), -6.0) && allOk;
	allOk = compare_float((var[10]), -2.0) && allOk;
	allOk = compare_float((var[11]), -1.0) && allOk;
	allOk = compare_float((var[12]), 1.0) && allOk;
	allOk = compare_float((var[13]), -3.0) && allOk;
	allOk = compare_float((var[14]), -7.0) && allOk;
	allOk = compare_float((var[15]), 8.0) && allOk;
	allOk = compare_float((var[16]), -9.0) && allOk;
	allOk = compare_float((var[17]), -4.0) && allOk;
	allOk = compare_float((var[18]), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (-2.0);
	var[1] = (4.0);
	var[2] = (6.0);
	var[3] = (7.0);
	var[4] = (-4.0);
	var[5] = (5.0);
	var[6] = (-8.0);
	var[7] = (9.0);
	var[8] = (-5.0);
	var[9] = (8.0);
	var[10] = (-5.0);
	var[11] = (6.0);
	var[12] = (-6.0);
	var[13] = (-9.0);
	var[14] = (-4.0);
	var[15] = (3.0);
	var[16] = (7.0);
	var[17] = (6.0);
	var[18] = (5.0);
}
#version 450
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

	var[0] = (ivec2(-6, 8));
	var[1] = (ivec2(3, -1));
	var[2] = (ivec2(-5, -2));
	var[3] = (ivec2(0, -2));
	var[4] = (ivec2(5, 2));
	var[5] = (ivec2(-8, 4));
	var[6] = (ivec2(-6, -4));
	var[7] = (ivec2(3, -2));
	var[8] = (ivec2(5, -7));
	var[9] = (ivec2(-3, 4));
	var[10] = (ivec2(1, 6));
	var[11] = (ivec2(8, 7));
	var[12] = (ivec2(4, 1));
	var[13] = (ivec2(1, 9));
	var[14] = (ivec2(-2, -9));
	var[15] = (ivec2(9, 6));
	var[16] = (ivec2(-8, 1));
	var[17] = (ivec2(-3, 2));
	var[18] = (ivec2(-3, -1));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

	var[0] = uint16_t(9u);
	var[1] = uint16_t(1u);
	var[2] = uint16_t(1u);
	var[3] = uint16_t(0u);
	var[4] = uint16_t(7u);
	var[5] = uint16_t(5u);
	var[6] = uint16_t(8u);
	var[7] = uint16_t(1u);
	var[8] = uint16_t(9u);
	var[9] = uint16_t(7u);
	var[10] = uint16_t(2u);
	var[11] = uint16_t(6u);
	var[12] = uint16_t(3u);
	var[13] = uint16_t(1u);
	var[14] = uint16_t(0u);
	var[15] = uint16_t(2u);
	var[16] = uint16_t(1u);
	var[17] = uint16_t(1u);
	var[18] = uint16_t(2u);
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
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

	var[0][0] = (vec3(0.0, 5.0, 5.0));
	var[0][1] = (vec3(0.0, -7.0, 8.0));
	var[1][0] = (vec3(-7.0, -4.0, 6.0));
	var[1][1] = (vec3(1.0, 3.0, 2.0));
	var[2][0] = (vec3(-6.0, 5.0, 2.0));
	var[2][1] = (vec3(1.0, 8.0, -8.0));
	var[3][0] = (vec3(2.0, -7.0, 5.0));
	var[3][1] = (vec3(-4.0, -6.0, -9.0));
	var[4][0] = (vec3(3.0, 0.0, -7.0));
	var[4][1] = (vec3(2.0, -4.0, 1.0));
	var[5][0] = (vec3(-2.0, -2.0, -5.0));
	var[5][1] = (vec3(2.0, 5.0, 4.0));
	var[6][0] = (vec3(4.0, -1.0, 7.0));
	var[6][1] = (vec3(9.0, -2.0, -4.0));
	var[7][0] = (vec3(8.0, -4.0, 2.0));
	var[7][1] = (vec3(5.0, -1.0, -3.0));
	var[8][0] = (vec3(3.0, -2.0, -8.0));
	var[8][1] = (vec3(6.0, 0.0, 9.0));
	var[9][0] = (vec3(1.0, -5.0, -1.0));
	var[9][1] = (vec3(-6.0, -6.0, 3.0));
	var[10][0] = (vec3(1.0, -8.0, -5.0));
	var[10][1] = (vec3(8.0, 5.0, 8.0));
	var[11][0] = (vec3(5.0, 5.0, 7.0));
	var[11][1] = (vec3(-9.0, 8.0, 0.0));
	var[12][0] = (vec3(8.0, 7.0, -1.0));
	var[12][1] = (vec3(-6.0, 1.0, -2.0));
	var[13][0] = (vec3(8.0, -6.0, -8.0));
	var[13][1] = (vec3(9.0, -5.0, 5.0));
	var[14][0] = (vec3(-8.0, 1.0, -3.0));
	var[14][1] = (vec3(-4.0, -5.0, 1.0));
	var[15][0] = (vec3(4.0, -2.0, -5.0));
	var[15][1] = (vec3(-9.0, -8.0, -5.0));
	var[16][0] = (vec3(5.0, 9.0, 6.0));
	var[16][1] = (vec3(7.0, 5.0, 7.0));
	var[17][0] = (vec3(0.0, 9.0, -4.0));
	var[17][1] = (vec3(7.0, -3.0, 7.0));
	var[18][0] = (vec3(5.0, -5.0, 1.0));
	var[18][1] = (vec3(9.0, 2.0, -6.0));
}
#version 450
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
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
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
	var[3][0] = (vec2(8.0, 2.0));
	var[3][1] = (vec2(-3.0, 2.0));
	var[3][2] = (vec2(-4.0, -4.0));
	var[3][3] = (vec2(2.0, -8.0));
	var[4][0] = (vec2(-4.0, 8.0));
	var[4][1] = (vec2(5.0, 7.0));
	var[4][2] = (vec2(-4.0, 6.0));
	var[4][3] = (vec2(8.0, 4.0));
	var[5][0] = (vec2(-9.0, -7.0));
	var[5][1] = (vec2(7.0, -5.0));
	var[5][2] = (vec2(1.0, -9.0));
	var[5][3] = (vec2(9.0, 5.0));
	var[6][0] = (vec2(7.0, 3.0));
	var[6][1] = (vec2(3.0, 3.0));
	var[6][2] = (vec2(-5.0, -9.0));
	var[6][3] = (vec2(2.0, 9.0));
	var[7][0] = (vec2(3.0, 8.0));
	var[7][1] = (vec2(3.0, -4.0));
	var[7][2] = (vec2(6.0, 1.0));
	var[7][3] = (vec2(-3.0, 1.0));
	var[8][0] = (vec2(-5.0, -2.0));
	var[8][1] = (vec2(7.0, 8.0));
	var[8][2] = (vec2(4.0, 7.0));
	var[8][3] = (vec2(-1.0, -8.0));
	var[9][0] = (vec2(-6.0, -6.0));
	var[9][1] = (vec2(-4.0, -2.0));
	var[9][2] = (vec2(3.0, 8.0));
	var[9][3] = (vec2(4.0, 4.0));
	var[10][0] = (vec2(-7.0, -6.0));
	var[10][1] = (vec2(8.0, -6.0));
	var[10][2] = (vec2(8.0, -3.0));
	var[10][3] = (vec2(-7.0, 0.0));
	var[11][0] = (vec2(-9.0, 2.0));
	var[11][1] = (vec2(-9.0, 7.0));
	var[11][2] = (vec2(-2.0, 2.0));
	var[11][3] = (vec2(-6.0, -1.0));
	var[12][0] = (vec2(1.0, 7.0));
	var[12][1] = (vec2(0.0, -4.0));
	var[12][2] = (vec2(-1.0, 5.0));
	var[12][3] = (vec2(9.0, -8.0));
	var[13][0] = (vec2(-3.0, 8.0));
	var[13][1] = (vec2(-1.0, 7.0));
	var[13][2] = (vec2(5.0, -7.0));
	var[13][3] = (vec2(8.0, 0.0));
	var[14][0] = (vec2(-5.0, 7.0));
	var[14][1] = (vec2(8.0, 9.0));
	var[14][2] = (vec2(8.0, 9.0));
	var[14][3] = (vec2(1.0, 9.0));
	var[15][0] = (vec2(-9.0, 8.0));
	var[15][1] = (vec2(-2.0, 9.0));
	var[15][2] = (vec2(6.0, 6.0));
	var[15][3] = (vec2(3.0, -5.0));
	var[16][0] = (vec2(1.0, -4.0));
	var[16][1] = (vec2(-5.0, 7.0));
	var[16][2] = (vec2(-8.0, 7.0));
	var[16][3] = (vec2(-1.0, -1.0));
	var[17][0] = (vec2(-2.0, -7.0));
	var[17][1] = (vec2(4.0, -8.0));
	var[17][2] = (vec2(2.0, 4.0));
	var[17][3] = (vec2(3.0, 1.0));
	var[18][0] = (vec2(7.0, 8.0));
	var[18][1] = (vec2(2.0, -9.0));
	var[18][2] = (vec2(-8.0, -9.0));
	var[18][3] = (vec2(-1.0, -3.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[0][2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	var[1][0] = (mat2(-6.0, -7.0, 1.0, -1.0));
	var[1][1] = (mat2(6.0, 2.0, -7.0, 8.0));
	var[1][2] = (mat2(-3.0, -2.0, 2.0, -7.0));
	var[2][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	var[2][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	var[2][2] = (mat2(4.0, -2.0, -7.0, 4.0));
	var[3][0] = (mat2(-7.0, -5.0, -7.0, -5.0));
	var[3][1] = (mat2(-6.0, 4.0, 6.0, 4.0));
	var[3][2] = (mat2(2.0, -1.0, 9.0, 6.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	var[0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	var[0][2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	var[1][0] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	var[1][1] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	var[1][2] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	var[2][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	var[2][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	var[2][2] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	var[3][0] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	var[3][1] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	var[3][2] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(0.0, 6.0, 4.0, 7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(1.0, 7.0, -4.0, 9.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-2.0, -4.0, 6.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(5.0, 2.0, -9.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(7.0, 6.0, -9.0, -3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(0.0, -2.0, 3.0, 7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-1.0, 6.0, -5.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(9.0, -3.0, -7.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-7.0, 0.0, 2.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(9.0, -8.0, -8.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(3.0, -3.0, -1.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(3.0, -8.0, 4.0, 0.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var[0][0][0] = (vec2(-7.0, 8.0));
	var[0][0][1] = (vec2(-2.0, -9.0));
	var[0][0][2] = (vec2(-4.0, -1.0));
	var[0][1][0] = (vec2(-3.0, -3.0));
	var[0][1][1] = (vec2(-8.0, 2.0));
	var[0][1][2] = (vec2(7.0, -2.0));
	var[0][2][0] = (vec2(-3.0, -3.0));
	var[0][2][1] = (vec2(-4.0, 5.0));
	var[0][2][2] = (vec2(-1.0, 9.0));
	var[1][0][0] = (vec2(-4.0, 7.0));
	var[1][0][1] = (vec2(1.0, 6.0));
	var[1][0][2] = (vec2(7.0, -8.0));
	var[1][1][0] = (vec2(8.0, 1.0));
	var[1][1][1] = (vec2(6.0, 8.0));
	var[1][1][2] = (vec2(9.0, -1.0));
	var[1][2][0] = (vec2(1.0, -1.0));
	var[1][2][1] = (vec2(0.0, 3.0));
	var[1][2][2] = (vec2(2.0, -3.0));
	var[2][0][0] = (vec2(-9.0, -8.0));
	var[2][0][1] = (vec2(-8.0, 4.0));
	var[2][0][2] = (vec2(-2.0, -2.0));
	var[2][1][0] = (vec2(-1.0, 3.0));
	var[2][1][1] = (vec2(-2.0, 9.0));
	var[2][1][2] = (vec2(9.0, -2.0));
	var[2][2][0] = (vec2(-1.0, 9.0));
	var[2][2][1] = (vec2(-9.0, -4.0));
	var[2][2][2] = (vec2(-4.0, -3.0));
	var[3][0][0] = (vec2(7.0, -5.0));
	var[3][0][1] = (vec2(-5.0, 0.0));
	var[3][0][2] = (vec2(-2.0, 4.0));
	var[3][1][0] = (vec2(5.0, 5.0));
	var[3][1][1] = (vec2(2.0, -3.0));
	var[3][1][2] = (vec2(-4.0, -5.0));
	var[3][2][0] = (vec2(-7.0, 6.0));
	var[3][2][1] = (vec2(-6.0, 8.0));
	var[3][2][2] = (vec2(-3.0, 9.0));
}
#version 450
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
	uint16_t var[4][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(9u);
	var[0][0] = uint16_t(1u);
	var[0][1] = uint16_t(1u);
	var[0][2] = uint16_t(0u);
	var[1][0] = uint16_t(7u);
	var[1][1] = uint16_t(5u);
	var[1][2] = uint16_t(8u);
	var[2][0] = uint16_t(1u);
	var[2][1] = uint16_t(9u);
	var[2][2] = uint16_t(7u);
	var[3][0] = uint16_t(2u);
	var[3][1] = uint16_t(6u);
	var[3][2] = uint16_t(3u);
}
#version 450
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
	u16vec3 var[4][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][2]), uvec3(1u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0]), uvec3(4u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1]), uvec3(7u, 2u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][2]), uvec3(0u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0]), uvec3(8u, 6u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1]), uvec3(6u, 1u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][2]), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0]), uvec3(0u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1]), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][2]), uvec3(6u, 3u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(1u);
	var[0][0] = u16vec3(uvec3(2u, 6u, 8u));
	var[0][1] = u16vec3(uvec3(3u, 3u, 4u));
	var[0][2] = u16vec3(uvec3(4u, 9u, 7u));
	var[1][0] = u16vec3(uvec3(5u, 4u, 5u));
	var[1][1] = u16vec3(uvec3(6u, 5u, 7u));
	var[1][2] = u16vec3(uvec3(0u, 6u, 4u));
	var[2][0] = u16vec3(uvec3(7u, 0u, 4u));
	var[2][1] = u16vec3(uvec3(2u, 1u, 0u));
	var[2][2] = u16vec3(uvec3(2u, 8u, 0u));
	var[3][0] = u16vec3(uvec3(7u, 0u, 2u));
	var[3][1] = u16vec3(uvec3(8u, 7u, 1u));
	var[3][2] = u16vec3(uvec3(2u, 8u, 1u));
}
#version 450
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
	i16vec4 var[4][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0]), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1]), ivec4(-8, 8, 9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][2]), ivec4(4, 0, 9, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0]), ivec4(-4, -9, -3, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1]), ivec4(-1, 4, -1, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][2]), ivec4(7, -4, 7, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0]), ivec4(9, 9, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1]), ivec4(-8, -7, 3, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][2]), ivec4(-2, -8, -7, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0]), ivec4(6, 9, -6, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1]), ivec4(-3, 9, 7, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][2]), ivec4(8, -6, -2, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(-4);
	var[0][0] = i16vec4(ivec4(-8, -4, 9, 2));
	var[0][1] = i16vec4(ivec4(7, -4, 4, 8));
	var[0][2] = i16vec4(ivec4(9, 5, 1, -3));
	var[1][0] = i16vec4(ivec4(3, 8, 7, 2));
	var[1][1] = i16vec4(ivec4(6, -9, 9, -2));
	var[1][2] = i16vec4(ivec4(4, -8, -7, -9));
	var[2][0] = i16vec4(ivec4(-1, -8, -1, -1));
	var[2][1] = i16vec4(ivec4(-6, 5, 2, -3));
	var[2][2] = i16vec4(ivec4(8, -7, -2, 9));
	var[3][0] = i16vec4(ivec4(7, 6, -9, 5));
	var[3][1] = i16vec4(ivec4(-3, 8, 5, -6));
	var[3][2] = i16vec4(ivec4(-9, -6, 2, 7));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[0][0][2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	var[0][1][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	var[0][1][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	var[0][1][2] = (mat2(9.0, -8.0, -6.0, -9.0));
	var[1][0][0] = (mat2(-6.0, -7.0, 1.0, -1.0));
	var[1][0][1] = (mat2(6.0, 2.0, -7.0, 8.0));
	var[1][0][2] = (mat2(-3.0, -2.0, 2.0, -7.0));
	var[1][1][0] = (mat2(-6.0, 8.0, 1.0, -2.0));
	var[1][1][1] = (mat2(-4.0, -5.0, -4.0, 2.0));
	var[1][1][2] = (mat2(4.0, -9.0, 8.0, -9.0));
	var[2][0][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	var[2][0][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	var[2][0][2] = (mat2(4.0, -2.0, -7.0, 4.0));
	var[2][1][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	var[2][1][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	var[2][1][2] = (mat2(-9.0, 7.0, -7.0, 5.0));
	var[3][0][0] = (mat2(-7.0, -5.0, -7.0, -5.0));
	var[3][0][1] = (mat2(-6.0, 4.0, 6.0, 4.0));
	var[3][0][2] = (mat2(2.0, -1.0, 9.0, 6.0));
	var[3][1][0] = (mat2(-9.0, -6.0, -9.0, 3.0));
	var[3][1][1] = (mat2(4.0, -2.0, 0.0, -7.0));
	var[3][1][2] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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
	i16vec3 var[4][2][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][0]), ivec3(4, 8, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][1]), ivec3(-4, 0, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][2]), ivec3(-5, -9, 9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][0]), ivec3(-2, -7, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][1]), ivec3(6, -1, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][2]), ivec3(-6, -9, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][0]), ivec3(4, 2, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][1]), ivec3(6, -2, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][2]), ivec3(-1, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][0]), ivec3(-9, -4, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][1]), ivec3(-7, -2, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][2]), ivec3(6, 2, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][0]), ivec3(-4, -8, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][1]), ivec3(-8, 6, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][2]), ivec3(-3, 3, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][0]), ivec3(2, 1, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][1]), ivec3(3, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][2]), ivec3(4, -7, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0][0]), ivec3(0, -1, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0][1]), ivec3(1, 0, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0][2]), ivec3(5, 1, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1][0]), ivec3(8, -9, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1][1]), ivec3(-6, -7, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1][2]), ivec3(-5, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var[0][0][0] = i16vec3(ivec3(1, -2, -3));
	var[0][0][1] = i16vec3(ivec3(-1, -4, -2));
	var[0][0][2] = i16vec3(ivec3(-2, 2, 0));
	var[0][1][0] = i16vec3(ivec3(7, -4, -8));
	var[0][1][1] = i16vec3(ivec3(4, 1, 5));
	var[0][1][2] = i16vec3(ivec3(-4, -6, -6));
	var[1][0][0] = i16vec3(ivec3(-6, -2, 0));
	var[1][0][1] = i16vec3(ivec3(-9, 2, -8));
	var[1][0][2] = i16vec3(ivec3(6, 2, -5));
	var[1][1][0] = i16vec3(ivec3(2, -7, -2));
	var[1][1][1] = i16vec3(ivec3(2, -5, -3));
	var[1][1][2] = i16vec3(ivec3(-1, 0, -6));
	var[2][0][0] = i16vec3(ivec3(-4, -8, 0));
	var[2][0][1] = i16vec3(ivec3(9, 6, 5));
	var[2][0][2] = i16vec3(ivec3(-3, 4, -3));
	var[2][1][0] = i16vec3(ivec3(9, -3, 6));
	var[2][1][1] = i16vec3(ivec3(8, 2, 7));
	var[2][1][2] = i16vec3(ivec3(-2, 2, 5));
	var[3][0][0] = i16vec3(ivec3(9, 0, 1));
	var[3][0][1] = i16vec3(ivec3(-5, 8, -5));
	var[3][0][2] = i16vec3(ivec3(0, 7, -6));
	var[3][1][0] = i16vec3(ivec3(-9, -7, 4));
	var[3][1][1] = i16vec3(ivec3(-3, -4, -6));
	var[3][1][2] = i16vec3(ivec3(-4, -6, -4));
}
#version 450
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
	f16vec2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][2]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][0]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][1]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][2]), vec2(-4.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][1]), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][2]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][0]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][1]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][2]), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][0]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][1]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][2]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][0]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][1]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][2]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][1]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][2]), vec2(8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(-2.0);
	var[0][0][0] = f16vec2(vec2(4.0, -2.0));
	var[0][0][1] = f16vec2(vec2(4.0, -1.0));
	var[0][0][2] = f16vec2(vec2(1.0, 9.0));
	var[0][1][0] = f16vec2(vec2(0.0, 3.0));
	var[0][1][1] = f16vec2(vec2(5.0, 9.0));
	var[0][1][2] = f16vec2(vec2(-9.0, -6.0));
	var[1][0][0] = f16vec2(vec2(4.0, 8.0));
	var[1][0][1] = f16vec2(vec2(-8.0, 1.0));
	var[1][0][2] = f16vec2(vec2(-3.0, 2.0));
	var[1][1][0] = f16vec2(vec2(7.0, 3.0));
	var[1][1][1] = f16vec2(vec2(-7.0, 4.0));
	var[1][1][2] = f16vec2(vec2(-5.0, 7.0));
	var[2][0][0] = f16vec2(vec2(2.0, -6.0));
	var[2][0][1] = f16vec2(vec2(5.0, 5.0));
	var[2][0][2] = f16vec2(vec2(-7.0, 3.0));
	var[2][1][0] = f16vec2(vec2(-6.0, -2.0));
	var[2][1][1] = f16vec2(vec2(-4.0, 5.0));
	var[2][1][2] = f16vec2(vec2(-2.0, 5.0));
	var[3][0][0] = f16vec2(vec2(0.0, -2.0));
	var[3][0][1] = f16vec2(vec2(3.0, -6.0));
	var[3][0][2] = f16vec2(vec2(5.0, 6.0));
	var[3][1][0] = f16vec2(vec2(2.0, 8.0));
	var[3][1][1] = f16vec2(vec2(-7.0, 3.0));
	var[3][1][2] = f16vec2(vec2(-7.0, -2.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(2.0, 4.0, -3.0, 1.0, -4.0, 4.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-5.0, -1.0, 4.0, 8.0, 7.0, 0.0, 8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(-4.0, -1.0, 6.0, 8.0, -8.0, 8.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(9.0, -3.0, 1.0, 6.0, -6.0, -5.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(4.0, 5.0, 6.0, 1.0, 5.0, 9.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][0][0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][0][0][2] = (vec3(2.0, -9.0, 0.0));
	var[0][0][1][0] = (vec3(-7.0, 3.0, -3.0));
	var[0][0][1][1] = (vec3(-4.0, -4.0, 5.0));
	var[0][0][1][2] = (vec3(-4.0, 1.0, -7.0));
	var[0][1][0][0] = (vec3(6.0, -2.0, -1.0));
	var[0][1][0][1] = (vec3(9.0, 2.0, -4.0));
	var[0][1][0][2] = (vec3(-9.0, -5.0, 4.0));
	var[0][1][1][0] = (vec3(-1.0, -6.0, 9.0));
	var[0][1][1][1] = (vec3(-1.0, 3.0, 0.0));
	var[0][1][1][2] = (vec3(-7.0, 1.0, -6.0));
	var[0][2][0][0] = (vec3(-7.0, 1.0, -4.0));
	var[0][2][0][1] = (vec3(8.0, -5.0, 4.0));
	var[0][2][0][2] = (vec3(1.0, -7.0, 3.0));
	var[0][2][1][0] = (vec3(-3.0, -3.0, 6.0));
	var[0][2][1][1] = (vec3(8.0, 1.0, -8.0));
	var[0][2][1][2] = (vec3(5.0, 9.0, -2.0));
	var[0][3][0][0] = (vec3(-3.0, -9.0, 1.0));
	var[0][3][0][1] = (vec3(-2.0, 3.0, -3.0));
	var[0][3][0][2] = (vec3(-1.0, 5.0, -8.0));
	var[0][3][1][0] = (vec3(3.0, -4.0, 8.0));
	var[0][3][1][1] = (vec3(-7.0, -8.0, -8.0));
	var[0][3][1][2] = (vec3(-6.0, 2.0, -1.0));
	var[1][0][0][0] = (vec3(7.0, 9.0, -7.0));
	var[1][0][0][1] = (vec3(8.0, 2.0, 5.0));
	var[1][0][0][2] = (vec3(-9.0, 7.0, -2.0));
	var[1][0][1][0] = (vec3(-7.0, 3.0, 4.0));
	var[1][0][1][1] = (vec3(-1.0, 1.0, 0.0));
	var[1][0][1][2] = (vec3(7.0, 7.0, 9.0));
	var[1][1][0][0] = (vec3(0.0, -6.0, 0.0));
	var[1][1][0][1] = (vec3(8.0, 6.0, 4.0));
	var[1][1][0][2] = (vec3(7.0, -4.0, 4.0));
	var[1][1][1][0] = (vec3(-6.0, 3.0, -3.0));
	var[1][1][1][1] = (vec3(0.0, -8.0, 6.0));
	var[1][1][1][2] = (vec3(-7.0, -2.0, 7.0));
	var[1][2][0][0] = (vec3(4.0, -7.0, 4.0));
	var[1][2][0][1] = (vec3(-6.0, 5.0, -4.0));
	var[1][2][0][2] = (vec3(5.0, -3.0, 3.0));
	var[1][2][1][0] = (vec3(8.0, 6.0, 1.0));
	var[1][2][1][1] = (vec3(6.0, 5.0, 1.0));
	var[1][2][1][2] = (vec3(7.0, 9.0, 0.0));
	var[1][3][0][0] = (vec3(5.0, 1.0, 3.0));
	var[1][3][0][1] = (vec3(-4.0, -5.0, 5.0));
	var[1][3][0][2] = (vec3(-6.0, 8.0, -7.0));
	var[1][3][1][0] = (vec3(0.0, -1.0, -9.0));
	var[1][3][1][1] = (vec3(-3.0, -5.0, 3.0));
	var[1][3][1][2] = (vec3(-3.0, -4.0, -7.0));
	var[2][0][0][0] = (vec3(4.0, 4.0, -3.0));
	var[2][0][0][1] = (vec3(9.0, 1.0, -6.0));
	var[2][0][0][2] = (vec3(7.0, -6.0, -1.0));
	var[2][0][1][0] = (vec3(-5.0, -2.0, -7.0));
	var[2][0][1][1] = (vec3(-8.0, -9.0, 6.0));
	var[2][0][1][2] = (vec3(2.0, -2.0, -7.0));
	var[2][1][0][0] = (vec3(4.0, -8.0, 1.0));
	var[2][1][0][1] = (vec3(-6.0, 7.0, 1.0));
	var[2][1][0][2] = (vec3(6.0, 3.0, 0.0));
	var[2][1][1][0] = (vec3(-2.0, -9.0, 9.0));
	var[2][1][1][1] = (vec3(1.0, 3.0, 4.0));
	var[2][1][1][2] = (vec3(5.0, -3.0, -6.0));
	var[2][2][0][0] = (vec3(-7.0, 8.0, 6.0));
	var[2][2][0][1] = (vec3(4.0, -8.0, -8.0));
	var[2][2][0][2] = (vec3(8.0, 9.0, -9.0));
	var[2][2][1][0] = (vec3(-8.0, -3.0, -7.0));
	var[2][2][1][1] = (vec3(4.0, -6.0, -4.0));
	var[2][2][1][2] = (vec3(-6.0, 0.0, 0.0));
	var[2][3][0][0] = (vec3(-5.0, 4.0, -6.0));
	var[2][3][0][1] = (vec3(-3.0, -1.0, -3.0));
	var[2][3][0][2] = (vec3(3.0, 3.0, 9.0));
	var[2][3][1][0] = (vec3(-6.0, -4.0, -5.0));
	var[2][3][1][1] = (vec3(5.0, 6.0, 7.0));
	var[2][3][1][2] = (vec3(-1.0, -3.0, -3.0));
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	var[0][1][0][0] = (vec3(9.0, -7.0, -5.0));
	var[0][1][0][1] = (vec3(-4.0, -8.0, -6.0));
	var[0][1][0][2] = (vec3(-9.0, -6.0, -5.0));
	var[0][1][1][0] = (vec3(7.0, -5.0, 1.0));
	var[0][1][1][1] = (vec3(-7.0, 6.0, -4.0));
	var[0][1][1][2] = (vec3(-3.0, -4.0, -2.0));
	var[0][2][0][0] = (vec3(4.0, 2.0, 9.0));
	var[0][2][0][1] = (vec3(-7.0, 2.0, 0.0));
	var[0][2][0][2] = (vec3(0.0, -4.0, 3.0));
	var[0][2][1][0] = (vec3(-7.0, -7.0, 1.0));
	var[0][2][1][1] = (vec3(1.0, -5.0, 0.0));
	var[0][2][1][2] = (vec3(5.0, -6.0, 7.0));
	var[0][3][0][0] = (vec3(0.0, 5.0, 9.0));
	var[0][3][0][1] = (vec3(-2.0, -2.0, 3.0));
	var[0][3][0][2] = (vec3(-5.0, 3.0, -7.0));
	var[0][3][1][0] = (vec3(-2.0, -3.0, 0.0));
	var[0][3][1][1] = (vec3(-8.0, -8.0, 6.0));
	var[0][3][1][2] = (vec3(2.0, -2.0, -4.0));
	var[1][0][0][0] = (vec3(-6.0, -4.0, 5.0));
	var[1][0][0][1] = (vec3(3.0, 9.0, -8.0));
	var[1][0][0][2] = (vec3(-4.0, 8.0, 0.0));
	var[1][0][1][0] = (vec3(5.0, -1.0, 2.0));
	var[1][0][1][1] = (vec3(3.0, 0.0, 8.0));
	var[1][0][1][2] = (vec3(-8.0, -9.0, -1.0));
	var[1][1][0][0] = (vec3(-4.0, -4.0, 3.0));
	var[1][1][0][1] = (vec3(-9.0, -7.0, 0.0));
	var[1][1][0][2] = (vec3(3.0, 0.0, -1.0));
	var[1][1][1][0] = (vec3(-5.0, -6.0, 8.0));
	var[1][1][1][1] = (vec3(3.0, 3.0, -1.0));
	var[1][1][1][2] = (vec3(-7.0, 5.0, 7.0));
	var[1][2][0][0] = (vec3(-2.0, 8.0, -5.0));
	var[1][2][0][1] = (vec3(4.0, -8.0, 2.0));
	var[1][2][0][2] = (vec3(4.0, 2.0, -7.0));
	var[1][2][1][0] = (vec3(-5.0, 2.0, -4.0));
	var[1][2][1][1] = (vec3(0.0, 5.0, -5.0));
	var[1][2][1][2] = (vec3(3.0, 3.0, -8.0));
	var[1][3][0][0] = (vec3(7.0, 1.0, 7.0));
	var[1][3][0][1] = (vec3(-6.0, 7.0, -3.0));
	var[1][3][0][2] = (vec3(4.0, -6.0, -5.0));
	var[1][3][1][0] = (vec3(-6.0, -9.0, -9.0));
	var[1][3][1][1] = (vec3(-3.0, 9.0, -8.0));
	var[1][3][1][2] = (vec3(7.0, 7.0, -2.0));
	var[2][0][0][0] = (vec3(-9.0, 4.0, -9.0));
	var[2][0][0][1] = (vec3(7.0, 3.0, 7.0));
	var[2][0][0][2] = (vec3(5.0, -4.0, 3.0));
	var[2][0][1][0] = (vec3(-9.0, 9.0, 4.0));
	var[2][0][1][1] = (vec3(7.0, -1.0, 2.0));
	var[2][0][1][2] = (vec3(-5.0, 2.0, -9.0));
	var[2][1][0][0] = (vec3(7.0, 4.0, -7.0));
	var[2][1][0][1] = (vec3(7.0, 7.0, -4.0));
	var[2][1][0][2] = (vec3(-5.0, 9.0, -8.0));
	var[2][1][1][0] = (vec3(-6.0, -7.0, -1.0));
	var[2][1][1][1] = (vec3(8.0, 9.0, 3.0));
	var[2][1][1][2] = (vec3(0.0, -5.0, -7.0));
	var[2][2][0][0] = (vec3(0.0, -7.0, -2.0));
	var[2][2][0][1] = (vec3(-8.0, 3.0, -2.0));
	var[2][2][0][2] = (vec3(9.0, -7.0, -7.0));
	var[2][2][1][0] = (vec3(4.0, -6.0, -3.0));
	var[2][2][1][1] = (vec3(-9.0, -3.0, 8.0));
	var[2][2][1][2] = (vec3(-8.0, -1.0, -6.0));
	var[2][3][0][0] = (vec3(-3.0, 4.0, 1.0));
	var[2][3][0][1] = (vec3(-6.0, 4.0, 7.0));
	var[2][3][0][2] = (vec3(-2.0, -4.0, -3.0));
	var[2][3][1][0] = (vec3(-3.0, -5.0, 1.0));
	var[2][3][1][1] = (vec3(4.0, 9.0, -7.0));
	var[2][3][1][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(5.0, -4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(6.0, -2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-8.0, 1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(8.0, 6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(4.0, -6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[0][0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[0][1][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[0][1][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[0][2][0] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	var[0][2][1] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	var[0][3][0] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
	var[0][3][1] = (mat4(-4.0, 2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0));
	var[1][0][0] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[1][0][1] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[1][1][0] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[1][1][1] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[1][2][0] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	var[1][2][1] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	var[1][3][0] = (mat4(-1.0, -9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0));
	var[1][3][1] = (mat4(-8.0, -1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0));
	var[2][0][0] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[2][0][1] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[2][1][0] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[2][1][1] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	var[2][2][0] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	var[2][2][1] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	var[2][3][0] = (mat4(4.0, 8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0));
	var[2][3][1] = (mat4(2.0, 0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[0][1][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[0][1][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[0][2][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	var[0][2][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	var[0][3][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	var[0][3][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	var[1][0][0] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[1][0][1] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[1][1][0] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[1][1][1] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[1][2][0] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	var[1][2][1] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	var[1][3][0] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	var[1][3][1] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	var[2][0][0] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[2][0][1] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[2][1][0] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[2][1][1] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	var[2][2][0] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	var[2][2][1] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	var[2][3][0] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	var[2][3][1] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	u16vec2 var[][4][2];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0][0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][3][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][0]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2][1]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][3][0]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][0]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][1]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2][0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2][1]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][3][0]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][3][1]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec2(uvec2(8u, 0u));
	var[0][0][1] = u16vec2(uvec2(6u, 0u));
	var[0][1][0] = u16vec2(uvec2(1u, 1u));
	var[0][1][1] = u16vec2(uvec2(2u, 8u));
	var[0][2][0] = u16vec2(uvec2(7u, 0u));
	var[0][2][1] = u16vec2(uvec2(3u, 9u));
	var[0][3][0] = u16vec2(uvec2(7u, 6u));
	var[0][3][1] = u16vec2(uvec2(4u, 4u));
	var[1][0][0] = u16vec2(uvec2(6u, 9u));
	var[1][0][1] = u16vec2(uvec2(3u, 2u));
	var[1][1][0] = u16vec2(uvec2(1u, 5u));
	var[1][1][1] = u16vec2(uvec2(0u, 2u));
	var[1][2][0] = u16vec2(uvec2(8u, 9u));
	var[1][2][1] = u16vec2(uvec2(1u, 2u));
	var[1][3][0] = u16vec2(uvec2(6u, 4u));
	var[1][3][1] = u16vec2(uvec2(5u, 7u));
	var[2][0][0] = u16vec2(uvec2(9u, 2u));
	var[2][0][1] = u16vec2(uvec2(4u, 5u));
	var[2][1][0] = u16vec2(uvec2(3u, 8u));
	var[2][1][1] = u16vec2(uvec2(1u, 8u));
	var[2][2][0] = u16vec2(uvec2(5u, 7u));
	var[2][2][1] = u16vec2(uvec2(9u, 9u));
	var[2][3][0] = u16vec2(uvec2(9u, 3u));
	var[2][3][1] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	var[0][1][0][0] = (vec3(-6.0, 3.0, 9.0));
	var[0][1][0][1] = (vec3(3.0, -2.0, -9.0));
	var[0][1][1][0] = (vec3(-7.0, -8.0, -6.0));
	var[0][1][1][1] = (vec3(-7.0, 2.0, -3.0));
	var[0][2][0][0] = (vec3(5.0, 5.0, -4.0));
	var[0][2][0][1] = (vec3(1.0, -9.0, 1.0));
	var[0][2][1][0] = (vec3(3.0, 0.0, -6.0));
	var[0][2][1][1] = (vec3(5.0, -6.0, -6.0));
	var[0][3][0][0] = (vec3(1.0, -4.0, 2.0));
	var[0][3][0][1] = (vec3(0.0, 1.0, -8.0));
	var[0][3][1][0] = (vec3(-3.0, -9.0, 6.0));
	var[0][3][1][1] = (vec3(-3.0, 6.0, 6.0));
	var[1][0][0][0] = (vec3(6.0, -5.0, -7.0));
	var[1][0][0][1] = (vec3(1.0, 1.0, -3.0));
	var[1][0][1][0] = (vec3(9.0, -7.0, 2.0));
	var[1][0][1][1] = (vec3(5.0, -4.0, 6.0));
	var[1][1][0][0] = (vec3(1.0, -1.0, 8.0));
	var[1][1][0][1] = (vec3(7.0, -2.0, -6.0));
	var[1][1][1][0] = (vec3(-1.0, -1.0, -5.0));
	var[1][1][1][1] = (vec3(-1.0, 1.0, -1.0));
	var[1][2][0][0] = (vec3(7.0, 1.0, -9.0));
	var[1][2][0][1] = (vec3(7.0, -8.0, -1.0));
	var[1][2][1][0] = (vec3(5.0, -3.0, 9.0));
	var[1][2][1][1] = (vec3(-6.0, 4.0, -4.0));
	var[1][3][0][0] = (vec3(-6.0, 1.0, 4.0));
	var[1][3][0][1] = (vec3(7.0, 9.0, -9.0));
	var[1][3][1][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][3][1][1] = (vec3(7.0, 1.0, -4.0));
	var[2][0][0][0] = (vec3(-3.0, -8.0, 6.0));
	var[2][0][0][1] = (vec3(8.0, 2.0, 4.0));
	var[2][0][1][0] = (vec3(0.0, 8.0, 0.0));
	var[2][0][1][1] = (vec3(-2.0, 1.0, -3.0));
	var[2][1][0][0] = (vec3(5.0, 5.0, -6.0));
	var[2][1][0][1] = (vec3(6.0, 7.0, -2.0));
	var[2][1][1][0] = (vec3(-5.0, -7.0, -1.0));
	var[2][1][1][1] = (vec3(4.0, -3.0, -7.0));
	var[2][2][0][0] = (vec3(2.0, 5.0, 0.0));
	var[2][2][0][1] = (vec3(1.0, -8.0, 0.0));
	var[2][2][1][0] = (vec3(7.0, -2.0, -7.0));
	var[2][2][1][1] = (vec3(-6.0, -5.0, 3.0));
	var[2][3][0][0] = (vec3(-3.0, 5.0, -5.0));
	var[2][3][0][1] = (vec3(4.0, 1.0, 9.0));
	var[2][3][1][0] = (vec3(3.0, -8.0, 6.0));
	var[2][3][1][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s.a), ivec3(0, 2, 6)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(8.0, -8.0, 2.0, -3.0, -1.0, -8.0, 8.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(1.0, 3.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(9, -3, -2));
	s.b[0][0] = (vec3(-3.0, 0.0, 2.0));
	s.b[0][1] = (vec3(-7.0, 0.0, -8.0));
	s.b[0][2] = (vec3(0.0, -4.0, -7.0));
	s.b[1][0] = (vec3(9.0, -3.0, 9.0));
	s.b[1][1] = (vec3(8.0, 4.0, 0.0));
	s.b[1][2] = (vec3(-6.0, -4.0, -6.0));
	s.b[2][0] = (vec3(7.0, -5.0, 4.0));
	s.b[2][1] = (vec3(-2.0, 4.0, -1.0));
	s.b[2][2] = (vec3(-1.0, 6.0, 6.0));
	s.b[3][0] = (vec3(-5.0, -5.0, 3.0));
	s.b[3][1] = (vec3(-6.0, 5.0, 2.0));
	s.b[3][2] = (vec3(2.0, -9.0, -5.0));
	s.c = (vec4(-5.0, 1.0, -2.0, 9.0));
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(1.0, -4.0, 7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(-1, 6, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(1, -7)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-6.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(7, 1, -6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(-8, 1)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(-4, 9)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(2.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(7, 5, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(4, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(1, 4)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-6.0, -4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(9.0, 1.0, -6.0, 4.0, -9.0, 3.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-3, -4, -8)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(9, -9)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(-9, 3)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-1, -5)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(3, 0, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(2, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(-5, -6)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-5.0, 7.0, -1.0, 6.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(-4, -6, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-1, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(-8, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(-6, -3)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(5.0, 3.0, 6.0, -9.0)) && allOk;
	allOk = compare_uint((u), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-8, -9, 6));
	s.b[0] = (ivec2(-6, -2));
	s.b[1] = (ivec2(4, -5));
	s.b[2] = (ivec2(-9, -7));
	s.b[3] = (ivec2(-1, 2));
	s.c = (vec4(2.0, -5.0, 0.0, -7.0));
	u = (3u);
}
#version 450
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
	allOk = compare_ivec3((s[0][0].a), ivec3(2, 9, -7)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(9.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-5, -5, -4)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(-7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(-8, -6, -3)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(5.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(-5, 7, -4)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(9.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-9, 5, 2)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(0.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(-9, 3, -7)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(0.0, 8.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(-2.0, 3.0, 4.0, 0.0));
	s[0][0].a = (ivec3(-1, -9, -8));
	s[0][0].c = (vec4(1.0, -7.0, -6.0, -4.0));
	s[0][1].a = (ivec3(1, -5, 3));
	s[0][1].c = (vec4(-5.0, -7.0, 4.0, 7.0));
	s[1][0].a = (ivec3(0, 7, 2));
	s[1][0].c = (vec4(-5.0, 1.0, -1.0, 7.0));
	s[1][1].a = (ivec3(8, 9, -2));
	s[1][1].c = (vec4(-6.0, 2.0, 7.0, 6.0));
	s[2][0].a = (ivec3(7, -7, 5));
	s[2][0].c = (vec4(-4.0, 6.0, -5.0, 7.0));
	s[2][1].a = (ivec3(-6, 1, 1));
	s[2][1].c = (vec4(-1.0, -3.0, 7.0, 8.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	highp uint u;
	T t[];
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
	allOk = compare_uint((u), 0u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(4.0, -6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(6u, 3u, 8u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(6.0, -3.0, 9.0, 7.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(1u, 1u, 9u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(5.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_int((t[0].c), 7) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0, 5.0, -6.0, 0.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(8u, 4u, 5u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-4.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(4u, 6u, 6u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(0.0, -6.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(3u, 7u, 2u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(8.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(8.0, -5.0, -6.0, -4.0)) && allOk;
	allOk = compare_int((t[1].c), 5) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(-4.0, -7.0, 0.0, 2.0, -5.0, -2.0, 1.0, 2.0, -5.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(1u, 2u, 7u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(6.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(3u, 4u, 5u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(-1.0, 2.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(7u, 2u, 9u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_int((t[2].c), 5) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(8.0, -8.0, -6.0, -5.0, 2.0, 5.0, -6.0, 9.0, 7.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(0u, 7u, 4u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(6.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(-2.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(5u, 5u, 4u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(-4.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(8u, 5u, 0u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(7.0, 5.0, 1.0, -8.0)) && allOk;
	allOk = compare_int((t[3].c), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(2u, 9u, 7u));
	s.b[0] = (vec2(-4.0, 6.0));
	s.b[1] = (vec2(-4.0, -7.0));
	s.b[2] = (vec2(-1.0, -7.0));
	s.b[3] = (vec2(1.0, -9.0));
	s.c = (vec4(-4.0, -7.0, -5.0, -4.0));
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
	allOk = compare_uint((u), 0u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(-4.0, 8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(7u, 6u, 8u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-9.0, -3.0, -3.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-4.0, -7.0, 2.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(1u, 9u, 6u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(-1.0, 6.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(4.0, -7.0, -5.0, -5.0)) && allOk;
	allOk = compare_int((t[0].c), -8) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0, -7.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(4u, 0u, 4u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(5.0, 3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(1.0, -4.0, 3.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(7u, 0u, 9u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-4.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(8u, 0u, 3u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-2.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_int((t[1].c), 5) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(-4.0, 1.0, 5.0, -1.0, -5.0, -4.0, 9.0, 5.0, 0.0, 4.0, -5.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(1u, 2u, 5u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(1.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(0u, 8u, 1u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(-5.0, -6.0, 5.0, 7.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(5u, 1u, 5u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(0.0, -6.0, -4.0, 1.0)) && allOk;
	allOk = compare_int((t[2].c), 1) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(-7.0, -6.0, -8.0, -7.0, 2.0, 7.0, -1.0, -5.0, 4.0, 0.0, 6.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(4u, 9u, 3u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(3.0, 9.0, -2.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(0u, 9u, 9u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(8u, 4u, 1u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(1.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_int((t[3].c), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(3u, 2u, 5u));
	s.b[0] = (vec2(6.0, -6.0));
	s.b[1] = (vec2(5.0, 6.0));
	s.b[2] = (vec2(-9.0, 8.0));
	s.b[3] = (vec2(1.0, 4.0));
	s.c = (vec4(-5.0, 1.0, 8.0, -2.0));
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
	allOk = compare_mat3x4(block[0].var, mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block[1].var = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block[2].var = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(block[0].var, mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block[1].var = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block[2].var = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
}
#version 450
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
	highp mat2x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(5.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-7.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -6.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(8.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(2.0, 6.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block[0].var[1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block[1].var[0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block[1].var[1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block[2].var[0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block[2].var[1] = (vec4(4.0, 6.0, -4.0, 0.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	uint8_t padding;
	u8vec4 var;
} block[3];

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(block[0].var), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(block[1].padding), 5u) && allOk;
	allOk = compare_u8vec4(uvec4(block[1].var), uvec4(7u, 0u, 1u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(block[2].padding), 6u) && allOk;
	allOk = compare_u8vec4(uvec4(block[2].var), uvec4(1u, 7u, 7u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint8_t(9u);
	block[0].var = u8vec4(uvec4(5u, 9u, 4u, 6u));
	block[1].padding = uint8_t(8u);
	block[1].var = u8vec4(uvec4(7u, 3u, 6u, 7u));
	block[2].padding = uint8_t(1u);
	block[2].var = u8vec4(uvec4(9u, 8u, 9u, 3u));
}
#version 450
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
	highp int a;
	highp uint b;
	lowp int c;
	mediump float d;
	lowp int e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool f;
	highp int g;
	mediump float h;
	mediump uint i;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bool j;
};
layout(std140, binding = 4) buffer BlockE
{
	mediump float k;
	lowp uint l;
	mediump float m;
	lowp int n;
	bool o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 0) && allOk;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_int((blockB.c), 9) && allOk;
	allOk = compare_float((blockB.d), -5.0) && allOk;
	allOk = compare_int((blockB.e), 0) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_bool((j), false) && allOk;
	allOk = compare_int((n), -7) && allOk;
	allOk = compare_bool((o), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (-9);
	blockB.d = (0.0);
	blockC.h = (-6.0);
	j = (true);
	l = (2u);
	n = (-6);
	o = (true);
}
#version 450
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
	bvec2 b[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp vec3 c;
	mediump mat4 d;
	lowp mat4 e;
	bvec4 f;
	highp uint g[];
};
layout(std140, binding = 3) buffer BlockD
{
	highp ivec2 h;
	highp mat4 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(e, mat4(3.0, -3.0, -4.0, -4.0, 1.0, -9.0, -6.0, -4.0, 1.0, -7.0, 1.0, 0.0, -9.0, -4.0, 3.0, 1.0)) && allOk;
	allOk = compare_uint((g[0]), 3u) && allOk;
	allOk = compare_uint((g[1]), 5u) && allOk;
	allOk = compare_uint((g[2]), 9u) && allOk;
	allOk = compare_uint((g[3]), 0u) && allOk;
	allOk = compare_uint((g[4]), 6u) && allOk;
	allOk = compare_ivec2((blockD.h), ivec2(-2, -4)) && allOk;
	allOk = compare_mat4(blockD.i[0], mat4(7.0, 1.0, -8.0, -9.0, 5.0, 1.0, -5.0, 5.0, -3.0, 6.0, 6.0, 2.0, 4.0, 4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(blockD.i[1], mat4(8.0, 6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0, 6.0, -3.0, -4.0, 5.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(blockD.i[2], mat4(2.0, -2.0, -6.0, 4.0, -8.0, 7.0, 1.0, -6.0, 8.0, 4.0, -4.0, 6.0, -7.0, 7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(blockD.i[3], mat4(4.0, 1.0, -2.0, 4.0, -3.0, 6.0, 1.0, -2.0, 5.0, 2.0, -8.0, -6.0, -5.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4(blockD.i[4], mat4(5.0, -5.0, 3.0, -8.0, 6.0, 5.0, -9.0, 7.0, 5.0, -8.0, 9.0, -8.0, -7.0, 9.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(2.0, -4.0, 0.0, 5.0, 7.0, -8.0, 0.0, 3.0, -5.0, -5.0, -7.0, 4.0));
	b[0] = (bvec2(false, false));
	b[1] = (bvec2(false, true));
	b[2] = (bvec2(true, false));
	c = (vec3(5.0, 1.0, 7.0));
	e = (mat4(-9.0, 5.0, 8.0, 1.0, -8.0, 3.0, 8.0, -8.0, 4.0, 5.0, 0.0, 2.0, 8.0, -4.0, -8.0, -7.0));
	g[0] = (9u);
	g[1] = (8u);
	g[2] = (4u);
	g[3] = (1u);
	g[4] = (6u);
	blockD.i[0] = (mat4(4.0, 2.0, -6.0, 4.0, -6.0, -4.0, -8.0, 6.0, -6.0, 3.0, -9.0, -6.0, 1.0, 9.0, -7.0, 2.0));
	blockD.i[1] = (mat4(5.0, 9.0, 3.0, -4.0, 6.0, 4.0, 5.0, 5.0, 6.0, 8.0, 1.0, -8.0, 3.0, -9.0, 5.0, -8.0));
	blockD.i[2] = (mat4(0.0, 5.0, 0.0, -7.0, 7.0, -2.0, 9.0, 8.0, 0.0, 5.0, -3.0, 8.0, 7.0, 4.0, 7.0, -3.0));
	blockD.i[3] = (mat4(9.0, -4.0, 7.0, -1.0, 5.0, 3.0, -8.0, 4.0, 2.0, -4.0, 1.0, 6.0, -8.0, -2.0, -6.0, 8.0));
	blockD.i[4] = (mat4(-6.0, 2.0, -5.0, -8.0, -5.0, -4.0, 2.0, 2.0, 2.0, -1.0, -2.0, 6.0, -1.0, 1.0, -7.0, 3.0));
}
#version 450
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
	highp mat4x2 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp float b[1];
	mediump int c;
	bvec2 d;
	mediump mat3x4 e;
	highp mat3x2 f;
};
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	mediump mat2x3 g;
	mediump ivec3 h[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	lowp uint i;
	highp uvec3 j;
	bvec4 k;
	highp mat2x3 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b[0]), -2.0) && allOk;
	allOk = compare_bvec2((d), bvec2(false, false)) && allOk;
	allOk = compare_mat3x4(e, mat3x4(-8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(f, mat3x2(8.0, -5.0, 7.0, -8.0, -4.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockD.h[0]), ivec3(-4, -1, 6)) && allOk;
	allOk = compare_uint((blockE.i), 1u) && allOk;
	allOk = compare_bvec4((blockE.k), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(-9.0, -3.0, -3.0, 9.0, 8.0, -5.0, 0.0, 2.0));
	b[0] = (1.0);
	d = (bvec2(false, true));
	e = (mat3x4(8.0, 5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0));
	f = (mat3x2(9.0, -4.0, 2.0, -4.0, 4.0, -8.0));
	blockE.i = (0u);
	blockE.j = (uvec3(3u, 0u, 0u));
	blockE.k = (bvec4(true, true, true, false));
}
#version 450
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
	mediump ivec2 a;
	mediump mat4x3 b;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp mat3x4 c;
	bvec3 d;
	mediump uvec3 e;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec3 f[1];
	lowp int g[];
};
layout(std140, binding = 4) readonly buffer BlockE
{
	mediump vec2 h;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(-8, -8)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(0.0, -9.0, -1.0, 4.0, -4.0, 0.0, -2.0, -5.0, 1.0, 5.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(1u, 3u, 9u)) && allOk;
	allOk = compare_int((g[0]), 5) && allOk;
	allOk = compare_vec2((blockE.h), vec2(9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-2, -9));
	b = (mat4x3(-3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0, 2.0, 6.0));
	blockC.c = (mat3x4(4.0, 2.0, 3.0, 5.0, 6.0, -9.0, 6.0, 6.0, -5.0, -8.0, -6.0, -6.0));
	blockC.d = (bvec3(false, false, true));
	g[0] = (7);
}
#version 450
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
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec4 b;
	layout(offset = 16) lowp vec2 c;
	layout(offset = 32) lowp uvec4 d;
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a), 4u) && allOk;
	allOk = compare_uint((blockB[1].a), 3u) && allOk;
	allOk = compare_uint((blockB[2].a), 5u) && allOk;
	allOk = compare_vec2((blockC[0].c), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2((blockC[1].c), vec2(-6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (4u);
	blockB[1].a = (4u);
	blockB[2].a = (9u);
	blockC[0].b = (vec4(5.0, -4.0, 2.0, -1.0));
	blockC[0].c = (vec2(9.0, -3.0));
	blockC[0].d = (uvec4(6u, 5u, 3u, 9u));
	blockC[1].b = (vec4(1.0, -2.0, -8.0, -6.0));
	blockC[1].c = (vec2(9.0, 4.0));
	blockC[1].d = (uvec4(6u, 3u, 2u, 2u));
}
#version 450
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
	layout(offset = 0) mediump uvec4 a[1];
	layout(offset = 16) mediump vec2 b;
	layout(offset = 24) lowp int c;
	layout(offset = 28) highp int d;
	layout(offset = 32) highp vec2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((b), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_int((c), -1) && allOk;
	allOk = compare_int((d), -8) && allOk;
	allOk = compare_vec2((e), vec2(2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec4(9u, 2u, 5u, 7u));
	b = (vec2(6.0, 2.0));
	c = (-8);
}
#version 450
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
	layout(offset = 0) lowp vec2 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec3 b;
	layout(offset = 16) lowp vec3 c;
	layout(offset = 32) bvec2 d;
	layout(offset = 48) bvec4 e;
	layout(offset = 64) highp ivec3 f;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 g;
	layout(offset = 16) highp ivec3 h[1];
	layout(offset = 32) mediump uvec4 i;
	layout(offset = 48) mediump ivec3 j;
	layout(offset = 64) mediump uvec2 k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec3((blockC[0].c), vec3(-5.0, -4.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockC[0].d), bvec2(false, false)) && allOk;
	allOk = compare_vec3((blockC[1].c), vec3(8.0, 8.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockC[1].d), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockD.h[0]), ivec3(9, -3, -6)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(4u, 5u, 5u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.k), uvec2(2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-7.0, 3.0));
	blockC[0].b = (vec3(-9.0, -7.0, -4.0));
	blockC[0].c = (vec3(-1.0, 9.0, -4.0));
	blockC[0].d = (bvec2(true, true));
	blockC[0].e = (bvec4(true, false, false, false));
	blockC[0].f = (ivec3(-7, 2, -5));
	blockC[1].b = (vec3(-9.0, 9.0, -1.0));
	blockC[1].c = (vec3(9.0, 4.0, 1.0));
	blockC[1].d = (bvec2(false, false));
	blockC[1].e = (bvec4(false, true, true, true));
	blockC[1].f = (ivec3(-6, 8, 5));
	blockD.g = (bvec2(false, true));
	blockD.h[0] = (ivec3(-2, 2, -5));
	blockD.i = (uvec4(0u, 8u, 5u, 7u));
	blockD.j = (ivec3(5, 5, 3));
	blockD.k = (uvec2(4u, 1u));
}
#version 450
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
	layout(offset = 16) mediump ivec3 b;
	layout(offset = 32) mediump ivec3 c[1];
	layout(offset = 48) mediump float d;
	layout(offset = 64) bvec4 e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_float((blockB.d), 1.0) && allOk;
	allOk = compare_bvec4((blockB.e), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(3, 0, -9));
	blockB.c[0] = (ivec3(-6, 3, 4));
	blockB.d = (-1.0);
	blockB.e = (bvec4(true, false, true, false));
}
#version 450
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
	layout(offset = 16) lowp uint b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool c;
	layout(offset = 16) bvec3 d[1];
	layout(offset = 32) highp float e;
	layout(offset = 36) mediump vec2 f;
	layout(offset = 44) lowp float g;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump vec4 h;
	layout(offset = 16) mediump uint i;
	layout(offset = 20) lowp ivec2 j;
	layout(offset = 32) highp ivec3 k;
	layout(offset = 48) highp uvec2 l;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(2, -4, -7, 7)) && allOk;
	allOk = compare_bool((c), true) && allOk;
	allOk = compare_bvec3((d[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_vec2((f), vec2(4.0, -6.0)) && allOk;
	allOk = compare_float((g), -1.0) && allOk;
	allOk = compare_vec4((blockD.h), vec4(-8.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_uint((blockD.i), 8u) && allOk;
	allOk = compare_ivec2((blockD.j), ivec2(-8, 3)) && allOk;
	allOk = compare_uvec2((blockD.l), uvec2(0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec4(-1, 9, 1, 3));
	b = (7u);
	c = (false);
	e = (6.0);
	f = (vec2(3.0, -6.0));
	g = (-3.0);
	blockD.h = (vec4(8.0, 4.0, 9.0, 1.0));
	blockD.i = (8u);
	blockD.j = (ivec2(-1, 4));
	blockD.k = (ivec3(-4, -2, -2));
}
#version 450
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
	lowp int mB;
};
struct sB
{
	highp mat3x2 mA;
	mediump mat4 mB;
	bvec4 mC;
	sA mD;
};
struct sC
{
	highp mat4x3 mA;
	bvec4 mB;
	lowp vec4 mC[2];
	highp uvec3 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bvec2 a;
	lowp ivec3 b;
	highp uint c[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp uvec4 d;
	highp uvec2 e;
	sB f;
	lowp vec3 g[];
};
layout(scalar, binding = 3) buffer BlockD
{
	highp mat3x2 h;
	bool i;
	lowp mat2x3 j[2];
	bvec4 k;
	sC l[];
};
layout(scalar, row_major, binding = 4) buffer BlockE
{
	lowp mat3x2 m;
	bvec4 n;
	lowp mat4 o;
	bvec2 p;
	bvec2 q[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
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
	allOk = compare_ivec3((blockB.b), ivec3(-5, 0, 3)) && allOk;
	allOk = compare_uint((blockB.c[0]), 5u) && allOk;
	allOk = compare_uvec4((d), uvec4(5u, 0u, 2u, 2u)) && allOk;
	allOk = compare_mat3x2(f.mA, mat3x2(4.0, -7.0, -2.0, -1.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(f.mB, mat4(-6.0, 3.0, -7.0, 4.0, 1.0, -6.0, -7.0, 2.0, 8.0, -2.0, 8.0, 0.0, 2.0, 2.0, -2.0, 3.0)) && allOk;
	allOk = compare_bvec4((f.mC), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bool((f.mD.mA), true) && allOk;
	allOk = compare_int((f.mD.mB), 3) && allOk;
	allOk = compare_mat3x2(h, mat3x2(-9.0, 8.0, -2.0, -2.0, 0.0, -1.0)) && allOk;
	allOk = compare_bvec4((k), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat3x2(blockE[0].m, mat3x2(8.0, 3.0, 3.0, 5.0, 4.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockE[0].n), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec2((blockE[0].p), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(9, 2, -6));
	blockB.c[0] = (8u);
	d = (uvec4(5u, 1u, 5u, 8u));
	e = (uvec2(1u, 2u));
	f.mA = (mat3x2(3.0, -6.0, -9.0, 9.0, -9.0, 9.0));
	f.mB = (mat4(8.0, -1.0, -4.0, 0.0, -4.0, 2.0, 1.0, 2.0, 9.0, -3.0, -2.0, -6.0, -2.0, 5.0, -3.0, 2.0));
	f.mC = (bvec4(true, false, true, true));
	f.mD.mA = (false);
	f.mD.mB = (8);
	g[0] = (vec3(-9.0, 2.0, -4.0));
	g[1] = (vec3(1.0, 8.0, 7.0));
	g[2] = (vec3(-4.0, -3.0, -2.0));
	g[3] = (vec3(7.0, -9.0, 3.0));
	g[4] = (vec3(8.0, 2.0, 4.0));
	g[5] = (vec3(-8.0, -4.0, -3.0));
	g[6] = (vec3(-8.0, 8.0, -8.0));
	g[7] = (vec3(3.0, -1.0, 4.0));
	h = (mat3x2(4.0, -4.0, 9.0, 8.0, -7.0, -1.0));
	j[0] = (mat2x3(-7.0, 3.0, -2.0, -4.0, 9.0, -4.0));
	j[1] = (mat2x3(0.0, 5.0, -5.0, 1.0, 7.0, -5.0));
	k = (bvec4(true, false, false, true));
	blockE[0].n = (bvec4(true, false, true, true));
	blockE[0].o = (mat4(-6.0, 9.0, 0.0, -1.0, 4.0, 8.0, 7.0, 1.0, -5.0, 8.0, 6.0, 4.0, 2.0, 5.0, -3.0, -1.0));
	blockE[0].q[0] = (bvec2(false, true));
	blockE[0].q[1] = (bvec2(false, false));
	blockE[0].q[2] = (bvec2(true, false));
	blockE[0].q[3] = (bvec2(true, true));
	blockE[0].q[4] = (bvec2(true, false));
	blockE[0].q[5] = (bvec2(false, true));
	blockE[0].q[6] = (bvec2(true, false));
	blockE[0].q[7] = (bvec2(false, false));
}
#version 450
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
	highp mat3x4 a;
	highp ivec4 b[2];
	lowp uvec4 c;
	bvec3 d[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp int e;
	bool f;
	lowp uvec2 g;
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp mat3x2 h[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	highp ivec2 i;
	highp ivec4 j;
	lowp mat2x3 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b[0]), ivec4(0, -2, 5, 6)) && allOk;
	allOk = compare_ivec4((blockB.b[1]), ivec4(-8, 5, 0, -7)) && allOk;
	allOk = compare_bvec3((blockB.d[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.d[1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.d[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.d[4]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.d[5]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.d[6]), bvec3(false, false, false)) && allOk;
	allOk = compare_int((e), -4) && allOk;
	allOk = compare_uvec2((g), uvec2(2u, 8u)) && allOk;
	allOk = compare_mat3x2(blockD.h[0], mat3x2(6.0, -5.0, 2.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[1], mat3x2(3.0, -5.0, -8.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[2], mat3x2(-1.0, 2.0, 6.0, -5.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[3], mat3x2(-4.0, -1.0, 7.0, 7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[4], mat3x2(-2.0, 3.0, -1.0, 4.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[5], mat3x2(-3.0, -5.0, -7.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[6], mat3x2(4.0, 5.0, 2.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[7], mat3x2(-6.0, 8.0, -7.0, 0.0, 1.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockE.i), ivec2(-3, 0)) && allOk;
	allOk = compare_ivec4((blockE.j), ivec4(4, -1, -1, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(2.0, 7.0, 2.0, 3.0, 4.0, 4.0, 9.0, -3.0, 2.0, 8.0, -9.0, -7.0));
	blockB.c = (uvec4(4u, 9u, 8u, 0u));
	blockB.d[0] = (bvec3(true, true, true));
	blockB.d[1] = (bvec3(false, false, true));
	blockB.d[2] = (bvec3(true, false, false));
	blockB.d[3] = (bvec3(false, true, true));
	blockB.d[4] = (bvec3(true, false, false));
	blockB.d[5] = (bvec3(true, true, true));
	blockB.d[6] = (bvec3(false, true, false));
	e = (7);
	g = (uvec2(9u, 5u));
	blockD.h[0] = (mat3x2(9.0, -5.0, -3.0, 3.0, -3.0, 2.0));
	blockD.h[1] = (mat3x2(-4.0, 9.0, 3.0, -8.0, 5.0, -7.0));
	blockD.h[2] = (mat3x2(6.0, -9.0, 8.0, -4.0, 0.0, -3.0));
	blockD.h[3] = (mat3x2(0.0, 8.0, -1.0, 3.0, -1.0, -3.0));
	blockD.h[4] = (mat3x2(8.0, 1.0, -6.0, -8.0, 2.0, 3.0));
	blockD.h[5] = (mat3x2(3.0, -4.0, -5.0, -1.0, 2.0, -4.0));
	blockD.h[6] = (mat3x2(2.0, -5.0, -3.0, 4.0, 2.0, -6.0));
	blockD.h[7] = (mat3x2(-1.0, -1.0, 0.0, 8.0, -6.0, 3.0));
	blockE.j = (ivec4(-5, 8, -5, 9));
	blockE.k[0] = (mat2x3(-7.0, 1.0, -9.0, 9.0, -5.0, 7.0));
}
#version 450
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
	mediump ivec2 a;
	mediump vec3 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].a), ivec2(-2, 4)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].b), vec3(3.0, -8.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].a), ivec2(-5, -4)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].b), vec3(-5.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].a), ivec2(-3, 6)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(2)].b), vec3(-6.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (ivec2(-7, 3));
	blockB[nonuniformEXT(0)].b = (vec3(-9.0, -7.0, -4.0));
	blockB[nonuniformEXT(1)].a = (ivec2(-1, 9));
	blockB[nonuniformEXT(1)].b = (vec3(-4.0, -4.0, 3.0));
	blockB[nonuniformEXT(2)].a = (ivec2(-7, -4));
	blockB[nonuniformEXT(2)].b = (vec3(0.0, -7.0, -9.0));
}
#version 450
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
	highp vec4 a;
	mediump float b;
	bvec3 c;
	bool d;
	bool e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].b), -9.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].d), false) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].e), true) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].b), -7.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].d), false) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].e), false) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].b), -5.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].d), true) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].e), true) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].b), -6.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].d), false) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].e), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec4(0.0, -7.0, -2.0, -6.0));
	blockB[nonuniformEXT(0)].b = (0.0);
	blockB[nonuniformEXT(0)].c = (bvec3(true, false, false));
	blockB[nonuniformEXT(0)].d = (true);
	blockB[nonuniformEXT(0)].e = (true);
	blockB[nonuniformEXT(1)].a = (vec4(4.0, -7.0, 9.0, 7.0));
	blockB[nonuniformEXT(1)].b = (-4.0);
	blockB[nonuniformEXT(1)].c = (bvec3(false, true, false));
	blockB[nonuniformEXT(1)].d = (true);
	blockB[nonuniformEXT(1)].e = (false);
	blockB[nonuniformEXT(2)].a = (vec4(8.0, -7.0, 8.0, -4.0));
	blockB[nonuniformEXT(2)].b = (-3.0);
	blockB[nonuniformEXT(2)].c = (bvec3(false, true, true));
	blockB[nonuniformEXT(2)].d = (true);
	blockB[nonuniformEXT(2)].e = (false);
	blockB[nonuniformEXT(3)].a = (vec4(-1.0, -7.0, 9.0, 3.0));
	blockB[nonuniformEXT(3)].b = (-6.0);
	blockB[nonuniformEXT(3)].c = (bvec3(false, false, false));
	blockB[nonuniformEXT(3)].d = (false);
	blockB[nonuniformEXT(3)].e = (true);
}
#version 450
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
	lowp uint b[1];
	bool c;
	mediump uint d[1];
	float16_t e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	uint16_t f;
	bool g;
	int16_t h;
	uint16_t i;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bool j;
	bool k;
	highp int l;
	float16_t m;
};
layout(std140, binding = 4) buffer BlockE
{
	lowp uint n;
	highp int o;
	mediump float p;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -4.0) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_uint16_t(uint(blockC.f), 2u) && allOk;
	allOk = compare_int16_t(int(blockC.h), 8) && allOk;
	allOk = compare_bool((j), true) && allOk;
	allOk = compare_int((blockE.o), -9) && allOk;
	allOk = compare_float((blockE.p), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9.0);
	blockB.b[0] = (0u);
	blockB.c = (false);
	blockB.d[0] = (7u);
	blockB.e = float16_t(-8.0);
	blockC.f = uint16_t(5u);
	blockC.i = uint16_t(1u);
	j = (true);
	k = (true);
	l = (9);
	m = float16_t(-6.0);
	blockE.n = (4u);
	blockE.o = (9);
	blockE.p = (4.0);
}
#version 450
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
	highp uint a[1];
	mediump int b;
	lowp float c;
	lowp int d;
};
layout(std430, binding = 2) buffer BlockC
{
	int16_t e;
	float16_t f;
	uint16_t g;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bool h;
	highp int i;
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	lowp int j;
	uint16_t k;
	float16_t l;
	uint16_t m[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), 3) && allOk;
	allOk = compare_float((c), -2.0) && allOk;
	allOk = compare_int((d), 9) && allOk;
	allOk = compare_int16_t(int(blockC.e), -9) && allOk;
	allOk = compare_float16_t(float(blockC.f), -1.0) && allOk;
	allOk = compare_uint16_t(uint(blockC.g), 1u) && allOk;
	allOk = compare_int((blockD.i), 6) && allOk;
	allOk = compare_int((j), -5) && allOk;
	allOk = compare_uint16_t(uint(k), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-2);
	c = (3.0);
	blockC.f = float16_t(5.0);
	blockC.g = uint16_t(8u);
	blockD.h = (true);
	j = (5);
}
#version 450
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
	bool b;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp ivec3 c;
	int16_t d;
	mediump uvec4 e[1];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	int16_t f;
	uint16_t g;
	int16_t h;
	mediump mat3 i;
	i16vec2 j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(4u, 0u, 4u, 6u)) && allOk;
	allOk = compare_bool((b), true) && allOk;
	allOk = compare_ivec3((c), ivec3(5, -5, -2)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(9u, 7u, 0u, 6u)) && allOk;
	allOk = compare_int16_t(int(blockD.f), 9) && allOk;
	allOk = compare_int16_t(int(blockD.h), -8) && allOk;
	allOk = compare_mat3(blockD.i, mat3(1.0, -8.0, -5.0, 5.0, -7.0, 8.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j), ivec2(7, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (ivec3(9, -5, 2));
	d = int16_t(1);
	e[0] = (uvec4(4u, 3u, 9u, 4u));
	blockD.f = int16_t(8);
	blockD.g = uint16_t(9u);
	blockD.h = int16_t(-5);
	blockD.i = (mat3(8.0, -9.0, 6.0, -1.0, -3.0, -2.0, 7.0, -1.0, -4.0));
	blockD.j = i16vec2(ivec2(9, -4));
}
#version 450
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
	highp mat3 a;
	highp vec2 b[6];
	f16vec4 c[];
} blockB;
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	mediump mat3x2 d;
	i16vec3 e;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat2x3 f;
	u16vec4 g[6];
	float16_t h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b[0]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.b[1]), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.b[2]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.b[3]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[4]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[5]), vec2(-1.0, 3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(g[0]), uvec4(9u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(g[1]), uvec4(8u, 8u, 6u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(g[2]), uvec4(3u, 7u, 6u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(g[3]), uvec4(4u, 6u, 2u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(g[4]), uvec4(3u, 1u, 9u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(g[5]), uvec4(6u, 2u, 2u, 2u)) && allOk;
	allOk = compare_float16_t(float(h[0]), 9.0) && allOk;
	allOk = compare_float16_t(float(h[1]), -3.0) && allOk;
	allOk = compare_float16_t(float(h[2]), 8.0) && allOk;
	allOk = compare_float16_t(float(h[3]), 2.0) && allOk;
	allOk = compare_float16_t(float(h[4]), 7.0) && allOk;
	allOk = compare_float16_t(float(h[5]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(3.0, -4.0, 2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0));
	f = (mat2x3(9.0, 2.0, 5.0, -2.0, -5.0, 0.0));
	g[0] = u16vec4(uvec4(6u, 0u, 3u, 3u));
	g[1] = u16vec4(uvec4(4u, 5u, 6u, 1u));
	g[2] = u16vec4(uvec4(5u, 3u, 2u, 2u));
	g[3] = u16vec4(uvec4(4u, 0u, 8u, 8u));
	g[4] = u16vec4(uvec4(1u, 5u, 1u, 9u));
	g[5] = u16vec4(uvec4(0u, 4u, 6u, 9u));
}
#version 450
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
	highp mat4 a;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec3 b;
	uint16_t c;
	mediump uvec3 d;
	mediump mat2 e[3];
	bvec2 f;
} blockC;
layout(std430, binding = 3) readonly buffer BlockD
{
	highp vec2 g;
	i16vec3 h;
	i16vec2 i;
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump vec3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a, mat4(1.0, 2.0, -8.0, 3.0, -6.0, -1.0, -1.0, 8.0, -5.0, 4.0, 4.0, 1.0, 7.0, 1.0, -7.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockC.b), uvec3(8u, 6u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(5u, 8u, 8u)) && allOk;
	allOk = compare_mat2(blockC.e[0], mat2(5.0, 9.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.e[1], mat2(1.0, 1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC.e[2], mat2(6.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec2((g), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec3((j[0]), vec3(9.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec3((j[1]), vec3(3.0, -9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4(9.0, 9.0, -4.0, 0.0, 7.0, -6.0, -1.0, 6.0, 5.0, 1.0, -9.0, -6.0, -2.0, 2.0, 0.0, -5.0));
	blockC.b = (uvec3(2u, 5u, 6u));
	blockC.d = (uvec3(9u, 3u, 0u));
	blockC.e[0] = (mat2(-6.0, -1.0, 2.0, 4.0));
	blockC.e[1] = (mat2(-4.0, 8.0, -7.0, -8.0));
	blockC.e[2] = (mat2(1.0, -6.0, -1.0, -3.0));
	blockC.f = (bvec2(true, false));
	j[0] = (vec3(-1.0, 4.0, -2.0));
	j[1] = (vec3(-5.0, 5.0, 3.0));
}
#version 450
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
	float16_t a;
	lowp mat3x4 b;
	lowp ivec4 c;
	f16vec3 d;
	mediump mat3x2 e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat4 f;
	bvec2 g[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	bvec2 h[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	i16vec4 i;
	highp mat2x3 j;
	i16vec3 k;
	u16vec3 l[];
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
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(a), -8.0) && allOk;
	allOk = compare_mat3x4(b, mat3x4(-8.0, 0.0, -9.0, -1.0, 4.0, -4.0, 0.0, -2.0, -5.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4(f, mat4(-7.0, 8.0, -1.0, 3.0, -2.0, -1.0, 5.0, 2.0, 2.0, 5.0, -9.0, -3.0, 7.0, 9.0, 2.0, -9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(i), ivec4(-2, -1, -2, -9)) && allOk;
	allOk = compare_mat2x3(j, mat2x3(2.0, 2.0, 5.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(l[0]), uvec3(6u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(l[1]), uvec3(8u, 5u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(l[2]), uvec3(9u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(l[3]), uvec3(8u, 7u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(l[4]), uvec3(7u, 7u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(l[5]), uvec3(7u, 2u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(l[6]), uvec3(7u, 8u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(l[7]), uvec3(2u, 4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = float16_t(-2.0);
	b = (mat3x4(-9.0, -3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0, 2.0));
	c = (ivec4(6, 4, 6, -5));
	d = f16vec3(vec3(2.0, -9.0, -8.0));
	f = (mat4(0.0, -8.0, -8.0, 9.0, 7.0, 9.0, -4.0, 9.0, -1.0, 7.0, 0.0, -2.0, -5.0, -9.0, -3.0, 2.0));
	blockD.h[0] = (bvec2(true, false));
	blockD.h[1] = (bvec2(false, false));
	i = i16vec4(ivec4(-7, 7, 7, 3));
	j = (mat2x3(-6.0, -4.0, 5.0, -1.0, -8.0, -9.0));
	k = i16vec3(ivec3(-7, -4, -1));
	l[0] = u16vec3(uvec3(3u, 5u, 9u));
	l[1] = u16vec3(uvec3(8u, 8u, 6u));
	l[2] = u16vec3(uvec3(9u, 5u, 2u));
	l[3] = u16vec3(uvec3(0u, 0u, 5u));
	l[4] = u16vec3(uvec3(6u, 6u, 0u));
	l[5] = u16vec3(uvec3(7u, 1u, 8u));
	l[6] = u16vec3(uvec3(5u, 7u, 5u));
	l[7] = u16vec3(uvec3(5u, 0u, 7u));
}
#version 450
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
	highp vec2 b;
	highp mat3 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(-2.0, 4.0, 3.0)) && allOk;
	allOk = compare_vec2((b), vec2(-8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(-7.0, 3.0, -9.0));
	b = (vec2(-7.0, -4.0));
}
#version 450
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
};
struct sB
{
	mediump mat4x2 mA;
	lowp mat3x2 mB;
	bvec4 mC;
	highp mat4 mD;
};
struct sC
{
	bool mA[6];
	sB mB;
	float16_t mC;
};
layout(std140, binding = 1) buffer BlockB
{
	uint16_t a;
	bool b[1];
	sA c[];
} blockB[2];
layout(std140, row_major, binding = 2) buffer BlockC
{
	sC d;
};
layout(std140, binding = 3) readonly buffer BlockD
{
	mediump uvec2 e[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[0].a), 0u) && allOk;
	allOk = compare_bool((blockB[0].b[0]), false) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].a), 1u) && allOk;
	allOk = compare_bool((blockB[1].b[0]), true) && allOk;
	allOk = compare_bool((d.mA[0]), true) && allOk;
	allOk = compare_bool((d.mA[1]), true) && allOk;
	allOk = compare_bool((d.mA[2]), false) && allOk;
	allOk = compare_bool((d.mA[3]), true) && allOk;
	allOk = compare_bool((d.mA[4]), true) && allOk;
	allOk = compare_bool((d.mA[5]), false) && allOk;
	allOk = compare_mat4x2(d.mB.mA, mat4x2(8.0, -1.0, -4.0, 5.0, -6.0, -1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(d.mB.mB, mat3x2(0.0, 1.0, -5.0, 2.0, -5.0, 4.0)) && allOk;
	allOk = compare_bvec4((d.mB.mC), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat4(d.mB.mD, mat4(-8.0, 2.0, -5.0, -8.0, -3.0, 7.0, 6.0, -5.0, -5.0, 5.0, -3.0, -6.0, 7.0, -6.0, 9.0, -1.0)) && allOk;
	allOk = compare_float16_t(float(d.mC), 3.0) && allOk;
	allOk = compare_uvec2((blockD.e[0]), uvec2(9u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.e[1]), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.e[2]), uvec2(5u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.e[3]), uvec2(5u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.e[4]), uvec2(1u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.e[5]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.e[6]), uvec2(6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = uint16_t(2u);
	blockB[0].b[0] = (true);
	blockB[0].c[0].mA = (ivec3(9, 0, 9));
	blockB[0].c[1].mA = (ivec3(-5, -3, 3));
	blockB[0].c[2].mA = (ivec3(5, -9, 5));
	blockB[0].c[3].mA = (ivec3(5, 2, 6));
	blockB[0].c[4].mA = (ivec3(-5, -8, -8));
	blockB[0].c[5].mA = (ivec3(-6, 9, 7));
	blockB[0].c[6].mA = (ivec3(0, 1, -3));
	blockB[1].a = uint16_t(6u);
	blockB[1].b[0] = (true);
	blockB[1].c[0].mA = (ivec3(-9, -5, -8));
	d.mA[0] = (true);
	d.mA[1] = (false);
	d.mA[2] = (false);
	d.mA[3] = (true);
	d.mA[4] = (true);
	d.mA[5] = (false);
	d.mB.mA = (mat4x2(-6.0, 1.0, 9.0, -5.0, -2.0, 8.0, -3.0, -3.0));
	d.mB.mB = (mat3x2(5.0, 9.0, -7.0, -5.0, 3.0, 6.0));
	d.mB.mC = (bvec4(true, true, false, true));
	d.mB.mD = (mat4(7.0, 2.0, -8.0, 8.0, 1.0, 3.0, 8.0, 8.0, -1.0, 5.0, 2.0, 2.0, 9.0, 0.0, -1.0, 1.0));
	d.mC = float16_t(8.0);
}
#version 450
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
	layout(offset = 0) mediump mat4x3 a;
	layout(offset = 64) int16_t b;
	layout(offset = 80) lowp mat2x3 c;
} blockB[];

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

layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp uvec4 a;
	lowp ivec2 b;
	u8vec2 c[1];
	highp vec4 d[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp mat2x3 e;
	mediump vec4 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(4, 1)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[0]), uvec2(8u, 8u)) && allOk;
	allOk = compare_mat2x3(e, mat2x3(-1.0, 7.0, 9.0, 1.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(3u, 2u, 9u, 0u));
	blockB.b = (ivec2(-8, 8));
	blockB.c[0] = u8vec2(uvec2(4u, 0u));
	blockB.d[0] = (vec4(-5.0, -5.0, -7.0, 5.0));
	blockB.d[1] = (vec4(2.0, -4.0, -8.0, 0.0));
	blockB.d[2] = (vec4(9.0, 3.0, 1.0, -6.0));
	blockB.d[3] = (vec4(4.0, -4.0, -6.0, 9.0));
	blockB.d[4] = (vec4(3.0, 7.0, 7.0, -8.0));
	blockB.d[5] = (vec4(5.0, -2.0, -7.0, -2.0));
	blockB.d[6] = (vec4(5.0, 0.0, -1.0, 5.0));
	e = (mat2x3(4.0, -9.0, -1.0, -1.0, 7.0, -1.0));
}
#version 450
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
	mediump uvec4 mB;
};
struct sB
{
	i8vec4 mA;
	i8vec2 mB;
	int8_t mC;
	lowp mat4x3 mD;
};
struct sC
{
	sB mA;
	bvec3 mB;
	lowp uint mC;
	highp vec3 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	highp mat4x2 a;
	u8vec4 b;
	i8vec4 c;
	mediump mat4x3 d;
	uint8_t e[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	i8vec2 f;
	lowp float g;
	mediump mat3 h;
	highp float i;
	mediump vec2 j[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	sA k;
	lowp mat3x4 l;
	highp uvec3 m;
	lowp vec2 n;
	sC o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a, mat4x2(4.0, -1.0, 1.0, 6.0, 1.0, 9.0, -6.0, -4.0)) && allOk;
	allOk = compare_u8vec4(uvec4(b), uvec4(5u, 7u, 0u, 7u)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(7.0, -7.0, -1.0, -1.0, -2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0)) && allOk;
	allOk = compare_uint8_t(uint(e[0]), 1u) && allOk;
	allOk = compare_i8vec2(ivec2(f), ivec2(4294967289, 9)) && allOk;
	allOk = compare_float((g), 7.0) && allOk;
	allOk = compare_mat3(h, mat3(-5.0, -9.0, 7.0, 3.0, -6.0, -5.0, -3.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec2((j[0]), vec2(-3.0, 6.0)) && allOk;
	allOk = compare_bool((k.mA), true) && allOk;
	allOk = compare_uvec4((k.mB), uvec4(6u, 5u, 9u, 7u)) && allOk;
	allOk = compare_mat3x4(l, mat3x4(2.0, 3.0, 8.0, 6.0, -2.0, 1.0, 7.0, -6.0, 3.0, 5.0, -7.0, -6.0)) && allOk;
	allOk = compare_uvec3((m), uvec3(2u, 9u, 9u)) && allOk;
	allOk = compare_i8vec4(ivec4(o[0].mA.mA), ivec4(1, 0, 2, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(o[0].mA.mB), ivec2(4294967289, 9)) && allOk;
	allOk = compare_int8_t(int(o[0].mA.mC), 4294967290) && allOk;
	allOk = compare_mat4x3(o[0].mA.mD, mat4x3(-9.0, -1.0, -6.0, 5.0, 8.0, -6.0, -5.0, -2.0, 3.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_bvec3((o[0].mB), bvec3(true, false, false)) && allOk;
	allOk = compare_uint((o[0].mC), 2u) && allOk;
	allOk = compare_vec3((o[0].mD), vec3(9.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(5.0, 7.0, -9.0, -6.0, 1.0, -2.0, -1.0, -3.0));
	c = i8vec4(ivec4(4294967292, 3, 4, 9));
	d = (mat4x3(1.0, 2.0, -6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0));
	e[0] = uint8_t(1u);
	i = (-3.0);
	j[0] = (vec2(7.0, -4.0));
	k.mA = (false);
	k.mB = (uvec4(7u, 1u, 3u, 0u));
	m = (uvec3(5u, 7u, 3u));
	n = (vec2(-2.0, -9.0));
	o[0].mA.mA = i8vec4(ivec4(9, 7, 0, 2));
	o[0].mA.mB = i8vec2(ivec2(3, 4294967292));
	o[0].mA.mC = int8_t(4294967287);
	o[0].mA.mD = (mat4x3(-5.0, 3.0, -8.0, 4.0, 6.0, 4.0, -2.0, -6.0, 4.0, -3.0, 9.0, 7.0));
	o[0].mB = (bvec3(true, false, false));
	o[0].mC = (3u);
	o[0].mD = (vec3(-8.0, -8.0, 9.0));
}
#version 450
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
};
layout(std140, binding = 1) buffer BlockB
{
	i8vec2 a;
	mediump vec2 b;
	highp ivec2 c;
};
layout(std140, binding = 2) buffer BlockC
{
	u8vec2 d;
	highp vec2 e;
	mediump mat4 f;
	mediump vec2 g[][7];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp ivec4 h;
	u8vec3 i;
	highp mat4x2 j;
	sA k[];
};
layout(std430, binding = 4) buffer BlockE
{
	lowp vec4 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(a), ivec2(1, 4294967291)) && allOk;
	allOk = compare_vec2((b), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_ivec2((c), ivec2(1, -7)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.d), uvec2(8u, 6u)) && allOk;
	allOk = compare_mat4(blockC.f, mat4(9.0, -8.0, 2.0, 9.0, 6.0, -5.0, 7.0, 3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_vec2((blockC.g[0][0]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((blockC.g[0][1]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((blockC.g[0][2]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_vec2((blockC.g[0][3]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((blockC.g[0][4]), vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC.g[0][5]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.g[0][6]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_ivec4((h), ivec4(1, 1, -9, -3)) && allOk;
	allOk = compare_u8vec3(uvec3(i), uvec3(6u, 6u, 1u)) && allOk;
	allOk = compare_mat4x2(j, mat4x2(-4.0, -6.0, 1.0, 3.0, -4.0, -4.0, 0.0, 1.0)) && allOk;
	allOk = compare_uint((k[0].mA), 6u) && allOk;
	allOk = compare_uint((k[1].mA), 7u) && allOk;
	allOk = compare_uint((k[2].mA), 2u) && allOk;
	allOk = compare_vec4((blockE.l[0]), vec4(6.0, 5.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4((blockE.l[1]), vec4(4.0, 9.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4((blockE.l[2]), vec4(-2.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec4((blockE.l[3]), vec4(-8.0, -9.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec2(-5.0, -4.0));
	c = (ivec2(-8, -5));
	blockC.d = u8vec2(uvec2(9u, 0u));
	blockC.e = (vec2(-7.0, 5.0));
	blockC.f = (mat4(3.0, 4.0, 7.0, 8.0, 3.0, 8.0, 8.0, 0.0, 8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0, -2.0));
	blockC.g[0][0] = (vec2(-7.0, -5.0));
	blockC.g[0][1] = (vec2(7.0, -9.0));
	blockC.g[0][2] = (vec2(-5.0, 5.0));
	blockC.g[0][3] = (vec2(3.0, 7.0));
	blockC.g[0][4] = (vec2(-7.0, -6.0));
	blockC.g[0][5] = (vec2(1.0, 8.0));
	blockC.g[0][6] = (vec2(8.0, -9.0));
	h = (ivec4(-8, 4, 8, 5));
	j = (mat4x2(8.0, 8.0, 0.0, -8.0, 1.0, -8.0, 2.0, -7.0));
	blockE.l[0] = (vec4(-5.0, -8.0, -6.0, -3.0));
	blockE.l[1] = (vec4(-6.0, -4.0, -7.0, 7.0));
	blockE.l[2] = (vec4(6.0, 9.0, -9.0, 3.0));
	blockE.l[3] = (vec4(4.0, 2.0, -6.0, 4.0));
}
#version 450
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
	highp mat4x2 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump mat2x3 b;
	mediump mat3 c;
	mediump mat2x3 d;
	highp uint e;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp uvec3 f;
	i8vec3 g[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp mat2x3 h;
	mediump ivec2 i[][8];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a[0], mat4x2(2.0, -8.0, -4.0, 7.0, 4.0, 0.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[1], mat4x2(-6.0, 4.0, 5.0, 6.0, -6.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[2], mat4x2(-7.0, 7.0, 5.0, 8.0, 5.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[3], mat4x2(2.0, 3.0, -7.0, -8.0, 9.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[4], mat4x2(3.0, 6.0, -3.0, 8.0, 6.0, -4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[5], mat4x2(5.0, 8.0, -9.0, -5.0, -1.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.c, mat3(-7.0, 7.0, 6.0, 7.0, 2.0, 9.0, 1.0, 5.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(1u, 8u, 1u)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][0]), ivec2(7, 5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][1]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][2]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][3]), ivec2(3, -9)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][4]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][5]), ivec2(-2, 6)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][6]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((blockE[0].i[0][7]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][0]), ivec2(2, 4)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][1]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][2]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][3]), ivec2(0, 0)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][4]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][5]), ivec2(3, -8)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][6]), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((blockE[0].i[1][7]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][0]), ivec2(-4, 2)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][1]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][2]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][3]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][4]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][5]), ivec2(7, 6)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][6]), ivec2(9, 9)) && allOk;
	allOk = compare_ivec2((blockE[0].i[2][7]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][0]), ivec2(-3, -5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][1]), ivec2(-5, 5)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][2]), ivec2(-1, -9)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][3]), ivec2(-7, -9)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][4]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][5]), ivec2(-6, 0)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][6]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((blockE[0].i[3][7]), ivec2(4, 2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][0]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][1]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][2]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][3]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][4]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][5]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][6]), ivec2(9, 9)) && allOk;
	allOk = compare_ivec2((blockE[1].i[0][7]), ivec2(4, -7)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][0]), ivec2(4, -1)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][1]), ivec2(-5, 8)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][2]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][3]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][4]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][5]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][6]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((blockE[1].i[1][7]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][1]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][2]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][3]), ivec2(3, 9)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][4]), ivec2(9, 3)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][5]), ivec2(0, 0)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][6]), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec2((blockE[1].i[2][7]), ivec2(3, -1)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][0]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][1]), ivec2(0, -7)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][2]), ivec2(-1, -8)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][3]), ivec2(5, 6)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][4]), ivec2(-5, -5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][5]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][6]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockE[1].i[3][7]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][0]), ivec2(4, -3)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][1]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][2]), ivec2(5, 8)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][3]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][4]), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][5]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][6]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[4][7]), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][0]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][1]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][2]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][3]), ivec2(5, -5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][4]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][5]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][6]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((blockE[1].i[5][7]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][0]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][1]), ivec2(5, -2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][2]), ivec2(-1, -2)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][3]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][4]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][5]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][6]), ivec2(9, -4)) && allOk;
	allOk = compare_ivec2((blockE[1].i[6][7]), ivec2(0, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(8.0, -2.0, -1.0, -6.0, 6.0, 0.0, 9.0, 5.0));
	blockB.a[1] = (mat4x2(4.0, 8.0, 6.0, 7.0, -5.0, 5.0, -2.0, 7.0));
	blockB.a[2] = (mat4x2(4.0, 7.0, 0.0, 9.0, -4.0, -5.0, 4.0, 9.0));
	blockB.a[3] = (mat4x2(-7.0, -6.0, -2.0, -4.0, 8.0, -6.0, -4.0, 6.0));
	blockB.a[4] = (mat4x2(-3.0, -6.0, 8.0, -6.0, -7.0, -1.0, 4.0, -7.0));
	blockB.a[5] = (mat4x2(2.0, -1.0, 4.0, -6.0, 5.0, -5.0, -1.0, -2.0));
	blockC.b = (mat2x3(-3.0, -7.0, 8.0, -6.0, 7.0, 9.0));
	blockC.c = (mat3(8.0, -3.0, -4.0, 4.0, 9.0, 0.0, 1.0, 2.0, -3.0));
	blockC.e = (0u);
	blockD.f = (uvec3(6u, 1u, 2u));
	blockD.g[0] = i8vec3(ivec3(0, 9, 4294967287));
	blockD.g[1] = i8vec3(ivec3(4, 7, 6));
	blockE[0].h = (mat2x3(6.0, -4.0, -5.0, -5.0, 3.0, -2.0));
	blockE[1].h = (mat2x3(4.0, -1.0, -5.0, 3.0, 4.0, -4.0));
}
#version 450
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
	i8vec4 mB;
};
struct sB
{
	u8vec3 mA;
	lowp mat3 mB;
	sA mC;
	u8vec3 mD;
};
layout(std430, row_major, binding = 1) readonly buffer BlockB
{
	mediump mat4x3 a;
	highp vec2 b;
	sB c;
	lowp mat4 d[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[0].c.mA), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_mat3(blockB[0].c.mB, mat3(8.0, -8.0, -2.0, 3.0, 8.0, -7.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockB[0].c.mC.mA), uvec4(0u, 8u, 5u, 8u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[0].c.mC.mB), ivec4(4294967293, 2, 4294967290, 9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[0].c.mD), uvec3(1u, 1u, 1u)) && allOk;
	allOk = compare_mat4(blockB[0].d[0], mat4(-5.0, -4.0, -4.0, 5.0, -6.0, 8.0, 5.0, 3.0, -5.0, 1.0, -3.0, -7.0, -8.0, -9.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[1], mat4(-4.0, -3.0, 5.0, 2.0, -7.0, 8.0, -9.0, 5.0, 2.0, 5.0, -7.0, 1.0, 5.0, 1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[2], mat4(9.0, 5.0, -3.0, 0.0, 0.0, -3.0, -5.0, 6.0, -6.0, -6.0, 2.0, -9.0, -9.0, 2.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[3], mat4(9.0, -3.0, -6.0, -7.0, -3.0, 7.0, -6.0, -9.0, 8.0, -7.0, -6.0, -7.0, 2.0, -6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[4], mat4(-7.0, 1.0, 4.0, -8.0, 3.0, 9.0, 3.0, -2.0, 7.0, -5.0, 0.0, -8.0, 4.0, 2.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[5], mat4(1.0, 6.0, -3.0, 5.0, 5.0, 4.0, -2.0, 1.0, 3.0, 8.0, -9.0, -4.0, 1.0, 3.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp ivec2 a;
	mediump vec2 b;
	i8vec2 c[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp uvec4 d[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(-2, 4)) && allOk;
	allOk = compare_vec2((b), vec2(8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(7, -6));
	b = (vec2(8.0, 6.0));
	blockC.d[0] = (uvec4(4u, 7u, 2u, 7u));
	blockC.d[1] = (uvec4(2u, 6u, 8u, 3u));
	blockC.d[2] = (uvec4(8u, 3u, 9u, 8u));
	blockC.d[3] = (uvec4(6u, 2u, 0u, 6u));
	blockC.d[4] = (uvec4(4u, 1u, 1u, 1u));
	blockC.d[5] = (uvec4(5u, 4u, 3u, 0u));
}
#version 450
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
	layout(offset = 0) mediump float a;
	layout(offset = 4) int8_t b;
	layout(offset = 8) mediump int c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec4 d;
	layout(offset = 16) bool e;
	layout(offset = 20) mediump uvec2 f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 6.0) && allOk;
	allOk = compare_int((blockB.c), 5) && allOk;
	allOk = compare_ivec4((blockC.d), ivec4(2, 5, -2, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8.0);
	blockB.b = int8_t(4294967289);
	blockB.c = (-6);
	blockC.d = (ivec4(-9, -1, 3, -9));
	blockC.e = (false);
	blockC.f = (uvec2(2u, 1u));
}
#version 450
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
	layout(offset = 0) lowp float a;
	layout(offset = 4) int8_t b;
	layout(offset = 16) mediump ivec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) int8_t d;
	layout(offset = 16) mediump ivec4 e;
	layout(offset = 32) i8vec2 f;
	layout(offset = 36) lowp uint g[1];
	layout(offset = 48) highp ivec4 h;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump vec2 i;
	layout(offset = 8) highp uvec2 j;
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_int8_t(int(blockB.b), 4) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(-4, -9, 0, 6)) && allOk;
	allOk = compare_int8_t(int(d), 0) && allOk;
	allOk = compare_ivec4((e), ivec4(6, 4, -1, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(f), ivec2(4294967291, 4294967292)) && allOk;
	allOk = compare_ivec4((h), ivec4(4, 1, 9, -2)) && allOk;
	allOk = compare_vec2((blockD[0].i), vec2(6.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockD[0].j), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-9.0);
	blockB.b = int8_t(4294967287);
	blockB.c = (ivec4(8, -8, -4, 0));
	d = int8_t(0);
	e = (ivec4(8, -5, 7, 4));
	f = i8vec2(ivec2(3, 3));
	g[0] = (6u);
	blockD[0].j = (uvec2(2u, 7u));
}
#version 450
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
	mediump uvec3 b;
	bool c;
	highp mat4x3 d;
	lowp vec3 e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(-8.0, 5.0, -1.0, -2.0, 6.0, 6.0, 9.0, -1.0, 0.0, -5.0, 9.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(6u, 4u, 0u)) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_vec3((blockB.e), vec3(-6.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(1.0, 8.0, 3.0, 1.0, -4.0, 0.0, -4.0, 1.0, -9.0, 1.0, -9.0, -6.0));
	blockB.b = (uvec3(3u, 9u, 8u));
	blockB.c = (true);
	blockB.e = (vec3(-8.0, -9.0, -2.0));
}
#version 450
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
	u8vec4 mA;
	highp mat3x2 mB;
	bvec3 mC;
	mediump mat4x3 mD[7];
};
struct sC
{
	sB mA;
	lowp ivec2 mB;
	lowp uvec3 mC;
};
struct sD
{
	u8vec3 mA;
};
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	sA a;
	mediump ivec2 b[][8];
} blockB[1];
layout(scalar, column_major, binding = 2) readonly buffer BlockC
{
	sC c;
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	mediump mat3x4 d;
	mediump int e;
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	sD f[5];
	lowp uvec3 g[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a.mA, mat3x2(4.0, -6.0, -2.0, 4.0, 6.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][0]), ivec2(-1, -2)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][1]), ivec2(2, -9)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][2]), ivec2(-1, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][3]), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][4]), ivec2(-8, -5)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][5]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][6]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((blockB[0].b[0][7]), ivec2(5, -9)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c.mA.mA), uvec4(4u, 0u, 2u, 1u)) && allOk;
	allOk = compare_mat3x2(blockC.c.mA.mB, mat3x2(1.0, 6.0, 2.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockC.c.mA.mC), bvec3(false, true, true)) && allOk;
	allOk = compare_mat4x3(blockC.c.mA.mD[0], mat4x3(0.0, -2.0, -1.0, 8.0, 6.0, -7.0, 9.0, -3.0, -5.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mA.mD[1], mat4x3(-6.0, 2.0, -9.0, 9.0, -5.0, -7.0, 6.0, -2.0, -1.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mA.mD[2], mat4x3(-7.0, -8.0, -9.0, 5.0, -7.0, 4.0, -5.0, -3.0, -7.0, -8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mA.mD[3], mat4x3(3.0, 4.0, -1.0, -1.0, -8.0, -3.0, 9.0, -8.0, 1.0, 6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mA.mD[4], mat4x3(2.0, 5.0, -1.0, -3.0, 4.0, -7.0, -2.0, -9.0, 1.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mA.mD[5], mat4x3(-9.0, 8.0, -4.0, 9.0, -4.0, -6.0, 1.0, 6.0, -1.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mA.mD[6], mat4x3(5.0, 2.0, 6.0, 5.0, 8.0, 4.0, 7.0, -6.0, -4.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockC.c.mB), ivec2(-5, -6)) && allOk;
	allOk = compare_uvec3((blockC.c.mC), uvec3(1u, 1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.e = (8);
	blockE.g[0] = (uvec3(0u, 8u, 9u));
	blockE.g[1] = (uvec3(9u, 0u, 6u));
	blockE.g[2] = (uvec3(9u, 1u, 4u));
	blockE.g[3] = (uvec3(5u, 4u, 0u));
	blockE.g[4] = (uvec3(6u, 7u, 1u));
	blockE.g[5] = (uvec3(1u, 5u, 9u));
}
#version 450
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
	lowp mat4 a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a[0], mat4(1.0, 1.0, 0.0, -5.0, -7.0, 9.0, -5.0, 8.0, -3.0, 4.0, 9.0, 0.0, 0.0, -9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.a[1], mat4(5.0, -1.0, -3.0, 5.0, 4.0, 1.0, 5.0, -6.0, 6.0, -4.0, -3.0, -9.0, -1.0, -8.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(8.0, 6.0, 5.0, 9.0, 2.0, -3.0, 0.0, -5.0, -4.0, 1.0, -6.0, 1.0, -8.0, 6.0, -3.0, 3.0));
	blockB.a[1] = (mat4(-6.0, -1.0, 8.0, -6.0, -8.0, -1.0, -7.0, -4.0, 0.0, 5.0, 2.0, -8.0, 6.0, 3.0, -3.0, -6.0));
}
#version 450
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
	u8vec3 a;
} blockB[];

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].a), uvec3(3u, 0u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].a), uvec3(0u, 4u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(2)].a), uvec3(4u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u8vec3(uvec3(7u, 9u, 4u));
	blockB[nonuniformEXT(1)].a = u8vec3(uvec3(8u, 7u, 4u));
	blockB[nonuniformEXT(2)].a = u8vec3(uvec3(4u, 2u, 4u));
}
#version 450
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
	mediump float a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].a), 1.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].a), -3.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].a), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (9.0);
	blockB[nonuniformEXT(1)].a = (-2.0);
	blockB[nonuniformEXT(2)].a = (-3.0);
}
#version 450
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
	highp vec2 a[1];
	highp int b;
	i8vec3 c[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec2(4.0, 0.0));
	blockB[nonuniformEXT(0)].b = (9);
	blockB[nonuniformEXT(1)].a[0] = (vec2(-4.0, -4.0));
	blockB[nonuniformEXT(1)].b = (-6);
}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(-6.0, -1.0, -7.0, -3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(1.0, 3.0, -8.0, 6.0, -6.0, -5.0, -8.0, 8.0, 3.0, 4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-9.0, 9.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-9.0, 3.0, -5.0, 1.0, 4.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(6.0, 7.0, 5.0, -7.0, -7.0, -3.0, 8.0, 1.0, 2.0, 8.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], 4.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_float(var[3][0], 5.0) && allOk;
	allOk = compare_float(var[3][1], -7.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_float(var[3][3], 6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(7.0, -1.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, -4.0, -3.0, 2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, -1.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(5.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(8.0, 1.0, -1.0, 5.0, -1.0, 6.0, 8.0, 5.0, 2.0, 0.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[2][0], 0.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], -1.0) && allOk;
	allOk = compare_float(var[3][1], -7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(1.0, 2.0, 1.0, -6.0, -9.0, 7.0, 0.0, -3.0, -2.0, -3.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], -4.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-7.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(0.0, 6.0, 4.0, 7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(1.0, 7.0, -4.0, 9.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, -4.0, 6.0, 2.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, column_major, binding = 1) readonly buffer Block
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], -6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-9.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-7.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-9.0, 6.0, -2.0));
	block.var[1] = (vec3(-9.0, 9.0, -9.0));
	block.var[2] = (vec3(6.0, 9.0, -6.0));
	block.var[3] = (vec3(-2.0, 0.0, -9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], 8.0) && allOk;
	allOk = compare_float(block.var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-5.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(9.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(9.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(1.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(0.0, 7.0, -1.0, 6.0, -7.0, 7.0, -9.0, -9.0, 4.0, 1.0, 2.0, -2.0));
}
#version 450
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
	i8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var), ivec2(4294967288, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i8vec2(ivec2(0, 8));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-9.0, 2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(7.0, -8.0, -3.0, 9.0, -3.0, -5.0, -4.0, 4.0, 0.0, 3.0, 2.0, 1.0, 2.0, -4.0, -7.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(6.0, 8.0, 5.0, 2.0, -2.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(-3.0, -8.0, -3.0, -1.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (vec3(-9.0, 5.0, 7.0));
	block.var[1] = (vec3(-6.0, -6.0, 2.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[2][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[2][1] = (vec3(3.0, 9.0, -8.0));
	block.var[2][2] = (vec3(-4.0, 8.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
}
#version 450
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
	bool var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), false) && allOk;
	allOk = compare_bool((block.var[0]), true) && allOk;
	allOk = compare_bool((block.var[1]), true) && allOk;
	allOk = compare_bool((block.var[2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (false);
	block.var[0] = (false);
	block.var[1] = (true);
	block.var[2] = (true);
}
#version 450
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
	highp uvec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var[0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[3]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[4]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[5]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[6]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[7]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[8]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[9]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[10]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[11]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[12]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[13]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[14]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[15]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[16]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[17]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[18]), uvec4(9u, 6u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[2] = (uvec4(3u, 4u, 4u, 2u));
	block.var[3] = (uvec4(0u, 5u, 6u, 2u));
	block.var[4] = (uvec4(9u, 5u, 7u, 7u));
	block.var[5] = (uvec4(0u, 3u, 8u, 1u));
	block.var[6] = (uvec4(4u, 9u, 1u, 3u));
	block.var[7] = (uvec4(8u, 8u, 8u, 1u));
	block.var[8] = (uvec4(7u, 5u, 4u, 8u));
	block.var[9] = (uvec4(6u, 6u, 0u, 9u));
	block.var[10] = (uvec4(7u, 2u, 3u, 0u));
	block.var[11] = (uvec4(4u, 4u, 8u, 5u));
	block.var[12] = (uvec4(6u, 1u, 9u, 4u));
	block.var[13] = (uvec4(5u, 7u, 7u, 0u));
	block.var[14] = (uvec4(2u, 5u, 1u, 3u));
	block.var[15] = (uvec4(9u, 6u, 1u, 2u));
	block.var[16] = (uvec4(0u, 0u, 8u, 4u));
	block.var[17] = (uvec4(9u, 5u, 7u, 1u));
	block.var[18] = (uvec4(2u, 0u, 0u, 4u));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(6.0, 9.0));
	block.var[0][1] = (vec2(-4.0, -4.0));
	block.var[0][2] = (vec2(2.0, 0.0));
	block.var[0][3] = (vec2(-7.0, 3.0));
	block.var[1][0] = (vec2(9.0, -6.0));
	block.var[1][1] = (vec2(8.0, -9.0));
	block.var[1][2] = (vec2(-9.0, -6.0));
	block.var[1][3] = (vec2(-4.0, -6.0));
	block.var[2][0] = (vec2(-8.0, 5.0));
	block.var[2][1] = (vec2(6.0, -8.0));
	block.var[2][2] = (vec2(-8.0, 3.0));
	block.var[2][3] = (vec2(2.0, 8.0));
	block.var[3][0] = (vec2(-8.0, -1.0));
	block.var[3][1] = (vec2(-3.0, 0.0));
	block.var[3][2] = (vec2(7.0, 5.0));
	block.var[3][3] = (vec2(-8.0, 5.0));
	block.var[4][0] = (vec2(7.0, 8.0));
	block.var[4][1] = (vec2(4.0, -2.0));
	block.var[4][2] = (vec2(4.0, -2.0));
	block.var[4][3] = (vec2(-2.0, 9.0));
	block.var[5][0] = (vec2(4.0, -4.0));
	block.var[5][1] = (vec2(-5.0, -5.0));
	block.var[5][2] = (vec2(-6.0, 8.0));
	block.var[5][3] = (vec2(9.0, -5.0));
	block.var[6][0] = (vec2(-2.0, 1.0));
	block.var[6][1] = (vec2(6.0, -2.0));
	block.var[6][2] = (vec2(2.0, -5.0));
	block.var[6][3] = (vec2(3.0, -3.0));
	block.var[7][0] = (vec2(-6.0, -4.0));
	block.var[7][1] = (vec2(-6.0, -7.0));
	block.var[7][2] = (vec2(9.0, 1.0));
	block.var[7][3] = (vec2(-4.0, 3.0));
	block.var[8][0] = (vec2(7.0, -9.0));
	block.var[8][1] = (vec2(7.0, -4.0));
	block.var[8][2] = (vec2(8.0, -2.0));
	block.var[8][3] = (vec2(9.0, 0.0));
	block.var[9][0] = (vec2(-9.0, 7.0));
	block.var[9][1] = (vec2(1.0, 4.0));
	block.var[9][2] = (vec2(-7.0, 9.0));
	block.var[9][3] = (vec2(-5.0, 2.0));
	block.var[10][0] = (vec2(-9.0, -3.0));
	block.var[10][1] = (vec2(-8.0, 5.0));
	block.var[10][2] = (vec2(-2.0, -8.0));
	block.var[10][3] = (vec2(7.0, -6.0));
	block.var[11][0] = (vec2(-7.0, 1.0));
	block.var[11][1] = (vec2(-3.0, 7.0));
	block.var[11][2] = (vec2(6.0, -5.0));
	block.var[11][3] = (vec2(9.0, -2.0));
	block.var[12][0] = (vec2(-9.0, -3.0));
	block.var[12][1] = (vec2(5.0, -5.0));
	block.var[12][2] = (vec2(3.0, 4.0));
	block.var[12][3] = (vec2(-9.0, 1.0));
	block.var[13][0] = (vec2(0.0, 8.0));
	block.var[13][1] = (vec2(-8.0, 3.0));
	block.var[13][2] = (vec2(-7.0, 9.0));
	block.var[13][3] = (vec2(-8.0, -7.0));
	block.var[14][0] = (vec2(7.0, 1.0));
	block.var[14][1] = (vec2(-1.0, -2.0));
	block.var[14][2] = (vec2(-8.0, -3.0));
	block.var[14][3] = (vec2(9.0, -1.0));
	block.var[15][0] = (vec2(-2.0, 1.0));
	block.var[15][1] = (vec2(-8.0, -7.0));
	block.var[15][2] = (vec2(-5.0, 7.0));
	block.var[15][3] = (vec2(-5.0, -7.0));
	block.var[16][0] = (vec2(-5.0, 2.0));
	block.var[16][1] = (vec2(-4.0, 8.0));
	block.var[16][2] = (vec2(-7.0, 6.0));
	block.var[16][3] = (vec2(5.0, 2.0));
	block.var[17][0] = (vec2(-5.0, 3.0));
	block.var[17][1] = (vec2(-9.0, 7.0));
	block.var[17][2] = (vec2(-3.0, -3.0));
	block.var[17][3] = (vec2(-7.0, -4.0));
	block.var[18][0] = (vec2(3.0, 7.0));
	block.var[18][1] = (vec2(-6.0, -7.0));
	block.var[18][2] = (vec2(-7.0, 5.0));
	block.var[18][3] = (vec2(-8.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, 2.0, -5.0));
	block.var[0][1] = (vec3(-3.0, -2.0, 2.0));
	block.var[0][2] = (vec3(-5.0, 9.0, 4.0));
	block.var[0][3] = (vec3(2.0, -4.0, 9.0));
	block.var[1][0] = (vec3(8.0, -4.0, -5.0));
	block.var[1][1] = (vec3(-5.0, 6.0, 8.0));
	block.var[1][2] = (vec3(-7.0, 4.0, -8.0));
	block.var[1][3] = (vec3(-1.0, 1.0, 1.0));
	block.var[2][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[2][1] = (vec3(9.0, 5.0, -7.0));
	block.var[2][2] = (vec3(8.0, 9.0, 0.0));
	block.var[2][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[3][0] = (vec3(7.0, -8.0, -7.0));
	block.var[3][1] = (vec3(2.0, 7.0, 5.0));
	block.var[3][2] = (vec3(5.0, -7.0, 0.0));
	block.var[3][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[4][0] = (vec3(2.0, -9.0, 0.0));
	block.var[4][1] = (vec3(9.0, -2.0, -8.0));
	block.var[4][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[4][3] = (vec3(0.0, 8.0, -9.0));
	block.var[5][0] = (vec3(2.0, 1.0, -7.0));
	block.var[5][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[5][2] = (vec3(8.0, -8.0, -5.0));
	block.var[5][3] = (vec3(5.0, 1.0, -3.0));
	block.var[6][0] = (vec3(2.0, 5.0, 2.0));
	block.var[6][1] = (vec3(2.0, 3.0, -2.0));
	block.var[6][2] = (vec3(5.0, 4.0, 6.0));
	block.var[6][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[7][0] = (vec3(1.0, 2.0, -4.0));
	block.var[7][1] = (vec3(9.0, -1.0, 6.0));
	block.var[7][2] = (vec3(9.0, -1.0, -2.0));
	block.var[7][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[8][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[8][1] = (vec3(4.0, 2.0, 0.0));
	block.var[8][2] = (vec3(1.0, -6.0, 1.0));
	block.var[8][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[9][0] = (vec3(1.0, 9.0, -4.0));
	block.var[9][1] = (vec3(1.0, -5.0, 9.0));
	block.var[9][2] = (vec3(2.0, -1.0, -1.0));
	block.var[9][3] = (vec3(5.0, 7.0, -4.0));
	block.var[10][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[10][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[10][2] = (vec3(0.0, 7.0, 9.0));
	block.var[10][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[11][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[11][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[11][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[11][3] = (vec3(-5.0, -7.0, 7.0));
	block.var[12][0] = (vec3(-5.0, 3.0, -5.0));
	block.var[12][1] = (vec3(-6.0, 6.0, 3.0));
	block.var[12][2] = (vec3(-6.0, 0.0, -5.0));
	block.var[12][3] = (vec3(-9.0, 8.0, -8.0));
	block.var[13][0] = (vec3(-5.0, 2.0, -7.0));
	block.var[13][1] = (vec3(-1.0, -2.0, 7.0));
	block.var[13][2] = (vec3(4.0, -7.0, 7.0));
	block.var[13][3] = (vec3(-3.0, 7.0, 6.0));
	block.var[14][0] = (vec3(9.0, -2.0, 2.0));
	block.var[14][1] = (vec3(-3.0, -6.0, 3.0));
	block.var[14][2] = (vec3(7.0, -7.0, -1.0));
	block.var[14][3] = (vec3(0.0, 1.0, -3.0));
	block.var[15][0] = (vec3(-6.0, 6.0, 2.0));
	block.var[15][1] = (vec3(-5.0, 0.0, 4.0));
	block.var[15][2] = (vec3(7.0, -6.0, -6.0));
	block.var[15][3] = (vec3(3.0, 8.0, 1.0));
	block.var[16][0] = (vec3(-3.0, -1.0, 7.0));
	block.var[16][1] = (vec3(-2.0, -7.0, -9.0));
	block.var[16][2] = (vec3(-8.0, -1.0, 4.0));
	block.var[16][3] = (vec3(0.0, -2.0, -5.0));
	block.var[17][0] = (vec3(2.0, -7.0, 3.0));
	block.var[17][1] = (vec3(-2.0, 4.0, -6.0));
	block.var[17][2] = (vec3(8.0, -7.0, -9.0));
	block.var[17][3] = (vec3(-4.0, 5.0, 4.0));
	block.var[18][0] = (vec3(1.0, -1.0, 8.0));
	block.var[18][1] = (vec3(8.0, 3.0, -9.0));
	block.var[18][2] = (vec3(1.0, -1.0, -7.0));
	block.var[18][3] = (vec3(-1.0, -7.0, -5.0));
}
#version 450
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
	highp uvec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[3]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[4]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[6]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[7]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[8]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[9]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[10]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[11]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[13]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[14]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[15]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[16]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[17]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[18]), uvec2(8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec2(6u, 1u));
	block.var[1] = (uvec2(8u, 1u));
	block.var[2] = (uvec2(7u, 4u));
	block.var[3] = (uvec2(6u, 6u));
	block.var[4] = (uvec2(5u, 8u));
	block.var[5] = (uvec2(4u, 7u));
	block.var[6] = (uvec2(8u, 4u));
	block.var[7] = (uvec2(6u, 3u));
	block.var[8] = (uvec2(6u, 0u));
	block.var[9] = (uvec2(3u, 5u));
	block.var[10] = (uvec2(2u, 4u));
	block.var[11] = (uvec2(7u, 8u));
	block.var[12] = (uvec2(6u, 2u));
	block.var[13] = (uvec2(6u, 0u));
	block.var[14] = (uvec2(3u, 2u));
	block.var[15] = (uvec2(5u, 1u));
	block.var[16] = (uvec2(7u, 2u));
	block.var[17] = (uvec2(3u, 6u));
	block.var[18] = (uvec2(0u, 1u));
}
#version 450
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
	bvec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block.var[0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[3][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][2]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (bvec3(true, true, false));
	block.var[0][1] = (bvec3(false, true, true));
	block.var[0][2] = (bvec3(false, false, false));
	block.var[1][0] = (bvec3(true, false, false));
	block.var[1][1] = (bvec3(true, true, true));
	block.var[1][2] = (bvec3(false, true, true));
	block.var[2][0] = (bvec3(false, true, true));
	block.var[2][1] = (bvec3(true, true, true));
	block.var[2][2] = (bvec3(true, true, true));
	block.var[3][0] = (bvec3(true, false, false));
	block.var[3][1] = (bvec3(false, true, false));
	block.var[3][2] = (bvec3(true, false, false));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[0][2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	block.var[1][0] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	block.var[1][1] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	block.var[1][2] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	block.var[2][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	block.var[2][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	block.var[2][2] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	block.var[3][0] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	block.var[3][1] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	block.var[3][2] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
}
#version 450
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
	uint8_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var[0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = uint8_t(9u);
	block.var[0][1] = uint8_t(5u);
	block.var[0][2] = uint8_t(2u);
	block.var[1][0] = uint8_t(6u);
	block.var[1][1] = uint8_t(7u);
	block.var[1][2] = uint8_t(5u);
	block.var[2][0] = uint8_t(8u);
	block.var[2][1] = uint8_t(4u);
	block.var[2][2] = uint8_t(2u);
	block.var[3][0] = uint8_t(6u);
	block.var[3][1] = uint8_t(0u);
	block.var[3][2] = uint8_t(1u);
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(3.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(5.0, 4.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(2.0, -7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(9.0, 1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-6.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(3.0, 7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(6.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-4.0, -1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-4.0, -3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(7.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(4.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(6.0, -7.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0] = (mat2(4.0, 4.0, -1.0, 2.0));
	block.var[0][1] = (mat2(-5.0, 1.0, -1.0, -2.0));
	block.var[0][2] = (mat2(-9.0, -3.0, -8.0, -6.0));
	block.var[1][0] = (mat2(-7.0, 1.0, -1.0, 6.0));
	block.var[1][1] = (mat2(2.0, -7.0, 8.0, -3.0));
	block.var[1][2] = (mat2(-2.0, 2.0, -7.0, -1.0));
	block.var[2][0] = (mat2(-3.0, -7.0, 2.0, -3.0));
	block.var[2][1] = (mat2(-6.0, 2.0, 7.0, 4.0));
	block.var[2][2] = (mat2(-2.0, -7.0, 4.0, -7.0));
	block.var[3][0] = (mat2(-5.0, -7.0, -5.0, -6.0));
	block.var[3][1] = (mat2(4.0, 6.0, 4.0, 2.0));
	block.var[3][2] = (mat2(-1.0, 9.0, 6.0, -5.0));
}
#version 450
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
	int16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0][0]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][1]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[0][2]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][1]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[1][2]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[2][0]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][1]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[2][2]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[3][0]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[3][1]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[3][2]), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0][0] = int16_t(8);
	block.var[0][1] = int16_t(-2);
	block.var[0][2] = int16_t(-4);
	block.var[1][0] = int16_t(-3);
	block.var[1][1] = int16_t(9);
	block.var[1][2] = int16_t(-5);
	block.var[2][0] = int16_t(-8);
	block.var[2][1] = int16_t(-3);
	block.var[2][2] = int16_t(2);
	block.var[3][0] = int16_t(-1);
	block.var[3][1] = int16_t(4);
	block.var[3][2] = int16_t(3);
}
#version 450
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
	i16vec4 var[4][3];
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
	allOk = compare_i16vec4(ivec4(block.var[0][0]), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1]), ivec4(-8, 8, 9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2]), ivec4(4, 0, 9, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0]), ivec4(-4, -9, -3, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1]), ivec4(-1, 4, -1, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2]), ivec4(7, -4, 7, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0]), ivec4(9, 9, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1]), ivec4(-8, -7, 3, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2]), ivec4(-2, -8, -7, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0]), ivec4(6, 9, -6, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1]), ivec4(-3, 9, 7, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][2]), ivec4(8, -6, -2, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(-4);
	block.var[0][0] = i16vec4(ivec4(-8, -4, 9, 2));
	block.var[0][1] = i16vec4(ivec4(7, -4, 4, 8));
	block.var[0][2] = i16vec4(ivec4(9, 5, 1, -3));
	block.var[1][0] = i16vec4(ivec4(3, 8, 7, 2));
	block.var[1][1] = i16vec4(ivec4(6, -9, 9, -2));
	block.var[1][2] = i16vec4(ivec4(4, -8, -7, -9));
	block.var[2][0] = i16vec4(ivec4(-1, -8, -1, -1));
	block.var[2][1] = i16vec4(ivec4(-6, 5, 2, -3));
	block.var[2][2] = i16vec4(ivec4(8, -7, -2, 9));
	block.var[3][0] = i16vec4(ivec4(7, 6, -9, 5));
	block.var[3][1] = i16vec4(ivec4(-3, 8, 5, -6));
	block.var[3][2] = i16vec4(ivec4(-9, -6, 2, 7));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0, 7.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0, -5.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(-6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0, -9.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0, 3.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(-5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0, -5.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0, -4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0, 4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0, -3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0, -8.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0, -5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0, -3.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0, 3.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0][0][0] = (mat4x3(-5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0, 9.0, 2.0, -5.0));
	block.var[0][0][1] = (mat4x3(-6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0, 2.0, 4.0, 4.0));
	block.var[0][0][2] = (mat4x3(-9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0, 2.0, 8.0, 9.0));
	block.var[0][1][0] = (mat4x3(5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0, 9.0, 7.0, 9.0));
	block.var[0][1][1] = (mat4x3(5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0, -6.0, -9.0, 7.0));
	block.var[0][1][2] = (mat4x3(9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0, 3.0, 4.0, -1.0));
	block.var[1][0][0] = (mat4x3(-3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0, -7.0, -4.0, 9.0));
	block.var[1][0][1] = (mat4x3(7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0, 0.0, 0.0, -4.0));
	block.var[1][0][2] = (mat4x3(-5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0, 1.0, 3.0, -8.0));
	block.var[1][1][0] = (mat4x3(-9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0, 6.0, 7.0, 7.0));
	block.var[1][1][1] = (mat4x3(0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0, 7.0, -6.0, -1.0));
	block.var[1][1][2] = (mat4x3(1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0, -5.0, -8.0, 5.0));
	block.var[2][0][0] = (mat4x3(-5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0, -3.0, -8.0, 8.0));
	block.var[2][0][1] = (mat4x3(9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0, -8.0, -9.0, -8.0));
	block.var[2][0][2] = (mat4x3(-9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0, 9.0, 8.0, 8.0));
	block.var[2][1][0] = (mat4x3(-6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0, -9.0, 3.0, -3.0));
	block.var[2][1][1] = (mat4x3(-5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0, -7.0, -1.0, -7.0));
	block.var[2][1][2] = (mat4x3(4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0, -1.0, 4.0, -8.0));
	block.var[3][0][0] = (mat4x3(2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0, -3.0, -6.0, 1.0));
	block.var[3][0][1] = (mat4x3(-5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0, -6.0, -5.0, -4.0));
	block.var[3][0][2] = (mat4x3(-4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0, 8.0, 5.0, 4.0));
	block.var[3][1][0] = (mat4x3(2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0, -4.0, -4.0, 1.0));
	block.var[3][1][1] = (mat4x3(-8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0, -2.0, 8.0, -7.0));
	block.var[3][1][2] = (mat4x3(2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0, -4.0, 2.0, -4.0));
}
#version 450
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
	u8vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0][0]), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0][1]), uvec4(5u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0][2]), uvec4(4u, 6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][0]), uvec4(5u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][1]), uvec4(7u, 8u, 5u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][2]), uvec4(5u, 6u, 6u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][0]), uvec4(7u, 6u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][1]), uvec4(3u, 3u, 2u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][2]), uvec4(2u, 2u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][0]), uvec4(5u, 4u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][1]), uvec4(0u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][2]), uvec4(3u, 8u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][0]), uvec4(9u, 5u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][1]), uvec4(2u, 0u, 2u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][2]), uvec4(3u, 7u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][0]), uvec4(4u, 1u, 6u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][1]), uvec4(8u, 2u, 2u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][2]), uvec4(3u, 4u, 1u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][0]), uvec4(7u, 4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][1]), uvec4(8u, 5u, 7u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][2]), uvec4(6u, 3u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][0]), uvec4(9u, 9u, 5u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][1]), uvec4(8u, 0u, 2u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][2]), uvec4(3u, 9u, 6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(9u);
	block.var[0][0][0] = u8vec4(uvec4(5u, 9u, 4u, 6u));
	block.var[0][0][1] = u8vec4(uvec4(8u, 7u, 3u, 6u));
	block.var[0][0][2] = u8vec4(uvec4(7u, 1u, 9u, 8u));
	block.var[0][1][0] = u8vec4(uvec4(2u, 7u, 4u, 8u));
	block.var[0][1][1] = u8vec4(uvec4(9u, 1u, 4u, 7u));
	block.var[0][1][2] = u8vec4(uvec4(0u, 8u, 1u, 0u));
	block.var[1][0][0] = u8vec4(uvec4(9u, 3u, 3u, 3u));
	block.var[1][0][1] = u8vec4(uvec4(9u, 0u, 6u, 8u));
	block.var[1][0][2] = u8vec4(uvec4(7u, 6u, 7u, 7u));
	block.var[1][1][0] = u8vec4(uvec4(4u, 9u, 9u, 9u));
	block.var[1][1][1] = u8vec4(uvec4(3u, 5u, 3u, 1u));
	block.var[1][1][2] = u8vec4(uvec4(4u, 3u, 3u, 8u));
	block.var[2][0][0] = u8vec4(uvec4(7u, 4u, 8u, 8u));
	block.var[2][0][1] = u8vec4(uvec4(5u, 3u, 1u, 1u));
	block.var[2][0][2] = u8vec4(uvec4(4u, 7u, 1u, 3u));
	block.var[2][1][0] = u8vec4(uvec4(9u, 4u, 7u, 0u));
	block.var[2][1][1] = u8vec4(uvec4(4u, 6u, 7u, 4u));
	block.var[2][1][2] = u8vec4(uvec4(2u, 8u, 9u, 9u));
	block.var[3][0][0] = u8vec4(uvec4(6u, 3u, 3u, 4u));
	block.var[3][0][1] = u8vec4(uvec4(7u, 8u, 8u, 1u));
	block.var[3][0][2] = u8vec4(uvec4(7u, 7u, 2u, 5u));
	block.var[3][1][0] = u8vec4(uvec4(8u, 8u, 1u, 2u));
	block.var[3][1][1] = u8vec4(uvec4(6u, 8u, 6u, 9u));
	block.var[3][1][2] = u8vec4(uvec4(6u, 5u, 0u, 1u));
}
#version 450
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
	uint16_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][1]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][2]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][2]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][2]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(9u);
	block.var[0][0][0] = uint16_t(1u);
	block.var[0][0][1] = uint16_t(1u);
	block.var[0][0][2] = uint16_t(0u);
	block.var[0][1][0] = uint16_t(1u);
	block.var[0][1][1] = uint16_t(0u);
	block.var[0][1][2] = uint16_t(2u);
	block.var[1][0][0] = uint16_t(7u);
	block.var[1][0][1] = uint16_t(5u);
	block.var[1][0][2] = uint16_t(8u);
	block.var[1][1][0] = uint16_t(1u);
	block.var[1][1][1] = uint16_t(1u);
	block.var[1][1][2] = uint16_t(2u);
	block.var[2][0][0] = uint16_t(1u);
	block.var[2][0][1] = uint16_t(9u);
	block.var[2][0][2] = uint16_t(7u);
	block.var[2][1][0] = uint16_t(9u);
	block.var[2][1][1] = uint16_t(3u);
	block.var[2][1][2] = uint16_t(0u);
	block.var[3][0][0] = uint16_t(2u);
	block.var[3][0][1] = uint16_t(6u);
	block.var[3][0][2] = uint16_t(3u);
	block.var[3][1][0] = uint16_t(8u);
	block.var[3][1][1] = uint16_t(4u);
	block.var[3][1][2] = uint16_t(6u);
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(1.0, 4.0, -6.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(1.0, -7.0, -5.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(4.0, 5.0, 5.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-6.0, 0.0, -5.0, 2.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-6.0, -8.0, -1.0, -8.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[0][0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[0][1][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[0][1][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[0][2][0] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	block.var[0][2][1] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	block.var[0][3][0] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
	block.var[0][3][1] = (mat2x3(3.0, 8.0, -9.0, 8.0, 6.0, 0.0));
	block.var[1][0][0] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[1][0][1] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[1][1][0] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[1][1][1] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[1][2][0] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	block.var[1][2][1] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	block.var[1][3][0] = (mat2x3(2.0, 3.0, 4.0, 3.0, 4.0, 2.0));
	block.var[1][3][1] = (mat2x3(-1.0, -4.0, 9.0, -8.0, 2.0, 8.0));
	block.var[2][0][0] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[2][0][1] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[2][1][0] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[2][1][1] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	block.var[2][2][0] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	block.var[2][2][1] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	block.var[2][3][0] = (mat2x3(6.0, -6.0, 4.0, -3.0, -1.0, -9.0));
	block.var[2][3][1] = (mat2x3(6.0, 3.0, -4.0, -2.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(0.0, -6.0, -7.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(3.0, 6.0, -6.0, -5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(7.0, 0.0, -9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-9.0, 8.0, 7.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-9.0, 3.0, 1.0, -2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block.var[0][0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block.var[0][1][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	block.var[0][1][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	block.var[0][2][0] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	block.var[0][2][1] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	block.var[0][3][0] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
	block.var[0][3][1] = (mat2x3(6.0, 6.0, 5.0, 3.0, 4.0, 7.0));
	block.var[1][0][0] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	block.var[1][0][1] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	block.var[1][1][0] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	block.var[1][1][1] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	block.var[1][2][0] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	block.var[1][2][1] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	block.var[1][3][0] = (mat2x3(0.0, 9.0, -5.0, 3.0, -7.0, 1.0));
	block.var[1][3][1] = (mat2x3(0.0, 6.0, 0.0, 6.0, 4.0, -1.0));
	block.var[2][0][0] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	block.var[2][0][1] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	block.var[2][1][0] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	block.var[2][1][1] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	block.var[2][2][0] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	block.var[2][2][1] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	block.var[2][3][0] = (mat2x3(-2.0, 2.0, 3.0, 8.0, 3.0, -5.0));
	block.var[2][3][1] = (mat2x3(1.0, -6.0, -1.0, 5.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[0][1][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	block.var[0][1][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	block.var[0][2][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	block.var[0][2][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	block.var[0][3][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	block.var[0][3][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	block.var[1][0][0] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	block.var[1][0][1] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	block.var[1][1][0] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	block.var[1][1][1] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	block.var[1][2][0] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	block.var[1][2][1] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	block.var[1][3][0] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	block.var[1][3][1] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	block.var[2][0][0] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	block.var[2][0][1] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	block.var[2][1][0] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	block.var[2][1][1] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	block.var[2][2][0] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	block.var[2][2][1] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	block.var[2][3][0] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	block.var[2][3][1] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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
	highp vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0][0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[0][0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[0][2][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[0][2][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][3][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[0][3][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][1]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][0]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[1][2][0]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][2][1]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[1][3][0]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][3][1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][1]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][1]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[2][2][0]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[2][2][1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[2][3][0]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[2][3][1]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(3.0, 8.0));
	block.var[0][0][1] = (vec2(7.0, -1.0));
	block.var[0][1][0] = (vec2(-6.0, -6.0));
	block.var[0][1][1] = (vec2(1.0, 6.0));
	block.var[0][2][0] = (vec2(-6.0, -2.0));
	block.var[0][2][1] = (vec2(5.0, 4.0));
	block.var[0][3][0] = (vec2(-4.0, -4.0));
	block.var[0][3][1] = (vec2(-2.0, -8.0));
	block.var[1][0][0] = (vec2(-4.0, 8.0));
	block.var[1][0][1] = (vec2(-2.0, -5.0));
	block.var[1][1][0] = (vec2(-7.0, 6.0));
	block.var[1][1][1] = (vec2(1.0, -6.0));
	block.var[1][2][0] = (vec2(0.0, 0.0));
	block.var[1][2][1] = (vec2(-4.0, -9.0));
	block.var[1][3][0] = (vec2(2.0, 9.0));
	block.var[1][3][1] = (vec2(-8.0, 9.0));
	block.var[2][0][0] = (vec2(-2.0, 5.0));
	block.var[2][0][1] = (vec2(6.0, -2.0));
	block.var[2][1][0] = (vec2(-9.0, 0.0));
	block.var[2][1][1] = (vec2(-8.0, -4.0));
	block.var[2][2][0] = (vec2(-2.0, 2.0));
	block.var[2][2][1] = (vec2(-2.0, 8.0));
	block.var[2][3][0] = (vec2(0.0, -8.0));
	block.var[2][3][1] = (vec2(1.0, 5.0));
}
#version 450
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
	allOk = compare_mat3(block.t[0].a, mat3(-2.0, 0.0, 6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(-5, -9, -5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(8, 6)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(0.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(8, 9, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(-6, 1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(5, -8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(-4, 4)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-6, -3, -5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(8, -1)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-6.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-8.0, -9.0, -1.0, 5.0, 6.0, 6.0, 0.0, -9.0, -5.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(-2, 8, -4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-9.0, 5.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(-4, 0, -4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(-5, 7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(1, 9)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-3.0, 4.0, -1.0, 5.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(7, -1, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(5, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(-1, -7)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(2.0, -9.0, -9.0, -8.0)) && allOk;
	allOk = compare_uint((block.u), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-3, 6, 8));
	block.s.b[0] = (ivec2(1, -7));
	block.s.b[1] = (ivec2(5, -7));
	block.s.b[2] = (ivec2(2, -2));
	block.s.b[3] = (ivec2(-1, -6));
	block.s.c = (vec4(-6.0, 7.0, 1.0, 8.0));
	block.u = (6u);
}
#version 450
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
	allOk = compare_uvec2((block.s[0].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(0.0, 0.0, -9.0, 8.0, -9.0, 9.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(-1.0, 8.0, 6.0, -1.0, 9.0, -2.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(2.0, -6.0, -1.0, -2.0, 0.0, -2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(6.0, -5.0, -8.0, -8.0, 4.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(4.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(8u, 6u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(5.0, -7.0, -5.0, 7.0, -4.0, 0.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(2.0, 1.0, 1.0, 8.0, 4.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(5.0, -2.0, 5.0, -9.0, -5.0, 6.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(-7.0, 6.0, -7.0, 4.0, 3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-7.0, -7.0, -6.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(0u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(-6.0, -7.0, 5.0, -5.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(-1.0, -3.0, -5.0, 9.0, 1.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(-6.0, 0.0, 9.0, -5.0, -8.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(5.0, 9.0, 7.0, -1.0, -9.0, 0.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(4.0, 2.0, 6.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(-3.0, -6.0, 9.0, -3.0, 2.0, 6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(9.0, -1.0, -9.0, 9.0, 7.0, -4.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(-4.0, -5.0, 5.0, -8.0, -1.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(2.0, 0.0, 5.0, 4.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(3.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (3u);
	block.s[0].a = (uvec2(4u, 2u));
	block.s[0].b[0][0] = (vec4(9.0, -7.0, -8.0, 3.0));
	block.s[0].b[0][1] = (vec4(-7.0, 8.0, 6.0, 8.0));
	block.s[0].b[1][0] = (vec4(0.0, 5.0, -7.0, -6.0));
	block.s[0].b[1][1] = (vec4(-1.0, 3.0, 7.0, 3.0));
	block.s[0].b[2][0] = (vec4(-2.0, 9.0, 9.0, -1.0));
	block.s[0].b[2][1] = (vec4(9.0, 0.0, 5.0, -2.0));
	block.s[0].b[3][0] = (vec4(4.0, -3.0, 0.0, 7.0));
	block.s[0].b[3][1] = (vec4(-2.0, -7.0, 1.0, 4.0));
	block.s[0].c = (vec3(-2.0, -6.0, 6.0));
	block.s[1].a = (uvec2(7u, 1u));
	block.s[1].b[0][0] = (vec4(-2.0, 5.0, -7.0, -7.0));
	block.s[1].b[0][1] = (vec4(1.0, -6.0, 2.0, 3.0));
	block.s[1].b[1][0] = (vec4(5.0, -2.0, 0.0, 7.0));
	block.s[1].b[1][1] = (vec4(-8.0, -5.0, -4.0, -4.0));
	block.s[1].b[2][0] = (vec4(0.0, 6.0, -5.0, -2.0));
	block.s[1].b[2][1] = (vec4(-4.0, -3.0, 6.0, 8.0));
	block.s[1].b[3][0] = (vec4(4.0, -8.0, -8.0, -4.0));
	block.s[1].b[3][1] = (vec4(-1.0, 5.0, 4.0, 6.0));
	block.s[1].c = (vec3(6.0, 9.0, -3.0));
	block.s[2].a = (uvec2(3u, 0u));
	block.s[2].b[0][0] = (vec4(-3.0, 7.0, -3.0, 7.0));
	block.s[2].b[0][1] = (vec4(-2.0, 3.0, 9.0, -7.0));
	block.s[2].b[1][0] = (vec4(-6.0, 1.0, 6.0, -4.0));
	block.s[2].b[1][1] = (vec4(-7.0, -8.0, 2.0, 5.0));
	block.s[2].b[2][0] = (vec4(7.0, -2.0, 6.0, -1.0));
	block.s[2].b[2][1] = (vec4(-6.0, -4.0, -2.0, -9.0));
	block.s[2].b[3][0] = (vec4(1.0, 3.0, 0.0, 3.0));
	block.s[2].b[3][1] = (vec4(-9.0, 1.0, -7.0, -5.0));
	block.s[2].c = (vec3(-8.0, 5.0, 4.0));
	block.s[3].a = (uvec2(0u, 8u));
	block.s[3].b[0][0] = (vec4(8.0, 6.0, -8.0, 0.0));
	block.s[3].b[0][1] = (vec4(3.0, 3.0, 4.0, -1.0));
	block.s[3].b[1][0] = (vec4(1.0, 7.0, 5.0, 3.0));
	block.s[3].b[1][1] = (vec4(-7.0, 4.0, -1.0, 4.0));
	block.s[3].b[2][0] = (vec4(6.0, -3.0, 1.0, -3.0));
	block.s[3].b[2][1] = (vec4(-4.0, 8.0, -8.0, 0.0));
	block.s[3].b[3][0] = (vec4(4.0, 6.0, -4.0, 4.0));
	block.s[3].b[3][1] = (vec4(-4.0, -4.0, -6.0, -4.0));
	block.s[3].c = (vec3(-6.0, 8.0, -9.0));
}
#version 450
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
    Block block[3];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block[0].var), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block[1].var), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block[2].var), ivec2(-8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (ivec2(-6, 8));
	block[1].var = (ivec2(3, -1));
	block[2].var = (ivec2(-5, -2));
}
#version 450
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
    Block block[3];
};

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

layout(std430, buffer_reference) buffer Block
{
	highp ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, buffer_reference) buffer Block
{
	f16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block[0].var), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block[1].var), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block[2].var), vec3(4.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec3(vec3(3.0, 3.0, 7.0));
	block[1].var = f16vec3(vec3(-3.0, -5.0, -9.0));
	block[2].var = f16vec3(vec3(-1.0, 0.0, 6.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 8.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(-9.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), -4.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 8.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-6.0, 5.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(1.0, 8.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (4.0);
	block[0].var[0] = (vec2(-2.0, 8.0));
	block[0].var[1] = (vec2(-4.0, 4.0));
	block[0].var[2] = (vec2(9.0, 5.0));
	block[0].var[3] = (vec2(-9.0, -2.0));
	block[1].padding = (6.0);
	block[1].var[0] = (vec2(-5.0, -1.0));
	block[1].var[1] = (vec2(9.0, 0.0));
	block[1].var[2] = (vec2(4.0, 5.0));
	block[1].var[3] = (vec2(-8.0, 4.0));
	block[2].padding = (-2.0);
	block[2].var[0] = (vec2(6.0, 4.0));
	block[2].var[1] = (vec2(-2.0, 5.0));
	block[2].var[2] = (vec2(-5.0, -6.0));
	block[2].var[3] = (vec2(-4.0, 7.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 5.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 0.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -5.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(5.0, 0.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-2.0, -5.0)) && allOk;
	allOk = compare_float((blockA[1].a), -5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -9.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -8.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -2.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-8.0, -2.0)) && allOk;
	allOk = compare_float((blockA[2].a), -9.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], 3.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], 0.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -2.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 3.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-2.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(3, -1)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(8, 4)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-3, -9)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[1].a = (9.0);
	blockA[2].a = (4.0);
	blockB[0].a = (mat3(6.0, -9.0, 8.0, 2.0, -2.0, -9.0, -2.0, 1.0, 2.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(5.0, 3.0, 3.0, 7.0, -2.0, -3.0, -5.0, -8.0, 9.0));
	blockB[1].d = (true);
	blockB[2].a = (mat3(-7.0, 7.0, 5.0, 2.0, -7.0, 6.0, 1.0, 3.0, 6.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	lowp uvec3 a;
	mediump uvec4 b;
	highp ivec2 c;
	mediump vec2 d;
	mediump uvec2 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump float f;
};
layout(std430, buffer_reference) buffer BlockD
{
	bool g;
	highp vec2 h;
	highp vec4 i;
};
layout(std140, buffer_reference) buffer BlockE
{
	bvec3 j[1];
	mediump vec3 k;
	bvec3 l;
	bvec3 m;
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(6.0, 0.0)) && allOk;
	allOk = compare_bool((blockD.g), true) && allOk;
	allOk = compare_vec4((blockD.i), vec4(-1.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockE.j[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockE.m), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 4u, 3u));
	blockB.c = (ivec2(-9, 3));
	blockB.d = (vec2(0.0, -9.0));
	blockB.e = (uvec2(5u, 3u));
	blockC.f = (4.0);
	blockD.i = (vec4(-8.0, -3.0, 6.0, 5.0));
	blockE.j[0] = (bvec3(true, true, false));
	blockE.m = (bvec3(true, true, true));
}
#version 450
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
	lowp mat4 b[1];
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
	allOk = compare_bvec3((blockB.c), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2(blockC.e, mat2(-5.0, 1.0, 2.0, -7.0)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(4u, 3u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockD.j), uvec3(7u, 9u, 1u)) && allOk;
	allOk = compare_bvec2((blockE.k), bvec2(true, true)) && allOk;
	allOk = compare_float((blockE.l), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0] = (false);
	blockC.e = (mat2(9.0, 0.0, -8.0, 6.0));
	blockC.f = (false);
	blockC.g = (uvec4(2u, 9u, 9u, 3u));
	blockC.h = (3);
	blockD.j = (uvec3(3u, 3u, 8u));
	blockE.k = (bvec2(false, false));
}
#version 450
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
	highp ivec4 f[1];
	lowp ivec4 g;
	highp ivec3 h;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat3 i;
	highp mat3x2 j[1];
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
	allOk = compare_ivec3((blockC.h), ivec3(-9, -2, -2)) && allOk;
	allOk = compare_mat3(blockD.i, mat3(1.0, -5.0, 9.0, 7.0, 9.0, -8.0, -4.0, 1.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockD.k), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(1u, 3u));
	blockB.d = (vec3(-4.0, 8.0, 6.0));
	blockC.g = (ivec4(-8, 4, 6, -9));
	blockC.h = (ivec3(5, 6, 1));
	blockD.i = (mat3(3.0, -3.0, 3.0, 0.0, -8.0, 2.0, -1.0, -6.0, 7.0));
	blockD.j[0] = (mat3x2(2.0, -9.0, -9.0, 6.0, 1.0, 2.0));
}
#version 450
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
	mediump mat4x2 h[3];
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
	allOk = compare_mat4x2(blockD.h[1], mat4x2(-9.0, -6.0, 6.0, 5.0, -5.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockD.h[2], mat4x2(2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(false, false));
	blockC.c = (uvec4(9u, 0u, 5u, 8u));
	blockD.d = (mat3x2(3.0, 4.0, 7.0, 8.0, 3.0, 8.0));
	blockD.g = (mat4(5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0, -8.0, 4.0, 8.0, 5.0, 3.0, 5.0, -4.0));
	blockD.h[0] = (mat4x2(8.0, 8.0, 0.0, -8.0, 1.0, -8.0, 2.0, -7.0));
	blockD.h[1] = (mat4x2(-2.0, 2.0, -5.0, -5.0, -8.0, -6.0, -3.0, -6.0));
	blockD.h[2] = (mat4x2(-4.0, -7.0, 7.0, 6.0, 9.0, -9.0, 3.0, 4.0));
}
#version 450
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
	mediump mat2 a;
	highp uvec3 b;
	lowp vec4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-7.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(7u, 8u, 3u)) && allOk;
	allOk = compare_vec4((blockB.c[0]), vec4(6.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.c[1]), vec4(9.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB.c[2]), vec4(0.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.c[3]), vec4(7.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.c[4]), vec4(2.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.c[5]), vec4(9.0, 8.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.c[6]), vec4(-5.0, 2.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.c[7]), vec4(7.0, 9.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(6u, 3u, 2u));
	blockB.c[0] = (vec4(6.0, -8.0, 8.0, -3.0));
	blockB.c[1] = (vec4(3.0, -3.0, -1.0, 6.0));
	blockB.c[2] = (vec4(9.0, 5.0, -6.0, -1.0));
	blockB.c[3] = (vec4(-2.0, 2.0, -3.0, -9.0));
	blockB.c[4] = (vec4(-5.0, 3.0, 5.0, -5.0));
	blockB.c[5] = (vec4(-2.0, -2.0, 8.0, -3.0));
	blockB.c[6] = (vec4(-3.0, -8.0, 1.0, -3.0));
	blockB.c[7] = (vec4(-1.0, 3.0, 7.0, -4.0));
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	sA a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0].mA), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (bvec3(true, true, false));
}
#version 450
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
	highp uint mB;
	bvec2 mC;
};
struct sB
{
	lowp mat2 mA;
	sA mB;
	bool mC;
	bvec4 mD;
};
layout(std430, buffer_reference) readonly buffer BlockB
{
	sB a[][8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

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

struct sA
{
	highp mat4 mA;
	mediump int mB;
	highp mat3 mC;
};
struct sB
{
	sA mA;
	mediump uvec3 mB;
};
struct sC
{
	highp vec2 mA;
	highp mat4 mB;
	lowp uint mC;
};
struct sD
{
	mediump mat4x3 mA;
	sC mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	bvec4 a;
	mediump mat4x3 b;
	lowp ivec2 c;
	sB d;
	mediump vec4 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump ivec2 f;
	mediump vec3 g;
	bvec4 h[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat4x3 i;
	sD j;
	highp vec2 k;
	mediump uint l;
	lowp mat3 m[];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp mat2 n;
	highp mat2x3 o;
	highp uvec3 p;
	bvec3 q[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.d.mA.mA, mat4(-6.0, -5.0, -6.0, -1.0, 1.0, 3.0, -2.0, -1.0, 1.0, 6.0, 2.0, 6.0, 8.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_int((blockB.d.mA.mB), -5) && allOk;
	allOk = compare_mat3(blockB.d.mA.mC, mat3(3.0, -4.0, -8.0, -5.0, -6.0, -9.0, -9.0, 5.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockB.d.mB), uvec3(8u, 1u, 8u)) && allOk;
	allOk = compare_vec4((blockB.e[0]), vec4(-1.0, 1.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.e[1]), vec4(8.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB.e[2]), vec4(-7.0, -3.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.e[3]), vec4(-7.0, 2.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockC.g), vec3(8.0, 7.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockC.h[0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockC.h[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockC.h[2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat4x3(blockD.j.mA, mat4x3(0.0, 5.0, 5.0, -8.0, 1.0, -7.0, 3.0, 2.0, 5.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec2((blockD.j.mB.mA), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_mat4(blockD.j.mB.mB, mat4(7.0, 3.0, 3.0, 1.0, -8.0, 7.0, 5.0, -9.0, 1.0, 6.0, 2.0, 7.0, 6.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_uint((blockD.j.mB.mC), 7u) && allOk;
	allOk = compare_uint((blockD.l), 0u) && allOk;
	allOk = compare_mat2(blockE.n, mat2(9.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockE.o, mat2x3(0.0, -4.0, 4.0, 9.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockE.p), uvec3(3u, 1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (ivec2(1, 7));
	blockB.d.mA.mA = (mat4(6.0, -3.0, -9.0, 6.0, 6.0, -6.0, -5.0, -4.0, -2.0, -5.0, 9.0, -5.0, -6.0, 0.0, -6.0, 4.0));
	blockB.d.mA.mB = (-7);
	blockB.d.mA.mC = (mat3(9.0, 5.0, 9.0, -9.0, 3.0, 3.0, 8.0, 4.0, 3.0));
	blockB.d.mB = (uvec3(5u, 5u, 9u));
	blockB.e[0] = (vec4(5.0, 0.0, -2.0, 2.0));
	blockB.e[1] = (vec4(1.0, 0.0, 8.0, 7.0));
	blockB.e[2] = (vec4(-5.0, 2.0, 3.0, 1.0));
	blockB.e[3] = (vec4(-5.0, -5.0, -1.0, -4.0));
	blockC.f = (ivec2(7, -5));
	blockC.h[0] = (bvec4(true, false, true, true));
	blockC.h[1] = (bvec4(true, false, false, false));
	blockC.h[2] = (bvec4(true, true, true, false));
	blockD.j.mA = (mat4x3(2.0, -5.0, 3.0, 0.0, 1.0, 8.0, -8.0, 1.0, -4.0, 7.0, 0.0, 2.0));
	blockD.j.mB.mA = (vec2(-9.0, -1.0));
	blockD.j.mB.mB = (mat4(9.0, 9.0, 6.0, 0.0, 3.0, 5.0, 8.0, 2.0, 3.0, -8.0, 1.0, 2.0, -3.0, -8.0, -2.0, 0.0));
	blockD.j.mB.mC = (1u);
	blockD.l = (3u);
	blockD.m[0] = (mat3(-9.0, 4.0, 1.0, 7.0, 7.0, 5.0, 8.0, -6.0, 8.0));
	blockD.m[1] = (mat3(8.0, 8.0, 5.0, -9.0, -3.0, 4.0, -4.0, 5.0, 6.0));
	blockD.m[2] = (mat3(-6.0, 8.0, 8.0, 9.0, -5.0, 8.0, -1.0, 9.0, -4.0));
	blockD.m[3] = (mat3(2.0, 0.0, 3.0, -6.0, 1.0, 3.0, -4.0, -3.0, -9.0));
	blockD.m[4] = (mat3(3.0, -5.0, -6.0, 4.0, -8.0, -9.0, 6.0, 7.0, -3.0));
	blockD.m[5] = (mat3(-6.0, 7.0, -3.0, 7.0, -4.0, 3.0, 4.0, 9.0, -5.0));
	blockD.m[6] = (mat3(-6.0, 9.0, 7.0, 1.0, -1.0, -5.0, -7.0, 0.0, -4.0));
	blockD.m[7] = (mat3(-6.0, 4.0, -6.0, -7.0, -9.0, 7.0, -3.0, 6.0, -3.0));
	blockE.o = (mat2x3(-9.0, -9.0, -9.0, 3.0, -2.0, -9.0));
	blockE.p = (uvec3(6u, 8u, 1u));
}
#version 450
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
	highp float a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp mat4x3 b;
	mediump vec2 c;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp mat3 d;
	mediump uint e;
	bool f;
	bool g;
	highp uvec3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockD.d, mat3(2.0, 9.0, 1.0, -6.0, -5.0, -6.0, -1.0, 1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7.0);
	blockB[1].a[0] = (-2.0);
	blockB[1].a[1] = (8.0);
	blockB[1].a[2] = (-4.0);
	blockC.b = (mat4x3(-8.0, 5.0, 3.0, 3.0, 9.0, -4.0, 3.0, -8.0, -8.0, -8.0, -4.0, 2.0));
	blockD.d = (mat3(1.0, 7.0, 6.0, -3.0, -9.0, 6.0, 6.0, -6.0, -5.0));
	blockD.e = (8u);
	blockD.f = (false);
}
#version 450
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
	lowp uint a;
	mediump int b;
	lowp float c;
	lowp int d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp float e;
	float16_t f;
	uint16_t g;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp int h;
	float16_t i;
};
layout(std430, buffer_reference) buffer BlockE
{
	float16_t j;
	uint16_t k;
	lowp int l;
	bool m;
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
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 9u) && allOk;
	allOk = compare_int((blockB.b), 3) && allOk;
	allOk = compare_float((blockB.c), -2.0) && allOk;
	allOk = compare_int((blockB.d), 9) && allOk;
	allOk = compare_float16_t(float(blockC.f), -1.0) && allOk;
	allOk = compare_uint16_t(uint(blockC.g), 1u) && allOk;
	allOk = compare_int((blockD.h), 1) && allOk;
	allOk = compare_float16_t(float(blockD.i), -8.0) && allOk;
	allOk = compare_float16_t(float(blockE.j), 6.0) && allOk;
	allOk = compare_bool((blockE.m), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-2);
	blockB.c = (3.0);
	blockC.e = (-4.0);
	blockC.f = float16_t(5.0);
	blockC.g = uint16_t(8u);
	blockD.h = (8);
	blockE.k = uint16_t(9u);
	blockE.l = (-4);
}
#version 450
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
	mediump uvec3 b;
	lowp vec3 c;
	highp mat4x3 d;
	mediump vec3 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	f16vec3 f;
	lowp mat2x3 g;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(2.0, -8.0, -4.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(6u, 0u, 4u)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(-6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0, 5.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.e), vec3(2.0, 3.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.f), vec3(-8.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(3u, 8u, 3u));
	blockB.c = (vec3(8.0, 6.0, 7.0));
	blockB.e = (vec3(-7.0, -6.0, -2.0));
	blockC.f = f16vec3(vec3(-4.0, 8.0, -6.0));
}
#version 450
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
	int16_t a;
	mediump ivec3 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	i16vec3 c;
	highp int d;
	lowp mat3x4 e;
	bvec2 f;
	mediump ivec2 g[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bool h;
	mediump mat3x2 i;
	mediump mat2 j;
	lowp mat2 k;
	mediump mat3x2 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), 0) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.c), ivec3(0, 3, 7)) && allOk;
	allOk = compare_int((blockC.d), -1) && allOk;
	allOk = compare_mat3x4(blockC.e, mat3x4(-8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0, 1.0, -1.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, true)) && allOk;
	allOk = compare_ivec2((blockC.g[0]), ivec2(1, -6)) && allOk;
	allOk = compare_mat2(blockD.j, mat2(2.0, 3.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[0], mat3x2(7.0, -8.0, 6.0, -8.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(6);
	blockC.c = i16vec3(ivec3(9, 2, -6));
	blockC.f = (bvec2(false, true));
	blockC.g[0] = (ivec2(0, -4));
	blockD.h = (false);
	blockD.j = (mat2(-2.0, -3.0, 5.0, 2.0));
	blockD.k = (mat2(0.0, 2.0, 0.0, -8.0));
	blockD.l[0] = (mat3x2(-5.0, 0.0, -3.0, 8.0, -3.0, -9.0));
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	sA a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (uvec3(5u, 2u, 5u));
}
#version 450
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
	uint16_t mA;
	float16_t mB;
	u16vec4 mC;
	i16vec3 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	float16_t a;
	lowp uvec4 b;
	highp uvec2 c[1];
	sA d;
	i16vec4 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	u16vec4 f;
	f16vec2 g;
	lowp mat4 h;
	i16vec2 i;
	bool j[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat2x3 k;
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	f16vec2 l;
	highp uvec3 m;
	highp mat2 n;
	mediump ivec3 o;
	highp mat4x3 p[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -4.0) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(5u, 7u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.e[0]), ivec4(8, -1, 6, 5)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f), uvec4(1u, 2u, 9u, 4u)) && allOk;
	allOk = compare_mat4(blockC.h, mat4(4.0, -9.0, -2.0, -8.0, -8.0, -4.0, -5.0, 1.0, 7.0, 3.0, 0.0, -1.0, -4.0, 0.0, 1.0, 0.0)) && allOk;
	allOk = compare_bool((blockC.j[0]), false) && allOk;
	allOk = compare_mat2(blockE.n, mat2(5.0, -2.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockE.o), ivec3(-8, 4, -5)) && allOk;
	allOk = compare_mat4x3(blockE.p[0], mat4x3(8.0, 3.0, 3.0, 9.0, 6.0, 2.0, 3.0, 1.0, 3.0, -3.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(4u, 7u, 8u, 8u));
	blockB.d.mA = uint16_t(3u);
	blockB.d.mB = float16_t(-9.0);
	blockB.d.mC = u16vec4(uvec4(1u, 6u, 3u, 9u));
	blockB.d.mD = i16vec3(ivec3(5, 4, -2));
	blockC.f = u16vec4(uvec4(1u, 4u, 3u, 8u));
	blockC.g = f16vec2(vec2(-9.0, -1.0));
	blockC.h = (mat4(6.0, -6.0, -9.0, -9.0, 2.0, 3.0, 8.0, 3.0, 7.0, 1.0, -7.0, 5.0, -1.0, -4.0, 3.0, -9.0));
	blockC.i = i16vec2(ivec2(9, -5));
	blockC.j[0] = (true);
	blockD.k = (mat2x3(-6.0, 4.0, 9.0, -2.0, -6.0, 3.0));
	blockE.l = f16vec2(vec2(6.0, 8.0));
	blockE.m = (uvec3(5u, 5u, 7u));
	blockE.n = (mat2(-4.0, 6.0, 7.0, 5.0));
	blockE.o = (ivec3(0, -8, 8));
	blockE.p[0] = (mat4x3(5.0, 5.0, -7.0, 8.0, -8.0, 0.0, 6.0, 5.0, -9.0, 1.0, 4.0, -7.0));
}
#version 450
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
	bool a;
	mediump mat4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_mat4(blockB.b[0], mat4(6.0, -4.0, -2.0, -3.0, -7.0, -9.0, -6.0, 2.0, -9.0, 8.0, 4.0, -9.0, 5.0, 6.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2 b;
	lowp vec4 c;
	u16vec4 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp mat2 e;
	highp ivec3 f;
	u16vec2 g[5];
	mediump mat4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockC[0].f), ivec3(6, 2, -9)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[1]), uvec2(7u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[2]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[3]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[4]), uvec2(7u, 0u)) && allOk;
	allOk = compare_mat4(blockC[0].h[0], mat4(-8.0, 9.0, 6.0, 3.0, 8.0, -9.0, -4.0, 3.0, 4.0, -6.0, 7.0, 3.0, 4.0, 7.0, -1.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockC[1].f), ivec3(5, -5, -9)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[0]), uvec2(9u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[2]), uvec2(3u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[3]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[4]), uvec2(2u, 9u)) && allOk;
	allOk = compare_mat4(blockC[1].h[0], mat4(-1.0, 0.0, 0.0, -6.0, 4.0, -1.0, 6.0, 8.0, -6.0, -6.0, -9.0, 2.0, 3.0, 5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[1], mat4(-3.0, -9.0, -3.0, 2.0, 4.0, -3.0, 8.0, 1.0, -7.0, 8.0, -7.0, -5.0, -7.0, -1.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[2], mat4(2.0, 1.0, 4.0, 7.0, 3.0, -2.0, 3.0, -5.0, 9.0, -4.0, -8.0, 0.0, 4.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[3], mat4(3.0, -7.0, 9.0, 5.0, -2.0, -3.0, -1.0, 9.0, -7.0, -8.0, 1.0, -9.0, -6.0, 8.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[4], mat4(1.0, -2.0, -4.0, -9.0, 7.0, 6.0, -3.0, -7.0, -6.0, -9.0, -9.0, -8.0, 7.0, -5.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat2(0.0, -6.0, 6.0, -6.0));
	blockB[0].c = (vec4(3.0, -7.0, 8.0, 5.0));
	blockB[1].b = (mat2(-5.0, 2.0, -2.0, 8.0));
	blockB[1].c = (vec4(-1.0, -1.0, 1.0, 7.0));
	blockB[2].b = (mat2(-1.0, -8.0, -7.0, 8.0));
	blockB[2].c = (vec4(2.0, 8.0, -1.0, -1.0));
	blockC[0].e = (mat2(-9.0, 5.0, 7.0, -7.0));
	blockC[0].f = (ivec3(5, -3, -4));
	blockC[0].g[0] = u16vec2(uvec2(7u, 1u));
	blockC[0].g[1] = u16vec2(uvec2(1u, 0u));
	blockC[0].g[2] = u16vec2(uvec2(2u, 0u));
	blockC[0].g[3] = u16vec2(uvec2(0u, 3u));
	blockC[0].g[4] = u16vec2(uvec2(2u, 0u));
	blockC[0].h[0] = (mat4(-2.0, 7.0, -7.0, 1.0, 8.0, -4.0, -1.0, 0.0, 2.0, -2.0, 8.0, 0.0, -1.0, 7.0, 0.0, 4.0));
	blockC[1].e = (mat2(4.0, 7.0, 2.0, 2.0));
	blockC[1].f = (ivec3(5, 2, -5));
	blockC[1].g[0] = u16vec2(uvec2(8u, 0u));
	blockC[1].g[1] = u16vec2(uvec2(4u, 1u));
	blockC[1].g[2] = u16vec2(uvec2(4u, 6u));
	blockC[1].g[3] = u16vec2(uvec2(8u, 2u));
	blockC[1].g[4] = u16vec2(uvec2(9u, 2u));
	blockC[1].h[0] = (mat4(-3.0, 2.0, 3.0, 0.0, -6.0, 9.0, -4.0, 8.0, -2.0, -3.0, 9.0, -2.0, 5.0, -4.0, -8.0, 7.0));
	blockC[1].h[1] = (mat4(-8.0, -1.0, 6.0, 3.0, 6.0, 4.0, -7.0, -4.0, -5.0, 7.0, 4.0, 8.0, -6.0, 4.0, -9.0, 1.0));
	blockC[1].h[2] = (mat4(-4.0, -6.0, 4.0, -1.0, 4.0, -5.0, -9.0, -3.0, 1.0, -3.0, 4.0, 4.0, 8.0, -7.0, -2.0, 6.0));
	blockC[1].h[3] = (mat4(8.0, 9.0, -1.0, -7.0, 1.0, 9.0, 6.0, -2.0, 9.0, -5.0, 9.0, -4.0, 7.0, -8.0, -1.0, 4.0));
	blockC[1].h[4] = (mat4(7.0, 8.0, -1.0, -1.0, 0.0, -8.0, 1.0, 3.0, 6.0, -5.0, -3.0, 1.0, -8.0, 6.0, 9.0, -1.0));
}
#version 450
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
	layout(offset = 4) highp uint b;
	layout(offset = 8) lowp uint c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) f16vec3 d;
	layout(offset = 8) bool e;
	layout(offset = 16) i16vec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i16vec3 g;
	layout(offset = 6) u16vec3 h;
	layout(offset = 16) mediump vec2 i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) f16vec2 j;
	layout(offset = 4) mediump int k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_uint((blockB.c), 0u) && allOk;
	allOk = compare_f16vec3(vec3(blockC.d), vec3(-5.0, 0.0, 3.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.g), ivec3(-2, -2, 4)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.h), uvec3(3u, 4u, 9u)) && allOk;
	allOk = compare_vec2((blockD.i), vec2(1.0, -1.0)) && allOk;
	allOk = compare_int((blockE.k), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(6.0);
	blockB.b = (5u);
	blockC.d = f16vec3(vec3(0.0, 9.0, 2.0));
	blockC.e = (true);
	blockC.f = i16vec3(ivec3(-6, 3, 5));
	blockD.g = i16vec3(ivec3(-8, -7, -8));
	blockD.h = u16vec3(uvec3(6u, 4u, 1u));
	blockD.i = (vec2(9.0, -9.0));
	blockE.j = f16vec2(vec2(9.0, 8.0));
	blockE.k = (-1);
}
#version 450
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
	layout(offset = 16) highp vec4 b;
	layout(offset = 32) mediump vec2 c;
	layout(offset = 40) bool d;
	layout(offset = 44) int16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-1.0, 9.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(0.0, -9.0)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.b = (vec4(3.0, 0.0, -9.0, -6.0));
	blockB.c = (vec2(3.0, 4.0));
	blockB.d = (false);
	blockB.e = int16_t(-4);
}
#version 450
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
	layout(offset = 0) f16vec4 a;
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) u16vec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(5.0, 7.0, -8.0, 7.0)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(5u, 2u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(-4.0, -8.0, 1.0, -1.0));
	blockB.b = (uvec4(5u, 3u, 6u, 1u));
	blockB.c = u16vec2(uvec2(7u, 0u));
}
#version 450
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
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) f16vec4 c;
	layout(offset = 48) bvec3 d;
	layout(offset = 64) highp vec4 e;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) highp ivec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) f16vec2 g;
	layout(offset = 4) lowp float h;
	layout(offset = 8) f16vec4 i;
	layout(offset = 16) lowp vec4 j;
	layout(offset = 32) i16vec2 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-3.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(0u, 4u, 3u, 0u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(6.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec3((blockC[0].f), ivec3(9, -3, 2)) && allOk;
	allOk = compare_ivec3((blockC[1].f), ivec3(-5, 8, 3)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[0].g), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].i), vec4(-9.0, -2.0, 8.0, 5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].k), ivec2(-8, -6)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[1].g), vec2(5.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].i), vec4(1.0, 5.0, 4.0, -2.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[1].k), ivec2(4, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(3u, 0u, 8u, 5u));
	blockB.c = f16vec4(vec4(1.0, 3.0, -9.0, 8.0));
	blockB.d = (bvec3(true, false, false));
	blockB.e = (vec4(2.0, 3.0, 0.0, 9.0));
	blockD[0].g = f16vec2(vec2(-1.0, -8.0));
	blockD[0].h = (-8.0);
	blockD[0].j = (vec4(-9.0, -4.0, -1.0, -2.0));
	blockD[0].k = i16vec2(ivec2(4, 0));
	blockD[1].g = f16vec2(vec2(-2.0, -9.0));
	blockD[1].h = (1.0);
	blockD[1].j = (vec4(-4.0, -2.0, -2.0, 4.0));
	blockD[1].k = i16vec2(ivec2(5, -6));
}
#version 450
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
	layout(offset = 0) mediump uvec2 a[1];
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) i16vec2 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a[0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[0].c[0]), ivec2(5, 9)) && allOk;
	allOk = compare_uvec2((blockB[1].a[0]), uvec2(5u, 4u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[1].c[0]), ivec2(-2, -1)) && allOk;
	allOk = compare_uvec2((blockB[2].a[0]), uvec2(9u, 7u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[2].c[0]), ivec2(7, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (uvec2(6u, 9u));
	blockB[1].b = (uvec2(0u, 7u));
	blockB[2].b = (uvec2(5u, 0u));
}
#version 450
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
	layout(offset = 0) mediump uint a;
	layout(offset = 4) int16_t b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u16vec3 c;
	layout(offset = 6) u16vec2 d;
	layout(offset = 16) lowp vec2 e;
	layout(offset = 24) u16vec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.b), 1) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.d), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.f), uvec3(8u, 8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockC.c = u16vec3(uvec3(7u, 2u, 0u));
	blockC.d = u16vec2(uvec2(3u, 6u));
	blockC.e = (vec2(-2.0, 0.0));
	blockC.f = u16vec3(uvec3(4u, 8u, 5u));
}
#version 450
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
	layout(offset = 0) i16vec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u16vec3 b;
	layout(offset = 16) lowp uvec4 c;
	layout(offset = 32) bvec4 d;
	layout(offset = 48) float16_t e;
	layout(offset = 52) f16vec2 f[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec4 g[1];
	layout(offset = 16) highp vec4 h;
	layout(offset = 32) lowp int i;
	layout(offset = 36) u16vec4 j;
	layout(offset = 48) highp vec4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockC[0].b), uvec3(6u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockC[0].c), uvec4(2u, 2u, 5u, 6u)) && allOk;
	allOk = compare_bvec4((blockC[0].d), bvec4(false, true, true, false)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].f[0]), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].b), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((blockC[1].c), uvec4(9u, 5u, 5u, 0u)) && allOk;
	allOk = compare_bvec4((blockC[1].d), bvec4(true, false, true, true)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].f[0]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].b), uvec3(5u, 8u, 8u)) && allOk;
	allOk = compare_uvec4((blockC[2].c), uvec4(5u, 5u, 2u, 8u)) && allOk;
	allOk = compare_bvec4((blockC[2].d), bvec4(true, false, false, true)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[2].f[0]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockD.g[0]), uvec4(0u, 4u, 0u, 5u)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(1.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_int((blockD.i), 7) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.j), uvec4(4u, 4u, 9u, 6u)) && allOk;
	allOk = compare_vec4((blockD.k), vec4(-5.0, -1.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i16vec3(ivec3(1, 7, -6));
	blockC[0].b = u16vec3(uvec3(0u, 5u, 8u));
	blockC[0].c = (uvec4(3u, 4u, 3u, 2u));
	blockC[0].d = (bvec4(true, false, true, true));
	blockC[0].e = float16_t(-7.0);
	blockC[0].f[0] = f16vec2(vec2(4.0, -5.0));
	blockC[1].b = u16vec3(uvec3(5u, 2u, 5u));
	blockC[1].c = (uvec4(4u, 4u, 5u, 3u));
	blockC[1].d = (bvec4(true, false, true, false));
	blockC[1].e = float16_t(7.0);
	blockC[1].f[0] = f16vec2(vec2(-8.0, 3.0));
	blockC[2].b = u16vec3(uvec3(4u, 4u, 6u));
	blockC[2].c = (uvec4(6u, 1u, 4u, 3u));
	blockC[2].d = (bvec4(false, true, false, true));
	blockC[2].e = float16_t(-1.0);
	blockC[2].f[0] = f16vec2(vec2(5.0, 7.0));
	blockD.g[0] = (uvec4(4u, 4u, 7u, 5u));
	blockD.h = (vec4(-6.0, 4.0, -1.0, -8.0));
	blockD.i = (-3);
	blockD.j = u16vec4(uvec4(6u, 8u, 7u, 3u));
	blockD.k = (vec4(6.0, -9.0, 1.0, 9.0));
}
#version 450
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
	layout(offset = 16) u16vec4 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec4 c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec3 d;
	layout(offset = 6) float16_t e;
	layout(offset = 8) int16_t f;
	layout(offset = 16) mediump ivec3 g;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) u16vec2 h[1];
	layout(offset = 4) i16vec2 i;
	layout(offset = 16) highp ivec3 j[1];
	layout(offset = 32) u16vec2 k;
	layout(offset = 36) mediump float l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockC.c), ivec4(1, 5, 0, -7)) && allOk;
	allOk = compare_float16_t(float(blockD.e), 3.0) && allOk;
	allOk = compare_int16_t(int(blockD.f), -1) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.i), ivec2(8, -6)) && allOk;
	allOk = compare_ivec3((blockE.j[0]), ivec3(1, -8, -6)) && allOk;
	allOk = compare_float((blockE.l), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.b = u16vec4(uvec4(6u, 5u, 6u, 9u));
	blockC.c = (ivec4(7, 7, -4, 1));
	blockD.d = u16vec3(uvec3(3u, 2u, 7u));
	blockD.e = float16_t(-7.0);
	blockD.g = (ivec3(-5, -9, 7));
	blockE.h[0] = u16vec2(uvec2(3u, 2u));
	blockE.i = i16vec2(ivec2(-7, 3));
	blockE.j[0] = (ivec3(-6, -9, 0));
	blockE.k = u16vec2(uvec2(9u, 6u));
	blockE.l = (-7.0);
}
#version 450
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
	f16vec2 a;
	bvec3 b;
	f16vec4 c;
	u16vec4 d;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec4 e;
	highp mat4x2 f;
	lowp vec3 g[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	mediump ivec4 h;
	highp mat2x3 i;
	mediump float j;
	mediump mat4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, true)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(9.0, 4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-3.0, 7.0, -1.0, 2.0, 2.0, 9.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((blockC.g[0]), vec3(-4.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((blockC.g[1]), vec3(2.0, 3.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockD[0].h), ivec4(-2, -8, -7, 4)) && allOk;
	allOk = compare_mat4(blockD[0].k, mat4(-9.0, 7.0, -6.0, 7.0, -4.0, 4.0, -3.0, -4.0, 5.0, 8.0, 7.0, -4.0, 3.0, -8.0, 3.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockD[1].h), ivec4(7, 5, 6, 0)) && allOk;
	allOk = compare_mat4(blockD[1].k, mat4(6.0, 5.0, 0.0, -4.0, -1.0, 2.0, 2.0, 1.0, 7.0, -3.0, 0.0, 1.0, -7.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockD[2].h), ivec4(8, -4, 3, 1)) && allOk;
	allOk = compare_mat4(blockD[2].k, mat4(-1.0, 1.0, 5.0, 1.0, -4.0, -9.0, 9.0, -3.0, 0.0, 8.0, -5.0, 9.0, 6.0, -3.0, -3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(-2.0, -4.0));
	blockB.b = (bvec3(false, true, true));
	blockB.c = f16vec4(vec4(-8.0, 0.0, 4.0, -9.0));
	blockB.d = u16vec4(uvec4(8u, 0u, 5u, 3u));
	blockC.f = (mat4x2(-8.0, -1.0, -3.0, 4.0, -2.0, 8.0, -4.0, 8.0));
	blockC.g[0] = (vec3(7.0, -1.0, -3.0));
	blockC.g[1] = (vec3(1.0, 7.0, 1.0));
	blockD[0].i = (mat2x3(4.0, -3.0, -6.0, 5.0, 0.0, 9.0));
	blockD[0].j = (2.0);
	blockD[0].k = (mat4(-9.0, -6.0, -5.0, 0.0, 5.0, -8.0, 1.0, 2.0, 6.0, 4.0, -4.0, 9.0, 0.0, -1.0, -2.0, 6.0));
	blockD[1].i = (mat2x3(5.0, -5.0, 5.0, -5.0, 9.0, -1.0));
	blockD[1].j = (7.0);
	blockD[1].k = (mat4(-7.0, 9.0, 1.0, 3.0, -3.0, 3.0, 6.0, 5.0, 8.0, -6.0, -8.0, 7.0, -9.0, 4.0, 8.0, -5.0));
	blockD[2].i = (mat2x3(-7.0, 0.0, -1.0, 0.0, -3.0, -8.0));
	blockD[2].j = (-8.0);
	blockD[2].k = (mat4(5.0, -1.0, -1.0, 2.0, -4.0, 8.0, 2.0, -8.0, -5.0, 7.0, -5.0, 1.0, 6.0, 0.0, 0.0, 4.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer BlockB
{
	f16vec2 a[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp ivec3 b;
	float16_t c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	sA d;
	mediump vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a[0]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.a[1]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.a[2]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.a[3]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.a[4]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.a[5]), vec2(9.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.a[6]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockC.b), ivec3(5, 5, -7)) && allOk;
	allOk = compare_float16_t(float(blockC.c[0]), -4.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[1]), 3.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[2]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[3]), 6.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.d.mA), uvec4(6u, 1u, 3u, 1u)) && allOk;
	allOk = compare_vec4((blockD.e[0]), vec4(-1.0, -9.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.e[1]), vec4(0.0, 2.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.e[2]), vec4(6.0, -8.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = f16vec2(vec2(-9.0, -7.0));
	blockB.a[1] = f16vec2(vec2(-4.0, 8.0));
	blockB.a[2] = f16vec2(vec2(-8.0, -9.0));
	blockB.a[3] = f16vec2(vec2(8.0, 2.0));
	blockB.a[4] = f16vec2(vec2(-6.0, -3.0));
	blockB.a[5] = f16vec2(vec2(1.0, 6.0));
	blockB.a[6] = f16vec2(vec2(3.0, -5.0));
	blockC.c[0] = float16_t(-2.0);
	blockC.c[1] = float16_t(-6.0);
	blockC.c[2] = float16_t(-7.0);
	blockC.c[3] = float16_t(4.0);
	blockD.d.mA = u16vec4(uvec4(7u, 5u, 2u, 0u));
	blockD.e[0] = (vec4(7.0, -9.0, -1.0, -6.0));
	blockD.e[1] = (vec4(4.0, 6.0, 5.0, 3.0));
	blockD.e[2] = (vec4(9.0, -5.0, -1.0, 2.0));
}
#version 450
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
	lowp uint a;
	mediump uint b;
	mediump int c;
	bool d;
};
layout(std140, buffer_reference) buffer BlockC
{
	uint8_t e[1];
	mediump float f;
	lowp uint g;
	lowp uint h;
	lowp int i;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp int j;
	mediump uint k;
	highp float l;
};
layout(std140, buffer_reference) readonly buffer BlockE
{
	highp int m;
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
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 8u) && allOk;
	allOk = compare_int((blockB.c), -2) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[0]), 5u) && allOk;
	allOk = compare_float((blockC.f), -9.0) && allOk;
	allOk = compare_uint((blockC.g), 9u) && allOk;
	allOk = compare_uint((blockD.k), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (5u);
	blockC.e[0] = uint8_t(4u);
	blockC.g = (5u);
	blockC.h = (8u);
	blockD.j = (5);
	blockD.l = (-9.0);
}
#version 450
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
	lowp mat2x3 a;
	u8vec2 b;
	bvec4 c;
	lowp ivec4 d;
	highp mat4x3 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool f;
	highp mat4x2 g[6];
	u8vec2 h;
	bvec4 i;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	i8vec2 j[7];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp uvec3 k;
	mediump mat4 l;
	highp mat2x3 m[5];
	int8_t n;
	highp vec3 o;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.d), ivec4(7, -2, -4, -9)) && allOk;
	allOk = compare_mat4x3(blockB.e, mat4x3(8.0, 1.0, -1.0, 3.0, 8.0, -1.0, 0.0, 0.0, -7.0, 2.0, 9.0, 7.0)) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(1.0, -4.0, -4.0, 0.0, -9.0, 2.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[1], mat4x2(6.0, -1.0, 2.0, -5.0, 3.0, -1.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[2], mat4x2(-6.0, -2.0, -9.0, 3.0, -8.0, 7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[3], mat4x2(-7.0, 8.0, -2.0, -9.0, -5.0, -8.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[4], mat4x2(-8.0, -8.0, -2.0, -3.0, -9.0, 8.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[5], mat4x2(9.0, 7.0, -9.0, 4.0, 2.0, -6.0, 4.0, -8.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h), uvec2(1u, 3u)) && allOk;
	allOk = compare_bvec4((blockC.i), bvec4(false, false, false, true)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[0]), ivec2(4294967291, 4)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[1]), ivec2(4, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[2]), ivec2(4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[3]), ivec2(7, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[4]), ivec2(9, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[5]), ivec2(4294967288, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[6]), ivec2(4, 4)) && allOk;
	allOk = compare_uvec3((blockE.k), uvec3(0u, 8u, 4u)) && allOk;
	allOk = compare_mat4(blockE.l, mat4(7.0, -1.0, 0.0, 6.0, 6.0, 3.0, 6.0, 5.0, -4.0, 3.0, -7.0, -5.0, 7.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockE.m[0], mat2x3(-7.0, 7.0, -8.0, -3.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockE.m[1], mat2x3(3.0, 2.0, -1.0, 6.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockE.m[2], mat2x3(-6.0, 0.0, -6.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockE.m[3], mat2x3(0.0, -9.0, -6.0, 6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockE.m[4], mat2x3(2.0, -3.0, -7.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_int8_t(int(blockE.n), 4294967287) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-5.0, -2.0, -6.0, -3.0, 0.0, 6.0));
	blockB.b = u8vec2(uvec2(2u, 8u));
	blockB.d = (ivec4(-2, 2, 3, -1));
	blockB.e = (mat4x3(4.0, -7.0, -9.0, -4.0, -4.0, 0.0, -6.0, 8.0, 4.0, -7.0, 2.0, 3.0));
	blockC.f = (false);
	blockC.g[0] = (mat4x2(-6.0, -5.0, -4.0, 6.0, -5.0, -6.0, 3.0, -2.0));
	blockC.g[1] = (mat4x2(-8.0, -5.0, 5.0, 2.0, -4.0, -2.0, 8.0, 8.0));
	blockC.g[2] = (mat4x2(-1.0, 8.0, -1.0, 7.0, 1.0, 0.0, 7.0, -5.0));
	blockC.g[3] = (mat4x2(6.0, 6.0, 5.0, 6.0, -6.0, -6.0, -6.0, 3.0));
	blockC.g[4] = (mat4x2(2.0, 5.0, -4.0, -9.0, 5.0, -5.0, -9.0, -1.0));
	blockC.g[5] = (mat4x2(-8.0, 8.0, -7.0, -1.0, 8.0, -1.0, 2.0, 3.0));
	blockC.h = u8vec2(uvec2(8u, 9u));
	blockC.i = (bvec4(false, false, false, true));
	blockE.k = (uvec3(1u, 5u, 4u));
	blockE.m[0] = (mat2x3(5.0, -5.0, -8.0, 2.0, 0.0, -3.0));
	blockE.m[1] = (mat2x3(-2.0, -1.0, 2.0, -4.0, -6.0, 5.0));
	blockE.m[2] = (mat2x3(-8.0, -6.0, 5.0, -3.0, -2.0, 2.0));
	blockE.m[3] = (mat2x3(9.0, -4.0, -4.0, -3.0, 3.0, 9.0));
	blockE.m[4] = (mat2x3(-8.0, 8.0, 7.0, 0.0, -2.0, -8.0));
	blockE.n = int8_t(6);
}
#version 450
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
	u8vec4 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat4x2 b;
	u8vec4 c[2];
	u8vec4 d;
	highp uint e;
	highp int f;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp vec4 g;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat4 h;
	lowp ivec3 i;
	lowp float j;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockC.c[0]), uvec4(5u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c[1]), uvec4(7u, 2u, 9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d), uvec4(2u, 4u, 4u, 4u)) && allOk;
	allOk = compare_uint((blockC.e), 4u) && allOk;
	allOk = compare_int((blockC.f), -7) && allOk;
	allOk = compare_float((blockE.j), 3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat4x2(2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0));
	blockC.c[0] = u8vec4(uvec4(9u, 6u, 0u, 2u));
	blockC.c[1] = u8vec4(uvec4(3u, 6u, 3u, 4u));
	blockD.g = (vec4(-5.0, -2.0, -2.0, 8.0));
	blockE.h = (mat4(-3.0, -3.0, -8.0, 1.0, -3.0, -1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0, 1.0, -9.0, 8.0, 9.0));
}
#version 450
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
	lowp uvec3 a[1];
	highp ivec2 b;
	u8vec3 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat4x2 d;
	highp uvec2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump mat4x2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(5u, 7u, 4u)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(7, -5)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.c[0]), uvec3(3u, 5u, 0u)) && allOk;
	allOk = compare_mat4x2(blockC.d, mat4x2(2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockC.e[0]), uvec2(9u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(9u, 2u, 5u));
	blockB.b = (ivec2(-7, 6));
	blockC.d = (mat4x2(6.0, -4.0, 5.0, 7.0, 9.0, -2.0, 6.0, 4.0));
	blockD.f[0] = (mat4x2(5.0, -8.0, -3.0, -8.0, 1.0, 5.0, 0.0, 2.0));
}
#version 450
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
	i8vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

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

layout(std140, buffer_reference) buffer BlockB
{
	lowp mat3x4 a;
	i8vec2 b;
	lowp mat3x2 c;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump mat3 d;
	highp mat4x2 e;
	highp ivec4 f;
	bvec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockC.d, mat3(1.0, -7.0, -4.0, 6.0, -1.0, -6.0, -2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-1.0, -1.0, -5.0, 2.0, -5.0, 1.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = i8vec2(ivec2(4294967295, 4294967287));
	blockB[1].b = i8vec2(ivec2(4294967291, 4294967287));
	blockC.d = (mat3(-3.0, -6.0, 7.0, -2.0, 1.0, -7.0, 9.0, 6.0, 2.0));
	blockC.e = (mat4x2(-1.0, 6.0, 9.0, -2.0, 0.0, 8.0, 9.0, 0.0));
	blockC.g = (bvec3(true, true, true));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i8vec3 b;
	layout(offset = 16) highp uvec4 c;
	layout(offset = 32) mediump vec4 d;
	layout(offset = 48) mediump float e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[0].a), uvec2(0u, 2u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.b), ivec3(4294967288, 4294967287, 5)) && allOk;
	allOk = compare_vec4((blockC.d), vec4(-1.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_float((blockC.e), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec2(uvec2(0u, 4u));
	blockC.b = i8vec3(ivec3(4294967293, 3, 2));
	blockC.c = (uvec4(0u, 2u, 1u, 4u));
	blockC.e = (3.0);
}
#version 450
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
	highp mat4x3 a;
	i8vec2 b;
	mediump mat3x4 c;
	bvec2 d;
	highp mat4 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	i8vec4 f;
	lowp mat3x2 g;
	highp mat3x2 h[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(6.0, 8.0, 4.0, -9.0, -4.0, 4.0, 0.0, 7.0, 2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(-5.0, 3.0, -8.0, 1.0, 6.0, 4.0, -5.0, 5.0, -5.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, true)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(5.0, -3.0, 0.0, 4.0, 2.0, 4.0, -1.0, 6.0, 1.0, -9.0, 3.0, 3.0, 8.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(0.0, -4.0, 0.0, 1.0, -3.0, 1.0, 3.0, -3.0, 2.0, 2.0, -4.0, 5.0, -8.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.e[2], mat4(-1.0, -1.0, 4.0, -1.0, -7.0, 8.0, 6.0, -5.0, 9.0, 7.0, -6.0, -5.0, 7.0, -1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.e[3], mat4(2.0, 9.0, 6.0, 6.0, 7.0, 1.0, -5.0, 0.0, 4.0, 7.0, 0.0, 7.0, -7.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.e[4], mat4(-4.0, -7.0, 9.0, -9.0, 7.0, 6.0, 6.0, 9.0, 7.0, -5.0, -2.0, -4.0, -2.0, 2.0, -3.0, 7.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f), ivec4(8, 4294967289, 4294967292, 8)) && allOk;
	allOk = compare_mat3x2(blockC[0].g, mat3x2(-4.0, -7.0, -8.0, 2.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat3x4(-8.0, -3.0, -7.0, 1.0, 0.0, 1.0, -4.0, 2.0, -7.0, -7.0, -3.0, -5.0));
	blockB.d = (bvec2(false, false));
	blockB.e[0] = (mat4(9.0, 9.0, 6.0, 9.0, -5.0, 2.0, -5.0, -6.0, 0.0, -5.0, 7.0, 4.0, -1.0, -2.0, -1.0, 3.0));
	blockB.e[1] = (mat4(-7.0, -2.0, 6.0, 9.0, -8.0, -3.0, -4.0, 5.0, -3.0, -2.0, 9.0, 3.0, -1.0, 3.0, -7.0, 3.0));
	blockB.e[2] = (mat4(5.0, -5.0, 4.0, -8.0, 6.0, 0.0, 2.0, -6.0, -7.0, 6.0, 5.0, 1.0, 2.0, -6.0, 9.0, 9.0));
	blockB.e[3] = (mat4(-2.0, -9.0, 7.0, 4.0, 0.0, 8.0, 1.0, 3.0, 4.0, 7.0, 6.0, 2.0, 9.0, 8.0, -5.0, 0.0));
	blockB.e[4] = (mat4(-3.0, 7.0, 0.0, 6.0, -6.0, 2.0, 4.0, 1.0, -3.0, -3.0, -6.0, 8.0, -9.0, -3.0, 7.0, 5.0));
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
	lowp ivec2 mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp vec3 a;
	lowp uvec4 b;
	lowp mat3x2 c[7];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp ivec3 d;
	highp vec2 e;
	sA f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(0u, 3u, 8u, 0u)) && allOk;
	allOk = compare_mat3x2(blockB.c[0], mat3x2(3.0, 1.0, -7.0, -8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1], mat3x2(8.0, -5.0, 9.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[2], mat3x2(1.0, 6.0, -7.0, 5.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[3], mat3x2(-5.0, -6.0, 1.0, 3.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[4], mat3x2(-4.0, -7.0, -8.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[5], mat3x2(4.0, -4.0, 7.0, 3.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[6], mat3x2(4.0, 8.0, -4.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockC[0].d), ivec3(-7, 3, 0)) && allOk;
	allOk = compare_vec2((blockC[0].e), vec2(8.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockC[0].f[0].mA), ivec2(5, 7)) && allOk;
	allOk = compare_ivec2((blockC[0].f[1].mA), ivec2(2, 4)) && allOk;
	allOk = compare_ivec2((blockC[0].f[2].mA), ivec2(-1, -2)) && allOk;
	allOk = compare_ivec2((blockC[0].f[3].mA), ivec2(-4, 6)) && allOk;
	allOk = compare_ivec2((blockC[0].f[4].mA), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((blockC[0].f[5].mA), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((blockC[0].f[6].mA), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((blockC[0].f[7].mA), ivec2(5, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(2.0, -8.0, -2.0));
	blockC[0].d = (ivec3(-5, 9, 8));
	blockC[0].e = (vec2(-4.0, -4.0));
	blockC[0].f[0].mA = (ivec2(-1, 3));
	blockC[0].f[1].mA = (ivec2(4, -7));
	blockC[0].f[2].mA = (ivec2(9, 8));
	blockC[0].f[3].mA = (ivec2(-9, -1));
	blockC[0].f[4].mA = (ivec2(5, -2));
	blockC[0].f[5].mA = (ivec2(4, -4));
	blockC[0].f[6].mA = (ivec2(-7, -5));
	blockC[0].f[7].mA = (ivec2(0, -4));
}
