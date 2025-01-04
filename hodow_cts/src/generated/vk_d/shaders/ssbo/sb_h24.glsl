#version 450
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
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], 9.0) && allOk;
	allOk = compare_float(var[3][2], -4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-6.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(1.0, -9.0, 9.0, 1.0, -8.0, -4.0, -5.0, -7.0, -2.0, -5.0, 4.0, -1.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(3.0, 2.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(9.0, 6.0, -9.0, -4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-3.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(2.0, 5.0, 6.0));
	var[1] = (vec3(-7.0, 5.0, 4.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-4.0, -6.0, 5.0, -5.0, 5.0, -9.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-2.0, -4.0, -2.0, 3.0, -1.0, -2.0, 0.0, 2.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	lowp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (-9.0);
}
#version 450
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
	highp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_vec3((var), vec3(-3.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (vec3(0.0, -2.0, -1.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var, mat4(-2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0, 6.0, 4.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0] = (vec4(2.0, 2.0, 1.0, 9.0));
	var[1] = (vec4(7.0, -2.0, 6.0, 5.0));
	var[2] = (vec4(4.0, 0.0, 2.0, -8.0));
	var[3] = (vec4(-7.0, 4.0, 2.0, 7.0));
}
#version 450
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

	padding = (-6.0);
	var = (mat3x4(-1.0, 0.0, -8.0, 5.0, 7.0, -2.0, -2.0, -1.0, -7.0, -3.0, -4.0, 5.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat3x4(9.0, 2.0, 7.0, -6.0, -9.0, 2.0, -3.0, 1.0, 4.0, 3.0, 2.0, -3.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], 4.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (vec2(-2.0, 7.0));
	var[1] = (vec2(-7.0, 3.0));
	var[2] = (vec2(4.0, -1.0));
	var[3] = (vec2(5.0, -1.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-6.0, 5.0, -5.0, 5.0, -9.0, 2.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var = (mat4x2(-4.0, -2.0, 3.0, -1.0, -2.0, 0.0, 2.0, -6.0));
}
#version 450
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
	u16vec3 var[3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(7u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec3(uvec3(1u, 2u, 6u));
	var[1] = u16vec3(uvec3(8u, 3u, 3u));
	var[2] = u16vec3(uvec3(4u, 4u, 9u));
}
#version 450
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

	var[0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][2] = (vec3(2.0, -9.0, 0.0));
	var[1][0] = (vec3(-7.0, 3.0, -3.0));
	var[1][1] = (vec3(-4.0, -4.0, 5.0));
	var[1][2] = (vec3(-4.0, 1.0, -7.0));
	var[2][0] = (vec3(7.0, 9.0, -7.0));
	var[2][1] = (vec3(8.0, 2.0, 5.0));
	var[2][2] = (vec3(-9.0, 7.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
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
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 9.0, -4.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(5.0, 5.0, -9.0, 2.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (mat2x3(-1.0, 8.0, -5.0, -3.0, 4.0, -4.0));
	var[1] = (mat2x3(1.0, -5.0, 6.0, -8.0, -3.0, 0.0));
	var[2] = (mat2x3(2.0, -1.0, -7.0, 4.0, 6.0, 6.0));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0] = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	var[1] = (mat2x4(9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0));
	var[2] = (mat2x4(3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0, -3.0));
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, -4.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-9.0, -1.0, 0.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-5.0, 3.0, -3.0, 6.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0] = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	var[1] = (mat3x2(-6.0, 7.0, -4.0, -7.0, 0.0, -7.0));
	var[2] = (mat3x2(-2.0, -6.0, -6.0, -4.0, -5.0, -4.0));
}
#version 450
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
	int8_t padding;
	int8_t var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0]), 3) && allOk;
	allOk = compare_int8_t(int(var[1]), 3) && allOk;
	allOk = compare_int8_t(int(var[2]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967290);
	var[0] = int8_t(4294967294);
	var[1] = int8_t(3);
	var[2] = int8_t(4294967288);
}
#version 450
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

	padding = float16_t(3.0);
	var[0] = f16vec3(vec3(3.0, 7.0, -3.0));
	var[1] = f16vec3(vec3(-5.0, -9.0, -1.0));
	var[2] = f16vec3(vec3(0.0, 6.0, 5.0));
}
#version 450
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
	highp uvec4 var[];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[3]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((var[4]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((var[5]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[6]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((var[7]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((var[8]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[9]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[10]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[11]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((var[12]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((var[13]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[14]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((var[15]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((var[16]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((var[17]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((var[18]), uvec4(9u, 6u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (uvec4(2u, 7u, 2u, 9u));
	var[1] = (uvec4(7u, 9u, 5u, 1u));
	var[2] = (uvec4(3u, 4u, 4u, 2u));
	var[3] = (uvec4(0u, 5u, 6u, 2u));
	var[4] = (uvec4(9u, 5u, 7u, 7u));
	var[5] = (uvec4(0u, 3u, 8u, 1u));
	var[6] = (uvec4(4u, 9u, 1u, 3u));
	var[7] = (uvec4(8u, 8u, 8u, 1u));
	var[8] = (uvec4(7u, 5u, 4u, 8u));
	var[9] = (uvec4(6u, 6u, 0u, 9u));
	var[10] = (uvec4(7u, 2u, 3u, 0u));
	var[11] = (uvec4(4u, 4u, 8u, 5u));
	var[12] = (uvec4(6u, 1u, 9u, 4u));
	var[13] = (uvec4(5u, 7u, 7u, 0u));
	var[14] = (uvec4(2u, 5u, 1u, 3u));
	var[15] = (uvec4(9u, 6u, 1u, 2u));
	var[16] = (uvec4(0u, 0u, 8u, 4u));
	var[17] = (uvec4(9u, 5u, 7u, 1u));
	var[18] = (uvec4(2u, 0u, 0u, 4u));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	var[3] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	var[4] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	var[5] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	var[6] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	var[7] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	var[8] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	var[9] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	var[10] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	var[11] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	var[12] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	var[13] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	var[14] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	var[15] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	var[16] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	var[17] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	var[18] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
}
#version 450
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
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[3] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[4] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[5] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[6] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[7] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[8] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[9] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[10] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[11] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	var[12] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	var[13] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	var[14] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	var[15] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	var[16] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	var[17] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	var[18] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
}
#version 450
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

	var[0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[3] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[4] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[5] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[6] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[7] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[8] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[9] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[10] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[11] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	var[12] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	var[13] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	var[14] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	var[15] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	var[16] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	var[17] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	var[18] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	var[3] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	var[4] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	var[5] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	var[6] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	var[7] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	var[8] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	var[9] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	var[10] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	var[11] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	var[12] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	var[13] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	var[14] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	var[15] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	var[16] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	var[17] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	var[18] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
}
#version 450
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

	var[0][0] = (vec2(4.0, -9.0));
	var[0][1] = (vec2(-2.0, 8.0));
	var[0][2] = (vec2(-4.0, 4.0));
	var[0][3] = (vec2(9.0, 5.0));
	var[1][0] = (vec2(-2.0, 4.0));
	var[1][1] = (vec2(6.0, -8.0));
	var[1][2] = (vec2(-5.0, -1.0));
	var[1][3] = (vec2(9.0, 0.0));
	var[2][0] = (vec2(5.0, -2.0));
	var[2][1] = (vec2(4.0, -5.0));
	var[2][2] = (vec2(-2.0, -4.0));
	var[2][3] = (vec2(6.0, 4.0));
	var[3][0] = (vec2(5.0, 5.0));
	var[3][1] = (vec2(-6.0, -5.0));
	var[3][2] = (vec2(7.0, -6.0));
	var[3][3] = (vec2(8.0, 5.0));
	var[4][0] = (vec2(5.0, -5.0));
	var[4][1] = (vec2(-6.0, -3.0));
	var[4][2] = (vec2(-1.0, -1.0));
	var[4][3] = (vec2(-2.0, 6.0));
	var[5][0] = (vec2(-1.0, -8.0));
	var[5][1] = (vec2(-5.0, 5.0));
	var[5][2] = (vec2(5.0, 9.0));
	var[5][3] = (vec2(-7.0, 0.0));
	var[6][0] = (vec2(6.0, 4.0));
	var[6][1] = (vec2(5.0, 2.0));
	var[6][2] = (vec2(6.0, -4.0));
	var[6][3] = (vec2(-4.0, 8.0));
	var[7][0] = (vec2(5.0, -1.0));
	var[7][1] = (vec2(7.0, 0.0));
	var[7][2] = (vec2(-7.0, -4.0));
	var[7][3] = (vec2(1.0, -1.0));
	var[8][0] = (vec2(7.0, -6.0));
	var[8][1] = (vec2(9.0, -9.0));
	var[8][2] = (vec2(7.0, -8.0));
	var[8][3] = (vec2(5.0, -4.0));
	var[9][0] = (vec2(4.0, 3.0));
	var[9][1] = (vec2(9.0, 1.0));
	var[9][2] = (vec2(-6.0, -3.0));
	var[9][3] = (vec2(-7.0, 9.0));
	var[10][0] = (vec2(3.0, 5.0));
	var[10][1] = (vec2(3.0, -7.0));
	var[10][2] = (vec2(0.0, 6.0));
	var[10][3] = (vec2(-8.0, -2.0));
	var[11][0] = (vec2(7.0, -6.0));
	var[11][1] = (vec2(2.0, -2.0));
	var[11][2] = (vec2(8.0, 8.0));
	var[11][3] = (vec2(1.0, -3.0));
	var[12][0] = (vec2(-8.0, 0.0));
	var[12][1] = (vec2(-4.0, 6.0));
	var[12][2] = (vec2(-7.0, 4.0));
	var[12][3] = (vec2(-6.0, -5.0));
	var[13][0] = (vec2(-2.0, 7.0));
	var[13][1] = (vec2(-3.0, 0.0));
	var[13][2] = (vec2(-8.0, -9.0));
	var[13][3] = (vec2(6.0, 0.0));
	var[14][0] = (vec2(6.0, -7.0));
	var[14][1] = (vec2(2.0, 3.0));
	var[14][2] = (vec2(-4.0, -6.0));
	var[14][3] = (vec2(5.0, -1.0));
	var[15][0] = (vec2(-8.0, 7.0));
	var[15][1] = (vec2(0.0, 0.0));
	var[15][2] = (vec2(-7.0, -3.0));
	var[15][3] = (vec2(-7.0, -3.0));
	var[16][0] = (vec2(2.0, 6.0));
	var[16][1] = (vec2(3.0, 3.0));
	var[16][2] = (vec2(-8.0, -2.0));
	var[16][3] = (vec2(-4.0, 0.0));
	var[17][0] = (vec2(2.0, 5.0));
	var[17][1] = (vec2(2.0, 3.0));
	var[17][2] = (vec2(-3.0, 2.0));
	var[17][3] = (vec2(4.0, 1.0));
	var[18][0] = (vec2(6.0, 5.0));
	var[18][1] = (vec2(3.0, 5.0));
	var[18][2] = (vec2(2.0, 5.0));
	var[18][3] = (vec2(-8.0, 8.0));
}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[3] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[4] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[5] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[6] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[7] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[8] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[9] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[10] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[11] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	var[12] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	var[13] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	var[14] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	var[15] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	var[16] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	var[17] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	var[18] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	var[3] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	var[4] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	var[5] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	var[6] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	var[7] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	var[8] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	var[9] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	var[10] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	var[11] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	var[12] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	var[13] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	var[14] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	var[15] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	var[16] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	var[17] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	var[18] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
}
#version 450
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

	var[0][0] = (vec2(4.0, -9.0));
	var[0][1] = (vec2(-2.0, 8.0));
	var[0][2] = (vec2(-4.0, 4.0));
	var[0][3] = (vec2(9.0, 5.0));
	var[1][0] = (vec2(-2.0, 4.0));
	var[1][1] = (vec2(6.0, -8.0));
	var[1][2] = (vec2(-5.0, -1.0));
	var[1][3] = (vec2(9.0, 0.0));
	var[2][0] = (vec2(5.0, -2.0));
	var[2][1] = (vec2(4.0, -5.0));
	var[2][2] = (vec2(-2.0, -4.0));
	var[2][3] = (vec2(6.0, 4.0));
	var[3][0] = (vec2(5.0, 5.0));
	var[3][1] = (vec2(-6.0, -5.0));
	var[3][2] = (vec2(7.0, -6.0));
	var[3][3] = (vec2(8.0, 5.0));
	var[4][0] = (vec2(5.0, -5.0));
	var[4][1] = (vec2(-6.0, -3.0));
	var[4][2] = (vec2(-1.0, -1.0));
	var[4][3] = (vec2(-2.0, 6.0));
	var[5][0] = (vec2(-1.0, -8.0));
	var[5][1] = (vec2(-5.0, 5.0));
	var[5][2] = (vec2(5.0, 9.0));
	var[5][3] = (vec2(-7.0, 0.0));
	var[6][0] = (vec2(6.0, 4.0));
	var[6][1] = (vec2(5.0, 2.0));
	var[6][2] = (vec2(6.0, -4.0));
	var[6][3] = (vec2(-4.0, 8.0));
	var[7][0] = (vec2(5.0, -1.0));
	var[7][1] = (vec2(7.0, 0.0));
	var[7][2] = (vec2(-7.0, -4.0));
	var[7][3] = (vec2(1.0, -1.0));
	var[8][0] = (vec2(7.0, -6.0));
	var[8][1] = (vec2(9.0, -9.0));
	var[8][2] = (vec2(7.0, -8.0));
	var[8][3] = (vec2(5.0, -4.0));
	var[9][0] = (vec2(4.0, 3.0));
	var[9][1] = (vec2(9.0, 1.0));
	var[9][2] = (vec2(-6.0, -3.0));
	var[9][3] = (vec2(-7.0, 9.0));
	var[10][0] = (vec2(3.0, 5.0));
	var[10][1] = (vec2(3.0, -7.0));
	var[10][2] = (vec2(0.0, 6.0));
	var[10][3] = (vec2(-8.0, -2.0));
	var[11][0] = (vec2(7.0, -6.0));
	var[11][1] = (vec2(2.0, -2.0));
	var[11][2] = (vec2(8.0, 8.0));
	var[11][3] = (vec2(1.0, -3.0));
	var[12][0] = (vec2(-8.0, 0.0));
	var[12][1] = (vec2(-4.0, 6.0));
	var[12][2] = (vec2(-7.0, 4.0));
	var[12][3] = (vec2(-6.0, -5.0));
	var[13][0] = (vec2(-2.0, 7.0));
	var[13][1] = (vec2(-3.0, 0.0));
	var[13][2] = (vec2(-8.0, -9.0));
	var[13][3] = (vec2(6.0, 0.0));
	var[14][0] = (vec2(6.0, -7.0));
	var[14][1] = (vec2(2.0, 3.0));
	var[14][2] = (vec2(-4.0, -6.0));
	var[14][3] = (vec2(5.0, -1.0));
	var[15][0] = (vec2(-8.0, 7.0));
	var[15][1] = (vec2(0.0, 0.0));
	var[15][2] = (vec2(-7.0, -3.0));
	var[15][3] = (vec2(-7.0, -3.0));
	var[16][0] = (vec2(2.0, 6.0));
	var[16][1] = (vec2(3.0, 3.0));
	var[16][2] = (vec2(-8.0, -2.0));
	var[16][3] = (vec2(-4.0, 0.0));
	var[17][0] = (vec2(2.0, 5.0));
	var[17][1] = (vec2(2.0, 3.0));
	var[17][2] = (vec2(-3.0, 2.0));
	var[17][3] = (vec2(4.0, 1.0));
	var[18][0] = (vec2(6.0, 5.0));
	var[18][1] = (vec2(3.0, 5.0));
	var[18][2] = (vec2(2.0, 5.0));
	var[18][3] = (vec2(-8.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[3] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[4] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[5] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[6] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[7] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[8] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[9] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[10] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[11] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	var[12] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	var[13] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	var[14] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	var[15] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	var[16] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	var[17] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	var[18] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
}
#version 450
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
	highp vec4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[0][2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][0]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][1]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][2]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[2][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[2][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[2][2]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[3][0]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][1]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[3][2]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[0][2] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[1][0] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[1][1] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[1][2] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[2][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[2][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[2][2] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[3][0] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[3][1] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[3][2] = (vec4(2.0, 6.0, 6.0, 1.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[0][2] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[1][0] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[1][1] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[1][2] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[2][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[2][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[2][2] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[3][0] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[3][1] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[3][2] = (mat2(6.0, 0.0, 1.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[0][2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	var[1][0] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	var[1][1] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	var[1][2] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	var[2][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	var[2][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	var[2][2] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	var[3][0] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	var[3][1] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	var[3][2] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(4.0, -9.0));
	var[0][0][1] = (vec2(-2.0, 8.0));
	var[0][0][2] = (vec2(-4.0, 4.0));
	var[0][0][3] = (vec2(9.0, 5.0));
	var[0][1][0] = (vec2(-2.0, 4.0));
	var[0][1][1] = (vec2(6.0, -8.0));
	var[0][1][2] = (vec2(-5.0, -1.0));
	var[0][1][3] = (vec2(9.0, 0.0));
	var[0][2][0] = (vec2(5.0, -2.0));
	var[0][2][1] = (vec2(4.0, -5.0));
	var[0][2][2] = (vec2(-2.0, -4.0));
	var[0][2][3] = (vec2(6.0, 4.0));
	var[1][0][0] = (vec2(5.0, 5.0));
	var[1][0][1] = (vec2(-6.0, -5.0));
	var[1][0][2] = (vec2(7.0, -6.0));
	var[1][0][3] = (vec2(8.0, 5.0));
	var[1][1][0] = (vec2(5.0, -5.0));
	var[1][1][1] = (vec2(-6.0, -3.0));
	var[1][1][2] = (vec2(-1.0, -1.0));
	var[1][1][3] = (vec2(-2.0, 6.0));
	var[1][2][0] = (vec2(-1.0, -8.0));
	var[1][2][1] = (vec2(-5.0, 5.0));
	var[1][2][2] = (vec2(5.0, 9.0));
	var[1][2][3] = (vec2(-7.0, 0.0));
	var[2][0][0] = (vec2(6.0, 4.0));
	var[2][0][1] = (vec2(5.0, 2.0));
	var[2][0][2] = (vec2(6.0, -4.0));
	var[2][0][3] = (vec2(-4.0, 8.0));
	var[2][1][0] = (vec2(5.0, -1.0));
	var[2][1][1] = (vec2(7.0, 0.0));
	var[2][1][2] = (vec2(-7.0, -4.0));
	var[2][1][3] = (vec2(1.0, -1.0));
	var[2][2][0] = (vec2(7.0, -6.0));
	var[2][2][1] = (vec2(9.0, -9.0));
	var[2][2][2] = (vec2(7.0, -8.0));
	var[2][2][3] = (vec2(5.0, -4.0));
	var[3][0][0] = (vec2(4.0, 3.0));
	var[3][0][1] = (vec2(9.0, 1.0));
	var[3][0][2] = (vec2(-6.0, -3.0));
	var[3][0][3] = (vec2(-7.0, 9.0));
	var[3][1][0] = (vec2(3.0, 5.0));
	var[3][1][1] = (vec2(3.0, -7.0));
	var[3][1][2] = (vec2(0.0, 6.0));
	var[3][1][3] = (vec2(-8.0, -2.0));
	var[3][2][0] = (vec2(7.0, -6.0));
	var[3][2][1] = (vec2(2.0, -2.0));
	var[3][2][2] = (vec2(8.0, 8.0));
	var[3][2][3] = (vec2(1.0, -3.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[0][2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[1][0] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[1][1] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[1][2] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[2][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[2][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[2][2] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[3][0] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[3][1] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[3][2] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[0][2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	var[1][0] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	var[1][1] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	var[1][2] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	var[2][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	var[2][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	var[2][2] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	var[3][0] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	var[3][1] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	var[3][2] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(-7.0, 8.0, 7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-2.0, 1.0, -7.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(7.0, 2.0, -2.0, -3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(5.0, 9.0, -2.0, -6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(7.0, 9.0, 5.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(4.0, -6.0, -4.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(9.0, 8.0, -5.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-3.0, -8.0, 0.0, -2.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(9.0, 4.0, -4.0, -7.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-8.0, 0.0, -2.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(2.0, 2.0, 8.0, 5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(9.0, -3.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0] = (mat2x3(6.0, 9.0, 9.0, -8.0, 7.0, 5.0));
	var[0][1] = (mat2x3(-1.0, -9.0, 0.0, 8.0, 1.0, -7.0));
	var[0][2] = (mat2x3(2.0, 4.0, -8.0, 4.0, 4.0, -4.0));
	var[1][0] = (mat2x3(3.0, 7.0, -5.0, -6.0, 7.0, 3.0));
	var[1][1] = (mat2x3(8.0, -7.0, -7.0, -6.0, 2.0, -8.0));
	var[1][2] = (mat2x3(8.0, -7.0, -2.0, 5.0, 7.0, 4.0));
	var[2][0] = (mat2x3(-7.0, -7.0, 6.0, -8.0, -8.0, 7.0));
	var[2][1] = (mat2x3(-8.0, 4.0, 7.0, 0.0, 3.0, 9.0));
	var[2][2] = (mat2x3(4.0, 7.0, 4.0, -7.0, 6.0, 1.0));
	var[3][0] = (mat2x3(3.0, 2.0, -1.0, -8.0, -8.0, 2.0));
	var[3][1] = (mat2x3(9.0, -3.0, -1.0, -2.0, -1.0, -1.0));
	var[3][2] = (mat2x3(8.0, 1.0, -6.0, -9.0, -3.0, -1.0));
}
#version 450
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
	bvec3 var[4][2][3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0][0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[0][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[0][0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[0][1][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[0][1][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][1][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][0][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][1][2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[2][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[2][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[3][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[3][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][0][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[3][1][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[3][1][2]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec3(true, true, false));
	var[0][0][1] = (bvec3(false, true, true));
	var[0][0][2] = (bvec3(false, false, false));
	var[0][1][0] = (bvec3(false, false, true));
	var[0][1][1] = (bvec3(true, false, true));
	var[0][1][2] = (bvec3(false, false, false));
	var[1][0][0] = (bvec3(true, false, false));
	var[1][0][1] = (bvec3(true, true, true));
	var[1][0][2] = (bvec3(false, true, true));
	var[1][1][0] = (bvec3(true, true, false));
	var[1][1][1] = (bvec3(false, false, true));
	var[1][1][2] = (bvec3(false, false, true));
	var[2][0][0] = (bvec3(false, true, true));
	var[2][0][1] = (bvec3(true, true, true));
	var[2][0][2] = (bvec3(true, true, true));
	var[2][1][0] = (bvec3(true, true, false));
	var[2][1][1] = (bvec3(false, true, false));
	var[2][1][2] = (bvec3(false, true, false));
	var[3][0][0] = (bvec3(true, false, false));
	var[3][0][1] = (bvec3(false, true, false));
	var[3][0][2] = (bvec3(true, false, false));
	var[3][1][0] = (bvec3(false, false, false));
	var[3][1][1] = (bvec3(true, true, false));
	var[3][1][2] = (bvec3(false, true, false));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][0][2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[0][0][2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[0][0][2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[0][1][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	var[0][1][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	var[0][1][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	var[0][1][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	var[0][1][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	var[0][1][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	var[0][1][2][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	var[0][1][2][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	var[0][1][2][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	var[1][0][0][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[1][0][0][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][0][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][0][1][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[1][0][1][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[1][0][1][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[1][0][2][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[1][0][2][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[1][0][2][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[1][1][0][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	var[1][1][0][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	var[1][1][0][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	var[1][1][1][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	var[1][1][1][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	var[1][1][1][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	var[1][1][2][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	var[1][1][2][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	var[1][1][2][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	var[2][0][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[2][0][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[2][0][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[2][0][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[2][0][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[2][0][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[2][0][2][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[2][0][2][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[2][0][2][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[2][1][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	var[2][1][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	var[2][1][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	var[2][1][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	var[2][1][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	var[2][1][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	var[2][1][2][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	var[2][1][2][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	var[2][1][2][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	var[3][0][0][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[3][0][0][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[3][0][0][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[3][0][1][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[3][0][1][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[3][0][1][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[3][0][2][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[3][0][2][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[3][0][2][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[3][1][0][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	var[3][1][0][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	var[3][1][0][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	var[3][1][1][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	var[3][1][1][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	var[3][1][1][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	var[3][1][2][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	var[3][1][2][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	var[3][1][2][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[0][0][2] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[0][1][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	var[0][1][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	var[0][1][2] = (mat2(-2.0, -3.0, 3.0, -1.0));
	var[1][0][0] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[1][0][1] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[1][0][2] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[1][1][0] = (mat2(-2.0, -8.0, 1.0, -1.0));
	var[1][1][1] = (mat2(9.0, -2.0, -3.0, 6.0));
	var[1][1][2] = (mat2(2.0, 6.0, -4.0, -6.0));
	var[2][0][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[2][0][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[2][0][2] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[2][1][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	var[2][1][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	var[2][1][2] = (mat2(-6.0, -2.0, 3.0, -6.0));
	var[3][0][0] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[3][0][1] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[3][0][2] = (mat2(6.0, 0.0, 1.0, 8.0));
	var[3][1][0] = (mat2(-9.0, -4.0, 0.0, -1.0));
	var[3][1][1] = (mat2(0.0, 7.0, 4.0, 1.0));
	var[3][1][2] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[0][0][2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[0][1][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	var[0][1][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	var[0][1][2] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	var[1][0][0] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[1][0][1] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[1][0][2] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[1][1][0] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	var[1][1][1] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	var[1][1][2] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	var[2][0][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[2][0][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[2][0][2] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[2][1][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	var[2][1][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	var[2][1][2] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	var[3][0][0] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[3][0][1] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[3][0][2] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	var[3][1][0] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	var[3][1][1] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	var[3][1][2] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
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
	u8vec4 var[4][2][3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0][0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][0]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][1]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][2]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][0]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][1]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][2]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][0]), uvec4(1u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][1]), uvec4(5u, 8u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][2]), uvec4(0u, 3u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][0]), uvec4(1u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][1]), uvec4(4u, 8u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][2]), uvec4(6u, 3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[0][0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[0][0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	var[0][1][0] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	var[0][1][1] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	var[0][1][2] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	var[1][0][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	var[1][0][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	var[1][0][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	var[1][1][0] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	var[1][1][1] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	var[1][1][2] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	var[2][0][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	var[2][0][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	var[2][0][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	var[2][1][0] = u8vec4(uvec4(8u, 9u, 4u, 7u));
	var[2][1][1] = u8vec4(uvec4(0u, 4u, 6u, 7u));
	var[2][1][2] = u8vec4(uvec4(4u, 2u, 8u, 9u));
	var[3][0][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	var[3][0][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	var[3][0][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	var[3][1][0] = u8vec4(uvec4(9u, 8u, 8u, 1u));
	var[3][1][1] = u8vec4(uvec4(2u, 6u, 8u, 6u));
	var[3][1][2] = u8vec4(uvec4(9u, 6u, 5u, 0u));
}
#version 450
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
	u16vec4 var[4][2][3];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0][0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][2]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][0]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][1]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][2]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][2]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][0]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][1]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][2]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[0][0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[0][1][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	var[0][1][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	var[0][1][2] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	var[1][0][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[1][0][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[1][0][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[1][1][0] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	var[1][1][1] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	var[1][1][2] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	var[2][0][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[2][0][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[2][0][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[2][1][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	var[2][1][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	var[2][1][2] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	var[3][0][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[3][0][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[3][0][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	var[3][1][0] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	var[3][1][1] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	var[3][1][2] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0] = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	var[0][0][1] = (mat4(6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0));
	var[0][0][2] = (mat4(-7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0));
	var[0][1][0] = (mat4(1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0, -1.0));
	var[0][1][1] = (mat4(8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0, 2.0));
	var[0][1][2] = (mat4(8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0, -7.0));
	var[1][0][0] = (mat4(3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0, -4.0));
	var[1][0][1] = (mat4(-1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0, -5.0));
	var[1][0][2] = (mat4(-1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0, 3.0));
	var[1][1][0] = (mat4(-5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0, 7.0));
	var[1][1][1] = (mat4(2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0, -4.0));
	var[1][1][2] = (mat4(-1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0, -2.0));
	var[2][0][0] = (mat4(6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0, 1.0));
	var[2][0][1] = (mat4(2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0, 2.0));
	var[2][0][2] = (mat4(4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0, 8.0));
	var[2][1][0] = (mat4(-1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0, 9.0));
	var[2][1][1] = (mat4(-7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0, -5.0));
	var[2][1][2] = (mat4(-6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0, 7.0));
	var[3][0][0] = (mat4(9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0, -8.0));
	var[3][0][1] = (mat4(6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0, -2.0));
	var[3][0][2] = (mat4(0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0, 5.0));
	var[3][1][0] = (mat4(1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0, 4.0));
	var[3][1][1] = (mat4(2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0, -8.0));
	var[3][1][2] = (mat4(9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0, -8.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0, -9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0, 8.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0, -1.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0, 0.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0, 6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0, -3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0, 8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0, 8.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0, -8.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0, -9.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0, 3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0, 9.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0, 6.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0][0][0] = (vec3(-6.0, 3.0, -3.0));
	var[0][0][0][1] = (vec3(9.0, -2.0, 3.0));
	var[0][0][0][2] = (vec3(9.0, -9.0, 7.0));
	var[0][0][0][3] = (vec3(4.0, -4.0, 5.0));
	var[0][0][1][0] = (vec3(-1.0, -2.0, 6.0));
	var[0][0][1][1] = (vec3(-4.0, 6.0, 4.0));
	var[0][0][1][2] = (vec3(-8.0, 7.0, 3.0));
	var[0][0][1][3] = (vec3(1.0, -9.0, -4.0));
	var[0][0][2][0] = (vec3(9.0, 2.0, 2.0));
	var[0][0][2][1] = (vec3(9.0, -7.0, 3.0));
	var[0][0][2][2] = (vec3(8.0, 2.0, 4.0));
	var[0][0][2][3] = (vec3(-9.0, 8.0, 2.0));
	var[0][1][0][0] = (vec3(-7.0, -3.0, -4.0));
	var[0][1][0][1] = (vec3(4.0, -3.0, -8.0));
	var[0][1][0][2] = (vec3(-5.0, -1.0, 1.0));
	var[0][1][0][3] = (vec3(2.0, -4.0, 6.0));
	var[0][1][1][0] = (vec3(-7.0, 1.0, 4.0));
	var[0][1][1][1] = (vec3(6.0, 8.0, -5.0));
	var[0][1][1][2] = (vec3(1.0, -6.0, 4.0));
	var[0][1][1][3] = (vec3(-2.0, 8.0, -9.0));
	var[0][1][2][0] = (vec3(0.0, -5.0, -3.0));
	var[0][1][2][1] = (vec3(-5.0, -8.0, 3.0));
	var[0][1][2][2] = (vec3(3.0, -6.0, 8.0));
	var[0][1][2][3] = (vec3(3.0, -3.0, -3.0));
	var[1][0][0][0] = (vec3(-8.0, 7.0, 3.0));
	var[1][0][0][1] = (vec3(0.0, -8.0, 0.0));
	var[1][0][0][2] = (vec3(6.0, -9.0, 0.0));
	var[1][0][0][3] = (vec3(4.0, -3.0, -4.0));
	var[1][0][1][0] = (vec3(-7.0, -8.0, -1.0));
	var[1][0][1][1] = (vec3(6.0, -3.0, -5.0));
	var[1][0][1][2] = (vec3(0.0, 8.0, -8.0));
	var[1][0][1][3] = (vec3(5.0, 5.0, -4.0));
	var[1][0][2][0] = (vec3(-4.0, -4.0, -3.0));
	var[1][0][2][1] = (vec3(3.0, 3.0, 2.0));
	var[1][0][2][2] = (vec3(8.0, -8.0, -6.0));
	var[1][0][2][3] = (vec3(4.0, 8.0, 9.0));
	var[1][1][0][0] = (vec3(5.0, -1.0, 6.0));
	var[1][1][0][1] = (vec3(8.0, 7.0, 1.0));
	var[1][1][0][2] = (vec3(-5.0, 6.0, -6.0));
	var[1][1][0][3] = (vec3(5.0, 6.0, -3.0));
	var[1][1][1][0] = (vec3(-9.0, -3.0, 6.0));
	var[1][1][1][1] = (vec3(0.0, -7.0, 3.0));
	var[1][1][1][2] = (vec3(2.0, -7.0, 1.0));
	var[1][1][1][3] = (vec3(-7.0, 7.0, 8.0));
	var[1][1][2][0] = (vec3(8.0, 8.0, 2.0));
	var[1][1][2][1] = (vec3(7.0, -5.0, -2.0));
	var[1][1][2][2] = (vec3(-9.0, 6.0, 2.0));
	var[1][1][2][3] = (vec3(-1.0, -9.0, -1.0));
	var[2][0][0][0] = (vec3(-1.0, 2.0, 4.0));
	var[2][0][0][1] = (vec3(4.0, 2.0, 0.0));
	var[2][0][0][2] = (vec3(5.0, 6.0, -6.0));
	var[2][0][0][3] = (vec3(1.0, -1.0, -3.0));
	var[2][0][1][0] = (vec3(7.0, 9.0, 8.0));
	var[2][0][1][1] = (vec3(-9.0, -9.0, -9.0));
	var[2][0][1][2] = (vec3(6.0, -7.0, -3.0));
	var[2][0][1][3] = (vec3(7.0, -6.0, 7.0));
	var[2][0][2][0] = (vec3(-9.0, 0.0, -1.0));
	var[2][0][2][1] = (vec3(-7.0, -2.0, -3.0));
	var[2][0][2][2] = (vec3(1.0, 4.0, 5.0));
	var[2][0][2][3] = (vec3(-1.0, -4.0, 9.0));
	var[2][1][0][0] = (vec3(3.0, -4.0, -1.0));
	var[2][1][0][1] = (vec3(-4.0, 5.0, 7.0));
	var[2][1][0][2] = (vec3(-5.0, 7.0, 5.0));
	var[2][1][0][3] = (vec3(7.0, 7.0, -1.0));
	var[2][1][1][0] = (vec3(9.0, 7.0, -5.0));
	var[2][1][1][1] = (vec3(3.0, -1.0, 3.0));
	var[2][1][1][2] = (vec3(8.0, -5.0, 3.0));
	var[2][1][1][3] = (vec3(-1.0, 5.0, -6.0));
	var[2][1][2][0] = (vec3(8.0, -8.0, 5.0));
	var[2][1][2][1] = (vec3(-3.0, 5.0, -4.0));
	var[2][1][2][2] = (vec3(-3.0, -2.0, 2.0));
	var[2][1][2][3] = (vec3(1.0, 0.0, -5.0));
	var[3][0][0][0] = (vec3(5.0, 4.0, 7.0));
	var[3][0][0][1] = (vec3(3.0, -3.0, 4.0));
	var[3][0][0][2] = (vec3(3.0, -6.0, 5.0));
	var[3][0][0][3] = (vec3(8.0, 7.0, -8.0));
	var[3][0][1][0] = (vec3(4.0, 8.0, -3.0));
	var[3][0][1][1] = (vec3(-9.0, 7.0, -2.0));
	var[3][0][1][2] = (vec3(0.0, -3.0, -3.0));
	var[3][0][1][3] = (vec3(-4.0, -9.0, 4.0));
	var[3][0][2][0] = (vec3(-5.0, -7.0, 1.0));
	var[3][0][2][1] = (vec3(-8.0, 1.0, 9.0));
	var[3][0][2][2] = (vec3(-8.0, 0.0, -2.0));
	var[3][0][2][3] = (vec3(-2.0, -4.0, -5.0));
	var[3][1][0][0] = (vec3(-6.0, -4.0, -2.0));
	var[3][1][0][1] = (vec3(-5.0, -2.0, -2.0));
	var[3][1][0][2] = (vec3(-8.0, 2.0, 4.0));
	var[3][1][0][3] = (vec3(3.0, -6.0, -1.0));
	var[3][1][1][0] = (vec3(-9.0, -7.0, -8.0));
	var[3][1][1][1] = (vec3(-8.0, -5.0, -1.0));
	var[3][1][1][2] = (vec3(2.0, 0.0, -4.0));
	var[3][1][1][3] = (vec3(-1.0, 1.0, 7.0));
	var[3][1][2][0] = (vec3(-5.0, -5.0, 8.0));
	var[3][1][2][1] = (vec3(-3.0, 4.0, -5.0));
	var[3][1][2][2] = (vec3(-8.0, 5.0, -2.0));
	var[3][1][2][3] = (vec3(6.0, 4.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(7.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(8.0, -5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(6.0, 3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(6.0, 9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(-5.0, 7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[0][0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[0][1][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[0][1][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[0][2][0] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	var[0][2][1] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	var[0][3][0] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
	var[0][3][1] = (mat4x3(-9.0, 0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0));
	var[1][0][0] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[1][0][1] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[1][1][0] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[1][1][1] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[1][2][0] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	var[1][2][1] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	var[1][3][0] = (mat4x3(-4.0, 1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0));
	var[1][3][1] = (mat4x3(-2.0, -2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0));
	var[2][0][0] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[2][0][1] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[2][1][0] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[2][1][1] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	var[2][2][0] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	var[2][2][1] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	var[2][3][0] = (mat4x3(-2.0, 3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0));
	var[2][3][1] = (mat4x3(-7.0, -4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0));
}
#version 450
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
	highp ivec4 var[][4][2];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[0][1][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[0][1][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[0][2][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((var[0][2][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((var[0][3][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((var[0][3][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][0][0]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[1][0][1]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][1][0]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[1][1][1]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[1][2][0]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((var[1][2][1]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((var[1][3][0]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((var[1][3][1]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((var[2][0][0]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[2][0][1]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[2][1][0]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[2][1][1]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((var[2][2][0]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((var[2][2][1]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((var[2][3][0]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((var[2][3][1]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec4(5, -9, 5, -6));
	var[0][0][1] = (ivec4(-2, -4, 1, -9));
	var[0][1][0] = (ivec4(6, 5, 4, 0));
	var[0][1][1] = (ivec4(5, 9, 0, 0));
	var[0][2][0] = (ivec4(7, 1, -4, 4));
	var[0][2][1] = (ivec4(-2, 5, -8, 0));
	var[0][3][0] = (ivec4(6, 8, -7, -2));
	var[0][3][1] = (ivec4(9, -9, -5, -6));
	var[1][0][0] = (ivec4(7, 3, 6, 8));
	var[1][0][1] = (ivec4(6, -4, 6, -7));
	var[1][1][0] = (ivec4(-6, 4, 4, 2));
	var[1][1][1] = (ivec4(9, 7, 5, 5));
	var[1][2][0] = (ivec4(8, -9, -8, -3));
	var[1][2][1] = (ivec4(3, -9, -5, -4));
	var[1][3][0] = (ivec4(-5, -7, -9, -3));
	var[1][3][1] = (ivec4(-2, -1, -9, 9));
	var[2][0][0] = (ivec4(9, -8, -9, 0));
	var[2][0][1] = (ivec4(5, -7, 2, 9));
	var[2][1][0] = (ivec4(3, -3, -9, -8));
	var[2][1][1] = (ivec4(-6, 3, 2, 0));
	var[2][2][0] = (ivec4(-8, 8, -3, 2));
	var[2][2][1] = (ivec4(-2, -6, 4, -5));
	var[2][3][0] = (ivec4(-5, 1, 9, -8));
	var[2][3][1] = (ivec4(0, 5, -8, -8));
}
#version 450
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
	uint16_t var[][4][2];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[0][2][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[0][2][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[0][3][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[0][3][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1][2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[1][2][1]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[1][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[1][3][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[2][2][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[2][2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][3][1]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = uint16_t(9u);
	var[0][0][1] = uint16_t(1u);
	var[0][1][0] = uint16_t(8u);
	var[0][1][1] = uint16_t(1u);
	var[0][2][0] = uint16_t(3u);
	var[0][2][1] = uint16_t(1u);
	var[0][3][0] = uint16_t(2u);
	var[0][3][1] = uint16_t(9u);
	var[1][0][0] = uint16_t(1u);
	var[1][0][1] = uint16_t(0u);
	var[1][1][0] = uint16_t(9u);
	var[1][1][1] = uint16_t(7u);
	var[1][2][0] = uint16_t(0u);
	var[1][2][1] = uint16_t(2u);
	var[1][3][0] = uint16_t(3u);
	var[1][3][1] = uint16_t(0u);
	var[2][0][0] = uint16_t(7u);
	var[2][0][1] = uint16_t(5u);
	var[2][1][0] = uint16_t(2u);
	var[2][1][1] = uint16_t(6u);
	var[2][2][0] = uint16_t(1u);
	var[2][2][1] = uint16_t(1u);
	var[2][3][0] = uint16_t(8u);
	var[2][3][1] = uint16_t(4u);
}
#version 450
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
	float16_t var[][4][2];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0][0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][2][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][2][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[0][3][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][3][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][1]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][0]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][2][0]), -8.0) && allOk;
	allOk = compare_float16_t(float(var[1][2][1]), -2.0) && allOk;
	allOk = compare_float16_t(float(var[1][3][0]), 8.0) && allOk;
	allOk = compare_float16_t(float(var[1][3][1]), -1.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][1]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[2][2][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2][2][1]), 3.0) && allOk;
	allOk = compare_float16_t(float(var[2][3][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2][3][1]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = float16_t(-8.0);
	var[0][0][1] = float16_t(9.0);
	var[0][1][0] = float16_t(2.0);
	var[0][1][1] = float16_t(-8.0);
	var[0][2][0] = float16_t(8.0);
	var[0][2][1] = float16_t(-3.0);
	var[0][3][0] = float16_t(3.0);
	var[0][3][1] = float16_t(8.0);
	var[1][0][0] = float16_t(-2.0);
	var[1][0][1] = float16_t(7.0);
	var[1][1][0] = float16_t(-1.0);
	var[1][1][1] = float16_t(6.0);
	var[1][2][0] = float16_t(6.0);
	var[1][2][1] = float16_t(-3.0);
	var[1][3][0] = float16_t(-7.0);
	var[1][3][1] = float16_t(-4.0);
	var[2][0][0] = float16_t(8.0);
	var[2][0][1] = float16_t(-9.0);
	var[2][1][0] = float16_t(-7.0);
	var[2][1][1] = float16_t(-5.0);
	var[2][2][0] = float16_t(-8.0);
	var[2][2][1] = float16_t(1.0);
	var[2][3][0] = float16_t(-6.0);
	var[2][3][1] = float16_t(8.0);
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(6, -9, 8)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-1.0, -3.0, 2.0, -9.0, 4.0, -3.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(1.0, -6.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(2, -5, -8));
	s.b[0] = (mat3(6.0, -9.0, -9.0, -8.0, 0.0, -1.0, -9.0, 2.0, -5.0));
	s.b[1] = (mat3(6.0, -6.0, -5.0, -4.0, -9.0, 4.0, 6.0, -9.0, 6.0));
	s.b[2] = (mat3(7.0, -3.0, 2.0, -8.0, 1.0, 5.0, 1.0, 7.0, -8.0));
	s.b[3] = (mat3(-3.0, -4.0, 9.0, -3.0, -3.0, -4.0, 4.0, -8.0, -1.0));
	s.c = (vec4(-1.0, -8.0, 4.0, -9.0));
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(2, -2, 0)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(4.0, -2.0, 2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-1.0, 5.0, 6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(-5.0, -2.0, 8.0, -4.0, 0.0, -9.0, -5.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(-2.0, 1.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(-3, -4, 0)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(7.0, 8.0, 6.0, 9.0, -6.0, 1.0, 1.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-2.0, 8.0, 0.0, 8.0, 4.0, 0.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(6.0, 8.0, 9.0, -9.0, -4.0, 0.0, -4.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(1.0, 2.0, 5.0, -8.0, -4.0, 4.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(-9.0, -9.0, -8.0, -1.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(-5, 5, 1)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(7.0, -7.0, 0.0, 1.0, 9.0, -3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(-3.0, 4.0, -1.0, 5.0, -6.0, -3.0, -5.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(4.0, -6.0, -2.0, 8.0, 0.0, 1.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(7.0, 1.0, -8.0, 0.0, 5.0, -3.0, -1.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(5.0, -3.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(6, 8, 1));
	s[0].b[0] = (mat3(-6.0, -6.0, 7.0, 1.0, 8.0, 8.0, 9.0, -7.0, -4.0));
	s[0].b[1] = (mat3(0.0, -9.0, -2.0, 7.0, 2.0, 3.0, -7.0, -4.0, 2.0));
	s[0].b[2] = (mat3(-2.0, -7.0, 3.0, 5.0, 3.0, 1.0, -6.0, -6.0, -6.0));
	s[0].b[3] = (mat3(0.0, -7.0, 4.0, 5.0, -6.0, -8.0, 4.0, -7.0, 5.0));
	s[0].c = (vec4(-6.0, 9.0, 0.0, -6.0));
	s[1].a = (ivec3(-7, 5, -7));
	s[1].b[0] = (mat3(-9.0, 7.0, 8.0, -1.0, -4.0, -3.0, -9.0, -1.0, 4.0));
	s[1].b[1] = (mat3(9.0, 3.0, -6.0, -7.0, -3.0, 5.0, 5.0, 3.0, -1.0));
	s[1].b[2] = (mat3(6.0, -8.0, -1.0, 2.0, -5.0, 7.0, 7.0, 7.0, -2.0));
	s[1].b[3] = (mat3(-7.0, -3.0, -2.0, 6.0, 4.0, 3.0, -2.0, -9.0, -2.0));
	s[1].c = (vec4(-2.0, -7.0, 1.0, 3.0));
	s[2].a = (ivec3(2, -2, -1));
	s[2].b[0] = (mat3(-3.0, -4.0, 6.0, -2.0, 9.0, 3.0, -4.0, 4.0, 4.0));
	s[2].b[1] = (mat3(8.0, 5.0, 6.0, -7.0, -7.0, 3.0, -6.0, -8.0, 5.0));
	s[2].b[2] = (mat3(4.0, -6.0, 8.0, 7.0, -6.0, 9.0, 3.0, -6.0, 4.0));
	s[2].b[3] = (mat3(2.0, -6.0, -2.0, 9.0, -6.0, -4.0, 0.0, 7.0, 9.0));
	s[2].c = (vec4(-6.0, 2.0, -6.0, 4.0));
	v = (vec4(1.0, -5.0, 8.0, -2.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(1, -7, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, -9.0, -7.0, -5.0, 1.0, -9.0, -1.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-8.0, -4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(-5, 3, 3)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(5.0, 1.0, 9.0, -9.0, 9.0, 2.0, -4.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-9.0, 3.0, 7.0, -4.0, 1.0, 1.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-7.0, -8.0, -8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(2, -8, -7)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -9.0, 3.0, 0.0, 3.0, -2.0, -8.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-6.0, 0.0, -9.0, 5.0, -4.0, -9.0, 6.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-6.0, 7.0, 1.0, 0.0, 6.0, -2.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(3.0, 6.0, 1.0, -7.0, -5.0, 6.0, 1.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-5.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-6.0, -6.0, 0.0, 8.0, 7.0, -7.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(3, 8, 6)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(-4.0, 3.0, 6.0, 5.0, -3.0, 1.0, -4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(9.0, 4.0, -6.0, -2.0, 2.0, 6.0, 2.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(-4.0, -9.0, 5.0, -6.0, 4.0, 2.0, 7.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(4.0, -3.0, -5.0, 8.0, 2.0, -1.0, 3.0, 0.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(2.0, 8.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-6, 7, -4)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(3.0, -4.0, -1.0, 3.0, -8.0, 0.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-8.0, -4.0, 0.0, -8.0, -5.0, -6.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(8.0, 2.0, -2.0, -9.0, -7.0, 8.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(9.0, -7.0, 4.0, 0.0, 9.0, 9.0, 5.0, 2.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(3.0, -4.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(0, 2, -1)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(2.0, 8.0, -6.0, 0.0, -3.0, 7.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-2.0, 2.0, -4.0, 3.0, -8.0, 5.0, 0.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(8.0, -7.0, 9.0, -8.0, -4.0, -6.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-8.0, -1.0, 2.0, 6.0, 6.0, 6.0, 1.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(2.0, 4.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(2.0, -1.0, -7.0));
	block[0].t.a[1] = (vec3(-5.0, -4.0, -8.0));
	block[0].t.a[2] = (vec3(-3.0, -6.0, -8.0));
	block[0].t.b.a = (ivec3(5, 5, 5));
	block[0].t.b.b[0][0] = (vec3(0.0, 9.0, -9.0));
	block[0].t.b.b[0][1] = (vec3(-5.0, 7.0, -7.0));
	block[0].t.b.b[0][2] = (vec3(8.0, 0.0, -1.0));
	block[0].t.b.b[1][0] = (vec3(3.0, 9.0, 1.0));
	block[0].t.b.b[1][1] = (vec3(1.0, -8.0, 7.0));
	block[0].t.b.b[1][2] = (vec3(8.0, 3.0, 4.0));
	block[0].t.b.b[2][0] = (vec3(7.0, 5.0, 6.0));
	block[0].t.b.b[2][1] = (vec3(4.0, 0.0, -1.0));
	block[0].t.b.b[2][2] = (vec3(-2.0, -7.0, -8.0));
	block[0].t.b.b[3][0] = (vec3(7.0, -9.0, 4.0));
	block[0].t.b.b[3][1] = (vec3(6.0, 3.0, 7.0));
	block[0].t.b.b[3][2] = (vec3(-6.0, 1.0, -5.0));
	block[0].t.b.c = (vec4(-4.0, 0.0, -6.0, 9.0));
	block[0].u = (2u);
	block[1].t.a[0] = (vec3(0.0, 8.0, 9.0));
	block[1].t.a[1] = (vec3(2.0, -4.0, -8.0));
	block[1].t.a[2] = (vec3(3.0, -3.0, -6.0));
	block[1].t.b.a = (ivec3(-3, -5, -9));
	block[1].t.b.b[0][0] = (vec3(9.0, -2.0, 1.0));
	block[1].t.b.b[0][1] = (vec3(-5.0, 0.0, 7.0));
	block[1].t.b.b[0][2] = (vec3(-2.0, -7.0, -7.0));
	block[1].t.b.b[1][0] = (vec3(5.0, -3.0, -2.0));
	block[1].t.b.b[1][1] = (vec3(-6.0, 3.0, -8.0));
	block[1].t.b.b[1][2] = (vec3(4.0, 2.0, -9.0));
	block[1].t.b.b[2][0] = (vec3(3.0, 2.0, -2.0));
	block[1].t.b.b[2][1] = (vec3(9.0, -8.0, -5.0));
	block[1].t.b.b[2][2] = (vec3(-8.0, -2.0, 8.0));
	block[1].t.b.b[3][0] = (vec3(7.0, 6.0, -4.0));
	block[1].t.b.b[3][1] = (vec3(3.0, 3.0, 3.0));
	block[1].t.b.b[3][2] = (vec3(-8.0, 3.0, -3.0));
	block[1].t.b.c = (vec4(-1.0, -4.0, 9.0, -7.0));
	block[1].u = (5u);
	block[2].t.a[0] = (vec3(-6.0, 0.0, -1.0));
	block[2].t.a[1] = (vec3(0.0, -7.0, -8.0));
	block[2].t.a[2] = (vec3(-9.0, 3.0, 4.0));
	block[2].t.b.a = (ivec3(-9, 2, 0));
	block[2].t.b.b[0][0] = (vec3(7.0, 7.0, 7.0));
	block[2].t.b.b[0][1] = (vec3(-8.0, 2.0, -4.0));
	block[2].t.b.b[0][2] = (vec3(-3.0, 0.0, 2.0));
	block[2].t.b.b[1][0] = (vec3(4.0, 6.0, -3.0));
	block[2].t.b.b[1][1] = (vec3(0.0, 2.0, 2.0));
	block[2].t.b.b[1][2] = (vec3(-8.0, -4.0, 2.0));
	block[2].t.b.b[2][0] = (vec3(0.0, -3.0, 1.0));
	block[2].t.b.b[2][1] = (vec3(9.0, -4.0, -9.0));
	block[2].t.b.b[2][2] = (vec3(-2.0, -9.0, -4.0));
	block[2].t.b.b[3][0] = (vec3(5.0, 2.0, 9.0));
	block[2].t.b.b[3][1] = (vec3(-6.0, -8.0, -5.0));
	block[2].t.b.b[3][2] = (vec3(9.0, 8.0, -8.0));
	block[2].t.b.c = (vec4(2.0, 0.0, 9.0, -4.0));
	block[2].u = (8u);
}
#version 450
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
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(5.0, 1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0, 2.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(5.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-8.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(7u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(0.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(5.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(6u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-2.0, 1.0, -2.0, 2.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 4) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(7.0, 1.0, -6.0, -4.0, -1.0, -9.0, 3.0, 4.0, 5.0, -6.0, -2.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(9u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(2.0, 7.0, 3.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(3u, 9u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(1.0, -7.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(5u, 1u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(6.0, -3.0, -4.0, 7.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -8) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(7.0, 4.0, 2.0, -3.0, -2.0, -2.0, 3.0, -5.0, 2.0, 1.0, -3.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(0u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-3.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(8u, 2u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(2.0, -2.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(0u, 1u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(3.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -4) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-9.0, 0.0, 9.0, -7.0, -1.0, 5.0, 8.0, -3.0, 4.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-7.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(9.0, 6.0, 3.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(8u, 6u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-9.0, -2.0, 7.0, 1.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -4) && allOk;
	allOk = compare_uint((block[1].u), 3u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(2.0, -1.0, -2.0, 4.0, 0.0, -8.0, -4.0, 0.0, 1.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(7u, 9u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-3.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-6.0, 4.0, 5.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(0u, 3u, 0u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(8.0, -5.0, 5.0, -1.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -7) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-2.0, -5.0, 4.0, -4.0, -3.0, 4.0, 4.0, -3.0, -7.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-2.0, 8.0, 2.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(1u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(7.0, -3.0, 0.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(5u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-6.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(6.0, 1.0, -7.0, -8.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(4u, 6u, 4u));
	block[0].s.b[0] = (vec2(-4.0, 1.0));
	block[0].s.b[1] = (vec2(2.0, -2.0));
	block[0].s.b[2] = (vec2(8.0, 7.0));
	block[0].s.b[3] = (vec2(2.0, -4.0));
	block[0].s.c = (vec4(3.0, -4.0, 6.0, 7.0));
	block[0].u = (5u);
	block[1].s.a = (uvec3(4u, 6u, 7u));
	block[1].s.b[0] = (vec2(5.0, 4.0));
	block[1].s.b[1] = (vec2(-9.0, -7.0));
	block[1].s.b[2] = (vec2(-9.0, -2.0));
	block[1].s.b[3] = (vec2(9.0, -6.0));
	block[1].s.c = (vec4(-3.0, 6.0, 3.0, -8.0));
	block[1].u = (9u);
	block[2].s.a = (uvec3(2u, 5u, 4u));
	block[2].s.b[0] = (vec2(-9.0, -5.0));
	block[2].s.b[1] = (vec2(2.0, 4.0));
	block[2].s.b[2] = (vec2(-4.0, 1.0));
	block[2].s.b[3] = (vec2(-2.0, -2.0));
	block[2].s.c = (vec4(4.0, 0.0, -6.0, 6.0));
	block[2].u = (4u);
}
#version 450
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
	highp uvec4 var;
} block[3];

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block[0].var), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block[1].var), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block[2].var), uvec4(3u, 6u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec4(2u, 7u, 2u, 9u));
	block[1].var = (uvec4(7u, 9u, 5u, 1u));
	block[2].var = (uvec4(3u, 4u, 4u, 2u));
}
#version 450
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
	bvec4 var;
} block[3];

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block[0].var), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block[1].var), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block[2].var), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec4(true, true, true, false));
	block[1].var = (bvec4(true, false, false, false));
	block[2].var = (bvec4(false, true, true, true));
}
#version 450
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
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 4.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-3.0, -9.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-7.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(8.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-8.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 3.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-3.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(1.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block[0].var[1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block[0].var[2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block[1].var[0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block[1].var[1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block[1].var[2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block[2].var[0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block[2].var[1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block[2].var[2] = (vec4(7.0, -8.0, -3.0, -2.0));
}
#version 450
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
	highp float var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].var), 7.0) && allOk;
	allOk = compare_float((block[1].var), -1.0) && allOk;
	allOk = compare_float((block[2].var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (-2.0);
	block[1].var = (4.0);
	block[2].var = (6.0);
}
#version 450
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
	highp uvec3 var;
} block[3];

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block[0].var), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block[1].var), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block[2].var), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec3(3u, 5u, 6u));
	block[1].var = (uvec3(5u, 4u, 5u));
	block[2].var = (uvec3(4u, 9u, 4u));
}
#version 450
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
	bvec4 var;
} block[3];

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block[0].var), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block[1].var), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block[2].var), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec4(true, true, true, false));
	block[1].var = (bvec4(true, false, false, false));
	block[2].var = (bvec4(false, true, true, true));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(-7.0, -8.0, 7.0));
	block[0].var[1] = (vec3(-6.0, -3.0, -4.0));
	block[1].var[0] = (vec3(3.0, -8.0, -9.0));
	block[1].var[1] = (vec3(-2.0, 5.0, 6.0));
	block[2].var[0] = (vec3(6.0, -5.0, -7.0));
	block[2].var[1] = (vec3(1.0, 1.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block[0].var, mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block[1].var = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block[2].var = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_mat2(block[0].var, mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_float((block[1].padding), -4.0) && allOk;
	allOk = compare_mat2(block[1].var, mat2(8.0, 0.0, -9.0, 9.0)) && allOk;
	allOk = compare_float((block[2].padding), 7.0) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-2.0, 8.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat2(-8.0, -7.0, 9.0, 2.0));
	block[1].padding = (2.0);
	block[1].var = (mat2(-4.0, -5.0, -1.0, -4.0));
	block[2].padding = (0.0);
	block[2].var = (mat2(-1.0, 0.0, 4.0, -3.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 1.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -2.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(6.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-4.0, 0.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(3.0, 9.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -5.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(9.0, 1.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(3.0, 5.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(8.0, -1.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(8.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][3], 7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-6.0, 5.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-3.0, -4.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-9.0, -4.0, -2.0, -8.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(8.0, -7.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	block[0].var[1] = (vec4(6.0, 1.0, -6.0, 6.0));
	block[0].var[2] = (vec4(0.0, -6.0, 3.0, 3.0));
	block[0].var[3] = (vec4(3.0, -3.0, 2.0, -8.0));
	block[1].padding = (9.0);
	block[1].var[0] = (vec4(-6.0, 6.0, 1.0, 9.0));
	block[1].var[1] = (vec4(-7.0, 4.0, -5.0, 5.0));
	block[1].var[2] = (vec4(-6.0, 5.0, 7.0, 7.0));
	block[1].var[3] = (vec4(-5.0, -9.0, 7.0, -2.0));
	block[2].padding = (-1.0);
	block[2].var[0] = (vec4(-4.0, -3.0, 3.0, -8.0));
	block[2].var[1] = (vec4(7.0, -8.0, -5.0, -9.0));
	block[2].var[2] = (vec4(-1.0, 0.0, -7.0, 7.0));
	block[2].var[3] = (vec4(8.0, -6.0, -6.0, -1.0));
}
#version 450
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
	u8vec3 var;
} block[3];

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(block[0].var), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(block[1].padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(block[1].var), uvec3(3u, 8u, 6u)) && allOk;
	allOk = compare_uint8_t(uint(block[2].padding), 0u) && allOk;
	allOk = compare_u8vec3(uvec3(block[2].var), uvec3(6u, 4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint8_t(4u);
	block[0].var = u8vec3(uvec3(5u, 9u, 6u));
	block[1].padding = uint8_t(9u);
	block[1].var = u8vec3(uvec3(4u, 7u, 1u));
	block[2].padding = uint8_t(5u);
	block[2].var = u8vec3(uvec3(1u, 7u, 9u));
}
#version 450
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
	mediump vec2 a;
	highp int b;
	bool c;
	lowp mat3x4 d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp mat4 e;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp float f;
	highp mat3 g;
	highp uvec2 h;
	highp mat3x4 i;
	highp vec2 j;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	bvec3 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_int((blockB.b), 9) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_mat3x4(blockB.d, mat3x4(-4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0, -9.0, -7.0, 9.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4(e, mat4(6.0, 0.0, -1.0, -3.0, 0.0, -1.0, -7.0, -7.0, 6.0, 9.0, -1.0, -1.0, 6.0, 1.0, 1.0, 7.0)) && allOk;
	allOk = compare_float((blockD.f), 2.0) && allOk;
	allOk = compare_mat3(blockD.g, mat3(-6.0, 8.0, -2.0, 4.0, 0.0, -1.0, 1.0, -8.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(5u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (false);
	blockB.d = (mat3x4(1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0));
	e = (mat4(-1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0, 5.0, 6.0, 5.0, 6.0, -6.0, -9.0));
	blockD.f = (3.0);
	blockD.g = (mat3(-7.0, -4.0, -6.0, -5.0, 3.0, -9.0, -6.0, -3.0, -7.0));
	k = (bvec3(false, false, true));
}
#version 450
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
	lowp mat2 a;
};
layout(std140, binding = 2) readonly buffer BlockC
{
	highp vec3 b[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp mat3 c;
	lowp uint d[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp mat4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockC.b[0]), vec3(2.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec3((blockC.b[1]), vec3(1.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3((blockC.b[2]), vec3(4.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3((blockC.b[3]), vec3(8.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.b[4]), vec3(5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockD.c, mat3(-4.0, -4.0, -3.0, 1.0, 5.0, 6.0, 9.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(9.0, 5.0, 7.0, -2.0));
	blockD.c = (mat3(4.0, -4.0, -4.0, 1.0, -6.0, 2.0, -1.0, 4.0, -4.0));
	e[0] = (mat4(-3.0, 2.0, 0.0, -6.0, -5.0, -6.0, 6.0, -7.0, 0.0, -9.0, -1.0, -1.0, 4.0, -2.0, -5.0, 5.0));
	e[1] = (mat4(3.0, 0.0, 9.0, -5.0, -3.0, 3.0, -7.0, 0.0, -2.0, -2.0, 7.0, -9.0, -8.0, 3.0, 5.0, 5.0));
	e[2] = (mat4(-1.0, 7.0, -1.0, -8.0, 0.0, -8.0, 4.0, -3.0, -4.0, 9.0, -9.0, -8.0, 8.0, 1.0, 2.0, -6.0));
	e[3] = (mat4(8.0, -9.0, 7.0, -1.0, 3.0, -8.0, 3.0, 9.0, 6.0, -4.0, 0.0, -9.0, 3.0, 5.0, 0.0, -7.0));
	e[4] = (mat4(1.0, 0.0, 0.0, -4.0, 5.0, -3.0, 2.0, 1.0, 8.0, -6.0, 2.0, -5.0, 6.0, 2.0, 0.0, -4.0));
	e[5] = (mat4(7.0, -3.0, 3.0, -9.0, 4.0, 8.0, 3.0, -6.0, -5.0, 9.0, -6.0, -9.0, -2.0, -4.0, -9.0, -8.0));
	e[6] = (mat4(6.0, 3.0, -1.0, -7.0, 7.0, -1.0, 0.0, 5.0, 5.0, 2.0, -5.0, -6.0, 6.0, -4.0, -9.0, 5.0));
}
#version 450
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
	highp mat3 mB;
	mediump mat4x3 mC;
};
struct sB
{
	highp vec4 mA;
	lowp mat3 mB;
};
struct sC
{
	lowp mat4x3 mA;
	lowp ivec2 mB;
	bool mC;
};
struct sD
{
	highp mat2x3 mA;
	lowp mat3x4 mB;
	sC mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump mat4x2 a[1];
	highp mat4x2 b[];
};
layout(std140, binding = 2) buffer BlockC
{
	sA c[];
} blockC[2];
layout(std140, row_major, binding = 3) buffer BlockD
{
	sB d;
	sD e;
	highp vec4 f[];
};
layout(std140, binding = 4) buffer BlockE
{
	lowp vec3 g;
	mediump vec2 h;
	bvec2 i;
	lowp ivec4 j;
	lowp vec4 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a[0], mat4x2(2.0, 4.0, -3.0, 6.0, 2.0, -2.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec2((blockC[0].c[0].mA), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC[0].c[0].mB, mat3(-7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].c[0].mC, mat4x3(-6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec2((blockC[1].c[0].mA), vec2(6.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[0].mB, mat3(-8.0, -3.0, -6.0, 1.0, 7.0, 6.0, -5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c[0].mC, mat4x3(9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec4((d.mA), vec4(-1.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(d.mB, mat3(6.0, -7.0, -2.0, -5.0, -1.0, -9.0, -2.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec4((f[0]), vec4(4.0, 7.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockE.g), vec3(1.0, 2.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockE.i), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockE.k[0]), vec4(-7.0, 1.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4x2(8.0, 0.0, 7.0, 5.0, -2.0, 9.0, 6.0, -5.0));
	b[0] = (mat4x2(4.0, 5.0, 7.0, 8.0, -1.0, 6.0, 6.0, 2.0));
	blockC[0].c[0].mA = (vec2(-7.0, -2.0));
	blockC[0].c[0].mB = (mat3(-4.0, -2.0, 4.0, -2.0, 3.0, 0.0, -8.0, 6.0, -7.0));
	blockC[0].c[0].mC = (mat4x3(4.0, 6.0, -2.0, -5.0, 3.0, 0.0, 9.0, -2.0, 3.0, -3.0, 3.0, 2.0));
	blockC[1].c[0].mA = (vec2(2.0, -6.0));
	blockC[1].c[0].mB = (mat3(-8.0, -6.0, 4.0, -7.0, -9.0, 7.0, -3.0, -1.0, -2.0));
	blockC[1].c[0].mC = (mat4x3(-4.0, 3.0, -1.0, 4.0, -2.0, 9.0, -2.0, 8.0, -5.0, -8.0, 9.0, 2.0));
	f[0] = (vec4(0.0, 6.0, -6.0, 0.0));
	blockE.g = (vec3(5.0, -3.0, 3.0));
	blockE.h = (vec2(-2.0, -9.0));
	blockE.i = (bvec2(false, true));
	blockE.j = (ivec4(7, 9, 8, 2));
}
#version 450
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
	lowp mat4x2 mB[1];
	lowp uint mC[1];
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	bool a;
	bvec2 b[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	sA c;
	highp ivec3 d[];
} blockC;
layout(std430, binding = 3) readonly buffer BlockD
{
	mediump uvec2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_bvec2((blockB.b[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[1]), bvec2(true, true)) && allOk;
	allOk = compare_ivec3((blockC.d[0]), ivec3(2, -6, -8)) && allOk;
	allOk = compare_ivec3((blockC.d[1]), ivec3(9, -9, 8)) && allOk;
	allOk = compare_ivec3((blockC.d[2]), ivec3(-6, -5, -9)) && allOk;
	allOk = compare_ivec3((blockC.d[3]), ivec3(-3, -5, 3)) && allOk;
	allOk = compare_ivec3((blockC.d[4]), ivec3(0, 7, 8)) && allOk;
	allOk = compare_ivec3((blockC.d[5]), ivec3(-9, -4, 1)) && allOk;
	allOk = compare_ivec3((blockC.d[6]), ivec3(1, -4, -5)) && allOk;
	allOk = compare_ivec3((blockC.d[7]), ivec3(-1, 2, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0] = (bvec2(true, true));
	blockB.b[1] = (bvec2(true, false));
	blockC.c.mA = (ivec4(5, -3, 4, -8));
	blockC.c.mB[0] = (mat4x2(9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0));
	blockC.c.mC[0] = (8u);
}
#version 450
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
	highp uvec2 mA[8];
	mediump mat4x2 mB[3];
};
struct sB
{
	mediump mat3 mA;
};
struct sC
{
	bvec2 mA[5];
};
struct sD
{
	lowp vec4 mA;
	sB mB[1];
	sC mC;
	mediump mat3 mD;
};
struct sE
{
	mediump mat4x2 mA;
	mediump ivec2 mB;
	bvec2 mC;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	mediump mat3x2 a;
	mediump uint b;
	sA c;
	lowp mat3 d;
	mediump vec4 e;
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp uvec2 f;
	lowp mat3 g;
	sD h;
	sE i[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(6.0, -9.0, 8.0, -4.0, 4.0, 4.0)) && allOk;
	allOk = compare_uint((blockB.b), 0u) && allOk;
	allOk = compare_mat4x2(blockC[0].i[0].mA, mat4x2(-3.0, 7.0, 8.0, -7.0, -4.0, 8.0, -4.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockC[0].i[0].mB), ivec2(3, -3)) && allOk;
	allOk = compare_bvec2((blockC[0].i[0].mC), bvec2(true, true)) && allOk;
	allOk = compare_mat4x2(blockC[0].i[1].mA, mat4x2(-8.0, 2.0, 3.0, -5.0, 7.0, 4.0, -1.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockC[0].i[1].mB), ivec2(-1, 9)) && allOk;
	allOk = compare_bvec2((blockC[0].i[1].mC), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(blockC[0].i[2].mA, mat4x2(7.0, -9.0, 9.0, -1.0, 4.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockC[0].i[2].mB), ivec2(3, -3)) && allOk;
	allOk = compare_bvec2((blockC[0].i[2].mC), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(7.0, -6.0, 7.0, -1.0, 1.0, 9.0));
	blockB.c.mA[0] = (uvec2(9u, 6u));
	blockB.c.mA[1] = (uvec2(8u, 6u));
	blockB.c.mA[2] = (uvec2(7u, 8u));
	blockB.c.mA[3] = (uvec2(8u, 6u));
	blockB.c.mA[4] = (uvec2(3u, 6u));
	blockB.c.mA[5] = (uvec2(9u, 3u));
	blockB.c.mA[6] = (uvec2(5u, 0u));
	blockB.c.mA[7] = (uvec2(3u, 4u));
	blockB.c.mB[0] = (mat4x2(-7.0, 5.0, -3.0, 9.0, -5.0, 9.0, -5.0, 6.0));
	blockB.c.mB[1] = (mat4x2(9.0, -6.0, -5.0, 0.0, 2.0, -5.0, -5.0, 7.0));
	blockB.c.mB[2] = (mat4x2(4.0, 3.0, -1.0, -7.0, -2.0, -2.0, -1.0, 6.0));
	blockB.e = (vec4(-1.0, 3.0, -7.0, 3.0));
	blockC[0].h.mA = (vec4(1.0, 2.0, -6.0, 9.0));
	blockC[0].h.mB[0].mA = (mat3(9.0, -2.0, -9.0, 7.0, 4.0, 0.0, 8.0, 1.0, 3.0));
	blockC[0].h.mC.mA[0] = (bvec2(false, true));
	blockC[0].h.mC.mA[1] = (bvec2(true, true));
	blockC[0].h.mC.mA[2] = (bvec2(true, false));
	blockC[0].h.mC.mA[3] = (bvec2(true, false));
	blockC[0].h.mC.mA[4] = (bvec2(true, true));
	blockC[0].h.mD = (mat3(-3.0, -6.0, 8.0, -9.0, -3.0, 7.0, 5.0, -8.0, 2.0));
	blockC[0].i[0].mA = (mat4x2(8.0, -1.0, 5.0, -7.0, -2.0, 9.0, -7.0, 4.0));
	blockC[0].i[0].mB = (ivec2(-3, -4));
	blockC[0].i[0].mC = (bvec2(false, true));
	blockC[0].i[1].mA = (mat4x2(7.0, 2.0, 3.0, 6.0, -8.0, 9.0, 8.0, -9.0));
	blockC[0].i[1].mB = (ivec2(-3, -4));
	blockC[0].i[1].mC = (bvec2(false, false));
	blockC[0].i[2].mA = (mat4x2(8.0, 8.0, 1.0, -2.0, 4.0, 5.0, 0.0, 9.0));
	blockC[0].i[2].mB = (ivec2(5, -3));
	blockC[0].i[2].mC = (bvec2(false, true));
}
#version 450
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
	lowp int a;
	mediump mat3 b;
	mediump vec2 c[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	lowp mat4x2 d[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	lowp uvec4 e;
	mediump uint f;
	lowp ivec3 g;
	mediump mat3x4 h[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 6) && allOk;
	allOk = compare_mat3(blockB.b, mat3(-3.0, -7.0, -2.0, 6.0, 2.0, -8.0, 1.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.c[0]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.c[1]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.c[2]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.c[3]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[0], mat4x2(7.0, -8.0, 0.0, 5.0, 4.0, -3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[1], mat4x2(-5.0, -9.0, 9.0, -7.0, -7.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[2], mat4x2(5.0, 5.0, 9.0, -4.0, -5.0, 7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[3], mat4x2(-5.0, 4.0, 2.0, 9.0, -8.0, 6.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[4], mat4x2(6.0, 9.0, -8.0, -6.0, 8.0, 7.0, 1.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockD[0].e), uvec4(2u, 9u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6);
	blockB.b = (mat3(9.0, 5.0, -8.0, -9.0, 2.0, -3.0, -1.0, 5.0, 5.0));
	blockB.c[0] = (vec2(-6.0, 3.0));
	blockB.c[1] = (vec2(7.0, 3.0));
	blockB.c[2] = (vec2(-3.0, 2.0));
	blockB.c[3] = (vec2(-9.0, -4.0));
	blockC.d[0] = (mat4x2(8.0, -3.0, -3.0, 5.0, 1.0, 7.0, 9.0, -3.0));
	blockC.d[1] = (mat4x2(7.0, 7.0, -9.0, 8.0, 5.0, 9.0, -4.0, 1.0));
	blockC.d[2] = (mat4x2(6.0, -5.0, -6.0, 2.0, 3.0, -1.0, -3.0, -1.0));
	blockC.d[3] = (mat4x2(7.0, -8.0, 4.0, -1.0, -6.0, 2.0, 7.0, 4.0));
	blockC.d[4] = (mat4x2(-5.0, 3.0, 9.0, 1.0, -4.0, -2.0, 2.0, -6.0));
	blockD[0].e = (uvec4(0u, 9u, 2u, 2u));
	blockD[0].f = (0u);
	blockD[0].g = (ivec3(-8, -7, 6));
	blockD[0].h[0] = (mat3x4(6.0, -1.0, -4.0, -9.0, 9.0, -6.0, -3.0, 7.0, 1.0, -7.0, 3.0, -6.0));
	blockD[0].h[1] = (mat3x4(-9.0, 7.0, -4.0, -1.0, -3.0, -5.0, -8.0, -7.0, 7.0, -1.0, 8.0, -8.0));
	blockD[0].h[2] = (mat3x4(1.0, -3.0, 5.0, -1.0, -4.0, 7.0, 0.0, 6.0, 9.0, -7.0, -3.0, -6.0));
	blockD[0].h[3] = (mat3x4(-9.0, -6.0, 8.0, 3.0, 4.0, -2.0, -9.0, 0.0, 5.0, 0.0, 7.0, -9.0));
	blockD[0].h[4] = (mat3x4(4.0, 7.0, -7.0, 6.0, 0.0, -3.0, 5.0, -1.0, -9.0, -3.0, 5.0, 8.0));
	blockD[0].h[5] = (mat3x4(-4.0, 9.0, 4.0, -5.0, -9.0, 6.0, 5.0, 4.0, -3.0, -4.0, 5.0, 3.0));
	blockD[0].h[6] = (mat3x4(-5.0, -5.0, -2.0, -5.0, -6.0, -9.0, -8.0, 5.0, -1.0, -4.0, -5.0, -5.0));
	blockD[0].h[7] = (mat3x4(-6.0, 0.0, 6.0, -3.0, 9.0, 2.0, 6.0, 7.0, -5.0, 5.0, -9.0, 4.0));
}
#version 450
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
	bvec4 mB;
	highp mat4x2 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	bvec2 b;
	highp vec2 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((c[0]), vec2(-7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (bvec2(true, true));
}
#version 450
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
	lowp uvec4 a[];
} blockB;

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a[0]), uvec4(3u, 9u, 9u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.a[1]), uvec4(2u, 6u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a[2]), uvec4(1u, 8u, 9u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.a[3]), uvec4(9u, 9u, 3u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a[4]), uvec4(1u, 6u, 6u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.a[5]), uvec4(4u, 3u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a[6]), uvec4(7u, 5u, 0u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(9u, 1u, 7u, 1u));
	blockB.a[1] = (uvec4(4u, 6u, 3u, 3u));
	blockB.a[2] = (uvec4(3u, 2u, 8u, 5u));
	blockB.a[3] = (uvec4(4u, 7u, 1u, 1u));
	blockB.a[4] = (uvec4(3u, 8u, 9u, 2u));
	blockB.a[5] = (uvec4(4u, 4u, 9u, 2u));
	blockB.a[6] = (uvec4(1u, 4u, 9u, 6u));
}
#version 450
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
	layout(offset = 16) bvec4 b;
	layout(offset = 32) bool c;
	layout(offset = 36) lowp uint d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(0)].d), 8u) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a), vec2(0.0, -9.0)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].d), 8u) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a), vec2(7.0, 0.0)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(2)].d), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec2(1.0, 1.0));
	blockB[nonuniformEXT(0)].b = (bvec4(true, true, true, false));
	blockB[nonuniformEXT(0)].c = (false);
	blockB[nonuniformEXT(1)].a = (vec2(-6.0, 3.0));
	blockB[nonuniformEXT(1)].b = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(1)].c = (false);
	blockB[nonuniformEXT(2)].a = (vec2(-1.0, -4.0));
	blockB[nonuniformEXT(2)].b = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(2)].c = (false);
}
#version 450
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
	bvec4 a;
	bool b;
	highp vec2 c[1];
	mediump mat4x3 d;
	lowp vec2 e;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp ivec2 f;
	lowp mat2x3 g;
	lowp uvec3 h;
	f16vec4 i[1];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((c[0]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0, 1.0, -1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec2((e), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(1, -6)) && allOk;
	allOk = compare_mat2x3(blockC.g, mat2x3(-7.0, 2.0, 8.0, -2.0, 8.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockC.h), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.i[0]), vec4(3.0, -6.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (false);
	e = (vec2(-4.0, 0.0));
	blockC.f = (ivec2(-4, 2));
	blockC.h = (uvec3(0u, 4u, 1u));
	blockC.i[0] = f16vec4(vec4(2.0, 0.0, 0.0, 2.0));
}
#version 450
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
	mediump mat4x3 a;
};
layout(std140, binding = 2) buffer BlockC
{
	float16_t b;
	lowp vec2 c;
	highp mat2 d;
	highp ivec4 e;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	lowp vec2 f;
	highp mat3x4 g;
	f16vec2 h[3];
	highp mat4x2 i;
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	highp int j;
	f16vec2 k;
	bvec3 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(a, mat4x3(-7.0, 8.0, 8.0, 2.0, 4.0, 0.0, -2.0, 6.0, -1.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_float16_t(float(b), -2.0) && allOk;
	allOk = compare_mat2(d, mat2(0.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec2((blockD.f), vec2(2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD.g, mat3x4(-7.0, -2.0, 9.0, 8.0, 9.0, 0.0, -5.0, 2.0, 3.0, 8.0, 7.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockE.l[0]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x3(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0));
	d = (mat2(9.0, 5.0, -6.0, -1.0));
	blockD.f = (vec2(-5.0, 3.0));
	blockD.g = (mat3x4(5.0, -5.0, -2.0, -2.0, 8.0, -3.0, -3.0, -8.0, 1.0, -3.0, -1.0, 3.0));
	blockD.h[0] = f16vec2(vec2(7.0, -4.0));
	blockD.h[1] = f16vec2(vec2(-5.0, -1.0));
	blockD.h[2] = f16vec2(vec2(-3.0, 1.0));
	blockD.i = (mat4x2(-9.0, 8.0, 9.0, -8.0, -8.0, 3.0, -3.0, 0.0));
	blockE.k = f16vec2(vec2(6.0, 1.0));
	blockE.l[0] = (bvec3(false, false, false));
}
#version 450
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
	highp mat3 a;
	mediump mat3 b;
	highp mat4x2 c;
	mediump mat2 d;
	mediump ivec4 e;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	u16vec4 f;
	highp ivec3 g[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	u16vec4 h;
	bvec3 i;
	float16_t j;
	lowp mat2 k;
	highp vec3 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(1.0, -5.0, 1.0, -5.0, 1.0, 2.0, -9.0, -7.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockB.e), ivec4(-3, 3, 1, -9)) && allOk;
	allOk = compare_ivec3((blockC.g[0]), ivec3(-3, 3, 1)) && allOk;
	allOk = compare_ivec3((blockC.g[1]), ivec3(1, -9, -3)) && allOk;
	allOk = compare_ivec3((blockC.g[2]), ivec3(-9, -7, -4)) && allOk;
	allOk = compare_ivec3((blockC.g[3]), ivec3(-4, -6, 1)) && allOk;
	allOk = compare_ivec3((blockC.g[4]), ivec3(3, -4, -4)) && allOk;
	allOk = compare_u16vec4(uvec4(h), uvec4(0u, 4u, 6u, 7u)) && allOk;
	allOk = compare_bvec3((i), bvec3(false, false, true)) && allOk;
	allOk = compare_float16_t(float(j), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3(5.0, 7.0, 8.0, 3.0, 8.0, 8.0, 4.0, 3.0, 0.0));
	blockB.c = (mat4x2(8.0, 7.0, -6.0, -1.0, 5.0, -9.0, 1.0, -2.0));
	blockC.f = u16vec4(uvec4(6u, 2u, 3u, 4u));
	blockC.g[0] = (ivec3(8, -9, -8));
	blockC.g[1] = (ivec3(4, 8, 5));
	blockC.g[2] = (ivec3(3, 5, -4));
	blockC.g[3] = (ivec3(8, 8, 0));
	blockC.g[4] = (ivec3(-8, 1, -8));
	h = u16vec4(uvec4(8u, 0u, 5u, 3u));
	i = (bvec3(true, true, true));
	j = float16_t(-4.0);
	k = (mat2(-7.0, 7.0, 6.0, 9.0));
}
#version 450
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
	highp mat3 mA;
};
struct sB
{
	mediump uvec2 mA;
	bvec2 mB;
};
struct sC
{
	sA mA;
	bool mB;
	sB mC;
};
struct sD
{
	int16_t mA;
	mediump ivec2 mB;
	uint16_t mC;
};
layout(std140, binding = 1) buffer BlockB
{
	bvec4 a;
	uint16_t b;
	sC c;
};
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	lowp mat2 d;
	sD e;
	lowp uint f[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat2x3 g;
	highp mat3x2 h;
	highp vec3 i[];
};
layout(std430, binding = 4) buffer BlockE
{
	lowp vec4 j;
	u16vec3 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(c.mA.mA, mat3(1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0)) && allOk;
	allOk = compare_bool((c.mB), true) && allOk;
	allOk = compare_uvec2((c.mC.mA), uvec2(1u, 2u)) && allOk;
	allOk = compare_bvec2((c.mC.mB), bvec2(false, false)) && allOk;
	allOk = compare_int16_t(int(blockC.e.mA), 1) && allOk;
	allOk = compare_ivec2((blockC.e.mB), ivec2(-6, 8)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e.mC), 8u) && allOk;
	allOk = compare_uint((blockC.f[0]), 2u) && allOk;
	allOk = compare_uint((blockC.f[1]), 3u) && allOk;
	allOk = compare_uint((blockC.f[2]), 4u) && allOk;
	allOk = compare_uint((blockC.f[3]), 2u) && allOk;
	allOk = compare_mat2x3(g, mat2x3(-9.0, 7.0, -2.0, 2.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(h, mat3x2(3.0, 1.0, 1.0, -9.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = uint16_t(9u);
	c.mA.mA = (mat3(0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0));
	c.mB = (true);
	c.mC.mA = (uvec2(7u, 5u));
	c.mC.mB = (bvec2(false, true));
	g = (mat2x3(-6.0, 1.0, 8.0, 8.0, -9.0, -8.0));
	h = (mat3x2(4.0, 8.0, 5.0, 3.0, 5.0, -4.0));
	k[0] = u16vec3(uvec3(6u, 7u, 7u));
	k[1] = u16vec3(uvec3(1u, 0u, 5u));
	k[2] = u16vec3(uvec3(5u, 3u, 8u));
	k[3] = u16vec3(uvec3(3u, 6u, 9u));
	k[4] = u16vec3(uvec3(1u, 9u, 1u));
	k[5] = u16vec3(uvec3(5u, 9u, 3u));
	k[6] = u16vec3(uvec3(9u, 0u, 6u));
	k[7] = u16vec3(uvec3(7u, 8u, 0u));
}
#version 450
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
	u16vec3 a;
	i16vec3 b[];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(a), uvec3(5u, 7u, 3u)) && allOk;
	allOk = compare_i16vec3(ivec3(b[0]), ivec3(-9, 9, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(b[1]), ivec3(7, 7, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(b[2]), ivec3(5, -7, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(b[3]), ivec3(-2, -1, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(b[4]), ivec3(2, -4, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(b[5]), ivec3(7, -1, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp uvec3 mA;
};
struct sB
{
	sA mA;
	mediump uvec3 mB;
	lowp uvec3 mC;
	u16vec2 mD[4];
};
struct sC
{
	highp uvec2 mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	i16vec3 a;
	highp ivec2 b;
	f16vec4 c;
	f16vec2 d;
	sB e[];
} blockB;
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	u16vec2 f[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp mat2 g;
	bvec2 h;
	sC i;
	bool j[];
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	bool k;
	bvec3 l[6];
	int16_t m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.d), vec2(7.0, 0.0)) && allOk;
	allOk = compare_mat2(blockD.g, mat2(4.0, -6.0, -3.0, 4.0)) && allOk;
	allOk = compare_uvec2((blockD.i.mA), uvec2(5u, 7u)) && allOk;
	allOk = compare_bool((blockD.j[0]), true) && allOk;
	allOk = compare_bool((blockD.j[1]), false) && allOk;
	allOk = compare_bool((blockD.j[2]), false) && allOk;
	allOk = compare_bool((blockD.j[3]), false) && allOk;
	allOk = compare_bool((blockD.j[4]), false) && allOk;
	allOk = compare_bool((blockD.j[5]), false) && allOk;
	allOk = compare_bool((blockE.k), true) && allOk;
	allOk = compare_int16_t(int(blockE.m[0]), 5) && allOk;
	allOk = compare_int16_t(int(blockE.m[1]), 0) && allOk;
	allOk = compare_int16_t(int(blockE.m[2]), -1) && allOk;
	allOk = compare_int16_t(int(blockE.m[3]), -8) && allOk;
	allOk = compare_int16_t(int(blockE.m[4]), -3) && allOk;
	allOk = compare_int16_t(int(blockE.m[5]), 6) && allOk;
	allOk = compare_int16_t(int(blockE.m[6]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(5, 6, 1));
	blockB.b = (ivec2(-5, 7));
	blockB.d = f16vec2(vec2(5.0, -5.0));
	blockB.e[0].mA.mA = (uvec3(6u, 3u, 8u));
	blockB.e[0].mB = (uvec3(5u, 4u, 5u));
	blockB.e[0].mC = (uvec3(8u, 5u, 7u));
	blockB.e[0].mD[0] = u16vec2(uvec2(1u, 9u));
	blockB.e[0].mD[1] = u16vec2(uvec2(7u, 9u));
	blockB.e[0].mD[2] = u16vec2(uvec2(1u, 0u));
	blockB.e[0].mD[3] = u16vec2(uvec2(6u, 0u));
	blockB.e[1].mA.mA = (uvec3(8u, 2u, 1u));
	blockB.e[1].mB = (uvec3(3u, 0u, 7u));
	blockB.e[1].mC = (uvec3(9u, 7u, 5u));
	blockB.e[1].mD[0] = u16vec2(uvec2(6u, 5u));
	blockB.e[1].mD[1] = u16vec2(uvec2(6u, 9u));
	blockB.e[1].mD[2] = u16vec2(uvec2(1u, 7u));
	blockB.e[1].mD[3] = u16vec2(uvec2(1u, 9u));
	blockB.e[2].mA.mA = (uvec3(9u, 6u, 6u));
	blockB.e[2].mB = (uvec3(1u, 1u, 2u));
	blockB.e[2].mC = (uvec3(1u, 8u, 0u));
	blockB.e[2].mD[0] = u16vec2(uvec2(0u, 1u));
	blockB.e[2].mD[1] = u16vec2(uvec2(4u, 1u));
	blockB.e[2].mD[2] = u16vec2(uvec2(2u, 6u));
	blockB.e[2].mD[3] = u16vec2(uvec2(9u, 6u));
	blockD.j[0] = (false);
	blockD.j[1] = (false);
	blockD.j[2] = (true);
	blockD.j[3] = (true);
	blockD.j[4] = (true);
	blockD.j[5] = (true);
	blockE.k = (false);
	blockE.m[0] = int16_t(0);
	blockE.m[1] = int16_t(-4);
	blockE.m[2] = int16_t(-8);
	blockE.m[3] = int16_t(-2);
	blockE.m[4] = int16_t(-4);
	blockE.m[5] = int16_t(5);
	blockE.m[6] = int16_t(1);
}
#version 450
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
	layout(offset = 0) bvec3 a;
	layout(offset = 16) highp ivec2 b;
	layout(offset = 24) lowp uvec2 c;
	layout(offset = 32) uint16_t d;
	layout(offset = 40) highp uvec2 e[1];
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec2 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 g;
	layout(offset = 16) bvec3 h;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec3 i;
	layout(offset = 16) mediump uvec2 j;
	layout(offset = 32) mediump uvec3 k;
	layout(offset = 44) i16vec2 l;
	layout(offset = 48) i16vec3 m;
} blockE;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].b), ivec2(8, 6)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].d), 0u) && allOk;
	allOk = compare_uvec2((blockB[0].e[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-8, -7)) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].d), 5u) && allOk;
	allOk = compare_uvec2((blockB[1].e[0]), uvec2(0u, 9u)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(false, true, true)) && allOk;
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
	blockC.f = i16vec2(ivec2(6, -8));
	blockD.g = (bvec2(true, true));
	blockD.h = (bvec3(false, false, false));
	blockE.i = (bvec3(true, true, false));
	blockE.j = (uvec2(4u, 9u));
	blockE.k = (uvec3(8u, 8u, 1u));
	blockE.l = i16vec2(ivec2(8, 7));
	blockE.m = i16vec3(ivec3(2, 9, 7));
}
#version 450
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
	f16vec4 a;
	u16vec4 b[7];
	u16vec2 c;
	mediump ivec2 d;
	mediump mat4x3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(b[0]), uvec4(3u, 3u, 5u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(b[1]), uvec4(3u, 8u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(b[2]), uvec4(1u, 7u, 1u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(b[3]), uvec4(9u, 2u, 1u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(b[4]), uvec4(9u, 6u, 1u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(b[5]), uvec4(4u, 4u, 8u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(b[6]), uvec4(1u, 4u, 6u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(c), uvec2(3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec4(vec4(9.0, -2.0, -3.0, -7.0));
	b[0] = u16vec4(uvec4(0u, 7u, 4u, 1u));
	b[1] = u16vec4(uvec4(7u, 5u, 0u, 0u));
	b[2] = u16vec4(uvec4(6u, 2u, 6u, 3u));
	b[3] = u16vec4(uvec4(7u, 5u, 0u, 9u));
	b[4] = u16vec4(uvec4(5u, 7u, 8u, 3u));
	b[5] = u16vec4(uvec4(2u, 2u, 8u, 3u));
	b[6] = u16vec4(uvec4(3u, 9u, 3u, 4u));
}
#version 450
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
	highp mat2 a;
	highp mat4x2 b[1];
	bvec3 c;
	i16vec3 d[4];
	mediump mat4 e[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump uvec4 f;
	mediump vec4 g[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	highp mat2x3 h;
	lowp float i;
	u16vec3 j;
	mediump float k;
	mediump mat4x2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(-2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(b[0], mat4x2(-3.0, -2.0, 2.0, 8.0, 9.0, -4.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(e[0], mat4(-7.0, 9.0, 3.0, 0.0, -6.0, -7.0, 0.0, 8.0, 5.0, -2.0, 9.0, 9.0, -8.0, -3.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(e[1], mat4(5.0, 4.0, -4.0, 2.0, -2.0, 5.0, -3.0, 3.0, 7.0, -2.0, -1.0, -1.0, 5.0, -5.0, -4.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(9u, 6u, 2u, 4u)) && allOk;
	allOk = compare_mat2x3(h, mat2x3(-1.0, 9.0, 9.0, -1.0, 8.0, 4.0)) && allOk;
	allOk = compare_float((i), 0.0) && allOk;
	allOk = compare_mat4x2(l[0], mat4x2(-1.0, 2.0, -3.0, 6.0, -9.0, -2.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(l[1], mat4x2(5.0, -9.0, 5.0, -6.0, 2.0, -8.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(l[2], mat4x2(-4.0, -1.0, 0.0, -8.0, -1.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(l[3], mat4x2(-7.0, 4.0, 9.0, -3.0, 3.0, -8.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(l[4], mat4x2(0.0, -7.0, 6.0, 6.0, 8.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(l[5], mat4x2(-5.0, -3.0, 8.0, 7.0, 7.0, 4.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(-5.0, -1.0, 6.0, 1.0));
	b[0] = (mat4x2(-5.0, -5.0, -8.0, -7.0, -6.0, -6.0, 5.0, 6.0));
	e[0] = (mat4(0.0, 1.0, 7.0, 3.0, 0.0, -6.0, 1.0, 6.0, -7.0, -1.0, 1.0, -9.0, -6.0, -4.0, -6.0, 5.0));
	e[1] = (mat4(6.0, -3.0, 7.0, 3.0, -1.0, 1.0, 1.0, 7.0, -9.0, -7.0, -1.0, -4.0, -2.0, -5.0, -8.0, -1.0));
	blockC.f = (uvec4(8u, 2u, 9u, 7u));
	h = (mat2x3(0.0, -7.0, 7.0, -3.0, -3.0, 0.0));
	j = u16vec3(uvec3(1u, 8u, 9u));
	k = (0.0);
	l[0] = (mat4x2(8.0, 3.0, 4.0, 7.0, -4.0, -8.0, -1.0, -9.0));
	l[1] = (mat4x2(6.0, 6.0, 7.0, 8.0, 4.0, -6.0, -8.0, 9.0));
	l[2] = (mat4x2(-9.0, 8.0, -5.0, -5.0, -2.0, 5.0, -6.0, 5.0));
	l[3] = (mat4x2(5.0, 0.0, -9.0, -6.0, 7.0, 3.0, 2.0, 7.0));
	l[4] = (mat4x2(-7.0, -9.0, -5.0, 6.0, -6.0, -9.0, -5.0, -9.0));
	l[5] = (mat4x2(1.0, -2.0, -3.0, -2.0, -9.0, -1.0, -6.0, 6.0));
}
#version 450
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
	mediump mat2x3 a;
	mediump ivec3 b;
	i8vec4 c[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp vec3 d;
	mediump mat3 e;
	lowp mat2 f[7];
	mediump uvec2 g;
	lowp mat3 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b), ivec3(6, 3, 2)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(-8.0, -6.0, 5.0, -1.0, -5.0, -3.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(-4.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC.f[1], mat2(0.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.f[2], mat2(1.0, -8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.f[3], mat2(0.0, -2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2(blockC.f[4], mat2(-6.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC.f[5], mat2(4.0, -7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC.f[6], mat2(-3.0, -1.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec3(-7, 9, -9));
	c[0] = i8vec4(ivec4(8, 0, 4294967288, 4294967287));
	c[1] = i8vec4(ivec4(5, 4, 4294967294, 4294967291));
	blockC.d = (vec3(5.0, -6.0, 3.0));
	blockC.e = (mat3(-5.0, 0.0, -9.0, 3.0, -9.0, -1.0, 6.0, 2.0, 7.0));
	blockC.f[0] = (mat2(-1.0, -6.0, 3.0, 1.0));
	blockC.f[1] = (mat2(-4.0, -9.0, 8.0, -7.0));
	blockC.f[2] = (mat2(3.0, -9.0, 3.0, 5.0));
	blockC.f[3] = (mat2(-9.0, 9.0, -5.0, -2.0));
	blockC.f[4] = (mat2(-2.0, -6.0, 4.0, 9.0));
	blockC.f[5] = (mat2(-2.0, -6.0, 3.0, 6.0));
	blockC.f[6] = (mat2(8.0, -7.0, 5.0, 6.0));
	blockC.g = (uvec2(2u, 2u));
}
#version 450
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
	highp mat4 mA[3][1];
	mediump ivec4 mB;
	mediump vec2 mC[2];
	highp vec2 mD[3];
};
layout(std140, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	lowp ivec4 b;
	sA c;
	u8vec2 d;
	lowp mat3x4 e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bool f;
	uint8_t g[6];
	highp int h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b), ivec4(2, -9, 4, 5)) && allOk;
	allOk = compare_u8vec2(uvec2(d), uvec2(3u, 9u)) && allOk;
	allOk = compare_uint8_t(uint(g[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(g[1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(g[2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(g[3]), 3u) && allOk;
	allOk = compare_uint8_t(uint(g[4]), 4u) && allOk;
	allOk = compare_uint8_t(uint(g[5]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(0.0, -7.0, 3.0, 9.0, -1.0, 3.0));
	b = (ivec4(-7, -7, 6, 0));
	c.mA[0][0] = (mat4(6.0, -9.0, -2.0, -5.0, -3.0, -5.0, -1.0, 9.0, 3.0, -2.0, -6.0, -4.0, -4.0, 8.0, -4.0, -8.0));
	c.mA[1][0] = (mat4(9.0, 2.0, -7.0, -3.0, 6.0, 3.0, 2.0, 3.0, 6.0, 8.0, 5.0, -5.0, -8.0, -3.0, -8.0, 6.0));
	c.mA[2][0] = (mat4(-1.0, -5.0, -7.0, 0.0, 5.0, -9.0, -3.0, -1.0, 0.0, -3.0, 0.0, -4.0, -8.0, -2.0, 2.0, -6.0));
	c.mB = (ivec4(3, -6, 8, -7));
	c.mC[0] = (vec2(4.0, -3.0));
	c.mC[1] = (vec2(2.0, 0.0));
	c.mD[0] = (vec2(0.0, -3.0));
	c.mD[1] = (vec2(0.0, -2.0));
	c.mD[2] = (vec2(3.0, 6.0));
	e[0] = (mat3x4(0.0, -6.0, -7.0, -4.0, 3.0, -4.0, -4.0, 5.0, -6.0, 0.0, 0.0, 9.0));
	e[1] = (mat3x4(-2.0, -3.0, 1.0, -9.0, -6.0, -8.0, 9.0, -4.0, 0.0, 6.0, 4.0, 7.0));
	e[2] = (mat3x4(-5.0, 9.0, 1.0, 5.0, -2.0, -4.0, 9.0, 7.0, 3.0, 8.0, 7.0, 7.0));
	e[3] = (mat3x4(3.0, 9.0, 8.0, 7.0, 0.0, 6.0, 5.0, -7.0, 6.0, 1.0, -5.0, -8.0));
	e[4] = (mat3x4(6.0, -5.0, -1.0, -2.0, 0.0, 5.0, 2.0, -9.0, 5.0, 7.0, -4.0, -5.0));
	g[0] = uint8_t(8u);
	g[1] = uint8_t(6u);
	g[2] = uint8_t(5u);
	g[3] = uint8_t(9u);
	g[4] = uint8_t(3u);
	g[5] = uint8_t(7u);
	h[0] = (1);
	h[1] = (-2);
	h[2] = (9);
	h[3] = (-4);
	h[4] = (-7);
	h[5] = (-7);
	h[6] = (-1);
	h[7] = (4);
}
#version 450
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
	layout(offset = 0) highp vec4 a[1];
	layout(offset = 16) mediump vec4 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uint c;
	layout(offset = 16) bvec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((b), vec4(-9.0, -8.0, -7.0, -5.0)) && allOk;
	allOk = compare_uint((c), 1u) && allOk;
	allOk = compare_bvec4((d), bvec4(false, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec4(9.0, 9.0, 3.0, 8.0));
	b = (vec4(-7.0, -9.0, -8.0, -2.0));
	d = (bvec4(false, true, false, false));
}
#version 450
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
	bool b;
	highp ivec2 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].c), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].c), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].c), ivec2(-4, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x4(-1.0, -9.0, 7.0, 2.0, -2.0, -6.0, -6.0, 1.0, 8.0, 0.0, 5.0, -1.0));
	blockB[nonuniformEXT(1)].a = (mat3x4(-5.0, 9.0, -1.0, 2.0, 1.0, 1.0, -7.0, -2.0, -3.0, 8.0, 2.0, 9.0));
	blockB[nonuniformEXT(2)].a = (mat3x4(8.0, -4.0, 4.0, 9.0, 9.0, -8.0, -7.0, 3.0, 6.0, 7.0, 4.0, -7.0));
}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
{
	mediump ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(-1, -2, -7, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2(var, mat2(3.0, 2.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], 7.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, -4.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(8.0, -4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_vec3((var), vec3(0.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4(var, mat4(-7.0, -7.0, -8.0, -2.0, 6.0, -6.0, 5.0, -8.0, -5.0, -8.0, -4.0, 4.0, -4.0, 4.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, 4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
{
	highp uvec4 var[];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[3]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((var[4]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((var[5]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[6]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((var[7]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((var[8]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[9]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[10]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[11]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((var[12]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((var[13]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[14]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((var[15]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((var[16]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((var[17]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((var[18]), uvec4(9u, 6u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[0][3], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_float(block.var[2][3], 9.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_float(block.var[3][2], 0.0) && allOk;
	allOk = compare_float(block.var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, -5.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(7.0, -5.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(1.0, -3.0, -8.0, 1.0, 3.0, -4.0, -4.0, -4.0, -6.0, -6.0, 9.0, 1.0, 1.0, 3.0, 2.0, -6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-1.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(6.0, -6.0));
	block.var[1] = (vec2(6.0, 5.0));
	block.var[2] = (vec2(9.0, -1.0));
}
#version 450
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
	i16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block.var), ivec4(-6, -9, 9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i16vec4(ivec4(-4, -8, -4, 9));
}
#version 450
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
	mediump vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var), vec2(7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec2(-7.0, 3.0));
}
#version 450
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
	mediump int var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (2);
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(8.0, -8.0, -2.0, -6.0, -3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(6.0, -8.0, -6.0, -7.0, 1.0, -5.0, 8.0, 0.0, 5.0, 6.0, 6.0, 8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 7.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][0], -6.0) && allOk;
	allOk = compare_float(block.var[3][1], 9.0) && allOk;
	allOk = compare_float(block.var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(4.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-6.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(1.0, -9.0, 9.0, 1.0, -8.0, -4.0, -5.0, -7.0, -2.0, -5.0, 4.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(8.0, -4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-9.0, 2.0, -2.0));
	block.var[1] = (vec3(0.0, -7.0, 0.0));
	block.var[2] = (vec3(1.0, -1.0, 6.0));
	block.var[3] = (vec3(-7.0, 7.0, 9.0));
}
#version 450
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
	bvec2 var;
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
	allOk = compare_bvec2((block.var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var = (bvec2(false, true));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], 4.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][3], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], 5.0) && allOk;
	allOk = compare_float(block.var[3][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][2], 1.0) && allOk;
	allOk = compare_float(block.var[3][3], 6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(7.0, -1.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, -4.0, -3.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, -1.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(5.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec4(6.0, -8.0, 9.0, -8.0));
	block.var[1] = (vec4(4.0, -8.0, 7.0, 9.0));
	block.var[2] = (vec4(-7.0, -2.0, -7.0, 0.0));
	block.var[3] = (vec4(-7.0, 7.0, -8.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], 2.0) && allOk;
	allOk = compare_float(block.var[0][3], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-9.0, -5.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat2x4(9.0, 8.0, 6.0, 6.0, 7.0, -3.0, 2.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(5.0, 9.0, -2.0, -3.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0] = (vec2(9.0, -8.0));
	block.var[1] = (vec2(2.0, 3.0));
	block.var[2] = (vec2(6.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(9.0, 7.0, 1.0, -5.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (vec2(7.0, 5.0));
	block.var[1] = (vec2(7.0, 4.0));
	block.var[2] = (vec2(8.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-6.0, 5.0, -1.0, -8.0, 2.0, -8.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec2(-6.0, 6.0));
	block.var[1] = (vec2(8.0, -4.0));
	block.var[2] = (vec2(3.0, 6.0));
	block.var[3] = (vec2(7.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec2(0.0, -6.0));
	block.var[1] = (vec2(-8.0, -6.0));
	block.var[2] = (vec2(-7.0, -7.0));
	block.var[3] = (vec2(1.0, 5.0));
}
#version 450
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
	highp vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_vec3((block.var[0]), vec3(9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((block.var[1]), vec3(5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[2]), vec3(-1.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0] = (vec3(4.0, 7.0, 8.0));
	block.var[1] = (vec3(-2.0, 7.0, -5.0));
	block.var[2] = (vec3(-7.0, 9.0, 6.0));
}
#version 450
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
	highp float var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var[0]), 7.0) && allOk;
	allOk = compare_float((block.var[1]), -1.0) && allOk;
	allOk = compare_float((block.var[2]), -6.0) && allOk;
	allOk = compare_float((block.var[3]), 0.0) && allOk;
	allOk = compare_float((block.var[4]), -7.0) && allOk;
	allOk = compare_float((block.var[5]), 5.0) && allOk;
	allOk = compare_float((block.var[6]), 4.0) && allOk;
	allOk = compare_float((block.var[7]), 2.0) && allOk;
	allOk = compare_float((block.var[8]), -1.0) && allOk;
	allOk = compare_float((block.var[9]), -6.0) && allOk;
	allOk = compare_float((block.var[10]), -2.0) && allOk;
	allOk = compare_float((block.var[11]), -1.0) && allOk;
	allOk = compare_float((block.var[12]), 1.0) && allOk;
	allOk = compare_float((block.var[13]), -3.0) && allOk;
	allOk = compare_float((block.var[14]), -7.0) && allOk;
	allOk = compare_float((block.var[15]), 8.0) && allOk;
	allOk = compare_float((block.var[16]), -9.0) && allOk;
	allOk = compare_float((block.var[17]), -4.0) && allOk;
	allOk = compare_float((block.var[18]), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (-2.0);
	block.var[1] = (4.0);
	block.var[2] = (6.0);
	block.var[3] = (7.0);
	block.var[4] = (-4.0);
	block.var[5] = (5.0);
	block.var[6] = (-8.0);
	block.var[7] = (9.0);
	block.var[8] = (-5.0);
	block.var[9] = (8.0);
	block.var[10] = (-5.0);
	block.var[11] = (6.0);
	block.var[12] = (-6.0);
	block.var[13] = (-9.0);
	block.var[14] = (-4.0);
	block.var[15] = (3.0);
	block.var[16] = (7.0);
	block.var[17] = (6.0);
	block.var[18] = (5.0);
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[3] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[4] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[5] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[6] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[7] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[8] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[9] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[10] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[11] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[12] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[13] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[14] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[15] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[16] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[17] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[18] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[3] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[4] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[5] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[6] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[7] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[8] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[9] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[10] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[11] = (mat2(6.0, 0.0, 1.0, 8.0));
	block.var[12] = (mat2(1.0, -2.0, -9.0, -7.0));
	block.var[13] = (mat2(2.0, 7.0, 5.0, -3.0));
	block.var[14] = (mat2(-2.0, -3.0, 3.0, -1.0));
	block.var[15] = (mat2(-2.0, -8.0, 1.0, -1.0));
	block.var[16] = (mat2(9.0, -2.0, -3.0, 6.0));
	block.var[17] = (mat2(2.0, 6.0, -4.0, -6.0));
	block.var[18] = (mat2(5.0, -6.0, 1.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block.var[0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block.var[1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block.var[2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[3][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	block.var[3][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[3][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[3][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[4][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	block.var[4][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[4][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[4][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[5][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	block.var[5][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[5][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[5][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[6][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	block.var[6][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[6][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[6][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[7][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	block.var[7][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[7][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[7][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[8][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	block.var[8][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[8][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[8][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[9][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	block.var[9][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[9][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[9][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[10][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	block.var[10][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[10][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[10][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[11][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	block.var[11][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[11][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[11][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	block.var[12][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	block.var[12][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	block.var[12][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	block.var[12][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	block.var[13][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	block.var[13][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	block.var[13][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	block.var[13][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	block.var[14][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	block.var[14][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	block.var[14][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	block.var[14][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	block.var[15][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	block.var[15][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	block.var[15][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	block.var[15][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	block.var[16][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	block.var[16][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	block.var[16][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	block.var[16][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	block.var[17][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	block.var[17][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	block.var[17][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	block.var[17][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	block.var[18][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	block.var[18][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	block.var[18][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	block.var[18][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[3] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[4] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[5] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[6] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[7] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[8] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[9] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[10] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[11] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	block.var[12] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	block.var[13] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	block.var[14] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	block.var[15] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	block.var[16] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	block.var[17] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	block.var[18] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
}
#version 450
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
	highp uvec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[1][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[2][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[3][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[3][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (uvec2(6u, 1u));
	block.var[0][1] = (uvec2(8u, 1u));
	block.var[0][2] = (uvec2(7u, 4u));
	block.var[1][0] = (uvec2(6u, 6u));
	block.var[1][1] = (uvec2(5u, 8u));
	block.var[1][2] = (uvec2(4u, 7u));
	block.var[2][0] = (uvec2(8u, 4u));
	block.var[2][1] = (uvec2(6u, 3u));
	block.var[2][2] = (uvec2(6u, 0u));
	block.var[3][0] = (uvec2(3u, 5u));
	block.var[3][1] = (uvec2(2u, 4u));
	block.var[3][2] = (uvec2(7u, 8u));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[0][2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[1][0] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[1][1] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[1][2] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[2][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[2][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[2][2] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[3][0] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[3][1] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[3][2] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[0][2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[0][2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[1][0][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[1][0][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][1][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[1][1][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[1][1][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[1][2][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[1][2][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[1][2][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[2][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[2][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[2][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[2][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[2][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[2][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[2][2][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[2][2][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[2][2][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[3][0][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[3][0][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[3][0][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[3][1][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[3][1][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[3][1][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[3][2][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[3][2][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[3][2][2] = (vec4(3.0, 9.0, 2.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(3.0, 1.0, 4.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-5.0, -8.0, -7.0, 1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(6.0, -5.0, 3.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(2.0, 6.0, 8.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-2.0, -4.0, -2.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(8.0, -4.0, -5.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(6.0, -9.0, -2.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-3.0, 6.0, 3.0, 2.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-2.0, -3.0, -1.0, -4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(2.0, -1.0, -4.0, 5.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-7.0, 7.0, 0.0, 7.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0] = (mat2x3(-2.0, -5.0, 0.0, 7.0, -2.0, 0.0));
	block.var[0][1] = (mat2x3(9.0, 9.0, 8.0, -6.0, 3.0, -9.0));
	block.var[0][2] = (mat2x3(0.0, 1.0, 1.0, 7.0, -8.0, 7.0));
	block.var[1][0] = (mat2x3(-4.0, 4.0, -5.0, -1.0, 0.0, 2.0));
	block.var[1][1] = (mat2x3(-5.0, 6.0, 7.0, -2.0, 4.0, -3.0));
	block.var[1][2] = (mat2x3(7.0, 6.0, -3.0, -2.0, -6.0, 7.0));
	block.var[2][0] = (mat2x3(-3.0, 2.0, 8.0, -1.0, 2.0, 2.0));
	block.var[2][1] = (mat2x3(-9.0, 3.0, 1.0, -7.0, -7.0, 3.0));
	block.var[2][2] = (mat2x3(-3.0, -5.0, 4.0, -6.0, 8.0, 7.0));
	block.var[3][0] = (mat2x3(-9.0, 2.0, -8.0, 9.0, 9.0, 3.0));
	block.var[3][1] = (mat2x3(5.0, 8.0, 5.0, -7.0, 6.0, 3.0));
	block.var[3][2] = (mat2x3(6.0, 6.0, 1.0, 2.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[0][0][2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	block.var[0][1][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	block.var[0][1][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	block.var[0][1][2] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	block.var[1][0][0] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	block.var[1][0][1] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	block.var[1][0][2] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	block.var[1][1][0] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	block.var[1][1][1] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	block.var[1][1][2] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	block.var[2][0][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	block.var[2][0][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	block.var[2][0][2] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	block.var[2][1][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	block.var[2][1][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	block.var[2][1][2] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	block.var[3][0][0] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	block.var[3][0][1] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	block.var[3][0][2] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	block.var[3][1][0] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	block.var[3][1][1] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	block.var[3][1][2] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	i8vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0][0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0][2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][0]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][1]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][2]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][0]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][1]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][0]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][1]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][2]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][2]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][0]), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][1]), ivec3(4294967289, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][2]), ivec3(3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0][0]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0][1]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0][2]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1][0]), ivec3(3, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1][1]), ivec3(4294967292, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1][2]), ivec3(4294967295, 4294967291, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[0][0][1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[0][0][2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[0][1][0] = i8vec3(ivec3(7, 4294967293, 7));
	block.var[0][1][1] = i8vec3(ivec3(4294967293, 4294967288, 2));
	block.var[0][1][2] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	block.var[1][0][0] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[1][0][1] = i8vec3(ivec3(9, 7, 5));
	block.var[1][0][2] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[1][1][0] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	block.var[1][1][1] = i8vec3(ivec3(4294967287, 1, 4294967288));
	block.var[1][1][2] = i8vec3(ivec3(4294967291, 8, 6));
	block.var[2][0][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[2][0][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[2][0][2] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[2][1][0] = i8vec3(ivec3(4294967288, 4, 8));
	block.var[2][1][1] = i8vec3(ivec3(4294967288, 4294967293, 1));
	block.var[2][1][2] = i8vec3(ivec3(4294967290, 4294967289, 6));
	block.var[3][0][0] = i8vec3(ivec3(3, 7, 4));
	block.var[3][0][1] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[3][0][2] = i8vec3(ivec3(4294967294, 8, 1));
	block.var[3][1][0] = i8vec3(ivec3(4294967295, 4294967289, 1));
	block.var[3][1][1] = i8vec3(ivec3(4294967292, 4294967295, 4294967292));
	block.var[3][1][2] = i8vec3(ivec3(4294967287, 1, 8));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(1.0, -8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-7.0, 3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-6.0, -9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(4.0, 2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(7.0, 8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[0][0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[0][0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	block.var[0][1][0] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	block.var[0][1][1] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	block.var[0][1][2] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	block.var[1][0][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	block.var[1][0][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	block.var[1][0][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	block.var[1][1][0] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	block.var[1][1][1] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	block.var[1][1][2] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	block.var[2][0][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	block.var[2][0][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	block.var[2][0][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	block.var[2][1][0] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
	block.var[2][1][1] = (mat2x4(-5.0, 1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0));
	block.var[2][1][2] = (mat2x4(2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0));
	block.var[3][0][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	block.var[3][0][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	block.var[3][0][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	block.var[3][1][0] = (mat2x4(-7.0, -3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0));
	block.var[3][1][1] = (mat2x4(2.0, 3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0));
	block.var[3][1][2] = (mat2x4(-6.0, -2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	i8vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0][0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][2][0]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][2][1]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][3][0]), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][3][1]), ivec3(4294967289, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][0]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][1]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][0]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][1]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][2][0]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][2][1]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][3][0]), ivec3(3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][3][1]), ivec3(3, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][0]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][1]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][0]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][1]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][2][0]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][2][1]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][3][0]), ivec3(4294967292, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][3][1]), ivec3(4294967295, 4294967291, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[0][0][1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[0][1][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[0][1][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[0][2][0] = i8vec3(ivec3(7, 4294967293, 7));
	block.var[0][2][1] = i8vec3(ivec3(4294967293, 4294967288, 2));
	block.var[0][3][0] = i8vec3(ivec3(4294967288, 4, 8));
	block.var[0][3][1] = i8vec3(ivec3(4294967288, 4294967293, 1));
	block.var[1][0][0] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[1][0][1] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[1][1][0] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[1][1][1] = i8vec3(ivec3(3, 7, 4));
	block.var[1][2][0] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	block.var[1][2][1] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	block.var[1][3][0] = i8vec3(ivec3(4294967290, 4294967289, 6));
	block.var[1][3][1] = i8vec3(ivec3(4294967295, 4294967289, 1));
	block.var[2][0][0] = i8vec3(ivec3(9, 7, 5));
	block.var[2][0][1] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[2][1][0] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[2][1][1] = i8vec3(ivec3(4294967294, 8, 1));
	block.var[2][2][0] = i8vec3(ivec3(4294967287, 1, 4294967288));
	block.var[2][2][1] = i8vec3(ivec3(4294967291, 8, 6));
	block.var[2][3][0] = i8vec3(ivec3(4294967292, 4294967295, 4294967292));
	block.var[2][3][1] = i8vec3(ivec3(4294967287, 1, 8));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[0][1][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	block.var[0][1][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	block.var[0][2][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	block.var[0][2][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	block.var[0][3][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	block.var[0][3][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	block.var[1][0][0] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	block.var[1][0][1] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	block.var[1][1][0] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	block.var[1][1][1] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	block.var[1][2][0] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	block.var[1][2][1] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	block.var[1][3][0] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	block.var[1][3][1] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	block.var[2][0][0] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	block.var[2][0][1] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	block.var[2][1][0] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	block.var[2][1][1] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	block.var[2][2][0] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	block.var[2][2][1] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	block.var[2][3][0] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	block.var[2][3][1] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
	lowp uint u;
	S s[3];
	mediump vec4 v;
};
layout (push_constant, std430) uniform PC {
    Block block;
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
	allOk = compare_ivec3((block.s[0].a), ivec3(7, -6, 5)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(3.0, -1.0, 8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(2.0, 6.0, -8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(4.0, 0.0, 7.0, 7.0, 8.0, 9.0, 9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(-8.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(5, 2, -3)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(-7.0, -7.0, 6.0, 9.0, -5.0, 2.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-4.0, 7.0, 8.0, -9.0, 4.0, 7.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(9.0, -5.0, -8.0, 0.0, -2.0, 6.0, 8.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(-2.0, -4.0, 1.0, 3.0, -6.0, -1.0, 3.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(-9.0, 1.0, -1.0, 3.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(7, 6, 5)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(4.0, 6.0, 9.0, 5.0, 9.0, -7.0, -8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(-1.0, 1.0, 3.0, 9.0, -8.0, -6.0, 4.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(-3.0, 4.0, 4.0, 8.0, 6.0, -6.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(-7.0, -5.0, 4.0, -9.0, 0.0, 5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(2.0, 4.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(7, -4, -7));
	block.s[0].b[0] = (mat3(-5.0, 3.0, -9.0, 6.0, 9.0, 2.0, -1.0, -2.0, 5.0));
	block.s[0].b[1] = (mat3(9.0, -5.0, -8.0, -7.0, -6.0, -9.0, 0.0, 9.0, -1.0));
	block.s[0].b[2] = (mat3(1.0, -8.0, 9.0, 7.0, 8.0, -1.0, 0.0, 7.0, -1.0));
	block.s[0].b[3] = (mat3(-6.0, -7.0, 7.0, 6.0, 8.0, 2.0, -4.0, 5.0, 4.0));
	block.s[0].c = (vec4(-7.0, 6.0, -4.0, 9.0));
	block.s[1].a = (ivec3(3, 2, 8));
	block.s[1].b[0] = (mat3(1.0, -4.0, -8.0, 4.0, -2.0, 3.0, -8.0, -4.0, -3.0));
	block.s[1].b[1] = (mat3(-7.0, 1.0, -1.0, 4.0, 0.0, -5.0, 8.0, -1.0, 3.0));
	block.s[1].b[2] = (mat3(-9.0, 4.0, 4.0, -5.0, -1.0, 9.0, 5.0, 4.0, -5.0));
	block.s[1].b[3] = (mat3(9.0, -4.0, 7.0, -8.0, -6.0, 4.0, 5.0, -3.0, 3.0));
	block.s[1].c = (vec4(-8.0, 9.0, -7.0, -3.0));
	block.s[2].a = (ivec3(2, -9, 5));
	block.s[2].b[0] = (mat3(5.0, 4.0, -6.0, -4.0, -2.0, -6.0, 4.0, 5.0, -8.0));
	block.s[2].b[1] = (mat3(-8.0, 6.0, -2.0, -6.0, 3.0, -4.0, -1.0, -1.0, -9.0));
	block.s[2].b[2] = (mat3(1.0, 8.0, 2.0, 0.0, 4.0, -8.0, 1.0, -9.0, -1.0));
	block.s[2].b[3] = (mat3(-7.0, -2.0, -6.0, -2.0, -3.0, 4.0, 9.0, -1.0, 3.0));
	block.s[2].c = (vec4(-9.0, 4.0, 9.0, -5.0));
	block.v = (vec4(-3.0, -3.0, 0.0, 0.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(2, 6, -5)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(7.0, 1.0, 4.0, -1.0, -5.0, -7.0, 6.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-5.0, 0.0, -5.0, -7.0, -8.0, -5.0, -6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(2.0, 2.0, -7.0, 1.0, -6.0, -8.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(6.0, -5.0, -3.0, -7.0, 9.0, -5.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(6.0, 0.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(4, -2, -6)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-9.0, 9.0, 4.0, -3.0, 2.0, 9.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-2.0, 3.0, -2.0, 5.0, -2.0, 8.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(9.0, 2.0, 0.0, 2.0, -4.0, 3.0, -5.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(6.0, 7.0, 9.0, -4.0, -5.0, 7.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(9.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-7, 7, 9)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(9.0, -1.0, 4.0, -5.0, 1.0, -5.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(0.0, 4.0, -3.0, 1.0, -6.0, 8.0, -8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-4.0, -2.0, 4.0, 1.0, -8.0, -1.0, -9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-5.0, -6.0, 8.0, 1.0, -8.0, 8.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-2.0, 1.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(8, 6, -6)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-3.0, 9.0, -9.0, 2.0, 7.0, 0.0, -5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-4.0, 8.0, 8.0, -3.0, -9.0, -7.0, -3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-4.0, 4.0, 8.0, 5.0, -3.0, -4.0, 4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(-3.0, 4.0, 9.0, 2.0, -6.0, -6.0, 0.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(8.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(7, 4, -7)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(8.0, 2.0, 7.0, 8.0, -3.0, -5.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-7.0, 4.0, 4.0, -2.0, -3.0, -9.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-5.0, 6.0, 0.0, -2.0, -4.0, 9.0, -4.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(2.0, 3.0, -3.0, -5.0, 4.0, 5.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(3.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-6, -2, -9)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-5.0, -2.0, 3.0, -3.0, 4.0, 3.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(9.0, 9.0, -1.0, 4.0, 5.0, 5.0, 2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(0.0, 2.0, 1.0, -2.0, -9.0, 2.0, 6.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-4.0, -9.0, -8.0, -4.0, -2.0, 3.0, 5.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(-3.0, 2.0, -9.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-4, -8, 5)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(8.0, -8.0, 6.0, 1.0, 8.0, -7.0, 6.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-8.0, 7.0, 7.0, 6.0, 4.0, 9.0, 1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(-5.0, -9.0, -8.0, -3.0, -2.0, 7.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(6.0, 4.0, 4.0, 5.0, 4.0, 4.0, -9.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-3.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(9, 5, -3)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(1.0, 8.0, 1.0, -8.0, -5.0, -8.0, -3.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-7.0, 9.0, -1.0, -6.0, -6.0, -9.0, -9.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(-9.0, -2.0, -1.0, -1.0, -1.0, 2.0, -6.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(1.0, -4.0, -7.0, 0.0, 8.0, -8.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(4.0, -5.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(0, -6, -7)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-7.0, -6.0, 2.0, 6.0, 2.0, -2.0, 1.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(9.0, -9.0, 7.0, 8.0, 3.0, 1.0, -5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(5.0, 7.0, -4.0, 9.0, -4.0, 3.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-2.0, -9.0, -4.0, 5.0, 5.0, 7.0, -3.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-8.0, 7.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(3, 5, -3));
	block[0].s[0].b[0] = (mat3(-8.0, 9.0, 6.0, -3.0, 0.0, -4.0, -9.0, 9.0, -5.0));
	block[0].s[0].b[1] = (mat3(7.0, -5.0, 4.0, 8.0, -2.0, -5.0, 3.0, -2.0, 1.0));
	block[0].s[0].b[2] = (mat3(2.0, 5.0, -1.0, -2.0, -6.0, 2.0, -9.0, 2.0, -6.0));
	block[0].s[0].b[3] = (mat3(-8.0, -1.0, 5.0, -9.0, 5.0, -3.0, 0.0, -6.0, 1.0));
	block[0].s[0].c = (vec4(-7.0, 4.0, -8.0, 2.0));
	block[0].s[1].a = (ivec3(-2, 2, 9));
	block[0].s[1].b[0] = (mat3(1.0, -6.0, -2.0, 7.0, 6.0, -6.0, -9.0, 1.0, -1.0));
	block[0].s[1].b[1] = (mat3(-9.0, 2.0, -4.0, -8.0, -2.0, 3.0, -7.0, 2.0, -2.0));
	block[0].s[1].b[2] = (mat3(-8.0, 0.0, -4.0, 6.0, -7.0, 8.0, 0.0, -9.0, -1.0));
	block[0].s[1].b[3] = (mat3(-3.0, -4.0, 0.0, -6.0, -6.0, 5.0, -7.0, 3.0, 3.0));
	block[0].s[1].c = (vec4(-7.0, -8.0, 1.0, -4.0));
	block[0].s[2].a = (ivec3(8, -5, 1));
	block[0].s[2].b[0] = (mat3(5.0, 0.0, 5.0, -3.0, -5.0, 0.0, -8.0, 4.0, 0.0));
	block[0].s[2].b[1] = (mat3(0.0, -2.0, -3.0, 9.0, 6.0, 6.0, -9.0, 6.0, -7.0));
	block[0].s[2].b[2] = (mat3(6.0, 8.0, -6.0, 1.0, -9.0, -2.0, -1.0, -5.0, 4.0));
	block[0].s[2].b[3] = (mat3(3.0, 0.0, -5.0, -4.0, -7.0, 7.0, -5.0, 6.0, 8.0));
	block[0].s[2].c = (vec4(-9.0, 2.0, 3.0, -9.0));
	block[0].v = (vec4(4.0, 5.0, 9.0, -2.0));
	block[1].s[0].a = (ivec3(9, -4, -2));
	block[1].s[0].b[0] = (mat3(-2.0, -2.0, 3.0, -9.0, 4.0, -6.0, 5.0, 0.0, -1.0));
	block[1].s[0].b[1] = (mat3(-8.0, -2.0, -6.0, 5.0, -5.0, 6.0, -1.0, -9.0, 5.0));
	block[1].s[0].b[2] = (mat3(7.0, -1.0, -7.0, -5.0, 2.0, 9.0, -1.0, -5.0, 7.0));
	block[1].s[0].b[3] = (mat3(-7.0, 2.0, 7.0, -3.0, 1.0, 0.0, 8.0, 3.0, 6.0));
	block[1].s[0].c = (vec4(-7.0, -4.0, 5.0, 9.0));
	block[1].s[1].a = (ivec3(3, 1, -4));
	block[1].s[1].b[0] = (mat3(-8.0, -5.0, 0.0, -8.0, 7.0, -7.0, -2.0, 9.0, 4.0));
	block[1].s[1].b[1] = (mat3(8.0, 2.0, -6.0, -2.0, 9.0, -3.0, 6.0, -2.0, 8.0));
	block[1].s[1].b[2] = (mat3(9.0, 1.0, 0.0, 6.0, 7.0, -7.0, 6.0, -2.0, 8.0));
	block[1].s[1].b[3] = (mat3(-6.0, 7.0, -3.0, -8.0, -3.0, -7.0, -9.0, -1.0, -7.0));
	block[1].s[1].c = (vec4(7.0, 5.0, 4.0, -8.0));
	block[1].s[2].a = (ivec3(-4, 3, 4));
	block[1].s[2].b[0] = (mat3(5.0, 3.0, 3.0, 5.0, -6.0, 0.0, -3.0, 0.0, 9.0));
	block[1].s[2].b[1] = (mat3(5.0, 2.0, -3.0, 0.0, 7.0, 5.0, 3.0, 8.0, -1.0));
	block[1].s[2].b[2] = (mat3(2.0, -1.0, -1.0, 5.0, -8.0, 7.0, -1.0, -8.0, 0.0));
	block[1].s[2].b[3] = (mat3(-9.0, -1.0, -7.0, -5.0, -5.0, -4.0, 5.0, -2.0, -3.0));
	block[1].s[2].c = (vec4(-8.0, 1.0, 9.0, -3.0));
	block[1].v = (vec4(-3.0, -2.0, 5.0, 5.0));
	block[2].s[0].a = (ivec3(-2, -7, 2));
	block[2].s[0].b[0] = (mat3(-5.0, 4.0, 0.0, -4.0, -4.0, 4.0, 5.0, -8.0, -9.0));
	block[2].s[0].b[1] = (mat3(-6.0, -4.0, 9.0, -7.0, 0.0, 7.0, -3.0, -9.0, -1.0));
	block[2].s[0].b[2] = (mat3(-8.0, 3.0, 9.0, -6.0, -9.0, -8.0, 3.0, 5.0, -1.0));
	block[2].s[0].b[3] = (mat3(-2.0, 2.0, -7.0, -1.0, 6.0, -2.0, -4.0, 3.0, -8.0));
	block[2].s[0].c = (vec4(-3.0, -3.0, 7.0, -7.0));
	block[2].s[1].a = (ivec3(8, 6, 4));
	block[2].s[1].b[0] = (mat3(7.0, 3.0, -2.0, 5.0, 0.0, 5.0, -9.0, -4.0, 2.0));
	block[2].s[1].b[1] = (mat3(6.0, 6.0, -5.0, 1.0, -7.0, 9.0, 6.0, 2.0, 1.0));
	block[2].s[1].b[2] = (mat3(-6.0, 2.0, 1.0, -3.0, -6.0, 7.0, -8.0, -8.0, -7.0));
	block[2].s[1].b[3] = (mat3(5.0, -4.0, 2.0, 7.0, 3.0, -6.0, -4.0, 4.0, -2.0));
	block[2].s[1].c = (vec4(7.0, -6.0, -3.0, -1.0));
	block[2].s[2].a = (ivec3(-8, 3, 6));
	block[2].s[2].b[0] = (mat3(5.0, 4.0, 8.0, -2.0, -9.0, 8.0, -7.0, -2.0, -3.0));
	block[2].s[2].b[1] = (mat3(-5.0, -8.0, -9.0, 1.0, 2.0, -1.0, -5.0, -5.0, -8.0));
	block[2].s[2].b[2] = (mat3(-5.0, -4.0, -3.0, 9.0, 0.0, 4.0, -6.0, -8.0, -1.0));
	block[2].s[2].b[3] = (mat3(-8.0, -7.0, -3.0, 8.0, -3.0, 6.0, 5.0, 2.0, 6.0));
	block[2].s[2].c = (vec4(-8.0, 5.0, -1.0, 0.0));
	block[2].v = (vec4(-4.0, 9.0, 0.0, -3.0));
}
#version 450
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
    Block block[3];
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
	allOk = compare_mat3(block[0].t[0].a, mat3(-8.0, 1.0, -5.0, 0.0, -5.0, -7.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(6, -8, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-1, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(9, 4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-2.0, 5.0, -2.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(2, 0, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(5, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(9, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-5, 7)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-5.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-6, 8, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-1, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-3.0, 6.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-9.0, -2.0, 2.0, 2.0, -7.0, 1.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-5, -3, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-3, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-2, 3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(8.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-4, 3, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(3, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(-5, 1)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(0.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-9, 8, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-5, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-4, -6)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-4.0, 9.0, 3.0, 5.0)) && allOk;
	allOk = compare_uint((block[0].u), 7u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-9.0, -3.0, 9.0, -9.0, 2.0, 7.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-5, -4, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-3, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(9, 2)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(8.0, -3.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(4, -2, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(9, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(3, -6, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(3, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-4.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(2.0, -4.0, 8.0, 8.0, -3.0, -9.0, -7.0, -3.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(8, 5, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(6, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(2, 7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(8.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-9, 8, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(2, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-3, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(4, 5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-8, 9, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-7, -8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-2.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_uint((block[1].u), 8u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-4.0, -8.0, 5.0, 9.0, 5.0, -3.0, 0.0, -6.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-8, 7, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-3, -2)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(4.0, 4.0, -9.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-8, -5, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-1, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-9, 1)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-4.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-5, -1, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-2, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-7, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(9, -9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(7.0, -4.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(8.0, -8.0, 6.0, 1.0, 8.0, -7.0, 6.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(6, 4, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(7, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-9, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(4, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(7.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-3, -5, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-5, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(2, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-7.0, 0.0, 8.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-7, -6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(7, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-5, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-4, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(3.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_uint((block[2].u), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-7, 3, 5));
	block[0].s.b[0] = (ivec2(-3, -2));
	block[0].s.b[1] = (ivec2(2, 9));
	block[0].s.b[2] = (ivec2(8, -5));
	block[0].s.b[3] = (ivec2(1, -8));
	block[0].s.c = (vec4(9.0, 6.0, -3.0, 0.0));
	block[0].u = (2u);
	block[1].s.a = (ivec3(-9, 2, 3));
	block[1].s.b[0] = (ivec2(-9, 4));
	block[1].s.b[1] = (ivec2(5, 9));
	block[1].s.b[2] = (ivec2(-2, 0));
	block[1].s.b[3] = (ivec2(9, -4));
	block[1].s.c = (vec4(-2.0, 3.0, 1.0, -4.0));
	block[1].u = (6u);
	block[2].s.a = (ivec3(-7, -4, 5));
	block[2].s.b[0] = (ivec2(9, 7));
	block[2].s.b[1] = (ivec2(5, 4));
	block[2].s.b[2] = (ivec2(-8, -8));
	block[2].s.b[3] = (ivec2(1, 9));
	block[2].s.c = (vec4(-3.0, -3.0, -2.0, 5.0));
	block[2].u = (3u);
}
#version 450
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
    Block block[3];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block[0].var), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block[1].var), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block[2].var), ivec3(7, 9, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i8vec3(ivec3(4294967292, 0, 0));
	block[1].var = i8vec3(ivec3(7, 9, 4294967290));
	block[2].var = i8vec3(ivec3(4294967288, 9, 4294967288));
}
#version 450
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
	mediump int a;
	mediump float b[1];
	lowp int c[1];
	mediump int d;
	bool e[1];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump int f;
	bool g[1];
	lowp int h;
	mediump uint i;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp int j;
	mediump int k;
	mediump int l;
	highp int m;
};
layout(std140, buffer_reference) buffer BlockE
{
	highp int n;
	mediump int o;
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

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 0) && allOk;
	allOk = compare_float((blockB.b[0]), 2.0) && allOk;
	allOk = compare_int((blockB.c[0]), -8) && allOk;
	allOk = compare_int((blockC.f), 5) && allOk;
	allOk = compare_int((blockC.h), 9) && allOk;
	allOk = compare_uint((blockC.i), 1u) && allOk;
	allOk = compare_int((blockD.l), 4) && allOk;
	allOk = compare_int((blockD.m), 9) && allOk;
	allOk = compare_int((blockE.n), -9) && allOk;
	allOk = compare_int((blockE.o), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6);
	blockB.c[0] = (0);
	blockB.d = (3);
	blockB.e[0] = (false);
	blockC.f = (6);
	blockC.g[0] = (true);
	blockC.i = (4u);
	blockD.j = (-6);
	blockD.k = (3);
	blockD.l = (-2);
	blockD.m = (5);
	blockE.n = (-2);
}
#version 450
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
	mediump int a;
	mediump float b;
	bool c;
	bool d;
	highp float e[1];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	bool f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
	allOk = compare_float((blockB.e[0]), -4.0) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-1);
	blockB.b = (-4.0);
	blockB.c = (true);
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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	highp mat4 b;
	highp ivec2 c;
	lowp mat3 d;
	mediump uvec3 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat2 f;
	bool g;
	mediump ivec4 h[1];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(-7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockB.e[0]), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.e[1]), uvec3(0u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.e[2]), uvec3(8u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.e[3]), uvec3(3u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.e[4]), uvec3(9u, 1u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.e[5]), uvec3(2u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.e[6]), uvec3(4u, 6u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.e[7]), uvec3(9u, 2u, 6u)) && allOk;
	allOk = compare_mat2(blockC.f, mat2(-6.0, 8.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(-9.0, -8.0, 0.0, 8.0, 0.0, 8.0, 7.0, 1.0, 2.0, -5.0, 9.0, -6.0, -3.0, 9.0, 4.0, 0.0));
	blockB.c = (ivec2(4, 5));
	blockB.e[0] = (uvec3(3u, 0u, 0u));
	blockB.e[1] = (uvec3(4u, 4u, 3u));
	blockB.e[2] = (uvec3(0u, 3u, 3u));
	blockB.e[3] = (uvec3(7u, 4u, 7u));
	blockB.e[4] = (uvec3(1u, 4u, 8u));
	blockB.e[5] = (uvec3(4u, 3u, 1u));
	blockB.e[6] = (uvec3(2u, 1u, 2u));
	blockB.e[7] = (uvec3(7u, 4u, 7u));
	blockC.g = (true);
	blockC.h[0] = (ivec4(-3, -5, 8, 2));
}
#version 450
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
	mediump mat3x4 c[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	mediump mat3x4 d[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat4 e;
	bvec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-5, 5)) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(-6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[1], mat3x4(5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[2], mat3x4(9.0, -5.0, 1.0, 8.0, -8.0, 4.0, -8.0, -3.0, -1.0, 4.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(1.0, -4.0, 7.0, -6.0, 0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1], mat3x4(3.0, 3.0, -7.0, 7.0, -3.0, -3.0, 8.0, 3.0, -1.0, 0.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[2], mat3x4(-3.0, -5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0, -1.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[3], mat3x4(-1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0, 7.0, -8.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD.e, mat4(-5.0, -7.0, -3.0, -6.0, 1.0, -8.0, 2.0, -4.0, 8.0, 5.0, 6.0, -8.0, -4.0, 7.0, -1.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockD.f), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(3, -4));
	blockB.b[0] = (mat3x4(2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0));
	blockB.b[1] = (mat3x4(4.0, -6.0, -8.0, -5.0, 0.0, 4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0));
	blockB.b[2] = (mat3x4(-5.0, 5.0, 5.0, -5.0, -2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0));
	blockB.c[0] = (mat3x4(-8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0, -2.0, -6.0, -9.0, 2.0, 6.0));
	blockB.c[1] = (mat3x4(-9.0, -4.0, 6.0, 0.0, -2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0, -8.0));
	blockB.c[2] = (mat3x4(9.0, 2.0, 5.0, -2.0, -5.0, 0.0, -4.0, 9.0, 0.0, -5.0, 8.0, -4.0));
	blockB.c[3] = (mat3x4(6.0, -6.0, 2.0, 7.0, 8.0, 7.0, -6.0, -2.0, 8.0, 6.0, -6.0, 1.0));
	blockD.e = (mat4(-9.0, -1.0, 0.0, 2.0, 3.0, 2.0, 9.0, 3.0, 1.0, -3.0, 0.0, 8.0, 3.0, -1.0, -3.0, -2.0));
	blockD.f = (bvec4(true, false, false, false));
}
#version 450
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
	bvec2 a;
	lowp int b;
	bvec3 c;
	bvec4 d;
	lowp ivec3 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp vec2 f;
	highp uvec4 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp vec4 h;
	mediump ivec4 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp mat2 j;
	bvec3 k;
	highp uint l;
	bvec4 m[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec4((blockC.g[0]), uvec4(0u, 3u, 6u, 1u)) && allOk;
	allOk = compare_mat2(blockE.j, mat2(6.0, -9.0, -2.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockE.k), bvec3(false, false, true)) && allOk;
	allOk = compare_uint((blockE.l), 3u) && allOk;
	allOk = compare_bvec4((blockE.m[0]), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.c = (bvec3(true, true, true));
	blockC.f = (vec2(-2.0, -9.0));
	blockC.g[0] = (uvec4(5u, 3u, 7u, 4u));
	blockD.i[0] = (ivec4(-6, 4, 8, -8));
	blockE.j = (mat2(4.0, 6.0, -9.0, 5.0));
	blockE.l = (1u);
	blockE.m[0] = (bvec4(false, false, true, true));
}
#version 450
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
	lowp uvec3 a;
	mediump ivec4 b;
	bvec2 c;
	mediump mat2x3 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp uvec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(8u, 2u, 7u)) && allOk;
	allOk = compare_ivec4((blockB[0].b), ivec4(-7, -4, -4, -6)) && allOk;
	allOk = compare_bvec2((blockB[0].c), bvec2(false, true)) && allOk;
	allOk = compare_uvec4((blockC[0].e[0]), uvec4(6u, 2u, 3u, 5u)) && allOk;
	allOk = compare_uvec4((blockC[0].e[1]), uvec4(0u, 4u, 0u, 3u)) && allOk;
	allOk = compare_uvec4((blockC[0].e[2]), uvec4(4u, 0u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((blockC[1].e[0]), uvec4(4u, 9u, 2u, 0u)) && allOk;
	allOk = compare_uvec4((blockC[1].e[1]), uvec4(9u, 9u, 8u, 8u)) && allOk;
	allOk = compare_uvec4((blockC[1].e[2]), uvec4(2u, 3u, 0u, 5u)) && allOk;
	allOk = compare_uvec4((blockC[1].e[3]), uvec4(7u, 2u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockC[1].e[4]), uvec4(0u, 3u, 2u, 3u)) && allOk;
	allOk = compare_uvec4((blockC[1].e[5]), uvec4(1u, 4u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockC[1].e[6]), uvec4(7u, 1u, 8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (ivec4(4, 1, -7, -4));
	blockB[0].c = (bvec2(true, false));
	blockC[0].e[0] = (uvec4(8u, 1u, 5u, 1u));
	blockC[0].e[1] = (uvec4(5u, 6u, 5u, 5u));
	blockC[0].e[2] = (uvec4(4u, 3u, 5u, 6u));
	blockC[1].e[0] = (uvec4(3u, 2u, 7u, 1u));
	blockC[1].e[1] = (uvec4(5u, 3u, 4u, 7u));
	blockC[1].e[2] = (uvec4(5u, 6u, 5u, 5u));
	blockC[1].e[3] = (uvec4(1u, 2u, 4u, 4u));
	blockC[1].e[4] = (uvec4(1u, 3u, 9u, 2u));
	blockC[1].e[5] = (uvec4(2u, 6u, 1u, 4u));
	blockC[1].e[6] = (uvec4(7u, 0u, 1u, 8u));
}
#version 450
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
	layout(offset = 16) bvec4 b;
	layout(offset = 32) bvec3 c;
	layout(offset = 44) highp float d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec2 e;
	layout(offset = 16) mediump uvec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec4 g;
	layout(offset = 16) lowp vec2 h[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(true, false, false)) && allOk;
	allOk = compare_float((blockB.d), -9.0) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(8u, 4u, 8u)) && allOk;
	allOk = compare_vec2((blockD.h[0]), vec2(-1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(8, 3));
	blockB.b = (bvec4(false, true, true, true));
	blockB.c = (bvec3(false, true, true));
	blockB.d = (-3.0);
	blockC.e = (ivec2(3, 4));
	blockC.f = (uvec3(8u, 7u, 5u));
	blockD.g = (bvec4(true, true, true, true));
	blockD.h[0] = (vec2(-3.0, 4.0));
}
#version 450
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
	lowp uvec3 a;
	lowp mat3 b;
	highp uvec3 c;
	mediump mat2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].b, mat3(2.0, 0.0, -3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].d, mat2(3.0, 5.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].b, mat3(7.0, -3.0, -9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].d, mat2(6.0, -9.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].b, mat3(-5.0, 9.0, 1.0, 9.0, -8.0, -7.0, -6.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(2)].d, mat2(4.0, 1.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec3(8u, 6u, 1u));
	blockB[nonuniformEXT(0)].b = (mat3(9.0, -5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0));
	blockB[nonuniformEXT(0)].c = (uvec3(7u, 8u, 3u));
	blockB[nonuniformEXT(0)].d = (mat2(-3.0, -7.0, -4.0, -2.0));
	blockB[nonuniformEXT(1)].a = (uvec3(5u, 5u, 3u));
	blockB[nonuniformEXT(1)].b = (mat3(9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0));
	blockB[nonuniformEXT(1)].c = (uvec3(1u, 4u, 6u));
	blockB[nonuniformEXT(1)].d = (mat2(-9.0, 5.0, 6.0, 1.0));
	blockB[nonuniformEXT(2)].a = (uvec3(8u, 1u, 7u));
	blockB[nonuniformEXT(2)].b = (mat3(-3.0, -8.0, -6.0, 3.0, 2.0, 7.0, 2.0, -9.0, 1.0));
	blockB[nonuniformEXT(2)].c = (uvec3(9u, 5u, 7u));
	blockB[nonuniformEXT(2)].d = (mat2(-1.0, 2.0, -5.0, -8.0));
}
#version 450
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
	highp mat3x4 a;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	f16vec2 b;
	bvec3 c;
	f16vec3 d;
	lowp mat2 e;
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	mediump mat4 f;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump int g[2];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(1.0, -6.0, -5.0, 7.0, 2.0, -1.0, 4.0, 1.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.b), vec2(3.0, 8.0)) && allOk;
	allOk = compare_int((blockE.g[0]), -4) && allOk;
	allOk = compare_int((blockE.g[1]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(9.0, 7.0, 5.0, -2.0, 9.0, -6.0, 1.0, 2.0, -4.0, -1.0, -9.0, 0.0));
	blockC.b = f16vec2(vec2(0.0, 6.0));
	blockC.c = (bvec3(false, true, true));
	blockC.d = f16vec3(vec3(4.0, -4.0, -4.0));
	blockE.g[0] = (0);
	blockE.g[1] = (-9);
}
#version 450
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
	highp uint b[6];
	highp ivec2 c[7];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockB.b[0]), 2u) && allOk;
	allOk = compare_uint((blockB.b[1]), 7u) && allOk;
	allOk = compare_uint((blockB.b[2]), 1u) && allOk;
	allOk = compare_uint((blockB.b[3]), 5u) && allOk;
	allOk = compare_uint((blockB.b[4]), 7u) && allOk;
	allOk = compare_uint((blockB.b[5]), 0u) && allOk;
	allOk = compare_ivec2((blockB.c[0]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((blockB.c[1]), ivec2(-6, -5)) && allOk;
	allOk = compare_ivec2((blockB.c[2]), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((blockB.c[3]), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec2((blockB.c[4]), ivec2(-1, -2)) && allOk;
	allOk = compare_ivec2((blockB.c[5]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((blockB.c[6]), ivec2(6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (5u);
	blockB.b[1] = (9u);
	blockB.b[2] = (4u);
	blockB.b[3] = (8u);
	blockB.b[4] = (6u);
	blockB.b[5] = (7u);
}
#version 450
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
	bvec2 a;
	u16vec4 b;
	highp mat2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = u16vec4(uvec4(6u, 3u, 2u, 1u));
	blockB.c = (mat2(-8.0, 8.0, -3.0, 3.0));
}
#version 450
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
	lowp mat4 a;
	mediump mat4x3 b;
	u16vec2 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec4 d;
	bvec2 e;
	bvec2 f;
	float16_t g;
	mediump mat4x3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-4.0, 6.0, 6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.c[0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.c[1]), uvec2(5u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.c[2]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(6u, 1u, 8u, 8u)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, true)) && allOk;
	allOk = compare_float16_t(float(blockC.g), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(9.0, -7.0, -5.0, -9.0, -8.0, 0.0, 8.0, 0.0, 8.0, 7.0, 1.0, 2.0, -5.0, 9.0, -6.0, -3.0));
	blockB.c[0] = u16vec2(uvec2(2u, 5u));
	blockB.c[1] = u16vec2(uvec2(3u, 0u));
	blockB.c[2] = u16vec2(uvec2(0u, 4u));
	blockC.d = (uvec4(4u, 3u, 0u, 3u));
	blockC.f = (bvec2(true, true));
	blockC.h[0] = (mat4x3(5.0, -3.0, 4.0, 7.0, -1.0, -2.0, 2.0, -2.0, 1.0, 0.0, 2.0, -9.0));
	blockC.h[1] = (mat4x3(0.0, 7.0, -3.0, -5.0, 8.0, 2.0, 2.0, -2.0, -1.0, 4.0, -3.0, -1.0));
	blockC.h[2] = (mat4x3(-2.0, 2.0, -3.0, -1.0, -6.0, -4.0, 3.0, -8.0, 6.0, 7.0, -3.0, -2.0));
}
#version 450
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
	bvec4 mB;
	mediump ivec4 mC[5];
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	i16vec2 a;
	bool b;
	bvec3 c;
	lowp vec3 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sA e;
	f16vec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.c), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.d[0]), vec3(5.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.d[1]), vec3(-2.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.d[2]), vec3(0.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.d[3]), vec3(-9.0, 7.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.d[4]), vec3(-2.0, -5.0, 2.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e.mA), uvec2(4u, 0u)) && allOk;
	allOk = compare_bvec4((blockC[0].e.mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec4((blockC[0].e.mC[0]), ivec4(8, 7, 9, -3)) && allOk;
	allOk = compare_ivec4((blockC[0].e.mC[1]), ivec4(1, 4, -9, 2)) && allOk;
	allOk = compare_ivec4((blockC[0].e.mC[2]), ivec4(7, -1, -3, 5)) && allOk;
	allOk = compare_ivec4((blockC[0].e.mC[3]), ivec4(0, 2, 7, 3)) && allOk;
	allOk = compare_ivec4((blockC[0].e.mC[4]), ivec4(3, 8, -4, 8)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f[0]), vec4(0.0, 0.0, 4.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f[1]), vec4(-5.0, -5.0, 7.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f[2]), vec4(-9.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f[3]), vec4(1.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f[4]), vec4(-8.0, -6.0, -8.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f[5]), vec4(0.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].e.mA), uvec2(4u, 8u)) && allOk;
	allOk = compare_bvec4((blockC[1].e.mB), bvec4(true, true, false, false)) && allOk;
	allOk = compare_ivec4((blockC[1].e.mC[0]), ivec4(3, -1, -2, 9)) && allOk;
	allOk = compare_ivec4((blockC[1].e.mC[1]), ivec4(3, -1, -8, -1)) && allOk;
	allOk = compare_ivec4((blockC[1].e.mC[2]), ivec4(-1, -1, -9, 4)) && allOk;
	allOk = compare_ivec4((blockC[1].e.mC[3]), ivec4(-8, 8, -6, 6)) && allOk;
	allOk = compare_ivec4((blockC[1].e.mC[4]), ivec4(0, -1, 0, -2)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].f[0]), vec4(-4.0, -9.0, 8.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].f[1]), vec4(-9.0, -4.0, -2.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].f[2]), vec4(8.0, -4.0, 5.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].f[3]), vec4(7.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].f[4]), vec4(-4.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[2].e.mA), uvec2(4u, 1u)) && allOk;
	allOk = compare_bvec4((blockC[2].e.mB), bvec4(false, true, true, false)) && allOk;
	allOk = compare_ivec4((blockC[2].e.mC[0]), ivec4(-6, 5, -1, 5)) && allOk;
	allOk = compare_ivec4((blockC[2].e.mC[1]), ivec4(-6, 5, -4, 5)) && allOk;
	allOk = compare_ivec4((blockC[2].e.mC[2]), ivec4(0, -7, -3, 0)) && allOk;
	allOk = compare_ivec4((blockC[2].e.mC[3]), ivec4(8, 5, 1, -8)) && allOk;
	allOk = compare_ivec4((blockC[2].e.mC[4]), ivec4(4, 4, -4, 1)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f[0]), vec4(7.0, 4.0, 6.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f[1]), vec4(8.0, 5.0, 7.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f[2]), vec4(5.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f[3]), vec4(9.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f[4]), vec4(4.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f[5]), vec4(-8.0, 9.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec2(ivec2(0, -7));
	blockB.b = (true);
	blockB.c = (bvec3(true, true, false));
	blockB.d[0] = (vec3(8.0, -3.0, 3.0));
	blockB.d[1] = (vec3(-3.0, -1.0, 6.0));
	blockB.d[2] = (vec3(9.0, 5.0, -6.0));
	blockB.d[3] = (vec3(-1.0, -2.0, 2.0));
	blockB.d[4] = (vec3(-3.0, -9.0, -5.0));
	blockC[0].f[0] = f16vec4(vec4(1.0, -4.0, 6.0, 0.0));
	blockC[0].f[1] = f16vec4(vec4(-2.0, -1.0, 5.0, 2.0));
	blockC[0].f[2] = f16vec4(vec4(-7.0, -6.0, -2.0, -6.0));
	blockC[0].f[3] = f16vec4(vec4(9.0, 9.0, -9.0, 5.0));
	blockC[0].f[4] = f16vec4(vec4(-3.0, 9.0, -9.0, -7.0));
	blockC[0].f[5] = f16vec4(vec4(6.0, 9.0, 0.0, 4.0));
	blockC[1].f[0] = f16vec4(vec4(-3.0, -7.0, 3.0, 1.0));
	blockC[1].f[1] = f16vec4(vec4(6.0, 1.0, -9.0, -9.0));
	blockC[1].f[2] = f16vec4(vec4(0.0, -8.0, -1.0, -3.0));
	blockC[1].f[3] = f16vec4(vec4(8.0, -5.0, 3.0, 5.0));
	blockC[1].f[4] = f16vec4(vec4(-7.0, 9.0, 7.0, -3.0));
	blockC[2].f[0] = f16vec4(vec4(-3.0, 7.0, -6.0, 7.0));
	blockC[2].f[1] = f16vec4(vec4(-9.0, -6.0, -2.0, -8.0));
	blockC[2].f[2] = f16vec4(vec4(2.0, -9.0, 4.0, -3.0));
	blockC[2].f[3] = f16vec4(vec4(-6.0, -2.0, 7.0, 1.0));
	blockC[2].f[4] = f16vec4(vec4(2.0, -3.0, -7.0, 1.0));
	blockC[2].f[5] = f16vec4(vec4(8.0, 9.0, 9.0, -4.0));
}
#version 450
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
	u16vec3 a;
	highp uvec4 b;
	lowp ivec3 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	f16vec4 d;
	bool e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	u16vec4 f;
	highp vec4 g;
	lowp mat3 h;
	lowp vec4 i[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	u16vec2 j;
	lowp ivec3 k;
	lowp uvec3 l;
	lowp mat4x3 m;
	lowp uvec3 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(2u, 7u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].f), uvec4(6u, 0u, 0u, 8u)) && allOk;
	allOk = compare_vec4((blockD[0].i[0]), vec4(-4.0, 8.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((blockD[0].i[1]), vec4(-4.0, 5.0, -3.0, -5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[1].f), uvec4(2u, 3u, 7u, 0u)) && allOk;
	allOk = compare_vec4((blockD[1].i[0]), vec4(5.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD[1].i[1]), vec4(0.0, -6.0, -9.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[2].f), uvec4(2u, 9u, 1u, 3u)) && allOk;
	allOk = compare_vec4((blockD[2].i[0]), vec4(-7.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockE.n[0]), uvec3(7u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((blockE.n[1]), uvec3(2u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.n[2]), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((blockE.n[3]), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockE.n[4]), uvec3(2u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.n[5]), uvec3(1u, 5u, 2u)) && allOk;
	allOk = compare_uvec3((blockE.n[6]), uvec3(3u, 8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (ivec3(-6, 5, 2));
	blockC.e[0] = (false);
	blockC.e[1] = (true);
	blockC.e[2] = (false);
	blockC.e[3] = (false);
	blockC.e[4] = (false);
	blockC.e[5] = (true);
	blockD[0].g = (vec4(9.0, 1.0, 0.0, 1.0));
	blockD[0].h = (mat3(1.0, 8.0, 9.0, 6.0, -4.0, -8.0, 7.0, 4.0, -7.0));
	blockD[0].i[0] = (vec4(4.0, 9.0, 3.0, -7.0));
	blockD[0].i[1] = (vec4(0.0, -3.0, 7.0, 4.0));
	blockD[1].g = (vec4(2.0, 0.0, -5.0, 7.0));
	blockD[1].h = (mat3(-8.0, 7.0, -3.0, -4.0, -3.0, 8.0, 1.0, 7.0, -9.0));
	blockD[1].i[0] = (vec4(-2.0, 1.0, 7.0, 1.0));
	blockD[1].i[1] = (vec4(-5.0, 2.0, 6.0, -2.0));
	blockD[2].g = (vec4(7.0, -9.0, -8.0, -5.0));
	blockD[2].h = (mat3(-3.0, -7.0, -1.0, 7.0, -9.0, -6.0, -1.0, 0.0, -1.0));
	blockD[2].i[0] = (vec4(9.0, -6.0, 0.0, -7.0));
	blockE.j = u16vec2(uvec2(7u, 7u));
	blockE.l = (uvec3(6u, 6u, 0u));
	blockE.n[0] = (uvec3(2u, 2u, 0u));
	blockE.n[1] = (uvec3(5u, 6u, 1u));
	blockE.n[2] = (uvec3(7u, 1u, 8u));
	blockE.n[3] = (uvec3(5u, 8u, 3u));
	blockE.n[4] = (uvec3(6u, 6u, 9u));
	blockE.n[5] = (uvec3(6u, 0u, 2u));
	blockE.n[6] = (uvec3(9u, 5u, 4u));
}
#version 450
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
	layout(offset = 0) lowp ivec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u16vec4 b;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) float16_t c;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp uint d;
	layout(offset = 4) mediump vec3 e;
	layout(offset = 16) mediump ivec3 f;
	layout(offset = 32) mediump vec2 g;
	layout(offset = 40) highp ivec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(4, -6, -2)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.b), uvec4(8u, 4u, 9u, 3u)) && allOk;
	allOk = compare_vec3((blockE[0].e), vec3(-3.0, 3.0, 5.0)) && allOk;
	allOk = compare_ivec3((blockE[0].f), ivec3(-7, 4, 5)) && allOk;
	allOk = compare_vec2((blockE[0].g), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockE[0].h), ivec2(-2, -8)) && allOk;
	allOk = compare_vec3((blockE[1].e), vec3(3.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((blockE[1].f), ivec3(8, -3, 3)) && allOk;
	allOk = compare_vec2((blockE[1].g), vec2(4.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockE[1].h), ivec2(9, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = u16vec4(uvec4(4u, 9u, 0u, 2u));
	blockD[0].c = float16_t(1.0);
	blockD[1].c = float16_t(1.0);
	blockE[0].d = (8u);
	blockE[0].e = (vec3(1.0, 0.0, 3.0));
	blockE[0].f = (ivec3(-9, -8, -6));
	blockE[0].g = (vec2(-6.0, -5.0));
	blockE[1].d = (7u);
	blockE[1].e = (vec3(-8.0, -1.0, 8.0));
	blockE[1].f = (ivec3(5, -5, 4));
	blockE[1].g = (vec2(4.0, -7.0));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec3 b;
	layout(offset = 16) bvec4 c;
	layout(offset = 32) highp vec3 d;
	layout(offset = 48) i16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB[0].a), vec4(-3.0, 7.0, -8.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockC.c), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(-4.0, 0.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.e), ivec3(3, 9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec4(vec4(-5.0, 5.0, -3.0, 3.0));
	blockC.b = i16vec3(ivec3(2, 7, 5));
	blockC.c = (bvec4(false, true, true, true));
	blockC.d = (vec3(-7.0, 0.0, -4.0));
	blockC.e = i16vec3(ivec3(2, 7, -3));
}
#version 450
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
	layout(offset = 16) highp uvec2 b;
	layout(offset = 24) i16vec3 c[1];
	layout(offset = 32) bool d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec3 e;
	layout(offset = 16) bvec2 f;
	layout(offset = 32) bvec4 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp ivec4 h;
	layout(offset = 16) int16_t i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(6, -5, 3, 0)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(9u, 9u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c[0]), ivec3(9, 4, 6)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(7u, 0u, 1u)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec4((blockD.h), ivec4(7, 2, 9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-2, -4, -9, -4));
	blockB.b = (uvec2(9u, 1u));
	blockB.d = (false);
	blockC.f = (bvec2(false, true));
	blockD.h = (ivec4(-8, -3, -2, -4));
	blockD.i = int16_t(-1);
}
#version 450
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
	i16vec3 mA;
	i16vec3 mB;
	lowp mat4x2 mC;
	i16vec3 mD;
};
struct sB
{
	bvec3 mA;
	sA mB;
	lowp mat4x3 mC;
	mediump mat3x2 mD;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	lowp mat2x3 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump uint b;
	int16_t c;
	highp uvec3 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	lowp int e;
	lowp uint f;
	lowp mat3x2 g;
};
layout(scalar, buffer_reference) buffer BlockE
{
	sB h;
	i16vec3 i[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0], mat2x3(4.0, -2.0, 7.0, -6.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1], mat2x3(2.0, 8.0, -3.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2], mat2x3(5.0, 4.0, -1.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3], mat2x3(-2.0, 2.0, 7.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[4], mat2x3(8.0, 3.0, 2.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_int16_t(int(blockC.c), -9) && allOk;
	allOk = compare_uvec3((blockC.d[0]), uvec3(9u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.d[1]), uvec3(7u, 5u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.d[2]), uvec3(1u, 9u, 2u)) && allOk;
	allOk = compare_uvec3((blockC.d[3]), uvec3(5u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.d[4]), uvec3(7u, 0u, 0u)) && allOk;
	allOk = compare_uint((blockD.f), 7u) && allOk;
	allOk = compare_mat3x2(blockD.g, mat3x2(6.0, -6.0, -3.0, -3.0, 5.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockE.h.mA), bvec3(true, false, true)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.h.mB.mA), ivec3(1, -2, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.h.mB.mB), ivec3(-6, -5, 7)) && allOk;
	allOk = compare_mat4x2(blockE.h.mB.mC, mat4x2(-4.0, 1.0, -5.0, 3.0, 9.0, 8.0, 7.0, 9.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.h.mB.mD), ivec3(1, 8, 8)) && allOk;
	allOk = compare_mat4x3(blockE.h.mC, mat4x3(-8.0, -2.0, 4.0, -5.0, 5.0, 7.0, -5.0, -6.0, 3.0, 6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockE.h.mD, mat3x2(-3.0, 1.0, -5.0, -8.0, 1.0, -8.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i[0]), ivec3(8, 6, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i[1]), ivec3(3, 7, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i[2]), ivec3(-5, 9, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i[3]), ivec3(5, -5, -3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i[4]), ivec3(1, 4, -3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i[5]), ivec3(5, 3, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i[6]), ivec3(-4, -4, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0] = (uvec3(0u, 1u, 1u));
	blockC.d[1] = (uvec3(0u, 2u, 2u));
	blockC.d[2] = (uvec3(1u, 8u, 6u));
	blockC.d[3] = (uvec3(8u, 6u, 6u));
	blockC.d[4] = (uvec3(1u, 2u, 8u));
	blockD.f = (7u);
	blockE.i[0] = i16vec3(ivec3(9, 4, 6));
	blockE.i[1] = i16vec3(ivec3(6, -9, -3));
	blockE.i[2] = i16vec3(ivec3(3, -7, 2));
	blockE.i[3] = i16vec3(ivec3(-3, 2, 6));
	blockE.i[4] = i16vec3(ivec3(5, -1, 9));
	blockE.i[5] = i16vec3(ivec3(-9, -9, 1));
	blockE.i[6] = i16vec3(ivec3(0, 6, -3));
}
#version 450
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
	uint16_t mA[2];
	highp mat3 mB[2];
	mediump mat2x3 mC;
};
struct sB
{
	bvec2 mA;
	sA mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sB a;
	f16vec2 b;
	mediump uint c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a.mA), bvec2(true, false)) && allOk;
	allOk = compare_uint16_t(uint(blockB.a.mB.mA[0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB.a.mB.mA[1]), 9u) && allOk;
	allOk = compare_mat3(blockB.a.mB.mB[0], mat3(-2.0, 3.0, 4.0, 1.0, -1.0, 4.0, -9.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.a.mB.mB[1], mat3(-7.0, 5.0, 5.0, -6.0, -6.0, 9.0, 7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB.a.mB.mC, mat2x3(-1.0, -7.0, 0.0, -4.0, 3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_uint((blockB.c[0]), 0u) && allOk;
	allOk = compare_uint((blockB.c[1]), 2u) && allOk;
	allOk = compare_uint((blockB.c[2]), 4u) && allOk;
	allOk = compare_uint((blockB.c[3]), 0u) && allOk;
	allOk = compare_uint((blockB.c[4]), 5u) && allOk;
	allOk = compare_uint((blockB.c[5]), 9u) && allOk;
	allOk = compare_uint((blockB.c[6]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (bvec2(true, true));
	blockB.a.mB.mA[0] = uint16_t(7u);
	blockB.a.mB.mA[1] = uint16_t(4u);
	blockB.a.mB.mB[0] = (mat3(-3.0, 7.0, 0.0, 1.0, 9.0, -7.0, 1.0, 2.0, -7.0));
	blockB.a.mB.mB[1] = (mat3(-3.0, 1.0, 0.0, 4.0, -5.0, 7.0, -7.0, -3.0, -9.0));
	blockB.a.mB.mC = (mat2x3(-4.0, 1.0, -2.0, -5.0, -1.0, -8.0));
	blockB.b = f16vec2(vec2(2.0, 4.0));
	blockB.c[0] = (0u);
	blockB.c[1] = (2u);
	blockB.c[2] = (4u);
	blockB.c[3] = (6u);
	blockB.c[4] = (2u);
	blockB.c[5] = (9u);
	blockB.c[6] = (4u);
}
#version 450
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
	i16vec4 a;
	lowp uvec4 b[1];
	lowp mat3x2 c;
	float16_t d;
	bvec3 e[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB[nonuniformEXT(0)].a), ivec4(1, -5, -9, -5)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].e[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[nonuniformEXT(1)].a), ivec4(4, -2, 9, 2)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].e[0]), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b[0] = (uvec4(0u, 4u, 9u, 0u));
	blockB[nonuniformEXT(0)].c = (mat3x2(-7.0, 5.0, 3.0, 4.0, 7.0, 8.0));
	blockB[nonuniformEXT(0)].e[0] = (bvec3(true, true, false));
	blockB[nonuniformEXT(1)].b[0] = (uvec4(9u, 8u, 7u, 8u));
	blockB[nonuniformEXT(1)].c = (mat3x2(7.0, -9.0, -5.0, 5.0, 3.0, 7.0));
	blockB[nonuniformEXT(1)].e[0] = (bvec3(true, true, false));
}
#version 450
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
	lowp int b[1];
};
layout(std140, buffer_reference) buffer BlockC
{
	bool c;
	uint8_t d;
	mediump uint e[1];
};
layout(std430, buffer_reference) buffer BlockD
{
	bool f;
	mediump uint g;
	lowp float h;
	bool i;
	bool j;
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
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), 9) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_uint8_t(uint(blockC.d), 8u) && allOk;
	allOk = compare_uint((blockC.e[0]), 1u) && allOk;
	allOk = compare_uint((blockD.g), 2u) && allOk;
	allOk = compare_float((blockD.h), -1.0) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (-4);
	blockC.d = uint8_t(1u);
	blockC.e[0] = (8u);
	blockD.f = (true);
	blockD.g = (9u);
	blockD.h = (0.0);
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

layout(std140, buffer_reference) readonly buffer BlockB
{
	bool a;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (vec3(3.0, 9.0, -5.0));
}
#version 450
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
	mediump vec2 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.a[1]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.a[2]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.a[3]), vec2(-1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint8_t b;
	mediump int c;
	bvec2 d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump vec3 e;
	u8vec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), 9) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[0]), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[1]), uvec3(8u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[2]), uvec3(4u, 0u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[3]), uvec3(4u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[4]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[5]), uvec3(8u, 4u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[6]), uvec3(3u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[7]), uvec3(0u, 2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(1u, 5u));
	blockB.b = uint8_t(5u);
	blockC.f[0] = u8vec3(uvec3(5u, 4u, 2u));
	blockC.f[1] = u8vec3(uvec3(4u, 1u, 2u));
	blockC.f[2] = u8vec3(uvec3(2u, 3u, 0u));
	blockC.f[3] = u8vec3(uvec3(2u, 7u, 5u));
	blockC.f[4] = u8vec3(uvec3(9u, 5u, 9u));
	blockC.f[5] = u8vec3(uvec3(5u, 1u, 2u));
	blockC.f[6] = u8vec3(uvec3(4u, 3u, 6u));
	blockC.f[7] = u8vec3(uvec3(8u, 2u, 2u));
}
#version 450
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
	u8vec2 mB;
	highp vec2 mC;
};
struct sB
{
	lowp ivec3 mA;
	lowp float mB;
	u8vec3 mC;
	int8_t mD;
};
struct sC
{
	uint8_t mA;
	sB mB;
	bvec3 mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump uvec2 a;
	mediump mat4x2 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	u8vec3 c;
	lowp int d;
	mediump uvec2 e;
	u8vec3 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	sA g;
	lowp mat2x3 h;
	bvec3 i;
	sC j;
	highp mat3x4 k[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat4x2(blockB.b[0], mat4x2(-4.0, -3.0, -1.0, 8.0, 8.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1], mat4x2(6.0, 8.0, -8.0, 9.0, -4.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2], mat4x2(-8.0, 3.0, 6.0, -4.0, -3.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3], mat4x2(-1.0, 9.0, -3.0, 9.0, -4.0, -3.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[4], mat4x2(6.0, -4.0, 2.0, -6.0, -2.0, -4.0, -5.0, 1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c), uvec3(0u, 5u, 0u)) && allOk;
	allOk = compare_int((blockC.d), 7) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(9u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[0]), uvec3(4u, 9u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[1]), uvec3(7u, 7u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[2]), uvec3(7u, 1u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[3]), uvec3(9u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[4]), uvec3(0u, 6u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f[5]), uvec3(5u, 9u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].g.mA), uvec2(7u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].g.mB), uvec2(2u, 4u)) && allOk;
	allOk = compare_vec2((blockD[0].g.mC), vec2(5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[0], mat3x4(5.0, -9.0, -5.0, -6.0, 2.0, 3.0, 3.0, 6.0, -5.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[1], mat3x4(1.0, -5.0, -4.0, -1.0, -1.0, 6.0, 1.0, 7.0, -4.0, 3.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[2], mat3x4(0.0, -8.0, 5.0, -6.0, 3.0, -5.0, 9.0, -8.0, 0.0, 5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[3], mat3x4(-7.0, -2.0, -3.0, 8.0, 2.0, 4.0, -1.0, -8.0, 1.0, -2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[4], mat3x4(-1.0, -2.0, 7.0, 3.0, 5.0, -3.0, 2.0, -4.0, -5.0, -4.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[5], mat3x4(0.0, 3.0, 3.0, -1.0, 9.0, 0.0, 2.0, -1.0, 5.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g.mA), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g.mB), uvec2(6u, 9u)) && allOk;
	allOk = compare_vec2((blockD[1].g.mC), vec2(1.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].k[0], mat3x4(-9.0, -4.0, 4.0, -5.0, 4.0, 2.0, 1.0, -3.0, -5.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].k[1], mat3x4(-7.0, 5.0, 5.0, 6.0, -3.0, 4.0, 2.0, -6.0, 1.0, -5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].k[2], mat3x4(-7.0, 1.0, 1.0, 3.0, -6.0, -7.0, 9.0, -9.0, 8.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].k[3], mat3x4(1.0, 2.0, -1.0, 3.0, 0.0, 6.0, 0.0, -8.0, -9.0, 8.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].k[4], mat3x4(-3.0, -1.0, -3.0, -5.0, 4.0, -3.0, 5.0, 0.0, 6.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].k[5], mat3x4(2.0, -1.0, 8.0, -3.0, 6.0, 4.0, 1.0, 5.0, 9.0, 8.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].k[6], mat3x4(-6.0, 8.0, 1.0, -7.0, 6.0, 9.0, 9.0, 0.0, 4.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g.mA), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g.mB), uvec2(8u, 9u)) && allOk;
	allOk = compare_vec2((blockD[2].g.mC), vec2(0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[2].k[0], mat3x4(-1.0, 6.0, -3.0, -9.0, -1.0, -1.0, 5.0, -4.0, -5.0, 6.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD[2].k[1], mat3x4(-3.0, 4.0, -8.0, 5.0, -3.0, -4.0, 7.0, -3.0, 2.0, 9.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD[2].k[2], mat3x4(7.0, 4.0, -8.0, 1.0, 5.0, 4.0, -9.0, -5.0, -9.0, 4.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[2].k[3], mat3x4(5.0, -4.0, -9.0, -8.0, 9.0, -4.0, 5.0, 8.0, -2.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD[2].k[4], mat3x4(8.0, -9.0, 5.0, 7.0, -7.0, 4.0, 0.0, 7.0, 7.0, 4.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4x2(9.0, 5.0, 6.0, -9.0, 4.0, 0.0, -5.0, 0.0));
	blockB.b[1] = (mat4x2(-7.0, -6.0, -7.0, 3.0, 9.0, -4.0, 1.0, -6.0));
	blockB.b[2] = (mat4x2(4.0, 6.0, 9.0, 8.0, -8.0, -8.0, -4.0, 9.0));
	blockB.b[3] = (mat4x2(-2.0, -5.0, 3.0, -8.0, 1.0, 2.0, 9.0, -1.0));
	blockB.b[4] = (mat4x2(-6.0, 4.0, -2.0, -1.0, 3.0, 3.0, -9.0, 7.0));
	blockC.c = u8vec3(uvec3(0u, 7u, 5u));
	blockC.d = (3);
	blockC.e = (uvec2(7u, 6u));
	blockC.f[0] = u8vec3(uvec3(0u, 2u, 1u));
	blockC.f[1] = u8vec3(uvec3(7u, 3u, 6u));
	blockC.f[2] = u8vec3(uvec3(7u, 7u, 5u));
	blockC.f[3] = u8vec3(uvec3(8u, 2u, 4u));
	blockC.f[4] = u8vec3(uvec3(5u, 1u, 3u));
	blockC.f[5] = u8vec3(uvec3(9u, 1u, 6u));
	blockD[0].h = (mat2x3(1.0, 6.0, 7.0, -8.0, 9.0, 4.0));
	blockD[0].i = (bvec3(false, false, false));
	blockD[0].j.mA = uint8_t(6u);
	blockD[0].j.mB.mA = (ivec3(1, 7, -3));
	blockD[0].j.mB.mB = (9.0);
	blockD[0].j.mB.mC = u8vec3(uvec3(2u, 7u, 0u));
	blockD[0].j.mB.mD = int8_t(1);
	blockD[0].j.mC = (bvec3(true, true, false));
	blockD[1].h = (mat2x3(-9.0, -7.0, 8.0, 7.0, -2.0, -8.0));
	blockD[1].i = (bvec3(true, true, true));
	blockD[1].j.mA = uint8_t(2u);
	blockD[1].j.mB.mA = (ivec3(7, 5, 4));
	blockD[1].j.mB.mB = (-3.0);
	blockD[1].j.mB.mC = u8vec3(uvec3(1u, 1u, 2u));
	blockD[1].j.mB.mD = int8_t(5);
	blockD[1].j.mC = (bvec3(false, true, false));
	blockD[2].h = (mat2x3(-7.0, 6.0, -9.0, 9.0, 8.0, 5.0));
	blockD[2].i = (bvec3(true, false, true));
	blockD[2].j.mA = uint8_t(1u);
	blockD[2].j.mB.mA = (ivec3(-3, 4, 2));
	blockD[2].j.mB.mB = (8.0);
	blockD[2].j.mB.mC = u8vec3(uvec3(6u, 1u, 3u));
	blockD[2].j.mB.mD = int8_t(2);
	blockD[2].j.mC = (bvec3(true, false, false));
}
#version 450
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
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp mat2 a;
	u8vec4 b;
	i8vec4 c;
	highp vec2 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sA e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp uvec2 f;
	highp uvec2 g;
	mediump vec3 h;
	lowp uvec2 i;
	highp mat3 j[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	mediump vec4 k[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(2.0, -4.0, -7.0, 7.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b), uvec4(9u, 6u, 1u, 9u)) && allOk;
	allOk = compare_vec2((blockB.d[0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB.d[1]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.d[2]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[0].mA, mat3x2(-5.0, 0.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[1].mA, mat3x2(1.0, 5.0, 9.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[2].mA, mat3x2(8.0, 9.0, -6.0, 7.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[3].mA, mat3x2(-8.0, -7.0, 8.0, 8.0, 8.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockD.f), uvec2(3u, 3u)) && allOk;
	allOk = compare_vec3((blockD.h), vec3(-5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(blockD.j[0], mat3(-5.0, 3.0, -9.0, -1.0, 0.0, 8.0, -4.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3(blockD.j[1], mat3(6.0, 3.0, 7.0, -6.0, 4.0, -7.0, -2.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD.j[2], mat3(9.0, 9.0, 9.0, 0.0, -7.0, -3.0, 1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(blockD.j[3], mat3(9.0, 9.0, 9.0, 9.0, 6.0, -5.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD.j[4], mat3(-2.0, 3.0, 9.0, -3.0, -4.0, 6.0, 5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD.j[5], mat3(-6.0, -8.0, -8.0, -1.0, 8.0, 8.0, 9.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-1.0, 9.0, 1.0, 3.0));
	blockB.b = u8vec4(uvec4(7u, 8u, 0u, 9u));
	blockB.d[0] = (vec2(-6.0, -3.0));
	blockB.d[1] = (vec2(8.0, 4.0));
	blockB.d[2] = (vec2(9.0, 1.0));
	blockC.e[0].mA = (mat3x2(0.0, -1.0, 4.0, -4.0, -2.0, -2.0));
	blockC.e[1].mA = (mat3x2(6.0, -3.0, 8.0, 7.0, -8.0, 2.0));
	blockC.e[2].mA = (mat3x2(-5.0, 3.0, -3.0, 5.0, -3.0, 8.0));
	blockC.e[3].mA = (mat3x2(-5.0, -1.0, 0.0, 2.0, 7.0, -3.0));
	blockD.g = (uvec2(2u, 7u));
	blockD.h = (vec3(7.0, 9.0, -2.0));
}
#version 450
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
	highp mat2 a;
	u8vec2 b;
	lowp vec4 c;
	lowp mat4 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	bvec4 e;
	bvec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].a, mat2(-7.0, -1.0, -7.0, 4.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b), uvec2(1u, 1u)) && allOk;
	allOk = compare_vec4((blockB[0].c), vec4(-3.0, 6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB[1].a, mat2(1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].b), uvec2(2u, 8u)) && allOk;
	allOk = compare_vec4((blockB[1].c), vec4(4.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(blockB[2].a, mat2(6.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[2].b), uvec2(0u, 9u)) && allOk;
	allOk = compare_vec4((blockB[2].c), vec4(8.0, -5.0, -3.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(true, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = u8vec2(uvec2(1u, 8u));
	blockB[0].d[0] = (mat4(0.0, -4.0, 7.0, 8.0, -6.0, -9.0, 0.0, 7.0, 3.0, 5.0, -7.0, 4.0, -9.0, 6.0, 7.0, -2.0));
	blockB[1].b = u8vec2(uvec2(1u, 4u));
	blockB[1].d[0] = (mat4(3.0, -3.0, 7.0, 0.0, 3.0, 7.0, -9.0, 6.0, -2.0, 1.0, 7.0, 8.0, -8.0, -8.0, -1.0, -2.0));
	blockB[1].d[1] = (mat4(4.0, 2.0, 8.0, 9.0, 9.0, -2.0, 8.0, -4.0, -6.0, -5.0, -9.0, -7.0, 6.0, 5.0, -2.0, -1.0));
	blockB[1].d[2] = (mat4(6.0, 7.0, -6.0, 9.0, -9.0, 3.0, 4.0, 0.0, -6.0, -9.0, 5.0, 0.0, 1.0, -2.0, 3.0, 2.0));
	blockB[2].b = u8vec2(uvec2(2u, 2u));
	blockB[2].d[0] = (mat4(7.0, 2.0, 3.0, -3.0, 1.0, 6.0, 6.0, 5.0, 8.0, -4.0, -9.0, -6.0, -2.0, 7.0, 0.0, -6.0));
	blockC.e = (bvec4(false, false, true, true));
}
#version 450
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
	lowp mat2x3 mB;
	highp mat2 mC;
	i8vec2 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	lowp vec3 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sA b[4];
	mediump mat4x3 c;
	i8vec3 d;
	lowp ivec4 e[][2];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	u8vec3 f;
	mediump mat3x2 g;
	highp mat2 h;
	mediump mat4 i;
	u8vec2 j[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockE
{
	u8vec4 k;
	i8vec2 l[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(-6.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.a[1]), vec3(-4.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.a[2]), vec3(-9.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.a[3]), vec3(-8.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC.b[0].mA, mat3x2(-1.0, -6.0, 6.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[0].mB, mat2x3(8.0, -4.0, 6.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.b[0].mC, mat2(4.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[0].mD), ivec2(2, 4)) && allOk;
	allOk = compare_mat3x2(blockC.b[1].mA, mat3x2(-4.0, 3.0, 0.0, 8.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[1].mB, mat2x3(7.0, -5.0, -6.0, 7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.b[1].mC, mat2(-8.0, -1.0, 6.0, 0.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[1].mD), ivec2(5, 5)) && allOk;
	allOk = compare_mat3x2(blockC.b[2].mA, mat3x2(-2.0, -6.0, -6.0, 4.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[2].mB, mat2x3(9.0, -7.0, -1.0, 3.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(blockC.b[2].mC, mat2(6.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[2].mD), ivec2(4294967294, 6)) && allOk;
	allOk = compare_mat3x2(blockC.b[3].mA, mat3x2(9.0, 8.0, 7.0, -5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[3].mB, mat2x3(-2.0, 4.0, 6.0, -3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(blockC.b[3].mC, mat2(5.0, 3.0, -6.0, 1.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[3].mD), ivec2(2, 4294967294)) && allOk;
	allOk = compare_mat4x3(blockC.c, mat4x3(-8.0, 6.0, 3.0, 1.0, -7.0, -4.0, -6.0, 3.0, 7.0, 9.0, -9.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d), ivec3(7, 9, 4294967289)) && allOk;
	allOk = compare_ivec4((blockC.e[0][0]), ivec4(2, -7, 0, 3)) && allOk;
	allOk = compare_ivec4((blockC.e[0][1]), ivec4(9, 8, -4, -6)) && allOk;
	allOk = compare_ivec4((blockC.e[1][0]), ivec4(8, -4, 4, -1)) && allOk;
	allOk = compare_ivec4((blockC.e[1][1]), ivec4(4, -8, -1, 0)) && allOk;
	allOk = compare_ivec4((blockC.e[2][0]), ivec4(7, -3, 8, -6)) && allOk;
	allOk = compare_ivec4((blockC.e[2][1]), ivec4(-8, 0, -6, -3)) && allOk;
	allOk = compare_ivec4((blockC.e[3][0]), ivec4(-4, -5, 8, -8)) && allOk;
	allOk = compare_ivec4((blockC.e[3][1]), ivec4(-6, -8, 5, -9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.f), uvec3(5u, 3u, 0u)) && allOk;
	allOk = compare_mat3x2(blockD.g, mat3x2(-3.0, -1.0, 6.0, 4.0, 7.0, -4.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[1]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[2]), uvec2(1u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[3]), uvec2(6u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[4]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[5]), uvec2(4u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[6]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[7]), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(4.0, 8.0, -7.0));
	blockB.a[1] = (vec3(-4.0, 1.0, -2.0));
	blockB.a[2] = (vec3(-6.0, -1.0, 5.0));
	blockB.a[3] = (vec3(2.0, 8.0, -8.0));
	blockC.b[0].mA = (mat3x2(2.0, -2.0, 3.0, -6.0, 5.0, -3.0));
	blockC.b[0].mB = (mat2x3(-4.0, -9.0, 2.0, 3.0, 6.0, 7.0));
	blockC.b[0].mC = (mat2(-2.0, 6.0, 4.0, -1.0));
	blockC.b[0].mD = i8vec2(ivec2(4294967287, 4294967295));
	blockC.b[1].mA = (mat3x2(0.0, 5.0, 2.0, -8.0, -2.0, -1.0));
	blockC.b[1].mB = (mat2x3(5.0, 2.0, 6.0, 0.0, -3.0, 0.0));
	blockC.b[1].mC = (mat2(6.0, -8.0, -5.0, 2.0));
	blockC.b[1].mD = i8vec2(ivec2(7, 4294967288));
	blockC.b[2].mA = (mat3x2(9.0, 2.0, 6.0, -1.0, -2.0, 2.0));
	blockC.b[2].mB = (mat2x3(9.0, 4.0, 5.0, -1.0, -7.0, -8.0));
	blockC.b[2].mC = (mat2(9.0, 5.0, -7.0, -9.0));
	blockC.b[2].mD = i8vec2(ivec2(4294967287, 4294967289));
	blockC.b[3].mA = (mat3x2(0.0, -4.0, 0.0, -7.0, -3.0, -8.0));
	blockC.b[3].mB = (mat2x3(-8.0, 5.0, -5.0, 3.0, -2.0, 1.0));
	blockC.b[3].mC = (mat2(-5.0, -6.0, -9.0, -5.0));
	blockC.b[3].mD = i8vec2(ivec2(6, 4294967287));
	blockC.c = (mat4x3(1.0, 9.0, -6.0, 2.0, -3.0, -7.0, -5.0, 4.0, -2.0, 9.0, -8.0, -6.0));
	blockC.d = i8vec3(ivec3(4294967287, 0, 4294967288));
	blockC.e[0][0] = (ivec4(-4, -5, 3, 8));
	blockC.e[0][1] = (ivec4(-4, 1, 7, -3));
	blockC.e[1][0] = (ivec4(-3, -1, 7, -6));
	blockC.e[1][1] = (ivec4(7, 3, 5, -8));
	blockC.e[2][0] = (ivec4(-3, -8, 4, 5));
	blockC.e[2][1] = (ivec4(-6, -7, -6, -4));
	blockC.e[3][0] = (ivec4(-8, 0, -9, 1));
	blockC.e[3][1] = (ivec4(4, -4, 5, 0));
	blockD.f = u8vec3(uvec3(0u, 7u, 1u));
	blockD.g = (mat3x2(4.0, -5.0, -9.0, 1.0, -2.0, 4.0));
}
#version 450
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
	int8_t a;
	highp vec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int8_t(5);
	blockB[nonuniformEXT(1)].a = int8_t(9);
	blockB[nonuniformEXT(2)].a = int8_t(4294967291);
	blockB[nonuniformEXT(3)].a = int8_t(5);
}
