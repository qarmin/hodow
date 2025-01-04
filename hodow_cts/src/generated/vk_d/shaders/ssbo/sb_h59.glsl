#version 450
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
	allOk = compare_mat2(var, mat2(-6.0, -3.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-2.0, -9.0));
	var[1] = (vec2(5.0, 8.0));
}
#version 450
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

	var = (mat4(-9.0, 1.0, 7.0, 9.0, -7.0, 2.0, -9.0, -7.0, 1.0, 9.0, 5.0, 4.0, -3.0, 0.0, 6.0, 0.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-2.0, 1.0, 8.0, 4.0, 9.0, -4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(4.0, 7.0, 1.0, -9.0, -6.0, 7.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(4.0, 6.0, 6.0, 0.0, -9.0, 3.0));
}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-4.0, 1.0, -2.0, -6.0, 1.0, 6.0, -7.0, 4.0, 3.0, -5.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-7.0, -9.0, 3.0));
	var[1] = (vec3(-3.0, -5.0, -8.0));
	var[2] = (vec3(5.0, -3.0, -6.0));
	var[3] = (vec3(1.0, 6.0, -7.0));
}
#version 450
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
	lowp ivec2 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -1) && allOk;
	allOk = compare_ivec2((var), ivec2(-7, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5);
	var = (ivec2(-9, -1));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2(var, mat2(9.0, 2.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat2(9.0, -6.0, -6.0, 3.0));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(-4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var = (mat3(6.0, 1.0, 6.0, -7.0, -8.0, -7.0, -6.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-2.0, 8.0, -5.0, 9.0, -6.0, -1.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var = (mat2x4(-3.0, -3.0, -7.0, -9.0, 3.0, -6.0, -5.0, -6.0));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-9.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, 6.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var = (mat2x4(7.0, 9.0, -5.0, 2.0, 9.0, -8.0, -9.0, -5.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, -8.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -2.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat2x4(7.0, 1.0, 2.0, 2.0, -6.0, -9.0, -1.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], -6.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(7.0, -8.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0] = (vec4(-8.0, -4.0, -6.0, 8.0));
	var[1] = (vec4(-1.0, 9.0, -1.0, 1.0));
	var[2] = (vec4(3.0, -5.0, 5.0, -6.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
}
#version 450
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

	var[0][0] = (vec3(1.0, 3.0, -7.0));
	var[0][1] = (vec3(-7.0, 2.0, 3.0));
	var[0][2] = (vec3(1.0, -2.0, -1.0));
	var[0][3] = (vec3(-5.0, -1.0, 9.0));
	var[1][0] = (vec3(8.0, -4.0, 3.0));
	var[1][1] = (vec3(4.0, 9.0, -6.0));
	var[1][2] = (vec3(7.0, 6.0, -5.0));
	var[1][3] = (vec3(2.0, 6.0, 3.0));
	var[2][0] = (vec3(2.0, 7.0, -1.0));
	var[2][1] = (vec3(-3.0, -3.0, -7.0));
	var[2][2] = (vec3(-5.0, 3.0, 4.0));
	var[2][3] = (vec3(-4.0, -2.0, 8.0));
}
#version 450
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
	u8vec4 var[3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat3x4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0, 1.0, 9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0] = (vec3(-7.0, 2.0, 3.0));
	var[0][1] = (vec3(1.0, -2.0, -1.0));
	var[0][2] = (vec3(-5.0, -1.0, 9.0));
	var[0][3] = (vec3(3.0, -7.0, 8.0));
	var[1][0] = (vec3(4.0, 9.0, -6.0));
	var[1][1] = (vec3(7.0, 6.0, -5.0));
	var[1][2] = (vec3(2.0, 6.0, 3.0));
	var[1][3] = (vec3(-4.0, 3.0, 2.0));
	var[2][0] = (vec3(-3.0, -3.0, -7.0));
	var[2][1] = (vec3(-5.0, 3.0, 4.0));
	var[2][2] = (vec3(-4.0, -2.0, 8.0));
	var[2][3] = (vec3(7.0, -1.0, -1.0));
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[3] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[4] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[5] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[6] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[7] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[8] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[9] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[10] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[11] = (mat2(5.0, 8.0, -2.0, 4.0));
	var[12] = (mat2(8.0, -7.0, 0.0, -7.0));
	var[13] = (mat2(-6.0, 8.0, 5.0, 2.0));
	var[14] = (mat2(5.0, -4.0, 3.0, 8.0));
	var[15] = (mat2(0.0, -2.0, 7.0, 4.0));
	var[16] = (mat2(4.0, -4.0, 0.0, 7.0));
	var[17] = (mat2(-7.0, 7.0, -1.0, 4.0));
	var[18] = (mat2(6.0, 1.0, 8.0, -1.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp mat2x4 var[];
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
	allOk = compare_mat2x4(var[3], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[3] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[4] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[5] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[6] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[7] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[8] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[9] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[10] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[11] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	var[12] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	var[13] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	var[14] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	var[15] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	var[16] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	var[17] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	var[18] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
}
#version 450
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

	var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[3] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[4] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[5] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[6] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[7] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[8] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[9] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[10] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[11] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	var[12] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	var[13] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	var[14] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	var[15] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	var[16] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	var[17] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	var[18] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[3] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[4] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[5] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[6] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[7] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[8] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[9] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[10] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[11] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	var[12] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	var[13] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	var[14] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	var[15] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	var[16] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	var[17] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	var[18] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
}
#version 450
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
	highp mat2x4 var[];
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
	allOk = compare_mat2x4(var[3], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[3] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[4] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[5] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[6] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[7] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[8] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[9] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[10] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[11] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	var[12] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	var[13] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	var[14] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	var[15] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	var[16] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	var[17] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	var[18] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[1][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[1][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[1][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[2][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[2][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[2][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[3][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[3][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[3][2] = (mat2(5.0, 8.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[0][2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	var[1][0] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	var[1][1] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	var[1][2] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	var[2][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	var[2][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	var[2][2] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	var[3][0] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	var[3][1] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	var[3][2] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp float var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0][0]), 7.0) && allOk;
	allOk = compare_float((var[0][1]), -1.0) && allOk;
	allOk = compare_float((var[0][2]), -6.0) && allOk;
	allOk = compare_float((var[1][0]), 0.0) && allOk;
	allOk = compare_float((var[1][1]), -7.0) && allOk;
	allOk = compare_float((var[1][2]), 5.0) && allOk;
	allOk = compare_float((var[2][0]), 4.0) && allOk;
	allOk = compare_float((var[2][1]), 2.0) && allOk;
	allOk = compare_float((var[2][2]), -1.0) && allOk;
	allOk = compare_float((var[3][0]), -6.0) && allOk;
	allOk = compare_float((var[3][1]), -2.0) && allOk;
	allOk = compare_float((var[3][2]), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (-2.0);
	var[0][1] = (4.0);
	var[0][2] = (6.0);
	var[1][0] = (7.0);
	var[1][1] = (-4.0);
	var[1][2] = (5.0);
	var[2][0] = (-8.0);
	var[2][1] = (9.0);
	var[2][2] = (-5.0);
	var[3][0] = (8.0);
	var[3][1] = (-5.0);
	var[3][2] = (6.0);
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[0][2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[0][2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[0][2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[0][2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	var[1][0][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[1][0][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[1][0][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[1][0][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[1][1][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[1][1][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[1][1][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[1][1][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[1][2][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[1][2][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[1][2][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[1][2][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[2][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[2][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[2][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[2][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[2][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[2][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[2][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[2][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[2][2][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[2][2][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[2][2][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[2][2][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[3][0][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[3][0][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[3][0][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[3][0][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[3][1][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[3][1][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[3][1][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[3][1][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[3][2][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[3][2][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[3][2][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[3][2][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[0][2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[1][0] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[1][1] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[1][2] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[2][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[2][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[2][2] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[3][0] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[3][1] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[3][2] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
}
#version 450
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
	i8vec3 var[4][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0]), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1]), ivec3(4294967289, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][2]), ivec3(9, 4294967292, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1]), ivec3(0, 4294967291, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][2]), ivec3(4294967292, 1, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0]), ivec3(4294967293, 4294967295, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1]), ivec3(6, 4294967295, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][2]), ivec3(3, 5, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1]), ivec3(7, 4294967290, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][2]), ivec3(4294967294, 0, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967292);
	var[0][0] = i8vec3(ivec3(0, 0, 7));
	var[0][1] = i8vec3(ivec3(9, 4294967290, 4294967288));
	var[0][2] = i8vec3(ivec3(9, 4294967288, 4294967293));
	var[1][0] = i8vec3(ivec3(3, 4294967295, 9));
	var[1][1] = i8vec3(ivec3(7, 5, 5));
	var[1][2] = i8vec3(ivec3(4294967293, 6, 4294967293));
	var[2][0] = i8vec3(ivec3(4294967295, 3, 5));
	var[2][1] = i8vec3(ivec3(4294967292, 4294967295, 4294967293));
	var[2][2] = i8vec3(ivec3(8, 4294967290, 3));
	var[3][0] = i8vec3(ivec3(7, 4, 4294967292));
	var[3][1] = i8vec3(ivec3(8, 8, 4294967294));
	var[3][2] = i8vec3(ivec3(8, 1, 7));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-8.0, -4.0));
	var[0][0][0][1] = (vec2(-3.0, 5.0));
	var[0][0][0][2] = (vec2(-9.0, 4.0));
	var[0][0][1][0] = (vec2(-2.0, -1.0));
	var[0][0][1][1] = (vec2(8.0, 3.0));
	var[0][0][1][2] = (vec2(7.0, 2.0));
	var[0][0][2][0] = (vec2(-4.0, 4.0));
	var[0][0][2][1] = (vec2(3.0, -6.0));
	var[0][0][2][2] = (vec2(-4.0, 3.0));
	var[0][1][0][0] = (vec2(2.0, 6.0));
	var[0][1][0][1] = (vec2(6.0, 1.0));
	var[0][1][0][2] = (vec2(4.0, -8.0));
	var[0][1][1][0] = (vec2(2.0, -5.0));
	var[0][1][1][1] = (vec2(-5.0, 5.0));
	var[0][1][1][2] = (vec2(2.0, -1.0));
	var[0][1][2][0] = (vec2(-9.0, 3.0));
	var[0][1][2][1] = (vec2(6.0, 5.0));
	var[0][1][2][2] = (vec2(-1.0, -8.0));
	var[1][0][0][0] = (vec2(4.0, 6.0));
	var[1][0][0][1] = (vec2(3.0, 6.0));
	var[1][0][0][2] = (vec2(-2.0, -9.0));
	var[1][0][1][0] = (vec2(-9.0, 0.0));
	var[1][0][1][1] = (vec2(-4.0, 9.0));
	var[1][0][1][2] = (vec2(-1.0, -1.0));
	var[1][0][2][0] = (vec2(-8.0, 6.0));
	var[1][0][2][1] = (vec2(5.0, -2.0));
	var[1][0][2][2] = (vec2(1.0, 4.0));
	var[1][1][0][0] = (vec2(2.0, -1.0));
	var[1][1][0][1] = (vec2(0.0, -2.0));
	var[1][1][0][2] = (vec2(-4.0, 6.0));
	var[1][1][1][0] = (vec2(2.0, -3.0));
	var[1][1][1][1] = (vec2(-2.0, 1.0));
	var[1][1][1][2] = (vec2(-3.0, 8.0));
	var[1][1][2][0] = (vec2(5.0, -1.0));
	var[1][1][2][1] = (vec2(-4.0, -4.0));
	var[1][1][2][2] = (vec2(7.0, -6.0));
	var[2][0][0][0] = (vec2(2.0, -5.0));
	var[2][0][0][1] = (vec2(-5.0, -9.0));
	var[2][0][0][2] = (vec2(-7.0, 3.0));
	var[2][0][1][0] = (vec2(-1.0, 0.0));
	var[2][0][1][1] = (vec2(-1.0, 4.0));
	var[2][0][1][2] = (vec2(-1.0, -6.0));
	var[2][0][2][0] = (vec2(-8.0, -6.0));
	var[2][0][2][1] = (vec2(8.0, 7.0));
	var[2][0][2][2] = (vec2(4.0, -9.0));
	var[2][1][0][0] = (vec2(-2.0, -8.0));
	var[2][1][0][1] = (vec2(0.0, -2.0));
	var[2][1][0][2] = (vec2(8.0, -2.0));
	var[2][1][1][0] = (vec2(3.0, 7.0));
	var[2][1][1][1] = (vec2(-9.0, -1.0));
	var[2][1][1][2] = (vec2(5.0, 7.0));
	var[2][1][2][0] = (vec2(-5.0, 7.0));
	var[2][1][2][1] = (vec2(6.0, 2.0));
	var[2][1][2][2] = (vec2(-4.0, -3.0));
	var[3][0][0][0] = (vec2(-4.0, -1.0));
	var[3][0][0][1] = (vec2(-3.0, -2.0));
	var[3][0][0][2] = (vec2(-5.0, -2.0));
	var[3][0][1][0] = (vec2(-7.0, -3.0));
	var[3][0][1][1] = (vec2(5.0, 4.0));
	var[3][0][1][2] = (vec2(4.0, 1.0));
	var[3][0][2][0] = (vec2(-3.0, -6.0));
	var[3][0][2][1] = (vec2(-4.0, -2.0));
	var[3][0][2][2] = (vec2(-5.0, -7.0));
	var[3][1][0][0] = (vec2(-5.0, 2.0));
	var[3][1][0][1] = (vec2(-7.0, 8.0));
	var[3][1][0][2] = (vec2(-6.0, 3.0));
	var[3][1][1][0] = (vec2(-3.0, -4.0));
	var[3][1][1][1] = (vec2(-5.0, -9.0));
	var[3][1][1][2] = (vec2(-8.0, -7.0));
	var[3][1][2][0] = (vec2(8.0, -8.0));
	var[3][1][2][1] = (vec2(-2.0, 7.0));
	var[3][1][2][2] = (vec2(5.0, -5.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[0][0][2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	var[0][1][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	var[0][1][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	var[0][1][2] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	var[1][0][0] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	var[1][0][1] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	var[1][0][2] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	var[1][1][0] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	var[1][1][1] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	var[1][1][2] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	var[2][0][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	var[2][0][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	var[2][0][2] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	var[2][1][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	var[2][1][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	var[2][1][2] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	var[3][0][0] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	var[3][0][1] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	var[3][0][2] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	var[3][1][0] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	var[3][1][1] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	var[3][1][2] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, 2.0, -5.0));
	var[0][0][0][1] = (vec3(-3.0, -2.0, 2.0));
	var[0][0][0][2] = (vec3(-5.0, 9.0, 4.0));
	var[0][0][0][3] = (vec3(2.0, -4.0, 9.0));
	var[0][0][1][0] = (vec3(8.0, -4.0, -5.0));
	var[0][0][1][1] = (vec3(-5.0, 6.0, 8.0));
	var[0][0][1][2] = (vec3(-7.0, 4.0, -8.0));
	var[0][0][1][3] = (vec3(-1.0, 1.0, 1.0));
	var[0][0][2][0] = (vec3(-4.0, 5.0, 7.0));
	var[0][0][2][1] = (vec3(9.0, 5.0, -7.0));
	var[0][0][2][2] = (vec3(8.0, 9.0, 0.0));
	var[0][0][2][3] = (vec3(-3.0, 3.0, 0.0));
	var[0][1][0][0] = (vec3(-5.0, 3.0, -5.0));
	var[0][1][0][1] = (vec3(-6.0, 6.0, 3.0));
	var[0][1][0][2] = (vec3(-6.0, 0.0, -5.0));
	var[0][1][0][3] = (vec3(-9.0, 8.0, -8.0));
	var[0][1][1][0] = (vec3(-5.0, 2.0, -7.0));
	var[0][1][1][1] = (vec3(-1.0, -2.0, 7.0));
	var[0][1][1][2] = (vec3(4.0, -7.0, 7.0));
	var[0][1][1][3] = (vec3(-3.0, 7.0, 6.0));
	var[0][1][2][0] = (vec3(9.0, -2.0, 2.0));
	var[0][1][2][1] = (vec3(-3.0, -6.0, 3.0));
	var[0][1][2][2] = (vec3(7.0, -7.0, -1.0));
	var[0][1][2][3] = (vec3(0.0, 1.0, -3.0));
	var[1][0][0][0] = (vec3(7.0, -8.0, -7.0));
	var[1][0][0][1] = (vec3(2.0, 7.0, 5.0));
	var[1][0][0][2] = (vec3(5.0, -7.0, 0.0));
	var[1][0][0][3] = (vec3(-2.0, 9.0, -7.0));
	var[1][0][1][0] = (vec3(2.0, -9.0, 0.0));
	var[1][0][1][1] = (vec3(9.0, -2.0, -8.0));
	var[1][0][1][2] = (vec3(-9.0, 5.0, 9.0));
	var[1][0][1][3] = (vec3(0.0, 8.0, -9.0));
	var[1][0][2][0] = (vec3(2.0, 1.0, -7.0));
	var[1][0][2][1] = (vec3(-7.0, 8.0, 7.0));
	var[1][0][2][2] = (vec3(8.0, -8.0, -5.0));
	var[1][0][2][3] = (vec3(5.0, 1.0, -3.0));
	var[1][1][0][0] = (vec3(-6.0, 6.0, 2.0));
	var[1][1][0][1] = (vec3(-5.0, 0.0, 4.0));
	var[1][1][0][2] = (vec3(7.0, -6.0, -6.0));
	var[1][1][0][3] = (vec3(3.0, 8.0, 1.0));
	var[1][1][1][0] = (vec3(-3.0, -1.0, 7.0));
	var[1][1][1][1] = (vec3(-2.0, -7.0, -9.0));
	var[1][1][1][2] = (vec3(-8.0, -1.0, 4.0));
	var[1][1][1][3] = (vec3(0.0, -2.0, -5.0));
	var[1][1][2][0] = (vec3(2.0, -7.0, 3.0));
	var[1][1][2][1] = (vec3(-2.0, 4.0, -6.0));
	var[1][1][2][2] = (vec3(8.0, -7.0, -9.0));
	var[1][1][2][3] = (vec3(-4.0, 5.0, 4.0));
	var[2][0][0][0] = (vec3(2.0, 5.0, 2.0));
	var[2][0][0][1] = (vec3(2.0, 3.0, -2.0));
	var[2][0][0][2] = (vec3(5.0, 4.0, 6.0));
	var[2][0][0][3] = (vec3(-1.0, 5.0, 6.0));
	var[2][0][1][0] = (vec3(1.0, 2.0, -4.0));
	var[2][0][1][1] = (vec3(9.0, -1.0, 6.0));
	var[2][0][1][2] = (vec3(9.0, -1.0, -2.0));
	var[2][0][1][3] = (vec3(-1.0, -8.0, 3.0));
	var[2][0][2][0] = (vec3(-4.0, 1.0, -4.0));
	var[2][0][2][1] = (vec3(4.0, 2.0, 0.0));
	var[2][0][2][2] = (vec3(1.0, -6.0, 1.0));
	var[2][0][2][3] = (vec3(-7.0, -9.0, 8.0));
	var[2][1][0][0] = (vec3(1.0, -1.0, 8.0));
	var[2][1][0][1] = (vec3(8.0, 3.0, -9.0));
	var[2][1][0][2] = (vec3(1.0, -1.0, -7.0));
	var[2][1][0][3] = (vec3(-1.0, -7.0, -5.0));
	var[2][1][1][0] = (vec3(-5.0, 1.0, 8.0));
	var[2][1][1][1] = (vec3(5.0, 5.0, -8.0));
	var[2][1][1][2] = (vec3(-8.0, 2.0, 8.0));
	var[2][1][1][3] = (vec3(2.0, -8.0, -6.0));
	var[2][1][2][0] = (vec3(-9.0, 1.0, 5.0));
	var[2][1][2][1] = (vec3(4.0, 5.0, 1.0));
	var[2][1][2][2] = (vec3(-7.0, 4.0, -5.0));
	var[2][1][2][3] = (vec3(4.0, 8.0, 8.0));
	var[3][0][0][0] = (vec3(1.0, 9.0, -4.0));
	var[3][0][0][1] = (vec3(1.0, -5.0, 9.0));
	var[3][0][0][2] = (vec3(2.0, -1.0, -1.0));
	var[3][0][0][3] = (vec3(5.0, 7.0, -4.0));
	var[3][0][1][0] = (vec3(-2.0, 9.0, -4.0));
	var[3][0][1][1] = (vec3(-4.0, 4.0, -1.0));
	var[3][0][1][2] = (vec3(0.0, 7.0, 9.0));
	var[3][0][1][3] = (vec3(-8.0, 3.0, 9.0));
	var[3][0][2][0] = (vec3(-7.0, -1.0, -9.0));
	var[3][0][2][1] = (vec3(-7.0, 3.0, 5.0));
	var[3][0][2][2] = (vec3(-7.0, 1.0, -1.0));
	var[3][0][2][3] = (vec3(-5.0, -7.0, 7.0));
	var[3][1][0][0] = (vec3(-4.0, -2.0, -5.0));
	var[3][1][0][1] = (vec3(-5.0, -9.0, 8.0));
	var[3][1][0][2] = (vec3(4.0, 8.0, 0.0));
	var[3][1][0][3] = (vec3(0.0, 9.0, 5.0));
	var[3][1][1][0] = (vec3(-3.0, 8.0, 6.0));
	var[3][1][1][1] = (vec3(7.0, 8.0, -7.0));
	var[3][1][1][2] = (vec3(-3.0, -6.0, -2.0));
	var[3][1][1][3] = (vec3(-6.0, 0.0, -8.0));
	var[3][1][2][0] = (vec3(-6.0, 0.0, 6.0));
	var[3][1][2][1] = (vec3(-1.0, 6.0, -7.0));
	var[3][1][2][2] = (vec3(7.0, 0.0, 1.0));
	var[3][1][2][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
	u8vec3 var[4][2][3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0][0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][2]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][0]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][1]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][0]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][1]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][2]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][2]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][2]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][1]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][2]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][0]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][1]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][2]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	var[0][0][2] = u8vec3(uvec3(7u, 1u, 5u));
	var[0][1][0] = u8vec3(uvec3(5u, 7u, 3u));
	var[0][1][1] = u8vec3(uvec3(9u, 8u, 1u));
	var[0][1][2] = u8vec3(uvec3(6u, 2u, 7u));
	var[1][0][0] = u8vec3(uvec3(1u, 7u, 9u));
	var[1][0][1] = u8vec3(uvec3(3u, 4u, 3u));
	var[1][0][2] = u8vec3(uvec3(5u, 7u, 4u));
	var[1][1][0] = u8vec3(uvec3(0u, 2u, 7u));
	var[1][1][1] = u8vec3(uvec3(4u, 8u, 8u));
	var[1][1][2] = u8vec3(uvec3(6u, 1u, 2u));
	var[2][0][0] = u8vec3(uvec3(5u, 4u, 7u));
	var[2][0][1] = u8vec3(uvec3(0u, 0u, 5u));
	var[2][0][2] = u8vec3(uvec3(2u, 5u, 5u));
	var[2][1][0] = u8vec3(uvec3(3u, 6u, 6u));
	var[2][1][1] = u8vec3(uvec3(2u, 7u, 9u));
	var[2][1][2] = u8vec3(uvec3(4u, 0u, 2u));
	var[3][0][0] = u8vec3(uvec3(5u, 9u, 6u));
	var[3][0][1] = u8vec3(uvec3(9u, 7u, 3u));
	var[3][0][2] = u8vec3(uvec3(9u, 4u, 9u));
	var[3][1][0] = u8vec3(uvec3(1u, 5u, 4u));
	var[3][1][1] = u8vec3(uvec3(3u, 7u, 7u));
	var[3][1][2] = u8vec3(uvec3(3u, 8u, 8u));
}
#version 450
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
	int8_t var[4][2][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][0][1]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][0][2]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][1][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][1][1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[0][1][2]), 7) && allOk;
	allOk = compare_int8_t(int(var[1][0][0]), 1) && allOk;
	allOk = compare_int8_t(int(var[1][0][1]), 6) && allOk;
	allOk = compare_int8_t(int(var[1][0][2]), 8) && allOk;
	allOk = compare_int8_t(int(var[1][1][0]), 4294967293) && allOk;
	allOk = compare_int8_t(int(var[1][1][1]), 8) && allOk;
	allOk = compare_int8_t(int(var[1][1][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[2][0][0]), 5) && allOk;
	allOk = compare_int8_t(int(var[2][0][1]), 2) && allOk;
	allOk = compare_int8_t(int(var[2][0][2]), 0) && allOk;
	allOk = compare_int8_t(int(var[2][1][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[2][1][1]), 9) && allOk;
	allOk = compare_int8_t(int(var[2][1][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[3][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[3][0][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[3][0][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[3][1][0]), 6) && allOk;
	allOk = compare_int8_t(int(var[3][1][1]), 7) && allOk;
	allOk = compare_int8_t(int(var[3][1][2]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = int8_t(4294967290);
	var[0][0][1] = int8_t(4294967294);
	var[0][0][2] = int8_t(3);
	var[0][1][0] = int8_t(0);
	var[0][1][1] = int8_t(4294967289);
	var[0][1][2] = int8_t(1);
	var[1][0][0] = int8_t(4294967288);
	var[1][0][1] = int8_t(1);
	var[1][0][2] = int8_t(2);
	var[1][1][0] = int8_t(7);
	var[1][1][1] = int8_t(4294967287);
	var[1][1][2] = int8_t(4294967289);
	var[2][0][0] = int8_t(4294967288);
	var[2][0][1] = int8_t(4294967294);
	var[2][0][2] = int8_t(7);
	var[2][1][0] = int8_t(6);
	var[2][1][1] = int8_t(1);
	var[2][1][2] = int8_t(4294967293);
	var[3][0][0] = int8_t(9);
	var[3][0][1] = int8_t(0);
	var[3][0][2] = int8_t(4294967292);
	var[3][1][0] = int8_t(2);
	var[3][1][1] = int8_t(5);
	var[3][1][2] = int8_t(4294967289);
}
#version 450
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
	highp vec4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_vec4((var[0][0][0]), vec4(4.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((var[0][0][1]), vec4(4.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((var[0][0][2]), vec4(-4.0, 3.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec4((var[0][1][0]), vec4(3.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec4((var[0][1][1]), vec4(1.0, -6.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((var[0][1][2]), vec4(6.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1][0][0]), vec4(-3.0, -6.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((var[1][0][1]), vec4(0.0, -8.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[1][0][2]), vec4(1.0, 8.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1][1][0]), vec4(-7.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((var[1][1][1]), vec4(-6.0, 5.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec4((var[1][1][2]), vec4(-5.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[2][0][0]), vec4(9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((var[2][0][1]), vec4(-5.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4((var[2][0][2]), vec4(2.0, -6.0, 6.0, -1.0)) && allOk;
	allOk = compare_vec4((var[2][1][0]), vec4(-4.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec4((var[2][1][1]), vec4(7.0, -3.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec4((var[2][1][2]), vec4(-5.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4((var[3][0][0]), vec4(6.0, -6.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][0][1]), vec4(1.0, 8.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((var[3][0][2]), vec4(-4.0, 2.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4((var[3][1][0]), vec4(-9.0, 9.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec4((var[3][1][1]), vec4(-9.0, -7.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec4((var[3][1][2]), vec4(-9.0, 4.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0][0][0] = (vec4(8.0, 3.0, -4.0, -6.0));
	var[0][0][1] = (vec4(-1.0, -3.0, 6.0, 5.0));
	var[0][0][2] = (vec4(-9.0, 4.0, -1.0, -7.0));
	var[0][1][0] = (vec4(7.0, 1.0, 1.0, -7.0));
	var[0][1][1] = (vec4(-6.0, -7.0, -4.0, 8.0));
	var[0][1][2] = (vec4(-1.0, -6.0, -8.0, 9.0));
	var[1][0][0] = (vec4(-6.0, -2.0, -8.0, 8.0));
	var[1][0][1] = (vec4(7.0, 5.0, 1.0, -6.0));
	var[1][0][2] = (vec4(-5.0, -8.0, 8.0, 0.0));
	var[1][1][0] = (vec4(7.0, -3.0, -8.0, -3.0));
	var[1][1][1] = (vec4(-9.0, 2.0, 1.0, -7.0));
	var[1][1][2] = (vec4(3.0, -5.0, 8.0, 5.0));
	var[2][0][0] = (vec4(8.0, 4.0, -4.0, -8.0));
	var[2][0][1] = (vec4(-3.0, 9.0, -7.0, -9.0));
	var[2][0][2] = (vec4(2.0, -6.0, 6.0, 6.0));
	var[2][1][0] = (vec4(-4.0, -5.0, 6.0, 0.0));
	var[2][1][1] = (vec4(-2.0, -8.0, 7.0, 0.0));
	var[2][1][2] = (vec4(-7.0, -2.0, -7.0, 3.0));
	var[3][0][0] = (vec4(2.0, -3.0, 0.0, -9.0));
	var[3][0][1] = (vec4(8.0, -8.0, 0.0, 2.0));
	var[3][0][2] = (vec4(6.0, 6.0, 1.0, 1.0));
	var[3][1][0] = (vec4(-8.0, 1.0, 6.0, 0.0));
	var[3][1][1] = (vec4(5.0, -3.0, -2.0, -9.0));
	var[3][1][2] = (vec4(-7.0, 2.0, -7.0, -7.0));
}
#version 450
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
	uint padding;
	highp uvec3 var[4][2][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 9u) && allOk;
	allOk = compare_uvec3((var[0][0][0]), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][0][1]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((var[0][0][2]), uvec3(0u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[0][1][0]), uvec3(0u, 9u, 5u)) && allOk;
	allOk = compare_uvec3((var[0][1][1]), uvec3(2u, 4u, 6u)) && allOk;
	allOk = compare_uvec3((var[0][1][2]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((var[1][0][0]), uvec3(8u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][0][1]), uvec3(5u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[1][0][2]), uvec3(2u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((var[1][1][0]), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][1][1]), uvec3(0u, 6u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][1][2]), uvec3(2u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((var[2][0][0]), uvec3(1u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((var[2][0][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_uvec3((var[2][0][2]), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((var[2][1][0]), uvec3(3u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((var[2][1][1]), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((var[2][1][2]), uvec3(3u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((var[3][0][0]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((var[3][0][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((var[3][0][2]), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[3][1][0]), uvec3(4u, 9u, 7u)) && allOk;
	allOk = compare_uvec3((var[3][1][1]), uvec3(2u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((var[3][1][2]), uvec3(0u, 3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3u);
	var[0][0][0] = (uvec3(5u, 6u, 5u));
	var[0][0][1] = (uvec3(4u, 5u, 4u));
	var[0][0][2] = (uvec3(9u, 4u, 4u));
	var[0][1][0] = (uvec3(1u, 6u, 3u));
	var[0][1][1] = (uvec3(9u, 4u, 9u));
	var[0][1][2] = (uvec3(7u, 9u, 1u));
	var[1][0][0] = (uvec3(7u, 7u, 0u));
	var[1][0][1] = (uvec3(2u, 9u, 4u));
	var[1][0][2] = (uvec3(7u, 8u, 9u));
	var[1][1][0] = (uvec3(4u, 6u, 4u));
	var[1][1][1] = (uvec3(9u, 3u, 4u));
	var[1][1][2] = (uvec3(3u, 5u, 4u));
	var[2][0][0] = (uvec3(4u, 3u, 5u));
	var[2][0][1] = (uvec3(8u, 0u, 5u));
	var[2][0][2] = (uvec3(4u, 6u, 7u));
	var[2][1][0] = (uvec3(8u, 7u, 1u));
	var[2][1][1] = (uvec3(5u, 2u, 4u));
	var[2][1][2] = (uvec3(1u, 2u, 6u));
	var[3][0][0] = (uvec3(7u, 5u, 3u));
	var[3][0][1] = (uvec3(7u, 0u, 8u));
	var[3][0][2] = (uvec3(1u, 2u, 1u));
	var[3][1][0] = (uvec3(5u, 3u, 8u));
	var[3][1][1] = (uvec3(8u, 7u, 1u));
	var[3][1][2] = (uvec3(2u, 5u, 9u));
}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0][0] = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	var[0][0][1] = (mat4x2(3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0));
	var[0][0][2] = (mat4x2(4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0, 6.0));
	var[0][1][0] = (mat4x2(9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0, -7.0));
	var[0][1][1] = (mat4x2(2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0, -9.0));
	var[0][1][2] = (mat4x2(7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0, 4.0));
	var[1][0][0] = (mat4x2(1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0, 5.0));
	var[1][0][1] = (mat4x2(-4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0, -1.0));
	var[1][0][2] = (mat4x2(6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0, 1.0));
	var[1][1][0] = (mat4x2(1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0, 2.0));
	var[1][1][1] = (mat4x2(6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0, -4.0));
	var[1][1][2] = (mat4x2(6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0, 8.0));
	var[2][0][0] = (mat4x2(-6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0, 8.0));
	var[2][0][1] = (mat4x2(-7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0, -2.0));
	var[2][0][2] = (mat4x2(-5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0, -5.0));
	var[2][1][0] = (mat4x2(-7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0, 1.0));
	var[2][1][1] = (mat4x2(6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0, -6.0));
	var[2][1][2] = (mat4x2(4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0, 5.0));
	var[3][0][0] = (mat4x2(6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0, 1.0));
	var[3][0][1] = (mat4x2(-9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0, -2.0));
	var[3][0][2] = (mat4x2(7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0, 4.0));
	var[3][1][0] = (mat4x2(-4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0, 7.0));
	var[3][1][1] = (mat4x2(-2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0, -3.0));
	var[3][1][2] = (mat4x2(-1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0, 7.0));
}
#version 450
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
	float16_t var[4][2][3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][2]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][1]), -8.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][2]), -2.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][1]), 3.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][1]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][0]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][1]), 8.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][2]), -1.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][1]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][2]), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(-8.0);
	var[0][0][0] = float16_t(9.0);
	var[0][0][1] = float16_t(-2.0);
	var[0][0][2] = float16_t(7.0);
	var[0][1][0] = float16_t(-3.0);
	var[0][1][1] = float16_t(6.0);
	var[0][1][2] = float16_t(-3.0);
	var[1][0][0] = float16_t(8.0);
	var[1][0][1] = float16_t(-9.0);
	var[1][0][2] = float16_t(2.0);
	var[1][1][0] = float16_t(-8.0);
	var[1][1][1] = float16_t(1.0);
	var[1][1][2] = float16_t(3.0);
	var[2][0][0] = float16_t(-8.0);
	var[2][0][1] = float16_t(-1.0);
	var[2][0][2] = float16_t(6.0);
	var[2][1][0] = float16_t(8.0);
	var[2][1][1] = float16_t(-7.0);
	var[2][1][2] = float16_t(-4.0);
	var[3][0][0] = float16_t(-7.0);
	var[3][0][1] = float16_t(-5.0);
	var[3][0][2] = float16_t(8.0);
	var[3][1][0] = float16_t(-6.0);
	var[3][1][1] = float16_t(8.0);
	var[3][1][2] = float16_t(0.0);
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(3.0, -2.0, -1.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-5.0, -2.0, 9.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(4.0, -4.0, -3.0, -5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-2.0, 0.0, 3.0, 7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(7.0, 7.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][0][0][1] = (vec3(0.0, -8.0, -2.0));
	var[0][0][1][0] = (vec3(8.0, 8.0, 0.0));
	var[0][0][1][1] = (vec3(3.0, -6.0, -6.0));
	var[0][1][0][0] = (vec3(-1.0, -3.0, 0.0));
	var[0][1][0][1] = (vec3(3.0, 3.0, 5.0));
	var[0][1][1][0] = (vec3(-1.0, -1.0, 3.0));
	var[0][1][1][1] = (vec3(-1.0, -7.0, 7.0));
	var[0][2][0][0] = (vec3(-7.0, 8.0, -3.0));
	var[0][2][0][1] = (vec3(3.0, 8.0, 1.0));
	var[0][2][1][0] = (vec3(3.0, 6.0, 2.0));
	var[0][2][1][1] = (vec3(9.0, -2.0, -9.0));
	var[0][3][0][0] = (vec3(-4.0, 0.0, -1.0));
	var[0][3][0][1] = (vec3(8.0, 9.0, -4.0));
	var[0][3][1][0] = (vec3(6.0, 5.0, -2.0));
	var[0][3][1][1] = (vec3(0.0, 6.0, 6.0));
	var[1][0][0][0] = (vec3(-1.0, 2.0, -9.0));
	var[1][0][0][1] = (vec3(1.0, 3.0, 2.0));
	var[1][0][1][0] = (vec3(1.0, 5.0, -6.0));
	var[1][0][1][1] = (vec3(-8.0, -6.0, -5.0));
	var[1][1][0][0] = (vec3(-6.0, -6.0, -8.0));
	var[1][1][0][1] = (vec3(2.0, -4.0, -3.0));
	var[1][1][1][0] = (vec3(-3.0, 4.0, 8.0));
	var[1][1][1][1] = (vec3(7.0, -2.0, -7.0));
	var[1][2][0][0] = (vec3(-9.0, 6.0, -2.0));
	var[1][2][0][1] = (vec3(-3.0, -8.0, -5.0));
	var[1][2][1][0] = (vec3(-2.0, -5.0, 0.0));
	var[1][2][1][1] = (vec3(-9.0, -9.0, -9.0));
	var[1][3][0][0] = (vec3(3.0, 8.0, 3.0));
	var[1][3][0][1] = (vec3(2.0, 2.0, -8.0));
	var[1][3][1][0] = (vec3(0.0, -1.0, 2.0));
	var[1][3][1][1] = (vec3(7.0, 7.0, 4.0));
	var[2][0][0][0] = (vec3(-9.0, 6.0, -9.0));
	var[2][0][0][1] = (vec3(0.0, -1.0, -3.0));
	var[2][0][1][0] = (vec3(-6.0, 9.0, 7.0));
	var[2][0][1][1] = (vec3(-5.0, -7.0, -2.0));
	var[2][1][0][0] = (vec3(-5.0, 5.0, -5.0));
	var[2][1][0][1] = (vec3(1.0, -1.0, 7.0));
	var[2][1][1][0] = (vec3(-5.0, 8.0, -7.0));
	var[2][1][1][1] = (vec3(-2.0, 4.0, 3.0));
	var[2][2][0][0] = (vec3(-9.0, -3.0, -1.0));
	var[2][2][0][1] = (vec3(7.0, 1.0, 1.0));
	var[2][2][1][0] = (vec3(4.0, -2.0, 7.0));
	var[2][2][1][1] = (vec3(0.0, 1.0, 9.0));
	var[2][3][0][0] = (vec3(-1.0, -5.0, -6.0));
	var[2][3][0][1] = (vec3(-9.0, 7.0, 3.0));
	var[2][3][1][0] = (vec3(7.0, 3.0, -9.0));
	var[2][3][1][1] = (vec3(1.0, -3.0, 5.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	u16vec4 var[][4][2];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0][0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][2][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][2][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][3][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][3][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][0]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][1]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][0]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][1]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][2][0]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][2][1]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][3][0]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][3][1]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][0]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][1]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][0]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][1]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][2][0]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][2][1]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][3][0]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][3][1]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[0][1][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[0][1][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[0][2][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	var[0][2][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	var[0][3][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	var[0][3][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	var[1][0][0] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[1][0][1] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[1][1][0] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[1][1][1] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[1][2][0] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	var[1][2][1] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	var[1][3][0] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	var[1][3][1] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	var[2][0][0] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[2][0][1] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[2][1][0] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[2][1][1] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	var[2][2][0] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	var[2][2][1] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	var[2][3][0] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	var[2][3][1] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
	highp uint var[][4][2];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((var[0][1][0]), 6u) && allOk;
	allOk = compare_uint((var[0][1][1]), 4u) && allOk;
	allOk = compare_uint((var[0][2][0]), 7u) && allOk;
	allOk = compare_uint((var[0][2][1]), 8u) && allOk;
	allOk = compare_uint((var[0][3][0]), 4u) && allOk;
	allOk = compare_uint((var[0][3][1]), 8u) && allOk;
	allOk = compare_uint((var[1][0][0]), 9u) && allOk;
	allOk = compare_uint((var[1][0][1]), 0u) && allOk;
	allOk = compare_uint((var[1][1][0]), 2u) && allOk;
	allOk = compare_uint((var[1][1][1]), 5u) && allOk;
	allOk = compare_uint((var[1][2][0]), 6u) && allOk;
	allOk = compare_uint((var[1][2][1]), 9u) && allOk;
	allOk = compare_uint((var[1][3][0]), 7u) && allOk;
	allOk = compare_uint((var[1][3][1]), 9u) && allOk;
	allOk = compare_uint((var[2][0][0]), 3u) && allOk;
	allOk = compare_uint((var[2][0][1]), 7u) && allOk;
	allOk = compare_uint((var[2][1][0]), 7u) && allOk;
	allOk = compare_uint((var[2][1][1]), 5u) && allOk;
	allOk = compare_uint((var[2][2][0]), 0u) && allOk;
	allOk = compare_uint((var[2][2][1]), 1u) && allOk;
	allOk = compare_uint((var[2][3][0]), 7u) && allOk;
	allOk = compare_uint((var[2][3][1]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (7u);
	var[0][0][1] = (9u);
	var[0][1][0] = (4u);
	var[0][1][1] = (8u);
	var[0][2][0] = (7u);
	var[0][2][1] = (8u);
	var[0][3][0] = (6u);
	var[0][3][1] = (8u);
	var[1][0][0] = (1u);
	var[1][0][1] = (0u);
	var[1][1][0] = (7u);
	var[1][1][1] = (5u);
	var[1][2][0] = (6u);
	var[1][2][1] = (1u);
	var[1][3][0] = (6u);
	var[1][3][1] = (2u);
	var[2][0][0] = (7u);
	var[2][0][1] = (7u);
	var[2][1][0] = (7u);
	var[2][1][1] = (2u);
	var[2][2][0] = (9u);
	var[2][2][1] = (8u);
	var[2][3][0] = (5u);
	var[2][3][1] = (3u);
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(1.0, 1.0, -8.0, -2.0, -7.0, -1.0, 8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(5.0, -6.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(4, 1, 5));
	s.b[0] = (mat3(-4.0, 6.0, -4.0, -7.0, -1.0, -7.0, 1.0, -9.0, -4.0));
	s.b[1] = (mat3(-7.0, -5.0, -4.0, -3.0, -9.0, 3.0, 5.0, -9.0, 5.0));
	s.b[2] = (mat3(2.0, 5.0, -2.0, -1.0, 3.0, -7.0, -9.0, 4.0, 4.0));
	s.b[3] = (mat3(-6.0, 1.0, -9.0, -5.0, -7.0, 0.0, 0.0, -4.0, 2.0));
	s.c = (vec4(-8.0, -5.0, 2.0, 4.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(4, -9, 2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-4.0, 1.0, 2.0, 9.0, -7.0, -8.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(9.0, 0.0, 5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-6, -2, 3));
	s.b[0][0] = (vec3(4.0, 0.0, -1.0));
	s.b[0][1] = (vec3(-9.0, -8.0, 0.0));
	s.b[0][2] = (vec3(7.0, 2.0, 7.0));
	s.b[1][0] = (vec3(-7.0, 5.0, 1.0));
	s.b[1][1] = (vec3(-7.0, -6.0, -4.0));
	s.b[1][2] = (vec3(-5.0, 1.0, -1.0));
	s.b[2][0] = (vec3(7.0, -4.0, 6.0));
	s.b[2][1] = (vec3(-5.0, 7.0, 1.0));
	s.b[2][2] = (vec3(-5.0, 3.0, 8.0));
	s.b[3][0] = (vec3(9.0, -2.0, -6.0));
	s.b[3][1] = (vec3(1.0, 1.0, -5.0));
	s.b[3][2] = (vec3(-7.0, 4.0, 7.0));
	s.c = (vec4(-6.0, 2.0, 7.0, 6.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-8, 6, -5)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-9.0, -4.0, 2.0, -6.0, 5.0, -9.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-7.0, -3.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(2, -3, 7));
	s.b[0][0] = (vec3(0.0, -9.0, 6.0));
	s.b[0][1] = (vec3(1.0, -9.0, -8.0));
	s.b[0][2] = (vec3(-6.0, 5.0, 4.0));
	s.b[1][0] = (vec3(-2.0, -8.0, 3.0));
	s.b[1][1] = (vec3(7.0, -4.0, -3.0));
	s.b[1][2] = (vec3(-3.0, -4.0, 2.0));
	s.b[2][0] = (vec3(-2.0, -8.0, -5.0));
	s.b[2][1] = (vec3(6.0, -2.0, -5.0));
	s.b[2][2] = (vec3(-2.0, 3.0, -7.0));
	s.b[3][0] = (vec3(5.0, 8.0, 0.0));
	s.b[3][1] = (vec3(4.0, -4.0, -7.0));
	s.b[3][2] = (vec3(-7.0, 1.0, 5.0));
	s.c = (vec4(2.0, 0.0, -9.0, -6.0));
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(-9, 2, -4)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(-3.0, -9.0, 5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(-5.0, 5.0, 3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-4.0, -5.0, 7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(2.0, -1.0, 9.0, 0.0, 5.0, 8.0, 0.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(1, 2, 9)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(3.0, 4.0, 6.0, -9.0, 1.0, 1.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(6.0, -2.0, -8.0, 3.0, -3.0, -9.0, -3.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(7.0, 3.0, 4.0, -1.0, -1.0, -3.0, 4.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(8.0, 7.0, 0.0, 5.0, 0.0, 7.0, -7.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(-3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(-7, -8, -6)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(-2.0, -5.0, -7.0, -4.0, -9.0, 2.0, -7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(-6.0, -8.0, 2.0, -2.0, -4.0, -6.0, 6.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(7.0, 8.0, 9.0, -9.0, 6.0, -8.0, 1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(4.0, 1.0, 3.0, -2.0, -4.0, -4.0, 8.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-1.0, -1.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(-2, 3, 4));
	s[0].b[0][0] = (vec3(2.0, 7.0, -7.0));
	s[0].b[0][1] = (vec3(5.0, 1.0, -7.0));
	s[0].b[0][2] = (vec3(-6.0, -4.0, -5.0));
	s[0].b[1][0] = (vec3(1.0, -1.0, 7.0));
	s[0].b[1][1] = (vec3(-4.0, 6.0, -5.0));
	s[0].b[1][2] = (vec3(7.0, 1.0, -5.0));
	s[0].b[2][0] = (vec3(3.0, 8.0, 9.0));
	s[0].b[2][1] = (vec3(-2.0, -6.0, 1.0));
	s[0].b[2][2] = (vec3(1.0, -5.0, -7.0));
	s[0].b[3][0] = (vec3(4.0, 7.0, -6.0));
	s[0].b[3][1] = (vec3(2.0, 7.0, 6.0));
	s[0].b[3][2] = (vec3(-1.0, -3.0, 7.0));
	s[0].c = (vec4(-2.0, 6.0, -9.0, -1.0));
	s[1].a = (ivec3(0, -1, -9));
	s[1].b[0][0] = (vec3(8.0, -8.0, -1.0));
	s[1].b[0][1] = (vec3(-2.0, 9.0, 3.0));
	s[1].b[0][2] = (vec3(2.0, 1.0, 6.0));
	s[1].b[1][0] = (vec3(6.0, 6.0, 8.0));
	s[1].b[1][1] = (vec3(-2.0, -2.0, -7.0));
	s[1].b[1][2] = (vec3(0.0, -8.0, 8.0));
	s[1].b[2][0] = (vec3(-5.0, 7.0, -9.0));
	s[1].b[2][1] = (vec3(-7.0, -2.0, 4.0));
	s[1].b[2][2] = (vec3(-3.0, -1.0, -4.0));
	s[1].b[3][0] = (vec3(-1.0, 0.0, -1.0));
	s[1].b[3][1] = (vec3(1.0, 1.0, -7.0));
	s[1].b[3][2] = (vec3(6.0, -1.0, 7.0));
	s[1].c = (vec4(-6.0, -2.0, -2.0, 9.0));
	s[2].a = (ivec3(-8, 0, 7));
	s[2].b[0][0] = (vec3(8.0, 3.0, -2.0));
	s[2].b[0][1] = (vec3(-1.0, -9.0, 4.0));
	s[2].b[0][2] = (vec3(-5.0, -4.0, 9.0));
	s[2].b[1][0] = (vec3(-5.0, 9.0, 4.0));
	s[2].b[1][1] = (vec3(-5.0, 2.0, -8.0));
	s[2].b[1][2] = (vec3(3.0, 1.0, 3.0));
	s[2].b[2][0] = (vec3(1.0, 5.0, -6.0));
	s[2].b[2][1] = (vec3(-7.0, 2.0, 0.0));
	s[2].b[2][2] = (vec3(-5.0, 0.0, 9.0));
	s[2].b[3][0] = (vec3(8.0, 7.0, -7.0));
	s[2].b[3][1] = (vec3(4.0, -2.0, -8.0));
	s[2].b[3][2] = (vec3(-6.0, -1.0, 7.0));
	s[2].c = (vec4(-7.0, 5.0, 3.0, -7.0));
	v = (vec4(0.0, -6.0, 4.0, -7.0));
}
#version 450
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
	lowp uint u;
	S s[3];
	mediump vec4 v;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0].a), ivec3(8, 0, -9)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(9.0, 3.0, -2.0, -6.0, 3.0, -7.0, -5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-4.0, -2.0, 5.0, 0.0, 0.0, -6.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-4.0, 0.0, -4.0, -8.0, 7.0, 8.0, 3.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(6.0, -9.0, 7.0, 8.0, 9.0, -3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-7.0, 7.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-5, 4, -2)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(8.0, -1.0, 6.0, 0.0, 4.0, 9.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-1.0, 8.0, 4.0, -3.0, -6.0, 6.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-8.0, -7.0, -4.0, 6.0, -5.0, 6.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-3.0, -8.0, -6.0, -4.0, -2.0, 6.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-4.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-7, 9, -8)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(6.0, 3.0, -7.0, 9.0, 2.0, 5.0, 9.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(3.0, 9.0, 3.0, -6.0, 0.0, 6.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-5.0, -5.0, 5.0, 2.0, -2.0, 9.0, 7.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(5.0, 2.0, 1.0, -6.0, 7.0, 0.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(9.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(4, -1, 1)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-4.0, 1.0, 6.0, 3.0, 9.0, -4.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-2.0, 7.0, -6.0, 1.0, -4.0, -1.0, 6.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(4.0, -6.0, -6.0, 1.0, 7.0, -6.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(1.0, -1.0, 1.0, 0.0, 9.0, -8.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(-3.0, -5.0, 3.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(1, -7, 6)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-7.0, 9.0, -3.0, 5.0, -5.0, -4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(4.0, 3.0, 1.0, -6.0, 2.0, 3.0, 5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(8.0, -8.0, -7.0, 7.0, -1.0, -7.0, -9.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-7.0, -1.0, -6.0, -6.0, 8.0, 2.0, 9.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(5.0, -2.0, 5.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-7, 3, 5)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-1.0, 4.0, -5.0, 2.0, -4.0, -9.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-7.0, 1.0, 2.0, -3.0, -3.0, -1.0, 7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(7.0, 8.0, -7.0, -5.0, 2.0, -2.0, 4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-3.0, 8.0, 2.0, -6.0, -8.0, -1.0, -4.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(8.0, -8.0, 4.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(1, 3, -2)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-9.0, -6.0, 0.0, -2.0, -9.0, 9.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-5.0, 8.0, 9.0, -4.0, -5.0, 5.0, 6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(7.0, -4.0, 7.0, 5.0, 0.0, -6.0, -8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-9.0, -7.0, -3.0, -3.0, 1.0, 7.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(8.0, 0.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-1, -4, 8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(8.0, -2.0, -1.0, 0.0, -4.0, 3.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(2.0, -6.0, 5.0, 0.0, 4.0, 1.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(2.0, 1.0, -3.0, 0.0, 9.0, 7.0, -9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(8.0, 4.0, -9.0, -3.0, 0.0, 3.0, -6.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(7.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-4, 8, 0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-2.0, -5.0, 9.0, 7.0, -6.0, -3.0, -2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(7.0, 0.0, 3.0, 8.0, -5.0, 9.0, -5.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(7.0, 1.0, 5.0, -3.0, -5.0, -6.0, -9.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-8.0, 5.0, 4.0, -8.0, 3.0, -6.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-8.0, 8.0, 0.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-5, 3, 4));
	block[0].s[0].b[0] = (mat3(-3.0, -8.0, 9.0, 5.0, 0.0, -1.0, 6.0, 9.0, -7.0));
	block[0].s[0].b[1] = (mat3(-2.0, 1.0, -6.0, -5.0, 3.0, 8.0, -6.0, 6.0, 1.0));
	block[0].s[0].b[2] = (mat3(-8.0, 5.0, -6.0, -4.0, 9.0, 4.0, 0.0, 5.0, 3.0));
	block[0].s[0].b[3] = (mat3(-9.0, -6.0, -3.0, -3.0, -9.0, 6.0, -5.0, -7.0, 6.0));
	block[0].s[0].c = (vec4(-6.0, 3.0, 6.0, -1.0));
	block[0].s[1].a = (ivec3(8, -9, -3));
	block[0].s[1].b[0] = (mat3(3.0, 4.0, 6.0, 7.0, 8.0, 5.0, 1.0, 2.0, 4.0));
	block[0].s[1].b[1] = (mat3(-6.0, -7.0, -6.0, -2.0, 9.0, 0.0, -6.0, -7.0, 7.0));
	block[0].s[1].b[2] = (mat3(-5.0, 5.0, 9.0, 7.0, -2.0, -9.0, -2.0, 6.0, 8.0));
	block[0].s[1].b[3] = (mat3(1.0, -5.0, -4.0, 0.0, 2.0, -1.0, 1.0, 5.0, 2.0));
	block[0].s[1].c = (vec4(6.0, 6.0, -7.0, 7.0));
	block[0].s[2].a = (ivec3(-2, -7, 1));
	block[0].s[2].b[0] = (mat3(4.0, 5.0, 8.0, 6.0, 7.0, 9.0, -1.0, 5.0, 5.0));
	block[0].s[2].b[1] = (mat3(-6.0, -7.0, -4.0, 2.0, -1.0, 5.0, -3.0, 3.0, 4.0));
	block[0].s[2].b[2] = (mat3(0.0, 3.0, -5.0, 0.0, -7.0, 1.0, -7.0, -8.0, -3.0));
	block[0].s[2].b[3] = (mat3(0.0, 7.0, 9.0, 9.0, 1.0, -4.0, 2.0, 4.0, -1.0));
	block[0].s[2].c = (vec4(2.0, -2.0, -8.0, 6.0));
	block[0].v = (vec4(6.0, 9.0, -8.0, -9.0));
	block[1].s[0].a = (ivec3(3, -5, 7));
	block[1].s[0].b[0] = (mat3(1.0, 6.0, -6.0, 3.0, -3.0, -9.0, 3.0, 6.0, 9.0));
	block[1].s[0].b[1] = (mat3(6.0, 4.0, -9.0, 7.0, -2.0, 1.0, 2.0, -6.0, 2.0));
	block[1].s[0].b[2] = (mat3(3.0, -3.0, 8.0, 1.0, 0.0, -1.0, 8.0, -9.0, -5.0));
	block[1].s[0].b[3] = (mat3(9.0, 6.0, -1.0, -5.0, -8.0, 3.0, -3.0, -3.0, -7.0));
	block[1].s[0].c = (vec4(2.0, -9.0, -4.0, -6.0));
	block[1].s[1].a = (ivec3(4, 3, 0));
	block[1].s[1].b[0] = (mat3(0.0, -4.0, -4.0, -9.0, -8.0, 9.0, -2.0, 4.0, 0.0));
	block[1].s[1].b[1] = (mat3(1.0, 8.0, 5.0, -6.0, -6.0, 2.0, 0.0, -2.0, -4.0));
	block[1].s[1].b[2] = (mat3(1.0, 7.0, -5.0, 5.0, -4.0, -1.0, -2.0, -3.0, -6.0));
	block[1].s[1].b[3] = (mat3(9.0, 6.0, -4.0, 2.0, 6.0, 1.0, 4.0, 6.0, 9.0));
	block[1].s[1].c = (vec4(2.0, 3.0, -4.0, 6.0));
	block[1].s[2].a = (ivec3(-5, 1, -6));
	block[1].s[2].b[0] = (mat3(4.0, 4.0, -5.0, 8.0, -5.0, -4.0, 6.0, 0.0, 7.0));
	block[1].s[2].b[1] = (mat3(-3.0, 1.0, 2.0, 3.0, 4.0, 5.0, 4.0, -5.0, -3.0));
	block[1].s[2].b[2] = (mat3(-5.0, 1.0, -1.0, -7.0, 3.0, -5.0, -6.0, -1.0, -1.0));
	block[1].s[2].b[3] = (mat3(-4.0, -6.0, -8.0, 3.0, 4.0, 1.0, 0.0, 8.0, -4.0));
	block[1].s[2].c = (vec4(4.0, -4.0, -9.0, -2.0));
	block[1].v = (vec4(3.0, 6.0, -5.0, 7.0));
	block[2].s[0].a = (ivec3(-6, 1, -4));
	block[2].s[0].b[0] = (mat3(-5.0, -2.0, -1.0, 0.0, 2.0, -9.0, 8.0, -9.0, -2.0));
	block[2].s[0].b[1] = (mat3(-2.0, -8.0, -7.0, 7.0, -8.0, -5.0, 2.0, 5.0, 9.0));
	block[2].s[0].b[2] = (mat3(-9.0, 9.0, 3.0, -1.0, 3.0, -9.0, -8.0, 3.0, 5.0));
	block[2].s[0].b[3] = (mat3(7.0, -4.0, -1.0, -9.0, -6.0, -5.0, 6.0, -6.0, -2.0));
	block[2].s[0].c = (vec4(4.0, -1.0, 6.0, 5.0));
	block[2].s[1].a = (ivec3(-9, 7, 4));
	block[2].s[1].b[0] = (mat3(-2.0, 2.0, 1.0, -8.0, -6.0, 6.0, -2.0, -1.0, -5.0));
	block[2].s[1].b[1] = (mat3(-2.0, 3.0, 5.0, 5.0, 6.0, -9.0, -1.0, -6.0, 7.0));
	block[2].s[1].b[2] = (mat3(3.0, 3.0, -5.0, 5.0, 2.0, 4.0, 1.0, 5.0, -5.0));
	block[2].s[1].b[3] = (mat3(2.0, -4.0, 1.0, 5.0, 7.0, 3.0, 3.0, -6.0, -7.0));
	block[2].s[1].c = (vec4(-6.0, 6.0, -2.0, -5.0));
	block[2].s[2].a = (ivec3(-4, 0, 6));
	block[2].s[2].b[0] = (mat3(9.0, -8.0, 9.0, -4.0, -9.0, 1.0, -8.0, -7.0, -5.0));
	block[2].s[2].b[1] = (mat3(3.0, 0.0, 1.0, -1.0, -6.0, 6.0, 5.0, 4.0, 8.0));
	block[2].s[2].b[2] = (mat3(-8.0, -4.0, -6.0, 7.0, -1.0, -3.0, 7.0, -3.0, -7.0));
	block[2].s[2].b[3] = (mat3(6.0, -5.0, 7.0, -8.0, 8.0, 1.0, -5.0, 5.0, 7.0));
	block[2].s[2].c = (vec4(4.0, -1.0, 2.0, 3.0));
	block[2].v = (vec4(2.0, 7.0, -1.0, 0.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_ivec3((s[0][0].a), ivec3(2, -3, 7)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(-9.0, -6.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-3, 5, 2)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(-9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(6, 5, 3)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(9.0, 3.0, -1.0, 0.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(6, -8, 2)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(7.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-1, 8, 6)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(1, 5, -2)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(9.0, -2.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(7.0, -4.0, -7.0, 3.0));
	s[0][0].a = (ivec3(2, 8, 2));
	s[0][0].c = (vec4(9.0, 2.0, -1.0, -2.0));
	s[0][1].a = (ivec3(9, -1, 1));
	s[0][1].c = (vec4(7.0, -1.0, -6.0, -7.0));
	s[1][0].a = (ivec3(-9, 5, -5));
	s[1][0].c = (vec4(5.0, 9.0, -5.0, -8.0));
	s[1][1].a = (ivec3(-8, 9, 7));
	s[1][1].c = (vec4(7.0, 6.0, 8.0, 2.0));
	s[2][0].a = (ivec3(3, -9, 6));
	s[2][0].c = (vec4(-7.0, -6.0, -9.0, 0.0));
	s[2][1].a = (ivec3(8, -1, 0));
	s[2][1].c = (vec4(-4.0, 5.0, 4.0, 1.0));
}
#version 450
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
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block[0].var, mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block[1].var = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block[2].var = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
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
} block[3];

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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat4x3 var;
} block[3];

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

layout(scalar, binding = 1) buffer Block
{
	uint padding;
	highp uvec2 var;
} block[3];

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].padding), 6u) && allOk;
	allOk = compare_uvec2((block[0].var), uvec2(0u, 6u)) && allOk;
	allOk = compare_uint((block[1].padding), 7u) && allOk;
	allOk = compare_uvec2((block[1].var), uvec2(1u, 7u)) && allOk;
	allOk = compare_uint((block[2].padding), 9u) && allOk;
	allOk = compare_uvec2((block[2].var), uvec2(0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6u);
	block[0].var = (uvec2(1u, 8u));
	block[1].padding = (1u);
	block[1].var = (uvec2(7u, 4u));
	block[2].padding = (6u);
	block[2].var = (uvec2(6u, 5u));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-4.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(4.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(8.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 3.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 7.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-8.0);
	block[0].var[0] = (vec2(-4.0, -3.0));
	block[0].var[1] = (vec2(5.0, -9.0));
	block[0].var[2] = (vec2(4.0, -2.0));
	block[1].padding = (-1.0);
	block[1].var[0] = (vec2(8.0, 3.0));
	block[1].var[1] = (vec2(7.0, 2.0));
	block[1].var[2] = (vec2(-4.0, 4.0));
	block[2].padding = (3.0);
	block[2].var[0] = (vec2(-6.0, -4.0));
	block[2].var[1] = (vec2(3.0, 4.0));
	block[2].var[2] = (vec2(6.0, 3.0));
}
#version 450
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
} blockA;
layout(std140, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
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
	allOk = compare_float((blockA.a), 6.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-3.0, 2.0, -9.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(2, 4)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (2.0);
	blockB.a = (mat3(-1.0, -9.0, 2.0, -5.0, 6.0, -6.0, -5.0, -4.0, -9.0));
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
	allOk = compare_float((blockA.a), 4.0) && allOk;
	allOk = compare_uint((blockB.b.a), 6u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(-3, 6)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(2.0, 5.0, -4.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-8.0);
	blockA.b.a = (mat3(8.0, -7.0, -9.0, 5.0, 2.0, 9.0, -9.0, -9.0, 0.0));
	blockA.b.b[0] = (ivec2(-3, 7));
	blockA.b.b[1] = (ivec2(-9, 8));
	blockA.b.b[2] = (ivec2(-2, 5));
	blockA.b.b[3] = (ivec2(1, 6));
	blockA.b.c = (vec4(4.0, -5.0, -1.0, -2.0));
	blockB.a = (mat2(-2.0, -9.0, 9.0, 9.0));
	blockB.b.a = (4u);
	blockB.b.b.a = (mat3(-5.0, 0.0, 4.0, 6.0, 5.0, -6.0, -8.0, 4.0, -6.0));
	blockB.b.b.b[0] = (ivec2(-1, 8));
	blockB.b.b.b[1] = (ivec2(-1, 6));
	blockB.b.b.b[2] = (ivec2(-2, 7));
	blockB.b.b.b[3] = (ivec2(-9, -6));
	blockB.b.b.c = (vec4(-6.0, 3.0, -3.0, 8.0));
	blockB.b.c = (bvec4(true, true, true, false));
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
	lowp float b;
	mediump uint c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp int d;
	highp uint e;
	mediump int f;
	mediump uint g;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp uint h;
	bool i;
	highp int j;
	bool k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_float((blockB.b), -6.0) && allOk;
	allOk = compare_uint((blockB.c), 0u) && allOk;
	allOk = compare_int((blockC.d), -1) && allOk;
	allOk = compare_uint((blockC.e), 5u) && allOk;
	allOk = compare_int((blockC.f), 5) && allOk;
	allOk = compare_uint((blockC.g), 3u) && allOk;
	allOk = compare_uint((blockD.h), 2u) && allOk;
	allOk = compare_bool((blockD.i), true) && allOk;
	allOk = compare_int((blockD.j), -8) && allOk;
	allOk = compare_bool((blockD.k), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (5.0);
	blockB.c = (8u);
	blockC.e = (4u);
	blockC.f = (-8);
	blockC.g = (2u);
	blockD.i = (true);
	blockD.k = (true);
}
#version 450
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
	lowp int b;
	bool c;
	highp int d;
	bool e[1];
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	bool f;
	mediump float g;
};
layout(std140, binding = 3) buffer BlockD
{
	mediump int h;
	bool i;
	bool j;
	lowp float k;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	lowp uint l;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.d), -7) && allOk;
	allOk = compare_bool((f), false) && allOk;
	allOk = compare_float((g), -4.0) && allOk;
	allOk = compare_int((blockD.h), -9) && allOk;
	allOk = compare_uint((blockE.l), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9.0);
	blockB.c = (false);
	blockB.d = (-9);
	blockD.h = (8);
	blockD.i = (true);
	blockD.k = (9.0);
	blockE.l = (6u);
}
#version 450
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
	mediump ivec4 b;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump uvec2 c;
	lowp int d;
	bvec2 e;
	highp ivec2 f;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump ivec3 g;
} blockD;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.c), uvec2(9u, 7u)) && allOk;
	allOk = compare_int((blockC.d), 9) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(false, false)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(3, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-7);
	b = (ivec4(4, -4, -7, -3));
	blockC.e = (bvec2(true, true));
	blockD.g = (ivec3(-9, -7, 3));
}
#version 450
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
	mediump mat4x2 c;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp uvec2 d;
	lowp mat2 e;
	mediump ivec2 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((b), uvec2(7u, 6u)) && allOk;
	allOk = compare_uvec2((d), uvec2(9u, 4u)) && allOk;
	allOk = compare_mat2(e, mat2(6.0, 5.0, -8.0, -6.0)) && allOk;
	allOk = compare_ivec2((f), ivec2(5, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2x3(6.0, 5.0, -7.0, 0.0, 1.0, -3.0));
	b = (uvec2(9u, 3u));
	c = (mat4x2(-9.0, -9.0, 8.0, 5.0, 0.0, 4.0, -8.0, -2.0));
	d = (uvec2(1u, 7u));
	f = (ivec2(-9, 3));
}
#version 450
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
	mediump ivec4 a;
	mediump mat4x3 b;
	bvec3 c[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump ivec4 d;
	bvec2 e;
	bvec2 f[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump uvec4 g;
	highp int h[2];
	highp mat2 i[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	mediump ivec2 j;
	highp uint k;
	highp mat2 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.c[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.c[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.c[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.c[3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.c[4]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.c[5]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.c[6]), bvec3(true, true, true)) && allOk;
	allOk = compare_ivec4((blockC.d), ivec4(9, 7, 3, -3)) && allOk;
	allOk = compare_bvec2((blockC.f[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.f[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.f[2]), bvec2(true, false)) && allOk;
	allOk = compare_mat2(blockD.i[0], mat2(0.0, -1.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2(blockD.i[1], mat2(-2.0, 1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2(blockD.i[2], mat2(-9.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(blockD.i[3], mat2(-3.0, -3.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(blockD.i[4], mat2(-8.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(blockD.i[5], mat2(-6.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockE.j), ivec2(5, 5)) && allOk;
	allOk = compare_mat2(blockE.l[0], mat2(2.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(blockE.l[1], mat2(6.0, -9.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(blockE.l[2], mat2(0.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2(blockE.l[3], mat2(-5.0, -9.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(blockE.l[4], mat2(7.0, -1.0, -7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(8, 9, -5, 5));
	blockB.b = (mat4x3(-4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0));
	blockC.e = (bvec2(true, true));
	blockD.h[0] = (-2);
	blockD.h[1] = (-3);
	blockE.j = (ivec2(-2, -8));
	blockE.k = (0u);
	blockE.l[0] = (mat2(-6.0, -5.0, -6.0, -7.0));
	blockE.l[1] = (mat2(-5.0, 9.0, 6.0, 8.0));
	blockE.l[2] = (mat2(0.0, 1.0, 0.0, -7.0));
	blockE.l[3] = (mat2(8.0, 5.0, -1.0, 3.0));
	blockE.l[4] = (mat2(-2.0, -5.0, -7.0, 9.0));
}
#version 450
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
	mediump mat3x2 a;
	highp float b;
	bool c;
	bvec3 d;
	lowp ivec2 e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp ivec2 f;
	bool g;
	bool h[];
};
layout(std140, binding = 3) buffer BlockD
{
	lowp int i;
	lowp uvec2 j[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	bvec2 k;
	highp uvec2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(2.0, -3.0, 2.0, -4.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockB.e), ivec2(8, 7)) && allOk;
	allOk = compare_ivec2((f), ivec2(3, 3)) && allOk;
	allOk = compare_bool((h[0]), true) && allOk;
	allOk = compare_bool((h[1]), false) && allOk;
	allOk = compare_uvec2((l[0]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((l[1]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((l[2]), uvec2(7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(8.0, 7.0, -2.0, 6.0, 0.0, 5.0));
	blockB.b = (9.0);
	blockB.e = (ivec2(5, 8));
	g = (true);
	h[0] = (true);
	h[1] = (true);
	blockD.j[0] = (uvec2(2u, 6u));
	k = (bvec2(true, false));
}
#version 450
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
	mediump uvec3 a;
	lowp int b;
	bvec4 c[];
} blockB[2];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[0].c[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(2u, 5u, 5u)) && allOk;
	allOk = compare_bvec4((blockB[1].c[0]), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(3u, 1u, 6u));
	blockB[0].c[0] = (bvec4(true, true, false, true));
	blockB[1].a = (uvec3(7u, 9u, 6u));
	blockB[1].c[0] = (bvec4(true, false, false, false));
}
#version 450
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
	lowp uvec3 a;
	mediump ivec4 b;
	bvec2 c;
	mediump mat2x3 d[];
} blockB[1];
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp uvec4 e[];
} blockC[2];

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

struct sA
{
	lowp mat3 mA;
};
struct sB
{
	lowp mat3x2 mA;
	lowp uint mB;
};
struct sC
{
	lowp mat2x3 mA;
};
struct sD
{
	sB mA;
	lowp ivec4 mB;
	mediump vec3 mC;
	sC mD[3];
};
struct sE
{
	highp mat3x2 mA;
	bool mB;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump vec4 a[1];
	sA b;
	highp mat4x3 c;
	bvec4 d;
	bvec3 e[][5];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec4 f;
	sD g[1];
	mediump ivec2 h[];
} blockC;
layout(std430, column_major, binding = 3) readonly buffer BlockD
{
	lowp mat2x3 i[];
};
layout(std430, binding = 4) buffer BlockE
{
	lowp mat4x2 j;
	highp vec4 k;
	sE l;
	lowp ivec3 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b.mA, mat3(0.0, -5.0, 3.0, -3.0, -2.0, 6.0, 1.0, -7.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[0][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[0][3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.e[0][4]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.e[1][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[1][1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[1][2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[1][3]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[1][4]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[2][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[2][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[2][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[2][3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[2][4]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[3][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[3][1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[3][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[3][3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.e[3][4]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[4][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[4][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[4][2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[4][3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[4][4]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[5][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[5][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[5][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[5][3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[5][4]), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec2((blockC.h[0]), ivec2(-6, 8)) && allOk;
	allOk = compare_mat4x2(j, mat4x2(2.0, -1.0, 0.0, 7.0, 2.0, -8.0, -7.0, -3.0)) && allOk;
	allOk = compare_vec4((k), vec4(-9.0, -1.0, -4.0, -8.0)) && allOk;
	allOk = compare_ivec3((m[0]), ivec3(-7, 8, 9)) && allOk;
	allOk = compare_ivec3((m[1]), ivec3(4, -7, -8)) && allOk;
	allOk = compare_ivec3((m[2]), ivec3(5, 4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (mat3(-5.0, -1.0, -4.0, -5.0, -9.0, -8.0, 0.0, 2.0, -4.0));
	blockB.d = (bvec4(true, false, true, false));
	blockB.e[0][0] = (bvec3(false, false, false));
	blockB.e[0][1] = (bvec3(false, false, true));
	blockB.e[0][2] = (bvec3(false, true, true));
	blockB.e[0][3] = (bvec3(false, true, true));
	blockB.e[0][4] = (bvec3(true, false, false));
	blockB.e[1][0] = (bvec3(true, true, false));
	blockB.e[1][1] = (bvec3(true, true, false));
	blockB.e[1][2] = (bvec3(true, false, false));
	blockB.e[1][3] = (bvec3(true, true, true));
	blockB.e[1][4] = (bvec3(true, true, true));
	blockB.e[2][0] = (bvec3(true, true, true));
	blockB.e[2][1] = (bvec3(false, true, true));
	blockB.e[2][2] = (bvec3(false, true, false));
	blockB.e[2][3] = (bvec3(false, false, true));
	blockB.e[2][4] = (bvec3(false, true, true));
	blockB.e[3][0] = (bvec3(false, false, false));
	blockB.e[3][1] = (bvec3(false, false, true));
	blockB.e[3][2] = (bvec3(false, true, false));
	blockB.e[3][3] = (bvec3(false, false, false));
	blockB.e[3][4] = (bvec3(true, true, true));
	blockB.e[4][0] = (bvec3(true, true, false));
	blockB.e[4][1] = (bvec3(false, false, true));
	blockB.e[4][2] = (bvec3(false, true, true));
	blockB.e[4][3] = (bvec3(false, false, false));
	blockB.e[4][4] = (bvec3(true, true, true));
	blockB.e[5][0] = (bvec3(true, true, false));
	blockB.e[5][1] = (bvec3(true, true, true));
	blockB.e[5][2] = (bvec3(true, true, false));
	blockB.e[5][3] = (bvec3(false, true, true));
	blockB.e[5][4] = (bvec3(true, false, true));
	blockC.g[0].mA.mA = (mat3x2(-8.0, -4.0, 8.0, 6.0, 8.0, -2.0));
	blockC.g[0].mA.mB = (0u);
	blockC.g[0].mB = (ivec4(6, 5, -3, 2));
	blockC.g[0].mC = (vec3(2.0, 8.0, 8.0));
	blockC.g[0].mD[0].mA = (mat2x3(1.0, -5.0, 3.0, -4.0, -5.0, 3.0));
	blockC.g[0].mD[1].mA = (mat2x3(-8.0, 6.0, 7.0, 6.0, 3.0, -6.0));
	blockC.g[0].mD[2].mA = (mat2x3(-7.0, 4.0, 3.0, 4.0, -2.0, 2.0));
	blockC.h[0] = (ivec2(6, -3));
	k = (vec4(-7.0, 8.0, -7.0, 2.0));
	l.mA = (mat3x2(8.0, -1.0, 6.0, -4.0, -9.0, 7.0));
	l.mB = (false);
	m[0] = (ivec3(-2, 9, 5));
	m[1] = (ivec3(-2, 9, 4));
	m[2] = (ivec3(4, -3, -4));
}
#version 450
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
	layout(offset = 0) mediump ivec2 a;
	layout(offset = 8) highp float b;
	layout(offset = 12) bool c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec3 d;
	layout(offset = 16) lowp ivec2 e;
	layout(offset = 24) lowp vec2 f[1];
	layout(offset = 32) mediump ivec2 g;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec4 h;
	layout(offset = 16) highp uvec4 i;
	layout(offset = 32) mediump ivec2 j;
	layout(offset = 48) lowp uvec3 k;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp vec4 l[1];
	layout(offset = 16) lowp uvec2 m;
	layout(offset = 32) highp ivec4 n;
	layout(offset = 48) lowp float o[1];
	layout(offset = 52) lowp ivec3 p;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(0, -6)) && allOk;
	allOk = compare_float((blockB.b), 9.0) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_vec2((blockC[0].f[0]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g), ivec2(-2, -2)) && allOk;
	allOk = compare_vec2((blockC[1].f[0]), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockC[1].g), ivec2(3, -7)) && allOk;
	allOk = compare_uvec4((i), uvec4(1u, 2u, 5u, 8u)) && allOk;
	allOk = compare_ivec2((j), ivec2(0, 2)) && allOk;
	allOk = compare_vec4((blockE[0].l[0]), vec4(-6.0, 7.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-9.0);
	blockB.c = (false);
	blockC[0].d = (vec3(9.0, 2.0, -6.0));
	blockC[0].e = (ivec2(6, -6));
	blockC[0].g = (ivec2(-8, -7));
	blockC[1].d = (vec3(-8.0, 3.0, -6.0));
	blockC[1].e = (ivec2(-9, 9));
	blockC[1].g = (ivec2(8, -1));
	h = (vec4(-4.0, 0.0, -4.0, 2.0));
	j = (ivec2(-2, -6));
	k = (uvec3(0u, 4u, 1u));
	blockE[0].l[0] = (vec4(2.0, 0.0, 0.0, 2.0));
	blockE[0].m = (uvec2(3u, 6u));
	blockE[0].n = (ivec4(-3, -3, 0, 8));
	blockE[0].o[0] = (-9.0);
	blockE[0].p = (ivec3(2, -4, 1));
}
#version 450
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
	layout(offset = 16) lowp uint b;
	layout(offset = 32) highp vec4 c;
	layout(offset = 48) mediump uint d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec3 e;
	layout(offset = 12) bool f;
	layout(offset = 16) bvec4 g;
	layout(offset = 32) bvec2 h;
	layout(offset = 40) mediump uint i[1];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uint((blockB.b), 4u) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-6.0, -8.0, 6.0, -6.0)) && allOk;
	allOk = compare_uint((blockB.d), 9u) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockC.h), bvec2(false, false)) && allOk;
	allOk = compare_uint((blockC.i[0]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (8u);
	blockC.e = (uvec3(9u, 9u, 2u));
	blockC.f = (false);
	blockC.g = (bvec4(true, true, true, true));
	blockC.i[0] = (6u);
}
#version 450
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
	layout(offset = 16) highp vec4 b;
	layout(offset = 32) highp ivec2 c;
	layout(offset = 48) mediump ivec4 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-9.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((blockB.b), vec4(3.0, -9.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(5, 2)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-4, -5, -7, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-4.0, -3.0, -2.0, 6.0));
	blockB.b = (vec4(-5.0, 6.0, -3.0, -4.0));
	blockB.c = (ivec2(-4, -2));
	blockB.d = (ivec4(-2, 1, -4, 8));
}
#version 450
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
	layout(offset = 16) highp vec2 b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec4 c;
	layout(offset = 16) mediump uvec4 d;
	layout(offset = 32) mediump uint e;
	layout(offset = 48) mediump uvec4 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 g;
	layout(offset = 8) highp uint h;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp uvec2 i;
	layout(offset = 8) mediump int j;
	layout(offset = 12) mediump int k[1];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(6.0, 7.0)) && allOk;
	allOk = compare_uint((blockC.e), 0u) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(2u, 1u, 6u, 3u)) && allOk;
	allOk = compare_uint((blockD.h), 6u) && allOk;
	allOk = compare_uvec2((blockE[0].i), uvec2(4u, 0u)) && allOk;
	allOk = compare_int((blockE[0].j), -8) && allOk;
	allOk = compare_uvec2((blockE[1].i), uvec2(4u, 2u)) && allOk;
	allOk = compare_int((blockE[1].j), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec2(1.0, -2.0));
	blockC.c = (uvec4(6u, 9u, 2u, 5u));
	blockC.d = (uvec4(8u, 4u, 3u, 2u));
	blockC.e = (7u);
	blockC.f = (uvec4(3u, 2u, 7u, 1u));
	blockD.g = (bvec2(false, false));
	blockD.h = (2u);
	blockE[0].i = (uvec2(8u, 8u));
	blockE[0].j = (-6);
	blockE[0].k[0] = (-9);
	blockE[1].i = (uvec2(5u, 9u));
	blockE[1].j = (-4);
	blockE[1].k[0] = (-7);
}
#version 450
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
	highp vec4 a;
	highp uint b;
	highp ivec2 c;
	mediump ivec4 d;
	lowp mat4x2 e[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	bvec3 f[7];
	mediump mat3 g[][1];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	bool h;
	lowp int i;
	bvec3 j;
	highp mat3x2 k[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(4.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_uint((b), 5u) && allOk;
	allOk = compare_ivec2((c), ivec2(6, -3)) && allOk;
	allOk = compare_int((blockD[0].i), 7) && allOk;
	allOk = compare_bvec3((blockD[0].j), bvec3(false, false, false)) && allOk;
	allOk = compare_int((blockD[1].i), -9) && allOk;
	allOk = compare_bvec3((blockD[1].j), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(8.0, -4.0, -1.0, -5.0));
	b = (8u);
	c = (ivec2(5, 8));
	d = (ivec4(9, 6, 7, 4));
	blockC.f[0] = (bvec3(true, false, true));
	blockC.f[1] = (bvec3(true, true, false));
	blockC.f[2] = (bvec3(true, true, false));
	blockC.f[3] = (bvec3(false, false, true));
	blockC.f[4] = (bvec3(true, true, true));
	blockC.f[5] = (bvec3(false, false, false));
	blockC.f[6] = (bvec3(false, true, false));
	blockC.g[0][0] = (mat3(-5.0, -4.0, -8.0, 7.0, 2.0, -2.0, 1.0, 4.0, 8.0));
	blockC.g[1][0] = (mat3(9.0, 6.0, -7.0, 5.0, -8.0, 7.0, 0.0, 9.0, 9.0));
	blockC.g[2][0] = (mat3(8.0, -1.0, -5.0, -1.0, 7.0, -4.0, -7.0, -7.0, -1.0));
	blockC.g[3][0] = (mat3(-1.0, 9.0, 6.0, 6.0, 8.0, -2.0, -4.0, 4.0, -5.0));
	blockC.g[4][0] = (mat3(-8.0, 3.0, -4.0, 9.0, 8.0, 8.0, 0.0, -6.0, 8.0));
	blockD[0].h = (false);
	blockD[0].i = (8);
	blockD[0].j = (bvec3(true, false, true));
	blockD[1].h = (true);
	blockD[1].i = (9);
	blockD[1].j = (bvec3(false, true, false));
}
#version 450
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
	highp mat2 mA;
	highp uvec4 mB;
};
struct sB
{
	sA mA;
	mediump mat4 mB;
	lowp mat4x3 mC;
	highp ivec4 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump uvec4 a[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	bvec3 b;
	lowp mat4 c;
	mediump mat3x4 d;
	sB e[];
} blockC[1];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp uvec2 f;
	highp uvec4 g;
	mediump int h[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	bvec2 i;
	highp vec4 j[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC[0].b), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3x4(blockC[0].d, mat3x4(0.0, 7.0, -5.0, -6.0, 7.0, -4.0, 0.0, 9.0, -7.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(blockC[0].e[0].mA.mA, mat2(-8.0, -2.0, 4.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[0].mA.mB), uvec4(0u, 4u, 6u, 3u)) && allOk;
	allOk = compare_mat4(blockC[0].e[0].mB, mat4(8.0, -6.0, -8.0, 0.0, -6.0, -3.0, -4.0, -5.0, 8.0, -8.0, -6.0, -8.0, 5.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[0].mC, mat4x3(-5.0, -8.0, -6.0, 5.0, -9.0, 9.0, 6.0, 1.0, 4.0, 2.0, 7.0, 3.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[0].mD), ivec4(3, 7, -2, -1)) && allOk;
	allOk = compare_mat2(blockC[0].e[1].mA.mA, mat2(-3.0, -5.0, 9.0, 4.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[1].mA.mB), uvec4(5u, 5u, 2u, 4u)) && allOk;
	allOk = compare_mat4(blockC[0].e[1].mB, mat4(2.0, -3.0, 6.0, 7.0, -1.0, 4.0, -4.0, 6.0, 0.0, -5.0, 1.0, 1.0, -9.0, 4.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[1].mC, mat4x3(-9.0, -6.0, 2.0, -2.0, 2.0, -4.0, -9.0, 0.0, -1.0, 7.0, -8.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[1].mD), ivec4(3, -1, 8, -3)) && allOk;
	allOk = compare_mat2(blockC[0].e[2].mA.mA, mat2(7.0, 3.0, -4.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[2].mA.mB), uvec4(3u, 6u, 6u, 9u)) && allOk;
	allOk = compare_mat4(blockC[0].e[2].mB, mat4(7.0, 4.0, 2.0, -1.0, 5.0, 0.0, -4.0, -8.0, -8.0, -7.0, 4.0, 8.0, -5.0, 5.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[2].mC, mat4x3(0.0, -1.0, -1.0, 2.0, 1.0, -4.0, 1.0, 0.0, 2.0, -1.0, 6.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[2].mD), ivec4(-1, 7, 5, -3)) && allOk;
	allOk = compare_mat2(blockC[0].e[3].mA.mA, mat2(-1.0, 6.0, 0.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[3].mA.mB), uvec4(8u, 2u, 5u, 3u)) && allOk;
	allOk = compare_mat4(blockC[0].e[3].mB, mat4(-5.0, -4.0, 6.0, -3.0, 6.0, 0.0, -5.0, 5.0, -7.0, 7.0, 9.0, -9.0, -1.0, -4.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[3].mC, mat4x3(8.0, -5.0, 2.0, 4.0, -1.0, 0.0, 8.0, -9.0, 8.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[3].mD), ivec4(-7, -5, 5, 5)) && allOk;
	allOk = compare_mat2(blockC[0].e[4].mA.mA, mat2(3.0, -7.0, -7.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[4].mA.mB), uvec4(3u, 7u, 6u, 5u)) && allOk;
	allOk = compare_mat4(blockC[0].e[4].mB, mat4(9.0, -7.0, 1.0, 1.0, -2.0, -7.0, 8.0, -4.0, 2.0, -2.0, -7.0, 2.0, -1.0, -1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[4].mC, mat4x3(-4.0, 5.0, 1.0, -4.0, 6.0, 3.0, -6.0, 4.0, -4.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[4].mD), ivec4(1, -9, 5, -7)) && allOk;
	allOk = compare_mat2(blockC[0].e[5].mA.mA, mat2(3.0, -6.0, 1.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[5].mA.mB), uvec4(6u, 5u, 7u, 5u)) && allOk;
	allOk = compare_mat4(blockC[0].e[5].mB, mat4(2.0, 4.0, 5.0, 0.0, -6.0, 1.0, 7.0, -7.0, 8.0, -3.0, -6.0, -5.0, 9.0, 3.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[5].mC, mat4x3(-4.0, -1.0, 0.0, -9.0, 7.0, 4.0, 0.0, -9.0, -1.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[5].mD), ivec4(6, 7, 8, -2)) && allOk;
	allOk = compare_mat2(blockC[0].e[6].mA.mA, mat2(4.0, 5.0, 5.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[6].mA.mB), uvec4(5u, 6u, 8u, 9u)) && allOk;
	allOk = compare_mat4(blockC[0].e[6].mB, mat4(-1.0, 7.0, -3.0, 9.0, -9.0, -1.0, 7.0, 8.0, -4.0, 9.0, -8.0, 7.0, 4.0, 8.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[6].mC, mat4x3(9.0, 7.0, 4.0, -9.0, 7.0, -5.0, 6.0, -4.0, 6.0, -2.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[6].mD), ivec4(-7, -7, -7, 0)) && allOk;
	allOk = compare_mat2(blockC[0].e[7].mA.mA, mat2(6.0, 2.0, -2.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[7].mA.mB), uvec4(0u, 7u, 2u, 6u)) && allOk;
	allOk = compare_mat4(blockC[0].e[7].mB, mat4(-5.0, 0.0, -2.0, -5.0, -9.0, 1.0, 8.0, 0.0, -4.0, -1.0, 4.0, 0.0, 3.0, 7.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[7].mC, mat4x3(-7.0, -2.0, 8.0, 6.0, 1.0, 4.0, 1.0, -3.0, -5.0, -4.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[7].mD), ivec4(-6, 0, -4, -2)) && allOk;
	allOk = compare_uvec2((f), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec4((g), uvec4(0u, 1u, 4u, 7u)) && allOk;
	allOk = compare_int((h[0]), -9) && allOk;
	allOk = compare_int((h[1]), -4) && allOk;
	allOk = compare_bvec2((blockE[0].i), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockE[0].j[0]), vec4(8.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec4((blockE[0].j[1]), vec4(8.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4((blockE[0].j[2]), vec4(-5.0, 0.0, 8.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockE[1].i), bvec2(true, true)) && allOk;
	allOk = compare_vec4((blockE[1].j[0]), vec4(-9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4((blockE[1].j[1]), vec4(-6.0, -2.0, 1.0, -2.0)) && allOk;
	allOk = compare_vec4((blockE[1].j[2]), vec4(-7.0, -8.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec4((blockE[1].j[3]), vec4(-4.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec4((blockE[1].j[4]), vec4(-8.0, -4.0, 7.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockE[2].i), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockE[2].j[0]), vec4(-9.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec4((blockE[2].j[1]), vec4(8.0, 1.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec4((blockE[2].j[2]), vec4(-1.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec4((blockE[2].j[3]), vec4(-7.0, 5.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4((blockE[2].j[4]), vec4(6.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_vec4((blockE[2].j[5]), vec4(2.0, -6.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec4((blockE[2].j[6]), vec4(-8.0, 6.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(1u, 7u, 6u, 4u));
	blockB.a[1] = (uvec4(7u, 1u, 9u, 3u));
	blockB.a[2] = (uvec4(8u, 6u, 1u, 8u));
	blockB.a[3] = (uvec4(0u, 4u, 3u, 8u));
	blockB.a[4] = (uvec4(2u, 0u, 9u, 5u));
	blockC[0].d = (mat3x4(7.0, 5.0, 2.0, 6.0, 0.0, -3.0, 0.0, 9.0, 4.0, 5.0, -1.0, -7.0));
	blockC[0].e[0].mA.mA = (mat2(-8.0, -8.0, 5.0, -5.0));
	blockC[0].e[0].mA.mB = (uvec4(5u, 5u, 0u, 7u));
	blockC[0].e[0].mB = (mat4(4.0, 5.0, -6.0, -7.0, -6.0, -4.0, -8.0, 0.0, -9.0, 1.0, 4.0, -4.0, 5.0, 0.0, 1.0, 4.0));
	blockC[0].e[0].mC = (mat4x3(5.0, 4.0, 8.0, -3.0, 1.0, 7.0, -9.0, -2.0, 0.0, -4.0, -8.0, 7.0));
	blockC[0].e[0].mD = (ivec4(-6, 7, 4, 3));
	blockC[0].e[1].mA.mA = (mat2(3.0, -2.0, 1.0, -2.0));
	blockC[0].e[1].mA.mB = (uvec4(6u, 0u, 4u, 7u));
	blockC[0].e[1].mB = (mat4(8.0, 4.0, -9.0, -2.0, -5.0, 1.0, 4.0, 0.0, -1.0, 3.0, -2.0, 0.0, -8.0, 8.0, -9.0, 5.0));
	blockC[0].e[1].mC = (mat4x3(-8.0, 8.0, 4.0, 8.0, -8.0, 6.0, -7.0, -4.0, 9.0, 9.0, 9.0, -9.0));
	blockC[0].e[1].mD = (ivec4(1, -1, -7, 8));
	blockC[0].e[2].mA.mA = (mat2(6.0, 4.0, -1.0, 6.0));
	blockC[0].e[2].mA.mB = (uvec4(3u, 6u, 5u, 1u));
	blockC[0].e[2].mB = (mat4(9.0, -1.0, -6.0, -2.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -4.0, 5.0, 7.0, 6.0, 9.0, -6.0));
	blockC[0].e[2].mC = (mat4x3(-6.0, 8.0, 1.0, 2.0, 5.0, 1.0, 4.0, -3.0, -6.0, -5.0, 0.0, -3.0));
	blockC[0].e[2].mD = (ivec4(1, 9, 9, 8));
	blockC[0].e[3].mA.mA = (mat2(-8.0, -5.0, 2.0, 9.0));
	blockC[0].e[3].mA.mB = (uvec4(2u, 0u, 4u, 4u));
	blockC[0].e[3].mB = (mat4(6.0, -3.0, 4.0, -8.0, -7.0, 0.0, 2.0, 0.0, 4.0, -8.0, 6.0, -3.0, -3.0, 8.0, 1.0, -7.0));
	blockC[0].e[3].mC = (mat4x3(-6.0, 6.0, 6.0, 8.0, 5.0, -7.0, -9.0, -6.0, -2.0, 9.0, -1.0, 6.0));
	blockC[0].e[3].mD = (ivec4(7, -9, 4, -3));
	blockC[0].e[4].mA.mA = (mat2(5.0, -7.0, -9.0, -5.0));
	blockC[0].e[4].mA.mB = (uvec4(1u, 7u, 6u, 0u));
	blockC[0].e[4].mB = (mat4(-8.0, -3.0, -4.0, 8.0, 7.0, -2.0, 8.0, 6.0, 6.0, 2.0, 9.0, 9.0, 8.0, -6.0, -1.0, -1.0));
	blockC[0].e[4].mC = (mat4x3(0.0, -3.0, 9.0, 3.0, -9.0, 8.0, 8.0, 8.0, -6.0, -6.0, -5.0, -4.0));
	blockC[0].e[4].mD = (ivec4(-5, 2, 1, -5));
	blockC[0].e[5].mA.mA = (mat2(-6.0, -9.0, -5.0, -9.0));
	blockC[0].e[5].mA.mB = (uvec4(2u, 7u, 5u, 6u));
	blockC[0].e[5].mB = (mat4(-8.0, 6.0, -6.0, -4.0, 4.0, 4.0, -7.0, -2.0, 3.0, -6.0, 1.0, -9.0, 2.0, 3.0, -6.0, 3.0));
	blockC[0].e[5].mC = (mat4x3(1.0, -8.0, -6.0, -9.0, -8.0, -9.0, -1.0, 4.0, -2.0, -6.0, -1.0, -1.0));
	blockC[0].e[5].mD = (ivec4(-7, -6, -8, 0));
	blockC[0].e[6].mA.mA = (mat2(-1.0, 7.0, -8.0, -9.0));
	blockC[0].e[6].mA.mB = (uvec4(2u, 4u, 4u, 7u));
	blockC[0].e[6].mB = (mat4(2.0, -5.0, 7.0, -1.0, -1.0, 1.0, 5.0, 2.0, 5.0, -1.0, -6.0, -5.0, 2.0, -4.0, -9.0, -3.0));
	blockC[0].e[6].mC = (mat4x3(-1.0, -9.0, 1.0, 6.0, -7.0, 3.0, -5.0, -5.0, -7.0, 9.0, 3.0, -4.0));
	blockC[0].e[6].mD = (ivec4(-6, 5, -4, -1));
	blockC[0].e[7].mA.mA = (mat2(-7.0, 6.0, -9.0, 1.0));
	blockC[0].e[7].mA.mB = (uvec4(3u, 1u, 4u, 8u));
	blockC[0].e[7].mB = (mat4(9.0, -4.0, -5.0, -4.0, -5.0, -5.0, 1.0, 2.0, -3.0, -7.0, 2.0, -1.0, -4.0, -1.0, -3.0, 0.0));
	blockC[0].e[7].mC = (mat4x3(7.0, -6.0, -2.0, -7.0, -5.0, -8.0, -6.0, -7.0, -2.0, 4.0, -9.0, 7.0));
	blockC[0].e[7].mD = (ivec4(6, 9, -2, 3));
	g = (uvec4(0u, 2u, 7u, 9u));
	h[0] = (1);
	h[1] = (3);
	blockE[0].i = (bvec2(true, false));
	blockE[0].j[0] = (vec4(-4.0, 6.0, -7.0, 4.0));
	blockE[0].j[1] = (vec4(-3.0, 1.0, 0.0, -2.0));
	blockE[0].j[2] = (vec4(-7.0, 5.0, -4.0, 5.0));
	blockE[1].i = (bvec2(false, true));
	blockE[1].j[0] = (vec4(8.0, 5.0, 9.0, 7.0));
	blockE[1].j[1] = (vec4(4.0, 3.0, -3.0, 2.0));
	blockE[1].j[2] = (vec4(2.0, 4.0, 5.0, 9.0));
	blockE[1].j[3] = (vec4(-3.0, -3.0, -1.0, 4.0));
	blockE[1].j[4] = (vec4(-2.0, 5.0, 2.0, -6.0));
	blockE[2].i = (bvec2(true, true));
	blockE[2].j[0] = (vec4(-4.0, 6.0, -6.0, -9.0));
	blockE[2].j[1] = (vec4(-1.0, -2.0, -8.0, 0.0));
	blockE[2].j[2] = (vec4(0.0, -6.0, 2.0, 4.0));
	blockE[2].j[3] = (vec4(-5.0, 0.0, 3.0, -4.0));
	blockE[2].j[4] = (vec4(8.0, 6.0, 9.0, 5.0));
	blockE[2].j[5] = (vec4(-2.0, 7.0, 0.0, 3.0));
	blockE[2].j[6] = (vec4(-2.0, -4.0, -4.0, 8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) readonly buffer BlockB
{
	bvec4 a;
	highp uvec3 b;
} blockB[];

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

layout(std140, binding = 1) readonly buffer BlockB
{
	mediump mat4x3 a;
	u16vec4 b;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	f16vec4 c;
	highp mat4x3 d;
	mediump vec2 e;
	lowp float f[];
};
layout(std140, binding = 3) buffer BlockD
{
	i16vec4 g;
	mediump ivec3 h;
	mediump int i;
	f16vec2 j;
	bvec4 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(a, mat4x3(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(b), uvec4(8u, 9u, 8u, 8u)) && allOk;
	allOk = compare_f16vec4(vec4(c), vec4(-4.0, 8.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec2((e), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_float((f[0]), -3.0) && allOk;
	allOk = compare_ivec3((h), ivec3(6, -1, -8)) && allOk;
	allOk = compare_int((i), -3) && allOk;
	allOk = compare_bvec4((k[0]), bvec4(true, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = f16vec4(vec4(-7.0, -2.0, -4.0, -2.0));
	d = (mat4x3(4.0, -2.0, 3.0, 0.0, -8.0, 6.0, -7.0, 4.0, 6.0, -2.0, -5.0, 3.0));
	e = (vec2(0.0, 9.0));
	h = (ivec3(2, -6, -8));
	i = (-6);
	j = f16vec2(vec2(4.0, -7.0));
	k[0] = (bvec4(true, false, false, true));
}
#version 450
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
	lowp vec4 a;
	bvec2 b;
};
layout(std430, binding = 2) buffer BlockC
{
	highp int c;
	f16vec2 d;
	bool e;
	lowp int f[];
};
layout(std140, binding = 3) buffer BlockD
{
	lowp ivec3 g;
	mediump vec3 h;
	i16vec3 i;
	i16vec4 j;
	mediump ivec4 k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-8.0, -8.0, 0.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(d), vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD.h), vec3(8.0, 3.0, 7.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.i), ivec3(5, -6, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-2.0, -9.0, -3.0, -1.0));
	c = (-5);
	d = f16vec2(vec2(-9.0, 4.0));
	blockD.h = (vec3(2.0, -9.0, -8.0));
	blockD.i = i16vec3(ivec3(3, 6, -6));
	blockD.k = (ivec4(7, -8, -2, -6));
}
#version 450
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
	highp mat3x4 a;
};
layout(std140, binding = 2) buffer BlockC
{
	f16vec4 b;
	mediump ivec3 c;
	lowp uint d;
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat3x2 e;
	i16vec2 f;
	f16vec3 g;
	highp mat3 h;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	f16vec3 i;
	highp float j;
	i16vec4 k[][6][6];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(-5.0, 7.0, -6.0, 3.0, -2.0, -6.0, -1.0, -7.0, 3.0, 8.0, -6.0, 9.0)) && allOk;
	allOk = compare_uint((blockC.d), 3u) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.f), ivec2(-8, -3)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g), vec3(3.0, 2.0, -6.0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][0][0]), ivec4(-9, -2, 4, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][0][1]), ivec4(-2, 1, 3, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][0][2]), ivec4(-1, 3, -4, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][0][3]), ivec4(-7, 0, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][0][4]), ivec4(-8, 3, 8, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][0][5]), ivec4(5, 6, 3, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][1][0]), ivec4(5, -8, -8, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][1][1]), ivec4(-3, 1, -8, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][1][2]), ivec4(-3, 2, 6, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][1][3]), ivec4(-7, 5, 9, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][1][4]), ivec4(7, 5, 0, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][1][5]), ivec4(6, 4, -4, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][2][0]), ivec4(-2, 1, 5, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][2][1]), ivec4(8, -7, -5, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][2][2]), ivec4(0, 7, -9, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][2][3]), ivec4(-2, 1, 8, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][2][4]), ivec4(-3, 3, 7, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][2][5]), ivec4(8, -3, 0, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][3][0]), ivec4(9, -7, -5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][3][1]), ivec4(-3, -1, -6, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][3][2]), ivec4(4, -7, 2, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][3][3]), ivec4(-4, 8, -1, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][3][4]), ivec4(-3, -1, -6, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][3][5]), ivec4(9, -4, 7, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][4][0]), ivec4(-1, 9, 5, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][4][1]), ivec4(8, -9, 7, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][4][2]), ivec4(8, -9, 0, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][4][3]), ivec4(-4, -8, 0, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][4][4]), ivec4(6, -4, 6, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][4][5]), ivec4(6, 3, -2, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][5][0]), ivec4(3, -2, -6, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][5][1]), ivec4(-2, 1, 3, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][5][2]), ivec4(6, -6, 5, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][5][3]), ivec4(5, 3, 2, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][5][4]), ivec4(0, -7, 7, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[0][5][5]), ivec4(-5, 2, 9, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][0][0]), ivec4(0, 3, -3, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][0][1]), ivec4(-3, 7, -9, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][0][2]), ivec4(-4, 1, -6, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][0][3]), ivec4(4, 5, -4, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][0][4]), ivec4(-7, 3, 6, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][0][5]), ivec4(1, 3, -7, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][1][0]), ivec4(-6, 9, -1, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][1][1]), ivec4(-7, 5, -6, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][1][2]), ivec4(-6, -5, -8, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][1][3]), ivec4(9, -4, -3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][1][4]), ivec4(-2, -5, -8, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][1][5]), ivec4(-7, -9, -9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][2][0]), ivec4(7, -2, -3, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][2][1]), ivec4(1, 0, -5, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][2][2]), ivec4(2, 2, -4, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][2][3]), ivec4(-1, 0, -6, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][2][4]), ivec4(6, -4, -7, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][2][5]), ivec4(-6, -1, -9, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][3][0]), ivec4(6, -7, 6, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][3][1]), ivec4(-8, 5, 7, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][3][2]), ivec4(7, -4, 6, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][3][3]), ivec4(-5, -3, -6, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][3][4]), ivec4(-2, -1, -8, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][3][5]), ivec4(3, 5, 1, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][4][0]), ivec4(2, 6, 8, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][4][1]), ivec4(-1, 7, 7, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][4][2]), ivec4(9, -3, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][4][3]), ivec4(-1, -4, -6, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][4][4]), ivec4(-1, -2, 4, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][4][5]), ivec4(6, -1, 4, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][5][0]), ivec4(-5, -8, 0, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][5][1]), ivec4(0, 8, 4, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][5][2]), ivec4(4, 0, 3, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][5][3]), ivec4(3, 3, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][5][4]), ivec4(9, 0, 4, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[1][5][5]), ivec4(8, -1, -9, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][0][0]), ivec4(3, 4, -5, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][0][1]), ivec4(3, 9, -5, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][0][2]), ivec4(-3, 1, 1, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][0][3]), ivec4(-3, -1, 2, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][0][4]), ivec4(-9, -1, -9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][0][5]), ivec4(6, 8, 1, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][1][0]), ivec4(8, -8, 6, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][1][1]), ivec4(-6, -4, 6, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][1][2]), ivec4(-3, -9, 4, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][1][3]), ivec4(-4, 0, 4, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][1][4]), ivec4(4, 7, 2, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][1][5]), ivec4(-7, -9, -9, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][2][0]), ivec4(7, 6, -1, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][2][1]), ivec4(7, 0, 8, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][2][2]), ivec4(-1, 6, 5, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][2][3]), ivec4(6, 8, -6, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][2][4]), ivec4(3, 9, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][2][5]), ivec4(6, 7, 6, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][3][0]), ivec4(-9, 6, 9, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][3][1]), ivec4(-7, -8, -4, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][3][2]), ivec4(6, -3, 2, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][3][3]), ivec4(6, -8, 7, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][3][4]), ivec4(3, 4, 8, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][3][5]), ivec4(1, -6, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][4][0]), ivec4(-2, -9, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][4][1]), ivec4(-3, -4, -5, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][4][2]), ivec4(8, 0, -6, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][4][3]), ivec4(-5, -7, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][4][4]), ivec4(-2, 2, 4, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][4][5]), ivec4(-8, -9, -5, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][5][0]), ivec4(0, 2, 3, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][5][1]), ivec4(-7, 1, 9, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][5][2]), ivec4(2, 6, 4, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][5][3]), ivec4(-1, -2, 9, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][5][4]), ivec4(1, 5, 5, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(k[2][5][5]), ivec4(-5, 3, -1, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][0][0]), ivec4(-6, 1, -4, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][0][1]), ivec4(-7, 6, 2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][0][2]), ivec4(-5, -2, -7, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][0][3]), ivec4(-3, -8, 2, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][0][4]), ivec4(3, -3, 6, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][0][5]), ivec4(8, 5, -3, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][1][0]), ivec4(-7, -5, -8, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][1][1]), ivec4(-1, -2, 9, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][1][2]), ivec4(3, 1, 4, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][1][3]), ivec4(-2, 5, 4, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][1][4]), ivec4(3, -7, -5, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][1][5]), ivec4(6, 9, 4, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][2][0]), ivec4(1, -2, -6, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][2][1]), ivec4(-2, -9, 1, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][2][2]), ivec4(0, 9, 8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][2][3]), ivec4(-7, 1, -6, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][2][4]), ivec4(-2, 6, 2, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(k[3][2][5]), ivec4(4, -3, 8, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(6.0, -3.0, 7.0, -4.0, -5.0, -1.0, -5.0, 1.0, -1.0, -2.0, -5.0, -7.0));
	blockC.b = f16vec4(vec4(1.0, 1.0, -9.0, -7.0));
	blockC.d = (3u);
	blockD.e = (mat3x2(1.0, -1.0, 6.0, 3.0, 6.0, -6.0));
	blockD.f = i16vec2(ivec2(2, 6));
	blockD.h = (mat3(4.0, -4.0, -4.0, 0.0, 3.0, -8.0, 1.0, 0.0, 0.0));
	i = f16vec3(vec3(-5.0, -3.0, -7.0));
	j = (-6.0);
	k[0][0][0] = i16vec4(ivec4(-8, 0, 1, 6));
	k[0][0][1] = i16vec4(ivec4(-6, 9, 6, -7));
	k[0][0][2] = i16vec4(ivec4(-3, 3, 1, -1));
	k[0][0][3] = i16vec4(ivec4(8, -1, 8, -1));
	k[0][0][4] = i16vec4(ivec4(-5, 5, 7, -2));
	k[0][0][5] = i16vec4(ivec4(8, -8, 7, 4));
	k[0][1][0] = i16vec4(ivec4(0, 3, -7, -6));
	k[0][1][1] = i16vec4(ivec4(6, -1, 8, -3));
	k[0][1][2] = i16vec4(ivec4(-8, 1, 1, -5));
	k[0][1][3] = i16vec4(ivec4(-9, 0, -3, -1));
	k[0][1][4] = i16vec4(ivec4(-4, -8, 3, 9));
	k[0][1][5] = i16vec4(ivec4(-2, 0, 1, -6));
	k[0][2][0] = i16vec4(ivec4(1, 6, 3, 6));
	k[0][2][1] = i16vec4(ivec4(-3, 4, -7, -6));
	k[0][2][2] = i16vec4(ivec4(-5, -9, -4, -7));
	k[0][2][3] = i16vec4(ivec4(-3, 3, -9, -1));
	k[0][2][4] = i16vec4(ivec4(-4, 2, -4, -2));
	k[0][2][5] = i16vec4(ivec4(2, 6, -8, -4));
	k[0][3][0] = i16vec4(ivec4(-5, 2, 7, -7));
	k[0][3][1] = i16vec4(ivec4(7, -9, 8, -7));
	k[0][3][2] = i16vec4(ivec4(-2, 2, 5, -8));
	k[0][3][3] = i16vec4(ivec4(-7, 4, 2, 9));
	k[0][3][4] = i16vec4(ivec4(-7, -3, 2, -7));
	k[0][3][5] = i16vec4(ivec4(8, -2, -6, -5));
	k[0][4][0] = i16vec4(ivec4(9, 1, 8, -4));
	k[0][4][1] = i16vec4(ivec4(5, 9, 3, -9));
	k[0][4][2] = i16vec4(ivec4(-7, 3, 4, -9));
	k[0][4][3] = i16vec4(ivec4(5, -1, 0, 9));
	k[0][4][4] = i16vec4(ivec4(-8, -2, 4, -9));
	k[0][4][5] = i16vec4(ivec4(6, -8, -3, 7));
	k[0][5][0] = i16vec4(ivec4(-9, 4, 6, 0));
	k[0][5][1] = i16vec4(ivec4(4, -8, 4, 0));
	k[0][5][2] = i16vec4(ivec4(9, -3, -5, 9));
	k[0][5][3] = i16vec4(ivec4(8, 1, 7, -8));
	k[0][5][4] = i16vec4(ivec4(-5, 2, -6, -8));
	k[0][5][5] = i16vec4(ivec4(-3, 2, -9, 7));
	k[1][0][0] = i16vec4(ivec4(7, -2, 6, 5));
	k[1][0][1] = i16vec4(ivec4(-8, 2, -3, -9));
	k[1][0][2] = i16vec4(ivec4(-6, 7, -8, 3));
	k[1][0][3] = i16vec4(ivec4(6, -9, 8, 9));
	k[1][0][4] = i16vec4(ivec4(6, -2, -9, -6));
	k[1][0][5] = i16vec4(ivec4(-8, 3, 4, -5));
	k[1][1][0] = i16vec4(ivec4(-7, -9, -2, -1));
	k[1][1][1] = i16vec4(ivec4(2, 7, 4, 3));
	k[1][1][2] = i16vec4(ivec4(3, 4, 8, 0));
	k[1][1][3] = i16vec4(ivec4(9, 7, 0, -3));
	k[1][1][4] = i16vec4(ivec4(3, -1, -5, -8));
	k[1][1][5] = i16vec4(ivec4(-3, 0, 1, 8));
	k[1][2][0] = i16vec4(ivec4(4, 9, -3, -4));
	k[1][2][1] = i16vec4(ivec4(-5, -8, -6, -6));
	k[1][2][2] = i16vec4(ivec4(8, 8, -2, 3));
	k[1][2][3] = i16vec4(ivec4(7, 9, 1, -5));
	k[1][2][4] = i16vec4(ivec4(0, -6, 7, -9));
	k[1][2][5] = i16vec4(ivec4(-7, -2, 6, -5));
	k[1][3][0] = i16vec4(ivec4(-2, 4, -2, -2));
	k[1][3][1] = i16vec4(ivec4(7, 3, 9, 3));
	k[1][3][2] = i16vec4(ivec4(-1, -7, -4, -7));
	k[1][3][3] = i16vec4(ivec4(-9, 1, -4, -1));
	k[1][3][4] = i16vec4(ivec4(-8, 0, 0, 7));
	k[1][3][5] = i16vec4(ivec4(4, -5, 3, 6));
	k[1][4][0] = i16vec4(ivec4(8, -7, -9, -3));
	k[1][4][1] = i16vec4(ivec4(-1, -4, 6, 2));
	k[1][4][2] = i16vec4(ivec4(0, 8, 9, -3));
	k[1][4][3] = i16vec4(ivec4(-9, -5, -8, 8));
	k[1][4][4] = i16vec4(ivec4(4, -7, -3, -1));
	k[1][4][5] = i16vec4(ivec4(6, -1, 4, 3));
	k[1][5][0] = i16vec4(ivec4(-4, -9, 0, 6));
	k[1][5][1] = i16vec4(ivec4(5, 0, 1, -6));
	k[1][5][2] = i16vec4(ivec4(9, 9, -7, 3));
	k[1][5][3] = i16vec4(ivec4(-6, -8, 6, 3));
	k[1][5][4] = i16vec4(ivec4(3, 9, -8, -9));
	k[1][5][5] = i16vec4(ivec4(-6, -4, -3, -1));
	k[2][0][0] = i16vec4(ivec4(-6, 3, -7, 4));
	k[2][0][1] = i16vec4(ivec4(4, -7, 0, -5));
	k[2][0][2] = i16vec4(ivec4(-8, 9, 6, 2));
	k[2][0][3] = i16vec4(ivec4(1, -6, -4, 4));
	k[2][0][4] = i16vec4(ivec4(2, 2, -1, 0));
	k[2][0][5] = i16vec4(ivec4(0, -6, -3, 0));
	k[2][1][0] = i16vec4(ivec4(-5, 8, -5, 3));
	k[2][1][1] = i16vec4(ivec4(4, -9, -4, 3));
	k[2][1][2] = i16vec4(ivec4(6, -4, -6, 7));
	k[2][1][3] = i16vec4(ivec4(-7, 9, 0, 5));
	k[2][1][4] = i16vec4(ivec4(-5, 7, -2, 3));
	k[2][1][5] = i16vec4(ivec4(1, -1, 8, 9));
	k[2][2][0] = i16vec4(ivec4(5, 3, 3, -9));
	k[2][2][1] = i16vec4(ivec4(0, 6, 9, 3));
	k[2][2][2] = i16vec4(ivec4(2, -7, -5, 8));
	k[2][2][3] = i16vec4(ivec4(7, 0, -6, 2));
	k[2][2][4] = i16vec4(ivec4(-7, 4, 8, 6));
	k[2][2][5] = i16vec4(ivec4(-2, -6, 9, -7));
	k[2][3][0] = i16vec4(ivec4(8, 2, 2, -3));
	k[2][3][1] = i16vec4(ivec4(-4, 7, -7, -3));
	k[2][3][2] = i16vec4(ivec4(-2, 1, 8, -6));
	k[2][3][3] = i16vec4(ivec4(8, 0, -2, 6));
	k[2][3][4] = i16vec4(ivec4(-7, 7, 0, 6));
	k[2][3][5] = i16vec4(ivec4(-7, 7, -2, -3));
	k[2][4][0] = i16vec4(ivec4(-6, -9, 5, -6));
	k[2][4][1] = i16vec4(ivec4(-6, -8, 0, -3));
	k[2][4][2] = i16vec4(ivec4(-4, 2, -1, -9));
	k[2][4][3] = i16vec4(ivec4(7, -2, -9, 1));
	k[2][4][4] = i16vec4(ivec4(0, 4, 1, -8));
	k[2][4][5] = i16vec4(ivec4(0, 3, 0, 0));
	k[2][5][0] = i16vec4(ivec4(-5, 0, -2, 5));
	k[2][5][1] = i16vec4(ivec4(8, 9, 3, 4));
	k[2][5][2] = i16vec4(ivec4(-4, -3, 3, -2));
	k[2][5][3] = i16vec4(ivec4(3, -2, 7, -8));
	k[2][5][4] = i16vec4(ivec4(-3, -1, -7, 7));
	k[2][5][5] = i16vec4(ivec4(6, 4, 4, 6));
	k[3][0][0] = i16vec4(ivec4(-8, -3, 6, -2));
	k[3][0][1] = i16vec4(ivec4(-2, -7, 2, 8));
	k[3][0][2] = i16vec4(ivec4(5, 3, -8, 3));
	k[3][0][3] = i16vec4(ivec4(7, -6, 4, -9));
	k[3][0][4] = i16vec4(ivec4(6, -5, 2, -8));
	k[3][0][5] = i16vec4(ivec4(-5, 0, -5, 3));
	k[3][1][0] = i16vec4(ivec4(7, -1, -4, 9));
	k[3][1][1] = i16vec4(ivec4(-5, 6, -8, -5));
	k[3][1][2] = i16vec4(ivec4(8, 9, -4, 2));
	k[3][1][3] = i16vec4(ivec4(-2, -9, -5, -8));
	k[3][1][4] = i16vec4(ivec4(1, -9, -1, 5));
	k[3][1][5] = i16vec4(ivec4(3, -8, 9, -3));
	k[3][2][0] = i16vec4(ivec4(3, -9, 3, 2));
	k[3][2][1] = i16vec4(ivec4(-4, -2, -4, -4));
	k[3][2][2] = i16vec4(ivec4(-5, -5, -4, 7));
	k[3][2][3] = i16vec4(ivec4(-5, -7, -4, -6));
	k[3][2][4] = i16vec4(ivec4(-5, -2, 7, -3));
	k[3][2][5] = i16vec4(ivec4(-8, 4, 6, 8));
	k[3][3][0] = i16vec4(ivec4(9, 2, 0, -8));
	k[3][3][1] = i16vec4(ivec4(7, -2, 5, 7));
	k[3][3][2] = i16vec4(ivec4(-3, 3, 1, -5));
	k[3][3][3] = i16vec4(ivec4(2, 5, 9, 7));
	k[3][3][4] = i16vec4(ivec4(4, 2, 4, -2));
	k[3][3][5] = i16vec4(ivec4(5, 1, 5, -7));
	k[3][4][0] = i16vec4(ivec4(-6, -8, 3, -9));
	k[3][4][1] = i16vec4(ivec4(-5, -6, -8, 7));
	k[3][4][2] = i16vec4(ivec4(-9, 0, 2, -4));
	k[3][4][3] = i16vec4(ivec4(0, 0, -4, -7));
	k[3][4][4] = i16vec4(ivec4(4, 3, -1, -2));
	k[3][4][5] = i16vec4(ivec4(-2, 4, -5, -8));
	k[3][5][0] = i16vec4(ivec4(5, 8, -9, 8));
	k[3][5][1] = i16vec4(ivec4(0, -7, -5, -3));
	k[3][5][2] = i16vec4(ivec4(2, 7, 4, -6));
	k[3][5][3] = i16vec4(ivec4(1, 8, 0, 3));
	k[3][5][4] = i16vec4(ivec4(-6, 9, -8, 3));
	k[3][5][5] = i16vec4(ivec4(-7, 0, -9, 0));
}
#version 450
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
	layout(offset = 12) float16_t b;
	layout(offset = 16) i16vec2 c;
	layout(offset = 20) mediump vec2 d;
	layout(offset = 28) bool e;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) bvec3 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uvec3 g;
	layout(offset = 12) u16vec2 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, true, false)) && allOk;
	allOk = compare_i16vec2(ivec2(c), ivec2(1, -5)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec3((g), uvec3(5u, 1u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(h), uvec2(9u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = float16_t(0.0);
	c = i16vec2(ivec2(-1, -9));
	d = (vec2(2.0, -4.0));
	e = (false);
	h = u16vec2(uvec2(3u, 5u));
}
#version 450
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
	layout(offset = 16) highp vec2 b;
	layout(offset = 24) float16_t c;
	layout(offset = 26) u16vec3 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) float16_t e;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_float16_t(float(blockC.e), 3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, false, true));
	b = (vec2(-7.0, 6.0));
	c = float16_t(0.0);
	d = u16vec3(uvec3(9u, 7u, 9u));
	blockC.e = float16_t(-5.0);
}
#version 450
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
	layout(offset = 0) bvec3 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) f16vec2 b;
	layout(offset = 4) mediump uint c;
	layout(offset = 8) f16vec4 d[1];
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp ivec2 e[1];
	layout(offset = 8) lowp vec2 f;
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, true, true)) && allOk;
	allOk = compare_f16vec2(vec2(b), vec2(1.0, 7.0)) && allOk;
	allOk = compare_uint((c), 3u) && allOk;
	allOk = compare_vec2((blockD[0].f), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2((blockD[1].f), vec2(-4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = f16vec2(vec2(-2.0, -9.0));
	d[0] = f16vec4(vec4(6.0, 5.0, -2.0, 8.0));
	blockD[0].e[0] = (ivec2(-2, 7));
	blockD[0].f = (vec2(7.0, 1.0));
	blockD[1].e[0] = (ivec2(-9, 4));
	blockD[1].f = (vec2(5.0, 9.0));
}
#version 450
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
	highp mat4x2 mA[5];
};
layout(scalar, binding = 1) buffer BlockB
{
	bvec4 a;
	bool b;
	sA c;
	mediump mat3x4 d;
	int16_t e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_mat4x2(blockB.c.mA[0], mat4x2(1.0, 4.0, -8.0, -5.0, -3.0, 7.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.c.mA[1], mat4x2(1.0, -7.0, -6.0, 0.0, -6.0, -2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB.c.mA[2], mat4x2(-5.0, 2.0, -2.0, -4.0, -2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.c.mA[3], mat4x2(-5.0, -7.0, 6.0, 1.0, -4.0, -3.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.c.mA[4], mat4x2(2.0, 8.0, 8.0, -2.0, 0.0, 4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.d, mat3x4(-4.0, 0.0, -6.0, -9.0, -3.0, 3.0, -1.0, -6.0, 5.0, 4.0, -1.0, 9.0)) && allOk;
	allOk = compare_int16_t(int(blockB.e), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.b = (true);
	blockB.d = (mat3x4(5.0, -9.0, -6.0, -4.0, 6.0, 1.0, -4.0, -9.0, -8.0, -2.0, -4.0, -7.0));
	blockB.e = int16_t(0);
}
#version 450
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
layout(scalar, binding = 1) buffer BlockB
{
	mediump uvec3 a;
	highp uint b;
	int16_t c;
	mediump vec3 d[5];
	mediump ivec2 e;
} blockB[1];
layout(scalar, binding = 2) buffer BlockC
{
	lowp vec2 f;
	bvec3 g[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp ivec2 h;
	lowp mat4x2 i[];
} blockD;
layout(scalar, column_major, binding = 4) buffer BlockE
{
	float16_t j;
	uint16_t k;
	bvec2 l;
	sA m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].b), 4u) && allOk;
	allOk = compare_ivec2((blockB[0].e), ivec2(6, -6)) && allOk;
	allOk = compare_vec2((f), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_bvec3((g[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((g[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((g[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((g[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_ivec2((blockD.h), ivec2(8, 5)) && allOk;
	allOk = compare_mat4x2(blockD.i[0], mat4x2(2.0, 9.0, 5.0, -4.0, -6.0, 7.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockD.i[1], mat4x2(-2.0, 5.0, 9.0, 7.0, -9.0, -9.0, 4.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(k), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(8u, 0u, 1u));
	blockB[0].c = int16_t(-3);
	blockB[0].e = (ivec2(0, -9));
	f = (vec2(4.0, 7.0));
	g[0] = (bvec3(true, false, false));
	g[1] = (bvec3(true, false, true));
	g[2] = (bvec3(false, false, true));
	g[3] = (bvec3(false, true, false));
	blockD.h = (ivec2(-5, -9));
	blockD.i[0] = (mat4x2(3.0, -2.0, 3.0, 0.0, 7.0, -5.0, -2.0, -9.0));
	blockD.i[1] = (mat4x2(-3.0, 9.0, -9.0, 4.0, -4.0, 0.0, -8.0, 4.0));
	k = uint16_t(6u);
	m[0].mA = (bvec3(false, false, true));
}
#version 450
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
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	i8vec3 b;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(b), ivec3(4294967291, 4294967294, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
}
#version 450
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
	highp vec4 mB[7];
};
struct sB
{
	sA mA;
};
struct sC
{
	mediump mat4x3 mA;
};
layout(std140, binding = 1) buffer BlockB
{
	highp mat4 a[8];
	sB b;
	mediump uint c;
	u8vec4 d[];
};
layout(std140, binding = 2) buffer BlockC
{
	i8vec3 e;
	highp ivec3 f[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp mat4x2 g;
	u8vec4 h;
	mediump vec2 i[];
};
layout(std430, binding = 4) buffer BlockE
{
	sC j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b.mA.mA, mat3x2(-6.0, 2.0, 8.0, 2.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4((b.mA.mB[0]), vec4(5.0, -2.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec4((b.mA.mB[1]), vec4(-3.0, -3.0, -3.0, -7.0)) && allOk;
	allOk = compare_vec4((b.mA.mB[2]), vec4(2.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4((b.mA.mB[3]), vec4(1.0, -7.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((b.mA.mB[4]), vec4(-7.0, -3.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec4((b.mA.mB[5]), vec4(0.0, 2.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec4((b.mA.mB[6]), vec4(-4.0, 0.0, -5.0, 5.0)) && allOk;
	allOk = compare_uint((c), 2u) && allOk;
	allOk = compare_i8vec3(ivec3(e), ivec3(1, 1, 2)) && allOk;
	allOk = compare_ivec3((f[0]), ivec3(8, 1, -4)) && allOk;
	allOk = compare_ivec3((f[1]), ivec3(-7, 0, 8)) && allOk;
	allOk = compare_ivec3((f[2]), ivec3(-2, 0, 9)) && allOk;
	allOk = compare_ivec3((f[3]), ivec3(-4, 1, -1)) && allOk;
	allOk = compare_ivec3((f[4]), ivec3(-1, 8, 4)) && allOk;
	allOk = compare_u8vec4(uvec4(h), uvec4(1u, 6u, 2u, 3u)) && allOk;
	allOk = compare_vec2((i[0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2((i[1]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((i[2]), vec2(-1.0, 3.0)) && allOk;
	allOk = compare_vec2((i[3]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2((i[4]), vec2(-4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA.mA = (mat3x2(-3.0, -2.0, -4.0, 2.0, 0.0, -8.0));
	b.mA.mB[0] = (vec4(-8.0, 0.0, 3.0, 7.0));
	b.mA.mB[1] = (vec4(5.0, 1.0, -5.0, 0.0));
	b.mA.mB[2] = (vec4(-3.0, 1.0, -6.0, -6.0));
	b.mA.mB[3] = (vec4(4.0, 6.0, -2.0, -7.0));
	b.mA.mB[4] = (vec4(8.0, 1.0, -6.0, 7.0));
	b.mA.mB[5] = (vec4(3.0, -8.0, -8.0, -9.0));
	b.mA.mB[6] = (vec4(8.0, 5.0, 9.0, 8.0));
	c = (3u);
	d[0] = u8vec4(uvec4(2u, 0u, 4u, 5u));
	d[1] = u8vec4(uvec4(2u, 8u, 6u, 8u));
	f[0] = (ivec3(6, -3, -1));
	f[1] = (ivec3(5, 5, -9));
	f[2] = (ivec3(-5, -7, -1));
	f[3] = (ivec3(0, -1, 6));
	f[4] = (ivec3(6, 1, 0));
	h = u8vec4(uvec4(8u, 1u, 7u, 6u));
	blockE.j[0].mA = (mat4x3(0.0, 7.0, -3.0, 3.0, -8.0, -6.0, -7.0, -5.0, -2.0, 0.0, 1.0, -8.0));
	blockE.j[1].mA = (mat4x3(7.0, -8.0, 6.0, 4.0, 1.0, -2.0, 4.0, -6.0, 6.0, -5.0, 5.0, 2.0));
	blockE.j[2].mA = (mat4x3(6.0, -9.0, 9.0, 1.0, 6.0, -4.0, -7.0, -3.0, -4.0, 4.0, -4.0, -7.0));
	blockE.j[3].mA = (mat4x3(-1.0, -6.0, 5.0, 3.0, -5.0, -8.0, 4.0, -1.0, 0.0, 8.0, 2.0, -7.0));
}
#version 450
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
	i8vec3 b;
	u8vec3 c;
	mediump ivec4 d[];
} blockB;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.c), uvec3(1u, 8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i8vec3(ivec3(9, 4294967287, 8));
	blockB.c = u8vec3(uvec3(6u, 3u, 9u));
	blockB.d[0] = (ivec4(5, 4, -2, -5));
}
#version 450
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
	layout(offset = 0) u8vec3 a;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec2 b;
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC[0].b), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((blockC[1].b), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC[2].b), vec2(0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec3(uvec3(4u, 4u, 9u));
	blockB[1].a = u8vec3(uvec3(1u, 5u, 2u));
	blockB[2].a = u8vec3(uvec3(9u, 4u, 7u));
	blockC[0].b = (vec2(5.0, -8.0));
	blockC[1].b = (vec2(-2.0, 4.0));
	blockC[2].b = (vec2(1.0, -2.0));
}
#version 450
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
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec3 b;
	layout(offset = 4) highp float c;
	layout(offset = 16) lowp vec4 d;
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec3 e;
	layout(offset = 12) mediump int f;
	layout(offset = 16) lowp vec4 g;
	layout(offset = 32) i8vec2 h;
	layout(offset = 36) lowp vec3 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockC[0].b), ivec3(4294967295, 6, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC[1].b), ivec3(4294967292, 9, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC[2].b), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_bvec3((e), bvec3(true, true, true)) && allOk;
	allOk = compare_vec4((g), vec4(3.0, 7.0, 4.0, -1.0)) && allOk;
	allOk = compare_i8vec2(ivec2(h), ivec2(3, 4294967293)) && allOk;
	allOk = compare_vec3((i), vec3(9.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, false));
	blockC[0].b = i8vec3(ivec3(4294967287, 5, 6));
	blockC[0].c = (5.0);
	blockC[0].d = (vec4(-2.0, 8.0, -2.0, 7.0));
	blockC[1].b = i8vec3(ivec3(7, 1, 4294967287));
	blockC[1].c = (4.0);
	blockC[1].d = (vec4(5.0, 9.0, -5.0, -9.0));
	blockC[2].b = i8vec3(ivec3(4294967287, 4294967289, 5));
	blockC[2].c = (8.0);
	blockC[2].d = (vec4(-9.0, 1.0, 3.0, -3.0));
	e = (bvec3(false, true, true));
	f = (0);
	g = (vec4(9.0, 1.0, 6.0, 6.0));
	h = i8vec2(ivec2(4294967295, 6));
	i = (vec3(7.0, 5.0, 2.0));
}
#version 450
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
	highp ivec3 a;
	u8vec4 b;
	u8vec3 c;
	u8vec4 d[];
} blockB[1];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[0].a), ivec3(2, -3, 2)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].d[0]), uvec4(9u, 6u, 8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec3(8, 7, -2));
	blockB[0].b = u8vec4(uvec4(1u, 0u, 7u, 3u));
	blockB[0].c = u8vec3(uvec3(5u, 7u, 7u));
	blockB[0].d[0] = u8vec4(uvec4(0u, 3u, 5u, 5u));
}
#version 450
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
	lowp mat4 a;
	lowp float b;
	bvec2 c;
	mediump float d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	d[0] = (7.0);
	d[1] = (-4.0);
	d[2] = (-2.0);
	d[3] = (-4.0);
	d[4] = (8.0);
	d[5] = (-7.0);
}
#version 450
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
	lowp mat4x3 a;
	mediump vec2 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].b), vec2(6.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].b), vec2(-6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (vec2(4.0, 1.0));
	blockB[nonuniformEXT(1)].b = (vec2(0.0, 7.0));
}
#version 450
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
	layout(offset = 0) uint8_t a;
	layout(offset = 1) uint8_t b;
	layout(offset = 4) highp ivec2 c;
	layout(offset = 16) highp ivec2 d;
} blockB[];

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].c), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].c), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].c), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].c), ivec2(-4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = uint8_t(7u);
	blockB[nonuniformEXT(0)].c = (ivec2(8, -4));
	blockB[nonuniformEXT(0)].d = (ivec2(7, 7));
	blockB[nonuniformEXT(1)].b = uint8_t(1u);
	blockB[nonuniformEXT(1)].c = (ivec2(-6, 5));
	blockB[nonuniformEXT(1)].d = (ivec2(-7, 1));
	blockB[nonuniformEXT(2)].b = uint8_t(0u);
	blockB[nonuniformEXT(2)].c = (ivec2(-9, -8));
	blockB[nonuniformEXT(2)].d = (ivec2(5, 5));
	blockB[nonuniformEXT(3)].b = uint8_t(3u);
	blockB[nonuniformEXT(3)].c = (ivec2(-6, 9));
	blockB[nonuniformEXT(3)].d = (ivec2(-9, 4));
}
#version 450
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
	highp uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(0u, 2u, 6u, 7u)) && allOk;
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

layout(std140, binding = 1) readonly buffer Block
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

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[0][3], 9.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], 2.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_float(var[3][2], 7.0) && allOk;
	allOk = compare_float(var[3][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, -4.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, -3.0, 7.0, -1.0)) && allOk;
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

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(8.0, 9.0, 7.0, 1.0, -5.0, -5.0)) && allOk;
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
	allOk = compare_mat3x4(var, mat3x4(8.0, -8.0, -2.0, -6.0, -3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0)) && allOk;
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(3.0, 8.0, -1.0, 9.0, 0.0, 0.0, 0.0, -4.0, 3.0, 0.0, 0.0, -6.0)) && allOk;
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], 8.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -2.0) && allOk;
	allOk = compare_float(var[3][2], -1.0) && allOk;
	allOk = compare_float(var[3][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, -2.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 5.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(1.0, -2.0, -1.0, -9.0)) && allOk;
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat4(var, mat4(2.0, 9.0, -4.0, -9.0, -4.0, -5.0, -8.0, 0.0, -8.0, 6.0, -4.0, -6.0, -7.0, -3.0, 4.0, -5.0)) && allOk;
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

}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0, 2.0)) && allOk;
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0, -2.0)) && allOk;
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

layout(std140, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	highp mat3 var[3];
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

layout(std430, binding = 1) readonly buffer Block
{
	highp int var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0]), 6) && allOk;
	allOk = compare_int((var[1]), 0) && allOk;
	allOk = compare_int((var[2]), 9) && allOk;
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
	bvec3 var[3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2]), bvec3(false, true, false)) && allOk;
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
	i8vec2 var[3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(0, 1)) && allOk;
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-3.0, 0.0, -1.0, -5.0, 6.0, 9.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(8.0, 3.0, -2.0, -1.0, 8.0, -2.0, 4.0, -3.0, 2.0)) && allOk;
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3(var[0], mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0)) && allOk;
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-1.0, -3.0, -1.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(9.0, 0.0, 0.0, -2.0, -7.0, -6.0)) && allOk;
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0, 6.0)) && allOk;
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0, -9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0, 0.0, 7.0, -9.0)) && allOk;
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][3], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][3], 4.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_float(block.var[3][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][3], -4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-6.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(7.0, 9.0, -1.0, -5.0));
	block.var[1] = (vec4(5.0, -7.0, 4.0, -8.0));
	block.var[2] = (vec4(-8.0, 0.0, -6.0, 9.0));
	block.var[3] = (vec4(-2.0, 0.0, -8.0, 3.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(6.0, -8.0, -3.0, 3.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(3.0, 3.0, 6.0, 4.0, -3.0, 2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_float(block.var[1][3], -9.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(8.0, -6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, 2.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(0.0, 1.0, 1.0, 2.0, -2.0, -8.0, -1.0, 8.0));
}
#version 450
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
	lowp ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var), ivec3(-1, -8, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec3(5, -9, -8));
}
#version 450
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
	mediump ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var), ivec3(-9, 4, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec3(-7, 5, -6));
}
#version 450
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
	mediump uint var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (0u);
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_float(block.var[2][0], -3.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][2], 7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(6.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-3.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-8.0, 5.0, -9.0, 5.0, 0.0, -3.0, 9.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 6.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(6.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-9.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(6.0, 3.0, -3.0, 3.0, 8.0, 1.0, -9.0, -6.0, 9.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block.var, mat2x3(-2.0, -3.0, -4.0, 2.0, 7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(1.0, 5.0, -2.0));
	block.var[1] = (vec3(7.0, 8.0, -1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-7.0, 2.0, 1.0));
	block.var[1] = (vec3(8.0, 3.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-7.0, -6.0, -6.0, -9.0, -6.0, -9.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(7.0, 2.0, 0.0, 0.0));
	block.var[1] = (vec4(8.0, -3.0, -2.0, 7.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], -1.0) && allOk;
	allOk = compare_float(block.var[3][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-9.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-8.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(2.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-5.0, -3.0, -4.0));
	block.var[1] = (vec3(-5.0, 0.0, -1.0));
	block.var[2] = (vec3(-1.0, 6.0, -4.0));
	block.var[3] = (vec3(-1.0, -8.0, 6.0));
}
#version 450
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
	int8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = int8_t(4294967290);
}
#version 450
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
	u16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var), uvec3(1u, 0u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u16vec3(uvec3(1u, 2u, 6u));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0] = (vec3(3.0, -6.0, 8.0));
	block.var[1] = (vec3(-7.0, 4.0, -4.0));
	block.var[2] = (vec3(5.0, -6.0, 7.0));
}
#version 450
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
	lowp mat2x4 var;
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-2.0, 5.0, -5.0, -5.0, 0.0, 4.0, 4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat2x4(5.0, -3.0, 6.0, -2.0, 4.0, -9.0, -4.0, -2.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-2.0, 8.0));
	block.var[0][1] = (vec2(1.0, 8.0));
	block.var[0][2] = (vec2(-7.0, 5.0));
	block.var[1][0] = (vec2(2.0, 0.0));
	block.var[1][1] = (vec2(-3.0, 1.0));
	block.var[1][2] = (vec2(2.0, -5.0));
	block.var[2][0] = (vec2(6.0, 3.0));
	block.var[2][1] = (vec2(6.0, 5.0));
	block.var[2][2] = (vec2(-5.0, 9.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-4.0, -6.0));
	block.var[0][1] = (vec2(1.0, -3.0));
	block.var[0][2] = (vec2(-1.0, -9.0));
	block.var[1][0] = (vec2(3.0, -2.0));
	block.var[1][1] = (vec2(5.0, -8.0));
	block.var[1][2] = (vec2(2.0, -9.0));
	block.var[2][0] = (vec2(1.0, -5.0));
	block.var[2][1] = (vec2(0.0, -2.0));
	block.var[2][2] = (vec2(2.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0] = (vec2(-2.0, 2.0));
	block.var[0][1] = (vec2(8.0, -5.0));
	block.var[0][2] = (vec2(3.0, -1.0));
	block.var[0][3] = (vec2(-7.0, 4.0));
	block.var[1][0] = (vec2(2.0, -4.0));
	block.var[1][1] = (vec2(8.0, 3.0));
	block.var[1][2] = (vec2(8.0, -1.0));
	block.var[1][3] = (vec2(6.0, -8.0));
	block.var[2][0] = (vec2(2.0, -5.0));
	block.var[2][1] = (vec2(5.0, -4.0));
	block.var[2][2] = (vec2(-9.0, 0.0));
	block.var[2][3] = (vec2(4.0, 8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	block.var[3] = (mat2(-6.0, -7.0, 1.0, -1.0));
	block.var[4] = (mat2(6.0, 2.0, -7.0, 8.0));
	block.var[5] = (mat2(-3.0, -2.0, 2.0, -7.0));
	block.var[6] = (mat2(-1.0, -3.0, -7.0, 2.0));
	block.var[7] = (mat2(-3.0, -6.0, 2.0, 7.0));
	block.var[8] = (mat2(4.0, -2.0, -7.0, 4.0));
	block.var[9] = (mat2(-7.0, -5.0, -7.0, -5.0));
	block.var[10] = (mat2(-6.0, 4.0, 6.0, 4.0));
	block.var[11] = (mat2(2.0, -1.0, 9.0, 6.0));
	block.var[12] = (mat2(-5.0, 7.0, -8.0, 6.0));
	block.var[13] = (mat2(1.0, 0.0, 7.0, -3.0));
	block.var[14] = (mat2(9.0, -8.0, -6.0, -9.0));
	block.var[15] = (mat2(-6.0, 8.0, 1.0, -2.0));
	block.var[16] = (mat2(-4.0, -5.0, -4.0, 2.0));
	block.var[17] = (mat2(4.0, -9.0, 8.0, -9.0));
	block.var[18] = (mat2(-2.0, 2.0, 3.0, -3.0));
}
#version 450
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
	u8vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[4]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[5]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[6]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[7]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[8]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[9]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[10]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[11]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[12]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[13]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[14]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[15]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[16]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[17]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[18]), uvec2(6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec2(uvec2(7u, 7u));
	block.var[1] = u8vec2(uvec2(9u, 6u));
	block.var[2] = u8vec2(uvec2(0u, 2u));
	block.var[3] = u8vec2(uvec2(1u, 1u));
	block.var[4] = u8vec2(uvec2(0u, 8u));
	block.var[5] = u8vec2(uvec2(8u, 5u));
	block.var[6] = u8vec2(uvec2(2u, 7u));
	block.var[7] = u8vec2(uvec2(4u, 4u));
	block.var[8] = u8vec2(uvec2(7u, 2u));
	block.var[9] = u8vec2(uvec2(4u, 5u));
	block.var[10] = u8vec2(uvec2(0u, 2u));
	block.var[11] = u8vec2(uvec2(1u, 8u));
	block.var[12] = u8vec2(uvec2(1u, 8u));
	block.var[13] = u8vec2(uvec2(4u, 0u));
	block.var[14] = u8vec2(uvec2(2u, 7u));
	block.var[15] = u8vec2(uvec2(2u, 0u));
	block.var[16] = u8vec2(uvec2(2u, 5u));
	block.var[17] = u8vec2(uvec2(3u, 4u));
	block.var[18] = u8vec2(uvec2(7u, 4u));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
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
	block.var[3][0] = (vec3(5.0, -1.0, 2.0));
	block.var[3][1] = (vec3(3.0, 0.0, 8.0));
	block.var[3][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[4][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[4][1] = (vec3(7.0, 3.0, 7.0));
	block.var[4][2] = (vec3(5.0, -4.0, 3.0));
	block.var[5][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[5][1] = (vec3(7.0, -1.0, 2.0));
	block.var[5][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[6][0] = (vec3(9.0, -7.0, -5.0));
	block.var[6][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[6][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[7][0] = (vec3(7.0, -5.0, 1.0));
	block.var[7][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[7][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[8][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[8][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[8][2] = (vec3(3.0, 0.0, -1.0));
	block.var[9][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[9][1] = (vec3(3.0, 3.0, -1.0));
	block.var[9][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[10][0] = (vec3(7.0, 4.0, -7.0));
	block.var[10][1] = (vec3(7.0, 7.0, -4.0));
	block.var[10][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[11][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[11][1] = (vec3(8.0, 9.0, 3.0));
	block.var[11][2] = (vec3(0.0, -5.0, -7.0));
	block.var[12][0] = (vec3(4.0, 2.0, 9.0));
	block.var[12][1] = (vec3(-7.0, 2.0, 0.0));
	block.var[12][2] = (vec3(0.0, -4.0, 3.0));
	block.var[13][0] = (vec3(-7.0, -7.0, 1.0));
	block.var[13][1] = (vec3(1.0, -5.0, 0.0));
	block.var[13][2] = (vec3(5.0, -6.0, 7.0));
	block.var[14][0] = (vec3(-2.0, 8.0, -5.0));
	block.var[14][1] = (vec3(4.0, -8.0, 2.0));
	block.var[14][2] = (vec3(4.0, 2.0, -7.0));
	block.var[15][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[15][1] = (vec3(0.0, 5.0, -5.0));
	block.var[15][2] = (vec3(3.0, 3.0, -8.0));
	block.var[16][0] = (vec3(0.0, -7.0, -2.0));
	block.var[16][1] = (vec3(-8.0, 3.0, -2.0));
	block.var[16][2] = (vec3(9.0, -7.0, -7.0));
	block.var[17][0] = (vec3(4.0, -6.0, -3.0));
	block.var[17][1] = (vec3(-9.0, -3.0, 8.0));
	block.var[17][2] = (vec3(-8.0, -1.0, -6.0));
	block.var[18][0] = (vec3(0.0, 5.0, 9.0));
	block.var[18][1] = (vec3(-2.0, -2.0, 3.0));
	block.var[18][2] = (vec3(-5.0, 3.0, -7.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	i8vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[4]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[5]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[6]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[7]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[8]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[9]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[10]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[11]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[12]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[13]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[14]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[15]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[16]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[17]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[18]), ivec3(1, 4294967293, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[3] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[4] = i8vec3(ivec3(9, 7, 5));
	block.var[5] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[6] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[7] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[8] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[9] = i8vec3(ivec3(3, 7, 4));
	block.var[10] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[11] = i8vec3(ivec3(4294967294, 8, 1));
	block.var[12] = i8vec3(ivec3(7, 4294967293, 7));
	block.var[13] = i8vec3(ivec3(4294967293, 4294967288, 2));
	block.var[14] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	block.var[15] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	block.var[16] = i8vec3(ivec3(4294967287, 1, 4294967288));
	block.var[17] = i8vec3(ivec3(4294967291, 8, 6));
	block.var[18] = i8vec3(ivec3(4294967288, 4, 8));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
{
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[0][2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[0][2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[1][0][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[1][0][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[1][1][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[1][1][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[1][2][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[1][2][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[2][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[2][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[2][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[2][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[2][2][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[2][2][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[3][0][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[3][0][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[3][1][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[3][1][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[3][2][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[3][2][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
}
#version 450
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
	u16vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[1][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[1][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[1][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[2][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[2][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[2][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[3][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[3][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[3][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
}
#version 450
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
	i8vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][2]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][2]), ivec3(2, 4294967294, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[0][1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[0][2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[1][0] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[1][1] = i8vec3(ivec3(9, 7, 5));
	block.var[1][2] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[2][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[2][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[2][2] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[3][0] = i8vec3(ivec3(3, 7, 4));
	block.var[3][1] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[3][2] = i8vec3(ivec3(4294967294, 8, 1));
}
#version 450
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
	int16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0][0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0][1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][2]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[1][0]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][1]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][2]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[2][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[2][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][2]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[3][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[3][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[3][2]), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = int16_t(6);
	block.var[0][1] = int16_t(8);
	block.var[0][2] = int16_t(-2);
	block.var[1][0] = int16_t(-4);
	block.var[1][1] = int16_t(-3);
	block.var[1][2] = int16_t(9);
	block.var[2][0] = int16_t(-5);
	block.var[2][1] = int16_t(-8);
	block.var[2][2] = int16_t(-3);
	block.var[3][0] = int16_t(2);
	block.var[3][1] = int16_t(-1);
	block.var[3][2] = int16_t(4);
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(-8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0] = (mat2x4(9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0, -1.0));
	block.var[0][1] = (mat2x4(-4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0, 9.0));
	block.var[0][2] = (mat2x4(-9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0, -7.0));
	block.var[1][0] = (mat2x4(-4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0, 0.0));
	block.var[1][1] = (mat2x4(-4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0, 3.0));
	block.var[1][2] = (mat2x4(-8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0, 4.0));
	block.var[2][0] = (mat2x4(-7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0, -2.0));
	block.var[2][1] = (mat2x4(1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0, -8.0));
	block.var[2][2] = (mat2x4(7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0, 2.0));
	block.var[3][0] = (mat2x4(9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0, 5.0));
	block.var[3][1] = (mat2x4(-9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0, -6.0));
	block.var[3][2] = (mat2x4(-9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0][0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	block.var[0][0][1] = (vec4(2.0, 7.0, -9.0, -9.0));
	block.var[0][1][0] = (vec4(-5.0, 4.0, 7.0, 5.0));
	block.var[0][1][1] = (vec4(8.0, -8.0, -8.0, 6.0));
	block.var[0][2][0] = (vec4(-3.0, 7.0, 0.0, 4.0));
	block.var[0][2][1] = (vec4(6.0, -4.0, 0.0, -5.0));
	block.var[1][0][0] = (vec4(8.0, -9.0, -8.0, 7.0));
	block.var[1][0][1] = (vec4(-7.0, -8.0, -6.0, -9.0));
	block.var[1][1][0] = (vec4(-8.0, 1.0, -2.0, 7.0));
	block.var[1][1][1] = (vec4(-6.0, -9.0, 9.0, 4.0));
	block.var[1][2][0] = (vec4(-6.0, 0.0, -3.0, -7.0));
	block.var[1][2][1] = (vec4(-7.0, 2.0, -1.0, 6.0));
	block.var[2][0][0] = (vec4(-1.0, -5.0, 1.0, -1.0));
	block.var[2][0][1] = (vec4(8.0, 7.0, 6.0, -9.0));
	block.var[2][1][0] = (vec4(8.0, 2.0, 1.0, 9.0));
	block.var[2][1][1] = (vec4(-7.0, 6.0, -8.0, -2.0));
	block.var[2][2][0] = (vec4(-8.0, 6.0, 9.0, 5.0));
	block.var[2][2][1] = (vec4(5.0, -1.0, -1.0, 4.0));
	block.var[3][0][0] = (vec4(-3.0, 7.0, -9.0, -3.0));
	block.var[3][0][1] = (vec4(9.0, 2.0, 6.0, 6.0));
	block.var[3][1][0] = (vec4(1.0, 5.0, -4.0, 1.0));
	block.var[3][1][1] = (vec4(-6.0, 2.0, 6.0, -8.0));
	block.var[3][2][0] = (vec4(7.0, 7.0, -5.0, -8.0));
	block.var[3][2][1] = (vec4(0.0, -6.0, -4.0, 5.0));
}
#version 450
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
	highp uvec2 var[4][2][3];
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
	allOk = compare_uvec2((block.var[0][0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][2]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][0]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][1]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][2]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][2]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][2]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][1]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec2(6u, 1u));
	block.var[0][0][1] = (uvec2(8u, 1u));
	block.var[0][0][2] = (uvec2(7u, 4u));
	block.var[0][1][0] = (uvec2(6u, 2u));
	block.var[0][1][1] = (uvec2(6u, 0u));
	block.var[0][1][2] = (uvec2(3u, 2u));
	block.var[1][0][0] = (uvec2(6u, 6u));
	block.var[1][0][1] = (uvec2(5u, 8u));
	block.var[1][0][2] = (uvec2(4u, 7u));
	block.var[1][1][0] = (uvec2(5u, 1u));
	block.var[1][1][1] = (uvec2(7u, 2u));
	block.var[1][1][2] = (uvec2(3u, 6u));
	block.var[2][0][0] = (uvec2(8u, 4u));
	block.var[2][0][1] = (uvec2(6u, 3u));
	block.var[2][0][2] = (uvec2(6u, 0u));
	block.var[2][1][0] = (uvec2(0u, 1u));
	block.var[2][1][1] = (uvec2(2u, 6u));
	block.var[2][1][2] = (uvec2(9u, 1u));
	block.var[3][0][0] = (uvec2(3u, 5u));
	block.var[3][0][1] = (uvec2(2u, 4u));
	block.var[3][0][2] = (uvec2(7u, 8u));
	block.var[3][1][0] = (uvec2(4u, 6u));
	block.var[3][1][1] = (uvec2(4u, 2u));
	block.var[3][1][2] = (uvec2(7u, 5u));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
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
	block.var[0][0][2][0] = (vec2(-8.0, 5.0));
	block.var[0][0][2][1] = (vec2(6.0, -8.0));
	block.var[0][0][2][2] = (vec2(-8.0, 3.0));
	block.var[0][0][2][3] = (vec2(2.0, 8.0));
	block.var[0][1][0][0] = (vec2(-9.0, -3.0));
	block.var[0][1][0][1] = (vec2(5.0, -5.0));
	block.var[0][1][0][2] = (vec2(3.0, 4.0));
	block.var[0][1][0][3] = (vec2(-9.0, 1.0));
	block.var[0][1][1][0] = (vec2(0.0, 8.0));
	block.var[0][1][1][1] = (vec2(-8.0, 3.0));
	block.var[0][1][1][2] = (vec2(-7.0, 9.0));
	block.var[0][1][1][3] = (vec2(-8.0, -7.0));
	block.var[0][1][2][0] = (vec2(7.0, 1.0));
	block.var[0][1][2][1] = (vec2(-1.0, -2.0));
	block.var[0][1][2][2] = (vec2(-8.0, -3.0));
	block.var[0][1][2][3] = (vec2(9.0, -1.0));
	block.var[1][0][0][0] = (vec2(-8.0, -1.0));
	block.var[1][0][0][1] = (vec2(-3.0, 0.0));
	block.var[1][0][0][2] = (vec2(7.0, 5.0));
	block.var[1][0][0][3] = (vec2(-8.0, 5.0));
	block.var[1][0][1][0] = (vec2(7.0, 8.0));
	block.var[1][0][1][1] = (vec2(4.0, -2.0));
	block.var[1][0][1][2] = (vec2(4.0, -2.0));
	block.var[1][0][1][3] = (vec2(-2.0, 9.0));
	block.var[1][0][2][0] = (vec2(4.0, -4.0));
	block.var[1][0][2][1] = (vec2(-5.0, -5.0));
	block.var[1][0][2][2] = (vec2(-6.0, 8.0));
	block.var[1][0][2][3] = (vec2(9.0, -5.0));
	block.var[1][1][0][0] = (vec2(-2.0, 1.0));
	block.var[1][1][0][1] = (vec2(-8.0, -7.0));
	block.var[1][1][0][2] = (vec2(-5.0, 7.0));
	block.var[1][1][0][3] = (vec2(-5.0, -7.0));
	block.var[1][1][1][0] = (vec2(-5.0, 2.0));
	block.var[1][1][1][1] = (vec2(-4.0, 8.0));
	block.var[1][1][1][2] = (vec2(-7.0, 6.0));
	block.var[1][1][1][3] = (vec2(5.0, 2.0));
	block.var[1][1][2][0] = (vec2(-5.0, 3.0));
	block.var[1][1][2][1] = (vec2(-9.0, 7.0));
	block.var[1][1][2][2] = (vec2(-3.0, -3.0));
	block.var[1][1][2][3] = (vec2(-7.0, -4.0));
	block.var[2][0][0][0] = (vec2(-2.0, 1.0));
	block.var[2][0][0][1] = (vec2(6.0, -2.0));
	block.var[2][0][0][2] = (vec2(2.0, -5.0));
	block.var[2][0][0][3] = (vec2(3.0, -3.0));
	block.var[2][0][1][0] = (vec2(-6.0, -4.0));
	block.var[2][0][1][1] = (vec2(-6.0, -7.0));
	block.var[2][0][1][2] = (vec2(9.0, 1.0));
	block.var[2][0][1][3] = (vec2(-4.0, 3.0));
	block.var[2][0][2][0] = (vec2(7.0, -9.0));
	block.var[2][0][2][1] = (vec2(7.0, -4.0));
	block.var[2][0][2][2] = (vec2(8.0, -2.0));
	block.var[2][0][2][3] = (vec2(9.0, 0.0));
	block.var[2][1][0][0] = (vec2(3.0, 7.0));
	block.var[2][1][0][1] = (vec2(-6.0, -7.0));
	block.var[2][1][0][2] = (vec2(-7.0, 5.0));
	block.var[2][1][0][3] = (vec2(-8.0, 4.0));
	block.var[2][1][1][0] = (vec2(4.0, -5.0));
	block.var[2][1][1][1] = (vec2(-6.0, -9.0));
	block.var[2][1][1][2] = (vec2(7.0, 7.0));
	block.var[2][1][1][3] = (vec2(-2.0, 6.0));
	block.var[2][1][2][0] = (vec2(1.0, -9.0));
	block.var[2][1][2][1] = (vec2(7.0, 6.0));
	block.var[2][1][2][2] = (vec2(-4.0, 2.0));
	block.var[2][1][2][3] = (vec2(1.0, 5.0));
	block.var[3][0][0][0] = (vec2(-9.0, 7.0));
	block.var[3][0][0][1] = (vec2(1.0, 4.0));
	block.var[3][0][0][2] = (vec2(-7.0, 9.0));
	block.var[3][0][0][3] = (vec2(-5.0, 2.0));
	block.var[3][0][1][0] = (vec2(-9.0, -3.0));
	block.var[3][0][1][1] = (vec2(-8.0, 5.0));
	block.var[3][0][1][2] = (vec2(-2.0, -8.0));
	block.var[3][0][1][3] = (vec2(7.0, -6.0));
	block.var[3][0][2][0] = (vec2(-7.0, 1.0));
	block.var[3][0][2][1] = (vec2(-3.0, 7.0));
	block.var[3][0][2][2] = (vec2(6.0, -5.0));
	block.var[3][0][2][3] = (vec2(9.0, -2.0));
	block.var[3][1][0][0] = (vec2(-8.0, -6.0));
	block.var[3][1][0][1] = (vec2(-6.0, 4.0));
	block.var[3][1][0][2] = (vec2(4.0, 7.0));
	block.var[3][1][0][3] = (vec2(-7.0, -9.0));
	block.var[3][1][1][0] = (vec2(7.0, -6.0));
	block.var[3][1][1][1] = (vec2(8.0, -8.0));
	block.var[3][1][1][2] = (vec2(-6.0, -7.0));
	block.var[3][1][1][3] = (vec2(-4.0, -2.0));
	block.var[3][1][2][0] = (vec2(-9.0, 9.0));
	block.var[3][1][2][1] = (vec2(4.0, -6.0));
	block.var[3][1][2][2] = (vec2(2.0, 3.0));
	block.var[3][1][2][3] = (vec2(6.0, 8.0));
}
#version 450
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
	u16vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0][0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][2]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][0]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][1]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][2]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][2]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][0]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][1]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][2]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[0][0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[0][1][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[0][1][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[0][1][2] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[1][0][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[1][0][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[1][0][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[1][1][0] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[1][1][1] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[1][1][2] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[2][0][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[2][0][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[2][0][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[2][1][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	block.var[2][1][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	block.var[2][1][2] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	block.var[3][0][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[3][0][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[3][0][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[3][1][0] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	block.var[3][1][1] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	block.var[3][1][2] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[0][0][2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	block.var[0][1][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	block.var[0][1][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	block.var[0][1][2] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	block.var[1][0][0] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	block.var[1][0][1] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	block.var[1][0][2] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	block.var[1][1][0] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	block.var[1][1][1] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	block.var[1][1][2] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	block.var[2][0][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	block.var[2][0][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	block.var[2][0][2] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	block.var[2][1][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	block.var[2][1][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	block.var[2][1][2] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	block.var[3][0][0] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	block.var[3][0][1] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	block.var[3][0][2] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	block.var[3][1][0] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	block.var[3][1][1] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	block.var[3][1][2] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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
	highp ivec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 6) && allOk;
	allOk = compare_ivec2((block.var[0][0][0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block.var[0][0][1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((block.var[0][0][2]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((block.var[0][1][0]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block.var[0][1][1]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((block.var[0][1][2]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((block.var[1][0][0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((block.var[1][0][1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((block.var[1][0][2]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((block.var[1][1][0]), ivec2(-3, -9)) && allOk;
	allOk = compare_ivec2((block.var[1][1][1]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((block.var[1][1][2]), ivec2(8, 6)) && allOk;
	allOk = compare_ivec2((block.var[2][0][0]), ivec2(-1, 0)) && allOk;
	allOk = compare_ivec2((block.var[2][0][1]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((block.var[2][0][2]), ivec2(-5, 6)) && allOk;
	allOk = compare_ivec2((block.var[2][1][0]), ivec2(3, -5)) && allOk;
	allOk = compare_ivec2((block.var[2][1][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block.var[2][1][2]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((block.var[3][0][0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((block.var[3][0][1]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block.var[3][0][2]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((block.var[3][1][0]), ivec2(-4, 8)) && allOk;
	allOk = compare_ivec2((block.var[3][1][1]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block.var[3][1][2]), ivec2(-9, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6);
	block.var[0][0][0] = (ivec2(8, 3));
	block.var[0][0][1] = (ivec2(-1, -5));
	block.var[0][0][2] = (ivec2(-2, 0));
	block.var[0][1][0] = (ivec2(1, 1));
	block.var[0][1][1] = (ivec2(9, -2));
	block.var[0][1][2] = (ivec2(-9, 9));
	block.var[1][0][0] = (ivec2(-2, 5));
	block.var[1][0][1] = (ivec2(2, -8));
	block.var[1][0][2] = (ivec2(4, -6));
	block.var[1][1][0] = (ivec2(6, -8));
	block.var[1][1][1] = (ivec2(1, -3));
	block.var[1][1][2] = (ivec2(2, -3));
	block.var[2][0][0] = (ivec2(-4, 3));
	block.var[2][0][1] = (ivec2(-2, 5));
	block.var[2][0][2] = (ivec2(-7, -3));
	block.var[2][1][0] = (ivec2(-1, -4));
	block.var[2][1][1] = (ivec2(6, -4));
	block.var[2][1][2] = (ivec2(-7, -9));
	block.var[3][0][0] = (ivec2(4, 1));
	block.var[3][0][1] = (ivec2(6, 8));
	block.var[3][0][2] = (ivec2(7, 4));
	block.var[3][1][0] = (ivec2(1, 8));
	block.var[3][1][1] = (ivec2(1, -8));
	block.var[3][1][2] = (ivec2(3, 3));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-7.0, 5.0, 4.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-3.0, 5.0, -8.0, -2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(3.0, -9.0, 1.0, 3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-6.0, 5.0, 3.0, -1.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(6.0, -4.0, -1.0, 5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-1.0, -8.0, 7.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(9.0, 5.0, 3.0, -1.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(3.0, 8.0, -7.0, 8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(4.0, -2.0, -2.0, -6.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(5.0, -9.0, -5.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-4.0, 0.0, -3.0, 5.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-2.0, 6.0, 0.0, 3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-5.0, -3.0, -6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-6.0, 5.0, -2.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(1.0, 8.0, -7.0, 5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(0.0, 5.0, 6.0, -5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-2.0, -1.0, 5.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-2.0, 9.0, 2.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-2.0, -9.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-6.0, -3.0, 6.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-8.0, -9.0, -8.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-4.0, -3.0, -5.0, 8.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(0.0, 3.0, 7.0, -5.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(7.0, -2.0, -8.0, 8.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0][0] = (vec3(5.0, -6.0, 0.0));
	block.var[0][0][0][1] = (vec3(-8.0, -2.0, 8.0));
	block.var[0][0][1][0] = (vec3(8.0, 0.0, 3.0));
	block.var[0][0][1][1] = (vec3(-6.0, -6.0, -1.0));
	block.var[0][0][2][0] = (vec3(2.0, -9.0, 1.0));
	block.var[0][0][2][1] = (vec3(3.0, 2.0, 1.0));
	block.var[0][1][0][0] = (vec3(8.0, -3.0, 3.0));
	block.var[0][1][0][1] = (vec3(8.0, 1.0, 3.0));
	block.var[0][1][1][0] = (vec3(6.0, 2.0, 9.0));
	block.var[0][1][1][1] = (vec3(-2.0, -9.0, -9.0));
	block.var[0][1][2][0] = (vec3(6.0, -2.0, -3.0));
	block.var[0][1][2][1] = (vec3(-8.0, -5.0, -2.0));
	block.var[1][0][0][0] = (vec3(5.0, -6.0, -8.0));
	block.var[1][0][0][1] = (vec3(-6.0, -5.0, -9.0));
	block.var[1][0][1][0] = (vec3(6.0, -9.0, 0.0));
	block.var[1][0][1][1] = (vec3(-1.0, -3.0, -6.0));
	block.var[1][0][2][0] = (vec3(9.0, 7.0, -5.0));
	block.var[1][0][2][1] = (vec3(-7.0, -2.0, -1.0));
	block.var[1][1][0][0] = (vec3(-5.0, 0.0, -9.0));
	block.var[1][1][0][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[1][1][1][0] = (vec3(-3.0, -1.0, 7.0));
	block.var[1][1][1][1] = (vec3(1.0, 1.0, 4.0));
	block.var[1][1][2][0] = (vec3(-2.0, 7.0, 0.0));
	block.var[1][1][2][1] = (vec3(1.0, 9.0, -4.0));
	block.var[2][0][0][0] = (vec3(-3.0, 0.0, 3.0));
	block.var[2][0][0][1] = (vec3(3.0, 5.0, -1.0));
	block.var[2][0][1][0] = (vec3(-1.0, 3.0, -1.0));
	block.var[2][0][1][1] = (vec3(-7.0, 7.0, -6.0));
	block.var[2][0][2][0] = (vec3(-6.0, -8.0, 2.0));
	block.var[2][0][2][1] = (vec3(-4.0, -3.0, -3.0));
	block.var[2][1][0][0] = (vec3(0.0, -1.0, 8.0));
	block.var[2][1][0][1] = (vec3(9.0, -4.0, 6.0));
	block.var[2][1][1][0] = (vec3(5.0, -2.0, 0.0));
	block.var[2][1][1][1] = (vec3(6.0, 6.0, 3.0));
	block.var[2][1][2][0] = (vec3(8.0, 3.0, 2.0));
	block.var[2][1][2][1] = (vec3(2.0, -8.0, 0.0));
	block.var[3][0][0][0] = (vec3(4.0, 8.0, 7.0));
	block.var[3][0][0][1] = (vec3(-2.0, -7.0, -5.0));
	block.var[3][0][1][0] = (vec3(5.0, -5.0, 1.0));
	block.var[3][0][1][1] = (vec3(-1.0, 7.0, -5.0));
	block.var[3][0][2][0] = (vec3(8.0, -7.0, -2.0));
	block.var[3][0][2][1] = (vec3(4.0, 3.0, -7.0));
	block.var[3][1][0][0] = (vec3(-1.0, 2.0, 7.0));
	block.var[3][1][0][1] = (vec3(7.0, 4.0, -1.0));
	block.var[3][1][1][0] = (vec3(-5.0, -6.0, -9.0));
	block.var[3][1][1][1] = (vec3(7.0, 3.0, 7.0));
	block.var[3][1][2][0] = (vec3(3.0, -9.0, 1.0));
	block.var[3][1][2][1] = (vec3(-3.0, 5.0, -4.0));
}
#version 450
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
	u8vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0][0]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0][1]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0][2]), uvec3(6u, 0u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][0]), uvec3(6u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][1]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][2]), uvec3(9u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][0]), uvec3(4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][1]), uvec3(1u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][2]), uvec3(4u, 6u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][0]), uvec3(1u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][1]), uvec3(9u, 8u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][2]), uvec3(3u, 5u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][0]), uvec3(8u, 1u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][1]), uvec3(1u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][2]), uvec3(0u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][0]), uvec3(0u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][1]), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][2]), uvec3(6u, 5u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][0]), uvec3(1u, 2u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][1]), uvec3(2u, 4u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][2]), uvec3(0u, 7u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][0]), uvec3(9u, 8u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][1]), uvec3(8u, 8u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][2]), uvec3(5u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(4u);
	block.var[0][0][0] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[0][0][1] = u8vec3(uvec3(9u, 4u, 7u));
	block.var[0][0][2] = u8vec3(uvec3(1u, 5u, 1u));
	block.var[0][1][0] = u8vec3(uvec3(7u, 3u, 9u));
	block.var[0][1][1] = u8vec3(uvec3(8u, 1u, 6u));
	block.var[0][1][2] = u8vec3(uvec3(2u, 7u, 0u));
	block.var[1][0][0] = u8vec3(uvec3(7u, 9u, 3u));
	block.var[1][0][1] = u8vec3(uvec3(4u, 3u, 5u));
	block.var[1][0][2] = u8vec3(uvec3(7u, 4u, 5u));
	block.var[1][1][0] = u8vec3(uvec3(2u, 7u, 4u));
	block.var[1][1][1] = u8vec3(uvec3(8u, 8u, 6u));
	block.var[1][1][2] = u8vec3(uvec3(1u, 2u, 3u));
	block.var[2][0][0] = u8vec3(uvec3(4u, 7u, 0u));
	block.var[2][0][1] = u8vec3(uvec3(0u, 5u, 2u));
	block.var[2][0][2] = u8vec3(uvec3(5u, 5u, 5u));
	block.var[2][1][0] = u8vec3(uvec3(6u, 6u, 2u));
	block.var[2][1][1] = u8vec3(uvec3(7u, 9u, 4u));
	block.var[2][1][2] = u8vec3(uvec3(0u, 2u, 1u));
	block.var[3][0][0] = u8vec3(uvec3(9u, 6u, 9u));
	block.var[3][0][1] = u8vec3(uvec3(7u, 3u, 9u));
	block.var[3][0][2] = u8vec3(uvec3(4u, 9u, 5u));
	block.var[3][1][0] = u8vec3(uvec3(5u, 4u, 3u));
	block.var[3][1][1] = u8vec3(uvec3(7u, 7u, 3u));
	block.var[3][1][2] = u8vec3(uvec3(8u, 8u, 1u));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(-1.0, -7.0, 6.0, -3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(2.0, -8.0, 4.0, 7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-7.0, -3.0, 9.0, -6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-5.0, -4.0, -7.0, 2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, 3.0, -9.0, -6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[0][0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[0][1][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	block.var[0][1][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	block.var[0][2][0] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	block.var[0][2][1] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	block.var[0][3][0] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
	block.var[0][3][1] = (mat4x3(-3.0, -7.0, -1.0, -5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0));
	block.var[1][0][0] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	block.var[1][0][1] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	block.var[1][1][0] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	block.var[1][1][1] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	block.var[1][2][0] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	block.var[1][2][1] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	block.var[1][3][0] = (mat4x3(-7.0, -1.0, 4.0, 4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0));
	block.var[1][3][1] = (mat4x3(-8.0, -4.0, -4.0, 2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0));
	block.var[2][0][0] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	block.var[2][0][1] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	block.var[2][1][0] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	block.var[2][1][1] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	block.var[2][2][0] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	block.var[2][2][1] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	block.var[2][3][0] = (mat4x3(1.0, -2.0, 8.0, -8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0));
	block.var[2][3][1] = (mat4x3(-7.0, -4.0, 2.0, 2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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

layout(std430, buffer_reference) buffer Block
{
	highp float var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var[0][0][0]), 7.0) && allOk;
	allOk = compare_float((block.var[0][0][1]), -1.0) && allOk;
	allOk = compare_float((block.var[0][1][0]), 4.0) && allOk;
	allOk = compare_float((block.var[0][1][1]), 2.0) && allOk;
	allOk = compare_float((block.var[0][2][0]), 1.0) && allOk;
	allOk = compare_float((block.var[0][2][1]), -3.0) && allOk;
	allOk = compare_float((block.var[0][3][0]), -4.0) && allOk;
	allOk = compare_float((block.var[0][3][1]), -5.0) && allOk;
	allOk = compare_float((block.var[1][0][0]), -6.0) && allOk;
	allOk = compare_float((block.var[1][0][1]), 0.0) && allOk;
	allOk = compare_float((block.var[1][1][0]), -1.0) && allOk;
	allOk = compare_float((block.var[1][1][1]), -6.0) && allOk;
	allOk = compare_float((block.var[1][2][0]), -7.0) && allOk;
	allOk = compare_float((block.var[1][2][1]), 8.0) && allOk;
	allOk = compare_float((block.var[1][3][0]), 9.0) && allOk;
	allOk = compare_float((block.var[1][3][1]), 7.0) && allOk;
	allOk = compare_float((block.var[2][0][0]), -7.0) && allOk;
	allOk = compare_float((block.var[2][0][1]), 5.0) && allOk;
	allOk = compare_float((block.var[2][1][0]), -2.0) && allOk;
	allOk = compare_float((block.var[2][1][1]), -1.0) && allOk;
	allOk = compare_float((block.var[2][2][0]), -9.0) && allOk;
	allOk = compare_float((block.var[2][2][1]), -4.0) && allOk;
	allOk = compare_float((block.var[2][3][0]), -7.0) && allOk;
	allOk = compare_float((block.var[2][3][1]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (-2.0);
	block.var[0][0][1] = (4.0);
	block.var[0][1][0] = (-8.0);
	block.var[0][1][1] = (9.0);
	block.var[0][2][0] = (-6.0);
	block.var[0][2][1] = (-9.0);
	block.var[0][3][0] = (5.0);
	block.var[0][3][1] = (4.0);
	block.var[1][0][0] = (6.0);
	block.var[1][0][1] = (7.0);
	block.var[1][1][0] = (-5.0);
	block.var[1][1][1] = (8.0);
	block.var[1][2][0] = (-4.0);
	block.var[1][2][1] = (3.0);
	block.var[1][3][0] = (-8.0);
	block.var[1][3][1] = (5.0);
	block.var[2][0][0] = (-4.0);
	block.var[2][0][1] = (5.0);
	block.var[2][1][0] = (-5.0);
	block.var[2][1][1] = (6.0);
	block.var[2][2][0] = (7.0);
	block.var[2][2][1] = (6.0);
	block.var[2][3][0] = (8.0);
	block.var[2][3][1] = (9.0);
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[0][1][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	block.var[0][1][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	block.var[0][2][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	block.var[0][2][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	block.var[0][3][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	block.var[0][3][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	block.var[1][0][0] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	block.var[1][0][1] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	block.var[1][1][0] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	block.var[1][1][1] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	block.var[1][2][0] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	block.var[1][2][1] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	block.var[1][3][0] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	block.var[1][3][1] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	block.var[2][0][0] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	block.var[2][0][1] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	block.var[2][1][0] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	block.var[2][1][1] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	block.var[2][2][0] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	block.var[2][2][1] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	block.var[2][3][0] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	block.var[2][3][1] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[0][1][0][0] = (vec3(6.0, -2.0, 0.0));
	block.var[0][1][0][1] = (vec3(3.0, 4.0, -6.0));
	block.var[0][1][1][0] = (vec3(3.0, -6.0, 2.0));
	block.var[0][1][1][1] = (vec3(4.0, -8.0, 0.0));
	block.var[0][2][0][0] = (vec3(0.0, 9.0, -7.0));
	block.var[0][2][0][1] = (vec3(5.0, 6.0, -3.0));
	block.var[0][2][1][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[0][2][1][1] = (vec3(7.0, 9.0, -2.0));
	block.var[0][3][0][0] = (vec3(5.0, -2.0, -1.0));
	block.var[0][3][0][1] = (vec3(7.0, -7.0, 5.0));
	block.var[0][3][1][0] = (vec3(-3.0, 6.0, 7.0));
	block.var[0][3][1][1] = (vec3(6.0, -5.0, -2.0));
	block.var[1][0][0][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][0][0][1] = (vec3(7.0, 0.0, -8.0));
	block.var[1][0][1][0] = (vec3(0.0, -5.0, 5.0));
	block.var[1][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][1][0][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[1][1][0][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[1][1][1][0] = (vec3(4.0, -9.0, -1.0));
	block.var[1][1][1][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[1][2][0][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][2][0][1] = (vec3(8.0, -6.0, 8.0));
	block.var[1][2][1][0] = (vec3(4.0, -8.0, 4.0));
	block.var[1][2][1][1] = (vec3(4.0, 5.0, 5.0));
	block.var[1][3][0][0] = (vec3(2.0, -1.0, 2.0));
	block.var[1][3][0][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][3][1][0] = (vec3(-2.0, 0.0, -6.0));
	block.var[1][3][1][1] = (vec3(2.0, -7.0, -2.0));
	block.var[2][0][0][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[2][0][0][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[2][0][1][0] = (vec3(2.0, -3.0, 6.0));
	block.var[2][0][1][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[2][1][0][0] = (vec3(2.0, -2.0, 4.0));
	block.var[2][1][0][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[2][1][1][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[2][1][1][1] = (vec3(2.0, 0.0, 5.0));
	block.var[2][2][0][0] = (vec3(2.0, 3.0, 6.0));
	block.var[2][2][0][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[2][2][1][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[2][2][1][1] = (vec3(6.0, 2.0, 2.0));
	block.var[2][3][0][0] = (vec3(1.0, -8.0, -3.0));
	block.var[2][3][0][1] = (vec3(7.0, 3.0, 1.0));
	block.var[2][3][1][0] = (vec3(2.0, -8.0, 6.0));
	block.var[2][3][1][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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
	highp vec4 var[][4][2];
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
	allOk = compare_vec4((block.var[0][1][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[0][2][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.var[0][2][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block.var[0][3][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[0][3][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][0]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][1]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][0]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][1]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[1][2][0]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((block.var[1][2][1]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[1][3][0]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[1][3][1]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][0]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][1]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][0]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][1]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((block.var[2][2][0]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][2][1]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][3][0]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[2][3][1]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[0][1][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	block.var[0][1][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	block.var[0][2][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	block.var[0][2][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	block.var[0][3][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	block.var[0][3][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	block.var[1][0][0] = (vec4(5.0, -9.0, 4.0, -1.0));
	block.var[1][0][1] = (vec4(-7.0, -6.0, -2.0, -8.0));
	block.var[1][1][0] = (vec4(-9.0, 2.0, -6.0, 6.0));
	block.var[1][1][1] = (vec4(6.0, 2.0, -3.0, 0.0));
	block.var[1][2][0] = (vec4(8.0, -1.0, -6.0, -8.0));
	block.var[1][2][1] = (vec4(9.0, 7.0, -3.0, -8.0));
	block.var[1][3][0] = (vec4(0.0, -7.0, -2.0, -7.0));
	block.var[1][3][1] = (vec4(3.0, -8.0, 1.0, 6.0));
	block.var[2][0][0] = (vec4(8.0, 7.0, 5.0, 1.0));
	block.var[2][0][1] = (vec4(-6.0, -5.0, -8.0, 8.0));
	block.var[2][1][0] = (vec4(-9.0, 8.0, -8.0, 0.0));
	block.var[2][1][1] = (vec4(2.0, 6.0, 6.0, 1.0));
	block.var[2][2][0] = (vec4(-3.0, -9.0, 2.0, 1.0));
	block.var[2][2][1] = (vec4(-7.0, 3.0, -5.0, 8.0));
	block.var[2][3][0] = (vec4(0.0, 5.0, -3.0, -2.0));
	block.var[2][3][1] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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
	highp uint var[][4][2];
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
	allOk = compare_uint((block.var[0][1][0]), 6u) && allOk;
	allOk = compare_uint((block.var[0][1][1]), 4u) && allOk;
	allOk = compare_uint((block.var[0][2][0]), 7u) && allOk;
	allOk = compare_uint((block.var[0][2][1]), 8u) && allOk;
	allOk = compare_uint((block.var[0][3][0]), 4u) && allOk;
	allOk = compare_uint((block.var[0][3][1]), 8u) && allOk;
	allOk = compare_uint((block.var[1][0][0]), 9u) && allOk;
	allOk = compare_uint((block.var[1][0][1]), 0u) && allOk;
	allOk = compare_uint((block.var[1][1][0]), 2u) && allOk;
	allOk = compare_uint((block.var[1][1][1]), 5u) && allOk;
	allOk = compare_uint((block.var[1][2][0]), 6u) && allOk;
	allOk = compare_uint((block.var[1][2][1]), 9u) && allOk;
	allOk = compare_uint((block.var[1][3][0]), 7u) && allOk;
	allOk = compare_uint((block.var[1][3][1]), 9u) && allOk;
	allOk = compare_uint((block.var[2][0][0]), 3u) && allOk;
	allOk = compare_uint((block.var[2][0][1]), 7u) && allOk;
	allOk = compare_uint((block.var[2][1][0]), 7u) && allOk;
	allOk = compare_uint((block.var[2][1][1]), 5u) && allOk;
	allOk = compare_uint((block.var[2][2][0]), 0u) && allOk;
	allOk = compare_uint((block.var[2][2][1]), 1u) && allOk;
	allOk = compare_uint((block.var[2][3][0]), 7u) && allOk;
	allOk = compare_uint((block.var[2][3][1]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (7u);
	block.var[0][0][1] = (9u);
	block.var[0][1][0] = (4u);
	block.var[0][1][1] = (8u);
	block.var[0][2][0] = (7u);
	block.var[0][2][1] = (8u);
	block.var[0][3][0] = (6u);
	block.var[0][3][1] = (8u);
	block.var[1][0][0] = (1u);
	block.var[1][0][1] = (0u);
	block.var[1][1][0] = (7u);
	block.var[1][1][1] = (5u);
	block.var[1][2][0] = (6u);
	block.var[1][2][1] = (1u);
	block.var[1][3][0] = (6u);
	block.var[1][3][1] = (2u);
	block.var[2][0][0] = (7u);
	block.var[2][0][1] = (7u);
	block.var[2][1][0] = (7u);
	block.var[2][1][1] = (2u);
	block.var[2][2][0] = (9u);
	block.var[2][2][1] = (8u);
	block.var[2][3][0] = (5u);
	block.var[2][3][1] = (3u);
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[0][1][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[0][1][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[0][2][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	block.var[0][2][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	block.var[0][3][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	block.var[0][3][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	block.var[1][0][0] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[1][0][1] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[1][1][0] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[1][1][1] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[1][2][0] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	block.var[1][2][1] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	block.var[1][3][0] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	block.var[1][3][1] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	block.var[2][0][0] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[2][0][1] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[2][1][0] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[2][1][1] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	block.var[2][2][0] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	block.var[2][2][1] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	block.var[2][3][0] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	block.var[2][3][1] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_uint((block.u), 1u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(-8.0, -9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-9.0, -3.0, 2.0, -5.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(8u, 3u, 6u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-6.0, 8.0, -7.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(5u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(5.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(3.0, 4.0, 3.0, 4.0)) && allOk;
	allOk = compare_int((block.t[0].c), -9) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(-9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0, 8.0, -9.0, 2.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-5.0, 6.0, 6.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-2.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(6u, 0u, 5u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-3.0, 7.0, 7.0, -2.0)) && allOk;
	allOk = compare_int((block.t[1].c), 0) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(7.0, -3.0, -2.0, 6.0, 9.0, 6.0, -5.0, -9.0, -5.0, -6.0, -4.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(0u, 0u, 5u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(-2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(5u, 5u, 6u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(8.0, 1.0, -4.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(6u, 7u, 3u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(-8.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_int((block.t[2].c), -7) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(-8.0, -4.0, -8.0, 5.0, -9.0, -1.0, 7.0, -9.0, -8.0, -4.0, -5.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(0u, 2u, 1u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(5.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(7u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(7.0, -3.0, -3.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(7.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_int((block.t[3].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(4u, 4u, 9u));
	block.s.b[0] = (vec2(8.0, -7.0));
	block.s.b[1] = (vec2(8.0, -2.0));
	block.s.b[2] = (vec2(-2.0, -6.0));
	block.s.b[3] = (vec2(6.0, 0.0));
	block.s.c = (vec4(-6.0, -4.0, 3.0, -6.0));
	block.u = (5u);
}
#version 450
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
	allOk = compare_mat3(block[0].var, mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block[1].var = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block[2].var = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
}
#version 450
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
	highp uint a;
	mediump ivec4 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 7u) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(-3, 2, -4, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (ivec4(7, -2, 6, 0));
}
#version 450
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
	lowp mat2x3 a;
	mediump mat4x2 b;
	highp vec4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b, mat4x2(4.0, 5.0, 3.0, 7.0, 5.0, 1.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(-5.0, 7.0, -5.0, 5.0, -3.0, 4.0, -8.0, 9.0));
}
#version 450
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
	bvec2 a[1];
	mediump mat3 b;
	bvec4 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat3x2 d;
	highp mat4x2 e;
	bool f;
	lowp vec3 g;
	mediump mat4x2 h[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec2 i;
	mediump vec3 j;
	highp mat2 k;
	highp uvec4 l[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0]), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockB.b, mat3(-5.0, 2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(1.0, 6.0, -8.0, -9.0, 0.0, -1.0, -1.0, 5.0)) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_vec3((blockC.g), vec3(-1.0, -2.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockD.i), bvec2(false, false)) && allOk;
	allOk = compare_vec3((blockD.j), vec3(6.0, -8.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockD.l[0]), uvec4(5u, 9u, 5u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3(6.0, 2.0, -8.0, 7.0, 6.0, -4.0, 5.0, 7.0, 9.0));
	blockB.c[0] = (bvec4(true, true, false, true));
	blockC.e = (mat4x2(6.0, 6.0, -9.0, 7.0, 6.0, 3.0, 9.0, -8.0));
	blockC.g = (vec3(4.0, -5.0, 0.0));
	blockC.h[0] = (mat4x2(-7.0, -1.0, 7.0, 9.0, 5.0, -4.0, -6.0, 0.0));
	blockD.j = (vec3(5.0, -8.0, 0.0));
	blockD.k = (mat2(-6.0, 9.0, 3.0, -2.0));
}
#version 450
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
	highp mat3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat3 c;
	bvec3 d;
	mediump mat4x2 e;
	mediump float f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp int g;
	mediump uvec3 h;
	mediump mat4 i[1];
	highp ivec4 j[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-1.0, -1.0, -5.0, 2.0, -6.0, 8.0, -7.0, -4.0)) && allOk;
	allOk = compare_float((blockC.f[0]), -7.0) && allOk;
	allOk = compare_int((blockD.g), -2) && allOk;
	allOk = compare_mat4(blockD.i[0], mat4(-1.0, 5.0, 2.0, 5.0, 5.0, -9.0, -3.0, -8.0, 9.0, 2.0, -9.0, -9.0, -1.0, 3.0, -2.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockD.j[0]), ivec4(-1, 5, 8, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2.0);
	blockC.c = (mat3(4.0, -6.0, 2.0, 6.0, 4.0, 6.0, -5.0, 2.0, -9.0));
	blockC.d = (bvec3(false, true, false));
	blockC.e = (mat4x2(5.0, 6.0, -6.0, 3.0, 7.0, -8.0, -2.0, -6.0));
	blockD.h = (uvec3(4u, 8u, 6u));
}
#version 450
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
	lowp uvec3 b;
	highp uvec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
	blockB.b = (uvec3(1u, 0u, 4u));
	blockB.c[0] = (uvec2(9u, 4u));
}
#version 450
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
	bool b;
	lowp mat3x4 c;
	highp uvec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].b), true) && allOk;
	allOk = compare_mat3x4(blockB[0].c, mat3x4(7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB[1].a), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].b), false) && allOk;
	allOk = compare_mat3x4(blockB[1].c, mat3x4(1.0, 1.0, -4.0, -5.0, -1.0, 2.0, 4.0, -2.0, 2.0, -1.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, true, true));
	blockB[0].b = (false);
	blockB[0].c = (mat3x4(5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0));
	blockB[0].d[0] = (uvec2(8u, 0u));
	blockB[0].d[1] = (uvec2(6u, 2u));
	blockB[0].d[2] = (uvec2(6u, 4u));
	blockB[0].d[3] = (uvec2(5u, 0u));
	blockB[0].d[4] = (uvec2(3u, 3u));
	blockB[1].a = (bvec4(false, false, true, false));
	blockB[1].b = (false);
	blockB[1].c = (mat3x4(8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0));
	blockB[1].d[0] = (uvec2(7u, 3u));
	blockB[1].d[1] = (uvec2(9u, 8u));
	blockB[1].d[2] = (uvec2(2u, 7u));
	blockB[1].d[3] = (uvec2(3u, 1u));
	blockB[1].d[4] = (uvec2(5u, 2u));
	blockB[1].d[5] = (uvec2(1u, 8u));
}
#version 450
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
	mediump uint a;
	mediump vec4 b;
	highp vec3 c;
	highp vec2 d;
	mediump vec3 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp vec4 f;
	highp ivec2 g;
	lowp ivec4 h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	bool i;
	bvec3 j;
	mediump mat4x3 k;
	lowp vec3 l;
	bvec4 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-3.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(6.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.e[0]), vec3(1.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.e[1]), vec3(7.0, 3.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].f), vec4(-4.0, 8.0, -7.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g), ivec2(-3, 4)) && allOk;
	allOk = compare_ivec4((blockC[0].h[0]), ivec4(-3, -7, -7, -1)) && allOk;
	allOk = compare_ivec4((blockC[0].h[1]), ivec4(9, -6, 8, -4)) && allOk;
	allOk = compare_ivec4((blockC[0].h[2]), ivec4(4, 1, -6, -2)) && allOk;
	allOk = compare_ivec4((blockC[0].h[3]), ivec4(-3, -5, 4, 3)) && allOk;
	allOk = compare_ivec4((blockC[0].h[4]), ivec4(0, 6, -1, -8)) && allOk;
	allOk = compare_ivec4((blockC[0].h[5]), ivec4(-3, -6, 1, 7)) && allOk;
	allOk = compare_ivec4((blockC[0].h[6]), ivec4(6, -5, -9, 2)) && allOk;
	allOk = compare_ivec4((blockC[0].h[7]), ivec4(9, 7, 3, 6)) && allOk;
	allOk = compare_vec4((blockC[1].f), vec4(2.0, 0.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockC[1].g), ivec2(1, 0)) && allOk;
	allOk = compare_ivec4((blockC[1].h[0]), ivec4(9, -2, -1, -4)) && allOk;
	allOk = compare_ivec4((blockC[1].h[1]), ivec4(-8, 0, 6, -5)) && allOk;
	allOk = compare_ivec4((blockC[1].h[2]), ivec4(-2, -7, -1, 7)) && allOk;
	allOk = compare_ivec4((blockC[1].h[3]), ivec4(-2, -9, -7, -2)) && allOk;
	allOk = compare_ivec4((blockC[1].h[4]), ivec4(-3, -3, -9, 6)) && allOk;
	allOk = compare_ivec4((blockC[1].h[5]), ivec4(9, -7, 9, -7)) && allOk;
	allOk = compare_vec4((blockC[2].f), vec4(9.0, -3.0, -4.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockC[2].g), ivec2(-7, -2)) && allOk;
	allOk = compare_ivec4((blockC[2].h[0]), ivec4(6, -3, 7, 7)) && allOk;
	allOk = compare_ivec4((blockC[2].h[1]), ivec4(8, -8, -9, 3)) && allOk;
	allOk = compare_ivec4((blockC[2].h[2]), ivec4(-2, 0, 5, -6)) && allOk;
	allOk = compare_ivec4((blockC[2].h[3]), ivec4(-6, -2, 8, -9)) && allOk;
	allOk = compare_ivec4((blockC[2].h[4]), ivec4(-6, -2, 7, 4)) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
	allOk = compare_vec3((blockD.l), vec3(9.0, -6.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockD.m), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (vec4(7.0, -2.0, 6.0, 0.0));
	blockB.c = (vec3(5.0, 9.0, -5.0));
	blockB.e[0] = (vec3(-1.0, 6.0, 5.0));
	blockB.e[1] = (vec3(8.0, 6.0, 2.0));
	blockC[0].f = (vec4(-7.0, -2.0, -4.0, -2.0));
	blockC[0].g = (ivec2(4, -2));
	blockC[0].h[0] = (ivec4(3, 0, -8, 6));
	blockC[0].h[1] = (ivec4(-7, 4, 6, -2));
	blockC[0].h[2] = (ivec4(-5, 3, 0, 9));
	blockC[0].h[3] = (ivec4(-2, 3, -3, 3));
	blockC[0].h[4] = (ivec4(2, 2, -6, -8));
	blockC[0].h[5] = (ivec4(-6, 4, -7, -9));
	blockC[0].h[6] = (ivec4(7, -3, -1, -2));
	blockC[0].h[7] = (ivec4(-4, 3, -1, 4));
	blockC[1].f = (vec4(-2.0, 9.0, -2.0, 8.0));
	blockC[1].g = (ivec2(-5, -8));
	blockC[1].h[0] = (ivec4(9, 2, -2, -2));
	blockC[1].h[1] = (ivec4(7, 3, 7, 3));
	blockC[1].h[2] = (ivec4(-1, -2, 1, 2));
	blockC[1].h[3] = (ivec4(-4, 2, -8, -6));
	blockC[1].h[4] = (ivec4(2, -5, -6, -3));
	blockC[1].h[5] = (ivec4(-2, 7, -4, -1));
	blockC[2].f = (vec4(-5.0, -8.0, 5.0, 8.0));
	blockC[2].g = (ivec2(-8, -5));
	blockC[2].h[0] = (ivec4(2, -9, -3, -9));
	blockC[2].h[1] = (ivec4(-2, 5, 4, 2));
	blockC[2].h[2] = (ivec4(-8, -8, 2, 2));
	blockC[2].h[3] = (ivec4(6, 5, 2, -4));
	blockC[2].h[4] = (ivec4(-9, -7, 4, 0));
	blockD.i = (false);
	blockD.j = (bvec3(true, false, false));
	blockD.k = (mat4x3(3.0, -2.0, -9.0, -5.0, -3.0, -9.0, 7.0, 9.0, 8.0, 2.0, 9.0, 7.0));
	blockD.l = (vec3(-2.0, -3.0, -2.0));
	blockD.m = (bvec4(true, false, true, false));
}
#version 450
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
	highp uint a[3];
	highp mat2x3 b;
	bool c;
	highp mat4x3 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bvec4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat4x2 f;
	highp mat4x3 g[][2];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	bvec4 h;
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 4u) && allOk;
	allOk = compare_uint((blockB.a[1]), 0u) && allOk;
	allOk = compare_uint((blockB.a[2]), 4u) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(0.0, 5.0, -5.0, 5.0, 5.0, -2.0)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_mat4x3(blockB.d[0], mat4x3(1.0, 9.0, 5.0, -6.0, 7.0, -5.0, -8.0, -8.0, -8.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[1], mat4x3(7.0, 7.0, 5.0, -5.0, -8.0, 0.0, 8.0, -4.0, -2.0, -5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[2], mat4x3(0.0, 6.0, 0.0, 8.0, -7.0, -4.0, -4.0, -9.0, -6.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[3], mat4x3(5.0, -6.0, -6.0, 1.0, 6.0, -6.0, -5.0, 9.0, -3.0, -8.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[4], mat4x3(-3.0, 9.0, -7.0, -3.0, 6.0, 0.0, -1.0, 3.0, 1.0, -1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[5], mat4x3(-2.0, 4.0, -7.0, -9.0, -9.0, -6.0, -5.0, -7.0, -9.0, -6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[6], mat4x3(7.0, -3.0, 5.0, 3.0, 0.0, 7.0, -4.0, 4.0, -3.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockC.e[0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.e[1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[2]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[3]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.e[4]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_mat4x2(blockD[0].f, mat4x2(-1.0, 3.0, -2.0, -2.0, 7.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].g[0][0], mat4x3(-8.0, -4.0, -9.0, -7.0, 0.0, 4.0, -6.0, 2.0, 5.0, -6.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].g[0][1], mat4x3(8.0, 0.0, 7.0, 9.0, 6.0, 4.0, -9.0, 9.0, 3.0, 3.0, -8.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockE.h), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (8u);
	blockB.a[1] = (3u);
	blockB.a[2] = (1u);
	blockB.b = (mat2x3(0.0, 9.0, 2.0, -3.0, -5.0, 1.0));
	blockB.c = (false);
	blockB.d[0] = (mat4x3(6.0, 5.0, 7.0, 2.0, -5.0, -9.0, 9.0, 8.0, -3.0, 8.0, -1.0, -1.0));
	blockB.d[1] = (mat4x3(6.0, -4.0, -8.0, -2.0, 2.0, -4.0, -4.0, -4.0, 1.0, 9.0, 4.0, -4.0));
	blockB.d[2] = (mat4x3(-4.0, -8.0, 0.0, -7.0, 6.0, 2.0, -1.0, 2.0, -2.0, 9.0, -1.0, -1.0));
	blockB.d[3] = (mat4x3(3.0, 2.0, -1.0, 0.0, 1.0, 2.0, -8.0, -2.0, -5.0, 9.0, -3.0, 4.0));
	blockB.d[4] = (mat4x3(-6.0, 6.0, -7.0, -5.0, 6.0, -3.0, -3.0, -1.0, -6.0, -5.0, -3.0, -2.0));
	blockB.d[5] = (mat4x3(0.0, 1.0, 1.0, -2.0, 8.0, 6.0, -3.0, -6.0, -6.0, -8.0, -3.0, -9.0));
	blockB.d[6] = (mat4x3(6.0, 5.0, -6.0, 8.0, -6.0, -2.0, -8.0, -6.0, 3.0, 9.0, -1.0, -4.0));
	blockC.e[0] = (bvec4(false, false, false, false));
	blockC.e[1] = (bvec4(true, true, true, true));
	blockC.e[2] = (bvec4(false, false, true, false));
	blockC.e[3] = (bvec4(true, false, false, false));
	blockC.e[4] = (bvec4(false, true, true, true));
	blockD[0].f = (mat4x2(-6.0, -2.0, -4.0, -6.0, 3.0, -4.0, -9.0, 0.0));
	blockE.h = (bvec4(true, true, true, false));
}
#version 450
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
	layout(offset = 0) mediump uvec3 a;
	layout(offset = 16) highp uvec4 b[1];
	layout(offset = 32) bvec2 c;
	layout(offset = 40) bvec2 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump int e;
	layout(offset = 4) mediump uint f;
	layout(offset = 8) bvec2 g;
	layout(offset = 16) lowp float h;
	layout(offset = 32) lowp vec4 i;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) bool j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp uvec4 k;
	layout(offset = 16) mediump vec2 l;
	layout(offset = 24) mediump uvec2 m;
	layout(offset = 32) highp ivec3 n;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b[0]), uvec4(9u, 8u, 7u, 2u)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(false, false)) && allOk;
	allOk = compare_int((blockC.e), 6) && allOk;
	allOk = compare_uint((blockC.f), 1u) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockC.i), vec4(-7.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
	allOk = compare_ivec3((blockE.n), ivec3(3, 8, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(4u, 4u, 5u));
	blockB.b[0] = (uvec4(2u, 7u, 4u, 8u));
	blockB.c = (bvec2(false, true));
	blockB.d = (bvec2(false, false));
	blockC.e = (7);
	blockC.f = (1u);
	blockC.g = (bvec2(false, false));
	blockC.h = (-8.0);
	blockE.k = (uvec4(1u, 9u, 7u, 6u));
	blockE.l = (vec2(-9.0, -3.0));
	blockE.m = (uvec2(5u, 2u));
	blockE.n = (ivec3(9, -7, -7));
}
#version 450
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
	layout(offset = 0) highp uvec3 a;
	layout(offset = 16) bvec3 b;
	layout(offset = 32) bvec2 c;
	layout(offset = 48) highp uvec3 d;
	layout(offset = 64) highp vec2 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp int f[1];
	layout(offset = 4) mediump uint g;
	layout(offset = 16) highp uvec3 h;
	layout(offset = 28) highp float i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump ivec4 j;
	layout(offset = 16) mediump vec3 k;
	layout(offset = 32) bvec2 l;
	layout(offset = 48) lowp uvec3 m[1];
	layout(offset = 64) bvec2 n;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp uvec4 o;
	layout(offset = 16) mediump vec2 p;
	layout(offset = 24) bvec2 q;
	layout(offset = 32) bvec3 r;
	layout(offset = 48) mediump vec2 s[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
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
	allOk = compare_ivec4((blockD.j), ivec4(-3, 0, 4, 7)) && allOk;
	allOk = compare_vec3((blockD.k), vec3(-8.0, 3.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockD.l), bvec2(false, true)) && allOk;
	allOk = compare_uvec3((blockD.m[0]), uvec3(2u, 6u, 0u)) && allOk;
	allOk = compare_bvec2((blockD.n), bvec2(false, false)) && allOk;
	allOk = compare_uvec4((blockE[0].o), uvec4(9u, 8u, 6u, 8u)) && allOk;
	allOk = compare_vec2((blockE[0].p), vec2(5.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockE[0].r), bvec3(false, false, true)) && allOk;
	allOk = compare_vec2((blockE[0].s[0]), vec2(6.0, 1.0)) && allOk;
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
	blockD.k = (vec3(2.0, 9.0, 7.0));
	blockD.l = (bvec2(true, true));
	blockD.m[0] = (uvec3(9u, 3u, 3u));
	blockD.n = (bvec2(true, true));
	blockE[0].p = (vec2(-7.0, -1.0));
	blockE[0].q = (bvec2(false, true));
	blockE[0].r = (bvec3(true, true, true));
	blockE[0].s[0] = (vec2(9.0, -4.0));
}
#version 450
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
	highp uint mA;
	sA mB;
	bvec3 mC;
	mediump uint mD;
};
struct sC
{
	mediump vec4 mA;
	highp ivec4 mB;
	lowp ivec2 mC;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp mat3 a;
	bvec4 b;
	sB c;
	mediump vec3 d;
	mediump ivec2 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp mat2x3 f;
	mediump float g;
	sC h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[0].a, mat3(-7.0, 8.0, 8.0, 2.0, 4.0, 0.0, -2.0, 6.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uint((blockB[0].c.mA), 7u) && allOk;
	allOk = compare_int((blockB[0].c.mB.mA), 0) && allOk;
	allOk = compare_bvec3((blockB[0].c.mC), bvec3(false, false, false)) && allOk;
	allOk = compare_uint((blockB[0].c.mD), 4u) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(-5.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB[1].a, mat3(2.0, 7.0, -1.0, -3.0, 5.0, 0.0, 2.0, 7.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockB[1].c.mA), 1u) && allOk;
	allOk = compare_int((blockB[1].c.mB.mA), 4) && allOk;
	allOk = compare_bvec3((blockB[1].c.mC), bvec3(false, true, true)) && allOk;
	allOk = compare_uint((blockB[1].c.mD), 5u) && allOk;
	allOk = compare_vec3((blockB[1].d), vec3(-1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(1.0, 5.0, -1.0, 3.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h.mA), vec4(-9.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockC.h.mB), ivec4(9, 3, -1, -8)) && allOk;
	allOk = compare_ivec2((blockC.h.mC), ivec2(-1, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0));
	blockB[0].d = (vec3(-3.0, -9.0, -5.0));
	blockB[0].e[0] = (ivec2(3, 5));
	blockB[0].e[1] = (ivec2(-5, -2));
	blockB[0].e[2] = (ivec2(-2, 8));
	blockB[0].e[3] = (ivec2(-3, -3));
	blockB[0].e[4] = (ivec2(-8, 1));
	blockB[0].e[5] = (ivec2(-3, -1));
	blockB[0].e[6] = (ivec2(3, 7));
	blockB[0].e[7] = (ivec2(-4, -5));
	blockB[1].a = (mat3(-1.0, -3.0, 1.0, -9.0, 8.0, 9.0, -8.0, -8.0, 3.0));
	blockB[1].d = (vec3(-6.0, -2.0, -6.0));
	blockB[1].e[0] = (ivec2(9, 9));
	blockB[1].e[1] = (ivec2(-9, 5));
	blockB[1].e[2] = (ivec2(-3, 9));
	blockB[1].e[3] = (ivec2(-9, -7));
	blockB[1].e[4] = (ivec2(6, 9));
	blockB[1].e[5] = (ivec2(0, 4));
	blockC.f = (mat2x3(5.0, -3.0, 0.0, 5.0, 0.0, 1.0));
	blockC.g = (-1.0);
	blockC.h.mA = (vec4(0.0, -7.0, -6.0, 7.0));
	blockC.h.mB = (ivec4(-2, -1, -5, -6));
	blockC.h.mC = (ivec2(-6, 2));
}
#version 450
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
	highp uvec3 mB;
	highp ivec3 mC;
};
struct sB
{
	sA mA;
	highp uvec2 mB[6];
	bvec2 mC[2];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	sB a;
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp float b;
	mediump ivec3 c;
	bvec2 d;
	highp ivec2 e;
	bvec2 f[][6];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	bvec3 g;
	lowp float h;
	highp uvec3 i;
	mediump float j[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp uvec3 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a.mA.mA), uvec3(2u, 6u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a.mA.mB), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_ivec3((blockB.a.mA.mC), ivec3(3, 9, 5)) && allOk;
	allOk = compare_uvec2((blockB.a.mB[0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.a.mB[1]), uvec2(9u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.a.mB[2]), uvec2(3u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.a.mB[3]), uvec2(3u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.a.mB[4]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.a.mB[5]), uvec2(7u, 7u)) && allOk;
	allOk = compare_bvec2((blockB.a.mC[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.a.mC[1]), bvec2(true, true)) && allOk;
	allOk = compare_float((blockC[0].b), 7.0) && allOk;
	allOk = compare_ivec3((blockC[0].c), ivec3(-3, -2, 4)) && allOk;
	allOk = compare_bvec2((blockC[0].d), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[0][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[0][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[0][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[1][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[1][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[2][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[2][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[2][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[3][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[3][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[3][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[3][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[3][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[4][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[4][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[4][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[4][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[4][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[4][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[5][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[5][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[5][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[5][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[5][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[5][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[6][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[6][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[6][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[6][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[6][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[6][5]), bvec2(false, false)) && allOk;
	allOk = compare_float((blockC[1].b), -2.0) && allOk;
	allOk = compare_ivec3((blockC[1].c), ivec3(-1, 1, -4)) && allOk;
	allOk = compare_bvec2((blockC[1].d), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[0][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[0][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[0][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[1][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[1][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[1][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[2][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[2][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[2][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[3][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[3][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[3][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].f[3][4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[1].f[3][5]), bvec2(false, true)) && allOk;
	allOk = compare_float((blockC[2].b), 6.0) && allOk;
	allOk = compare_ivec3((blockC[2].c), ivec3(-1, 9, -9)) && allOk;
	allOk = compare_bvec2((blockC[2].d), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[0][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[0][4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[0][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[1][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[1][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[1][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[2][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[2][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[2][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[2][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[2][5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[3][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[2].f[3][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[3][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[3][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[3][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].f[3][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec3((blockE.k[0]), uvec3(4u, 0u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.k[1]), uvec3(9u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((blockE.k[2]), uvec3(7u, 6u, 2u)) && allOk;
	allOk = compare_uvec3((blockE.k[3]), uvec3(1u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (1.0);
	blockC[0].c = (ivec3(-9, 4, -3));
	blockC[0].d = (bvec2(false, true));
	blockC[0].e = (ivec2(-5, 7));
	blockC[1].b = (-7.0);
	blockC[1].c = (ivec3(1, 3, 5));
	blockC[1].d = (bvec2(true, true));
	blockC[1].e = (ivec2(-4, 5));
	blockC[2].b = (3.0);
	blockC[2].c = (ivec3(8, -6, 8));
	blockC[2].d = (bvec2(false, false));
	blockC[2].e = (ivec2(-3, 1));
	blockD.j[0] = (-9.0);
	blockD.j[1] = (9.0);
	blockD.j[2] = (-9.0);
	blockD.j[3] = (2.0);
	blockD.j[4] = (-8.0);
	blockE.k[0] = (uvec3(0u, 3u, 5u));
	blockE.k[1] = (uvec3(8u, 2u, 5u));
	blockE.k[2] = (uvec3(3u, 9u, 5u));
	blockE.k[3] = (uvec3(3u, 9u, 5u));
}
#version 450
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
	highp float mB;
	mediump vec4 mC[2];
	highp int mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp mat4x2 a;
	highp mat4x2 b[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockC
{
	mediump vec3 c;
	bvec2 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp mat3x4 e;
	lowp ivec2 f;
	sA g;
	highp ivec3 h;
	mediump vec2 i[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockE
{
	lowp vec3 j[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(2.0, -8.0, -3.0, -9.0, -1.0, 5.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[0], mat4x2(5.0, -1.0, -4.0, -2.0, -6.0, 7.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1], mat4x2(1.0, -1.0, -5.0, -2.0, -4.0, -5.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2], mat4x2(-8.0, 8.0, 6.0, 4.0, 4.0, 7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3], mat4x2(-1.0, -4.0, -3.0, -5.0, -4.0, 8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[4], mat4x2(-8.0, 2.0, 9.0, -2.0, 1.0, -2.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec3((blockC.c), vec3(-5.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD.e, mat3x4(-1.0, -5.0, 3.0, -9.0, -7.0, -3.0, 1.0, 9.0, -9.0, -1.0, -7.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockD.f), ivec2(6, 5)) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(-4, -2, 2)) && allOk;
	allOk = compare_vec2((blockD.i[0]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((blockD.i[1]), vec2(3.0, -6.0)) && allOk;
	allOk = compare_vec2((blockD.i[2]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_vec3((blockE[0].j[0]), vec3(-5.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec3((blockE[0].j[1]), vec3(2.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec3((blockE[0].j[2]), vec3(0.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockE[0].j[3]), vec3(2.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec3((blockE[0].j[4]), vec3(9.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3((blockE[0].j[5]), vec3(2.0, 9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-3.0, -4.0, 9.0, -2.0, -5.0, -7.0, -4.0, 6.0));
	blockB.b[0] = (mat4x2(-2.0, -6.0, -6.0, 4.0, 4.0, 3.0, 9.0, -2.0));
	blockB.b[1] = (mat4x2(8.0, -6.0, -9.0, -8.0, -5.0, -7.0, 4.0, 4.0));
	blockB.b[2] = (mat4x2(-6.0, 4.0, 1.0, -9.0, 6.0, -2.0, 8.0, -3.0));
	blockB.b[3] = (mat4x2(-4.0, 3.0, 4.0, 7.0, -4.0, -2.0, 8.0, -8.0));
	blockB.b[4] = (mat4x2(-7.0, 0.0, -3.0, -2.0, 3.0, -1.0, 1.0, 6.0));
	blockD.e = (mat3x4(-5.0, -2.0, -1.0, -8.0, 7.0, 8.0, 0.0, -9.0, -5.0, 8.0, 1.0, -4.0));
	blockD.f = (ivec2(9, -1));
	blockD.g.mA = (vec4(9.0, -7.0, -5.0, -4.0));
	blockD.g.mB = (-1.0);
	blockD.g.mC[0] = (vec4(5.0, 7.0, 7.0, -2.0));
	blockD.g.mC[1] = (vec4(4.0, 6.0, -6.0, 3.0));
	blockD.g.mD = (0);
	blockD.i[0] = (vec2(-4.0, 1.0));
	blockD.i[1] = (vec2(7.0, -6.0));
	blockD.i[2] = (vec2(-4.0, 6.0));
}
#version 450
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
	uint16_t b;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump uint c;
	highp uint d;
};
layout(std140, buffer_reference) buffer BlockD
{
	int16_t e;
	uint16_t f;
	float16_t g;
	uint16_t h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.b), 0u) && allOk;
	allOk = compare_uint((blockC.c), 6u) && allOk;
	allOk = compare_uint((blockC.d), 8u) && allOk;
	allOk = compare_float16_t(float(blockD.g), 9.0) && allOk;
	allOk = compare_uint16_t(uint(blockD.h), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint16_t(3u);
	blockC.c = (2u);
	blockC.d = (1u);
	blockD.f = uint16_t(0u);
	blockD.g = float16_t(-9.0);
	blockD.h = uint16_t(9u);
}
#version 450
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
	lowp ivec3 a;
	highp ivec4 b;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	lowp ivec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-5, 5, -6)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(7, 0, 5, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(2, 4, 9, -2));
}
#version 450
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
	uint16_t mB;
	mediump mat3x2 mC;
};
struct sB
{
	sA mA;
	mediump ivec3 mB;
	i16vec2 mC;
	highp uvec3 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	float16_t a;
	lowp ivec2 b;
	highp ivec3 c;
	highp ivec2 d;
	sB e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(4, 3)) && allOk;
	allOk = compare_ivec2((blockB.d), ivec2(-4, -5)) && allOk;
	allOk = compare_bool((blockB.e[0].mA.mA), false) && allOk;
	allOk = compare_uint16_t(uint(blockB.e[0].mA.mB), 3u) && allOk;
	allOk = compare_mat3x2(blockB.e[0].mA.mC, mat3x2(-3.0, 6.0, -6.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec3((blockB.e[0].mB), ivec3(-6, -3, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[0].mC), ivec2(-6, 1)) && allOk;
	allOk = compare_uvec3((blockB.e[0].mD), uvec3(6u, 1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(3, -9));
	blockB.d = (ivec2(9, -4));
	blockB.e[0].mA.mA = (true);
	blockB.e[0].mA.mB = uint16_t(5u);
	blockB.e[0].mA.mC = (mat3x2(-4.0, 0.0, -7.0, -9.0, -8.0, -4.0));
	blockB.e[0].mB = (ivec3(-7, 2, -5));
	blockB.e[0].mC = i16vec2(ivec2(-9, 9));
	blockB.e[0].mD = (uvec3(4u, 0u, 3u));
}
#version 450
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
};
struct sB
{
	mediump mat2 mA;
};
struct sC
{
	mediump vec2 mA;
	mediump uint mB;
	sB mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat3x4 a[2];
	sA b;
	f16vec2 c;
	sC d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a[0], mat3x4(4.0, 4.0, -4.0, 7.0, 4.0, 1.0, 9.0, 3.0, -5.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1], mat3x4(7.0, -1.0, -1.0, 6.0, -5.0, 5.0, -6.0, 5.0, -7.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b.mA), vec3(0.0, 6.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.d[0].mA), vec2(3.0, -2.0)) && allOk;
	allOk = compare_uint((blockB.d[0].mB), 8u) && allOk;
	allOk = compare_mat2(blockB.d[0].mC.mA, mat2(-3.0, 3.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.d[1].mA), vec2(6.0, -2.0)) && allOk;
	allOk = compare_uint((blockB.d[1].mB), 8u) && allOk;
	allOk = compare_mat2(blockB.d[1].mC.mA, mat2(-2.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.d[2].mA), vec2(1.0, -6.0)) && allOk;
	allOk = compare_uint((blockB.d[2].mB), 9u) && allOk;
	allOk = compare_mat2(blockB.d[2].mC.mA, mat2(4.0, 9.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.d[3].mA), vec2(0.0, -1.0)) && allOk;
	allOk = compare_uint((blockB.d[3].mB), 0u) && allOk;
	allOk = compare_mat2(blockB.d[3].mC.mA, mat2(8.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB.d[4].mA), vec2(7.0, 9.0)) && allOk;
	allOk = compare_uint((blockB.d[4].mB), 4u) && allOk;
	allOk = compare_mat2(blockB.d[4].mC.mA, mat2(-7.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB.d[5].mA), vec2(1.0, -8.0)) && allOk;
	allOk = compare_uint((blockB.d[5].mB), 9u) && allOk;
	allOk = compare_mat2(blockB.d[5].mC.mA, mat2(-2.0, 2.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.d[6].mA), vec2(1.0, 6.0)) && allOk;
	allOk = compare_uint((blockB.d[6].mB), 1u) && allOk;
	allOk = compare_mat2(blockB.d[6].mC.mA, mat2(-1.0, -8.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = f16vec3(vec3(3.0, 7.0, 7.0));
	blockB.c = f16vec2(vec2(-8.0, 5.0));
	blockB.d[0].mA = (vec2(-2.0, -7.0));
	blockB.d[0].mB = (9u);
	blockB.d[0].mC.mA = (mat2(5.0, -1.0, -1.0, -1.0));
	blockB.d[1].mA = (vec2(-2.0, 5.0));
	blockB.d[1].mB = (4u);
	blockB.d[1].mC.mA = (mat2(2.0, -8.0, -1.0, -2.0));
	blockB.d[2].mA = (vec2(0.0, -1.0));
	blockB.d[2].mB = (5u);
	blockB.d[2].mC.mA = (mat2(-8.0, 1.0, -7.0, -3.0));
	blockB.d[3].mA = (vec2(5.0, 4.0));
	blockB.d[3].mB = (4u);
	blockB.d[3].mC.mA = (mat2(3.0, -6.0, 1.0, -1.0));
	blockB.d[4].mA = (vec2(-9.0, -1.0));
	blockB.d[4].mB = (2u);
	blockB.d[4].mC.mA = (mat2(-1.0, 1.0, 2.0, -5.0));
	blockB.d[5].mA = (vec2(-1.0, 7.0));
	blockB.d[5].mB = (9u);
	blockB.d[5].mC.mA = (mat2(-4.0, 4.0, 7.0, -2.0));
	blockB.d[6].mA = (vec2(-1.0, -7.0));
	blockB.d[6].mB = (7u);
	blockB.d[6].mC.mA = (mat2(8.0, -5.0, -9.0, 2.0));
}
#version 450
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
	mediump mat4x2 a;
	lowp vec2 b;
	lowp vec3 c;
	u16vec3 d;
	lowp vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(2.0, 6.0, -4.0, 2.0, -7.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(7.0, 0.0, 4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.d), uvec3(7u, 9u, 3u)) && allOk;
	allOk = compare_vec3((blockB.e), vec3(-8.0, 1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-1.0, 5.0, 9.0, -9.0, 1.0, 8.0, 3.0, 2.0));
	blockB.c = (vec3(6.0, 3.0, -6.0));
	blockB.d = u16vec3(uvec3(5u, 1u, 0u));
}
#version 450
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
	f16vec3 a[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	i16vec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a[0]), vec3(0.0, 2.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[1]), vec3(6.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[2]), vec3(-6.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[3]), vec3(-4.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[4]), vec3(4.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[5]), vec3(-8.0, -9.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[6]), vec3(0.0, 4.0, -4.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.b[0]), ivec3(7, 2, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.b[1]), ivec3(7, -5, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.b[2]), ivec3(3, -5, -3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.b[3]), ivec3(-1, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.b[4]), ivec3(-3, 1, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.b[5]), ivec3(-9, -4, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.b[6]), ivec3(9, 1, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = f16vec3(vec3(6.0, -1.0, 0.0));
	blockB.a[1] = f16vec3(vec3(3.0, -7.0, 6.0));
	blockB.a[2] = f16vec3(vec3(-7.0, 6.0, -8.0));
	blockB.a[3] = f16vec3(vec3(-4.0, -6.0, 3.0));
	blockB.a[4] = f16vec3(vec3(-2.0, 5.0, -2.0));
	blockB.a[5] = f16vec3(vec3(6.0, 7.0, -5.0));
	blockB.a[6] = f16vec3(vec3(-5.0, -2.0, -2.0));
}
#version 450
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
	sA mA;
	f16vec3 mB;
	float16_t mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp uvec3 a;
	sB b;
	highp mat2x3 c;
	bvec2 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp ivec2 e;
	highp mat3x4 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp mat3 g[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	i16vec3 h;
	lowp uvec4 i;
	highp vec4 j;
	lowp ivec2 k[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.b.mA.mA), uvec4(9u, 3u, 9u, 6u)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b.mB), vec3(-2.0, 3.0, 9.0)) && allOk;
	allOk = compare_float16_t(float(blockB.b.mC), 1.0) && allOk;
	allOk = compare_mat2x3(blockB.c, mat2x3(-5.0, 0.0, -1.0, -2.0, 9.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(1, -7)) && allOk;
	allOk = compare_mat3(blockD[0].g[0], mat3(1.0, -3.0, 3.0, -8.0, -3.0, 2.0, -3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD[0].g[1], mat3(1.0, 4.0, 3.0, 9.0, 8.0, 0.0, -4.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(blockD[0].g[2], mat3(-9.0, 1.0, -9.0, -8.0, 1.0, -6.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD[0].g[3], mat3(0.0, 9.0, -9.0, -3.0, -1.0, -7.0, -3.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3(blockD[0].g[4], mat3(-6.0, 8.0, 3.0, 0.0, 5.0, 2.0, 5.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD[1].g[0], mat3(5.0, -9.0, 0.0, -7.0, -3.0, 9.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(blockD[1].g[1], mat3(-9.0, 4.0, -1.0, -5.0, 7.0, -7.0, -9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(blockD[1].g[2], mat3(4.0, 7.0, -6.0, -5.0, 4.0, -3.0, -9.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3(blockD[1].g[3], mat3(9.0, 1.0, -2.0, 0.0, 9.0, 5.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3(blockD[1].g[4], mat3(1.0, -2.0, -3.0, 4.0, 9.0, -7.0, -3.0, -5.0, -4.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.h), ivec3(0, -3, -1)) && allOk;
	allOk = compare_uvec4((blockE.i), uvec4(5u, 3u, 6u, 3u)) && allOk;
	allOk = compare_vec4((blockE.j), vec4(-6.0, 9.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockE.k[0]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((blockE.k[1]), ivec2(5, 3)) && allOk;
	allOk = compare_ivec2((blockE.k[2]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((blockE.k[3]), ivec2(0, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(4u, 4u, 9u));
	blockB.b.mA.mA = u16vec4(uvec4(1u, 5u, 2u, 9u));
	blockB.b.mB = f16vec3(vec3(9.0, -3.0, 5.0));
	blockB.b.mC = float16_t(-8.0);
	blockB.c = (mat2x3(-2.0, 1.0, -8.0, 4.0, -2.0, -6.0));
	blockB.d[0] = (bvec2(false, true));
	blockB.d[1] = (bvec2(true, true));
	blockB.d[2] = (bvec2(false, true));
	blockC.e = (ivec2(-3, 9));
	blockC.f[0] = (mat3x4(0.0, -8.0, 6.0, -8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0));
	blockC.f[1] = (mat3x4(-6.0, -5.0, -4.0, -2.0, 8.0, -7.0, 4.0, 0.0, 7.0, 2.0, -4.0, 1.0));
	blockD[0].g[0] = (mat3(6.0, 7.0, 7.0, -2.0, -9.0, -9.0, 5.0, -4.0, 7.0));
	blockD[0].g[1] = (mat3(7.0, -2.0, 7.0, -8.0, -3.0, -4.0, 5.0, -9.0, -6.0));
	blockD[0].g[2] = (mat3(3.0, 2.0, 3.0, -7.0, -4.0, 2.0, -4.0, -3.0, 0.0));
	blockD[0].g[3] = (mat3(8.0, -6.0, 9.0, 8.0, 7.0, -1.0, -2.0, 1.0, -8.0));
	blockD[0].g[4] = (mat3(1.0, -8.0, -5.0, 0.0, 7.0, -6.0, -2.0, -6.0, -7.0));
	blockD[1].g[0] = (mat3(-5.0, 8.0, 0.0, 9.0, 0.0, -7.0, 6.0, 1.0, 8.0));
	blockD[1].g[1] = (mat3(5.0, -2.0, 9.0, -1.0, -5.0, -9.0, 3.0, -7.0, 7.0));
	blockD[1].g[2] = (mat3(-4.0, -2.0, -5.0, 0.0, -4.0, 4.0, -6.0, -7.0, -3.0));
	blockD[1].g[3] = (mat3(-2.0, -6.0, -4.0, -3.0, -4.0, -7.0, 7.0, -8.0, -2.0));
	blockD[1].g[4] = (mat3(-8.0, -8.0, -7.0, 0.0, -4.0, 1.0, 6.0, -6.0, -2.0));
	blockE.h = i16vec3(ivec3(-3, 3, -3));
	blockE.k[0] = (ivec2(2, -9));
	blockE.k[1] = (ivec2(8, 6));
	blockE.k[2] = (ivec2(-9, -3));
	blockE.k[3] = (ivec2(9, 3));
}
#version 450
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
	lowp int mA;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp int b;
	lowp uvec3 c;
	float16_t d;
	float16_t e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump vec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a.mA), 1) && allOk;
	allOk = compare_float16_t(float(blockB[0].d), 2.0) && allOk;
	allOk = compare_float16_t(float(blockB[0].e[0]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockB[0].e[1]), -8.0) && allOk;
	allOk = compare_vec3((blockC.f[0]), vec3(2.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC.f[1]), vec3(-7.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec3((blockC.f[2]), vec3(8.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC.f[3]), vec3(7.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.f[4]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.f[5]), vec3(1.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.f[6]), vec3(-8.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec3((blockC.f[7]), vec3(-1.0, -1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (9);
	blockB[0].b = (-2);
	blockB[0].c = (uvec3(5u, 7u, 0u));
	blockB[0].d = float16_t(2.0);
	blockB[0].e[0] = float16_t(-8.0);
	blockB[0].e[1] = float16_t(7.0);
	blockC.f[0] = (vec3(6.0, -4.0, 5.0));
	blockC.f[1] = (vec3(7.0, 9.0, -2.0));
	blockC.f[2] = (vec3(6.0, 4.0, 0.0));
	blockC.f[3] = (vec3(7.0, 5.0, -3.0));
	blockC.f[4] = (vec3(1.0, 0.0, -8.0));
	blockC.f[5] = (vec3(-8.0, 5.0, 2.0));
	blockC.f[6] = (vec3(6.0, 6.0, -9.0));
	blockC.f[7] = (vec3(7.0, 6.0, 3.0));
}
#version 450
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
	mediump uvec3 mB;
	bool mC;
};
struct sB
{
	uint16_t mA;
	bool mB;
	highp ivec4 mC[6];
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp uvec4 a;
	mediump mat2x3 b;
	float16_t c;
	sA d[][2];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec3 e;
	mediump mat3x4 f;
	lowp int g;
	i16vec4 h;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	lowp uvec3 i[5];
	highp vec2 j;
	highp mat3x4 k;
	sB l[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.d[0][0].mA), 3u) && allOk;
	allOk = compare_uvec3((blockB.d[0][0].mB), uvec3(2u, 4u, 9u)) && allOk;
	allOk = compare_bool((blockB.d[0][0].mC), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[0][1].mA), 5u) && allOk;
	allOk = compare_uvec3((blockB.d[0][1].mB), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_bool((blockB.d[0][1].mC), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[1][0].mA), 2u) && allOk;
	allOk = compare_uvec3((blockB.d[1][0].mB), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_bool((blockB.d[1][0].mC), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[1][1].mA), 2u) && allOk;
	allOk = compare_uvec3((blockB.d[1][1].mB), uvec3(4u, 4u, 3u)) && allOk;
	allOk = compare_bool((blockB.d[1][1].mC), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[2][0].mA), 8u) && allOk;
	allOk = compare_uvec3((blockB.d[2][0].mB), uvec3(7u, 1u, 0u)) && allOk;
	allOk = compare_bool((blockB.d[2][0].mC), false) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[2][1].mA), 0u) && allOk;
	allOk = compare_uvec3((blockB.d[2][1].mB), uvec3(0u, 1u, 2u)) && allOk;
	allOk = compare_bool((blockB.d[2][1].mC), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[3][0].mA), 1u) && allOk;
	allOk = compare_uvec3((blockB.d[3][0].mB), uvec3(6u, 7u, 3u)) && allOk;
	allOk = compare_bool((blockB.d[3][0].mC), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[3][1].mA), 5u) && allOk;
	allOk = compare_uvec3((blockB.d[3][1].mB), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_bool((blockB.d[3][1].mC), true) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[4][0].mA), 4u) && allOk;
	allOk = compare_uvec3((blockB.d[4][0].mB), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_bool((blockB.d[4][0].mC), false) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[4][1].mA), 6u) && allOk;
	allOk = compare_uvec3((blockB.d[4][1].mB), uvec3(0u, 2u, 9u)) && allOk;
	allOk = compare_bool((blockB.d[4][1].mC), false) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3x4(blockC.f, mat3x4(4.0, -1.0, 3.0, 5.0, 2.0, -9.0, 7.0, -6.0, 0.0, 6.0, 4.0, -1.0)) && allOk;
	allOk = compare_int((blockC.g), -2) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.h), ivec4(7, -5, 7, -9)) && allOk;
	allOk = compare_uvec3((blockD.i[0]), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.i[1]), uvec3(8u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((blockD.i[2]), uvec3(9u, 3u, 6u)) && allOk;
	allOk = compare_uvec3((blockD.i[3]), uvec3(0u, 1u, 1u)) && allOk;
	allOk = compare_uvec3((blockD.i[4]), uvec3(4u, 1u, 8u)) && allOk;
	allOk = compare_vec2((blockD.j), vec2(9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2x3(2.0, 3.0, 7.0, -9.0, -2.0, 5.0));
	blockB.c = float16_t(-9.0);
	blockC.f = (mat3x4(-9.0, -1.0, 8.0, 2.0, 9.0, 8.0, -5.0, 5.0, -6.0, -6.0, -5.0, -7.0));
	blockD.i[0] = (uvec3(4u, 0u, 4u));
	blockD.i[1] = (uvec3(8u, 4u, 8u));
	blockD.i[2] = (uvec3(2u, 7u, 4u));
	blockD.i[3] = (uvec3(1u, 0u, 8u));
	blockD.i[4] = (uvec3(3u, 4u, 3u));
	blockD.l[0].mA = uint16_t(1u);
	blockD.l[0].mB = (true);
	blockD.l[0].mC[0] = (ivec4(2, 2, 6, 9));
	blockD.l[0].mC[1] = (ivec4(4, -4, -6, 7));
	blockD.l[0].mC[2] = (ivec4(-2, 6, 6, 4));
	blockD.l[0].mC[3] = (ivec4(-6, -7, 7, 3));
	blockD.l[0].mC[4] = (ivec4(8, -7, -5, -2));
	blockD.l[0].mC[5] = (ivec4(-4, -8, -1, 0));
	blockD.l[1].mA = uint16_t(8u);
	blockD.l[1].mB = (false);
	blockD.l[1].mC[0] = (ivec4(0, 3, 4, -8));
	blockD.l[1].mC[1] = (ivec4(4, -9, 8, 4));
	blockD.l[1].mC[2] = (ivec4(-4, -7, -1, -2));
	blockD.l[1].mC[3] = (ivec4(-2, 9, -1, 0));
	blockD.l[1].mC[4] = (ivec4(-4, 7, 6, -2));
	blockD.l[1].mC[5] = (ivec4(7, -8, -5, -6));
	blockD.l[2].mA = uint16_t(5u);
	blockD.l[2].mB = (false);
	blockD.l[2].mC[0] = (ivec4(-7, 9, -6, -5));
	blockD.l[2].mC[1] = (ivec4(-1, -4, 8, -6));
	blockD.l[2].mC[2] = (ivec4(3, 3, 1, 7));
	blockD.l[2].mC[3] = (ivec4(-2, -6, 9, 7));
	blockD.l[2].mC[4] = (ivec4(0, 3, 8, 8));
	blockD.l[2].mC[5] = (ivec4(-9, 2, -7, 0));
	blockD.l[3].mA = uint16_t(8u);
	blockD.l[3].mB = (false);
	blockD.l[3].mC[0] = (ivec4(-3, -9, 7, -3));
	blockD.l[3].mC[1] = (ivec4(-5, -6, 5, -1));
	blockD.l[3].mC[2] = (ivec4(-4, -9, -9, -6));
	blockD.l[3].mC[3] = (ivec4(-6, -7, 0, -2));
	blockD.l[3].mC[4] = (ivec4(-7, 6, -8, -4));
	blockD.l[3].mC[5] = (ivec4(-9, -3, -7, 5));
	blockD.l[4].mA = uint16_t(9u);
	blockD.l[4].mB = (true);
	blockD.l[4].mC[0] = (ivec4(-3, 6, -3, -9));
	blockD.l[4].mC[1] = (ivec4(-5, -7, -9, -9));
	blockD.l[4].mC[2] = (ivec4(-5, -8, 7, -5));
	blockD.l[4].mC[3] = (ivec4(-1, 0, 2, -3));
	blockD.l[4].mC[4] = (ivec4(9, 0, -9, 4));
	blockD.l[4].mC[5] = (ivec4(2, 5, -5, -6));
}
#version 450
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
	highp int b[1];
	lowp int c;
	lowp uint d;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp int e;
	bool f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), 9) && allOk;
	allOk = compare_int((blockC.e), 0) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0] = (-4);
	blockC.e = (-9);
}
#version 450
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
	int8_t a;
	bvec3 b;
	highp vec3 c;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uint d;
	lowp vec4 e;
	mediump float f;
	mediump uvec4 g[1];
	highp vec2 h;
};
layout(std430, buffer_reference) buffer BlockD
{
	u8vec4 i;
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.d), 4u) && allOk;
	allOk = compare_vec4((blockC.e), vec4(4.0, -4.0, -9.0, -9.0)) && allOk;
	allOk = compare_float((blockC.f), -7.0) && allOk;
	allOk = compare_uvec4((blockC.g[0]), uvec4(1u, 1u, 2u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i), uvec4(9u, 9u, 8u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(4);
	blockB.b = (bvec3(true, false, true));
	blockB.c = (vec3(-4.0, -4.0, -6.0));
	blockC.d = (9u);
	blockC.f = (-9.0);
	blockC.g[0] = (uvec4(9u, 3u, 5u, 9u));
	blockD.i = u8vec4(uvec4(6u, 7u, 9u, 5u));
}
#version 450
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
	bvec2 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp ivec3 f[7];
	uint8_t g;
	highp mat4 h;
	mediump ivec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.c), bvec2(false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d), uvec3(4u, 2u, 5u)) && allOk;
	allOk = compare_bvec2((blockB.e[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.e[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.e[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.e[4]), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockC.f[0]), ivec3(-7, 4, 1)) && allOk;
	allOk = compare_ivec3((blockC.f[1]), ivec3(-6, -7, 2)) && allOk;
	allOk = compare_ivec3((blockC.f[2]), ivec3(8, -2, 8)) && allOk;
	allOk = compare_ivec3((blockC.f[3]), ivec3(0, 2, 2)) && allOk;
	allOk = compare_ivec3((blockC.f[4]), ivec3(-2, 3, -6)) && allOk;
	allOk = compare_ivec3((blockC.f[5]), ivec3(7, -7, 9)) && allOk;
	allOk = compare_ivec3((blockC.f[6]), ivec3(-2, 7, 6)) && allOk;
	allOk = compare_uint8_t(uint(blockC.g), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (3);
	blockB.c = (bvec2(true, false));
	blockB.d = u8vec3(uvec3(6u, 1u, 8u));
	blockB.e[0] = (bvec2(false, false));
	blockB.e[1] = (bvec2(true, false));
	blockB.e[2] = (bvec2(true, false));
	blockB.e[3] = (bvec2(true, true));
	blockB.e[4] = (bvec2(false, true));
	blockC.g = uint8_t(4u);
}
#version 450
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
	lowp ivec3 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump uint b[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp ivec2 c;
	lowp mat3x2 d;
	bvec3 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp uvec3 f;
	lowp uvec2 g;
	lowp int h;
	lowp uint i;
	highp mat4x2 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.b[0]), 1u) && allOk;
	allOk = compare_mat3x2(blockD.d, mat3x2(-5.0, -8.0, -6.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockD.e[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockE.g), uvec2(4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec3(8, -2, -1));
	blockC.b[0] = (5u);
	blockD.d = (mat3x2(9.0, 5.0, 4.0, 8.0, 6.0, 7.0));
	blockD.e[0] = (bvec3(false, false, true));
	blockE.g = (uvec2(6u, 4u));
	blockE.h = (-5);
	blockE.j[0] = (mat4x2(9.0, -4.0, -7.0, 8.0, -6.0, -6.0, -2.0, -4.0));
}
#version 450
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
	i8vec2 a[1];
	mediump mat4 b;
	int8_t c;
	lowp ivec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

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

struct sA
{
	lowp ivec4 mA;
	i8vec3 mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	lowp ivec2 a;
	int8_t b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec4 c;
	lowp uvec4 d;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat4 e;
	u8vec4 f;
	uint8_t g;
	sA h[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp uvec4 i;
	mediump float j;
	mediump mat4 k;
	highp ivec4 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-8, -8)) && allOk;
	allOk = compare_uint8_t(uint(blockD.g), 9u) && allOk;
	allOk = compare_ivec4((blockD.h[0].mA), ivec4(-2, 2, 7, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.h[0].mB), ivec3(4294967295, 5, 9)) && allOk;
	allOk = compare_ivec4((blockE.l[0]), ivec4(2, 2, 9, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = int8_t(4294967293);
	blockC.c = (bvec4(true, true, true, false));
	blockC.d = (uvec4(6u, 6u, 2u, 5u));
	blockD.h[0].mA = (ivec4(-5, -8, 9, 7));
	blockD.h[0].mB = i8vec3(ivec3(4294967287, 4294967288, 4294967292));
	blockE.i = (uvec4(6u, 6u, 3u, 7u));
	blockE.j = (-2.0);
	blockE.k = (mat4(2.0, -6.0, -5.0, -1.0, -6.0, -4.0, 8.0, 2.0, 0.0, -9.0, 8.0, -2.0, -6.0, 4.0, -3.0, 2.0));
	blockE.l[0] = (ivec4(-1, 7, -1, 3));
}
#version 450
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
	sA mA;
	mediump vec3 mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	u8vec2 a;
	lowp mat3x2 b;
	uint8_t c;
	sB d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.c), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(4u, 1u));
	blockB.b = (mat3x2(-2.0, 0.0, -6.0, 6.0, -6.0, 3.0));
}
#version 450
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
	highp ivec2 a[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	highp uint b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.b), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(1, 1));
	blockB.a[1] = (ivec2(-4, 1));
	blockB.a[2] = (ivec2(8, -4));
	blockB.a[3] = (ivec2(1, -9));
}
#version 450
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
	lowp vec3 mA;
};
struct sB
{
	highp mat3x2 mA;
	uint8_t mB;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockB
{
	sA a;
	sB b;
	highp mat4x2 c;
	bvec3 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	uint8_t e;
	lowp vec4 f;
	lowp vec2 g;
	lowp mat3x4 h[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	int8_t i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b.mA, mat3x2(-9.0, 4.0, 7.0, 2.0, -2.0, 2.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.b.mB), 3u) && allOk;
	allOk = compare_vec4((blockC[0].f), vec4(-7.0, -8.0, 1.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC[0].g), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].h[0], mat3x4(0.0, 0.0, -9.0, 0.0, 5.0, 7.0, 6.0, -9.0, 2.0, 6.0, 0.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].e = uint8_t(1u);
	blockC[0].g = (vec2(9.0, 8.0));
	blockC[0].h[0] = (mat3x4(-3.0, -9.0, -3.0, -2.0, -1.0, 3.0, 7.0, -1.0, -3.0, -5.0, 7.0, -4.0));
	blockD.i[0] = int8_t(6);
	blockD.i[1] = int8_t(4294967290);
	blockD.i[2] = int8_t(4294967288);
	blockD.i[3] = int8_t(6);
	blockD.i[4] = int8_t(4294967292);
}
#version 450
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
	layout(offset = 0) lowp float a;
	layout(offset = 16) highp vec4 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6.0);
	blockB[0].b = (vec4(7.0, 6.0, 3.0, -4.0));
	blockB[1].a = (2.0);
	blockB[1].b = (vec4(-4.0, 5.0, -4.0, 0.0));
	blockB[2].a = (0.0);
	blockB[2].b = (vec4(-4.0, -6.0, -7.0, -4.0));
}
#version 450
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
	layout(offset = 0) uint8_t b;
	layout(offset = 16) highp ivec3 c[1];
	layout(offset = 32) u8vec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockC[0].c[0]), ivec3(1, -3, -3)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].d), uvec2(9u, 4u)) && allOk;
	allOk = compare_ivec3((blockC[1].c[0]), ivec3(-6, -9, 3)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].d), uvec2(6u, 8u)) && allOk;
	allOk = compare_ivec3((blockC[2].c[0]), ivec3(0, 8, 0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].d), uvec2(7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(9u, 2u));
	blockC[0].b = uint8_t(4u);
	blockC[0].c[0] = (ivec3(8, 0, 6));
	blockC[0].d = u8vec2(uvec2(8u, 1u));
	blockC[1].b = uint8_t(6u);
	blockC[1].c[0] = (ivec3(-3, 2, -1));
	blockC[1].d = u8vec2(uvec2(3u, 6u));
	blockC[2].b = uint8_t(1u);
	blockC[2].c[0] = (ivec3(-3, -3, 9));
	blockC[2].d = u8vec2(uvec2(7u, 1u));
}
#version 450
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
	highp mat4x3 mA[2][5];
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec2 a;
	mediump mat3x2 b;
	sA c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp float d;
	u8vec2 e;
	mediump uvec2 f;
	i8vec3 g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp uvec2 h;
	lowp int i[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	lowp ivec4 j;
	highp mat4 k;
	lowp ivec4 l[6];
	u8vec2 m;
	sB n;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.d), 2.0) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(3u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(0u, 5u)) && allOk;
	allOk = compare_int((blockD.i[0]), 7) && allOk;
	allOk = compare_int((blockD.i[1]), 9) && allOk;
	allOk = compare_int((blockD.i[2]), -4) && allOk;
	allOk = compare_int((blockD.i[3]), -9) && allOk;
	allOk = compare_int((blockD.i[4]), 7) && allOk;
	allOk = compare_int((blockD.i[5]), 9) && allOk;
	allOk = compare_int((blockD.i[6]), -8) && allOk;
	allOk = compare_ivec4((blockE.j), ivec4(5, -3, -3, -9)) && allOk;
	allOk = compare_mat4(blockE.k, mat4(8.0, -7.0, 3.0, 3.0, -6.0, 8.0, 9.0, -9.0, -6.0, 4.0, 1.0, -4.0, -1.0, 5.0, -9.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockE.l[0]), ivec4(4, 7, -8, 9)) && allOk;
	allOk = compare_ivec4((blockE.l[1]), ivec4(-9, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((blockE.l[2]), ivec4(7, -7, 1, 6)) && allOk;
	allOk = compare_ivec4((blockE.l[3]), ivec4(7, -9, -3, 9)) && allOk;
	allOk = compare_ivec4((blockE.l[4]), ivec4(-1, -8, 6, 1)) && allOk;
	allOk = compare_ivec4((blockE.l[5]), ivec4(2, -7, 1, -8)) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.m), uvec2(8u, 9u)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[0][0], mat4x3(-1.0, -6.0, 2.0, 5.0, -7.0, 9.0, 8.0, 8.0, -4.0, -1.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[0][1], mat4x3(4.0, 5.0, -4.0, 4.0, -8.0, -4.0, -9.0, 2.0, 5.0, 7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[0][2], mat4x3(-8.0, 5.0, 7.0, -2.0, -8.0, -2.0, -6.0, 8.0, -2.0, 9.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[0][3], mat4x3(-6.0, -4.0, 6.0, -8.0, 4.0, 9.0, -2.0, -5.0, -2.0, 0.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[0][4], mat4x3(1.0, 0.0, -4.0, 4.0, 6.0, -8.0, 1.0, -3.0, -3.0, 1.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[1][0], mat4x3(-1.0, -4.0, -6.0, 7.0, 9.0, 9.0, 5.0, -3.0, 9.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[1][1], mat4x3(1.0, 9.0, -6.0, -3.0, 5.0, -9.0, -9.0, 6.0, 2.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[1][2], mat4x3(-5.0, 1.0, -1.0, -2.0, 8.0, -1.0, -8.0, -6.0, -2.0, 1.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[1][3], mat4x3(2.0, 2.0, -6.0, 8.0, 8.0, -1.0, -3.0, 9.0, -5.0, -3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockE.n.mA[1][4], mat4x3(-9.0, -2.0, 4.0, 8.0, -2.0, -2.0, -9.0, -2.0, -6.0, -9.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockC.d = (3.0);
	blockD.h = (uvec2(7u, 7u));
	blockE.j = (ivec4(-9, -5, -9, -6));
	blockE.m = u8vec2(uvec2(3u, 5u));
	blockE.n.mA[0][0] = (mat4x3(6.0, 0.0, -5.0, 1.0, 1.0, 4.0, 5.0, 9.0, -3.0, 6.0, 6.0, -2.0));
	blockE.n.mA[0][1] = (mat4x3(4.0, 8.0, -6.0, 0.0, 1.0, -9.0, 7.0, -3.0, 8.0, -2.0, -4.0, -7.0));
	blockE.n.mA[0][2] = (mat4x3(-8.0, -2.0, 8.0, -3.0, 4.0, 0.0, 1.0, -1.0, -3.0, 9.0, 7.0, 1.0));
	blockE.n.mA[0][3] = (mat4x3(-9.0, 2.0, 0.0, 0.0, -3.0, -8.0, 2.0, -3.0, -3.0, -1.0, -5.0, 8.0));
	blockE.n.mA[0][4] = (mat4x3(1.0, -1.0, -1.0, 4.0, 3.0, 5.0, -4.0, -6.0, 9.0, -2.0, -2.0, -5.0));
	blockE.n.mA[1][0] = (mat4x3(-2.0, 4.0, 0.0, 9.0, 1.0, 0.0, 3.0, 1.0, -7.0, 7.0, 4.0, -5.0));
	blockE.n.mA[1][1] = (mat4x3(9.0, 2.0, 8.0, -6.0, -5.0, -4.0, -7.0, 3.0, -1.0, -3.0, -1.0, -7.0));
	blockE.n.mA[1][2] = (mat4x3(4.0, 2.0, 7.0, -6.0, 0.0, 2.0, -8.0, -6.0, 8.0, -2.0, 5.0, 5.0));
	blockE.n.mA[1][3] = (mat4x3(8.0, -3.0, 1.0, -6.0, 8.0, -2.0, -5.0, 6.0, 0.0, 5.0, -6.0, 6.0));
	blockE.n.mA[1][4] = (mat4x3(4.0, -1.0, -7.0, 6.0, -5.0, -1.0, 4.0, -6.0, -5.0, -8.0, -7.0, -3.0));
}
#version 450
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
	lowp uvec2 a[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a[0]), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a[0]), uvec2(3u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (uvec2(7u, 4u));
	blockB[nonuniformEXT(1)].a[0] = (uvec2(8u, 3u));
}
#version 450
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
	mediump mat4x3 a;
	uint8_t b;
	mediump ivec3 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].c[0]), ivec3(8, -9, 7)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].c[0]), ivec3(-4, -3, 5)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].c[0]), ivec3(-4, -9, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(-1.0, 1.0, -1.0, 8.0, 9.0, -4.0, -2.0, 9.0, -9.0, 3.0, -8.0, -9.0));
	blockB[nonuniformEXT(0)].b = uint8_t(2u);
	blockB[nonuniformEXT(0)].c[0] = (ivec3(-3, 2, 4));
	blockB[nonuniformEXT(1)].a = (mat4x3(5.0, 8.0, 2.0, -6.0, 4.0, -5.0, -5.0, -9.0, -7.0, 7.0, -8.0, 8.0));
	blockB[nonuniformEXT(1)].b = uint8_t(3u);
	blockB[nonuniformEXT(1)].c[0] = (ivec3(1, 1, 7));
	blockB[nonuniformEXT(2)].a = (mat4x3(4.0, 5.0, 4.0, 8.0, -7.0, 0.0, 5.0, 7.0, -8.0, -8.0, 1.0, 1.0));
	blockB[nonuniformEXT(2)].b = uint8_t(7u);
	blockB[nonuniformEXT(2)].c[0] = (ivec3(-5, -9, 6));
}
