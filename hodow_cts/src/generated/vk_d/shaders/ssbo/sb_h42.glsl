#version 450
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
	allOk = compare_mat2(var, mat2(1.0, 7.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-1.0, 0.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(var, mat4(9.0, 6.0, 4.0, -5.0, -2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-4.0, -7.0, 4.0, 2.0));
	var[1] = (vec4(2.0, 2.0, 1.0, 9.0));
	var[2] = (vec4(7.0, -2.0, 6.0, 5.0));
	var[3] = (vec4(4.0, 0.0, 2.0, -8.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[3][0], -3.0) && allOk;
	allOk = compare_float(var[3][1], -8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-6.0, -9.0, 0.0, 8.0, -9.0, 9.0, 4.0, -9.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

layout(std430, row_major, binding = 1) buffer Block
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
	allOk = compare_mat2x4(var, mat2x4(4.0, -4.0, 8.0, -4.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-9.0, -9.0, 5.0, -4.0));
	var[1] = (vec4(7.0, 6.0, -1.0, 7.0));
}
#version 450
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

	var = (mat3x2(5.0, -7.0, 9.0, -6.0, 5.0, -9.0));
}
#version 450
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
	u16vec2 var;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var), uvec2(8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u16vec2(uvec2(8u, 0u));
}
#version 450
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
	highp ivec3 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -4) && allOk;
	allOk = compare_ivec3((var), ivec3(5, 7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5);
	var = (ivec3(-5, 0, 1));
}
#version 450
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

	padding = (9.0);
	var = (mat2(6.0, -9.0, -4.0, 2.0));
}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var, mat3(8.0, -4.0, 9.0, 0.0, 8.0, -3.0, -1.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0] = (vec3(8.0, -2.0, 3.0));
	var[1] = (vec3(2.0, -2.0, 4.0));
	var[2] = (vec3(-9.0, 5.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var, mat4(0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0, -4.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat4(-7.0, 9.0, 1.0, 3.0, -1.0, -4.0, -5.0, 4.0, 4.0, 3.0, 2.0, 7.0, 2.0, -1.0, 7.0, 0.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec2(0.0, 8.0));
	var[1] = (vec2(-7.0, -2.0));
	var[2] = (vec2(8.0, 2.0));
}
#version 450
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
	highp ivec4 var[3];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[2]), ivec4(-3, -3, -5, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec4(5, -9, 5, -6));
	var[1] = (ivec4(-2, -4, 1, -9));
	var[2] = (ivec4(7, 3, 6, 8));
}
#version 450
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

	var[0] = (uvec4(2u, 7u, 2u, 9u));
	var[1] = (uvec4(7u, 9u, 5u, 1u));
	var[2] = (uvec4(3u, 4u, 4u, 2u));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
}
#version 450
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
	highp uint var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 3u) && allOk;
	allOk = compare_uint((var[0]), 6u) && allOk;
	allOk = compare_uint((var[1]), 9u) && allOk;
	allOk = compare_uint((var[2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7u);
	var[0] = (9u);
	var[1] = (1u);
	var[2] = (0u);
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (mat3(-8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0, -4.0));
	var[1] = (mat3(3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0, -6.0));
	var[2] = (mat3(8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0, 8.0));
}
#version 450
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
	int16_t var[];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0]), -5) && allOk;
	allOk = compare_int16_t(int(var[1]), 1) && allOk;
	allOk = compare_int16_t(int(var[2]), 8) && allOk;
	allOk = compare_int16_t(int(var[3]), -2) && allOk;
	allOk = compare_int16_t(int(var[4]), 9) && allOk;
	allOk = compare_int16_t(int(var[5]), -5) && allOk;
	allOk = compare_int16_t(int(var[6]), -8) && allOk;
	allOk = compare_int16_t(int(var[7]), 6) && allOk;
	allOk = compare_int16_t(int(var[8]), 3) && allOk;
	allOk = compare_int16_t(int(var[9]), -8) && allOk;
	allOk = compare_int16_t(int(var[10]), 6) && allOk;
	allOk = compare_int16_t(int(var[11]), -7) && allOk;
	allOk = compare_int16_t(int(var[12]), 9) && allOk;
	allOk = compare_int16_t(int(var[13]), 5) && allOk;
	allOk = compare_int16_t(int(var[14]), 9) && allOk;
	allOk = compare_int16_t(int(var[15]), -3) && allOk;
	allOk = compare_int16_t(int(var[16]), -1) && allOk;
	allOk = compare_int16_t(int(var[17]), -2) && allOk;
	allOk = compare_int16_t(int(var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = int16_t(6);
	var[1] = int16_t(8);
	var[2] = int16_t(-2);
	var[3] = int16_t(-4);
	var[4] = int16_t(-3);
	var[5] = int16_t(9);
	var[6] = int16_t(-5);
	var[7] = int16_t(-8);
	var[8] = int16_t(-3);
	var[9] = int16_t(2);
	var[10] = int16_t(-1);
	var[11] = int16_t(4);
	var[12] = int16_t(3);
	var[13] = int16_t(9);
	var[14] = int16_t(6);
	var[15] = int16_t(2);
	var[16] = int16_t(3);
	var[17] = int16_t(7);
	var[18] = int16_t(7);
}
#version 450
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
	bool var[];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0]), false) && allOk;
	allOk = compare_bool((var[1]), true) && allOk;
	allOk = compare_bool((var[2]), true) && allOk;
	allOk = compare_bool((var[3]), false) && allOk;
	allOk = compare_bool((var[4]), false) && allOk;
	allOk = compare_bool((var[5]), true) && allOk;
	allOk = compare_bool((var[6]), true) && allOk;
	allOk = compare_bool((var[7]), false) && allOk;
	allOk = compare_bool((var[8]), false) && allOk;
	allOk = compare_bool((var[9]), false) && allOk;
	allOk = compare_bool((var[10]), false) && allOk;
	allOk = compare_bool((var[11]), true) && allOk;
	allOk = compare_bool((var[12]), true) && allOk;
	allOk = compare_bool((var[13]), false) && allOk;
	allOk = compare_bool((var[14]), true) && allOk;
	allOk = compare_bool((var[15]), true) && allOk;
	allOk = compare_bool((var[16]), false) && allOk;
	allOk = compare_bool((var[17]), true) && allOk;
	allOk = compare_bool((var[18]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (false);
	var[1] = (false);
	var[2] = (true);
	var[3] = (true);
	var[4] = (false);
	var[5] = (false);
	var[6] = (true);
	var[7] = (true);
	var[8] = (true);
	var[9] = (true);
	var[10] = (false);
	var[11] = (false);
	var[12] = (false);
	var[13] = (false);
	var[14] = (true);
	var[15] = (false);
	var[16] = (true);
	var[17] = (false);
	var[18] = (true);
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[3] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[4] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[5] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[6] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[7] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[8] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[9] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[10] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[11] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	var[12] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	var[13] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	var[14] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	var[15] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	var[16] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	var[17] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	var[18] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
}
#version 450
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
	highp mat3x2 var[];
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
	allOk = compare_mat3x2(var[3], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(9.0, -4.0));
	var[0][1] = (vec2(-7.0, 8.0));
	var[0][2] = (vec2(-2.0, -9.0));
	var[1][0] = (vec2(-1.0, 7.0));
	var[1][1] = (vec2(-3.0, -3.0));
	var[1][2] = (vec2(-8.0, 2.0));
	var[2][0] = (vec2(-2.0, -1.0));
	var[2][1] = (vec2(-3.0, -3.0));
	var[2][2] = (vec2(-4.0, 5.0));
	var[3][0] = (vec2(9.0, 7.0));
	var[3][1] = (vec2(-4.0, 7.0));
	var[3][2] = (vec2(1.0, 6.0));
	var[4][0] = (vec2(-8.0, 9.0));
	var[4][1] = (vec2(8.0, 1.0));
	var[4][2] = (vec2(6.0, 8.0));
	var[5][0] = (vec2(-1.0, 2.0));
	var[5][1] = (vec2(1.0, -1.0));
	var[5][2] = (vec2(0.0, 3.0));
	var[6][0] = (vec2(-3.0, -2.0));
	var[6][1] = (vec2(-9.0, -8.0));
	var[6][2] = (vec2(-8.0, 4.0));
	var[7][0] = (vec2(-2.0, 9.0));
	var[7][1] = (vec2(-1.0, 3.0));
	var[7][2] = (vec2(-2.0, 9.0));
	var[8][0] = (vec2(-2.0, -4.0));
	var[8][1] = (vec2(-1.0, 9.0));
	var[8][2] = (vec2(-9.0, -4.0));
	var[9][0] = (vec2(-3.0, -2.0));
	var[9][1] = (vec2(7.0, -5.0));
	var[9][2] = (vec2(-5.0, 0.0));
	var[10][0] = (vec2(4.0, -4.0));
	var[10][1] = (vec2(5.0, 5.0));
	var[10][2] = (vec2(2.0, -3.0));
	var[11][0] = (vec2(-5.0, -3.0));
	var[11][1] = (vec2(-7.0, 6.0));
	var[11][2] = (vec2(-6.0, 8.0));
	var[12][0] = (vec2(9.0, 4.0));
	var[12][1] = (vec2(-8.0, -6.0));
	var[12][2] = (vec2(4.0, -6.0));
	var[13][0] = (vec2(-9.0, -3.0));
	var[13][1] = (vec2(8.0, 9.0));
	var[13][2] = (vec2(4.0, -8.0));
	var[14][0] = (vec2(0.0, -4.0));
	var[14][1] = (vec2(6.0, -1.0));
	var[14][2] = (vec2(-7.0, 8.0));
	var[15][0] = (vec2(4.0, 2.0));
	var[15][1] = (vec2(2.0, -3.0));
	var[15][2] = (vec2(1.0, -6.0));
	var[16][0] = (vec2(7.0, 3.0));
	var[16][1] = (vec2(-7.0, 5.0));
	var[16][2] = (vec2(2.0, -9.0));
	var[17][0] = (vec2(-2.0, -8.0));
	var[17][1] = (vec2(-9.0, 5.0));
	var[17][2] = (vec2(-2.0, 1.0));
	var[18][0] = (vec2(2.0, -5.0));
	var[18][1] = (vec2(2.0, 8.0));
	var[18][2] = (vec2(1.0, 5.0));
}
#version 450
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
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
	var[3][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[3][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[3][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[4][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[4][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[4][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[5][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[5][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[5][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[6][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[6][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[6][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[7][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[7][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[7][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[8][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[8][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[8][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[9][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[9][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[9][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[10][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[10][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[10][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[11][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[11][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[11][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[12][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	var[12][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	var[12][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	var[13][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	var[13][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	var[13][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	var[14][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	var[14][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	var[14][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	var[15][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	var[15][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	var[15][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	var[16][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	var[16][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	var[16][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	var[17][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	var[17][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	var[17][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	var[18][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	var[18][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	var[18][2] = (vec4(9.0, 2.0, -4.0, 7.0));
}
#version 450
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
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[3] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[4] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[5] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[6] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[7] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[8] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[9] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[10] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[11] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	var[12] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	var[13] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	var[14] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	var[15] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	var[16] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	var[17] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	var[18] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[0][2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[1][0] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[1][1] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[1][2] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[2][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[2][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[2][2] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[3][0] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[3][1] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[3][2] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[0][2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	var[1][0] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	var[1][1] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	var[1][2] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	var[2][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	var[2][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	var[2][2] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	var[3][0] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	var[3][1] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	var[3][2] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[0][2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[1][0] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[1][1] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[1][2] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[2][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[2][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[2][2] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[3][0] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[3][1] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[3][2] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
}
#version 450
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
	highp vec2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_vec2((var[0][0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((var[0][1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((var[1][0]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((var[1][2]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2((var[2][0]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][1]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((var[2][2]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((var[3][0]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((var[3][1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[3][2]), vec2(-1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0] = (vec2(8.0, 7.0));
	var[0][1] = (vec2(-1.0, -4.0));
	var[0][2] = (vec2(8.0, -2.0));
	var[1][0] = (vec2(-5.0, -2.0));
	var[1][1] = (vec2(5.0, 6.0));
	var[1][2] = (vec2(-2.0, -6.0));
	var[2][0] = (vec2(-6.0, 1.0));
	var[2][1] = (vec2(6.0, -7.0));
	var[2][2] = (vec2(6.0, 1.0));
	var[3][0] = (vec2(-6.0, -9.0));
	var[3][1] = (vec2(0.0, -8.0));
	var[3][2] = (vec2(-4.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0, 1.0, -4.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0, -4.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0, 7.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0, -5.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0, 4.0, 5.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0, 0.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0, 5.0, -5.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0, 1.0, 2.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0, 8.0, 8.0, 7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0][0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][0][1] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][0][2] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[0][0][3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	var[0][1][0] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[0][1][1] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[0][1][2] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[0][1][3] = (vec4(3.0, 9.0, -6.0, 1.0));
	var[0][2][0] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[0][2][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][2][2] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[0][2][3] = (vec4(6.0, 0.0, 8.0, 4.0));
	var[1][0][0] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][1] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][2] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][0][3] = (vec4(-5.0, 7.0, 9.0, -8.0));
	var[1][1][0] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[1][1][1] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[1][1][2] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[1][1][3] = (vec4(9.0, -5.0, 0.0, 7.0));
	var[1][2][0] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[1][2][1] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[1][2][2] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[1][2][3] = (vec4(-2.0, -9.0, 2.0, -7.0));
	var[2][0][0] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[2][0][1] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[2][0][2] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[2][0][3] = (vec4(3.0, -4.0, -1.0, -4.0));
	var[2][1][0] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[2][1][1] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[2][1][2] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[2][1][3] = (vec4(-2.0, -3.0, 5.0, 1.0));
	var[2][2][0] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[2][2][1] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[2][2][2] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[2][2][3] = (vec4(1.0, 4.0, -2.0, 2.0));
	var[3][0][0] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[3][0][1] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[3][0][2] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[3][0][3] = (vec4(-7.0, 5.0, 7.0, 6.0));
	var[3][1][0] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[3][1][1] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[3][1][2] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[3][1][3] = (vec4(3.0, 8.0, 9.0, -8.0));
	var[3][2][0] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][2][1] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[3][2][2] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[3][2][3] = (vec4(-5.0, 6.0, -7.0, 4.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	var[0][0][1] = (vec4(6.0, 1.0, -6.0, 6.0));
	var[0][0][2] = (vec4(0.0, -6.0, 3.0, 3.0));
	var[0][0][3] = (vec4(3.0, -3.0, 2.0, -8.0));
	var[0][1][0] = (vec4(9.0, -6.0, 6.0, 1.0));
	var[0][1][1] = (vec4(9.0, -7.0, 4.0, -5.0));
	var[0][1][2] = (vec4(5.0, -6.0, 5.0, 7.0));
	var[0][1][3] = (vec4(7.0, -5.0, -9.0, 7.0));
	var[0][2][0] = (vec4(-2.0, -1.0, -4.0, -3.0));
	var[0][2][1] = (vec4(3.0, -8.0, 7.0, -8.0));
	var[0][2][2] = (vec4(-5.0, -9.0, -1.0, 0.0));
	var[0][2][3] = (vec4(-7.0, 7.0, 8.0, -6.0));
	var[1][0][0] = (vec4(-6.0, -1.0, 6.0, 3.0));
	var[1][0][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[1][0][2] = (vec4(-1.0, 3.0, -5.0, 4.0));
	var[1][0][3] = (vec4(-4.0, 3.0, 4.0, -4.0));
	var[1][1][0] = (vec4(-8.0, 4.0, 5.0, -5.0));
	var[1][1][1] = (vec4(0.0, -3.0, -4.0, 5.0));
	var[1][1][2] = (vec4(-4.0, -7.0, 4.0, -3.0));
	var[1][1][3] = (vec4(9.0, 3.0, -4.0, -3.0));
	var[1][2][0] = (vec4(-9.0, 6.0, -3.0, -6.0));
	var[1][2][1] = (vec4(-1.0, 8.0, 3.0, -2.0));
	var[1][2][2] = (vec4(9.0, -2.0, -3.0, -8.0));
	var[1][2][3] = (vec4(3.0, -8.0, 5.0, 7.0));
	var[2][0][0] = (vec4(-2.0, -7.0, 3.0, 8.0));
	var[2][0][1] = (vec4(-7.0, -6.0, 4.0, -4.0));
	var[2][0][2] = (vec4(6.0, -2.0, -7.0, 7.0));
	var[2][0][3] = (vec4(8.0, -8.0, -2.0, -8.0));
	var[2][1][0] = (vec4(3.0, 9.0, 3.0, 1.0));
	var[2][1][1] = (vec4(-3.0, -5.0, -8.0, -7.0));
	var[2][1][2] = (vec4(5.0, -1.0, -6.0, 8.0));
	var[2][1][3] = (vec4(-8.0, 4.0, 8.0, 6.0));
	var[2][2][0] = (vec4(-5.0, 4.0, -3.0, -1.0));
	var[2][2][1] = (vec4(-8.0, 3.0, 5.0, 0.0));
	var[2][2][2] = (vec4(7.0, 6.0, -4.0, 1.0));
	var[2][2][3] = (vec4(4.0, 3.0, 6.0, -3.0));
	var[3][0][0] = (vec4(-8.0, -6.0, 5.0, -9.0));
	var[3][0][1] = (vec4(-3.0, 0.0, -1.0, -5.0));
	var[3][0][2] = (vec4(9.0, -8.0, -9.0, -1.0));
	var[3][0][3] = (vec4(2.0, 5.0, 6.0, 2.0));
	var[3][1][0] = (vec4(3.0, 8.0, 8.0, -7.0));
	var[3][1][1] = (vec4(-1.0, 5.0, -3.0, 5.0));
	var[3][1][2] = (vec4(-3.0, -4.0, 6.0, -6.0));
	var[3][1][3] = (vec4(-5.0, 7.0, -6.0, 7.0));
	var[3][2][0] = (vec4(-3.0, -8.0, 1.0, 1.0));
	var[3][2][1] = (vec4(2.0, 3.0, 1.0, 5.0));
	var[3][2][2] = (vec4(-2.0, 2.0, -2.0, -9.0));
	var[3][2][3] = (vec4(-1.0, 2.0, -1.0, 8.0));
}
#version 450
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
	highp uint var[4][2][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((var[0][0][2]), 9u) && allOk;
	allOk = compare_uint((var[0][1][0]), 7u) && allOk;
	allOk = compare_uint((var[0][1][1]), 8u) && allOk;
	allOk = compare_uint((var[0][1][2]), 6u) && allOk;
	allOk = compare_uint((var[1][0][0]), 0u) && allOk;
	allOk = compare_uint((var[1][0][1]), 3u) && allOk;
	allOk = compare_uint((var[1][0][2]), 7u) && allOk;
	allOk = compare_uint((var[1][1][0]), 9u) && allOk;
	allOk = compare_uint((var[1][1][1]), 0u) && allOk;
	allOk = compare_uint((var[1][1][2]), 1u) && allOk;
	allOk = compare_uint((var[2][0][0]), 6u) && allOk;
	allOk = compare_uint((var[2][0][1]), 4u) && allOk;
	allOk = compare_uint((var[2][0][2]), 2u) && allOk;
	allOk = compare_uint((var[2][1][0]), 4u) && allOk;
	allOk = compare_uint((var[2][1][1]), 8u) && allOk;
	allOk = compare_uint((var[2][1][2]), 7u) && allOk;
	allOk = compare_uint((var[3][0][0]), 5u) && allOk;
	allOk = compare_uint((var[3][0][1]), 7u) && allOk;
	allOk = compare_uint((var[3][0][2]), 5u) && allOk;
	allOk = compare_uint((var[3][1][0]), 9u) && allOk;
	allOk = compare_uint((var[3][1][1]), 7u) && allOk;
	allOk = compare_uint((var[3][1][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (7u);
	var[0][0][1] = (9u);
	var[0][0][2] = (1u);
	var[0][1][0] = (7u);
	var[0][1][1] = (8u);
	var[0][1][2] = (6u);
	var[1][0][0] = (0u);
	var[1][0][1] = (7u);
	var[1][0][2] = (7u);
	var[1][1][0] = (1u);
	var[1][1][1] = (9u);
	var[1][1][2] = (8u);
	var[2][0][0] = (4u);
	var[2][0][1] = (8u);
	var[2][0][2] = (7u);
	var[2][1][0] = (6u);
	var[2][1][1] = (8u);
	var[2][1][2] = (6u);
	var[3][0][0] = (5u);
	var[3][0][1] = (7u);
	var[3][0][2] = (2u);
	var[3][1][0] = (2u);
	var[3][1][1] = (5u);
	var[3][1][2] = (3u);
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[0][0][2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[0][1][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	var[0][1][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	var[0][1][2] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	var[1][0][0] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[1][0][1] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[1][0][2] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[1][1][0] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	var[1][1][1] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	var[1][1][2] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	var[2][0][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[2][0][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[2][0][2] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[2][1][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	var[2][1][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	var[2][1][2] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	var[3][0][0] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[3][0][1] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[3][0][2] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	var[3][1][0] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	var[3][1][1] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	var[3][1][2] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[0][0][2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	var[0][1][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	var[0][1][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	var[0][1][2] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	var[1][0][0] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	var[1][0][1] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	var[1][0][2] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	var[1][1][0] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	var[1][1][1] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	var[1][1][2] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	var[2][0][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	var[2][0][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	var[2][0][2] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	var[2][1][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	var[2][1][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	var[2][1][2] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	var[3][0][0] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	var[3][0][1] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	var[3][0][2] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	var[3][1][0] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	var[3][1][1] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	var[3][1][2] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
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
	var[0][0][2][0] = (vec2(-8.0, 4.0));
	var[0][0][2][1] = (vec2(5.0, -9.0));
	var[0][0][2][2] = (vec2(1.0, -5.0));
	var[0][0][2][3] = (vec2(-4.0, -2.0));
	var[0][1][0][0] = (vec2(4.0, 2.0));
	var[0][1][0][1] = (vec2(-4.0, 1.0));
	var[0][1][0][2] = (vec2(5.0, -7.0));
	var[0][1][0][3] = (vec2(5.0, 5.0));
	var[0][1][1][0] = (vec2(-5.0, 1.0));
	var[0][1][1][1] = (vec2(-7.0, -3.0));
	var[0][1][1][2] = (vec2(-1.0, 1.0));
	var[0][1][1][3] = (vec2(4.0, 7.0));
	var[0][1][2][0] = (vec2(-9.0, 1.0));
	var[0][1][2][1] = (vec2(-6.0, 7.0));
	var[0][1][2][2] = (vec2(8.0, -7.0));
	var[0][1][2][3] = (vec2(2.0, 1.0));
	var[1][0][0][0] = (vec2(6.0, -1.0));
	var[1][0][0][1] = (vec2(-7.0, -5.0));
	var[1][0][0][2] = (vec2(-2.0, -8.0));
	var[1][0][0][3] = (vec2(1.0, 3.0));
	var[1][0][1][0] = (vec2(4.0, 2.0));
	var[1][0][1][1] = (vec2(-9.0, 2.0));
	var[1][0][1][2] = (vec2(-3.0, 3.0));
	var[1][0][1][3] = (vec2(0.0, 1.0));
	var[1][0][2][0] = (vec2(-5.0, -9.0));
	var[1][0][2][1] = (vec2(2.0, -2.0));
	var[1][0][2][2] = (vec2(-3.0, 0.0));
	var[1][0][2][3] = (vec2(9.0, 6.0));
	var[1][1][0][0] = (vec2(-7.0, 4.0));
	var[1][1][0][1] = (vec2(-4.0, 4.0));
	var[1][1][0][2] = (vec2(0.0, 7.0));
	var[1][1][0][3] = (vec2(7.0, -1.0));
	var[1][1][1][0] = (vec2(0.0, -2.0));
	var[1][1][1][1] = (vec2(-8.0, 2.0));
	var[1][1][1][2] = (vec2(8.0, -1.0));
	var[1][1][1][3] = (vec2(5.0, 2.0));
	var[1][1][2][0] = (vec2(4.0, 1.0));
	var[1][1][2][1] = (vec2(-6.0, 7.0));
	var[1][1][2][2] = (vec2(-7.0, 1.0));
	var[1][1][2][3] = (vec2(2.0, -4.0));
	var[2][0][0][0] = (vec2(3.0, -4.0));
	var[2][0][0][1] = (vec2(2.0, -3.0));
	var[2][0][0][2] = (vec2(6.0, 5.0));
	var[2][0][0][3] = (vec2(0.0, -2.0));
	var[2][0][1][0] = (vec2(-3.0, -2.0));
	var[2][0][1][1] = (vec2(-7.0, 3.0));
	var[2][0][1][2] = (vec2(-6.0, 2.0));
	var[2][0][1][3] = (vec2(9.0, 6.0));
	var[2][0][2][0] = (vec2(-4.0, 4.0));
	var[2][0][2][1] = (vec2(0.0, -3.0));
	var[2][0][2][2] = (vec2(-7.0, 0.0));
	var[2][0][2][3] = (vec2(-9.0, 1.0));
	var[2][1][0][0] = (vec2(-8.0, -5.0));
	var[2][1][0][1] = (vec2(8.0, -8.0));
	var[2][1][0][2] = (vec2(7.0, -2.0));
	var[2][1][0][3] = (vec2(-7.0, -7.0));
	var[2][1][1][0] = (vec2(6.0, -1.0));
	var[2][1][1][1] = (vec2(0.0, -4.0));
	var[2][1][1][2] = (vec2(-5.0, -3.0));
	var[2][1][1][3] = (vec2(-7.0, -5.0));
	var[2][1][2][0] = (vec2(-7.0, -7.0));
	var[2][1][2][1] = (vec2(-6.0, -7.0));
	var[2][1][2][2] = (vec2(3.0, 1.0));
	var[2][1][2][3] = (vec2(9.0, -1.0));
	var[3][0][0][0] = (vec2(7.0, 2.0));
	var[3][0][0][1] = (vec2(1.0, 9.0));
	var[3][0][0][2] = (vec2(-3.0, 3.0));
	var[3][0][0][3] = (vec2(-7.0, 9.0));
	var[3][0][1][0] = (vec2(-4.0, -1.0));
	var[3][0][1][1] = (vec2(3.0, 6.0));
	var[3][0][1][2] = (vec2(8.0, 3.0));
	var[3][0][1][3] = (vec2(1.0, 5.0));
	var[3][0][2][0] = (vec2(7.0, 0.0));
	var[3][0][2][1] = (vec2(0.0, -2.0));
	var[3][0][2][2] = (vec2(3.0, -7.0));
	var[3][0][2][3] = (vec2(-3.0, 1.0));
	var[3][1][0][0] = (vec2(-5.0, 4.0));
	var[3][1][0][1] = (vec2(6.0, 6.0));
	var[3][1][0][2] = (vec2(-4.0, -7.0));
	var[3][1][0][3] = (vec2(1.0, -7.0));
	var[3][1][1][0] = (vec2(-5.0, 3.0));
	var[3][1][1][1] = (vec2(-7.0, -3.0));
	var[3][1][1][2] = (vec2(-6.0, 7.0));
	var[3][1][1][3] = (vec2(-4.0, 1.0));
	var[3][1][2][0] = (vec2(-7.0, -7.0));
	var[3][1][2][1] = (vec2(0.0, 4.0));
	var[3][1][2][2] = (vec2(4.0, -9.0));
	var[3][1][2][3] = (vec2(-5.0, -8.0));
}
#version 450
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
	i16vec2 var[4][2][3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0][0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][0]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][1]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][2]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][0]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][1]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][2]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][0]), ivec2(-2, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][1]), ivec2(-6, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][2]), ivec2(8, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][2]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][0]), ivec2(0, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][1]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][2]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec2(ivec2(6, -2));
	var[0][0][1] = i16vec2(ivec2(-2, -8));
	var[0][0][2] = i16vec2(ivec2(3, 5));
	var[0][1][0] = i16vec2(ivec2(6, 9));
	var[0][1][1] = i16vec2(ivec2(0, 9));
	var[0][1][2] = i16vec2(ivec2(0, 5));
	var[1][0][0] = i16vec2(ivec2(-9, -9));
	var[1][0][1] = i16vec2(ivec2(-4, -3));
	var[1][0][2] = i16vec2(ivec2(-2, 6));
	var[1][1][0] = i16vec2(ivec2(9, -8));
	var[1][1][1] = i16vec2(ivec2(4, 6));
	var[1][1][2] = i16vec2(ivec2(-9, -9));
	var[2][0][0] = i16vec2(ivec2(0, -1));
	var[2][0][1] = i16vec2(ivec2(3, -9));
	var[2][0][2] = i16vec2(ivec2(9, -6));
	var[2][1][0] = i16vec2(ivec2(4, 1));
	var[2][1][1] = i16vec2(ivec2(-5, -1));
	var[2][1][2] = i16vec2(ivec2(4, -5));
	var[3][0][0] = i16vec2(ivec2(-1, -7));
	var[3][0][1] = i16vec2(ivec2(-1, -6));
	var[3][0][2] = i16vec2(ivec2(6, 5));
	var[3][1][0] = i16vec2(ivec2(-6, 1));
	var[3][1][1] = i16vec2(ivec2(-8, 4));
	var[3][1][2] = i16vec2(ivec2(-6, 1));
}
#version 450
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
	f16vec3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0][0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][2]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][0]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][1]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][2]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][0]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][1]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][2]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][2]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][2]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][0]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][1]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][2]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][0]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][1]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][2]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[0][0][2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[0][1][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	var[0][1][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	var[0][1][2] = f16vec3(vec3(6.0, 9.0, 7.0));
	var[1][0][0] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[1][0][1] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[1][0][2] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[1][1][0] = f16vec3(vec3(2.0, 5.0, 3.0));
	var[1][1][1] = f16vec3(vec3(9.0, -8.0, 2.0));
	var[1][1][2] = f16vec3(vec3(-7.0, -8.0, -3.0));
	var[2][0][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[2][0][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[2][0][2] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[2][1][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	var[2][1][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	var[2][1][2] = f16vec3(vec3(-9.0, -5.0, 5.0));
	var[3][0][0] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[3][0][1] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[3][0][2] = f16vec3(vec3(-4.0, -2.0, 4.0));
	var[3][1][0] = f16vec3(vec3(-3.0, -6.0, 0.0));
	var[3][1][1] = f16vec3(vec3(-3.0, 9.0, -1.0));
	var[3][1][2] = f16vec3(vec3(-9.0, 0.0, -5.0));
}
#version 450
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
	bvec3 var[4][2][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec3((var[0][0][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][0][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[0][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[0][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[0][1][2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[1][0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[1][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[1][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1][1][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[1][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[2][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[2][0][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[2][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[2][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[3][0][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[3][0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[3][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][1][1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[3][1][2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var[0][0][0] = (bvec3(true, false, false));
	var[0][0][1] = (bvec3(true, true, false));
	var[0][0][2] = (bvec3(false, false, true));
	var[0][1][0] = (bvec3(false, true, true));
	var[0][1][1] = (bvec3(false, true, false));
	var[0][1][2] = (bvec3(false, false, true));
	var[1][0][0] = (bvec3(false, false, true));
	var[1][0][1] = (bvec3(true, true, false));
	var[1][0][2] = (bvec3(true, true, false));
	var[1][1][0] = (bvec3(true, false, false));
	var[1][1][1] = (bvec3(false, true, false));
	var[1][1][2] = (bvec3(false, true, true));
	var[2][0][0] = (bvec3(true, true, true));
	var[2][0][1] = (bvec3(true, true, true));
	var[2][0][2] = (bvec3(true, true, true));
	var[2][1][0] = (bvec3(true, false, false));
	var[2][1][1] = (bvec3(true, false, false));
	var[2][1][2] = (bvec3(true, false, false));
	var[3][0][0] = (bvec3(false, false, false));
	var[3][0][1] = (bvec3(true, false, true));
	var[3][0][2] = (bvec3(false, false, false));
	var[3][1][0] = (bvec3(false, false, true));
	var[3][1][1] = (bvec3(true, false, false));
	var[3][1][2] = (bvec3(true, false, false));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(2.0, -3.0, -5.0, -8.0, -3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-6.0, 9.0, 2.0, -1.0, 8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(-7.0, -3.0, 8.0, 0.0, -1.0, -5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-6.0, 5.0, -7.0, 0.0, 3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-6.0, 1.0, 5.0, -1.0, -1.0, 5.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-9.0, 7.0, 3.0, 1.0, 4.0, 9.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -6.0, 8.0, -4.0, -4.0, 0.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(0.0, -1.0, 1.0, 5.0, 5.0, 3.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-5.0, -6.0, 3.0, -2.0, 5.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-9.0, -6.0, -7.0, 5.0, 8.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-3.0, -1.0, -3.0, 3.0, -1.0, -6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-6.0, -8.0, 1.0, 8.0, -8.0, -4.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-1.0, 4.0, 5.0, -9.0, 8.0, -1.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(0.0, -9.0, 6.0, -2.0, 3.0, 2.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-2.0, 5.0, -8.0, -8.0, 0.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(9.0, -4.0, -1.0, 2.0, 9.0, 9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(2.0, 1.0, 4.0, 5.0, 6.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(9.0, 2.0, -7.0, 2.0, 0.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(9.0, 6.0, 1.0, -5.0, -1.0, 4.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(5.0, 3.0, 9.0, -3.0, 4.0, 7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(7.0, -8.0, -2.0, 0.0, -4.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(2.0, -5.0, 1.0, 2.0, -3.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(9.0, 4.0, 0.0, -9.0, 5.0, 8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(0.0, -8.0, 1.0, 2.0, 5.0, 6.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (mat2x4(2.0, -2.0, 9.0, -4.0, 3.0, 2.0, -4.0, 0.0));
	var[0][0][1] = (mat2x4(6.0, 0.0, -1.0, -8.0, 7.0, 4.0, -8.0, 2.0));
	var[0][0][2] = (mat2x4(5.0, 4.0, -3.0, 4.0, 8.0, 2.0, 4.0, -6.0));
	var[0][1][0] = (mat2x4(7.0, 5.0, -9.0, 8.0, -7.0, -5.0, 8.0, -9.0));
	var[0][1][1] = (mat2x4(7.0, 5.0, -2.0, 7.0, -3.0, 4.0, 1.0, 5.0));
	var[0][1][2] = (mat2x4(-1.0, 8.0, 4.0, -9.0, 2.0, 3.0, -3.0, 2.0));
	var[1][0][0] = (mat2x4(7.0, -5.0, -1.0, -8.0, 1.0, 7.0, -9.0, -2.0));
	var[1][0][1] = (mat2x4(6.0, -7.0, 6.0, 9.0, -6.0, -6.0, 6.0, 3.0));
	var[1][0][2] = (mat2x4(7.0, -1.0, 9.0, 5.0, 9.0, 4.0, -6.0, -7.0));
	var[1][1][0] = (mat2x4(-7.0, 9.0, 4.0, -1.0, 5.0, 5.0, -9.0, 7.0));
	var[1][1][1] = (mat2x4(0.0, -9.0, 5.0, -7.0, 7.0, -4.0, 6.0, -4.0));
	var[1][1][2] = (mat2x4(8.0, -2.0, -5.0, 5.0, 5.0, -1.0, 5.0, 8.0));
	var[2][0][0] = (mat2x4(-6.0, -5.0, 9.0, 2.0, 0.0, -8.0, 2.0, 2.0));
	var[2][0][1] = (mat2x4(-7.0, -3.0, 5.0, 2.0, 3.0, 4.0, 6.0, 4.0));
	var[2][0][2] = (mat2x4(-9.0, -1.0, 6.0, -2.0, 2.0, 8.0, -5.0, 4.0));
	var[2][1][0] = (mat2x4(6.0, -6.0, 6.0, -3.0, 2.0, 5.0, 5.0, 1.0));
	var[2][1][1] = (mat2x4(2.0, -5.0, 3.0, 3.0, 8.0, 2.0, 3.0, -4.0));
	var[2][1][2] = (mat2x4(6.0, 8.0, 8.0, 7.0, -9.0, -5.0, -3.0, -3.0));
	var[3][0][0] = (mat2x4(7.0, 0.0, 6.0, 9.0, 1.0, -1.0, -1.0, 5.0));
	var[3][0][1] = (mat2x4(-2.0, -9.0, 9.0, 3.0, 9.0, -6.0, -6.0, 2.0));
	var[3][0][2] = (mat2x4(6.0, 9.0, 1.0, 5.0, 4.0, -3.0, 6.0, 1.0));
	var[3][1][0] = (mat2x4(-5.0, -2.0, 3.0, 1.0, -4.0, -9.0, -1.0, -1.0));
	var[3][1][1] = (mat2x4(-9.0, 0.0, -7.0, 1.0, 9.0, -7.0, 4.0, 9.0));
	var[3][1][2] = (mat2x4(-5.0, 3.0, -8.0, 6.0, -7.0, -5.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0][0][0] = (vec4(8.0, -2.0, 8.0, 8.0));
	var[0][0][0][1] = (vec4(3.0, 5.0, -5.0, 7.0));
	var[0][0][0][2] = (vec4(6.0, -9.0, 3.0, 0.0));
	var[0][0][1][0] = (vec4(-3.0, 1.0, -9.0, -9.0));
	var[0][0][1][1] = (vec4(-6.0, -5.0, 1.0, 9.0));
	var[0][0][1][2] = (vec4(0.0, -9.0, -2.0, -4.0));
	var[0][0][2][0] = (vec4(-3.0, -1.0, -6.0, 1.0));
	var[0][0][2][1] = (vec4(-2.0, -2.0, -1.0, -7.0));
	var[0][0][2][2] = (vec4(8.0, 0.0, -6.0, -1.0));
	var[0][1][0][0] = (vec4(-1.0, 2.0, -8.0, -6.0));
	var[0][1][0][1] = (vec4(4.0, -8.0, 9.0, 0.0));
	var[0][1][0][2] = (vec4(7.0, -2.0, 2.0, 2.0));
	var[0][1][1][0] = (vec4(9.0, -9.0, 2.0, 1.0));
	var[0][1][1][1] = (vec4(5.0, 5.0, 5.0, 0.0));
	var[0][1][1][2] = (vec4(9.0, 8.0, 7.0, 7.0));
	var[0][1][2][0] = (vec4(5.0, -7.0, -6.0, -4.0));
	var[0][1][2][1] = (vec4(4.0, -5.0, -7.0, 2.0));
	var[0][1][2][2] = (vec4(2.0, 1.0, -7.0, 1.0));
	var[1][0][0][0] = (vec4(7.0, -6.0, -1.0, -7.0));
	var[1][0][0][1] = (vec4(-8.0, 7.0, -8.0, 6.0));
	var[1][0][0][2] = (vec4(-8.0, 2.0, -5.0, 9.0));
	var[1][0][1][0] = (vec4(-7.0, 4.0, -1.0, -3.0));
	var[1][0][1][1] = (vec4(-8.0, -1.0, 1.0, -6.0));
	var[1][0][1][2] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[1][0][2][0] = (vec4(0.0, -6.0, 5.0, -1.0));
	var[1][0][2][1] = (vec4(4.0, 3.0, -6.0, 1.0));
	var[1][0][2][2] = (vec4(8.0, -2.0, 3.0, -1.0));
	var[1][1][0][0] = (vec4(-1.0, 9.0, -4.0, 4.0));
	var[1][1][0][1] = (vec4(1.0, 7.0, -4.0, 1.0));
	var[1][1][0][2] = (vec4(9.0, -7.0, 4.0, -2.0));
	var[1][1][1][0] = (vec4(5.0, -1.0, 9.0, -9.0));
	var[1][1][1][1] = (vec4(-6.0, 3.0, 7.0, -1.0));
	var[1][1][1][2] = (vec4(-6.0, 3.0, -3.0, 1.0));
	var[1][1][2][0] = (vec4(7.0, 2.0, -9.0, 0.0));
	var[1][1][2][1] = (vec4(-8.0, -8.0, 4.0, 7.0));
	var[1][1][2][2] = (vec4(6.0, 8.0, -2.0, 8.0));
	var[2][0][0][0] = (vec4(-9.0, 4.0, 9.0, 0.0));
	var[2][0][0][1] = (vec4(2.0, -7.0, -7.0, -1.0));
	var[2][0][0][2] = (vec4(8.0, -9.0, -3.0, 5.0));
	var[2][0][1][0] = (vec4(7.0, -8.0, 1.0, -5.0));
	var[2][0][1][1] = (vec4(0.0, -7.0, -3.0, -5.0));
	var[2][0][1][2] = (vec4(-4.0, 3.0, -5.0, 4.0));
	var[2][0][2][0] = (vec4(5.0, -9.0, -6.0, 5.0));
	var[2][0][2][1] = (vec4(3.0, -6.0, -7.0, -3.0));
	var[2][0][2][2] = (vec4(9.0, 3.0, -7.0, -9.0));
	var[2][1][0][0] = (vec4(9.0, -2.0, -1.0, 7.0));
	var[2][1][0][1] = (vec4(-4.0, -8.0, 9.0, -5.0));
	var[2][1][0][2] = (vec4(7.0, 9.0, -6.0, -2.0));
	var[2][1][1][0] = (vec4(8.0, -6.0, 9.0, -3.0));
	var[2][1][1][1] = (vec4(4.0, 1.0, -8.0, 9.0));
	var[2][1][1][2] = (vec4(-1.0, 4.0, 6.0, 6.0));
	var[2][1][2][0] = (vec4(-5.0, -8.0, -2.0, -3.0));
	var[2][1][2][1] = (vec4(-8.0, 3.0, 8.0, 1.0));
	var[2][1][2][2] = (vec4(-5.0, 7.0, 2.0, 4.0));
	var[3][0][0][0] = (vec4(-9.0, 6.0, -9.0, 6.0));
	var[3][0][0][1] = (vec4(-1.0, -1.0, -4.0, 5.0));
	var[3][0][0][2] = (vec4(2.0, -6.0, 8.0, 4.0));
	var[3][0][1][0] = (vec4(2.0, 4.0, -3.0, 9.0));
	var[3][0][1][1] = (vec4(8.0, 5.0, -3.0, 7.0));
	var[3][0][1][2] = (vec4(-4.0, 6.0, 4.0, 0.0));
	var[3][0][2][0] = (vec4(-2.0, 1.0, 8.0, 1.0));
	var[3][0][2][1] = (vec4(4.0, 6.0, 4.0, -2.0));
	var[3][0][2][2] = (vec4(9.0, 9.0, 7.0, 4.0));
	var[3][1][0][0] = (vec4(7.0, 0.0, -1.0, 3.0));
	var[3][1][0][1] = (vec4(8.0, -5.0, 9.0, -5.0));
	var[3][1][0][2] = (vec4(8.0, -3.0, 1.0, 7.0));
	var[3][1][1][0] = (vec4(9.0, 3.0, -6.0, -1.0));
	var[3][1][1][1] = (vec4(-7.0, -5.0, 3.0, -1.0));
	var[3][1][1][2] = (vec4(-1.0, 9.0, 3.0, 5.0));
	var[3][1][2][0] = (vec4(6.0, -3.0, 6.0, -2.0));
	var[3][1][2][1] = (vec4(2.0, -3.0, 0.0, 7.0));
	var[3][1][2][2] = (vec4(8.0, -4.0, -2.0, 2.0));
}
#version 450
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
	bvec2 var[][4][2];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[0][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][3][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2][3][1]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec2(true, false));
	var[0][0][1] = (bvec2(true, true));
	var[0][1][0] = (bvec2(false, false));
	var[0][1][1] = (bvec2(false, true));
	var[0][2][0] = (bvec2(false, true));
	var[0][2][1] = (bvec2(true, true));
	var[0][3][0] = (bvec2(true, false));
	var[0][3][1] = (bvec2(true, false));
	var[1][0][0] = (bvec2(false, false));
	var[1][0][1] = (bvec2(false, false));
	var[1][1][0] = (bvec2(true, true));
	var[1][1][1] = (bvec2(false, false));
	var[1][2][0] = (bvec2(false, false));
	var[1][2][1] = (bvec2(true, true));
	var[1][3][0] = (bvec2(true, false));
	var[1][3][1] = (bvec2(false, false));
	var[2][0][0] = (bvec2(false, true));
	var[2][0][1] = (bvec2(true, true));
	var[2][1][0] = (bvec2(true, false));
	var[2][1][1] = (bvec2(true, false));
	var[2][2][0] = (bvec2(true, false));
	var[2][2][1] = (bvec2(false, false));
	var[2][3][0] = (bvec2(false, false));
	var[2][3][1] = (bvec2(false, true));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[0][1][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[0][1][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[0][2][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	var[0][2][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	var[0][3][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	var[0][3][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	var[1][0][0] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[1][0][1] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[1][1][0] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[1][1][1] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[1][2][0] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	var[1][2][1] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	var[1][3][0] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	var[1][3][1] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	var[2][0][0] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[2][0][1] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[2][1][0] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[2][1][1] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	var[2][2][0] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	var[2][2][1] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	var[2][3][0] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	var[2][3][1] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(-7.0, 4.0, -9.0, 9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(4.0, -3.0, 2.0, 1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-9.0, -9.0, -9.0, 3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(1.0, 3.0, -2.0, 4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(-5.0, 3.0, 3.0, 2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, 3.0, -7.0));
	var[0][0][0][1] = (vec3(-7.0, 2.0, 3.0));
	var[0][0][0][2] = (vec3(1.0, -2.0, -1.0));
	var[0][0][0][3] = (vec3(-5.0, -1.0, 9.0));
	var[0][0][1][0] = (vec3(8.0, -4.0, 3.0));
	var[0][0][1][1] = (vec3(4.0, 9.0, -6.0));
	var[0][0][1][2] = (vec3(7.0, 6.0, -5.0));
	var[0][0][1][3] = (vec3(2.0, 6.0, 3.0));
	var[0][1][0][0] = (vec3(-9.0, 3.0, -2.0));
	var[0][1][0][1] = (vec3(5.0, 6.0, -7.0));
	var[0][1][0][2] = (vec3(-8.0, 1.0, 8.0));
	var[0][1][0][3] = (vec3(1.0, 6.0, -1.0));
	var[0][1][1][0] = (vec3(-5.0, 0.0, -6.0));
	var[0][1][1][1] = (vec3(5.0, -3.0, 2.0));
	var[0][1][1][2] = (vec3(-5.0, 2.0, -2.0));
	var[0][1][1][3] = (vec3(-7.0, -9.0, -1.0));
	var[0][2][0][0] = (vec3(-5.0, 5.0, -2.0));
	var[0][2][0][1] = (vec3(1.0, -7.0, -9.0));
	var[0][2][0][2] = (vec3(4.0, -9.0, 8.0));
	var[0][2][0][3] = (vec3(2.0, 5.0, -4.0));
	var[0][2][1][0] = (vec3(-9.0, -9.0, 5.0));
	var[0][2][1][1] = (vec3(-3.0, 6.0, -3.0));
	var[0][2][1][2] = (vec3(7.0, -9.0, -4.0));
	var[0][2][1][3] = (vec3(9.0, 6.0, 2.0));
	var[0][3][0][0] = (vec3(-1.0, -5.0, 2.0));
	var[0][3][0][1] = (vec3(4.0, 7.0, -4.0));
	var[0][3][0][2] = (vec3(6.0, 2.0, -4.0));
	var[0][3][0][3] = (vec3(8.0, -8.0, -1.0));
	var[0][3][1][0] = (vec3(-8.0, -9.0, 2.0));
	var[0][3][1][1] = (vec3(-8.0, -2.0, -1.0));
	var[0][3][1][2] = (vec3(-4.0, 5.0, 4.0));
	var[0][3][1][3] = (vec3(-6.0, -1.0, 7.0));
	var[1][0][0][0] = (vec3(2.0, 7.0, -1.0));
	var[1][0][0][1] = (vec3(-3.0, -3.0, -7.0));
	var[1][0][0][2] = (vec3(-5.0, 3.0, 4.0));
	var[1][0][0][3] = (vec3(-4.0, -2.0, 8.0));
	var[1][0][1][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][0][1][1] = (vec3(-4.0, -7.0, -7.0));
	var[1][0][1][2] = (vec3(8.0, 4.0, -6.0));
	var[1][0][1][3] = (vec3(6.0, 0.0, 1.0));
	var[1][1][0][0] = (vec3(-2.0, -3.0, -7.0));
	var[1][1][0][1] = (vec3(-9.0, -4.0, 9.0));
	var[1][1][0][2] = (vec3(4.0, -4.0, 5.0));
	var[1][1][0][3] = (vec3(7.0, 1.0, 7.0));
	var[1][1][1][0] = (vec3(-9.0, 5.0, 4.0));
	var[1][1][1][1] = (vec3(4.0, 0.0, 0.0));
	var[1][1][1][2] = (vec3(0.0, -3.0, 3.0));
	var[1][1][1][3] = (vec3(1.0, 8.0, 0.0));
	var[1][2][0][0] = (vec3(-3.0, -5.0, 2.0));
	var[1][2][0][1] = (vec3(-9.0, 5.0, -6.0));
	var[1][2][0][2] = (vec3(5.0, -7.0, -9.0));
	var[1][2][0][3] = (vec3(0.0, 9.0, 9.0));
	var[1][2][1][0] = (vec3(-9.0, 5.0, 5.0));
	var[1][2][1][1] = (vec3(-2.0, 7.0, 7.0));
	var[1][2][1][2] = (vec3(-2.0, 7.0, -9.0));
	var[1][2][1][3] = (vec3(5.0, 5.0, -4.0));
	var[1][3][0][0] = (vec3(1.0, -1.0, 9.0));
	var[1][3][0][1] = (vec3(-9.0, 4.0, 7.0));
	var[1][3][0][2] = (vec3(-5.0, -9.0, 1.0));
	var[1][3][0][3] = (vec3(-1.0, 2.0, -5.0));
	var[1][3][1][0] = (vec3(3.0, 6.0, 7.0));
	var[1][3][1][1] = (vec3(4.0, -5.0, 8.0));
	var[1][3][1][2] = (vec3(4.0, 6.0, 1.0));
	var[1][3][1][3] = (vec3(-4.0, 5.0, -7.0));
	var[2][0][0][0] = (vec3(7.0, -1.0, -8.0));
	var[2][0][0][1] = (vec3(9.0, 9.0, -6.0));
	var[2][0][0][2] = (vec3(0.0, 1.0, 1.0));
	var[2][0][0][3] = (vec3(2.0, 7.0, 2.0));
	var[2][0][1][0] = (vec3(-3.0, -6.0, 5.0));
	var[2][0][1][1] = (vec3(3.0, -1.0, -1.0));
	var[2][0][1][2] = (vec3(-2.0, 9.0, -5.0));
	var[2][0][1][3] = (vec3(8.0, -6.0, -5.0));
	var[2][1][0][0] = (vec3(-2.0, 9.0, -8.0));
	var[2][1][0][1] = (vec3(-8.0, 7.0, -9.0));
	var[2][1][0][2] = (vec3(3.0, -2.0, -3.0));
	var[2][1][0][3] = (vec3(-5.0, 1.0, -4.0));
	var[2][1][1][0] = (vec3(5.0, 5.0, 8.0));
	var[2][1][1][1] = (vec3(3.0, 7.0, -3.0));
	var[2][1][1][2] = (vec3(-2.0, 2.0, -9.0));
	var[2][1][1][3] = (vec3(0.0, 9.0, 5.0));
	var[2][2][0][0] = (vec3(6.0, -3.0, 7.0));
	var[2][2][0][1] = (vec3(-3.0, 1.0, -7.0));
	var[2][2][0][2] = (vec3(-1.0, 0.0, -9.0));
	var[2][2][0][3] = (vec3(0.0, -4.0, 9.0));
	var[2][2][1][0] = (vec3(-6.0, -5.0, 7.0));
	var[2][2][1][1] = (vec3(6.0, 1.0, -2.0));
	var[2][2][1][2] = (vec3(2.0, 8.0, 9.0));
	var[2][2][1][3] = (vec3(2.0, -8.0, -9.0));
	var[2][3][0][0] = (vec3(-2.0, -3.0, -9.0));
	var[2][3][0][1] = (vec3(5.0, -8.0, -5.0));
	var[2][3][0][2] = (vec3(-7.0, -4.0, -3.0));
	var[2][3][0][3] = (vec3(-1.0, 8.0, -8.0));
	var[2][3][1][0] = (vec3(-2.0, -6.0, 6.0));
	var[2][3][1][1] = (vec3(-3.0, -2.0, -8.0));
	var[2][3][1][2] = (vec3(-3.0, -2.0, -2.0));
	var[2][3][1][3] = (vec3(-9.0, 4.0, 7.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(7.0, 4.0, -4.0));
	var[0][0][0][1] = (vec3(-6.0, 3.0, -3.0));
	var[0][0][0][2] = (vec3(9.0, -2.0, 3.0));
	var[0][0][0][3] = (vec3(9.0, -9.0, 7.0));
	var[0][0][1][0] = (vec3(5.0, 1.0, -9.0));
	var[0][0][1][1] = (vec3(-1.0, -2.0, 6.0));
	var[0][0][1][2] = (vec3(-4.0, 6.0, 4.0));
	var[0][0][1][3] = (vec3(-8.0, 7.0, 3.0));
	var[0][1][0][0] = (vec3(9.0, 1.0, -1.0));
	var[0][1][0][1] = (vec3(-1.0, 2.0, 4.0));
	var[0][1][0][2] = (vec3(4.0, 2.0, 0.0));
	var[0][1][0][3] = (vec3(5.0, 6.0, -6.0));
	var[0][1][1][0] = (vec3(-3.0, 7.0, -6.0));
	var[0][1][1][1] = (vec3(7.0, 9.0, 8.0));
	var[0][1][1][2] = (vec3(-9.0, -9.0, -9.0));
	var[0][1][1][3] = (vec3(6.0, -7.0, -3.0));
	var[0][2][0][0] = (vec3(-5.0, 2.0, -4.0));
	var[0][2][0][1] = (vec3(-7.0, -3.0, -4.0));
	var[0][2][0][2] = (vec3(4.0, -3.0, -8.0));
	var[0][2][0][3] = (vec3(-5.0, -1.0, 1.0));
	var[0][2][1][0] = (vec3(6.0, -2.0, 8.0));
	var[0][2][1][1] = (vec3(-7.0, 1.0, 4.0));
	var[0][2][1][2] = (vec3(6.0, 8.0, -5.0));
	var[0][2][1][3] = (vec3(1.0, -6.0, 4.0));
	var[0][3][0][0] = (vec3(-1.0, 7.0, 7.0));
	var[0][3][0][1] = (vec3(3.0, -4.0, -1.0));
	var[0][3][0][2] = (vec3(-4.0, 5.0, 7.0));
	var[0][3][0][3] = (vec3(-5.0, 7.0, 5.0));
	var[0][3][1][0] = (vec3(-1.0, -1.0, 5.0));
	var[0][3][1][1] = (vec3(9.0, 7.0, -5.0));
	var[0][3][1][2] = (vec3(3.0, -1.0, 3.0));
	var[0][3][1][3] = (vec3(8.0, -5.0, 3.0));
	var[1][0][0][0] = (vec3(-4.0, -9.0, 8.0));
	var[1][0][0][1] = (vec3(9.0, 2.0, 2.0));
	var[1][0][0][2] = (vec3(9.0, -7.0, 3.0));
	var[1][0][0][3] = (vec3(8.0, 2.0, 4.0));
	var[1][0][1][0] = (vec3(2.0, 4.0, -3.0));
	var[1][0][1][1] = (vec3(-8.0, 7.0, 3.0));
	var[1][0][1][2] = (vec3(0.0, -8.0, 0.0));
	var[1][0][1][3] = (vec3(6.0, -9.0, 0.0));
	var[1][1][0][0] = (vec3(7.0, -1.0, -4.0));
	var[1][1][0][1] = (vec3(-9.0, 0.0, -1.0));
	var[1][1][0][2] = (vec3(-7.0, -2.0, -3.0));
	var[1][1][0][3] = (vec3(1.0, 4.0, 5.0));
	var[1][1][1][0] = (vec3(9.0, 8.0, 7.0));
	var[1][1][1][1] = (vec3(5.0, 4.0, 7.0));
	var[1][1][1][2] = (vec3(3.0, -3.0, 4.0));
	var[1][1][1][3] = (vec3(3.0, -6.0, 5.0));
	var[1][2][0][0] = (vec3(-9.0, 3.0, -3.0));
	var[1][2][0][1] = (vec3(0.0, -5.0, -3.0));
	var[1][2][0][2] = (vec3(-5.0, -8.0, 3.0));
	var[1][2][0][3] = (vec3(3.0, -6.0, 8.0));
	var[1][2][1][0] = (vec3(-3.0, 5.0, 6.0));
	var[1][2][1][1] = (vec3(5.0, -1.0, 6.0));
	var[1][2][1][2] = (vec3(8.0, 7.0, 1.0));
	var[1][2][1][3] = (vec3(-5.0, 6.0, -6.0));
	var[1][3][0][0] = (vec3(-6.0, 1.0, 0.0));
	var[1][3][0][1] = (vec3(8.0, -8.0, 5.0));
	var[1][3][0][2] = (vec3(-3.0, 5.0, -4.0));
	var[1][3][0][3] = (vec3(-3.0, -2.0, 2.0));
	var[1][3][1][0] = (vec3(-5.0, 3.0, -6.0));
	var[1][3][1][1] = (vec3(-6.0, -4.0, -2.0));
	var[1][3][1][2] = (vec3(-5.0, -2.0, -2.0));
	var[1][3][1][3] = (vec3(-8.0, 2.0, 4.0));
	var[2][0][0][0] = (vec3(-4.0, 5.0, 5.0));
	var[2][0][0][1] = (vec3(-7.0, -8.0, -1.0));
	var[2][0][0][2] = (vec3(6.0, -3.0, -5.0));
	var[2][0][0][3] = (vec3(0.0, 8.0, -8.0));
	var[2][0][1][0] = (vec3(-4.0, 4.0, 8.0));
	var[2][0][1][1] = (vec3(-4.0, -4.0, -3.0));
	var[2][0][1][2] = (vec3(3.0, 3.0, 2.0));
	var[2][0][1][3] = (vec3(8.0, -8.0, -6.0));
	var[2][1][0][0] = (vec3(-8.0, -4.0, -9.0));
	var[2][1][0][1] = (vec3(4.0, 8.0, -3.0));
	var[2][1][0][2] = (vec3(-9.0, 7.0, -2.0));
	var[2][1][0][3] = (vec3(0.0, -3.0, -3.0));
	var[2][1][1][0] = (vec3(4.0, -2.0, -4.0));
	var[2][1][1][1] = (vec3(-5.0, -7.0, 1.0));
	var[2][1][1][2] = (vec3(-8.0, 1.0, 9.0));
	var[2][1][1][3] = (vec3(-8.0, 0.0, -2.0));
	var[2][2][0][0] = (vec3(-3.0, -7.0, 7.0));
	var[2][2][0][1] = (vec3(-9.0, -3.0, 6.0));
	var[2][2][0][2] = (vec3(0.0, -7.0, 3.0));
	var[2][2][0][3] = (vec3(2.0, -7.0, 1.0));
	var[2][2][1][0] = (vec3(8.0, -1.0, -9.0));
	var[2][2][1][1] = (vec3(8.0, 8.0, 2.0));
	var[2][2][1][2] = (vec3(7.0, -5.0, -2.0));
	var[2][2][1][3] = (vec3(-9.0, 6.0, 2.0));
	var[2][3][0][0] = (vec3(-1.0, -1.0, 1.0));
	var[2][3][0][1] = (vec3(-9.0, -7.0, -8.0));
	var[2][3][0][2] = (vec3(-8.0, -5.0, -1.0));
	var[2][3][0][3] = (vec3(2.0, 0.0, -4.0));
	var[2][3][1][0] = (vec3(7.0, 6.0, 4.0));
	var[2][3][1][1] = (vec3(-5.0, -5.0, 8.0));
	var[2][3][1][2] = (vec3(-3.0, 4.0, -5.0));
	var[2][3][1][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	i8vec2 var[][4][2];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][3][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][3][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][0]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][1]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][0]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2][0]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2][1]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][3][0]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][3][1]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][0]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][1]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][0]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][1]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2][0]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2][1]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][3][0]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][3][1]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec2(ivec2(0, 8));
	var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	var[0][1][0] = i8vec2(ivec2(4294967293, 4294967293));
	var[0][1][1] = i8vec2(ivec2(4294967290, 3));
	var[0][2][0] = i8vec2(ivec2(4294967293, 0));
	var[0][2][1] = i8vec2(ivec2(3, 4294967291));
	var[0][3][0] = i8vec2(ivec2(4294967292, 4294967292));
	var[0][3][1] = i8vec2(ivec2(3, 4294967294));
	var[1][0][0] = i8vec2(ivec2(4294967294, 4294967295));
	var[1][0][1] = i8vec2(ivec2(8, 4294967290));
	var[1][1][0] = i8vec2(ivec2(4294967295, 8));
	var[1][1][1] = i8vec2(ivec2(5, 8));
	var[1][2][0] = i8vec2(ivec2(4294967295, 4294967292));
	var[1][2][1] = i8vec2(ivec2(5, 4294967292));
	var[1][3][0] = i8vec2(ivec2(8, 4));
	var[1][3][1] = i8vec2(ivec2(8, 6));
	var[2][0][0] = i8vec2(ivec2(8, 4294967289));
	var[2][0][1] = i8vec2(ivec2(7, 4294967294));
	var[2][1][0] = i8vec2(ivec2(4294967293, 4294967292));
	var[2][1][1] = i8vec2(ivec2(4294967287, 6));
	var[2][2][0] = i8vec2(ivec2(4294967291, 4));
	var[2][2][1] = i8vec2(ivec2(0, 4294967293));
	var[2][3][0] = i8vec2(ivec2(5, 4294967294));
	var[2][3][1] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	i16vec3 var[][4][2];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0][0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2][0]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2][1]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][3][0]), ivec3(-6, 2, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][3][1]), ivec3(-4, 3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][0]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][1]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][0]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][1]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2][0]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2][1]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][3][0]), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][3][1]), ivec3(2, 8, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][0]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][1]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][0]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][1]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2][0]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2][1]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][3][0]), ivec3(-8, -6, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][3][1]), ivec3(7, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec3(ivec3(6, 1, -2));
	var[0][0][1] = i16vec3(ivec3(-3, -1, -4));
	var[0][1][0] = i16vec3(ivec3(-5, -4, -8));
	var[0][1][1] = i16vec3(ivec3(0, 9, 6));
	var[0][2][0] = i16vec3(ivec3(-6, 7, -4));
	var[0][2][1] = i16vec3(ivec3(-8, 4, 1));
	var[0][3][0] = i16vec3(ivec3(-6, 9, -3));
	var[0][3][1] = i16vec3(ivec3(6, 8, 2));
	var[1][0][0] = i16vec3(ivec3(-2, -2, 2));
	var[1][0][1] = i16vec3(ivec3(0, -6, -2));
	var[1][1][0] = i16vec3(ivec3(5, -3, 4));
	var[1][1][1] = i16vec3(ivec3(-3, 9, 0));
	var[1][2][0] = i16vec3(ivec3(5, -4, -6));
	var[1][2][1] = i16vec3(ivec3(-6, 2, -7));
	var[1][3][0] = i16vec3(ivec3(7, -2, 2));
	var[1][3][1] = i16vec3(ivec3(5, -9, -7));
	var[2][0][0] = i16vec3(ivec3(0, -9, 2));
	var[2][0][1] = i16vec3(ivec3(-8, 6, 2));
	var[2][1][0] = i16vec3(ivec3(1, -5, 8));
	var[2][1][1] = i16vec3(ivec3(-5, 0, 7));
	var[2][2][0] = i16vec3(ivec3(-2, 2, -5));
	var[2][2][1] = i16vec3(ivec3(-3, -1, 0));
	var[2][3][0] = i16vec3(ivec3(4, -3, -4));
	var[2][3][1] = i16vec3(ivec3(-6, -4, -6));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(5.0, -4.0));
	var[0][0][0][1] = (vec2(5.0, 1.0));
	var[0][0][1][0] = (vec2(-8.0, -1.0));
	var[0][0][1][1] = (vec2(9.0, -8.0));
	var[0][1][0][0] = (vec2(4.0, -3.0));
	var[0][1][0][1] = (vec2(6.0, 7.0));
	var[0][1][1][0] = (vec2(-7.0, -9.0));
	var[0][1][1][1] = (vec2(5.0, 0.0));
	var[0][2][0][0] = (vec2(7.0, 7.0));
	var[0][2][0][1] = (vec2(0.0, 2.0));
	var[0][2][1][0] = (vec2(4.0, -7.0));
	var[0][2][1][1] = (vec2(-5.0, -7.0));
	var[0][3][0][0] = (vec2(4.0, -2.0));
	var[0][3][0][1] = (vec2(6.0, 1.0));
	var[0][3][1][0] = (vec2(-2.0, -8.0));
	var[0][3][1][1] = (vec2(9.0, 1.0));
	var[1][0][0][0] = (vec2(5.0, -4.0));
	var[1][0][0][1] = (vec2(5.0, -2.0));
	var[1][0][1][0] = (vec2(9.0, -9.0));
	var[1][0][1][1] = (vec2(-1.0, 6.0));
	var[1][1][0][0] = (vec2(9.0, 2.0));
	var[1][1][0][1] = (vec2(1.0, -6.0));
	var[1][1][1][0] = (vec2(8.0, -8.0));
	var[1][1][1][1] = (vec2(5.0, -5.0));
	var[1][2][0][0] = (vec2(8.0, 2.0));
	var[1][2][0][1] = (vec2(1.0, -1.0));
	var[1][2][1][0] = (vec2(9.0, 0.0));
	var[1][2][1][1] = (vec2(-8.0, -9.0));
	var[1][3][0][0] = (vec2(3.0, 4.0));
	var[1][3][0][1] = (vec2(-1.0, 5.0));
	var[1][3][1][0] = (vec2(2.0, -6.0));
	var[1][3][1][1] = (vec2(7.0, -4.0));
	var[2][0][0][0] = (vec2(-4.0, 7.0));
	var[2][0][0][1] = (vec2(-8.0, 1.0));
	var[2][0][1][0] = (vec2(4.0, -4.0));
	var[2][0][1][1] = (vec2(6.0, -5.0));
	var[2][1][0][0] = (vec2(-5.0, 4.0));
	var[2][1][0][1] = (vec2(5.0, 0.0));
	var[2][1][1][0] = (vec2(6.0, 9.0));
	var[2][1][1][1] = (vec2(5.0, -8.0));
	var[2][2][0][0] = (vec2(-2.0, 7.0));
	var[2][2][0][1] = (vec2(8.0, 2.0));
	var[2][2][1][0] = (vec2(-3.0, -3.0));
	var[2][2][1][1] = (vec2(7.0, -2.0));
	var[2][3][0][0] = (vec2(5.0, 3.0));
	var[2][3][0][1] = (vec2(9.0, -9.0));
	var[2][3][1][0] = (vec2(7.0, 1.0));
	var[2][3][1][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[0][0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[0][0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[0][0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[0][0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[0][1][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[0][1][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[0][1][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[0][1][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[0][1][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[0][1][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[0][1][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[0][1][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[0][2][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	var[0][2][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	var[0][2][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	var[0][2][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	var[0][2][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	var[0][2][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	var[0][2][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	var[0][2][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	var[0][3][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	var[0][3][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	var[0][3][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	var[0][3][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	var[0][3][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	var[0][3][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	var[0][3][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	var[0][3][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	var[1][0][0][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[1][0][0][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[1][0][0][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[1][0][0][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	var[1][0][1][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[1][0][1][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[1][0][1][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[1][0][1][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[1][1][0][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[1][1][0][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[1][1][0][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[1][1][0][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[1][1][1][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[1][1][1][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[1][1][1][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[1][1][1][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[1][2][0][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	var[1][2][0][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	var[1][2][0][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	var[1][2][0][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	var[1][2][1][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	var[1][2][1][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	var[1][2][1][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	var[1][2][1][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	var[1][3][0][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	var[1][3][0][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	var[1][3][0][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	var[1][3][0][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	var[1][3][1][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	var[1][3][1][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	var[1][3][1][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	var[1][3][1][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[2][0][0][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[2][0][0][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[2][0][0][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[2][0][0][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[2][0][1][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[2][0][1][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[2][0][1][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[2][0][1][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[2][1][0][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[2][1][0][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[2][1][0][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[2][1][0][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[2][1][1][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[2][1][1][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[2][1][1][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[2][1][1][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	var[2][2][0][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	var[2][2][0][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	var[2][2][0][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	var[2][2][0][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	var[2][2][1][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	var[2][2][1][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	var[2][2][1][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	var[2][2][1][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	var[2][3][0][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	var[2][3][0][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	var[2][3][0][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	var[2][3][0][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	var[2][3][1][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	var[2][3][1][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	var[2][3][1][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	var[2][3][1][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	u8vec4 var;
} block[3];

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block[0].var), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block[1].var), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block[2].var), uvec4(1u, 4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block[1].var = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block[2].var = u8vec4(uvec4(6u, 7u, 1u, 9u));
}
#version 450
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
	i8vec3 var;
} block[3];

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

layout(std430, column_major, binding = 1) buffer Block
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
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -6.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(2.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(7.0, -6.0, -6.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(5.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-7.0, -8.0, 6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(6.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-2.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block[1].var = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block[2].var = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
}
#version 450
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
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -3.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-7.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(5.0, -4.0, 1.0)) && allOk;
	allOk = compare_float((block[1].padding), -3.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 3.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(5.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(1.0, -3.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), -9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 5.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(1.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(0.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (4.0);
	block[0].var[0] = (vec3(5.0, -6.0, 0.0));
	block[0].var[1] = (vec3(-8.0, -2.0, 8.0));
	block[1].padding = (8.0);
	block[1].var[0] = (vec3(0.0, 3.0, -6.0));
	block[1].var[1] = (vec3(-6.0, -1.0, 2.0));
	block[2].padding = (-9.0);
	block[2].var[0] = (vec3(1.0, 3.0, 2.0));
	block[2].var[1] = (vec3(1.0, 5.0, -6.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), 1.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-9.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_float((blockA[1].a), -9.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(-8.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_float((blockA[2].a), -1.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(-4.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(6, -3)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-1, -8)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(5, 1)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[1].a = (0.0);
	blockA[2].a = (-1.0);
	blockB[0].a[0] = (vec3(-5.0, 5.0, 6.0));
	blockB[0].a[1] = (vec3(9.0, -6.0, -4.0));
	blockB[0].a[2] = (vec3(0.0, -8.0, 5.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(-9.0, 8.0, -1.0));
	blockB[1].a[1] = (vec3(-6.0, 9.0, 2.0));
	blockB[1].a[2] = (vec3(-1.0, -7.0, -5.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(5.0, 0.0, 9.0));
	blockB[2].a[1] = (vec3(-9.0, -5.0, 7.0));
	blockB[2].a[2] = (vec3(-7.0, 8.0, 0.0));
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
} blockA;
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), -5.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-5, 7)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-4.0, 0.0, -9.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-9.0);
	blockA.b.a[0] = (vec3(-7.0, 5.0, -6.0));
	blockA.b.a[1] = (vec3(3.0, -3.0, -2.0));
	blockA.b.a[2] = (vec3(-9.0, 1.0, -7.0));
	blockA.b.b[0] = (ivec2(9, 9));
	blockA.b.b[1] = (ivec2(-7, -8));
	blockA.b.b[2] = (ivec2(3, -7));
	blockA.b.b[3] = (ivec2(8, 6));
	blockA.b.c = (vec4(8.0, 0.0, 5.0, -7.0));
	blockB.a[0] = (vec2(7.0, 3.0));
	blockB.a[1] = (vec2(-2.0, 9.0));
	blockB.b.a = (2u);
	blockB.b.b.a[0] = (vec3(-1.0, 9.0, 0.0));
	blockB.b.b.a[1] = (vec3(5.0, -2.0, 4.0));
	blockB.b.b.a[2] = (vec3(-3.0, 0.0, 7.0));
	blockB.b.b.b[0] = (ivec2(-2, -7));
	blockB.b.b.b[1] = (ivec2(1, 4));
	blockB.b.b.b[2] = (ivec2(-2, 5));
	blockB.b.b.b[3] = (ivec2(-7, -7));
	blockB.b.b.c = (vec4(1.0, -6.0, 2.0, 3.0));
	blockB.b.c = (bvec4(true, true, true, true));
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

layout(std430, column_major, binding = 1) buffer BlockB
{
	bvec3 a;
	bool b;
	lowp mat3x4 c;
	mediump float d;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uint e[2];
	highp mat3x4 f;
	highp vec4 g;
	highp mat2x3 h;
	mediump uvec4 i[6];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_float((blockB.d), 5.0) && allOk;
	allOk = compare_uint((blockC.e[0]), 6u) && allOk;
	allOk = compare_uint((blockC.e[1]), 1u) && allOk;
	allOk = compare_vec4((blockC.g), vec4(-2.0, 1.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.h, mat2x3(-1.0, 9.0, -8.0, 7.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.c = (mat3x4(6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0, 9.0, 3.0, 1.0));
	blockB.d = (-6.0);
	blockC.e[0] = (8u);
	blockC.e[1] = (2u);
	blockC.f = (mat3x4(-6.0, 7.0, 5.0, -2.0, 9.0, 7.0, -2.0, 5.0, 3.0, -8.0, -7.0, 0.0));
	blockC.g = (vec4(-1.0, 5.0, 4.0, -9.0));
	blockC.h = (mat2x3(-1.0, 7.0, -7.0, -1.0, -1.0, 7.0));
}
#version 450
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
	bool a[];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a[0] = (true);
	a[1] = (true);
	a[2] = (true);
	a[3] = (true);
	a[4] = (false);
	a[5] = (false);
}
#version 450
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
	lowp mat4 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp uvec3 b;
	mediump vec4 c;
	highp mat2 d;
	lowp mat2x3 e;
};
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	lowp ivec3 f;
	highp uvec4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((c), vec4(8.0, 3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat2(d, mat2(1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(e, mat2x3(-1.0, -1.0, -7.0, 7.0, -4.0, -3.0)) && allOk;
	allOk = compare_ivec3((f), ivec3(1, -4, -9)) && allOk;
	allOk = compare_uvec4((g[0]), uvec4(1u, 3u, 5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0));
	c = (vec4(-6.0, -7.0, -7.0, -4.0));
	d = (mat2(8.0, 2.0, -9.0, 0.0));
}
#version 450
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
	lowp mat4x3 a[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	bool b[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0], mat4x3(0.0, 0.0, -2.0, 3.0, -3.0, -7.0, 3.0, 1.0, 3.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_bool((blockC.b[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x3(5.0, -5.0, -9.0, -5.0, -5.0, 2.0, 3.0, 0.0, -4.0, 9.0, -1.0, -8.0));
	blockC.b[0] = (false);
}
#version 450
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
struct sB
{
	mediump ivec2 mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp vec4 a;
	sA b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp ivec4 c;
	highp mat2x3 d;
	bvec3 e;
	lowp uvec2 f[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat2x3 g[3];
	highp mat3 h;
	highp mat4 i[];
} blockD[2];
layout(std140, binding = 4) buffer BlockE
{
	sB j;
	lowp mat3x4 k;
	bvec4 l;
	highp uvec4 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-7.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockC.f[0]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.f[1]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.f[2]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.f[3]), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat3(blockD[0].h, mat3(8.0, 9.0, -8.0, 2.0, 9.0, 1.0, 6.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[0], mat4(-6.0, -4.0, -1.0, 7.0, -9.0, -1.0, 5.0, 3.0, 9.0, -4.0, -3.0, -7.0, 9.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[1], mat4(-1.0, 8.0, -4.0, 1.0, 8.0, 4.0, 2.0, 1.0, 3.0, 5.0, -4.0, 7.0, 0.0, -7.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[2], mat4(3.0, -2.0, -4.0, -5.0, 6.0, -6.0, 5.0, -4.0, -6.0, -8.0, -5.0, 2.0, -5.0, 7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[3], mat4(8.0, 1.0, -8.0, -4.0, -4.0, -4.0, 5.0, -7.0, -4.0, -1.0, 6.0, -1.0, 1.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[4], mat4(-6.0, -3.0, 3.0, -2.0, -4.0, 8.0, -9.0, 5.0, -1.0, 8.0, -3.0, 9.0, 5.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[5], mat4(-5.0, 3.0, 3.0, -9.0, 7.0, 4.0, -6.0, -1.0, 8.0, -6.0, -2.0, 4.0, -2.0, -4.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[6], mat4(6.0, 5.0, 2.0, 7.0, 7.0, -5.0, -9.0, 4.0, 1.0, -5.0, 5.0, 4.0, -7.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4(blockD[0].i[7], mat4(-9.0, 0.0, -5.0, 7.0, 3.0, 8.0, -1.0, 9.0, 5.0, 7.0, -8.0, -7.0, -5.0, -7.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(blockD[1].h, mat3(-4.0, -1.0, -7.0, 8.0, 7.0, -1.0, -2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(blockD[1].i[0], mat4(6.0, 3.0, -1.0, 7.0, 8.0, 0.0, 2.0, 6.0, 9.0, 1.0, 9.0, 1.0, -7.0, 2.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(blockD[1].i[1], mat4(0.0, 8.0, -6.0, 9.0, 1.0, 0.0, 1.0, 5.0, 7.0, -8.0, -5.0, -5.0, 6.0, 8.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4(blockD[1].i[2], mat4(-9.0, 9.0, 0.0, 2.0, -7.0, 7.0, 8.0, 8.0, 6.0, 5.0, -5.0, -1.0, 1.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4(blockD[1].i[3], mat4(-7.0, -7.0, 7.0, -4.0, 5.0, 1.0, -1.0, 2.0, 4.0, 4.0, 2.0, 7.0, -5.0, 1.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD[1].i[4], mat4(-1.0, -3.0, -7.0, -4.0, -3.0, -3.0, -6.0, 3.0, 7.0, -3.0, -5.0, 7.0, -9.0, -6.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockE.j.mA), ivec2(0, -7)) && allOk;
	allOk = compare_mat3x4(blockE.k, mat3x4(-3.0, -6.0, -7.0, -4.0, -1.0, -1.0, -7.0, 3.0, -9.0, 3.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-6.0, -2.0, 3.0, -5.0));
	blockC.e = (bvec3(true, false, false));
	blockC.f[0] = (uvec2(2u, 2u));
	blockC.f[1] = (uvec2(2u, 1u));
	blockC.f[2] = (uvec2(7u, 4u));
	blockC.f[3] = (uvec2(1u, 1u));
	blockD[0].g[0] = (mat2x3(8.0, -8.0, -5.0, 1.0, 4.0, 3.0));
	blockD[0].g[1] = (mat2x3(-9.0, -3.0, 8.0, 5.0, 8.0, 1.0));
	blockD[0].g[2] = (mat2x3(8.0, 9.0, 2.0, 7.0, -2.0, -9.0));
	blockD[0].h = (mat3(-9.0, 7.0, 3.0, -9.0, 1.0, -8.0, -6.0, -7.0, 3.0));
	blockD[0].i[0] = (mat4(-6.0, 6.0, 6.0, 0.0, -2.0, 8.0, -8.0, -9.0, -9.0, -7.0, 9.0, -7.0, -8.0, 7.0, 4.0, -4.0));
	blockD[0].i[1] = (mat4(4.0, -1.0, 7.0, -1.0, 4.0, -8.0, -7.0, -7.0, 1.0, 4.0, -1.0, -7.0, 1.0, 2.0, -3.0, -4.0));
	blockD[0].i[2] = (mat4(-6.0, -3.0, 1.0, 8.0, 2.0, 1.0, -9.0, 9.0, -5.0, 1.0, 6.0, -9.0, 5.0, -2.0, -5.0, -8.0));
	blockD[0].i[3] = (mat4(4.0, 7.0, 4.0, 5.0, 5.0, -9.0, 3.0, 3.0, -7.0, 9.0, 5.0, 3.0, 3.0, -7.0, 2.0, 8.0));
	blockD[0].i[4] = (mat4(-5.0, 3.0, 2.0, 7.0, -3.0, -5.0, -2.0, 2.0, 8.0, 3.0, 9.0, -2.0, 5.0, -3.0, -1.0, -7.0));
	blockD[0].i[5] = (mat4(6.0, -9.0, 5.0, -1.0, -3.0, -1.0, -7.0, -7.0, 2.0, -8.0, 2.0, -5.0, -9.0, -2.0, 9.0, -4.0));
	blockD[0].i[6] = (mat4(-7.0, 5.0, 8.0, 2.0, -6.0, 0.0, 7.0, -4.0, 5.0, 1.0, 0.0, 4.0, -1.0, 7.0, 6.0, 6.0));
	blockD[0].i[7] = (mat4(-6.0, -7.0, 5.0, -1.0, -3.0, 9.0, 2.0, 7.0, 8.0, -3.0, 5.0, 9.0, -3.0, 1.0, 8.0, 6.0));
	blockD[1].g[0] = (mat2x3(-2.0, -5.0, -1.0, -2.0, 0.0, 7.0));
	blockD[1].g[1] = (mat2x3(7.0, 4.0, -1.0, 4.0, 9.0, 3.0));
	blockD[1].g[2] = (mat2x3(-6.0, 4.0, -9.0, 3.0, 9.0, 9.0));
	blockD[1].h = (mat3(-6.0, 6.0, 4.0, -2.0, -4.0, 8.0, -4.0, 3.0, 5.0));
	blockD[1].i[0] = (mat4(-8.0, 2.0, -2.0, -7.0, 6.0, -1.0, -7.0, 6.0, -1.0, 3.0, -5.0, 2.0, 9.0, 1.0, 3.0, -7.0));
	blockD[1].i[1] = (mat4(8.0, 7.0, -5.0, 3.0, 3.0, -8.0, -4.0, -2.0, 5.0, -5.0, -5.0, -8.0, 0.0, 9.0, -4.0, -2.0));
	blockD[1].i[2] = (mat4(8.0, -5.0, 9.0, 1.0, -7.0, -6.0, 8.0, 2.0, -7.0, -8.0, 1.0, 9.0, 3.0, 6.0, -4.0, 9.0));
	blockD[1].i[3] = (mat4(6.0, 0.0, -7.0, -7.0, -5.0, -8.0, -1.0, -9.0, -9.0, -2.0, 1.0, -8.0, -1.0, 2.0, 3.0, -7.0));
	blockD[1].i[4] = (mat4(-5.0, -8.0, -4.0, -2.0, 7.0, -3.0, -1.0, -1.0, 9.0, -9.0, -8.0, 7.0, 2.0, 0.0, -7.0, -1.0));
	blockE.m = (uvec4(2u, 2u, 7u, 6u));
}
#version 450
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
	highp ivec4 mA[2];
};
struct sB
{
	sA mA;
	bool mB;
	highp vec4 mC;
};
layout(std140, binding = 1) buffer BlockB
{
	highp mat2 a;
	highp int b;
	mediump mat3 c;
	mediump uvec2 d;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec3 e;
	bvec4 f;
	lowp uint g;
	sB h[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bool i;
	highp vec4 j;
	highp mat4x3 k;
	lowp float l;
	mediump vec3 m[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
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
	allOk = compare_mat2(blockB.a, mat2(-8.0, -8.0, 0.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(0u, 3u)) && allOk;
	allOk = compare_uint((blockC.g), 8u) && allOk;
	allOk = compare_ivec4((blockC.h[0].mA.mA[0]), ivec4(8, -7, -4, -7)) && allOk;
	allOk = compare_ivec4((blockC.h[0].mA.mA[1]), ivec4(-2, 2, 7, 8)) && allOk;
	allOk = compare_bool((blockC.h[0].mB), false) && allOk;
	allOk = compare_vec4((blockC.h[0].mC), vec4(-5.0, 7.0, 4.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC.h[1].mA.mA[0]), ivec4(-1, 5, 9, -1)) && allOk;
	allOk = compare_ivec4((blockC.h[1].mA.mA[1]), ivec4(5, -9, 2, 3)) && allOk;
	allOk = compare_bool((blockC.h[1].mB), false) && allOk;
	allOk = compare_vec4((blockC.h[1].mC), vec4(-2.0, 2.0, 2.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC.h[2].mA.mA[0]), ivec4(2, -3, -9, -2)) && allOk;
	allOk = compare_ivec4((blockC.h[2].mA.mA[1]), ivec4(5, -8, -9, -5)) && allOk;
	allOk = compare_bool((blockC.h[2].mB), false) && allOk;
	allOk = compare_vec4((blockC.h[2].mC), vec4(-4.0, 8.0, -2.0, -4.0)) && allOk;
	allOk = compare_bool((blockD.i), true) && allOk;
	allOk = compare_vec4((blockD.j), vec4(7.0, -2.0, -6.0, 6.0)) && allOk;
	allOk = compare_float((blockD.l), -3.0) && allOk;
	allOk = compare_vec3((blockD.m[0]), vec3(3.0, 7.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.m[1]), vec3(7.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD.m[2]), vec3(-1.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.m[3]), vec3(-2.0, -4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-2.0, -9.0, -3.0, -1.0));
	blockB.b = (-2);
	blockB.c = (mat3(7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0, 2.0, 6.0));
	blockC.f = (bvec4(false, false, false, false));
	blockC.g = (7u);
	blockC.h[0].mA.mA[0] = (ivec4(7, -8, -2, -6));
	blockC.h[0].mA.mA[1] = (ivec4(-3, 0, 7, -1));
	blockC.h[0].mB = (true);
	blockC.h[0].mC = (vec4(-5.0, 8.0, 8.0, -3.0));
	blockC.h[1].mA.mA[0] = (ivec4(-5, -8, 9, 7));
	blockC.h[1].mA.mA[1] = (ivec4(-9, -8, -4, 0));
	blockC.h[1].mB = (false);
	blockC.h[1].mC = (vec4(-1.0, 2.0, -2.0, 2.0));
	blockC.h[2].mA.mA[0] = (ivec4(-3, 9, 9, -2));
	blockC.h[2].mA.mA[1] = (ivec4(2, -6, 0, -6));
	blockC.h[2].mB = (false);
	blockC.h[2].mC = (vec4(-1.0, 7.0, -1.0, 3.0));
	blockD.i = (false);
	blockD.k = (mat4x3(-7.0, -9.0, -5.0, 9.0, 0.0, -7.0, 7.0, 7.0, 3.0, -6.0, -4.0, 5.0));
	blockD.m[0] = (vec3(-8.0, -9.0, -7.0));
	blockD.m[1] = (vec3(-4.0, -1.0, -2.0));
	blockD.m[2] = (vec3(-1.0, -8.0, 5.0));
	blockD.m[3] = (vec3(-6.0, 7.0, -5.0));
}
#version 450
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
	layout(offset = 0) bool a;
} blockB;

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
}
#version 450
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
	int16_t d[1];
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
	allOk = compare_uint((blockE.e), 9u) && allOk;
	allOk = compare_f16vec2(vec2(blockE.f), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec4((blockE.g), vec4(-2.0, -5.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockE.h, mat4x2(-7.0, -2.0, 9.0, 8.0, 9.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_uint((blockE.i), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0));
	b = f16vec2(vec2(-3.0, -1.0));
	d[0] = int16_t(-6);
	blockE.f = f16vec2(vec2(-2.0, 2.0));
	blockE.h = (mat4x2(5.0, -5.0, -2.0, -2.0, 8.0, -3.0, -3.0, -8.0));
	blockE.i = (9u);
}
#version 450
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
	u16vec3 a;
	lowp mat3 b;
	int16_t c[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	u16vec3 d;
	int16_t e;
	mediump int f;
	f16vec2 g[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	i16vec4 h;
	bool i;
	mediump mat4x2 j;
	lowp mat2 k[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp vec3 l;
	f16vec2 m;
	lowp vec2 n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.c[0]), -2) && allOk;
	allOk = compare_int16_t(int(blockB.c[1]), 0) && allOk;
	allOk = compare_int16_t(int(blockB.c[2]), 9) && allOk;
	allOk = compare_int16_t(int(blockB.c[3]), -1) && allOk;
	allOk = compare_int16_t(int(blockB.c[4]), -9) && allOk;
	allOk = compare_int16_t(int(blockB.c[5]), -6) && allOk;
	allOk = compare_int16_t(int(blockB.c[6]), -9) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.d), uvec3(6u, 1u, 6u)) && allOk;
	allOk = compare_int16_t(int(blockC.e), 0) && allOk;
	allOk = compare_int((blockC.f), 2) && allOk;
	allOk = compare_mat4x2(j, mat4x2(6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(k[0], mat2(3.0, -3.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(k[1], mat2(-8.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(k[2], mat2(3.0, 3.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(k[3], mat2(1.0, 9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(k[4], mat2(8.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(k[5], mat2(-1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(k[6], mat2(1.0, 1.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec2((blockE.n[0]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((blockE.n[1]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec2((blockE.n[2]), vec2(-7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(4u, 4u, 9u));
	blockB.c[0] = int16_t(4);
	blockB.c[1] = int16_t(1);
	blockB.c[2] = int16_t(-2);
	blockB.c[3] = int16_t(-8);
	blockB.c[4] = int16_t(-6);
	blockB.c[5] = int16_t(9);
	blockB.c[6] = int16_t(4);
	blockC.d = u16vec3(uvec3(6u, 3u, 2u));
	blockC.e = int16_t(4);
	blockC.f = (-7);
	blockC.g[0] = f16vec2(vec2(5.0, -6.0));
	blockC.g[1] = f16vec2(vec2(4.0, -3.0));
	blockC.g[2] = f16vec2(vec2(9.0, 0.0));
	blockC.g[3] = f16vec2(vec2(-8.0, 6.0));
	blockC.g[4] = f16vec2(vec2(-8.0, -7.0));
	blockC.g[5] = f16vec2(vec2(-2.0, 5.0));
	h = i16vec4(ivec4(1, 3, -3, -1));
	i = (true);
	j = (mat4x2(-5.0, -4.0, -2.0, 8.0, -7.0, 4.0, 0.0, 7.0));
	k[0] = (mat2(2.0, -4.0, 1.0, 6.0));
	k[1] = (mat2(-2.0, 5.0, 7.0, -9.0));
	k[2] = (mat2(-4.0, 7.0, -9.0, 7.0));
	k[3] = (mat2(7.0, -8.0, 5.0, -2.0));
	k[4] = (mat2(-3.0, -9.0, 7.0, -4.0));
	k[5] = (mat2(-6.0, 3.0, -7.0, -4.0));
	k[6] = (mat2(2.0, -4.0, -3.0, 3.0));
	blockE.n[0] = (vec2(-6.0, 7.0));
	blockE.n[1] = (vec2(1.0, 9.0));
	blockE.n[2] = (vec2(-1.0, -8.0));
}
#version 450
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
	highp mat3x4 a;
	bvec3 b;
	bool c;
	u16vec4 d;
	lowp vec4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(2.0, 7.0, -9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0)) && allOk;
	allOk = compare_bvec3((b), bvec3(true, true, false)) && allOk;
	allOk = compare_bool((c), true) && allOk;
	allOk = compare_vec4((e[0]), vec4(2.0, 5.0, 6.0, 4.0)) && allOk;
	allOk = compare_vec4((e[1]), vec4(1.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_vec4((e[2]), vec4(2.0, -7.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec4((e[3]), vec4(-9.0, -8.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((e[4]), vec4(9.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4((e[5]), vec4(-7.0, 8.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(8.0, 9.0, -5.0, 5.0, -4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0));
	b = (bvec3(false, false, true));
	c = (true);
	d = u16vec4(uvec4(6u, 6u, 3u, 2u));
	e[0] = (vec4(4.0, -7.0, 5.0, -6.0));
	e[1] = (vec4(4.0, -3.0, 9.0, 0.0));
	e[2] = (vec4(-8.0, 6.0, -8.0, -7.0));
	e[3] = (vec4(-2.0, 5.0, 1.0, 3.0));
	e[4] = (vec4(-3.0, -1.0, 1.0, -6.0));
	e[5] = (vec4(-5.0, -4.0, -2.0, 8.0));
}
#version 450
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
	i16vec2 a[];
} blockB;

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a[0]), ivec2(-9, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec2(ivec2(-9, -3));
}
#version 450
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
	sA mA;
	f16vec3 mB;
	f16vec4 mC;
	f16vec3 mD;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	float16_t a;
	f16vec2 b[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	sB c;
	bool d;
	f16vec2 e[3][1];
	int16_t f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 0.0) && allOk;
	allOk = compare_f16vec3(vec3(blockC.c.mA.mA), vec3(2.0, 8.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.c.mB), vec3(-2.0, 4.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c.mC), vec4(-2.0, -1.0, 1.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.c.mD), vec3(-6.0, 3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e[0][0]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e[1][0]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e[2][0]), vec2(-2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(6.0);
	blockB.b[0] = f16vec2(vec2(3.0, -9.0));
	blockB.b[1] = f16vec2(vec2(0.0, 9.0));
	blockB.b[2] = f16vec2(vec2(2.0, -6.0));
	blockB.b[3] = f16vec2(vec2(6.0, -6.0));
	blockC.c.mA.mA = f16vec3(vec3(3.0, 5.0, -8.0));
	blockC.c.mB = f16vec3(vec3(-7.0, -8.0, 3.0));
	blockC.c.mC = f16vec4(vec4(-6.0, -9.0, 9.0, -9.0));
	blockC.c.mD = f16vec3(vec3(9.0, 8.0, -1.0));
	blockC.e[0][0] = f16vec2(vec2(-4.0, 2.0));
	blockC.e[1][0] = f16vec2(vec2(1.0, 2.0));
	blockC.e[2][0] = f16vec2(vec2(9.0, -3.0));
	blockC.f = int16_t(-2);
}
#version 450
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
	float16_t a[2];
	highp vec2 b;
	bvec2 c;
};
layout(std140, binding = 2) buffer BlockC
{
	f16vec3 d;
	highp mat2 e;
	float16_t f[2];
	mediump mat3x4 g;
	mediump ivec4 h[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((c), bvec2(false, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].d), vec3(-4.0, 0.0, -2.0)) && allOk;
	allOk = compare_float16_t(float(blockC[0].f[0]), -6.0) && allOk;
	allOk = compare_float16_t(float(blockC[0].f[1]), 9.0) && allOk;
	allOk = compare_mat3x4(blockC[0].g, mat3x4(8.0, 3.0, 7.0, 5.0, -6.0, 5.0, -9.0, -2.0, 4.0, -1.0, -1.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].h[0]), ivec4(2, -6, 8, -7)) && allOk;
	allOk = compare_ivec4((blockC[0].h[1]), ivec4(-4, -7, -2, 2)) && allOk;
	allOk = compare_ivec4((blockC[0].h[2]), ivec4(7, 8, -1, 5)) && allOk;
	allOk = compare_ivec4((blockC[0].h[3]), ivec4(9, -1, 5, -9)) && allOk;
	allOk = compare_ivec4((blockC[0].h[4]), ivec4(2, 3, 2, -3)) && allOk;
	allOk = compare_ivec4((blockC[0].h[5]), ivec4(-9, -2, 5, -8)) && allOk;
	allOk = compare_ivec4((blockC[0].h[6]), ivec4(-9, -5, -1, 5)) && allOk;
	allOk = compare_ivec4((blockC[0].h[7]), ivec4(8, -5, 7, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = float16_t(-2.0);
	a[1] = float16_t(-9.0);
	c = (bvec2(true, true));
	blockC[0].d = f16vec3(vec3(-5.0, -9.0, 4.0));
	blockC[0].e = (mat2(-6.0, 2.0, 6.0, 4.0));
	blockC[0].f[0] = float16_t(6.0);
	blockC[0].f[1] = float16_t(-5.0);
	blockC[0].g = (mat3x4(2.0, -9.0, -8.0, 3.0, 6.0, -6.0, 5.0, 6.0, -6.0, 3.0, 7.0, -8.0));
}
#version 450
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
	u16vec3 a;
	highp uvec4 b;
	lowp ivec3 c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump mat4x2 d;
	lowp uvec2 e[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp vec2 f;
	mediump mat4 g;
	mediump vec3 h[];
} blockD[1];
layout(std140, binding = 4) buffer BlockE
{
	mediump mat3 i;
	highp mat2 j;
	mediump uvec2 k;
	float16_t l[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockD[0].f), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].h[0]), vec3(-9.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2(blockE[0].j, mat2(5.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec2((blockE[0].k), uvec2(3u, 3u)) && allOk;
	allOk = compare_float16_t(float(blockE[0].l[0]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockE[0].l[1]), -7.0) && allOk;
	allOk = compare_float16_t(float(blockE[0].l[2]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockE[0].l[3]), 2.0) && allOk;
	allOk = compare_mat2(blockE[1].j, mat2(-6.0, 2.0, -3.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockE[1].k), uvec2(5u, 4u)) && allOk;
	allOk = compare_float16_t(float(blockE[1].l[0]), 0.0) && allOk;
	allOk = compare_float16_t(float(blockE[1].l[1]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockE[1].l[2]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockE[1].l[3]), 2.0) && allOk;
	allOk = compare_mat2(blockE[2].j, mat2(-6.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockE[2].k), uvec2(5u, 6u)) && allOk;
	allOk = compare_float16_t(float(blockE[2].l[0]), -8.0) && allOk;
	allOk = compare_float16_t(float(blockE[2].l[1]), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(0u, 4u, 9u));
	blockB.c[0] = (ivec3(-6, 5, 2));
	d = (mat4x2(1.0, -1.0, -7.0, -8.0, -8.0, -5.0, 1.0, -3.0));
	e[0] = (uvec2(5u, 0u));
	e[1] = (uvec2(8u, 3u));
	e[2] = (uvec2(5u, 3u));
	e[3] = (uvec2(2u, 5u));
	blockD[0].f = (vec2(9.0, 1.0));
	blockD[0].g = (mat4(0.0, 9.0, 7.0, 9.0, 1.0, 6.0, 4.0, 3.0, 1.0, -4.0, -7.0, -7.0, 8.0, -8.0, 4.0, 0.0));
	blockE[0].j = (mat2(7.0, -3.0, -4.0, -3.0));
	blockE[0].k = (uvec2(8u, 8u));
	blockE[0].l[0] = float16_t(7.0);
	blockE[0].l[1] = float16_t(-9.0);
	blockE[0].l[2] = float16_t(-2.0);
	blockE[0].l[3] = float16_t(1.0);
	blockE[1].j = (mat2(5.0, 7.0, -9.0, -8.0));
	blockE[1].k = (uvec2(3u, 3u));
	blockE[1].l[0] = float16_t(-7.0);
	blockE[1].l[1] = float16_t(-1.0);
	blockE[1].l[2] = float16_t(7.0);
	blockE[1].l[3] = float16_t(-9.0);
	blockE[2].j = (mat2(6.0, 2.0, -6.0, -5.0));
	blockE[2].k = (uvec2(6u, 6u));
	blockE[2].l[0] = float16_t(2.0);
	blockE[2].l[1] = float16_t(-5.0);
}
#version 450
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
	layout(offset = 0) i16vec4 a;
	layout(offset = 8) uint16_t b;
	layout(offset = 12) highp int c;
	layout(offset = 16) lowp uvec4 d[1];
	layout(offset = 32) uint16_t e;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(b), 6u) && allOk;
	allOk = compare_int((c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec4(ivec4(-6, -9, 9, 5));
	b = uint16_t(2u);
	d[0] = (uvec4(2u, 2u, 0u, 7u));
	e = uint16_t(9u);
}
#version 450
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
	bvec3 mB;
};
struct sB
{
	u16vec4 mA;
	highp mat3 mB;
	int16_t mC;
	f16vec3 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a[][3][7];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	f16vec3 b;
	i16vec4 c;
	sB d[3];
	highp mat2 e[];
};
layout(scalar, binding = 3) readonly buffer BlockD
{
	bvec2 f[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump uvec4 g;
	lowp vec2 h;
	i16vec4 i[3];
	bool j[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(b), vec3(6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(e[0], mat2(0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(e[1], mat2(0.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(e[2], mat2(-8.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2(e[3], mat2(-1.0, 1.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec2((blockE[0].h), vec2(-7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0][0].mA = (ivec2(5, 6));
	blockB.a[0][0][0].mB = (bvec3(false, true, true));
	blockB.a[0][0][1].mA = (ivec2(-2, 4));
	blockB.a[0][0][1].mB = (bvec3(true, true, true));
	blockB.a[0][0][2].mA = (ivec2(-3, 1));
	blockB.a[0][0][2].mB = (bvec3(false, true, true));
	blockB.a[0][0][3].mA = (ivec2(4, 9));
	blockB.a[0][0][3].mB = (bvec3(false, false, true));
	blockB.a[0][0][4].mA = (ivec2(4, -3));
	blockB.a[0][0][4].mB = (bvec3(false, true, true));
	blockB.a[0][0][5].mA = (ivec2(1, 2));
	blockB.a[0][0][5].mB = (bvec3(true, true, false));
	blockB.a[0][0][6].mA = (ivec2(3, -2));
	blockB.a[0][0][6].mB = (bvec3(false, false, false));
	blockB.a[0][1][0].mA = (ivec2(-3, -6));
	blockB.a[0][1][0].mB = (bvec3(true, false, false));
	blockB.a[0][1][1].mA = (ivec2(-1, 4));
	blockB.a[0][1][1].mB = (bvec3(true, true, true));
	blockB.a[0][1][2].mA = (ivec2(2, 7));
	blockB.a[0][1][2].mB = (bvec3(true, false, false));
	blockB.a[0][1][3].mA = (ivec2(0, -1));
	blockB.a[0][1][3].mB = (bvec3(true, false, true));
	blockB.a[0][1][4].mA = (ivec2(-8, 8));
	blockB.a[0][1][4].mB = (bvec3(true, true, true));
	blockB.a[0][1][5].mA = (ivec2(3, -3));
	blockB.a[0][1][5].mB = (bvec3(false, false, true));
	blockB.a[0][1][6].mA = (ivec2(7, -4));
	blockB.a[0][1][6].mB = (bvec3(false, false, false));
	blockB.a[0][2][0].mA = (ivec2(-2, 9));
	blockB.a[0][2][0].mB = (bvec3(false, true, false));
	blockB.a[0][2][1].mA = (ivec2(-4, 4));
	blockB.a[0][2][1].mB = (bvec3(false, true, true));
	blockB.a[0][2][2].mA = (ivec2(3, -9));
	blockB.a[0][2][2].mB = (bvec3(true, false, false));
	blockB.a[0][2][3].mA = (ivec2(0, -4));
	blockB.a[0][2][3].mB = (bvec3(false, true, false));
	blockB.a[0][2][4].mA = (ivec2(1, 3));
	blockB.a[0][2][4].mB = (bvec3(true, false, true));
	blockB.a[0][2][5].mA = (ivec2(-3, 0));
	blockB.a[0][2][5].mB = (bvec3(false, false, false));
	blockB.a[0][2][6].mA = (ivec2(-7, -5));
	blockB.a[0][2][6].mB = (bvec3(true, false, false));
	b = f16vec3(vec3(-4.0, 0.0, -1.0));
	blockE[0].g = (uvec4(9u, 9u, 8u, 5u));
	blockE[0].i[0] = i16vec4(ivec4(9, 8, -1, -4));
	blockE[0].i[1] = i16vec4(ivec4(4, -9, 3, 8));
	blockE[0].i[2] = i16vec4(ivec4(-6, 8, 6, 4));
}
#version 450
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
	highp mat4x3 a;
	bool b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((b), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x3(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0));
}
#version 450
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
	lowp mat3x4 a;
	bool b;
	highp int c;
} blockB;
layout(std430, row_major, binding = 2) readonly buffer BlockC
{
	lowp int d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), -7) && allOk;
	allOk = compare_int((d[0]), 7) && allOk;
	allOk = compare_int((d[1]), -4) && allOk;
	allOk = compare_int((d[2]), 8) && allOk;
	allOk = compare_int((d[3]), -1) && allOk;
	allOk = compare_int((d[4]), 2) && allOk;
	allOk = compare_int((d[5]), 0) && allOk;
	allOk = compare_int((d[6]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0));
	blockB.c = (7);
}
#version 450
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
	mediump ivec2 a;
	i8vec4 b[];
};
layout(std430, row_major, binding = 2) readonly buffer BlockC
{
	mediump mat2x3 c[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	uint8_t d;
	mediump mat4x3 e;
	lowp int f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(b[0]), ivec4(0, 4294967287, 4294967295, 4)) && allOk;
	allOk = compare_mat4x3(e, mat4x3(-6.0, 7.0, -9.0, 9.0, 5.0, -2.0, 8.0, -6.0, 4.0, 3.0, 5.0, -1.0)) && allOk;
	allOk = compare_int((f[0]), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	d = uint8_t(2u);
	e = (mat4x3(6.0, 2.0, 6.0, 4.0, -9.0, -6.0, 6.0, -8.0, 5.0, -5.0, 3.0, 6.0));
	f[0] = (-6);
}
#version 450
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
	bvec3 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b[0]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec3(true, true, true));
}
#version 450
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
	highp ivec4 a;
	mediump vec2 b[6];
	u8vec4 c;
	lowp vec4 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(6, 8, 8, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (vec2(-6.0, 6.0));
	b[1] = (vec2(-6.0, 3.0));
	b[2] = (vec2(-7.0, 8.0));
	b[3] = (vec2(5.0, -6.0));
	b[4] = (vec2(-7.0, -2.0));
	b[5] = (vec2(2.0, 3.0));
	c = u8vec4(uvec4(7u, 9u, 9u, 7u));
}
#version 450
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
	u8vec2 mB;
	lowp uint mC;
};
struct sB
{
	sA mA;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump ivec3 a[2];
	u8vec4 b;
	sB c;
	mediump mat3x2 d;
	i8vec4 e[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[0].a[0]), ivec3(-5, -9, -7)) && allOk;
	allOk = compare_ivec3((blockB[0].a[1]), ivec3(9, -1, 0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b), uvec4(7u, 4u, 7u, 2u)) && allOk;
	allOk = compare_mat3x2(blockB[0].d, mat3x2(8.0, 5.0, -7.0, -3.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (ivec3(-7, 4, -4));
	blockB[0].a[1] = (ivec3(-7, -3, -9));
	blockB[0].b = u8vec4(uvec4(3u, 5u, 1u, 6u));
	blockB[0].d = (mat3x2(1.0, 2.0, -4.0, -6.0, 7.0, 1.0));
}
#version 450
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
	highp mat3x2 a;
	u8vec3 b;
	bvec4 c[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	u8vec4 d[5];
	lowp mat4x2 e[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	u8vec2 f;
	bvec3 g;
	i8vec4 h;
	highp ivec4 i[][7];
} blockD[3];
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump int j;
	highp vec2 k;
	highp uvec3 l;
	mediump ivec2 m;
	mediump mat4x3 n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(3.0, -9.0, -9.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB.c[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[3]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.c[4]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.c[5]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat4x2(e[0], mat4x2(9.0, 0.0, -6.0, -9.0, 5.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(e[1], mat4x2(-3.0, -5.0, 2.0, 8.0, 0.0, 6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x2(e[2], mat4x2(9.0, -3.0, 8.0, 2.0, -3.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(e[3], mat4x2(-6.0, -6.0, -6.0, -1.0, -7.0, -9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(e[4], mat4x2(-7.0, 3.0, 7.0, 4.0, 1.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(e[5], mat4x2(4.0, 3.0, 0.0, -7.0, -8.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(e[6], mat4x2(1.0, 5.0, 3.0, 1.0, 6.0, 4.0, 8.0, 3.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].f), uvec2(7u, 2u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].h), ivec4(1, 4294967292, 4294967290, 8)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0][0]), ivec4(-9, 0, 0, 7)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0][1]), ivec4(-3, 6, -7, -8)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0][2]), ivec4(0, 0, -5, -4)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0][3]), ivec4(-3, -1, -1, 7)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0][4]), ivec4(3, -5, 3, 9)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0][5]), ivec4(7, 8, -3, 3)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0][6]), ivec4(8, 9, 1, -5)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1][0]), ivec4(4, -8, -9, -5)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1][1]), ivec4(6, -4, -9, 3)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1][2]), ivec4(-6, 9, -4, 7)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1][3]), ivec4(-7, -6, 0, 2)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1][4]), ivec4(5, 1, 9, -4)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1][5]), ivec4(-6, 0, -5, -3)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1][6]), ivec4(-7, -4, -4, 0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].f), uvec2(9u, 5u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].h), ivec4(6, 4294967294, 4, 4294967288)) && allOk;
	allOk = compare_ivec4((blockD[1].i[0][0]), ivec4(-1, -6, 7, 8)) && allOk;
	allOk = compare_ivec4((blockD[1].i[0][1]), ivec4(-8, 0, 1, 9)) && allOk;
	allOk = compare_ivec4((blockD[1].i[0][2]), ivec4(3, 4, -4, -2)) && allOk;
	allOk = compare_ivec4((blockD[1].i[0][3]), ivec4(-7, 2, -2, -6)) && allOk;
	allOk = compare_ivec4((blockD[1].i[0][4]), ivec4(-8, -2, -7, -9)) && allOk;
	allOk = compare_ivec4((blockD[1].i[0][5]), ivec4(0, 9, -2, 7)) && allOk;
	allOk = compare_ivec4((blockD[1].i[0][6]), ivec4(-1, -9, -8, 5)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].f), uvec2(7u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[2].h), ivec4(1, 2, 9, 4294967293)) && allOk;
	allOk = compare_ivec4((blockD[2].i[0][0]), ivec4(-8, -8, 4, 0)) && allOk;
	allOk = compare_ivec4((blockD[2].i[0][1]), ivec4(9, 0, 0, -1)) && allOk;
	allOk = compare_ivec4((blockD[2].i[0][2]), ivec4(-9, -4, -9, 8)) && allOk;
	allOk = compare_ivec4((blockD[2].i[0][3]), ivec4(6, -9, 8, 1)) && allOk;
	allOk = compare_ivec4((blockD[2].i[0][4]), ivec4(-4, 6, 8, 7)) && allOk;
	allOk = compare_ivec4((blockD[2].i[0][5]), ivec4(-9, -8, -5, 5)) && allOk;
	allOk = compare_ivec4((blockD[2].i[0][6]), ivec4(5, -2, -1, -8)) && allOk;
	allOk = compare_ivec4((blockD[2].i[1][0]), ivec4(1, 1, 3, -5)) && allOk;
	allOk = compare_ivec4((blockD[2].i[1][1]), ivec4(3, -9, -1, -6)) && allOk;
	allOk = compare_ivec4((blockD[2].i[1][2]), ivec4(3, -3, 2, -9)) && allOk;
	allOk = compare_ivec4((blockD[2].i[1][3]), ivec4(9, 5, 3, 9)) && allOk;
	allOk = compare_ivec4((blockD[2].i[1][4]), ivec4(-7, 4, 0, 4)) && allOk;
	allOk = compare_ivec4((blockD[2].i[1][5]), ivec4(9, 4, 5, -4)) && allOk;
	allOk = compare_ivec4((blockD[2].i[1][6]), ivec4(9, 2, 2, 4)) && allOk;
	allOk = compare_vec2((blockE.k), vec2(6.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockE.n, mat4x3(-7.0, -6.0, 6.0, 3.0, 6.0, 0.0, -7.0, -3.0, 6.0, -3.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-1.0, -9.0, -2.0, -6.0, 8.0, 0.0));
	blockB.b = u8vec3(uvec3(5u, 6u, 5u));
	d[0] = u8vec4(uvec4(3u, 9u, 9u, 6u));
	d[1] = u8vec4(uvec4(8u, 8u, 6u, 9u));
	d[2] = u8vec4(uvec4(8u, 8u, 1u, 7u));
	d[3] = u8vec4(uvec4(7u, 8u, 8u, 1u));
	d[4] = u8vec4(uvec4(4u, 5u, 0u, 7u));
	e[0] = (mat4x2(1.0, -5.0, 2.0, 6.0, -2.0, -5.0, 4.0, -4.0));
	e[1] = (mat4x2(5.0, 7.0, -9.0, -8.0, -5.0, -3.0, -7.0, -1.0));
	e[2] = (mat4x2(7.0, -9.0, -6.0, -1.0, 0.0, -1.0, 9.0, -6.0));
	e[3] = (mat4x2(0.0, -7.0, -5.0, 6.0, 2.0, -6.0, -5.0, -5.0));
	e[4] = (mat4x2(-1.0, 2.0, -5.0, -1.0, 9.0, -9.0, 4.0, -3.0));
	e[5] = (mat4x2(-2.0, 6.0, -3.0, -7.0, 9.0, 1.0, 4.0, -9.0));
	e[6] = (mat4x2(6.0, 9.0, 0.0, 8.0, -6.0, -3.0, -7.0, 2.0));
	blockD[0].f = u8vec2(uvec2(8u, 3u));
	blockD[0].h = i8vec4(ivec4(0, 1, 5, 2));
	blockD[0].i[0][0] = (ivec4(-3, -6, 7, -5));
	blockD[0].i[0][1] = (ivec4(6, 1, 5, -1));
	blockD[0].i[0][2] = (ivec4(-1, -9, 7, 4));
	blockD[0].i[0][3] = (ivec4(-4, 4, -4, 7));
	blockD[0].i[0][4] = (ivec4(4, 8, -6, 3));
	blockD[0].i[0][5] = (ivec4(1, 6, 2, -1));
	blockD[0].i[0][6] = (ivec4(5, -3, 7, -2));
	blockD[0].i[1][0] = (ivec4(-3, -4, 0, 9));
	blockD[0].i[1][1] = (ivec4(9, -8, -6, 2));
	blockD[0].i[1][2] = (ivec4(4, 3, -1, -6));
	blockD[0].i[1][3] = (ivec4(-8, 7, 1, -1));
	blockD[0].i[1][4] = (ivec4(-9, 7, -9, -6));
	blockD[0].i[1][5] = (ivec4(-1, 1, -8, 4));
	blockD[0].i[1][6] = (ivec4(-1, 6, -3, 5));
	blockD[1].f = u8vec2(uvec2(3u, 2u));
	blockD[1].h = i8vec4(ivec4(4294967291, 4294967292, 4294967290, 4294967295));
	blockD[1].i[0][0] = (ivec4(3, 0, -1, -4));
	blockD[1].i[0][1] = (ivec4(4, 9, 1, 6));
	blockD[1].i[0][2] = (ivec4(6, 5, 4, -6));
	blockD[1].i[0][3] = (ivec4(8, 0, -2, 3));
	blockD[1].i[0][4] = (ivec4(5, 4, 0, 6));
	blockD[1].i[0][5] = (ivec4(6, 2, -7, 5));
	blockD[1].i[0][6] = (ivec4(7, -9, -5, 0));
	blockD[2].f = u8vec2(uvec2(3u, 5u));
	blockD[2].h = i8vec4(ivec4(4294967289, 4294967292, 4294967288, 4294967288));
	blockD[2].i[0][0] = (ivec4(7, -4, -4, 4));
	blockD[2].i[0][1] = (ivec4(-5, 6, -7, 1));
	blockD[2].i[0][2] = (ivec4(4, 3, -7, -7));
	blockD[2].i[0][3] = (ivec4(9, -4, 9, -2));
	blockD[2].i[0][4] = (ivec4(7, -3, -8, -6));
	blockD[2].i[0][5] = (ivec4(-2, -3, 2, -2));
	blockD[2].i[0][6] = (ivec4(-1, 0, 5, -5));
	blockD[2].i[1][0] = (ivec4(5, -9, -3, 5));
	blockD[2].i[1][1] = (ivec4(-4, -4, -7, 9));
	blockD[2].i[1][2] = (ivec4(6, -8, 1, 1));
	blockD[2].i[1][3] = (ivec4(9, 6, -4, 2));
	blockD[2].i[1][4] = (ivec4(-6, -3, 0, 8));
	blockD[2].i[1][5] = (ivec4(-3, 0, -9, 2));
	blockD[2].i[1][6] = (ivec4(0, -2, -7, -6));
	blockE.j = (-2);
	blockE.k = (vec2(-2.0, -8.0));
	blockE.l = (uvec3(2u, 3u, 9u));
}
#version 450
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
	int8_t a;
	bvec3 b[][8];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	i8vec4 c[];
} blockC[3];

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a), 4) && allOk;
	allOk = compare_bvec3((blockB.b[0][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[0][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.b[0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[0][3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[0][4]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[0][5]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[0][6]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.b[0][7]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.b[1][2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.b[1][3]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.b[1][4]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.b[1][5]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB.b[1][6]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[1][7]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.b[2][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.b[2][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[2][2]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[2][3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[2][4]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[2][5]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[2][6]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[2][7]), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0][0] = (bvec3(true, false, false));
	blockB.b[0][1] = (bvec3(true, true, false));
	blockB.b[0][2] = (bvec3(true, false, false));
	blockB.b[0][3] = (bvec3(false, true, false));
	blockB.b[0][4] = (bvec3(false, false, false));
	blockB.b[0][5] = (bvec3(true, false, true));
	blockB.b[0][6] = (bvec3(true, false, false));
	blockB.b[0][7] = (bvec3(true, true, true));
	blockB.b[1][0] = (bvec3(false, true, true));
	blockB.b[1][1] = (bvec3(true, false, false));
	blockB.b[1][2] = (bvec3(false, false, false));
	blockB.b[1][3] = (bvec3(false, false, false));
	blockB.b[1][4] = (bvec3(true, false, true));
	blockB.b[1][5] = (bvec3(false, false, true));
	blockB.b[1][6] = (bvec3(true, false, false));
	blockB.b[1][7] = (bvec3(true, true, true));
	blockB.b[2][0] = (bvec3(false, true, false));
	blockB.b[2][1] = (bvec3(false, false, false));
	blockB.b[2][2] = (bvec3(false, true, false));
	blockB.b[2][3] = (bvec3(false, false, false));
	blockB.b[2][4] = (bvec3(true, true, false));
	blockB.b[2][5] = (bvec3(true, true, false));
	blockB.b[2][6] = (bvec3(true, false, false));
	blockB.b[2][7] = (bvec3(false, false, false));
	blockC[0].c[0] = i8vec4(ivec4(3, 8, 4294967289, 2));
	blockC[0].c[1] = i8vec4(ivec4(8, 4294967292, 1, 4294967289));
	blockC[0].c[2] = i8vec4(ivec4(6, 4294967294, 4294967292, 7));
	blockC[0].c[3] = i8vec4(ivec4(4294967287, 1, 4294967287, 4294967289));
	blockC[0].c[4] = i8vec4(ivec4(4294967289, 4294967289, 4294967295, 4294967291));
	blockC[0].c[5] = i8vec4(ivec4(4294967291, 4294967287, 4, 4294967289));
	blockC[0].c[6] = i8vec4(ivec4(3, 4294967290, 4294967290, 3));
	blockC[1].c[0] = i8vec4(ivec4(4294967291, 4294967293, 2, 7));
	blockC[1].c[1] = i8vec4(ivec4(5, 3, 4, 4294967295));
	blockC[2].c[0] = i8vec4(ivec4(4294967293, 4294967289, 4294967290, 6));
	blockC[2].c[1] = i8vec4(ivec4(6, 2, 4294967289, 7));
}
#version 450
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
	highp mat3x2 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump mat4x2 a[5];
	highp float b;
	u8vec2 c;
	highp int d;
	bvec3 e[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	i8vec4 f;
	bvec3 g;
	sA h[7];
	lowp mat2x3 i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.c), uvec2(7u, 5u)) && allOk;
	allOk = compare_bvec3((blockB.e[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.e[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2x3(blockC.i, mat2x3(4.0, -2.0, 7.0, 5.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(-8.0, -4.0, -7.0, 2.0, -2.0, 1.0, 6.0, -8.0));
	blockB.a[1] = (mat4x2(6.0, -1.0, -9.0, 3.0, -6.0, 4.0, -7.0, 6.0));
	blockB.a[2] = (mat4x2(-5.0, -4.0, 8.0, -7.0, 4.0, -3.0, -3.0, 5.0));
	blockB.a[3] = (mat4x2(6.0, 7.0, -8.0, 3.0, 9.0, 9.0, 5.0, 6.0));
	blockB.a[4] = (mat4x2(5.0, -3.0, -9.0, 7.0, -2.0, -9.0, 9.0, 0.0));
	blockB.b = (-6.0);
	blockB.d = (-2);
	blockB.e[0] = (bvec3(true, false, false));
	blockB.e[1] = (bvec3(false, false, true));
	blockC.g = (bvec3(false, true, true));
}
#version 450
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
	layout(offset = 0) i8vec2 a;
	layout(offset = 2) i8vec2 b;
	layout(offset = 4) int8_t c;
	layout(offset = 6) u8vec2 d[1];
	layout(offset = 16) mediump ivec3 e[1];
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump float f;
	layout(offset = 4) i8vec3 g;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec2 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a), ivec2(7, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].b), ivec2(4294967287, 4)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].d[0]), uvec2(2u, 0u)) && allOk;
	allOk = compare_float((f), 7.0) && allOk;
	allOk = compare_i8vec3(ivec3(g), ivec3(5, 4294967291, 8)) && allOk;
	allOk = compare_u8vec2(uvec2(h), uvec2(8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec2(ivec2(4294967295, 1));
	blockB[0].b = i8vec2(ivec2(4294967295, 8));
	blockB[0].c = int8_t(9);
	blockB[0].d[0] = u8vec2(uvec2(3u, 3u));
	blockB[0].e[0] = (ivec3(9, -9, 3));
	f = (-8.0);
	g = i8vec3(ivec3(4294967287, 4294967292, 4294967293));
	h = u8vec2(uvec2(4u, 6u));
}
#version 450
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
	bvec2 mB;
	bvec2 mC;
};
struct sB
{
	sA mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	sB a[];
} blockB[3];
layout(scalar, column_major, binding = 2) readonly buffer BlockC
{
	i8vec4 b[];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(b[0]), ivec4(4294967293, 4294967293, 5, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(b[1]), ivec4(4294967294, 2, 8, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(b[2]), ivec4(4, 4294967290, 4294967295, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(b[3]), ivec4(0, 4294967288, 4294967291, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(b[4]), ivec4(4294967287, 0, 9, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0].mA.mA = (uvec4(4u, 4u, 9u, 1u));
	blockB[0].a[0].mA.mB = (bvec2(false, false));
	blockB[0].a[0].mA.mC = (bvec2(false, false));
	blockB[0].a[1].mA.mA = (uvec4(5u, 2u, 9u, 4u));
	blockB[0].a[1].mA.mB = (bvec2(false, true));
	blockB[0].a[1].mA.mC = (bvec2(true, false));
	blockB[0].a[2].mA.mA = (uvec4(7u, 6u, 5u, 3u));
	blockB[0].a[2].mA.mB = (bvec2(false, false));
	blockB[0].a[2].mA.mC = (bvec2(false, false));
	blockB[0].a[3].mA.mA = (uvec4(9u, 8u, 8u, 8u));
	blockB[0].a[3].mA.mB = (bvec2(true, true));
	blockB[0].a[3].mA.mC = (bvec2(false, true));
	blockB[0].a[4].mA.mA = (uvec4(0u, 8u, 6u, 6u));
	blockB[0].a[4].mA.mB = (bvec2(false, false));
	blockB[0].a[4].mA.mC = (bvec2(true, false));
	blockB[0].a[5].mA.mA = (uvec4(3u, 2u, 2u, 8u));
	blockB[0].a[5].mA.mB = (bvec2(false, false));
	blockB[0].a[5].mA.mC = (bvec2(true, false));
	blockB[0].a[6].mA.mA = (uvec4(6u, 4u, 8u, 1u));
	blockB[0].a[6].mA.mB = (bvec2(false, false));
	blockB[0].a[6].mA.mC = (bvec2(false, false));
	blockB[0].a[7].mA.mA = (uvec4(3u, 6u, 4u, 4u));
	blockB[0].a[7].mA.mB = (bvec2(true, true));
	blockB[0].a[7].mA.mC = (bvec2(true, true));
	blockB[1].a[0].mA.mA = (uvec4(2u, 3u, 4u, 9u));
	blockB[1].a[0].mA.mB = (bvec2(false, false));
	blockB[1].a[0].mA.mC = (bvec2(false, true));
	blockB[1].a[1].mA.mA = (uvec4(9u, 3u, 8u, 6u));
	blockB[1].a[1].mA.mB = (bvec2(true, true));
	blockB[1].a[1].mA.mC = (bvec2(true, false));
	blockB[1].a[2].mA.mA = (uvec4(0u, 8u, 8u, 9u));
	blockB[1].a[2].mA.mB = (bvec2(false, true));
	blockB[1].a[2].mA.mC = (bvec2(false, true));
	blockB[1].a[3].mA.mA = (uvec4(9u, 5u, 4u, 2u));
	blockB[1].a[3].mA.mB = (bvec2(true, true));
	blockB[1].a[3].mA.mC = (bvec2(true, false));
	blockB[2].a[0].mA.mA = (uvec4(9u, 6u, 6u, 7u));
	blockB[2].a[0].mA.mB = (bvec2(true, false));
	blockB[2].a[0].mA.mC = (bvec2(true, true));
	blockB[2].a[1].mA.mA = (uvec4(3u, 8u, 6u, 3u));
	blockB[2].a[1].mA.mB = (bvec2(false, true));
	blockB[2].a[1].mA.mC = (bvec2(true, true));
	blockB[2].a[2].mA.mA = (uvec4(8u, 2u, 2u, 4u));
	blockB[2].a[2].mA.mB = (bvec2(true, false));
	blockB[2].a[2].mA.mC = (bvec2(true, true));
	blockB[2].a[3].mA.mA = (uvec4(0u, 3u, 4u, 3u));
	blockB[2].a[3].mA.mB = (bvec2(false, false));
	blockB[2].a[3].mA.mC = (bvec2(false, true));
	blockB[2].a[4].mA.mA = (uvec4(3u, 3u, 1u, 6u));
	blockB[2].a[4].mA.mB = (bvec2(true, true));
	blockB[2].a[4].mA.mC = (bvec2(false, false));
	blockB[2].a[5].mA.mA = (uvec4(2u, 1u, 3u, 9u));
	blockB[2].a[5].mA.mB = (bvec2(true, false));
	blockB[2].a[5].mA.mC = (bvec2(true, false));
}
#version 450
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
	uint8_t a[1];
	bool b;
	highp uvec3 c;
	lowp mat3x4 d;
	mediump ivec3 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(0)].a[0]), 5u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].b), false) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].d, mat3x4(0.0, -1.0, 9.0, 2.0, -2.0, 5.0, -2.0, 0.0, 6.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].e), ivec3(0, -9, 7)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(1)].a[0]), 2u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].b), false) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].d, mat3x4(-7.0, 8.0, -5.0, 8.0, -2.0, 9.0, 2.0, 7.0, 9.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].e), ivec3(-3, 1, 4)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(2)].a[0]), 3u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].b), true) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(2)].d, mat3x4(0.0, 3.0, -4.0, 0.0, 2.0, 3.0, 8.0, 4.0, 7.0, 8.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].e), ivec3(-5, -5, 7)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(3)].a[0]), 8u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].b), true) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(3)].d, mat3x4(-9.0, -8.0, -6.0, 7.0, -6.0, -6.0, 0.0, 0.0, -5.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(3)].e), ivec3(5, -1, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = uint8_t(3u);
	blockB[nonuniformEXT(0)].b = (true);
	blockB[nonuniformEXT(0)].c = (uvec3(8u, 6u, 3u));
	blockB[nonuniformEXT(0)].d = (mat3x4(4.0, 8.0, -3.0, 9.0, 6.0, -3.0, -1.0, 5.0, -8.0, 3.0, 6.0, -6.0));
	blockB[nonuniformEXT(0)].e = (ivec3(-1, -2, 2));
	blockB[nonuniformEXT(1)].a[0] = uint8_t(8u);
	blockB[nonuniformEXT(1)].b = (false);
	blockB[nonuniformEXT(1)].c = (uvec3(4u, 2u, 0u));
	blockB[nonuniformEXT(1)].d = (mat3x4(-5.0, 8.0, -8.0, -1.0, -2.0, -3.0, 1.0, 3.0, -2.0, -3.0, -3.0, 7.0));
	blockB[nonuniformEXT(1)].e = (ivec3(-4, -5, -1));
	blockB[nonuniformEXT(2)].a[0] = uint8_t(5u);
	blockB[nonuniformEXT(2)].b = (false);
	blockB[nonuniformEXT(2)].c = (uvec3(4u, 6u, 5u));
	blockB[nonuniformEXT(2)].d = (mat3x4(-8.0, -3.0, 6.0, 6.0, -8.0, 0.0, 1.0, 0.0, 3.0, 4.0, -4.0, -2.0));
	blockB[nonuniformEXT(2)].e = (ivec3(-1, 5, 2));
	blockB[nonuniformEXT(3)].a[0] = uint8_t(8u);
	blockB[nonuniformEXT(3)].b = (true);
	blockB[nonuniformEXT(3)].c = (uvec3(5u, 8u, 8u));
	blockB[nonuniformEXT(3)].d = (mat3x4(-9.0, 9.0, 6.0, 4.0, 5.0, -9.0, 9.0, 5.0, -3.0, -7.0, 0.0, -3.0));
	blockB[nonuniformEXT(3)].e = (ivec3(0, 5, 0));
}
#version 450
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
	bvec3 a;
	highp vec3 b;
	mediump uvec4 c;
} blockB[];

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

layout(scalar, column_major, binding = 1) buffer BlockB
{
	int8_t a;
	mediump float b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].b), -2.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].b), 7.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].b), 0.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].b), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int8_t(1);
	blockB[nonuniformEXT(0)].b = (-6.0);
	blockB[nonuniformEXT(1)].a = int8_t(4294967294);
	blockB[nonuniformEXT(1)].b = (5.0);
	blockB[nonuniformEXT(2)].a = int8_t(1);
	blockB[nonuniformEXT(2)].b = (-6.0);
	blockB[nonuniformEXT(3)].a = int8_t(4294967291);
	blockB[nonuniformEXT(3)].b = (-1.0);
}
#version 450
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
	lowp ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-1, -8, 1)) && allOk;
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
	mediump uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(8u, 5u, 9u)) && allOk;
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
	allOk = compare_mat3(var, mat3(8.0, 6.0, -1.0, -6.0, 1.0, -4.0, -9.0, 1.0, -3.0)) && allOk;
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(9.0, 6.0, 4.0, -5.0, -2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0)) && allOk;
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
	allOk = compare_mat2x3(var, mat2x3(9.0, 1.0, -4.0, 3.0, 3.0, -6.0)) && allOk;
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

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(9.0, 4.0, 5.0, 6.0, 8.0, -5.0)) && allOk;
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-5.0, 9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0)) && allOk;
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(1.0, -7.0, -7.0, -5.0, -4.0, 7.0, 6.0, -1.0)) && allOk;
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
	allOk = compare_mat2x4(var, mat2x4(-7.0, -7.0, 7.0, -4.0, -5.0, -3.0, 1.0, 0.0)) && allOk;
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
	u16vec3 var;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var), uvec3(1u, 0u, 5u)) && allOk;
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
	highp uvec3 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 5u) && allOk;
	allOk = compare_uvec3((var), uvec3(4u, 7u, 5u)) && allOk;
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(9.0, -1.0, 7.0, -5.0, -9.0, 2.0, -8.0, 8.0)) && allOk;
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
	highp ivec2 var[3];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[2]), ivec2(-8, 8)) && allOk;
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

}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(3.0, -1.0, 3.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-8.0, 5.0, -4.0, 8.0, -3.0, 2.0)) && allOk;
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

layout(std430, binding = 1) readonly buffer Block
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

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

layout(scalar, row_major, binding = 1) readonly buffer Block
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

layout(scalar, binding = 1) readonly buffer Block
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

}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s.a), ivec3(-8, 9, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-7.0, -6.0, 4.0, 1.0, -8.0, -7.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(1.0, 8.0, 3.0, 7.0, -3.0, 4.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-9.0, -1.0, 3.0, 8.0, -7.0, -6.0, 9.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-9.0, 6.0, -1.0, -7.0, 0.0, -4.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(3.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-7, 4, -9)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-6.0, -2.0, 7.0, 5.0, -5.0, 9.0, -2.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-9.0, -2.0, 2.0, -3.0, 5.0, 4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-3.0, 5.0, 0.0, 2.0, -8.0, 2.0, -7.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, 4.0, 1.0, -4.0, -1.0, -5.0, 6.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(2.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-4, -7, -1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(9.0, 7.0, 8.0, 9.0, 1.0, -6.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(3.0, 3.0, 3.0, -3.0, -2.0, 4.0, 1.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(3.0, 8.0, 0.0, -6.0, 3.0, -8.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-4.0, -1.0, -3.0, -7.0, -8.0, 0.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(5.0, -1.0, -9.0, -3.0)) && allOk;
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
	allOk = compare_mat4x2(block.var, mat4x2(6.0, 9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-3.0, 9.0, -1.0, 2.0, 4.0, 5.0, -6.0, 6.0));
}
#version 450
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
	mediump vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var), vec3(1.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec3(6.0, 8.0, -1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[0][3], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_float(block.var[1][3], 8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-6.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(2.0, -6.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(8.0, -9.0, 0.0, -6.0));
	block.var[1] = (vec4(7.0, 8.0, 6.0, -6.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][3], -4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-6.0, -4.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(1.0, -8.0, -5.0, -2.0, 9.0, 1.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(6.0, -3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-7.0, 6.0, 2.0, -6.0, 9.0, 7.0, 1.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-4.0, 8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(4.0, 9.0, 2.0, 7.0, -6.0, -9.0, 2.0, -3.0, 1.0, 4.0, 3.0, 2.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[3][0], 0.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][2], -1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-9.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(9.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-2.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(0.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-5.0, 8.0, 1.0));
	block.var[1] = (vec3(-5.0, 5.0, 1.0));
	block.var[2] = (vec3(-8.0, -8.0, -7.0));
	block.var[3] = (vec3(-6.0, 1.0, 7.0));
}
#version 450
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
	uint padding;
	highp uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 2u) && allOk;
	allOk = compare_uvec2((block.var), uvec2(8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2u);
	block.var = (uvec2(7u, 4u));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(-5.0, -4.0, 8.0, -5.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var = (mat2x3(-5.0, 5.0, 3.0, 1.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(3.0, -9.0, 3.0, -3.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat2x3(-4.0, -4.0, 3.0, -2.0, 8.0, 1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(2.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat2x3(8.0, 5.0, 2.0, -2.0, -1.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat2x4(-2.0, -6.0, 0.0, -7.0, 7.0, -9.0, 0.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], -3.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][3], -1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-8.0, 1.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-3.0, 3.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var = (mat3x4(0.0, -2.0, -2.0, -2.0, 6.0, 2.0, 9.0, -5.0, -2.0, -8.0, -8.0, -1.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(7.0, -3.0));
	block.var[0][1] = (vec2(-2.0, 4.0));
	block.var[1][0] = (vec2(1.0, -3.0));
	block.var[1][1] = (vec2(2.0, -4.0));
	block.var[2][0] = (vec2(-1.0, 1.0));
	block.var[2][1] = (vec2(-4.0, 3.0));
}
#version 450
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
	allOk = compare_vec3((block.var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(5.0, 4.0, 7.0));
	block.var[1] = (vec3(8.0, -2.0, 7.0));
	block.var[2] = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x4(block.var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
}
#version 450
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
	i8vec3 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(3.0, -9.0, -2.0, -1.0, 3.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(-2.0, 8.0, -6.0, 4.0, 6.0, -4.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0] = (mat2x4(5.0, -4.0, -9.0, -9.0, 9.0, 1.0, 2.0, 5.0));
	block.var[1] = (mat2x4(5.0, -1.0, -3.0, -2.0, -4.0, -4.0, 8.0, 8.0));
	block.var[2] = (mat2x4(3.0, 1.0, -6.0, 2.0, 2.0, 5.0, 4.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-5.0, -1.0, -7.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(7.0, 0.0, 5.0, 0.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0][0] = (vec2(-6.0, 1.0));
	block.var[0][1] = (vec2(-3.0, -1.0));
	block.var[0][2] = (vec2(-9.0, 3.0));
	block.var[1][0] = (vec2(-2.0, 5.0));
	block.var[1][1] = (vec2(-8.0, 2.0));
	block.var[1][2] = (vec2(-9.0, 1.0));
	block.var[2][0] = (vec2(-5.0, 0.0));
	block.var[2][1] = (vec2(-2.0, 2.0));
	block.var[2][2] = (vec2(-1.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
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
	block.var[3][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[3][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[3][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[3][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[4][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[4][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[4][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[4][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[5][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[5][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[5][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[5][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[6][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[6][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[6][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[6][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[7][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[7][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[7][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[7][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[8][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[8][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[8][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[8][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[9][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[9][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[9][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[9][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[10][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[10][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[10][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[10][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[11][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[11][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[11][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[11][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	block.var[12][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	block.var[12][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	block.var[12][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	block.var[12][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	block.var[13][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	block.var[13][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	block.var[13][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	block.var[13][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	block.var[14][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	block.var[14][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	block.var[14][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	block.var[14][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	block.var[15][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	block.var[15][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	block.var[15][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	block.var[15][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	block.var[16][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	block.var[16][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	block.var[16][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	block.var[16][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	block.var[17][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	block.var[17][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	block.var[17][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	block.var[17][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	block.var[18][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	block.var[18][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	block.var[18][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	block.var[18][3] = (vec4(5.0, 7.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-3.0, -6.0, 6.0));
	block.var[0][1] = (vec3(1.0, -4.0, -3.0));
	block.var[0][2] = (vec3(-3.0, 3.0, -2.0));
	block.var[0][3] = (vec3(-7.0, 1.0, -5.0));
	block.var[1][0] = (vec3(-1.0, -5.0, 7.0));
	block.var[1][1] = (vec3(1.0, -2.0, -4.0));
	block.var[1][2] = (vec3(-4.0, -6.0, 5.0));
	block.var[1][3] = (vec3(-2.0, 6.0, -9.0));
	block.var[2][0] = (vec3(5.0, -5.0, 7.0));
	block.var[2][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[2][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[2][3] = (vec3(-2.0, 6.0, -3.0));
	block.var[3][0] = (vec3(-9.0, -2.0, -2.0));
	block.var[3][1] = (vec3(7.0, 9.0, -4.0));
	block.var[3][2] = (vec3(3.0, 1.0, 0.0));
	block.var[3][3] = (vec3(-9.0, -2.0, -7.0));
	block.var[4][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[4][1] = (vec3(-2.0, -7.0, 5.0));
	block.var[4][2] = (vec3(-2.0, -6.0, 4.0));
	block.var[4][3] = (vec3(9.0, 5.0, -9.0));
	block.var[5][0] = (vec3(-3.0, 3.0, 7.0));
	block.var[5][1] = (vec3(3.0, -4.0, -8.0));
	block.var[5][2] = (vec3(-2.0, 2.0, -1.0));
	block.var[5][3] = (vec3(1.0, -9.0, 9.0));
	block.var[6][0] = (vec3(-7.0, -7.0, -7.0));
	block.var[6][1] = (vec3(6.0, -9.0, 3.0));
	block.var[6][2] = (vec3(-5.0, 2.0, 4.0));
	block.var[6][3] = (vec3(-2.0, -4.0, -6.0));
	block.var[7][0] = (vec3(-1.0, 5.0, 5.0));
	block.var[7][1] = (vec3(-9.0, -3.0, -9.0));
	block.var[7][2] = (vec3(3.0, 2.0, 0.0));
	block.var[7][3] = (vec3(0.0, -9.0, 7.0));
	block.var[8][0] = (vec3(5.0, -5.0, -2.0));
	block.var[8][1] = (vec3(6.0, 5.0, -4.0));
	block.var[8][2] = (vec3(-2.0, 9.0, -3.0));
	block.var[8][3] = (vec3(2.0, 5.0, -4.0));
	block.var[9][0] = (vec3(6.0, 4.0, 7.0));
	block.var[9][1] = (vec3(1.0, -4.0, -6.0));
	block.var[9][2] = (vec3(4.0, -6.0, -5.0));
	block.var[9][3] = (vec3(5.0, 6.0, -1.0));
	block.var[10][0] = (vec3(6.0, 3.0, -9.0));
	block.var[10][1] = (vec3(-7.0, 3.0, -4.0));
	block.var[10][2] = (vec3(1.0, 2.0, 6.0));
	block.var[10][3] = (vec3(-2.0, 3.0, 7.0));
	block.var[11][0] = (vec3(-5.0, 8.0, -9.0));
	block.var[11][1] = (vec3(-4.0, -1.0, -9.0));
	block.var[11][2] = (vec3(5.0, 5.0, 6.0));
	block.var[11][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[12][0] = (vec3(-5.0, -6.0, -3.0));
	block.var[12][1] = (vec3(-2.0, 5.0, 8.0));
	block.var[12][2] = (vec3(2.0, -9.0, 7.0));
	block.var[12][3] = (vec3(7.0, -3.0, 4.0));
	block.var[13][0] = (vec3(9.0, 4.0, 1.0));
	block.var[13][1] = (vec3(5.0, -9.0, 2.0));
	block.var[13][2] = (vec3(-7.0, -3.0, -9.0));
	block.var[13][3] = (vec3(9.0, -6.0, 3.0));
	block.var[14][0] = (vec3(-9.0, -4.0, 0.0));
	block.var[14][1] = (vec3(5.0, 8.0, 9.0));
	block.var[14][2] = (vec3(-7.0, -9.0, -5.0));
	block.var[14][3] = (vec3(0.0, -1.0, -6.0));
	block.var[15][0] = (vec3(-9.0, -9.0, 9.0));
	block.var[15][1] = (vec3(9.0, -1.0, 8.0));
	block.var[15][2] = (vec3(8.0, -8.0, 4.0));
	block.var[15][3] = (vec3(9.0, -8.0, 8.0));
	block.var[16][0] = (vec3(4.0, 6.0, 1.0));
	block.var[16][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[16][2] = (vec3(-4.0, -3.0, 8.0));
	block.var[16][3] = (vec3(-9.0, -9.0, 2.0));
	block.var[17][0] = (vec3(0.0, -2.0, 5.0));
	block.var[17][1] = (vec3(8.0, 4.0, -4.0));
	block.var[17][2] = (vec3(5.0, 4.0, -5.0));
	block.var[17][3] = (vec3(0.0, -3.0, 9.0));
	block.var[18][0] = (vec3(-4.0, -7.0, 3.0));
	block.var[18][1] = (vec3(6.0, 4.0, 1.0));
	block.var[18][2] = (vec3(-3.0, 3.0, 8.0));
	block.var[18][3] = (vec3(-6.0, 5.0, -6.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[3] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[4] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[5] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[6] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[7] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[8] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[9] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[10] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[11] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	block.var[12] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	block.var[13] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	block.var[14] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	block.var[15] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	block.var[16] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	block.var[17] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	block.var[18] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	int16_t var[];
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
	allOk = compare_int16_t(int(block.var[3]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[4]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[5]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[6]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[7]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[8]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[9]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[10]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[11]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[12]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[13]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[14]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[15]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[16]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[17]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int16_t(6);
	block.var[1] = int16_t(8);
	block.var[2] = int16_t(-2);
	block.var[3] = int16_t(-4);
	block.var[4] = int16_t(-3);
	block.var[5] = int16_t(9);
	block.var[6] = int16_t(-5);
	block.var[7] = int16_t(-8);
	block.var[8] = int16_t(-3);
	block.var[9] = int16_t(2);
	block.var[10] = int16_t(-1);
	block.var[11] = int16_t(4);
	block.var[12] = int16_t(3);
	block.var[13] = int16_t(9);
	block.var[14] = int16_t(6);
	block.var[15] = int16_t(2);
	block.var[16] = int16_t(3);
	block.var[17] = int16_t(7);
	block.var[18] = int16_t(7);
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[0][2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[0][2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[0][2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[1][0][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[1][0][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][1][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[1][1][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[1][1][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[1][1][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[1][2][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[1][2][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[1][2][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[1][2][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[2][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[2][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[2][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[2][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[2][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[2][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[2][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[2][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[2][2][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[2][2][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[2][2][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[2][2][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[3][0][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[3][0][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[3][0][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[3][0][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[3][1][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[3][1][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[3][1][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[3][1][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[3][2][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[3][2][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][2][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[3][2][3] = (vec4(8.0, -7.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[0][2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[0][2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[1][0][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[1][0][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][1][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[1][1][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[1][1][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[1][2][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[1][2][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[1][2][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[2][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[2][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[2][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[2][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[2][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[2][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[2][2][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[2][2][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[2][2][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[3][0][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[3][0][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[3][0][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[3][1][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[3][1][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[3][1][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[3][2][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[3][2][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[3][2][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[0][2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[1][0] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[1][1] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[1][2] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[2][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[2][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[2][2] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[3][0] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[3][1] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[3][2] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[0][2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	block.var[1][0] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	block.var[1][1] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	block.var[1][2] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	block.var[2][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	block.var[2][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	block.var[2][2] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	block.var[3][0] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	block.var[3][1] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	block.var[3][2] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
}
#version 450
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
	bvec2 var[4][3];
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
	allOk = compare_bvec2((block.var[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0][0] = (bvec2(false, true));
	block.var[0][1] = (bvec2(true, false));
	block.var[0][2] = (bvec2(false, false));
	block.var[1][0] = (bvec2(false, false));
	block.var[1][1] = (bvec2(true, true));
	block.var[1][2] = (bvec2(true, false));
	block.var[2][0] = (bvec2(false, false));
	block.var[2][1] = (bvec2(true, true));
	block.var[2][2] = (bvec2(true, false));
	block.var[3][0] = (bvec2(false, true));
	block.var[3][1] = (bvec2(false, true));
	block.var[3][2] = (bvec2(false, false));
}
#version 450
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
	float16_t var[4][2][3];
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
	allOk = compare_float16_t(float(block.var[0][0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][2]), -8.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][0]), -2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][2]), 3.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][2]), 8.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][2]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][0]), -1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = float16_t(-8.0);
	block.var[0][0][1] = float16_t(9.0);
	block.var[0][0][2] = float16_t(-2.0);
	block.var[0][1][0] = float16_t(8.0);
	block.var[0][1][1] = float16_t(-3.0);
	block.var[0][1][2] = float16_t(6.0);
	block.var[1][0][0] = float16_t(7.0);
	block.var[1][0][1] = float16_t(8.0);
	block.var[1][0][2] = float16_t(-9.0);
	block.var[1][1][0] = float16_t(-3.0);
	block.var[1][1][1] = float16_t(-8.0);
	block.var[1][1][2] = float16_t(1.0);
	block.var[2][0][0] = float16_t(2.0);
	block.var[2][0][1] = float16_t(-8.0);
	block.var[2][0][2] = float16_t(-1.0);
	block.var[2][1][0] = float16_t(3.0);
	block.var[2][1][1] = float16_t(8.0);
	block.var[2][1][2] = float16_t(-7.0);
	block.var[3][0][0] = float16_t(6.0);
	block.var[3][0][1] = float16_t(-7.0);
	block.var[3][0][2] = float16_t(-5.0);
	block.var[3][1][0] = float16_t(-4.0);
	block.var[3][1][1] = float16_t(-6.0);
	block.var[3][1][2] = float16_t(8.0);
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[0][0][2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	block.var[0][1][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	block.var[0][1][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	block.var[0][1][2] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	block.var[1][0][0] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	block.var[1][0][1] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	block.var[1][0][2] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	block.var[1][1][0] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	block.var[1][1][1] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	block.var[1][1][2] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	block.var[2][0][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	block.var[2][0][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	block.var[2][0][2] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	block.var[2][1][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	block.var[2][1][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	block.var[2][1][2] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	block.var[3][0][0] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	block.var[3][0][1] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	block.var[3][0][2] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	block.var[3][1][0] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	block.var[3][1][1] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	block.var[3][1][2] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	highp ivec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 7) && allOk;
	allOk = compare_ivec3((block.var[0][0][0]), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_ivec3((block.var[0][0][1]), ivec3(-6, -8, 3)) && allOk;
	allOk = compare_ivec3((block.var[0][0][2]), ivec3(-1, -7, -1)) && allOk;
	allOk = compare_ivec3((block.var[0][1][0]), ivec3(-2, 7, 5)) && allOk;
	allOk = compare_ivec3((block.var[0][1][1]), ivec3(2, 0, 9)) && allOk;
	allOk = compare_ivec3((block.var[0][1][2]), ivec3(6, 7, 0)) && allOk;
	allOk = compare_ivec3((block.var[1][0][0]), ivec3(2, 9, -8)) && allOk;
	allOk = compare_ivec3((block.var[1][0][1]), ivec3(4, 9, -3)) && allOk;
	allOk = compare_ivec3((block.var[1][0][2]), ivec3(-3, -9, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][1][0]), ivec3(4, -6, 1)) && allOk;
	allOk = compare_ivec3((block.var[1][1][1]), ivec3(7, 4, -6)) && allOk;
	allOk = compare_ivec3((block.var[1][1][2]), ivec3(9, 3, 1)) && allOk;
	allOk = compare_ivec3((block.var[2][0][0]), ivec3(3, -6, -6)) && allOk;
	allOk = compare_ivec3((block.var[2][0][1]), ivec3(7, 3, 6)) && allOk;
	allOk = compare_ivec3((block.var[2][0][2]), ivec3(9, 0, 5)) && allOk;
	allOk = compare_ivec3((block.var[2][1][0]), ivec3(5, -6, -1)) && allOk;
	allOk = compare_ivec3((block.var[2][1][1]), ivec3(8, 8, 3)) && allOk;
	allOk = compare_ivec3((block.var[2][1][2]), ivec3(3, -7, 5)) && allOk;
	allOk = compare_ivec3((block.var[3][0][0]), ivec3(8, 2, 7)) && allOk;
	allOk = compare_ivec3((block.var[3][0][1]), ivec3(-7, 2, 1)) && allOk;
	allOk = compare_ivec3((block.var[3][0][2]), ivec3(-4, 0, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][1][0]), ivec3(7, 6, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][1][1]), ivec3(0, 3, -5)) && allOk;
	allOk = compare_ivec3((block.var[3][1][2]), ivec3(-9, 4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5);
	block.var[0][0][0] = (ivec3(0, -9, 2));
	block.var[0][0][1] = (ivec3(4, 1, 6));
	block.var[0][0][2] = (ivec3(6, 2, 4));
	block.var[0][1][0] = (ivec3(-8, 1, -5));
	block.var[0][1][1] = (ivec3(-4, 9, -2));
	block.var[0][1][2] = (ivec3(6, -6, -7));
	block.var[1][0][0] = (ivec3(4, 2, -4));
	block.var[1][0][1] = (ivec3(-1, -7, 8));
	block.var[1][0][2] = (ivec3(-4, 1, -4));
	block.var[1][1][0] = (ivec3(3, 0, -7));
	block.var[1][1][1] = (ivec3(-5, -7, -7));
	block.var[1][1][2] = (ivec3(-2, -9, 6));
	block.var[2][0][0] = (ivec3(-1, 5, -4));
	block.var[2][0][1] = (ivec3(2, -2, 6));
	block.var[2][0][2] = (ivec3(7, -1, -1));
	block.var[2][1][0] = (ivec3(7, -4, -8));
	block.var[2][1][1] = (ivec3(7, 7, -7));
	block.var[2][1][2] = (ivec3(-8, 6, 4));
	block.var[3][0][0] = (ivec3(-3, -1, -4));
	block.var[3][0][1] = (ivec3(-1, -3, 6));
	block.var[3][0][2] = (ivec3(-3, 8, 6));
	block.var[3][1][0] = (ivec3(2, 3, 4));
	block.var[3][1][1] = (ivec3(-3, -7, 1));
	block.var[3][1][2] = (ivec3(-3, -9, -1));
}
#version 450
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
	bvec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec3((block.var[0][0][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][0][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1][2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][1][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[3][0][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[3][0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][1][1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1][2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0][0][0] = (bvec3(true, false, false));
	block.var[0][0][1] = (bvec3(true, true, false));
	block.var[0][0][2] = (bvec3(false, false, true));
	block.var[0][1][0] = (bvec3(false, true, true));
	block.var[0][1][1] = (bvec3(false, true, false));
	block.var[0][1][2] = (bvec3(false, false, true));
	block.var[1][0][0] = (bvec3(false, false, true));
	block.var[1][0][1] = (bvec3(true, true, false));
	block.var[1][0][2] = (bvec3(true, true, false));
	block.var[1][1][0] = (bvec3(true, false, false));
	block.var[1][1][1] = (bvec3(false, true, false));
	block.var[1][1][2] = (bvec3(false, true, true));
	block.var[2][0][0] = (bvec3(true, true, true));
	block.var[2][0][1] = (bvec3(true, true, true));
	block.var[2][0][2] = (bvec3(true, true, true));
	block.var[2][1][0] = (bvec3(true, false, false));
	block.var[2][1][1] = (bvec3(true, false, false));
	block.var[2][1][2] = (bvec3(true, false, false));
	block.var[3][0][0] = (bvec3(false, false, false));
	block.var[3][0][1] = (bvec3(true, false, true));
	block.var[3][0][2] = (bvec3(false, false, false));
	block.var[3][1][0] = (bvec3(false, false, true));
	block.var[3][1][1] = (bvec3(true, false, false));
	block.var[3][1][2] = (bvec3(true, false, false));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-6.0, -3.0, -8.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-5.0, 8.0, -3.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-9.0, 4.0, -4.0, -2.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-4.0, 4.0, -9.0, -1.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(4.0, -6.0, 9.0, -8.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-1.0, -8.0, 3.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(7.0, 2.0, -2.0, 6.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(3.0, 1.0, 1.0, 2.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-3.0, 0.0, 1.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-2.0, -4.0, -6.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-6.0, -4.0, 5.0, -3.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(0.0, 2.0, -8.0, 5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(0.0, -6.0, -3.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(2.0, 8.0, 8.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(5.0, -1.0, 6.0, 6.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(6.0, -5.0, 8.0, 1.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-6.0, -1.0, -9.0, -3.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-5.0, 7.0, 3.0, -7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(4.0, -6.0, -4.0, 0.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(2.0, 6.0, 0.0, -5.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-3.0, -9.0, 9.0, 6.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-2.0, 1.0, 4.0, 1.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-4.0, 9.0, 7.0, -4.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0] = (mat2x3(4.0, 4.0, 5.0, -5.0, 2.0, 8.0));
	block.var[0][0][1] = (mat2x3(-1.0, -2.0, -7.0, -8.0, -2.0, 2.0));
	block.var[0][0][2] = (mat2x3(-2.0, 7.0, -9.0, 7.0, -7.0, -5.0));
	block.var[0][1][0] = (mat2x3(-4.0, -5.0, -4.0, -9.0, 4.0, 6.0));
	block.var[0][1][1] = (mat2x3(3.0, -4.0, 1.0, -8.0, 2.0, -4.0));
	block.var[0][1][2] = (mat2x3(6.0, 9.0, 8.0, -3.0, 4.0, -7.0));
	block.var[1][0][0] = (mat2x3(6.0, 8.0, -8.0, 0.0, 2.0, 7.0));
	block.var[1][0][1] = (mat2x3(-9.0, -2.0, -9.0, -1.0, -1.0, -4.0));
	block.var[1][0][2] = (mat2x3(-3.0, 7.0, 9.0, 0.0, -4.0, 9.0));
	block.var[1][1][0] = (mat2x3(-8.0, 0.0, -7.0, 6.0, 7.0, 8.0));
	block.var[1][1][1] = (mat2x3(2.0, 8.0, 2.0, 1.0, 6.0, -1.0));
	block.var[1][1][2] = (mat2x3(8.0, 1.0, -8.0, -1.0, 2.0, -1.0));
	block.var[2][0][0] = (mat2x3(0.0, 7.0, 7.0, 9.0, -8.0, 5.0));
	block.var[2][0][1] = (mat2x3(5.0, 1.0, 6.0, 3.0, -6.0, 8.0));
	block.var[2][0][2] = (mat2x3(9.0, 6.0, 7.0, 0.0, -6.0, -7.0));
	block.var[2][1][0] = (mat2x3(7.0, -6.0, -6.0, -1.0, 0.0, -1.0));
	block.var[2][1][1] = (mat2x3(2.0, 7.0, 6.0, -8.0, 6.0, 7.0));
	block.var[2][1][2] = (mat2x3(-3.0, -1.0, 9.0, -1.0, -7.0, -2.0));
	block.var[3][0][0] = (mat2x3(6.0, 4.0, 8.0, 5.0, -1.0, 4.0));
	block.var[3][0][1] = (mat2x3(4.0, 9.0, 9.0, -8.0, 6.0, 6.0));
	block.var[3][0][2] = (mat2x3(3.0, 8.0, 3.0, 4.0, 4.0, 3.0));
	block.var[3][1][0] = (mat2x3(1.0, 4.0, -5.0, -8.0, -5.0, 2.0));
	block.var[3][1][1] = (mat2x3(1.0, 2.0, 5.0, -4.0, -5.0, -6.0));
	block.var[3][1][2] = (mat2x3(9.0, -2.0, 0.0, 5.0, -9.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(3.0, 1.0, 4.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-5.0, -8.0, -7.0, 1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(3.0, -2.0, -8.0, -9.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-5.0, -5.0, -2.0, 6.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(0.0, 7.0, 6.0, -3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(6.0, -5.0, 3.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(2.0, 6.0, 8.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-2.0, -4.0, -2.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(9.0, 1.0, 3.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-2.0, 6.0, 8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-2.0, 0.0, 0.0, 8.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(8.0, -4.0, -5.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(6.0, -9.0, -2.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-3.0, 6.0, 3.0, 2.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-7.0, 9.0, 9.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-6.0, -7.0, 2.0, -1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(6.0, -6.0, -5.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-2.0, -3.0, -1.0, -4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(2.0, -1.0, -4.0, 5.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-7.0, 7.0, 0.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(0.0, -9.0, 4.0, -2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(8.0, 7.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(3.0, 1.0, -2.0, 9.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0][0] = (mat2x3(-2.0, -5.0, 0.0, 7.0, -2.0, 0.0));
	block.var[0][0][1] = (mat2x3(9.0, 9.0, 8.0, -6.0, 3.0, -9.0));
	block.var[0][0][2] = (mat2x3(0.0, 1.0, 1.0, 7.0, -8.0, 7.0));
	block.var[0][1][0] = (mat2x3(1.0, 2.0, -3.0, 0.0, -3.0, -2.0));
	block.var[0][1][1] = (mat2x3(3.0, -2.0, 5.0, -6.0, -7.0, -7.0));
	block.var[0][1][2] = (mat2x3(3.0, -4.0, -6.0, -2.0, 6.0, -7.0));
	block.var[1][0][0] = (mat2x3(-4.0, 4.0, -5.0, -1.0, 0.0, 2.0));
	block.var[1][0][1] = (mat2x3(-5.0, 6.0, 7.0, -2.0, 4.0, -3.0));
	block.var[1][0][2] = (mat2x3(7.0, 6.0, -3.0, -2.0, -6.0, 7.0));
	block.var[1][1][0] = (mat2x3(-3.0, 3.0, -9.0, 3.0, 8.0, -1.0));
	block.var[1][1][1] = (mat2x3(7.0, 4.0, -9.0, -7.0, 2.0, 1.0));
	block.var[1][1][2] = (mat2x3(-7.0, -2.0, 5.0, -6.0, -6.0, -1.0));
	block.var[2][0][0] = (mat2x3(-3.0, 2.0, 8.0, -1.0, 2.0, 2.0));
	block.var[2][0][1] = (mat2x3(-9.0, 3.0, 1.0, -7.0, -7.0, 3.0));
	block.var[2][0][2] = (mat2x3(-3.0, -5.0, 4.0, -6.0, 8.0, 7.0));
	block.var[2][1][0] = (mat2x3(-2.0, 6.0, 9.0, 1.0, -6.0, 6.0));
	block.var[2][1][1] = (mat2x3(6.0, 5.0, 3.0, 4.0, 7.0, 0.0));
	block.var[2][1][2] = (mat2x3(9.0, -5.0, 3.0, -7.0, 1.0, 0.0));
	block.var[3][0][0] = (mat2x3(-9.0, 2.0, -8.0, 9.0, 9.0, 3.0));
	block.var[3][0][1] = (mat2x3(5.0, 8.0, 5.0, -7.0, 6.0, 3.0));
	block.var[3][0][2] = (mat2x3(6.0, 6.0, 1.0, 2.0, -7.0, -9.0));
	block.var[3][1][0] = (mat2x3(6.0, 0.0, 6.0, 4.0, -1.0, -2.0));
	block.var[3][1][1] = (mat2x3(2.0, 3.0, 8.0, 3.0, -5.0, 1.0));
	block.var[3][1][2] = (mat2x3(-6.0, -1.0, 5.0, 9.0, -6.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(9.0, -6.0, -3.0, -7.0, 7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(0.0, 5.0, 0.0, -9.0, 3.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-2.0, -5.0, -2.0, -5.0, -8.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(9.0, 0.0, 3.0, -7.0, -2.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(2.0, -9.0, -8.0, 5.0, 3.0, -5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[0][0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[0][1][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	block.var[0][1][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	block.var[0][2][0] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	block.var[0][2][1] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	block.var[0][3][0] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
	block.var[0][3][1] = (mat2x4(-4.0, -8.0, -2.0, 8.0, -5.0, 5.0, -9.0, 9.0));
	block.var[1][0][0] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	block.var[1][0][1] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	block.var[1][1][0] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	block.var[1][1][1] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	block.var[1][2][0] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	block.var[1][2][1] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	block.var[1][3][0] = (mat2x4(5.0, 0.0, -8.0, -5.0, 5.0, -6.0, 9.0, 8.0));
	block.var[1][3][1] = (mat2x4(-9.0, -9.0, -2.0, -6.0, 7.0, 3.0, 3.0, -2.0));
	block.var[2][0][0] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	block.var[2][0][1] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	block.var[2][1][0] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	block.var[2][1][1] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	block.var[2][2][0] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	block.var[2][2][1] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	block.var[2][3][0] = (mat2x4(4.0, -3.0, -6.0, 4.0, -3.0, 9.0, -3.0, 0.0));
	block.var[2][3][1] = (mat2x4(4.0, 4.0, -6.0, 7.0, -8.0, 7.0, -1.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(-8.0, 7.0, -3.0, -1.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(3.0, 4.0, -2.0, -2.0, -6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(8.0, -1.0, 6.0, -1.0, 5.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(-1.0, 7.0, 4.0, 1.0, 8.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(7.0, 3.0, -4.0, 5.0, 4.0, 8.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[0][0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[0][1][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	block.var[0][1][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[0][1][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	block.var[0][1][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[0][2][0][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	block.var[0][2][0][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	block.var[0][2][1][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	block.var[0][2][1][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	block.var[0][3][0][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	block.var[0][3][0][1] = (vec4(1.0, -2.0, 4.0, 5.0));
	block.var[0][3][1][0] = (vec4(0.0, 7.0, 8.0, 6.0));
	block.var[0][3][1][1] = (vec4(-7.0, -6.0, -1.0, 7.0));
	block.var[1][0][0][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[1][0][0][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[1][0][1][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	block.var[1][0][1][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[1][1][0][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	block.var[1][1][0][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[1][1][1][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	block.var[1][1][1][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[1][2][0][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	block.var[1][2][0][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	block.var[1][2][1][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	block.var[1][2][1][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	block.var[1][3][0][0] = (vec4(-1.0, -9.0, 8.0, 3.0));
	block.var[1][3][0][1] = (vec4(-6.0, 4.0, 0.0, 8.0));
	block.var[1][3][1][0] = (vec4(0.0, 9.0, 6.0, 5.0));
	block.var[1][3][1][1] = (vec4(-1.0, 1.0, 1.0, 7.0));
	block.var[2][0][0][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	block.var[2][0][0][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[2][0][1][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	block.var[2][0][1][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[2][1][0][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	block.var[2][1][0][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[2][1][1][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	block.var[2][1][1][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	block.var[2][2][0][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	block.var[2][2][0][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	block.var[2][2][1][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	block.var[2][2][1][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	block.var[2][3][0][0] = (vec4(6.0, -6.0, -7.0, 9.0));
	block.var[2][3][0][1] = (vec4(-7.0, -4.0, -9.0, 7.0));
	block.var[2][3][1][0] = (vec4(-2.0, 4.0, -8.0, -3.0));
	block.var[2][3][1][1] = (vec4(1.0, 7.0, 7.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(0.0, 6.0, 8.0, -6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(8.0, 4.0, -9.0, 4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(6.0, -5.0, -8.0, -6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(6.0, -4.0, -1.0, -9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, 2.0, -6.0, -5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[0][0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[0][1][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[0][1][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[0][2][0] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	block.var[0][2][1] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	block.var[0][3][0] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
	block.var[0][3][1] = (mat4x3(5.0, 0.0, 3.0, 8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0));
	block.var[1][0][0] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[1][0][1] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[1][1][0] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[1][1][1] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[1][2][0] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	block.var[1][2][1] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	block.var[1][3][0] = (mat4x3(6.0, -8.0, -9.0, -9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0));
	block.var[1][3][1] = (mat4x3(5.0, 2.0, 7.0, -9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0));
	block.var[2][0][0] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[2][0][1] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[2][1][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[2][1][1] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	block.var[2][2][0] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	block.var[2][2][1] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	block.var[2][3][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0));
	block.var[2][3][1] = (mat4x3(7.0, -1.0, -2.0, 1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(-8.0, 7.0, -3.0, -1.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(3.0, 4.0, -2.0, -2.0, -6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(8.0, -1.0, 6.0, -1.0, 5.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(-1.0, 7.0, 4.0, 1.0, 8.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(7.0, 3.0, -4.0, 5.0, 4.0, 8.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[0][0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[0][1][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	block.var[0][1][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[0][1][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	block.var[0][1][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[0][2][0][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	block.var[0][2][0][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	block.var[0][2][1][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	block.var[0][2][1][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	block.var[0][3][0][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	block.var[0][3][0][1] = (vec4(1.0, -2.0, 4.0, 5.0));
	block.var[0][3][1][0] = (vec4(0.0, 7.0, 8.0, 6.0));
	block.var[0][3][1][1] = (vec4(-7.0, -6.0, -1.0, 7.0));
	block.var[1][0][0][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[1][0][0][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[1][0][1][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	block.var[1][0][1][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[1][1][0][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	block.var[1][1][0][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[1][1][1][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	block.var[1][1][1][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[1][2][0][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	block.var[1][2][0][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	block.var[1][2][1][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	block.var[1][2][1][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	block.var[1][3][0][0] = (vec4(-1.0, -9.0, 8.0, 3.0));
	block.var[1][3][0][1] = (vec4(-6.0, 4.0, 0.0, 8.0));
	block.var[1][3][1][0] = (vec4(0.0, 9.0, 6.0, 5.0));
	block.var[1][3][1][1] = (vec4(-1.0, 1.0, 1.0, 7.0));
	block.var[2][0][0][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	block.var[2][0][0][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[2][0][1][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	block.var[2][0][1][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[2][1][0][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	block.var[2][1][0][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[2][1][1][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	block.var[2][1][1][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	block.var[2][2][0][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	block.var[2][2][0][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	block.var[2][2][1][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	block.var[2][2][1][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	block.var[2][3][0][0] = (vec4(6.0, -6.0, -7.0, 9.0));
	block.var[2][3][0][1] = (vec4(-7.0, -4.0, -9.0, 7.0));
	block.var[2][3][1][0] = (vec4(-2.0, 4.0, -8.0, -3.0));
	block.var[2][3][1][1] = (vec4(1.0, 7.0, 7.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-8.0, -4.0));
	block.var[0][0][0][1] = (vec2(-3.0, 5.0));
	block.var[0][0][0][2] = (vec2(-9.0, 4.0));
	block.var[0][0][1][0] = (vec2(-2.0, -1.0));
	block.var[0][0][1][1] = (vec2(8.0, 3.0));
	block.var[0][0][1][2] = (vec2(7.0, 2.0));
	block.var[0][1][0][0] = (vec2(2.0, -5.0));
	block.var[0][1][0][1] = (vec2(-5.0, -9.0));
	block.var[0][1][0][2] = (vec2(-7.0, 3.0));
	block.var[0][1][1][0] = (vec2(-1.0, 0.0));
	block.var[0][1][1][1] = (vec2(-1.0, 4.0));
	block.var[0][1][1][2] = (vec2(-1.0, -6.0));
	block.var[0][2][0][0] = (vec2(2.0, 6.0));
	block.var[0][2][0][1] = (vec2(6.0, 1.0));
	block.var[0][2][0][2] = (vec2(4.0, -8.0));
	block.var[0][2][1][0] = (vec2(2.0, -5.0));
	block.var[0][2][1][1] = (vec2(-5.0, 5.0));
	block.var[0][2][1][2] = (vec2(2.0, -1.0));
	block.var[0][3][0][0] = (vec2(-2.0, -8.0));
	block.var[0][3][0][1] = (vec2(0.0, -2.0));
	block.var[0][3][0][2] = (vec2(8.0, -2.0));
	block.var[0][3][1][0] = (vec2(3.0, 7.0));
	block.var[0][3][1][1] = (vec2(-9.0, -1.0));
	block.var[0][3][1][2] = (vec2(5.0, 7.0));
	block.var[1][0][0][0] = (vec2(-4.0, 4.0));
	block.var[1][0][0][1] = (vec2(3.0, -6.0));
	block.var[1][0][0][2] = (vec2(-4.0, 3.0));
	block.var[1][0][1][0] = (vec2(4.0, 6.0));
	block.var[1][0][1][1] = (vec2(3.0, 6.0));
	block.var[1][0][1][2] = (vec2(-2.0, -9.0));
	block.var[1][1][0][0] = (vec2(-8.0, -6.0));
	block.var[1][1][0][1] = (vec2(8.0, 7.0));
	block.var[1][1][0][2] = (vec2(4.0, -9.0));
	block.var[1][1][1][0] = (vec2(-4.0, -1.0));
	block.var[1][1][1][1] = (vec2(-3.0, -2.0));
	block.var[1][1][1][2] = (vec2(-5.0, -2.0));
	block.var[1][2][0][0] = (vec2(-9.0, 3.0));
	block.var[1][2][0][1] = (vec2(6.0, 5.0));
	block.var[1][2][0][2] = (vec2(-1.0, -8.0));
	block.var[1][2][1][0] = (vec2(2.0, -1.0));
	block.var[1][2][1][1] = (vec2(0.0, -2.0));
	block.var[1][2][1][2] = (vec2(-4.0, 6.0));
	block.var[1][3][0][0] = (vec2(-5.0, 7.0));
	block.var[1][3][0][1] = (vec2(6.0, 2.0));
	block.var[1][3][0][2] = (vec2(-4.0, -3.0));
	block.var[1][3][1][0] = (vec2(-5.0, 2.0));
	block.var[1][3][1][1] = (vec2(-7.0, 8.0));
	block.var[1][3][1][2] = (vec2(-6.0, 3.0));
	block.var[2][0][0][0] = (vec2(-9.0, 0.0));
	block.var[2][0][0][1] = (vec2(-4.0, 9.0));
	block.var[2][0][0][2] = (vec2(-1.0, -1.0));
	block.var[2][0][1][0] = (vec2(-8.0, 6.0));
	block.var[2][0][1][1] = (vec2(5.0, -2.0));
	block.var[2][0][1][2] = (vec2(1.0, 4.0));
	block.var[2][1][0][0] = (vec2(-7.0, -3.0));
	block.var[2][1][0][1] = (vec2(5.0, 4.0));
	block.var[2][1][0][2] = (vec2(4.0, 1.0));
	block.var[2][1][1][0] = (vec2(-3.0, -6.0));
	block.var[2][1][1][1] = (vec2(-4.0, -2.0));
	block.var[2][1][1][2] = (vec2(-5.0, -7.0));
	block.var[2][2][0][0] = (vec2(2.0, -3.0));
	block.var[2][2][0][1] = (vec2(-2.0, 1.0));
	block.var[2][2][0][2] = (vec2(-3.0, 8.0));
	block.var[2][2][1][0] = (vec2(5.0, -1.0));
	block.var[2][2][1][1] = (vec2(-4.0, -4.0));
	block.var[2][2][1][2] = (vec2(7.0, -6.0));
	block.var[2][3][0][0] = (vec2(-3.0, -4.0));
	block.var[2][3][0][1] = (vec2(-5.0, -9.0));
	block.var[2][3][0][2] = (vec2(-8.0, -7.0));
	block.var[2][3][1][0] = (vec2(8.0, -8.0));
	block.var[2][3][1][1] = (vec2(-2.0, 7.0));
	block.var[2][3][1][2] = (vec2(5.0, -5.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	int8_t var[][4][2];
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
	allOk = compare_int8_t(int(block.var[0][1][0]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][1]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[0][2][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][2][1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[0][3][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[0][3][1]), 9) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][0]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][1]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][0]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[1][2][0]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[1][2][1]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[1][3][0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[1][3][1]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][0]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][1]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[2][2][0]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[2][2][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[2][3][0]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[2][3][1]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int8_t(4294967290);
	block.var[0][0][1] = int8_t(4294967294);
	block.var[0][1][0] = int8_t(4294967288);
	block.var[0][1][1] = int8_t(4294967294);
	block.var[0][2][0] = int8_t(0);
	block.var[0][2][1] = int8_t(4294967289);
	block.var[0][3][0] = int8_t(6);
	block.var[0][3][1] = int8_t(1);
	block.var[1][0][0] = int8_t(3);
	block.var[1][0][1] = int8_t(4294967288);
	block.var[1][1][0] = int8_t(7);
	block.var[1][1][1] = int8_t(9);
	block.var[1][2][0] = int8_t(1);
	block.var[1][2][1] = int8_t(7);
	block.var[1][3][0] = int8_t(4294967293);
	block.var[1][3][1] = int8_t(2);
	block.var[2][0][0] = int8_t(1);
	block.var[2][0][1] = int8_t(2);
	block.var[2][1][0] = int8_t(0);
	block.var[2][1][1] = int8_t(4294967292);
	block.var[2][2][0] = int8_t(4294967287);
	block.var[2][2][1] = int8_t(4294967289);
	block.var[2][3][0] = int8_t(5);
	block.var[2][3][1] = int8_t(4294967289);
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(5, -4, -3)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, 9.0, 7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, 0.0, 8.0, 8.0, -4.0, 8.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(9, 7, 8)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-5.0, -5.0, 7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(2.0, 1.0, -7.0, 9.0, 0.0, 4.0, -1.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(4.0, -5.0, -9.0, -3.0, -1.0, -2.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-7.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, -2, -2)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(0.0, -2.0, 9.0, -7.0, 6.0, 4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-5.0, 1.0, 9.0, 3.0, -3.0, 8.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-5.0, 6.0, 5.0, 1.0, -2.0, -5.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-8.0, 8.0, -8.0, 9.0, 7.0, 4.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-4.0, -6.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, -5, 3));
	block[0].s.b[0][0] = (vec3(-2.0, -9.0, -6.0));
	block[0].s.b[0][1] = (vec3(1.0, -4.0, 0.0));
	block[0].s.b[0][2] = (vec3(4.0, 4.0, -7.0));
	block[0].s.b[1][0] = (vec3(-8.0, -9.0, 6.0));
	block[0].s.b[1][1] = (vec3(4.0, -6.0, 2.0));
	block[0].s.b[1][2] = (vec3(5.0, 5.0, 1.0));
	block[0].s.b[2][0] = (vec3(-1.0, -6.0, -4.0));
	block[0].s.b[2][1] = (vec3(5.0, 0.0, 5.0));
	block[0].s.b[2][2] = (vec3(-3.0, 0.0, 5.0));
	block[0].s.b[3][0] = (vec3(-1.0, 1.0, -7.0));
	block[0].s.b[3][1] = (vec3(-7.0, 8.0, -2.0));
	block[0].s.b[3][2] = (vec3(-9.0, 5.0, 6.0));
	block[0].s.c = (vec4(6.0, -9.0, -4.0, 6.0));
	block[1].s.a = (ivec3(-3, 7, 5));
	block[1].s.b[0][0] = (vec3(-4.0, 7.0, -2.0));
	block[1].s.b[0][1] = (vec3(8.0, 4.0, 8.0));
	block[1].s.b[0][2] = (vec3(-5.0, -8.0, 6.0));
	block[1].s.b[1][0] = (vec3(-5.0, -9.0, -5.0));
	block[1].s.b[1][1] = (vec3(-7.0, 2.0, 0.0));
	block[1].s.b[1][2] = (vec3(0.0, 0.0, 1.0));
	block[1].s.b[2][0] = (vec3(-9.0, 0.0, 7.0));
	block[1].s.b[2][1] = (vec3(9.0, -3.0, 5.0));
	block[1].s.b[2][2] = (vec3(9.0, 5.0, -1.0));
	block[1].s.b[3][0] = (vec3(-7.0, -8.0, 1.0));
	block[1].s.b[3][1] = (vec3(8.0, -7.0, 8.0));
	block[1].s.b[3][2] = (vec3(1.0, 8.0, 0.0));
	block[1].s.c = (vec4(-4.0, -7.0, -3.0, 1.0));
	block[2].s.a = (ivec3(-1, -2, 2));
	block[2].s.b[0][0] = (vec3(2.0, -2.0, 3.0));
	block[2].s.b[0][1] = (vec3(-9.0, 7.0, -7.0));
	block[2].s.b[0][2] = (vec3(-7.0, 7.0, 0.0));
	block[2].s.b[1][0] = (vec3(-2.0, -9.0, -1.0));
	block[2].s.b[1][1] = (vec3(-8.0, 2.0, -1.0));
	block[2].s.b[1][2] = (vec3(7.0, -9.0, 3.0));
	block[2].s.b[2][0] = (vec3(9.0, -1.0, 8.0));
	block[2].s.b[2][1] = (vec3(-5.0, -9.0, 4.0));
	block[2].s.b[2][2] = (vec3(-4.0, 0.0, 8.0));
	block[2].s.b[3][0] = (vec3(9.0, 1.0, -5.0));
	block[2].s.b[3][1] = (vec3(0.0, 0.0, 4.0));
	block[2].s.b[3][2] = (vec3(0.0, 9.0, 6.0));
	block[2].s.c = (vec4(8.0, 8.0, -7.0, 3.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.t[0].a, mat3(-2.0, -8.0, -9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(-2, -1, 8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(6, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(6, -5)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(5.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(6, 8, 5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(-4, 2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(-8, 4)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-2.0, -8.0, -9.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(3, -9, -5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(3, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(-9, 6)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(2.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-8.0, 1.0, 7.0, 6.0, -9.0, 1.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(-9, 2, -2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-4, -8)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-9.0, -8.0, -4.0, -5.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(-9, -8, 2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(5, 6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(-9, -8)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-5.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(1, 9, -7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-3, 2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(-5, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(6, 6)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-6.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_uint((block.u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-5, -2, 8));
	block.s.b[0] = (ivec2(8, -7));
	block.s.b[1] = (ivec2(8, -2));
	block.s.b[2] = (ivec2(-2, -6));
	block.s.b[3] = (ivec2(6, 0));
	block.s.c = (vec4(-6.0, -4.0, 3.0, -6.0));
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
	allOk = compare_uvec2((block.s[0].a), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-9.0, 5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(-5.0, 5.0, 3.0, 0.0, -3.0, 5.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(-5.0, -4.0, -5.0, 7.0, -4.0, -9.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(-7.0, -9.0, 2.0, -1.0, 9.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(8.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(0.0, 8.0, -7.0, 3.0, 4.0, 6.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(1.0, -7.0, 6.0, 1.0, 6.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(-3.0, -9.0, -3.0, 8.0, -4.0, 7.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(-1.0, -1.0, -3.0, 4.0, 4.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(4.0, 8.0, -8.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(1u, 8u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(0.0, 5.0, 0.0, 7.0, -7.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(-5.0, -7.0, -4.0, -9.0, 2.0, -7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(-6.0, -8.0, 2.0, -2.0, -4.0, -6.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(3.0, 7.0, 8.0, 9.0, -9.0, 6.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(9.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(3u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(2.0, -6.0, 4.0, 1.0, 3.0, -2.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(8.0, -9.0, -2.0, 1.0, -7.0, 8.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(8.0, 2.0, 5.0, -1.0, -1.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(2.0, -1.0, -2.0, 2.0, -8.0, 6.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(-3.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (7u);
	block.s[0].a = (uvec2(6u, 9u));
	block.s[0].b[0][0] = (vec4(7.0, -7.0, 5.0, 1.0));
	block.s[0].b[0][1] = (vec4(-7.0, -6.0, -4.0, -5.0));
	block.s[0].b[1][0] = (vec4(1.0, -1.0, 7.0, -4.0));
	block.s[0].b[1][1] = (vec4(6.0, -5.0, 7.0, 1.0));
	block.s[0].b[2][0] = (vec4(-5.0, 3.0, 8.0, 9.0));
	block.s[0].b[2][1] = (vec4(-2.0, -6.0, 1.0, 1.0));
	block.s[0].b[3][0] = (vec4(-5.0, -7.0, 4.0, 7.0));
	block.s[0].b[3][1] = (vec4(-6.0, 2.0, 7.0, 6.0));
	block.s[0].c = (vec3(-7.0, 5.0, -2.0));
	block.s[1].a = (uvec2(4u, 7u));
	block.s[1].b[0][0] = (vec4(-1.0, -3.0, 7.0, 8.0));
	block.s[1].b[0][1] = (vec4(-8.0, -1.0, -2.0, 9.0));
	block.s[1].b[1][0] = (vec4(3.0, 2.0, 1.0, 6.0));
	block.s[1].b[1][1] = (vec4(6.0, 6.0, 8.0, -2.0));
	block.s[1].b[2][0] = (vec4(-2.0, -7.0, 0.0, -8.0));
	block.s[1].b[2][1] = (vec4(8.0, -5.0, 7.0, -9.0));
	block.s[1].b[3][0] = (vec4(-7.0, -2.0, 4.0, -3.0));
	block.s[1].b[3][1] = (vec4(-1.0, -4.0, -1.0, 0.0));
	block.s[1].c = (vec3(2.0, 9.0, 5.0));
	block.s[2].a = (uvec2(7u, 5u));
	block.s[2].b[0][0] = (vec4(-1.0, 1.0, 1.0, -7.0));
	block.s[2].b[0][1] = (vec4(6.0, -1.0, 7.0, 8.0));
	block.s[2].b[1][0] = (vec4(3.0, -2.0, -1.0, -9.0));
	block.s[2].b[1][1] = (vec4(4.0, -5.0, -4.0, 9.0));
	block.s[2].b[2][0] = (vec4(-5.0, 9.0, 4.0, -5.0));
	block.s[2].b[2][1] = (vec4(2.0, -8.0, 3.0, 1.0));
	block.s[2].b[3][0] = (vec4(3.0, 1.0, 5.0, -6.0));
	block.s[2].b[3][1] = (vec4(-7.0, 2.0, 0.0, -5.0));
	block.s[2].c = (vec3(8.0, -4.0, -7.0));
	block.s[3].a = (uvec2(1u, 0u));
	block.s[3].b[0][0] = (vec4(0.0, 9.0, 8.0, 7.0));
	block.s[3].b[0][1] = (vec4(-7.0, 4.0, -2.0, -8.0));
	block.s[3].b[1][0] = (vec4(-6.0, -1.0, 7.0, -2.0));
	block.s[3].b[1][1] = (vec4(6.0, -9.0, -1.0, -6.0));
	block.s[3].b[2][0] = (vec4(-2.0, -2.0, 9.0, -7.0));
	block.s[3].b[2][1] = (vec4(5.0, 3.0, -7.0, 0.0));
	block.s[3].b[3][0] = (vec4(-6.0, 4.0, -7.0, -8.0));
	block.s[3].b[3][1] = (vec4(9.0, -5.0, 1.0, -7.0));
	block.s[3].c = (vec3(4.0, -4.0, -3.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(7, -9, -9)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(1.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-4, 1, -9)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(3.0, -7.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-8, 4, -5)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-3.0, 9.0, -9.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(-8, 5, -7)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-5.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(-7, 2, 3)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-6.0, -4.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-9, 6, 5)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(-5.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(7, 5, 9)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-4.0, 9.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(4, 2, 6)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-4.0, 8.0, -2.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-2, 5, -3)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(-8.0, -8.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(2, 5, -6)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-5.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(5, -4, 4)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(6.0, -6.0, -9.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(1, -6, 7)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(7.0, -9.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-8.0, 2.0, 3.0, -5.0));
	block[0].s[0][0].a = (ivec3(3, -3, 5));
	block[0].s[0][0].c = (vec4(-1.0, 8.0, 2.0, -1.0));
	block[0].s[0][1].a = (ivec3(7, 1, -1));
	block[0].s[0][1].c = (vec4(7.0, 0.0, -4.0, -2.0));
	block[0].s[1][0].a = (ivec3(-6, -6, -1));
	block[0].s[1][0].c = (vec4(0.0, -9.0, -5.0, -1.0));
	block[0].s[1][1].a = (ivec3(-4, 9, -6));
	block[0].s[1][1].c = (vec4(-4.0, 6.0, -2.0, 5.0));
	block[0].s[2][0].a = (ivec3(-4, -1, -5));
	block[0].s[2][0].c = (vec4(7.0, -2.0, -1.0, 0.0));
	block[0].s[2][1].a = (ivec3(-6, 6, 9));
	block[0].s[2][1].c = (vec4(-6.0, 9.0, -5.0, 4.0));
	block[1].v = (vec4(8.0, -2.0, -2.0, -2.0));
	block[1].s[0][0].a = (ivec3(-7, -4, 9));
	block[1].s[0][0].c = (vec4(-5.0, 2.0, 4.0, -7.0));
	block[1].s[0][1].a = (ivec3(-3, -2, 2));
	block[1].s[0][1].c = (vec4(1.0, -8.0, -4.0, 8.0));
	block[1].s[1][0].a = (ivec3(-8, -1, 9));
	block[1].s[1][0].c = (vec4(7.0, 3.0, 9.0, 6.0));
	block[1].s[1][1].a = (ivec3(6, -8, 9));
	block[1].s[1][1].c = (vec4(1.0, 7.0, -4.0, -2.0));
	block[2].v = (vec4(8.0, -3.0, 8.0, 0.0));
	block[2].s[0][0].a = (ivec3(7, -8, 1));
	block[2].s[0][0].c = (vec4(-9.0, 8.0, -1.0, -2.0));
	block[2].s[0][1].a = (ivec3(-7, -5, 4));
	block[2].s[0][1].c = (vec4(9.0, 6.0, -4.0, 0.0));
}
#version 450
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
    Block block[3];
};

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
	allOk = compare_mat3x4(block[0].var, mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block[0].var[1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block[0].var[2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block[1].var[0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block[1].var[1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block[1].var[2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block[2].var[0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block[2].var[1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block[2].var[2] = (vec4(0.0, 4.0, 1.0, -9.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 9.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-9.0, 7.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-1.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(3.0, 0.0, 9.0)) && allOk;
	allOk = compare_float((block[1].padding), 8.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -9.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-5.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(4.0, -4.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(5.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(6.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(2.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	block[1].padding = (1.0);
	block[1].var = (mat3(-3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0, 4.0));
	block[2].padding = (1.0);
	block[2].var = (mat3(-6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat3x4(block[0].var, mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0, -9.0, 0.0, -5.0, -1.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-8.0, 6.0, 3.0, -4.0, -1.0, 2.0, 5.0, -9.0, -3.0, 8.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var[0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block[0].var[1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block[0].var[2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	block[1].padding = (0.0);
	block[1].var[0] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block[1].var[1] = (vec4(-7.0, 6.0, -4.0, 2.0));
	block[1].var[2] = (vec4(7.0, -9.0, 4.0, -1.0));
	block[2].padding = (0.0);
	block[2].var[0] = (vec4(-7.0, 2.0, -6.0, 3.0));
	block[2].var[1] = (vec4(-7.0, 7.0, 1.0, 4.0));
	block[2].var[2] = (vec4(4.0, 1.0, -9.0, 8.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -1.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 2.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, 2.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 5.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(4.0, -5.0, 3.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), 7.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -8.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(8.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(1.0, -8.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(5.0, -6.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	block[1].padding = (-4.0);
	block[1].var = (mat3x4(2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0, 2.0, -4.0, -4.0, -1.0));
	block[2].padding = (4.0);
	block[2].var = (mat3x4(6.0, 0.0, 4.0, -9.0, -2.0, 4.0, -1.0, -5.0, 1.0, -9.0, 5.0, -5.0));
}
#version 450
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
	highp uint a;
	highp float b;
	highp float c;
	highp float d;
	mediump vec3 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec3 f;
	mediump vec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 1u) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, true, true)) && allOk;
	allOk = compare_vec4((blockC.g), vec4(9.0, 6.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockB.e = (vec3(-8.0, -5.0, 0.0));
	blockC.f = (bvec3(true, true, true));
}
#version 450
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
	lowp uint mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a;
	highp mat3x4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[0].a.mA, mat4(-7.0, 3.0, -2.0, 9.0, -9.0, -1.0, -9.0, 1.0, -8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0)) && allOk;
	allOk = compare_uint((blockB[0].a.mB), 4u) && allOk;
	allOk = compare_mat3x4(blockB[0].b[0], mat3x4(8.0, -1.0, 2.0, 0.0, 1.0, 6.0, -5.0, 2.0, 7.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB[1].a.mA, mat4(0.0, -9.0, -3.0, -2.0, 0.0, -6.0, -3.0, 1.0, 8.0, -5.0, 8.0, 8.0, 9.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_uint((blockB[1].a.mB), 2u) && allOk;
	allOk = compare_mat3x4(blockB[1].b[0], mat3x4(6.0, -4.0, 8.0, -4.0, -1.0, -9.0, -5.0, 5.0, -5.0, -4.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (mat4(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0, 3.0));
	blockB[0].a.mB = (2u);
	blockB[1].a.mA = (mat4(1.0, -8.0, -8.0, -1.0, -5.0, 7.0, -5.0, -3.0, -8.0, 6.0, -4.0, -9.0, 8.0, -8.0, -5.0, 1.0));
	blockB[1].a.mB = (0u);
}
#version 450
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
	highp uvec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(5u, 5u)) && allOk;
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
	highp vec2 mA[4];
	bool mB;
	lowp mat3x2 mC;
	mediump mat2x3 mD;
};
layout(std140, buffer_reference) readonly buffer BlockB
{
	mediump ivec3 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat3 b[6];
	sA c;
	lowp mat3x2 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump uvec3 e;
	highp ivec4 f;
	lowp ivec2 g;
	lowp vec3 h;
	bool i[][5];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockC.b[0], mat3(-7.0, -4.0, 2.0, 8.0, -9.0, 1.0, 7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC.b[1], mat3(-1.0, 2.0, 8.0, 1.0, 4.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.b[2], mat3(0.0, -2.0, 8.0, -4.0, 1.0, 9.0, 4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.b[3], mat3(7.0, 3.0, -1.0, -3.0, 2.0, 9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.b[4], mat3(-2.0, -3.0, 1.0, 9.0, 0.0, 3.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockC.b[5], mat3(8.0, 5.0, 4.0, 5.0, 3.0, -2.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec2((blockC.c.mA[0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2((blockC.c.mA[1]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.c.mA[2]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC.c.mA[3]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_bool((blockC.c.mB), false) && allOk;
	allOk = compare_mat3x2(blockC.c.mC, mat3x2(0.0, 4.0, -1.0, -7.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.c.mD, mat2x3(-4.0, 8.0, 4.0, 3.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[0], mat3x2(4.0, 2.0, -8.0, -5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[1], mat3x2(7.0, -8.0, 8.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[2], mat3x2(0.0, -4.0, -3.0, 8.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[3], mat3x2(1.0, 2.0, -6.0, 8.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[4], mat3x2(6.0, -6.0, 3.0, -2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[5], mat3x2(-8.0, 4.0, 9.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[6], mat3x2(-2.0, 6.0, 0.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[7], mat3x2(1.0, -5.0, 0.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockD[0].e), uvec3(6u, 6u, 2u)) && allOk;
	allOk = compare_ivec4((blockD[0].f), ivec4(1, 3, 2, 9)) && allOk;
	allOk = compare_ivec2((blockD[0].g), ivec2(2, -4)) && allOk;
	allOk = compare_vec3((blockD[0].h), vec3(6.0, -2.0, 3.0)) && allOk;
	allOk = compare_bool((blockD[0].i[0][0]), false) && allOk;
	allOk = compare_bool((blockD[0].i[0][1]), false) && allOk;
	allOk = compare_bool((blockD[0].i[0][2]), false) && allOk;
	allOk = compare_bool((blockD[0].i[0][3]), false) && allOk;
	allOk = compare_bool((blockD[0].i[0][4]), true) && allOk;
	allOk = compare_bool((blockD[0].i[1][0]), true) && allOk;
	allOk = compare_bool((blockD[0].i[1][1]), false) && allOk;
	allOk = compare_bool((blockD[0].i[1][2]), false) && allOk;
	allOk = compare_bool((blockD[0].i[1][3]), true) && allOk;
	allOk = compare_bool((blockD[0].i[1][4]), false) && allOk;
	allOk = compare_bool((blockD[0].i[2][0]), true) && allOk;
	allOk = compare_bool((blockD[0].i[2][1]), true) && allOk;
	allOk = compare_bool((blockD[0].i[2][2]), false) && allOk;
	allOk = compare_bool((blockD[0].i[2][3]), true) && allOk;
	allOk = compare_bool((blockD[0].i[2][4]), true) && allOk;
	allOk = compare_bool((blockD[0].i[3][0]), true) && allOk;
	allOk = compare_bool((blockD[0].i[3][1]), true) && allOk;
	allOk = compare_bool((blockD[0].i[3][2]), true) && allOk;
	allOk = compare_bool((blockD[0].i[3][3]), true) && allOk;
	allOk = compare_bool((blockD[0].i[3][4]), false) && allOk;
	allOk = compare_bool((blockD[0].i[4][0]), true) && allOk;
	allOk = compare_bool((blockD[0].i[4][1]), true) && allOk;
	allOk = compare_bool((blockD[0].i[4][2]), true) && allOk;
	allOk = compare_bool((blockD[0].i[4][3]), false) && allOk;
	allOk = compare_bool((blockD[0].i[4][4]), true) && allOk;
	allOk = compare_bool((blockD[0].i[5][0]), false) && allOk;
	allOk = compare_bool((blockD[0].i[5][1]), false) && allOk;
	allOk = compare_bool((blockD[0].i[5][2]), false) && allOk;
	allOk = compare_bool((blockD[0].i[5][3]), false) && allOk;
	allOk = compare_bool((blockD[0].i[5][4]), true) && allOk;
	allOk = compare_bool((blockD[0].i[6][0]), false) && allOk;
	allOk = compare_bool((blockD[0].i[6][1]), true) && allOk;
	allOk = compare_bool((blockD[0].i[6][2]), false) && allOk;
	allOk = compare_bool((blockD[0].i[6][3]), true) && allOk;
	allOk = compare_bool((blockD[0].i[6][4]), true) && allOk;
	allOk = compare_uvec3((blockD[1].e), uvec3(8u, 1u, 4u)) && allOk;
	allOk = compare_ivec4((blockD[1].f), ivec4(8, 8, -1, -3)) && allOk;
	allOk = compare_ivec2((blockD[1].g), ivec2(7, 6)) && allOk;
	allOk = compare_vec3((blockD[1].h), vec3(-4.0, -8.0, -3.0)) && allOk;
	allOk = compare_bool((blockD[1].i[0][0]), true) && allOk;
	allOk = compare_bool((blockD[1].i[0][1]), true) && allOk;
	allOk = compare_bool((blockD[1].i[0][2]), true) && allOk;
	allOk = compare_bool((blockD[1].i[0][3]), false) && allOk;
	allOk = compare_bool((blockD[1].i[0][4]), true) && allOk;
	allOk = compare_bool((blockD[1].i[1][0]), false) && allOk;
	allOk = compare_bool((blockD[1].i[1][1]), true) && allOk;
	allOk = compare_bool((blockD[1].i[1][2]), true) && allOk;
	allOk = compare_bool((blockD[1].i[1][3]), false) && allOk;
	allOk = compare_bool((blockD[1].i[1][4]), false) && allOk;
	allOk = compare_bool((blockD[1].i[2][0]), false) && allOk;
	allOk = compare_bool((blockD[1].i[2][1]), false) && allOk;
	allOk = compare_bool((blockD[1].i[2][2]), true) && allOk;
	allOk = compare_bool((blockD[1].i[2][3]), true) && allOk;
	allOk = compare_bool((blockD[1].i[2][4]), false) && allOk;
	allOk = compare_bool((blockD[1].i[3][0]), true) && allOk;
	allOk = compare_bool((blockD[1].i[3][1]), false) && allOk;
	allOk = compare_bool((blockD[1].i[3][2]), false) && allOk;
	allOk = compare_bool((blockD[1].i[3][3]), false) && allOk;
	allOk = compare_bool((blockD[1].i[3][4]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0] = (mat3x2(-6.0, -8.0, -5.0, 0.0, 4.0, 3.0));
	blockC.d[1] = (mat3x2(-1.0, 9.0, -6.0, -4.0, 3.0, -3.0));
	blockC.d[2] = (mat3x2(-1.0, 6.0, -6.0, -4.0, 3.0, 2.0));
	blockC.d[3] = (mat3x2(9.0, 5.0, 2.0, -3.0, -7.0, 3.0));
	blockC.d[4] = (mat3x2(0.0, 7.0, -4.0, 4.0, -4.0, 3.0));
	blockC.d[5] = (mat3x2(-4.0, -1.0, 0.0, -6.0, 4.0, -6.0));
	blockC.d[6] = (mat3x2(-2.0, 6.0, -9.0, -9.0, -2.0, -7.0));
	blockC.d[7] = (mat3x2(4.0, -4.0, -2.0, 5.0, -9.0, -1.0));
	blockD[0].e = (uvec3(8u, 2u, 3u));
	blockD[0].f = (ivec4(-8, 8, -7, 5));
	blockD[0].g = (ivec2(-5, -4));
	blockD[0].h = (vec3(4.0, -6.0, -8.0));
	blockD[0].i[0][0] = (true);
	blockD[0].i[0][1] = (false);
	blockD[0].i[0][2] = (false);
	blockD[0].i[0][3] = (true);
	blockD[0].i[0][4] = (true);
	blockD[0].i[1][0] = (true);
	blockD[0].i[1][1] = (false);
	blockD[0].i[1][2] = (true);
	blockD[0].i[1][3] = (true);
	blockD[0].i[1][4] = (true);
	blockD[0].i[2][0] = (true);
	blockD[0].i[2][1] = (false);
	blockD[0].i[2][2] = (true);
	blockD[0].i[2][3] = (true);
	blockD[0].i[2][4] = (false);
	blockD[0].i[3][0] = (false);
	blockD[0].i[3][1] = (true);
	blockD[0].i[3][2] = (true);
	blockD[0].i[3][3] = (true);
	blockD[0].i[3][4] = (true);
	blockD[0].i[4][0] = (false);
	blockD[0].i[4][1] = (false);
	blockD[0].i[4][2] = (true);
	blockD[0].i[4][3] = (true);
	blockD[0].i[4][4] = (true);
	blockD[0].i[5][0] = (true);
	blockD[0].i[5][1] = (true);
	blockD[0].i[5][2] = (true);
	blockD[0].i[5][3] = (false);
	blockD[0].i[5][4] = (true);
	blockD[0].i[6][0] = (true);
	blockD[0].i[6][1] = (false);
	blockD[0].i[6][2] = (false);
	blockD[0].i[6][3] = (false);
	blockD[0].i[6][4] = (true);
	blockD[1].e = (uvec3(7u, 1u, 0u));
	blockD[1].f = (ivec4(6, -1, -8, 7));
	blockD[1].g = (ivec2(-1, 8));
	blockD[1].h = (vec3(-2.0, 9.0, 6.0));
	blockD[1].i[0][0] = (true);
	blockD[1].i[0][1] = (true);
	blockD[1].i[0][2] = (false);
	blockD[1].i[0][3] = (false);
	blockD[1].i[0][4] = (false);
	blockD[1].i[1][0] = (false);
	blockD[1].i[1][1] = (true);
	blockD[1].i[1][2] = (true);
	blockD[1].i[1][3] = (false);
	blockD[1].i[1][4] = (false);
	blockD[1].i[2][0] = (true);
	blockD[1].i[2][1] = (false);
	blockD[1].i[2][2] = (true);
	blockD[1].i[2][3] = (true);
	blockD[1].i[2][4] = (true);
	blockD[1].i[3][0] = (false);
	blockD[1].i[3][1] = (false);
	blockD[1].i[3][2] = (false);
	blockD[1].i[3][3] = (true);
	blockD[1].i[3][4] = (true);
}
#version 450
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
	bool mB;
	mediump uvec4 mC;
	lowp uvec4 mD;
};
struct sB
{
	sA mA;
	mediump uvec4 mB;
	mediump mat3 mC;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp uvec3 a;
	highp vec2 b;
	bvec2 c;
	sB d[6];
	mediump int e;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp mat2x3 f;
	highp ivec2 g;
	lowp uvec2 h;
	highp float i;
	highp ivec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(2.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockB.d[0].mA.mA), ivec4(-9, 2, -1, -3)) && allOk;
	allOk = compare_bool((blockB.d[0].mA.mB), false) && allOk;
	allOk = compare_uvec4((blockB.d[0].mA.mC), uvec4(5u, 5u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.d[0].mA.mD), uvec4(3u, 3u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.d[0].mB), uvec4(2u, 9u, 1u, 9u)) && allOk;
	allOk = compare_mat3(blockB.d[0].mC, mat3(8.0, -1.0, 4.0, 7.0, -6.0, 1.0, 5.0, -2.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockB.d[1].mA.mA), ivec4(-9, -8, 0, -6)) && allOk;
	allOk = compare_bool((blockB.d[1].mA.mB), true) && allOk;
	allOk = compare_uvec4((blockB.d[1].mA.mC), uvec4(3u, 9u, 3u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.d[1].mA.mD), uvec4(0u, 4u, 9u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.d[1].mB), uvec4(9u, 1u, 1u, 0u)) && allOk;
	allOk = compare_mat3(blockB.d[1].mC, mat3(-6.0, 7.0, -3.0, -5.0, 9.0, -9.0, -3.0, 7.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockB.d[2].mA.mA), ivec4(-5, -1, -3, 5)) && allOk;
	allOk = compare_bool((blockB.d[2].mA.mB), true) && allOk;
	allOk = compare_uvec4((blockB.d[2].mA.mC), uvec4(5u, 1u, 2u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.d[2].mA.mD), uvec4(0u, 2u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.d[2].mB), uvec4(7u, 4u, 1u, 8u)) && allOk;
	allOk = compare_mat3(blockB.d[2].mC, mat3(-2.0, 8.0, -9.0, -3.0, -8.0, -6.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockB.d[3].mA.mA), ivec4(3, -3, 5, -7)) && allOk;
	allOk = compare_bool((blockB.d[3].mA.mB), false) && allOk;
	allOk = compare_uvec4((blockB.d[3].mA.mC), uvec4(9u, 7u, 5u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.d[3].mA.mD), uvec4(2u, 7u, 7u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.d[3].mB), uvec4(6u, 0u, 1u, 6u)) && allOk;
	allOk = compare_mat3(blockB.d[3].mC, mat3(8.0, -5.0, 2.0, 6.0, -6.0, 7.0, 4.0, -2.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockB.d[4].mA.mA), ivec4(1, 9, -2, 8)) && allOk;
	allOk = compare_bool((blockB.d[4].mA.mB), true) && allOk;
	allOk = compare_uvec4((blockB.d[4].mA.mC), uvec4(8u, 8u, 5u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.d[4].mA.mD), uvec4(5u, 2u, 9u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.d[4].mB), uvec4(0u, 3u, 1u, 2u)) && allOk;
	allOk = compare_mat3(blockB.d[4].mC, mat3(5.0, 1.0, -3.0, -1.0, -3.0, -5.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockB.d[5].mA.mA), ivec4(7, 2, 1, 3)) && allOk;
	allOk = compare_bool((blockB.d[5].mA.mB), true) && allOk;
	allOk = compare_uvec4((blockB.d[5].mA.mC), uvec4(6u, 7u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.d[5].mA.mD), uvec4(4u, 6u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.d[5].mB), uvec4(7u, 6u, 1u, 9u)) && allOk;
	allOk = compare_mat3(blockB.d[5].mC, mat3(8.0, -9.0, -1.0, -9.0, -2.0, 4.0, 7.0, 2.0, 6.0)) && allOk;
	allOk = compare_int((blockB.e), 7) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(-2.0, 5.0, 2.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(4, 7)) && allOk;
	allOk = compare_uvec2((blockC.h), uvec2(1u, 7u)) && allOk;
	allOk = compare_float((blockC.i), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(7u, 0u, 3u));
	blockB.b = (vec2(2.0, -2.0));
	blockB.d[0].mA.mA = (ivec4(6, -1, -9, 3));
	blockB.d[0].mA.mB = (false);
	blockB.d[0].mA.mC = (uvec4(2u, 9u, 6u, 2u));
	blockB.d[0].mA.mD = (uvec4(7u, 6u, 3u, 6u));
	blockB.d[0].mB = (uvec4(1u, 2u, 7u, 7u));
	blockB.d[0].mC = (mat3(-2.0, 2.0, -1.0, 0.0, -5.0, -7.0, 2.0, 8.0, 1.0));
	blockB.d[1].mA.mA = (ivec4(-6, 4, -7, 6));
	blockB.d[1].mA.mB = (true);
	blockB.d[1].mA.mC = (uvec4(0u, 5u, 3u, 7u));
	blockB.d[1].mA.mD = (uvec4(7u, 0u, 5u, 8u));
	blockB.d[1].mB = (uvec4(8u, 8u, 9u, 3u));
	blockB.d[1].mC = (mat3(-5.0, 0.0, -4.0, -1.0, -1.0, 5.0, -8.0, -6.0, -2.0));
	blockB.d[2].mA.mA = (ivec4(-5, -4, 8, -7));
	blockB.d[2].mA.mB = (true);
	blockB.d[2].mA.mC = (uvec4(7u, 7u, 8u, 3u));
	blockB.d[2].mA.mD = (uvec4(6u, 2u, 2u, 5u));
	blockB.d[2].mB = (uvec4(6u, 5u, 8u, 9u));
	blockB.d[2].mC = (mat3(9.0, 6.0, -7.0, -8.0, 7.0, 2.0, 6.0, 7.0, 3.0));
	blockB.d[3].mA.mA = (ivec4(4, -3, -3, 5));
	blockB.d[3].mA.mB = (false);
	blockB.d[3].mA.mC = (uvec4(3u, 5u, 1u, 1u));
	blockB.d[3].mA.mD = (uvec4(8u, 0u, 0u, 3u));
	blockB.d[3].mB = (uvec4(6u, 4u, 4u, 2u));
	blockB.d[3].mC = (mat3(7.0, -3.0, -8.0, -9.0, 0.0, 2.0, -8.0, -2.0, 1.0));
	blockB.d[4].mA.mA = (ivec4(6, 7, -8, 3));
	blockB.d[4].mA.mB = (true);
	blockB.d[4].mA.mC = (uvec4(5u, 4u, 9u, 7u));
	blockB.d[4].mA.mD = (uvec4(6u, 4u, 2u, 0u));
	blockB.d[4].mB = (uvec4(4u, 8u, 9u, 6u));
	blockB.d[4].mC = (mat3(9.0, 4.0, -5.0, -1.0, -9.0, 4.0, 9.0, -9.0, -4.0));
	blockB.d[5].mA.mA = (ivec4(9, 9, 5, 6));
	blockB.d[5].mA.mB = (false);
	blockB.d[5].mA.mC = (uvec4(8u, 5u, 9u, 6u));
	blockB.d[5].mA.mD = (uvec4(6u, 4u, 6u, 5u));
	blockB.d[5].mB = (uvec4(2u, 6u, 2u, 3u));
	blockB.d[5].mC = (mat3(-2.0, 7.0, 4.0, -8.0, -6.0, 9.0, -5.0, -1.0, -5.0));
	blockC.f = (mat2x3(5.0, -8.0, -5.0, 9.0, -5.0, 2.0));
	blockC.g = (ivec2(2, 5));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec3 b;
	layout(offset = 16) lowp ivec2 c;
	layout(offset = 32) mediump vec3 d;
	layout(offset = 48) mediump uvec3 e;
	layout(offset = 60) highp float f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec4 g;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp vec4 h;
	layout(offset = 16) lowp uvec3 i;
	layout(offset = 32) bvec2 j[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC.b), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec2((blockC.c), ivec2(1, -8)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(6.0, -5.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(0u, 3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6);
	blockB[1].a = (-2);
	blockC.b = (bvec3(false, true, true));
	blockC.c = (ivec2(8, 1));
	blockC.d = (vec3(9.0, 5.0, -4.0));
	blockC.e = (uvec3(4u, 2u, 4u));
	blockC.f = (3.0);
	blockD.g = (bvec4(false, true, false, false));
	blockE.h = (vec4(-7.0, 4.0, 9.0, -8.0));
	blockE.i = (uvec3(9u, 5u, 1u));
	blockE.j[0] = (bvec2(false, true));
}
#version 450
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
	layout(offset = 0) lowp vec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec2 b;
	layout(offset = 8) lowp uvec2 c;
	layout(offset = 16) lowp vec3 d;
	layout(offset = 32) lowp vec3 e;
	layout(offset = 48) lowp ivec4 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 g;
	layout(offset = 8) lowp int h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp float i;
	layout(offset = 16) bvec4 j;
	layout(offset = 32) bvec2 k;
	layout(offset = 48) bvec4 l;
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.c), uvec2(7u, 8u)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(1.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(-4.0, -2.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(2, -4, 7, 1)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(false, true)) && allOk;
	allOk = compare_bvec4((blockE.j), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec2((blockE.k), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockE.l), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-3.0, -9.0, -1.0, -1.0));
	blockC.b = (vec2(-1.0, -7.0));
	blockC.c = (uvec2(2u, 1u));
	blockC.d = (vec3(-3.0, 5.0, 2.0));
	blockC.f = (ivec4(3, -6, -7, -9));
	blockD.h = (-2);
	blockE.i = (-8.0);
	blockE.j = (bvec4(true, true, true, true));
	blockE.k = (bvec2(true, true));
}
#version 450
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
	layout(offset = 4) bool b;
	layout(offset = 8) mediump vec2 c;
	layout(offset = 16) bvec2 d;
	layout(offset = 32) mediump uvec4 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec4 f;
	layout(offset = 16) bool g[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec2 h;
	layout(offset = 8) lowp int i;
	layout(offset = 16) bvec3 j;
	layout(offset = 32) lowp uvec2 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 9u) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockB.e), uvec4(0u, 3u, 8u, 5u)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(-6, 4, 2, -1)) && allOk;
	allOk = compare_bool((blockC.g[0]), true) && allOk;
	allOk = compare_vec2((blockD.h), vec2(0.0, 1.0)) && allOk;
	allOk = compare_int((blockD.i), 9) && allOk;
	allOk = compare_uvec2((blockD.k), uvec2(6u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9u);
	blockB.b = (true);
	blockB.c = (vec2(-5.0, -1.0));
	blockB.d = (bvec2(true, false));
	blockB.e = (uvec4(5u, 0u, 4u, 3u));
	blockC.f = (ivec4(9, 4, 4, -4));
	blockC.g[0] = (true);
	blockD.h = (vec2(-5.0, -2.0));
	blockD.i = (7);
	blockD.j = (bvec3(true, true, true));
}
#version 450
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
	layout(offset = 0) mediump ivec2 a;
	layout(offset = 16) lowp uvec4 b;
	layout(offset = 32) highp uint c;
	layout(offset = 36) lowp ivec3 d;
	layout(offset = 48) lowp int e[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec4 f;
	layout(offset = 16) bvec2 g;
	layout(offset = 24) mediump uint h;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) mediump int i;
	layout(offset = 4) bool j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-3, 6)) && allOk;
	allOk = compare_ivec3((blockB.d), ivec3(-9, -4, 4)) && allOk;
	allOk = compare_int((blockB.e[0]), -5) && allOk;
	allOk = compare_vec4((blockC.f), vec4(6.0, -9.0, 0.0, -4.0)) && allOk;
	allOk = compare_uint((blockC.h), 6u) && allOk;
	allOk = compare_int((blockD.i), -3) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(3u, 0u, 8u, 5u));
	blockB.c = (1u);
	blockB.d = (ivec3(3, -9, 8));
	blockB.e[0] = (5);
	blockC.g = (bvec2(true, false));
	blockC.h = (2u);
}
#version 450
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
	layout(offset = 0) mediump float b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].a), vec2(-3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(-5.0, 5.0));
	blockC.b = (-3.0);
}
#version 450
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
	mediump uvec2 a;
	mediump mat4x3 b;
	lowp vec2 c;
	bvec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a), uvec2(7u, 1u)) && allOk;
	allOk = compare_mat4x3(blockB[0].b, mat4x3(2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec2(7u, 8u));
	blockB[0].b = (mat4x3(-2.0, 6.0, 0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0, 5.0, 8.0));
	blockB[0].c = (vec2(6.0, 2.0));
	blockB[0].d[0] = (bvec2(true, true));
	blockB[0].d[1] = (bvec2(true, false));
	blockB[0].d[2] = (bvec2(false, true));
	blockB[0].d[3] = (bvec2(false, false));
	blockB[0].d[4] = (bvec2(false, false));
	blockB[0].d[5] = (bvec2(false, true));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(row_major, buffer_reference) buffer BlockB
{
	layout(offset = 0) bvec3 a[1];
	layout(offset = 16) lowp ivec2 b[1];
	layout(offset = 24) highp mat2x3 c;
	layout(offset = 48) mediump vec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].c, mat2x3(9.0, -5.0, -6.0, 3.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].d), vec2(7.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].b[0]), ivec2(-6, 5)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].c, mat2x3(-7.0, -7.0, 0.0, -4.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].d), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].b[0]), ivec2(-2, 1)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].c, mat2x3(-6.0, -1.0, 9.0, 0.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].d), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].b[0]), ivec2(6, 9)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(3)].c, mat2x3(9.0, -5.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].d), vec2(1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (bvec3(true, false, true));
	blockB[nonuniformEXT(0)].b[0] = (ivec2(8, 4));
	blockB[nonuniformEXT(0)].d = (vec2(-4.0, -8.0));
	blockB[nonuniformEXT(1)].a[0] = (bvec3(false, true, false));
	blockB[nonuniformEXT(1)].b[0] = (ivec2(-6, 4));
	blockB[nonuniformEXT(1)].d = (vec2(-8.0, 5.0));
	blockB[nonuniformEXT(2)].a[0] = (bvec3(false, false, false));
	blockB[nonuniformEXT(2)].b[0] = (ivec2(5, 0));
	blockB[nonuniformEXT(2)].d = (vec2(7.0, -1.0));
	blockB[nonuniformEXT(3)].a[0] = (bvec3(true, true, true));
	blockB[nonuniformEXT(3)].b[0] = (ivec2(5, 8));
	blockB[nonuniformEXT(3)].d = (vec2(-1.0, -2.0));
}
#version 450
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
	lowp mat3 b;
	int16_t c;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	u16vec4 d;
	lowp vec3 e[1];
	lowp vec4 f[1];
	u16vec3 g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 h;
	lowp ivec4 i;
	i16vec4 j[1];
	lowp mat3x2 k;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	i16vec4 l;
	f16vec2 m;
	lowp vec2 n;
	highp ivec4 o;
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_int16_t(int(blockB.c), -9) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.d), uvec4(3u, 8u, 6u, 1u)) && allOk;
	allOk = compare_vec3((blockC.e[0]), vec3(-6.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.f[0]), vec4(5.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockD.i), ivec4(-9, -8, 8, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[0]), ivec4(9, -9, -2, 6)) && allOk;
	allOk = compare_mat3x2(blockD.k, mat3x2(-7.0, 9.0, 8.0, 7.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec2((blockE.n), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockE.o), ivec4(-3, 3, 3, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = int16_t(9);
	blockC.d = u16vec4(uvec4(6u, 6u, 3u, 2u));
	blockD.h = (ivec4(-8, -7, -2, 5));
	blockD.i = (ivec4(1, 3, -3, -1));
	blockD.j[0] = i16vec4(ivec4(1, -6, -5, -4));
	blockE.l = i16vec4(ivec4(2, -4, 1, 6));
	blockE.n = (vec2(7.0, -9.0));
}
#version 450
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
	highp mat2x3 a;
	lowp uint b;
	i16vec3 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat4x3 d;
	lowp ivec2 e;
	f16vec3 f;
	lowp mat4x3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-5.0, -6.0, 9.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(-1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(4, -8)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.f), vec3(-3.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(3.0, 2.0, 4.0, -4.0, 2.0, 9.0));
	blockB.b = (2u);
	blockC.f = f16vec3(vec3(-9.0, -5.0, 4.0));
	blockC.g[0] = (mat4x3(-3.0, -8.0, -8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0, -2.0, -6.0, -9.0));
	blockC.g[1] = (mat4x3(2.0, 6.0, -9.0, -4.0, 6.0, 0.0, -2.0, -5.0, -5.0, -4.0, -9.0, 7.0));
	blockC.g[2] = (mat4x3(-1.0, -8.0, 9.0, 2.0, 5.0, -2.0, -5.0, 0.0, -4.0, 9.0, 0.0, -5.0));
	blockC.g[3] = (mat4x3(8.0, -4.0, 6.0, -6.0, 2.0, 7.0, 8.0, 7.0, -6.0, -2.0, 8.0, 6.0));
}
#version 450
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
	lowp mat4x2 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	f16vec4 b;
	mediump uvec3 c;
	i16vec2 d;
	bvec3 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump mat3x2 f;
	bvec3 g;
	i16vec3 h;
	mediump uvec2 i;
	f16vec3 j[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	mediump ivec4 k;
	bool l;
	highp ivec3 m;
	mediump mat4x2 n;
	mediump mat3 o[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a[0], mat4x2(4.0, 1.0, -1.0, 9.0, 1.0, -6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[1], mat4x2(2.0, -9.0, -9.0, -6.0, 6.0, -5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[2], mat4x2(7.0, -2.0, -7.0, -7.0, -1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[3], mat4x2(-4.0, 9.0, -1.0, -7.0, 8.0, 9.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[4], mat4x2(-5.0, -6.0, -9.0, -5.0, 7.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[5], mat4x2(-5.0, -1.0, 8.0, -3.0, -3.0, -6.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[6], mat4x2(6.0, 3.0, -7.0, 3.0, 2.0, 1.0, -2.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.b), vec4(8.0, 7.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(4u, 5u, 2u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.d), ivec2(5, 4)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(true, false, true)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.h), ivec3(-1, 6, 6)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[0]), vec3(5.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[1]), vec3(-1.0, -9.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[2]), vec3(6.0, -8.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[3]), vec3(-8.0, -6.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[4]), vec3(8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[5]), vec3(0.0, 7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[6]), vec3(-9.0, 6.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockE.k), ivec4(-6, -9, 9, -8)) && allOk;
	allOk = compare_bool((blockE.l), true) && allOk;
	allOk = compare_ivec3((blockE.m), ivec3(0, -8, 6)) && allOk;
	allOk = compare_mat4x2(blockE.n, mat4x2(-6.0, 8.0, -9.0, 5.0, 0.0, 5.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(5.0, 1.0, 7.0, -2.0, -9.0, -1.0, -6.0, -3.0));
	blockB.a[1] = (mat4x2(-9.0, -4.0, -9.0, 3.0, -2.0, 4.0, -4.0, 9.0));
	blockB.a[2] = (mat4x2(1.0, 9.0, 2.0, 2.0, -6.0, -1.0, 5.0, -7.0));
	blockB.a[3] = (mat4x2(3.0, 5.0, -7.0, 5.0, -5.0, 7.0, 7.0, -3.0));
	blockB.a[4] = (mat4x2(2.0, 7.0, -2.0, -5.0, 9.0, 9.0, 5.0, -3.0));
	blockB.a[5] = (mat4x2(8.0, -9.0, -3.0, -2.0, 7.0, 9.0, -4.0, 7.0));
	blockB.a[6] = (mat4x2(8.0, 9.0, -1.0, -2.0, 5.0, -5.0, -4.0, -8.0));
	blockC.b = f16vec4(vec4(-4.0, 0.0, 8.0, 2.0));
	blockC.c = (uvec3(8u, 5u, 7u));
	blockC.d = i16vec2(ivec2(-9, -2));
	blockC.e[0] = (bvec3(true, false, true));
	blockC.e[1] = (bvec3(false, true, false));
	blockC.e[2] = (bvec3(false, false, false));
	blockC.e[3] = (bvec3(false, true, false));
	blockC.e[4] = (bvec3(false, false, false));
	blockD.f = (mat3x2(7.0, -9.0, -6.0, -2.0, 7.0, 3.0));
	blockD.g = (bvec3(true, false, false));
	blockD.h = i16vec3(ivec3(1, -5, 8));
	blockD.j[0] = f16vec3(vec3(0.0, 6.0, 3.0));
	blockD.j[1] = f16vec3(vec3(8.0, -7.0, 2.0));
	blockD.j[2] = f16vec3(vec3(8.0, -4.0, 1.0));
	blockD.j[3] = f16vec3(vec3(-7.0, 6.0, -2.0));
	blockD.j[4] = f16vec3(vec3(-4.0, 7.0, -9.0));
	blockD.j[5] = f16vec3(vec3(1.0, -9.0, -7.0));
	blockD.j[6] = f16vec3(vec3(-7.0, -7.0, -1.0));
}
#version 450
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
	layout(offset = 0) u16vec3 a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) bvec2 c;
	layout(offset = 40) i16vec4 d;
	layout(offset = 48) mediump vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(8u, 5u, 4u)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(false, true)) && allOk;
	allOk = compare_vec3((blockB.e), vec3(8.0, 3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(8u, 5u, 4u));
	blockB.b = (bvec4(true, true, true, false));
	blockB.c = (bvec2(false, true));
	blockB.d = i16vec4(ivec4(6, 4, 6, -5));
	blockB.e = (vec3(2.0, -9.0, -8.0));
}
#version 450
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
	layout(offset = 0) highp ivec4 a;
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

	blockB.a = (ivec4(-7, 0, 2, -8));
}
#version 450
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
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	bool a[1];
	u16vec3 b;
	u16vec2 c;
	highp vec3 d;
	sA e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

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

layout(std140, buffer_reference) buffer BlockB
{
	uint8_t a;
	int8_t b;
	uint8_t c[1];
	uint8_t d;
	lowp int e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = int8_t(3);
	blockB.c[0] = uint8_t(0u);
	blockB.e = (-4);
}
#version 450
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
	mediump ivec2 a;
	bvec2 b[][4];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b[0][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[0][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[2][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[2][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[3][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[3][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[3][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[3][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[4][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[4][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[4][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[4][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[5][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[5][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[5][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[5][3]), bvec2(true, false)) && allOk;
	allOk = compare_mat4(blockC.c[0], mat4(0.0, 4.0, 7.0, 2.0, 5.0, -3.0, 6.0, 7.0, 4.0, 5.0, 8.0, 5.0, 7.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(blockC.c[1], mat4(-7.0, -5.0, 7.0, -6.0, 4.0, 9.0, -2.0, 2.0, 3.0, -7.0, -5.0, 9.0, 6.0, 6.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.c[2], mat4(-4.0, 3.0, -5.0, -8.0, 7.0, 7.0, 1.0, 3.0, 9.0, -4.0, -8.0, 4.0, 8.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC.c[3], mat4(0.0, 5.0, 7.0, -4.0, 9.0, 6.0, 2.0, 9.0, -1.0, -9.0, 4.0, -5.0, 7.0, 7.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(5, -5));
	blockB.b[0][0] = (bvec2(true, true));
	blockB.b[0][1] = (bvec2(true, false));
	blockB.b[0][2] = (bvec2(true, false));
	blockB.b[0][3] = (bvec2(false, false));
	blockB.b[1][0] = (bvec2(false, true));
	blockB.b[1][1] = (bvec2(true, false));
	blockB.b[1][2] = (bvec2(false, false));
	blockB.b[1][3] = (bvec2(true, false));
	blockB.b[2][0] = (bvec2(true, false));
	blockB.b[2][1] = (bvec2(true, false));
	blockB.b[2][2] = (bvec2(false, false));
	blockB.b[2][3] = (bvec2(false, false));
	blockB.b[3][0] = (bvec2(false, true));
	blockB.b[3][1] = (bvec2(false, true));
	blockB.b[3][2] = (bvec2(true, false));
	blockB.b[3][3] = (bvec2(true, true));
	blockB.b[4][0] = (bvec2(true, false));
	blockB.b[4][1] = (bvec2(false, true));
	blockB.b[4][2] = (bvec2(true, false));
	blockB.b[4][3] = (bvec2(true, true));
	blockB.b[5][0] = (bvec2(false, true));
	blockB.b[5][1] = (bvec2(false, false));
	blockB.b[5][2] = (bvec2(true, true));
	blockB.b[5][3] = (bvec2(true, true));
	blockC.c[0] = (mat4(-2.0, 6.0, 0.0, -7.0, 3.0, -7.0, -1.0, -5.0, 1.0, 4.0, -3.0, 4.0, 5.0, 0.0, 7.0, -5.0));
	blockC.c[1] = (mat4(0.0, -3.0, 0.0, 8.0, -6.0, 4.0, -6.0, -7.0, -6.0, 7.0, -6.0, -5.0, 3.0, 9.0, -3.0, 5.0));
	blockC.c[2] = (mat4(9.0, 4.0, 7.0, -3.0, -1.0, 1.0, 1.0, -3.0, -8.0, 7.0, 9.0, 0.0, 4.0, 1.0, -4.0, 1.0));
	blockC.c[3] = (mat4(-6.0, 3.0, 8.0, 4.0, 9.0, 9.0, -4.0, 9.0, -2.0, -7.0, 5.0, 9.0, 0.0, -6.0, -1.0, -7.0));
}
#version 450
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
	bool a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp uvec2 b;
	u8vec2 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	i8vec2 d[];
};
layout(std140, buffer_reference) buffer BlockE
{
	lowp ivec3 e;
	mediump uvec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockC.c[0]), uvec2(7u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.c[1]), uvec2(6u, 6u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.d[0]), ivec2(7, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.d[1]), ivec2(1, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.d[2]), ivec2(4294967291, 4294967288)) && allOk;
	allOk = compare_uvec3((blockE.f[0]), uvec3(6u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.f[1]), uvec3(5u, 6u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.f[2]), uvec3(6u, 0u, 0u)) && allOk;
	allOk = compare_uvec3((blockE.f[3]), uvec3(0u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockE.f[4]), uvec3(2u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((blockE.f[5]), uvec3(1u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0] = u8vec2(uvec2(4u, 7u));
	blockC.c[1] = u8vec2(uvec2(9u, 7u));
	blockD.d[0] = i8vec2(ivec2(8, 4294967295));
	blockD.d[1] = i8vec2(ivec2(7, 4294967287));
	blockD.d[2] = i8vec2(ivec2(4294967293, 4294967295));
	blockE.e = (ivec3(6, -2, -4));
	blockE.f[0] = (uvec3(7u, 8u, 1u));
	blockE.f[1] = (uvec3(6u, 5u, 0u));
	blockE.f[2] = (uvec3(5u, 5u, 3u));
	blockE.f[3] = (uvec3(6u, 1u, 7u));
	blockE.f[4] = (uvec3(9u, 9u, 0u));
	blockE.f[5] = (uvec3(0u, 3u, 0u));
}
#version 450
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
	mediump mat3 mA[6];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockB
{
	u8vec3 a[6];
	bool b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bvec2 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp uint d;
	lowp mat4 e;
	int8_t f;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	bvec2 g;
	lowp mat2 h;
	i8vec3 i;
	mediump mat2x3 j;
	sA k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b[0]), true) && allOk;
	allOk = compare_bool((blockB.b[1]), true) && allOk;
	allOk = compare_bool((blockB.b[2]), false) && allOk;
	allOk = compare_bool((blockB.b[3]), true) && allOk;
	allOk = compare_bool((blockB.b[4]), false) && allOk;
	allOk = compare_bool((blockB.b[5]), true) && allOk;
	allOk = compare_bool((blockB.b[6]), false) && allOk;
	allOk = compare_bool((blockB.b[7]), true) && allOk;
	allOk = compare_bvec2((blockC[0].c[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].c[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].c[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].c[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].c[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].c[5]), bvec2(true, false)) && allOk;
	allOk = compare_uint((blockD.d), 0u) && allOk;
	allOk = compare_mat4(blockD.e, mat4(-7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0, -2.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(blockE[0].h, mat2(-7.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockE[0].j, mat2x3(2.0, -4.0, -5.0, 1.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2(blockE[1].h, mat2(-2.0, -1.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockE[1].j, mat2x3(-2.0, -8.0, 7.0, -4.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2(blockE[2].h, mat2(-5.0, -3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockE[2].j, mat2x3(3.0, 6.0, 4.0, -9.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c[0] = (bvec2(true, false));
	blockC[0].c[1] = (bvec2(true, false));
	blockC[0].c[2] = (bvec2(true, true));
	blockC[0].c[3] = (bvec2(true, false));
	blockC[0].c[4] = (bvec2(true, true));
	blockC[0].c[5] = (bvec2(false, true));
	blockD.d = (5u);
	blockD.f = int8_t(8);
	blockE[0].g = (bvec2(false, false));
	blockE[0].i = i8vec3(ivec3(4294967293, 4294967290, 4));
	blockE[0].j = (mat2x3(-9.0, 5.0, 1.0, -9.0, 6.0, -7.0));
	blockE[0].k[0].mA[0] = (mat3(-8.0, -2.0, 6.0, 4.0, -3.0, 4.0, 9.0, -8.0, -8.0));
	blockE[0].k[0].mA[1] = (mat3(5.0, -9.0, -3.0, -3.0, -3.0, -1.0, -6.0, 6.0, 4.0));
	blockE[0].k[0].mA[2] = (mat3(-3.0, 8.0, 5.0, -7.0, -6.0, 0.0, -5.0, -7.0, 4.0));
	blockE[0].k[0].mA[3] = (mat3(-8.0, -7.0, -7.0, -5.0, -3.0, -7.0, -5.0, 3.0, -1.0));
	blockE[0].k[0].mA[4] = (mat3(-5.0, -9.0, -2.0, -7.0, -6.0, 9.0, 4.0, 1.0, -6.0));
	blockE[0].k[0].mA[5] = (mat3(8.0, 6.0, -1.0, -4.0, -9.0, -4.0, -7.0, 9.0, 0.0));
	blockE[0].k[1].mA[0] = (mat3(-3.0, 8.0, -5.0, -6.0, 2.0, -1.0, -9.0, -6.0, -1.0));
	blockE[0].k[1].mA[1] = (mat3(9.0, -8.0, -2.0, -4.0, -8.0, 9.0, 8.0, 9.0, -7.0));
	blockE[0].k[1].mA[2] = (mat3(8.0, -6.0, 6.0, -7.0, -3.0, -2.0, -5.0, -9.0, 6.0));
	blockE[0].k[1].mA[3] = (mat3(-3.0, -7.0, -8.0, 3.0, -4.0, 2.0, 9.0, 7.0, -9.0));
	blockE[0].k[1].mA[4] = (mat3(-7.0, -2.0, 6.0, -3.0, -6.0, 2.0, 2.0, 3.0, -9.0));
	blockE[0].k[1].mA[5] = (mat3(-6.0, 0.0, 3.0, -5.0, -2.0, 2.0, -5.0, 5.0, 0.0));
	blockE[0].k[2].mA[0] = (mat3(5.0, 6.0, 9.0, -4.0, 1.0, 4.0, -7.0, -7.0, 8.0));
	blockE[0].k[2].mA[1] = (mat3(7.0, -5.0, 7.0, -3.0, 5.0, -7.0, 6.0, 1.0, -6.0));
	blockE[0].k[2].mA[2] = (mat3(0.0, 8.0, 3.0, 7.0, 3.0, 8.0, 7.0, 4.0, 2.0));
	blockE[0].k[2].mA[3] = (mat3(-6.0, -7.0, 1.0, -9.0, -2.0, 3.0, -4.0, 8.0, -1.0));
	blockE[0].k[2].mA[4] = (mat3(5.0, -4.0, 3.0, 0.0, -8.0, 1.0, 6.0, 9.0, 9.0));
	blockE[0].k[2].mA[5] = (mat3(-4.0, -6.0, -7.0, -6.0, 3.0, -4.0, -6.0, 0.0, 7.0));
	blockE[0].k[3].mA[0] = (mat3(-2.0, -5.0, -5.0, 7.0, -4.0, 2.0, 2.0, 1.0, -3.0));
	blockE[0].k[3].mA[1] = (mat3(5.0, -7.0, 2.0, -6.0, 6.0, -6.0, 8.0, 5.0, 7.0));
	blockE[0].k[3].mA[2] = (mat3(8.0, 7.0, -6.0, 4.0, 3.0, 6.0, -9.0, -8.0, 9.0));
	blockE[0].k[3].mA[3] = (mat3(8.0, 2.0, 5.0, -2.0, -4.0, -1.0, 7.0, -5.0, 4.0));
	blockE[0].k[3].mA[4] = (mat3(-3.0, 6.0, -6.0, 2.0, -1.0, 3.0, 4.0, 1.0, 2.0));
	blockE[0].k[3].mA[5] = (mat3(-4.0, 9.0, -3.0, -6.0, 9.0, 9.0, 2.0, -4.0, -1.0));
	blockE[0].k[4].mA[0] = (mat3(1.0, -7.0, -7.0, -7.0, 8.0, -2.0, 2.0, 3.0, -7.0));
	blockE[0].k[4].mA[1] = (mat3(-2.0, -4.0, -9.0, -6.0, -1.0, -6.0, -6.0, 3.0, 8.0));
	blockE[0].k[4].mA[2] = (mat3(9.0, 2.0, 6.0, -6.0, -9.0, 4.0, 9.0, -4.0, -8.0));
	blockE[0].k[4].mA[3] = (mat3(7.0, -6.0, 4.0, -8.0, 4.0, 0.0, 7.0, 2.0, -6.0));
	blockE[0].k[4].mA[4] = (mat3(-8.0, 0.0, -4.0, 7.0, -6.0, 2.0, -6.0, 1.0, -5.0));
	blockE[0].k[4].mA[5] = (mat3(-5.0, 1.0, 7.0, 4.0, 0.0, 6.0, -6.0, -3.0, 7.0));
	blockE[0].k[5].mA[0] = (mat3(5.0, -7.0, -4.0, -2.0, 8.0, -4.0, 6.0, -7.0, 8.0));
	blockE[0].k[5].mA[1] = (mat3(-9.0, -4.0, 1.0, -5.0, 4.0, 0.0, -5.0, -8.0, -7.0));
	blockE[0].k[5].mA[2] = (mat3(1.0, 7.0, -8.0, -1.0, 9.0, -2.0, 4.0, 5.0, 8.0));
	blockE[0].k[5].mA[3] = (mat3(-5.0, 4.0, -5.0, 7.0, 3.0, -2.0, 0.0, -6.0, 7.0));
	blockE[0].k[5].mA[4] = (mat3(2.0, -7.0, 4.0, -4.0, 4.0, -4.0, -2.0, 3.0, 8.0));
	blockE[0].k[5].mA[5] = (mat3(7.0, -1.0, 8.0, -8.0, 6.0, 2.0, -8.0, 1.0, 1.0));
	blockE[0].k[6].mA[0] = (mat3(1.0, 4.0, -5.0, 7.0, 8.0, -7.0, 1.0, 6.0, -8.0));
	blockE[0].k[6].mA[1] = (mat3(1.0, 1.0, -5.0, -7.0, 0.0, -2.0, -3.0, -2.0, 9.0));
	blockE[0].k[6].mA[2] = (mat3(-4.0, -8.0, 5.0, 2.0, 4.0, 2.0, -7.0, 3.0, -5.0));
	blockE[0].k[6].mA[3] = (mat3(0.0, 5.0, 8.0, -5.0, 1.0, 6.0, 4.0, 4.0, 6.0));
	blockE[0].k[6].mA[4] = (mat3(6.0, 1.0, 9.0, 5.0, 9.0, 7.0, 8.0, 7.0, 5.0));
	blockE[0].k[6].mA[5] = (mat3(-9.0, 7.0, 5.0, 7.0, 0.0, -7.0, 0.0, -3.0, 4.0));
	blockE[1].g = (bvec2(false, false));
	blockE[1].i = i8vec3(ivec3(4294967292, 8, 0));
	blockE[1].j = (mat2x3(8.0, 2.0, -6.0, 1.0, -3.0, 5.0));
	blockE[1].k[0].mA[0] = (mat3(-9.0, -4.0, -1.0, 1.0, -4.0, -8.0, -5.0, 2.0, 9.0));
	blockE[1].k[0].mA[1] = (mat3(-3.0, 4.0, -4.0, 3.0, 0.0, -4.0, 7.0, -1.0, -9.0));
	blockE[1].k[0].mA[2] = (mat3(8.0, -8.0, -1.0, 5.0, 3.0, 2.0, -1.0, 7.0, 4.0));
	blockE[1].k[0].mA[3] = (mat3(-7.0, -5.0, -7.0, 0.0, 6.0, -1.0, 6.0, -2.0, -1.0));
	blockE[1].k[0].mA[4] = (mat3(3.0, -1.0, -6.0, 3.0, -5.0, -4.0, -6.0, 6.0, -5.0));
	blockE[1].k[0].mA[5] = (mat3(-2.0, 4.0, -9.0, -4.0, -4.0, 8.0, -5.0, 3.0, -9.0));
	blockE[1].k[1].mA[0] = (mat3(-5.0, 4.0, -4.0, 2.0, -9.0, 3.0, -2.0, -2.0, 9.0));
	blockE[1].k[1].mA[1] = (mat3(-1.0, 8.0, 3.0, -8.0, -7.0, 5.0, 8.0, -8.0, 3.0));
	blockE[1].k[1].mA[2] = (mat3(6.0, 8.0, 9.0, 4.0, -5.0, -6.0, -1.0, 9.0, 2.0));
	blockE[1].k[1].mA[3] = (mat3(-5.0, -3.0, 4.0, 9.0, 2.0, 2.0, -1.0, -5.0, 0.0));
	blockE[1].k[1].mA[4] = (mat3(-6.0, 8.0, 4.0, 3.0, -1.0, -9.0, 5.0, -9.0, -4.0));
	blockE[1].k[1].mA[5] = (mat3(-1.0, -8.0, -8.0, -6.0, 4.0, 9.0, -1.0, -3.0, -8.0));
	blockE[1].k[2].mA[0] = (mat3(5.0, -9.0, -1.0, 8.0, 7.0, 9.0, -6.0, 5.0, 1.0));
	blockE[1].k[2].mA[1] = (mat3(0.0, -3.0, 9.0, -2.0, -2.0, -2.0, -9.0, -7.0, 9.0));
	blockE[1].k[2].mA[2] = (mat3(4.0, 8.0, -3.0, -1.0, -8.0, 1.0, -9.0, 7.0, 2.0));
	blockE[1].k[2].mA[3] = (mat3(8.0, 1.0, 3.0, -9.0, -3.0, -2.0, 0.0, -4.0, 1.0));
	blockE[1].k[2].mA[4] = (mat3(1.0, 6.0, 2.0, 4.0, -3.0, -8.0, -1.0, -1.0, -8.0));
	blockE[1].k[2].mA[5] = (mat3(7.0, 5.0, -7.0, -5.0, 7.0, 8.0, -9.0, -6.0, 6.0));
	blockE[1].k[3].mA[0] = (mat3(-2.0, 7.0, -4.0, -4.0, -6.0, 2.0, 1.0, 7.0, 7.0));
	blockE[1].k[3].mA[1] = (mat3(4.0, 2.0, -6.0, -3.0, 9.0, -6.0, 6.0, 4.0, 8.0));
	blockE[1].k[3].mA[2] = (mat3(5.0, -7.0, 4.0, 9.0, 7.0, -7.0, 9.0, 2.0, -1.0));
	blockE[1].k[3].mA[3] = (mat3(8.0, 1.0, -9.0, -5.0, 8.0, 3.0, -8.0, 9.0, 9.0));
	blockE[1].k[3].mA[4] = (mat3(3.0, -7.0, -1.0, 7.0, -1.0, -7.0, -7.0, 5.0, -9.0));
	blockE[1].k[3].mA[5] = (mat3(5.0, -8.0, -1.0, 3.0, -2.0, -9.0, -3.0, -3.0, 3.0));
	blockE[2].g = (bvec2(false, false));
	blockE[2].i = i8vec3(ivec3(3, 4294967295, 4294967293));
	blockE[2].j = (mat2x3(1.0, -1.0, 5.0, -5.0, 7.0, 4.0));
	blockE[2].k[0].mA[0] = (mat3(-8.0, 7.0, 3.0, -9.0, -5.0, -2.0, 1.0, -9.0, -2.0));
	blockE[2].k[0].mA[1] = (mat3(6.0, -7.0, -4.0, 1.0, -2.0, 9.0, -6.0, -1.0, 0.0));
	blockE[2].k[0].mA[2] = (mat3(-6.0, 9.0, -6.0, 2.0, -1.0, -3.0, 1.0, 0.0, 5.0));
	blockE[2].k[0].mA[3] = (mat3(7.0, 8.0, -9.0, -9.0, -8.0, -6.0, 3.0, 6.0, -9.0));
	blockE[2].k[0].mA[4] = (mat3(9.0, -9.0, 5.0, -8.0, 7.0, 3.0, 8.0, 0.0, 1.0));
	blockE[2].k[0].mA[5] = (mat3(4.0, 9.0, 4.0, 7.0, -4.0, -8.0, 3.0, -4.0, -4.0));
	blockE[2].k[1].mA[0] = (mat3(-4.0, 5.0, 2.0, 1.0, -2.0, -3.0, 2.0, 4.0, -5.0));
	blockE[2].k[1].mA[1] = (mat3(-6.0, -8.0, -2.0, -5.0, 3.0, 3.0, -7.0, 4.0, 8.0));
	blockE[2].k[1].mA[2] = (mat3(-5.0, 7.0, 8.0, -8.0, -7.0, 6.0, -2.0, 2.0, 6.0));
	blockE[2].k[1].mA[3] = (mat3(0.0, 8.0, 8.0, -8.0, -9.0, 0.0, 0.0, 1.0, 4.0));
	blockE[2].k[1].mA[4] = (mat3(3.0, 0.0, -2.0, 7.0, 8.0, 2.0, 0.0, -8.0, -2.0));
	blockE[2].k[1].mA[5] = (mat3(3.0, 2.0, -1.0, 8.0, 6.0, 6.0, -9.0, 1.0, 6.0));
	blockE[2].k[2].mA[0] = (mat3(2.0, 4.0, -8.0, 6.0, 9.0, -5.0, -9.0, -3.0, -6.0));
	blockE[2].k[2].mA[1] = (mat3(-1.0, 6.0, 9.0, 7.0, -4.0, 5.0, 4.0, -3.0, -8.0));
	blockE[2].k[2].mA[2] = (mat3(-6.0, -7.0, 1.0, 0.0, -2.0, -5.0, 6.0, -7.0, -3.0));
	blockE[2].k[2].mA[3] = (mat3(6.0, 8.0, 1.0, 7.0, 5.0, 7.0, 7.0, 3.0, 6.0));
	blockE[2].k[2].mA[4] = (mat3(6.0, -3.0, -3.0, 8.0, -8.0, 8.0, -2.0, -8.0, -3.0));
	blockE[2].k[2].mA[5] = (mat3(-4.0, 3.0, -9.0, -5.0, 9.0, -8.0, 2.0, 5.0, -4.0));
	blockE[2].k[3].mA[0] = (mat3(-6.0, 6.0, -1.0, 6.0, -1.0, -6.0, 2.0, -8.0, -4.0));
	blockE[2].k[3].mA[1] = (mat3(-8.0, 5.0, 3.0, -7.0, -6.0, 9.0, -8.0, 3.0, -9.0));
	blockE[2].k[3].mA[2] = (mat3(-3.0, 2.0, -5.0, 7.0, -9.0, 5.0, 1.0, 7.0, -5.0));
	blockE[2].k[3].mA[3] = (mat3(-5.0, 7.0, -3.0, 6.0, -5.0, 9.0, -9.0, 0.0, -5.0));
	blockE[2].k[3].mA[4] = (mat3(7.0, 7.0, 8.0, 7.0, 8.0, 3.0, 4.0, 3.0, -6.0));
	blockE[2].k[3].mA[5] = (mat3(-9.0, -6.0, 9.0, -6.0, 7.0, -6.0, 4.0, 3.0, -7.0));
}
#version 450
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
layout(std140, row_major, buffer_reference) buffer BlockB
{
	bvec3 a;
	highp vec2 b;
	sA c;
	sB d;
	mediump ivec3 e[][2];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat3x2 f;
	mediump mat3 g;
	lowp mat3x4 h;
	highp ivec2 i;
	i8vec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.d.mA), 6u) && allOk;
	allOk = compare_mat3x2(blockC.f, mat3x2(1.0, 2.0, -1.0, 9.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(blockC.g, mat3(3.0, -9.0, 3.0, 5.0, 2.0, 3.0, 1.0, -6.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockC.i), ivec2(-8, 4)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.j), ivec3(4294967289, 1, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.b = (vec2(1.0, 2.0));
	blockB.c.mA = (mat4x2(-4.0, 0.0, -1.0, 6.0, -9.0, -6.0, 0.0, -5.0));
	blockB.c.mB = (bvec2(false, true));
	blockB.c.mC = int8_t(4);
	blockB.d.mA = uint8_t(9u);
	blockC.f = (mat3x2(-1.0, 4.0, -2.0, -5.0, 5.0, 3.0));
	blockC.h = (mat3x4(7.0, -9.0, -8.0, 3.0, 5.0, 5.0, -1.0, 7.0, -1.0, -8.0, 0.0, -8.0));
	blockC.i = (ivec2(4, -3));
	blockC.j = i8vec3(ivec3(4294967292, 9, 4294967287));
}
#version 450
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
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump vec2 a;
	bvec2 b;
	sA c;
	i8vec2 d[5];
	u8vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e[0]), uvec3(7u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e[1]), uvec3(5u, 8u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e[2]), uvec3(3u, 9u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e[3]), uvec3(2u, 2u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e[4]), uvec3(1u, 7u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e[5]), uvec3(3u, 1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-7.0, 3.0));
	blockB.b = (bvec2(false, true));
	blockB.c.mA = (bvec4(true, false, true, true));
	blockB.c.mB = (uvec4(2u, 0u, 6u, 3u));
	blockB.c.mC = (ivec2(-4, -7));
	blockB.d[0] = i8vec2(ivec2(2, 4294967291));
	blockB.d[1] = i8vec2(ivec2(4294967287, 9));
	blockB.d[2] = i8vec2(ivec2(4294967295, 9));
	blockB.d[3] = i8vec2(ivec2(4, 1));
	blockB.d[4] = i8vec2(ivec2(4294967288, 4294967294));
}
#version 450
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
	int8_t a;
	mediump ivec2 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp ivec3 c;
	mediump mat3 d;
	highp uvec3 e;
	lowp mat2x3 f[][4];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp mat4x2 g;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockC.f[0][0], mat2x3(0.0, 9.0, -6.0, 5.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[0][1], mat2x3(-1.0, -6.0, 5.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[0][2], mat2x3(4.0, 8.0, 5.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[0][3], mat2x3(4.0, -2.0, -5.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1][0], mat2x3(-3.0, 6.0, 4.0, 1.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1][1], mat2x3(0.0, -4.0, -7.0, 5.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1][2], mat2x3(8.0, -2.0, 6.0, 1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1][3], mat2x3(-5.0, -7.0, 4.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2][0], mat2x3(-1.0, -9.0, -6.0, 3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2][1], mat2x3(4.0, 7.0, -2.0, -1.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2][2], mat2x3(3.0, 8.0, 6.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2][3], mat2x3(1.0, -6.0, -5.0, 0.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3][0], mat2x3(-5.0, 8.0, 1.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3][1], mat2x3(-6.0, -3.0, 2.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3][2], mat2x3(7.0, 2.0, -3.0, -8.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3][3], mat2x3(1.0, -1.0, 9.0, -4.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4][0], mat2x3(-2.0, -2.0, 3.0, 3.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4][1], mat2x3(-8.0, 5.0, -3.0, -6.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4][2], mat2x3(1.0, 8.0, -1.0, -2.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4][3], mat2x3(7.0, 6.0, 1.0, 2.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(5.0, -7.0, -9.0, -8.0, 6.0, -3.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(1);
	blockB.b[0] = (ivec2(1, -4));
	blockB.b[1] = (ivec2(1, 8));
	blockB.b[2] = (ivec2(-4, 1));
	blockC.c = (ivec3(-9, 3, 0));
	blockC.d = (mat3(-9.0, -6.0, 3.0, 4.0, -1.0, -4.0, -7.0, -8.0, -3.0));
	blockC.f[0][0] = (mat2x3(-1.0, -4.0, -8.0, 2.0, 0.0, 3.0));
	blockC.f[0][1] = (mat2x3(9.0, -8.0, -9.0, -2.0, 0.0, 2.0));
	blockC.f[0][2] = (mat2x3(6.0, -7.0, 3.0, 9.0, 8.0, 1.0));
	blockC.f[0][3] = (mat2x3(7.0, -9.0, 2.0, 7.0, 0.0, -8.0));
	blockC.f[1][0] = (mat2x3(-4.0, -2.0, -6.0, -2.0, 0.0, -4.0));
	blockC.f[1][1] = (mat2x3(-4.0, -9.0, 1.0, 5.0, -8.0, -8.0));
	blockC.f[1][2] = (mat2x3(9.0, -4.0, 9.0, -7.0, 5.0, 9.0));
	blockC.f[1][3] = (mat2x3(3.0, 6.0, -8.0, 2.0, -3.0, 9.0));
	blockC.f[2][0] = (mat2x3(-5.0, -1.0, 0.0, -3.0, 7.0, 4.0));
	blockC.f[2][1] = (mat2x3(1.0, 5.0, 4.0, -6.0, -7.0, -2.0));
	blockC.f[2][2] = (mat2x3(4.0, -8.0, -4.0, -5.0, 9.0, -4.0));
	blockC.f[2][3] = (mat2x3(5.0, 1.0, -5.0, 9.0, 0.0, -8.0));
	blockC.f[3][0] = (mat2x3(-7.0, -6.0, -8.0, 2.0, 0.0, -3.0));
	blockC.f[3][1] = (mat2x3(4.0, -3.0, -5.0, -9.0, 4.0, 2.0));
	blockC.f[3][2] = (mat2x3(-4.0, -2.0, -3.0, -2.0, -5.0, 2.0));
	blockC.f[3][3] = (mat2x3(-5.0, -9.0, -8.0, -1.0, 1.0, 8.0));
	blockC.f[4][0] = (mat2x3(-6.0, -3.0, -4.0, 3.0, -6.0, -9.0));
	blockC.f[4][1] = (mat2x3(-3.0, -7.0, 5.0, 7.0, -3.0, -9.0));
	blockC.f[4][2] = (mat2x3(-4.0, 6.0, 3.0, -9.0, 0.0, 0.0));
	blockC.f[4][3] = (mat2x3(-4.0, 8.0, 2.0, 9.0, 2.0, -2.0));
	blockD.g = (mat4x2(-5.0, -2.0, -5.0, 8.0, 6.0, 2.0, 4.0, 9.0));
}
#version 450
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
	layout(offset = 0) u8vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(2u, 0u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(4u, 9u, 2u, 4u));
}
#version 450
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
	layout(offset = 0) mediump int a[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec4 b;
	layout(offset = 16) i8vec4 c;
	layout(offset = 20) int8_t d;
	layout(offset = 32) mediump uvec4 e;
	layout(offset = 48) u8vec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp uint g;
	layout(offset = 4) highp vec2 h;
	layout(offset = 16) highp uvec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a[0]), 7) && allOk;
	allOk = compare_int((blockB[1].a[0]), -4) && allOk;
	allOk = compare_vec4((blockC.b), vec4(4.0, 3.0, 7.0, -3.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c), ivec4(2, 4294967295, 9, 4294967288)) && allOk;
	allOk = compare_int8_t(int(blockC.d), 0) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(5u, 3u, 8u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f), uvec3(4u, 6u, 1u)) && allOk;
	allOk = compare_uint((blockD.g), 8u) && allOk;
	allOk = compare_vec2((blockD.h), vec2(9.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(4u, 9u, 9u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (vec4(8.0, -4.0, -8.0, 5.0));
	blockC.c = i8vec4(ivec4(3, 3, 9, 4294967292));
	blockC.f = u8vec3(uvec3(1u, 4u, 9u));
	blockD.g = (3u);
	blockD.h = (vec2(7.0, 6.0));
	blockD.i = (uvec4(5u, 1u, 8u, 9u));
}
#version 450
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
	layout(offset = 0) bvec2 a;
	layout(offset = 16) mediump vec3 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i8vec3 c;
	layout(offset = 16) highp vec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i8vec4 e;
	layout(offset = 16) highp uvec3 f[1];
	layout(offset = 32) u8vec2 g;
	layout(offset = 34) u8vec4 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp float i;
	layout(offset = 16) highp uvec4 j[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-1.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(-4.0, -2.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(-1.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e), ivec4(4294967291, 4294967291, 9, 4294967288)) && allOk;
	allOk = compare_uvec3((blockD.f[0]), uvec3(7u, 9u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.g), uvec2(2u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.h), uvec4(3u, 1u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockE.j[0]), uvec4(2u, 1u, 0u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (vec3(-2.0, -5.0, -7.0));
	blockC[0].c = i8vec3(ivec3(4294967292, 6, 4294967294));
	blockC[0].d = (vec4(-6.0, -6.0, 4.0, 4.0));
	blockC[1].c = i8vec3(ivec3(3, 9, 4294967294));
	blockC[1].d = (vec4(8.0, -6.0, -9.0, -8.0));
	blockD.f[0] = (uvec3(9u, 2u, 5u));
	blockE.i = (3.0);
	blockE.j[0] = (uvec4(9u, 8u, 1u, 7u));
}
