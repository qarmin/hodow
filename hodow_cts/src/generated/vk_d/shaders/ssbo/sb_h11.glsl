#version 450
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
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (7u);
}
#version 450
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
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(2.0, 4.0));
	var[1] = (vec2(8.0, 4.0));
	var[2] = (vec2(0.0, 7.0));
}
#version 450
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

	var[0] = (vec3(-1.0, 0.0, 6.0));
	var[1] = (vec3(-6.0, -6.0, -2.0));
	var[2] = (vec3(5.0, 4.0, -9.0));
	var[3] = (vec3(-4.0, -2.0, 2.0));
}
#version 450
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
	int8_t var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	var = int8_t(4294967290);
}
#version 450
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

	var[0] = (vec2(-1.0, -3.0));
	var[1] = (vec2(-7.0, -2.0));
}
#version 450
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

	var[0] = (vec4(6.0, -9.0, 1.0, -3.0));
	var[1] = (vec4(4.0, -7.0, 5.0, 6.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], 0.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_float(var[3][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-1.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(0.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(1.0, 1.0, 8.0));
	var[1] = (vec3(0.0, 4.0, -9.0));
	var[2] = (vec3(-3.0, 7.0, -6.0));
	var[3] = (vec3(-7.0, -9.0, -7.0));
}
#version 450
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
	uint8_t var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = uint8_t(9u);
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

	padding = (-8.0);
	var = (vec3(-5.0, 8.0, 9.0));
}
#version 450
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

	padding = (-6.0);
	var[0] = (vec3(-3.0, 9.0, -2.0));
	var[1] = (vec3(-6.0, -6.0, 3.0));
	var[2] = (vec3(-9.0, 7.0, -5.0));
}
#version 450
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

	padding = (-1.0);
	var = (mat3x2(-6.0, -1.0, 7.0, -5.0, -1.0, 2.0));
}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-1.0, -5.0, -6.0, 6.0, 0.0, -7.0, 9.0, -6.0, 0.0, 3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0] = (vec4(9.0, -6.0, 8.0, -2.0));
	var[1] = (vec4(6.0, 9.0, -3.0, 9.0));
	var[2] = (vec4(2.0, -9.0, -9.0, 2.0));
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(7.0, -3.0));
	var[0][1] = (vec2(-2.0, 4.0));
	var[1][0] = (vec2(1.0, -3.0));
	var[1][1] = (vec2(2.0, -4.0));
	var[2][0] = (vec2(-1.0, 1.0));
	var[2][1] = (vec2(-4.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
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
}
#version 450
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
	i16vec3 var[3];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2]), ivec3(6, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i16vec3(ivec3(6, 1, -2));
	var[1] = i16vec3(ivec3(-3, -1, -4));
	var[2] = i16vec3(ivec3(-2, -2, 2));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(4.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-1.0, -9.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (mat2(2.0, 6.0, -6.0, 2.0));
	var[1] = (mat2(4.0, 4.0, 7.0, 0.0));
	var[2] = (mat2(8.0, 0.0, -1.0, 8.0));
}
#version 450
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

	var[0] = (bvec3(true, true, false));
	var[1] = (bvec3(false, true, true));
	var[2] = (bvec3(false, false, false));
	var[3] = (bvec3(true, false, false));
	var[4] = (bvec3(true, true, true));
	var[5] = (bvec3(false, true, true));
	var[6] = (bvec3(false, true, true));
	var[7] = (bvec3(true, true, true));
	var[8] = (bvec3(true, true, true));
	var[9] = (bvec3(true, false, false));
	var[10] = (bvec3(false, true, false));
	var[11] = (bvec3(true, false, false));
	var[12] = (bvec3(false, false, true));
	var[13] = (bvec3(true, false, true));
	var[14] = (bvec3(false, false, false));
	var[15] = (bvec3(true, true, false));
	var[16] = (bvec3(false, false, true));
	var[17] = (bvec3(false, false, true));
	var[18] = (bvec3(true, true, false));
}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[3] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[4] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[5] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[6] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[7] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[8] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[9] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[10] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[11] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	var[12] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	var[13] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	var[14] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	var[15] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	var[16] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	var[17] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	var[18] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
}
#version 450
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

	var[0][0] = (vec2(-8.0, -4.0));
	var[0][1] = (vec2(-3.0, 5.0));
	var[0][2] = (vec2(-9.0, 4.0));
	var[1][0] = (vec2(-2.0, -1.0));
	var[1][1] = (vec2(8.0, 3.0));
	var[1][2] = (vec2(7.0, 2.0));
	var[2][0] = (vec2(-4.0, 4.0));
	var[2][1] = (vec2(3.0, -6.0));
	var[2][2] = (vec2(-4.0, 3.0));
	var[3][0] = (vec2(4.0, 6.0));
	var[3][1] = (vec2(3.0, 6.0));
	var[3][2] = (vec2(-2.0, -9.0));
	var[4][0] = (vec2(-9.0, 0.0));
	var[4][1] = (vec2(-4.0, 9.0));
	var[4][2] = (vec2(-1.0, -1.0));
	var[5][0] = (vec2(-8.0, 6.0));
	var[5][1] = (vec2(5.0, -2.0));
	var[5][2] = (vec2(1.0, 4.0));
	var[6][0] = (vec2(2.0, -5.0));
	var[6][1] = (vec2(-5.0, -9.0));
	var[6][2] = (vec2(-7.0, 3.0));
	var[7][0] = (vec2(-1.0, 0.0));
	var[7][1] = (vec2(-1.0, 4.0));
	var[7][2] = (vec2(-1.0, -6.0));
	var[8][0] = (vec2(-8.0, -6.0));
	var[8][1] = (vec2(8.0, 7.0));
	var[8][2] = (vec2(4.0, -9.0));
	var[9][0] = (vec2(-4.0, -1.0));
	var[9][1] = (vec2(-3.0, -2.0));
	var[9][2] = (vec2(-5.0, -2.0));
	var[10][0] = (vec2(-7.0, -3.0));
	var[10][1] = (vec2(5.0, 4.0));
	var[10][2] = (vec2(4.0, 1.0));
	var[11][0] = (vec2(-3.0, -6.0));
	var[11][1] = (vec2(-4.0, -2.0));
	var[11][2] = (vec2(-5.0, -7.0));
	var[12][0] = (vec2(2.0, 6.0));
	var[12][1] = (vec2(6.0, 1.0));
	var[12][2] = (vec2(4.0, -8.0));
	var[13][0] = (vec2(2.0, -5.0));
	var[13][1] = (vec2(-5.0, 5.0));
	var[13][2] = (vec2(2.0, -1.0));
	var[14][0] = (vec2(-9.0, 3.0));
	var[14][1] = (vec2(6.0, 5.0));
	var[14][2] = (vec2(-1.0, -8.0));
	var[15][0] = (vec2(2.0, -1.0));
	var[15][1] = (vec2(0.0, -2.0));
	var[15][2] = (vec2(-4.0, 6.0));
	var[16][0] = (vec2(2.0, -3.0));
	var[16][1] = (vec2(-2.0, 1.0));
	var[16][2] = (vec2(-3.0, 8.0));
	var[17][0] = (vec2(5.0, -1.0));
	var[17][1] = (vec2(-4.0, -4.0));
	var[17][2] = (vec2(7.0, -6.0));
	var[18][0] = (vec2(-2.0, -8.0));
	var[18][1] = (vec2(0.0, -2.0));
	var[18][2] = (vec2(8.0, -2.0));
}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(7.0, 4.0, -4.0));
	var[0][1] = (vec3(-6.0, 3.0, -3.0));
	var[0][2] = (vec3(9.0, -2.0, 3.0));
	var[0][3] = (vec3(9.0, -9.0, 7.0));
	var[1][0] = (vec3(5.0, 1.0, -9.0));
	var[1][1] = (vec3(-1.0, -2.0, 6.0));
	var[1][2] = (vec3(-4.0, 6.0, 4.0));
	var[1][3] = (vec3(-8.0, 7.0, 3.0));
	var[2][0] = (vec3(-4.0, -9.0, 8.0));
	var[2][1] = (vec3(9.0, 2.0, 2.0));
	var[2][2] = (vec3(9.0, -7.0, 3.0));
	var[2][3] = (vec3(8.0, 2.0, 4.0));
	var[3][0] = (vec3(2.0, 4.0, -3.0));
	var[3][1] = (vec3(-8.0, 7.0, 3.0));
	var[3][2] = (vec3(0.0, -8.0, 0.0));
	var[3][3] = (vec3(6.0, -9.0, 0.0));
	var[4][0] = (vec3(-4.0, 5.0, 5.0));
	var[4][1] = (vec3(-7.0, -8.0, -1.0));
	var[4][2] = (vec3(6.0, -3.0, -5.0));
	var[4][3] = (vec3(0.0, 8.0, -8.0));
	var[5][0] = (vec3(-4.0, 4.0, 8.0));
	var[5][1] = (vec3(-4.0, -4.0, -3.0));
	var[5][2] = (vec3(3.0, 3.0, 2.0));
	var[5][3] = (vec3(8.0, -8.0, -6.0));
	var[6][0] = (vec3(9.0, 1.0, -1.0));
	var[6][1] = (vec3(-1.0, 2.0, 4.0));
	var[6][2] = (vec3(4.0, 2.0, 0.0));
	var[6][3] = (vec3(5.0, 6.0, -6.0));
	var[7][0] = (vec3(-3.0, 7.0, -6.0));
	var[7][1] = (vec3(7.0, 9.0, 8.0));
	var[7][2] = (vec3(-9.0, -9.0, -9.0));
	var[7][3] = (vec3(6.0, -7.0, -3.0));
	var[8][0] = (vec3(7.0, -1.0, -4.0));
	var[8][1] = (vec3(-9.0, 0.0, -1.0));
	var[8][2] = (vec3(-7.0, -2.0, -3.0));
	var[8][3] = (vec3(1.0, 4.0, 5.0));
	var[9][0] = (vec3(9.0, 8.0, 7.0));
	var[9][1] = (vec3(5.0, 4.0, 7.0));
	var[9][2] = (vec3(3.0, -3.0, 4.0));
	var[9][3] = (vec3(3.0, -6.0, 5.0));
	var[10][0] = (vec3(-8.0, -4.0, -9.0));
	var[10][1] = (vec3(4.0, 8.0, -3.0));
	var[10][2] = (vec3(-9.0, 7.0, -2.0));
	var[10][3] = (vec3(0.0, -3.0, -3.0));
	var[11][0] = (vec3(4.0, -2.0, -4.0));
	var[11][1] = (vec3(-5.0, -7.0, 1.0));
	var[11][2] = (vec3(-8.0, 1.0, 9.0));
	var[11][3] = (vec3(-8.0, 0.0, -2.0));
	var[12][0] = (vec3(-5.0, 2.0, -4.0));
	var[12][1] = (vec3(-7.0, -3.0, -4.0));
	var[12][2] = (vec3(4.0, -3.0, -8.0));
	var[12][3] = (vec3(-5.0, -1.0, 1.0));
	var[13][0] = (vec3(6.0, -2.0, 8.0));
	var[13][1] = (vec3(-7.0, 1.0, 4.0));
	var[13][2] = (vec3(6.0, 8.0, -5.0));
	var[13][3] = (vec3(1.0, -6.0, 4.0));
	var[14][0] = (vec3(-9.0, 3.0, -3.0));
	var[14][1] = (vec3(0.0, -5.0, -3.0));
	var[14][2] = (vec3(-5.0, -8.0, 3.0));
	var[14][3] = (vec3(3.0, -6.0, 8.0));
	var[15][0] = (vec3(-3.0, 5.0, 6.0));
	var[15][1] = (vec3(5.0, -1.0, 6.0));
	var[15][2] = (vec3(8.0, 7.0, 1.0));
	var[15][3] = (vec3(-5.0, 6.0, -6.0));
	var[16][0] = (vec3(-3.0, -7.0, 7.0));
	var[16][1] = (vec3(-9.0, -3.0, 6.0));
	var[16][2] = (vec3(0.0, -7.0, 3.0));
	var[16][3] = (vec3(2.0, -7.0, 1.0));
	var[17][0] = (vec3(8.0, -1.0, -9.0));
	var[17][1] = (vec3(8.0, 8.0, 2.0));
	var[17][2] = (vec3(7.0, -5.0, -2.0));
	var[17][3] = (vec3(-9.0, 6.0, 2.0));
	var[18][0] = (vec3(-1.0, 7.0, 7.0));
	var[18][1] = (vec3(3.0, -4.0, -1.0));
	var[18][2] = (vec3(-4.0, 5.0, 7.0));
	var[18][3] = (vec3(-5.0, 7.0, 5.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

	var[0] = (bvec3(true, true, false));
	var[1] = (bvec3(false, true, true));
	var[2] = (bvec3(false, false, false));
	var[3] = (bvec3(true, false, false));
	var[4] = (bvec3(true, true, true));
	var[5] = (bvec3(false, true, true));
	var[6] = (bvec3(false, true, true));
	var[7] = (bvec3(true, true, true));
	var[8] = (bvec3(true, true, true));
	var[9] = (bvec3(true, false, false));
	var[10] = (bvec3(false, true, false));
	var[11] = (bvec3(true, false, false));
	var[12] = (bvec3(false, false, true));
	var[13] = (bvec3(true, false, true));
	var[14] = (bvec3(false, false, false));
	var[15] = (bvec3(true, true, false));
	var[16] = (bvec3(false, false, true));
	var[17] = (bvec3(false, false, true));
	var[18] = (bvec3(true, true, false));
}
#version 450
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
	highp mat2x4 var[];
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
	allOk = compare_mat2x4(var[3], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[3][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[3][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[4][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[4][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[5][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[5][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[6][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[6][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[7][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[7][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[8][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[8][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[9][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[9][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[10][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[10][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[11][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[11][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	var[12][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	var[12][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	var[13][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	var[13][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	var[14][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	var[14][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	var[15][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	var[15][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	var[16][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	var[16][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	var[17][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	var[17][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	var[18][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	var[18][1] = (vec4(9.0, -8.0, 7.0, 0.0));
}
#version 450
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
	i16vec2 var[4][3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][2]), ivec2(1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i16vec2(ivec2(6, -2));
	var[0][1] = i16vec2(ivec2(-2, -8));
	var[0][2] = i16vec2(ivec2(3, 5));
	var[1][0] = i16vec2(ivec2(-9, -9));
	var[1][1] = i16vec2(ivec2(-4, -3));
	var[1][2] = i16vec2(ivec2(-2, 6));
	var[2][0] = i16vec2(ivec2(0, -1));
	var[2][1] = i16vec2(ivec2(3, -9));
	var[2][2] = i16vec2(ivec2(9, -6));
	var[3][0] = i16vec2(ivec2(-1, -7));
	var[3][1] = i16vec2(ivec2(-1, -6));
	var[3][2] = i16vec2(ivec2(6, 5));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[1][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[1][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[1][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[1][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[1][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[1][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[2][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[2][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[2][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[2][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[2][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[2][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[3][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[3][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[3][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[3][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[3][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[3][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[0][2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	var[1][0] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	var[1][1] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	var[1][2] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	var[2][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	var[2][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	var[2][2] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	var[3][0] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	var[3][1] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	var[3][2] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
}
#version 450
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
	int8_t var[4][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][1]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][2]), 3) && allOk;
	allOk = compare_int8_t(int(var[1][0]), 1) && allOk;
	allOk = compare_int8_t(int(var[1][1]), 6) && allOk;
	allOk = compare_int8_t(int(var[1][2]), 8) && allOk;
	allOk = compare_int8_t(int(var[2][0]), 5) && allOk;
	allOk = compare_int8_t(int(var[2][1]), 2) && allOk;
	allOk = compare_int8_t(int(var[2][2]), 0) && allOk;
	allOk = compare_int8_t(int(var[3][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[3][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[3][2]), 4294967289) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = int8_t(4294967290);
	var[0][1] = int8_t(4294967294);
	var[0][2] = int8_t(3);
	var[1][0] = int8_t(4294967288);
	var[1][1] = int8_t(1);
	var[1][2] = int8_t(2);
	var[2][0] = int8_t(4294967288);
	var[2][1] = int8_t(4294967294);
	var[2][2] = int8_t(7);
	var[3][0] = int8_t(9);
	var[3][1] = int8_t(0);
	var[3][2] = int8_t(4294967292);
}
#version 450
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
	i16vec2 var[4][3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][2]), ivec2(1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i16vec2(ivec2(6, -2));
	var[0][1] = i16vec2(ivec2(-2, -8));
	var[0][2] = i16vec2(ivec2(3, 5));
	var[1][0] = i16vec2(ivec2(-9, -9));
	var[1][1] = i16vec2(ivec2(-4, -3));
	var[1][2] = i16vec2(ivec2(-2, 6));
	var[2][0] = i16vec2(ivec2(0, -1));
	var[2][1] = i16vec2(ivec2(3, -9));
	var[2][2] = i16vec2(ivec2(9, -6));
	var[3][0] = i16vec2(ivec2(-1, -7));
	var[3][1] = i16vec2(ivec2(-1, -6));
	var[3][2] = i16vec2(ivec2(6, 5));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0] = (mat4(7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0, 1.0));
	var[0][1] = (mat4(3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0, 5.0));
	var[0][2] = (mat4(2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0, -1.0));
	var[1][0] = (mat4(9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0, 5.0));
	var[1][1] = (mat4(6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0, 7.0));
	var[1][2] = (mat4(-1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0, 4.0));
	var[2][0] = (mat4(-8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0, -9.0));
	var[2][1] = (mat4(-2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0, 5.0));
	var[2][2] = (mat4(-2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0, -2.0));
	var[3][0] = (mat4(-6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0, -9.0));
	var[3][1] = (mat4(-3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0, 6.0));
	var[3][2] = (mat4(9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0, 5.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(-9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0][0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	var[0][0][1] = (vec4(2.0, 7.0, -9.0, -9.0));
	var[0][1][0] = (vec4(-5.0, 4.0, 7.0, 5.0));
	var[0][1][1] = (vec4(8.0, -8.0, -8.0, 6.0));
	var[0][2][0] = (vec4(-3.0, 7.0, 0.0, 4.0));
	var[0][2][1] = (vec4(6.0, -4.0, 0.0, -5.0));
	var[1][0][0] = (vec4(8.0, -9.0, -8.0, 7.0));
	var[1][0][1] = (vec4(-7.0, -8.0, -6.0, -9.0));
	var[1][1][0] = (vec4(-8.0, 1.0, -2.0, 7.0));
	var[1][1][1] = (vec4(-6.0, -9.0, 9.0, 4.0));
	var[1][2][0] = (vec4(-6.0, 0.0, -3.0, -7.0));
	var[1][2][1] = (vec4(-7.0, 2.0, -1.0, 6.0));
	var[2][0][0] = (vec4(-1.0, -5.0, 1.0, -1.0));
	var[2][0][1] = (vec4(8.0, 7.0, 6.0, -9.0));
	var[2][1][0] = (vec4(8.0, 2.0, 1.0, 9.0));
	var[2][1][1] = (vec4(-7.0, 6.0, -8.0, -2.0));
	var[2][2][0] = (vec4(-8.0, 6.0, 9.0, 5.0));
	var[2][2][1] = (vec4(5.0, -1.0, -1.0, 4.0));
	var[3][0][0] = (vec4(-3.0, 7.0, -9.0, -3.0));
	var[3][0][1] = (vec4(9.0, 2.0, 6.0, 6.0));
	var[3][1][0] = (vec4(1.0, 5.0, -4.0, 1.0));
	var[3][1][1] = (vec4(-6.0, 2.0, 6.0, -8.0));
	var[3][2][0] = (vec4(7.0, 7.0, -5.0, -8.0));
	var[3][2][1] = (vec4(0.0, -6.0, -4.0, 5.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[0][0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	var[0][1][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	var[0][1][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	var[0][1][2] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	var[1][0][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	var[1][0][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	var[1][0][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	var[1][1][0] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	var[1][1][1] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	var[1][1][2] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	var[2][0][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	var[2][0][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	var[2][0][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	var[2][1][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	var[2][1][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	var[2][1][2] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	var[3][0][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	var[3][0][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	var[3][0][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	var[3][1][0] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	var[3][1][1] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	var[3][1][2] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[0][0][2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[0][0][2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[0][0][2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[0][1][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	var[0][1][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	var[0][1][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	var[0][1][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	var[0][1][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	var[0][1][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	var[0][1][2][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	var[0][1][2][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	var[0][1][2][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	var[1][0][0][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[1][0][0][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[1][0][0][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[1][0][1][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[1][0][1][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[1][0][1][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[1][0][2][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[1][0][2][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[1][0][2][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[1][1][0][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	var[1][1][0][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	var[1][1][0][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	var[1][1][1][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	var[1][1][1][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	var[1][1][1][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	var[1][1][2][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	var[1][1][2][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	var[1][1][2][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	var[2][0][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[2][0][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[2][0][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[2][0][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[2][0][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[2][0][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[2][0][2][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[2][0][2][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[2][0][2][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[2][1][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	var[2][1][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	var[2][1][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	var[2][1][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	var[2][1][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	var[2][1][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	var[2][1][2][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	var[2][1][2][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	var[2][1][2][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	var[3][0][0][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[3][0][0][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[3][0][0][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[3][0][1][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[3][0][1][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[3][0][1][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[3][0][2][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[3][0][2][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[3][0][2][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	var[3][1][0][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	var[3][1][0][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	var[3][1][0][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	var[3][1][1][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	var[3][1][1][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	var[3][1][1][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	var[3][1][2][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	var[3][1][2][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	var[3][1][2][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	i8vec3 var[4][2][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][0]), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][1]), ivec3(4294967289, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][2]), ivec3(9, 4294967292, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][0]), ivec3(1, 6, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][1]), ivec3(5, 0, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][2]), ivec3(1, 4294967294, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][1]), ivec3(0, 4294967291, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][2]), ivec3(4294967292, 1, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][0]), ivec3(7, 4294967293, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][1]), ivec3(4294967291, 4294967295, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][0]), ivec3(4294967293, 4294967295, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][1]), ivec3(6, 4294967295, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][2]), ivec3(3, 5, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][0]), ivec3(4294967293, 4294967294, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][1]), ivec3(4294967289, 8, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][2]), ivec3(4294967288, 9, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][1]), ivec3(7, 4294967290, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][2]), ivec3(4294967294, 0, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][0]), ivec3(4294967293, 4294967295, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][1]), ivec3(3, 4294967295, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][2]), ivec3(4294967291, 2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967292);
	var[0][0][0] = i8vec3(ivec3(0, 0, 7));
	var[0][0][1] = i8vec3(ivec3(9, 4294967290, 4294967288));
	var[0][0][2] = i8vec3(ivec3(9, 4294967288, 4294967293));
	var[0][1][0] = i8vec3(ivec3(4294967293, 7, 4294967293));
	var[0][1][1] = i8vec3(ivec3(4294967288, 2, 4294967287));
	var[0][1][2] = i8vec3(ivec3(4294967295, 4294967293, 4294967292));
	var[1][0][0] = i8vec3(ivec3(3, 4294967295, 9));
	var[1][0][1] = i8vec3(ivec3(7, 5, 5));
	var[1][0][2] = i8vec3(ivec3(4294967293, 6, 4294967293));
	var[1][1][0] = i8vec3(ivec3(4294967290, 4294967295, 4294967287));
	var[1][1][1] = i8vec3(ivec3(1, 4294967288, 4294967291));
	var[1][1][2] = i8vec3(ivec3(8, 6, 4294967288));
	var[2][0][0] = i8vec3(ivec3(4294967295, 3, 5));
	var[2][0][1] = i8vec3(ivec3(4294967292, 4294967295, 4294967293));
	var[2][0][2] = i8vec3(ivec3(8, 4294967290, 3));
	var[2][1][0] = i8vec3(ivec3(4, 8, 4294967288));
	var[2][1][1] = i8vec3(ivec3(4294967293, 1, 4294967290));
	var[2][1][2] = i8vec3(ivec3(4294967289, 6, 4294967295));
	var[3][0][0] = i8vec3(ivec3(7, 4, 4294967292));
	var[3][0][1] = i8vec3(ivec3(8, 8, 4294967294));
	var[3][0][2] = i8vec3(ivec3(8, 1, 7));
	var[3][1][0] = i8vec3(ivec3(4294967289, 1, 4294967292));
	var[3][1][1] = i8vec3(ivec3(4294967295, 4294967292, 4294967287));
	var[3][1][2] = i8vec3(ivec3(1, 8, 3));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	bvec3 var[][4][2];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0][0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[0][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[0][1][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[0][1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[0][2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[0][2][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][3][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[1][0][1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[1][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][2][1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1][3][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1][3][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[2][0][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][0][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[2][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][3][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[2][3][1]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec3(true, true, false));
	var[0][0][1] = (bvec3(false, true, true));
	var[0][1][0] = (bvec3(false, true, true));
	var[0][1][1] = (bvec3(true, true, true));
	var[0][2][0] = (bvec3(false, false, true));
	var[0][2][1] = (bvec3(true, false, true));
	var[0][3][0] = (bvec3(true, true, false));
	var[0][3][1] = (bvec3(false, true, false));
	var[1][0][0] = (bvec3(false, false, false));
	var[1][0][1] = (bvec3(true, false, false));
	var[1][1][0] = (bvec3(true, true, true));
	var[1][1][1] = (bvec3(true, false, false));
	var[1][2][0] = (bvec3(false, false, false));
	var[1][2][1] = (bvec3(true, true, false));
	var[1][3][0] = (bvec3(false, true, false));
	var[1][3][1] = (bvec3(false, false, false));
	var[2][0][0] = (bvec3(true, true, true));
	var[2][0][1] = (bvec3(false, true, true));
	var[2][1][0] = (bvec3(false, true, false));
	var[2][1][1] = (bvec3(true, false, false));
	var[2][2][0] = (bvec3(false, false, true));
	var[2][2][1] = (bvec3(false, false, true));
	var[2][3][0] = (bvec3(true, true, false));
	var[2][3][1] = (bvec3(false, true, false));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-2, 8, 0)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-9.0, -5.0, 4.0, -2.0, -7.0, 9.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-2.0, -6.0, 3.0, -7.0, -5.0, 8.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(5.0, 0.0, 0.0, -6.0, 7.0, 3.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-4.0, -8.0, 7.0, 8.0, 3.0, 9.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(2.0, 8.0, -1.0, 6.0, 0.0, 4.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(5, -1, 8)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(4.0, -3.0, -6.0, 6.0, 0.0, 9.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(-4.0, 6.0, -5.0, 6.0, 9.0, -3.0, 8.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-6.0, -4.0, -2.0, 6.0, -7.0, -5.0, 6.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-7.0, 9.0, 2.0, 5.0, 9.0, -1.0, -4.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(3.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(2, 5, -5)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-5.0, 5.0, 2.0, -2.0, 9.0, 7.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(2.0, 1.0, -6.0, 7.0, 0.0, -8.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(7.0, -1.0, 1.0, -4.0, -2.0, 3.0, 6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-3.0, -3.0, 9.0, 8.0, 0.0, 4.0, 1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(5.0, -4.0, 1.0, 6.0, 3.0, 9.0, -4.0, 6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(4, -2, 7)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(-6.0, 1.0, -4.0, -1.0, 6.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-6.0, 1.0, 7.0, -6.0, 1.0, -5.0, -8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(1.0, 0.0, 9.0, -8.0, 9.0, 2.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-3.0, 5.0, -5.0, -4.0, 2.0, 2.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(1.0, -6.0, 2.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(0, 8, 8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-8.0, -7.0, 7.0, -1.0, -7.0, -9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-1.0, -6.0, -6.0, 8.0, 2.0, 9.0, 5.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(4.0, -5.0, 2.0, -4.0, -9.0, 5.0, -7.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(1.0, 2.0, -3.0, -3.0, -1.0, 7.0, 1.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(8.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-1.0, 0.0, -3.0, 8.0, 2.0, -6.0, -8.0, -1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(2, 3, -3)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-5.0, 3.0, 8.0, 5.0, -2.0, 5.0, 0.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(4.0, 2.0, -1.0, 1.0, -5.0, -6.0, -8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(-2.0, -1.0, -4.0, 8.0, -4.0, 8.0, 0.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(0.0, -2.0, -9.0, 9.0, -6.0, 2.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(9.0, -4.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(6.0, 3.0, 4.0, 6.0, 7.0, 8.0, 5.0, 1.0, 2.0));
	block[0].t.b.a = (ivec3(4, -6, -7));
	block[0].t.b.b[0] = (mat3(-6.0, -2.0, 9.0, 0.0, -6.0, -7.0, 7.0, -5.0, 5.0));
	block[0].t.b.b[1] = (mat3(9.0, 7.0, -2.0, -9.0, -2.0, 6.0, 8.0, 1.0, -5.0));
	block[0].t.b.b[2] = (mat3(-4.0, 0.0, 2.0, -1.0, 1.0, 5.0, 2.0, 4.0, 5.0));
	block[0].t.b.b[3] = (mat3(8.0, 6.0, 7.0, 9.0, -1.0, 5.0, 5.0, -6.0, -7.0));
	block[0].t.b.c = (vec4(-4.0, 2.0, -1.0, 5.0));
	block[0].u = (1u);
	block[1].t.a = (mat3(-6.0, 1.0, 6.0, -6.0, 3.0, -3.0, -9.0, 3.0, 6.0));
	block[1].t.b.a = (ivec3(9, 6, 4));
	block[1].t.b.b[0] = (mat3(-9.0, 7.0, -2.0, 1.0, 2.0, -6.0, 2.0, 3.0, -3.0));
	block[1].t.b.b[1] = (mat3(8.0, 1.0, 0.0, -1.0, 8.0, -9.0, -5.0, 9.0, 6.0));
	block[1].t.b.b[2] = (mat3(-1.0, -5.0, -8.0, 3.0, -3.0, -3.0, -7.0, 0.0, -4.0));
	block[1].t.b.b[3] = (mat3(-4.0, -9.0, -8.0, 9.0, -2.0, 4.0, 0.0, 1.0, 8.0));
	block[1].t.b.c = (vec4(5.0, -6.0, -6.0, 2.0));
	block[1].u = (3u);
	block[2].t.a = (mat3(-1.0, -1.0, -4.0, -6.0, -8.0, 3.0, 4.0, 1.0, 0.0));
	block[2].t.b.a = (ivec3(8, -4, 2));
	block[2].t.b.b[0] = (mat3(-9.0, -4.0, -6.0, 2.0, 3.0, -4.0, 6.0, 4.0, -4.0));
	block[2].t.b.b[1] = (mat3(-9.0, -2.0, 3.0, 6.0, -5.0, 7.0, 8.0, -6.0, 1.0));
	block[2].t.b.b[2] = (mat3(-4.0, -9.0, 7.0, 4.0, -4.0, 0.0, 6.0, -5.0, -2.0));
	block[2].t.b.b[3] = (mat3(-1.0, 0.0, 2.0, -9.0, 8.0, -9.0, -2.0, -2.0, -8.0));
	block[2].t.b.c = (vec4(-7.0, 7.0, -8.0, -5.0));
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(6u, 0u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(9.0, -1.0, 9.0, 2.0, -7.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(4.0, 5.0, 6.0, 7.0, 1.0, -6.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-9.0, 3.0, 4.0, 5.0, -6.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(-4.0, 5.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(6u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(4.0, 2.0, -3.0, -2.0, -2.0, 3.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(1.0, -3.0, 0.0, -9.0, 0.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(5.0, 8.0, -3.0, 4.0, 4.0, 1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(8.0, 4.0, 6.0, -1.0, 3.0, -1.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(0.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(0.0, -2.0, 7.0, 9.0, 9.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-8.0, 5.0, 3.0, -3.0, 8.0, 4.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(-7.0, -4.0, 7.0, -4.0, -1.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(9.0, 3.0, 7.0, -2.0, 9.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(-8.0, 3.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(8u, 3u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-9.0, 4.0, -5.0, -8.0, -6.0, -2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(7.0, 3.0, -1.0, -3.0, 0.0, -6.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(-2.0, 6.0, -9.0, 1.0, -1.0, 2.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(9.0, 6.0, 7.0, 5.0, -6.0, -3.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(3.0, -9.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-6.0, -9.0, -4.0, -1.0, 1.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(5.0, -9.0, 0.0, -9.0, 1.0, -7.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(2.0, -2.0, 8.0, 5.0, 9.0, 6.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(8.0, 5.0, -3.0, -3.0, -1.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(2.0, -3.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(2u, 1u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(4.0, -4.0, -6.0, -3.0, 9.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(2.0, -4.0, 9.0, 4.0, 7.0, -1.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-8.0, 1.0, 8.0, -4.0, 0.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(0.0, 6.0, -9.0, -9.0, -2.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-1.0, -5.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(7u, 8u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-2.0, -9.0, -4.0, -7.0, -2.0, 1.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(6.0, -3.0, -4.0, 7.0, 3.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(-9.0, -2.0, 7.0, 1.0, 4.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-8.0, -1.0, 0.0, -2.0, 2.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(5.0, -6.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(2u, 8u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(8.0, 1.0, -1.0, 7.0, 0.0, 0.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(0.0, -6.0, 2.0, -1.0, -2.0, 4.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-4.0, 0.0, 1.0, 9.0, 1.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(7.0, 5.0, -6.0, 4.0, 8.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-5.0, 4.0, -3.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-5.0, 6.0, -2.0, 6.0, 1.0, -5.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(5.0, -5.0, 8.0, -5.0, 5.0, -1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-1.0, -8.0, -1.0, 4.0, -3.0, -7.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(8.0, -1.0, 5.0, -2.0, -3.0, 8.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(-1.0, -4.0, -3.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(2.0, -2.0, -5.0, 4.0, -4.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-3.0, -7.0, -6.0, 6.0, 0.0, 8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(2.0, -6.0, 3.0, 1.0, -8.0, 9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-2.0, 8.0, 2.0, -5.0, -7.0, -8.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-3.0, -4.0, -7.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-3.0, 6.0, 5.0, 1.0, -1.0, 7.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-3.0, 0.0, 0.0, 0.0, 3.0, 0.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-6.0, -6.0, -1.0, -4.0, 4.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(-7.0, -8.0, -7.0, 5.0, -7.0, 9.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(-5.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (4u);
	block[0].s[0].a = (uvec2(3u, 5u));
	block[0].s[0].b[0] = (mat2x4(3.0, -4.0, 6.0, 7.0, -1.0, -6.0, -4.0, -8.0));
	block[0].s[0].b[1] = (mat2x4(-2.0, 7.0, -4.0, -9.0, 1.0, 9.0, -5.0, -2.0));
	block[0].s[0].b[2] = (mat2x4(-9.0, -6.0, 4.0, 2.0, 2.0, -6.0, -5.0, 3.0));
	block[0].s[0].b[3] = (mat2x4(9.0, 8.0, -6.0, -2.0, -5.0, 2.0, 8.0, 8.0));
	block[0].s[0].c = (vec3(-7.0, 5.0, 9.0));
	block[0].s[1].a = (uvec2(6u, 1u));
	block[0].s[1].b[0] = (mat2x4(-8.0, -2.0, 7.0, -9.0, 6.0, 6.0, -9.0, 1.0));
	block[0].s[1].b[1] = (mat2x4(7.0, 7.0, -2.0, -3.0, -4.0, -7.0, -7.0, -1.0));
	block[0].s[1].b[2] = (mat2x4(5.0, -4.0, -9.0, -7.0, -6.0, -3.0, 8.0, -5.0));
	block[0].s[1].b[3] = (mat2x4(0.0, 5.0, 4.0, -2.0, -1.0, -4.0, 7.0, -6.0));
	block[0].s[1].c = (vec3(0.0, 8.0, -2.0));
	block[0].s[2].a = (uvec2(0u, 7u));
	block[0].s[2].b[0] = (mat2x4(-7.0, 3.0, -4.0, -3.0, 4.0, 4.0, 6.0, 8.0));
	block[0].s[2].b[1] = (mat2x4(-5.0, -9.0, -7.0, -1.0, -4.0, 3.0, -1.0, -1.0));
	block[0].s[2].b[2] = (mat2x4(3.0, -7.0, -6.0, -3.0, 2.0, 3.0, 7.0, 8.0));
	block[0].s[2].b[3] = (mat2x4(-3.0, 6.0, -7.0, 3.0, -3.0, 0.0, 8.0, -1.0));
	block[0].s[2].c = (vec3(-8.0, -8.0, -7.0));
	block[0].s[3].a = (uvec2(0u, 1u));
	block[0].s[3].b[0] = (mat2x4(-6.0, -9.0, -9.0, -5.0, -7.0, -9.0, -6.0, 9.0));
	block[0].s[3].b[1] = (mat2x4(-8.0, 4.0, 8.0, -9.0, -7.0, -3.0, -2.0, -7.0));
	block[0].s[3].b[2] = (mat2x4(-8.0, 0.0, 4.0, -5.0, -9.0, -2.0, -8.0, -5.0));
	block[0].s[3].b[3] = (mat2x4(-9.0, -8.0, 1.0, -8.0, -9.0, 5.0, -4.0, 1.0));
	block[0].s[3].c = (vec3(8.0, -4.0, -4.0));
	block[1].v = (1u);
	block[1].s[0].a = (uvec2(9u, 5u));
	block[1].s[0].b[0] = (mat2x4(-4.0, -5.0, 7.0, -2.0, 8.0, -7.0, 5.0, 6.0));
	block[1].s[0].b[1] = (mat2x4(-4.0, 0.0, 5.0, -1.0, 0.0, -3.0, 0.0, 0.0));
	block[1].s[0].b[2] = (mat2x4(-4.0, 2.0, -7.0, 3.0, 0.0, -1.0, 9.0, 2.0));
	block[1].s[0].b[3] = (mat2x4(6.0, 1.0, -9.0, 2.0, 8.0, -7.0, -3.0, -1.0));
	block[1].s[0].c = (vec3(-1.0, -9.0, -7.0));
	block[1].s[1].a = (uvec2(2u, 9u));
	block[1].s[1].b[0] = (mat2x4(4.0, -7.0, 8.0, -9.0, 4.0, -2.0, 8.0, 2.0));
	block[1].s[1].b[1] = (mat2x4(1.0, 4.0, -2.0, -9.0, 2.0, -9.0, 6.0, -4.0));
	block[1].s[1].b[2] = (mat2x4(5.0, 4.0, 5.0, 5.0, -2.0, 9.0, -3.0, 1.0));
	block[1].s[1].b[3] = (mat2x4(-3.0, -6.0, -9.0, -2.0, 2.0, 6.0, -9.0, -6.0));
	block[1].s[1].c = (vec3(6.0, -4.0, -8.0));
	block[1].s[2].a = (uvec2(8u, 2u));
	block[1].s[2].b[0] = (mat2x4(-5.0, 8.0, 3.0, 8.0, 5.0, -6.0, -3.0, -4.0));
	block[1].s[2].b[1] = (mat2x4(9.0, -6.0, -9.0, 1.0, -3.0, -2.0, 5.0, 4.0));
	block[1].s[2].b[2] = (mat2x4(1.0, -7.0, 2.0, 8.0, 2.0, 1.0, 7.0, 2.0));
	block[1].s[2].b[3] = (mat2x4(-6.0, -1.0, -8.0, 5.0, 4.0, -9.0, -7.0, -9.0));
	block[1].s[2].c = (vec3(-8.0, 3.0, -5.0));
	block[1].s[3].a = (uvec2(6u, 4u));
	block[1].s[3].b[0] = (mat2x4(-2.0, 9.0, -6.0, -3.0, 6.0, 3.0, -8.0, -5.0));
	block[1].s[3].b[1] = (mat2x4(-8.0, 0.0, 8.0, 3.0, -7.0, 0.0, -2.0, 3.0));
	block[1].s[3].b[2] = (mat2x4(2.0, 7.0, 0.0, 1.0, -4.0, -6.0, 3.0, 9.0));
	block[1].s[3].b[3] = (mat2x4(5.0, 4.0, 7.0, -1.0, -6.0, -6.0, -8.0, -9.0));
	block[1].s[3].c = (vec3(5.0, 1.0, -1.0));
	block[2].v = (6u);
	block[2].s[0].a = (uvec2(4u, 3u));
	block[2].s[0].b[0] = (mat2x4(-6.0, 3.0, -1.0, 8.0, 0.0, 9.0, -8.0, -9.0));
	block[2].s[0].b[1] = (mat2x4(6.0, 7.0, 3.0, -4.0, -2.0, -6.0, -3.0, -1.0));
	block[2].s[0].b[2] = (mat2x4(-9.0, -4.0, -9.0, -5.0, 2.0, 4.0, -4.0, 1.0));
	block[2].s[0].b[3] = (mat2x4(-2.0, -2.0, 4.0, 0.0, -6.0, 6.0, 6.0, -8.0));
	block[2].s[0].c = (vec3(-6.0, -9.0, -1.0));
	block[2].s[1].a = (uvec2(7u, 0u));
	block[2].s[1].b[0] = (mat2x4(-6.0, 9.0, 6.0, 5.0, -1.0, -7.0, -9.0, -6.0));
	block[2].s[1].b[1] = (mat2x4(-8.0, 2.0, 0.0, 6.0, -6.0, 6.0, 2.0, 1.0));
	block[2].s[1].b[2] = (mat2x4(-8.0, -9.0, 0.0, 0.0, -3.0, -5.0, -8.0, 2.0));
	block[2].s[1].b[3] = (mat2x4(-8.0, -3.0, 4.0, 3.0, 4.0, 5.0, -4.0, 2.0));
	block[2].s[1].c = (vec3(6.0, 0.0, 9.0));
	block[2].s[2].a = (uvec2(3u, 1u));
	block[2].s[2].b[0] = (mat2x4(-7.0, -9.0, -4.0, 7.0, -2.0, 7.0, 6.0, 2.0));
	block[2].s[2].b[1] = (mat2x4(-3.0, -2.0, 2.0, 7.0, 1.0, -1.0, 0.0, 7.0));
	block[2].s[2].b[2] = (mat2x4(7.0, 1.0, -8.0, 6.0, -9.0, 5.0, 0.0, -6.0));
	block[2].s[2].b[3] = (mat2x4(-3.0, -2.0, -3.0, -8.0, 7.0, -3.0, 1.0, -5.0));
	block[2].s[2].c = (vec3(-3.0, 8.0, -9.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(7, 0, 8)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(8.0, 8.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(8, 0, 9)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-8.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-8.0, 9.0, 0.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(1, 2, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(3, 8, 0)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-3.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(6, 1, 5)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(9.0, 7.0, 8.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(6, 9, -8)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-5.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-7, 9, 0)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-8.0, 4.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-5, -5, 7)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(1.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(4, -1, 1)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-3.0, -1.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(-6, -3, -2)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-2.0, 0.0, -2.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-7, 6, 4)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-2.0, -3.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-5.0, 3.0, -2.0, -9.0));
	block[0].s[0][0].a = (ivec3(-6, 1, -4));
	block[0].s[0][0].c = (vec4(6.0, 4.0, -6.0, 2.0));
	block[0].s[0][1].a = (ivec3(5, -3, 0));
	block[0].s[0][1].c = (vec4(-2.0, -9.0, 5.0, 6.0));
	block[0].s[1][0].a = (ivec3(0, 4, 4));
	block[0].s[1][0].c = (vec4(5.0, 5.0, 1.0, -1.0));
	block[0].s[1][1].a = (ivec3(5, -1, 1));
	block[0].s[1][1].c = (vec4(6.0, -9.0, -4.0, 6.0));
	block[0].s[2][0].a = (ivec3(-7, -8, -9));
	block[0].s[2][0].c = (vec4(-6.0, -4.0, 5.0, 0.0));
	block[0].s[2][1].a = (ivec3(-7, -7, 8));
	block[0].s[2][1].c = (vec4(-3.0, 7.0, 5.0, -4.0));
	block[1].v = (vec4(-2.0, 8.0, 4.0, 8.0));
	block[1].s[0][0].a = (ivec3(-5, -8, 6));
	block[1].s[0][0].c = (vec4(-7.0, 2.0, 0.0, 0.0));
	block[1].s[0][1].a = (ivec3(7, 9, -3));
	block[1].s[0][1].c = (vec4(-1.0, -7.0, -8.0, 1.0));
	block[1].s[1][0].a = (ivec3(-5, -9, -5));
	block[1].s[1][0].c = (vec4(0.0, 1.0, -9.0, 0.0));
	block[1].s[1][1].a = (ivec3(5, 9, 5));
	block[1].s[1][1].c = (vec4(8.0, -7.0, 8.0, 1.0));
	block[2].v = (vec4(0.0, -4.0, -7.0, -3.0));
	block[2].s[0][0].a = (ivec3(1, -1, -2));
	block[2].s[0][0].c = (vec4(2.0, 2.0, -2.0, 3.0));
	block[2].s[0][1].a = (ivec3(-9, 7, -7));
	block[2].s[0][1].c = (vec4(-7.0, 7.0, 0.0, -2.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block[0].var, mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block[1].var = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block[2].var = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block[0].var, mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(1.0, 2.0, 6.0, -6.0));
	block[1].var = (mat2(2.0, 4.0, 4.0, 7.0));
	block[2].var = (mat2(0.0, 8.0, 0.0, -1.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -6.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(9.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-3.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(2.0, -5.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(-6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(0.0, 0.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(7.0, -9.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-6.0, -4.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(4.0, 4.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(2.0, 0.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-3.0, 4.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(-2.0, -5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block[1].var = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block[2].var = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
}
#version 450
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
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block[1].var = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block[2].var = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
}
#version 450
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
} block[3];

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
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(6.0, -3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -4.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(1.0, -4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -2.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(6.0, -2.0));
	block[0].var[1] = (vec2(2.0, 8.0));
	block[0].var[2] = (vec2(-5.0, 3.0));
	block[0].var[3] = (vec2(-1.0, -7.0));
	block[1].var[0] = (vec2(4.0, 2.0));
	block[1].var[1] = (vec2(-4.0, 8.0));
	block[1].var[2] = (vec2(3.0, 8.0));
	block[1].var[3] = (vec2(-1.0, 6.0));
	block[2].var[0] = (vec2(-8.0, 2.0));
	block[2].var[1] = (vec2(-5.0, 5.0));
	block[2].var[2] = (vec2(-4.0, -9.0));
	block[2].var[3] = (vec2(0.0, 4.0));
}
#version 450
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
	allOk = compare_float((blockA.a), 7.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-5.0, -3.0, -5.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-1, 5)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-6.0);
	blockB.a = (mat3(3.0, -3.0, 5.0, 4.0, -5.0, -4.0, -5.0, -3.0, -8.0));
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
	lowp float a[1];
	mediump int b;
	lowp float c;
	highp uint d;
	lowp float e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a[0]), 1.0) && allOk;
	allOk = compare_int((blockB.b), -5) && allOk;
	allOk = compare_float((blockB.c), -9.0) && allOk;
	allOk = compare_float((blockB.e), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (7u);
	blockB.e = (-8.0);
}
#version 450
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
	highp vec3 a;
	lowp mat4 b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp uvec2 c;
	lowp vec2 d;
	lowp uint e;
	lowp ivec3 f;
	highp ivec4 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4(b[0], mat4(2.0, -5.0, 6.0, 3.0, 0.0, -2.0, 2.0, 5.0, -3.0, -7.0, 3.0, -5.0, 1.0, 3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4(b[1], mat4(-6.0, -3.0, 2.0, 1.0, 6.0, -9.0, 4.0, 9.0, -8.0, 9.0, -4.0, -1.0, 7.0, 8.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4(b[2], mat4(-9.0, 7.0, 1.0, -6.0, -2.0, -4.0, 9.0, -3.0, -2.0, -5.0, -8.0, 6.0, 1.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(b[3], mat4(1.0, 0.0, -3.0, 7.0, 3.0, 9.0, -4.0, -6.0, 4.0, -5.0, -1.0, -8.0, 1.0, -2.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4(b[4], mat4(8.0, -7.0, 4.0, -3.0, 9.0, -6.0, 7.0, 6.0, 2.0, -7.0, 2.0, 7.0, 0.0, 0.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(b[5], mat4(5.0, 0.0, -5.0, 9.0, 8.0, 5.0, 7.0, -2.0, 5.0, 8.0, -6.0, 2.0, 7.0, -7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4(b[6], mat4(-7.0, 6.0, 3.0, 7.0, -5.0, -2.0, -5.0, 1.0, 9.0, 2.0, -8.0, 3.0, 6.0, -4.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(b[7], mat4(-4.0, 8.0, 5.0, 6.0, -8.0, 0.0, 7.0, 2.0, 4.0, -8.0, -4.0, 9.0, 8.0, 0.0, 9.0, -1.0)) && allOk;
	allOk = compare_uint((blockC.e), 5u) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-4, 2, 8)) && allOk;
	allOk = compare_ivec4((blockC.g[0]), ivec4(4, 9, 0, -6)) && allOk;
	allOk = compare_ivec4((blockC.g[1]), ivec4(-3, -3, 8, 1)) && allOk;
	allOk = compare_ivec4((blockC.g[2]), ivec4(-7, -2, -5, 2)) && allOk;
	allOk = compare_ivec4((blockC.g[3]), ivec4(6, -1, 3, -1)) && allOk;
	allOk = compare_ivec4((blockC.g[4]), ivec4(1, 4, -4, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (uvec2(0u, 8u));
	blockC.e = (0u);
	blockC.f = (ivec3(-1, -7, -8));
}
#version 450
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
	lowp float mB;
	mediump vec4 mC;
	lowp ivec2 mD;
};
struct sB
{
	bvec3 mA;
};
struct sC
{
	bool mA;
};
struct sD
{
	sC mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	bvec2 a[2];
	lowp uvec2 b;
	lowp mat4 c[1];
	bvec4 d[1];
	bvec2 e[][2];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp float f;
	sA g[4];
	sB h;
	bool i;
	mediump mat4x2 j[][6];
};
layout(std140, binding = 3) buffer BlockD
{
	lowp vec2 k;
	mediump mat3x2 l;
	mediump vec3 m;
	sD n;
	mediump mat2x3 o[];
};
layout(std430, binding = 4) buffer BlockE
{
	highp vec2 p;
	mediump uvec4 q;
	lowp float r[6];
	highp uvec2 s;
	mediump ivec4 t[][5];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.a[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec4((blockB.d[0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_float((f), -7.0) && allOk;
	allOk = compare_bvec3((h.mA), bvec3(true, true, true)) && allOk;
	allOk = compare_bool((i), true) && allOk;
	allOk = compare_mat4x2(j[0][0], mat4x2(-3.0, -5.0, 5.0, 5.0, -7.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(j[0][1], mat4x2(-6.0, -1.0, 6.0, 7.0, 0.0, 5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(j[0][2], mat4x2(-8.0, -1.0, 0.0, 1.0, 4.0, -9.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(j[0][3], mat4x2(8.0, 1.0, 2.0, 6.0, -2.0, -4.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4x2(j[0][4], mat4x2(8.0, 8.0, -7.0, 2.0, 3.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(j[0][5], mat4x2(-7.0, 3.0, 0.0, 2.0, -6.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(j[1][0], mat4x2(9.0, -8.0, 9.0, 3.0, 7.0, -4.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(j[1][1], mat4x2(9.0, -7.0, -4.0, 2.0, 1.0, 7.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(j[1][2], mat4x2(7.0, -5.0, 1.0, -8.0, -8.0, 1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(j[1][3], mat4x2(-9.0, -4.0, -3.0, -4.0, -4.0, 9.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(j[1][4], mat4x2(3.0, 8.0, 0.0, 2.0, 5.0, 0.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x2(j[1][5], mat4x2(-1.0, -1.0, -6.0, -9.0, -1.0, 1.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(j[2][0], mat4x2(-2.0, -4.0, 9.0, -4.0, 2.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(j[2][1], mat4x2(-7.0, -1.0, -7.0, 7.0, -2.0, 3.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(j[2][2], mat4x2(-9.0, 0.0, 1.0, -7.0, 7.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(j[2][3], mat4x2(-5.0, -7.0, 2.0, 0.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(j[2][4], mat4x2(-1.0, -2.0, -8.0, 1.0, -4.0, -5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(j[2][5], mat4x2(6.0, -1.0, -3.0, 3.0, 4.0, 9.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec2((k), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec3((m), vec3(-2.0, -1.0, -9.0)) && allOk;
	allOk = compare_bool((n.mA.mA), false) && allOk;
	allOk = compare_vec2((blockE.p), vec2(-6.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockE.s), uvec2(2u, 8u)) && allOk;
	allOk = compare_ivec4((blockE.t[0][0]), ivec4(7, 3, 7, 9)) && allOk;
	allOk = compare_ivec4((blockE.t[0][1]), ivec4(-4, 5, -2, -1)) && allOk;
	allOk = compare_ivec4((blockE.t[0][2]), ivec4(-4, -1, -1, 4)) && allOk;
	allOk = compare_ivec4((blockE.t[0][3]), ivec4(2, -5, 0, 1)) && allOk;
	allOk = compare_ivec4((blockE.t[0][4]), ivec4(3, 6, 0, -5)) && allOk;
	allOk = compare_ivec4((blockE.t[1][0]), ivec4(4, 1, 1, 4)) && allOk;
	allOk = compare_ivec4((blockE.t[1][1]), ivec4(-6, -6, -8, -4)) && allOk;
	allOk = compare_ivec4((blockE.t[1][2]), ivec4(2, 2, -5, 4)) && allOk;
	allOk = compare_ivec4((blockE.t[1][3]), ivec4(5, 4, 9, -9)) && allOk;
	allOk = compare_ivec4((blockE.t[1][4]), ivec4(6, -3, -1, 4)) && allOk;
	allOk = compare_ivec4((blockE.t[2][0]), ivec4(7, -4, 0, 5)) && allOk;
	allOk = compare_ivec4((blockE.t[2][1]), ivec4(9, 5, -5, -5)) && allOk;
	allOk = compare_ivec4((blockE.t[2][2]), ivec4(4, 1, 3, 4)) && allOk;
	allOk = compare_ivec4((blockE.t[2][3]), ivec4(4, -3, -3, -4)) && allOk;
	allOk = compare_ivec4((blockE.t[2][4]), ivec4(4, -2, -5, 3)) && allOk;
	allOk = compare_ivec4((blockE.t[3][0]), ivec4(3, 1, -7, 1)) && allOk;
	allOk = compare_ivec4((blockE.t[3][1]), ivec4(-3, -1, 8, 8)) && allOk;
	allOk = compare_ivec4((blockE.t[3][2]), ivec4(0, 7, -3, -9)) && allOk;
	allOk = compare_ivec4((blockE.t[3][3]), ivec4(4, -4, 1, 3)) && allOk;
	allOk = compare_ivec4((blockE.t[3][4]), ivec4(-2, -4, 4, -1)) && allOk;
	allOk = compare_ivec4((blockE.t[4][0]), ivec4(7, 3, -2, 4)) && allOk;
	allOk = compare_ivec4((blockE.t[4][1]), ivec4(-4, -8, 2, 1)) && allOk;
	allOk = compare_ivec4((blockE.t[4][2]), ivec4(8, -4, -4, -5)) && allOk;
	allOk = compare_ivec4((blockE.t[4][3]), ivec4(8, 0, 5, -4)) && allOk;
	allOk = compare_ivec4((blockE.t[4][4]), ivec4(5, -5, 6, 8)) && allOk;
	allOk = compare_ivec4((blockE.t[5][0]), ivec4(5, -2, 2, -7)) && allOk;
	allOk = compare_ivec4((blockE.t[5][1]), ivec4(-3, -1, 2, 5)) && allOk;
	allOk = compare_ivec4((blockE.t[5][2]), ivec4(-5, 7, -9, 0)) && allOk;
	allOk = compare_ivec4((blockE.t[5][3]), ivec4(-8, 9, 9, -2)) && allOk;
	allOk = compare_ivec4((blockE.t[5][4]), ivec4(-6, 8, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(2u, 9u));
	blockB.c[0] = (mat4(-2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0));
	blockB.d[0] = (bvec4(false, false, true, false));
	blockB.e[0][0] = (bvec2(true, true));
	blockB.e[0][1] = (bvec2(true, false));
	blockB.e[1][0] = (bvec2(false, true));
	blockB.e[1][1] = (bvec2(true, true));
	blockB.e[2][0] = (bvec2(false, false));
	blockB.e[2][1] = (bvec2(false, false));
	blockB.e[3][0] = (bvec2(false, false));
	blockB.e[3][1] = (bvec2(false, false));
	blockB.e[4][0] = (bvec2(true, true));
	blockB.e[4][1] = (bvec2(true, false));
	blockB.e[5][0] = (bvec2(true, true));
	blockB.e[5][1] = (bvec2(true, true));
	blockB.e[6][0] = (bvec2(false, false));
	blockB.e[6][1] = (bvec2(false, true));
	f = (-2.0);
	g[0].mA = (vec4(1.0, 8.0, -2.0, -4.0));
	g[0].mB = (-9.0);
	g[0].mC = (vec4(1.0, 6.0, 9.0, -8.0));
	g[0].mD = (ivec2(-3, -6));
	g[1].mA = (vec4(-5.0, 8.0, -8.0, -8.0));
	g[1].mB = (-4.0);
	g[1].mC = (vec4(-1.0, 5.0, -6.0, -8.0));
	g[1].mD = (ivec2(3, -6));
	g[2].mA = (vec4(6.0, 4.0, 5.0, 8.0));
	g[2].mB = (1.0);
	g[2].mC = (vec4(3.0, -1.0, 5.0, -5.0));
	g[2].mD = (ivec2(-7, 1));
	g[3].mA = (vec4(3.0, -1.0, 1.0, 0.0));
	g[3].mB = (-2.0);
	g[3].mC = (vec4(-5.0, 2.0, -7.0, 4.0));
	g[3].mD = (ivec2(5, -9));
	h.mA = (bvec3(false, true, true));
	i = (true);
	j[0][0] = (mat4x2(-8.0, -5.0, -5.0, -9.0, 9.0, 6.0, 0.0, -8.0));
	j[0][1] = (mat4x2(4.0, 7.0, 7.0, -9.0, 8.0, 1.0, 7.0, -9.0));
	j[0][2] = (mat4x2(-7.0, -6.0, 6.0, -5.0, -2.0, -1.0, 7.0, 9.0));
	j[0][3] = (mat4x2(-7.0, 8.0, 5.0, -4.0, -3.0, -2.0, -2.0, -7.0));
	j[0][4] = (mat4x2(-4.0, 6.0, -8.0, -4.0, 2.0, 7.0, 6.0, 7.0));
	j[0][5] = (mat4x2(1.0, 9.0, -2.0, 7.0, 5.0, -2.0, -8.0, 2.0));
	j[1][0] = (mat4x2(9.0, -4.0, -6.0, 3.0, -6.0, 1.0, 5.0, 6.0));
	j[1][1] = (mat4x2(2.0, -7.0, -2.0, 9.0, -1.0, 5.0, -8.0, -7.0));
	j[1][2] = (mat4x2(1.0, -1.0, 9.0, -2.0, 3.0, -7.0, -8.0, -3.0));
	j[1][3] = (mat4x2(5.0, 0.0, 8.0, 7.0, 4.0, 1.0, 5.0, 0.0));
	j[1][4] = (mat4x2(6.0, 2.0, -3.0, 4.0, -3.0, 8.0, -6.0, 0.0));
	j[1][5] = (mat4x2(-7.0, -5.0, 7.0, -7.0, -4.0, -1.0, -8.0, -9.0));
	j[2][0] = (mat4x2(3.0, 0.0, -9.0, 3.0, -3.0, 6.0, -2.0, -2.0));
	j[2][1] = (mat4x2(7.0, -1.0, -6.0, 7.0, -4.0, 4.0, -2.0, 5.0));
	j[2][2] = (mat4x2(6.0, -5.0, -8.0, -6.0, -8.0, 2.0, -6.0, 8.0));
	j[2][3] = (mat4x2(8.0, 0.0, -1.0, -4.0, 9.0, -8.0, -7.0, -3.0));
	j[2][4] = (mat4x2(3.0, -2.0, -4.0, 3.0, -6.0, 7.0, 5.0, 8.0));
	j[2][5] = (mat4x2(-3.0, -6.0, -8.0, 0.0, 9.0, -5.0, -6.0, -2.0));
	m = (vec3(8.0, -4.0, 1.0));
	n.mA.mA = (false);
	o[0] = (mat2x3(1.0, 5.0, -9.0, -5.0, -7.0, 5.0));
	o[1] = (mat2x3(7.0, -9.0, -1.0, 1.0, 0.0, -9.0));
	o[2] = (mat2x3(-8.0, -3.0, -3.0, 4.0, 4.0, 0.0));
	o[3] = (mat2x3(9.0, -6.0, 3.0, 4.0, 7.0, -2.0));
	o[4] = (mat2x3(-5.0, 8.0, -2.0, 6.0, -5.0, -2.0));
	o[5] = (mat2x3(-9.0, -4.0, 5.0, -2.0, 1.0, -1.0));
	blockE.p = (vec2(7.0, 7.0));
	blockE.r[0] = (8.0);
	blockE.r[1] = (-7.0);
	blockE.r[2] = (5.0);
	blockE.r[3] = (9.0);
	blockE.r[4] = (-1.0);
	blockE.r[5] = (3.0);
	blockE.t[0][0] = (ivec4(7, 8, 2, 0));
	blockE.t[0][1] = (ivec4(-4, 5, -1, -6));
	blockE.t[0][2] = (ivec4(-5, -4, -2, 6));
	blockE.t[0][3] = (ivec4(-9, 5, -5, -8));
	blockE.t[0][4] = (ivec4(4, 9, 3, -1));
	blockE.t[1][0] = (ivec4(-8, 5, -5, 3));
	blockE.t[1][1] = (ivec4(4, -2, 7, 2));
	blockE.t[1][2] = (ivec4(-1, -8, 7, -6));
	blockE.t[1][3] = (ivec4(-6, -6, -3, -7));
	blockE.t[1][4] = (ivec4(-9, -3, 5, -6));
	blockE.t[2][0] = (ivec4(0, -4, 0, -8));
	blockE.t[2][1] = (ivec4(8, 1, 6, 4));
	blockE.t[2][2] = (ivec4(-7, 9, 1, 9));
	blockE.t[2][3] = (ivec4(4, -6, -1, 4));
	blockE.t[2][4] = (ivec4(9, -9, 4, 0));
	blockE.t[3][0] = (ivec4(-7, -7, -3, -8));
	blockE.t[3][1] = (ivec4(3, 5, -2, -7));
	blockE.t[3][2] = (ivec4(-3, -5, 5, 1));
	blockE.t[3][3] = (ivec4(-4, 1, -8, 3));
	blockE.t[3][4] = (ivec4(-2, -7, 7, -2));
	blockE.t[4][0] = (ivec4(9, -3, -5, -2));
	blockE.t[4][1] = (ivec4(-8, 4, -8, -5));
	blockE.t[4][2] = (ivec4(4, -9, -2, 0));
	blockE.t[4][3] = (ivec4(-6, 4, 3, 7));
	blockE.t[4][4] = (ivec4(-4, 7, -2, -1));
	blockE.t[5][0] = (ivec4(-2, 3, 9, -6));
	blockE.t[5][1] = (ivec4(-3, 4, -2, 7));
	blockE.t[5][2] = (ivec4(-4, 8, 4, -7));
	blockE.t[5][3] = (ivec4(-7, 7, -1, -9));
	blockE.t[5][4] = (ivec4(-3, -8, -2, -3));
}
#version 450
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
	mediump uvec3 mA;
	mediump vec3 mB;
	mediump mat2 mC;
};
struct sB
{
	lowp uvec3 mA;
};
struct sC
{
	sB mA;
	highp vec4 mB;
	highp mat4x2 mC;
	bvec4 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump mat4 a;
	highp float b;
	bool c[4];
	highp mat4 d;
};
layout(std140, binding = 2) buffer BlockC
{
	bool e;
	bvec2 f;
	highp uvec4 g;
	bvec3 h;
	mediump ivec3 i;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	sA j;
	sC k;
	mediump mat2x3 l;
	lowp mat4x2 m;
	lowp uint n[4];
} blockD[2];
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp vec3 o;
	highp mat2 p;
	highp mat4 q[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((c[0]), false) && allOk;
	allOk = compare_bool((c[1]), false) && allOk;
	allOk = compare_bool((c[2]), false) && allOk;
	allOk = compare_bool((c[3]), false) && allOk;
	allOk = compare_mat4(d, mat4(-8.0, 9.0, -4.0, -1.0, 7.0, 8.0, -4.0, 6.0, -3.0, 2.0, 1.0, -9.0, -9.0, 4.0, 9.0, -2.0)) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(3u, 3u, 3u, 7u)) && allOk;
	allOk = compare_bvec3((blockC.h), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec3((blockD[0].j.mA), uvec3(1u, 8u, 4u)) && allOk;
	allOk = compare_vec3((blockD[0].j.mB), vec3(0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD[0].j.mC, mat2(-2.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockD[0].l, mat2x3(4.0, 5.0, 8.0, 5.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].m, mat4x2(5.0, 8.0, -7.0, -5.0, 7.0, -6.0, 4.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[0].n[0]), 6u) && allOk;
	allOk = compare_uint((blockD[0].n[1]), 5u) && allOk;
	allOk = compare_uint((blockD[0].n[2]), 3u) && allOk;
	allOk = compare_uint((blockD[0].n[3]), 4u) && allOk;
	allOk = compare_uvec3((blockD[1].j.mA), uvec3(6u, 3u, 9u)) && allOk;
	allOk = compare_vec3((blockD[1].j.mB), vec3(6.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2(blockD[1].j.mC, mat2(-4.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].l, mat2x3(-9.0, 4.0, -5.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].m, mat4x2(2.0, 8.0, 4.0, 9.0, 0.0, -6.0, -3.0, -3.0)) && allOk;
	allOk = compare_uint((blockD[1].n[0]), 3u) && allOk;
	allOk = compare_uint((blockD[1].n[1]), 7u) && allOk;
	allOk = compare_uint((blockD[1].n[2]), 8u) && allOk;
	allOk = compare_uint((blockD[1].n[3]), 1u) && allOk;
	allOk = compare_mat2(p, mat2(-1.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4(q[0], mat4(4.0, 4.0, 5.0, 4.0, -4.0, 0.0, -7.0, -2.0, 7.0, 5.0, -3.0, 4.0, 8.0, 5.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4(q[1], mat4(9.0, -5.0, 4.0, -5.0, -1.0, 7.0, -7.0, -7.0, 0.0, 5.0, -3.0, -8.0, 9.0, -1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4(q[2], mat4(3.0, 1.0, -6.0, 2.0, 9.0, -7.0, 8.0, -3.0, -6.0, 3.0, -9.0, -9.0, 9.0, -3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4(q[3], mat4(4.0, -8.0, -4.0, -9.0, -7.0, -1.0, 1.0, 1.0, 4.0, 0.0, -8.0, -4.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4(q[4], mat4(-5.0, 8.0, 2.0, -4.0, 1.0, 3.0, 0.0, -5.0, 0.0, -6.0, 0.0, 2.0, 1.0, 3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4(q[5], mat4(0.0, -7.0, -4.0, -8.0, 7.0, -3.0, -8.0, -7.0, 2.0, -9.0, -7.0, 1.0, -8.0, -1.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4(5.0, -5.0, -9.0, -4.0, -5.0, -5.0, 2.0, 8.0, 3.0, 0.0, -4.0, 6.0, 9.0, -1.0, -8.0, -3.0));
	d = (mat4(9.0, 9.0, 8.0, -9.0, -1.0, -8.0, -8.0, 5.0, 1.0, -6.0, 4.0, 6.0, 7.0, 4.0, 6.0, 1.0));
	blockC.e = (false);
	blockC.f = (bvec2(true, true));
	blockC.g = (uvec4(0u, 9u, 8u, 9u));
	blockD[0].k.mA.mA = (uvec3(8u, 8u, 3u));
	blockD[0].k.mB = (vec4(-1.0, -7.0, -2.0, -2.0));
	blockD[0].k.mC = (mat4x2(-7.0, -8.0, -9.0, -2.0, 6.0, 0.0, -7.0, 3.0));
	blockD[0].k.mD = (bvec4(true, false, true, false));
	blockD[0].l = (mat2x3(4.0, 5.0, 0.0, 7.0, -5.0, 0.0));
	blockD[0].m = (mat4x2(-3.0, 0.0, 8.0, -6.0, 4.0, -6.0, -7.0, -6.0));
	blockD[0].n[0] = (2u);
	blockD[0].n[1] = (7u);
	blockD[0].n[2] = (2u);
	blockD[0].n[3] = (4u);
	blockD[1].k.mA.mA = (uvec3(8u, 8u, 0u));
	blockD[1].k.mB = (vec4(9.0, 0.0, 4.0, 1.0));
	blockD[1].k.mC = (mat4x2(-4.0, 1.0, -6.0, 3.0, 8.0, 4.0, 9.0, 9.0));
	blockD[1].k.mD = (bvec4(false, true, false, true));
	blockD[1].l = (mat2x3(0.0, -6.0, -1.0, -7.0, -8.0, 3.0));
	blockD[1].m = (mat4x2(7.0, -3.0, -1.0, -6.0, 5.0, 5.0, -2.0, -1.0));
	blockD[1].n[0] = (9u);
	blockD[1].n[1] = (9u);
	blockD[1].n[2] = (6u);
	blockD[1].n[3] = (0u);
	o = (vec3(2.0, 6.0, -7.0));
	p = (mat2(-9.0, 5.0, -9.0, 0.0));
}
#version 450
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
	bvec2 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat4x3 b;
	mediump uvec2 c;
	highp ivec4 d;
	bool e[3];
	bool f[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump ivec3 g[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp vec3 h[8];
	bvec2 i;
	highp uvec3 j;
	mediump mat3 k;
	highp mat2 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.a[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.a[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.a[3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.a[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.a[5]), bvec2(false, false)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec2((c), uvec2(9u, 1u)) && allOk;
	allOk = compare_ivec4((d), ivec4(-4, -3, 1, -4)) && allOk;
	allOk = compare_bool((e[0]), true) && allOk;
	allOk = compare_bool((e[1]), true) && allOk;
	allOk = compare_bool((e[2]), false) && allOk;
	allOk = compare_bool((f[0]), true) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(0u, 2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x3(-7.0, -4.0, 8.0, 2.0, -9.0, 0.0, 4.0, 3.0, -1.0, -6.0, -4.0, -5.0));
	c = (uvec2(4u, 3u));
	d = (ivec4(6, -6, -2, -8));
	f[0] = (true);
	g[0] = (ivec3(-1, -1, 1));
	blockE.h[0] = (vec3(7.0, 8.0, 7.0));
	blockE.h[1] = (vec3(0.0, -5.0, 6.0));
	blockE.h[2] = (vec3(5.0, -6.0, -6.0));
	blockE.h[3] = (vec3(6.0, 6.0, -6.0));
	blockE.h[4] = (vec3(3.0, 2.0, -4.0));
	blockE.h[5] = (vec3(5.0, -9.0, 5.0));
	blockE.h[6] = (vec3(-9.0, -5.0, -1.0));
	blockE.h[7] = (vec3(-8.0, -7.0, 8.0));
	blockE.i = (bvec2(true, true));
	blockE.j = (uvec3(4u, 8u, 9u));
	blockE.k = (mat3(-1.0, 5.0, -3.0, -9.0, -7.0, -4.0, 7.0, 5.0, -1.0));
	blockE.l[0] = (mat2(7.0, 2.0, -9.0, -7.0));
	blockE.l[1] = (mat2(1.0, -7.0, -9.0, 3.0));
	blockE.l[2] = (mat2(3.0, 8.0, -2.0, 2.0));
	blockE.l[3] = (mat2(-1.0, -4.0, 7.0, -2.0));
	blockE.l[4] = (mat2(7.0, -1.0, -7.0, 8.0));
	blockE.l[5] = (mat2(0.0, 0.0, 1.0, 0.0));
	blockE.l[6] = (mat2(4.0, 2.0, 4.0, 7.0));
}
#version 450
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
	highp ivec3 mB;
	highp ivec3 mC;
};
struct sB
{
	sA mA;
	bvec3 mB;
	lowp vec3 mC[7][5];
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp ivec2 a;
	lowp ivec3 b;
	sB c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(2, -3)) && allOk;
	allOk = compare_vec2((blockB.c[0].mA.mA), vec2(6.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockB.c[0].mA.mB), ivec3(4, -3, -7)) && allOk;
	allOk = compare_ivec3((blockB.c[0].mA.mC), ivec3(7, 6, -5)) && allOk;
	allOk = compare_bvec3((blockB.c[0].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[0][0]), vec3(-6.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[0][1]), vec3(8.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[0][2]), vec3(-2.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[0][3]), vec3(7.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[0][4]), vec3(1.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[1][0]), vec3(8.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[1][1]), vec3(3.0, 4.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[1][2]), vec3(-3.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[1][3]), vec3(-2.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[1][4]), vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[2][0]), vec3(7.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[2][1]), vec3(3.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[2][2]), vec3(3.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[2][3]), vec3(-1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[2][4]), vec3(-3.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[3][0]), vec3(2.0, 5.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[3][1]), vec3(3.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[3][2]), vec3(-5.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[3][3]), vec3(6.0, -2.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[3][4]), vec3(6.0, 1.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[4][0]), vec3(5.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[4][1]), vec3(-4.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[4][2]), vec3(4.0, -4.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[4][3]), vec3(4.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[4][4]), vec3(-2.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[5][0]), vec3(-7.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[5][1]), vec3(-8.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[5][2]), vec3(0.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[5][3]), vec3(1.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[5][4]), vec3(4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[6][0]), vec3(-4.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[6][1]), vec3(-4.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[6][2]), vec3(8.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[6][3]), vec3(-9.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mC[6][4]), vec3(4.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.c[1].mA.mA), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockB.c[1].mA.mB), ivec3(-7, -1, 9)) && allOk;
	allOk = compare_ivec3((blockB.c[1].mA.mC), ivec3(-9, 2, 9)) && allOk;
	allOk = compare_bvec3((blockB.c[1].mB), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[0][0]), vec3(1.0, 6.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[0][1]), vec3(-4.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[0][2]), vec3(0.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[0][3]), vec3(-7.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[0][4]), vec3(9.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[1][0]), vec3(9.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[1][1]), vec3(9.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[1][2]), vec3(2.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[1][3]), vec3(-4.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[1][4]), vec3(-1.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[2][0]), vec3(3.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[2][1]), vec3(6.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[2][2]), vec3(5.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[2][3]), vec3(-8.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[2][4]), vec3(9.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[3][0]), vec3(-5.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[3][1]), vec3(-6.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[3][2]), vec3(1.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[3][3]), vec3(-6.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[3][4]), vec3(-6.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[4][0]), vec3(-3.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[4][1]), vec3(9.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[4][2]), vec3(-8.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[4][3]), vec3(7.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[4][4]), vec3(-3.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[5][0]), vec3(2.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[5][1]), vec3(-9.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[5][2]), vec3(1.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[5][3]), vec3(2.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[5][4]), vec3(9.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[6][0]), vec3(-4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[6][1]), vec3(7.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[6][2]), vec3(-3.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[6][3]), vec3(-5.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mC[6][4]), vec3(-9.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.c[2].mA.mA), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB.c[2].mA.mB), ivec3(-6, 8, -4)) && allOk;
	allOk = compare_ivec3((blockB.c[2].mA.mC), ivec3(7, 3, 6)) && allOk;
	allOk = compare_bvec3((blockB.c[2].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[0][0]), vec3(-9.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[0][1]), vec3(-6.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[0][2]), vec3(-8.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[0][3]), vec3(5.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[0][4]), vec3(-5.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[1][0]), vec3(9.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[1][1]), vec3(8.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[1][2]), vec3(7.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[1][3]), vec3(7.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[1][4]), vec3(1.0, -1.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[2][0]), vec3(-2.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[2][1]), vec3(-1.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[2][2]), vec3(-6.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[2][3]), vec3(-3.0, 1.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[2][4]), vec3(-4.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[3][0]), vec3(2.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[3][1]), vec3(3.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[3][2]), vec3(8.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[3][3]), vec3(-7.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[3][4]), vec3(-5.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[4][0]), vec3(6.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[4][1]), vec3(2.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[4][2]), vec3(-7.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[4][3]), vec3(8.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[4][4]), vec3(6.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[5][0]), vec3(-1.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[5][1]), vec3(7.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[5][2]), vec3(-4.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[5][3]), vec3(-9.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[5][4]), vec3(3.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[6][0]), vec3(-9.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[6][1]), vec3(4.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[6][2]), vec3(4.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[6][3]), vec3(-1.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mC[6][4]), vec3(-1.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.c[3].mA.mA), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB.c[3].mA.mB), ivec3(4, 1, -6)) && allOk;
	allOk = compare_ivec3((blockB.c[3].mA.mC), ivec3(2, 0, -1)) && allOk;
	allOk = compare_bvec3((blockB.c[3].mB), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[0][0]), vec3(-2.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[0][1]), vec3(-4.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[0][2]), vec3(-2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[0][3]), vec3(-8.0, -6.0, -6.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[0][4]), vec3(0.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[1][0]), vec3(6.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[1][1]), vec3(-7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mC[1][2]), vec3(-1.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0].mA.mA = (vec2(5.0, 9.0));
	blockB.c[0].mA.mB = (ivec3(-2, 3, 0));
	blockB.c[0].mA.mC = (ivec3(-9, 7, -3));
	blockB.c[0].mB = (bvec3(false, false, true));
	blockB.c[0].mC[0][0] = (vec3(-6.0, 0.0, 5.0));
	blockB.c[0].mC[0][1] = (vec3(-3.0, 3.0, -2.0));
	blockB.c[0].mC[0][2] = (vec3(-9.0, -5.0, -3.0));
	blockB.c[0].mC[0][3] = (vec3(-9.0, 7.0, 9.0));
	blockB.c[0].mC[0][4] = (vec3(8.0, 2.0, 9.0));
	blockB.c[0].mC[1][0] = (vec3(-8.0, 8.0, 9.0));
	blockB.c[0].mC[1][1] = (vec3(6.0, 7.0, 5.0));
	blockB.c[0].mC[1][2] = (vec3(-3.0, 7.0, -7.0));
	blockB.c[0].mC[1][3] = (vec3(7.0, 2.0, -6.0));
	blockB.c[0].mC[1][4] = (vec3(1.0, 0.0, 9.0));
	blockB.c[0].mC[2][0] = (vec3(0.0, 3.0, -1.0));
	blockB.c[0].mC[2][1] = (vec3(7.0, 9.0, 4.0));
	blockB.c[0].mC[2][2] = (vec3(4.0, 1.0, -1.0));
	blockB.c[0].mC[2][3] = (vec3(7.0, -3.0, 5.0));
	blockB.c[0].mC[2][4] = (vec3(-8.0, -2.0, -1.0));
	blockB.c[0].mC[3][0] = (vec3(9.0, -2.0, 2.0));
	blockB.c[0].mC[3][1] = (vec3(-8.0, -8.0, -3.0));
	blockB.c[0].mC[3][2] = (vec3(-3.0, 0.0, 6.0));
	blockB.c[0].mC[3][3] = (vec3(-1.0, -1.0, -9.0));
	blockB.c[0].mC[3][4] = (vec3(-8.0, -4.0, -1.0));
	blockB.c[0].mC[4][0] = (vec3(-9.0, 3.0, -3.0));
	blockB.c[0].mC[4][1] = (vec3(5.0, 9.0, 8.0));
	blockB.c[0].mC[4][2] = (vec3(3.0, 0.0, 0.0));
	blockB.c[0].mC[4][3] = (vec3(-8.0, 5.0, 5.0));
	blockB.c[0].mC[4][4] = (vec3(8.0, -3.0, 7.0));
	blockB.c[0].mC[5][0] = (vec3(5.0, -2.0, 7.0));
	blockB.c[0].mC[5][1] = (vec3(-1.0, -9.0, -3.0));
	blockB.c[0].mC[5][2] = (vec3(-8.0, -8.0, 5.0));
	blockB.c[0].mC[5][3] = (vec3(-2.0, -2.0, 8.0));
	blockB.c[0].mC[5][4] = (vec3(8.0, 9.0, 6.0));
	blockB.c[0].mC[6][0] = (vec3(-3.0, -3.0, -1.0));
	blockB.c[0].mC[6][1] = (vec3(-1.0, 7.0, -2.0));
	blockB.c[0].mC[6][2] = (vec3(-7.0, 4.0, 4.0));
	blockB.c[0].mC[6][3] = (vec3(-9.0, 7.0, -7.0));
	blockB.c[0].mC[6][4] = (vec3(-2.0, -4.0, 5.0));
	blockB.c[1].mA.mA = (vec2(-5.0, 4.0));
	blockB.c[1].mA.mB = (ivec3(-8, 6, -7));
	blockB.c[1].mA.mC = (ivec3(-1, -2, -4));
	blockB.c[1].mB = (bvec3(true, true, true));
	blockB.c[1].mC[0][0] = (vec3(7.0, -2.0, -3.0));
	blockB.c[1].mC[0][1] = (vec3(-2.0, -5.0, 8.0));
	blockB.c[1].mC[0][2] = (vec3(-4.0, -3.0, -6.0));
	blockB.c[1].mC[0][3] = (vec3(-1.0, -2.0, -3.0));
	blockB.c[1].mC[0][4] = (vec3(8.0, 1.0, -5.0));
	blockB.c[1].mC[1][0] = (vec3(6.0, 1.0, 5.0));
	blockB.c[1].mC[1][1] = (vec3(-2.0, 4.0, 4.0));
	blockB.c[1].mC[1][2] = (vec3(-9.0, -9.0, 8.0));
	blockB.c[1].mC[1][3] = (vec3(-9.0, 1.0, -1.0));
	blockB.c[1].mC[1][4] = (vec3(2.0, 6.0, 8.0));
	blockB.c[1].mC[2][0] = (vec3(1.0, 2.0, -4.0));
	blockB.c[1].mC[2][1] = (vec3(5.0, 0.0, 6.0));
	blockB.c[1].mC[2][2] = (vec3(5.0, -7.0, -7.0));
	blockB.c[1].mC[2][3] = (vec3(-7.0, -2.0, 4.0));
	blockB.c[1].mC[2][4] = (vec3(9.0, -9.0, -7.0));
	blockB.c[1].mC[3][0] = (vec3(-8.0, -3.0, 3.0));
	blockB.c[1].mC[3][1] = (vec3(0.0, -4.0, 7.0));
	blockB.c[1].mC[3][2] = (vec3(-8.0, -7.0, 8.0));
	blockB.c[1].mC[3][3] = (vec3(-3.0, -5.0, -2.0));
	blockB.c[1].mC[3][4] = (vec3(-7.0, 2.0, -5.0));
	blockB.c[1].mC[4][0] = (vec3(-8.0, 9.0, -9.0));
	blockB.c[1].mC[4][1] = (vec3(5.0, -2.0, 3.0));
	blockB.c[1].mC[4][2] = (vec3(8.0, 8.0, -6.0));
	blockB.c[1].mC[4][3] = (vec3(4.0, -6.0, -8.0));
	blockB.c[1].mC[4][4] = (vec3(4.0, -7.0, 8.0));
	blockB.c[1].mC[5][0] = (vec3(-2.0, 9.0, -2.0));
	blockB.c[1].mC[5][1] = (vec3(7.0, 4.0, 2.0));
	blockB.c[1].mC[5][2] = (vec3(4.0, 9.0, -8.0));
	blockB.c[1].mC[5][3] = (vec3(7.0, -3.0, 9.0));
	blockB.c[1].mC[5][4] = (vec3(-9.0, 6.0, -1.0));
	blockB.c[1].mC[6][0] = (vec3(9.0, 5.0, 5.0));
	blockB.c[1].mC[6][1] = (vec3(9.0, 9.0, 6.0));
	blockB.c[1].mC[6][2] = (vec3(-7.0, 1.0, 7.0));
	blockB.c[1].mC[6][3] = (vec3(2.0, -8.0, -1.0));
	blockB.c[1].mC[6][4] = (vec3(-2.0, 9.0, 4.0));
	blockB.c[2].mA.mA = (vec2(7.0, -1.0));
	blockB.c[2].mA.mB = (ivec3(4, 6, -2));
	blockB.c[2].mA.mC = (ivec3(3, -1, 4));
	blockB.c[2].mB = (bvec3(true, true, false));
	blockB.c[2].mC[0][0] = (vec3(-4.0, -8.0, 1.0));
	blockB.c[2].mC[0][1] = (vec3(7.0, 8.0, 7.0));
	blockB.c[2].mC[0][2] = (vec3(6.0, 9.0, -9.0));
	blockB.c[2].mC[0][3] = (vec3(7.0, -9.0, -3.0));
	blockB.c[2].mC[0][4] = (vec3(4.0, -2.0, 6.0));
	blockB.c[2].mC[1][0] = (vec3(4.0, -9.0, -9.0));
	blockB.c[2].mC[1][1] = (vec3(2.0, 8.0, -8.0));
	blockB.c[2].mC[1][2] = (vec3(3.0, 7.0, -6.0));
	blockB.c[2].mC[1][3] = (vec3(-8.0, -5.0, 4.0));
	blockB.c[2].mC[1][4] = (vec3(1.0, -6.0, -1.0));
	blockB.c[2].mC[2][0] = (vec3(4.0, 7.0, -3.0));
	blockB.c[2].mC[2][1] = (vec3(8.0, -8.0, 9.0));
	blockB.c[2].mC[2][2] = (vec3(6.0, -1.0, -6.0));
	blockB.c[2].mC[2][3] = (vec3(-6.0, -9.0, -6.0));
	blockB.c[2].mC[2][4] = (vec3(5.0, 6.0, 5.0));
	blockB.c[2].mC[3][0] = (vec3(-1.0, -4.0, 7.0));
	blockB.c[2].mC[3][1] = (vec3(-6.0, 6.0, -4.0));
	blockB.c[2].mC[3][2] = (vec3(3.0, 2.0, 8.0));
	blockB.c[2].mC[3][3] = (vec3(2.0, -2.0, 0.0));
	blockB.c[2].mC[3][4] = (vec3(-1.0, 8.0, 9.0));
	blockB.c[2].mC[4][0] = (vec3(8.0, -4.0, 6.0));
	blockB.c[2].mC[4][1] = (vec3(-3.0, -7.0, -6.0));
	blockB.c[2].mC[4][2] = (vec3(0.0, 9.0, 1.0));
	blockB.c[2].mC[4][3] = (vec3(1.0, 1.0, 2.0));
	blockB.c[2].mC[4][4] = (vec3(4.0, -3.0, 6.0));
	blockB.c[2].mC[5][0] = (vec3(0.0, -2.0, 5.0));
	blockB.c[2].mC[5][1] = (vec3(8.0, -5.0, 0.0));
	blockB.c[2].mC[5][2] = (vec3(4.0, 1.0, 4.0));
	blockB.c[2].mC[5][3] = (vec3(-2.0, -4.0, -3.0));
	blockB.c[2].mC[5][4] = (vec3(9.0, -5.0, 4.0));
	blockB.c[2].mC[6][0] = (vec3(3.0, -7.0, -1.0));
	blockB.c[2].mC[6][1] = (vec3(6.0, 7.0, -6.0));
	blockB.c[2].mC[6][2] = (vec3(-6.0, -9.0, -8.0));
	blockB.c[2].mC[6][3] = (vec3(-1.0, 4.0, -8.0));
	blockB.c[2].mC[6][4] = (vec3(9.0, 0.0, 5.0));
	blockB.c[3].mA.mA = (vec2(6.0, 5.0));
	blockB.c[3].mA.mB = (ivec3(-5, 3, 0));
	blockB.c[3].mA.mC = (ivec3(-2, 9, -2));
	blockB.c[3].mB = (bvec3(true, false, true));
	blockB.c[3].mC[0][0] = (vec3(-1.0, 8.0, -9.0));
	blockB.c[3].mC[0][1] = (vec3(5.0, -9.0, 5.0));
	blockB.c[3].mC[0][2] = (vec3(-5.0, -7.0, -2.0));
	blockB.c[3].mC[0][3] = (vec3(-7.0, -1.0, -3.0));
	blockB.c[3].mC[0][4] = (vec3(-4.0, -3.0, -7.0));
	blockB.c[3].mC[1][0] = (vec3(-8.0, -5.0, 0.0));
	blockB.c[3].mC[1][1] = (vec3(2.0, -2.0, -1.0));
	blockB.c[3].mC[1][2] = (vec3(-1.0, -4.0, -3.0));
	blockB.c[3].mC[1][3] = (vec3(-3.0, 4.0, 8.0));
	blockB.c[3].mC[1][4] = (vec3(2.0, -6.0, 7.0));
	blockB.c[3].mC[2][0] = (vec3(2.0, -8.0, 6.0));
	blockB.c[3].mC[2][1] = (vec3(0.0, -8.0, -3.0));
	blockB.c[3].mC[2][2] = (vec3(-5.0, 2.0, 8.0));
	blockB.c[3].mC[2][3] = (vec3(-8.0, 9.0, 5.0));
	blockB.c[3].mC[2][4] = (vec3(3.0, -4.0, -9.0));
	blockB.c[3].mC[3][0] = (vec3(4.0, -4.0, 5.0));
	blockB.c[3].mC[3][1] = (vec3(-3.0, -9.0, 7.0));
	blockB.c[3].mC[3][2] = (vec3(0.0, 6.0, -8.0));
	blockB.c[3].mC[3][3] = (vec3(-9.0, 9.0, 4.0));
	blockB.c[3].mC[3][4] = (vec3(-4.0, 0.0, -6.0));
	blockB.c[3].mC[4][0] = (vec3(9.0, 2.0, 1.0));
	blockB.c[3].mC[4][1] = (vec3(1.0, 3.0, 7.0));
	blockB.c[3].mC[4][2] = (vec3(-5.0, -5.0, 1.0));
	blockB.c[3].mC[4][3] = (vec3(7.0, -6.0, 2.0));
	blockB.c[3].mC[4][4] = (vec3(6.0, -2.0, 7.0));
	blockB.c[3].mC[5][0] = (vec3(9.0, 5.0, 8.0));
	blockB.c[3].mC[5][1] = (vec3(-7.0, 7.0, -6.0));
	blockB.c[3].mC[5][2] = (vec3(-6.0, 6.0, 9.0));
	blockB.c[3].mC[5][3] = (vec3(1.0, -2.0, -5.0));
	blockB.c[3].mC[5][4] = (vec3(8.0, -5.0, 8.0));
	blockB.c[3].mC[6][0] = (vec3(4.0, -2.0, 6.0));
	blockB.c[3].mC[6][1] = (vec3(1.0, -1.0, 6.0));
	blockB.c[3].mC[6][2] = (vec3(7.0, -9.0, 1.0));
	blockB.c[3].mC[6][3] = (vec3(2.0, 8.0, -7.0));
	blockB.c[3].mC[6][4] = (vec3(7.0, 4.0, -9.0));
	blockB.c[4].mA.mA = (vec2(8.0, 6.0));
	blockB.c[4].mA.mB = (ivec3(9, -2, 3));
	blockB.c[4].mA.mC = (ivec3(8, -5, -8));
	blockB.c[4].mB = (bvec3(false, true, true));
	blockB.c[4].mC[0][0] = (vec3(-3.0, 7.0, 7.0));
	blockB.c[4].mC[0][1] = (vec3(-1.0, 9.0, -1.0));
	blockB.c[4].mC[0][2] = (vec3(-3.0, 8.0, 9.0));
	blockB.c[4].mC[0][3] = (vec3(-5.0, 1.0, -9.0));
	blockB.c[4].mC[0][4] = (vec3(-7.0, 6.0, 2.0));
	blockB.c[4].mC[1][0] = (vec3(3.0, -7.0, 7.0));
	blockB.c[4].mC[1][1] = (vec3(2.0, 7.0, 8.0));
	blockB.c[4].mC[1][2] = (vec3(-6.0, 2.0, 6.0));
	blockB.c[4].mC[1][3] = (vec3(3.0, -8.0, 9.0));
	blockB.c[4].mC[1][4] = (vec3(2.0, -5.0, -1.0));
	blockB.c[4].mC[2][0] = (vec3(-4.0, -3.0, -1.0));
	blockB.c[4].mC[2][1] = (vec3(-6.0, 1.0, -1.0));
	blockB.c[4].mC[2][2] = (vec3(2.0, 8.0, 1.0));
	blockB.c[4].mC[2][3] = (vec3(9.0, -5.0, -9.0));
	blockB.c[4].mC[2][4] = (vec3(-3.0, 7.0, -3.0));
	blockB.c[4].mC[3][0] = (vec3(-8.0, -8.0, 9.0));
	blockB.c[4].mC[3][1] = (vec3(-3.0, -5.0, 1.0));
	blockB.c[4].mC[3][2] = (vec3(5.0, 6.0, 5.0));
	blockB.c[4].mC[3][3] = (vec3(7.0, -6.0, 0.0));
	blockB.c[4].mC[3][4] = (vec3(-5.0, -4.0, 9.0));
	blockB.c[4].mC[4][0] = (vec3(1.0, 3.0, 6.0));
	blockB.c[4].mC[4][1] = (vec3(3.0, -4.0, -1.0));
	blockB.c[4].mC[4][2] = (vec3(-5.0, 7.0, 4.0));
	blockB.c[4].mC[4][3] = (vec3(-3.0, 0.0, -8.0));
	blockB.c[4].mC[4][4] = (vec3(7.0, 8.0, -7.0));
	blockB.c[4].mC[5][0] = (vec3(6.0, 8.0, -5.0));
	blockB.c[4].mC[5][1] = (vec3(-7.0, -1.0, -2.0));
	blockB.c[4].mC[5][2] = (vec3(-6.0, -8.0, -9.0));
	blockB.c[4].mC[5][3] = (vec3(-3.0, 9.0, -3.0));
	blockB.c[4].mC[5][4] = (vec3(3.0, -4.0, -3.0));
	blockB.c[4].mC[6][0] = (vec3(5.0, 8.0, -6.0));
	blockB.c[4].mC[6][1] = (vec3(3.0, -2.0, 4.0));
	blockB.c[4].mC[6][2] = (vec3(-8.0, -2.0, -7.0));
	blockB.c[4].mC[6][3] = (vec3(-6.0, 4.0, 0.0));
	blockB.c[4].mC[6][4] = (vec3(4.0, -8.0, -5.0));
	blockB.c[5].mA.mA = (vec2(2.0, -7.0));
	blockB.c[5].mA.mB = (ivec3(-3, 3, 2));
	blockB.c[5].mA.mC = (ivec3(9, 2, -2));
	blockB.c[5].mB = (bvec3(false, true, true));
	blockB.c[5].mC[0][0] = (vec3(-4.0, -4.0, -2.0));
	blockB.c[5].mC[0][1] = (vec3(-6.0, 3.0, -9.0));
	blockB.c[5].mC[0][2] = (vec3(-5.0, 9.0, -3.0));
	blockB.c[5].mC[0][3] = (vec3(3.0, -1.0, -7.0));
	blockB.c[5].mC[0][4] = (vec3(-1.0, 7.0, -7.0));
	blockB.c[5].mC[1][0] = (vec3(-4.0, 1.0, 9.0));
	blockB.c[5].mC[1][1] = (vec3(0.0, -1.0, 0.0));
	blockB.c[5].mC[1][2] = (vec3(9.0, 1.0, 2.0));
	blockB.c[5].mC[1][3] = (vec3(5.0, 5.0, 2.0));
	blockB.c[5].mC[1][4] = (vec3(8.0, -9.0, 3.0));
	blockB.c[5].mC[2][0] = (vec3(2.0, -2.0, 9.0));
	blockB.c[5].mC[2][1] = (vec3(7.0, -4.0, 2.0));
	blockB.c[5].mC[2][2] = (vec3(9.0, 2.0, 2.0));
	blockB.c[5].mC[2][3] = (vec3(9.0, 2.0, 7.0));
	blockB.c[5].mC[2][4] = (vec3(-8.0, 2.0, -4.0));
	blockB.c[5].mC[3][0] = (vec3(4.0, 4.0, 9.0));
	blockB.c[5].mC[3][1] = (vec3(8.0, -7.0, 3.0));
	blockB.c[5].mC[3][2] = (vec3(8.0, 0.0, 0.0));
	blockB.c[5].mC[3][3] = (vec3(5.0, 2.0, 6.0));
	blockB.c[5].mC[3][4] = (vec3(-4.0, 7.0, 2.0));
	blockB.c[5].mC[4][0] = (vec3(0.0, 9.0, 5.0));
	blockB.c[5].mC[4][1] = (vec3(8.0, 2.0, 1.0));
	blockB.c[5].mC[4][2] = (vec3(-6.0, 4.0, -3.0));
	blockB.c[5].mC[4][3] = (vec3(8.0, -4.0, -1.0));
	blockB.c[5].mC[4][4] = (vec3(1.0, 5.0, 3.0));
	blockB.c[5].mC[5][0] = (vec3(8.0, 3.0, 6.0));
	blockB.c[5].mC[5][1] = (vec3(-6.0, 3.0, 8.0));
	blockB.c[5].mC[5][2] = (vec3(-7.0, 8.0, 0.0));
	blockB.c[5].mC[5][3] = (vec3(0.0, 4.0, -3.0));
	blockB.c[5].mC[5][4] = (vec3(1.0, 8.0, 6.0));
	blockB.c[5].mC[6][0] = (vec3(9.0, -8.0, 5.0));
	blockB.c[5].mC[6][1] = (vec3(-6.0, -1.0, -2.0));
	blockB.c[5].mC[6][2] = (vec3(-4.0, 9.0, -1.0));
	blockB.c[5].mC[6][3] = (vec3(-8.0, -7.0, -2.0));
	blockB.c[5].mC[6][4] = (vec3(6.0, 2.0, -4.0));
	blockB.c[6].mA.mA = (vec2(-2.0, -4.0));
	blockB.c[6].mA.mB = (ivec3(2, -6, -8));
	blockB.c[6].mA.mC = (ivec3(-2, 7, 3));
	blockB.c[6].mB = (bvec3(true, true, true));
	blockB.c[6].mC[0][0] = (vec3(-3.0, 8.0, -1.0));
	blockB.c[6].mC[0][1] = (vec3(9.0, -3.0, 8.0));
	blockB.c[6].mC[0][2] = (vec3(1.0, 0.0, 6.0));
	blockB.c[6].mC[0][3] = (vec3(9.0, 7.0, 0.0));
	blockB.c[6].mC[0][4] = (vec3(-5.0, 1.0, -8.0));
	blockB.c[6].mC[1][0] = (vec3(9.0, -2.0, 2.0));
	blockB.c[6].mC[1][1] = (vec3(6.0, -9.0, -3.0));
	blockB.c[6].mC[1][2] = (vec3(-3.0, -5.0, 9.0));
	blockB.c[6].mC[1][3] = (vec3(-1.0, 0.0, 0.0));
	blockB.c[6].mC[1][4] = (vec3(1.0, 6.0, 4.0));
	blockB.c[6].mC[2][0] = (vec3(7.0, -3.0, 5.0));
	blockB.c[6].mC[2][1] = (vec3(6.0, -7.0, -7.0));
	blockB.c[6].mC[2][2] = (vec3(-7.0, -1.0, -1.0));
	blockB.c[6].mC[2][3] = (vec3(-9.0, 5.0, 1.0));
	blockB.c[6].mC[2][4] = (vec3(1.0, 1.0, 5.0));
	blockB.c[6].mC[3][0] = (vec3(6.0, -2.0, -8.0));
	blockB.c[6].mC[3][1] = (vec3(3.0, 6.0, 5.0));
	blockB.c[6].mC[3][2] = (vec3(6.0, 7.0, -5.0));
	blockB.c[6].mC[3][3] = (vec3(-9.0, -5.0, 0.0));
	blockB.c[6].mC[3][4] = (vec3(5.0, 3.0, 0.0));
	blockB.c[6].mC[4][0] = (vec3(-9.0, 4.0, 4.0));
	blockB.c[6].mC[4][1] = (vec3(5.0, -3.0, -2.0));
	blockB.c[6].mC[4][2] = (vec3(4.0, 8.0, -8.0));
	blockB.c[6].mC[4][3] = (vec3(-1.0, -5.0, 0.0));
	blockB.c[6].mC[4][4] = (vec3(-4.0, 3.0, -6.0));
	blockB.c[6].mC[5][0] = (vec3(-8.0, -5.0, -6.0));
	blockB.c[6].mC[5][1] = (vec3(-1.0, -9.0, -3.0));
	blockB.c[6].mC[5][2] = (vec3(3.0, -5.0, -5.0));
	blockB.c[6].mC[5][3] = (vec3(-4.0, -6.0, -9.0));
	blockB.c[6].mC[5][4] = (vec3(4.0, -7.0, -1.0));
	blockB.c[6].mC[6][0] = (vec3(-7.0, -9.0, -3.0));
	blockB.c[6].mC[6][1] = (vec3(-3.0, -4.0, -2.0));
	blockB.c[6].mC[6][2] = (vec3(9.0, -5.0, 3.0));
	blockB.c[6].mC[6][3] = (vec3(3.0, 2.0, -7.0));
	blockB.c[6].mC[6][4] = (vec3(-7.0, 0.0, -6.0));
	blockB.c[7].mA.mA = (vec2(-2.0, 4.0));
	blockB.c[7].mA.mB = (ivec3(-6, 4, -7));
	blockB.c[7].mA.mC = (ivec3(7, 3, -1));
	blockB.c[7].mB = (bvec3(true, true, true));
	blockB.c[7].mC[0][0] = (vec3(-6.0, -3.0, -4.0));
	blockB.c[7].mC[0][1] = (vec3(5.0, -8.0, 6.0));
	blockB.c[7].mC[0][2] = (vec3(-2.0, 4.0, 9.0));
	blockB.c[7].mC[0][3] = (vec3(-7.0, 4.0, -6.0));
	blockB.c[7].mC[0][4] = (vec3(-4.0, -5.0, 3.0));
	blockB.c[7].mC[1][0] = (vec3(-6.0, 1.0, 7.0));
	blockB.c[7].mC[1][1] = (vec3(1.0, -6.0, -8.0));
	blockB.c[7].mC[1][2] = (vec3(7.0, -5.0, 7.0));
	blockB.c[7].mC[1][3] = (vec3(0.0, 0.0, -1.0));
	blockB.c[7].mC[1][4] = (vec3(-2.0, -8.0, 2.0));
	blockB.c[7].mC[2][0] = (vec3(9.0, -9.0, 6.0));
	blockB.c[7].mC[2][1] = (vec3(3.0, 6.0, -5.0));
	blockB.c[7].mC[2][2] = (vec3(4.0, 2.0, 8.0));
	blockB.c[7].mC[2][3] = (vec3(-4.0, -2.0, 3.0));
	blockB.c[7].mC[2][4] = (vec3(2.0, 0.0, 2.0));
	blockB.c[7].mC[3][0] = (vec3(6.0, 7.0, 4.0));
	blockB.c[7].mC[3][1] = (vec3(-7.0, -9.0, 7.0));
	blockB.c[7].mC[3][2] = (vec3(-9.0, -7.0, 8.0));
	blockB.c[7].mC[3][3] = (vec3(-3.0, 4.0, -1.0));
	blockB.c[7].mC[3][4] = (vec3(-5.0, -3.0, -6.0));
	blockB.c[7].mC[4][0] = (vec3(-4.0, -7.0, -2.0));
	blockB.c[7].mC[4][1] = (vec3(6.0, -3.0, -5.0));
	blockB.c[7].mC[4][2] = (vec3(-4.0, -4.0, 7.0));
	blockB.c[7].mC[4][3] = (vec3(6.0, 7.0, 1.0));
	blockB.c[7].mC[4][4] = (vec3(4.0, -6.0, 6.0));
	blockB.c[7].mC[5][0] = (vec3(1.0, -9.0, -5.0));
	blockB.c[7].mC[5][1] = (vec3(1.0, -6.0, -4.0));
	blockB.c[7].mC[5][2] = (vec3(-8.0, 0.0, -2.0));
	blockB.c[7].mC[5][3] = (vec3(8.0, -4.0, 8.0));
	blockB.c[7].mC[5][4] = (vec3(-2.0, 6.0, 3.0));
	blockB.c[7].mC[6][0] = (vec3(1.0, -9.0, 7.0));
	blockB.c[7].mC[6][1] = (vec3(1.0, -3.0, -1.0));
	blockB.c[7].mC[6][2] = (vec3(0.0, 5.0, -6.0));
	blockB.c[7].mC[6][3] = (vec3(-7.0, -4.0, 5.0));
	blockB.c[7].mC[6][4] = (vec3(3.0, -4.0, -8.0));
}
#version 450
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
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 b;
	layout(offset = 12) lowp int c;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp int d[1];
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec3 e;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a), 4u) && allOk;
	allOk = compare_bvec3((blockC.b), bvec3(false, true, true)) && allOk;
	allOk = compare_int((blockC.c), -2) && allOk;
	allOk = compare_int((blockD.d[0]), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (2u);
	blockC.b = (bvec3(true, false, false));
	blockD.d[0] = (-9);
	e = (ivec3(1, 6, -8));
}
#version 450
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
	layout(offset = 0) lowp mat4x3 a;
	layout(offset = 64) highp ivec2 b;
	layout(offset = 72) bvec2 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].a, mat4x3(4.0, -1.0, 1.0, 6.0, 1.0, 9.0, -6.0, -4.0, 2.0, -9.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].a, mat4x3(-1.0, -1.0, -2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].a, mat4x3(7.0, 3.0, -6.0, -5.0, -3.0, -4.0, -5.0, 8.0, -3.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(3)].a, mat4x3(-2.0, 3.0, 3.0, 1.0, 5.0, 8.0, 7.0, -7.0, 6.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(5.0, 7.0, -9.0, -6.0, 1.0, -2.0, -1.0, -3.0, -9.0, -9.0, -2.0, -4.0));
	blockB[nonuniformEXT(0)].c = (bvec2(false, true));
	blockB[nonuniformEXT(1)].a = (mat4x3(2.0, -6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0));
	blockB[nonuniformEXT(1)].c = (bvec2(true, false));
	blockB[nonuniformEXT(2)].a = (mat4x3(9.0, 5.0, 7.0, -5.0, 9.0, -3.0, 8.0, -3.0, 7.0, -4.0, -9.0, -2.0));
	blockB[nonuniformEXT(2)].c = (bvec2(false, false));
	blockB[nonuniformEXT(3)].a = (mat4x3(5.0, -4.0, 9.0, -2.0, -5.0, -8.0, -4.0, 0.0, 8.0, 2.0, 6.0, 3.0));
	blockB[nonuniformEXT(3)].c = (bvec2(true, true));
}
#version 450
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
	mediump float a;
	int16_t b;
	bool c;
	uint16_t d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	float16_t e;
	int16_t f;
};
layout(std140, binding = 3) buffer BlockD
{
	lowp uint g;
	bool h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.b), -3) && allOk;
	allOk = compare_uint16_t(uint(blockB.d), 3u) && allOk;
	allOk = compare_uint((g), 0u) && allOk;
	allOk = compare_bool((h), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9.0);
	blockB.b = int16_t(-2);
	blockB.c = (true);
	e = float16_t(2.0);
	f = int16_t(-8);
	g = (1u);
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

layout(std430, binding = 1) buffer BlockB
{
	highp float a;
	i16vec4 b[1];
};
layout(std140, binding = 2) readonly buffer BlockC
{
	u16vec4 c;
	lowp vec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), -2.0) && allOk;
	allOk = compare_i16vec4(ivec4(b[0]), ivec4(4, 3, -8, 3)) && allOk;
	allOk = compare_u16vec4(uvec4(c), uvec4(2u, 4u, 3u, 4u)) && allOk;
	allOk = compare_vec4((d), vec4(-2.0, -3.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-7.0);
}
#version 450
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
	highp mat2x3 a;
	u16vec2 b;
	highp mat4x3 c;
	highp mat2 d;
	highp uvec4 e[];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	mediump float f[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	u16vec3 g;
	mediump float h;
	u16vec4 i;
	bool j[1];
	u16vec4 k[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a, mat2x3(4.0, -1.0, 1.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_u16vec2(uvec2(b), uvec2(7u, 1u)) && allOk;
	allOk = compare_mat2(d, mat2(-2.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(8u, 6u, 0u, 5u)) && allOk;
	allOk = compare_float((f[0]), 9.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.g), uvec3(8u, 7u, 5u)) && allOk;
	allOk = compare_float((blockD.h), -5.0) && allOk;
	allOk = compare_bool((blockD.j[0]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2x3(5.0, 7.0, -9.0, -6.0, 1.0, -2.0));
	b = u16vec2(uvec2(9u, 5u));
	c = (mat4x3(-9.0, -9.0, -2.0, -4.0, -4.0, 3.0, 4.0, 9.0, 1.0, 2.0, -6.0, 5.0));
	d = (mat2(9.0, 2.0, -1.0, -7.0));
	blockD.h = (2.0);
	blockD.j[0] = (true);
}
#version 450
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
	lowp mat4x3 mB[6][2];
	lowp int mC[2];
	uint16_t mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec2 a;
	highp ivec3 b[4];
	lowp ivec2 c[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec2 d;
	f16vec2 e;
	sA f;
	u16vec3 g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(blockC.f.mA), 0.0) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[0][0], mat4x3(-5.0, 8.0, 6.0, 4.0, 4.0, 6.0, -1.0, 3.0, 7.0, 6.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[0][1], mat4x3(-1.0, -8.0, -8.0, -6.0, -3.0, 4.0, 3.0, 9.0, 0.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[1][0], mat4x3(1.0, -5.0, -6.0, -2.0, 3.0, -3.0, -2.0, 6.0, 8.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[1][1], mat4x3(6.0, 7.0, 7.0, -7.0, 6.0, 2.0, 5.0, 6.0, -2.0, 5.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[2][0], mat4x3(6.0, 7.0, 5.0, -5.0, 8.0, 2.0, 4.0, -9.0, 0.0, -7.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[2][1], mat4x3(-4.0, -2.0, -7.0, 1.0, -2.0, 2.0, -4.0, -2.0, 4.0, 6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[3][0], mat4x3(4.0, -8.0, 0.0, -1.0, 1.0, -4.0, 1.0, -2.0, 4.0, -5.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[3][1], mat4x3(5.0, -5.0, -3.0, 0.0, 2.0, -4.0, -2.0, -1.0, -8.0, 8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[4][0], mat4x3(-2.0, -6.0, -5.0, 4.0, -9.0, 2.0, -1.0, -4.0, -5.0, -8.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[4][1], mat4x3(-3.0, -7.0, -3.0, -5.0, -8.0, -1.0, 1.0, -1.0, -1.0, 9.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[5][0], mat4x3(6.0, 0.0, 6.0, -8.0, -8.0, -9.0, -4.0, 8.0, 8.0, 3.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mB[5][1], mat4x3(8.0, 4.0, -1.0, -3.0, 8.0, -7.0, -8.0, 8.0, -7.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_int((blockC.f.mC[0]), -5) && allOk;
	allOk = compare_int((blockC.f.mC[1]), 0) && allOk;
	allOk = compare_uint16_t(uint(blockC.f.mD), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.c[0] = (ivec2(-9, -8));
	blockB.c[1] = (ivec2(9, -6));
	blockB.c[2] = (ivec2(-4, 5));
	blockB.c[3] = (ivec2(-4, -6));
	blockB.c[4] = (ivec2(-4, -2));
	blockB.c[5] = (ivec2(-8, 5));
	blockB.c[6] = (ivec2(-4, -5));
	blockB.c[7] = (ivec2(-9, -2));
	blockC.f.mA = float16_t(4.0);
	blockC.f.mB[0][0] = (mat4x3(-4.0, -5.0, -7.0, -1.0, 2.0, 5.0, -7.0, 6.0, 3.0, 1.0, 8.0, -6.0));
	blockC.f.mB[0][1] = (mat4x3(1.0, -6.0, 0.0, 5.0, -1.0, 1.0, -2.0, 7.0, -7.0, -6.0, -7.0, -3.0));
	blockC.f.mB[1][0] = (mat4x3(-9.0, 7.0, -3.0, 5.0, -4.0, 4.0, -1.0, 9.0, 7.0, -9.0, -5.0, -6.0));
	blockC.f.mB[1][1] = (mat4x3(-4.0, -2.0, -7.0, 6.0, 3.0, 9.0, 1.0, 9.0, -9.0, -8.0, -6.0, 9.0));
	blockC.f.mB[2][0] = (mat4x3(0.0, -1.0, 6.0, 5.0, -7.0, -1.0, -2.0, -4.0, 9.0, 8.0, -8.0, -7.0));
	blockC.f.mB[2][1] = (mat4x3(-8.0, -3.0, -8.0, 3.0, -2.0, 7.0, 2.0, 0.0, -8.0, -1.0, 6.0, 1.0));
	blockC.f.mB[3][0] = (mat4x3(1.0, 6.0, -2.0, -4.0, 2.0, 3.0, -4.0, 3.0, 7.0, -5.0, 8.0, 6.0));
	blockC.f.mB[3][1] = (mat4x3(0.0, 6.0, 6.0, -8.0, 5.0, -4.0, 4.0, 6.0, 5.0, 3.0, 7.0, -3.0));
	blockC.f.mB[4][0] = (mat4x3(3.0, 9.0, 4.0, 1.0, -8.0, -9.0, 2.0, -7.0, -2.0, 3.0, 8.0, 9.0));
	blockC.f.mB[4][1] = (mat4x3(7.0, 5.0, -8.0, 8.0, 3.0, 4.0, 9.0, -1.0, 1.0, -7.0, 0.0, 6.0));
	blockC.f.mB[5][0] = (mat4x3(9.0, -1.0, 2.0, -8.0, -2.0, 3.0, 0.0, 8.0, 9.0, 7.0, -4.0, -5.0));
	blockC.f.mB[5][1] = (mat4x3(0.0, -3.0, -7.0, -4.0, 1.0, -8.0, -1.0, 7.0, -3.0, -3.0, -3.0, 3.0));
	blockC.f.mC[0] = (4);
	blockC.f.mC[1] = (-1);
	blockC.f.mD = uint16_t(1u);
}
#version 450
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
	bvec3 a;
	i16vec3 b;
	uint16_t c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	f16vec3 d;
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	u16vec2 e;
	highp ivec4 f;
	mediump ivec3 g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 4u) && allOk;
	allOk = compare_f16vec3(vec3(blockC.d), vec3(-5.0, -1.0, 2.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.e), uvec2(6u, 0u)) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(6, 8, 2, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = i16vec3(ivec3(9, -5, 2));
	blockC.d = f16vec3(vec3(0.0, 0.0, 7.0));
	blockD.g[0] = (ivec3(-4, 6, 5));
	blockD.g[1] = (ivec3(7, -4, 8));
	blockD.g[2] = (ivec3(-5, -3, -2));
	blockD.g[3] = (ivec3(-1, 1, 3));
	blockD.g[4] = (ivec3(0, -9, 0));
	blockD.g[5] = (ivec3(-9, 9, 3));
	blockD.g[6] = (ivec3(3, -8, 0));
}
#version 450
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
	layout(offset = 8) f16vec4 b;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) bvec4 c;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp ivec3 d;
	layout(offset = 12) i16vec2 e[1];
	layout(offset = 16) highp ivec4 f;
	layout(offset = 32) f16vec3 g;
	layout(offset = 38) int16_t h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, true)) && allOk;
	allOk = compare_f16vec4(vec4(b), vec4(9.0, -5.0, 7.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockC.c), bvec4(true, false, true, true)) && allOk;
	allOk = compare_i16vec2(ivec2(e[0]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec4((f), ivec4(3, -2, -1, -5)) && allOk;
	allOk = compare_f16vec3(vec3(g), vec3(5.0, 3.0, 9.0)) && allOk;
	allOk = compare_int16_t(int(h), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, false));
	b = f16vec4(vec4(2.0, 4.0, 9.0, -2.0));
	d = (ivec3(8, -5, 4));
	f = (ivec4(-5, 0, 4, 7));
}
#version 450
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
	layout(offset = 0) lowp uvec4 a;
	layout(offset = 16) mediump uvec3 b;
	layout(offset = 28) f16vec2 c;
	layout(offset = 32) mediump int d[1];
	layout(offset = 48) bvec4 e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 1u, 0u, 6u)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.c), vec2(9.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB.e), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(5u, 4u, 3u, 2u));
	blockB.b = (uvec3(1u, 8u, 0u));
	blockB.d[0] = (0);
	blockB.e = (bvec4(true, false, true, true));
}
#version 450
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
	layout(offset = 0) u16vec3 a[1];
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec2 b;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec4 c;
	layout(offset = 16) i16vec3 d[1];
	layout(offset = 24) mediump vec2 e[1];
	layout(offset = 32) lowp uvec4 f;
	layout(offset = 48) u16vec2 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(a[0]), uvec3(9u, 9u, 9u)) && allOk;
	allOk = compare_bvec2((blockC.b), bvec2(true, false)) && allOk;
	allOk = compare_vec4((c), vec4(-6.0, -1.0, -6.0, 3.0)) && allOk;
	allOk = compare_i16vec3(ivec3(d[0]), ivec3(-7, 9, 3)) && allOk;
	allOk = compare_uvec4((f), uvec4(0u, 4u, 7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u16vec3(uvec3(3u, 1u, 2u));
	blockC.b = (bvec2(true, false));
	e[0] = (vec2(1.0, -9.0));
	f = (uvec4(2u, 7u, 9u, 9u));
	g = u16vec2(uvec2(3u, 3u));
}
#version 450
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
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bool a[1];
	u16vec3 b;
	u16vec2 c;
	highp vec3 d;
	sA e;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB[0].c), uvec2(4u, 1u)) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(-2.0, -2.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockB[0].e.mA), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uvec4((blockB[0].e.mB), uvec4(0u, 3u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (true);
	blockB[0].c = u16vec2(uvec2(3u, 7u));
	blockB[0].d = (vec3(-9.0, -6.0, 5.0));
}
#version 450
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
	i16vec2 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	i16vec4 a;
	i16vec3 b;
	lowp uvec2 c;
	u16vec4 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sA e;
	lowp vec2 f;
	mediump int g[];
};
layout(scalar, binding = 3) buffer BlockD
{
	mediump mat2x3 h[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	i16vec3 i;
	bvec4 j;
	lowp uint k;
	mediump int l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(-8, 7, -3, 6)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(2u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[0]), uvec4(4u, 5u, 8u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[1]), uvec4(5u, 5u, 7u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[2]), uvec4(7u, 3u, 0u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[3]), uvec4(5u, 7u, 9u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[4]), uvec4(0u, 0u, 0u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[5]), uvec4(2u, 5u, 5u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[6]), uvec4(1u, 7u, 0u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[7]), uvec4(1u, 4u, 4u, 2u)) && allOk;
	allOk = compare_vec2((f), vec2(3.0, -8.0)) && allOk;
	allOk = compare_int((g[0]), 4) && allOk;
	allOk = compare_int((g[1]), 9) && allOk;
	allOk = compare_int((g[2]), 6) && allOk;
	allOk = compare_int((g[3]), 2) && allOk;
	allOk = compare_int((g[4]), -7) && allOk;
	allOk = compare_mat2x3(h[0], mat2x3(-4.0, -8.0, -4.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(h[1], mat2x3(6.0, 6.0, 2.0, -4.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(h[2], mat2x3(3.0, 3.0, -8.0, 0.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x3(h[3], mat2x3(-9.0, -1.0, 6.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2x3(h[4], mat2x3(5.0, -4.0, 7.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x3(h[5], mat2x3(-3.0, -2.0, -1.0, -4.0, 3.0, 4.0)) && allOk;
	allOk = compare_int((l[0]), -9) && allOk;
	allOk = compare_int((l[1]), -6) && allOk;
	allOk = compare_int((l[2]), -7) && allOk;
	allOk = compare_int((l[3]), 1) && allOk;
	allOk = compare_int((l[4]), 8) && allOk;
	allOk = compare_int((l[5]), 0) && allOk;
	allOk = compare_int((l[6]), 7) && allOk;
	allOk = compare_int((l[7]), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(2, 7, 2, 3));
	blockB.b = i16vec3(ivec3(4, 4, 9));
	blockB.d[0] = u16vec4(uvec4(3u, 6u, 8u, 2u));
	blockB.d[1] = u16vec4(uvec4(6u, 7u, 4u, 4u));
	blockB.d[2] = u16vec4(uvec4(1u, 3u, 0u, 4u));
	blockB.d[3] = u16vec4(uvec4(9u, 8u, 0u, 9u));
	blockB.d[4] = u16vec4(uvec4(1u, 9u, 5u, 6u));
	blockB.d[5] = u16vec4(uvec4(9u, 5u, 4u, 2u));
	blockB.d[6] = u16vec4(uvec4(8u, 5u, 9u, 5u));
	blockB.d[7] = u16vec4(uvec4(0u, 7u, 7u, 9u));
	f = (vec2(7.0, -3.0));
	g[0] = (6);
	g[1] = (9);
	g[2] = (-3);
	g[3] = (9);
	g[4] = (3);
	h[0] = (mat2x3(-4.0, -7.0, 6.0, -2.0, 2.0, 5.0));
	h[1] = (mat2x3(-5.0, 7.0, -4.0, 7.0, 6.0, 9.0));
	h[2] = (mat2x3(-3.0, -3.0, -5.0, 3.0, 2.0, -4.0));
	h[3] = (mat2x3(3.0, 5.0, 9.0, -8.0, -7.0, 6.0));
	h[4] = (mat2x3(8.0, 0.0, -9.0, -4.0, -3.0, 0.0));
	h[5] = (mat2x3(-1.0, -1.0, 8.0, 3.0, -3.0, 8.0));
	i = i16vec3(ivec3(-6, 2, 1));
	l[0] = (2);
	l[1] = (-3);
	l[2] = (2);
	l[3] = (-5);
	l[4] = (4);
	l[5] = (-6);
	l[6] = (-1);
	l[7] = (0);
}
#version 450
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
	highp vec4 mA;
	f16vec2 mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	i16vec3 a;
	bvec3 b[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	i16vec2 c;
	mediump vec4 d;
	highp vec3 e;
	sA f[4];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(a), ivec3(8, 1, 7)) && allOk;
	allOk = compare_bvec3((b[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((b[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((b[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((b[3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((b[4]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((b[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((b[6]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((b[7]), bvec3(true, true, false)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.c), ivec2(-9, -8)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(-4.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.f[0].mA), vec4(5.0, -8.0, -3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[0].mB), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.f[1].mA), vec4(6.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[1].mB), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.f[2].mA), vec4(6.0, 0.0, 6.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[2].mB), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.f[3].mA), vec4(-1.0, 9.0, 0.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[3].mB), vec2(-8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec3(ivec3(9, 9, 3));
	b[0] = (bvec3(true, false, false));
	b[1] = (bvec3(true, false, true));
	b[2] = (bvec3(false, false, false));
	b[3] = (bvec3(false, true, false));
	b[4] = (bvec3(false, true, false));
	b[5] = (bvec3(false, true, false));
	b[6] = (bvec3(true, true, true));
	b[7] = (bvec3(true, true, false));
	blockC.c = i16vec2(ivec2(-4, -2));
	blockC.e = (vec3(-4.0, -1.0, 2.0));
	blockC.f[0].mA = (vec4(-4.0, -5.0, -5.0, -2.0));
	blockC.f[0].mB = f16vec2(vec2(7.0, -9.0));
	blockC.f[1].mA = (vec4(-5.0, -9.0, 0.0, 2.0));
	blockC.f[1].mB = f16vec2(vec2(-8.0, 6.0));
	blockC.f[2].mA = (vec4(-9.0, -5.0, 8.0, -8.0));
	blockC.f[2].mB = f16vec2(vec2(-7.0, 3.0));
	blockC.f[3].mA = (vec4(-6.0, 3.0, -9.0, -6.0));
	blockC.f[3].mB = f16vec2(vec2(-1.0, 5.0));
}
#version 450
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
	mediump mat4x2 a;
	bvec3 b;
	lowp ivec4 c;
	f16vec2 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[nonuniformEXT(0)].a, mat4x2(1.0, -6.0, -5.0, 7.0, 2.0, -1.0, 4.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].b), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(1)].a, mat4x2(1.0, -4.0, -4.0, -3.0, 1.0, 5.0, 6.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].b), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(2)].a, mat4x2(5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].b), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bool b;
	mediump mat4 c;
	f16vec3 d;
	uint16_t e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(0)].a), 6) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].b), true) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].c, mat4(1.0, -7.0, 2.0, -1.0, -2.0, -8.0, -7.0, -4.0, -1.0, -5.0, -5.0, 4.0, -8.0, -3.0, -5.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(0)].d), vec3(-8.0, 0.0, 5.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(1)].a), -3) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].b), false) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].c, mat4(6.0, -5.0, -9.0, 9.0, -7.0, -7.0, 9.0, -2.0, 9.0, 5.0, 5.0, 9.0, -4.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(1)].d), vec3(1.0, -5.0, 4.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(2)].a), 9) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].b), true) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(2)].c, mat4(9.0, 1.0, 6.0, 9.0, -8.0, -6.0, 8.0, 7.0, 1.0, 5.0, 5.0, -4.0, -8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(2)].d), vec3(3.0, -9.0, 1.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(3)].a), 8) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].b), true) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(3)].c, mat4(-3.0, -6.0, -1.0, -6.0, 4.0, 7.0, -8.0, 2.0, 8.0, 7.0, 8.0, -8.0, -2.0, -2.0, 8.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(3)].d), vec3(-3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int16_t(6);
	blockB[nonuniformEXT(0)].d = f16vec3(vec3(8.0, -3.0, -3.0));
	blockB[nonuniformEXT(0)].e = uint16_t(9u);
	blockB[nonuniformEXT(1)].a = int16_t(1);
	blockB[nonuniformEXT(1)].d = f16vec3(vec3(-1.0, 7.0, -8.0));
	blockB[nonuniformEXT(1)].e = uint16_t(7u);
	blockB[nonuniformEXT(2)].a = int16_t(-1);
	blockB[nonuniformEXT(2)].d = f16vec3(vec3(-7.0, 6.0, 6.0));
	blockB[nonuniformEXT(2)].e = uint16_t(0u);
	blockB[nonuniformEXT(3)].a = int16_t(-4);
	blockB[nonuniformEXT(3)].d = f16vec3(vec3(-1.0, 8.0, -8.0));
	blockB[nonuniformEXT(3)].e = uint16_t(0u);
}
#version 450
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
	uint8_t a;
	highp int b[1];
	lowp int c;
	lowp uint d;
};
layout(std430, binding = 2) buffer BlockC
{
	uint8_t e;
	uint8_t f;
} blockC;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((c), -7) && allOk;
	allOk = compare_uint8_t(uint(blockC.e), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (4);
	blockC.e = uint8_t(6u);
	blockC.f = uint8_t(5u);
}
#version 450
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
	u8vec2 a;
};
layout(std140, binding = 2) buffer BlockC
{
	lowp vec4 b[];
};
layout(std140, binding = 3) buffer BlockD
{
	mediump vec3 c;
	u8vec3 d;
	highp mat4 e[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	highp uvec2 f;
	mediump vec2 g;
	mediump int h;
	int8_t i[1];
	highp ivec2 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(a), uvec2(5u, 4u)) && allOk;
	allOk = compare_vec4((b[0]), vec4(8.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((b[1]), vec4(-2.0, 6.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec4((b[2]), vec4(-9.0, 9.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec4((b[3]), vec4(2.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((b[4]), vec4(-9.0, 7.0, 0.0, -2.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.d), uvec3(0u, 6u, 9u)) && allOk;
	allOk = compare_uvec2((f), uvec2(4u, 2u)) && allOk;
	allOk = compare_int((h), -1) && allOk;
	allOk = compare_int8_t(int(i[0]), 3) && allOk;
	allOk = compare_ivec2((j[0]), ivec2(4, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (vec4(3.0, -2.0, 2.0, -7.0));
	b[1] = (vec4(4.0, 6.0, -8.0, 8.0));
	b[2] = (vec4(-3.0, 3.0, -3.0, -1.0));
	b[3] = (vec4(6.0, 9.0, 5.0, -6.0));
	b[4] = (vec4(-1.0, -2.0, 2.0, -3.0));
	blockD.d = u8vec3(uvec3(0u, 3u, 6u));
	blockD.e[0] = (mat4(-2.0, 8.0, -3.0, -3.0, -8.0, 1.0, -3.0, -1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0, 1.0, -9.0));
	blockD.e[1] = (mat4(8.0, 9.0, -8.0, -8.0, 3.0, -3.0, 0.0, 4.0, 6.0, 1.0, -4.0, 6.0, 0.0, -2.0, -1.0, 5.0));
	blockD.e[2] = (mat4(2.0, -7.0, -6.0, -2.0, -6.0, 9.0, 9.0, -9.0, 5.0, -3.0, 9.0, -9.0, -7.0, 6.0, 9.0, 0.0));
	f = (uvec2(8u, 4u));
	g = (vec2(-3.0, 0.0));
	h = (5);
	i[0] = int8_t(0);
	j[0] = (ivec2(1, -1));
}
#version 450
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
	i8vec4 a[1];
	highp mat2 b[];
} blockB[2];
layout(std140, binding = 2) buffer BlockC
{
	highp mat4 c;
	lowp mat4x2 d;
	bvec4 e;
	mediump float f;
	highp vec2 g[];
} blockC;
layout(std430, binding = 3) readonly buffer BlockD
{
	u8vec2 h[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a[0]), ivec4(4294967289, 3, 4294967294, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].a[0]), ivec4(4294967288, 6, 4294967291, 4294967288)) && allOk;
	allOk = compare_mat4(blockC.c, mat4(-4.0, 8.0, -1.0, 2.0, 0.0, 1.0, 6.0, -5.0, 2.0, 7.0, -5.0, 4.0, -7.0, 0.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockC.d, mat4x2(-2.0, 0.0, -6.0, -3.0, 1.0, 8.0, -5.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (mat4(2.0, -7.0, 1.0, 3.0, 2.0, -7.0, 4.0, 9.0, -8.0, -1.0, 3.0, -1.0, 4.0, 1.0, -8.0, -8.0));
	blockC.d = (mat4x2(-1.0, -5.0, 7.0, -5.0, -3.0, -8.0, 6.0, -4.0));
	blockC.e = (bvec4(false, false, true, false));
	blockC.f = (4.0);
	blockC.g[0] = (vec2(3.0, -9.0));
}
#version 450
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
	highp mat3x2 mB;
	highp mat3x4 mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	u8vec4 a;
	bvec2 b;
	sA c;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp int d;
	mediump mat2x3 e;
	lowp mat4x2 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(2u, 3u, 7u, 5u)) && allOk;
	allOk = compare_int((d), -5) && allOk;
	allOk = compare_mat2x3(e, mat2x3(0.0, 1.0, -8.0, 0.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(2u, 0u, 0u, 7u));
	blockB.b = (bvec2(true, false));
	f[0] = (mat4x2(-9.0, -1.0, -6.0, 9.0, -8.0, -4.0, -9.0, 9.0));
}
#version 450
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
	mediump float mA;
	mediump mat4x3 mB;
	highp mat2 mC;
	mediump uvec4 mD;
};
struct sB
{
	highp mat4x2 mA;
	uint8_t mB;
	sA mC;
};
struct sC
{
	u8vec3 mA;
	i8vec4 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump float a;
	lowp ivec4 b;
	bvec2 c;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	sB d[1];
	mediump int e;
	sC f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -5.0) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(5, -6, -9, 9)) && allOk;
	allOk = compare_mat4x2(blockC.d[0].mA, mat4x2(5.0, -1.0, -7.0, 5.0, -5.0, 2.0, -2.0, -4.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC.d[0].mB), 0u) && allOk;
	allOk = compare_float((blockC.d[0].mC.mA), 7.0) && allOk;
	allOk = compare_mat4x3(blockC.d[0].mC.mB, mat4x3(-1.0, -5.0, -5.0, 3.0, 5.0, 1.0, -2.0, 3.0, 8.0, -1.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2(blockC.d[0].mC.mC, mat2(4.0, -3.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockC.d[0].mC.mD), uvec4(9u, 9u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (3.0);
	blockB.b = (ivec4(-4, 2, 2, 4));
	blockB.c = (bvec2(false, false));
	blockC.d[0].mA = (mat4x2(-4.0, 9.0, -9.0, 8.0, -2.0, -5.0, 0.0, 4.0));
	blockC.d[0].mB = uint8_t(5u);
	blockC.d[0].mC.mA = (-8.0);
	blockC.d[0].mC.mB = (mat4x3(-5.0, 3.0, 6.0, 0.0, -2.0, -5.0, 4.0, 9.0, 5.0, 7.0, 0.0, 5.0));
	blockC.d[0].mC.mC = (mat2(-5.0, -4.0, -2.0, -4.0));
	blockC.d[0].mC.mD = (uvec4(5u, 1u, 4u, 8u));
	blockC.f[0].mA = u8vec3(uvec3(3u, 6u, 1u));
	blockC.f[0].mB = i8vec4(ivec4(4, 4294967293, 8, 4294967290));
}
#version 450
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
	i8vec2 a;
	highp mat4 b;
	lowp float c;
	highp mat4x3 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(a), ivec2(2, 7)) && allOk;
	allOk = compare_mat4(b, mat4(-9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_float((c), -9.0) && allOk;
	allOk = compare_mat4x3(d[0], mat4x3(6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x3(d[1], mat4x3(2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(d[2], mat4x3(-7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(d[3], mat4x3(-3.0, -3.0, -3.0, 3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(d[4], mat4x3(2.0, 3.0, 0.0, -1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(d[5], mat4x3(4.0, 0.0, -3.0, -3.0, 9.0, -1.0, -8.0, -9.0, -7.0, -2.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4(-5.0, 5.0, -4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0, -6.0, 9.0));
	c = (4.0);
	d[0] = (mat4x3(-5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0));
	d[1] = (mat4x3(6.0, -8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0));
	d[2] = (mat4x3(-4.0, -2.0, 8.0, -7.0, 4.0, 0.0, 7.0, 2.0, -4.0, 1.0, 6.0, -2.0));
	d[3] = (mat4x3(5.0, 7.0, -9.0, -4.0, 7.0, -9.0, 7.0, 7.0, -8.0, 5.0, -2.0, -3.0));
	d[4] = (mat4x3(-9.0, 7.0, -4.0, -6.0, 3.0, -7.0, -4.0, 2.0, -4.0, -3.0, 3.0, 2.0));
	d[5] = (mat4x3(0.0, 8.0, 8.0, -2.0, -6.0, 7.0, 1.0, 9.0, -1.0, -8.0, 1.0, 0.0));
}
#version 450
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
	u8vec3 mB[1];
	mediump ivec3 mC;
	lowp mat4 mD;
};
struct sB
{
	bool mA;
	highp mat2x3 mB;
	highp vec4 mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp mat4x3 a;
	mediump vec4 b;
	lowp ivec4 c;
	highp ivec2 d;
	highp mat4 e[];
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	mediump float f;
	mediump mat2x3 g;
	bool h;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat3x2 i[2];
	sA j[];
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	int8_t k;
	sB l;
	mediump mat3 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(a, mat4x3(-8.0, -9.0, -9.0, 3.0, 3.0, 0.0, -5.0, -2.0, 3.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4((b), vec4(6.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_ivec4((c), ivec4(5, 1, 5, -7)) && allOk;
	allOk = compare_ivec2((d), ivec2(4, 7)) && allOk;
	allOk = compare_mat4(e[0], mat4(2.0, -6.0, 8.0, -3.0, -6.0, -5.0, -2.0, -4.0, 6.0, 5.0, 0.0, -6.0, -7.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(e[1], mat4(6.0, 8.0, 1.0, 6.0, 6.0, -1.0, -7.0, -6.0, -6.0, 9.0, 6.0, -5.0, 4.0, 8.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4(e[2], mat4(-7.0, -3.0, -3.0, -3.0, -2.0, 9.0, -7.0, -9.0, 8.0, 7.0, 9.0, 6.0, -4.0, 4.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4(e[3], mat4(2.0, 3.0, -9.0, 8.0, 5.0, 2.0, -7.0, 2.0, 8.0, 4.0, 7.0, 3.0, 7.0, 1.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(e[4], mat4(7.0, 8.0, 8.0, 6.0, -2.0, -2.0, -1.0, -4.0, -9.0, 2.0, -5.0, -1.0, -6.0, -3.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(e[5], mat4(2.0, 0.0, -4.0, 1.0, -1.0, 4.0, -2.0, 8.0, 0.0, -4.0, 4.0, -2.0, -3.0, 0.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(e[6], mat4(3.0, 9.0, -2.0, 7.0, 5.0, -4.0, -7.0, -3.0, 1.0, 3.0, -8.0, -6.0, 8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(e[7], mat4(1.0, -9.0, 1.0, -9.0, -5.0, 2.0, 0.0, -5.0, 6.0, -3.0, 9.0, -5.0, 5.0, 5.0, -1.0, 4.0)) && allOk;
	allOk = compare_bool((h), false) && allOk;
	allOk = compare_mat3x2(i[0], mat3x2(-3.0, -6.0, -6.0, -4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(i[1], mat3x2(8.0, -2.0, -3.0, 6.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec4((j[0].mA), uvec4(6u, 3u, 8u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(j[0].mB[0]), uvec3(1u, 9u, 5u)) && allOk;
	allOk = compare_ivec3((j[0].mC), ivec3(-4, -6, 7)) && allOk;
	allOk = compare_mat4(j[0].mD, mat4(-5.0, -6.0, -7.0, -9.0, 4.0, -4.0, -7.0, -2.0, 5.0, 9.0, 7.0, 3.0, -4.0, -7.0, 7.0, -1.0)) && allOk;
	allOk = compare_uvec4((j[1].mA), uvec4(9u, 1u, 8u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(j[1].mB[0]), uvec3(9u, 5u, 9u)) && allOk;
	allOk = compare_ivec3((j[1].mC), ivec3(-3, 8, -1)) && allOk;
	allOk = compare_mat4(j[1].mD, mat4(-4.0, 6.0, 7.0, 9.0, -5.0, -7.0, -5.0, -3.0, 8.0, -1.0, 6.0, -3.0, 4.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec4((j[2].mA), uvec4(7u, 9u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(j[2].mB[0]), uvec3(4u, 7u, 1u)) && allOk;
	allOk = compare_ivec3((j[2].mC), ivec3(-6, 2, -9)) && allOk;
	allOk = compare_mat4(j[2].mD, mat4(-7.0, -5.0, -8.0, 0.0, -1.0, 4.0, 1.0, 0.0, 1.0, 4.0, 2.0, 9.0, 3.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_uvec4((j[3].mA), uvec4(6u, 7u, 7u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(j[3].mB[0]), uvec3(8u, 6u, 9u)) && allOk;
	allOk = compare_ivec3((j[3].mC), ivec3(-6, -5, 8)) && allOk;
	allOk = compare_mat4(j[3].mD, mat4(1.0, 4.0, -4.0, 3.0, -8.0, 8.0, -4.0, -4.0, -5.0, -7.0, 4.0, 6.0, 2.0, 0.0, 4.0, 2.0)) && allOk;
	allOk = compare_uvec4((j[4].mA), uvec4(6u, 4u, 3u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(j[4].mB[0]), uvec3(0u, 5u, 4u)) && allOk;
	allOk = compare_ivec3((j[4].mC), ivec3(-8, -8, 8)) && allOk;
	allOk = compare_mat4(j[4].mD, mat4(-9.0, 8.0, -3.0, -9.0, -2.0, 3.0, 9.0, 0.0, -3.0, -7.0, 7.0, 6.0, -3.0, -3.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec4((j[5].mA), uvec4(8u, 6u, 1u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(j[5].mB[0]), uvec3(4u, 1u, 6u)) && allOk;
	allOk = compare_ivec3((j[5].mC), ivec3(-9, -8, -7)) && allOk;
	allOk = compare_mat4(j[5].mD, mat4(-5.0, 8.0, 0.0, 9.0, -5.0, 5.0, -2.0, -1.0, 0.0, 4.0, 4.0, 1.0, 7.0, -2.0, -9.0, 6.0)) && allOk;
	allOk = compare_bool((l.mA), false) && allOk;
	allOk = compare_mat2x3(l.mB, mat2x3(9.0, -4.0, -3.0, -1.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec4((l.mC), vec4(-4.0, 5.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(m[0], mat3(8.0, 7.0, 8.0, -8.0, 6.0, 6.0, -5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3(m[1], mat3(9.0, 1.0, -3.0, 6.0, -9.0, 9.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(m[2], mat3(9.0, -8.0, 0.0, -2.0, -2.0, -9.0, 0.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x3(7.0, -8.0, -6.0, -6.0, 3.0, 5.0, -1.0, 2.0, 9.0, 3.0, -7.0, -7.0));
	b = (vec4(4.0, 1.0, 7.0, -3.0));
	c = (ivec4(-2, 4, -2, 3));
	e[0] = (mat4(-6.0, 1.0, -8.0, -3.0, 0.0, 7.0, 0.0, -3.0, 9.0, 6.0, -4.0, -8.0, 5.0, -9.0, 6.0, -6.0));
	e[1] = (mat4(-2.0, 6.0, -5.0, 6.0, 6.0, -3.0, 7.0, -3.0, -2.0, 5.0, -2.0, 7.0, -9.0, -9.0, 6.0, 3.0));
	e[2] = (mat4(9.0, -1.0, -6.0, 2.0, 8.0, 2.0, -5.0, 1.0, 8.0, -7.0, 7.0, 0.0, -7.0, -4.0, -1.0, -3.0));
	e[3] = (mat4(-1.0, -2.0, -1.0, 6.0, -7.0, -2.0, 1.0, 6.0, 5.0, -7.0, 0.0, -4.0, -9.0, 5.0, 9.0, -3.0));
	e[4] = (mat4(1.0, 4.0, 0.0, -3.0, 2.0, -6.0, -7.0, -3.0, 0.0, -3.0, 8.0, -1.0, -5.0, 6.0, -4.0, 0.0));
	e[5] = (mat4(-9.0, -1.0, -2.0, 2.0, 5.0, -5.0, 2.0, -4.0, 9.0, 6.0, -6.0, 3.0, -4.0, 7.0, 2.0, 8.0));
	e[6] = (mat4(8.0, -4.0, 6.0, -5.0, -6.0, -2.0, -7.0, 0.0, -1.0, -1.0, -2.0, -5.0, -8.0, -6.0, -6.0, 2.0));
	e[7] = (mat4(4.0, 1.0, 8.0, 6.0, 2.0, 1.0, 6.0, 8.0, -1.0, -7.0, 5.0, 8.0, -2.0, -7.0, 2.0, -5.0));
	i[0] = (mat3x2(7.0, -3.0, 0.0, 8.0, 3.0, 2.0));
	i[1] = (mat3x2(3.0, 8.0, -5.0, 0.0, -4.0, 5.0));
	j[0].mA = (uvec4(8u, 8u, 8u, 4u));
	j[0].mB[0] = u8vec3(uvec3(4u, 1u, 7u));
	j[0].mC = (ivec3(8, 1, -8));
	j[0].mD = (mat4(-9.0, 6.0, -5.0, -3.0, 1.0, -1.0, 0.0, 4.0, -5.0, -1.0, 9.0, 1.0, 5.0, 2.0, 7.0, -7.0));
	j[1].mA = (uvec4(1u, 8u, 1u, 7u));
	j[1].mB[0] = u8vec3(uvec3(5u, 1u, 0u));
	j[1].mC = (ivec3(-6, -4, 7));
	j[1].mD = (mat4(-5.0, 7.0, 5.0, 6.0, 3.0, -6.0, 8.0, -4.0, -9.0, 9.0, -9.0, 4.0, -6.0, -6.0, -1.0, 4.0));
	j[2].mA = (uvec4(9u, 8u, 5u, 5u));
	j[2].mB[0] = u8vec3(uvec3(0u, 4u, 9u));
	j[2].mC = (ivec3(8, 6, 4));
	j[2].mD = (mat4(9.0, -8.0, -3.0, 9.0, 4.0, -1.0, 4.0, -9.0, 4.0, -4.0, 3.0, -6.0, 8.0, 4.0, -1.0, 1.0));
	j[3].mA = (uvec4(5u, 2u, 8u, 6u));
	j[3].mB[0] = u8vec3(uvec3(0u, 5u, 0u));
	j[3].mC = (ivec3(-8, 3, -7));
	j[3].mD = (mat4(3.0, 8.0, 2.0, 2.0, 1.0, 6.0, -8.0, 1.0, -1.0, 2.0, 1.0, 7.0, 9.0, 4.0, 8.0, 8.0));
	j[4].mA = (uvec4(8u, 1u, 5u, 7u));
	j[4].mB[0] = u8vec3(uvec3(7u, 0u, 5u));
	j[4].mC = (ivec3(-2, 8, 4));
	j[4].mD = (mat4(1.0, 4.0, -9.0, -6.0, -3.0, -6.0, -3.0, 3.0, -1.0, -5.0, 9.0, 0.0, 1.0, -4.0, -4.0, 5.0));
	j[5].mA = (uvec4(5u, 6u, 7u, 7u));
	j[5].mB[0] = u8vec3(uvec3(4u, 5u, 0u));
	j[5].mC = (ivec3(-1, -1, 6));
	j[5].mD = (mat4(7.0, -7.0, 1.0, 4.0, 9.0, 9.0, -9.0, 5.0, 3.0, -8.0, -2.0, -9.0, 5.0, -7.0, -8.0, -9.0));
	k = int8_t(4294967291);
	l.mA = (false);
	l.mB = (mat2x3(-1.0, 7.0, 1.0, -4.0, -1.0, 5.0));
	l.mC = (vec4(8.0, -3.0, -2.0, 0.0));
	m[0] = (mat3(8.0, -9.0, -1.0, -6.0, 5.0, 4.0, -3.0, 3.0, -2.0));
	m[1] = (mat3(2.0, -5.0, 4.0, 8.0, 3.0, -8.0, -8.0, -1.0, 8.0));
	m[2] = (mat3(0.0, 5.0, 0.0, -7.0, -7.0, 9.0, -6.0, 4.0, 0.0));
}
#version 450
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
	layout(offset = 0) highp vec4 a;
	layout(offset = 16) mediump uvec2 b;
	layout(offset = 24) bool c;
	layout(offset = 32) bvec4 d;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a), vec4(2.0, -3.0, 2.0, -4.0)) && allOk;
	allOk = compare_bool((blockB[0].c), false) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec4(8.0, 7.0, -2.0, 6.0));
	blockB[0].b = (uvec2(0u, 7u));
	blockB[0].c = (false);
	blockB[0].d = (bvec4(false, false, false, true));
}
#version 450
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
	highp ivec3 a;
	highp vec2 b;
	lowp uvec4 c;
	i8vec4 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	i8vec4 e[6];
	mediump uvec3 f;
	mediump uvec4 g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(1, -8, 7)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e[0]), ivec4(9, 4294967289, 4294967287, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e[1]), ivec4(4294967287, 4294967290, 4294967292, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e[2]), ivec4(8, 4294967295, 4294967292, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e[3]), ivec4(6, 4294967294, 4294967289, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e[4]), ivec4(4294967288, 4294967292, 4294967290, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e[5]), ivec4(4294967295, 4294967291, 4294967291, 6)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(3u, 3u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(3u, 6u, 5u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-7, 9, 6));
	blockB.d[0] = i8vec4(ivec4(4294967287, 4294967288, 5, 4294967295));
	blockB.d[1] = i8vec4(ivec4(4294967287, 4294967292, 4, 4294967290));
	blockB.d[2] = i8vec4(ivec4(9, 4294967295, 4294967294, 4294967293));
	blockB.d[3] = i8vec4(ivec4(5, 6, 0, 6));
	blockB.d[4] = i8vec4(ivec4(1, 8, 4294967292, 4294967292));
	blockC.e[0] = i8vec4(ivec4(4294967292, 4294967294, 4294967294, 4294967291));
	blockC.e[1] = i8vec4(ivec4(4294967287, 9, 6, 3));
	blockC.e[2] = i8vec4(ivec4(7, 4294967290, 4294967295, 4294967293));
	blockC.e[3] = i8vec4(ivec4(4294967294, 9, 4294967290, 1));
	blockC.e[4] = i8vec4(ivec4(6, 7, 4294967289, 2));
	blockC.e[5] = i8vec4(ivec4(4294967295, 9, 0, 9));
	blockC.g = (uvec4(8u, 8u, 9u, 4u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(row_major, binding = 1) buffer BlockB
{
	layout(offset = 0) mediump uvec4 a[1];
	layout(offset = 16) u8vec4 b;
	layout(offset = 20) i8vec4 c;
	layout(offset = 24) mediump mat2x3 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].d, mat2x3(7.0, -1.0, -5.0, -1.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].d, mat2x3(-2.0, -2.0, -6.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].d, mat2x3(-1.0, -3.0, 2.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(3)].d, mat2x3(-7.0, 1.0, -2.0, -7.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (uvec4(3u, 2u, 9u, 0u));
	blockB[nonuniformEXT(0)].b = u8vec4(uvec4(7u, 6u, 4u, 0u));
	blockB[nonuniformEXT(0)].c = i8vec4(ivec4(4294967291, 4294967291, 4294967289, 5));
	blockB[nonuniformEXT(0)].d = (mat2x3(2.0, -8.0, 9.0, -4.0, 0.0, 3.0));
	blockB[nonuniformEXT(1)].a[0] = (uvec4(1u, 3u, 8u, 2u));
	blockB[nonuniformEXT(1)].b = u8vec4(uvec4(9u, 0u, 6u, 2u));
	blockB[nonuniformEXT(1)].c = i8vec4(ivec4(7, 4294967288, 5, 4294967294));
	blockB[nonuniformEXT(1)].d = (mat2x3(-7.0, 5.0, -1.0, -2.0, 0.0, 5.0));
	blockB[nonuniformEXT(2)].a[0] = (uvec4(5u, 0u, 1u, 6u));
	blockB[nonuniformEXT(2)].b = u8vec4(uvec4(6u, 4u, 1u, 9u));
	blockB[nonuniformEXT(2)].c = i8vec4(ivec4(4, 4294967293, 1, 6));
	blockB[nonuniformEXT(2)].d = (mat2x3(5.0, 5.0, -1.0, 8.0, -1.0, -1.0));
	blockB[nonuniformEXT(3)].a[0] = (uvec4(9u, 3u, 7u, 5u));
	blockB[nonuniformEXT(3)].b = u8vec4(uvec4(9u, 8u, 8u, 3u));
	blockB[nonuniformEXT(3)].c = i8vec4(ivec4(3, 4294967290, 1, 4294967295));
	blockB[nonuniformEXT(3)].d = (mat2x3(-1.0, 2.0, -4.0, 1.0, -5.0, 4.0));
}
#version 450
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

}
#version 450
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
	allOk = compare_mat3(var, mat3(6.0, 3.0, -1.0, -6.0, 2.0, 1.0, -4.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(1.0, -7.0, -7.0, -8.0, -2.0, 6.0, -6.0, 5.0, -8.0, -5.0, -8.0, -4.0, 4.0, -4.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(4.0, 9.0, -1.0, 1.0, 7.0, -8.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4(var, mat4(6.0, -1.0, -4.0, 5.0, 5.0, -8.0, 7.0, -8.0, 5.0, 4.0, 0.0, 6.0, 5.0, 1.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 6.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[2][2], -4.0) && allOk;
	allOk = compare_float(var[2][3], 2.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], -7.0) && allOk;
	allOk = compare_float(var[3][3], -7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, -2.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-6.0, -4.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(2.0, -5.0, -4.0, 3.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec2 var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(var), uvec2(0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec4 var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(var), uvec4(4u, 6u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec2 var[3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[2]), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec4 var[3];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_vec4((var[0]), vec4(4.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((var[1]), vec4(4.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((var[2]), vec4(-4.0, 3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4(var[0], mat4(8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	lowp ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var), ivec2(-1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec2(5, -9));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(0.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-2.0, -4.0, -8.0, -2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-3.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(2.0, 5.0, 6.0));
	block.var[1] = (vec3(-7.0, 5.0, 4.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	f16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block.var), vec3(4.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = f16vec3(vec3(3.0, 3.0, 7.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(4.0, -8.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(7.0, -1.0, -6.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(-7.0, 2.0, -1.0, 0.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(6.0, 5.0, -4.0));
	block.var[1] = (vec3(-7.0, 8.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-6.0, 6.0, -6.0, 8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-1.0, 5.0, -3.0, -6.0, -5.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_vec2((block.var), vec2(-1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (vec2(3.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat4(block.var, mat4(7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat4(0.0, -9.0, -5.0, 3.0, -8.0, 5.0, -4.0, 0.0, 1.0, 6.0, -2.0, -7.0, -5.0, 0.0, -5.0, 0.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-8.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-6.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var[0] = (vec3(8.0, -4.0, -4.0));
	block.var[1] = (vec3(3.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-5.0, 4.0, -5.0, -8.0, -6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat3x2(4.0, -6.0, -4.0, -1.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-2.0, 2.0, -8.0, -6.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec2(-9.0, -5.0));
	block.var[1] = (vec2(5.0, 6.0));
	block.var[2] = (vec2(5.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], -8.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec2(9.0, -3.0));
	block.var[1] = (vec2(-1.0, 1.0));
	block.var[2] = (vec2(9.0, -7.0));
	block.var[3] = (vec2(-4.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-6.0, 1.0, 6.0, -7.0, 4.0, 3.0, -5.0, 1.0, 0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0] = (vec3(-3.0, -5.0, -8.0));
	block.var[1] = (vec3(5.0, -3.0, -6.0));
	block.var[2] = (vec3(1.0, 6.0, -7.0));
	block.var[3] = (vec3(-9.0, 3.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0] = (vec3(-5.0, 8.0, -8.0));
	block.var[1] = (vec3(-1.0, -5.0, 0.0));
	block.var[2] = (vec3(7.0, 3.0, -1.0));
	block.var[3] = (vec3(7.0, 1.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
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
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
}
#version 450
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
	highp uvec3 var[];
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
	allOk = compare_uvec3((block.var[3]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[4]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[5]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[6]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[7]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[8]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[9]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[10]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[11]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[12]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[13]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[14]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((block.var[15]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[16]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[17]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[18]), uvec3(9u, 3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec3(3u, 5u, 6u));
	block.var[1] = (uvec3(5u, 4u, 5u));
	block.var[2] = (uvec3(4u, 9u, 4u));
	block.var[3] = (uvec3(4u, 7u, 7u));
	block.var[4] = (uvec3(0u, 2u, 9u));
	block.var[5] = (uvec3(4u, 7u, 8u));
	block.var[6] = (uvec3(9u, 4u, 3u));
	block.var[7] = (uvec3(5u, 8u, 0u));
	block.var[8] = (uvec3(5u, 4u, 6u));
	block.var[9] = (uvec3(7u, 7u, 5u));
	block.var[10] = (uvec3(3u, 7u, 0u));
	block.var[11] = (uvec3(8u, 1u, 2u));
	block.var[12] = (uvec3(1u, 1u, 6u));
	block.var[13] = (uvec3(3u, 9u, 4u));
	block.var[14] = (uvec3(9u, 7u, 9u));
	block.var[15] = (uvec3(1u, 4u, 6u));
	block.var[16] = (uvec3(4u, 9u, 3u));
	block.var[17] = (uvec3(4u, 3u, 5u));
	block.var[18] = (uvec3(4u, 8u, 7u));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[3][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[3][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[4][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[4][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[5][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[5][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[6][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[6][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[7][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[7][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[8][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[8][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[9][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[9][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[10][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[10][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[11][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[11][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	block.var[12][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	block.var[12][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	block.var[13][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	block.var[13][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	block.var[14][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	block.var[14][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	block.var[15][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	block.var[15][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	block.var[16][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	block.var[16][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	block.var[17][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	block.var[17][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	block.var[18][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	block.var[18][1] = (vec4(2.0, 1.0, 3.0, -6.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[3][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[3][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[3][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[3][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[4][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[4][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[4][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[4][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[5][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[5][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[5][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[5][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[6][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[6][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[6][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[6][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[7][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[7][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[7][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[7][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[8][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[8][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[8][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[8][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[9][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[9][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[9][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[9][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[10][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[10][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[10][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[10][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[11][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[11][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[11][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[11][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[12][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	block.var[12][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[12][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[12][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[13][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	block.var[13][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[13][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[13][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[14][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	block.var[14][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[14][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[14][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[15][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	block.var[15][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[15][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[15][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[16][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	block.var[16][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[16][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[16][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[17][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	block.var[17][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[17][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[17][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[18][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	block.var[18][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[18][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[18][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x4(block.var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[3][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[3][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[4][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[4][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[5][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[5][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[6][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[6][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[7][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[7][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[8][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[8][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[9][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[9][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[10][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[10][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[11][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[11][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	block.var[12][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	block.var[12][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	block.var[13][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	block.var[13][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	block.var[14][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	block.var[14][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	block.var[15][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	block.var[15][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	block.var[16][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	block.var[16][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	block.var[17][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	block.var[17][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	block.var[18][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	block.var[18][1] = (vec4(2.0, 1.0, 3.0, -6.0));
}
#version 450
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
	i8vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var[0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][2]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][2]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][2]), ivec2(3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i8vec2(ivec2(0, 8));
	block.var[0][1] = i8vec2(ivec2(4294967292, 9));
	block.var[0][2] = i8vec2(ivec2(4294967294, 4294967295));
	block.var[1][0] = i8vec2(ivec2(8, 4294967290));
	block.var[1][1] = i8vec2(ivec2(8, 4294967289));
	block.var[1][2] = i8vec2(ivec2(7, 4294967294));
	block.var[2][0] = i8vec2(ivec2(4294967293, 4294967293));
	block.var[2][1] = i8vec2(ivec2(4294967290, 3));
	block.var[2][2] = i8vec2(ivec2(4294967295, 8));
	block.var[3][0] = i8vec2(ivec2(5, 8));
	block.var[3][1] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[3][2] = i8vec2(ivec2(4294967287, 6));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[0][1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[0][2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[0][2][1] = (vec3(7.0, 0.0, -8.0));
	block.var[1][0][0] = (vec3(0.0, -5.0, 5.0));
	block.var[1][0][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][1][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[1][1][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[1][2][0] = (vec3(2.0, -3.0, 6.0));
	block.var[1][2][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[2][0][0] = (vec3(6.0, -2.0, 0.0));
	block.var[2][0][1] = (vec3(3.0, 4.0, -6.0));
	block.var[2][1][0] = (vec3(3.0, -6.0, 2.0));
	block.var[2][1][1] = (vec3(4.0, -8.0, 0.0));
	block.var[2][2][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[2][2][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[3][0][0] = (vec3(4.0, -9.0, -1.0));
	block.var[3][0][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[3][1][0] = (vec3(2.0, -2.0, 4.0));
	block.var[3][1][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[3][2][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[3][2][1] = (vec3(2.0, 0.0, 5.0));
}
#version 450
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
	highp vec3 var[4][3];
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
	allOk = compare_vec3((block.var[0][0]), vec3(9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((block.var[0][1]), vec3(5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[0][2]), vec3(-1.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec3((block.var[1][0]), vec3(-9.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((block.var[1][1]), vec3(-2.0, -4.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[1][2]), vec3(3.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[2][0]), vec3(-4.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[2][1]), vec3(6.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((block.var[2][2]), vec3(5.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[3][0]), vec3(5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[3][1]), vec3(-8.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3((block.var[3][2]), vec3(-3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0] = (vec3(4.0, 7.0, 8.0));
	block.var[0][1] = (vec3(-2.0, 7.0, -5.0));
	block.var[0][2] = (vec3(-7.0, 9.0, 6.0));
	block.var[1][0] = (vec3(6.0, 0.0, -5.0));
	block.var[1][1] = (vec3(2.0, -8.0, 5.0));
	block.var[1][2] = (vec3(0.0, 2.0, 0.0));
	block.var[2][0] = (vec3(5.0, 1.0, -5.0));
	block.var[2][1] = (vec3(0.0, 1.0, 0.0));
	block.var[2][2] = (vec3(7.0, -2.0, -2.0));
	block.var[3][0] = (vec3(8.0, -1.0, -1.0));
	block.var[3][1] = (vec3(5.0, 1.0, -1.0));
	block.var[3][2] = (vec3(-3.0, 8.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0, -8.0, 6.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0, 5.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0, -2.0, 3.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0, -3.0, 1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0, 6.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0, 8.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0, -3.0, -4.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0, -5.0, 7.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0, 4.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0, 1.0, 8.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][0][2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	block.var[0][1][0] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][1][1] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][1][2] = (vec4(-7.0, 6.0, -4.0, 2.0));
	block.var[0][2][0] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[0][2][1] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[0][2][2] = (vec4(-7.0, 2.0, -6.0, 3.0));
	block.var[1][0][0] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][1] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][0][2] = (vec4(-3.0, 5.0, 9.0, 3.0));
	block.var[1][1][0] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[1][1][1] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[1][1][2] = (vec4(4.0, -1.0, -5.0, -8.0));
	block.var[1][2][0] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[1][2][1] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[1][2][2] = (vec4(-2.0, 9.0, 8.0, 7.0));
	block.var[2][0][0] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[2][0][1] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[2][0][2] = (vec4(4.0, -2.0, -4.0, 2.0));
	block.var[2][1][0] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[2][1][1] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[2][1][2] = (vec4(3.0, -1.0, 9.0, -8.0));
	block.var[2][2][0] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[2][2][1] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[2][2][2] = (vec4(4.0, -8.0, 5.0, -2.0));
	block.var[3][0][0] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[3][0][1] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[3][0][2] = (vec4(4.0, -9.0, -3.0, -6.0));
	block.var[3][1][0] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[3][1][1] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[3][1][2] = (vec4(2.0, 5.0, -5.0, 7.0));
	block.var[3][2][0] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[3][2][1] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[3][2][2] = (vec4(-4.0, -7.0, -3.0, 7.0));
}
#version 450
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
	bvec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[1][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[3][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[3][1][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec2(true, false));
	block.var[0][0][1] = (bvec2(true, true));
	block.var[0][0][2] = (bvec2(false, false));
	block.var[0][1][0] = (bvec2(false, true));
	block.var[0][1][1] = (bvec2(true, true));
	block.var[0][1][2] = (bvec2(false, false));
	block.var[1][0][0] = (bvec2(false, false));
	block.var[1][0][1] = (bvec2(false, true));
	block.var[1][0][2] = (bvec2(true, true));
	block.var[1][1][0] = (bvec2(true, true));
	block.var[1][1][1] = (bvec2(true, false));
	block.var[1][1][2] = (bvec2(false, false));
	block.var[2][0][0] = (bvec2(false, false));
	block.var[2][0][1] = (bvec2(false, true));
	block.var[2][0][2] = (bvec2(true, true));
	block.var[2][1][0] = (bvec2(true, false));
	block.var[2][1][1] = (bvec2(true, false));
	block.var[2][1][2] = (bvec2(true, false));
	block.var[3][0][0] = (bvec2(false, false));
	block.var[3][0][1] = (bvec2(true, false));
	block.var[3][0][2] = (bvec2(true, false));
	block.var[3][1][0] = (bvec2(false, false));
	block.var[3][1][1] = (bvec2(false, false));
	block.var[3][1][2] = (bvec2(false, true));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[0][0][2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[0][1][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	block.var[0][1][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	block.var[0][1][2] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	block.var[1][0][0] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[1][0][1] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[1][0][2] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[1][1][0] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	block.var[1][1][1] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	block.var[1][1][2] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	block.var[2][0][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[2][0][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[2][0][2] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[2][1][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	block.var[2][1][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	block.var[2][1][2] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	block.var[3][0][0] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[3][0][1] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[3][0][2] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	block.var[3][1][0] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	block.var[3][1][1] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	block.var[3][1][2] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-8.0, 7.0, -3.0, -1.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(3.0, 4.0, -2.0, -2.0, -6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(8.0, -1.0, 6.0, -1.0, 5.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(-1.0, 7.0, 4.0, 1.0, 8.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(7.0, 3.0, -4.0, 5.0, 4.0, 8.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[0][0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[0][0][2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[0][0][2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[0][1][0][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	block.var[0][1][0][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	block.var[0][1][1][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	block.var[0][1][1][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	block.var[0][1][2][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	block.var[0][1][2][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	block.var[1][0][0][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	block.var[1][0][0][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[1][0][1][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	block.var[1][0][1][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[1][0][2][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	block.var[1][0][2][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[1][1][0][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	block.var[1][1][0][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	block.var[1][1][1][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	block.var[1][1][1][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	block.var[1][1][2][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	block.var[1][1][2][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	block.var[2][0][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	block.var[2][0][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[2][0][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	block.var[2][0][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[2][0][2][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	block.var[2][0][2][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[2][1][0][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	block.var[2][1][0][1] = (vec4(1.0, -2.0, 4.0, 5.0));
	block.var[2][1][1][0] = (vec4(0.0, 7.0, 8.0, 6.0));
	block.var[2][1][1][1] = (vec4(-7.0, -6.0, -1.0, 7.0));
	block.var[2][1][2][0] = (vec4(-1.0, -9.0, 8.0, 3.0));
	block.var[2][1][2][1] = (vec4(-6.0, 4.0, 0.0, 8.0));
	block.var[3][0][0][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	block.var[3][0][0][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[3][0][1][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	block.var[3][0][1][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[3][0][2][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	block.var[3][0][2][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	block.var[3][1][0][0] = (vec4(0.0, 9.0, 6.0, 5.0));
	block.var[3][1][0][1] = (vec4(-1.0, 1.0, 1.0, 7.0));
	block.var[3][1][1][0] = (vec4(6.0, -6.0, -7.0, 9.0));
	block.var[3][1][1][1] = (vec4(-7.0, -4.0, -9.0, 7.0));
	block.var[3][1][2][0] = (vec4(-2.0, 4.0, -8.0, -3.0));
	block.var[3][1][2][1] = (vec4(1.0, 7.0, 7.0, -3.0));
}
#version 450
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
	highp vec2 var[4][2][3];
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
	allOk = compare_vec2((block.var[0][0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][0]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][2]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][2]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][2]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][1]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][2]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(3.0, 8.0));
	block.var[0][0][1] = (vec2(7.0, -1.0));
	block.var[0][0][2] = (vec2(-4.0, 8.0));
	block.var[0][1][0] = (vec2(-6.0, -2.0));
	block.var[0][1][1] = (vec2(5.0, 4.0));
	block.var[0][1][2] = (vec2(0.0, 0.0));
	block.var[1][0][0] = (vec2(-2.0, -5.0));
	block.var[1][0][1] = (vec2(-2.0, 5.0));
	block.var[1][0][2] = (vec2(6.0, -2.0));
	block.var[1][1][0] = (vec2(-4.0, -9.0));
	block.var[1][1][1] = (vec2(-2.0, 2.0));
	block.var[1][1][2] = (vec2(-2.0, 8.0));
	block.var[2][0][0] = (vec2(-6.0, -6.0));
	block.var[2][0][1] = (vec2(1.0, 6.0));
	block.var[2][0][2] = (vec2(-7.0, 6.0));
	block.var[2][1][0] = (vec2(-4.0, -4.0));
	block.var[2][1][1] = (vec2(-2.0, -8.0));
	block.var[2][1][2] = (vec2(2.0, 9.0));
	block.var[3][0][0] = (vec2(1.0, -6.0));
	block.var[3][0][1] = (vec2(-9.0, 0.0));
	block.var[3][0][2] = (vec2(-8.0, -4.0));
	block.var[3][1][0] = (vec2(-8.0, 9.0));
	block.var[3][1][1] = (vec2(0.0, -8.0));
	block.var[3][1][2] = (vec2(1.0, 5.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(3.0, 6.0, -1.0, 9.0, 5.0, -8.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-9.0, -6.0, -1.0, -8.0, 7.0, -5.0, 7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(8.0, -5.0, 6.0, -9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(1.0, -4.0, -4.0, 1.0, -5.0, -1.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-7.0, -8.0, -7.0, -4.0, -7.0, 6.0, -9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[0][0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[0][0][2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[0][1][0] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	block.var[0][1][1] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	block.var[0][1][2] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	block.var[1][0][0] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[1][0][1] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[1][0][2] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[1][1][0] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	block.var[1][1][1] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	block.var[1][1][2] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	block.var[2][0][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[2][0][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[2][0][2] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[2][1][0] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
	block.var[2][1][1] = (mat3(1.0, -8.0, 5.0, -8.0, -4.0, 5.0, -4.0, 5.0, 3.0));
	block.var[2][1][2] = (mat3(2.0, 4.0, 4.0, -7.0, -3.0, 4.0, -2.0, -2.0, 9.0));
	block.var[3][0][0] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[3][0][1] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[3][0][2] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	block.var[3][1][0] = (mat3(-1.0, -5.0, -7.0, -6.0, -6.0, 4.0, 0.0, -9.0, 8.0));
	block.var[3][1][1] = (mat3(-2.0, 1.0, -3.0, 1.0, -3.0, -7.0, -3.0, 6.0, -6.0));
	block.var[3][1][2] = (mat3(3.0, 9.0, 2.0, 3.0, 9.0, -1.0, -7.0, 4.0, 2.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[0][0][2][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[0][0][2][1] = (vec3(3.0, 9.0, -8.0));
	block.var[0][0][2][2] = (vec3(-4.0, 8.0, 0.0));
	block.var[0][1][0][0] = (vec3(4.0, 2.0, 9.0));
	block.var[0][1][0][1] = (vec3(-7.0, 2.0, 0.0));
	block.var[0][1][0][2] = (vec3(0.0, -4.0, 3.0));
	block.var[0][1][1][0] = (vec3(-7.0, -7.0, 1.0));
	block.var[0][1][1][1] = (vec3(1.0, -5.0, 0.0));
	block.var[0][1][1][2] = (vec3(5.0, -6.0, 7.0));
	block.var[0][1][2][0] = (vec3(-2.0, 8.0, -5.0));
	block.var[0][1][2][1] = (vec3(4.0, -8.0, 2.0));
	block.var[0][1][2][2] = (vec3(4.0, 2.0, -7.0));
	block.var[1][0][0][0] = (vec3(5.0, -1.0, 2.0));
	block.var[1][0][0][1] = (vec3(3.0, 0.0, 8.0));
	block.var[1][0][0][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[1][0][1][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[1][0][1][1] = (vec3(7.0, 3.0, 7.0));
	block.var[1][0][1][2] = (vec3(5.0, -4.0, 3.0));
	block.var[1][0][2][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[1][0][2][1] = (vec3(7.0, -1.0, 2.0));
	block.var[1][0][2][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[1][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[1][1][0][1] = (vec3(0.0, 5.0, -5.0));
	block.var[1][1][0][2] = (vec3(3.0, 3.0, -8.0));
	block.var[1][1][1][0] = (vec3(0.0, -7.0, -2.0));
	block.var[1][1][1][1] = (vec3(-8.0, 3.0, -2.0));
	block.var[1][1][1][2] = (vec3(9.0, -7.0, -7.0));
	block.var[1][1][2][0] = (vec3(4.0, -6.0, -3.0));
	block.var[1][1][2][1] = (vec3(-9.0, -3.0, 8.0));
	block.var[1][1][2][2] = (vec3(-8.0, -1.0, -6.0));
	block.var[2][0][0][0] = (vec3(9.0, -7.0, -5.0));
	block.var[2][0][0][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[2][0][0][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[2][0][1][0] = (vec3(7.0, -5.0, 1.0));
	block.var[2][0][1][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[2][0][1][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[2][0][2][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[2][0][2][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[2][0][2][2] = (vec3(3.0, 0.0, -1.0));
	block.var[2][1][0][0] = (vec3(0.0, 5.0, 9.0));
	block.var[2][1][0][1] = (vec3(-2.0, -2.0, 3.0));
	block.var[2][1][0][2] = (vec3(-5.0, 3.0, -7.0));
	block.var[2][1][1][0] = (vec3(-2.0, -3.0, 0.0));
	block.var[2][1][1][1] = (vec3(-8.0, -8.0, 6.0));
	block.var[2][1][1][2] = (vec3(2.0, -2.0, -4.0));
	block.var[2][1][2][0] = (vec3(7.0, 1.0, 7.0));
	block.var[2][1][2][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[2][1][2][2] = (vec3(4.0, -6.0, -5.0));
	block.var[3][0][0][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[3][0][0][1] = (vec3(3.0, 3.0, -1.0));
	block.var[3][0][0][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[3][0][1][0] = (vec3(7.0, 4.0, -7.0));
	block.var[3][0][1][1] = (vec3(7.0, 7.0, -4.0));
	block.var[3][0][1][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[3][0][2][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[3][0][2][1] = (vec3(8.0, 9.0, 3.0));
	block.var[3][0][2][2] = (vec3(0.0, -5.0, -7.0));
	block.var[3][1][0][0] = (vec3(-6.0, -9.0, -9.0));
	block.var[3][1][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[3][1][0][2] = (vec3(7.0, 7.0, -2.0));
	block.var[3][1][1][0] = (vec3(-3.0, 4.0, 1.0));
	block.var[3][1][1][1] = (vec3(-6.0, 4.0, 7.0));
	block.var[3][1][1][2] = (vec3(-2.0, -4.0, -3.0));
	block.var[3][1][2][0] = (vec3(-3.0, -5.0, 1.0));
	block.var[3][1][2][1] = (vec3(4.0, 9.0, -7.0));
	block.var[3][1][2][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	i8vec4 var[4][2][3];
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
	allOk = compare_i8vec4(ivec4(block.var[0][0][2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][2]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][0]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][1]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][2]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][0]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][1]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][2]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][2]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][2]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][0]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][1]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][2]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][0]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][1]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][2]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[0][0][2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[0][1][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[0][1][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[0][1][2] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[1][0][0] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[1][0][1] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[1][0][2] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[1][1][0] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[1][1][1] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[1][1][2] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[2][0][0] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[2][0][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[2][0][2] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[2][1][0] = i8vec4(ivec4(1, 0, 5, 0));
	block.var[2][1][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	block.var[2][1][2] = i8vec4(ivec4(6, 1, 0, 2));
	block.var[3][0][0] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[3][0][1] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[3][0][2] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[3][1][0] = i8vec4(ivec4(6, 1, 9, 4294967291));
	block.var[3][1][1] = i8vec4(ivec4(4294967295, 0, 3, 9));
	block.var[3][1][2] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
	bvec2 var[4][2][3];
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
	allOk = compare_bvec2((block.var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[1][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[1][1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[3][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1][2]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0][0][0] = (bvec2(false, true));
	block.var[0][0][1] = (bvec2(true, false));
	block.var[0][0][2] = (bvec2(false, false));
	block.var[0][1][0] = (bvec2(true, true));
	block.var[0][1][1] = (bvec2(true, false));
	block.var[0][1][2] = (bvec2(false, true));
	block.var[1][0][0] = (bvec2(false, false));
	block.var[1][0][1] = (bvec2(true, true));
	block.var[1][0][2] = (bvec2(true, false));
	block.var[1][1][0] = (bvec2(true, true));
	block.var[1][1][1] = (bvec2(false, false));
	block.var[1][1][2] = (bvec2(false, true));
	block.var[2][0][0] = (bvec2(false, false));
	block.var[2][0][1] = (bvec2(true, true));
	block.var[2][0][2] = (bvec2(true, false));
	block.var[2][1][0] = (bvec2(false, true));
	block.var[2][1][1] = (bvec2(false, true));
	block.var[2][1][2] = (bvec2(false, false));
	block.var[3][0][0] = (bvec2(false, true));
	block.var[3][0][1] = (bvec2(false, true));
	block.var[3][0][2] = (bvec2(false, false));
	block.var[3][1][0] = (bvec2(false, false));
	block.var[3][1][1] = (bvec2(false, false));
	block.var[3][1][2] = (bvec2(true, true));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-6.0, -5.0, 5.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-6.0, -8.0, 6.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-8.0, 9.0, -8.0, -3.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(7.0, 3.0, 8.0, 1.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-7.0, 7.0, 5.0, -3.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(0.0, 2.0, -5.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(0.0, 4.0, 3.0, 9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-1.0, -2.0, -8.0, -4.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-6.0, 0.0, -1.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(6.0, -3.0, 2.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-6.0, -8.0, -7.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-1.0, 1.0, 6.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(7.0, -4.0, 3.0, 7.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-2.0, 0.0, -2.0, 1.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-4.0, 1.0, -1.0, 0.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-2.0, -2.0, -9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(2.0, -1.0, -3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(0.0, 6.0, 9.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-7.0, -1.0, -4.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(9.0, 8.0, 2.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-3.0, 8.0, -5.0, 6.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(8.0, 6.0, 6.0, 0.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(5.0, 4.0, 5.0, -9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-1.0, -1.0, -7.0, 8.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0][0] = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	block.var[0][0][1] = (mat3x2(-8.0, 1.0, 5.0, -2.0, 7.0, 4.0));
	block.var[0][0][2] = (mat3x2(-6.0, 7.0, -6.0, 2.0, 5.0, 0.0));
	block.var[0][1][0] = (mat3x2(-9.0, -8.0, 7.0, -5.0, -1.0, -7.0));
	block.var[0][1][1] = (mat3x2(4.0, -2.0, -6.0, -5.0, 6.0, -3.0));
	block.var[0][1][2] = (mat3x2(-7.0, 9.0, 9.0, -8.0, 0.0, 6.0));
	block.var[1][0][0] = (mat3x2(6.0, -5.0, 4.0, -2.0, 0.0, -3.0));
	block.var[1][0][1] = (mat3x2(-3.0, -2.0, 9.0, -2.0, -7.0, -9.0));
	block.var[1][0][2] = (mat3x2(-2.0, -8.0, 4.0, 3.0, 8.0, 7.0));
	block.var[1][1][0] = (mat3x2(-3.0, 9.0, -2.0, -5.0, -4.0, -4.0));
	block.var[1][1][1] = (mat3x2(6.0, -7.0, 5.0, -1.0, 5.0, 4.0));
	block.var[1][1][2] = (mat3x2(-7.0, -3.0, 6.0, -8.0, 2.0, -3.0));
	block.var[2][0][0] = (mat3x2(9.0, -5.0, 9.0, -1.0, 4.0, 6.0));
	block.var[2][0][1] = (mat3x2(-4.0, -6.0, 0.0, 7.0, -2.0, -1.0));
	block.var[2][0][2] = (mat3x2(-9.0, 8.0, -6.0, -9.0, 5.0, 2.0));
	block.var[2][1][0] = (mat3x2(-4.0, -7.0, 0.0, 8.0, 4.0, -8.0));
	block.var[2][1][1] = (mat3x2(-5.0, -1.0, -5.0, 2.0, -6.0, 3.0));
	block.var[2][1][2] = (mat3x2(4.0, 5.0, 1.0, -7.0, 1.0, 2.0));
	block.var[3][0][0] = (mat3x2(-9.0, 9.0, 4.0, -4.0, 9.0, 3.0));
	block.var[3][0][1] = (mat3x2(3.0, 1.0, -4.0, 0.0, -7.0, -4.0));
	block.var[3][0][2] = (mat3x2(7.0, 7.0, -1.0, -2.0, 6.0, 4.0));
	block.var[3][1][0] = (mat3x2(-7.0, -1.0, -4.0, 8.0, 1.0, -8.0));
	block.var[3][1][1] = (mat3x2(2.0, 7.0, 8.0, -5.0, -3.0, 8.0));
	block.var[3][1][2] = (mat3x2(-6.0, 3.0, -2.0, 7.0, -4.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[0][1][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[0][1][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[0][1][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[0][1][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[0][2][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[0][2][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[0][2][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[0][2][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[0][3][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[0][3][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	block.var[0][3][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	block.var[0][3][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	block.var[1][0][0][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[1][0][0][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[1][0][1][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[1][0][1][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[1][1][0][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[1][1][0][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[1][1][1][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[1][1][1][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[1][2][0][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[1][2][0][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[1][2][1][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[1][2][1][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[1][3][0][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	block.var[1][3][0][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	block.var[1][3][1][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	block.var[1][3][1][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	block.var[2][0][0][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[2][0][0][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[2][0][1][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[2][0][1][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[2][1][0][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[2][1][0][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[2][1][1][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[2][1][1][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[2][2][0][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[2][2][0][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[2][2][1][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[2][2][1][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[2][3][0][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	block.var[2][3][0][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	block.var[2][3][1][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	block.var[2][3][1][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[0][1][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	block.var[0][1][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	block.var[0][2][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	block.var[0][2][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	block.var[0][3][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	block.var[0][3][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	block.var[1][0][0] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	block.var[1][0][1] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	block.var[1][1][0] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	block.var[1][1][1] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	block.var[1][2][0] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	block.var[1][2][1] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	block.var[1][3][0] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	block.var[1][3][1] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	block.var[2][0][0] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	block.var[2][0][1] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	block.var[2][1][0] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	block.var[2][1][1] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	block.var[2][2][0] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	block.var[2][2][1] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	block.var[2][3][0] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	block.var[2][3][1] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[0][1][0][0] = (vec3(9.0, -7.0, -5.0));
	block.var[0][1][0][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[0][1][0][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[0][1][1][0] = (vec3(7.0, -5.0, 1.0));
	block.var[0][1][1][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[0][1][1][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[0][2][0][0] = (vec3(4.0, 2.0, 9.0));
	block.var[0][2][0][1] = (vec3(-7.0, 2.0, 0.0));
	block.var[0][2][0][2] = (vec3(0.0, -4.0, 3.0));
	block.var[0][2][1][0] = (vec3(-7.0, -7.0, 1.0));
	block.var[0][2][1][1] = (vec3(1.0, -5.0, 0.0));
	block.var[0][2][1][2] = (vec3(5.0, -6.0, 7.0));
	block.var[0][3][0][0] = (vec3(0.0, 5.0, 9.0));
	block.var[0][3][0][1] = (vec3(-2.0, -2.0, 3.0));
	block.var[0][3][0][2] = (vec3(-5.0, 3.0, -7.0));
	block.var[0][3][1][0] = (vec3(-2.0, -3.0, 0.0));
	block.var[0][3][1][1] = (vec3(-8.0, -8.0, 6.0));
	block.var[0][3][1][2] = (vec3(2.0, -2.0, -4.0));
	block.var[1][0][0][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[1][0][0][1] = (vec3(3.0, 9.0, -8.0));
	block.var[1][0][0][2] = (vec3(-4.0, 8.0, 0.0));
	block.var[1][0][1][0] = (vec3(5.0, -1.0, 2.0));
	block.var[1][0][1][1] = (vec3(3.0, 0.0, 8.0));
	block.var[1][0][1][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[1][1][0][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[1][1][0][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[1][1][0][2] = (vec3(3.0, 0.0, -1.0));
	block.var[1][1][1][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[1][1][1][1] = (vec3(3.0, 3.0, -1.0));
	block.var[1][1][1][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[1][2][0][0] = (vec3(-2.0, 8.0, -5.0));
	block.var[1][2][0][1] = (vec3(4.0, -8.0, 2.0));
	block.var[1][2][0][2] = (vec3(4.0, 2.0, -7.0));
	block.var[1][2][1][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[1][2][1][1] = (vec3(0.0, 5.0, -5.0));
	block.var[1][2][1][2] = (vec3(3.0, 3.0, -8.0));
	block.var[1][3][0][0] = (vec3(7.0, 1.0, 7.0));
	block.var[1][3][0][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[1][3][0][2] = (vec3(4.0, -6.0, -5.0));
	block.var[1][3][1][0] = (vec3(-6.0, -9.0, -9.0));
	block.var[1][3][1][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][3][1][2] = (vec3(7.0, 7.0, -2.0));
	block.var[2][0][0][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[2][0][0][1] = (vec3(7.0, 3.0, 7.0));
	block.var[2][0][0][2] = (vec3(5.0, -4.0, 3.0));
	block.var[2][0][1][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[2][0][1][1] = (vec3(7.0, -1.0, 2.0));
	block.var[2][0][1][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[2][1][0][0] = (vec3(7.0, 4.0, -7.0));
	block.var[2][1][0][1] = (vec3(7.0, 7.0, -4.0));
	block.var[2][1][0][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[2][1][1][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[2][1][1][1] = (vec3(8.0, 9.0, 3.0));
	block.var[2][1][1][2] = (vec3(0.0, -5.0, -7.0));
	block.var[2][2][0][0] = (vec3(0.0, -7.0, -2.0));
	block.var[2][2][0][1] = (vec3(-8.0, 3.0, -2.0));
	block.var[2][2][0][2] = (vec3(9.0, -7.0, -7.0));
	block.var[2][2][1][0] = (vec3(4.0, -6.0, -3.0));
	block.var[2][2][1][1] = (vec3(-9.0, -3.0, 8.0));
	block.var[2][2][1][2] = (vec3(-8.0, -1.0, -6.0));
	block.var[2][3][0][0] = (vec3(-3.0, 4.0, 1.0));
	block.var[2][3][0][1] = (vec3(-6.0, 4.0, 7.0));
	block.var[2][3][0][2] = (vec3(-2.0, -4.0, -3.0));
	block.var[2][3][1][0] = (vec3(-3.0, -5.0, 1.0));
	block.var[2][3][1][1] = (vec3(4.0, 9.0, -7.0));
	block.var[2][3][1][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-5, -1, -9)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, 6.0, -3.0, -6.0, -2.0, -6.0, 3.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(0.0, -9.0, 8.0, -9.0, 9.0, 3.0, 6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(6.0, -1.0, 9.0, -2.0, -7.0, -8.0, 2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(4.0, 4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-9, -7, 5));
	block.s.b[0][0] = (vec3(-6.0, 3.0, -3.0));
	block.s.b[0][1] = (vec3(-2.0, -9.0, 1.0));
	block.s.b[0][2] = (vec3(-7.0, 9.0, 9.0));
	block.s.b[1][0] = (vec3(-7.0, -8.0, 3.0));
	block.s.b[1][1] = (vec3(-7.0, 8.0, 6.0));
	block.s.b[1][2] = (vec3(8.0, 0.0, 5.0));
	block.s.b[2][0] = (vec3(-7.0, -6.0, -1.0));
	block.s.b[2][1] = (vec3(3.0, 7.0, 3.0));
	block.s.b[2][2] = (vec3(-2.0, 9.0, 9.0));
	block.s.b[3][0] = (vec3(-1.0, 9.0, 0.0));
	block.s.b[3][1] = (vec3(5.0, -2.0, 4.0));
	block.s.b[3][2] = (vec3(-3.0, 0.0, 7.0));
	block.s.c = (vec4(-2.0, -7.0, 1.0, 4.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_float((block[0].padding), -3.0) && allOk;
	allOk = compare_mat2x3(block[0].var, mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(1.0, 4.0, -2.0, 0.0, -7.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -8.0) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, 1.0, -3.0, 3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var = (mat2x3(-2.0, -5.0, 0.0, 7.0, -2.0, 0.0));
	block[1].padding = (9.0);
	block[1].var = (mat2x3(9.0, 8.0, -6.0, 3.0, -9.0, 0.0));
	block[2].padding = (1.0);
	block[2].var = (mat2x3(1.0, 7.0, -8.0, 7.0, -4.0, 4.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -2.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(9.0, 2.0, -1.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), -1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -4.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-3.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-5.0, 4.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat2x4(2.0, -2.0, 9.0, -4.0, 3.0, 2.0, -4.0, 0.0));
	block[1].padding = (6.0);
	block[1].var = (mat2x4(7.0, 4.0, -8.0, 2.0, 0.0, -1.0, -8.0, 5.0));
	block[2].padding = (8.0);
	block[2].var = (mat2x4(4.0, -3.0, 4.0, 7.0, 2.0, 4.0, -6.0, 1.0));
}
#version 450
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
	highp mat3x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(-4.0, -6.0, 5.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(9.0, -1.0, 4.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(2.0, 7.0, 6.0, -8.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var = (mat3x2(-1.0, 2.0, -8.0, -4.0, 9.0, 6.0));
	block[1].padding = (8.0);
	block[1].var = (mat3x2(5.0, -7.0, -7.0, 0.0, 5.0, 8.0));
	block[2].padding = (1.0);
	block[2].var = (mat3x2(-4.0, 1.0, 3.0, 0.0, -6.0, -9.0));
}
#version 450
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
	highp float a;
	lowp float b;
	mediump uint c;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp int d[1];
	highp uint e;
	mediump int f;
	mediump uint g;
};
layout(std140, buffer_reference) buffer BlockD
{
	bool h;
	highp float i;
	bool j;
	mediump int k;
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

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 6.0) && allOk;
	allOk = compare_uint((blockB.c), 3u) && allOk;
	allOk = compare_int((blockC.d[0]), -3) && allOk;
	allOk = compare_uint((blockC.e), 4u) && allOk;
	allOk = compare_int((blockC.f), -9) && allOk;
	allOk = compare_uint((blockC.g), 4u) && allOk;
	allOk = compare_bool((blockD.h), true) && allOk;
	allOk = compare_float((blockD.i), 8.0) && allOk;
	allOk = compare_bool((blockD.j), true) && allOk;
	allOk = compare_int((blockD.k), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5.0);
	blockB.b = (9.0);
	blockB.c = (4u);
	blockC.e = (7u);
	blockC.f = (-5);
	blockC.g = (4u);
	blockD.i = (-9.0);
	blockD.k = (1);
}
#version 450
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
	bool a;
	lowp int b[1];
};
layout(std430, buffer_reference) buffer BlockC
{
	bool c;
	highp int d;
	mediump uint e[1];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp int f;
	bool g;
	mediump int h;
	lowp int i[1];
	bool j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_int((blockC.d), 5) && allOk;
	allOk = compare_uint((blockC.e[0]), 1u) && allOk;
	allOk = compare_bool((blockD.g), true) && allOk;
	allOk = compare_int((blockD.h), 6) && allOk;
	allOk = compare_int((blockD.i[0]), 0) && allOk;
	allOk = compare_bool((blockD.j), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (false);
	blockC.d = (8);
	blockC.e[0] = (8u);
	blockD.f = (1);
	blockD.h = (0);
	blockD.j = (true);
}
#version 450
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
};
struct sB
{
	mediump uvec2 mA;
	sA mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp mat3x4 a;
	lowp vec4 b[1];
	highp mat3x4 c;
	mediump vec3 d;
	mediump mat2 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp uvec3 f;
	sB g;
	mediump ivec3 h;
	mediump mat4 i;
	mediump ivec4 j[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.c, mat3x4(-2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(-1.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2(blockB.e[0], mat2(-4.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(8u, 1u, 3u)) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(-6, -9, -8)) && allOk;
	allOk = compare_ivec4((blockC.j[0]), ivec4(0, -8, -3, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (vec3(3.0, -1.0, -6.0));
	blockB.e[0] = (mat2(-4.0, -5.0, 3.0, -5.0));
	blockC.g.mA = (uvec2(8u, 4u));
	blockC.g.mB.mA = (mat3(-4.0, 8.0, -5.0, 2.0, -2.0, 8.0, -1.0, -1.0, 1.0));
	blockC.h = (ivec3(7, 8, 7));
	blockC.j[0] = (ivec4(-5, -1, -8, -7));
}
#version 450
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
	highp vec3 a;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	mediump mat3x4 b;
	mediump uvec2 c;
	bvec2 d;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat3x4 e[];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.c), uvec2(5u, 9u)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(false, true)) && allOk;
	allOk = compare_mat3x4(blockD.e[0], mat3x4(-7.0, 9.0, -2.0, -6.0, 7.0, -6.0, -8.0, 5.0, 0.0, 5.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(1.0, 1.0, -4.0));
	blockD.e[0] = (mat3x4(5.0, -4.0, 0.0, -8.0, -2.0, -8.0, 3.0, -9.0, -1.0, 2.0, 9.0, -2.0));
}
#version 450
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
	mediump vec2 mB;
	highp vec3 mC;
	lowp vec4 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump ivec2 a;
	bool b;
	sA c;
	bvec3 d;
	mediump mat4x3 e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp uint f;
	mediump mat4x3 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump uint h[3];
	lowp mat3x4 i[];
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump mat4x2 j;
	mediump uint k[4];
	mediump ivec3 l;
	lowp ivec3 m[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_mat4x2(blockB.c.mA, mat4x2(-4.0, -4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB.c.mB), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c.mC), vec3(9.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB.c.mD), vec4(6.0, 0.0, -1.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(true, true, true)) && allOk;
	allOk = compare_mat4x3(blockB.e, mat4x3(-1.0, -1.0, 6.0, 1.0, 1.0, 7.0, 2.0, -6.0, 8.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_uint((blockC.f), 4u) && allOk;
	allOk = compare_mat4x3(blockC.g[0], mat4x3(1.0, -8.0, -9.0, 5.0, 0.0, -3.0, 9.0, 1.0, -6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC.g[1], mat4x3(-7.0, -9.0, 6.0, -4.0, -1.0, 5.0, 3.0, 8.0, -2.0, 1.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC.g[2], mat4x3(0.0, 0.0, -7.0, -9.0, 6.0, 4.0, 5.0, 3.0, -1.0, 1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC.g[3], mat4x3(8.0, 8.0, 0.0, -2.0, -5.0, -7.0, -8.0, 0.0, -6.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_uint((blockD.h[0]), 9u) && allOk;
	allOk = compare_uint((blockD.h[1]), 9u) && allOk;
	allOk = compare_uint((blockD.h[2]), 1u) && allOk;
	allOk = compare_mat3x4(blockD.i[0], mat3x4(-4.0, 9.0, -7.0, -9.0, -8.0, 4.0, -7.0, 6.0, 6.0, 9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[1], mat3x4(-7.0, 0.0, -4.0, -3.0, -7.0, 0.0, -8.0, -1.0, 6.0, 0.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[2], mat3x4(4.0, -6.0, 2.0, -3.0, -4.0, 1.0, 3.0, 6.0, 2.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[3], mat3x4(0.0, -3.0, 5.0, -7.0, -7.0, -5.0, 5.0, -5.0, -9.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[4], mat3x4(-6.0, -1.0, 7.0, 5.0, -6.0, -8.0, 0.0, 4.0, 8.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[5], mat3x4(-7.0, 8.0, 2.0, -2.0, 6.0, 1.0, 6.0, -4.0, 9.0, 8.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[6], mat3x4(-3.0, 8.0, 2.0, 8.0, -2.0, -7.0, 0.0, -6.0, -4.0, 3.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[7], mat3x4(-2.0, 9.0, 9.0, 7.0, 6.0, -8.0, 3.0, -4.0, -1.0, 9.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockE.j, mat4x2(-6.0, -7.0, 2.0, 7.0, -8.0, 7.0, 1.0, -8.0)) && allOk;
	allOk = compare_uint((blockE.k[0]), 9u) && allOk;
	allOk = compare_uint((blockE.k[1]), 7u) && allOk;
	allOk = compare_uint((blockE.k[2]), 5u) && allOk;
	allOk = compare_uint((blockE.k[3]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(4, 0));
	blockB.b = (true);
	blockB.d = (bvec3(false, false, false));
	blockC.f = (6u);
	blockD.h[0] = (8u);
	blockD.h[1] = (1u);
	blockD.h[2] = (8u);
	blockD.i[0] = (mat3x4(1.0, 0.0, -9.0, -4.0, 1.0, -2.0, 1.0, 6.0, 9.0, -8.0, -1.0, 5.0));
	blockD.i[1] = (mat3x4(-6.0, -8.0, 3.0, -1.0, 5.0, -5.0, -5.0, 2.0, -7.0, 4.0, -3.0, -6.0));
	blockD.i[2] = (mat3x4(3.0, -6.0, -7.0, 1.0, 5.0, -9.0, -6.0, -4.0, 7.0, 4.0, 8.0, -9.0));
	blockD.i[3] = (mat3x4(0.0, -8.0, -5.0, 9.0, 0.0, -5.0, -9.0, 6.0, -8.0, 4.0, 7.0, 8.0));
	blockD.i[4] = (mat3x4(7.0, 7.0, -9.0, 1.0, -9.0, -7.0, 6.0, -2.0, 7.0, -6.0, -5.0, -1.0));
	blockD.i[5] = (mat3x4(9.0, -7.0, 5.0, -3.0, -2.0, 8.0, -4.0, -2.0, -7.0, -4.0, -8.0, 2.0));
	blockD.i[6] = (mat3x4(6.0, 6.0, -4.0, 7.0, 7.0, 1.0, -2.0, 5.0, -8.0, 9.0, 7.0, -2.0));
	blockD.i[7] = (mat3x4(2.0, 9.0, -6.0, -6.0, 5.0, -4.0, 3.0, 1.0, 6.0, 2.0, -2.0, -1.0));
	blockE.j = (mat4x2(-8.0, -7.0, 9.0, 5.0, -7.0, 1.0, 9.0, 3.0));
	blockE.l = (ivec3(-3, 5, 8));
	blockE.m[0] = (ivec3(4, 5, 0));
	blockE.m[1] = (ivec3(7, 1, 0));
	blockE.m[2] = (ivec3(6, -3, -3));
	blockE.m[3] = (ivec3(-6, 2, 4));
	blockE.m[4] = (ivec3(8, 0, -7));
}
#version 450
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
	lowp mat4 mA;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump mat4x2 a;
	highp vec2 b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool c;
	lowp mat3 d;
	highp ivec2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	sA f[];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp mat3x4 g;
	highp vec2 h[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(1.0, -3.0, 9.0, 7.0, -5.0, 2.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.b[0]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_mat3(blockC.d, mat3(-7.0, 8.0, 7.0, 2.0, 6.0, -1.0, 8.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockC.e[0]), ivec2(2, 6)) && allOk;
	allOk = compare_mat4(blockD.f[0].mA, mat4(1.0, -8.0, -1.0, -1.0, 1.0, -9.0, 5.0, -2.0, 1.0, 0.0, 4.0, -9.0, 6.0, -1.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec2(6.0, -4.0));
	blockC.c = (true);
	blockC.e[0] = (ivec2(0, -8));
	blockD.f[0].mA = (mat4(-8.0, 6.0, 3.0, 4.0, 5.0, -9.0, 9.0, -5.0, 2.0, 7.0, -8.0, 0.0, 6.0, 6.0, 1.0, -7.0));
	blockE.g = (mat3x4(-1.0, 7.0, 9.0, 5.0, -4.0, -6.0, 0.0, -8.0, -2.0, 5.0, -8.0, 0.0));
	blockE.h[0] = (vec2(-6.0, 9.0));
}
#version 450
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
	mediump mat4x2 a;
	lowp ivec2 b[][6];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat2 c;
	highp vec3 d;
	mediump int e;
	mediump uvec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(4.0, 1.0, -1.0, 9.0, 1.0, -6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(blockC.c, mat2(-2.0, -7.0, 4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(5.0, 1.0, 7.0, -2.0, -9.0, -1.0, -6.0, -3.0));
	blockC.c = (mat2(9.0, 2.0, -1.0, -7.0));
	blockC.e = (7);
	blockC.f[0] = (uvec2(1u, 7u));
}
#version 450
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
	lowp uvec4 a;
	lowp ivec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(0u, 4u, 3u, 7u)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(0u, 5u, 8u, 3u));
}
#version 450
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
	lowp ivec3 mC[6];
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	lowp mat2 b[7];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp vec4 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp mat3x4 d;
	sA e;
	highp vec3 f[2];
	mediump ivec4 g;
	lowp vec3 h;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-5.0, -2.0, 3.0, 7.0, -6.0, 8.0, -6.0, -1.0, -6.0, 3.0, -7.0, 9.0, 3.0, -3.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(blockC.b[0], mat2(7.0, -5.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2(blockC.b[1], mat2(3.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(blockC.b[2], mat2(-1.0, -9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(blockC.b[3], mat2(3.0, 2.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(blockC.b[4], mat2(2.0, -6.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(blockC.b[5], mat2(-6.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2(blockC.b[6], mat2(6.0, 4.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.c[0]), vec4(-9.0, -2.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.c[1]), vec4(-2.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.c[2]), vec4(-1.0, 3.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.c[3]), vec4(-7.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4((blockD.c[4]), vec4(-8.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.c[5]), vec4(5.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockE.d, mat3x4(0.0, -3.0, -9.0, 1.0, 3.0, -3.0, 0.0, -6.0, -3.0, 7.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec3((blockE.f[0]), vec3(0.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec3((blockE.f[1]), vec3(2.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockE.g), ivec4(-1, -9, 3, 6)) && allOk;
	allOk = compare_vec3((blockE.h), vec3(8.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(6.0, -5.0, -1.0, -3.0, -1.0, -2.0, 7.0, -5.0, -5.0, -4.0, 1.0, -7.0, 1.0, 1.0, -9.0, -7.0));
	blockD.c[0] = (vec4(-8.0, 0.0, 1.0, 6.0));
	blockD.c[1] = (vec4(-6.0, 9.0, 6.0, -7.0));
	blockD.c[2] = (vec4(-3.0, 3.0, 1.0, -1.0));
	blockD.c[3] = (vec4(8.0, -1.0, 8.0, -1.0));
	blockD.c[4] = (vec4(-5.0, 5.0, 7.0, -2.0));
	blockD.c[5] = (vec4(8.0, -8.0, 7.0, 4.0));
	blockE.f[0] = (vec3(2.0, 1.0, -6.0));
	blockE.f[1] = (vec3(-4.0, 4.0, 2.0));
	blockE.h = (vec3(-6.0, -3.0, 0.0));
}
#version 450
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
	mediump uvec3 a;
	highp mat4 b;
	highp uint c;
	bvec2 d;
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp ivec4 e;
	mediump ivec2 f[3];
	mediump uint g;
	bvec2 h;
	mediump vec2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(4u, 9u, 4u)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((blockC[0].e), ivec4(-8, -4, 9, -2)) && allOk;
	allOk = compare_ivec2((blockC[0].f[0]), ivec2(0, 3)) && allOk;
	allOk = compare_ivec2((blockC[0].f[1]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((blockC[0].f[2]), ivec2(-9, 7)) && allOk;
	allOk = compare_uint((blockC[0].g), 2u) && allOk;
	allOk = compare_bvec2((blockC[0].h), bvec2(true, true)) && allOk;
	allOk = compare_ivec4((blockC[1].e), ivec4(1, 6, -2, -7)) && allOk;
	allOk = compare_ivec2((blockC[1].f[0]), ivec2(-1, -8)) && allOk;
	allOk = compare_ivec2((blockC[1].f[1]), ivec2(-4, -6)) && allOk;
	allOk = compare_ivec2((blockC[1].f[2]), ivec2(7, -1)) && allOk;
	allOk = compare_uint((blockC[1].g), 2u) && allOk;
	allOk = compare_bvec2((blockC[1].h), bvec2(true, true)) && allOk;
	allOk = compare_ivec4((blockC[2].e), ivec4(3, 7, -6, 7)) && allOk;
	allOk = compare_ivec2((blockC[2].f[0]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((blockC[2].f[1]), ivec2(-6, 7)) && allOk;
	allOk = compare_ivec2((blockC[2].f[2]), ivec2(-2, 3)) && allOk;
	allOk = compare_uint((blockC[2].g), 3u) && allOk;
	allOk = compare_bvec2((blockC[2].h), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(8u, 0u, 3u));
	blockB.b = (mat4(-4.0, -9.0, -3.0, 2.0, -5.0, 1.0, -9.0, -8.0, 5.0, -1.0, -9.0, -4.0, 4.0, -6.0, 9.0, -1.0));
	blockB.c = (9u);
	blockC[0].e = (ivec4(6, 1, 8, -4));
	blockC[0].f[0] = (ivec2(-4, -4));
	blockC[0].f[1] = (ivec2(-2, -2));
	blockC[0].f[2] = (ivec2(-5, -9));
	blockC[0].i[0] = (vec2(-6.0, -1.0));
	blockC[1].e = (ivec4(-3, -2, 9, -6));
	blockC[1].f[0] = (ivec2(1, 6));
	blockC[1].f[1] = (ivec2(7, -7));
	blockC[1].f[2] = (ivec2(2, -1));
	blockC[1].i[0] = (vec2(-2.0, 8.0));
	blockC[1].i[1] = (vec2(0.0, 4.0));
	blockC[1].i[2] = (vec2(2.0, -5.0));
	blockC[1].i[3] = (vec2(-5.0, 2.0));
	blockC[1].i[4] = (vec2(-5.0, 0.0));
	blockC[1].i[5] = (vec2(-2.0, -3.0));
	blockC[2].e = (ivec4(-3, 5, -6, -1));
	blockC[2].f[0] = (ivec2(-9, -4));
	blockC[2].f[1] = (ivec2(-6, 9));
	blockC[2].f[2] = (ivec2(6, -8));
	blockC[2].i[0] = (vec2(-7.0, -6.0));
	blockC[2].i[1] = (vec2(-9.0, -7.0));
	blockC[2].i[2] = (vec2(1.0, 2.0));
}
#version 450
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
	highp vec4 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp mat4 a;
	bool b;
	bvec4 c;
	sA d;
	highp ivec3 e[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockC
{
	mediump mat4 f;
	mediump uvec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(6.0, 8.0, 4.0, -9.0, -4.0, 4.0, 0.0, 7.0, 2.0, -8.0, 2.0, -3.0, -1.0, -5.0, -5.0, 3.0)) && allOk;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, true, false)) && allOk;
	allOk = compare_ivec2((blockB.d.mA), ivec2(5, -1)) && allOk;
	allOk = compare_vec4((blockB.d.mB), vec4(-5.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC.f, mat4(4.0, 2.0, 4.0, -1.0, 6.0, 1.0, -9.0, 3.0, 3.0, 8.0, -2.0, -3.0, -6.0, 0.0, -4.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockC.g[0]), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.g[1]), uvec2(5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(7.0, 7.0, 1.0, -6.0, -1.0, 9.0, 3.0, -5.0, -9.0, -8.0, 3.0, -3.0, -6.0, 0.0, -8.0, -3.0));
	blockB.c = (bvec4(false, true, true, true));
	blockB.d.mA = (ivec2(-5, -5));
	blockB.d.mB = (vec4(5.0, 9.0, 9.0, 6.0));
	blockB.e[0] = (ivec3(9, -5, 2));
}
#version 450
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
	lowp int mA[1];
	mediump vec3 mB;
	mediump mat3x4 mC;
};
struct sB
{
	lowp mat3x4 mA;
	bvec4 mB;
	highp vec4 mC;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp uvec2 a;
	highp vec4 b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	sA c;
	sB d;
	highp vec3 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp mat3x2 f[1];
	mediump uvec2 g;
	highp ivec2 h[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	mediump mat4x3 i;
	highp int j;
	highp mat2x3 k;
	mediump vec3 l;
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
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b[0]), vec4(3.0, 0.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(9.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB.b[2]), vec4(-9.0, 8.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.b[3]), vec4(-4.0, -1.0, -7.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB.b[4]), vec4(-4.0, 3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.f[0], mat3x2(-4.0, -8.0, 5.0, -2.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockD.h[0]), ivec2(-9, 5)) && allOk;
	allOk = compare_int((blockE.j), -6) && allOk;
	allOk = compare_mat2x3(blockE.k, mat2x3(7.0, -3.0, 8.0, 9.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec4(-8.0, -3.0, 8.0, -6.0));
	blockB.b[1] = (vec4(4.0, -4.0, -7.0, 9.0));
	blockB.b[2] = (vec4(4.0, 6.0, -1.0, -5.0));
	blockB.b[3] = (vec4(0.0, 8.0, -1.0, 4.0));
	blockB.b[4] = (vec4(-1.0, -6.0, 6.0, 6.0));
	blockC[0].d.mA = (mat3x4(9.0, -9.0, -4.0, -8.0, 0.0, 8.0, -9.0, -5.0, 2.0, -3.0, 4.0, -2.0));
	blockC[0].d.mB = (bvec4(true, true, true, true));
	blockC[0].d.mC = (vec4(-6.0, -6.0, 2.0, 7.0));
	blockD.h[0] = (ivec2(8, -3));
	blockE.i = (mat4x3(-3.0, 3.0, -8.0, 7.0, 0.0, 4.0, 1.0, -2.0, 3.0, -3.0, -5.0, -2.0));
	blockE.k = (mat2x3(9.0, -1.0, 2.0, 3.0, 7.0, -8.0));
}
#version 450
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
	mediump vec4 a;
	lowp vec2 b;
	mediump uvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[nonuniformEXT(0)].a), vec4(-8.0, -8.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].b), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(1)].a), vec4(-5.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].b), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(2)].a), vec4(5.0, -6.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].b), vec2(-2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec4(-2.0, -9.0, -3.0, -1.0));
	blockB[nonuniformEXT(0)].b = (vec2(-2.0, 7.0));
	blockB[nonuniformEXT(0)].c = (uvec3(5u, 8u, 5u));
	blockB[nonuniformEXT(1)].a = (vec4(-9.0, 4.0, -6.0, 2.0));
	blockB[nonuniformEXT(1)].b = (vec2(6.0, 4.0));
	blockB[nonuniformEXT(1)].c = (uvec3(2u, 5u, 7u));
	blockB[nonuniformEXT(2)].a = (vec4(-9.0, -8.0, 3.0, 6.0));
	blockB[nonuniformEXT(2)].b = (vec2(-6.0, 5.0));
	blockB[nonuniformEXT(2)].c = (uvec3(3u, 9u, 7u));
}
#version 450
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
	highp vec3 a;
	bool b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std430, buffer_reference) buffer BlockB
{
	float16_t a;
	bool b;
	lowp float c;
	highp uint d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 4.0) && allOk;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-5.0);
	blockB.b = (false);
	blockB.c = (-9.0);
	blockB.d = (0u);
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
	u16vec4 a;
	u16vec4 b[6];
	f16vec3 c;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	mediump mat3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.c), vec3(7.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(6u, 4u, 7u, 8u));
	blockB.c = f16vec3(vec3(7.0, -1.0, -6.0));
}
#version 450
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
	u16vec4 mB;
};
struct sB
{
	i16vec4 mA;
	highp mat4x2 mB;
	bvec4 mC;
	sA mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	sB a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a[0].mA), ivec4(-9, 9, 2, 0)) && allOk;
	allOk = compare_mat4x2(blockB.a[0].mB, mat4x2(5.0, 5.0, 5.0, -5.0, -2.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB.a[0].mC), bvec4(false, true, false, true)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a[0].mD.mA), uvec4(6u, 8u, 7u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a[0].mD.mB), uvec4(5u, 0u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = i16vec4(ivec4(-9, -3, 8, 0));
	blockB.a[0].mB = (mat4x2(-3.0, 9.0, -5.0, 2.0, 1.0, 8.0, 6.0, 2.0));
	blockB.a[0].mC = (bvec4(true, false, false, false));
	blockB.a[0].mD.mA = u16vec4(uvec4(0u, 9u, 6u, 1u));
	blockB.a[0].mD.mB = u16vec4(uvec4(7u, 8u, 7u, 5u));
}
#version 450
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
	highp ivec4 mB;
	lowp ivec4 mC;
	i16vec4 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	uint16_t a;
	lowp int b;
	highp ivec4 c;
	i16vec4 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat4x2 e;
	i16vec4 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	sA g;
	mediump mat4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[0].a), 1u) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-6.0, -3.0, 8.0, 3.0, 5.0, 1.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = uint16_t(5u);
	blockB[0].c = (ivec4(-5, -4, -8, -5));
	blockB[0].d[0] = i16vec4(ivec4(0, 0, -7, 5));
	blockB[0].d[1] = i16vec4(ivec4(3, 4, 7, 8));
	blockB[0].d[2] = i16vec4(ivec4(3, 8, 8, 0));
	blockB[0].d[3] = i16vec4(ivec4(8, -6, 5, 1));
	blockB[0].d[4] = i16vec4(ivec4(7, -1, -9, -2));
	blockC.e = (mat4x2(-7.0, -5.0, -5.0, 5.0, 7.0, 3.0, -9.0, 7.0));
	blockD.g.mA = (ivec3(-7, -2, 2));
	blockD.g.mB = (ivec4(-5, -5, -8, -6));
	blockD.g.mC = (ivec4(-3, -6, -4, -7));
	blockD.g.mD = i16vec4(ivec4(7, 6, 9, -9));
}
#version 450
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
	highp uvec2 a;
	u16vec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(9u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(9u, 4u));
}
#version 450
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
	highp mat4x3 a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	f16vec2 b;
	bool c;
	highp mat3x4 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp vec2 e;
	highp mat4 f;
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	uint16_t g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(-5.0, -2.0, 3.0, 7.0, -6.0, 8.0, -6.0, -1.0, -6.0, 3.0, -7.0, 9.0)) && allOk;
	allOk = compare_bool((blockC[0].c), true) && allOk;
	allOk = compare_mat3x4(blockC[0].d[0], mat3x4(7.0, -5.0, -4.0, -9.0, 3.0, -4.0, 1.0, 9.0, -1.0, -9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].d[1], mat3x4(3.0, 2.0, -6.0, 9.0, 2.0, -6.0, -9.0, 8.0, -6.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].d[2], mat3x4(6.0, 4.0, -9.0, 0.0, -9.0, -2.0, 4.0, 6.0, -2.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].d[3], mat3x4(-1.0, 3.0, -4.0, 0.0, -7.0, 0.0, 4.0, -1.0, -8.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].d[4], mat3x4(5.0, 6.0, 3.0, 7.0, 0.0, 3.0, -3.0, -3.0, -3.0, 7.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].d[5], mat3x4(-4.0, 1.0, -6.0, -3.0, 4.0, 5.0, -4.0, 8.0, -7.0, 3.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].d[6], mat3x4(1.0, 3.0, -7.0, 7.0, 3.0, 4.0, -5.0, 3.0, 3.0, 9.0, -5.0, 8.0)) && allOk;
	allOk = compare_bool((blockC[1].c), false) && allOk;
	allOk = compare_mat3x4(blockC[1].d[0], mat3x4(0.0, -3.0, -1.0, 2.0, -4.0, -9.0, -1.0, -9.0, 3.0, 6.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].d[1], mat3x4(9.0, -6.0, 1.0, -4.0, -3.0, -7.0, 6.0, 2.0, 8.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].d[2], mat3x4(-7.0, -3.0, -8.0, 2.0, -1.0, 3.0, -3.0, 6.0, -4.0, 8.0, 5.0, -3.0)) && allOk;
	allOk = compare_bool((blockC[2].c), false) && allOk;
	allOk = compare_mat3x4(blockC[2].d[0], mat3x4(-8.0, 2.0, -3.0, 1.0, -8.0, -9.0, -3.0, 2.0, 6.0, -1.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].d[1], mat3x4(9.0, 1.0, 7.0, 5.0, 0.0, -2.0, 6.0, 4.0, -4.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].d[2], mat3x4(-1.0, 4.0, -7.0, 5.0, -6.0, -8.0, -6.0, -5.0, -8.0, -3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].d[3], mat3x4(-3.0, 0.0, -2.0, -5.0, -8.0, -8.0, -7.0, -9.0, -9.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].d[4], mat3x4(6.0, -8.0, -6.0, -4.0, 6.0, 4.0, -3.0, -9.0, 4.0, 0.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].d[5], mat3x4(4.0, -4.0, 4.0, 7.0, 2.0, -6.0, -7.0, -9.0, -9.0, 0.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].d[6], mat3x4(-8.0, 8.0, -1.0, -2.0, 9.0, -9.0, 3.0, 1.0, 4.0, 3.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].d[7], mat3x4(4.0, -3.0, 3.0, -7.0, -5.0, -9.0, 6.0, 9.0, 4.0, -7.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec2((blockD[0].e), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((blockD[1].e), vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2((blockD[2].e), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.g[0]), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(6.0, -5.0, -1.0, -3.0, -1.0, -2.0, 7.0, -5.0, -5.0, -4.0, 1.0, -7.0));
	blockC[0].c = (false);
	blockC[0].d[0] = (mat3x4(-7.0, -8.0, 6.0, 5.0, 0.0, 1.0, -1.0, 6.0, 3.0, 6.0, -6.0, 2.0));
	blockC[0].d[1] = (mat3x4(6.0, 9.0, -9.0, 4.0, 4.0, -4.0, -4.0, 0.0, 3.0, -8.0, 1.0, 0.0));
	blockC[0].d[2] = (mat3x4(0.0, -5.0, -3.0, -7.0, -6.0, -8.0, 0.0, 1.0, 6.0, -6.0, 9.0, 6.0));
	blockC[0].d[3] = (mat3x4(-7.0, -3.0, 3.0, 1.0, -1.0, 8.0, -1.0, 8.0, -1.0, -5.0, 5.0, 7.0));
	blockC[0].d[4] = (mat3x4(-2.0, 8.0, -8.0, 7.0, 4.0, 7.0, -2.0, 6.0, 5.0, -8.0, 2.0, -3.0));
	blockC[0].d[5] = (mat3x4(-9.0, -6.0, 7.0, -8.0, 3.0, 6.0, -9.0, 8.0, 9.0, 6.0, -2.0, -9.0));
	blockC[0].d[6] = (mat3x4(-6.0, -8.0, 3.0, 4.0, -5.0, -6.0, 3.0, -7.0, 4.0, 4.0, -7.0, 0.0));
	blockC[1].c = (true);
	blockC[1].d[0] = (mat3x4(2.0, 1.0, -6.0, -4.0, 4.0, 2.0, 2.0, -1.0, 0.0, 0.0, -6.0, -3.0));
	blockC[1].d[1] = (mat3x4(0.0, -8.0, -3.0, 6.0, -2.0, -2.0, -7.0, 2.0, 8.0, 5.0, 3.0, -8.0));
	blockC[1].d[2] = (mat3x4(3.0, 7.0, -6.0, 4.0, -9.0, 6.0, -5.0, 2.0, -8.0, -5.0, 0.0, -5.0));
	blockC[2].c = (true);
	blockC[2].d[0] = (mat3x4(-6.0, 6.0, -1.0, 8.0, -3.0, -8.0, 1.0, 1.0, -5.0, -9.0, 0.0, -3.0));
	blockC[2].d[1] = (mat3x4(-1.0, -4.0, -8.0, 3.0, 9.0, -2.0, 0.0, 1.0, -6.0, -7.0, -9.0, -2.0));
	blockC[2].d[2] = (mat3x4(-1.0, 2.0, 7.0, 4.0, 3.0, 3.0, 4.0, 8.0, 0.0, 9.0, 7.0, 0.0));
	blockC[2].d[3] = (mat3x4(-3.0, 3.0, -1.0, -5.0, -8.0, -3.0, 0.0, 1.0, 8.0, -5.0, 8.0, -5.0));
	blockC[2].d[4] = (mat3x4(3.0, 4.0, -9.0, -4.0, 3.0, 6.0, -4.0, -6.0, 7.0, -7.0, 9.0, 0.0));
	blockC[2].d[5] = (mat3x4(5.0, -5.0, 7.0, -2.0, 3.0, 1.0, -1.0, 8.0, 9.0, 7.0, -1.0, -4.0));
	blockC[2].d[6] = (mat3x4(9.0, -5.0, 6.0, -8.0, -5.0, 8.0, 9.0, -4.0, 2.0, -2.0, -9.0, -5.0));
	blockC[2].d[7] = (mat3x4(-8.0, 1.0, -9.0, -1.0, 5.0, 3.0, -8.0, 9.0, -3.0, 1.0, 6.0, 3.0));
	blockD[0].f = (mat4(4.0, -9.0, 3.0, 2.0, -7.0, -4.0, -9.0, -4.0, -6.0, -7.0, -1.0, -2.0, -5.0, -3.0, -4.0, 2.0));
	blockD[1].f = (mat4(-4.0, -4.0, -6.0, 3.0, 4.0, -5.0, 8.0, 7.0, 9.0, -8.0, 8.0, 9.0, -3.0, -6.0, -2.0, 1.0));
	blockD[2].f = (mat4(-6.0, -2.0, 3.0, 6.0, 7.0, 6.0, 3.0, 9.0, -9.0, -5.0, -9.0, 3.0, -7.0, 5.0, 0.0, 2.0));
	blockE.g[0] = uint16_t(7u);
}
#version 450
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
	highp mat4 mA;
	uint16_t mB;
};
struct sC
{
	lowp vec3 mA;
	sA mB;
	i16vec3 mC;
	sB mD;
};
struct sD
{
	highp mat2x3 mA;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sC a;
	mediump mat2x3 b[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp mat4x2 c;
	sD d;
	u16vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a.mA), vec3(8.0, 1.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockB.a.mB.mA), bvec3(true, true, true)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.a.mC), ivec3(-3, 9, 0)) && allOk;
	allOk = compare_mat4(blockB.a.mD.mA, mat4(-2.0, 6.0, -1.0, 7.0, 7.0, 1.0, 2.0, 5.0, 3.0, -9.0, -2.0, -6.0, 7.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB.a.mD.mB), 4u) && allOk;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(-9.0, -2.0, -2.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[1], mat2x3(-7.0, 8.0, 5.0, -9.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[2], mat2x3(8.0, -5.0, -6.0, -4.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[3], mat2x3(5.0, -8.0, -3.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e[0]), uvec4(7u, 8u, 4u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (vec3(9.0, 9.0, 3.0));
	blockB.a.mB.mA = (bvec3(true, false, false));
	blockB.a.mC = i16vec3(ivec3(-2, 0, 2));
	blockB.a.mD.mA = (mat4(-8.0, -1.0, -3.0, -1.0, 4.0, -5.0, -6.0, -6.0, 7.0, 0.0, -1.0, 9.0, 3.0, 6.0, -4.0, 3.0));
	blockB.a.mD.mB = uint16_t(3u);
	blockB.b[0] = (mat2x3(-4.0, 8.0, -7.0, -7.0, -6.0, -5.0));
	blockB.b[1] = (mat2x3(4.0, 6.0, 9.0, 1.0, 3.0, -4.0));
	blockB.b[2] = (mat2x3(-2.0, 8.0, -5.0, 7.0, 0.0, -4.0));
	blockB.b[3] = (mat2x3(-1.0, 2.0, -4.0, -5.0, -5.0, -2.0));
	blockC.e[0] = u16vec4(uvec4(6u, 6u, 8u, 6u));
}
#version 450
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
	highp vec2 mB;
	mediump ivec4 mC[4];
	mediump ivec2 mD;
};
struct sB
{
	mediump ivec3 mA;
	lowp mat2x3 mB;
	f16vec3 mC;
};
struct sC
{
	highp uvec3 mA;
	lowp mat2x3 mB[3];
	mediump mat4 mC;
	sB mD;
};
struct sD
{
	lowp ivec3 mA[7];
	mediump uvec4 mB;
	bool mC;
	highp mat3x4 mD[4];
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp vec4 a;
	bool b;
	sA c;
	i16vec4 d;
	mediump int e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump mat3 f;
	sC g;
	highp mat4x3 h;
	sD i;
	f16vec3 j[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	mediump float k;
	lowp vec2 l;
	u16vec4 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a), vec4(3.0, -6.0, -6.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[0].c.mA), vec3(-2.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB[0].c.mB), vec2(5.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[0]), ivec4(0, -4, -3, -1)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[1]), ivec4(8, -9, 1, 8)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[2]), ivec4(-4, 4, 1, -2)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[3]), ivec4(-6, -3, 8, -3)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mD), ivec2(-3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].d), ivec4(3, -2, -8, -7)) && allOk;
	allOk = compare_int((blockB[0].e[0]), 2) && allOk;
	allOk = compare_int((blockB[0].e[1]), -2) && allOk;
	allOk = compare_int((blockB[0].e[2]), 2) && allOk;
	allOk = compare_int((blockB[0].e[3]), 7) && allOk;
	allOk = compare_int((blockB[0].e[4]), 0) && allOk;
	allOk = compare_vec4((blockB[1].a), vec4(1.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[1].c.mA), vec3(-8.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].c.mB), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[0]), ivec4(-3, -9, -1, -5)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[1]), ivec4(9, -2, 4, 9)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[2]), ivec4(0, 8, 3, -2)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[3]), ivec4(-2, 9, -6, 8)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mD), ivec2(7, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].d), ivec4(-6, -2, 2, -3)) && allOk;
	allOk = compare_int((blockB[1].e[0]), -9) && allOk;
	allOk = compare_int((blockB[1].e[1]), -4) && allOk;
	allOk = compare_ivec3((blockC.i.mA[0]), ivec3(6, 2, -1)) && allOk;
	allOk = compare_ivec3((blockC.i.mA[1]), ivec3(-8, 4, -5)) && allOk;
	allOk = compare_ivec3((blockC.i.mA[2]), ivec3(-1, 3, -7)) && allOk;
	allOk = compare_ivec3((blockC.i.mA[3]), ivec3(-9, -5, -2)) && allOk;
	allOk = compare_ivec3((blockC.i.mA[4]), ivec3(-7, 1, -7)) && allOk;
	allOk = compare_ivec3((blockC.i.mA[5]), ivec3(-4, -2, 9)) && allOk;
	allOk = compare_ivec3((blockC.i.mA[6]), ivec3(-8, -5, 8)) && allOk;
	allOk = compare_uvec4((blockC.i.mB), uvec4(1u, 7u, 3u, 6u)) && allOk;
	allOk = compare_bool((blockC.i.mC), true) && allOk;
	allOk = compare_mat3x4(blockC.i.mD[0], mat3x4(-5.0, -7.0, -5.0, -4.0, -6.0, -7.0, 2.0, 3.0, 1.0, -4.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC.i.mD[1], mat3x4(-8.0, 9.0, 3.0, 7.0, -1.0, -1.0, 4.0, -2.0, -4.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC.i.mD[2], mat3x4(0.0, -5.0, 3.0, 5.0, -4.0, -3.0, 9.0, -5.0, 1.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockC.i.mD[3], mat3x4(0.0, -8.0, -7.0, 8.0, 4.0, 4.0, -7.0, -1.0, 7.0, -1.0, 1.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[0]), vec3(8.0, -8.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[1]), vec3(5.0, -9.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[2]), vec3(5.0, -4.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[3]), vec3(0.0, 8.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[4]), vec3(4.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[5]), vec3(-2.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[6]), vec3(7.0, 6.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[7]), vec3(2.0, -3.0, 9.0)) && allOk;
	allOk = compare_float((blockD.k), -2.0) && allOk;
	allOk = compare_vec2((blockD.l), vec2(3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec4(-5.0, 8.0, 2.0, -3.0));
	blockB[0].b = (false);
	blockB[0].c.mA = f16vec3(vec3(1.0, -9.0, 4.0));
	blockB[0].c.mB = (vec2(3.0, 3.0));
	blockB[0].c.mC[0] = (ivec4(-7, -5, -1, -4));
	blockB[0].c.mC[1] = (ivec4(-4, 4, -8, 5));
	blockB[0].c.mC[2] = (ivec4(3, -1, 7, 7));
	blockB[0].c.mC[3] = (ivec4(-7, 1, 4, 4));
	blockB[0].c.mD = (ivec2(-7, -1));
	blockB[0].d = i16vec4(ivec4(0, -2, -1, 0));
	blockB[1].a = (vec4(6.0, -4.0, -3.0, -1.0));
	blockB[1].b = (true);
	blockB[1].c.mA = f16vec3(vec3(9.0, -9.0, 2.0));
	blockB[1].c.mB = (vec2(4.0, -9.0));
	blockB[1].c.mC[0] = (ivec4(-7, -2, -6, 4));
	blockB[1].c.mC[1] = (ivec4(-5, -7, 6, 6));
	blockB[1].c.mC[2] = (ivec4(-1, -4, -7, -7));
	blockB[1].c.mC[3] = (ivec4(6, 7, -1, -1));
	blockB[1].c.mD = (ivec2(1, 8));
	blockB[1].d = i16vec4(ivec4(-9, 5, -5, 7));
	blockC.g.mA = (uvec3(7u, 4u, 8u));
	blockC.g.mB[0] = (mat2x3(7.0, -3.0, 6.0, 0.0, 7.0, 2.0));
	blockC.g.mB[1] = (mat2x3(-2.0, 7.0, -6.0, 6.0, -7.0, -9.0));
	blockC.g.mB[2] = (mat2x3(-2.0, 8.0, 2.0, 6.0, 2.0, -4.0));
	blockC.g.mC = (mat4(8.0, -8.0, -1.0, 9.0, -7.0, 1.0, -8.0, 6.0, 5.0, -5.0, -4.0, 1.0, 7.0, -8.0, 5.0, 9.0));
	blockC.g.mD.mA = (ivec3(4, 5, 6));
	blockC.g.mD.mB = (mat2x3(-9.0, -9.0, -4.0, 0.0, 8.0, 8.0));
	blockC.g.mD.mC = f16vec3(vec3(-1.0, -3.0, -2.0));
	blockC.h = (mat4x3(-2.0, 1.0, -6.0, 6.0, 7.0, -5.0, -1.0, 7.0, 8.0, -3.0, -5.0, 7.0));
	blockC.i.mA[0] = (ivec3(6, 2, 5));
	blockC.i.mA[1] = (ivec3(-7, -7, -8));
	blockC.i.mA[2] = (ivec3(-2, -1, -2));
	blockC.i.mA[3] = (ivec3(-2, 8, -5));
	blockC.i.mA[4] = (ivec3(4, 9, 9));
	blockC.i.mA[5] = (ivec3(-5, 2, 8));
	blockC.i.mA[6] = (ivec3(-1, -1, -2));
	blockC.i.mB = (uvec4(7u, 4u, 8u, 5u));
	blockC.i.mC = (true);
	blockC.i.mD[0] = (mat3x4(5.0, -4.0, -9.0, -7.0, 2.0, 1.0, 4.0, 0.0, -6.0, 9.0, -2.0, -9.0));
	blockC.i.mD[1] = (mat3x4(6.0, -4.0, -9.0, -6.0, -4.0, -6.0, -8.0, 2.0, 9.0, 6.0, -7.0, -4.0));
	blockC.i.mD[2] = (mat3x4(-6.0, -5.0, 7.0, 8.0, -8.0, -1.0, 6.0, -8.0, -4.0, -1.0, -8.0, 9.0));
	blockC.i.mD[3] = (mat3x4(4.0, -1.0, -2.0, -3.0, -5.0, 4.0, 8.0, 2.0, -3.0, 5.0, -8.0, 6.0));
	blockD.k = (-5.0);
	blockD.l = (vec2(5.0, 8.0));
}
#version 450
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
	lowp float a;
	highp float b;
	uint8_t c;
	int8_t d;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp int e;
	lowp float f;
	bool g;
};
layout(std140, buffer_reference) buffer BlockD
{
	bool h;
	mediump uint i;
	uint8_t j;
	lowp float k;
	lowp int l;
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump float m;
	bool n;
	bool o;
	uint8_t p[1];
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
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -8.0) && allOk;
	allOk = compare_int((blockC.e), 4) && allOk;
	allOk = compare_float((blockC.f), 0.0) && allOk;
	allOk = compare_bool((blockC.g), false) && allOk;
	allOk = compare_bool((blockD.h), false) && allOk;
	allOk = compare_uint((blockD.i), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockD.j), 1u) && allOk;
	allOk = compare_int((blockD.l), 6) && allOk;
	allOk = compare_bool((blockE.n), false) && allOk;
	allOk = compare_uint8_t(uint(blockE.p[0]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8.0);
	blockC.e = (6);
	blockC.f = (0.0);
	blockC.g = (false);
	blockD.i = (3u);
	blockD.j = uint8_t(7u);
	blockD.k = (6.0);
	blockD.l = (7);
	blockE.m = (-5.0);
}
#version 450
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
	mediump ivec4 a;
	highp float b;
	u8vec2 c;
	i8vec2 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec3 e;
	i8vec3 f;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec3 g;
	i8vec3 h;
	uint8_t i;
	bvec2 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(2, 5, 9, -9)) && allOk;
	allOk = compare_float((blockB.b), -9.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d), ivec2(5, 3)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, true)) && allOk;
	allOk = compare_ivec3((blockD.g), ivec3(-9, 3, 8)) && allOk;
	allOk = compare_uint8_t(uint(blockD.i), 6u) && allOk;
	allOk = compare_bvec2((blockD.j), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-1, -4, 2, -1));
	blockB.b = (2.0);
	blockB.c = u8vec2(uvec2(2u, 5u));
	blockB.d = i8vec2(ivec2(7, 4294967291));
	blockC.e = (bvec3(false, true, false));
	blockD.g = (ivec3(-1, 9, 2));
	blockD.h = i8vec3(ivec3(3, 4294967294, 9));
	blockD.i = uint8_t(0u);
	blockD.j = (bvec2(true, true));
}
#version 450
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
	highp uvec3 a;
	highp mat3x2 b;
	bvec3 c;
	bvec2 d;
	bvec2 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat2x3 f;
	u8vec3 g;
	bvec3 h;
	bvec3 i;
	mediump mat3x2 j;
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b, mat3x2(-7.0, -9.0, 5.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(false, false)) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(3.0, 5.0, 2.0, -9.0, 0.0, -5.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g), uvec3(1u, 1u, 7u)) && allOk;
	allOk = compare_bvec3((blockC.h), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.i), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3x2(blockC.j, mat3x2(1.0, 8.0, -3.0, 7.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.e = (bvec2(false, false));
	blockC.f = (mat2x3(-2.0, 4.0, -6.0, 5.0, -4.0, 9.0));
	blockC.g = u8vec3(uvec3(7u, 2u, 5u));
	blockC.h = (bvec3(false, true, true));
}
#version 450
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
	bvec4 mB;
};
struct sB
{
	bool mA;
	mediump mat2x3 mB;
	highp mat3x4 mC;
	mediump ivec2 mD;
};
struct sC
{
	bvec4 mA;
	bool mB;
	sB mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a;
	sC b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a.mA, mat3(-8.0, 9.0, 9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB.a.mB), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (bvec4(true, true, false, false));
	blockB.b[0].mB = (true);
	blockB.b[0].mC.mA = (false);
	blockB.b[0].mC.mB = (mat2x3(8.0, 3.0, -1.0, 1.0, 0.0, -9.0));
	blockB.b[0].mC.mC = (mat3x4(4.0, 7.0, 8.0, 7.0, 7.0, -9.0, 1.0, -9.0, -7.0, 6.0, -2.0, 7.0));
	blockB.b[0].mC.mD = (ivec2(7, -6));
	blockB.b[1].mA = (bvec4(false, false, false, true));
	blockB.b[1].mB = (true);
	blockB.b[1].mC.mA = (false);
	blockB.b[1].mC.mB = (mat2x3(-4.0, 1.0, -2.0, 1.0, 6.0, 9.0));
	blockB.b[1].mC.mC = (mat3x4(-6.0, -5.0, -1.0, 9.0, -7.0, 5.0, -3.0, -2.0, 8.0, -4.0, -2.0, -7.0));
	blockB.b[1].mC.mD = (ivec2(-4, -2));
	blockB.b[2].mA = (bvec4(false, false, true, false));
	blockB.b[2].mB = (true);
	blockB.b[2].mC.mA = (true);
	blockB.b[2].mC.mB = (mat2x3(-8.0, -1.0, 5.0, -6.0, -8.0, 3.0));
	blockB.b[2].mC.mC = (mat3x4(-4.0, -8.0, 2.0, 6.0, 6.0, -4.0, 7.0, 7.0, 1.0, -2.0, 5.0, -8.0));
	blockB.b[2].mC.mD = (ivec2(-1, 7));
	blockB.b[3].mA = (bvec4(true, true, true, false));
	blockB.b[3].mB = (true);
	blockB.b[3].mC.mA = (true);
	blockB.b[3].mC.mB = (mat2x3(-1.0, 5.0, -5.0, -5.0, 2.0, -7.0));
	blockB.b[3].mC.mC = (mat3x4(9.0, 7.0, -2.0, 2.0, 9.0, -6.0, -6.0, 5.0, -4.0, 3.0, 1.0, 6.0));
	blockB.b[3].mC.mD = (ivec2(4, 5));
	blockB.b[4].mA = (bvec4(false, true, true, true));
	blockB.b[4].mB = (false);
	blockB.b[4].mC.mA = (true);
	blockB.b[4].mC.mB = (mat2x3(4.0, -3.0, -6.0, 3.0, -6.0, -7.0));
	blockB.b[4].mC.mC = (mat3x4(2.0, -2.0, -1.0, -8.0, -7.0, 9.0, 5.0, -7.0, 1.0, 9.0, 3.0, -8.0));
	blockB.b[4].mC.mD = (ivec2(6, -8));
	blockB.b[5].mA = (bvec4(false, false, false, false));
	blockB.b[5].mB = (false);
	blockB.b[5].mC.mA = (true);
	blockB.b[5].mC.mB = (mat2x3(1.0, 5.0, -9.0, -6.0, -4.0, 7.0));
	blockB.b[5].mC.mC = (mat3x4(-1.0, -2.0, -7.0, -3.0, 5.0, 8.0, 4.0, 5.0, 0.0, 7.0, 1.0, 0.0));
	blockB.b[5].mC.mD = (ivec2(-8, -6));
	blockB.b[6].mA = (bvec4(false, false, false, false));
	blockB.b[6].mB = (false);
	blockB.b[6].mC.mA = (false);
	blockB.b[6].mC.mB = (mat2x3(4.0, 8.0, -9.0, 0.0, -8.0, -5.0));
	blockB.b[6].mC.mC = (mat3x4(6.0, -3.0, -3.0, -6.0, 2.0, 4.0, 8.0, 0.0, -7.0, 7.0, -4.0, -8.0));
	blockB.b[6].mC.mD = (ivec2(-5, -6));
	blockB.b[7].mA = (bvec4(true, true, true, false));
	blockB.b[7].mB = (true);
	blockB.b[7].mC.mA = (false);
	blockB.b[7].mC.mB = (mat2x3(9.0, 0.0, -5.0, -9.0, 6.0, -8.0));
	blockB.b[7].mC.mC = (mat3x4(-5.0, -7.0, -1.0, -9.0, 3.0, -9.0, -3.0, -2.0, 0.0, 3.0, 6.0, -2.0));
	blockB.b[7].mC.mD = (ivec2(2, 8));
}
#version 450
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
	i8vec4 b;
	bvec4 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump float d;
	lowp ivec2 e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat2x3 f;
	mediump vec3 g;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	u8vec3 h;
	mediump mat4 i;
	mediump float j;
	lowp int k[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(3.0, -9.0, -2.0, -9.0, 6.0, -5.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(4294967294, 4294967289, 8, 4294967289)) && allOk;
	allOk = compare_bvec4((blockB.c[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.c[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[3]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.c[4]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.c[5]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_float((blockC.d), 5.0) && allOk;
	allOk = compare_ivec2((blockC.e[0]), ivec2(3, -7)) && allOk;
	allOk = compare_ivec2((blockC.e[1]), ivec2(9, -4)) && allOk;
	allOk = compare_ivec2((blockC.e[2]), ivec2(-7, 2)) && allOk;
	allOk = compare_mat2x3(blockD.f, mat2x3(5.0, -3.0, 8.0, 5.0, 1.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.g), vec3(-9.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(blockE.i, mat4(2.0, 9.0, 0.0, -6.0, -9.0, 5.0, -3.0, -6.0, 2.0, -3.0, -5.0, 2.0, 8.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_float((blockE.j), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-1.0, -2.0, 8.0, -9.0, -6.0, 0.0));
	blockC.d = (9.0);
	blockC.e[0] = (ivec2(6, 9));
	blockC.e[1] = (ivec2(-6, 2));
	blockC.e[2] = (ivec2(0, -5));
	blockD.f = (mat2x3(7.0, -8.0, 7.0, -3.0, -4.0, -3.0));
	blockE.i = (mat4(7.0, 1.0, -5.0, 2.0, 6.0, -2.0, -5.0, 4.0, -4.0, 5.0, 7.0, -9.0, -8.0, -5.0, -3.0, -7.0));
	blockE.k[0] = (7);
	blockE.k[1] = (-9);
	blockE.k[2] = (-6);
	blockE.k[3] = (-1);
}
#version 450
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
	layout(offset = 0) lowp vec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp int b;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec2 c;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) i8vec2 d;
	layout(offset = 16) mediump uvec4 e;
	layout(offset = 32) lowp uvec2 f;
	layout(offset = 40) i8vec4 g;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-6.0, 0.0, 9.0)) && allOk;
	allOk = compare_int((blockC[0].b), -4) && allOk;
	allOk = compare_int((blockC[1].b), 2) && allOk;
	allOk = compare_vec2((blockD.c), vec2(9.0, -9.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE[0].d), ivec2(4294967289, 4294967292)) && allOk;
	allOk = compare_uvec4((blockE[0].e), uvec4(1u, 4u, 7u, 8u)) && allOk;
	allOk = compare_uvec2((blockE[0].f), uvec2(3u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE[0].g), ivec4(3, 4, 4294967294, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(4.0, 8.0, -7.0));
	blockC[0].b = (-4);
	blockC[1].b = (1);
	blockD.c = (vec2(-2.0, -6.0));
	blockE[0].e = (uvec4(6u, 1u, 8u, 0u));
	blockE[0].g = i8vec4(ivec4(4294967290, 5, 4294967293, 0));
}
#version 450
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
	uint8_t mB;
};
struct sB
{
	mediump vec4 mA;
	lowp ivec3 mB;
	u8vec2 mC;
	i8vec2 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	i8vec3 a;
	lowp vec4 b[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	int8_t c;
	sA d;
	bvec2 e;
	lowp mat4 f;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	sB g;
	lowp int h;
	u8vec4 i;
	mediump ivec3 j;
	i8vec2 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b[0]), vec4(-9.0, 9.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(7.0, 0.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB.b[2]), vec4(-5.0, -2.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.b[3]), vec4(2.0, -4.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.b[4]), vec4(-1.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockD.j), ivec3(2, -2, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(3, 4294967292, 2));
	blockB.b[0] = (vec4(2.0, 4.0, 9.0, -2.0));
	blockB.b[1] = (vec4(-4.0, -9.0, -2.0, 0.0));
	blockB.b[2] = (vec4(9.0, 8.0, -5.0, 4.0));
	blockB.b[3] = (vec4(-6.0, -8.0, -5.0, 0.0));
	blockB.b[4] = (vec4(4.0, 7.0, 3.0, -2.0));
	blockC[0].c = int8_t(9);
	blockC[0].e = (bvec2(true, false));
	blockC[0].f = (mat4(-5.0, -2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0, -8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0));
	blockC[1].c = int8_t(4294967294);
	blockC[1].e = (bvec2(true, false));
	blockC[1].f = (mat4(-4.0, 6.0, 0.0, -2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0, -8.0, 9.0, 2.0, 5.0, -2.0, -5.0));
	blockC[2].c = int8_t(0);
	blockC[2].e = (bvec2(false, false));
	blockC[2].f = (mat4(8.0, -4.0, 6.0, -6.0, 2.0, 7.0, 8.0, 7.0, -6.0, -2.0, 8.0, 6.0, -6.0, 1.0, -8.0, 1.0));
	blockD.i = u8vec4(uvec4(9u, 3u, 5u, 9u));
	blockD.j = (ivec3(9, -7, -1));
	blockD.k[0] = i8vec2(ivec2(9, 4294967293));
	blockD.k[1] = i8vec2(ivec2(4294967295, 7));
	blockD.k[2] = i8vec2(ivec2(4294967290, 1));
	blockD.k[3] = i8vec2(ivec2(9, 4294967288));
	blockD.k[4] = i8vec2(ivec2(6, 4294967291));
	blockD.k[5] = i8vec2(ivec2(4294967294, 2));
	blockD.k[6] = i8vec2(ivec2(1, 7));
	blockD.k[7] = i8vec2(ivec2(4294967287, 9));
}
#version 450
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
	lowp uvec2 mA;
	i8vec2 mB;
	bvec3 mC;
	uint8_t mD;
};
struct sC
{
	highp mat3x2 mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	u8vec4 a;
	lowp vec3 b;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	mediump mat2 c;
	sA d;
	u8vec2 e;
	mediump ivec3 f;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	i8vec2 g[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	sB h[1];
	highp mat4x3 i;
	sC j;
	uint8_t k;
	lowp vec4 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[2];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockC[0].c, mat2(-8.0, -6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC[0].d.mA, mat3(6.0, -6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].e), uvec2(8u, 4u)) && allOk;
	allOk = compare_ivec3((blockC[0].f), ivec3(-8, 6, 2)) && allOk;
	allOk = compare_mat2(blockC[1].c, mat2(3.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(blockC[1].d.mA, mat3(-9.0, 1.0, 1.0, 3.0, 6.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].e), uvec2(2u, 8u)) && allOk;
	allOk = compare_ivec3((blockC[1].f), ivec3(5, 8, -9)) && allOk;
	allOk = compare_uvec2((blockE.h[0].mA), uvec2(3u, 5u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.h[0].mB), ivec2(4294967291, 1)) && allOk;
	allOk = compare_bvec3((blockE.h[0].mC), bvec3(false, true, false)) && allOk;
	allOk = compare_uint8_t(uint(blockE.h[0].mD), 9u) && allOk;
	allOk = compare_mat3x2(blockE.j.mA, mat3x2(5.0, 7.0, 9.0, -5.0, -1.0, 3.0)) && allOk;
	allOk = compare_vec4((blockE.l[0]), vec4(-4.0, -9.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec4(uvec4(9u, 4u, 4u, 5u));
	blockC[0].c = (mat2(5.0, 4.0, 8.0, 6.0));
	blockC[0].d.mA = (mat3(7.0, -5.0, 5.0, -2.0, 7.0, 4.0, 7.0, 0.0, 9.0));
	blockC[0].f = (ivec3(4, 9, -7));
	blockC[1].c = (mat2(-6.0, -2.0, -4.0, 8.0));
	blockC[1].d.mA = (mat3(-6.0, -4.0, 6.0, -3.0, -6.0, 8.0, -6.0, -7.0, -1.0));
	blockC[1].f = (ivec3(2, -1, 4));
	blockD[0].g[0] = i8vec2(ivec2(4294967290, 5));
	blockD[0].g[1] = i8vec2(ivec2(4294967291, 4294967295));
	blockD[0].g[2] = i8vec2(ivec2(4294967294, 4294967293));
	blockD[1].g[0] = i8vec2(ivec2(4294967289, 8));
	blockD[1].g[1] = i8vec2(ivec2(4294967290, 7));
	blockD[1].g[2] = i8vec2(ivec2(9, 8));
	blockD[1].g[3] = i8vec2(ivec2(4294967293, 4294967292));
	blockD[1].g[4] = i8vec2(ivec2(4, 9));
	blockD[1].g[5] = i8vec2(ivec2(0, 1));
	blockD[1].g[6] = i8vec2(ivec2(2, 4294967293));
	blockD[1].g[7] = i8vec2(ivec2(4294967287, 4294967287));
	blockE.h[0].mA = (uvec2(5u, 3u));
	blockE.h[0].mB = i8vec2(ivec2(4294967288, 4));
	blockE.h[0].mC = (bvec3(true, true, false));
	blockE.h[0].mD = uint8_t(7u);
	blockE.i = (mat4x3(-9.0, 6.0, -5.0, 4.0, -5.0, -2.0, 7.0, -4.0, 0.0, 6.0, 3.0, -5.0));
	blockE.j.mA = (mat3x2(2.0, 4.0, 9.0, -2.0, -4.0, -5.0));
	blockE.k = uint8_t(2u);
	blockE.l[0] = (vec4(-1.0, 3.0, 8.0, -9.0));
}
#version 450
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
	highp uvec2 a;
	lowp mat3x4 b[1];
	mediump mat4 c;
	mediump mat3x2 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump mat3x4 e;
	i8vec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(-1.0, 7.0, -1.0, 0.0, -7.0, -4.0, 2.0, 8.0, -9.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.c, mat4(2.0, -1.0, 2.0, 8.0, 1.0, 4.0, -7.0, -2.0, 4.0, -8.0, 0.0, -2.0, 8.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0], mat3x2(4.0, 1.0, 0.0, 7.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1], mat3x2(-3.0, 2.0, 9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[2], mat3x2(-2.0, -3.0, 1.0, 9.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[3], mat3x2(-9.0, -4.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[4], mat3x2(5.0, 3.0, -2.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[5], mat3x2(4.0, -6.0, 2.0, 9.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[6], mat3x2(9.0, 1.0, 3.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[7], mat3x2(-7.0, 9.0, 0.0, -4.0, 8.0, 4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[0]), ivec2(4294967291, 4294967291)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[1]), ivec2(8, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[2]), ivec2(4294967292, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[3]), ivec2(8, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[4]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[5]), ivec2(2, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[6]), ivec2(8, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(0u, 3u));
	blockB.c = (mat4(-4.0, 3.0, -5.0, -1.0, -5.0, -6.0, 6.0, 5.0, -1.0, 2.0, 8.0, 8.0, -2.0, -7.0, -6.0, 5.0));
	blockB.d[0] = (mat3x2(-2.0, -2.0, 6.0, 8.0, -3.0, 7.0));
	blockB.d[1] = (mat3x2(9.0, -9.0, -8.0, -5.0, 3.0, -8.0));
	blockB.d[2] = (mat3x2(-7.0, -1.0, -1.0, -1.0, 9.0, 1.0));
	blockB.d[3] = (mat3x2(1.0, -3.0, -5.0, 0.0, -3.0, -2.0));
	blockB.d[4] = (mat3x2(8.0, 3.0, 7.0, -4.0, -2.0, -4.0));
	blockB.d[5] = (mat3x2(-8.0, 5.0, -6.0, 8.0, 6.0, 4.0));
	blockB.d[6] = (mat3x2(6.0, -4.0, -6.0, 3.0, 1.0, 7.0));
	blockB.d[7] = (mat3x2(7.0, 9.0, 0.0, 3.0, -3.0, 4.0));
	blockC[0].e = (mat3x4(-1.0, 5.0, -5.0, 3.0, 6.0, -6.0, 0.0, -1.0, -2.0, -8.0, 4.0, 9.0));
	blockC[0].f[0] = i8vec2(ivec2(4294967290, 4294967292));
	blockC[0].f[1] = i8vec2(ivec2(3, 4294967293));
	blockC[0].f[2] = i8vec2(ivec2(4294967295, 6));
	blockC[0].f[3] = i8vec2(ivec2(4294967290, 4294967292));
	blockC[0].f[4] = i8vec2(ivec2(3, 2));
	blockC[0].f[5] = i8vec2(ivec2(9, 5));
	blockC[0].f[6] = i8vec2(ivec2(2, 4294967293));
}
#version 450
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
	mediump mat3x4 mB;
	i8vec3 mC;
	mediump mat4x2 mD;
};
struct sB
{
	i8vec2 mA;
	sA mB;
};
struct sC
{
	bvec4 mA[8];
	highp ivec3 mB;
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockB
{
	mediump vec2 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sB b;
	sC c;
	highp mat3 d[5];
	highp vec3 e[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockC.d[0], mat3(8.0, 1.0, -1.0, 8.0, 1.0, 7.0, -6.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.d[1], mat3(2.0, 7.0, 7.0, -5.0, 2.0, 5.0, -6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.d[2], mat3(3.0, 0.0, 0.0, 9.0, -5.0, 5.0, -8.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.d[3], mat3(-4.0, 3.0, 8.0, 7.0, 2.0, 0.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.d[4], mat3(-3.0, -5.0, 0.0, 9.0, -8.0, -5.0, -9.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC.e[0]), vec3(-7.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC.e[1]), vec3(-7.0, -7.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA = i8vec2(ivec2(4294967288, 4294967295));
	blockC.b.mB.mA = (mat4x2(1.0, -1.0, 3.0, 8.0, 1.0, 8.0, 4.0, 9.0));
	blockC.b.mB.mB = (mat3x4(4.0, 2.0, -8.0, -2.0, 2.0, -1.0, 4.0, -2.0, 3.0, 8.0, 3.0, 7.0));
	blockC.b.mB.mC = i8vec3(ivec3(4294967288, 4294967287, 2));
	blockC.b.mB.mD = (mat4x2(5.0, 4.0, 5.0, -4.0, 2.0, -1.0, 9.0, -7.0));
	blockC.d[0] = (mat3(0.0, -8.0, -8.0, -3.0, 1.0, -2.0, 1.0, 0.0, 6.0));
	blockC.d[1] = (mat3(4.0, -8.0, -9.0, -6.0, 8.0, -5.0, 6.0, -3.0, 4.0));
	blockC.d[2] = (mat3(7.0, 2.0, -5.0, -5.0, 4.0, -9.0, -3.0, -7.0, 3.0));
	blockC.d[3] = (mat3(-5.0, 0.0, -8.0, -9.0, -2.0, 8.0, -8.0, 1.0, 3.0));
	blockC.d[4] = (mat3(-8.0, -2.0, 5.0, 3.0, 2.0, 7.0, 3.0, -2.0, 5.0));
	blockC.e[0] = (vec3(2.0, -2.0, -9.0));
	blockC.e[1] = (vec3(6.0, -6.0, -9.0));
}
#version 450
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
	bvec3 mB[2][1];
	lowp mat3x2 mC;
	mediump vec2 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
	bvec3 b;
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump mat3x4 c;
	u8vec4 d;
	lowp mat4 e;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockC.d), uvec4(1u, 3u, 6u, 7u)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(-5.0, -6.0, -4.0, 3.0, 4.0, 5.0, -8.0, -3.0, 2.0, 6.0, 3.0, 6.0, -3.0, 6.0, 0.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec3(true, false, false));
	blockC.d = u8vec4(uvec4(8u, 1u, 0u, 7u));
	blockC.e = (mat4(8.0, -5.0, 7.0, 0.0, -4.0, -1.0, 2.0, -4.0, -5.0, -5.0, -2.0, -5.0, -9.0, 0.0, 2.0, -9.0));
}
#version 450
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
	mediump vec3 a;
	bool b;
	highp mat4x3 c;
	u8vec3 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp vec4 e[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp float f[][7];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(2.0, 5.0, -2.0)) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_mat4x3(blockB.c, mat4x3(2.0, 8.0, -8.0, -1.0, -7.0, 5.0, -9.0, -5.0, -6.0, -1.0, -7.0, 0.0)) && allOk;
	allOk = compare_float((blockD[0].f[0][0]), 7.0) && allOk;
	allOk = compare_float((blockD[0].f[0][1]), 9.0) && allOk;
	allOk = compare_float((blockD[0].f[0][2]), -5.0) && allOk;
	allOk = compare_float((blockD[0].f[0][3]), 5.0) && allOk;
	allOk = compare_float((blockD[0].f[0][4]), -7.0) && allOk;
	allOk = compare_float((blockD[0].f[0][5]), -9.0) && allOk;
	allOk = compare_float((blockD[0].f[0][6]), 9.0) && allOk;
	allOk = compare_float((blockD[0].f[1][0]), -3.0) && allOk;
	allOk = compare_float((blockD[0].f[1][1]), 8.0) && allOk;
	allOk = compare_float((blockD[0].f[1][2]), 8.0) && allOk;
	allOk = compare_float((blockD[0].f[1][3]), -5.0) && allOk;
	allOk = compare_float((blockD[0].f[1][4]), -9.0) && allOk;
	allOk = compare_float((blockD[0].f[1][5]), -9.0) && allOk;
	allOk = compare_float((blockD[0].f[1][6]), 3.0) && allOk;
	allOk = compare_float((blockD[0].f[2][0]), -3.0) && allOk;
	allOk = compare_float((blockD[0].f[2][1]), 8.0) && allOk;
	allOk = compare_float((blockD[0].f[2][2]), 1.0) && allOk;
	allOk = compare_float((blockD[0].f[2][3]), 7.0) && allOk;
	allOk = compare_float((blockD[0].f[2][4]), 3.0) && allOk;
	allOk = compare_float((blockD[0].f[2][5]), -1.0) && allOk;
	allOk = compare_float((blockD[0].f[2][6]), 4.0) && allOk;
	allOk = compare_float((blockD[0].f[3][0]), -3.0) && allOk;
	allOk = compare_float((blockD[0].f[3][1]), 8.0) && allOk;
	allOk = compare_float((blockD[0].f[3][2]), -8.0) && allOk;
	allOk = compare_float((blockD[0].f[3][3]), 8.0) && allOk;
	allOk = compare_float((blockD[0].f[3][4]), -3.0) && allOk;
	allOk = compare_float((blockD[0].f[3][5]), 7.0) && allOk;
	allOk = compare_float((blockD[0].f[3][6]), 6.0) && allOk;
	allOk = compare_float((blockD[0].f[4][0]), -5.0) && allOk;
	allOk = compare_float((blockD[0].f[4][1]), 0.0) && allOk;
	allOk = compare_float((blockD[0].f[4][2]), -4.0) && allOk;
	allOk = compare_float((blockD[0].f[4][3]), 2.0) && allOk;
	allOk = compare_float((blockD[0].f[4][4]), -4.0) && allOk;
	allOk = compare_float((blockD[0].f[4][5]), -3.0) && allOk;
	allOk = compare_float((blockD[0].f[4][6]), -3.0) && allOk;
	allOk = compare_float((blockD[0].f[5][0]), -9.0) && allOk;
	allOk = compare_float((blockD[0].f[5][1]), -4.0) && allOk;
	allOk = compare_float((blockD[0].f[5][2]), -4.0) && allOk;
	allOk = compare_float((blockD[0].f[5][3]), 0.0) && allOk;
	allOk = compare_float((blockD[0].f[5][4]), -1.0) && allOk;
	allOk = compare_float((blockD[0].f[5][5]), 6.0) && allOk;
	allOk = compare_float((blockD[0].f[5][6]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(8.0, 3.0, 6.0));
	blockB.c = (mat4x3(6.0, -5.0, 8.0, 4.0, -2.0, -7.0, 0.0, 5.0, 1.0, -3.0, 3.0, 4.0));
	blockB.d[0] = u8vec3(uvec3(8u, 7u, 5u));
	blockB.d[1] = u8vec3(uvec3(0u, 0u, 3u));
	blockB.d[2] = u8vec3(uvec3(9u, 6u, 0u));
	blockC.e[0] = (vec4(5.0, -4.0, -3.0, 4.0));
	blockC.e[1] = (vec4(-6.0, 9.0, 4.0, 1.0));
	blockC.e[2] = (vec4(-3.0, 5.0, -7.0, 3.0));
	blockC.e[3] = (vec4(-4.0, 4.0, -1.0, -1.0));
	blockC.e[4] = (vec4(-7.0, -2.0, -6.0, -5.0));
	blockC.e[5] = (vec4(0.0, -4.0, -3.0, 5.0));
	blockD[0].f[0][0] = (6.0);
	blockD[0].f[0][1] = (-2.0);
	blockD[0].f[0][2] = (2.0);
	blockD[0].f[0][3] = (8.0);
	blockD[0].f[0][4] = (8.0);
	blockD[0].f[0][5] = (7.0);
	blockD[0].f[0][6] = (-8.0);
	blockD[0].f[1][0] = (0.0);
	blockD[0].f[1][1] = (8.0);
	blockD[0].f[1][2] = (7.0);
	blockD[0].f[1][3] = (-9.0);
	blockD[0].f[1][4] = (1.0);
	blockD[0].f[1][5] = (-9.0);
	blockD[0].f[1][6] = (-8.0);
	blockD[0].f[2][0] = (-4.0);
	blockD[0].f[2][1] = (1.0);
	blockD[0].f[2][2] = (4.0);
	blockD[0].f[2][3] = (9.0);
	blockD[0].f[2][4] = (-6.0);
	blockD[0].f[2][5] = (-5.0);
	blockD[0].f[2][6] = (9.0);
	blockD[0].f[3][0] = (3.0);
	blockD[0].f[3][1] = (2.0);
	blockD[0].f[3][2] = (-3.0);
	blockD[0].f[3][3] = (5.0);
	blockD[0].f[3][4] = (-6.0);
	blockD[0].f[3][5] = (-3.0);
	blockD[0].f[3][6] = (3.0);
	blockD[0].f[4][0] = (7.0);
	blockD[0].f[4][1] = (6.0);
	blockD[0].f[4][2] = (-7.0);
	blockD[0].f[4][3] = (3.0);
	blockD[0].f[4][4] = (5.0);
	blockD[0].f[4][5] = (4.0);
	blockD[0].f[4][6] = (-1.0);
	blockD[0].f[5][0] = (1.0);
	blockD[0].f[5][1] = (-7.0);
	blockD[0].f[5][2] = (-7.0);
	blockD[0].f[5][3] = (6.0);
	blockD[0].f[5][4] = (3.0);
	blockD[0].f[5][5] = (9.0);
	blockD[0].f[5][6] = (5.0);
}
#version 450
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
	bvec3 a;
	highp vec3 b;
	mediump uvec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].a), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].c), uvec4(0u, 5u, 6u, 0u)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].a), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].c), uvec4(1u, 9u, 8u, 8u)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].a), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(2)].c), uvec4(2u, 6u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec3(true, false, true));
	blockB[nonuniformEXT(0)].b = (vec3(5.0, -9.0, 8.0));
	blockB[nonuniformEXT(0)].c = (uvec4(8u, 1u, 9u, 5u));
	blockB[nonuniformEXT(1)].a = (bvec3(true, true, false));
	blockB[nonuniformEXT(1)].b = (vec3(-7.0, 1.0, 3.0));
	blockB[nonuniformEXT(1)].c = (uvec4(2u, 7u, 5u, 9u));
	blockB[nonuniformEXT(2)].a = (bvec3(false, false, true));
	blockB[nonuniformEXT(2)].b = (vec3(4.0, 1.0, -8.0));
	blockB[nonuniformEXT(2)].c = (uvec4(6u, 8u, 2u, 2u));
}
#version 450
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
	u8vec3 a;
	lowp mat4x3 b;
	lowp mat2 c;
	i8vec3 d;
	u8vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].a), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].c, mat2(3.0, -8.0, 1.0, 6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(0)].d), ivec3(4, 4294967291, 5)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].e), uvec3(4u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].a), uvec3(1u, 1u, 2u)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].c, mat2(3.0, 3.0, 8.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(1)].d), ivec3(4294967293, 4294967290, 0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].e), uvec3(1u, 3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4x3(-6.0, -1.0, 9.0, 3.0, -5.0, -9.0, -8.0, 3.0, -3.0, -6.0, 0.0, -8.0));
	blockB[nonuniformEXT(0)].c = (mat2(-3.0, -7.0, 1.0, 0.0));
	blockB[nonuniformEXT(0)].d = i8vec3(ivec3(1, 4294967292, 2));
	blockB[nonuniformEXT(0)].e = u8vec3(uvec3(4u, 1u, 1u));
	blockB[nonuniformEXT(1)].b = (mat4x3(9.0, 9.0, 6.0, 9.0, -5.0, 2.0, -5.0, -6.0, 0.0, -5.0, 7.0, 4.0));
	blockB[nonuniformEXT(1)].c = (mat2(-1.0, -2.0, -1.0, 3.0));
	blockB[nonuniformEXT(1)].d = i8vec3(ivec3(4294967289, 4294967294, 6));
	blockB[nonuniformEXT(1)].e = u8vec3(uvec3(6u, 7u, 0u));
}
