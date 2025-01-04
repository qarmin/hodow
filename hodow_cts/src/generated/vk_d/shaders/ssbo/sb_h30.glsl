#version 450
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
	mediump int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (2);
}
#version 450
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

	var = (mat2x4(-4.0, -7.0, 5.0, -2.0, 2.0, -1.0, -3.0, -3.0));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-5.0, -9.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-5.0, 0.0, 6.0, -3.0));
	var[1] = (vec4(-7.0, -8.0, 7.0, -1.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-6.0, 7.0, -2.0, -6.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(2.0, 3.0));
	var[1] = (vec2(-2.0, 0.0));
	var[2] = (vec2(-2.0, -1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_float(var[3][0], 0.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], 8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(0.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(2.0, 8.0, 7.0, -6.0, -3.0, -1.0, -7.0, -9.0, 8.0, -9.0, -3.0, 1.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, -7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-4.0, 3.0));
	var[1] = (vec2(-8.0, -8.0));
	var[2] = (vec2(-6.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(-9.0, -6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-8.0, -2.0));
	var[1] = (vec2(-8.0, -4.0));
	var[2] = (vec2(5.0, 6.0));
	var[3] = (vec2(-2.0, 5.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var, mat2(2.0, -5.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat2(-7.0, -2.0, -2.0, -4.0));
}
#version 450
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

	padding = (2.0);
	var[0] = (vec4(6.0, -8.0, 9.0, -8.0));
	var[1] = (vec4(4.0, -8.0, 7.0, 9.0));
	var[2] = (vec4(-7.0, -2.0, -7.0, 0.0));
	var[3] = (vec4(-7.0, 7.0, -8.0, -2.0));
}
#version 450
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

	padding = (1.0);
	var = (mat4x3(-1.0, -5.0, 5.0, -9.0, -3.0, 5.0, 8.0, 4.0, 6.0, 0.0, 4.0, -6.0));
}
#version 450
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
	highp vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2]), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(3.0, 8.0));
	var[1] = (vec2(7.0, -1.0));
	var[2] = (vec2(-4.0, 8.0));
}
#version 450
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
	int8_t var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[1]), 3) && allOk;
	allOk = compare_int8_t(int(var[2]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = int8_t(4294967290);
	var[1] = int8_t(4294967294);
	var[2] = int8_t(3);
}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
}
#version 450
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
	highp mat2x3 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
}
#version 450
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
	float16_t var[3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(-8.0);
	var[0] = float16_t(9.0);
	var[1] = float16_t(-2.0);
	var[2] = float16_t(7.0);
}
#version 450
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
	highp mat2 var[];
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
	allOk = compare_mat2(var[3], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[3] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[4] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[5] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[6] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[7] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[8] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[9] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[10] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[11] = (mat2(6.0, 0.0, 1.0, 8.0));
	var[12] = (mat2(1.0, -2.0, -9.0, -7.0));
	var[13] = (mat2(2.0, 7.0, 5.0, -3.0));
	var[14] = (mat2(-2.0, -3.0, 3.0, -1.0));
	var[15] = (mat2(-2.0, -8.0, 1.0, -1.0));
	var[16] = (mat2(9.0, -2.0, -3.0, 6.0));
	var[17] = (mat2(2.0, 6.0, -4.0, -6.0));
	var[18] = (mat2(5.0, -6.0, 1.0, 5.0));
}
#version 450
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
	highp mat2x4 var[];
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
	allOk = compare_mat2x4(var[3], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[3][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[3][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[4][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[4][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[5][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[5][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[6][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[6][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[7][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[7][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[8][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[8][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[9][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[9][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[10][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[10][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[11][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[11][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	var[12][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	var[12][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	var[13][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	var[13][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	var[14][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	var[14][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	var[15][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	var[15][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	var[16][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	var[16][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	var[17][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	var[17][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	var[18][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	var[18][1] = (vec4(2.0, 1.0, 3.0, -6.0));
}
#version 450
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
	highp ivec4 var[4][3];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[0][2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[1][0]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][1]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[1][2]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[2][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[2][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[2][2]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[3][0]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[3][1]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[3][2]), ivec4(-3, 1, 3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (ivec4(5, -9, 5, -6));
	var[0][1] = (ivec4(-2, -4, 1, -9));
	var[0][2] = (ivec4(7, 3, 6, 8));
	var[1][0] = (ivec4(6, -4, 6, -7));
	var[1][1] = (ivec4(9, -8, -9, 0));
	var[1][2] = (ivec4(5, -7, 2, 9));
	var[2][0] = (ivec4(6, 5, 4, 0));
	var[2][1] = (ivec4(5, 9, 0, 0));
	var[2][2] = (ivec4(-6, 4, 4, 2));
	var[3][0] = (ivec4(9, 7, 5, 5));
	var[3][1] = (ivec4(3, -3, -9, -8));
	var[3][2] = (ivec4(-6, 3, 2, 0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	var[1][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	var[1][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	var[1][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	var[2][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	var[2][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	var[2][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	var[3][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	var[3][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	var[3][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(3.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-5.0, -3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(8.0, -5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-4.0, -5.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(1.0, 3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-4.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-4.0, 5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-3.0, 2.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-6.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(1.0, -5.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(3.0, 7.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (vec2(1.0, -7.0));
	var[0][0][1] = (vec2(-1.0, 5.0));
	var[0][1][0] = (vec2(-3.0, 4.0));
	var[0][1][1] = (vec2(8.0, -2.0));
	var[0][2][0] = (vec2(-6.0, -5.0));
	var[0][2][1] = (vec2(-1.0, 3.0));
	var[1][0][0] = (vec2(4.0, -8.0));
	var[1][0][1] = (vec2(6.0, 6.0));
	var[1][1][0] = (vec2(-2.0, 1.0));
	var[1][1][1] = (vec2(3.0, 2.0));
	var[1][2][0] = (vec2(1.0, 7.0));
	var[1][2][1] = (vec2(-2.0, -4.0));
	var[2][0][0] = (vec2(2.0, -1.0));
	var[2][0][1] = (vec2(-4.0, -5.0));
	var[2][1][0] = (vec2(-8.0, 3.0));
	var[2][1][1] = (vec2(-7.0, 5.0));
	var[2][2][0] = (vec2(0.0, -4.0));
	var[2][2][1] = (vec2(-9.0, 9.0));
	var[3][0][0] = (vec2(1.0, 7.0));
	var[3][0][1] = (vec2(9.0, 1.0));
	var[3][1][0] = (vec2(3.0, -3.0));
	var[3][1][1] = (vec2(7.0, 1.0));
	var[3][2][0] = (vec2(5.0, 4.0));
	var[3][2][1] = (vec2(1.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(1.0, -8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-7.0, 3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-6.0, -9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(4.0, 2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(7.0, 8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[0][0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[0][0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[0][1][0] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	var[0][1][1] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	var[0][1][2] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	var[1][0][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[1][0][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[1][0][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[1][1][0] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	var[1][1][1] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	var[1][1][2] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	var[2][0][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[2][0][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[2][0][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[2][1][0] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
	var[2][1][1] = (mat2x4(-5.0, 1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0));
	var[2][1][2] = (mat2x4(2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0));
	var[3][0][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[3][0][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[3][0][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	var[3][1][0] = (mat2x4(-7.0, -3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0));
	var[3][1][1] = (mat2x4(2.0, 3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0));
	var[3][1][2] = (mat2x4(-6.0, -2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-4.0, -6.0));
	var[0][0][0][1] = (vec2(1.0, -3.0));
	var[0][0][0][2] = (vec2(-1.0, -9.0));
	var[0][0][1][0] = (vec2(3.0, -2.0));
	var[0][0][1][1] = (vec2(5.0, -8.0));
	var[0][0][1][2] = (vec2(2.0, -9.0));
	var[0][0][2][0] = (vec2(1.0, -5.0));
	var[0][0][2][1] = (vec2(0.0, -2.0));
	var[0][0][2][2] = (vec2(2.0, -1.0));
	var[0][1][0][0] = (vec2(-1.0, -9.0));
	var[0][1][0][1] = (vec2(-8.0, 9.0));
	var[0][1][0][2] = (vec2(-1.0, -6.0));
	var[0][1][1][0] = (vec2(-5.0, 7.0));
	var[0][1][1][1] = (vec2(-8.0, -6.0));
	var[0][1][1][2] = (vec2(1.0, -5.0));
	var[0][1][2][0] = (vec2(-3.0, 8.0));
	var[0][1][2][1] = (vec2(-2.0, 3.0));
	var[0][1][2][2] = (vec2(-2.0, 5.0));
	var[1][0][0][0] = (vec2(-7.0, 9.0));
	var[1][0][0][1] = (vec2(-8.0, 7.0));
	var[1][0][0][2] = (vec2(1.0, -9.0));
	var[1][0][1][0] = (vec2(-5.0, -5.0));
	var[1][0][1][1] = (vec2(9.0, 3.0));
	var[1][0][1][2] = (vec2(-3.0, -6.0));
	var[1][0][2][0] = (vec2(1.0, 3.0));
	var[1][0][2][1] = (vec2(-3.0, -4.0));
	var[1][0][2][2] = (vec2(-9.0, 4.0));
	var[1][1][0][0] = (vec2(7.0, -3.0));
	var[1][1][0][1] = (vec2(4.0, 5.0));
	var[1][1][0][2] = (vec2(-9.0, 3.0));
	var[1][1][1][0] = (vec2(6.0, -1.0));
	var[1][1][1][1] = (vec2(-6.0, -5.0));
	var[1][1][1][2] = (vec2(7.0, -6.0));
	var[1][1][2][0] = (vec2(1.0, 8.0));
	var[1][1][2][1] = (vec2(7.0, -1.0));
	var[1][1][2][2] = (vec2(2.0, 6.0));
	var[2][0][0][0] = (vec2(-2.0, -3.0));
	var[2][0][0][1] = (vec2(-5.0, 1.0));
	var[2][0][0][2] = (vec2(-5.0, 8.0));
	var[2][0][1][0] = (vec2(7.0, 8.0));
	var[2][0][1][1] = (vec2(-1.0, -3.0));
	var[2][0][1][2] = (vec2(-8.0, 5.0));
	var[2][0][2][0] = (vec2(6.0, 6.0));
	var[2][0][2][1] = (vec2(0.0, -8.0));
	var[2][0][2][2] = (vec2(-6.0, -4.0));
	var[2][1][0][0] = (vec2(-6.0, 5.0));
	var[2][1][0][1] = (vec2(6.0, -8.0));
	var[2][1][0][2] = (vec2(-2.0, -1.0));
	var[2][1][1][0] = (vec2(-3.0, -3.0));
	var[2][1][1][1] = (vec2(-5.0, 8.0));
	var[2][1][1][2] = (vec2(8.0, -7.0));
	var[2][1][2][0] = (vec2(-6.0, 6.0));
	var[2][1][2][1] = (vec2(-9.0, 5.0));
	var[2][1][2][2] = (vec2(-5.0, 8.0));
	var[3][0][0][0] = (vec2(-6.0, -5.0));
	var[3][0][0][1] = (vec2(8.0, 5.0));
	var[3][0][0][2] = (vec2(-9.0, 0.0));
	var[3][0][1][0] = (vec2(6.0, -3.0));
	var[3][0][1][1] = (vec2(6.0, 0.0));
	var[3][0][1][2] = (vec2(1.0, 6.0));
	var[3][0][2][0] = (vec2(4.0, 4.0));
	var[3][0][2][1] = (vec2(0.0, -1.0));
	var[3][0][2][2] = (vec2(-2.0, 2.0));
	var[3][1][0][0] = (vec2(4.0, -5.0));
	var[3][1][0][1] = (vec2(1.0, 4.0));
	var[3][1][0][2] = (vec2(8.0, 1.0));
	var[3][1][1][0] = (vec2(8.0, -4.0));
	var[3][1][1][1] = (vec2(-6.0, 2.0));
	var[3][1][1][2] = (vec2(-5.0, -5.0));
	var[3][1][2][0] = (vec2(-4.0, 1.0));
	var[3][1][2][1] = (vec2(2.0, 4.0));
	var[3][1][2][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[0][1][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[0][1][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[0][2][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[0][2][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[0][3][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	var[0][3][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	var[1][0][0] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[1][0][1] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[1][1][0] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[1][1][1] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[1][2][0] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[1][2][1] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[1][3][0] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	var[1][3][1] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	var[2][0][0] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[2][0][1] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[2][1][0] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[2][1][1] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[2][2][0] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[2][2][1] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[2][3][0] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	var[2][3][1] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(9.0, -6.0, -3.0, -7.0, 7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(0.0, 5.0, 0.0, -9.0, 3.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-2.0, -5.0, -2.0, -5.0, -8.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(9.0, 0.0, 3.0, -7.0, -2.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(2.0, -9.0, -8.0, 5.0, 3.0, -5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[0][0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[0][1][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[0][1][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[0][2][0] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	var[0][2][1] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	var[0][3][0] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
	var[0][3][1] = (mat2x4(-4.0, -8.0, -2.0, 8.0, -5.0, 5.0, -9.0, 9.0));
	var[1][0][0] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[1][0][1] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[1][1][0] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[1][1][1] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[1][2][0] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	var[1][2][1] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	var[1][3][0] = (mat2x4(5.0, 0.0, -8.0, -5.0, 5.0, -6.0, 9.0, 8.0));
	var[1][3][1] = (mat2x4(-9.0, -9.0, -2.0, -6.0, 7.0, 3.0, 3.0, -2.0));
	var[2][0][0] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[2][0][1] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[2][1][0] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[2][1][1] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	var[2][2][0] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	var[2][2][1] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	var[2][3][0] = (mat2x4(4.0, -3.0, -6.0, 4.0, -3.0, 9.0, -3.0, 0.0));
	var[2][3][1] = (mat2x4(4.0, 4.0, -6.0, 7.0, -8.0, 7.0, -1.0, -7.0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-4.0, -6.0));
	var[0][0][0][1] = (vec2(1.0, -3.0));
	var[0][0][0][2] = (vec2(-1.0, -9.0));
	var[0][0][1][0] = (vec2(3.0, -2.0));
	var[0][0][1][1] = (vec2(5.0, -8.0));
	var[0][0][1][2] = (vec2(2.0, -9.0));
	var[0][1][0][0] = (vec2(-2.0, -3.0));
	var[0][1][0][1] = (vec2(-5.0, 1.0));
	var[0][1][0][2] = (vec2(-5.0, 8.0));
	var[0][1][1][0] = (vec2(7.0, 8.0));
	var[0][1][1][1] = (vec2(-1.0, -3.0));
	var[0][1][1][2] = (vec2(-8.0, 5.0));
	var[0][2][0][0] = (vec2(-1.0, -9.0));
	var[0][2][0][1] = (vec2(-8.0, 9.0));
	var[0][2][0][2] = (vec2(-1.0, -6.0));
	var[0][2][1][0] = (vec2(-5.0, 7.0));
	var[0][2][1][1] = (vec2(-8.0, -6.0));
	var[0][2][1][2] = (vec2(1.0, -5.0));
	var[0][3][0][0] = (vec2(-6.0, 5.0));
	var[0][3][0][1] = (vec2(6.0, -8.0));
	var[0][3][0][2] = (vec2(-2.0, -1.0));
	var[0][3][1][0] = (vec2(-3.0, -3.0));
	var[0][3][1][1] = (vec2(-5.0, 8.0));
	var[0][3][1][2] = (vec2(8.0, -7.0));
	var[1][0][0][0] = (vec2(1.0, -5.0));
	var[1][0][0][1] = (vec2(0.0, -2.0));
	var[1][0][0][2] = (vec2(2.0, -1.0));
	var[1][0][1][0] = (vec2(-7.0, 9.0));
	var[1][0][1][1] = (vec2(-8.0, 7.0));
	var[1][0][1][2] = (vec2(1.0, -9.0));
	var[1][1][0][0] = (vec2(6.0, 6.0));
	var[1][1][0][1] = (vec2(0.0, -8.0));
	var[1][1][0][2] = (vec2(-6.0, -4.0));
	var[1][1][1][0] = (vec2(-6.0, -5.0));
	var[1][1][1][1] = (vec2(8.0, 5.0));
	var[1][1][1][2] = (vec2(-9.0, 0.0));
	var[1][2][0][0] = (vec2(-3.0, 8.0));
	var[1][2][0][1] = (vec2(-2.0, 3.0));
	var[1][2][0][2] = (vec2(-2.0, 5.0));
	var[1][2][1][0] = (vec2(7.0, -3.0));
	var[1][2][1][1] = (vec2(4.0, 5.0));
	var[1][2][1][2] = (vec2(-9.0, 3.0));
	var[1][3][0][0] = (vec2(-6.0, 6.0));
	var[1][3][0][1] = (vec2(-9.0, 5.0));
	var[1][3][0][2] = (vec2(-5.0, 8.0));
	var[1][3][1][0] = (vec2(4.0, -5.0));
	var[1][3][1][1] = (vec2(1.0, 4.0));
	var[1][3][1][2] = (vec2(8.0, 1.0));
	var[2][0][0][0] = (vec2(-5.0, -5.0));
	var[2][0][0][1] = (vec2(9.0, 3.0));
	var[2][0][0][2] = (vec2(-3.0, -6.0));
	var[2][0][1][0] = (vec2(1.0, 3.0));
	var[2][0][1][1] = (vec2(-3.0, -4.0));
	var[2][0][1][2] = (vec2(-9.0, 4.0));
	var[2][1][0][0] = (vec2(6.0, -3.0));
	var[2][1][0][1] = (vec2(6.0, 0.0));
	var[2][1][0][2] = (vec2(1.0, 6.0));
	var[2][1][1][0] = (vec2(4.0, 4.0));
	var[2][1][1][1] = (vec2(0.0, -1.0));
	var[2][1][1][2] = (vec2(-2.0, 2.0));
	var[2][2][0][0] = (vec2(6.0, -1.0));
	var[2][2][0][1] = (vec2(-6.0, -5.0));
	var[2][2][0][2] = (vec2(7.0, -6.0));
	var[2][2][1][0] = (vec2(1.0, 8.0));
	var[2][2][1][1] = (vec2(7.0, -1.0));
	var[2][2][1][2] = (vec2(2.0, 6.0));
	var[2][3][0][0] = (vec2(8.0, -4.0));
	var[2][3][0][1] = (vec2(-6.0, 2.0));
	var[2][3][0][2] = (vec2(-5.0, -5.0));
	var[2][3][1][0] = (vec2(-4.0, 1.0));
	var[2][3][1][1] = (vec2(2.0, 4.0));
	var[2][3][1][2] = (vec2(-6.0, 8.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
{
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][1][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[0][1][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[0][1][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[0][1][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[0][1][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[0][1][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[0][2][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	var[0][2][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	var[0][2][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	var[0][2][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	var[0][2][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	var[0][2][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	var[0][3][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	var[0][3][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	var[0][3][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	var[0][3][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	var[0][3][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	var[0][3][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	var[1][0][0][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[1][0][0][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[1][0][0][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[1][0][1][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[1][0][1][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][1][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][1][0][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[1][1][0][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[1][1][0][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[1][1][1][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[1][1][1][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[1][1][1][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[1][2][0][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	var[1][2][0][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	var[1][2][0][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	var[1][2][1][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	var[1][2][1][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	var[1][2][1][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	var[1][3][0][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	var[1][3][0][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	var[1][3][0][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	var[1][3][1][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	var[1][3][1][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	var[1][3][1][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	var[2][0][0][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[2][0][0][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[2][0][0][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[2][0][1][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[2][0][1][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[2][0][1][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[2][1][0][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[2][1][0][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[2][1][0][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[2][1][1][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[2][1][1][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[2][1][1][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[2][2][0][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	var[2][2][0][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	var[2][2][0][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	var[2][2][1][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	var[2][2][1][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	var[2][2][1][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	var[2][3][0][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	var[2][3][0][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	var[2][3][0][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	var[2][3][1][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	var[2][3][1][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	var[2][3][1][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-6.0, -7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(2.0, 0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-7.0, 8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-9.0, 3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-5.0, 0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[0][0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[0][1][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[0][1][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[0][2][0] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	var[0][2][1] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	var[0][3][0] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
	var[0][3][1] = (mat4x2(-1.0, -3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0));
	var[1][0][0] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[1][0][1] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[1][1][0] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[1][1][1] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[1][2][0] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	var[1][2][1] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	var[1][3][0] = (mat4x2(-3.0, 8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0));
	var[1][3][1] = (mat4x2(-2.0, 7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0));
	var[2][0][0] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[2][0][1] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[2][1][0] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[2][1][1] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	var[2][2][0] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	var[2][2][1] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	var[2][3][0] = (mat4x2(-7.0, 5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0));
	var[2][3][1] = (mat4x2(5.0, -8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0));
}
#version 450
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
	u8vec4 var[][4][2];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0][0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][2][0]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][2][1]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][3][0]), uvec4(1u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][3][1]), uvec4(5u, 8u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][0]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][1]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][0]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][1]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][2][0]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][2][1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][3][0]), uvec4(0u, 3u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][3][1]), uvec4(1u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][0]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][1]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][0]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][1]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][2][0]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][2][1]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][3][0]), uvec4(4u, 8u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][3][1]), uvec4(6u, 3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[0][0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[0][1][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	var[0][1][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	var[0][2][0] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	var[0][2][1] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	var[0][3][0] = u8vec4(uvec4(8u, 9u, 4u, 7u));
	var[0][3][1] = u8vec4(uvec4(0u, 4u, 6u, 7u));
	var[1][0][0] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	var[1][0][1] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	var[1][1][0] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	var[1][1][1] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	var[1][2][0] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	var[1][2][1] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	var[1][3][0] = u8vec4(uvec4(4u, 2u, 8u, 9u));
	var[1][3][1] = u8vec4(uvec4(9u, 8u, 8u, 1u));
	var[2][0][0] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	var[2][0][1] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	var[2][1][0] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	var[2][1][1] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	var[2][2][0] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	var[2][2][1] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	var[2][3][0] = u8vec4(uvec4(2u, 6u, 8u, 6u));
	var[2][3][1] = u8vec4(uvec4(9u, 6u, 5u, 0u));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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

	s.a = (ivec3(-1, 0, 1));
	s.b[0][0] = (vec3(6.0, -6.0, 5.0));
	s.b[0][1] = (vec3(6.0, -9.0, 8.0));
	s.b[0][2] = (vec3(1.0, 4.0, -5.0));
	s.b[1][0] = (vec3(1.0, 8.0, -2.0));
	s.b[1][1] = (vec3(-1.0, -5.0, -4.0));
	s.b[1][2] = (vec3(-2.0, 0.0, 2.0));
	s.b[2][0] = (vec3(6.0, 8.0, 8.0));
	s.b[2][1] = (vec3(8.0, 9.0, 9.0));
	s.b[2][2] = (vec3(-4.0, 4.0, -1.0));
	s.b[3][0] = (vec3(-8.0, 7.0, 3.0));
	s.b[3][1] = (vec3(-6.0, 4.0, -9.0));
	s.b[3][2] = (vec3(-1.0, 8.0, 7.0));
	s.c = (vec4(2.0, 7.0, -5.0, 3.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-5.0, 8.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(4.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 6.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(6.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-9.0, -6.0, 5.0, -1.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][3], 9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(0.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-6.0, -1.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(-1.0, 3.0, -1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-9.0);
	block[0].var[0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block[0].var[1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block[0].var[2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block[0].var[3] = (vec4(0.0, -1.0, -4.0, 4.0));
	block[1].padding = (7.0);
	block[1].var[0] = (vec4(6.0, -1.0, -3.0, -3.0));
	block[1].var[1] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block[1].var[2] = (vec4(9.0, 4.0, -3.0, 1.0));
	block[1].var[3] = (vec4(-9.0, 6.0, 5.0, 2.0));
	block[2].padding = (-7.0);
	block[2].var[0] = (vec4(9.0, 9.0, -5.0, -7.0));
	block[2].var[1] = (vec4(-4.0, -6.0, 5.0, -9.0));
	block[2].var[2] = (vec4(1.0, 9.0, -4.0, 4.0));
	block[2].var[3] = (vec4(7.0, 0.0, 7.0, 7.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_float((block[1].padding), -7.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(7.0, 7.0, 5.0, -1.0, -5.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), -1.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(0.0, 4.0, 7.0, -4.0, -7.0, -5.0, 8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6.0);
	block[0].var[0] = (vec2(-4.0, -4.0));
	block[0].var[1] = (vec2(2.0, 0.0));
	block[0].var[2] = (vec2(-7.0, 3.0));
	block[0].var[3] = (vec2(9.0, 9.0));
	block[1].padding = (8.0);
	block[1].var[0] = (vec2(-9.0, -6.0));
	block[1].var[1] = (vec2(-4.0, -6.0));
	block[1].var[2] = (vec2(-6.0, -8.0));
	block[1].var[3] = (vec2(-9.0, 6.0));
	block[2].padding = (-8.0);
	block[2].var[0] = (vec2(2.0, 8.0));
	block[2].var[1] = (vec2(5.0, -8.0));
	block[2].var[2] = (vec2(-8.0, -3.0));
	block[2].var[3] = (vec2(3.0, 7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA[3];
layout(std140, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
} blockB[3];

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
	allOk = compare_float((blockA[0].a), -8.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-6.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_float((blockA[1].a), -7.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(1.0, 8.0, 3.0, 7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -3.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(3.0, -9.0, -1.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-7, 0)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-5, 9)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(2, -8)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-4.0);
	blockA[1].a = (4.0);
	blockA[2].a = (3.0);
	blockB[0].a = (mat3(1.0, 2.0, 1.0, -8.0, -8.0, -4.0, 4.0, 0.0, -5.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(3.0, 5.0, 4.0, 3.0, -6.0, 8.0, 4.0, -6.0, 1.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(2.0, -2.0, 4.0, -6.0, 6.0, -4.0, -1.0, 3.0, 0.0));
	blockB[2].d = (false);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA[3];
layout(scalar, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
} blockB[3];

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
	allOk = compare_float(blockA[0].c[0][0], 4.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_float((blockA[1].a), 7.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], 4.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -1.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-5.0, -7.0)) && allOk;
	allOk = compare_float((blockA[2].a), 6.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], 0.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -7.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], -8.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-7.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-8, -2)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-3, 2)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(0, 2)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-7.0);
	blockA[1].a = (-5.0);
	blockA[2].a = (-9.0);
	blockB[0].a = (mat3(-5.0, 3.0, -2.0, 1.0, 2.0, 5.0, -1.0, -2.0, -6.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(5.0, -3.0, 0.0, -6.0, 1.0, 1.0, -6.0, -2.0, 7.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(-4.0, -8.0, -2.0, 3.0, -7.0, 2.0, -2.0, -8.0, 0.0));
	blockB[2].d = (false);
}
#version 450
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
layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA[3];
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA[0].a), -9.0) && allOk;
	allOk = compare_float((blockA[1].a), -6.0) && allOk;
	allOk = compare_float((blockA[2].a), 2.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 6u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-6.0, 3.0, 9.0, -1.0, 4.0, -5.0, 1.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-1, -6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, 4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-6, 8)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-8.0, -9.0, 8.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-4.0, 9.0, 3.0, 5.0, -3.0, -2.0, 1.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(-1, 8)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(6, -6)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(7.0, 4.0, -7.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-8.0, -5.0, -4.0, 4.0, 8.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(-3, 4)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(-6, -6)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(0.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-7.0);
	blockA[0].b.a = (mat3(3.0, 5.0, -3.0, -2.0, 2.0, 9.0, 8.0, -5.0, 1.0));
	blockA[0].b.b[0] = (ivec2(-8, 9));
	blockA[0].b.b[1] = (ivec2(6, -3));
	blockA[0].b.b[2] = (ivec2(0, -4));
	blockA[0].b.b[3] = (ivec2(-9, 9));
	blockA[0].b.c = (vec4(-5.0, 7.0, -5.0, 4.0));
	blockA[1].a = (3.0);
	blockA[1].b.a = (mat3(-2.0, 1.0, 2.0, 5.0, -1.0, -2.0, -6.0, 2.0, -9.0));
	blockA[1].b.b[0] = (ivec2(2, -6));
	blockA[1].b.b[1] = (ivec2(-8, -1));
	blockA[1].b.b[2] = (ivec2(5, -9));
	blockA[1].b.b[3] = (ivec2(5, -3));
	blockA[1].b.c = (vec4(0.0, -6.0, 1.0, 1.0));
	blockA[2].a = (6.0);
	blockA[2].b.a = (mat3(-6.0, -9.0, 1.0, -1.0, -9.0, 2.0, -4.0, -8.0, -2.0));
	blockA[2].b.b[0] = (ivec2(3, -7));
	blockA[2].b.b[1] = (ivec2(2, -2));
	blockA[2].b.b[2] = (ivec2(-8, 0));
	blockA[2].b.b[3] = (ivec2(-4, 6));
	blockA[2].b.c = (vec4(-7.0, 8.0, 0.0, -9.0));
	blockB[0].a = (mat2(0.0, -6.0, -6.0, 5.0));
	blockB[0].b.a = (4u);
	blockB[0].b.b.a = (mat3(3.0, 3.0, 5.0, 0.0, 5.0, -3.0, -5.0, 0.0, -8.0));
	blockB[0].b.b.b[0] = (ivec2(4, 0));
	blockB[0].b.b.b[1] = (ivec2(0, -2));
	blockB[0].b.b.b[2] = (ivec2(-3, 9));
	blockB[0].b.b.b[3] = (ivec2(6, 6));
	blockB[0].b.b.c = (vec4(-9.0, 6.0, -7.0, 6.0));
	blockB[0].b.c = (bvec4(false, true, false, false));
	blockB[0].d = (true);
	blockB[1].a = (mat2(-7.0, 7.0, -5.0, 6.0));
	blockB[1].b.a = (8u);
	blockB[1].b.b.a = (mat3(-7.0, 4.0, -8.0, 2.0, -7.0, -8.0, 1.0, -4.0, -9.0));
	blockB[1].b.b.b[0] = (ivec2(2, 3));
	blockB[1].b.b.b[1] = (ivec2(-9, 4));
	blockB[1].b.b.b[2] = (ivec2(5, 9));
	blockB[1].b.b.b[3] = (ivec2(-2, 0));
	blockB[1].b.b.c = (vec4(9.0, -4.0, -2.0, 3.0));
	blockB[1].b.c = (bvec4(true, true, false, false));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-1.0, -8.0, -2.0, -6.0));
	blockB[2].b.a = (0u);
	blockB[2].b.b.a = (mat3(-5.0, 6.0, -1.0, -9.0, 5.0, 7.0, -1.0, -7.0, -5.0));
	blockB[2].b.b.b[0] = (ivec2(2, 9));
	blockB[2].b.b.b[1] = (ivec2(-1, -5));
	blockB[2].b.b.b[2] = (ivec2(7, -7));
	blockB[2].b.b.b[3] = (ivec2(2, 7));
	blockB[2].b.b.c = (vec4(-3.0, 1.0, 0.0, 8.0));
	blockB[2].b.c = (bvec4(true, true, false, false));
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

layout(std140, binding = 1) buffer BlockB
{
	mediump mat4x2 a;
	lowp mat4 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a, mat4x2(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(b[0], mat4(-3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4(b[1], mat4(-7.0, -1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4(b[2], mat4(-1.0, -8.0, -3.0, -6.0, 1.0, 7.0, 6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(b[3], mat4(-1.0, 1.0, 1.0, 0.0, 9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4(b[4], mat4(-2.0, -9.0, -7.0, -2.0, -3.0, -3.0, -9.0, 6.0, 9.0, -7.0, 9.0, -7.0, 9.0, -3.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0));
	b[0] = (mat4(4.0, 7.0, -1.0, 6.0, 5.0, 8.0, 6.0, 2.0, -7.0, -2.0, -4.0, -2.0, 4.0, -2.0, 3.0, 0.0));
	b[1] = (mat4(-8.0, 6.0, -7.0, 4.0, 6.0, -2.0, -5.0, 3.0, 0.0, 9.0, -2.0, 3.0, -3.0, 3.0, 2.0, 2.0));
	b[2] = (mat4(-6.0, -8.0, -6.0, 4.0, -7.0, -9.0, 7.0, -3.0, -1.0, -2.0, -4.0, 3.0, -1.0, 4.0, -2.0, 9.0));
	b[3] = (mat4(-2.0, 8.0, -5.0, -8.0, 9.0, 2.0, -2.0, -2.0, 7.0, 3.0, 7.0, 3.0, -1.0, -2.0, 1.0, 2.0));
	b[4] = (mat4(-4.0, 2.0, -8.0, -6.0, 2.0, -5.0, -6.0, -3.0, -2.0, 7.0, -4.0, -1.0, -5.0, -8.0, 5.0, 8.0));
}
#version 450
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
};
struct sB
{
	mediump mat2 mA;
	sA mB;
	highp mat2x3 mC;
};
struct sC
{
	bool mA;
	lowp vec2 mB;
	highp mat3x4 mC;
	highp mat4x3 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sB a[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	sC b;
	highp mat4x2 c;
	mediump ivec2 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((b.mA), true) && allOk;
	allOk = compare_vec2((b.mB), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(b.mC, mat3x4(-9.0, -2.0, 4.0, 9.0, 7.0, -5.0, -7.0, 8.0, 0.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(b.mD, mat4x3(0.0, 8.0, 1.0, -5.0, 7.0, 4.0, 2.0, 9.0, -9.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(c, mat4x2(7.0, 0.0, -1.0, 2.0, -3.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_ivec2((d[0]), ivec2(3, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0].mA = (mat2(0.0, 3.0, -7.0, -2.0));
	a[0].mB.mA = (vec4(2.0, -7.0, 4.0, 6.0));
	a[0].mC = (mat2x3(-8.0, -3.0, -3.0, 8.0, 3.0, -1.0));
	c = (mat4x2(1.0, -8.0, -9.0, -8.0, 8.0, 3.0, 9.0, -3.0));
}
#version 450
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
	lowp ivec4 b;
	highp vec3 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(-2, 4, 3)) && allOk;
	allOk = compare_ivec4((b), ivec4(-8, 3, -5, -4)) && allOk;
	allOk = compare_vec3((c[0]), vec3(-5.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(-7, 3, -9));
}
#version 450
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
	lowp mat4x2 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	bvec2 a;
	mediump ivec4 b;
	sA c;
	lowp ivec2 d;
	lowp ivec2 e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp uvec2 f;
	highp mat3x2 g;
	bvec3 h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(-5, 1, -7, 1)) && allOk;
	allOk = compare_ivec2((blockB.e[0]), ivec2(-6, 8)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(8u, 2u)) && allOk;
	allOk = compare_mat3x2(blockC.g, mat3x2(-3.0, 3.0, 1.0, -9.0, 7.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockC.h), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (ivec4(-8, -5, 0, 0));
	blockB.c.mA = (mat3(-7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0, 8.0));
	blockB.c.mB = (mat4x2(0.0, 8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0));
	blockB.e[0] = (ivec2(-5, 7));
	blockC.f = (uvec2(3u, 4u));
	blockC.g = (mat3x2(5.0, 3.0, 7.0, -7.0, -6.0, 1.0));
	blockC.h = (bvec3(true, false, true));
}
#version 450
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
	lowp int a[];
} blockB[3];
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	mediump ivec2 b;
} blockC;
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	bvec4 c;
	mediump mat3x2 d;
	lowp mat3 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a[0]), 2) && allOk;
	allOk = compare_int((blockB[1].a[0]), 5) && allOk;
	allOk = compare_int((blockB[2].a[0]), 9) && allOk;
	allOk = compare_mat3x2(d, mat3x2(-2.0, -6.0, 6.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(e, mat3(3.0, -6.0, -8.0, 8.0, 2.0, 9.0, 8.0, -6.0, -9.0)) && allOk;
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

layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	highp ivec2 b;
	lowp mat2 c;
	lowp vec2 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(2.0, 7.0, -9.0, 3.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2(c, mat2(3.0, 9.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec2((d), vec2(-2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(8.0, 9.0, -5.0, 5.0, -4.0, 2.0));
	d = (vec2(4.0, 1.0));
}
#version 450
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
	mediump mat4x2 mB;
	highp ivec2 mC;
};
struct sB
{
	mediump uint mA;
	bvec2 mB;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump vec4 a;
	mediump vec3 b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	sA c;
	mediump float d;
	highp ivec3 e;
	mediump float f;
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	sB g;
	lowp ivec2 h;
	mediump vec4 i;
	highp uint j;
	mediump uvec4 k[][3];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp vec3 l;
	lowp uvec4 m;
	highp mat4x2 n;
	lowp int o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
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
	allOk = compare_vec4((a), vec4(-5.0, 5.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((b[0]), vec3(9.0, -5.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockC[0].c.mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat4x2(blockC[0].c.mB, mat4x2(-1.0, 7.0, 5.0, 7.0, 2.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockC[0].c.mC), ivec2(-2, -1)) && allOk;
	allOk = compare_float((blockC[0].d), -5.0) && allOk;
	allOk = compare_ivec3((blockC[0].e), ivec3(5, 3, 9)) && allOk;
	allOk = compare_float((blockC[0].f), -5.0) && allOk;
	allOk = compare_bvec4((blockC[1].c.mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_mat4x2(blockC[1].c.mB, mat4x2(-1.0, 1.0, 4.0, -4.0, -9.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockC[1].c.mC), ivec2(0, 6)) && allOk;
	allOk = compare_float((blockC[1].d), 8.0) && allOk;
	allOk = compare_ivec3((blockC[1].e), ivec3(5, 9, -3)) && allOk;
	allOk = compare_float((blockC[1].f), 2.0) && allOk;
	allOk = compare_ivec2((h), ivec2(-7, 7)) && allOk;
	allOk = compare_uint((j), 5u) && allOk;
	allOk = compare_uvec4((k[0][0]), uvec4(0u, 9u, 1u, 4u)) && allOk;
	allOk = compare_uvec4((k[0][1]), uvec4(4u, 0u, 9u, 0u)) && allOk;
	allOk = compare_uvec4((k[0][2]), uvec4(4u, 9u, 4u, 1u)) && allOk;
	allOk = compare_uvec4((k[1][0]), uvec4(6u, 8u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((k[1][1]), uvec4(2u, 3u, 7u, 6u)) && allOk;
	allOk = compare_uvec4((k[1][2]), uvec4(6u, 4u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((k[2][0]), uvec4(3u, 3u, 1u, 9u)) && allOk;
	allOk = compare_uvec4((k[2][1]), uvec4(8u, 6u, 2u, 2u)) && allOk;
	allOk = compare_uvec4((k[2][2]), uvec4(2u, 5u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((k[3][0]), uvec4(2u, 9u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((k[3][1]), uvec4(2u, 7u, 2u, 2u)) && allOk;
	allOk = compare_uvec4((k[3][2]), uvec4(9u, 0u, 6u, 9u)) && allOk;
	allOk = compare_vec3((l), vec3(2.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x2(n, mat4x2(-9.0, 2.0, 1.0, -3.0, 4.0, -2.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(3.0, -4.0, 2.0, 2.0));
	b[0] = (vec3(4.0, 9.0, -2.0));
	blockC[0].c.mA = (bvec4(false, true, false, false));
	blockC[0].c.mB = (mat4x2(8.0, -8.0, -5.0, -5.0, 4.0, 0.0, -6.0, 4.0));
	blockC[0].c.mC = (ivec2(7, 3));
	blockC[1].c.mA = (bvec4(true, true, false, false));
	blockC[1].c.mB = (mat4x2(-9.0, -8.0, -5.0, -8.0, 4.0, 9.0, -3.0, 4.0));
	blockC[1].c.mC = (ivec2(4, -3));
	j = (8u);
	n = (mat4x2(-8.0, 6.0, -5.0, -2.0, 2.0, 1.0, 7.0, -9.0));
	o[0] = (9);
}
#version 450
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
	layout(offset = 0) highp ivec3 a;
	layout(offset = 16) lowp ivec3 b;
	layout(offset = 32) lowp vec4 c;
	layout(offset = 48) lowp uvec2 d;
	layout(offset = 56) lowp float e;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) bvec3 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec4 g;
	layout(offset = 16) bvec3 h;
	layout(offset = 32) highp uvec4 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(4, 2, 5)) && allOk;
	allOk = compare_vec4((c), vec4(-3.0, 7.0, -7.0, -1.0)) && allOk;
	allOk = compare_uvec2((d), uvec2(3u, 8u)) && allOk;
	allOk = compare_bvec3((f), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((h), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(8, -4, -1));
	b = (ivec3(-5, -1, 5));
	c = (vec4(8.0, 9.0, 6.0, 7.0));
	d = (uvec2(4u, 3u));
	e = (9.0);
	g = (vec4(-5.0, -2.0, 7.0, -6.0));
	i = (uvec4(8u, 7u, 1u, 5u));
}
#version 450
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
	layout(offset = 16) bvec3 b;
	layout(offset = 32) lowp ivec2 c;
	layout(offset = 48) mediump vec3 d;
	layout(offset = 60) bool e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, true)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-5, -3)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(7.0, 5.0, 7.0)) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.d = (vec3(0.0, 4.0, 2.0));
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

layout(std430, binding = 1) buffer BlockB
{
	int16_t a;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(a), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int16_t(-9);
}
#version 450
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
	highp ivec2 a[1];
	highp vec3 b;
	lowp ivec3 c;
	i16vec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a[0]), ivec2(0, -6)) && allOk;
	allOk = compare_vec3((b), vec3(9.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(-9.0, 0.0, 9.0));
	d = i16vec4(ivec4(-6, 3, 5, -8));
}
#version 450
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
	lowp mat3 a;
	i16vec4 b;
	uint16_t c;
	i16vec2 d;
	highp mat2x3 e;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	uint16_t f;
	lowp mat4x2 g;
	bvec2 h;
	lowp vec3 i;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp uint j;
	highp uvec3 k;
	i16vec4 l[1];
	u16vec4 m;
	uint16_t n;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.c), 3u) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d), ivec2(-1, 6)) && allOk;
	allOk = compare_uint16_t(uint(f), 3u) && allOk;
	allOk = compare_mat4x2(g, mat4x2(-7.0, 0.0, 6.0, -7.0, 5.0, -9.0, 3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec4(ivec4(-5, -7, 5, 2));
	blockB.e = (mat2x3(9.0, 3.0, 1.0, -6.0, 4.0, -4.0));
	g = (mat4x2(9.0, 3.0, 7.0, 7.0, -8.0, 5.0, -2.0, -7.0));
	blockD.j = (5u);
}
#version 450
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
	float16_t a;
	lowp float b;
	u16vec4 c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	i16vec3 d;
	mediump mat4x2 e;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump uint f;
	mediump uvec2 g;
	i16vec4 h[1];
	bvec4 i[1];
} blockD;
layout(std430, binding = 4) readonly buffer BlockE
{
	highp int j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 2.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.c), uvec4(7u, 6u, 2u, 4u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d), ivec3(4, 5, 3)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_uint((blockD.f), 7u) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h[0]), ivec4(8, -6, 2, -6)) && allOk;
	allOk = compare_int((j), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-1.0);
	blockB.b = (-4.0);
	blockB.c = u16vec4(uvec4(2u, 8u, 3u, 2u));
	blockC.d = i16vec3(ivec3(-5, 7, -5));
	blockC.e = (mat4x2(5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0));
	blockD.f = (7u);
	blockD.h[0] = i16vec4(ivec4(-2, 9, -6, 3));
	blockD.i[0] = (bvec4(false, true, false, true));
}
#version 450
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
	f16vec3 a;
	mediump mat4x3 b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat4x3 c;
	lowp ivec3 d;
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump mat4 e;
	highp uint f[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(a), vec3(1.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC.c, mat4x3(-4.0, -3.0, 5.0, -4.0, -9.0, -5.0, 0.0, -6.0, 2.0, 1.0, 6.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(9, 2, 5)) && allOk;
	allOk = compare_mat4(blockD.e, mat4(-2.0, -4.0, 7.0, 1.0, -8.0, -9.0, 5.0, 1.0, -5.0, 5.0, -3.0, 6.0, 6.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_uint((blockD.f[0]), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec3(vec3(2.0, 7.0, -5.0));
	b[0] = (mat4x3(-4.0, 0.0, 4.0, -8.0, -7.0, 7.0, -5.0, 5.0, 8.0, 0.0, 3.0, 3.0));
	b[1] = (mat4x3(8.0, -6.0, -1.0, 8.0, 5.0, -9.0, 0.0, 1.0, -2.0, 8.0, 7.0, -7.0));
	b[2] = (mat4x3(-5.0, 5.0, -6.0, 7.0, 3.0, 1.0, -9.0, 7.0, 8.0, -5.0, -7.0, 8.0));
	b[3] = (mat4x3(-9.0, 5.0, 8.0, -8.0, 3.0, 8.0, 4.0, 5.0, 0.0, 8.0, -4.0, -8.0));
	blockC.c = (mat4x3(1.0, -2.0, -8.0, -8.0, 2.0, -6.0, 2.0, -5.0, -3.0, -7.0, -5.0, -6.0));
	blockC.d = (ivec3(-4, -7, 7));
	blockD.f[0] = (6u);
}
#version 450
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
	lowp uvec2 b;
	lowp ivec2 c[1];
} blockB[2];

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (uvec2(8u, 6u));
	blockB[1].b = (uvec2(6u, 7u));
}
#version 450
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
	highp mat2x3 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(5.0, 9.0, -9.0, -9.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat2x3(-4.0, 2.0, -1.0, 2.0, 2.0, -5.0));
}
#version 450
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
	mediump uint b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0)) && allOk;
	allOk = compare_uint((blockB.b[0]), 4u) && allOk;
	allOk = compare_uint((blockB.b[1]), 3u) && allOk;
	allOk = compare_uint((blockB.b[2]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (4u);
	blockB.b[1] = (2u);
	blockB.b[2] = (4u);
}
#version 450
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
	highp mat3x4 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp uint b;
	mediump uint c;
	highp uvec3 d;
	lowp int e[];
};
layout(std140, binding = 3) buffer BlockD
{
	int16_t f;
	mediump uint g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((c), 2u) && allOk;
	allOk = compare_uvec3((d), uvec3(3u, 7u, 3u)) && allOk;
	allOk = compare_int((e[0]), 8) && allOk;
	allOk = compare_int((e[1]), -7) && allOk;
	allOk = compare_int((e[2]), -6) && allOk;
	allOk = compare_int((e[3]), -9) && allOk;
	allOk = compare_int((e[4]), 2) && allOk;
	allOk = compare_int((e[5]), 7) && allOk;
	allOk = compare_uint((blockD.g[0]), 3u) && allOk;
	allOk = compare_uint((blockD.g[1]), 8u) && allOk;
	allOk = compare_uint((blockD.g[2]), 5u) && allOk;
	allOk = compare_uint((blockD.g[3]), 4u) && allOk;
	allOk = compare_uint((blockD.g[4]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(-9.0, 0.0, -5.0, 8.0, -3.0, -3.0, 2.0, 6.0, 8.0, 9.0, 1.0, 2.0));
	blockB.a[1] = (mat3x4(9.0, -5.0, 7.0, -1.0, 8.0, 8.0, -9.0, 6.0, 5.0, -1.0, -3.0, -2.0));
	blockB.a[2] = (mat3x4(-4.0, 2.0, -8.0, -4.0, 9.0, -4.0, -4.0, -4.0, -4.0, 4.0, 1.0, -7.0));
	blockB.a[3] = (mat3x4(-1.0, 6.0, 0.0, -1.0, 9.0, 2.0, 2.0, 3.0, -8.0, -1.0, -2.0, 0.0));
	blockB.a[4] = (mat3x4(-8.0, 1.0, -1.0, 4.0, 9.0, -2.0, 2.0, -6.0, 2.0, -3.0, -5.0, -5.0));
	blockB.a[5] = (mat3x4(-3.0, 6.0, -7.0, -2.0, -5.0, -1.0, -3.0, 0.0, 6.0, -3.0, -6.0, -2.0));
	b = (4u);
	e[0] = (-3);
	e[1] = (1);
	e[2] = (6);
	e[3] = (-6);
	e[4] = (-9);
	e[5] = (6);
	blockD.f = int16_t(8);
}
#version 450
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
	i16vec2 mB;
	f16vec3 mC;
	lowp uint mD;
};
struct sB
{
	mediump uint mA;
	lowp vec3 mB;
	i16vec2 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	bvec4 a;
	sA b;
	sB c;
	lowp mat3x4 d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	f16vec2 e;
	highp mat4x2 f;
};
layout(std430, binding = 3) buffer BlockD
{
	float16_t g;
	i16vec2 h;
	float16_t i[];
};
layout(std430, binding = 4) buffer BlockE
{
	mediump vec3 j;
	highp ivec4 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat3x2(b.mA, mat3x2(-8.0, -2.0, -7.0, -4.0, -4.0, -5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(b.mB), ivec2(-1, 2)) && allOk;
	allOk = compare_f16vec3(vec3(b.mC), vec3(-2.0, -4.0, 7.0)) && allOk;
	allOk = compare_uint((b.mD), 0u) && allOk;
	allOk = compare_uint((c.mA), 2u) && allOk;
	allOk = compare_vec3((c.mB), vec3(-9.0, 4.0, 0.0)) && allOk;
	allOk = compare_i16vec2(ivec2(c.mC), ivec2(-1, -5)) && allOk;
	allOk = compare_f16vec2(vec2(e), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(f, mat4x2(7.0, 4.0, -8.0, -3.0, 2.0, -9.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((j), vec3(2.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, false));
	b.mA = (mat3x2(5.0, -5.0, -5.0, 9.0, -6.0, 0.0));
	b.mB = i16vec2(ivec2(6, 2));
	b.mC = f16vec3(vec3(7.0, 9.0, -4.0));
	b.mD = (0u);
	c.mA = (4u);
	c.mB = (vec3(-4.0, -4.0, 2.0));
	c.mC = i16vec2(ivec2(4, -3));
	e = f16vec2(vec2(5.0, 2.0));
	g = float16_t(0.0);
	h = i16vec2(ivec2(-4, 0));
	i[0] = float16_t(6.0);
	i[1] = float16_t(-5.0);
	i[2] = float16_t(-7.0);
	j = (vec3(-1.0, -3.0, -9.0));
	k = (ivec4(2, 6, -7, 4));
}
#version 450
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
	layout(offset = 0) i16vec2 a;
	layout(offset = 4) float16_t b;
	layout(offset = 6) i16vec2 c;
	layout(offset = 10) i16vec2 d;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(a), ivec2(-1, -5)) && allOk;
	allOk = compare_float16_t(float(b), -9.0) && allOk;
	allOk = compare_i16vec2(ivec2(c), ivec2(-9, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec2(ivec2(0, -7));
	c = i16vec2(ivec2(-6, 0));
	d = i16vec2(ivec2(4, -5));
}
#version 450
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
	layout(offset = 0) bvec4 a[1];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a[0]), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec4(true, false, true, false));
}
#version 450
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
	mediump float mA[5];
	mediump mat2x3 mB[7];
};
struct sB
{
	bvec3 mA;
	mediump mat3x4 mB;
	sA mC;
	float16_t mD;
};
struct sC
{
	lowp ivec4 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	sB a;
	lowp ivec3 b;
	bvec4 c;
	int16_t d[][6];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sC e;
	mediump ivec4 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(-5, 8, 5)) && allOk;
	allOk = compare_ivec4((f[0]), ivec4(-3, 1, -6, 5)) && allOk;
	allOk = compare_ivec4((f[1]), ivec4(-1, -2, -6, -9)) && allOk;
	allOk = compare_ivec4((f[2]), ivec4(1, 9, 4, 1)) && allOk;
	allOk = compare_ivec4((f[3]), ivec4(6, 1, 6, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (bvec3(true, true, true));
	blockB.a.mB = (mat3x4(1.0, 2.0, -4.0, -1.0, -9.0, 0.0, 0.0, 6.0, -6.0, -5.0, 2.0, 3.0));
	blockB.a.mC.mA[0] = (0.0);
	blockB.a.mC.mA[1] = (4.0);
	blockB.a.mC.mA[2] = (-4.0);
	blockB.a.mC.mA[3] = (-4.0);
	blockB.a.mC.mA[4] = (1.0);
	blockB.a.mC.mB[0] = (mat2x3(-6.0, 2.0, -1.0, 4.0, -4.0, -7.0));
	blockB.a.mC.mB[1] = (mat2x3(8.0, -8.0, 1.0, -1.0, -6.0, -3.0));
	blockB.a.mC.mB[2] = (mat2x3(2.0, 0.0, -6.0, -5.0, -6.0, 6.0));
	blockB.a.mC.mB[3] = (mat2x3(-7.0, 0.0, -9.0, -1.0, -1.0, 4.0));
	blockB.a.mC.mB[4] = (mat2x3(-2.0, -5.0, 5.0, 3.0, 0.0, 9.0));
	blockB.a.mC.mB[5] = (mat2x3(-5.0, -3.0, 3.0, -7.0, 0.0, -2.0));
	blockB.a.mC.mB[6] = (mat2x3(-2.0, 7.0, -9.0, -8.0, 3.0, 5.0));
	blockB.a.mD = float16_t(5.0);
	blockB.b = (ivec3(-1, 7, -1));
	blockB.c = (bvec4(false, false, true, false));
	f[0] = (ivec4(3, -6, -5, 9));
	f[1] = (ivec4(-6, -9, -2, -4));
	f[2] = (ivec4(-9, -8, 6, 3));
	f[3] = (ivec4(-1, -7, 7, -1));
}
#version 450
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
	highp mat3x2 a;
	lowp vec2 b;
	i16vec2 c;
	mediump uvec2 d;
	int16_t e[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-8.0, -5.0, -2.0, 5.0, 9.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(3u, 4u)) && allOk;
	allOk = compare_int16_t(int(blockB.e[0]), 1) && allOk;
	allOk = compare_int16_t(int(blockB.e[1]), 8) && allOk;
	allOk = compare_int16_t(int(blockB.e[2]), 1) && allOk;
	allOk = compare_int16_t(int(blockB.e[3]), -2) && allOk;
	allOk = compare_int16_t(int(blockB.e[4]), -8) && allOk;
	allOk = compare_int16_t(int(blockB.e[5]), -6) && allOk;
	allOk = compare_int16_t(int(blockB.e[6]), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec2(1.0, -9.0));
	blockB.e[0] = int16_t(3);
	blockB.e[1] = int16_t(4);
	blockB.e[2] = int16_t(-1);
	blockB.e[3] = int16_t(-4);
	blockB.e[4] = int16_t(-7);
	blockB.e[5] = int16_t(-8);
	blockB.e[6] = int16_t(-3);
}
#version 450
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
	lowp mat4x3 a;
	u16vec2 b;
	u16vec3 c;
	lowp uvec2 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB[nonuniformEXT(0)].c), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].d), uvec2(5u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB[nonuniformEXT(1)].c), uvec3(3u, 1u, 6u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].d), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB[nonuniformEXT(2)].c), uvec3(1u, 8u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].d), uvec2(2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = u16vec2(uvec2(7u, 8u));
	blockB[nonuniformEXT(0)].c = u16vec3(uvec3(3u, 0u, 5u));
	blockB[nonuniformEXT(1)].b = u16vec2(uvec2(1u, 4u));
	blockB[nonuniformEXT(1)].c = u16vec3(uvec3(6u, 0u, 8u));
	blockB[nonuniformEXT(2)].b = u16vec2(uvec2(9u, 5u));
	blockB[nonuniformEXT(2)].c = u16vec3(uvec3(7u, 6u, 6u));
}
#version 450
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
	lowp int a;
	highp float b;
	uint8_t c;
	int8_t d;
};
layout(std140, binding = 2) buffer BlockC
{
	uint8_t e;
	bool f;
	int8_t g[1];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	bool h;
};
layout(std430, binding = 4) buffer BlockE
{
	mediump uint i;
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
	allOk = compare_uint8_t(uint(blockC.e), 4u) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_bool((h), false) && allOk;
	allOk = compare_uint((blockE.i), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (8);
	b = (-2.0);
	blockC.e = uint8_t(8u);
	h = (false);
	blockE.i = (3u);
}
#version 450
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
	int8_t a;
	bvec2 b;
	highp uint c[6];
} blockB;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(9);
	blockB.c[0] = (0u);
	blockB.c[1] = (7u);
	blockB.c[2] = (4u);
	blockB.c[3] = (1u);
	blockB.c[4] = (7u);
	blockB.c[5] = (5u);
}
#version 450
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
	layout(offset = 16) bvec4 b;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec4 c;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uint d;
	layout(offset = 4) i8vec2 e;
	layout(offset = 6) int8_t f;
	layout(offset = 7) u8vec3 g;
	layout(offset = 16) mediump uvec2 h;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec3 i;
	layout(offset = 12) i8vec3 j;
	layout(offset = 16) lowp ivec3 k;
	layout(offset = 28) bool l;
} blockE[3];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a), ivec4(2, 4294967288, 4294967292, 7)) && allOk;
	allOk = compare_bvec4((blockB[0].b), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c), uvec4(3u, 4u, 2u, 6u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.e), ivec2(1, 4294967289)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j), ivec3(4294967289, 4294967288, 9)) && allOk;
	allOk = compare_ivec3((blockE[0].k), ivec3(-9, 1, 1)) && allOk;
	allOk = compare_bool((blockE[0].l), false) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j), ivec3(6, 4294967292, 6)) && allOk;
	allOk = compare_ivec3((blockE[1].k), ivec3(7, 5, 8)) && allOk;
	allOk = compare_bool((blockE[1].l), false) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j), ivec3(9, 7, 4294967288)) && allOk;
	allOk = compare_ivec3((blockE[2].k), ivec3(5, -1, 1)) && allOk;
	allOk = compare_bool((blockE[2].l), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec4(ivec4(8, 4294967294, 4294967295, 4294967290));
	blockB[0].b = (bvec4(false, false, false, false));
	blockC.c = u8vec4(uvec4(3u, 7u, 7u, 5u));
	blockD.d = (8u);
	blockD.f = int8_t(7);
	blockD.g = u8vec3(uvec3(1u, 3u, 9u));
	blockD.h = (uvec2(6u, 4u));
	blockE[0].i = (ivec3(-5, 4, 9));
	blockE[0].k = (ivec3(-4, 8, -6));
	blockE[1].i = (ivec3(6, -3, -6));
	blockE[1].k = (ivec3(-1, 4, -7));
	blockE[2].i = (ivec3(-1, 4, -6));
	blockE[2].k = (ivec3(-2, -3, -7));
}
#version 450
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
	mediump ivec3 a[];
} blockB;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec3(8, 2, -4));
	blockB.a[1] = (ivec3(3, -3, 7));
	blockB.a[2] = (ivec3(-3, 4, 3));
	blockB.a[3] = (ivec3(-9, 5, 2));
	blockB.a[4] = (ivec3(0, 4, 2));
}
#version 450
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
	bool a[1];
	mediump mat4x2 b;
	lowp ivec2 c;
	highp ivec3 d;
	mediump mat3x2 e[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].b, mat4x2(-2.0, -9.0, 3.0, 3.0, -4.0, -2.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[0], mat3x2(7.0, -9.0, 3.0, 3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[1], mat3x2(-6.0, -1.0, -9.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[2], mat3x2(-3.0, 0.0, 9.0, 6.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[3], mat3x2(1.0, -4.0, 9.0, -7.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat4x2(8.0, -4.0, 7.0, 7.0, 4.0, -9.0, -6.0, 5.0));
	blockB[0].c = (ivec2(-7, 1));
	blockB[0].d = (ivec3(9, -4, -9));
	blockB[0].e[0] = (mat3x2(-8.0, 5.0, 5.0, 1.0, 3.0, -6.0));
	blockB[0].e[1] = (mat3x2(9.0, -9.0, 4.0, -3.0, -3.0, 6.0));
	blockB[0].e[2] = (mat3x2(-2.0, -2.0, 5.0, -1.0, -4.0, -9.0));
	blockB[0].e[3] = (mat3x2(-6.0, 4.0, -3.0, -9.0, -1.0, -4.0));
}
#version 450
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
	mediump mat3 a;
	mediump uvec3 b[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	u8vec2 c;
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump ivec2 d;
	mediump vec4 e;
	i8vec3 f;
	highp mat3x2 g[];
};
layout(scalar, binding = 4) buffer BlockE
{
	lowp vec4 h[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(9.0, -9.0, 6.0, -9.0, 0.0, 7.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.c), uvec2(9u, 0u)) && allOk;
	allOk = compare_ivec2((d), ivec2(3, -1)) && allOk;
	allOk = compare_i8vec3(ivec3(f), ivec3(0, 8, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(0.0, -5.0, -1.0, 5.0, -4.0, 1.0, 0.0, 6.0, 1.0));
	blockC.c = u8vec2(uvec2(4u, 3u));
	f = i8vec3(ivec3(7, 4294967293, 4294967294));
	blockE.h[0] = (vec4(8.0, 3.0, -9.0, 1.0));
	blockE.h[1] = (vec4(9.0, -8.0, 7.0, 9.0));
}
#version 450
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
	mediump vec3 mA;
	int8_t mB;
	u8vec3 mC;
	i8vec4 mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	bvec2 a;
	lowp float b;
	lowp ivec3 c;
	int8_t d[];
};
layout(scalar, binding = 2) buffer BlockC
{
	uint8_t e[2];
	sA f;
	mediump ivec4 g;
	u8vec2 h;
} blockC[3];
layout(scalar, binding = 3) buffer BlockD
{
	bvec3 i;
	lowp int j;
	i8vec2 k;
	bool l;
	highp uint m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((c), ivec3(-7, -9, 6)) && allOk;
	allOk = compare_int8_t(int(d[0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(d[1]), 3) && allOk;
	allOk = compare_int8_t(int(d[2]), 4294967288) && allOk;
	allOk = compare_uint8_t(uint(blockC[0].e[0]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockC[0].e[1]), 3u) && allOk;
	allOk = compare_ivec4((blockC[0].g), ivec4(7, 0, 7, -8)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].h), uvec2(3u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(blockC[1].e[0]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC[1].e[1]), 9u) && allOk;
	allOk = compare_ivec4((blockC[1].g), ivec4(-2, 8, 7, -6)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].h), uvec2(6u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockC[2].e[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC[2].e[1]), 3u) && allOk;
	allOk = compare_ivec4((blockC[2].g), ivec4(5, 0, 6, 4)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].h), uvec2(9u, 9u)) && allOk;
	allOk = compare_int((j), 3) && allOk;
	allOk = compare_i8vec2(ivec2(k), ivec2(4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (2.0);
	d[0] = int8_t(4294967294);
	d[1] = int8_t(5);
	d[2] = int8_t(4294967287);
	blockC[0].e[0] = uint8_t(1u);
	blockC[0].e[1] = uint8_t(7u);
	blockC[0].f.mA = (vec3(-1.0, 9.0, -9.0));
	blockC[0].f.mB = int8_t(4);
	blockC[0].f.mC = u8vec3(uvec3(5u, 9u, 7u));
	blockC[0].f.mD = i8vec4(ivec4(4294967293, 4294967290, 0, 4294967287));
	blockC[0].g = (ivec4(2, 1, 0, 6));
	blockC[1].e[0] = uint8_t(3u);
	blockC[1].e[1] = uint8_t(2u);
	blockC[1].f.mA = (vec3(9.0, -8.0, 2.0));
	blockC[1].f.mB = int8_t(4294967289);
	blockC[1].f.mC = u8vec3(uvec3(8u, 8u, 6u));
	blockC[1].f.mD = i8vec4(ivec4(4294967290, 4294967294, 4294967290, 4294967288));
	blockC[1].g = (ivec4(2, 7, 5, 4));
	blockC[2].e[0] = uint8_t(5u);
	blockC[2].e[1] = uint8_t(8u);
	blockC[2].f.mA = (vec3(2.0, -3.0, 0.0));
	blockC[2].f.mB = int8_t(3);
	blockC[2].f.mC = u8vec3(uvec3(6u, 0u, 6u));
	blockC[2].f.mD = i8vec4(ivec4(0, 4294967294, 4294967295, 6));
	blockC[2].g = (ivec4(4, 5, 4, -1));
	i = (bvec3(true, false, true));
	k = i8vec2(ivec2(4294967295, 8));
	l = (false);
	m[0] = (5u);
	m[1] = (9u);
	m[2] = (2u);
	m[3] = (2u);
	m[4] = (1u);
	m[5] = (2u);
	m[6] = (6u);
	m[7] = (4u);
}
#version 450
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
	mediump mat2x3 a;
	bvec4 b;
	highp mat4x3 c;
	i8vec3 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	u8vec4 e;
	i8vec3 f[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	bool g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(6.0, -5.0, 3.0, 0.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.c, mat4x3(1.0, -4.0, 2.0, -8.0, -6.0, 0.0, 3.0, 0.0, 3.0, -3.0, -1.0, 2.0)) && allOk;
	allOk = compare_bool((g[0]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(false, false, false, false));
	blockB.c = (mat4x3(-9.0, 0.0, 0.0, -1.0, -8.0, -1.0, -9.0, -8.0, -9.0, -5.0, 3.0, -8.0));
	blockC.e = u8vec4(uvec4(2u, 8u, 6u, 8u));
	blockC.f[0] = i8vec3(ivec3(5, 6, 0));
	blockC.f[1] = i8vec3(ivec3(4294967290, 4294967288, 4));
	blockC.f[2] = i8vec3(ivec3(4294967295, 4294967291, 1));
	blockC.f[3] = i8vec3(ivec3(4294967292, 4294967294, 0));
	blockC.f[4] = i8vec3(ivec3(2, 9, 6));
	g[0] = (false);
}
#version 450
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
	mediump uvec4 a;
	i8vec3 b;
	u8vec4 c[1];
	mediump mat3 d;
	lowp int e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(0)].c[0]), uvec4(8u, 8u, 2u, 9u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].d, mat3(-6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(1)].c[0]), uvec4(6u, 9u, 6u, 0u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].d, mat3(-2.0, 3.0, 0.0, 8.0, -4.0, -1.0, 6.0, -7.0, -9.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(2)].c[0]), uvec4(9u, 1u, 6u, 0u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].d, mat3(9.0, -6.0, -6.0, -3.0, 6.0, -3.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(3)].c[0]), uvec4(7u, 3u, 1u, 2u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(3)].d, mat3(4.0, -9.0, -7.0, 8.0, -7.0, -6.0, -9.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec4(8u, 3u, 1u, 4u));
	blockB[nonuniformEXT(0)].b = i8vec3(ivec3(4294967293, 9, 4294967291));
	blockB[nonuniformEXT(1)].a = (uvec4(7u, 8u, 7u, 5u));
	blockB[nonuniformEXT(1)].b = i8vec3(ivec3(9, 4294967292, 2));
	blockB[nonuniformEXT(2)].a = (uvec4(0u, 0u, 1u, 6u));
	blockB[nonuniformEXT(2)].b = i8vec3(ivec3(3, 0, 4294967288));
	blockB[nonuniformEXT(3)].a = (uvec4(1u, 6u, 4u, 9u));
	blockB[nonuniformEXT(3)].b = i8vec3(ivec3(4294967293, 4294967290, 4294967294));
}
#version 450
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

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-6.0, -6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0)) && allOk;
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

layout(std430, binding = 1) readonly buffer Block
{
	highp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(-5.0, -3.0, -9.0)) && allOk;
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
	highp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 7) && allOk;
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	i16vec3 var;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var), ivec3(3, 4, 8)) && allOk;
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-6.0, -9.0, 1.0, 5.0, -6.0, -6.0, -9.0, -2.0)) && allOk;
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(1.0, -8.0, 7.0, -5.0, 4.0, 6.0)) && allOk;
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

}
#version 450
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

}
#version 450
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
	float16_t var;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var), -7.0) && allOk;
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

}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-5.0, -1.0, -7.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(7.0, 0.0, 5.0, 0.0, -5.0, 5.0)) && allOk;
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
	u8vec3 var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(var[0]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2]), uvec3(6u, 0u, 6u)) && allOk;
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
	uint16_t padding;
	u16vec2 var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(var[0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2]), uvec2(6u, 7u)) && allOk;
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

}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, -3.0));
	block.var[1] = (vec2(-8.0, 0.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(8.0, -6.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, 7.0));
	block.var[1] = (vec2(9.0, 8.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(3.0, 5.0, -3.0, -2.0, -9.0, -9.0, 4.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-6.0, -3.0, 9.0));
	block.var[1] = (vec3(-2.0, -6.0, -6.0));
	block.var[2] = (vec3(3.0, -9.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 4.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], 8.0) && allOk;
	allOk = compare_float(block.var[3][1], 1.0) && allOk;
	allOk = compare_float(block.var[3][2], -2.0) && allOk;
	allOk = compare_float(block.var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(1.0, 1.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-1.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(8.0, 1.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(3.0, 5.0, -1.0, -5.0));
	block.var[1] = (vec4(4.0, 2.0, 8.0, -7.0));
	block.var[2] = (vec4(-2.0, 6.0, -3.0, -1.0));
	block.var[3] = (vec4(-2.0, 5.0, 7.0, 1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-4.0, 7.0, 7.0, -6.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-5.0, 7.0, 6.0, 9.0, -6.0, 8.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var, mat3(4.0, -3.0, 1.0, -7.0, 7.0, -7.0, -5.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-5.0, -3.0, -5.0, -2.0, 2.0, -5.0, 6.0, 3.0, -8.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-2.0, -6.0, 9.0, 2.0, 2.0, -8.0, -2.0, 7.0, -4.0, -6.0, 3.0, 2.0, 9.0, -2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-7.0, 6.0, 4.0, 9.0, 8.0, 9.0, 2.0, 6.0, -6.0, 7.0, 1.0, -7.0, 1.0, 4.0, 4.0, -2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][3], -9.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][2], 4.0) && allOk;
	allOk = compare_float(block.var[2][3], -1.0) && allOk;
	allOk = compare_float(block.var[3][0], 8.0) && allOk;
	allOk = compare_float(block.var[3][1], 6.0) && allOk;
	allOk = compare_float(block.var[3][2], -6.0) && allOk;
	allOk = compare_float(block.var[3][3], 3.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(9.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-8.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-1.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(8.0, 6.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(0.0, 9.0, -7.0, 3.0, 6.0, 6.0, 6.0, 1.0, -1.0, 2.0, 3.0, 8.0, 3.0, 1.0, 2.0, -2.0));
}
#version 450
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
	int16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = int16_t(6);
}
#version 450
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
	lowp vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_vec4((block.var), vec4(4.0, 3.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var = (vec4(-3.0, 0.0, 1.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec2(2.0, -8.0));
	block.var[1] = (vec2(-5.0, 2.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, 3.0, -7.0));
	block.var[0][1] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][2] = (vec3(1.0, -2.0, -1.0));
	block.var[0][3] = (vec3(-5.0, -1.0, 9.0));
	block.var[1][0] = (vec3(8.0, -4.0, 3.0));
	block.var[1][1] = (vec3(4.0, 9.0, -6.0));
	block.var[1][2] = (vec3(7.0, 6.0, -5.0));
	block.var[1][3] = (vec3(2.0, 6.0, 3.0));
	block.var[2][0] = (vec3(2.0, 7.0, -1.0));
	block.var[2][1] = (vec3(-3.0, -3.0, -7.0));
	block.var[2][2] = (vec3(-5.0, 3.0, 4.0));
	block.var[2][3] = (vec3(-4.0, -2.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
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
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(-7.0, 8.0, 7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-2.0, 1.0, -7.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(7.0, 2.0, -2.0, -3.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0] = (mat2x3(6.0, 9.0, 9.0, -8.0, 7.0, 5.0));
	block.var[1] = (mat2x3(-1.0, -9.0, 0.0, 8.0, 1.0, -7.0));
	block.var[2] = (mat2x3(2.0, 4.0, -8.0, 4.0, 4.0, -4.0));
}
#version 450
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
	i16vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1]), ivec2(-3, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2]), ivec2(2, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0] = i16vec2(ivec2(-2, -2));
	block.var[1] = i16vec2(ivec2(-8, 3));
	block.var[2] = i16vec2(ivec2(5, -9));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	bvec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[4]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[6]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[7]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[8]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[9]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[10]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[11]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[12]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[13]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[14]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[15]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[16]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[17]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[18]), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec4(true, true, true, false));
	block.var[1] = (bvec4(true, false, false, false));
	block.var[2] = (bvec4(false, true, true, true));
	block.var[3] = (bvec4(true, true, true, false));
	block.var[4] = (bvec4(true, false, true, false));
	block.var[5] = (bvec4(true, false, false, true));
	block.var[6] = (bvec4(false, true, true, false));
	block.var[7] = (bvec4(true, true, true, false));
	block.var[8] = (bvec4(false, false, true, true));
	block.var[9] = (bvec4(true, false, true, false));
	block.var[10] = (bvec4(true, true, true, true));
	block.var[11] = (bvec4(false, true, false, true));
	block.var[12] = (bvec4(false, true, false, true));
	block.var[13] = (bvec4(true, true, true, false));
	block.var[14] = (bvec4(false, true, false, false));
	block.var[15] = (bvec4(true, false, false, true));
	block.var[16] = (bvec4(true, true, true, false));
	block.var[17] = (bvec4(true, false, false, false));
	block.var[18] = (bvec4(false, false, true, true));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[3] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[4] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[5] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[6] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[7] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[8] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[9] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[10] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[11] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	block.var[12] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	block.var[13] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	block.var[14] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	block.var[15] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	block.var[16] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	block.var[17] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	block.var[18] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[3][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[3][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[4][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[4][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[5][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[5][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[6][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[6][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[7][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[7][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[8][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[8][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[9][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[9][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[10][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[10][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[11][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[11][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[12][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[12][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[13][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[13][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[14][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[14][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[15][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[15][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[16][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[16][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[17][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[17][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[18][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[18][1] = (vec4(9.0, -8.0, 7.0, 0.0));
}
#version 450
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
	u16vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[4]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[5]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[6]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[7]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[8]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[9]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[10]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[11]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[13]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[14]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[15]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[16]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[17]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[18]), uvec2(1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec2(uvec2(8u, 0u));
	block.var[1] = u16vec2(uvec2(6u, 0u));
	block.var[2] = u16vec2(uvec2(6u, 9u));
	block.var[3] = u16vec2(uvec2(3u, 2u));
	block.var[4] = u16vec2(uvec2(9u, 2u));
	block.var[5] = u16vec2(uvec2(4u, 5u));
	block.var[6] = u16vec2(uvec2(1u, 1u));
	block.var[7] = u16vec2(uvec2(2u, 8u));
	block.var[8] = u16vec2(uvec2(1u, 5u));
	block.var[9] = u16vec2(uvec2(0u, 2u));
	block.var[10] = u16vec2(uvec2(3u, 8u));
	block.var[11] = u16vec2(uvec2(1u, 8u));
	block.var[12] = u16vec2(uvec2(7u, 0u));
	block.var[13] = u16vec2(uvec2(3u, 9u));
	block.var[14] = u16vec2(uvec2(8u, 9u));
	block.var[15] = u16vec2(uvec2(1u, 2u));
	block.var[16] = u16vec2(uvec2(5u, 7u));
	block.var[17] = u16vec2(uvec2(9u, 9u));
	block.var[18] = u16vec2(uvec2(7u, 6u));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var[0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[0][2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	block.var[1][0] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	block.var[1][1] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	block.var[1][2] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	block.var[2][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	block.var[2][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	block.var[2][2] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	block.var[3][0] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	block.var[3][1] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	block.var[3][2] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[0][2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	block.var[1][0] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	block.var[1][1] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	block.var[1][2] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	block.var[2][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	block.var[2][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	block.var[2][2] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	block.var[3][0] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	block.var[3][1] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	block.var[3][2] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[1][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[1][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[1][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[2][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[2][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[2][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[3][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[3][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[3][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[0][2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[1][0] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[1][1] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[1][2] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[2][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[2][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[2][2] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[3][0] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[3][1] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[3][2] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(0.0, 6.0, 4.0, 7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(1.0, 7.0, -4.0, 9.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-2.0, -4.0, 6.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(5.0, 2.0, -9.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(7.0, 6.0, -9.0, -3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(0.0, -2.0, 3.0, 7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-1.0, 6.0, -5.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(9.0, -3.0, -7.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-7.0, 0.0, 2.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(9.0, -8.0, -8.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(3.0, -3.0, -1.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(3.0, -8.0, 4.0, 0.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var[0][0][0] = (vec2(-7.0, 8.0));
	block.var[0][0][1] = (vec2(-2.0, -9.0));
	block.var[0][0][2] = (vec2(-4.0, -1.0));
	block.var[0][1][0] = (vec2(-3.0, -3.0));
	block.var[0][1][1] = (vec2(-8.0, 2.0));
	block.var[0][1][2] = (vec2(7.0, -2.0));
	block.var[0][2][0] = (vec2(-3.0, -3.0));
	block.var[0][2][1] = (vec2(-4.0, 5.0));
	block.var[0][2][2] = (vec2(-1.0, 9.0));
	block.var[1][0][0] = (vec2(-4.0, 7.0));
	block.var[1][0][1] = (vec2(1.0, 6.0));
	block.var[1][0][2] = (vec2(7.0, -8.0));
	block.var[1][1][0] = (vec2(8.0, 1.0));
	block.var[1][1][1] = (vec2(6.0, 8.0));
	block.var[1][1][2] = (vec2(9.0, -1.0));
	block.var[1][2][0] = (vec2(1.0, -1.0));
	block.var[1][2][1] = (vec2(0.0, 3.0));
	block.var[1][2][2] = (vec2(2.0, -3.0));
	block.var[2][0][0] = (vec2(-9.0, -8.0));
	block.var[2][0][1] = (vec2(-8.0, 4.0));
	block.var[2][0][2] = (vec2(-2.0, -2.0));
	block.var[2][1][0] = (vec2(-1.0, 3.0));
	block.var[2][1][1] = (vec2(-2.0, 9.0));
	block.var[2][1][2] = (vec2(9.0, -2.0));
	block.var[2][2][0] = (vec2(-1.0, 9.0));
	block.var[2][2][1] = (vec2(-9.0, -4.0));
	block.var[2][2][2] = (vec2(-4.0, -3.0));
	block.var[3][0][0] = (vec2(7.0, -5.0));
	block.var[3][0][1] = (vec2(-5.0, 0.0));
	block.var[3][0][2] = (vec2(-2.0, 4.0));
	block.var[3][1][0] = (vec2(5.0, 5.0));
	block.var[3][1][1] = (vec2(2.0, -3.0));
	block.var[3][1][2] = (vec2(-4.0, -5.0));
	block.var[3][2][0] = (vec2(-7.0, 6.0));
	block.var[3][2][1] = (vec2(-6.0, 8.0));
	block.var[3][2][2] = (vec2(-3.0, 9.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[0][0][2] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[0][1][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	block.var[0][1][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	block.var[0][1][2] = (mat2(-2.0, -3.0, 3.0, -1.0));
	block.var[1][0][0] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[1][0][1] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[1][0][2] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[1][1][0] = (mat2(-2.0, -8.0, 1.0, -1.0));
	block.var[1][1][1] = (mat2(9.0, -2.0, -3.0, 6.0));
	block.var[1][1][2] = (mat2(2.0, 6.0, -4.0, -6.0));
	block.var[2][0][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[2][0][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[2][0][2] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[2][1][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	block.var[2][1][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	block.var[2][1][2] = (mat2(-6.0, -2.0, 3.0, -6.0));
	block.var[3][0][0] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[3][0][1] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[3][0][2] = (mat2(6.0, 0.0, 1.0, 8.0));
	block.var[3][1][0] = (mat2(-9.0, -4.0, 0.0, -1.0));
	block.var[3][1][1] = (mat2(0.0, 7.0, 4.0, 1.0));
	block.var[3][1][2] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[0][0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[0][1][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	block.var[0][1][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	block.var[0][1][2] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	block.var[1][0][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[1][0][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[1][0][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[1][1][0] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	block.var[1][1][1] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	block.var[1][1][2] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	block.var[2][0][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[2][0][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[2][0][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[2][1][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	block.var[2][1][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	block.var[2][1][2] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	block.var[3][0][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[3][0][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[3][0][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	block.var[3][1][0] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	block.var[3][1][1] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	block.var[3][1][2] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0][0][0] = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	block.var[0][0][1] = (mat3(-8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0));
	block.var[0][0][2] = (mat3(5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0));
	block.var[0][1][0] = (mat3(-3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0, 5.0));
	block.var[0][1][1] = (mat3(-8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0, 1.0));
	block.var[0][1][2] = (mat3(9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0, -9.0));
	block.var[1][0][0] = (mat3(1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0, -6.0));
	block.var[1][0][1] = (mat3(-8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0, 2.0));
	block.var[1][0][2] = (mat3(-3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0, 3.0));
	block.var[1][1][0] = (mat3(2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0, -1.0));
	block.var[1][1][1] = (mat3(-8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0, -5.0));
	block.var[1][1][2] = (mat3(2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0, -6.0));
	block.var[2][0][0] = (mat3(5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0, 0.0));
	block.var[2][0][1] = (mat3(-4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0, 9.0));
	block.var[2][0][2] = (mat3(7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0, -6.0));
	block.var[2][1][0] = (mat3(-1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0, 9.0));
	block.var[2][1][1] = (mat3(2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0, -3.0));
	block.var[2][1][2] = (mat3(-9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0, -8.0));
	block.var[3][0][0] = (mat3(-7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0, 2.0));
	block.var[3][0][1] = (mat3(4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0, -8.0));
	block.var[3][0][2] = (mat3(3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0, -1.0));
	block.var[3][1][0] = (mat3(6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0, 6.0));
	block.var[3][1][1] = (mat3(-4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0, 2.0));
	block.var[3][1][2] = (mat3(-2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(-9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(-1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0][0] = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	block.var[0][0][1] = (mat3(1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0));
	block.var[0][0][2] = (mat3(4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0));
	block.var[0][1][0] = (mat3(4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0, -3.0));
	block.var[0][1][1] = (mat3(2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0, -6.0));
	block.var[0][1][2] = (mat3(9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0, -5.0));
	block.var[1][0][0] = (mat3(3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0, 4.0));
	block.var[1][0][1] = (mat3(7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0, 7.0));
	block.var[1][0][2] = (mat3(-6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0, 5.0));
	block.var[1][1][0] = (mat3(6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0, 1.0));
	block.var[1][1][1] = (mat3(-1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0, 8.0));
	block.var[1][1][2] = (mat3(7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0, 0.0));
	block.var[2][0][0] = (mat3(4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0, -3.0));
	block.var[2][0][1] = (mat3(6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0, -4.0));
	block.var[2][0][2] = (mat3(-4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0, -8.0));
	block.var[2][1][0] = (mat3(7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0, 0.0));
	block.var[2][1][1] = (mat3(7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0, 7.0));
	block.var[2][1][2] = (mat3(6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0, 8.0));
	block.var[3][0][0] = (mat3(-8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0, -3.0));
	block.var[3][0][1] = (mat3(-8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0, 3.0));
	block.var[3][0][2] = (mat3(-2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0, -2.0));
	block.var[3][1][0] = (mat3(-8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0, 0.0));
	block.var[3][1][1] = (mat3(-4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0, -9.0));
	block.var[3][1][2] = (mat3(-6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(1.0, 1.0, 2.0, -9.0, -1.0, 3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(2.0, -6.0, 0.0, -3.0, 1.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(4.0, -5.0, -7.0, 8.0, 0.0, -3.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-8.0, 0.0, -4.0, 7.0, -3.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(4.0, 7.0, 9.0, -5.0, 5.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(0.0, -9.0, -1.0, 7.0, -3.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(9.0, 6.0, -6.0, 8.0, 4.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(5.0, -3.0, -4.0, 4.0, 0.0, -3.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-8.0, 3.0, 6.0, 3.0, 9.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(7.0, 0.0, 9.0, -9.0, -7.0, 1.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(5.0, 8.0, 1.0, -3.0, -6.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-2.0, 9.0, -9.0, -7.0, -5.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(2.0, 3.0, 3.0, -9.0, 5.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-5.0, 2.0, 6.0, 6.0, 1.0, 0.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(5.0, -5.0, -1.0, -6.0, 9.0, -9.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(5.0, -7.0, -3.0, -4.0, -8.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-5.0, -2.0, 3.0, 6.0, 8.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(4.0, -5.0, 1.0, 5.0, 3.0, 4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-1.0, 1.0, 7.0, 0.0, 0.0, 0.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(3.0, -7.0, 6.0, 1.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(1.0, -9.0, -4.0, 4.0, 9.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(2.0, -6.0, 5.0, 6.0, 0.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(-4.0, 2.0, -3.0, 3.0, -5.0, -5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0][0] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][0][0][1] = (vec4(1.0, 7.0, 1.0, -7.0));
	block.var[0][0][1][0] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][0][1][1] = (vec4(2.0, -1.0, 4.0, 2.0));
	block.var[0][0][2][0] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[0][0][2][1] = (vec4(5.0, -2.0, 1.0, 0.0));
	block.var[0][1][0][0] = (vec4(6.0, 7.0, 9.0, 5.0));
	block.var[0][1][0][1] = (vec4(8.0, 5.0, 5.0, 9.0));
	block.var[0][1][1][0] = (vec4(5.0, 9.0, -6.0, -8.0));
	block.var[0][1][1][1] = (vec4(9.0, 2.0, -5.0, -2.0));
	block.var[0][1][2][0] = (vec4(8.0, -3.0, -7.0, -6.0));
	block.var[0][1][2][1] = (vec4(0.0, 7.0, 4.0, -6.0));
	block.var[1][0][0][0] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][0][0][1] = (vec4(5.0, -3.0, 3.0, 1.0));
	block.var[1][0][1][0] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[1][0][1][1] = (vec4(9.0, -1.0, 8.0, -4.0));
	block.var[1][0][2][0] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[1][0][2][1] = (vec4(2.0, -4.0, 6.0, 0.0));
	block.var[1][1][0][0] = (vec4(-8.0, -6.0, 3.0, -3.0));
	block.var[1][1][0][1] = (vec4(-1.0, 5.0, -7.0, -4.0));
	block.var[1][1][1][0] = (vec4(-3.0, 0.0, -2.0, 7.0));
	block.var[1][1][1][1] = (vec4(-4.0, 5.0, -9.0, 3.0));
	block.var[1][1][2][0] = (vec4(-2.0, 1.0, -8.0, -2.0));
	block.var[1][1][2][1] = (vec4(3.0, -3.0, 9.0, 6.0));
	block.var[2][0][0][0] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[2][0][0][1] = (vec4(-3.0, -2.0, 3.0, -9.0));
	block.var[2][0][1][0] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[2][0][1][1] = (vec4(3.0, -2.0, 6.0, 5.0));
	block.var[2][0][2][0] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[2][0][2][1] = (vec4(2.0, 7.0, -9.0, -3.0));
	block.var[2][1][0][0] = (vec4(8.0, -6.0, 8.0, -7.0));
	block.var[2][1][0][1] = (vec4(-5.0, 0.0, 4.0, 8.0));
	block.var[2][1][1][0] = (vec4(0.0, 1.0, 1.0, -9.0));
	block.var[2][1][1][1] = (vec4(0.0, 1.0, -6.0, -6.0));
	block.var[2][1][2][0] = (vec4(-7.0, -6.0, 3.0, -2.0));
	block.var[2][1][2][1] = (vec4(9.0, 2.0, -5.0, 1.0));
	block.var[3][0][0][0] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[3][0][0][1] = (vec4(-8.0, -4.0, 6.0, -4.0));
	block.var[3][0][1][0] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[3][0][1][1] = (vec4(-2.0, -8.0, 4.0, 4.0));
	block.var[3][0][2][0] = (vec4(4.0, 0.0, -9.0, 1.0));
	block.var[3][0][2][1] = (vec4(-8.0, 8.0, -8.0, -4.0));
	block.var[3][1][0][0] = (vec4(-3.0, 9.0, 4.0, -6.0));
	block.var[3][1][0][1] = (vec4(-8.0, 4.0, -7.0, -7.0));
	block.var[3][1][1][0] = (vec4(1.0, -6.0, 7.0, 1.0));
	block.var[3][1][1][1] = (vec4(-3.0, 9.0, -8.0, 5.0));
	block.var[3][1][2][0] = (vec4(-1.0, 1.0, -7.0, 8.0));
	block.var[3][1][2][1] = (vec4(-9.0, 3.0, -2.0, 7.0));
}
#version 450
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
	u8vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var[0][0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][2][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][2][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][3][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][3][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][1]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][2][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][2][1]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][3][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][3][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][0]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][1]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][1]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][2][0]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][2][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][3][0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][3][1]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec2(uvec2(7u, 7u));
	block.var[0][0][1] = u8vec2(uvec2(9u, 6u));
	block.var[0][1][0] = u8vec2(uvec2(2u, 7u));
	block.var[0][1][1] = u8vec2(uvec2(4u, 4u));
	block.var[0][2][0] = u8vec2(uvec2(1u, 8u));
	block.var[0][2][1] = u8vec2(uvec2(4u, 0u));
	block.var[0][3][0] = u8vec2(uvec2(7u, 4u));
	block.var[0][3][1] = u8vec2(uvec2(0u, 1u));
	block.var[1][0][0] = u8vec2(uvec2(0u, 2u));
	block.var[1][0][1] = u8vec2(uvec2(1u, 1u));
	block.var[1][1][0] = u8vec2(uvec2(7u, 2u));
	block.var[1][1][1] = u8vec2(uvec2(4u, 5u));
	block.var[1][2][0] = u8vec2(uvec2(2u, 7u));
	block.var[1][2][1] = u8vec2(uvec2(2u, 0u));
	block.var[1][3][0] = u8vec2(uvec2(2u, 3u));
	block.var[1][3][1] = u8vec2(uvec2(5u, 4u));
	block.var[2][0][0] = u8vec2(uvec2(0u, 8u));
	block.var[2][0][1] = u8vec2(uvec2(8u, 5u));
	block.var[2][1][0] = u8vec2(uvec2(0u, 2u));
	block.var[2][1][1] = u8vec2(uvec2(1u, 8u));
	block.var[2][2][0] = u8vec2(uvec2(2u, 5u));
	block.var[2][2][1] = u8vec2(uvec2(3u, 4u));
	block.var[2][3][0] = u8vec2(uvec2(4u, 2u));
	block.var[2][3][1] = u8vec2(uvec2(1u, 9u));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[0][1][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[0][1][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[0][2][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	block.var[0][2][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	block.var[0][3][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	block.var[0][3][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	block.var[1][0][0] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[1][0][1] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[1][1][0] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[1][1][1] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[1][2][0] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	block.var[1][2][1] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	block.var[1][3][0] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	block.var[1][3][1] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	block.var[2][0][0] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[2][0][1] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[2][1][0] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[2][1][1] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	block.var[2][2][0] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	block.var[2][2][1] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	block.var[2][3][0] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	block.var[2][3][1] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

struct S
{
	highp uvec2 a;
	mediump mat2x4 b[4];
	highp vec3 c;
};
layout(std140, buffer_reference) buffer Block
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(-7.0, 2.0, 3.0, 1.0, -1.0, -5.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(9.0, -9.0, -8.0, -6.0, -4.0, 6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(1.0, -9.0, -8.0, 5.0, -7.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(3.0, -7.0, 2.0, -7.0, -5.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(2.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(-5.0, 8.0, -2.0, 4.0, -4.0, -3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(8.0, 7.0, 5.0, 9.0, -2.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(9.0, 1.0, 8.0, -8.0, -8.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(2.0, 6.0, 2.0, 5.0, -6.0, -4.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(4.0, -1.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(3.0, -5.0, 5.0, 5.0, -1.0, -3.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-8.0, -1.0, 5.0, -4.0, 4.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(6.0, 1.0, -6.0, 7.0, 7.0, -9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-1.0, -5.0, -7.0, -2.0, 0.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(-2.0, -9.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-1.0, 9.0, 9.0, -3.0, -9.0, -3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(3.0, 2.0, 1.0, 2.0, -5.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(1.0, -4.0, 1.0, 9.0, 2.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(2.0, 5.0, 0.0, -1.0, 3.0, -9.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-9.0, 0.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-6.0, 9.0, -2.0, 8.0, -1.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-3.0, -9.0, -2.0, -9.0, 4.0, -3.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-8.0, 3.0, -6.0, -9.0, -7.0, -6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(5.0, 0.0, -5.0, -8.0, 4.0, -3.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(7.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(6.0, -5.0, -1.0, 9.0, 5.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-9.0, 5.0, 9.0, -3.0, -1.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-5.0, 6.0, 7.0, 3.0, 5.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(-1.0, 0.0, -5.0, 8.0, -2.0, 2.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(0.0, -3.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(9.0, 7.0, -4.0, -1.0, -8.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(9.0, 1.0, 0.0, 9.0, -1.0, -6.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(9.0, -7.0, 6.0, 1.0, 3.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-9.0, -2.0, -3.0, -7.0, -2.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(7.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-9.0, 3.0, 3.0, 7.0, 6.0, -3.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-4.0, -1.0, -8.0, 0.0, -2.0, 4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-5.0, 3.0, -5.0, 4.0, 5.0, -7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-6.0, 3.0, -5.0, -7.0, 9.0, -6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-2.0, 1.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(7.0, -7.0, 5.0, 1.0, 7.0, -4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(8.0, -4.0, 3.0, 9.0, -5.0, 4.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-4.0, -1.0, 0.0, -4.0, 8.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-1.0, 7.0, -2.0, 1.0, 1.0, 9.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(7.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(2.0, -8.0, -7.0, -8.0, 0.0, -8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-8.0, 1.0, 3.0, -4.0, 2.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-5.0, -5.0, 5.0, -2.0, 6.0, -5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-4.0, -6.0, -1.0, -7.0, 0.0, 2.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(6.0, 7.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(0u, 3u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-9.0, 2.0, -8.0, -5.0, 1.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(2.0, 2.0, 5.0, -8.0, 7.0, -1.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-5.0, 5.0, -7.0, -1.0, 6.0, 5.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(8.0, -7.0, 4.0, 7.0, -5.0, 3.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(4.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (5u);
	block[0].s[0].a = (uvec2(5u, 5u));
	block[0].s[0].b[0][0] = (vec4(-4.0, -1.0, -5.0, -1.0));
	block[0].s[0].b[0][1] = (vec4(8.0, 2.0, -1.0, 0.0));
	block[0].s[0].b[1][0] = (vec4(-9.0, -5.0, -1.0, 7.0));
	block[0].s[0].b[1][1] = (vec4(-2.0, -1.0, 0.0, 7.0));
	block[0].s[0].b[2][0] = (vec4(1.0, -1.0, -4.0, 9.0));
	block[0].s[0].b[2][1] = (vec4(-6.0, -6.0, 6.0, 9.0));
	block[0].s[0].b[3][0] = (vec4(7.0, 0.0, -4.0, -2.0));
	block[0].s[0].b[3][1] = (vec4(-4.0, 6.0, -2.0, 5.0));
	block[0].s[0].c = (vec3(6.0, 5.0, 6.0));
	block[0].s[1].a = (uvec2(0u, 9u));
	block[0].s[1].b[0][0] = (vec4(-6.0, 9.0, -5.0, 4.0));
	block[0].s[1].b[0][1] = (vec4(2.0, 8.0, -2.0, -2.0));
	block[0].s[1].b[1][0] = (vec4(-2.0, -7.0, -4.0, 9.0));
	block[0].s[1].b[1][1] = (vec4(-8.0, -1.0, 9.0, -5.0));
	block[0].s[1].b[2][0] = (vec4(2.0, 4.0, -7.0, 7.0));
	block[0].s[1].b[2][1] = (vec4(3.0, 9.0, 6.0, -3.0));
	block[0].s[1].b[3][0] = (vec4(-2.0, 2.0, 6.0, -8.0));
	block[0].s[1].b[3][1] = (vec4(9.0, 1.0, -8.0, -4.0));
	block[0].s[1].c = (vec3(3.0, -6.0, 2.0));
	block[0].s[2].a = (uvec2(6u, 2u));
	block[0].s[2].b[0][0] = (vec4(8.0, 1.0, 7.0, -4.0));
	block[0].s[2].b[0][1] = (vec4(-2.0, 0.0, 8.0, -3.0));
	block[0].s[2].b[1][0] = (vec4(8.0, 0.0, 7.0, -8.0));
	block[0].s[2].b[1][1] = (vec4(1.0, -9.0, 8.0, -1.0));
	block[0].s[2].b[2][0] = (vec4(-2.0, -7.0, -5.0, 4.0));
	block[0].s[2].b[2][1] = (vec4(9.0, 6.0, -4.0, 0.0));
	block[0].s[2].b[3][0] = (vec4(4.0, 2.0, -4.0, 9.0));
	block[0].s[2].b[3][1] = (vec4(-6.0, 3.0, -1.0, 5.0));
	block[0].s[2].c = (vec3(3.0, 6.0, 3.0));
	block[0].s[3].a = (uvec2(0u, 4u));
	block[0].s[3].b[0][0] = (vec4(7.0, -4.0, 3.0, 9.0));
	block[0].s[3].b[0][1] = (vec4(-2.0, -6.0, 6.0, -4.0));
	block[0].s[3].b[1][0] = (vec4(-9.0, 2.0, 0.0, 0.0));
	block[0].s[3].b[1][1] = (vec4(-5.0, 6.0, 3.0, -7.0));
	block[0].s[3].b[2][0] = (vec4(-3.0, -7.0, 3.0, -6.0));
	block[0].s[3].b[2][1] = (vec4(-6.0, -6.0, 3.0, 5.0));
	block[0].s[3].b[3][0] = (vec4(-7.0, -2.0, 0.0, -4.0));
	block[0].s[3].b[3][1] = (vec4(3.0, 2.0, 3.0, 3.0));
	block[0].s[3].c = (vec3(-2.0, 0.0, -1.0));
	block[1].v = (8u);
	block[1].s[0].a = (uvec2(5u, 3u));
	block[1].s[0].b[0][0] = (vec4(-3.0, -5.0, -2.0, -5.0));
	block[1].s[0].b[0][1] = (vec4(4.0, -5.0, 2.0, -7.0));
	block[1].s[0].b[1][0] = (vec4(4.0, 8.0, 5.0, 4.0));
	block[1].s[0].b[1][1] = (vec4(-3.0, -4.0, -4.0, 1.0));
	block[1].s[0].b[2][0] = (vec4(2.0, 6.0, 6.0, -3.0));
	block[1].s[0].b[2][1] = (vec4(-4.0, -9.0, -3.0, -2.0));
	block[1].s[0].b[3][0] = (vec4(-1.0, 6.0, 7.0, -7.0));
	block[1].s[0].b[3][1] = (vec4(9.0, 4.0, -2.0, -9.0));
	block[1].s[0].c = (vec3(2.0, -3.0, 1.0));
	block[1].s[1].a = (uvec2(0u, 0u));
	block[1].s[1].b[0][0] = (vec4(-4.0, 6.0, 1.0, 3.0));
	block[1].s[1].b[0][1] = (vec4(-5.0, 4.0, -7.0, 3.0));
	block[1].s[1].b[1][0] = (vec4(3.0, -9.0, 8.0, 3.0));
	block[1].s[1].b[1][1] = (vec4(-3.0, -9.0, -7.0, 0.0));
	block[1].s[1].b[2][0] = (vec4(-9.0, 2.0, -7.0, -6.0));
	block[1].s[1].b[2][1] = (vec4(-5.0, -9.0, 3.0, 8.0));
	block[1].s[1].b[3][0] = (vec4(-4.0, 1.0, -8.0, 1.0));
	block[1].s[1].b[3][1] = (vec4(-9.0, -8.0, 0.0, -8.0));
	block[1].s[1].c = (vec3(4.0, -7.0, 4.0));
	block[1].s[2].a = (uvec2(6u, 1u));
	block[1].s[2].b[0][0] = (vec4(-1.0, 0.0, -1.0, -6.0));
	block[1].s[2].b[0][1] = (vec4(1.0, 4.0, -8.0, -4.0));
	block[1].s[2].b[1][0] = (vec4(-8.0, -6.0, -8.0, -6.0));
	block[1].s[2].b[1][1] = (vec4(-2.0, 7.0, 5.0, 2.0));
	block[1].s[2].b[2][0] = (vec4(3.0, -5.0, -7.0, 8.0));
	block[1].s[2].b[2][1] = (vec4(5.0, 9.0, 8.0, -1.0));
	block[1].s[2].b[3][0] = (vec4(2.0, -4.0, 1.0, 1.0));
	block[1].s[2].b[3][1] = (vec4(-3.0, 8.0, 1.0, -3.0));
	block[1].s[2].c = (vec3(3.0, 5.0, 6.0));
	block[1].s[3].a = (uvec2(7u, 7u));
	block[1].s[3].b[0][0] = (vec4(3.0, 3.0, 1.0, 5.0));
	block[1].s[3].b[0][1] = (vec4(-9.0, 7.0, 8.0, -3.0));
	block[1].s[3].b[1][0] = (vec4(7.0, 8.0, -7.0, 8.0));
	block[1].s[3].b[1][1] = (vec4(-9.0, 2.0, 3.0, -8.0));
	block[1].s[3].b[2][0] = (vec4(3.0, 5.0, 8.0, -9.0));
	block[1].s[3].b[2][1] = (vec4(3.0, -7.0, -8.0, -1.0));
	block[1].s[3].b[3][0] = (vec4(1.0, 2.0, 9.0, 6.0));
	block[1].s[3].b[3][1] = (vec4(-6.0, 8.0, 3.0, -3.0));
	block[1].s[3].c = (vec3(-8.0, 5.0, 2.0));
	block[2].v = (0u);
	block[2].s[0].a = (uvec2(0u, 6u));
	block[2].s[0].b[0][0] = (vec4(-1.0, -2.0, 8.0, 3.0));
	block[2].s[0].b[0][1] = (vec4(-8.0, 2.0, -4.0, -9.0));
	block[2].s[0].b[1][0] = (vec4(-8.0, 4.0, 6.0, 2.0));
	block[2].s[0].b[1][1] = (vec4(-8.0, 0.0, -3.0, 4.0));
	block[2].s[0].b[2][0] = (vec4(9.0, 6.0, -2.0, 8.0));
	block[2].s[0].b[2][1] = (vec4(-7.0, -6.0, 7.0, 0.0));
	block[2].s[0].b[3][0] = (vec4(7.0, 3.0, 1.0, -5.0));
	block[2].s[0].b[3][1] = (vec4(-5.0, 3.0, -4.0, 8.0));
	block[2].s[0].c = (vec3(1.0, 0.0, 5.0));
	block[2].s[1].a = (uvec2(9u, 0u));
	block[2].s[1].b[0][0] = (vec4(6.0, 9.0, -3.0, 7.0));
	block[2].s[1].b[0][1] = (vec4(-4.0, -2.0, 4.0, 7.0));
	block[2].s[1].b[1][0] = (vec4(6.0, 1.0, 2.0, 6.0));
	block[2].s[1].b[1][1] = (vec4(-3.0, -9.0, 9.0, -1.0));
	block[2].s[1].b[2][0] = (vec4(-8.0, 0.0, 3.0, 9.0));
	block[2].s[1].b[2][1] = (vec4(2.0, 7.0, -5.0, -9.0));
	block[2].s[1].b[3][0] = (vec4(3.0, -8.0, -2.0, 9.0));
	block[2].s[1].b[3][1] = (vec4(-3.0, -3.0, -9.0, 6.0));
	block[2].s[1].c = (vec3(-4.0, 1.0, 6.0));
	block[2].s[2].a = (uvec2(4u, 2u));
	block[2].s[2].b[0][0] = (vec4(8.0, 7.0, 9.0, -8.0));
	block[2].s[2].b[0][1] = (vec4(2.0, -6.0, 3.0, 2.0));
	block[2].s[2].b[1][0] = (vec4(-8.0, 3.0, -5.0, 9.0));
	block[2].s[2].b[1][1] = (vec4(9.0, -3.0, -6.0, -1.0));
	block[2].s[2].b[2][0] = (vec4(9.0, 1.0, -7.0, 9.0));
	block[2].s[2].b[2][1] = (vec4(-1.0, -5.0, -6.0, -9.0));
	block[2].s[2].b[3][0] = (vec4(5.0, 2.0, 5.0, 1.0));
	block[2].s[2].b[3][1] = (vec4(-5.0, 2.0, 2.0, 8.0));
	block[2].s[2].c = (vec3(-9.0, 9.0, 0.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-2.0, 8.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 0.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(1.0, -1.0, -5.0, 4.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-7.0, -3.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block[1].var = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block[2].var = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(2.0, 3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(-6.0, 5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 9.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(2.0, -9.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(2.0, -7.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(4.0, -9.0));
	block[0].var[1] = (vec2(-2.0, 8.0));
	block[0].var[2] = (vec2(-4.0, 4.0));
	block[0].var[3] = (vec2(9.0, 5.0));
	block[1].var[0] = (vec2(-2.0, 4.0));
	block[1].var[1] = (vec2(6.0, -8.0));
	block[1].var[2] = (vec2(-5.0, -1.0));
	block[1].var[3] = (vec2(9.0, 0.0));
	block[2].var[0] = (vec2(5.0, -2.0));
	block[2].var[1] = (vec2(4.0, -5.0));
	block[2].var[2] = (vec2(-2.0, -4.0));
	block[2].var[3] = (vec2(6.0, 4.0));
}
#version 450
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
	i16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std140, buffer_reference) buffer BlockB
{
	mediump ivec2 a;
	highp int b;
	highp ivec4 c;
	highp vec3 d;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec3 e;
	bvec4 f;
	lowp ivec4 g;
	lowp float h;
	highp int i;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp uint j[1];
	highp ivec3 k;
	mediump float l;
	mediump ivec4 m;
};
layout(std140, buffer_reference) buffer BlockE
{
	highp ivec4 n;
	mediump ivec4 o;
	mediump vec4 p[1];
	highp vec2 q;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 9) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(7, -5, 2, -1)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(-8.0, 2.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(false, true, false, false)) && allOk;
	allOk = compare_ivec4((blockC.g), ivec4(2, 2, 6, 1)) && allOk;
	allOk = compare_int((blockC.i), 1) && allOk;
	allOk = compare_uint((blockD.j[0]), 4u) && allOk;
	allOk = compare_float((blockD.l), -1.0) && allOk;
	allOk = compare_ivec4((blockE.n), ivec4(-1, -2, -9, 1)) && allOk;
	allOk = compare_vec4((blockE.p[0]), vec4(-7.0, 6.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec2((blockE.q), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (ivec4(-7, 6, 2, -8));
	blockB.d = (vec3(7.0, 6.0, -4.0));
	blockC.f = (bvec4(true, false, true, true));
	blockC.g = (ivec4(-8, -8, 5, 2));
	blockC.h = (6.0);
	blockC.i = (6);
	blockD.j[0] = (3u);
	blockD.k = (ivec3(7, 6, 3));
	blockD.m = (ivec4(-8, 1, 4, -5));
	blockE.n = (ivec4(0, -7, -1, 7));
	blockE.o = (ivec4(9, 5, -4, -6));
}
#version 450
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
	highp uvec3 a;
	lowp vec2 b;
	lowp uvec4 c;
	highp vec2 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	bool e;
	lowp uvec3 f;
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	mediump uvec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.d), vec2(7.0, 5.0)) && allOk;
	allOk = compare_bool((blockC.e), true) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(7u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(4u, 0u, 2u));
	blockB.b = (vec2(-1.0, 2.0));
	blockB.d = (vec2(5.0, -3.0));
	blockC.e = (true);
}
#version 450
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
	lowp mat3x4 h[6];
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
	blockD.h[1] = (mat3x4(-4.0, -1.0, 6.0, 0.0, -4.0, 9.0, 2.0, 2.0, -7.0, -8.0, -1.0, -2.0));
	blockD.h[2] = (mat3x4(-1.0, -8.0, 1.0, -1.0, 3.0, 9.0, -2.0, 2.0, 0.0, 2.0, -3.0, -5.0));
	blockD.h[3] = (mat3x4(4.0, -3.0, 6.0, -7.0, -6.0, -5.0, -1.0, -3.0, -5.0, 6.0, -3.0, -6.0));
	blockD.h[4] = (mat3x4(-2.0, -3.0, 8.0, 1.0, 0.0, -8.0, -6.0, 6.0, -2.0, 1.0, -3.0, -6.0));
	blockD.h[5] = (mat3x4(-9.0, -8.0, -6.0, -6.0, 6.0, 9.0, -6.0, -2.0, 8.0, 5.0, -1.0, 3.0));
}
#version 450
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
	mediump vec3 b;
	lowp mat4x3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat4 d;
	highp uvec3 e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec3 f;
	highp uvec2 g;
	highp mat2 h;
	lowp uvec3 i;
	highp int j[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	bvec3 k[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(blockC.d, mat4(-8.0, -7.0, 9.0, 9.0, -7.0, -8.0, 4.0, 3.0, -8.0, 9.0, -8.0, -7.0, -2.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockD.f), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(9u, 1u)) && allOk;
	allOk = compare_mat2(blockD.h, mat2(2.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockD.i), uvec3(0u, 9u, 4u)) && allOk;
	allOk = compare_int((blockD.j[0]), -8) && allOk;
	allOk = compare_int((blockD.j[1]), 9) && allOk;
	allOk = compare_int((blockD.j[2]), -3) && allOk;
	allOk = compare_int((blockD.j[3]), -3) && allOk;
	allOk = compare_int((blockD.j[4]), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-1.0, -4.0, 2.0, -1.0));
	blockB.b = (vec3(2.0, 2.0, -5.0));
	blockB.c[0] = (mat4x3(7.0, -5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0));
	blockB.c[1] = (mat4x3(3.0, -2.0, 9.0, -6.0, 3.0, 5.0, 5.0, 9.0, 3.0, -9.0, -1.0, -5.0));
	blockB.c[2] = (mat4x3(-8.0, 3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0, 6.0, 9.0, 9.0));
	blockB.c[3] = (mat4x3(-1.0, -2.0, 8.0, 7.0, -5.0, -2.0, -3.0, -4.0, 3.0, 1.0, -2.0, -3.0));
	blockB.c[4] = (mat4x3(-9.0, 9.0, -1.0, -3.0, -4.0, -3.0, 1.0, 0.0, -5.0, 8.0, -3.0, 8.0));
	blockB.c[5] = (mat4x3(5.0, 0.0, 1.0, 2.0, 6.0, 8.0, 2.0, -3.0, -3.0, -6.0, -5.0, 3.0));
	blockB.c[6] = (mat4x3(3.0, 0.0, -4.0, -9.0, 0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0, -9.0));
	blockB.c[7] = (mat4x3(4.0, -4.0, -1.0, 6.0, -7.0, -1.0, -7.0, 7.0, -5.0, 1.0, -4.0, 8.0));
	blockC.d = (mat4(4.0, -7.0, -8.0, 6.0, -8.0, 6.0, -9.0, 0.0, -6.0, -3.0, -5.0, 3.0, 5.0, -5.0, 7.0, 0.0));
	blockC.e[0] = (uvec3(0u, 3u, 7u));
	blockD.f = (bvec3(true, true, true));
	blockD.g = (uvec2(3u, 8u));
	blockD.h = (mat2(-4.0, 2.0, 0.0, -8.0));
	blockD.j[0] = (7);
	blockD.j[1] = (5);
	blockD.j[2] = (1);
	blockD.j[3] = (-5);
	blockD.j[4] = (0);
	blockE.k[0] = (bvec3(false, true, true));
	blockE.k[1] = (bvec3(false, true, true));
	blockE.k[2] = (bvec3(false, false, false));
	blockE.k[3] = (bvec3(true, true, true));
	blockE.k[4] = (bvec3(false, false, true));
	blockE.k[5] = (bvec3(true, false, false));
	blockE.k[6] = (bvec3(true, false, false));
	blockE.k[7] = (bvec3(true, false, false));
}
#version 450
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
	lowp mat4x3 a;
	lowp mat2x3 b;
	mediump float c;
	bvec3 d;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump uint e;
	highp mat3x2 f[];
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b, mat2x3(-6.0, 1.0, 8.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_float((blockB.c), 5.0) && allOk;
	allOk = compare_mat3x2(blockC.f[0], mat3x2(2.0, 3.0, -7.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[1], mat3x2(1.0, 1.0, 3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[2], mat3x2(6.0, -4.0, 6.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[3], mat3x2(-9.0, -5.0, -1.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[4], mat3x2(-8.0, 5.0, -1.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[5], mat3x2(-7.0, 7.0, 6.0, 7.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(8.0, -2.0, -1.0, -6.0, 6.0, 0.0, 9.0, 5.0, 4.0, 8.0, 6.0, 7.0));
	blockB.c = (0.0);
	blockC.e = (6u);
	blockC.f[0] = (mat3x2(-7.0, -6.0, -2.0, -4.0, 8.0, -6.0));
	blockC.f[1] = (mat3x2(-4.0, 6.0, -3.0, -6.0, 8.0, -6.0));
	blockC.f[2] = (mat3x2(-7.0, -1.0, 4.0, -7.0, 2.0, -1.0));
	blockC.f[3] = (mat3x2(4.0, -6.0, 5.0, -5.0, -1.0, -2.0));
	blockC.f[4] = (mat3x2(-3.0, -7.0, 8.0, -6.0, 7.0, 9.0));
	blockC.f[5] = (mat3x2(8.0, -3.0, -4.0, 4.0, 9.0, 0.0));
}
#version 450
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
	highp vec2 b;
	lowp mat2 c;
	mediump mat4x2 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec4 e[7];
	lowp uvec4 f;
	highp vec3 g;
	highp int h;
	bool i[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp mat3 j;
	lowp ivec2 k;
	highp uvec3 l;
	highp vec3 m[];
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump float n[1];
	lowp mat4x2 o[7];
	lowp mat2 p;
	lowp mat4x2 q[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.c, mat2(0.0, -3.0, 9.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockC.e[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.e[2]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[3]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[4]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.e[5]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[6]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(1u, 2u, 9u, 6u)) && allOk;
	allOk = compare_bool((blockC.i[0]), false) && allOk;
	allOk = compare_bool((blockC.i[1]), false) && allOk;
	allOk = compare_bool((blockC.i[2]), true) && allOk;
	allOk = compare_bool((blockC.i[3]), false) && allOk;
	allOk = compare_bool((blockC.i[4]), false) && allOk;
	allOk = compare_bool((blockC.i[5]), true) && allOk;
	allOk = compare_bool((blockC.i[6]), true) && allOk;
	allOk = compare_bool((blockC.i[7]), true) && allOk;
	allOk = compare_ivec2((blockD.k), ivec2(-8, -5)) && allOk;
	allOk = compare_uvec3((blockD.l), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_float((blockE.n[0]), -8.0) && allOk;
	allOk = compare_mat2(blockE.p, mat2(-8.0, 9.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[0], mat4x2(0.0, -1.0, 4.0, 1.0, 9.0, 7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[1], mat4x2(-7.0, 7.0, -8.0, -8.0, -6.0, 0.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[2], mat4x2(-8.0, -5.0, -6.0, 7.0, 1.0, -5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[3], mat4x2(4.0, -4.0, 0.0, -6.0, 0.0, 6.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[4], mat4x2(0.0, -2.0, -8.0, -4.0, 1.0, 6.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[5], mat4x2(7.0, -4.0, -9.0, -6.0, 0.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[6], mat4x2(7.0, 7.0, 1.0, 3.0, 4.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockE.q[7], mat4x2(4.0, -2.0, -4.0, 4.0, 7.0, -2.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat2(-9.0, 1.0, 2.0, 8.0));
	blockC.e[0] = (bvec4(false, false, false, false));
	blockC.e[1] = (bvec4(false, false, true, true));
	blockC.e[2] = (bvec4(true, false, true, false));
	blockC.e[3] = (bvec4(false, false, false, false));
	blockC.e[4] = (bvec4(false, false, true, true));
	blockC.e[5] = (bvec4(true, true, true, false));
	blockC.e[6] = (bvec4(true, true, false, false));
	blockC.f = (uvec4(1u, 4u, 3u, 6u));
	blockC.g = (vec3(-8.0, 1.0, 6.0));
	blockC.h = (6);
	blockD.k = (ivec2(3, -8));
	blockD.l = (uvec3(7u, 3u, 3u));
	blockE.n[0] = (-9.0);
	blockE.o[0] = (mat4x2(8.0, -6.0, -3.0, 9.0, 3.0, -7.0, 0.0, -4.0));
	blockE.o[1] = (mat4x2(-3.0, -9.0, -1.0, -8.0, -1.0, 4.0, 5.0, -4.0));
	blockE.o[2] = (mat4x2(2.0, 2.0, 1.0, -3.0, 4.0, 0.0, -8.0, 4.0));
	blockE.o[3] = (mat4x2(-1.0, -4.0, -7.0, 3.0, 5.0, -1.0, -2.0, -4.0));
	blockE.o[4] = (mat4x2(9.0, -2.0, -5.0, 8.0, -7.0, -8.0, -4.0, 4.0));
	blockE.o[5] = (mat4x2(-9.0, -8.0, -1.0, -4.0, 2.0, 4.0, -7.0, -2.0));
	blockE.o[6] = (mat4x2(-9.0, 9.0, -3.0, 0.0, -5.0, 3.0, 0.0, -5.0));
	blockE.p = (mat2(-7.0, 0.0, 7.0, -1.0));
	blockE.q[0] = (mat4x2(-5.0, 5.0, 0.0, -4.0, 1.0, 7.0, 2.0, 4.0));
	blockE.q[1] = (mat4x2(-9.0, 6.0, -5.0, -5.0, -7.0, -9.0, -4.0, -9.0));
	blockE.q[2] = (mat4x2(6.0, 8.0, -6.0, -9.0, 5.0, 8.0, 6.0, -9.0));
	blockE.q[3] = (mat4x2(1.0, -8.0, -6.0, 3.0, 9.0, 0.0, 5.0, 2.0));
	blockE.q[4] = (mat4x2(4.0, -2.0, 0.0, 1.0, 3.0, 3.0, -3.0, -5.0));
	blockE.q[5] = (mat4x2(2.0, -3.0, 5.0, 7.0, -5.0, 7.0, -9.0, 7.0));
	blockE.q[6] = (mat4x2(-1.0, 4.0, 9.0, 4.0, -6.0, 8.0, -4.0, 7.0));
	blockE.q[7] = (mat4x2(-2.0, -8.0, -5.0, 4.0, -2.0, 2.0, 3.0, 6.0));
}
#version 450
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
	bvec4 a[1];
	lowp ivec2 b;
	highp ivec2 c;
	highp ivec4 d;
	highp vec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp uvec3 a;
	mediump mat4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.b[0], mat4(9.0, -9.0, -1.0, -9.0, 1.0, -8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.b[1], mat4(2.0, 0.0, 1.0, 6.0, -5.0, 2.0, 7.0, -5.0, 4.0, -7.0, 0.0, -9.0, -3.0, -2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.b[2], mat4(-3.0, 1.0, 8.0, -5.0, 8.0, 8.0, 9.0, 6.0, -2.0, -4.0, 1.0, 6.0, -4.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.b[3], mat4(-9.0, -5.0, 5.0, -5.0, -4.0, -6.0, -4.0, 8.0, 9.0, -8.0, 2.0, 9.0, 1.0, 6.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.b[4], mat4(-6.0, -4.0, -1.0, 7.0, -9.0, -1.0, 5.0, 3.0, 9.0, -4.0, -3.0, -7.0, 9.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.b[5], mat4(-1.0, 8.0, -4.0, 1.0, 8.0, 4.0, 2.0, 1.0, 3.0, 5.0, -4.0, 7.0, 0.0, -7.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.b[6], mat4(3.0, -2.0, -4.0, -5.0, 6.0, -6.0, 5.0, -4.0, -6.0, -8.0, -5.0, 2.0, -5.0, 7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB.b[7], mat4(8.0, 1.0, -8.0, -4.0, -4.0, -4.0, 5.0, -7.0, -4.0, -1.0, 6.0, -1.0, 1.0, 4.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(1u, 5u, 5u));
	blockB.b[0] = (mat4(-5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0, 3.0, 2.0, -7.0, 1.0));
	blockB.b[1] = (mat4(3.0, 2.0, -7.0, 4.0, 9.0, -8.0, -1.0, 3.0, -1.0, 4.0, 1.0, -8.0, -8.0, -1.0, -5.0, 7.0));
	blockB.b[2] = (mat4(-5.0, -3.0, -8.0, 6.0, -4.0, -9.0, 8.0, -8.0, -5.0, 1.0, 4.0, 3.0, -9.0, -3.0, 8.0, 5.0));
	blockB.b[3] = (mat4(8.0, 1.0, 8.0, 9.0, 2.0, 7.0, -2.0, -9.0, -9.0, 7.0, 3.0, -9.0, 1.0, -8.0, -6.0, -7.0));
	blockB.b[4] = (mat4(3.0, -6.0, 6.0, 6.0, 0.0, -2.0, 8.0, -8.0, -9.0, -9.0, -7.0, 9.0, -7.0, -8.0, 7.0, 4.0));
	blockB.b[5] = (mat4(-4.0, 4.0, -1.0, 7.0, -1.0, 4.0, -8.0, -7.0, -7.0, 1.0, 4.0, -1.0, -7.0, 1.0, 2.0, -3.0));
	blockB.b[6] = (mat4(-4.0, -6.0, -3.0, 1.0, 8.0, 2.0, 1.0, -9.0, 9.0, -5.0, 1.0, 6.0, -9.0, 5.0, -2.0, -5.0));
	blockB.b[7] = (mat4(-8.0, 4.0, 7.0, 4.0, 5.0, 5.0, -9.0, 3.0, 3.0, -7.0, 9.0, 5.0, 3.0, 3.0, -7.0, 2.0));
}
#version 450
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
	layout(offset = 16) highp uvec4 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec2 c;
	layout(offset = 16) mediump vec3 d;
	layout(offset = 32) lowp ivec3 e;
	layout(offset = 48) lowp vec2 f[1];
	layout(offset = 64) lowp vec3 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uint h;
	layout(offset = 16) highp ivec4 i;
	layout(offset = 32) lowp ivec3 j;
	layout(offset = 44) highp uint k;
	layout(offset = 48) mediump ivec2 l;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump ivec4 m;
	layout(offset = 16) lowp ivec2 n;
	layout(offset = 32) mediump vec3 o[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, true, true, false)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(1.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec2((blockC.f[0]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockD[0].i), ivec4(3, -7, -8, 9)) && allOk;
	allOk = compare_ivec2((blockD[0].l), ivec2(6, -3)) && allOk;
	allOk = compare_ivec4((blockD[1].i), ivec4(6, -4, 6, 7)) && allOk;
	allOk = compare_ivec2((blockD[1].l), ivec2(-1, -8)) && allOk;
	allOk = compare_ivec4((blockE[0].m), ivec4(9, 7, -8, 5)) && allOk;
	allOk = compare_ivec2((blockE[0].n), ivec2(-1, 1)) && allOk;
	allOk = compare_vec3((blockE[0].o[0]), vec3(7.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, false, false));
	blockB[0].b = (uvec4(3u, 8u, 3u, 7u));
	blockC.c = (ivec2(6, 7));
	blockC.e = (ivec3(7, 4, 7));
	blockC.f[0] = (vec2(0.0, 9.0));
	blockC.g = (vec3(-4.0, -5.0, 4.0));
	blockD[0].h = (6u);
	blockD[0].i = (ivec4(-7, -6, -2, -4));
	blockD[0].j = (ivec3(8, -6, -4));
	blockD[0].k = (6u);
	blockD[0].l = (ivec2(-3, -6));
	blockD[1].h = (3u);
	blockD[1].i = (ivec4(-6, -7, -1, 4));
	blockD[1].j = (ivec3(-7, 2, -1));
	blockD[1].k = (1u);
	blockD[1].l = (ivec2(-6, 5));
	blockE[0].m = (ivec4(-5, -1, -2, -3));
	blockE[0].n = (ivec2(-7, 8));
	blockE[0].o[0] = (vec3(-6.0, 7.0, 9.0));
}
#version 450
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
	mediump mat2x3 a[8];
	bvec4 b;
	lowp mat4x3 c;
	lowp float d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp mat4x3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(false, true, false, false)) && allOk;
	allOk = compare_float((blockB.d[0]), 8.0) && allOk;
	allOk = compare_float((blockB.d[1]), 5.0) && allOk;
	allOk = compare_float((blockB.d[2]), -4.0) && allOk;
	allOk = compare_float((blockB.d[3]), -1.0) && allOk;
	allOk = compare_float((blockB.d[4]), -8.0) && allOk;
	allOk = compare_mat4x3(blockC[0].e[0], mat4x3(4.0, -7.0, 1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[1], mat4x3(6.0, -6.0, 8.0, 2.0, -5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[0], mat4x3(8.0, -5.0, 3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[1], mat4x3(-3.0, 9.0, -7.0, -5.0, -7.0, 0.0, -2.0, 3.0, 2.0, -6.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[0], mat4x3(6.0, -3.0, 1.0, -6.0, 5.0, -1.0, -2.0, -6.0, -9.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[1], mat4x3(1.0, 6.0, 1.0, 6.0, -8.0, 5.0, -6.0, 2.0, -9.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[2], mat4x3(2.0, -7.0, 1.0, -1.0, 6.0, -6.0, 4.0, 6.0, 2.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[3], mat4x3(9.0, 0.0, -6.0, -4.0, -3.0, 2.0, 7.0, -4.0, -5.0, -9.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, true, true, true));
	blockB.c = (mat4x3(-7.0, 0.0, -2.0, -2.0, 7.0, -9.0, -8.0, 3.0, 5.0, 5.0, -1.0, 7.0));
	blockB.d[0] = (-1.0);
	blockB.d[1] = (-8.0);
	blockB.d[2] = (0.0);
	blockB.d[3] = (-8.0);
	blockB.d[4] = (4.0);
	blockC[0].e[0] = (mat4x3(-3.0, -4.0, 9.0, -9.0, -8.0, 8.0, 1.0, 2.0, -6.0, 8.0, -9.0, 7.0));
	blockC[0].e[1] = (mat4x3(-1.0, 3.0, -8.0, 3.0, 9.0, 6.0, -4.0, 0.0, -9.0, 3.0, 5.0, 0.0));
	blockC[1].e[0] = (mat4x3(-7.0, 1.0, 0.0, 0.0, -4.0, 5.0, -3.0, 2.0, 1.0, 8.0, -6.0, 2.0));
	blockC[1].e[1] = (mat4x3(-5.0, 6.0, 2.0, 0.0, -4.0, 7.0, -3.0, 3.0, -9.0, 4.0, 8.0, 3.0));
	blockC[2].e[0] = (mat4x3(-6.0, -5.0, 9.0, -6.0, -9.0, -2.0, -4.0, -9.0, -8.0, 6.0, 3.0, -1.0));
	blockC[2].e[1] = (mat4x3(-7.0, 7.0, -1.0, 0.0, 5.0, 5.0, 2.0, -5.0, -6.0, 6.0, -4.0, -9.0));
	blockC[2].e[2] = (mat4x3(5.0, 7.0, -4.0, -2.0, 5.0, 4.0, 2.0, 9.0, -5.0, 6.0, 2.0, -1.0));
	blockC[2].e[3] = (mat4x3(3.0, -4.0, -9.0, 9.0, -8.0, 1.0, -2.0, -8.0, 3.0, 4.0, 6.0, 7.0));
}
#version 450
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
	highp ivec4 a;
	u16vec2 b;
	f16vec4 c;
	f16vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(5.0, -7.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-5, 9, 5, 5));
}
#version 450
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
	mediump uvec3 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

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
	mediump mat4x3 mA;
	mediump float mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	bvec2 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump ivec2 c;
	bool d;
	uint16_t e;
	lowp mat3 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	f16vec2 g;
	float16_t h;
	mediump ivec2 i;
	highp mat4x2 j;
	i16vec4 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b[0]), bvec2(true, true)) && allOk;
	allOk = compare_ivec2((blockC.c), ivec2(8, -7)) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
	allOk = compare_float16_t(float(blockD.h), -2.0) && allOk;
	allOk = compare_mat4x2(blockD.j, mat4x2(4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat4x3(8.0, 0.0, 4.0, 7.0, 5.0, 7.0, -2.0, 9.0, -1.0, 6.0, -5.0, 6.0));
	blockB.a.mB = (5.0);
	blockC.d = (true);
	blockC.f[0] = (mat3(-2.0, -8.0, 4.0, 3.0, 6.0, 6.0, 0.0, -7.0, -2.0));
	blockD.g = f16vec2(vec2(-5.0, 3.0));
	blockD.i = (ivec2(9, -2));
}
#version 450
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
	highp mat3x4 a;
	f16vec2 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp ivec4 c;
	bvec2 d;
	highp mat4 e;
	mediump uvec3 f;
	bvec4 g[5];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.b[0]), vec2(-2.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b[1]), vec2(3.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b[2]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b[3]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b[4]), vec2(8.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b[5]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(-8, 9, -9, 8)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(false, false)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(7u, 2u, 2u)) && allOk;
	allOk = compare_bvec4((blockC.g[0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.g[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.g[2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.g[3]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.g[4]), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (ivec4(5, 5, 9, 3));
	blockC.d = (bvec2(true, true));
	blockC.e = (mat4(3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0, -5.0));
	blockC.g[0] = (bvec4(true, true, false, false));
	blockC.g[1] = (bvec4(false, true, true, true));
	blockC.g[2] = (bvec4(true, false, false, false));
	blockC.g[3] = (bvec4(true, true, true, true));
	blockC.g[4] = (bvec4(true, true, false, false));
}
#version 450
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
	mediump vec3 mA;
};
struct sB
{
	sA mA;
	float16_t mB;
	bool mC;
	i16vec2 mD;
};
struct sC
{
	mediump float mA;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp int a;
	bool b;
	lowp mat3 c;
	mediump vec4 d;
	lowp ivec3 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump vec3 f;
	lowp uvec3 g;
	sB h;
	mediump ivec2 i[][3];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	sC j[6];
	uint16_t k;
	u16vec3 l;
	highp int m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].b), false) && allOk;
	allOk = compare_bool((blockB[1].b), true) && allOk;
	allOk = compare_bool((blockB[2].b), false) && allOk;
	allOk = compare_vec3((blockC.h.mA.mA), vec3(7.0, -1.0, 8.0)) && allOk;
	allOk = compare_float16_t(float(blockC.h.mB), -6.0) && allOk;
	allOk = compare_bool((blockC.h.mC), false) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.h.mD), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((blockC.i[0][0]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockC.i[0][1]), ivec2(-8, -2)) && allOk;
	allOk = compare_ivec2((blockC.i[0][2]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((blockC.i[1][0]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((blockC.i[1][1]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((blockC.i[1][2]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((blockC.i[2][0]), ivec2(-3, 5)) && allOk;
	allOk = compare_ivec2((blockC.i[2][1]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((blockC.i[2][2]), ivec2(-9, 6)) && allOk;
	allOk = compare_float((blockD.j[0].mA), -8.0) && allOk;
	allOk = compare_float((blockD.j[1].mA), 5.0) && allOk;
	allOk = compare_float((blockD.j[2].mA), -6.0) && allOk;
	allOk = compare_float((blockD.j[3].mA), -6.0) && allOk;
	allOk = compare_float((blockD.j[4].mA), -2.0) && allOk;
	allOk = compare_float((blockD.j[5].mA), -9.0) && allOk;
	allOk = compare_uint16_t(uint(blockD.k), 9u) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l), uvec3(1u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (false);
	blockB[0].d = (vec4(5.0, -1.0, -9.0, -4.0));
	blockB[1].b = (false);
	blockB[1].d = (vec4(1.0, 6.0, 7.0, -7.0));
	blockB[2].b = (false);
	blockB[2].d = (vec4(6.0, -8.0, -8.0, 8.0));
	blockC.f = (vec3(-6.0, -9.0, -7.0));
	blockC.h.mA.mA = (vec3(-7.0, -5.0, 6.0));
	blockC.h.mB = float16_t(-1.0);
	blockC.h.mC = (false);
	blockC.h.mD = i16vec2(ivec2(5, -9));
	blockD.k = uint16_t(9u);
}
#version 450
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
	u16vec4 a;
	uint16_t b;
	highp mat4x2 c;
	lowp int d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(0)].a), uvec4(2u, 5u, 0u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(0)].b), 4u) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(0)].d), -6) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(1)].a), uvec4(6u, 4u, 6u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(1)].b), 8u) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].d), -2) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(2)].a), uvec4(8u, 5u, 2u, 5u)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(2)].b), 5u) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(2)].d), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u16vec4(uvec4(6u, 1u, 1u, 0u));
	blockB[nonuniformEXT(0)].b = uint16_t(9u);
	blockB[nonuniformEXT(0)].d = (-8);
	blockB[nonuniformEXT(1)].a = u16vec4(uvec4(5u, 1u, 4u, 9u));
	blockB[nonuniformEXT(1)].b = uint16_t(3u);
	blockB[nonuniformEXT(1)].d = (-4);
	blockB[nonuniformEXT(2)].a = u16vec4(uvec4(4u, 4u, 7u, 2u));
	blockB[nonuniformEXT(2)].b = uint16_t(4u);
	blockB[nonuniformEXT(2)].d = (3);
}
#version 450
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
	uint8_t a;
	highp uint b;
	mediump int c;
	mediump float d[1];
	uint8_t e;
};
layout(std140, buffer_reference) buffer BlockC
{
	int8_t f;
	uint8_t g;
	bool h;
	int8_t i;
};
layout(std140, buffer_reference) buffer BlockD
{
	uint8_t j;
	uint8_t k;
	uint8_t l;
	bool m;
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump int n;
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
	allOk = compare_float((blockB.d[0]), -7.0) && allOk;
	allOk = compare_int8_t(int(blockC.f), 5) && allOk;
	allOk = compare_uint8_t(uint(blockC.g), 4u) && allOk;
	allOk = compare_bool((blockC.h), true) && allOk;
	allOk = compare_uint8_t(uint(blockD.j), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockD.k), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockD.l), 4u) && allOk;
	allOk = compare_bool((blockD.m), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(2u);
	blockB.b = (0u);
	blockB.c = (-5);
	blockB.d[0] = (-9.0);
	blockB.e = uint8_t(4u);
	blockC.g = uint8_t(2u);
	blockC.i = int8_t(7);
	blockD.k = uint8_t(9u);
	blockD.m = (true);
	blockE.n = (-3);
}
#version 450
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
	i8vec4 a;
	i8vec2 b;
	mediump uvec3 c;
	u8vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.b = i8vec2(ivec2(6, 0));
	blockB.c = (uvec3(3u, 8u, 3u));
}
#version 450
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
	lowp mat4x3 a;
	lowp int b;
	highp mat2x3 c;
	u8vec3 d;
	mediump mat2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.c, mat2x3(-6.0, 9.0, 8.0, 3.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (2);
	blockB.d = u8vec3(uvec3(0u, 5u, 8u));
}
#version 450
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
	highp vec4 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp vec4 b;
	mediump mat2x3 c;
	i8vec2 d;
	mediump mat3x4 e;
	bool f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump mat4x3 g[2][3];
	bool h;
	u8vec4 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockC.d), ivec2(4, 4294967288)) && allOk;
	allOk = compare_bool((blockC.f[0]), true) && allOk;
	allOk = compare_bool((blockC.f[1]), false) && allOk;
	allOk = compare_bool((blockC.f[2]), false) && allOk;
	allOk = compare_bool((blockC.f[3]), true) && allOk;
	allOk = compare_bool((blockC.f[4]), true) && allOk;
	allOk = compare_bool((blockD[0].h), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec4(1.0, -6.0, -2.0, 5.0));
	blockB.a[1] = (vec4(1.0, -6.0, -5.0, -1.0));
	blockB.a[2] = (vec4(4.0, -7.0, -3.0, -5.0));
	blockC.b = (vec4(7.0, -3.0, -4.0, 3.0));
	blockC.d = i8vec2(ivec2(4294967295, 2));
	blockD[0].g[0][0] = (mat4x3(-1.0, -1.0, -1.0, 9.0, 1.0, 1.0, -3.0, -5.0, 0.0, -3.0, -2.0, 8.0));
	blockD[0].g[0][1] = (mat4x3(3.0, 7.0, -4.0, -2.0, -4.0, -8.0, 5.0, -6.0, 8.0, 6.0, 4.0, 6.0));
	blockD[0].g[0][2] = (mat4x3(-4.0, -6.0, 3.0, 1.0, 7.0, 7.0, 9.0, 0.0, 3.0, -3.0, 4.0, -1.0));
	blockD[0].g[1][0] = (mat4x3(6.0, -2.0, 5.0, -6.0, -8.0, -5.0, 0.0, 4.0, 3.0, -1.0, 9.0, -6.0));
	blockD[0].g[1][1] = (mat4x3(-4.0, 3.0, -3.0, -1.0, 6.0, -6.0, -4.0, 3.0, 2.0, 9.0, 5.0, 2.0));
	blockD[0].g[1][2] = (mat4x3(-3.0, -7.0, 3.0, 0.0, 7.0, -4.0, 4.0, -4.0, 3.0, -4.0, -1.0, 0.0));
	blockD[0].h = (false);
}
#version 450
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
	lowp mat4x2 mB;
	lowp uvec4 mC;
	bvec3 mD[8];
};
struct sB
{
	highp vec3 mA;
	highp ivec2 mB[6];
};
struct sC
{
	lowp uvec4 mA;
};
struct sD
{
	lowp vec3 mA;
	mediump uvec4 mB;
	sC mC;
};
struct sE
{
	u8vec3 mA[4];
	i8vec3 mB;
	lowp uvec2 mC;
	mediump mat3x2 mD;
};
struct sF
{
	sE mA;
	mediump uvec3 mB[1];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	sB b;
	lowp mat3 c;
	lowp mat2x3 d;
	u8vec4 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	sD f;
	sF g;
	mediump vec2 h;
	highp ivec3 i;
	uint8_t j[];
};
layout(scalar, buffer_reference) readonly buffer BlockE
{
	bool k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockC[0].c, mat3(-5.0, -7.0, -2.0, -6.0, -6.0, 0.0, 4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC[1].c, mat3(-2.0, -8.0, -4.0, 4.0, -1.0, 1.0, 4.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD.f.mA), vec3(9.0, -6.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockD.f.mB), uvec4(0u, 0u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((blockD.f.mC.mA), uvec4(9u, 8u, 7u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g.mA.mA[0]), uvec3(8u, 4u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g.mA.mA[1]), uvec3(9u, 4u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g.mA.mA[2]), uvec3(8u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g.mA.mA[3]), uvec3(4u, 5u, 1u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.g.mA.mB), ivec3(6, 4294967292, 9)) && allOk;
	allOk = compare_uvec2((blockD.g.mA.mC), uvec2(5u, 6u)) && allOk;
	allOk = compare_mat3x2(blockD.g.mA.mD, mat3x2(2.0, 1.0, -5.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockD.g.mB[0]), uvec3(6u, 5u, 9u)) && allOk;
	allOk = compare_vec2((blockD.h), vec2(0.0, 5.0)) && allOk;
	allOk = compare_bool((blockE[0].k[0]), true) && allOk;
	allOk = compare_bool((blockE[0].k[1]), true) && allOk;
	allOk = compare_bool((blockE[0].k[2]), true) && allOk;
	allOk = compare_bool((blockE[0].k[3]), true) && allOk;
	allOk = compare_bool((blockE[0].k[4]), false) && allOk;
	allOk = compare_bool((blockE[0].k[5]), false) && allOk;
	allOk = compare_bool((blockE[1].k[0]), false) && allOk;
	allOk = compare_bool((blockE[1].k[1]), false) && allOk;
	allOk = compare_bool((blockE[1].k[2]), false) && allOk;
	allOk = compare_bool((blockE[1].k[3]), true) && allOk;
	allOk = compare_bool((blockE[1].k[4]), false) && allOk;
	allOk = compare_bool((blockE[1].k[5]), false) && allOk;
	allOk = compare_bool((blockE[1].k[6]), false) && allOk;
	allOk = compare_bool((blockE[1].k[7]), false) && allOk;
	allOk = compare_bool((blockE[2].k[0]), false) && allOk;
	allOk = compare_bool((blockE[2].k[1]), true) && allOk;
	allOk = compare_bool((blockE[2].k[2]), true) && allOk;
	allOk = compare_bool((blockE[2].k[3]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (mat4x2(-4.0, -5.0, -1.0, 2.0, -9.0, 1.0, -6.0, -5.0));
	blockB.a[0].mB = (mat4x2(-1.0, 7.0, 0.0, 0.0, -6.0, 6.0, -1.0, 2.0));
	blockB.a[0].mC = (uvec4(6u, 0u, 7u, 4u));
	blockB.a[0].mD[0] = (bvec3(true, true, true));
	blockB.a[0].mD[1] = (bvec3(true, false, false));
	blockB.a[0].mD[2] = (bvec3(true, false, true));
	blockB.a[0].mD[3] = (bvec3(true, true, true));
	blockB.a[0].mD[4] = (bvec3(true, false, true));
	blockB.a[0].mD[5] = (bvec3(false, true, false));
	blockB.a[0].mD[6] = (bvec3(false, false, false));
	blockB.a[0].mD[7] = (bvec3(true, false, false));
	blockB.a[1].mA = (mat4x2(-6.0, 3.0, -9.0, -5.0, 0.0, 0.0, -1.0, -3.0));
	blockB.a[1].mB = (mat4x2(4.0, 1.0, 6.0, -4.0, -9.0, 6.0, 2.0, 4.0));
	blockB.a[1].mC = (uvec4(2u, 4u, 2u, 7u));
	blockB.a[1].mD[0] = (bvec3(false, true, true));
	blockB.a[1].mD[1] = (bvec3(true, false, false));
	blockB.a[1].mD[2] = (bvec3(false, false, true));
	blockB.a[1].mD[3] = (bvec3(true, true, true));
	blockB.a[1].mD[4] = (bvec3(true, true, false));
	blockB.a[1].mD[5] = (bvec3(false, true, false));
	blockB.a[1].mD[6] = (bvec3(true, false, false));
	blockB.a[1].mD[7] = (bvec3(false, false, false));
	blockB.a[2].mA = (mat4x2(0.0, 8.0, 6.0, -1.0, -1.0, -5.0, -7.0, 8.0));
	blockB.a[2].mB = (mat4x2(7.0, 7.0, 7.0, -7.0, -2.0, 0.0, -1.0, 9.0));
	blockB.a[2].mC = (uvec4(6u, 2u, 1u, 8u));
	blockB.a[2].mD[0] = (bvec3(true, true, true));
	blockB.a[2].mD[1] = (bvec3(true, true, true));
	blockB.a[2].mD[2] = (bvec3(false, true, true));
	blockB.a[2].mD[3] = (bvec3(true, true, false));
	blockB.a[2].mD[4] = (bvec3(false, true, false));
	blockB.a[2].mD[5] = (bvec3(false, true, false));
	blockB.a[2].mD[6] = (bvec3(true, false, false));
	blockB.a[2].mD[7] = (bvec3(true, true, false));
	blockC[0].b.mA = (vec3(-4.0, 9.0, -9.0));
	blockC[0].b.mB[0] = (ivec2(-7, 0));
	blockC[0].b.mB[1] = (ivec2(-5, -9));
	blockC[0].b.mB[2] = (ivec2(3, -7));
	blockC[0].b.mB[3] = (ivec2(-7, -9));
	blockC[0].b.mB[4] = (ivec2(9, 0));
	blockC[0].b.mB[5] = (ivec2(6, 2));
	blockC[0].c = (mat3(-7.0, 5.0, 1.0, -1.0, -8.0, 8.0, 4.0, -8.0, -1.0));
	blockC[0].d = (mat2x3(-2.0, 6.0, 1.0, -7.0, 1.0, -3.0));
	blockC[0].e[0] = u8vec4(uvec4(1u, 9u, 2u, 5u));
	blockC[0].e[1] = u8vec4(uvec4(6u, 5u, 6u, 6u));
	blockC[0].e[2] = u8vec4(uvec4(5u, 1u, 7u, 5u));
	blockC[0].e[3] = u8vec4(uvec4(9u, 4u, 8u, 8u));
	blockC[0].e[4] = u8vec4(uvec4(8u, 7u, 4u, 3u));
	blockC[1].b.mA = (vec3(2.0, -4.0, 8.0));
	blockC[1].b.mB[0] = (ivec2(-3, -9));
	blockC[1].b.mB[1] = (ivec2(-4, 4));
	blockC[1].b.mB[2] = (ivec2(6, 5));
	blockC[1].b.mB[3] = (ivec2(-3, -8));
	blockC[1].b.mB[4] = (ivec2(1, -7));
	blockC[1].b.mB[5] = (ivec2(7, -6));
	blockC[1].c = (mat3(0.0, 8.0, -3.0, -8.0, 0.0, -8.0, 6.0, 3.0, 2.0));
	blockC[1].d = (mat2x3(2.0, 5.0, -7.0, -4.0, -2.0, 4.0));
	blockC[1].e[0] = u8vec4(uvec4(1u, 7u, 4u, 0u));
	blockC[1].e[1] = u8vec4(uvec4(5u, 5u, 9u, 8u));
	blockC[1].e[2] = u8vec4(uvec4(4u, 3u, 7u, 7u));
	blockC[1].e[3] = u8vec4(uvec4(4u, 1u, 6u, 5u));
	blockC[1].e[4] = u8vec4(uvec4(5u, 9u, 3u, 6u));
	blockD.h = (vec2(-3.0, 6.0));
	blockD.i = (ivec3(-5, 4, 7));
	blockD.j[0] = uint8_t(1u);
	blockD.j[1] = uint8_t(5u);
}
