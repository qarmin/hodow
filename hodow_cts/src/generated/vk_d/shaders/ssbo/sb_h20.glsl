#version 450
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
	mediump uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec2(5u, 3u));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(8.0, -6.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-9.0, 7.0));
	var[1] = (vec2(9.0, 8.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(0.0, -6.0, -5.0, 0.0, 1.0, 3.0, -2.0, 5.0, -5.0, -6.0, 2.0, -1.0, 0.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-6.0, -5.0, -2.0, -2.0));
	var[1] = (vec4(-5.0, -9.0, -5.0, 1.0));
	var[2] = (vec4(4.0, 1.0, -2.0, -6.0));
	var[3] = (vec4(-7.0, -7.0, -1.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(1.0, -7.0, -7.0, -5.0, -4.0, 7.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(6.0, -2.0, -6.0, -3.0));
	var[1] = (vec4(1.0, -2.0, -4.0, 2.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-4.0, -5.0, 8.0, -8.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], 0.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], 3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, -2.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-3.0, 5.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(6.0, 3.0, 9.0, -5.0));
	var[1] = (vec4(2.0, 2.0, -6.0, 6.0));
	var[2] = (vec4(8.0, 8.0, 2.0, 0.0));
}
#version 450
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
	u8vec2 var;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u8vec2(uvec2(7u, 7u));
}
#version 450
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

	var = (vec3(0.0, 0.0, -2.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(2.0, -5.0, 3.0, 0.0));
}
#version 450
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
	allOk = compare_mat3(var, mat3(6.0, -1.0, 3.0, 8.0, -4.0, 9.0, 0.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-6.0, -9.0, 5.0));
	var[1] = (vec3(8.0, -2.0, 3.0));
	var[2] = (vec3(2.0, -2.0, 4.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], 1.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_float(var[3][0], -9.0) && allOk;
	allOk = compare_float(var[3][1], 3.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-2.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-2.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(5.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-9.0, 3.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-4.0, -3.0, -1.0, -1.0));
	var[1] = (vec4(6.0, -6.0, 8.0, -4.0));
	var[2] = (vec4(-5.0, 6.0, 5.0, 5.0));
	var[3] = (vec4(3.0, 2.0, -5.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-2.0, 4.0, -1.0, -2.0, 7.0, 7.0, 9.0, -5.0, -1.0, 8.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(4.0, -8.0, 3.0, 6.0, -8.0, 8.0, -7.0, 4.0, -4.0, -7.0, -4.0, 0.0));
}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat2(var, mat2(-4.0, 9.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var = (mat2(-4.0, -8.0, -2.0, -2.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-1.0, 3.0, 5.0, 6.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat2x3(-1.0, -7.0, 6.0, 0.0, -8.0, -2.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-7.0, 7.0, -4.0, -5.0, -3.0, 1.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var = (mat2x4(9.0, -1.0, 0.0, 4.0, -8.0, 1.0, 9.0, -8.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var = (mat3x2(2.0, 7.0, -2.0, 0.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec3(2.0, -2.0, 0.0));
	var[1] = (vec3(-7.0, 0.0, 1.0));
	var[2] = (vec3(-1.0, 6.0, -7.0));
	var[3] = (vec3(7.0, 9.0, -4.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	f16vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
}
#version 450
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
	highp uvec4 var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 4u) && allOk;
	allOk = compare_uvec4((var[0]), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[1]), uvec4(9u, 5u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((var[2]), uvec4(6u, 5u, 1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2u);
	var[0] = (uvec4(7u, 2u, 9u, 7u));
	var[1] = (uvec4(9u, 5u, 1u, 3u));
	var[2] = (uvec4(4u, 4u, 2u, 0u));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-7.0, 5.0, 4.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-3.0, 5.0, -8.0, -2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(3.0, -9.0, 1.0, 3.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0] = (vec3(5.0, -6.0, 0.0));
	var[0][1] = (vec3(-8.0, -2.0, 8.0));
	var[1][0] = (vec3(8.0, 0.0, 3.0));
	var[1][1] = (vec3(-6.0, -6.0, -1.0));
	var[2][0] = (vec3(2.0, -9.0, 1.0));
	var[2][1] = (vec3(3.0, 2.0, 1.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	var[1] = (mat2x4(1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0));
	var[2] = (mat2x4(6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0, -8.0));
}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	var[3] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	var[4] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	var[5] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	var[6] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	var[7] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	var[8] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	var[9] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	var[10] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	var[11] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	var[12] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	var[13] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	var[14] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	var[15] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	var[16] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	var[17] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	var[18] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
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
	var[3][0] = (vec3(-7.0, 3.0, 4.0));
	var[3][1] = (vec3(-1.0, 1.0, 0.0));
	var[3][2] = (vec3(7.0, 7.0, 9.0));
	var[4][0] = (vec3(4.0, 4.0, -3.0));
	var[4][1] = (vec3(9.0, 1.0, -6.0));
	var[4][2] = (vec3(7.0, -6.0, -1.0));
	var[5][0] = (vec3(-5.0, -2.0, -7.0));
	var[5][1] = (vec3(-8.0, -9.0, 6.0));
	var[5][2] = (vec3(2.0, -2.0, -7.0));
	var[6][0] = (vec3(6.0, -2.0, -1.0));
	var[6][1] = (vec3(9.0, 2.0, -4.0));
	var[6][2] = (vec3(-9.0, -5.0, 4.0));
	var[7][0] = (vec3(-1.0, -6.0, 9.0));
	var[7][1] = (vec3(-1.0, 3.0, 0.0));
	var[7][2] = (vec3(-7.0, 1.0, -6.0));
	var[8][0] = (vec3(0.0, -6.0, 0.0));
	var[8][1] = (vec3(8.0, 6.0, 4.0));
	var[8][2] = (vec3(7.0, -4.0, 4.0));
	var[9][0] = (vec3(-6.0, 3.0, -3.0));
	var[9][1] = (vec3(0.0, -8.0, 6.0));
	var[9][2] = (vec3(-7.0, -2.0, 7.0));
	var[10][0] = (vec3(4.0, -8.0, 1.0));
	var[10][1] = (vec3(-6.0, 7.0, 1.0));
	var[10][2] = (vec3(6.0, 3.0, 0.0));
	var[11][0] = (vec3(-2.0, -9.0, 9.0));
	var[11][1] = (vec3(1.0, 3.0, 4.0));
	var[11][2] = (vec3(5.0, -3.0, -6.0));
	var[12][0] = (vec3(-7.0, 1.0, -4.0));
	var[12][1] = (vec3(8.0, -5.0, 4.0));
	var[12][2] = (vec3(1.0, -7.0, 3.0));
	var[13][0] = (vec3(-3.0, -3.0, 6.0));
	var[13][1] = (vec3(8.0, 1.0, -8.0));
	var[13][2] = (vec3(5.0, 9.0, -2.0));
	var[14][0] = (vec3(4.0, -7.0, 4.0));
	var[14][1] = (vec3(-6.0, 5.0, -4.0));
	var[14][2] = (vec3(5.0, -3.0, 3.0));
	var[15][0] = (vec3(8.0, 6.0, 1.0));
	var[15][1] = (vec3(6.0, 5.0, 1.0));
	var[15][2] = (vec3(7.0, 9.0, 0.0));
	var[16][0] = (vec3(-7.0, 8.0, 6.0));
	var[16][1] = (vec3(4.0, -8.0, -8.0));
	var[16][2] = (vec3(8.0, 9.0, -9.0));
	var[17][0] = (vec3(-8.0, -3.0, -7.0));
	var[17][1] = (vec3(4.0, -6.0, -4.0));
	var[17][2] = (vec3(-6.0, 0.0, 0.0));
	var[18][0] = (vec3(-3.0, -9.0, 1.0));
	var[18][1] = (vec3(-2.0, 3.0, -3.0));
	var[18][2] = (vec3(-1.0, 5.0, -8.0));
}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[3][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[3][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[3][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[4][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[4][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[4][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[5][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[5][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[5][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[6][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[6][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[6][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[7][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[7][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[7][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[8][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[8][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[8][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[9][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[9][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[9][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[10][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[10][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[10][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[11][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[11][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[11][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[12][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	var[12][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[12][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[13][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	var[13][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[13][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[14][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	var[14][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[14][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[15][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	var[15][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[15][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[16][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	var[16][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[16][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[17][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	var[17][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[17][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[18][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	var[18][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[18][2] = (vec4(7.0, -9.0, 0.0, -3.0));
}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	var[0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	var[1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	var[2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[3][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	var[3][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[4][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	var[4][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[5][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	var[5][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[6][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	var[6][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[7][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	var[7][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[8][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	var[8][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[9][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	var[9][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[10][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	var[10][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[11][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	var[11][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	var[12][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	var[12][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	var[13][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	var[13][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	var[14][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	var[14][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	var[15][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	var[15][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	var[16][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	var[16][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	var[17][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	var[17][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	var[18][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	var[18][1] = (vec4(8.0, -6.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(-3.0, -6.0, 6.0));
	var[0][1] = (vec3(1.0, -4.0, -3.0));
	var[0][2] = (vec3(-3.0, 3.0, -2.0));
	var[0][3] = (vec3(-7.0, 1.0, -5.0));
	var[1][0] = (vec3(-1.0, -5.0, 7.0));
	var[1][1] = (vec3(1.0, -2.0, -4.0));
	var[1][2] = (vec3(-4.0, -6.0, 5.0));
	var[1][3] = (vec3(-2.0, 6.0, -9.0));
	var[2][0] = (vec3(5.0, -5.0, 7.0));
	var[2][1] = (vec3(-4.0, 8.0, -3.0));
	var[2][2] = (vec3(-2.0, 0.0, 8.0));
	var[2][3] = (vec3(-2.0, 6.0, -3.0));
	var[3][0] = (vec3(-9.0, -2.0, -2.0));
	var[3][1] = (vec3(7.0, 9.0, -4.0));
	var[3][2] = (vec3(3.0, 1.0, 0.0));
	var[3][3] = (vec3(-9.0, -2.0, -7.0));
	var[4][0] = (vec3(-5.0, -6.0, 5.0));
	var[4][1] = (vec3(-2.0, -7.0, 5.0));
	var[4][2] = (vec3(-2.0, -6.0, 4.0));
	var[4][3] = (vec3(9.0, 5.0, -9.0));
	var[5][0] = (vec3(-3.0, 3.0, 7.0));
	var[5][1] = (vec3(3.0, -4.0, -8.0));
	var[5][2] = (vec3(-2.0, 2.0, -1.0));
	var[5][3] = (vec3(1.0, -9.0, 9.0));
	var[6][0] = (vec3(-7.0, -7.0, -7.0));
	var[6][1] = (vec3(6.0, -9.0, 3.0));
	var[6][2] = (vec3(-5.0, 2.0, 4.0));
	var[6][3] = (vec3(-2.0, -4.0, -6.0));
	var[7][0] = (vec3(-1.0, 5.0, 5.0));
	var[7][1] = (vec3(-9.0, -3.0, -9.0));
	var[7][2] = (vec3(3.0, 2.0, 0.0));
	var[7][3] = (vec3(0.0, -9.0, 7.0));
	var[8][0] = (vec3(5.0, -5.0, -2.0));
	var[8][1] = (vec3(6.0, 5.0, -4.0));
	var[8][2] = (vec3(-2.0, 9.0, -3.0));
	var[8][3] = (vec3(2.0, 5.0, -4.0));
	var[9][0] = (vec3(6.0, 4.0, 7.0));
	var[9][1] = (vec3(1.0, -4.0, -6.0));
	var[9][2] = (vec3(4.0, -6.0, -5.0));
	var[9][3] = (vec3(5.0, 6.0, -1.0));
	var[10][0] = (vec3(6.0, 3.0, -9.0));
	var[10][1] = (vec3(-7.0, 3.0, -4.0));
	var[10][2] = (vec3(1.0, 2.0, 6.0));
	var[10][3] = (vec3(-2.0, 3.0, 7.0));
	var[11][0] = (vec3(-5.0, 8.0, -9.0));
	var[11][1] = (vec3(-4.0, -1.0, -9.0));
	var[11][2] = (vec3(5.0, 5.0, 6.0));
	var[11][3] = (vec3(-8.0, 1.0, -7.0));
	var[12][0] = (vec3(-5.0, -6.0, -3.0));
	var[12][1] = (vec3(-2.0, 5.0, 8.0));
	var[12][2] = (vec3(2.0, -9.0, 7.0));
	var[12][3] = (vec3(7.0, -3.0, 4.0));
	var[13][0] = (vec3(9.0, 4.0, 1.0));
	var[13][1] = (vec3(5.0, -9.0, 2.0));
	var[13][2] = (vec3(-7.0, -3.0, -9.0));
	var[13][3] = (vec3(9.0, -6.0, 3.0));
	var[14][0] = (vec3(-9.0, -4.0, 0.0));
	var[14][1] = (vec3(5.0, 8.0, 9.0));
	var[14][2] = (vec3(-7.0, -9.0, -5.0));
	var[14][3] = (vec3(0.0, -1.0, -6.0));
	var[15][0] = (vec3(-9.0, -9.0, 9.0));
	var[15][1] = (vec3(9.0, -1.0, 8.0));
	var[15][2] = (vec3(8.0, -8.0, 4.0));
	var[15][3] = (vec3(9.0, -8.0, 8.0));
	var[16][0] = (vec3(4.0, 6.0, 1.0));
	var[16][1] = (vec3(-9.0, 7.0, 3.0));
	var[16][2] = (vec3(-4.0, -3.0, 8.0));
	var[16][3] = (vec3(-9.0, -9.0, 2.0));
	var[17][0] = (vec3(0.0, -2.0, 5.0));
	var[17][1] = (vec3(8.0, 4.0, -4.0));
	var[17][2] = (vec3(5.0, 4.0, -5.0));
	var[17][3] = (vec3(0.0, -3.0, 9.0));
	var[18][0] = (vec3(-4.0, -7.0, 3.0));
	var[18][1] = (vec3(6.0, 4.0, 1.0));
	var[18][2] = (vec3(-3.0, 3.0, 8.0));
	var[18][3] = (vec3(-6.0, 5.0, -6.0));
}
#version 450
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

	var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[3] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[4] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[5] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[6] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[7] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[8] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[9] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[10] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[11] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	var[12] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	var[13] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	var[14] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	var[15] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	var[16] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	var[17] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	var[18] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	var[0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	var[0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[0][2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[0][2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[0][2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[0][2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[1][0][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[1][0][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[1][0][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[1][0][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[1][1][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[1][1][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[1][1][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[1][1][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[1][2][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[1][2][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[1][2][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[1][2][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[2][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[2][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[2][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[2][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[2][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[2][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[2][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[2][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[2][2][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[2][2][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[2][2][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[2][2][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[3][0][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[3][0][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[3][0][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[3][0][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[3][1][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[3][1][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[3][1][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[3][1][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[3][2][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[3][2][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[3][2][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[3][2][3] = (vec4(6.0, 0.0, 6.0, -6.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-2.0, 8.0));
	var[0][0][1] = (vec2(1.0, 8.0));
	var[0][0][2] = (vec2(-7.0, 5.0));
	var[0][1][0] = (vec2(2.0, 0.0));
	var[0][1][1] = (vec2(-3.0, 1.0));
	var[0][1][2] = (vec2(2.0, -5.0));
	var[0][2][0] = (vec2(6.0, 3.0));
	var[0][2][1] = (vec2(6.0, 5.0));
	var[0][2][2] = (vec2(-5.0, 9.0));
	var[1][0][0] = (vec2(-8.0, 9.0));
	var[1][0][1] = (vec2(3.0, -3.0));
	var[1][0][2] = (vec2(3.0, -5.0));
	var[1][1][0] = (vec2(7.0, -8.0));
	var[1][1][1] = (vec2(3.0, 1.0));
	var[1][1][2] = (vec2(-2.0, 1.0));
	var[1][2][0] = (vec2(4.0, -9.0));
	var[1][2][1] = (vec2(3.0, 6.0));
	var[1][2][2] = (vec2(7.0, 1.0));
	var[2][0][0] = (vec2(9.0, -9.0));
	var[2][0][1] = (vec2(0.0, -6.0));
	var[2][0][2] = (vec2(-7.0, 7.0));
	var[2][1][0] = (vec2(-8.0, 7.0));
	var[2][1][1] = (vec2(9.0, 6.0));
	var[2][1][2] = (vec2(-1.0, 0.0));
	var[2][2][0] = (vec2(-3.0, 6.0));
	var[2][2][1] = (vec2(-1.0, -6.0));
	var[2][2][2] = (vec2(-1.0, -3.0));
	var[3][0][0] = (vec2(0.0, -1.0));
	var[3][0][1] = (vec2(4.0, -9.0));
	var[3][0][2] = (vec2(1.0, 1.0));
	var[3][1][0] = (vec2(-9.0, 7.0));
	var[3][1][1] = (vec2(0.0, 4.0));
	var[3][1][2] = (vec2(-3.0, -3.0));
	var[3][2][0] = (vec2(6.0, 8.0));
	var[3][2][1] = (vec2(-7.0, 5.0));
	var[3][2][2] = (vec2(-6.0, -5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0, 8.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0, 0.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0, 6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0, -3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0, -9.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0][0] = (vec3(-6.0, 3.0, -3.0));
	var[0][0][1] = (vec3(9.0, -2.0, 3.0));
	var[0][0][2] = (vec3(9.0, -9.0, 7.0));
	var[0][0][3] = (vec3(4.0, -4.0, 5.0));
	var[0][1][0] = (vec3(-1.0, -2.0, 6.0));
	var[0][1][1] = (vec3(-4.0, 6.0, 4.0));
	var[0][1][2] = (vec3(-8.0, 7.0, 3.0));
	var[0][1][3] = (vec3(1.0, -9.0, -4.0));
	var[0][2][0] = (vec3(9.0, 2.0, 2.0));
	var[0][2][1] = (vec3(9.0, -7.0, 3.0));
	var[0][2][2] = (vec3(8.0, 2.0, 4.0));
	var[0][2][3] = (vec3(-9.0, 8.0, 2.0));
	var[1][0][0] = (vec3(-8.0, 7.0, 3.0));
	var[1][0][1] = (vec3(0.0, -8.0, 0.0));
	var[1][0][2] = (vec3(6.0, -9.0, 0.0));
	var[1][0][3] = (vec3(4.0, -3.0, -4.0));
	var[1][1][0] = (vec3(-7.0, -8.0, -1.0));
	var[1][1][1] = (vec3(6.0, -3.0, -5.0));
	var[1][1][2] = (vec3(0.0, 8.0, -8.0));
	var[1][1][3] = (vec3(5.0, 5.0, -4.0));
	var[1][2][0] = (vec3(-4.0, -4.0, -3.0));
	var[1][2][1] = (vec3(3.0, 3.0, 2.0));
	var[1][2][2] = (vec3(8.0, -8.0, -6.0));
	var[1][2][3] = (vec3(4.0, 8.0, 9.0));
	var[2][0][0] = (vec3(-1.0, 2.0, 4.0));
	var[2][0][1] = (vec3(4.0, 2.0, 0.0));
	var[2][0][2] = (vec3(5.0, 6.0, -6.0));
	var[2][0][3] = (vec3(1.0, -1.0, -3.0));
	var[2][1][0] = (vec3(7.0, 9.0, 8.0));
	var[2][1][1] = (vec3(-9.0, -9.0, -9.0));
	var[2][1][2] = (vec3(6.0, -7.0, -3.0));
	var[2][1][3] = (vec3(7.0, -6.0, 7.0));
	var[2][2][0] = (vec3(-9.0, 0.0, -1.0));
	var[2][2][1] = (vec3(-7.0, -2.0, -3.0));
	var[2][2][2] = (vec3(1.0, 4.0, 5.0));
	var[2][2][3] = (vec3(-1.0, -4.0, 9.0));
	var[3][0][0] = (vec3(5.0, 4.0, 7.0));
	var[3][0][1] = (vec3(3.0, -3.0, 4.0));
	var[3][0][2] = (vec3(3.0, -6.0, 5.0));
	var[3][0][3] = (vec3(8.0, 7.0, -8.0));
	var[3][1][0] = (vec3(4.0, 8.0, -3.0));
	var[3][1][1] = (vec3(-9.0, 7.0, -2.0));
	var[3][1][2] = (vec3(0.0, -3.0, -3.0));
	var[3][1][3] = (vec3(-4.0, -9.0, 4.0));
	var[3][2][0] = (vec3(-5.0, -7.0, 1.0));
	var[3][2][1] = (vec3(-8.0, 1.0, 9.0));
	var[3][2][2] = (vec3(-8.0, 0.0, -2.0));
	var[3][2][3] = (vec3(-2.0, -4.0, -5.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[0][0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[0][0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[0][0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[0][0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[0][0][2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[0][0][2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[0][0][2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][0][2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[0][1][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	var[0][1][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[0][1][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[0][1][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[0][1][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	var[0][1][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[0][1][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[0][1][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[0][1][2][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	var[0][1][2][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[0][1][2][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[0][1][2][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[1][0][0][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[1][0][0][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][0][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][0][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][0][1][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[1][0][1][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[1][0][1][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[1][0][1][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[1][0][2][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[1][0][2][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[1][0][2][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[1][0][2][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[1][1][0][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	var[1][1][0][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[1][1][0][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[1][1][0][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[1][1][1][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	var[1][1][1][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[1][1][1][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[1][1][1][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[1][1][2][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	var[1][1][2][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[1][1][2][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[1][1][2][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[2][0][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[2][0][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[2][0][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[2][0][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[2][0][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[2][0][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[2][0][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[2][0][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[2][0][2][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[2][0][2][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[2][0][2][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[2][0][2][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[2][1][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	var[2][1][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[2][1][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[2][1][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	var[2][1][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	var[2][1][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	var[2][1][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	var[2][1][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	var[2][1][2][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	var[2][1][2][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	var[2][1][2][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	var[2][1][2][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	var[3][0][0][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[3][0][0][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[3][0][0][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[3][0][0][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[3][0][1][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[3][0][1][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[3][0][1][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[3][0][1][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[3][0][2][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[3][0][2][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][0][2][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[3][0][2][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[3][1][0][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	var[3][1][0][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	var[3][1][0][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	var[3][1][0][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	var[3][1][1][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	var[3][1][1][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	var[3][1][1][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	var[3][1][1][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	var[3][1][2][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	var[3][1][2][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	var[3][1][2][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	var[3][1][2][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	uint16_t var[4][2][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = uint16_t(9u);
	var[0][0][1] = uint16_t(1u);
	var[0][0][2] = uint16_t(1u);
	var[0][1][0] = uint16_t(3u);
	var[0][1][1] = uint16_t(1u);
	var[0][1][2] = uint16_t(0u);
	var[1][0][0] = uint16_t(0u);
	var[1][0][1] = uint16_t(7u);
	var[1][0][2] = uint16_t(5u);
	var[1][1][0] = uint16_t(2u);
	var[1][1][1] = uint16_t(1u);
	var[1][1][2] = uint16_t(1u);
	var[2][0][0] = uint16_t(8u);
	var[2][0][1] = uint16_t(1u);
	var[2][0][2] = uint16_t(9u);
	var[2][1][0] = uint16_t(2u);
	var[2][1][1] = uint16_t(9u);
	var[2][1][2] = uint16_t(3u);
	var[3][0][0] = uint16_t(7u);
	var[3][0][1] = uint16_t(2u);
	var[3][0][2] = uint16_t(6u);
	var[3][1][0] = uint16_t(0u);
	var[3][1][1] = uint16_t(8u);
	var[3][1][2] = uint16_t(4u);
}
#version 450
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
	highp uvec3 var[4][2][3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0][0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[0][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((var[0][1][1]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][1][2]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((var[1][0][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][0][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[1][0][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][1][0]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((var[1][1][1]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((var[1][1][2]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((var[2][0][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[2][0][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[2][0][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][1][0]), uvec3(9u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((var[2][1][1]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][1][2]), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][0][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][0][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[3][0][2]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[3][1][0]), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((var[3][1][1]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[3][1][2]), uvec3(7u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec3(3u, 5u, 6u));
	var[0][0][1] = (uvec3(5u, 4u, 5u));
	var[0][0][2] = (uvec3(4u, 9u, 4u));
	var[0][1][0] = (uvec3(1u, 1u, 6u));
	var[0][1][1] = (uvec3(3u, 9u, 4u));
	var[0][1][2] = (uvec3(9u, 7u, 9u));
	var[1][0][0] = (uvec3(4u, 7u, 7u));
	var[1][0][1] = (uvec3(0u, 2u, 9u));
	var[1][0][2] = (uvec3(4u, 7u, 8u));
	var[1][1][0] = (uvec3(1u, 4u, 6u));
	var[1][1][1] = (uvec3(4u, 9u, 3u));
	var[1][1][2] = (uvec3(4u, 3u, 5u));
	var[2][0][0] = (uvec3(9u, 4u, 3u));
	var[2][0][1] = (uvec3(5u, 8u, 0u));
	var[2][0][2] = (uvec3(5u, 4u, 6u));
	var[2][1][0] = (uvec3(4u, 8u, 7u));
	var[2][1][1] = (uvec3(1u, 5u, 2u));
	var[2][1][2] = (uvec3(4u, 1u, 2u));
	var[3][0][0] = (uvec3(7u, 7u, 5u));
	var[3][0][1] = (uvec3(3u, 7u, 0u));
	var[3][0][2] = (uvec3(8u, 1u, 2u));
	var[3][1][0] = (uvec3(6u, 5u, 3u));
	var[3][1][1] = (uvec3(8u, 8u, 7u));
	var[3][1][2] = (uvec3(1u, 2u, 5u));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-1.0, -7.0, 6.0, -3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(2.0, -8.0, 4.0, 7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-7.0, -3.0, 9.0, -6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-5.0, -4.0, -7.0, 2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, 3.0, -9.0, -6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[0][0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[0][0][2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	var[0][1][0] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	var[0][1][1] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	var[0][1][2] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	var[1][0][0] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	var[1][0][1] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	var[1][0][2] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	var[1][1][0] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	var[1][1][1] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	var[1][1][2] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	var[2][0][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	var[2][0][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	var[2][0][2] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	var[2][1][0] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
	var[2][1][1] = (mat4x3(-3.0, -7.0, -1.0, -5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0));
	var[2][1][2] = (mat4x3(-7.0, -1.0, 4.0, 4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0));
	var[3][0][0] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	var[3][0][1] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	var[3][0][2] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	var[3][1][0] = (mat4x3(-8.0, -4.0, -4.0, 2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0));
	var[3][1][1] = (mat4x3(1.0, -2.0, 8.0, -8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0));
	var[3][1][2] = (mat4x3(-7.0, -4.0, 2.0, 2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(4.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-1.0, -9.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(7.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(1.0, -1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-8.0, -2.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-4.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(2.0, -3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-3.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-3.0, 3.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(0.0, -5.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(6.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-7.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, -7.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-1.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-7.0, 6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-7.0, 4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-7.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(7.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-4.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-7.0, 0.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-2.0, 3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(7.0, 8.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0] = (mat2(2.0, 6.0, -6.0, 2.0));
	var[0][0][1] = (mat2(4.0, 4.0, 7.0, 0.0));
	var[0][0][2] = (mat2(8.0, 0.0, -1.0, 8.0));
	var[0][1][0] = (mat2(1.0, -7.0, -2.0, -8.0));
	var[0][1][1] = (mat2(-9.0, 4.0, -4.0, -7.0));
	var[0][1][2] = (mat2(-9.0, -5.0, 3.0, -1.0));
	var[1][0][0] = (mat2(-4.0, -5.0, 7.0, -3.0));
	var[1][0][1] = (mat2(-1.0, 0.0, 6.0, -6.0));
	var[1][0][2] = (mat2(7.0, 4.0, -7.0, 1.0));
	var[1][1][0] = (mat2(-1.0, -6.0, -3.0, -9.0));
	var[1][1][1] = (mat2(-4.0, -8.0, -1.0, -8.0));
	var[1][1][2] = (mat2(1.0, -2.0, 9.0, 9.0));
	var[2][0][0] = (mat2(-8.0, -9.0, -7.0, 1.0));
	var[2][0][1] = (mat2(-2.0, -6.0, -8.0, -6.0));
	var[2][0][2] = (mat2(-6.0, 2.0, -9.0, 9.0));
	var[2][1][0] = (mat2(4.0, -3.0, -3.0, 0.0));
	var[2][1][1] = (mat2(-1.0, -5.0, -6.0, -8.0));
	var[2][1][2] = (mat2(0.0, 8.0, 8.0, -3.0));
	var[3][0][0] = (mat2(0.0, -3.0, -7.0, 8.0));
	var[3][0][1] = (mat2(8.0, 7.0, -3.0, 7.0));
	var[3][0][2] = (mat2(2.0, -8.0, -7.0, 5.0));
	var[3][1][0] = (mat2(-9.0, 5.0, -2.0, 1.0));
	var[3][1][1] = (mat2(9.0, -3.0, -5.0, -3.0));
	var[3][1][2] = (mat2(5.0, 0.0, -9.0, 4.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

layout(scalar, column_major, binding = 1) buffer Block
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

layout(scalar, row_major, binding = 1) buffer Block
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

layout(scalar, column_major, binding = 1) buffer Block
{
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-8.0, -4.0));
	var[0][0][0][1] = (vec2(-3.0, 5.0));
	var[0][0][0][2] = (vec2(-9.0, 4.0));
	var[0][0][1][0] = (vec2(-2.0, -1.0));
	var[0][0][1][1] = (vec2(8.0, 3.0));
	var[0][0][1][2] = (vec2(7.0, 2.0));
	var[0][1][0][0] = (vec2(2.0, -5.0));
	var[0][1][0][1] = (vec2(-5.0, -9.0));
	var[0][1][0][2] = (vec2(-7.0, 3.0));
	var[0][1][1][0] = (vec2(-1.0, 0.0));
	var[0][1][1][1] = (vec2(-1.0, 4.0));
	var[0][1][1][2] = (vec2(-1.0, -6.0));
	var[0][2][0][0] = (vec2(2.0, 6.0));
	var[0][2][0][1] = (vec2(6.0, 1.0));
	var[0][2][0][2] = (vec2(4.0, -8.0));
	var[0][2][1][0] = (vec2(2.0, -5.0));
	var[0][2][1][1] = (vec2(-5.0, 5.0));
	var[0][2][1][2] = (vec2(2.0, -1.0));
	var[0][3][0][0] = (vec2(-2.0, -8.0));
	var[0][3][0][1] = (vec2(0.0, -2.0));
	var[0][3][0][2] = (vec2(8.0, -2.0));
	var[0][3][1][0] = (vec2(3.0, 7.0));
	var[0][3][1][1] = (vec2(-9.0, -1.0));
	var[0][3][1][2] = (vec2(5.0, 7.0));
	var[1][0][0][0] = (vec2(-4.0, 4.0));
	var[1][0][0][1] = (vec2(3.0, -6.0));
	var[1][0][0][2] = (vec2(-4.0, 3.0));
	var[1][0][1][0] = (vec2(4.0, 6.0));
	var[1][0][1][1] = (vec2(3.0, 6.0));
	var[1][0][1][2] = (vec2(-2.0, -9.0));
	var[1][1][0][0] = (vec2(-8.0, -6.0));
	var[1][1][0][1] = (vec2(8.0, 7.0));
	var[1][1][0][2] = (vec2(4.0, -9.0));
	var[1][1][1][0] = (vec2(-4.0, -1.0));
	var[1][1][1][1] = (vec2(-3.0, -2.0));
	var[1][1][1][2] = (vec2(-5.0, -2.0));
	var[1][2][0][0] = (vec2(-9.0, 3.0));
	var[1][2][0][1] = (vec2(6.0, 5.0));
	var[1][2][0][2] = (vec2(-1.0, -8.0));
	var[1][2][1][0] = (vec2(2.0, -1.0));
	var[1][2][1][1] = (vec2(0.0, -2.0));
	var[1][2][1][2] = (vec2(-4.0, 6.0));
	var[1][3][0][0] = (vec2(-5.0, 7.0));
	var[1][3][0][1] = (vec2(6.0, 2.0));
	var[1][3][0][2] = (vec2(-4.0, -3.0));
	var[1][3][1][0] = (vec2(-5.0, 2.0));
	var[1][3][1][1] = (vec2(-7.0, 8.0));
	var[1][3][1][2] = (vec2(-6.0, 3.0));
	var[2][0][0][0] = (vec2(-9.0, 0.0));
	var[2][0][0][1] = (vec2(-4.0, 9.0));
	var[2][0][0][2] = (vec2(-1.0, -1.0));
	var[2][0][1][0] = (vec2(-8.0, 6.0));
	var[2][0][1][1] = (vec2(5.0, -2.0));
	var[2][0][1][2] = (vec2(1.0, 4.0));
	var[2][1][0][0] = (vec2(-7.0, -3.0));
	var[2][1][0][1] = (vec2(5.0, 4.0));
	var[2][1][0][2] = (vec2(4.0, 1.0));
	var[2][1][1][0] = (vec2(-3.0, -6.0));
	var[2][1][1][1] = (vec2(-4.0, -2.0));
	var[2][1][1][2] = (vec2(-5.0, -7.0));
	var[2][2][0][0] = (vec2(2.0, -3.0));
	var[2][2][0][1] = (vec2(-2.0, 1.0));
	var[2][2][0][2] = (vec2(-3.0, 8.0));
	var[2][2][1][0] = (vec2(5.0, -1.0));
	var[2][2][1][1] = (vec2(-4.0, -4.0));
	var[2][2][1][2] = (vec2(7.0, -6.0));
	var[2][3][0][0] = (vec2(-3.0, -4.0));
	var[2][3][0][1] = (vec2(-5.0, -9.0));
	var[2][3][0][2] = (vec2(-8.0, -7.0));
	var[2][3][1][0] = (vec2(8.0, -8.0));
	var[2][3][1][1] = (vec2(-2.0, 7.0));
	var[2][3][1][2] = (vec2(5.0, -5.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-4, -5, 3)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, -7.0, 6.0, -3.0, 7.0, 5.0, -8.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-4.0, -8.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-8, -9, 6));
	s.b[0][0] = (vec3(-6.0, -2.0, 4.0));
	s.b[0][1] = (vec3(-5.0, -9.0, -7.0));
	s.b[0][2] = (vec3(-1.0, 2.0, 2.0));
	s.b[1][0] = (vec3(-5.0, 0.0, -7.0));
	s.b[1][1] = (vec3(9.0, 9.0, -1.0));
	s.b[1][2] = (vec3(-4.0, 4.0, -4.0));
	s.b[2][0] = (vec3(9.0, 8.0, 0.0));
	s.b[2][1] = (vec3(-8.0, -7.0, -1.0));
	s.b[2][2] = (vec3(-1.0, -7.0, -3.0));
	s.b[3][0] = (vec3(6.0, -5.0, 4.0));
	s.b[3][1] = (vec3(-9.0, 3.0, -6.0));
	s.b[3][2] = (vec3(1.0, -5.0, 9.0));
	s.c = (vec4(1.0, 4.0, -5.0, -1.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
{
	lowp vec2 u;
	mediump uint v;
	S s[];
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
	allOk = compare_uvec2((s[0].a), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(-9.0, 5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(-5.0, 5.0, 3.0, 0.0, -3.0, 5.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(-5.0, -4.0, -5.0, 7.0, -4.0, -9.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(-7.0, -9.0, 2.0, -1.0, 9.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(8.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(0.0, 8.0, -7.0, 3.0, 4.0, 6.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(1.0, -7.0, 6.0, 1.0, 6.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(-3.0, -9.0, -3.0, 8.0, -4.0, 7.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(-1.0, -1.0, -3.0, 4.0, 4.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(4.0, 8.0, -8.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(1u, 8u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(0.0, 5.0, 0.0, 7.0, -7.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(-5.0, -7.0, -4.0, -9.0, 2.0, -7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(-6.0, -8.0, 2.0, -2.0, -4.0, -6.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(3.0, 7.0, 8.0, 9.0, -9.0, 6.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(9.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(3u, 2u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(2.0, -6.0, 4.0, 1.0, 3.0, -2.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(8.0, -9.0, -2.0, 1.0, -7.0, 8.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(8.0, 2.0, 5.0, -1.0, -1.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(2.0, -1.0, -2.0, 2.0, -8.0, 6.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(-3.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (7u);
	s[0].a = (uvec2(6u, 9u));
	s[0].b[0][0] = (vec4(7.0, -7.0, 5.0, 1.0));
	s[0].b[0][1] = (vec4(-7.0, -6.0, -4.0, -5.0));
	s[0].b[1][0] = (vec4(1.0, -1.0, 7.0, -4.0));
	s[0].b[1][1] = (vec4(6.0, -5.0, 7.0, 1.0));
	s[0].b[2][0] = (vec4(-5.0, 3.0, 8.0, 9.0));
	s[0].b[2][1] = (vec4(-2.0, -6.0, 1.0, 1.0));
	s[0].b[3][0] = (vec4(-5.0, -7.0, 4.0, 7.0));
	s[0].b[3][1] = (vec4(-6.0, 2.0, 7.0, 6.0));
	s[0].c = (vec3(-7.0, 5.0, -2.0));
	s[1].a = (uvec2(4u, 7u));
	s[1].b[0][0] = (vec4(-1.0, -3.0, 7.0, 8.0));
	s[1].b[0][1] = (vec4(-8.0, -1.0, -2.0, 9.0));
	s[1].b[1][0] = (vec4(3.0, 2.0, 1.0, 6.0));
	s[1].b[1][1] = (vec4(6.0, 6.0, 8.0, -2.0));
	s[1].b[2][0] = (vec4(-2.0, -7.0, 0.0, -8.0));
	s[1].b[2][1] = (vec4(8.0, -5.0, 7.0, -9.0));
	s[1].b[3][0] = (vec4(-7.0, -2.0, 4.0, -3.0));
	s[1].b[3][1] = (vec4(-1.0, -4.0, -1.0, 0.0));
	s[1].c = (vec3(2.0, 9.0, 5.0));
	s[2].a = (uvec2(7u, 5u));
	s[2].b[0][0] = (vec4(-1.0, 1.0, 1.0, -7.0));
	s[2].b[0][1] = (vec4(6.0, -1.0, 7.0, 8.0));
	s[2].b[1][0] = (vec4(3.0, -2.0, -1.0, -9.0));
	s[2].b[1][1] = (vec4(4.0, -5.0, -4.0, 9.0));
	s[2].b[2][0] = (vec4(-5.0, 9.0, 4.0, -5.0));
	s[2].b[2][1] = (vec4(2.0, -8.0, 3.0, 1.0));
	s[2].b[3][0] = (vec4(3.0, 1.0, 5.0, -6.0));
	s[2].b[3][1] = (vec4(-7.0, 2.0, 0.0, -5.0));
	s[2].c = (vec3(8.0, -4.0, -7.0));
	s[3].a = (uvec2(1u, 0u));
	s[3].b[0][0] = (vec4(0.0, 9.0, 8.0, 7.0));
	s[3].b[0][1] = (vec4(-7.0, 4.0, -2.0, -8.0));
	s[3].b[1][0] = (vec4(-6.0, -1.0, 7.0, -2.0));
	s[3].b[1][1] = (vec4(6.0, -9.0, -1.0, -6.0));
	s[3].b[2][0] = (vec4(-2.0, -2.0, 9.0, -7.0));
	s[3].b[2][1] = (vec4(5.0, 3.0, -7.0, 0.0));
	s[3].b[3][0] = (vec4(-6.0, 4.0, -7.0, -8.0));
	s[3].b[3][1] = (vec4(9.0, -5.0, 1.0, -7.0));
	s[3].c = (vec3(4.0, -4.0, -3.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block[0].var, mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(2.0, -4.0));
	block[0].var[1] = (vec2(-5.0, 3.0));
	block[0].var[2] = (vec2(7.0, 1.0));
	block[0].var[3] = (vec2(8.0, -5.0));
	block[1].var[0] = (vec2(7.0, -3.0));
	block[1].var[1] = (vec2(1.0, -6.0));
	block[1].var[2] = (vec2(9.0, -3.0));
	block[1].var[3] = (vec2(1.0, -5.0));
	block[2].var[0] = (vec2(-8.0, 4.0));
	block[2].var[1] = (vec2(5.0, -9.0));
	block[2].var[2] = (vec2(1.0, -5.0));
	block[2].var[3] = (vec2(-4.0, -2.0));
}
#version 450
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
	highp mat4 var;
} block[3];

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
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-4.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-6.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(0.0, -2.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(-7.0, 6.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(0.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-3.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(7.0, 7.0, -4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -6.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-9.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-9.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(8.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(8.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(-3.0, -6.0, 6.0));
	block[0].var[1] = (vec3(1.0, -4.0, -3.0));
	block[0].var[2] = (vec3(-3.0, 3.0, -2.0));
	block[0].var[3] = (vec3(-7.0, 1.0, -5.0));
	block[1].var[0] = (vec3(-1.0, -5.0, 7.0));
	block[1].var[1] = (vec3(1.0, -2.0, -4.0));
	block[1].var[2] = (vec3(-4.0, -6.0, 5.0));
	block[1].var[3] = (vec3(-2.0, 6.0, -9.0));
	block[2].var[0] = (vec3(5.0, -5.0, 7.0));
	block[2].var[1] = (vec3(-4.0, 8.0, -3.0));
	block[2].var[2] = (vec3(-2.0, 0.0, 8.0));
	block[2].var[3] = (vec3(-2.0, 6.0, -3.0));
}
#version 450
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

layout(std140, binding = 1) buffer BlockB
{
	highp vec4 a;
	highp vec2 b;
	bvec3 c;
	mediump vec2 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(8.0, -2.0, -1.0, -6.0));
	blockB.d = (vec2(8.0, 6.0));
}
#version 450
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
	highp ivec3 a;
} blockB;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

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
	lowp uvec3 mA;
	mediump uvec3 mB;
	lowp mat4x3 mC;
};
layout(std140, binding = 1) buffer BlockB
{
	highp ivec2 a;
	sA b;
	highp mat4x3 c[1];
	lowp mat2x3 d;
	mediump mat3x2 e[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat3x4 f;
	lowp ivec2 g;
	mediump mat2 h;
	highp mat4x3 i;
	lowp int j;
};
layout(std430, binding = 3) buffer BlockD
{
	bool k;
	lowp mat4 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(4, -1)) && allOk;
	allOk = compare_mat4x3(c[0], mat4x3(-2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(f, mat3x4(-1.0, -3.0, -6.0, 7.0, 6.0, -7.0, 2.0, -2.0, 3.0, 3.0, 1.0, 5.0)) && allOk;
	allOk = compare_ivec2((g), ivec2(8, 7)) && allOk;
	allOk = compare_int((j), -9) && allOk;
	allOk = compare_mat4(l[0], mat4(6.0, -1.0, 8.0, -2.0, 7.0, -6.0, -6.0, 3.0, 2.0, 9.0, -4.0, 1.0, 0.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (mat4x3(9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0, 7.0, -3.0));
	d = (mat2x3(2.0, -2.0, 9.0, 5.0, 7.0, -5.0));
	f = (mat3x4(-9.0, -2.0, 9.0, 7.0, 8.0, -1.0, 5.0, -4.0, 9.0, -2.0, -5.0, -8.0));
	g = (ivec2(-4, 0));
	j = (4);
	k = (false);
	l[0] = (mat4(-3.0, 3.0, 6.0, -6.0, 9.0, -8.0, 4.0, 4.0, 7.0, -6.0, 7.0, -9.0, -2.0, 3.0, -8.0, -8.0));
}
#version 450
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
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat2 a;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump mat3x2 b;
	highp mat2 c;
	mediump mat4 d;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat2 e[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp uvec4 f;
	lowp mat4 g;
	sA h;
	mediump uint i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b, mat3x2(-9.0, -1.0, -9.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_uvec4((f), uvec4(2u, 6u, 6u, 7u)) && allOk;
	allOk = compare_mat4(g, mat4(-5.0, 8.0, 8.0, 9.0, 6.0, -2.0, -4.0, 1.0, 6.0, -4.0, 8.0, -4.0, -1.0, -9.0, -5.0, 5.0)) && allOk;
	allOk = compare_uint((i[0]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(-6.0, -2.0, 3.0, -5.0));
	b = (mat3x2(-4.0, 5.0, -9.0, 8.0, 1.0, 9.0));
	blockD.e[0] = (mat2(-8.0, -8.0, -1.0, -5.0));
	f = (uvec4(2u, 2u, 1u, 7u));
	g = (mat4(6.0, -4.0, -9.0, 8.0, -8.0, -5.0, 1.0, 4.0, 3.0, -9.0, -3.0, 8.0, 5.0, 8.0, 1.0, 8.0));
	h.mA = (ivec4(9, 2, 7, -2));
}
#version 450
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
} blockB;

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, false));
}
#version 450
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
	layout(offset = 8) mediump float b;
	layout(offset = 12) lowp float c[1];
	layout(offset = 16) mediump uvec4 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec4 e;
	layout(offset = 16) highp vec3 f[1];
	layout(offset = 32) mediump ivec4 g;
	layout(offset = 48) mediump float h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(9.0, -2.0)) && allOk;
	allOk = compare_float((blockB.b), -1.0) && allOk;
	allOk = compare_float((blockB.c[0]), 7.0) && allOk;
	allOk = compare_ivec4((blockC.g), ivec4(-1, 2, 8, 1)) && allOk;
	allOk = compare_float((blockC.h), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(1.0, -6.0));
	blockB.b = (-2.0);
	blockB.c[0] = (5.0);
	blockB.d = (uvec4(6u, 0u, 6u, 5u));
	blockC.e = (vec4(4.0, -7.0, -3.0, -5.0));
	blockC.f[0] = (vec3(7.0, -3.0, -4.0));
	blockC.h = (-6.0);
}
#version 450
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
	lowp ivec4 mB;
	lowp uvec3 mC;
};
struct sB
{
	mediump mat3x2 mA[7];
	highp vec2 mB;
};
struct sC
{
	sB mA;
	highp mat3x2 mB;
};
struct sD
{
	mediump vec3 mA;
	lowp int mB;
	highp vec2 mC;
};
struct sE
{
	bvec3 mA;
	highp mat4 mB;
	mediump mat4 mC;
	mediump uvec3 mD;
};
struct sF
{
	highp mat3x2 mA;
	highp int mB;
};
struct sG
{
	bool mA;
	sF mB;
	mediump uvec4 mC;
};
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	mediump uvec3 a[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bvec3 b[6];
	highp uvec3 c[];
};
layout(scalar, binding = 3) buffer BlockD
{
	bool d;
	sA e;
	highp mat3x4 f;
	sC g;
	mediump int h[][3];
};
layout(scalar, row_major, binding = 4) buffer BlockE
{
	highp uint i;
	bool j;
	sD k;
	sE l;
	sG m[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((c[0]), uvec3(7u, 0u, 0u)) && allOk;
	allOk = compare_bool((d), false) && allOk;
	allOk = compare_bool((e.mA), false) && allOk;
	allOk = compare_ivec4((e.mB), ivec4(6, -3, 5, -6)) && allOk;
	allOk = compare_uvec3((e.mC), uvec3(7u, 5u, 6u)) && allOk;
	allOk = compare_mat3x4(f, mat3x4(-7.0, 4.0, -9.0, -6.0, 1.0, -2.0, -2.0, -6.0, -5.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_uint((blockE[0].i), 7u) && allOk;
	allOk = compare_vec3((blockE[0].k.mA), vec3(1.0, 6.0, 8.0)) && allOk;
	allOk = compare_int((blockE[0].k.mB), 1) && allOk;
	allOk = compare_vec2((blockE[0].k.mC), vec2(8.0, 4.0)) && allOk;
	allOk = compare_bool((blockE[0].m[0].mA), true) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0].mB.mA, mat3x2(-2.0, 6.0, -7.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_int((blockE[0].m[0].mB.mB), 1) && allOk;
	allOk = compare_uvec4((blockE[0].m[0].mC), uvec4(6u, 2u, 4u, 5u)) && allOk;
	allOk = compare_uint((blockE[1].i), 8u) && allOk;
	allOk = compare_vec3((blockE[1].k.mA), vec3(0.0, 5.0, -7.0)) && allOk;
	allOk = compare_int((blockE[1].k.mB), 6) && allOk;
	allOk = compare_vec2((blockE[1].k.mC), vec2(1.0, -3.0)) && allOk;
	allOk = compare_bool((blockE[1].m[0].mA), false) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0].mB.mA, mat3x2(-2.0, 2.0, 3.0, -6.0, -4.0, 2.0)) && allOk;
	allOk = compare_int((blockE[1].m[0].mB.mB), 4) && allOk;
	allOk = compare_uvec4((blockE[1].m[0].mC), uvec4(7u, 2u, 3u, 9u)) && allOk;
	allOk = compare_bool((blockE[1].m[1].mA), false) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1].mB.mA, mat3x2(-8.0, 2.0, 0.0, 8.0, 9.0, -8.0)) && allOk;
	allOk = compare_int((blockE[1].m[1].mB.mB), 6) && allOk;
	allOk = compare_uvec4((blockE[1].m[1].mC), uvec4(2u, 0u, 2u, 2u)) && allOk;
	allOk = compare_bool((blockE[1].m[2].mA), false) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2].mB.mA, mat3x2(-4.0, 3.0, -1.0, -2.0, 9.0, -6.0)) && allOk;
	allOk = compare_int((blockE[1].m[2].mB.mB), 3) && allOk;
	allOk = compare_uvec4((blockE[1].m[2].mC), uvec4(2u, 1u, 1u, 5u)) && allOk;
	allOk = compare_uint((blockE[2].i), 9u) && allOk;
	allOk = compare_vec3((blockE[2].k.mA), vec3(0.0, 8.0, -3.0)) && allOk;
	allOk = compare_int((blockE[2].k.mB), 7) && allOk;
	allOk = compare_vec2((blockE[2].k.mC), vec2(5.0, 9.0)) && allOk;
	allOk = compare_bool((blockE[2].m[0].mA), true) && allOk;
	allOk = compare_mat3x2(blockE[2].m[0].mB.mA, mat3x2(-5.0, 1.0, 4.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_int((blockE[2].m[0].mB.mB), 2) && allOk;
	allOk = compare_uvec4((blockE[2].m[0].mC), uvec4(4u, 4u, 2u, 7u)) && allOk;
	allOk = compare_bool((blockE[2].m[1].mA), false) && allOk;
	allOk = compare_mat3x2(blockE[2].m[1].mB.mA, mat3x2(-6.0, 6.0, 7.0, -9.0, -8.0, 0.0)) && allOk;
	allOk = compare_int((blockE[2].m[1].mB.mB), -6) && allOk;
	allOk = compare_uvec4((blockE[2].m[1].mC), uvec4(6u, 5u, 8u, 0u)) && allOk;
	allOk = compare_bool((blockE[2].m[2].mA), false) && allOk;
	allOk = compare_mat3x2(blockE[2].m[2].mB.mA, mat3x2(-4.0, -9.0, -8.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_int((blockE[2].m[2].mB.mB), -2) && allOk;
	allOk = compare_uvec4((blockE[2].m[2].mC), uvec4(8u, 9u, 5u, 3u)) && allOk;
	allOk = compare_bool((blockE[2].m[3].mA), true) && allOk;
	allOk = compare_mat3x2(blockE[2].m[3].mB.mA, mat3x2(3.0, 3.0, 8.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_int((blockE[2].m[3].mB.mB), -2) && allOk;
	allOk = compare_uvec4((blockE[2].m[3].mC), uvec4(0u, 4u, 9u, 4u)) && allOk;
	allOk = compare_bool((blockE[2].m[4].mA), true) && allOk;
	allOk = compare_mat3x2(blockE[2].m[4].mB.mA, mat3x2(-7.0, 3.0, 9.0, -1.0, 4.0, -3.0)) && allOk;
	allOk = compare_int((blockE[2].m[4].mB.mB), 6) && allOk;
	allOk = compare_uvec4((blockE[2].m[4].mC), uvec4(6u, 3u, 1u, 6u)) && allOk;
	allOk = compare_bool((blockE[2].m[5].mA), true) && allOk;
	allOk = compare_mat3x2(blockE[2].m[5].mB.mA, mat3x2(-6.0, 2.0, -5.0, 1.0, 9.0, -5.0)) && allOk;
	allOk = compare_int((blockE[2].m[5].mB.mB), 1) && allOk;
	allOk = compare_uvec4((blockE[2].m[5].mC), uvec4(5u, 8u, 4u, 4u)) && allOk;
	allOk = compare_bool((blockE[2].m[6].mA), false) && allOk;
	allOk = compare_mat3x2(blockE[2].m[6].mB.mA, mat3x2(1.0, 0.0, 3.0, 2.0, -3.0, -1.0)) && allOk;
	allOk = compare_int((blockE[2].m[6].mB.mB), 9) && allOk;
	allOk = compare_uvec4((blockE[2].m[6].mC), uvec4(3u, 1u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (bvec3(true, false, true));
	b[1] = (bvec3(false, true, false));
	b[2] = (bvec3(false, false, true));
	b[3] = (bvec3(false, false, false));
	b[4] = (bvec3(false, false, true));
	b[5] = (bvec3(true, false, true));
	c[0] = (uvec3(2u, 1u, 8u));
	d = (false);
	g.mA.mA[0] = (mat3x2(5.0, 3.0, 9.0, 9.0, -9.0, 7.0));
	g.mA.mA[1] = (mat3x2(-2.0, -7.0, -7.0, -4.0, 1.0, 7.0));
	g.mA.mA[2] = (mat3x2(-7.0, 3.0, 7.0, -5.0, -8.0, -5.0));
	g.mA.mA[3] = (mat3x2(7.0, -5.0, 8.0, 5.0, -7.0, -8.0));
	g.mA.mA[4] = (mat3x2(-9.0, -4.0, 6.0, -7.0, 8.0, 5.0));
	g.mA.mA[5] = (mat3x2(-3.0, -2.0, 7.0, 9.0, 4.0, 6.0));
	g.mA.mA[6] = (mat3x2(6.0, -9.0, -3.0, 3.0, -7.0, 2.0));
	g.mA.mB = (vec2(-3.0, 2.0));
	g.mB = (mat3x2(6.0, 5.0, -1.0, 9.0, -9.0, -9.0));
	h[0][0] = (1);
	h[0][1] = (0);
	h[0][2] = (6);
	blockE[0].i = (0u);
	blockE[0].j = (false);
	blockE[0].l.mA = (bvec3(true, true, false));
	blockE[0].l.mB = (mat4(-7.0, 4.0, 5.0, 5.0, -3.0, -3.0, -7.0, 1.0, 7.0, 5.0, -4.0, 8.0, -3.0, 6.0, -8.0, 4.0));
	blockE[0].l.mC = (mat4(9.0, 1.0, -9.0, 5.0, -7.0, 7.0, -8.0, -4.0, 1.0, 1.0, 0.0, 3.0, -6.0, -6.0, 5.0, 6.0));
	blockE[0].l.mD = (uvec3(7u, 5u, 5u));
	blockE[0].m[0].mA = (false);
	blockE[0].m[0].mB.mA = (mat3x2(-1.0, 4.0, -4.0, 5.0, 7.0, 0.0));
	blockE[0].m[0].mB.mB = (0);
	blockE[0].m[0].mC = (uvec4(8u, 8u, 7u, 6u));
	blockE[1].i = (2u);
	blockE[1].j = (true);
	blockE[1].l.mA = (bvec3(false, false, true));
	blockE[1].l.mB = (mat4(2.0, 1.0, 8.0, 4.0, 3.0, -1.0, -5.0, -4.0, 9.0, -2.0, -5.0, -3.0, 7.0, -1.0, -9.0, 9.0));
	blockE[1].l.mC = (mat4(-7.0, 5.0, -6.0, 1.0, 1.0, 8.0, -3.0, 7.0, -9.0, 5.0, -2.0, -9.0, -4.0, -6.0, -1.0, 7.0));
	blockE[1].l.mD = (uvec3(8u, 1u, 5u));
	blockE[1].m[0].mA = (false);
	blockE[1].m[0].mB.mA = (mat3x2(-6.0, 5.0, -2.0, 8.0, -2.0, 3.0));
	blockE[1].m[0].mB.mB = (-4);
	blockE[1].m[0].mC = (uvec4(2u, 8u, 2u, 3u));
	blockE[1].m[1].mA = (true);
	blockE[1].m[1].mB.mA = (mat3x2(-8.0, -6.0, 3.0, -1.0, 7.0, 4.0));
	blockE[1].m[1].mB.mB = (4);
	blockE[1].m[1].mC = (uvec4(0u, 9u, 2u, 8u));
	blockE[1].m[2].mA = (true);
	blockE[1].m[2].mB.mA = (mat3x2(5.0, -5.0, -2.0, -9.0, -4.0, 3.0));
	blockE[1].m[2].mB.mB = (4);
	blockE[1].m[2].mC = (uvec4(8u, 1u, 1u, 2u));
	blockE[2].i = (7u);
	blockE[2].j = (false);
	blockE[2].l.mA = (bvec3(false, true, false));
	blockE[2].l.mB = (mat4(-5.0, 8.0, 7.0, 5.0, -6.0, 8.0, -7.0, -6.0, 5.0, 3.0, -3.0, -6.0, -9.0, 3.0, -1.0, 5.0));
	blockE[2].l.mC = (mat4(-8.0, 8.0, -2.0, 9.0, -5.0, 4.0, 5.0, 2.0, -7.0, -5.0, -7.0, 2.0, 3.0, -2.0, 5.0, 2.0));
	blockE[2].l.mD = (uvec3(2u, 2u, 6u));
	blockE[2].m[0].mA = (false);
	blockE[2].m[0].mB.mA = (mat3x2(7.0, -7.0, -4.0, 6.0, -4.0, 4.0));
	blockE[2].m[0].mB.mB = (-1);
	blockE[2].m[0].mC = (uvec4(5u, 6u, 8u, 6u));
	blockE[2].m[1].mA = (true);
	blockE[2].m[1].mB.mA = (mat3x2(9.0, -1.0, 8.0, -6.0, 2.0, -5.0));
	blockE[2].m[1].mB.mB = (-6);
	blockE[2].m[1].mC = (uvec4(9u, 2u, 0u, 8u));
	blockE[2].m[2].mA = (true);
	blockE[2].m[2].mB.mA = (mat3x2(-7.0, -5.0, -8.0, -7.0, 4.0, -5.0));
	blockE[2].m[2].mB.mB = (2);
	blockE[2].m[2].mC = (uvec4(2u, 1u, 7u, 6u));
	blockE[2].m[3].mA = (false);
	blockE[2].m[3].mB.mA = (mat3x2(0.0, 3.0, -1.0, -8.0, -9.0, 7.0));
	blockE[2].m[3].mB.mB = (6);
	blockE[2].m[3].mC = (uvec4(1u, 7u, 0u, 3u));
	blockE[2].m[4].mA = (true);
	blockE[2].m[4].mB.mA = (mat3x2(-6.0, -9.0, -4.0, 1.0, 4.0, 7.0));
	blockE[2].m[4].mB.mB = (5);
	blockE[2].m[4].mC = (uvec4(7u, 0u, 8u, 4u));
	blockE[2].m[5].mA = (true);
	blockE[2].m[5].mB.mA = (mat3x2(2.0, 0.0, -9.0, 4.0, 6.0, -1.0));
	blockE[2].m[5].mB.mB = (-1);
	blockE[2].m[5].mC = (uvec4(9u, 1u, 1u, 0u));
	blockE[2].m[6].mA = (false);
	blockE[2].m[6].mB.mA = (mat3x2(5.0, -8.0, -7.0, 5.0, 3.0, 5.0));
	blockE[2].m[6].mB.mB = (-6);
	blockE[2].m[6].mC = (uvec4(8u, 9u, 7u, 1u));
}
#version 450
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
	mediump vec4 mB;
};
struct sB
{
	highp uvec4 mA;
	mediump mat3 mB;
	highp ivec4 mC;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump uvec2 a;
	highp mat3x4 b;
	lowp vec4 c;
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp uvec3 d;
	highp mat4 e;
	sA f;
	sB g[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec3((blockC[0].d), uvec3(4u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((blockC[0].g[0].mA), uvec4(6u, 9u, 2u, 1u)) && allOk;
	allOk = compare_mat3(blockC[0].g[0].mB, mat3(-2.0, -4.0, 5.0, -8.0, 8.0, 8.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[0].mC), ivec4(7, 8, -8, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x4(-6.0, -9.0, -1.0, 3.0, -9.0, 7.0, 7.0, 7.0, -9.0, -9.0, 4.0, -3.0));
	blockB.c = (vec4(-7.0, -6.0, 6.0, -3.0));
	blockC[0].e = (mat4(2.0, -1.0, -7.0, 5.0, -9.0, -3.0, -2.0, -5.0, -7.0, -6.0, -7.0, -6.0, -1.0, 1.0, 7.0, 9.0));
	blockC[0].f.mA = (bvec2(true, false));
	blockC[0].f.mB = (vec4(-8.0, 8.0, -4.0, -9.0));
	blockC[0].g[0].mA = (uvec4(3u, 9u, 0u, 4u));
	blockC[0].g[0].mB = (mat3(0.0, 4.0, 4.0, -1.0, -8.0, -8.0, 2.0, 1.0, 3.0));
	blockC[0].g[0].mC = (ivec4(-8, 6, 9, 4));
}
#version 450
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
	mediump mat4 a;
	mediump mat2x3 b[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bool c;
	lowp int d;
	bool e;
	lowp vec2 f[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockC[0].c), true) && allOk;
	allOk = compare_int((blockC[0].d), 9) && allOk;
	allOk = compare_vec2((blockC[0].f[0]), vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2((blockC[0].f[1]), vec2(4.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC[0].f[2]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_bool((blockC[1].c), false) && allOk;
	allOk = compare_int((blockC[1].d), -8) && allOk;
	allOk = compare_vec2((blockC[1].f[0]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2((blockC[1].f[1]), vec2(1.0, 5.0)) && allOk;
	allOk = compare_vec2((blockC[1].f[2]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC[1].f[3]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC[1].f[4]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec2((blockC[1].f[5]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2((blockC[1].f[6]), vec2(-7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat2x3(-6.0, -6.0, 7.0, 0.0, -1.0, 9.0));
	b[1] = (mat2x3(3.0, 6.0, -4.0, 3.0, 6.0, -4.0));
	b[2] = (mat2x3(8.0, -7.0, -7.0, -6.0, -5.0, 4.0));
	b[3] = (mat2x3(6.0, 9.0, 1.0, 3.0, -4.0, -2.0));
	b[4] = (mat2x3(8.0, -5.0, 7.0, 0.0, -4.0, -1.0));
	b[5] = (mat2x3(2.0, -4.0, -5.0, -5.0, -2.0, -5.0));
	b[6] = (mat2x3(-9.0, 0.0, 2.0, -9.0, -5.0, 8.0));
	blockC[0].c = (false);
	blockC[0].f[0] = (vec2(-9.0, -6.0));
	blockC[0].f[1] = (vec2(7.0, -9.0));
	blockC[0].f[2] = (vec2(-8.0, 6.0));
	blockC[1].c = (false);
	blockC[1].f[0] = (vec2(-7.0, 5.0));
	blockC[1].f[1] = (vec2(-7.0, -7.0));
	blockC[1].f[2] = (vec2(2.0, 4.0));
	blockC[1].f[3] = (vec2(0.0, 3.0));
	blockC[1].f[4] = (vec2(2.0, -3.0));
	blockC[1].f[5] = (vec2(-4.0, -3.0));
	blockC[1].f[6] = (vec2(0.0, 6.0));
}
#version 450
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
	mediump vec3 a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(8.0, 6.0, 5.0));
	blockB.a[1] = (vec3(9.0, 2.0, -3.0));
	blockB.a[2] = (vec3(0.0, -5.0, -4.0));
	blockB.a[3] = (vec3(1.0, -6.0, 1.0));
	blockB.a[4] = (vec3(-8.0, 6.0, -3.0));
	blockB.a[5] = (vec3(3.0, -6.0, -1.0));
}
#version 450
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
	lowp uvec4 a;
	highp ivec3 b;
	mediump float c;
	highp uint d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].a), uvec4(7u, 0u, 1u, 9u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(0)].c), 4.0) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].a), uvec4(8u, 3u, 4u, 5u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].c), -5.0) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(2)].a), uvec4(4u, 8u, 3u, 0u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].c), -7.0) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(3)].a), uvec4(2u, 3u, 7u, 6u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].c), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (ivec3(-3, 7, -3));
	blockB[nonuniformEXT(0)].c = (4.0);
	blockB[nonuniformEXT(1)].b = (ivec3(4, 2, -9));
	blockB[nonuniformEXT(1)].c = (-8.0);
	blockB[nonuniformEXT(2)].b = (ivec3(-6, -4, -2));
	blockB[nonuniformEXT(2)].c = (-8.0);
	blockB[nonuniformEXT(3)].b = (ivec3(8, 0, -1));
	blockB[nonuniformEXT(3)].c = (1.0);
}
#version 450
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
	highp vec2 c[7];
	mediump mat4x3 d;
	lowp vec2 e;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp ivec2 f;
	lowp mat2x3 g;
	lowp uvec3 h;
	f16vec4 i[6];
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
	allOk = compare_vec2((c[1]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec2((c[2]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((c[3]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((c[4]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((c[5]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((c[6]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-7.0, 4.0, 1.0, -6.0, -7.0, 2.0, 8.0, -2.0, 8.0, 0.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec2((e), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-6, 7)) && allOk;
	allOk = compare_mat2x3(blockC.g, mat2x3(-7.0, 9.0, -2.0, 7.0, 6.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockC.h), uvec3(0u, 4u, 7u)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.i[0]), vec4(6.0, 7.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.i[1]), vec4(-9.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.i[2]), vec4(6.0, 1.0, 7.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.i[3]), vec4(-4.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.i[4]), vec4(4.0, -3.0, 0.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.i[5]), vec4(7.0, -9.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (false);
	e = (vec2(-3.0, 2.0));
	blockC.f = (ivec2(0, 0));
	blockC.h = (uvec3(4u, 2u, 5u));
	blockC.i[0] = f16vec4(vec4(-4.0, 1.0, 8.0, 7.0));
	blockC.i[1] = f16vec4(vec4(-4.0, -3.0, -2.0, 7.0));
	blockC.i[2] = f16vec4(vec4(-9.0, 3.0, 8.0, 2.0));
	blockC.i[3] = f16vec4(vec4(4.0, -8.0, -4.0, -3.0));
	blockC.i[4] = f16vec4(vec4(-8.0, 8.0, -8.0, 3.0));
	blockC.i[5] = f16vec4(vec4(-1.0, 4.0, 4.0, -4.0));
}
#version 450
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
	mediump vec4 a;
	u16vec2 b;
	f16vec2 c;
	float16_t d;
	i16vec3 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(b), uvec2(3u, 7u)) && allOk;
	allOk = compare_f16vec2(vec2(c), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(e), ivec3(-5, 1, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-2.0, -9.0, -3.0, -1.0));
	b = u16vec2(uvec2(5u, 6u));
	e = i16vec3(ivec3(-9, 4, -6));
}
#version 450
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
	uint16_t a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp uvec4 b;
	mediump uvec3 c;
	highp vec3 d[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat3x2 e;
	mediump mat3x4 f;
	float16_t g;
	uint16_t h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a[0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(a[1]), 3u) && allOk;
	allOk = compare_uint16_t(uint(a[2]), 7u) && allOk;
	allOk = compare_uint16_t(uint(a[3]), 5u) && allOk;
	allOk = compare_uint16_t(uint(a[4]), 3u) && allOk;
	allOk = compare_uint16_t(uint(a[5]), 2u) && allOk;
	allOk = compare_uint16_t(uint(a[6]), 4u) && allOk;
	allOk = compare_uint16_t(uint(a[7]), 7u) && allOk;
	allOk = compare_uvec4((blockC.b), uvec4(0u, 3u, 2u, 0u)) && allOk;
	allOk = compare_mat3x2(e, mat3x2(-5.0, -7.0, 3.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(f, mat3x4(0.0, -5.0, 0.0, 1.0, -8.0, 0.0, 3.0, -5.0, 5.0, -7.0, 1.0, -8.0)) && allOk;
	allOk = compare_float16_t(float(g), 2.0) && allOk;
	allOk = compare_uint16_t(uint(h[0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(h[1]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = uint16_t(2u);
	a[1] = uint16_t(0u);
	a[2] = uint16_t(0u);
	a[3] = uint16_t(7u);
	a[4] = uint16_t(4u);
	a[5] = uint16_t(5u);
	a[6] = uint16_t(2u);
	a[7] = uint16_t(5u);
	blockC.c = (uvec3(1u, 1u, 6u));
	blockC.d[0] = (vec3(-3.0, 9.0, 4.0));
	e = (mat3x2(0.0, 4.0, 5.0, -2.0, 4.0, -6.0));
	f = (mat3x4(5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0, -1.0, -6.0));
	g = float16_t(9.0);
}
#version 450
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
	float16_t a[1];
	lowp uvec2 b;
	highp ivec3 c;
	highp int d;
	mediump vec2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(a[0]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = float16_t(8.0);
	b = (uvec2(4u, 9u));
	c = (ivec3(5, -4, 2));
	e[0] = (vec2(9.0, -3.0));
}
#version 450
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
	u16vec4 a[];
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	mediump int b;
	highp ivec4 c;
	mediump mat2x3 d[];
};
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	bvec3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a[0]), uvec4(4u, 3u, 5u, 9u)) && allOk;
	allOk = compare_int((b), 0) && allOk;
	allOk = compare_mat2x3(d[0], mat2x3(9.0, 1.0, -5.0, -2.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 a;
	i16vec3 b[];
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = i16vec3(ivec3(-4, 8, 6));
	blockB[0].b[1] = i16vec3(ivec3(-3, -7, -4));
	blockB[0].b[2] = i16vec3(ivec3(-2, -9, -8));
	blockB[0].b[3] = i16vec3(ivec3(-5, 9, -1));
	blockB[0].b[4] = i16vec3(ivec3(1, 7, 9));
	blockB[0].b[5] = i16vec3(ivec3(-8, -6, 4));
	blockB[1].b[0] = i16vec3(ivec3(-8, -6, 3));
	blockB[1].b[1] = i16vec3(ivec3(2, 7, 2));
	blockB[1].b[2] = i16vec3(ivec3(-9, 1, -9));
	blockB[1].b[3] = i16vec3(ivec3(6, 2, -1));
	blockB[1].b[4] = i16vec3(ivec3(2, -5, -8));
	blockB[2].b[0] = i16vec3(ivec3(-2, -2, -7));
	blockB[2].b[1] = i16vec3(ivec3(-8, -9, -2));
	blockB[2].b[2] = i16vec3(ivec3(6, 0, -7));
	blockB[2].b[3] = i16vec3(ivec3(3, -7, -1));
	blockB[2].b[4] = i16vec3(ivec3(-5, 1, 4));
	blockB[2].b[5] = i16vec3(ivec3(-3, 4, 5));
	blockB[2].b[6] = i16vec3(ivec3(0, 7, -5));
}
#version 450
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
	layout(offset = 0) f16vec3 a;
	layout(offset = 8) highp uvec2 b[1];
	layout(offset = 16) i16vec3 c[1];
	layout(offset = 24) bool d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u16vec2 e;
	layout(offset = 4) i16vec3 f;
	layout(offset = 12) lowp float g;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i16vec2 h;
	layout(offset = 8) mediump ivec2 i[1];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a), vec3(6.0, -5.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockB.b[0]), uvec2(2u, 9u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c[0]), ivec3(-3, 9, 4)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.h), ivec2(0, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(-2.0, -4.0, -9.0));
	blockB.b[0] = (uvec2(8u, 9u));
	blockB.d = (false);
	e = u16vec2(uvec2(5u, 3u));
	f = i16vec3(ivec3(0, 0, -1));
	g = (-8.0);
	blockD.h = i16vec2(ivec2(-1, -9));
	blockD.i[0] = (ivec2(-8, -9));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	mediump ivec2 a[];
} blockB;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

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

layout(std140, binding = 1) buffer BlockB
{
	u8vec3 a;
	lowp vec3 b;
	uint8_t c;
	i8vec3 d;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec3 e;
	mediump int f;
	bvec2 g;
};
layout(std430, binding = 3) readonly buffer BlockD
{
	highp int h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_vec3((b), vec3(2.0, 4.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(d), ivec3(6, 4294967295, 5)) && allOk;
	allOk = compare_ivec3((e), ivec3(-9, 9, -2)) && allOk;
	allOk = compare_int((f), -9) && allOk;
	allOk = compare_bvec2((g), bvec2(true, false)) && allOk;
	allOk = compare_int((h), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec3(uvec3(3u, 1u, 6u));
	b = (vec3(-2.0, 2.0, -7.0));
	d = i8vec3(ivec3(6, 4294967288, 8));
	e = (ivec3(-3, 3, -3));
	f = (-1);
	g = (bvec2(true, false));
}
#version 450
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
	mediump uvec2 a;
	lowp ivec4 b;
	bool c;
	highp mat3x4 d[];
} blockB;
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	mediump uvec2 e;
	lowp mat4x3 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(-6, -3, -1, -9)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_mat3x4(blockB.d[0], mat3x4(-7.0, -4.0, -8.0, 9.0, -9.0, -8.0, -6.0, -2.0, 8.0, 8.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[1], mat3x4(1.0, -1.0, 8.0, 8.0, 1.0, 9.0, 4.0, -6.0, 7.0, -5.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[2], mat3x4(2.0, 3.0, 0.0, 4.0, -5.0, -5.0, -2.0, -6.0, 9.0, -3.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[3], mat3x4(5.0, -4.0, -4.0, 0.0, -2.0, 8.0, -6.0, -9.0, 4.0, -5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[4], mat3x4(8.0, -4.0, 6.0, 2.0, -5.0, -9.0, 8.0, 7.0, 8.0, 6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[5], mat3x4(6.0, 0.0, 5.0, -8.0, 7.0, -3.0, -5.0, -1.0, -7.0, 7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(f[0], mat4x3(2.0, -7.0, -6.0, 2.0, 7.0, -8.0, -4.0, -7.0, -3.0, 0.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(f[1], mat4x3(2.0, -3.0, -6.0, 1.0, 4.0, 9.0, -7.0, 4.0, 6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(f[2], mat4x3(9.0, -3.0, -4.0, -3.0, -6.0, 7.0, -4.0, 0.0, 7.0, -6.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(f[3], mat4x3(-7.0, 4.0, -9.0, -4.0, -2.0, 2.0, 2.0, 9.0, -6.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x3(f[4], mat4x3(9.0, -4.0, 6.0, -7.0, 0.0, -8.0, -2.0, 5.0, 5.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(f[5], mat4x3(-4.0, -6.0, -4.0, -3.0, -4.0, -2.0, -5.0, 1.0, 8.0, -7.0, -9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(7u, 9u));
	blockB.b = (ivec4(5, 5, -3, -5));
	blockB.c = (true);
	blockB.d[0] = (mat3x4(-9.0, 1.0, 9.0, 7.0, 2.0, 9.0, -3.0, -9.0, 6.0, -5.0, 6.0, -6.0));
	blockB.d[1] = (mat3x4(-1.0, 3.0, -4.0, -1.0, 3.0, 9.0, -8.0, 2.0, 5.0, 8.0, -5.0, 0.0));
	blockB.d[2] = (mat3x4(5.0, 2.0, -6.0, -2.0, 3.0, 4.0, 4.0, -4.0, -3.0, 4.0, -5.0, -5.0));
	blockB.d[3] = (mat3x4(7.0, 0.0, 1.0, -9.0, 6.0, -7.0, 9.0, -2.0, -9.0, 2.0, 2.0, -7.0));
	blockB.d[4] = (mat3x4(8.0, 7.0, -3.0, 7.0, 8.0, 9.0, -1.0, -2.0, 8.0, -6.0, 3.0, -7.0));
	blockB.d[5] = (mat3x4(-7.0, 8.0, -8.0, 8.0, -5.0, 6.0, -7.0, 1.0, 3.0, -1.0, 3.0, 4.0));
}
#version 450
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
	highp mat3x4 mA;
	bvec4 mB;
};
struct sB
{
	bvec2 mA[8];
	sA mB;
	highp int mC;
	u8vec2 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	lowp vec2 a;
	bvec4 b[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp int c;
	bvec3 d[];
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	u8vec2 e;
	highp ivec4 f;
	bool g;
	u8vec2 h;
	bvec2 i;
};
layout(std140, binding = 4) buffer BlockE
{
	sB j;
	mediump mat3x2 k;
	u8vec3 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.b[1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB.b[2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.b[3]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_int((blockC[0].c), -9) && allOk;
	allOk = compare_bvec3((blockC[0].d[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC[0].d[1]), bvec3(false, false, true)) && allOk;
	allOk = compare_int((blockC[1].c), -5) && allOk;
	allOk = compare_bvec3((blockC[1].d[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC[1].d[1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC[1].d[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(e), uvec2(2u, 7u)) && allOk;
	allOk = compare_bool((g), false) && allOk;
	allOk = compare_mat3x2(k, mat3x2(2.0, -5.0, 7.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_u8vec3(uvec3(l[0]), uvec3(5u, 6u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(l[1]), uvec3(9u, 2u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(l[2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(l[3]), uvec3(0u, 1u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(l[4]), uvec3(8u, 2u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(l[5]), uvec3(2u, 3u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(l[6]), uvec3(9u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec4(false, true, true, true));
	blockB.b[1] = (bvec4(false, false, true, false));
	blockB.b[2] = (bvec4(true, false, true, false));
	blockB.b[3] = (bvec4(false, false, false, true));
	blockC[0].c = (-1);
	blockC[1].c = (7);
	e = u8vec2(uvec2(7u, 9u));
	f = (ivec4(5, 8, 1, 8));
	i = (bvec2(false, true));
	j.mA[0] = (bvec2(true, true));
	j.mA[1] = (bvec2(false, true));
	j.mA[2] = (bvec2(false, false));
	j.mA[3] = (bvec2(true, false));
	j.mA[4] = (bvec2(false, false));
	j.mA[5] = (bvec2(false, false));
	j.mA[6] = (bvec2(false, true));
	j.mA[7] = (bvec2(false, false));
	j.mB.mA = (mat3x4(7.0, 4.0, -4.0, 4.0, -1.0, 7.0, -1.0, 4.0, -8.0, -7.0, -7.0, 1.0));
	j.mB.mB = (bvec4(false, true, true, true));
	j.mC = (-6);
	j.mD = u8vec2(uvec2(5u, 4u));
	k = (mat3x2(8.0, 2.0, 1.0, -9.0, 9.0, -5.0));
}
#version 450
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
	i8vec4 mA;
	highp vec4 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	lowp mat4x2 a;
	mediump mat4x2 b[];
};
layout(std430, binding = 2) buffer BlockC
{
	highp ivec3 c;
	i8vec3 d;
	int8_t e;
	sA f[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	u8vec2 g;
	mediump mat3 h;
	mediump uvec3 i;
	bvec3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(b[0], mat4x2(-3.0, 5.0, 6.0, 8.0, -8.0, 9.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(b[1], mat4x2(3.0, -5.0, -8.0, 3.0, 6.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(b[2], mat4x2(-6.0, 3.0, -1.0, 9.0, -3.0, 9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(b[3], mat4x2(6.0, -4.0, 6.0, -4.0, 2.0, -6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(b[4], mat4x2(-5.0, 1.0, -9.0, -9.0, 1.0, 7.0, -1.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(9, -9, -8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d), ivec3(6, 0, 4294967293)) && allOk;
	allOk = compare_int8_t(int(blockC.e), 7) && allOk;
	allOk = compare_bvec3((j[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((j[1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((j[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((j[3]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(-6.0, -9.0, 9.0, 5.0, 6.0, -9.0, 4.0, 0.0));
	b[0] = (mat4x2(-5.0, 0.0, -7.0, -6.0, -7.0, 3.0, 9.0, -4.0));
	b[1] = (mat4x2(1.0, -6.0, 4.0, 6.0, 9.0, 8.0, -8.0, -8.0));
	b[2] = (mat4x2(-4.0, 9.0, -2.0, -5.0, 3.0, -8.0, 1.0, 2.0));
	b[3] = (mat4x2(9.0, -1.0, -6.0, 4.0, -2.0, -1.0, 3.0, 3.0));
	b[4] = (mat4x2(-9.0, 7.0, 2.0, -5.0, -2.0, 3.0, -2.0, -5.0));
	blockC.c = (ivec3(-3, 7, 9));
	blockC.d = i8vec3(ivec3(4294967287, 1, 4294967291));
	blockC.e = int8_t(0);
	blockC.f[0].mA = i8vec4(ivec4(1, 4294967287, 1, 0));
	blockC.f[0].mB = (vec4(9.0, -8.0, -4.0, 2.0));
	g = u8vec2(uvec2(9u, 1u));
	h = (mat3(3.0, -9.0, 6.0, 1.0, 7.0, -1.0, 1.0, 1.0, 6.0));
	j[0] = (bvec3(false, false, false));
	j[1] = (bvec3(false, false, true));
	j[2] = (bvec3(false, false, false));
	j[3] = (bvec3(false, true, true));
}
#version 450
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
	u8vec2 mA[3];
	mediump uvec2 mB;
	lowp mat3 mC;
};
struct sB
{
	i8vec4 mA;
	mediump mat4x2 mB;
	int8_t mC;
	mediump ivec4 mD;
};
struct sC
{
	lowp ivec4 mA;
	highp ivec2 mB;
};
struct sD
{
	bool mA;
	bvec4 mB;
	i8vec3 mC;
	lowp uvec2 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	lowp int a;
	u8vec4 b;
	sA c[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	sB d;
	bool e;
	mediump mat4x2 f;
	i8vec2 g;
	mediump vec4 h[][6][4];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp vec3 i;
	highp uvec3 j;
	mediump vec2 k;
	int8_t l;
	int8_t m[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	sC n;
	sD o;
	bvec3 p;
	mediump vec2 q[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.b), uvec4(0u, 6u, 4u, 5u)) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-1.0, 6.0, -1.0, 5.0, -9.0, -8.0, 2.0, 6.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.g), ivec2(3, 4294967288)) && allOk;
	allOk = compare_vec4((blockC.h[0][0][0]), vec4(-9.0, 3.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][0][1]), vec4(-4.0, 9.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][0][2]), vec4(0.0, 4.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][0][3]), vec4(9.0, -8.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][1][0]), vec4(2.0, -4.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][1][1]), vec4(9.0, -4.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][1][2]), vec4(-7.0, 2.0, 6.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][1][3]), vec4(0.0, 2.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][2][0]), vec4(-2.0, -8.0, 7.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][2][1]), vec4(2.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][2][2]), vec4(-5.0, -8.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][2][3]), vec4(-6.0, 5.0, -2.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][3][0]), vec4(-2.0, 5.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][3][1]), vec4(-3.0, 9.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][3][2]), vec4(5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][3][3]), vec4(-7.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][4][0]), vec4(-9.0, -1.0, 7.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][4][1]), vec4(0.0, 3.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][4][2]), vec4(7.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][4][3]), vec4(-4.0, -7.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][5][0]), vec4(-2.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][5][1]), vec4(-3.0, -1.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][5][2]), vec4(1.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC.h[0][5][3]), vec4(-5.0, 2.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][0][0]), vec4(2.0, 7.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][0][1]), vec4(7.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][0][2]), vec4(2.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][0][3]), vec4(-7.0, -1.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][1][0]), vec4(7.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][1][1]), vec4(7.0, -4.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][1][2]), vec4(-7.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][1][3]), vec4(3.0, 5.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][2][0]), vec4(9.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][2][1]), vec4(0.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][2][2]), vec4(-7.0, -1.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][2][3]), vec4(9.0, 5.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][3][0]), vec4(8.0, 8.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][3][1]), vec4(-7.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][3][2]), vec4(-9.0, 4.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][3][3]), vec4(2.0, -2.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][4][0]), vec4(6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][4][1]), vec4(0.0, -7.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][4][2]), vec4(2.0, 2.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][4][3]), vec4(-1.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][5][0]), vec4(3.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][5][1]), vec4(-7.0, 8.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][5][2]), vec4(-6.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[1][5][3]), vec4(-8.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][0][0]), vec4(-3.0, 5.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][0][1]), vec4(-4.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][0][2]), vec4(8.0, -1.0, -3.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][0][3]), vec4(2.0, -2.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][1][0]), vec4(-6.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][1][1]), vec4(5.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][1][2]), vec4(-1.0, 8.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][1][3]), vec4(4.0, -3.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][2][0]), vec4(2.0, -4.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][2][1]), vec4(4.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][2][2]), vec4(1.0, 3.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][2][3]), vec4(-6.0, 6.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][3][0]), vec4(-8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][3][1]), vec4(-4.0, 4.0, 7.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][3][2]), vec4(-9.0, 1.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][3][3]), vec4(-5.0, -9.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][4][0]), vec4(-2.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][4][1]), vec4(6.0, 6.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][4][2]), vec4(-8.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][4][3]), vec4(-4.0, -8.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][5][0]), vec4(-7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][5][1]), vec4(-7.0, 7.0, 6.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][5][2]), vec4(6.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[2][5][3]), vec4(5.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][0][0]), vec4(-1.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][0][1]), vec4(4.0, 8.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][0][2]), vec4(7.0, 6.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][0][3]), vec4(-5.0, -7.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][1][0]), vec4(-1.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][1][1]), vec4(-5.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][1][2]), vec4(8.0, -5.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][1][3]), vec4(-8.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][2][0]), vec4(-4.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][2][1]), vec4(1.0, 0.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][2][2]), vec4(-7.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][2][3]), vec4(7.0, 3.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][3][0]), vec4(3.0, 8.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][3][1]), vec4(5.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][3][2]), vec4(-7.0, -1.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][3][3]), vec4(8.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][4][0]), vec4(9.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][4][1]), vec4(4.0, 3.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][4][2]), vec4(-4.0, 9.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][4][3]), vec4(-8.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][5][0]), vec4(-7.0, -3.0, 3.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][5][1]), vec4(9.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][5][2]), vec4(0.0, 4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[3][5][3]), vec4(2.0, -4.0, -5.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][0][0]), vec4(-2.0, 8.0, 7.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][0][1]), vec4(-2.0, 1.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][0][2]), vec4(3.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][0][3]), vec4(4.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][1][0]), vec4(-3.0, 1.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][1][1]), vec4(-7.0, 6.0, 8.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][1][2]), vec4(-2.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][1][3]), vec4(3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][2][0]), vec4(-6.0, 7.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][2][1]), vec4(5.0, 6.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][2][2]), vec4(-8.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][2][3]), vec4(6.0, -3.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][3][0]), vec4(-4.0, 6.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][3][1]), vec4(-6.0, 2.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][3][2]), vec4(0.0, 6.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][3][3]), vec4(5.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][4][0]), vec4(-5.0, 3.0, -6.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][4][1]), vec4(-9.0, -7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][4][2]), vec4(-8.0, 9.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][4][3]), vec4(-4.0, 4.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][5][0]), vec4(-1.0, -8.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][5][1]), vec4(-9.0, -4.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][5][2]), vec4(-1.0, -1.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[4][5][3]), vec4(-5.0, -6.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.h[5][0][0]), vec4(1.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[5][0][1]), vec4(5.0, -7.0, -8.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[5][0][2]), vec4(-5.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[5][0][3]), vec4(7.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.h[5][1][0]), vec4(9.0, -8.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.h[5][1][1]), vec4(-6.0, 9.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0);
	blockB.c[0].mA[0] = u8vec2(uvec2(5u, 6u));
	blockB.c[0].mA[1] = u8vec2(uvec2(2u, 7u));
	blockB.c[0].mA[2] = u8vec2(uvec2(9u, 8u));
	blockB.c[0].mB = (uvec2(2u, 6u));
	blockB.c[0].mC = (mat3(-9.0, 8.0, 4.0, -7.0, -7.0, -9.0, -8.0, 8.0, 6.0));
	blockB.c[1].mA[0] = u8vec2(uvec2(0u, 8u));
	blockB.c[1].mA[1] = u8vec2(uvec2(1u, 8u));
	blockB.c[1].mA[2] = u8vec2(uvec2(9u, 5u));
	blockB.c[1].mB = (uvec2(5u, 5u));
	blockB.c[1].mC = (mat3(-7.0, -6.0, -4.0, 5.0, -9.0, 8.0, -9.0, 2.0, -2.0));
	blockB.c[2].mA[0] = u8vec2(uvec2(5u, 0u));
	blockB.c[2].mA[1] = u8vec2(uvec2(1u, 5u));
	blockB.c[2].mA[2] = u8vec2(uvec2(4u, 3u));
	blockB.c[2].mB = (uvec2(0u, 0u));
	blockB.c[2].mC = (mat3(5.0, 9.0, 3.0, 0.0, 6.0, -2.0, -4.0, 5.0, 1.0));
	blockB.c[3].mA[0] = u8vec2(uvec2(4u, 0u));
	blockB.c[3].mA[1] = u8vec2(uvec2(9u, 1u));
	blockB.c[3].mA[2] = u8vec2(uvec2(8u, 5u));
	blockB.c[3].mB = (uvec2(1u, 9u));
	blockB.c[3].mC = (mat3(-9.0, 2.0, 3.0, -9.0, 6.0, -2.0, 9.0, -9.0, 1.0));
	blockC.d.mA = i8vec4(ivec4(9, 4294967292, 5, 4294967288));
	blockC.d.mB = (mat4x2(9.0, -8.0, -5.0, 6.0, -5.0, 4.0, 8.0, -1.0));
	blockC.d.mC = int8_t(4294967295);
	blockC.d.mD = (ivec4(-3, -8, -3, -9));
	blockC.e = (false);
	blockC.h[0][0][0] = (vec4(3.0, -9.0, 3.0, 2.0));
	blockC.h[0][0][1] = (vec4(-4.0, -2.0, 1.0, 9.0));
	blockC.h[0][0][2] = (vec4(7.0, 1.0, 9.0, 1.0));
	blockC.h[0][0][3] = (vec4(-4.0, -7.0, 0.0, 8.0));
	blockC.h[0][1][0] = (vec4(3.0, -3.0, -7.0, -5.0));
	blockC.h[0][1][1] = (vec4(5.0, 3.0, 9.0, 8.0));
	blockC.h[0][1][2] = (vec4(-9.0, 6.0, 2.0, -5.0));
	blockC.h[0][1][3] = (vec4(8.0, 2.0, -5.0, 2.0));
	blockC.h[0][2][0] = (vec4(9.0, 0.0, -1.0, -4.0));
	blockC.h[0][2][1] = (vec4(2.0, -9.0, -2.0, 8.0));
	blockC.h[0][2][2] = (vec4(0.0, 7.0, -3.0, 5.0));
	blockC.h[0][2][3] = (vec4(-3.0, 3.0, -9.0, 6.0));
	blockC.h[0][3][0] = (vec4(-3.0, -7.0, 2.0, 0.0));
	blockC.h[0][3][1] = (vec4(-8.0, 8.0, -5.0, 3.0));
	blockC.h[0][3][2] = (vec4(-8.0, -1.0, -8.0, -9.0));
	blockC.h[0][3][3] = (vec4(6.0, 3.0, -7.0, -2.0));
	blockC.h[0][4][0] = (vec4(7.0, -8.0, 4.0, -1.0));
	blockC.h[0][4][1] = (vec4(-9.0, 7.0, 0.0, 9.0));
	blockC.h[0][4][2] = (vec4(-9.0, -2.0, 0.0, -1.0));
	blockC.h[0][4][3] = (vec4(-1.0, -8.0, -2.0, 2.0));
	blockC.h[0][5][0] = (vec4(-5.0, 7.0, 6.0, -6.0));
	blockC.h[0][5][1] = (vec4(-8.0, 4.0, -6.0, 4.0));
	blockC.h[0][5][2] = (vec4(2.0, -1.0, -7.0, 5.0));
	blockC.h[0][5][3] = (vec4(7.0, 0.0, -2.0, -1.0));
	blockC.h[1][0][0] = (vec4(-3.0, -1.0, 5.0, 2.0));
	blockC.h[1][0][1] = (vec4(-3.0, 1.0, 8.0, 1.0));
	blockC.h[1][0][2] = (vec4(-3.0, 5.0, 6.0, -3.0));
	blockC.h[1][0][3] = (vec4(-3.0, -1.0, -4.0, -1.0));
	blockC.h[1][1][0] = (vec4(-5.0, -3.0, -9.0, 9.0));
	blockC.h[1][1][1] = (vec4(0.0, 2.0, -3.0, 1.0));
	blockC.h[1][1][2] = (vec4(0.0, 4.0, -5.0, 1.0));
	blockC.h[1][1][3] = (vec4(1.0, 7.0, -2.0, 8.0));
	blockC.h[1][2][0] = (vec4(3.0, -4.0, 2.0, -8.0));
	blockC.h[1][2][1] = (vec4(-5.0, -7.0, 9.0, -2.0));
	blockC.h[1][2][2] = (vec4(5.0, -8.0, 7.0, 5.0));
	blockC.h[1][2][3] = (vec4(-4.0, -1.0, 5.0, 3.0));
	blockC.h[1][3][0] = (vec4(7.0, -2.0, 6.0, -8.0));
	blockC.h[1][3][1] = (vec4(6.0, 4.0, 5.0, -8.0));
	blockC.h[1][3][2] = (vec4(-9.0, -9.0, -4.0, -5.0));
	blockC.h[1][3][3] = (vec4(-8.0, -1.0, 6.0, 7.0));
	blockC.h[1][4][0] = (vec4(-6.0, 4.0, 5.0, 0.0));
	blockC.h[1][4][1] = (vec4(-8.0, -5.0, -2.0, 9.0));
	blockC.h[1][4][2] = (vec4(-6.0, -9.0, -3.0, -7.0));
	blockC.h[1][4][3] = (vec4(2.0, 4.0, 1.0, -5.0));
	blockC.h[1][5][0] = (vec4(-8.0, -8.0, 2.0, 3.0));
	blockC.h[1][5][1] = (vec4(-3.0, 5.0, -2.0, -3.0));
	blockC.h[1][5][2] = (vec4(-5.0, -6.0, 5.0, 8.0));
	blockC.h[1][5][3] = (vec4(-6.0, -1.0, -7.0, -4.0));
	blockC.h[2][0][0] = (vec4(1.0, 3.0, 8.0, 4.0));
	blockC.h[2][0][1] = (vec4(-7.0, 4.0, 1.0, -8.0));
	blockC.h[2][0][2] = (vec4(-4.0, -8.0, 3.0, -4.0));
	blockC.h[2][0][3] = (vec4(-7.0, 7.0, 3.0, 7.0));
	blockC.h[2][1][0] = (vec4(-5.0, 1.0, 3.0, 4.0));
	blockC.h[2][1][1] = (vec4(-7.0, 8.0, 8.0, -4.0));
	blockC.h[2][1][2] = (vec4(9.0, -7.0, 1.0, 4.0));
	blockC.h[2][1][3] = (vec4(-4.0, 1.0, -9.0, 2.0));
	blockC.h[2][2][0] = (vec4(8.0, 4.0, 3.0, 2.0));
	blockC.h[2][2][1] = (vec4(3.0, 0.0, 1.0, -8.0));
	blockC.h[2][2][2] = (vec4(9.0, 5.0, -3.0, -8.0));
	blockC.h[2][2][3] = (vec4(1.0, 4.0, -8.0, 2.0));
	blockC.h[2][3][0] = (vec4(6.0, -3.0, 7.0, 4.0));
	blockC.h[2][3][1] = (vec4(-8.0, 0.0, 7.0, 0.0));
	blockC.h[2][3][2] = (vec4(-5.0, 0.0, -6.0, 4.0));
	blockC.h[2][3][3] = (vec4(-1.0, 8.0, -5.0, -8.0));
	blockC.h[2][4][0] = (vec4(6.0, -4.0, 9.0, 2.0));
	blockC.h[2][4][1] = (vec4(-9.0, 7.0, 4.0, -6.0));
	blockC.h[2][4][2] = (vec4(-1.0, -4.0, 1.0, -5.0));
	blockC.h[2][4][3] = (vec4(-9.0, 2.0, -5.0, 9.0));
	blockC.h[2][5][0] = (vec4(9.0, 5.0, -2.0, 0.0));
	blockC.h[2][5][1] = (vec4(1.0, 0.0, -9.0, -1.0));
	blockC.h[2][5][2] = (vec4(-2.0, -6.0, 2.0, 2.0));
	blockC.h[2][5][3] = (vec4(-2.0, -4.0, -3.0, 6.0));
	blockC.h[3][0][0] = (vec4(-9.0, 5.0, -5.0, 1.0));
	blockC.h[3][0][1] = (vec4(-5.0, 3.0, -5.0, -5.0));
	blockC.h[3][0][2] = (vec4(-3.0, -2.0, -8.0, 5.0));
	blockC.h[3][0][3] = (vec4(-2.0, -8.0, -5.0, -9.0));
	blockC.h[3][1][0] = (vec4(-9.0, -6.0, 7.0, 2.0));
	blockC.h[3][1][1] = (vec4(-4.0, 0.0, 9.0, 0.0));
	blockC.h[3][1][2] = (vec4(1.0, -4.0, -7.0, -7.0));
	blockC.h[3][1][3] = (vec4(2.0, -5.0, -7.0, 7.0));
	blockC.h[3][2][0] = (vec4(7.0, 0.0, 9.0, 9.0));
	blockC.h[3][2][1] = (vec4(-6.0, 0.0, 0.0, -8.0));
	blockC.h[3][2][2] = (vec4(-6.0, 7.0, 3.0, -7.0));
	blockC.h[3][2][3] = (vec4(-2.0, 8.0, -5.0, -8.0));
	blockC.h[3][3][0] = (vec4(2.0, 6.0, 6.0, -5.0));
	blockC.h[3][3][1] = (vec4(-3.0, 3.0, -8.0, 4.0));
	blockC.h[3][3][2] = (vec4(-1.0, 4.0, 4.0, -2.0));
	blockC.h[3][3][3] = (vec4(1.0, 3.0, -3.0, 2.0));
	blockC.h[3][4][0] = (vec4(-4.0, 8.0, -4.0, 9.0));
	blockC.h[3][4][1] = (vec4(7.0, 9.0, -7.0, 8.0));
	blockC.h[3][4][2] = (vec4(3.0, -4.0, -9.0, 6.0));
	blockC.h[3][4][3] = (vec4(5.0, -6.0, -1.0, -2.0));
	blockC.h[3][5][0] = (vec4(7.0, 1.0, -6.0, -6.0));
	blockC.h[3][5][1] = (vec4(-6.0, 1.0, -9.0, 5.0));
	blockC.h[3][5][2] = (vec4(-5.0, 5.0, -1.0, -3.0));
	blockC.h[3][5][3] = (vec4(4.0, 9.0, -6.0, -1.0));
	blockC.h[4][0][0] = (vec4(-6.0, 1.0, 9.0, -4.0));
	blockC.h[4][0][1] = (vec4(-6.0, -8.0, -7.0, -2.0));
	blockC.h[4][0][2] = (vec4(-2.0, -9.0, 8.0, 4.0));
	blockC.h[4][0][3] = (vec4(7.0, 3.0, 3.0, 6.0));
	blockC.h[4][1][0] = (vec4(-3.0, -4.0, -6.0, 5.0));
	blockC.h[4][1][1] = (vec4(-7.0, -9.0, 0.0, 3.0));
	blockC.h[4][1][2] = (vec4(0.0, 0.0, 4.0, 8.0));
	blockC.h[4][1][3] = (vec4(0.0, -8.0, -9.0, -7.0));
	blockC.h[4][2][0] = (vec4(-7.0, -2.0, -8.0, 2.0));
	blockC.h[4][2][1] = (vec4(9.0, 0.0, -2.0, 8.0));
	blockC.h[4][2][2] = (vec4(-7.0, 4.0, -9.0, 5.0));
	blockC.h[4][2][3] = (vec4(0.0, 7.0, 2.0, -3.0));
	blockC.h[4][3][0] = (vec4(-4.0, -8.0, -3.0, -3.0));
	blockC.h[4][3][1] = (vec4(8.0, -4.0, 6.0, -5.0));
	blockC.h[4][3][2] = (vec4(-6.0, 1.0, 1.0, -2.0));
	blockC.h[4][3][3] = (vec4(6.0, -6.0, 6.0, 6.0));
	blockC.h[4][4][0] = (vec4(-5.0, 0.0, -8.0, -2.0));
	blockC.h[4][4][1] = (vec4(8.0, 2.0, 6.0, -5.0));
	blockC.h[4][4][2] = (vec4(5.0, -3.0, 7.0, 8.0));
	blockC.h[4][4][3] = (vec4(2.0, 4.0, -6.0, -6.0));
	blockC.h[4][5][0] = (vec4(7.0, 9.0, 0.0, 8.0));
	blockC.h[4][5][1] = (vec4(-9.0, 6.0, -3.0, -4.0));
	blockC.h[4][5][2] = (vec4(7.0, -6.0, 7.0, -2.0));
	blockC.h[4][5][3] = (vec4(8.0, -5.0, 0.0, 3.0));
	blockC.h[5][0][0] = (vec4(-1.0, 0.0, 5.0, -1.0));
	blockC.h[5][0][1] = (vec4(7.0, -9.0, 7.0, -8.0));
	blockC.h[5][0][2] = (vec4(-8.0, -1.0, 3.0, -5.0));
	blockC.h[5][0][3] = (vec4(-1.0, 6.0, 6.0, -4.0));
	blockC.h[5][1][0] = (vec4(1.0, -6.0, 8.0, -1.0));
	blockC.h[5][1][1] = (vec4(2.0, 2.0, 6.0, -3.0));
	blockC.h[5][1][2] = (vec4(-5.0, -5.0, 1.0, 7.0));
	blockC.h[5][1][3] = (vec4(1.0, 2.0, -7.0, -2.0));
	blockC.h[5][2][0] = (vec4(0.0, -2.0, -1.0, -4.0));
	blockC.h[5][2][1] = (vec4(-5.0, 4.0, 4.0, 1.0));
	blockC.h[5][2][2] = (vec4(5.0, 5.0, 9.0, -3.0));
	blockC.h[5][2][3] = (vec4(5.0, -9.0, 2.0, -4.0));
	blockC.h[5][3][0] = (vec4(-5.0, -7.0, 5.0, 9.0));
	blockC.h[5][3][1] = (vec4(6.0, 1.0, -3.0, 8.0));
	blockC.h[5][3][2] = (vec4(0.0, -3.0, 7.0, -4.0));
	blockC.h[5][3][3] = (vec4(-5.0, -3.0, -9.0, 6.0));
	blockC.h[5][4][0] = (vec4(1.0, -7.0, -4.0, 8.0));
	blockC.h[5][4][1] = (vec4(5.0, -5.0, 3.0, 9.0));
	blockC.h[5][4][2] = (vec4(-5.0, -9.0, 8.0, -3.0));
	blockC.h[5][4][3] = (vec4(7.0, 4.0, 0.0, -1.0));
	blockC.h[5][5][0] = (vec4(-2.0, -6.0, 4.0, 7.0));
	blockC.h[5][5][1] = (vec4(5.0, -6.0, 6.0, -6.0));
	blockC.h[5][5][2] = (vec4(1.0, -3.0, -2.0, 0.0));
	blockC.h[5][5][3] = (vec4(5.0, 7.0, 8.0, 5.0));
	blockC.h[6][0][0] = (vec4(-7.0, -5.0, -1.0, -1.0));
	blockC.h[6][0][1] = (vec4(0.0, 1.0, -4.0, 8.0));
	blockC.h[6][0][2] = (vec4(3.0, 8.0, -6.0, 5.0));
	blockC.h[6][0][3] = (vec4(4.0, -5.0, -2.0, 1.0));
	blockC.h[6][1][0] = (vec4(-7.0, -8.0, -1.0, -6.0));
	blockC.h[6][1][1] = (vec4(-4.0, -4.0, -7.0, 4.0));
	blockC.h[6][1][2] = (vec4(-9.0, -9.0, 1.0, 5.0));
	blockC.h[6][1][3] = (vec4(-9.0, -8.0, -3.0, -6.0));
	blockC.h[6][2][0] = (vec4(-2.0, -7.0, 8.0, 5.0));
	blockC.h[6][2][1] = (vec4(-4.0, -2.0, -9.0, -8.0));
	blockC.h[6][2][2] = (vec4(9.0, 1.0, -1.0, -7.0));
	blockC.h[6][2][3] = (vec4(6.0, -2.0, -4.0, -9.0));
	blockC.h[6][3][0] = (vec4(-7.0, 1.0, -9.0, 6.0));
	blockC.h[6][3][1] = (vec4(3.0, -8.0, -1.0, -8.0));
	blockC.h[6][3][2] = (vec4(-3.0, 2.0, 0.0, 8.0));
	blockC.h[6][3][3] = (vec4(-7.0, 8.0, -5.0, -8.0));
	blockC.h[6][4][0] = (vec4(-9.0, -7.0, 3.0, 2.0));
	blockC.h[6][4][1] = (vec4(7.0, -7.0, 4.0, -9.0));
	blockC.h[6][4][2] = (vec4(6.0, 6.0, -4.0, 6.0));
	blockC.h[6][4][3] = (vec4(-5.0, -6.0, -3.0, 3.0));
	blockC.h[6][5][0] = (vec4(8.0, -2.0, 7.0, -2.0));
	blockC.h[6][5][1] = (vec4(-6.0, 7.0, 8.0, -2.0));
	blockC.h[6][5][2] = (vec4(7.0, -2.0, -4.0, -7.0));
	blockC.h[6][5][3] = (vec4(2.0, 2.0, -6.0, 6.0));
	i = (vec3(-3.0, 4.0, 7.0));
	j = (uvec3(9u, 0u, 3u));
	l = int8_t(4294967293);
	blockE[0].n.mA = (ivec4(3, -5, -6, -9));
	blockE[0].n.mB = (ivec2(7, -3));
	blockE[0].p = (bvec3(false, false, true));
	blockE[0].q[0] = (vec2(-3.0, -1.0));
	blockE[0].q[1] = (vec2(8.0, -8.0));
	blockE[0].q[2] = (vec2(9.0, -1.0));
	blockE[0].q[3] = (vec2(-8.0, -9.0));
	blockE[0].q[4] = (vec2(5.0, -7.0));
	blockE[0].q[5] = (vec2(-1.0, 1.0));
}
#version 450
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
	mediump vec3 a;
	highp mat4x3 b;
	highp mat2 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b, mat4x3(-4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(blockB.c[0], mat2(3.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB.c[1], mat2(-9.0, -3.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB.c[2], mat2(-7.0, -7.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(blockB.c[3], mat2(-6.0, 8.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(8.0, 7.0, -2.0));
}
#version 450
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
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp uvec3 a[];
} blockB[1];
layout(std140, binding = 2) buffer BlockC
{
	i8vec2 b;
	lowp mat4x3 c[];
} blockC;
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	i8vec2 d;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	sA e[2];
	bvec3 f;
	u8vec2 g[][4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a[0]), uvec3(5u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[1]), uvec3(1u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[2]), uvec3(3u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[3]), uvec3(9u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[4]), uvec3(9u, 1u, 8u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[5]), uvec3(4u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[6]), uvec3(8u, 1u, 4u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b), ivec2(4294967294, 4294967295)) && allOk;
	allOk = compare_mat4x3(blockC.c[0], mat4x3(-5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0, -8.0, 4.0, -8.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[1], mat4x3(4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0, 0.0, 6.0, 8.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[2], mat4x3(-3.0, 2.0, 2.0, 3.0, 3.0, -7.0, 7.0, -3.0, -3.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[3], mat4x3(0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[4], mat4x3(-1.0, -4.0, -1.0, -1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[5], mat4x3(-8.0, -2.0, -1.0, 4.0, 5.0, 7.0, -9.0, -9.0, 8.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.d), ivec2(2, 7)) && allOk;
	allOk = compare_u8vec4(uvec4(e[0].mA), uvec4(0u, 6u, 2u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(e[1].mA), uvec4(2u, 2u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec3(7u, 4u, 8u));
	blockB[0].a[1] = (uvec3(3u, 7u, 9u));
	blockB[0].a[2] = (uvec3(2u, 0u, 8u));
	blockB[0].a[3] = (uvec3(7u, 1u, 0u));
	blockB[0].a[4] = (uvec3(8u, 2u, 7u));
	blockB[0].a[5] = (uvec3(5u, 4u, 4u));
	blockB[0].a[6] = (uvec3(2u, 5u, 8u));
	blockC.b = i8vec2(ivec2(3, 4294967294));
	blockC.c[0] = (mat4x3(9.0, 0.0, 6.0, -5.0, 5.0, 5.0, -5.0, -2.0, -4.0, -4.0, -9.0, -5.0));
	blockC.c[1] = (mat4x3(4.0, -3.0, -8.0, -8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0, -2.0, -6.0));
	blockC.c[2] = (mat4x3(-9.0, 2.0, 6.0, -9.0, -4.0, 6.0, 0.0, -2.0, -5.0, -5.0, -4.0, -9.0));
	blockC.c[3] = (mat4x3(7.0, -1.0, -8.0, 9.0, 2.0, 5.0, -2.0, -5.0, 0.0, -4.0, 9.0, 0.0));
	blockC.c[4] = (mat4x3(-5.0, 8.0, -4.0, 6.0, -6.0, 2.0, 7.0, 8.0, 7.0, -6.0, -2.0, 8.0));
	blockC.c[5] = (mat4x3(6.0, -6.0, 1.0, -8.0, 1.0, -8.0, 6.0, -7.0, 0.0, 1.0, -9.0, -4.0));
	e[0].mA = u8vec4(uvec4(4u, 2u, 0u, 9u));
	e[1].mA = u8vec4(uvec4(3u, 5u, 9u, 1u));
	f = (bvec3(true, false, true));
}
#version 450
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
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec2 b;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uvec3 c;
	layout(offset = 16) highp ivec2 d;
	layout(offset = 24) u8vec4 e;
	layout(offset = 28) u8vec2 f;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump uint g;
	layout(offset = 4) int8_t h;
} blockE;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_uvec3((blockD[0].c), uvec3(4u, 9u, 3u)) && allOk;
	allOk = compare_ivec2((blockD[0].d), ivec2(-7, 8)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].e), uvec4(4u, 4u, 4u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].f), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec3((blockD[1].c), uvec3(3u, 5u, 6u)) && allOk;
	allOk = compare_ivec2((blockD[1].d), ivec2(-2, -8)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].e), uvec4(8u, 2u, 9u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].f), uvec2(6u, 4u)) && allOk;
	allOk = compare_uvec3((blockD[2].c), uvec3(4u, 8u, 3u)) && allOk;
	allOk = compare_ivec2((blockD[2].d), ivec2(9, 3)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].e), uvec4(9u, 9u, 5u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].f), uvec2(7u, 5u)) && allOk;
	allOk = compare_uint((blockE.g), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC.b = (ivec2(-3, -2));
	blockD[0].c = (uvec3(9u, 0u, 2u));
	blockD[0].d = (ivec2(1, 1));
	blockD[0].e = u8vec4(uvec4(8u, 4u, 3u, 1u));
	blockD[0].f = u8vec2(uvec2(1u, 6u));
	blockD[1].c = (uvec3(2u, 4u, 4u));
	blockD[1].d = (ivec2(-3, 4));
	blockD[1].e = u8vec4(uvec4(7u, 6u, 7u, 0u));
	blockD[1].f = u8vec2(uvec2(5u, 6u));
	blockD[2].c = (uvec3(4u, 8u, 9u));
	blockD[2].d = (ivec2(4, -2));
	blockD[2].e = u8vec4(uvec4(3u, 0u, 1u, 1u));
	blockD[2].f = u8vec2(uvec2(0u, 2u));
	blockE.g = (2u);
	blockE.h = int8_t(0);
}
#version 450
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
	layout(offset = 4) i8vec4 b;
	layout(offset = 8) i8vec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool d;
	layout(offset = 4) bvec3 e;
} blockC;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 7u) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(4294967287, 9, 4294967289, 8)) && allOk;
	allOk = compare_bool((blockC.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.c = i8vec4(ivec4(4294967290, 6, 1, 8));
	blockC.d = (true);
	blockC.e = (bvec3(false, false, false));
}
#version 450
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
	lowp mat3 a;
	mediump float b[4];
};
layout(scalar, binding = 2) buffer BlockC
{
	i8vec3 c;
	i8vec4 d;
	i8vec2 e;
	i8vec4 f[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump ivec3 g;
	lowp int h[];
} blockD;
layout(scalar, column_major, binding = 4) buffer BlockE
{
	bvec2 i;
	lowp ivec4 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(a, mat3(4.0, -7.0, 3.0, 0.0, -6.0, 5.0, 9.0, 8.0, -2.0)) && allOk;
	allOk = compare_float((b[0]), 4.0) && allOk;
	allOk = compare_float((b[1]), -9.0) && allOk;
	allOk = compare_float((b[2]), 8.0) && allOk;
	allOk = compare_float((b[3]), -7.0) && allOk;
	allOk = compare_i8vec2(ivec2(e), ivec2(4294967287, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0]), ivec4(4294967291, 5, 2, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1]), ivec4(4294967290, 7, 4294967290, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2]), ivec4(9, 4294967292, 4294967295, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3]), ivec4(3, 4294967288, 0, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(f[4]), ivec4(4294967293, 4294967288, 2, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(f[5]), ivec4(4, 7, 4294967288, 4294967294)) && allOk;
	allOk = compare_ivec3((blockD.g), ivec3(4, 1, -5)) && allOk;
	allOk = compare_int((blockD.h[0]), -6) && allOk;
	allOk = compare_int((blockD.h[1]), 8) && allOk;
	allOk = compare_int((blockD.h[2]), -2) && allOk;
	allOk = compare_int((blockD.h[3]), -5) && allOk;
	allOk = compare_int((blockD.h[4]), 6) && allOk;
	allOk = compare_int((blockD.h[5]), -7) && allOk;
	allOk = compare_int((blockD.h[6]), 3) && allOk;
	allOk = compare_ivec4((blockE.j[0]), ivec4(-6, 0, -7, -2)) && allOk;
	allOk = compare_ivec4((blockE.j[1]), ivec4(9, 6, -5, -8)) && allOk;
	allOk = compare_ivec4((blockE.j[2]), ivec4(-5, 4, -9, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3(4.0, 8.0, -8.0, -3.0, 8.0, -6.0, 4.0, -4.0, -7.0));
	b[0] = (9.0);
	b[1] = (4.0);
	b[2] = (6.0);
	b[3] = (-1.0);
	c = i8vec3(ivec3(4294967291, 0, 8));
	e = i8vec2(ivec2(6, 6));
	f[0] = i8vec4(ivec4(8, 9, 7, 7));
	f[1] = i8vec4(ivec4(4294967294, 4294967295, 9, 1));
	f[2] = i8vec4(ivec4(2, 4294967294, 3, 2));
	f[3] = i8vec4(ivec4(0, 7, 4294967294, 4294967287));
	f[4] = i8vec4(ivec4(9, 4294967287, 4294967292, 4294967288));
	f[5] = i8vec4(ivec4(0, 8, 4294967287, 4294967291));
	blockD.g = (ivec3(2, -3, 4));
	blockD.h[0] = (-2);
	blockD.h[1] = (-6);
	blockD.h[2] = (-3);
	blockD.h[3] = (-2);
	blockD.h[4] = (-6);
	blockD.h[5] = (-3);
	blockD.h[6] = (-9);
	blockE.i = (bvec2(true, false));
	blockE.j[0] = (ivec4(-6, 2, 7, -3));
	blockE.j[1] = (ivec4(-4, -2, 7, 1));
	blockE.j[2] = (ivec4(1, 4, -9, -5));
}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(1.0, 9.0, 9.0, 9.0, -4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-9.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-7.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[1][3], -8.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[2][3], -6.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_float(var[3][2], -8.0) && allOk;
	allOk = compare_float(var[3][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(2.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, -5.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(-2.0, 1.0, 8.0, 4.0, 9.0, -4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-6.0, -3.0, 6.0, -8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(2.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-5.0, 4.0, -5.0, -8.0, -6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-2.0, 4.0, -3.0, -4.0, 2.0, -8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i16vec4 var[];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[4]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[5]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[6]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[7]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[8]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[9]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[10]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[11]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[12]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[13]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[14]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[15]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[16]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[17]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[18]), ivec4(4, -6, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][3], 9.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-9.0, 3.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(2.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, -6.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-8.0, -3.0, 3.0, -7.0));
	block.var[1] = (vec4(7.0, 6.0, 3.0, -2.0));
	block.var[2] = (vec4(7.0, 7.0, -9.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-7.0, 8.0, 6.0, 0.0, 0.0, 2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-1.0, -4.0, 5.0, 9.0, -4.0, -2.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-8.0, 4.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-1.0, -9.0));
	block.var[1] = (vec2(0.0, -5.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(8.0, -4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-6.0, 6.0, 1.0, 6.0, -7.0, -8.0, -7.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[0][3], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-5.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 4.0, -1.0, -1.0));
	block.var[1] = (vec4(-4.0, -7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(1.0, -6.0, 0.0, -8.0, -3.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(1.0, 1.0, 3.0, -2.0, -4.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-8.0, 9.0));
	block.var[1] = (vec2(3.0, 2.0));
	block.var[2] = (vec2(3.0, -1.0));
	block.var[3] = (vec2(-9.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3(block.var, mat3(3.0, -1.0, -6.0, 2.0, 1.0, -4.0, 6.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec3(-8.0, -5.0, -6.0));
	block.var[1] = (vec3(3.0, -9.0, 7.0));
	block.var[2] = (vec3(-3.0, 6.0, -4.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[2][0] = (vec3(7.0, 9.0, -7.0));
	block.var[2][1] = (vec3(8.0, 2.0, 5.0));
	block.var[2][2] = (vec3(-9.0, 7.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
}
#version 450
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
	f16vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2]), vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec2(vec2(-2.0, 4.0));
	block.var[1] = f16vec2(vec2(-2.0, 4.0));
	block.var[2] = f16vec2(vec2(-1.0, 1.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
}
#version 450
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
	highp vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_vec4((block.var[0]), vec4(4.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((block.var[1]), vec4(4.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[2]), vec4(-4.0, 3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec4(8.0, 3.0, -4.0, -6.0));
	block.var[1] = (vec4(-1.0, -3.0, 6.0, 5.0));
	block.var[2] = (vec4(-9.0, 4.0, -1.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4(block.var[0], mat4(-3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0, 0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0, 4.0, 2.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	block.var[1] = (mat4(2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0));
	block.var[2] = (mat4(9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(9.0, -6.0, -8.0, -7.0, 2.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-4.0, 1.0, 5.0, 2.0, -6.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(8.0, 9.0, 2.0, -7.0, -8.0, 9.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0] = (vec2(-2.0, 8.0));
	block.var[0][1] = (vec2(-4.0, 4.0));
	block.var[0][2] = (vec2(9.0, 5.0));
	block.var[0][3] = (vec2(-9.0, -2.0));
	block.var[1][0] = (vec2(6.0, -8.0));
	block.var[1][1] = (vec2(-5.0, -1.0));
	block.var[1][2] = (vec2(9.0, 0.0));
	block.var[1][3] = (vec2(4.0, 5.0));
	block.var[2][0] = (vec2(4.0, -5.0));
	block.var[2][1] = (vec2(-2.0, -4.0));
	block.var[2][2] = (vec2(6.0, 4.0));
	block.var[2][3] = (vec2(-2.0, 5.0));
}
#version 450
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
	u8vec4 var[3];
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
	allOk = compare_u8vec4(uvec4(block.var[0]), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1]), uvec4(5u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2]), uvec4(4u, 6u, 1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(9u);
	block.var[0] = u8vec4(uvec4(5u, 9u, 4u, 6u));
	block.var[1] = u8vec4(uvec4(8u, 7u, 3u, 6u));
	block.var[2] = u8vec4(uvec4(7u, 1u, 9u, 8u));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[2][1] = (vec3(7.0, 0.0, -8.0));
	block.var[3][0] = (vec3(0.0, -5.0, 5.0));
	block.var[3][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[4][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[4][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[5][0] = (vec3(2.0, -3.0, 6.0));
	block.var[5][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[6][0] = (vec3(6.0, -2.0, 0.0));
	block.var[6][1] = (vec3(3.0, 4.0, -6.0));
	block.var[7][0] = (vec3(3.0, -6.0, 2.0));
	block.var[7][1] = (vec3(4.0, -8.0, 0.0));
	block.var[8][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[8][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[9][0] = (vec3(4.0, -9.0, -1.0));
	block.var[9][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[10][0] = (vec3(2.0, -2.0, 4.0));
	block.var[10][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[11][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[11][1] = (vec3(2.0, 0.0, 5.0));
	block.var[12][0] = (vec3(0.0, 9.0, -7.0));
	block.var[12][1] = (vec3(5.0, 6.0, -3.0));
	block.var[13][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[13][1] = (vec3(7.0, 9.0, -2.0));
	block.var[14][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[14][1] = (vec3(8.0, -6.0, 8.0));
	block.var[15][0] = (vec3(4.0, -8.0, 4.0));
	block.var[15][1] = (vec3(4.0, 5.0, 5.0));
	block.var[16][0] = (vec3(2.0, 3.0, 6.0));
	block.var[16][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[17][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[17][1] = (vec3(6.0, 2.0, 2.0));
	block.var[18][0] = (vec3(5.0, -2.0, -1.0));
	block.var[18][1] = (vec3(7.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[3] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[4] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[5] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[6] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[7] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[8] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[9] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[10] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[11] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	block.var[12] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	block.var[13] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	block.var[14] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	block.var[15] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	block.var[16] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	block.var[17] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	block.var[18] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	highp ivec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var[0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block.var[0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block.var[0][2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((block.var[1][0]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][1]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][2]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((block.var[2][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((block.var[2][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((block.var[2][2]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((block.var[3][0]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][1]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][2]), ivec3(1, -4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (ivec3(-5, 0, -9));
	block.var[0][1] = (ivec3(2, 4, 1));
	block.var[0][2] = (ivec3(6, 6, 2));
	block.var[1][0] = (ivec3(4, 4, 2));
	block.var[1][1] = (ivec3(-4, -1, -7));
	block.var[1][2] = (ivec3(8, -4, 1));
	block.var[2][0] = (ivec3(-4, -1, 5));
	block.var[2][1] = (ivec3(-4, 2, -2));
	block.var[2][2] = (ivec3(6, 7, -1));
	block.var[3][0] = (ivec3(-1, -3, -1));
	block.var[3][1] = (ivec3(-4, -1, -3));
	block.var[3][2] = (ivec3(6, -3, 8));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[1][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[1][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[1][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[2][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[2][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[2][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[3][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[3][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[3][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block.var[0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block.var[0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block.var[0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block.var[0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block.var[0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block.var[0][2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block.var[0][2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block.var[0][2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	block.var[1][0][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[1][0][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[1][0][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[1][1][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[1][1][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[1][1][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[1][2][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[1][2][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[1][2][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[2][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[2][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[2][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[2][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[2][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[2][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[2][2][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[2][2][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[2][2][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[3][0][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[3][0][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[3][0][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[3][1][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[3][1][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[3][1][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[3][2][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[3][2][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[3][2][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[0][0][2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	block.var[0][1][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	block.var[0][1][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	block.var[0][1][2] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	block.var[1][0][0] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	block.var[1][0][1] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	block.var[1][0][2] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	block.var[1][1][0] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	block.var[1][1][1] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	block.var[1][1][2] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	block.var[2][0][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	block.var[2][0][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	block.var[2][0][2] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	block.var[2][1][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	block.var[2][1][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	block.var[2][1][2] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	block.var[3][0][0] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	block.var[3][0][1] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	block.var[3][0][2] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	block.var[3][1][0] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	block.var[3][1][1] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	block.var[3][1][2] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(4.0, 1.0, -5.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(6.0, 2.0, -9.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(4.0, -5.0, 0.0, 0.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(6.0, 8.0, 9.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-6.0, -1.0, -9.0, 3.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[0][0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[0][0][2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	block.var[0][1][0] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	block.var[0][1][1] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	block.var[0][1][2] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	block.var[1][0][0] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	block.var[1][0][1] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	block.var[1][0][2] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	block.var[1][1][0] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	block.var[1][1][1] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	block.var[1][1][2] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	block.var[2][0][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	block.var[2][0][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	block.var[2][0][2] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	block.var[2][1][0] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
	block.var[2][1][1] = (mat2x3(-7.0, -4.0, 3.0, -6.0, -7.0, -9.0));
	block.var[2][1][2] = (mat2x3(-9.0, 8.0, -8.0, 7.0, 8.0, -9.0));
	block.var[3][0][0] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	block.var[3][0][1] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	block.var[3][0][2] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	block.var[3][1][0] = (mat2x3(0.0, -8.0, -9.0, 3.0, 8.0, -4.0));
	block.var[3][1][1] = (mat2x3(6.0, -9.0, -1.0, 5.0, 7.0, -4.0));
	block.var[3][1][2] = (mat2x3(0.0, -7.0, -9.0, -2.0, -6.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[0][0][2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[0][1][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	block.var[0][1][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	block.var[0][1][2] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	block.var[1][0][0] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[1][0][1] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[1][0][2] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[1][1][0] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	block.var[1][1][1] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	block.var[1][1][2] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	block.var[2][0][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[2][0][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[2][0][2] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[2][1][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	block.var[2][1][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	block.var[2][1][2] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	block.var[3][0][0] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[3][0][1] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[3][0][2] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	block.var[3][1][0] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	block.var[3][1][1] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	block.var[3][1][2] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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
	i16vec2 var[4][2][3];
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
	allOk = compare_i16vec2(ivec2(block.var[0][0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][0]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][1]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][2]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][0]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][1]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][2]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][0]), ivec2(-2, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][1]), ivec2(-6, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][2]), ivec2(8, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][2]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][0]), ivec2(0, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][1]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][2]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec2(ivec2(6, -2));
	block.var[0][0][1] = i16vec2(ivec2(-2, -8));
	block.var[0][0][2] = i16vec2(ivec2(3, 5));
	block.var[0][1][0] = i16vec2(ivec2(6, 9));
	block.var[0][1][1] = i16vec2(ivec2(0, 9));
	block.var[0][1][2] = i16vec2(ivec2(0, 5));
	block.var[1][0][0] = i16vec2(ivec2(-9, -9));
	block.var[1][0][1] = i16vec2(ivec2(-4, -3));
	block.var[1][0][2] = i16vec2(ivec2(-2, 6));
	block.var[1][1][0] = i16vec2(ivec2(9, -8));
	block.var[1][1][1] = i16vec2(ivec2(4, 6));
	block.var[1][1][2] = i16vec2(ivec2(-9, -9));
	block.var[2][0][0] = i16vec2(ivec2(0, -1));
	block.var[2][0][1] = i16vec2(ivec2(3, -9));
	block.var[2][0][2] = i16vec2(ivec2(9, -6));
	block.var[2][1][0] = i16vec2(ivec2(4, 1));
	block.var[2][1][1] = i16vec2(ivec2(-5, -1));
	block.var[2][1][2] = i16vec2(ivec2(4, -5));
	block.var[3][0][0] = i16vec2(ivec2(-1, -7));
	block.var[3][0][1] = i16vec2(ivec2(-1, -6));
	block.var[3][0][2] = i16vec2(ivec2(6, 5));
	block.var[3][1][0] = i16vec2(ivec2(-6, 1));
	block.var[3][1][1] = i16vec2(ivec2(-8, 4));
	block.var[3][1][2] = i16vec2(ivec2(-6, 1));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-7.0, -4.0, -3.0, 2.0, -3.0, 1.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(0.0, 0.0, 7.0, -4.0, -1.0, -9.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(1.0, 7.0, -3.0, 4.0, 3.0, 4.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(5.0, 3.0, -7.0, -1.0, 5.0, -5.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-4.0, 8.0, -8.0, -3.0, -9.0, 2.0, 5.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[0][0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[0][0][2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	block.var[0][1][0] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	block.var[0][1][1] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	block.var[0][1][2] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	block.var[1][0][0] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	block.var[1][0][1] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	block.var[1][0][2] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	block.var[1][1][0] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	block.var[1][1][1] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	block.var[1][1][2] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	block.var[2][0][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	block.var[2][0][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	block.var[2][0][2] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	block.var[2][1][0] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
	block.var[2][1][1] = (mat3(-7.0, 4.0, 8.0, -8.0, -8.0, -9.0, -8.0, -9.0, 0.0));
	block.var[2][1][2] = (mat3(5.0, 9.0, 0.0, -1.0, 0.0, -6.0, -7.0, -9.0, -2.0));
	block.var[3][0][0] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	block.var[3][0][1] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	block.var[3][0][2] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	block.var[3][1][0] = (mat3(7.0, 9.0, -3.0, 3.0, -7.0, 4.0, 9.0, 3.0, -8.0));
	block.var[3][1][1] = (mat3(-1.0, 2.0, 8.0, 0.0, -8.0, -5.0, 6.0, 2.0, 6.0));
	block.var[3][1][2] = (mat3(-5.0, 0.0, 1.0, 8.0, 9.0, -2.0, 3.0, 4.0, 1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-5.0, -3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(3.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-5.0, -8.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(2.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(8.0, -5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-4.0, -5.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(1.0, 3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(0.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(3.0, -5.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(4.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-4.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-4.0, 5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-3.0, 2.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(2.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-2.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-2.0, 4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-6.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(1.0, -5.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(3.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-2.0, -3.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(2.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-9.0, 0.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0][0] = (vec2(1.0, -7.0));
	block.var[0][0][0][1] = (vec2(-1.0, 5.0));
	block.var[0][0][1][0] = (vec2(-3.0, 4.0));
	block.var[0][0][1][1] = (vec2(8.0, -2.0));
	block.var[0][0][2][0] = (vec2(-6.0, -5.0));
	block.var[0][0][2][1] = (vec2(-1.0, 3.0));
	block.var[0][1][0][0] = (vec2(2.0, -9.0));
	block.var[0][1][0][1] = (vec2(3.0, 7.0));
	block.var[0][1][1][0] = (vec2(9.0, -8.0));
	block.var[0][1][1][1] = (vec2(3.0, -8.0));
	block.var[0][1][2][0] = (vec2(-9.0, 3.0));
	block.var[0][1][2][1] = (vec2(-5.0, 7.0));
	block.var[1][0][0][0] = (vec2(4.0, -8.0));
	block.var[1][0][0][1] = (vec2(6.0, 6.0));
	block.var[1][0][1][0] = (vec2(-2.0, 1.0));
	block.var[1][0][1][1] = (vec2(3.0, 2.0));
	block.var[1][0][2][0] = (vec2(1.0, 7.0));
	block.var[1][0][2][1] = (vec2(-2.0, -4.0));
	block.var[1][1][0][0] = (vec2(8.0, -8.0));
	block.var[1][1][0][1] = (vec2(4.0, -4.0));
	block.var[1][1][1][0] = (vec2(7.0, -4.0));
	block.var[1][1][1][1] = (vec2(-8.0, 1.0));
	block.var[1][1][2][0] = (vec2(0.0, 0.0));
	block.var[1][1][2][1] = (vec2(-9.0, -4.0));
	block.var[2][0][0][0] = (vec2(2.0, -1.0));
	block.var[2][0][0][1] = (vec2(-4.0, -5.0));
	block.var[2][0][1][0] = (vec2(-8.0, 3.0));
	block.var[2][0][1][1] = (vec2(-7.0, 5.0));
	block.var[2][0][2][0] = (vec2(0.0, -4.0));
	block.var[2][0][2][1] = (vec2(-9.0, 9.0));
	block.var[2][1][0][0] = (vec2(7.0, 4.0));
	block.var[2][1][0][1] = (vec2(1.0, -1.0));
	block.var[2][1][1][0] = (vec2(-7.0, -5.0));
	block.var[2][1][1][1] = (vec2(1.0, -1.0));
	block.var[2][1][2][0] = (vec2(7.0, 0.0));
	block.var[2][1][2][1] = (vec2(9.0, -6.0));
	block.var[3][0][0][0] = (vec2(1.0, 7.0));
	block.var[3][0][0][1] = (vec2(9.0, 1.0));
	block.var[3][0][1][0] = (vec2(3.0, -3.0));
	block.var[3][0][1][1] = (vec2(7.0, 1.0));
	block.var[3][0][2][0] = (vec2(5.0, 4.0));
	block.var[3][0][2][1] = (vec2(1.0, -7.0));
	block.var[3][1][0][0] = (vec2(1.0, -3.0));
	block.var[3][1][0][1] = (vec2(1.0, 2.0));
	block.var[3][1][1][0] = (vec2(-1.0, -3.0));
	block.var[3][1][1][1] = (vec2(3.0, -3.0));
	block.var[3][1][2][0] = (vec2(-6.0, 3.0));
	block.var[3][1][2][1] = (vec2(2.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(7.0, -1.0, -4.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(7.0, -4.0, -3.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-3.0, 3.0, -5.0, -3.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-4.0, 1.0, 0.0, 4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(6.0, -9.0, -3.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(2.0, -7.0, -9.0, 2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-4.0, 7.0, 3.0, -4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(9.0, -4.0, -9.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(9.0, 2.0, -2.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-4.0, 0.0, -4.0, 5.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-6.0, -9.0, 9.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(4.0, -5.0, -9.0, -9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(6.0, -2.0, 6.0, -7.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(5.0, 8.0, 3.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(9.0, -2.0, 3.0, -1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(0.0, 7.0, -1.0, 9.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(9.0, 4.0, 8.0, -2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(-5.0, 6.0, -8.0, 1.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(4.0, 1.0, -5.0, -2.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-8.0, -7.0, -8.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-4.0, 7.0, 3.0, 3.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(4.0, -7.0, -4.0, -4.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(8.0, -8.0, -9.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-4.0, 9.0, -5.0, -3.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0][0][0][0] = (vec2(-4.0, -3.0));
	block.var[0][0][0][1] = (vec2(5.0, -9.0));
	block.var[0][0][0][2] = (vec2(4.0, -2.0));
	block.var[0][0][1][0] = (vec2(-1.0, 8.0));
	block.var[0][0][1][1] = (vec2(3.0, 7.0));
	block.var[0][0][1][2] = (vec2(2.0, -4.0));
	block.var[0][0][2][0] = (vec2(4.0, 3.0));
	block.var[0][0][2][1] = (vec2(-6.0, -4.0));
	block.var[0][0][2][2] = (vec2(3.0, 4.0));
	block.var[0][1][0][0] = (vec2(6.0, 6.0));
	block.var[0][1][0][1] = (vec2(1.0, 4.0));
	block.var[0][1][0][2] = (vec2(-8.0, 2.0));
	block.var[0][1][1][0] = (vec2(-5.0, -5.0));
	block.var[0][1][1][1] = (vec2(5.0, 2.0));
	block.var[0][1][1][2] = (vec2(-1.0, -9.0));
	block.var[0][1][2][0] = (vec2(3.0, 6.0));
	block.var[0][1][2][1] = (vec2(5.0, -1.0));
	block.var[0][1][2][2] = (vec2(-8.0, 2.0));
	block.var[1][0][0][0] = (vec2(6.0, 3.0));
	block.var[1][0][0][1] = (vec2(6.0, -2.0));
	block.var[1][0][0][2] = (vec2(-9.0, -9.0));
	block.var[1][0][1][0] = (vec2(0.0, -4.0));
	block.var[1][0][1][1] = (vec2(9.0, -1.0));
	block.var[1][0][1][2] = (vec2(-1.0, -8.0));
	block.var[1][0][2][0] = (vec2(6.0, 5.0));
	block.var[1][0][2][1] = (vec2(-2.0, 1.0));
	block.var[1][0][2][2] = (vec2(4.0, 2.0));
	block.var[1][1][0][0] = (vec2(-1.0, 0.0));
	block.var[1][1][0][1] = (vec2(-2.0, -4.0));
	block.var[1][1][0][2] = (vec2(6.0, 2.0));
	block.var[1][1][1][0] = (vec2(-3.0, -2.0));
	block.var[1][1][1][1] = (vec2(1.0, -3.0));
	block.var[1][1][1][2] = (vec2(8.0, 5.0));
	block.var[1][1][2][0] = (vec2(-1.0, -4.0));
	block.var[1][1][2][1] = (vec2(-4.0, 7.0));
	block.var[1][1][2][2] = (vec2(-6.0, -2.0));
	block.var[2][0][0][0] = (vec2(-5.0, -5.0));
	block.var[2][0][0][1] = (vec2(-9.0, -7.0));
	block.var[2][0][0][2] = (vec2(3.0, -1.0));
	block.var[2][0][1][0] = (vec2(0.0, -1.0));
	block.var[2][0][1][1] = (vec2(4.0, -1.0));
	block.var[2][0][1][2] = (vec2(-6.0, -8.0));
	block.var[2][0][2][0] = (vec2(-6.0, 8.0));
	block.var[2][0][2][1] = (vec2(7.0, 4.0));
	block.var[2][0][2][2] = (vec2(-9.0, -4.0));
	block.var[2][1][0][0] = (vec2(-8.0, 0.0));
	block.var[2][1][0][1] = (vec2(-2.0, 8.0));
	block.var[2][1][0][2] = (vec2(-2.0, 3.0));
	block.var[2][1][1][0] = (vec2(7.0, -9.0));
	block.var[2][1][1][1] = (vec2(-1.0, 5.0));
	block.var[2][1][1][2] = (vec2(7.0, -5.0));
	block.var[2][1][2][0] = (vec2(7.0, 6.0));
	block.var[2][1][2][1] = (vec2(2.0, -4.0));
	block.var[2][1][2][2] = (vec2(-3.0, -5.0));
	block.var[3][0][0][0] = (vec2(-1.0, -3.0));
	block.var[3][0][0][1] = (vec2(-2.0, -5.0));
	block.var[3][0][0][2] = (vec2(-2.0, -7.0));
	block.var[3][0][1][0] = (vec2(-3.0, 5.0));
	block.var[3][0][1][1] = (vec2(4.0, 4.0));
	block.var[3][0][1][2] = (vec2(1.0, -3.0));
	block.var[3][0][2][0] = (vec2(-6.0, -4.0));
	block.var[3][0][2][1] = (vec2(-2.0, -5.0));
	block.var[3][0][2][2] = (vec2(-7.0, 2.0));
	block.var[3][1][0][0] = (vec2(2.0, -7.0));
	block.var[3][1][0][1] = (vec2(8.0, -6.0));
	block.var[3][1][0][2] = (vec2(3.0, -3.0));
	block.var[3][1][1][0] = (vec2(-4.0, -5.0));
	block.var[3][1][1][1] = (vec2(-9.0, -8.0));
	block.var[3][1][1][2] = (vec2(-7.0, 8.0));
	block.var[3][1][2][0] = (vec2(-8.0, -2.0));
	block.var[3][1][2][1] = (vec2(7.0, 5.0));
	block.var[3][1][2][2] = (vec2(-5.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[0][1][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[0][1][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[0][2][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	block.var[0][2][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	block.var[0][3][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	block.var[0][3][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	block.var[1][0][0] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[1][0][1] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[1][1][0] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[1][1][1] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[1][2][0] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	block.var[1][2][1] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	block.var[1][3][0] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	block.var[1][3][1] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	block.var[2][0][0] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[2][0][1] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[2][1][0] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[2][1][1] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	block.var[2][2][0] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	block.var[2][2][1] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	block.var[2][3][0] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	block.var[2][3][1] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[0][1][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[0][1][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[0][2][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	block.var[0][2][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	block.var[0][3][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	block.var[0][3][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	block.var[1][0][0] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[1][0][1] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[1][1][0] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[1][1][1] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[1][2][0] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	block.var[1][2][1] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	block.var[1][3][0] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	block.var[1][3][1] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	block.var[2][0][0] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[2][0][1] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[2][1][0] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[2][1][1] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	block.var[2][2][0] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	block.var[2][2][1] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	block.var[2][3][0] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	block.var[2][3][1] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
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
	block.var[0][1][0][0] = (vec3(2.0, 5.0, 2.0));
	block.var[0][1][0][1] = (vec3(2.0, 3.0, -2.0));
	block.var[0][1][0][2] = (vec3(5.0, 4.0, 6.0));
	block.var[0][1][0][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[0][1][1][0] = (vec3(1.0, 2.0, -4.0));
	block.var[0][1][1][1] = (vec3(9.0, -1.0, 6.0));
	block.var[0][1][1][2] = (vec3(9.0, -1.0, -2.0));
	block.var[0][1][1][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[0][2][0][0] = (vec3(-5.0, 3.0, -5.0));
	block.var[0][2][0][1] = (vec3(-6.0, 6.0, 3.0));
	block.var[0][2][0][2] = (vec3(-6.0, 0.0, -5.0));
	block.var[0][2][0][3] = (vec3(-9.0, 8.0, -8.0));
	block.var[0][2][1][0] = (vec3(-5.0, 2.0, -7.0));
	block.var[0][2][1][1] = (vec3(-1.0, -2.0, 7.0));
	block.var[0][2][1][2] = (vec3(4.0, -7.0, 7.0));
	block.var[0][2][1][3] = (vec3(-3.0, 7.0, 6.0));
	block.var[0][3][0][0] = (vec3(1.0, -1.0, 8.0));
	block.var[0][3][0][1] = (vec3(8.0, 3.0, -9.0));
	block.var[0][3][0][2] = (vec3(1.0, -1.0, -7.0));
	block.var[0][3][0][3] = (vec3(-1.0, -7.0, -5.0));
	block.var[0][3][1][0] = (vec3(-5.0, 1.0, 8.0));
	block.var[0][3][1][1] = (vec3(5.0, 5.0, -8.0));
	block.var[0][3][1][2] = (vec3(-8.0, 2.0, 8.0));
	block.var[0][3][1][3] = (vec3(2.0, -8.0, -6.0));
	block.var[1][0][0][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[1][0][0][1] = (vec3(9.0, 5.0, -7.0));
	block.var[1][0][0][2] = (vec3(8.0, 9.0, 0.0));
	block.var[1][0][0][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[1][0][1][0] = (vec3(7.0, -8.0, -7.0));
	block.var[1][0][1][1] = (vec3(2.0, 7.0, 5.0));
	block.var[1][0][1][2] = (vec3(5.0, -7.0, 0.0));
	block.var[1][0][1][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[1][1][0][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[1][1][0][1] = (vec3(4.0, 2.0, 0.0));
	block.var[1][1][0][2] = (vec3(1.0, -6.0, 1.0));
	block.var[1][1][0][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[1][1][1][0] = (vec3(1.0, 9.0, -4.0));
	block.var[1][1][1][1] = (vec3(1.0, -5.0, 9.0));
	block.var[1][1][1][2] = (vec3(2.0, -1.0, -1.0));
	block.var[1][1][1][3] = (vec3(5.0, 7.0, -4.0));
	block.var[1][2][0][0] = (vec3(9.0, -2.0, 2.0));
	block.var[1][2][0][1] = (vec3(-3.0, -6.0, 3.0));
	block.var[1][2][0][2] = (vec3(7.0, -7.0, -1.0));
	block.var[1][2][0][3] = (vec3(0.0, 1.0, -3.0));
	block.var[1][2][1][0] = (vec3(-6.0, 6.0, 2.0));
	block.var[1][2][1][1] = (vec3(-5.0, 0.0, 4.0));
	block.var[1][2][1][2] = (vec3(7.0, -6.0, -6.0));
	block.var[1][2][1][3] = (vec3(3.0, 8.0, 1.0));
	block.var[1][3][0][0] = (vec3(-9.0, 1.0, 5.0));
	block.var[1][3][0][1] = (vec3(4.0, 5.0, 1.0));
	block.var[1][3][0][2] = (vec3(-7.0, 4.0, -5.0));
	block.var[1][3][0][3] = (vec3(4.0, 8.0, 8.0));
	block.var[1][3][1][0] = (vec3(-4.0, -2.0, -5.0));
	block.var[1][3][1][1] = (vec3(-5.0, -9.0, 8.0));
	block.var[1][3][1][2] = (vec3(4.0, 8.0, 0.0));
	block.var[1][3][1][3] = (vec3(0.0, 9.0, 5.0));
	block.var[2][0][0][0] = (vec3(2.0, -9.0, 0.0));
	block.var[2][0][0][1] = (vec3(9.0, -2.0, -8.0));
	block.var[2][0][0][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[2][0][0][3] = (vec3(0.0, 8.0, -9.0));
	block.var[2][0][1][0] = (vec3(2.0, 1.0, -7.0));
	block.var[2][0][1][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[2][0][1][2] = (vec3(8.0, -8.0, -5.0));
	block.var[2][0][1][3] = (vec3(5.0, 1.0, -3.0));
	block.var[2][1][0][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[2][1][0][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[2][1][0][2] = (vec3(0.0, 7.0, 9.0));
	block.var[2][1][0][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[2][1][1][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[2][1][1][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[2][1][1][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[2][1][1][3] = (vec3(-5.0, -7.0, 7.0));
	block.var[2][2][0][0] = (vec3(-3.0, -1.0, 7.0));
	block.var[2][2][0][1] = (vec3(-2.0, -7.0, -9.0));
	block.var[2][2][0][2] = (vec3(-8.0, -1.0, 4.0));
	block.var[2][2][0][3] = (vec3(0.0, -2.0, -5.0));
	block.var[2][2][1][0] = (vec3(2.0, -7.0, 3.0));
	block.var[2][2][1][1] = (vec3(-2.0, 4.0, -6.0));
	block.var[2][2][1][2] = (vec3(8.0, -7.0, -9.0));
	block.var[2][2][1][3] = (vec3(-4.0, 5.0, 4.0));
	block.var[2][3][0][0] = (vec3(-3.0, 8.0, 6.0));
	block.var[2][3][0][1] = (vec3(7.0, 8.0, -7.0));
	block.var[2][3][0][2] = (vec3(-3.0, -6.0, -2.0));
	block.var[2][3][0][3] = (vec3(-6.0, 0.0, -8.0));
	block.var[2][3][1][0] = (vec3(-6.0, 0.0, 6.0));
	block.var[2][3][1][1] = (vec3(-1.0, 6.0, -7.0));
	block.var[2][3][1][2] = (vec3(7.0, 0.0, 1.0));
	block.var[2][3][1][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	int16_t var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0][0][0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0][0][1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[0][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[0][2][1]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[0][3][0]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][3][1]), -9) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][0]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][1]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][0]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][1]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[1][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][2][1]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[1][3][0]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[1][3][1]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][1]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][0]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][1]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[2][2][0]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[2][2][1]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[2][3][0]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[2][3][1]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int16_t(6);
	block.var[0][0][1] = int16_t(8);
	block.var[0][1][0] = int16_t(-5);
	block.var[0][1][1] = int16_t(-8);
	block.var[0][2][0] = int16_t(3);
	block.var[0][2][1] = int16_t(9);
	block.var[0][3][0] = int16_t(7);
	block.var[0][3][1] = int16_t(7);
	block.var[1][0][0] = int16_t(-2);
	block.var[1][0][1] = int16_t(-4);
	block.var[1][1][0] = int16_t(-3);
	block.var[1][1][1] = int16_t(2);
	block.var[1][2][0] = int16_t(6);
	block.var[1][2][1] = int16_t(2);
	block.var[1][3][0] = int16_t(1);
	block.var[1][3][1] = int16_t(-9);
	block.var[2][0][0] = int16_t(-3);
	block.var[2][0][1] = int16_t(9);
	block.var[2][1][0] = int16_t(-1);
	block.var[2][1][1] = int16_t(4);
	block.var[2][2][0] = int16_t(3);
	block.var[2][2][1] = int16_t(7);
	block.var[2][3][0] = int16_t(-3);
	block.var[2][3][1] = int16_t(0);
}
#version 450
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
	highp int var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var[0][0][0]), 6) && allOk;
	allOk = compare_int((block.var[0][0][1]), 0) && allOk;
	allOk = compare_int((block.var[0][1][0]), 8) && allOk;
	allOk = compare_int((block.var[0][1][1]), -9) && allOk;
	allOk = compare_int((block.var[0][2][0]), 5) && allOk;
	allOk = compare_int((block.var[0][2][1]), -3) && allOk;
	allOk = compare_int((block.var[0][3][0]), 3) && allOk;
	allOk = compare_int((block.var[0][3][1]), -1) && allOk;
	allOk = compare_int((block.var[1][0][0]), 9) && allOk;
	allOk = compare_int((block.var[1][0][1]), -6) && allOk;
	allOk = compare_int((block.var[1][1][0]), -1) && allOk;
	allOk = compare_int((block.var[1][1][1]), 0) && allOk;
	allOk = compare_int((block.var[1][2][0]), 4) && allOk;
	allOk = compare_int((block.var[1][2][1]), 4) && allOk;
	allOk = compare_int((block.var[1][3][0]), -9) && allOk;
	allOk = compare_int((block.var[1][3][1]), -7) && allOk;
	allOk = compare_int((block.var[2][0][0]), -9) && allOk;
	allOk = compare_int((block.var[2][0][1]), -8) && allOk;
	allOk = compare_int((block.var[2][1][0]), -9) && allOk;
	allOk = compare_int((block.var[2][1][1]), 5) && allOk;
	allOk = compare_int((block.var[2][2][0]), -9) && allOk;
	allOk = compare_int((block.var[2][2][1]), -9) && allOk;
	allOk = compare_int((block.var[2][3][0]), 9) && allOk;
	allOk = compare_int((block.var[2][3][1]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (8);
	block.var[0][0][1] = (2);
	block.var[0][1][0] = (-8);
	block.var[0][1][1] = (6);
	block.var[0][2][0] = (-4);
	block.var[0][2][1] = (9);
	block.var[0][3][0] = (-3);
	block.var[0][3][1] = (-3);
	block.var[1][0][0] = (-5);
	block.var[1][0][1] = (0);
	block.var[1][1][0] = (-6);
	block.var[1][1][1] = (6);
	block.var[1][2][0] = (-8);
	block.var[1][2][1] = (4);
	block.var[1][3][0] = (6);
	block.var[1][3][1] = (-2);
	block.var[2][0][0] = (-7);
	block.var[2][0][1] = (-7);
	block.var[2][1][0] = (-5);
	block.var[2][1][1] = (5);
	block.var[2][2][0] = (-4);
	block.var[2][2][1] = (5);
	block.var[2][3][0] = (5);
	block.var[2][3][1] = (7);
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[0][1][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[0][1][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[0][2][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	block.var[0][2][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	block.var[0][3][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	block.var[0][3][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	block.var[1][0][0] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[1][0][1] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[1][1][0] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[1][1][1] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[1][2][0] = (mat2(-2.0, -3.0, 3.0, -1.0));
	block.var[1][2][1] = (mat2(-2.0, -8.0, 1.0, -1.0));
	block.var[1][3][0] = (mat2(-6.0, -2.0, 3.0, -6.0));
	block.var[1][3][1] = (mat2(-9.0, -4.0, 0.0, -1.0));
	block.var[2][0][0] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[2][0][1] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[2][1][0] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[2][1][1] = (mat2(6.0, 0.0, 1.0, 8.0));
	block.var[2][2][0] = (mat2(9.0, -2.0, -3.0, 6.0));
	block.var[2][2][1] = (mat2(2.0, 6.0, -4.0, -6.0));
	block.var[2][3][0] = (mat2(0.0, 7.0, 4.0, 1.0));
	block.var[2][3][1] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][0][0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[0][0][1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[0][0][1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][0][1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][0][1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][1][0][0] = (vec3(9.0, 1.0, -1.0));
	block.var[0][1][0][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[0][1][0][2] = (vec3(4.0, 2.0, 0.0));
	block.var[0][1][0][3] = (vec3(5.0, 6.0, -6.0));
	block.var[0][1][1][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[0][1][1][1] = (vec3(7.0, 9.0, 8.0));
	block.var[0][1][1][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[0][1][1][3] = (vec3(6.0, -7.0, -3.0));
	block.var[0][2][0][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[0][2][0][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[0][2][0][2] = (vec3(4.0, -3.0, -8.0));
	block.var[0][2][0][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[0][2][1][0] = (vec3(6.0, -2.0, 8.0));
	block.var[0][2][1][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[0][2][1][2] = (vec3(6.0, 8.0, -5.0));
	block.var[0][2][1][3] = (vec3(1.0, -6.0, 4.0));
	block.var[0][3][0][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[0][3][0][1] = (vec3(3.0, -4.0, -1.0));
	block.var[0][3][0][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[0][3][0][3] = (vec3(-5.0, 7.0, 5.0));
	block.var[0][3][1][0] = (vec3(-1.0, -1.0, 5.0));
	block.var[0][3][1][1] = (vec3(9.0, 7.0, -5.0));
	block.var[0][3][1][2] = (vec3(3.0, -1.0, 3.0));
	block.var[0][3][1][3] = (vec3(8.0, -5.0, 3.0));
	block.var[1][0][0][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[1][0][0][1] = (vec3(9.0, 2.0, 2.0));
	block.var[1][0][0][2] = (vec3(9.0, -7.0, 3.0));
	block.var[1][0][0][3] = (vec3(8.0, 2.0, 4.0));
	block.var[1][0][1][0] = (vec3(2.0, 4.0, -3.0));
	block.var[1][0][1][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][1][2] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][1][3] = (vec3(6.0, -9.0, 0.0));
	block.var[1][1][0][0] = (vec3(7.0, -1.0, -4.0));
	block.var[1][1][0][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[1][1][0][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[1][1][0][3] = (vec3(1.0, 4.0, 5.0));
	block.var[1][1][1][0] = (vec3(9.0, 8.0, 7.0));
	block.var[1][1][1][1] = (vec3(5.0, 4.0, 7.0));
	block.var[1][1][1][2] = (vec3(3.0, -3.0, 4.0));
	block.var[1][1][1][3] = (vec3(3.0, -6.0, 5.0));
	block.var[1][2][0][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[1][2][0][1] = (vec3(0.0, -5.0, -3.0));
	block.var[1][2][0][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[1][2][0][3] = (vec3(3.0, -6.0, 8.0));
	block.var[1][2][1][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[1][2][1][1] = (vec3(5.0, -1.0, 6.0));
	block.var[1][2][1][2] = (vec3(8.0, 7.0, 1.0));
	block.var[1][2][1][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[1][3][0][0] = (vec3(-6.0, 1.0, 0.0));
	block.var[1][3][0][1] = (vec3(8.0, -8.0, 5.0));
	block.var[1][3][0][2] = (vec3(-3.0, 5.0, -4.0));
	block.var[1][3][0][3] = (vec3(-3.0, -2.0, 2.0));
	block.var[1][3][1][0] = (vec3(-5.0, 3.0, -6.0));
	block.var[1][3][1][1] = (vec3(-6.0, -4.0, -2.0));
	block.var[1][3][1][2] = (vec3(-5.0, -2.0, -2.0));
	block.var[1][3][1][3] = (vec3(-8.0, 2.0, 4.0));
	block.var[2][0][0][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[2][0][0][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[2][0][0][2] = (vec3(6.0, -3.0, -5.0));
	block.var[2][0][0][3] = (vec3(0.0, 8.0, -8.0));
	block.var[2][0][1][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[2][0][1][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[2][0][1][2] = (vec3(3.0, 3.0, 2.0));
	block.var[2][0][1][3] = (vec3(8.0, -8.0, -6.0));
	block.var[2][1][0][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[2][1][0][1] = (vec3(4.0, 8.0, -3.0));
	block.var[2][1][0][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[2][1][0][3] = (vec3(0.0, -3.0, -3.0));
	block.var[2][1][1][0] = (vec3(4.0, -2.0, -4.0));
	block.var[2][1][1][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[2][1][1][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[2][1][1][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[2][2][0][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[2][2][0][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[2][2][0][2] = (vec3(0.0, -7.0, 3.0));
	block.var[2][2][0][3] = (vec3(2.0, -7.0, 1.0));
	block.var[2][2][1][0] = (vec3(8.0, -1.0, -9.0));
	block.var[2][2][1][1] = (vec3(8.0, 8.0, 2.0));
	block.var[2][2][1][2] = (vec3(7.0, -5.0, -2.0));
	block.var[2][2][1][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[2][3][0][0] = (vec3(-1.0, -1.0, 1.0));
	block.var[2][3][0][1] = (vec3(-9.0, -7.0, -8.0));
	block.var[2][3][0][2] = (vec3(-8.0, -5.0, -1.0));
	block.var[2][3][0][3] = (vec3(2.0, 0.0, -4.0));
	block.var[2][3][1][0] = (vec3(7.0, 6.0, 4.0));
	block.var[2][3][1][1] = (vec3(-5.0, -5.0, 8.0));
	block.var[2][3][1][2] = (vec3(-3.0, 4.0, -5.0));
	block.var[2][3][1][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	i8vec4 var[][4][2];
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
	allOk = compare_i8vec4(ivec4(block.var[0][1][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][3][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][3][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][0]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][1]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][0]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][1]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2][0]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2][1]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][3][0]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][3][1]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][0]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][1]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][0]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][1]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2][0]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2][1]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][3][0]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][3][1]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[0][1][0] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[0][1][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[0][2][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[0][2][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[0][3][0] = i8vec4(ivec4(1, 0, 5, 0));
	block.var[0][3][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	block.var[1][0][0] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[1][0][1] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[1][1][0] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[1][1][1] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[1][2][0] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[1][2][1] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[1][3][0] = i8vec4(ivec4(6, 1, 0, 2));
	block.var[1][3][1] = i8vec4(ivec4(6, 1, 9, 4294967291));
	block.var[2][0][0] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[2][0][1] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[2][1][0] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[2][1][1] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[2][2][0] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[2][2][1] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[2][3][0] = i8vec4(ivec4(4294967295, 0, 3, 9));
	block.var[2][3][1] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s.a), ivec3(4, -7, 2)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, 9.0, 6.0, 2.0, 2.0, -9.0, -7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-3.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(-9.0, -3.0, 2.0, 5.0, -4.0, -1.0, 9.0, 4.0, -3.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(-3, 2, 4)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(9.0, -7.0, -5.0, -9.0, -6.0, 8.0, -6.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(-3.0, -9.0, -8.0, -8.0, 5.0, 6.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(0.0, 0.0, 4.0, -4.0, 9.0, -7.0, 0.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(5.0, 5.0, -3.0, 9.0, -1.0, -6.0, 5.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(-4.0, 6.0, 4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a = (mat3(-9.0, -6.0, -6.0, 3.0, -3.0, 8.0, 4.0, -6.0, -1.0));
	block.t.b.a = (ivec3(-8, 0, 9));
	block.t.b.b[0] = (mat3(7.0, -5.0, 9.0, -6.0, -7.0, -7.0, -2.0, 2.0, 3.0));
	block.t.b.b[1] = (mat3(-5.0, -7.0, -2.0, 8.0, -6.0, 3.0, -7.0, 3.0, -6.0));
	block.t.b.b[2] = (mat3(-7.0, -2.0, 2.0, 2.0, -7.0, 6.0, -2.0, 5.0, 8.0));
	block.t.b.b[3] = (mat3(-8.0, 8.0, 3.0, 4.0, 6.0, -6.0, 0.0, 1.0, 0.0));
	block.t.b.c = (vec4(-7.0, -5.0, 3.0, 7.0));
	block.u = (9u);
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(6.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-9.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(6.0, -9.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(8.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-6.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-4.0, 6.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-4.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-4.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(2.0, -4.0, 9.0));
	block[0].var[1] = (vec3(-4.0, 2.0, 5.0));
	block[0].var[2] = (vec3(5.0, -9.0, -5.0));
	block[1].var[0] = (vec3(3.0, 1.0, 8.0));
	block[1].var[1] = (vec3(6.0, 9.0, -8.0));
	block[1].var[2] = (vec3(-1.0, 5.0, 1.0));
	block[2].var[0] = (vec3(6.0, -5.0, -4.0));
	block[2].var[1] = (vec3(-8.0, -8.0, -2.0));
	block[2].var[2] = (vec3(9.0, -4.0, 4.0));
}
#version 450
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
	allOk = compare_mat2x4(block[0].var, mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block[0].var[1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block[1].var[0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block[1].var[1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block[2].var[0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block[2].var[1] = (vec4(1.0, 0.0, -4.0, 1.0));
}
#version 450
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
	highp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].padding), 9u) && allOk;
	allOk = compare_uvec3((block[0].var), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uint((block[1].padding), 2u) && allOk;
	allOk = compare_uvec3((block[1].var), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_uint((block[2].padding), 2u) && allOk;
	allOk = compare_uvec3((block[2].var), uvec3(6u, 8u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (3u);
	block[0].var = (uvec3(5u, 6u, 5u));
	block[1].padding = (4u);
	block[1].var = (uvec3(5u, 4u, 9u));
	block[2].padding = (4u);
	block[2].var = (uvec3(4u, 7u, 7u));
}
#version 450
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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat2(block[0].var, mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_mat2(block[1].var, mat2(-7.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_float((block[2].padding), -9.0) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-3.0, 6.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var = (mat2(2.0, 6.0, -6.0, 2.0));
	block[1].padding = (4.0);
	block[1].var = (mat2(4.0, 7.0, 0.0, 8.0));
	block[2].padding = (0.0);
	block[2].var = (mat2(-1.0, 8.0, -4.0, -5.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_mat3x4(block[0].var, mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0, -5.0, 2.0, 6.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 5.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(1.0, 3.0, -1.0, 5.0, -2.0, 2.0, 7.0, -6.0, -1.0, 2.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	block[1].padding = (-1.0);
	block[1].var = (mat3x4(-4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0, 4.0, 7.0, 4.0, -7.0));
	block[2].padding = (7.0);
	block[2].var = (mat3x4(5.0, -9.0, -3.0, 0.0, 7.0, 1.0, -4.0, 0.0, -8.0, -2.0, -9.0, 5.0));
}
#version 450
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
	i8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(block[0].var), ivec2(4294967293, 1)) && allOk;
	allOk = compare_int8_t(int(block[1].padding), 9) && allOk;
	allOk = compare_i8vec2(ivec2(block[1].var), ivec2(0, 1)) && allOk;
	allOk = compare_int8_t(int(block[2].padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(block[2].var), ivec2(4294967293, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int8_t(0);
	block[0].var = i8vec2(ivec2(8, 4294967292));
	block[1].padding = int8_t(9);
	block[1].var = i8vec2(ivec2(4294967294, 4294967295));
	block[2].padding = int8_t(8);
	block[2].var = i8vec2(ivec2(4294967290, 8));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -6.0) && allOk;
	allOk = compare_float((blockA[1].a), 2.0) && allOk;
	allOk = compare_float((blockA[2].a), 4.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 6u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-7.0, 2.0, -8.0, 3.0, 7.0, 3.0, 9.0, 6.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(2, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-7, 2)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-5, -8)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-3.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 8u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-8.0, 8.0, -5.0, -6.0, -4.0, -7.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(2, 8)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(-2.0, 4.0, 2.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-5.0, 3.0, 6.0, 3.0, 9.0, 0.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(4, -8)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(4.0, -8.0, -2.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-2.0);
	blockA[0].b.a = (mat3(-2.0, 5.0, 6.0, -1.0, -7.0, 3.0, 2.0, -9.0, -5.0));
	blockA[0].b.b[0] = (ivec2(6, -7));
	blockA[0].b.b[1] = (ivec2(7, 4));
	blockA[0].b.b[2] = (ivec2(-9, -4));
	blockA[0].b.b[3] = (ivec2(2, -4));
	blockA[0].b.c = (vec4(-6.0, -7.0, -6.0, -8.0));
	blockA[1].a = (3.0);
	blockA[1].b.a = (mat3(1.0, 8.0, -4.0, 1.0, -2.0, -2.0, 0.0, -3.0, -5.0));
	blockA[1].b.b[0] = (ivec2(-6, 4));
	blockA[1].b.b[1] = (ivec2(4, 0));
	blockA[1].b.b[2] = (ivec2(6, -4));
	blockA[1].b.b[3] = (ivec2(-1, -2));
	blockA[1].b.c = (vec4(3.0, 0.0, -5.0, -5.0));
	blockA[2].a = (1.0);
	blockA[2].b.a = (mat3(-5.0, 1.0, -5.0, 6.0, -3.0, 0.0, 6.0, -2.0, -6.0));
	blockA[2].b.b[0] = (ivec2(-5, -6));
	blockA[2].b.b[1] = (ivec2(-1, 6));
	blockA[2].b.b[2] = (ivec2(8, -7));
	blockA[2].b.b[3] = (ivec2(-9, 0));
	blockA[2].b.c = (vec4(2.0, 1.0, 9.0, -3.0));
	blockB[0].a = (mat2(3.0, 0.0, 7.0, 6.0));
	blockB[0].b.a = (6u);
	blockB[0].b.b.a = (mat3(7.0, -4.0, -5.0, -9.0, -2.0, 1.0, 3.0, -3.0, -3.0));
	blockB[0].b.b.b[0] = (ivec2(1, -4));
	blockB[0].b.b.b[1] = (ivec2(0, 5));
	blockB[0].b.b.b[2] = (ivec2(-9, 1));
	blockB[0].b.b.b[3] = (ivec2(-4, -7));
	blockB[0].b.b.c = (vec4(6.0, 7.0, 0.0, -8.0));
	blockB[0].b.c = (bvec4(false, true, true, false));
	blockB[0].d = (false);
	blockB[1].a = (mat2(4.0, 0.0, 3.0, -2.0));
	blockB[1].b.a = (2u);
	blockB[1].b.b.a = (mat3(-7.0, -1.0, 9.0, -8.0, -2.0, -8.0, -6.0, 7.0, 4.0));
	blockB[1].b.b.b[0] = (ivec2(4, 9));
	blockB[1].b.b.b[1] = (ivec2(-3, 1));
	blockB[1].b.b.b[2] = (ivec2(9, -9));
	blockB[1].b.b.b[3] = (ivec2(-4, -9));
	blockB[1].b.b.c = (vec4(-5.0, 1.0, 4.0, -6.0));
	blockB[1].b.c = (bvec4(true, true, false, true));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-9.0, 1.0, -4.0, -8.0));
	blockB[2].b.a = (4u);
	blockB[2].b.b.a = (mat3(7.0, 1.0, 5.0, 4.0, -2.0, -9.0, 2.0, -6.0, -2.0));
	blockB[2].b.b.b[0] = (ivec2(-8, 0));
	blockB[2].b.b.b[1] = (ivec2(-1, -4));
	blockB[2].b.b.b[2] = (ivec2(-9, 3));
	blockB[2].b.b.b[3] = (ivec2(7, -8));
	blockB[2].b.b.c = (vec4(-9.0, -1.0, -3.0, 5.0));
	blockB[2].b.c = (bvec4(true, true, true, true));
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

layout(std430, buffer_reference) buffer BlockB
{
	lowp int a;
	mediump mat3x2 b;
	bvec4 c;
	highp mat4 d;
	lowp vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
	allOk = compare_mat3x2(blockB.b, mat3x2(7.0, -9.0, 3.0, 0.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.d, mat4(9.0, -1.0, -9.0, -6.0, -9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.e[0]), vec3(1.0, 2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(9.0, -5.0, 5.0, -4.0, 2.0, -1.0));
	blockB.c = (bvec4(true, true, true, false));
	blockB.d = (mat4(-2.0, -8.0, -6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0));
}
#version 450
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
	lowp mat4 a;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(1.0, -3.0, 9.0, 7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0] = (mat3(0.0, 7.0, 5.0, -3.0, 1.0, 0.0, -8.0, -8.0, 5.0));
}
#version 450
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
	highp mat3x4 a;
	mediump mat3x2 b;
	mediump mat3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(-5.0, -9.0, -7.0, 9.0, -1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(-5.0, -9.0, -9.0, -7.0, 3.0, 1.0));
	blockB.c[0] = (mat3(2.0, -4.0, -6.0, 7.0, 1.0, 9.0, 1.0, 3.0, 9.0));
}
#version 450
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
	lowp mat4 mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp mat4 a;
	mediump uvec3 b;
	lowp float c;
	mediump float d;
	highp mat4x2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp uvec2 f;
	lowp mat3x2 g;
	lowp uvec3 h;
	lowp mat4 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat3 j[1];
	highp mat3x2 k;
	lowp mat4x3 l[1];
	bvec2 m[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	lowp ivec4 n;
	sA o[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(7u, 4u, 8u)) && allOk;
	allOk = compare_float((blockB.c), 4.0) && allOk;
	allOk = compare_float((blockB.d), -4.0) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(5u, 6u)) && allOk;
	allOk = compare_mat3x2(blockC.g, mat3x2(1.0, 1.0, 0.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC.h), uvec3(8u, 2u, 2u)) && allOk;
	allOk = compare_mat3(blockD.j[0], mat3(0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockD.k, mat3x2(2.0, -4.0, 4.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD.l[0], mat4x3(5.0, -7.0, -8.0, -5.0, 0.0, 1.0, -4.0, -9.0, 2.0, -4.0, -5.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockD.m[0]), bvec2(true, true)) && allOk;
	allOk = compare_ivec4((blockE.n), ivec4(8, 0, -7, -8)) && allOk;
	allOk = compare_ivec4((blockE.o[0].mA), ivec4(-7, -3, 3, 2)) && allOk;
	allOk = compare_mat4(blockE.o[0].mB, mat4(-8.0, -1.0, -7.0, 0.0, 6.0, -5.0, 4.0, -3.0, 7.0, -5.0, 1.0, 8.0, 0.0, -3.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(0u, 2u, 1u));
	blockB.c = (-2.0);
	blockB.e[0] = (mat4x2(7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0));
	blockC.f = (uvec2(6u, 5u));
	blockC.g = (mat3x2(-1.0, -4.0, 8.0, 0.0, 4.0, 7.0));
	blockC.h = (uvec3(4u, 7u, 4u));
	blockC.i[0] = (mat4(3.0, 2.0, 5.0, 0.0, -4.0, -6.0, 6.0, -7.0, -6.0, 7.0, 8.0, -6.0, 4.0, -8.0, 9.0, -3.0));
	blockD.j[0] = (mat3(8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0, 8.0));
	blockD.k = (mat3x2(-6.0, 1.0, 8.0, -5.0, 4.0, 8.0));
	blockD.l[0] = (mat4x3(5.0, -5.0, -7.0, -3.0, -6.0, 4.0, -9.0, 5.0, 1.0, -9.0, 6.0, -7.0));
	blockE.n = (ivec4(4, -3, 4, 9));
	blockE.o[0].mA = (ivec4(-8, -8, 5, -9));
	blockE.o[0].mB = (mat4(-3.0, -3.0, -3.0, -1.0, -6.0, 6.0, 4.0, -3.0, 8.0, 5.0, -7.0, -6.0, 0.0, -5.0, -7.0, 4.0));
}
#version 450
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
	highp uvec4 b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat3x2 c;
	highp mat4x2 d;
	bvec2 e[1];
	bvec2 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp float g;
	highp uvec2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC[0].c, mat3x2(4.0, 5.0, -6.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d, mat4x2(-4.0, -6.0, 8.0, -3.0, -5.0, 0.0, -4.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockC[0].e[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[0].f[6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].f[7]), bvec2(false, false)) && allOk;
	allOk = compare_uvec2((blockD.h[0]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.h[1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((blockD.h[2]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockD.h[3]), uvec2(1u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.h[4]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.h[5]), uvec2(3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat2x3(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0));
	blockB[0].b[0] = (uvec4(4u, 2u, 4u, 5u));
	blockB[0].b[1] = (uvec4(4u, 9u, 7u, 2u));
	blockB[0].b[2] = (uvec4(2u, 9u, 6u, 7u));
	blockB[0].b[3] = (uvec4(8u, 0u, 1u, 8u));
	blockB[0].b[4] = (uvec4(6u, 0u, 3u, 5u));
	blockB[1].a = (mat2x3(-4.0, -8.0, -5.0, -1.0, 2.0, 0.0));
	blockB[1].b[0] = (uvec4(8u, 6u, 4u, 8u));
	blockB[1].b[1] = (uvec4(8u, 2u, 9u, 5u));
	blockC[0].d = (mat4x2(-9.0, 1.0, 0.0, 9.0, -7.0, 2.0, 2.0, -9.0));
	blockC[0].e[0] = (bvec2(false, false));
	blockD.h[0] = (uvec2(8u, 6u));
	blockD.h[1] = (uvec2(2u, 7u));
	blockD.h[2] = (uvec2(0u, 0u));
	blockD.h[3] = (uvec2(9u, 8u));
	blockD.h[4] = (uvec2(5u, 9u));
	blockD.h[5] = (uvec2(4u, 2u));
}
#version 450
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
	mediump mat2x3 mB;
	highp vec3 mC;
	lowp mat3x4 mD;
};
struct sB
{
	sA mA;
	lowp vec2 mB[2];
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump ivec2 a;
	bvec3 b;
	mediump mat2 c;
	highp ivec2 d;
	sB e;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	mediump float f;
	bvec3 g[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3x2(blockB.e.mA.mA, mat3x2(0.0, 9.0, -1.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB.e.mA.mB, mat2x3(6.0, 1.0, -6.0, 0.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.e.mA.mC), vec3(6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.e.mA.mD, mat3x4(-7.0, -5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.e.mB[0]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.e.mB[1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_float((blockC.f), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec3(true, true, true));
	blockB.c = (mat2(-3.0, 5.0, -8.0, -2.0));
	blockB.d = (ivec2(4, 1));
	blockB.e.mA.mA = (mat3x2(-2.0, -8.0, -6.0, 9.0, 4.0, -5.0));
	blockB.e.mA.mB = (mat2x3(5.0, -1.0, 4.0, -7.0, 5.0, -6.0));
	blockB.e.mA.mC = (vec3(4.0, -3.0, 9.0));
	blockB.e.mA.mD = (mat3x4(0.0, -8.0, 6.0, -8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0));
	blockB.e.mB[0] = (vec2(-6.0, -5.0));
	blockB.e.mB[1] = (vec2(-4.0, -2.0));
}
#version 450
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
	layout(offset = 0) mediump ivec3 a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) highp uint c;
	layout(offset = 36) lowp vec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-1, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(0, -7, -2));
	blockB.b = (bvec4(false, false, true, false));
	blockB.c = (3u);
	blockB.d = (vec3(4.0, 9.0, 1.0));
}
#version 450
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
	layout(offset = 16) bvec2 b;
	layout(offset = 32) bvec4 c[1];
	layout(offset = 48) mediump ivec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-7, 5, 8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (bvec4(false, false, true, false));
	blockB.d = (ivec4(9, -5, -6, 0));
}
#version 450
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
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) mediump uvec3 c;
	layout(offset = 32) lowp vec3 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uint e;
	layout(offset = 4) bvec2 f;
	layout(offset = 12) highp uint g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].b), uvec2(8u, 0u)) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(6.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockB[1].b), uvec2(5u, 5u)) && allOk;
	allOk = compare_vec3((blockB[1].d), vec3(-1.0, 3.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockB[2].b), uvec2(7u, 1u)) && allOk;
	allOk = compare_vec3((blockB[2].d), vec3(-8.0, -6.0, -5.0)) && allOk;
	allOk = compare_uint((blockC.e), 2u) && allOk;
	allOk = compare_uint((blockC.g), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec2(-3, 7));
	blockB[0].b = (uvec2(0u, 4u));
	blockB[0].c = (uvec3(1u, 8u, 7u));
	blockB[0].d = (vec3(3.0, -1.0, 5.0));
	blockB[1].a = (ivec2(0, -4));
	blockB[1].b = (uvec2(9u, 6u));
	blockB[1].c = (uvec3(1u, 5u, 0u));
	blockB[1].d = (vec3(7.0, 3.0, 5.0));
	blockB[2].a = (ivec2(-7, 4));
	blockB[2].b = (uvec2(9u, 2u));
	blockB[2].c = (uvec3(3u, 4u, 2u));
	blockB[2].d = (vec3(1.0, 5.0, 2.0));
	blockC.e = (1u);
	blockC.f = (bvec2(true, true));
	blockC.g = (1u);
}
#version 450
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
	mediump vec4 a;
	bool b;
	mediump vec2 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp uint d;
	bvec4 e;
	mediump ivec4 f;
	mediump uvec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a), vec4(-5.0, -9.0, -7.0, 9.0)) && allOk;
	allOk = compare_bool((blockB[0].b), true) && allOk;
	allOk = compare_vec2((blockB[0].c[0]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB[1].a), vec4(-2.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_bool((blockB[1].b), false) && allOk;
	allOk = compare_vec2((blockB[1].c[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[1]), vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[2]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[3]), vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[4]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[5]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[6]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec4((blockB[2].a), vec4(7.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_bool((blockB[2].b), false) && allOk;
	allOk = compare_vec2((blockB[2].c[0]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(3, -6, -8, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (false);
	blockB[1].b = (true);
	blockB[2].b = (true);
	blockC.e = (bvec4(false, false, false, true));
	blockC.f = (ivec4(-6, -5, 0, 0));
}
#version 450
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
	highp ivec2 a;
	highp vec2 b;
	highp mat4x3 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump uvec3 d;
	bvec4 e;
	highp float f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(2, 0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[0], mat4x3(0.0, -7.0, 9.0, 2.0, -8.0, 8.0, 4.0, 1.0, 9.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[1], mat4x3(-5.0, -7.0, -7.0, 2.0, -3.0, -5.0, 8.0, 6.0, 1.0, 1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[2], mat4x3(-6.0, -8.0, -2.0, 3.0, -8.0, 4.0, 8.0, -7.0, 7.0, -4.0, -6.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(false, true, true, true)) && allOk;
	allOk = compare_float((blockC.f[0]), 3.0) && allOk;
	allOk = compare_float((blockC.f[1]), 0.0) && allOk;
	allOk = compare_float((blockC.f[2]), 8.0) && allOk;
	allOk = compare_float((blockC.f[3]), -7.0) && allOk;
	allOk = compare_float((blockC.f[4]), 5.0) && allOk;
	allOk = compare_float((blockC.f[5]), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(2, -8));
	blockB.c[0] = (mat4x3(9.0, 8.0, -9.0, 4.0, 0.0, 0.0, -3.0, 9.0, 7.0, 6.0, -4.0, -9.0));
	blockB.c[1] = (mat4x3(3.0, -1.0, -3.0, -5.0, 8.0, 8.0, -6.0, -3.0, 1.0, -8.0, -3.0, -5.0));
	blockB.c[2] = (mat4x3(4.0, -3.0, -7.0, -8.0, 1.0, -4.0, -3.0, -2.0, -5.0, 2.0, 5.0, 0.0));
	blockC.d = (uvec3(3u, 3u, 8u));
	blockC.e = (bvec4(false, false, false, true));
}
#version 450
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
	u16vec4 b[1];
	f16vec2 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump ivec2 d;
	float16_t e;
	highp mat4x3 f;
	highp mat4x3 g;
	lowp ivec3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockC.f, mat4x3(-3.0, -1.0, 4.0, 8.0, -1.0, 6.0, 5.0, -8.0, -6.0, 5.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(6u, 4u, 7u, 8u));
	blockB.c = f16vec2(vec2(-9.0, 8.0));
	blockC.d = (ivec2(0, -8));
	blockC.f = (mat4x3(5.0, 4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0, -9.0, 3.0, -9.0));
	blockC.g = (mat4x3(-1.0, 6.0, 2.0, 7.0, -1.0, -6.0, 3.0, 1.0, -4.0, -9.0, 8.0, -7.0));
	blockC.h = (ivec3(3, -9, 3));
}
#version 450
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
	highp mat4x3 mB;
	i16vec2 mC;
};
struct sB
{
	u16vec2 mA;
};
struct sC
{
	mediump float mA;
	lowp ivec3 mB;
	sB mC;
	bool mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	bvec2 a;
	highp vec3 b;
	uint16_t c;
	mediump uvec3 d;
	i16vec2 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	u16vec4 f;
	sA g;
	sC h;
	bvec4 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(8u, 8u, 5u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e), ivec2(-5, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(-4.0, 2.0, -1.0));
	blockB.c = uint16_t(4u);
	blockB.d = (uvec3(7u, 6u, 5u));
	blockB.e = i16vec2(ivec2(-2, 4));
	blockC.g.mA = u16vec3(uvec3(8u, 6u, 6u));
	blockC.g.mB = (mat4x3(5.0, 5.0, 9.0, -1.0, -6.0, 0.0, 4.0, 4.0, -8.0, -7.0, -3.0, 6.0));
	blockC.g.mC = i16vec2(ivec2(-8, -7));
	blockC.h.mA = (-2.0);
	blockC.h.mB = (ivec3(5, 1, 3));
	blockC.h.mC.mA = u16vec2(uvec2(9u, 3u));
	blockC.h.mD = (true);
	blockC.i[0] = (bvec4(false, false, false, false));
}
#version 450
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
	highp mat2 mB;
};
struct sB
{
	sA mA;
	float16_t mB[4];
	uint16_t mC;
	i16vec2 mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	uint16_t a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sB b;
	mediump mat3x2 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	f16vec2 d[8];
	f16vec2 e;
	bvec4 f;
	mediump ivec3 g;
	bvec3 h[];
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 4u) && allOk;
	allOk = compare_vec2((blockC.b.mA.mA), vec2(3.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC.b.mA.mB, mat2(2.0, 0.0, -3.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(blockC.b.mB[0]), -5.0) && allOk;
	allOk = compare_float16_t(float(blockC.b.mB[1]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockC.b.mB[2]), -7.0) && allOk;
	allOk = compare_float16_t(float(blockC.b.mB[3]), 3.0) && allOk;
	allOk = compare_uint16_t(uint(blockC.b.mC), 6u) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.b.mD), ivec2(2, 3)) && allOk;
	allOk = compare_mat3x2(blockC.c[0], mat3x2(3.0, 3.0, 5.0, -5.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockC.c[1], mat3x2(6.0, -8.0, 7.0, -3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.c[2], mat3x2(8.0, 2.0, 4.0, -4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC.c[3], mat3x2(9.0, -1.0, 6.0, -9.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockC.c[4], mat3x2(1.0, 7.0, -4.0, -5.0, 9.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.e), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockD.f), bvec4(true, true, false, false)) && allOk;
	allOk = compare_ivec3((blockD.g), ivec3(9, 2, 0)) && allOk;
	allOk = compare_bvec3((blockD.h[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.h[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.h[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.h[3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.h[4]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(8u);
	blockC.b.mA.mA = (vec2(-5.0, 3.0));
	blockC.b.mA.mB = (mat2(9.0, -5.0, -5.0, 0.0));
	blockC.b.mB[0] = float16_t(-1.0);
	blockC.b.mB[1] = float16_t(-9.0);
	blockC.b.mB[2] = float16_t(2.0);
	blockC.b.mB[3] = float16_t(-4.0);
	blockC.b.mC = uint16_t(1u);
	blockC.b.mD = i16vec2(ivec2(-4, 8));
	blockC.c[0] = (mat3x2(6.0, -3.0, -7.0, -4.0, -2.0, -9.0));
	blockC.c[1] = (mat3x2(-8.0, -5.0, 9.0, -1.0, 1.0, 7.0));
	blockC.c[2] = (mat3x2(9.0, -8.0, -6.0, 4.0, 8.0, -8.0));
	blockC.c[3] = (mat3x2(4.0, 6.0, -9.0, 5.0, 6.0, 1.0));
	blockC.c[4] = (mat3x2(3.0, 0.0, -1.0, -3.0, -8.0, -6.0));
	blockD.d[0] = f16vec2(vec2(3.0, 2.0));
	blockD.d[1] = f16vec2(vec2(7.0, 2.0));
	blockD.d[2] = f16vec2(vec2(-9.0, 1.0));
	blockD.d[3] = f16vec2(vec2(-9.0, 6.0));
	blockD.d[4] = f16vec2(vec2(2.0, -1.0));
	blockD.d[5] = f16vec2(vec2(2.0, -5.0));
	blockD.d[6] = f16vec2(vec2(-8.0, -7.0));
	blockD.d[7] = f16vec2(vec2(8.0, -9.0));
	blockD.e = f16vec2(vec2(2.0, -2.0));
	blockD.f = (bvec4(true, false, false, true));
	blockD.g = (ivec3(-7, -2, -2));
	blockD.h[0] = (bvec3(false, true, true));
	blockD.h[1] = (bvec3(true, true, true));
	blockD.h[2] = (bvec3(true, false, true));
	blockD.h[3] = (bvec3(true, false, true));
	blockD.h[4] = (bvec3(false, false, false));
}
#version 450
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
	mediump float a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	u16vec2 b;
	mediump vec2 c;
	highp vec2 d;
	f16vec2 e;
	lowp mat4x2 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp mat4x3 g;
	mediump uvec3 h;
	mediump int i;
	bvec3 j[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump ivec4 k[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a[0]), 4.0) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.b), uvec2(0u, 3u)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(6.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[0], mat4x2(-9.0, 6.0, 8.0, -9.0, -6.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD.g, mat4x3(-7.0, -1.0, -1.0, -2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0)) && allOk;
	allOk = compare_int((blockD.i), -5) && allOk;
	allOk = compare_bvec3((blockD.j[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec4((blockE.k[0]), ivec4(-5, -3, -4, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (5.0);
	blockC.b = u16vec2(uvec2(9u, 2u));
	blockC.d = (vec2(-2.0, -1.0));
	blockC.f[0] = (mat4x2(-9.0, -2.0, -4.0, -4.0, 3.0, 4.0, 9.0, 1.0));
	blockD.g = (mat4x3(2.0, -6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0));
	blockE.k[0] = (ivec4(-5, 9, -3, 8));
}
#version 450
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
	mediump uvec2 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint b[];
};
layout(std430, buffer_reference) buffer BlockD
{
	f16vec2 c;
	int16_t d;
	u16vec3 e[3][3];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump vec3 f;
	int16_t g;
	highp mat4x2 h;
	mediump float i;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.b[0]), 3u) && allOk;
	allOk = compare_uint((blockC.b[1]), 0u) && allOk;
	allOk = compare_uint((blockC.b[2]), 5u) && allOk;
	allOk = compare_uint((blockC.b[3]), 9u) && allOk;
	allOk = compare_uint((blockC.b[4]), 0u) && allOk;
	allOk = compare_uint((blockC.b[5]), 9u) && allOk;
	allOk = compare_uint((blockC.b[6]), 9u) && allOk;
	allOk = compare_uint((blockC.b[7]), 1u) && allOk;
	allOk = compare_f16vec2(vec2(blockD.c), vec2(5.0, 2.0)) && allOk;
	allOk = compare_int16_t(int(blockD.d), -4) && allOk;
	allOk = compare_vec3((blockE.f), vec3(8.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockE.h, mat4x2(2.0, -7.0, 2.0, 7.0, 3.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_float((blockE.i), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec2(7u, 4u));
	blockB[0].a[1] = (uvec2(8u, 3u));
	blockB[0].a[2] = (uvec2(7u, 9u));
	blockC.b[0] = (2u);
	blockC.b[1] = (0u);
	blockC.b[2] = (8u);
	blockC.b[3] = (7u);
	blockC.b[4] = (1u);
	blockC.b[5] = (0u);
	blockC.b[6] = (8u);
	blockC.b[7] = (2u);
	blockD.e[0][0] = u16vec3(uvec3(4u, 2u, 5u));
	blockD.e[0][1] = u16vec3(uvec3(8u, 6u, 1u));
	blockD.e[0][2] = u16vec3(uvec3(4u, 5u, 8u));
	blockD.e[1][0] = u16vec3(uvec3(2u, 6u, 0u));
	blockD.e[1][1] = u16vec3(uvec3(5u, 2u, 9u));
	blockD.e[1][2] = u16vec3(uvec3(4u, 5u, 1u));
	blockD.e[2][0] = u16vec3(uvec3(4u, 8u, 8u));
	blockD.e[2][1] = u16vec3(uvec3(3u, 6u, 1u));
	blockD.e[2][2] = u16vec3(uvec3(4u, 8u, 0u));
	blockE.g = int16_t(-9);
	blockE.i = (-5.0);
}
#version 450
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
	bool mB;
	lowp float mC;
	bvec4 mD;
};
struct sB
{
	int16_t mA;
	mediump mat3x2 mB;
	sA mC;
	u16vec3 mD;
};
struct sC
{
	lowp uvec3 mA;
	uint16_t mB[6];
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp uvec3 a;
	mediump vec3 b;
	mediump mat4x3 c;
	f16vec4 d;
	lowp ivec3 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat4x2 f;
	sB g[][7];
};
layout(std430, buffer_reference) buffer BlockD
{
	sC h;
	bool i[7];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp vec4 j[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.d), vec4(-6.0, 5.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-8.0, 1.0, 6.0, -5.0, 3.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_int16_t(int(blockC.g[0][0].mA), -1) && allOk;
	allOk = compare_mat3x2(blockC.g[0][0].mB, mat3x2(-3.0, 3.0, 2.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][0].mC.mA), uvec3(1u, 2u, 8u)) && allOk;
	allOk = compare_bool((blockC.g[0][0].mC.mB), false) && allOk;
	allOk = compare_float((blockC.g[0][0].mC.mC), 2.0) && allOk;
	allOk = compare_bvec4((blockC.g[0][0].mC.mD), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][0].mD), uvec3(0u, 8u, 1u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[0][1].mA), 6) && allOk;
	allOk = compare_mat3x2(blockC.g[0][1].mB, mat3x2(-5.0, 3.0, 0.0, -6.0, 2.0, -8.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][1].mC.mA), uvec3(8u, 6u, 4u)) && allOk;
	allOk = compare_bool((blockC.g[0][1].mC.mB), false) && allOk;
	allOk = compare_float((blockC.g[0][1].mC.mC), -3.0) && allOk;
	allOk = compare_bvec4((blockC.g[0][1].mC.mD), bvec4(true, false, true, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][1].mD), uvec3(6u, 5u, 4u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[0][2].mA), 4) && allOk;
	allOk = compare_mat3x2(blockC.g[0][2].mB, mat3x2(0.0, -1.0, 8.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][2].mC.mA), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_bool((blockC.g[0][2].mC.mB), false) && allOk;
	allOk = compare_float((blockC.g[0][2].mC.mC), 8.0) && allOk;
	allOk = compare_bvec4((blockC.g[0][2].mC.mD), bvec4(true, true, false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][2].mD), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[0][3].mA), 1) && allOk;
	allOk = compare_mat3x2(blockC.g[0][3].mB, mat3x2(4.0, -2.0, 0.0, 2.0, 8.0, 5.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][3].mC.mA), uvec3(2u, 5u, 2u)) && allOk;
	allOk = compare_bool((blockC.g[0][3].mC.mB), true) && allOk;
	allOk = compare_float((blockC.g[0][3].mC.mC), 8.0) && allOk;
	allOk = compare_bvec4((blockC.g[0][3].mC.mD), bvec4(true, false, true, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][3].mD), uvec3(6u, 8u, 8u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[0][4].mA), 5) && allOk;
	allOk = compare_mat3x2(blockC.g[0][4].mB, mat3x2(-6.0, -1.0, -7.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][4].mC.mA), uvec3(3u, 1u, 5u)) && allOk;
	allOk = compare_bool((blockC.g[0][4].mC.mB), false) && allOk;
	allOk = compare_float((blockC.g[0][4].mC.mC), -3.0) && allOk;
	allOk = compare_bvec4((blockC.g[0][4].mC.mD), bvec4(true, true, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][4].mD), uvec3(1u, 4u, 1u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[0][5].mA), 4) && allOk;
	allOk = compare_mat3x2(blockC.g[0][5].mB, mat3x2(-6.0, 8.0, 1.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][5].mC.mA), uvec3(7u, 0u, 2u)) && allOk;
	allOk = compare_bool((blockC.g[0][5].mC.mB), true) && allOk;
	allOk = compare_float((blockC.g[0][5].mC.mC), 5.0) && allOk;
	allOk = compare_bvec4((blockC.g[0][5].mC.mD), bvec4(false, false, false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][5].mD), uvec3(3u, 7u, 8u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[0][6].mA), -7) && allOk;
	allOk = compare_mat3x2(blockC.g[0][6].mB, mat3x2(-4.0, 3.0, 1.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][6].mC.mA), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_bool((blockC.g[0][6].mC.mB), true) && allOk;
	allOk = compare_float((blockC.g[0][6].mC.mC), -3.0) && allOk;
	allOk = compare_bvec4((blockC.g[0][6].mC.mD), bvec4(true, true, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[0][6].mD), uvec3(8u, 9u, 2u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[1][0].mA), -5) && allOk;
	allOk = compare_mat3x2(blockC.g[1][0].mB, mat3x2(2.0, -3.0, 4.0, 9.0, -4.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][0].mC.mA), uvec3(6u, 7u, 3u)) && allOk;
	allOk = compare_bool((blockC.g[1][0].mC.mB), true) && allOk;
	allOk = compare_float((blockC.g[1][0].mC.mC), -1.0) && allOk;
	allOk = compare_bvec4((blockC.g[1][0].mC.mD), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][0].mD), uvec3(1u, 7u, 4u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[1][1].mA), -7) && allOk;
	allOk = compare_mat3x2(blockC.g[1][1].mB, mat3x2(6.0, 2.0, -6.0, 7.0, -7.0, -2.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][1].mC.mA), uvec3(1u, 9u, 1u)) && allOk;
	allOk = compare_bool((blockC.g[1][1].mC.mB), false) && allOk;
	allOk = compare_float((blockC.g[1][1].mC.mC), -9.0) && allOk;
	allOk = compare_bvec4((blockC.g[1][1].mC.mD), bvec4(true, false, false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][1].mD), uvec3(7u, 8u, 2u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[1][2].mA), 5) && allOk;
	allOk = compare_mat3x2(blockC.g[1][2].mB, mat3x2(9.0, 9.0, 8.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][2].mC.mA), uvec3(7u, 6u, 1u)) && allOk;
	allOk = compare_bool((blockC.g[1][2].mC.mB), true) && allOk;
	allOk = compare_float((blockC.g[1][2].mC.mC), -4.0) && allOk;
	allOk = compare_bvec4((blockC.g[1][2].mC.mD), bvec4(false, false, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][2].mD), uvec3(5u, 9u, 9u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[1][3].mA), -5) && allOk;
	allOk = compare_mat3x2(blockC.g[1][3].mB, mat3x2(7.0, -9.0, -5.0, 1.0, 5.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][3].mC.mA), uvec3(7u, 0u, 2u)) && allOk;
	allOk = compare_bool((blockC.g[1][3].mC.mB), false) && allOk;
	allOk = compare_float((blockC.g[1][3].mC.mC), -9.0) && allOk;
	allOk = compare_bvec4((blockC.g[1][3].mC.mD), bvec4(true, true, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][3].mD), uvec3(7u, 1u, 3u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[1][4].mA), 5) && allOk;
	allOk = compare_mat3x2(blockC.g[1][4].mB, mat3x2(-4.0, -8.0, -7.0, -2.0, -7.0, 0.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][4].mC.mA), uvec3(0u, 5u, 5u)) && allOk;
	allOk = compare_bool((blockC.g[1][4].mC.mB), false) && allOk;
	allOk = compare_float((blockC.g[1][4].mC.mC), -4.0) && allOk;
	allOk = compare_bvec4((blockC.g[1][4].mC.mD), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][4].mD), uvec3(2u, 9u, 5u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[1][5].mA), 6) && allOk;
	allOk = compare_mat3x2(blockC.g[1][5].mB, mat3x2(2.0, 7.0, 8.0, -5.0, 5.0, -2.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][5].mC.mA), uvec3(4u, 0u, 7u)) && allOk;
	allOk = compare_bool((blockC.g[1][5].mC.mB), true) && allOk;
	allOk = compare_float((blockC.g[1][5].mC.mC), 9.0) && allOk;
	allOk = compare_bvec4((blockC.g[1][5].mC.mD), bvec4(false, false, true, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][5].mD), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_int16_t(int(blockC.g[1][6].mA), -1) && allOk;
	allOk = compare_mat3x2(blockC.g[1][6].mB, mat3x2(0.0, 6.0, -3.0, -9.0, -9.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][6].mC.mA), uvec3(7u, 2u, 0u)) && allOk;
	allOk = compare_bool((blockC.g[1][6].mC.mB), true) && allOk;
	allOk = compare_float((blockC.g[1][6].mC.mC), 5.0) && allOk;
	allOk = compare_bvec4((blockC.g[1][6].mC.mD), bvec4(true, false, true, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g[1][6].mD), uvec3(1u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockD.h.mA), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_uint16_t(uint(blockD.h.mB[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockD.h.mB[1]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockD.h.mB[2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockD.h.mB[3]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockD.h.mB[4]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockD.h.mB[5]), 3u) && allOk;
	allOk = compare_bool((blockD.i[0]), true) && allOk;
	allOk = compare_bool((blockD.i[1]), false) && allOk;
	allOk = compare_bool((blockD.i[2]), true) && allOk;
	allOk = compare_bool((blockD.i[3]), true) && allOk;
	allOk = compare_bool((blockD.i[4]), false) && allOk;
	allOk = compare_bool((blockD.i[5]), true) && allOk;
	allOk = compare_bool((blockD.i[6]), false) && allOk;
	allOk = compare_vec4((blockE.j[0]), vec4(9.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec4((blockE.j[1]), vec4(3.0, 6.0, -3.0, -7.0)) && allOk;
	allOk = compare_vec4((blockE.j[2]), vec4(7.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec4((blockE.j[3]), vec4(-3.0, -5.0, -1.0, -4.0)) && allOk;
	allOk = compare_vec4((blockE.j[4]), vec4(5.0, -2.0, -8.0, -9.0)) && allOk;
	allOk = compare_vec4((blockE.j[5]), vec4(3.0, -6.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec4((blockE.j[6]), vec4(-5.0, -3.0, -4.0, 3.0)) && allOk;
	allOk = compare_vec4((blockE.j[7]), vec4(7.0, 7.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(3u, 2u, 9u));
	blockB.b = (vec3(-7.0, -8.0, 8.0));
	blockB.c = (mat4x3(4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0, 9.0, 3.0));
	blockB.e[0] = (ivec3(-6, 9, 3));
	blockB.e[1] = (ivec3(7, 7, -8));
	blockB.e[2] = (ivec3(5, -2, -7));
	blockB.e[3] = (ivec3(-2, 5, 0));
	blockB.e[4] = (ivec3(-1, 5, 4));
	blockB.e[5] = (ivec3(-9, -1, -1));
	blockC.g[0][0].mA = int16_t(5);
	blockC.g[0][0].mB = (mat3x2(5.0, -1.0, -1.0, -1.0, 2.0, -8.0));
	blockC.g[0][0].mC.mA = u16vec3(uvec3(3u, 0u, 3u));
	blockC.g[0][0].mC.mB = (true);
	blockC.g[0][0].mC.mC = (4.0);
	blockC.g[0][0].mC.mD = (bvec4(true, true, true, true));
	blockC.g[0][0].mD = u16vec3(uvec3(2u, 7u, 1u));
	blockC.g[0][1].mA = int16_t(-8);
	blockC.g[0][1].mB = (mat3x2(5.0, 3.0, 2.0, 4.0, -9.0, 9.0));
	blockC.g[0][1].mC.mA = u16vec3(uvec3(6u, 1u, 7u));
	blockC.g[0][1].mC.mB = (false);
	blockC.g[0][1].mC.mC = (8.0);
	blockC.g[0][1].mC.mD = (bvec4(false, false, true, false));
	blockC.g[0][1].mD = u16vec3(uvec3(7u, 0u, 4u));
	blockC.g[0][2].mA = int16_t(6);
	blockC.g[0][2].mB = (mat3x2(9.0, 4.0, -7.0, 4.0, -5.0, 4.0));
	blockC.g[0][2].mC.mA = u16vec3(uvec3(5u, 1u, 4u));
	blockC.g[0][2].mC.mB = (true);
	blockC.g[0][2].mC.mC = (8.0);
	blockC.g[0][2].mC.mD = (bvec4(false, false, true, false));
	blockC.g[0][2].mD = u16vec3(uvec3(8u, 5u, 1u));
	blockC.g[0][3].mA = int16_t(7);
	blockC.g[0][3].mB = (mat3x2(-3.0, -3.0, 8.0, 9.0, -5.0, -2.0));
	blockC.g[0][3].mC.mA = u16vec3(uvec3(1u, 1u, 4u));
	blockC.g[0][3].mC.mB = (true);
	blockC.g[0][3].mC.mC = (-4.0);
	blockC.g[0][3].mC.mD = (bvec4(false, true, false, true));
	blockC.g[0][3].mD = u16vec3(uvec3(7u, 8u, 6u));
	blockC.g[0][4].mA = int16_t(2);
	blockC.g[0][4].mB = (mat3x2(4.0, -3.0, 4.0, -8.0, -7.0, -9.0));
	blockC.g[0][4].mC.mA = u16vec3(uvec3(9u, 2u, 0u));
	blockC.g[0][4].mC.mB = (true);
	blockC.g[0][4].mC.mC = (-4.0);
	blockC.g[0][4].mC.mD = (bvec4(true, false, true, true));
	blockC.g[0][4].mD = u16vec3(uvec3(2u, 0u, 1u));
	blockC.g[0][5].mA = int16_t(-9);
	blockC.g[0][5].mB = (mat3x2(6.0, 1.0, 3.0, 9.0, -1.0, -3.0));
	blockC.g[0][5].mC.mA = u16vec3(uvec3(9u, 1u, 5u));
	blockC.g[0][5].mC.mB = (true);
	blockC.g[0][5].mC.mC = (-4.0);
	blockC.g[0][5].mC.mD = (bvec4(false, false, true, true));
	blockC.g[0][5].mD = u16vec3(uvec3(1u, 5u, 8u));
	blockC.g[0][6].mA = int16_t(-5);
	blockC.g[0][6].mB = (mat3x2(-2.0, 8.0, -8.0, -2.0, 7.0, -5.0));
	blockC.g[0][6].mC.mA = u16vec3(uvec3(5u, 3u, 9u));
	blockC.g[0][6].mC.mB = (true);
	blockC.g[0][6].mC.mC = (6.0);
	blockC.g[0][6].mC.mD = (bvec4(true, false, true, true));
	blockC.g[0][6].mD = u16vec3(uvec3(7u, 1u, 0u));
	blockC.g[1][0].mA = int16_t(8);
	blockC.g[1][0].mB = (mat3x2(-1.0, -2.0, -8.0, 1.0, -7.0, -3.0));
	blockC.g[1][0].mC.mA = u16vec3(uvec3(0u, 9u, 9u));
	blockC.g[1][0].mC.mB = (false);
	blockC.g[1][0].mC.mC = (7.0);
	blockC.g[1][0].mC.mD = (bvec4(false, false, false, true));
	blockC.g[1][0].mD = u16vec3(uvec3(3u, 5u, 0u));
	blockC.g[1][1].mA = int16_t(6);
	blockC.g[1][1].mB = (mat3x2(1.0, 6.0, -8.0, -6.0, -8.0, -6.0));
	blockC.g[1][1].mC.mA = u16vec3(uvec3(1u, 9u, 8u));
	blockC.g[1][1].mC.mB = (true);
	blockC.g[1][1].mC.mC = (0.0);
	blockC.g[1][1].mC.mD = (bvec4(false, true, true, true));
	blockC.g[1][1].mD = u16vec3(uvec3(0u, 1u, 0u));
	blockC.g[1][2].mA = int16_t(8);
	blockC.g[1][2].mB = (mat3x2(3.0, -6.0, 9.0, -9.0, -4.0, -9.0));
	blockC.g[1][2].mC.mA = u16vec3(uvec3(7u, 1u, 6u));
	blockC.g[1][2].mC.mB = (true);
	blockC.g[1][2].mC.mC = (-7.0);
	blockC.g[1][2].mC.mD = (bvec4(false, true, true, false));
	blockC.g[1][2].mD = u16vec3(uvec3(3u, 6u, 8u));
	blockC.g[1][3].mA = int16_t(4);
	blockC.g[1][3].mB = (mat3x2(7.0, 5.0, 4.0, -4.0, 2.0, -1.0));
	blockC.g[1][3].mC.mA = u16vec3(uvec3(4u, 6u, 9u));
	blockC.g[1][3].mC.mB = (true);
	blockC.g[1][3].mC.mC = (-5.0);
	blockC.g[1][3].mC.mD = (bvec4(true, false, false, true));
	blockC.g[1][3].mD = u16vec3(uvec3(8u, 0u, 0u));
	blockC.g[1][4].mA = int16_t(8);
	blockC.g[1][4].mB = (mat3x2(-2.0, -9.0, -3.0, -2.0, 0.0, 6.0));
	blockC.g[1][4].mC.mA = u16vec3(uvec3(5u, 6u, 1u));
	blockC.g[1][4].mC.mB = (false);
	blockC.g[1][4].mC.mC = (9.0);
	blockC.g[1][4].mC.mD = (bvec4(true, false, true, false));
	blockC.g[1][4].mD = u16vec3(uvec3(8u, 9u, 8u));
	blockC.g[1][5].mA = int16_t(-5);
	blockC.g[1][5].mB = (mat3x2(9.0, 6.0, -9.0, -8.0, -4.0, -2.0));
	blockC.g[1][5].mC.mA = u16vec3(uvec3(0u, 4u, 7u));
	blockC.g[1][5].mC.mB = (false);
	blockC.g[1][5].mC.mC = (2.0);
	blockC.g[1][5].mC.mD = (bvec4(false, true, false, false));
	blockC.g[1][5].mD = u16vec3(uvec3(0u, 9u, 4u));
	blockC.g[1][6].mA = int16_t(-3);
	blockC.g[1][6].mB = (mat3x2(3.0, 5.0, -5.0, -2.0, 4.0, 5.0));
	blockC.g[1][6].mC.mA = u16vec3(uvec3(2u, 8u, 8u));
	blockC.g[1][6].mC.mB = (false);
	blockC.g[1][6].mC.mC = (0.0);
	blockC.g[1][6].mC.mD = (bvec4(true, false, false, false));
	blockC.g[1][6].mD = u16vec3(uvec3(1u, 9u, 0u));
	blockD.h.mA = (uvec3(6u, 9u, 9u));
	blockD.h.mB[0] = uint16_t(4u);
	blockD.h.mB[1] = uint16_t(9u);
	blockD.h.mB[2] = uint16_t(1u);
	blockD.h.mB[3] = uint16_t(8u);
	blockD.h.mB[4] = uint16_t(6u);
	blockD.h.mB[5] = uint16_t(1u);
	blockD.i[0] = (false);
	blockD.i[1] = (false);
	blockD.i[2] = (true);
	blockD.i[3] = (true);
	blockD.i[4] = (true);
	blockD.i[5] = (false);
	blockD.i[6] = (true);
	blockE.j[0] = (vec4(2.0, 4.0, -6.0, 4.0));
	blockE.j[1] = (vec4(-8.0, -6.0, -6.0, -8.0));
	blockE.j[2] = (vec4(-3.0, -3.0, 7.0, -4.0));
	blockE.j[3] = (vec4(-8.0, -2.0, -7.0, -7.0));
	blockE.j[4] = (vec4(-3.0, 4.0, -6.0, 9.0));
	blockE.j[5] = (vec4(1.0, -6.0, -1.0, 3.0));
	blockE.j[6] = (vec4(-5.0, -3.0, 3.0, 1.0));
	blockE.j[7] = (vec4(9.0, 3.0, -2.0, 8.0));
}
#version 450
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
	lowp mat3x2 a;
	mediump mat4x2 b;
	lowp uint c;
	lowp vec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a, mat3x2(3.0, -9.0, -9.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_uint((blockB[0].c), 6u) && allOk;
	allOk = compare_vec3((blockB[0].d[0]), vec3(-6.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB[0].d[1]), vec3(3.0, 4.0, -8.0)) && allOk;
	allOk = compare_vec3((blockB[0].d[2]), vec3(8.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB[0].d[3]), vec3(-7.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x2(-1.0, -9.0, -2.0, -6.0, 8.0, 0.0));
	blockB[0].c = (6u);
	blockB[0].d[0] = (vec3(-5.0, 1.0, -3.0));
	blockB[0].d[1] = (vec3(9.0, 1.0, 8.0));
	blockB[0].d[2] = (vec3(-1.0, -7.0, 2.0));
	blockB[0].d[3] = (vec3(2.0, -2.0, 9.0));
}
#version 450
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
	layout(offset = 0) int16_t a;
	layout(offset = 4) bvec3 b;
	layout(offset = 16) mediump ivec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) uint16_t d;
	layout(offset = 4) bvec2 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec3 f;
	layout(offset = 8) highp vec2 g;
	layout(offset = 16) i16vec2 h;
	layout(offset = 20) u16vec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), 4) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(1, 9)) && allOk;
	allOk = compare_uint16_t(uint(blockC.d), 8u) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[0].f), uvec3(6u, 7u, 3u)) && allOk;
	allOk = compare_vec2((blockD[0].g), vec2(-1.0, 6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].h), ivec2(-5, 5)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[1].f), uvec3(3u, 0u, 6u)) && allOk;
	allOk = compare_vec2((blockD[1].g), vec2(6.0, -7.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[1].h), ivec2(5, -9)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[2].f), uvec3(3u, 9u, 7u)) && allOk;
	allOk = compare_vec2((blockD[2].g), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[2].h), ivec2(9, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(-5);
	blockB.c = (ivec2(8, 4));
	blockC.d = uint16_t(0u);
	blockC.e = (bvec2(true, true));
	blockD[0].f = u16vec3(uvec3(9u, 5u, 8u));
	blockD[0].g = (vec2(0.0, 9.0));
	blockD[0].h = i16vec2(ivec2(3, 1));
	blockD[0].i = u16vec4(uvec4(3u, 8u, 2u, 9u));
	blockD[1].f = u16vec3(uvec3(0u, 6u, 2u));
	blockD[1].g = (vec2(7.0, -8.0));
	blockD[1].h = i16vec2(ivec2(5, -2));
	blockD[1].i = u16vec4(uvec4(0u, 1u, 7u, 0u));
	blockD[2].f = u16vec3(uvec3(9u, 7u, 5u));
	blockD[2].g = (vec2(-9.0, -1.0));
	blockD[2].h = i16vec2(ivec2(-1, 7));
	blockD[2].i = u16vec4(uvec4(4u, 1u, 9u, 4u));
}
#version 450
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
	bvec2 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp vec4 b[6];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp mat4x2 c;
	highp ivec4 d[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	bvec3 e;
	float16_t f[1];
	highp uvec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.a[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.a[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.a[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.a[4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.a[5]), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockC.b[0]), vec4(-8.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.b[1]), vec4(4.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.b[2]), vec4(-1.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC.b[3]), vec4(3.0, -5.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.b[4]), vec4(1.0, 0.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.b[5]), vec4(3.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockE[0].g[0]), uvec4(5u, 6u, 4u, 6u)) && allOk;
	allOk = compare_uvec4((blockE[0].g[1]), uvec4(9u, 5u, 7u, 3u)) && allOk;
	allOk = compare_uvec4((blockE[0].g[2]), uvec4(4u, 5u, 5u, 6u)) && allOk;
	allOk = compare_uvec4((blockE[0].g[3]), uvec4(1u, 2u, 4u, 5u)) && allOk;
	allOk = compare_uvec4((blockE[0].g[4]), uvec4(6u, 0u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((blockE[0].g[5]), uvec4(5u, 3u, 0u, 3u)) && allOk;
	allOk = compare_uvec4((blockE[0].g[6]), uvec4(9u, 3u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec2(true, true));
	blockB.a[1] = (bvec2(false, false));
	blockB.a[2] = (bvec2(true, false));
	blockB.a[3] = (bvec2(true, true));
	blockB.a[4] = (bvec2(false, true));
	blockB.a[5] = (bvec2(true, false));
	blockC.b[0] = (vec4(-2.0, -2.0, 7.0, -2.0));
	blockC.b[1] = (vec4(1.0, 3.0, -9.0, -2.0));
	blockC.b[2] = (vec4(-7.0, 9.0, -9.0, 4.0));
	blockC.b[3] = (vec4(-1.0, 8.0, 4.0, -4.0));
	blockC.b[4] = (vec4(0.0, 7.0, 6.0, 5.0));
	blockC.b[5] = (vec4(3.0, 3.0, -4.0, -6.0));
	blockD.c = (mat4x2(4.0, 2.0, -6.0, 7.0, -8.0, 5.0, 6.0, 8.0));
	blockE[0].e = (bvec3(true, false, true));
	blockE[0].f[0] = float16_t(4.0);
}
#version 450
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
	mediump mat4 mA;
};
struct sB
{
	lowp mat4 mA;
	mediump mat2 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec3 a[8];
	i16vec3 b;
	sA c;
	sB d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp uvec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(6, 6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec3(ivec3(-5, -6, 6));
	blockB.c.mA = (mat4(-7.0, 0.0, -9.0, -1.0, -1.0, 4.0, -2.0, -5.0, 5.0, 3.0, 0.0, 9.0, -5.0, -3.0, 3.0, -7.0));
	blockB.d[0].mA = (mat4(0.0, -2.0, -2.0, 7.0, -9.0, -8.0, 3.0, 5.0, 5.0, -1.0, 7.0, -1.0, -8.0, 0.0, -8.0, 4.0));
	blockB.d[0].mB = (mat2(-3.0, -4.0, 9.0, -9.0));
	blockC.e[0] = (uvec3(7u, 9u, 8u));
	blockC.e[1] = (uvec3(1u, 8u, 9u));
	blockC.e[2] = (uvec3(0u, 8u, 1u));
	blockC.e[3] = (uvec3(5u, 5u, 5u));
	blockC.e[4] = (uvec3(9u, 4u, 5u));
	blockC.e[5] = (uvec3(7u, 8u, 4u));
	blockC.e[6] = (uvec3(8u, 8u, 1u));
}
#version 450
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
	highp vec4 a;
	i8vec4 b;
	highp int c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp uvec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), -8) && allOk;
	allOk = compare_uvec4((blockC.d[0]), uvec4(0u, 5u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.d[1]), uvec4(8u, 2u, 1u, 4u)) && allOk;
	allOk = compare_uvec4((blockC.d[2]), uvec4(0u, 6u, 4u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-6.0, -2.0, 3.0, -5.0));
	blockB.b = i8vec4(ivec4(4294967292, 5, 4294967287, 8));
	blockB.c = (1);
	blockC.d[0] = (uvec4(1u, 9u, 5u, 4u));
	blockC.d[1] = (uvec4(2u, 4u, 1u, 2u));
	blockC.d[2] = (uvec4(2u, 3u, 0u, 2u));
}
#version 450
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
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = u8vec3(uvec3(8u, 7u, 4u));
}
#version 450
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
	highp uvec3 mB;
	bool mC;
};
struct sB
{
	i8vec4 mA;
	int8_t mB;
};
struct sC
{
	i8vec2 mA;
	highp mat4 mB;
	lowp float mC;
};
struct sD
{
	u8vec4 mA;
	sC mB;
	u8vec4 mC;
};
layout(std430, buffer_reference) readonly buffer BlockB
{
	highp uint a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sA b;
	u8vec2 c[7];
	sB d[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	u8vec2 e;
	u8vec2 f;
	lowp float g;
	sD h;
	mediump mat3x2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 4u) && allOk;
	allOk = compare_uint((blockB.a[1]), 0u) && allOk;
	allOk = compare_uint((blockB.a[2]), 4u) && allOk;
	allOk = compare_uint((blockB.a[3]), 6u) && allOk;
	allOk = compare_uint((blockB.a[4]), 7u) && allOk;
	allOk = compare_uint((blockB.a[5]), 5u) && allOk;
	allOk = compare_uint((blockB.a[6]), 8u) && allOk;
	allOk = compare_uint((blockB.a[7]), 8u) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0].mA), ivec4(4294967288, 4294967292, 4294967293, 5)) && allOk;
	allOk = compare_int8_t(int(blockC.d[0].mB), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1].mA), ivec4(0, 4294967294, 3, 0)) && allOk;
	allOk = compare_int8_t(int(blockC.d[1].mB), 4294967295) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2].mA), ivec4(8, 4294967292, 4294967295, 6)) && allOk;
	allOk = compare_int8_t(int(blockC.d[2].mB), 4294967295) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3].mA), ivec4(4294967289, 4294967287, 8, 0)) && allOk;
	allOk = compare_int8_t(int(blockC.d[3].mB), 9) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[4].mA), ivec4(4294967292, 4294967290, 4294967295, 5)) && allOk;
	allOk = compare_int8_t(int(blockC.d[4].mB), 6) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[5].mA), ivec4(1, 4294967291, 4294967288, 4294967290)) && allOk;
	allOk = compare_int8_t(int(blockC.d[5].mB), 3) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[6].mA), ivec4(6, 9, 9, 4294967290)) && allOk;
	allOk = compare_int8_t(int(blockC.d[6].mB), 8) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[7].mA), ivec4(4294967290, 4294967293, 6, 4294967293)) && allOk;
	allOk = compare_int8_t(int(blockC.d[7].mB), 4294967289) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.e), uvec2(0u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.f), uvec2(5u, 7u)) && allOk;
	allOk = compare_mat3x2(blockD.i[0], mat3x2(7.0, 7.0, -3.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[1], mat3x2(-2.0, 2.0, 2.0, -8.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[2], mat3x2(6.0, 7.0, 4.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[3], mat3x2(-7.0, -8.0, 1.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[4], mat3x2(-2.0, 7.0, -2.0, 7.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA = uint8_t(9u);
	blockC.b.mB = (uvec3(4u, 3u, 9u));
	blockC.b.mC = (true);
	blockC.c[0] = u8vec2(uvec2(9u, 7u));
	blockC.c[1] = u8vec2(uvec2(4u, 0u));
	blockC.c[2] = u8vec2(uvec2(9u, 6u));
	blockC.c[3] = u8vec2(uvec2(1u, 7u));
	blockC.c[4] = u8vec2(uvec2(8u, 7u));
	blockC.c[5] = u8vec2(uvec2(5u, 7u));
	blockC.c[6] = u8vec2(uvec2(8u, 1u));
	blockC.d[0].mA = i8vec4(ivec4(4294967292, 4, 4294967288, 4294967292));
	blockC.d[0].mB = int8_t(4294967293);
	blockC.d[1].mA = i8vec4(ivec4(1, 4294967292, 4294967292, 4294967289));
	blockC.d[1].mB = int8_t(4294967291);
	blockC.d[2].mA = i8vec4(ivec4(4294967295, 9, 4294967288, 6));
	blockC.d[2].mB = int8_t(6);
	blockC.d[3].mA = i8vec4(ivec4(2, 4294967295, 0, 2));
	blockC.d[3].mB = int8_t(6);
	blockC.d[4].mA = i8vec4(ivec4(4294967294, 4294967295, 3, 0));
	blockC.d[4].mB = int8_t(4294967295);
	blockC.d[5].mA = i8vec4(ivec4(4294967288, 9, 2, 1));
	blockC.d[5].mB = int8_t(4294967293);
	blockC.d[6].mA = i8vec4(ivec4(4294967294, 4294967293, 4294967295, 2));
	blockC.d[6].mB = int8_t(4294967289);
	blockC.d[7].mA = i8vec4(ivec4(4294967291, 4, 4294967290, 4294967291));
	blockC.d[7].mB = int8_t(4294967293);
	blockD.f = u8vec2(uvec2(0u, 8u));
	blockD.g = (-3.0);
	blockD.h.mA = u8vec4(uvec4(7u, 7u, 1u, 7u));
	blockD.h.mB.mA = i8vec2(ivec2(4294967293, 1));
	blockD.h.mB.mB = (mat4(6.0, -6.0, -9.0, 6.0, 8.0, -8.0, 9.0, 5.0, -6.0, -6.0, -1.0, -6.0, -2.0, 3.0, -4.0, 7.0));
	blockD.h.mB.mC = (-6.0);
	blockD.h.mC = u8vec4(uvec4(8u, 6u, 5u, 8u));
	blockD.i[0] = (mat3x2(7.0, -9.0, 6.0, -4.0, 4.0, -5.0));
	blockD.i[1] = (mat3x2(5.0, -1.0, 8.0, 1.0, -2.0, 0.0));
	blockD.i[2] = (mat3x2(0.0, -7.0, -4.0, 9.0, -2.0, 6.0));
	blockD.i[3] = (mat3x2(6.0, 4.0, 5.0, -9.0, -6.0, -6.0));
	blockD.i[4] = (mat3x2(-2.0, -4.0, -6.0, 3.0, -4.0, -9.0));
}
#version 450
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
	lowp vec3 mB;
	mediump mat2x3 mC;
	lowp mat4 mD;
};
layout(std430, buffer_reference) readonly buffer BlockB
{
	sA a[][8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0][0].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockB.a[0][0].mB), vec3(3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][0].mC, mat2x3(-6.0, 8.0, -7.0, -4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][0].mD, mat4(-5.0, -1.0, 5.0, 8.0, -5.0, 7.0, 4.0, -1.0, -2.0, 2.0, 2.0, 9.0, -4.0, 8.0, -2.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0][1].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[0][1].mB), vec3(-1.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][1].mC, mat2x3(1.0, 5.0, 6.0, -4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][1].mD, mat4(-6.0, -3.0, 8.0, 2.0, 6.0, -1.0, -1.0, 8.0, -4.0, -9.0, 7.0, 4.0, -3.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0][2].mA), bvec3(true, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[0][2].mB), vec3(1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][2].mC, mat2x3(-2.0, -2.0, 9.0, 7.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][2].mD, mat4(4.0, 1.0, -8.0, -9.0, -4.0, 4.0, -3.0, 4.0, 4.0, 3.0, 2.0, 3.0, -3.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0][3].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockB.a[0][3].mB), vec3(-3.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][3].mC, mat2x3(1.0, -6.0, 4.0, 3.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][3].mD, mat4(8.0, 7.0, 6.0, 4.0, 1.0, -4.0, 3.0, 4.0, -6.0, 3.0, 0.0, 6.0, 6.0, 0.0, 3.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0][4].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockB.a[0][4].mB), vec3(-7.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][4].mC, mat2x3(7.0, 5.0, -8.0, -8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][4].mD, mat4(-4.0, 4.0, 5.0, -9.0, -8.0, -2.0, -8.0, -5.0, -7.0, 1.0, -8.0, -3.0, -2.0, -8.0, -5.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0][5].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[0][5].mB), vec3(-7.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][5].mC, mat2x3(-8.0, -8.0, -3.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][5].mD, mat4(6.0, -4.0, 0.0, -7.0, -5.0, -5.0, 2.0, 3.0, 6.0, -4.0, -3.0, 7.0, 5.0, -1.0, 0.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0][6].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[0][6].mB), vec3(8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][6].mC, mat2x3(8.0, -8.0, -1.0, -4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][6].mD, mat4(-8.0, 0.0, 0.0, -1.0, -1.0, -9.0, -8.0, -6.0, 7.0, -7.0, -8.0, 3.0, 3.0, 3.0, -5.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0][7].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[0][7].mB), vec3(5.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[0][7].mC, mat2x3(9.0, -9.0, 7.0, 2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB.a[0][7].mD, mat4(3.0, -7.0, 3.0, -5.0, 6.0, 9.0, -6.0, 2.0, -8.0, 0.0, -6.0, -9.0, 2.0, 6.0, -6.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][0].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_vec3((blockB.a[1][0].mB), vec3(-6.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][0].mC, mat2x3(2.0, 7.0, 8.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][0].mD, mat4(-8.0, -4.0, 7.0, -2.0, -6.0, 6.0, -2.0, -1.0, -2.0, -9.0, 2.0, 2.0, 5.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][1].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[1][1].mB), vec3(4.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][1].mC, mat2x3(5.0, -9.0, 2.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][1].mD, mat4(2.0, -3.0, 2.0, 6.0, 4.0, -2.0, -1.0, -4.0, -2.0, 6.0, -6.0, 2.0, 4.0, 1.0, -2.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][2].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_vec3((blockB.a[1][2].mB), vec3(-8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][2].mC, mat2x3(9.0, -4.0, 8.0, 3.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][2].mD, mat4(1.0, -7.0, 2.0, 0.0, -6.0, 0.0, 0.0, 2.0, -9.0, -8.0, 3.0, 2.0, -9.0, 9.0, 6.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][3].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockB.a[1][3].mB), vec3(-4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][3].mC, mat2x3(4.0, -5.0, -3.0, -2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][3].mD, mat4(-4.0, 7.0, -3.0, 9.0, 3.0, 6.0, -6.0, 9.0, 0.0, 2.0, -7.0, -8.0, 7.0, 5.0, -3.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][4].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[1][4].mB), vec3(-6.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][4].mC, mat2x3(6.0, 9.0, 6.0, -1.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][4].mD, mat4(8.0, 6.0, -7.0, -2.0, 2.0, -9.0, -3.0, 5.0, -8.0, 9.0, 1.0, 7.0, 0.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][5].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[1][5].mB), vec3(6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][5].mC, mat2x3(-1.0, 5.0, -7.0, -1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][5].mD, mat4(6.0, 4.0, 1.0, 5.0, 7.0, 9.0, 2.0, 2.0, 8.0, -1.0, 6.0, 1.0, -5.0, -7.0, 3.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][6].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[1][6].mB), vec3(-1.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][6].mC, mat2x3(-7.0, 5.0, 9.0, 7.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][6].mD, mat4(0.0, -4.0, -5.0, -7.0, -5.0, -4.0, -2.0, 8.0, -9.0, -6.0, 2.0, -4.0, -3.0, -1.0, 7.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1][7].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[1][7].mB), vec3(-7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1][7].mC, mat2x3(-8.0, 4.0, -7.0, -1.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.a[1][7].mD, mat4(-8.0, 3.0, -8.0, 6.0, -1.0, -7.0, 0.0, -7.0, 1.0, -4.0, -4.0, 5.0, -2.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][0].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[2][0].mB), vec3(-2.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][0].mC, mat2x3(-1.0, 5.0, -9.0, 2.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][0].mD, mat4(0.0, -9.0, -3.0, 3.0, 7.0, -8.0, 7.0, -1.0, 8.0, -1.0, 5.0, -9.0, -2.0, -4.0, 9.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][1].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[2][1].mB), vec3(-9.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][1].mC, mat2x3(-9.0, -2.0, 2.0, -8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][1].mD, mat4(7.0, -5.0, 4.0, -5.0, -9.0, 0.0, 2.0, -3.0, 9.0, -4.0, 3.0, -8.0, -9.0, -1.0, 8.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][2].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[2][2].mB), vec3(6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][2].mC, mat2x3(6.0, -9.0, -3.0, -3.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][2].mD, mat4(8.0, -2.0, 8.0, 5.0, -5.0, 1.0, -5.0, -6.0, -8.0, -9.0, 7.0, -2.0, 1.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][3].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[2][3].mB), vec3(4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][3].mC, mat2x3(-9.0, 4.0, -7.0, -7.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][3].mD, mat4(3.0, -1.0, 4.0, 8.0, -7.0, 5.0, -9.0, 1.0, -9.0, -6.0, 7.0, -7.0, -4.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][4].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockB.a[2][4].mB), vec3(6.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][4].mC, mat2x3(7.0, 9.0, -3.0, -6.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][4].mD, mat4(9.0, 1.0, -8.0, 6.0, -3.0, 7.0, -2.0, 4.0, 1.0, -6.0, -7.0, -3.0, -4.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][5].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_vec3((blockB.a[2][5].mB), vec3(3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][5].mC, mat2x3(4.0, 1.0, -9.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][5].mD, mat4(-9.0, -4.0, -7.0, 6.0, -9.0, -3.0, -2.0, 9.0, -1.0, 7.0, 9.0, 4.0, 7.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][6].mA), bvec3(true, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[2][6].mB), vec3(-1.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][6].mC, mat2x3(9.0, -5.0, -1.0, -8.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][6].mD, mat4(4.0, -5.0, 6.0, -8.0, -5.0, -8.0, 7.0, 9.0, -4.0, 7.0, -9.0, -4.0, 6.0, -1.0, -6.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2][7].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockB.a[2][7].mB), vec3(-2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2][7].mC, mat2x3(3.0, 8.0, 8.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB.a[2][7].mD, mat4(9.0, -4.0, 7.0, 6.0, 5.0, 3.0, -8.0, 2.0, -8.0, -6.0, -9.0, 0.0, -6.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][0].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[3][0].mB), vec3(-1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][0].mC, mat2x3(-3.0, -9.0, -2.0, 5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][0].mD, mat4(-8.0, -7.0, 7.0, -2.0, 7.0, -8.0, 2.0, 5.0, -9.0, 7.0, -4.0, 2.0, -5.0, -6.0, 1.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][1].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[3][1].mB), vec3(9.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][1].mC, mat2x3(9.0, 1.0, 0.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][1].mD, mat4(6.0, 3.0, 0.0, -7.0, 8.0, 3.0, -6.0, -8.0, -4.0, -7.0, -5.0, 3.0, 6.0, 5.0, 6.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][2].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[3][2].mB), vec3(5.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][2].mC, mat2x3(-9.0, -3.0, 6.0, 6.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][2].mD, mat4(7.0, 7.0, -7.0, -5.0, -2.0, 4.0, -9.0, 7.0, -3.0, -8.0, 0.0, -3.0, -6.0, -6.0, 6.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][3].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[3][3].mB), vec3(0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][3].mC, mat2x3(-3.0, -8.0, -7.0, -3.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][3].mD, mat4(9.0, -1.0, 5.0, -7.0, 1.0, -4.0, 0.0, 2.0, 4.0, -9.0, 7.0, -7.0, -6.0, -2.0, 0.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][4].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[3][4].mB), vec3(-5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][4].mC, mat2x3(2.0, 5.0, 5.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][4].mD, mat4(-7.0, 5.0, 3.0, 1.0, 0.0, -3.0, 9.0, 6.0, 2.0, 9.0, -7.0, -6.0, -1.0, 8.0, 0.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][5].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB.a[3][5].mB), vec3(8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][5].mC, mat2x3(0.0, -1.0, 9.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][5].mD, mat4(-8.0, 6.0, 5.0, -1.0, 6.0, 2.0, -3.0, 8.0, -7.0, -7.0, 3.0, 3.0, 0.0, -4.0, -1.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][6].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockB.a[3][6].mB), vec3(-7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][6].mC, mat2x3(4.0, -1.0, 2.0, 1.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][6].mD, mat4(9.0, -5.0, 0.0, 0.0, -9.0, 7.0, -1.0, -4.0, 1.0, 1.0, -8.0, -8.0, 5.0, -1.0, 7.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3][7].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockB.a[3][7].mB), vec3(-4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3][7].mC, mat2x3(-3.0, 6.0, -6.0, -1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.a[3][7].mD, mat4(4.0, -6.0, -8.0, 5.0, -3.0, 4.0, 0.0, -6.0, 3.0, 5.0, -7.0, -2.0, -6.0, 7.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp vec2 a;
	highp uint b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sA c[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockD
{
	mediump mat4x3 d[1];
	int8_t e;
	lowp vec2 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp ivec2 g;
	i8vec4 h[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC.c[0].mA), vec4(-4.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[0].mB, mat4x3(-5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -3.0, 7.0, 8.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD.d[0], mat4x3(-9.0, -7.0, -6.0, -3.0, -7.0, 8.0, 4.0, -1.0, -4.0, -3.0, 9.0, 4.0)) && allOk;
	allOk = compare_int8_t(int(blockD.e), 1) && allOk;
	allOk = compare_vec2((blockD.f[0]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockE.g), ivec2(-3, -5)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.h[0]), ivec4(4, 3, 0, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(8.0, 7.0));
	blockC.c[0].mA = (vec4(6.0, 0.0, 5.0, 9.0));
	blockC.c[0].mB = (mat4x3(-5.0, 6.0, 2.0, 4.0, 5.0, -7.0, 7.0, 8.0, -2.0, -1.0, 6.0, -4.0));
	blockE.g = (ivec2(-2, 3));
	blockE.h[0] = i8vec4(ivec4(4294967293, 3, 2, 2));
}
#version 450
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
	bvec4 mC;
	mediump ivec2 mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	sA a;
	bvec3 b;
	lowp uvec4 c;
	mediump uvec4 d;
	highp ivec2 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	i8vec2 f[4];
	lowp uint g;
	lowp ivec3 h;
	u8vec4 i;
	lowp mat3 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	int8_t k;
	highp ivec4 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].b), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec4((blockB[0].c), uvec4(9u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[0].d), uvec4(8u, 2u, 9u, 4u)) && allOk;
	allOk = compare_ivec2((blockB[0].e), ivec2(3, -8)) && allOk;
	allOk = compare_bvec3((blockB[1].b), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockB[1].c), uvec4(9u, 2u, 2u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[1].d), uvec4(9u, 8u, 6u, 1u)) && allOk;
	allOk = compare_ivec2((blockB[1].e), ivec2(-6, -3)) && allOk;
	allOk = compare_bvec3((blockB[2].b), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec4((blockB[2].c), uvec4(1u, 7u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((blockB[2].d), uvec4(0u, 5u, 4u, 5u)) && allOk;
	allOk = compare_ivec2((blockB[2].e), ivec2(-2, 9)) && allOk;
	allOk = compare_uint((blockC.g), 1u) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(-8, 2, -3)) && allOk;
	allOk = compare_mat3(blockC.j[0], mat3(-2.0, 4.0, 3.0, 9.0, 8.0, -8.0, 2.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.j[1], mat3(3.0, -6.0, -7.0, -3.0, -4.0, 6.0, 3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.j[2], mat3(9.0, -4.0, -4.0, 6.0, 0.0, 2.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_int8_t(int(blockD.k), 4294967292) && allOk;
	allOk = compare_ivec4((blockD.l[0]), ivec4(5, -6, 5, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (mat2(6.0, -8.0, -5.0, -5.0));
	blockB[0].a.mB = (uvec4(3u, 4u, 2u, 9u));
	blockB[0].a.mC = (bvec4(true, true, true, false));
	blockB[0].a.mD = (ivec2(-5, 8));
	blockB[0].b = (bvec3(false, true, true));
	blockB[0].d = (uvec4(3u, 3u, 0u, 3u));
	blockB[0].e = (ivec2(4, -5));
	blockB[1].a.mA = (mat2(-8.0, -3.0, -5.0, 0.0));
	blockB[1].a.mB = (uvec4(8u, 4u, 7u, 2u));
	blockB[1].a.mC = (bvec4(true, false, true, false));
	blockB[1].a.mD = (ivec2(9, 3));
	blockB[1].b = (bvec3(false, true, false));
	blockB[1].d = (uvec4(7u, 3u, 4u, 8u));
	blockB[1].e = (ivec2(-8, 9));
	blockB[2].a.mA = (mat2(0.0, -8.0, -2.0, -5.0));
	blockB[2].a.mB = (uvec4(5u, 1u, 9u, 3u));
	blockB[2].a.mC = (bvec4(true, true, false, false));
	blockB[2].a.mD = (ivec2(3, 8));
	blockB[2].b = (bvec3(false, true, false));
	blockB[2].d = (uvec4(9u, 9u, 0u, 4u));
	blockB[2].e = (ivec2(7, 9));
	blockC.g = (6u);
	blockC.h = (ivec3(4, -2, -4));
	blockD.k = int8_t(4294967295);
	blockD.l[0] = (ivec4(-6, -8, -9, 0));
}
#version 450
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
	layout(offset = 0) mediump vec2 a;
	layout(offset = 16) bvec3 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec3 c[1];
	layout(offset = 16) u8vec4 d;
	layout(offset = 32) lowp vec4 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec2 f;
	layout(offset = 8) mediump uint g;
	layout(offset = 16) lowp vec3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC[0].c[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].d), uvec4(1u, 8u, 4u, 5u)) && allOk;
	allOk = compare_vec4((blockC[0].e), vec4(7.0, 7.0, -1.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockC[1].c[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[1].d), uvec4(4u, 5u, 5u, 1u)) && allOk;
	allOk = compare_vec4((blockC[1].e), vec4(1.0, 8.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockD.f), ivec2(-8, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(3.0, -4.0));
	blockB.b = (bvec3(false, true, false));
	blockC[0].c[0] = (bvec3(false, false, true));
	blockC[1].c[0] = (bvec3(false, false, true));
	blockD.f = (ivec2(-2, -4));
	blockD.g = (4u);
	blockD.h = (vec3(-9.0, -5.0, 4.0));
}
#version 450
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
	layout(offset = 8) lowp vec2 b;
	layout(offset = 16) mediump vec4 c;
	layout(offset = 32) lowp float d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-9.0, -3.0, -2.0, 5.0)) && allOk;
	allOk = compare_float((blockB.d), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (vec2(-5.0, 6.0));
	blockB.c = (vec4(-3.0, -4.0, -4.0, -2.0));
}
#version 450
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
	highp ivec4 mA[6];
};
struct sB
{
	lowp ivec2 mA[6];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	lowp uvec3 a;
	mediump mat4x3 b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp uvec3 c;
	highp int d;
	sA e;
	sB f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp int g;
	highp ivec4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b[0], mat4x3(0.0, -5.0, -6.0, 5.0, -2.0, -8.0, 5.0, -9.0, -5.0, 5.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[1], mat4x3(7.0, -5.0, -5.0, -8.0, -8.0, 8.0, 1.0, -7.0, -5.0, 5.0, 7.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[0]), ivec4(0, -2, 3, 0)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[1]), ivec4(8, -4, -1, 6)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[2]), ivec4(-7, -9, 8, 0)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[3]), ivec4(-4, -6, -1, 5)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[4]), ivec4(1, -5, -8, -6)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[5]), ivec4(6, 9, 9, -6)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[0]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[1]), ivec2(6, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[2]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[4]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[5]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[0]), ivec2(0, 1)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[1]), ivec2(7, -2)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[3]), ivec2(-6, 4)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[4]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[5]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[0]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[1]), ivec2(2, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[2]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[4]), ivec2(0, 4)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[5]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[0]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[1]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[2]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[3]), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[4]), ivec2(7, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[5]), ivec2(-3, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[0]), ivec2(-7, 1)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[1]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[2]), ivec2(2, -8)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[3]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[4]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[5]), ivec2(4, 3)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[0]), ivec2(4, -1)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[1]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[2]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[3]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[4]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[5]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[0]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[1]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[2]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[3]), ivec2(4, -6)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[4]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[5]), ivec2(-6, 6)) && allOk;
	allOk = compare_int((blockD[0].g), 7) && allOk;
	allOk = compare_int((blockD[1].g), -5) && allOk;
	allOk = compare_int((blockD[2].g), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(8u, 3u, 1u));
	blockC.c = (uvec3(1u, 6u, 5u));
	blockC.d = (-8);
	blockC.e.mA[0] = (ivec4(-4, 1, -4, -4));
	blockC.e.mA[1] = (ivec4(-7, -1, 9, -8));
	blockC.e.mA[2] = (ivec4(6, 2, -1, 0));
	blockC.e.mA[3] = (ivec4(2, -2, -1, 3));
	blockC.e.mA[4] = (ivec4(0, -8, 9, 2));
	blockC.e.mA[5] = (ivec4(1, -2, -3, -1));
	blockC.f[0].mA[0] = (ivec2(2, -5));
	blockC.f[0].mA[1] = (ivec2(4, -6));
	blockC.f[0].mA[2] = (ivec2(-5, -3));
	blockC.f[0].mA[3] = (ivec2(-5, 6));
	blockC.f[0].mA[4] = (ivec2(6, -1));
	blockC.f[0].mA[5] = (ivec2(-3, -7));
	blockC.f[1].mA[0] = (ivec2(-3, -6));
	blockC.f[1].mA[1] = (ivec2(-2, 0));
	blockC.f[1].mA[2] = (ivec2(-2, -3));
	blockC.f[1].mA[3] = (ivec2(-8, 1));
	blockC.f[1].mA[4] = (ivec2(8, -6));
	blockC.f[1].mA[5] = (ivec2(-3, 1));
	blockC.f[2].mA[0] = (ivec2(6, -6));
	blockC.f[2].mA[1] = (ivec2(-9, 6));
	blockC.f[2].mA[2] = (ivec2(8, -8));
	blockC.f[2].mA[3] = (ivec2(9, 5));
	blockC.f[2].mA[4] = (ivec2(-6, -6));
	blockC.f[2].mA[5] = (ivec2(-1, -6));
	blockC.f[3].mA[0] = (ivec2(-2, 3));
	blockC.f[3].mA[1] = (ivec2(-4, 7));
	blockC.f[3].mA[2] = (ivec2(-6, -9));
	blockC.f[3].mA[3] = (ivec2(-3, 1));
	blockC.f[3].mA[4] = (ivec2(8, 7));
	blockC.f[3].mA[5] = (ivec2(-9, 6));
	blockC.f[4].mA[0] = (ivec2(-4, 4));
	blockC.f[4].mA[1] = (ivec2(-5, 5));
	blockC.f[4].mA[2] = (ivec2(-1, 8));
	blockC.f[4].mA[3] = (ivec2(1, -2));
	blockC.f[4].mA[4] = (ivec2(0, 0));
	blockC.f[4].mA[5] = (ivec2(-7, -4));
	blockC.f[5].mA[0] = (ivec2(9, -2));
	blockC.f[5].mA[1] = (ivec2(6, 6));
	blockC.f[5].mA[2] = (ivec2(4, 5));
	blockC.f[5].mA[3] = (ivec2(-9, -6));
	blockC.f[5].mA[4] = (ivec2(-6, -2));
	blockC.f[5].mA[5] = (ivec2(-4, -6));
	blockC.f[6].mA[0] = (ivec2(3, -4));
	blockC.f[6].mA[1] = (ivec2(-9, 0));
	blockC.f[6].mA[2] = (ivec2(1, 4));
	blockC.f[6].mA[3] = (ivec2(3, 7));
	blockC.f[6].mA[4] = (ivec2(1, 2));
	blockC.f[6].mA[5] = (ivec2(6, 1));
	blockD[0].g = (4);
	blockD[1].g = (9);
	blockD[2].g = (-4);
}
#version 450
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
	lowp mat2 mA;
	lowp mat4x2 mB;
};
struct sB
{
	lowp vec3 mA;
	sA mB;
};
struct sC
{
	bvec4 mA;
};
struct sD
{
	i8vec3 mA;
	mediump mat3x2 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	u8vec2 a;
	mediump vec3 b;
	sB c[7];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	sC d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp mat4x2 e;
	mediump uint f;
	u8vec4 g;
	mediump vec2 h;
	int8_t i[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	sD j[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(9.0, -5.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mA), vec3(3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2(blockB.c[0].mB.mA, mat2(2.0, 8.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[0].mB.mB, mat4x2(6.0, 1.0, 7.0, 8.0, -4.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mA), vec3(-8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2(blockB.c[1].mB.mA, mat2(0.0, 2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[1].mB.mB, mat4x2(4.0, -3.0, 0.0, -9.0, 7.0, -9.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mA), vec3(-2.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2(blockB.c[2].mB.mA, mat2(3.0, -6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[2].mB.mB, mat4x2(-2.0, 0.0, -1.0, 4.0, -9.0, 3.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mA), vec3(-7.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(blockB.c[3].mB.mA, mat2(9.0, -2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[3].mB.mB, mat4x2(9.0, 7.0, 7.0, -4.0, 1.0, 1.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[4].mA), vec3(1.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2(blockB.c[4].mB.mA, mat2(3.0, -8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[4].mB.mB, mat4x2(-6.0, -9.0, 1.0, 2.0, 2.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[5].mA), vec3(3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(blockB.c[5].mB.mA, mat2(6.0, 7.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[5].mB.mB, mat4x2(-6.0, -1.0, -4.0, 4.0, 6.0, 9.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[6].mA), vec3(1.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB.c[6].mB.mA, mat2(-9.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[6].mB.mB, mat4x2(7.0, 1.0, 5.0, -6.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockD.e, mat4x2(0.0, -3.0, -6.0, 2.0, -4.0, -7.0, 9.0, -4.0)) && allOk;
	allOk = compare_uint((blockD.f), 0u) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.g), uvec4(2u, 9u, 5u, 4u)) && allOk;
	allOk = compare_int8_t(int(blockD.i[0]), 4294967288) && allOk;
	allOk = compare_int8_t(int(blockD.i[1]), 0) && allOk;
	allOk = compare_int8_t(int(blockD.i[2]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockD.i[3]), 0) && allOk;
	allOk = compare_int8_t(int(blockD.i[4]), 5) && allOk;
	allOk = compare_int8_t(int(blockD.i[5]), 5) && allOk;
	allOk = compare_int8_t(int(blockD.i[6]), 3) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[0][0].mA), ivec3(3, 4294967288, 4)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[0][0].mB, mat3x2(-8.0, 5.0, 6.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[0][1].mA), ivec3(3, 4294967295, 5)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[0][1].mB, mat3x2(6.0, -2.0, -8.0, 9.0, 2.0, 8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[0][2].mA), ivec3(4294967293, 4294967292, 8)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[0][2].mB, mat3x2(-7.0, 5.0, -8.0, -2.0, -6.0, 7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[0][3].mA), ivec3(9, 9, 4294967287)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[0][3].mB, mat3x2(-9.0, 0.0, -8.0, 3.0, -8.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[1][0].mA), ivec3(4, 4294967292, 0)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[1][0].mB, mat3x2(6.0, -6.0, -6.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[1][1].mA), ivec3(7, 6, 4294967288)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[1][1].mB, mat3x2(-5.0, 0.0, -2.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[1][2].mA), ivec3(4294967289, 9, 8)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[1][2].mB, mat3x2(5.0, 9.0, -3.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[1][3].mA), ivec3(4294967291, 4294967293, 9)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[1][3].mB, mat3x2(-3.0, -5.0, -8.0, -2.0, -4.0, -5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[2][0].mA), ivec3(2, 4, 4294967291)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[2][0].mB, mat3x2(-5.0, 0.0, -2.0, 2.0, -5.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[2][1].mA), ivec3(9, 4294967288, 7)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[2][1].mB, mat3x2(9.0, -1.0, 7.0, 2.0, 8.0, -6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[2][2].mA), ivec3(5, 4294967293, 8)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[2][2].mB, mat3x2(7.0, 3.0, -9.0, -9.0, -1.0, 8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[2][3].mA), ivec3(0, 2, 4294967289)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[2][3].mB, mat3x2(-3.0, -4.0, -8.0, 4.0, 3.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[3][0].mA), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[3][0].mB, mat3x2(-6.0, -9.0, 1.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[3][1].mA), ivec3(6, 4294967291, 5)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[3][1].mB, mat3x2(-5.0, 2.0, 5.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[3][2].mA), ivec3(6, 7, 4294967289)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[3][2].mB, mat3x2(0.0, 0.0, 5.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].j[3][3].mA), ivec3(9, 3, 4294967291)) && allOk;
	allOk = compare_mat3x2(blockE[0].j[3][3].mB, mat3x2(-8.0, 1.0, -7.0, -9.0, 4.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[0][0].mA), ivec3(4294967287, 5, 0)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[0][0].mB, mat3x2(-3.0, -9.0, 7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[0][1].mA), ivec3(9, 3, 4294967287)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[0][1].mB, mat3x2(8.0, -4.0, 3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[0][2].mA), ivec3(3, 9, 4294967291)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[0][2].mB, mat3x2(-8.0, 0.0, 7.0, 3.0, -8.0, 4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[0][3].mA), ivec3(5, 4294967288, 4294967290)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[0][3].mB, mat3x2(3.0, 3.0, 1.0, 9.0, 0.0, 3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[1][0].mA), ivec3(8, 7, 8)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[1][0].mB, mat3x2(-3.0, 6.0, -6.0, 3.0, 3.0, 1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[1][1].mA), ivec3(4294967292, 4294967289, 4294967289)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[1][1].mB, mat3x2(-8.0, 9.0, -6.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[1][2].mA), ivec3(1, 6, 4294967295)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[1][2].mB, mat3x2(-5.0, 0.0, 6.0, 9.0, -7.0, 9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[1][3].mA), ivec3(4294967288, 4294967295, 4294967292)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[1][3].mB, mat3x2(-8.0, 3.0, 7.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[2][0].mA), ivec3(4294967289, 4294967288, 6)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[2][0].mB, mat3x2(-4.0, 7.0, -9.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[2][1].mA), ivec3(4294967295, 4294967288, 4294967293)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[2][1].mB, mat3x2(8.0, 2.0, 6.0, -8.0, 4.0, 6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[2][2].mA), ivec3(4, 2, 9)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[2][2].mB, mat3x2(5.0, 8.0, 0.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[2][3].mA), ivec3(2, 3, 6)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[2][3].mB, mat3x2(-4.0, 8.0, -5.0, -1.0, -5.0, 3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[3][0].mA), ivec3(4294967288, 4294967293, 5)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[3][0].mB, mat3x2(6.0, 9.0, 3.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[3][1].mA), ivec3(5, 4294967295, 4294967288)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[3][1].mB, mat3x2(-7.0, -1.0, 1.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[3][2].mA), ivec3(4294967290, 4294967290, 8)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[3][2].mB, mat3x2(5.0, 0.0, -1.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[3][3].mA), ivec3(9, 8, 7)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[3][3].mB, mat3x2(-8.0, -5.0, -6.0, -7.0, -2.0, -5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[4][0].mA), ivec3(4294967294, 4294967294, 8)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[4][0].mB, mat3x2(-9.0, -6.0, 9.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[4][1].mA), ivec3(4294967293, 4294967287, 4294967291)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[4][1].mB, mat3x2(-1.0, -1.0, 4.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[4][2].mA), ivec3(3, 6, 6)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[4][2].mB, mat3x2(7.0, 7.0, -5.0, 9.0, -5.0, 1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].j[4][3].mA), ivec3(4294967290, 4294967288, 4294967291)) && allOk;
	allOk = compare_mat3x2(blockE[1].j[4][3].mB, mat3x2(4.0, -4.0, 3.0, 1.0, 4.0, 3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[0][0].mA), ivec3(4294967290, 4294967291, 4294967287)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[0][0].mB, mat3x2(-8.0, 1.0, -1.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[0][1].mA), ivec3(1, 3, 5)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[0][1].mB, mat3x2(-7.0, -6.0, -1.0, 8.0, 8.0, 7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[0][2].mA), ivec3(0, 8, 1)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[0][2].mB, mat3x2(-1.0, -8.0, -6.0, -4.0, -1.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[0][3].mA), ivec3(4294967292, 4294967293, 0)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[0][3].mB, mat3x2(-7.0, 2.0, -5.0, -7.0, 1.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[1][0].mA), ivec3(8, 6, 1)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[1][0].mB, mat3x2(6.0, -4.0, 1.0, 1.0, -6.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[1][1].mA), ivec3(4294967290, 4294967292, 5)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[1][1].mB, mat3x2(5.0, 2.0, 1.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[1][2].mA), ivec3(5, 4294967295, 4294967294)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[1][2].mB, mat3x2(9.0, 3.0, 5.0, -3.0, 7.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[1][3].mA), ivec3(4294967294, 5, 4294967290)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[1][3].mB, mat3x2(-3.0, 4.0, 8.0, 4.0, 9.0, 2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[2][0].mA), ivec3(4294967287, 6, 4294967295)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[2][0].mB, mat3x2(-7.0, 9.0, 2.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[2][1].mA), ivec3(5, 0, 5)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[2][1].mB, mat3x2(-9.0, 1.0, -2.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[2][2].mA), ivec3(7, 4294967290, 4294967287)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[2][2].mB, mat3x2(-6.0, 3.0, -5.0, 2.0, -9.0, 7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[2][3].mA), ivec3(9, 0, 7)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[2][3].mB, mat3x2(8.0, -5.0, -4.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[2].j[3][0].mA), ivec3(2, 4294967292, 4294967289)) && allOk;
	allOk = compare_mat3x2(blockE[2].j[3][0].mB, mat3x2(-9.0, 5.0, 3.0, 9.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(-9.0, 0.0, 9.0));
	blockB.c[0].mA = (vec3(2.0, -6.0, 6.0));
	blockB.c[0].mB.mA = (mat2(1.0, 2.0, 9.0, -3.0));
	blockB.c[0].mB.mB = (mat4x2(7.0, -9.0, 3.0, 8.0, 2.0, 4.0, -8.0, -4.0));
	blockB.c[1].mA = (vec3(-6.0, 3.0, 5.0));
	blockB.c[1].mB.mA = (mat2(-2.0, -6.0, -2.0, 5.0));
	blockB.c[1].mB.mB = (mat4x2(-3.0, -8.0, 8.0, -8.0, 3.0, -1.0, 4.0, 4.0));
	blockB.c[2].mA = (vec3(-8.0, -7.0, -8.0));
	blockB.c[2].mB.mA = (mat2(-3.0, 2.0, 0.0, 0.0));
	blockB.c[2].mB.mB = (mat4x2(-4.0, 9.0, 8.0, -7.0, -1.0, -7.0, 2.0, -7.0));
	blockB.c[3].mA = (vec3(3.0, -6.0, -9.0));
	blockB.c[3].mB.mA = (mat2(2.0, -8.0, -5.0, -3.0));
	blockB.c[3].mB.mB = (mat4x2(3.0, -2.0, -4.0, 9.0, -4.0, 0.0, 5.0, -5.0));
	blockB.c[4].mA = (vec3(9.0, -9.0, 9.0));
	blockB.c[4].mB.mA = (mat2(-3.0, 0.0, 8.0, -9.0));
	blockB.c[4].mB.mB = (mat4x2(1.0, 7.0, -5.0, 0.0, -1.0, 9.0, 7.0, 1.0));
	blockB.c[5].mA = (vec3(8.0, -1.0, -4.0));
	blockB.c[5].mB.mA = (mat2(2.0, -4.0, 1.0, 8.0));
	blockB.c[5].mB.mB = (mat4x2(-6.0, -6.0, -8.0, 2.0, 7.0, -8.0, -1.0, 5.0));
	blockB.c[6].mA = (vec3(0.0, -4.0, 2.0));
	blockB.c[6].mB.mA = (mat2(7.0, -4.0, -3.0, -2.0));
	blockB.c[6].mB.mB = (mat4x2(4.0, -2.0, -6.0, -1.0, 3.0, -7.0, -2.0, -4.0));
	blockC[0].d[0].mA = (bvec4(true, true, false, false));
	blockC[0].d[1].mA = (bvec4(false, false, true, false));
	blockC[0].d[2].mA = (bvec4(false, false, true, false));
	blockC[0].d[3].mA = (bvec4(true, false, false, true));
	blockC[0].d[4].mA = (bvec4(false, true, false, false));
	blockC[0].d[5].mA = (bvec4(false, true, true, false));
	blockC[1].d[0].mA = (bvec4(false, true, false, false));
	blockC[1].d[1].mA = (bvec4(true, false, false, true));
	blockC[1].d[2].mA = (bvec4(false, false, true, true));
	blockC[1].d[3].mA = (bvec4(true, true, true, true));
	blockC[1].d[4].mA = (bvec4(true, false, true, true));
	blockC[1].d[5].mA = (bvec4(true, true, true, true));
	blockC[1].d[6].mA = (bvec4(false, true, false, false));
	blockC[2].d[0].mA = (bvec4(true, false, true, true));
	blockC[2].d[1].mA = (bvec4(true, false, false, true));
	blockC[2].d[2].mA = (bvec4(true, false, false, false));
	blockC[2].d[3].mA = (bvec4(true, false, false, false));
	blockC[2].d[4].mA = (bvec4(true, true, true, true));
	blockC[2].d[5].mA = (bvec4(true, true, true, false));
	blockC[2].d[6].mA = (bvec4(true, true, false, true));
	blockC[2].d[7].mA = (bvec4(false, true, false, false));
	blockD.e = (mat4x2(-5.0, -5.0, -9.0, 6.0, 0.0, 3.0, -7.0, -8.0));
	blockD.g = u8vec4(uvec4(0u, 5u, 6u, 9u));
	blockD.i[0] = int8_t(4294967295);
	blockD.i[1] = int8_t(7);
	blockD.i[2] = int8_t(4294967290);
	blockD.i[3] = int8_t(4);
	blockD.i[4] = int8_t(6);
	blockD.i[5] = int8_t(1);
	blockD.i[6] = int8_t(5);
	blockE[0].j[0][0].mA = i8vec3(ivec3(4294967295, 4, 6));
	blockE[0].j[0][0].mB = (mat3x2(-5.0, -7.0, 6.0, 1.0, 6.0, -2.0));
	blockE[0].j[0][1].mA = i8vec3(ivec3(4294967287, 2, 9));
	blockE[0].j[0][1].mB = (mat3x2(0.0, -5.0, 9.0, 2.0, 1.0, 9.0));
	blockE[0].j[0][2].mA = i8vec3(ivec3(4, 4294967287, 8));
	blockE[0].j[0][2].mB = (mat3x2(2.0, -4.0, 0.0, 8.0, 6.0, -8.0));
	blockE[0].j[0][3].mA = i8vec3(ivec3(9, 9, 0));
	blockE[0].j[0][3].mB = (mat3x2(3.0, 5.0, 2.0, 0.0, -2.0, 0.0));
	blockE[0].j[1][0].mA = i8vec3(ivec3(2, 6, 1));
	blockE[0].j[1][0].mB = (mat3x2(-6.0, -8.0, 8.0, 5.0, 8.0, 1.0));
	blockE[0].j[1][1].mA = i8vec3(ivec3(4, 7, 9));
	blockE[0].j[1][1].mB = (mat3x2(3.0, -1.0, 6.0, -6.0, -4.0, -5.0));
	blockE[0].j[1][2].mA = i8vec3(ivec3(4294967290, 0, 4294967294));
	blockE[0].j[1][2].mB = (mat3x2(6.0, 1.0, 1.0, 8.0, 6.0, -6.0));
	blockE[0].j[1][3].mA = i8vec3(ivec3(4294967289, 4294967288, 4294967291));
	blockE[0].j[1][3].mB = (mat3x2(-1.0, -6.0, 2.0, 5.0, -8.0, 0.0));
	blockE[0].j[2][0].mA = i8vec3(ivec3(5, 1, 1));
	blockE[0].j[2][0].mB = (mat3x2(2.0, -7.0, 5.0, -7.0, 6.0, 5.0));
	blockE[0].j[2][1].mA = i8vec3(ivec3(4294967294, 6, 4294967287));
	blockE[0].j[2][1].mB = (mat3x2(-7.0, 8.0, -9.0, -8.0, 4.0, -5.0));
	blockE[0].j[2][2].mA = i8vec3(ivec3(4294967294, 8, 4));
	blockE[0].j[2][2].mB = (mat3x2(2.0, 0.0, -5.0, -8.0, -4.0, -6.0));
	blockE[0].j[2][3].mA = i8vec3(ivec3(5, 4294967289, 4294967294));
	blockE[0].j[2][3].mB = (mat3x2(-4.0, -4.0, -3.0, -3.0, -5.0, -3.0));
	blockE[0].j[3][0].mA = i8vec3(ivec3(9, 4294967288, 2));
	blockE[0].j[3][0].mB = (mat3x2(6.0, -4.0, 3.0, -6.0, 1.0, -4.0));
	blockE[0].j[3][1].mA = i8vec3(ivec3(5, 8, 7));
	blockE[0].j[3][1].mB = (mat3x2(9.0, -3.0, -7.0, 8.0, -3.0, 3.0));
	blockE[0].j[3][2].mA = i8vec3(ivec3(4, 9, 9));
	blockE[0].j[3][2].mB = (mat3x2(-7.0, -3.0, 2.0, -5.0, -7.0, 9.0));
	blockE[0].j[3][3].mA = i8vec3(ivec3(4294967290, 4, 3));
	blockE[0].j[3][3].mB = (mat3x2(0.0, 4.0, 0.0, -4.0, 1.0, -5.0));
	blockE[1].j[0][0].mA = i8vec3(ivec3(4294967293, 5, 4294967291));
	blockE[1].j[0][0].mB = (mat3x2(2.0, -3.0, 2.0, 2.0, -7.0, -9.0));
	blockE[1].j[0][1].mA = i8vec3(ivec3(4294967291, 5, 4));
	blockE[1].j[0][1].mB = (mat3x2(4.0, 2.0, -1.0, 0.0, 5.0, -8.0));
	blockE[1].j[0][2].mA = i8vec3(ivec3(4294967288, 4294967295, 4294967290));
	blockE[1].j[0][2].mB = (mat3x2(0.0, 4.0, 8.0, -4.0, 7.0, 0.0));
	blockE[1].j[0][3].mA = i8vec3(ivec3(0, 5, 6));
	blockE[1].j[0][3].mB = (mat3x2(-5.0, -1.0, 6.0, 7.0, 2.0, -3.0));
	blockE[1].j[1][0].mA = i8vec3(ivec3(8, 4294967294, 4294967295));
	blockE[1].j[1][0].mB = (mat3x2(-9.0, 2.0, 6.0, -5.0, 1.0, 3.0));
	blockE[1].j[1][1].mA = i8vec3(ivec3(4294967289, 2, 4));
	blockE[1].j[1][1].mB = (mat3x2(-4.0, 5.0, 6.0, 9.0, 4.0, 6.0));
	blockE[1].j[1][2].mA = i8vec3(ivec3(6, 1, 2));
	blockE[1].j[1][2].mB = (mat3x2(2.0, 2.0, -5.0, 3.0, -2.0, -3.0));
	blockE[1].j[1][3].mA = i8vec3(ivec3(1, 4294967289, 0));
	blockE[1].j[1][3].mB = (mat3x2(7.0, 2.0, -2.0, -2.0, -3.0, -2.0));
	blockE[1].j[2][0].mA = i8vec3(ivec3(4294967287, 4294967292, 4294967290));
	blockE[1].j[2][0].mB = (mat3x2(5.0, 8.0, 7.0, -1.0, 9.0, 1.0));
	blockE[1].j[2][1].mA = i8vec3(ivec3(8, 1, 4294967287));
	blockE[1].j[2][1].mB = (mat3x2(-1.0, -8.0, 0.0, 9.0, 6.0, 8.0));
	blockE[1].j[2][2].mA = i8vec3(ivec3(4294967289, 4294967288, 4294967293));
	blockE[1].j[2][2].mB = (mat3x2(1.0, 9.0, -5.0, 0.0, 6.0, 2.0));
	blockE[1].j[2][3].mA = i8vec3(ivec3(6, 9, 0));
	blockE[1].j[2][3].mB = (mat3x2(7.0, -9.0, 7.0, -9.0, 0.0, 3.0));
	blockE[1].j[3][0].mA = i8vec3(ivec3(4294967293, 1, 4294967288));
	blockE[1].j[3][0].mB = (mat3x2(-9.0, -3.0, 5.0, -6.0, -4.0, -4.0));
	blockE[1].j[3][1].mA = i8vec3(ivec3(4294967293, 4294967290, 4294967290));
	blockE[1].j[3][1].mB = (mat3x2(-7.0, -9.0, -2.0, -6.0, 5.0, -1.0));
	blockE[1].j[3][2].mA = i8vec3(ivec3(4294967292, 6, 3));
	blockE[1].j[3][2].mB = (mat3x2(-1.0, -4.0, 0.0, 6.0, -6.0, 1.0));
	blockE[1].j[3][3].mA = i8vec3(ivec3(6, 4294967288, 4294967287));
	blockE[1].j[3][3].mB = (mat3x2(2.0, -3.0, -6.0, 3.0, 0.0, 0.0));
	blockE[1].j[4][0].mA = i8vec3(ivec3(4294967289, 5, 4294967295));
	blockE[1].j[4][0].mB = (mat3x2(7.0, -1.0, 2.0, 3.0, -3.0, -6.0));
	blockE[1].j[4][1].mA = i8vec3(ivec3(9, 0, 4294967290));
	blockE[1].j[4][1].mB = (mat3x2(-6.0, 5.0, -8.0, -9.0, 3.0, 3.0));
	blockE[1].j[4][2].mA = i8vec3(ivec3(8, 4294967295, 4294967292));
	blockE[1].j[4][2].mB = (mat3x2(-6.0, -4.0, 9.0, -3.0, 8.0, 7.0));
	blockE[1].j[4][3].mA = i8vec3(ivec3(6, 4294967291, 4));
	blockE[1].j[4][3].mB = (mat3x2(-6.0, 0.0, -1.0, -8.0, -5.0, 4.0));
	blockE[2].j[0][0].mA = i8vec3(ivec3(4294967287, 3, 8));
	blockE[2].j[0][0].mB = (mat3x2(7.0, 0.0, 2.0, -3.0, -6.0, 5.0));
	blockE[2].j[0][1].mA = i8vec3(ivec3(1, 6, 4294967293));
	blockE[2].j[0][1].mB = (mat3x2(1.0, 4.0, -5.0, 3.0, -1.0, 2.0));
	blockE[2].j[0][2].mA = i8vec3(ivec3(4294967295, 4294967293, 4294967287));
	blockE[2].j[0][2].mB = (mat3x2(3.0, 3.0, 1.0, -5.0, 4.0, -3.0));
	blockE[2].j[0][3].mA = i8vec3(ivec3(4294967294, 8, 9));
	blockE[2].j[0][3].mB = (mat3x2(5.0, 2.0, -1.0, 9.0, 0.0, 7.0));
	blockE[2].j[1][0].mA = i8vec3(ivec3(7, 4294967290, 6));
	blockE[2].j[1][0].mB = (mat3x2(-1.0, -5.0, 6.0, 2.0, -5.0, 3.0));
	blockE[2].j[1][1].mA = i8vec3(ivec3(4294967293, 4294967294, 4294967294));
	blockE[2].j[1][1].mB = (mat3x2(-6.0, -1.0, 5.0, 1.0, -8.0, 1.0));
	blockE[2].j[1][2].mA = i8vec3(ivec3(4, 4294967292, 5));
	blockE[2].j[1][2].mB = (mat3x2(-2.0, -1.0, 3.0, 8.0, 3.0, -5.0));
	blockE[2].j[1][3].mA = i8vec3(ivec3(4294967292, 8, 4294967291));
	blockE[2].j[1][3].mB = (mat3x2(5.0, 5.0, -4.0, 2.0, 7.0, -5.0));
	blockE[2].j[2][0].mA = i8vec3(ivec3(8, 9, 6));
	blockE[2].j[2][0].mB = (mat3x2(-4.0, -8.0, -8.0, -7.0, 9.0, 9.0));
	blockE[2].j[2][1].mA = i8vec3(ivec3(4, 1, 5));
	blockE[2].j[2][1].mB = (mat3x2(-6.0, -3.0, -1.0, 4.0, 3.0, -9.0));
	blockE[2].j[2][2].mA = i8vec3(ivec3(4294967287, 4294967295, 0));
	blockE[2].j[2][2].mB = (mat3x2(7.0, -1.0, -4.0, 6.0, -5.0, -8.0));
	blockE[2].j[2][3].mA = i8vec3(ivec3(6, 0, 4294967295));
	blockE[2].j[2][3].mB = (mat3x2(7.0, -4.0, 7.0, 8.0, 2.0, 1.0));
	blockE[2].j[3][0].mA = i8vec3(ivec3(4294967291, 9, 1));
	blockE[2].j[3][0].mB = (mat3x2(3.0, 3.0, 2.0, 1.0, 6.0, -3.0));
	blockE[2].j[3][1].mA = i8vec3(ivec3(9, 4294967295, 5));
	blockE[2].j[3][1].mB = (mat3x2(-2.0, 3.0, -8.0, -8.0, 8.0, 3.0));
	blockE[2].j[3][2].mA = i8vec3(ivec3(3, 0, 4294967287));
	blockE[2].j[3][2].mB = (mat3x2(-2.0, -3.0, 9.0, -8.0, -2.0, 6.0));
	blockE[2].j[3][3].mA = i8vec3(ivec3(6, 3, 6));
	blockE[2].j[3][3].mB = (mat3x2(9.0, 3.0, 6.0, -2.0, -1.0, 1.0));
	blockE[2].j[4][0].mA = i8vec3(ivec3(4294967287, 0, 2));
	blockE[2].j[4][0].mB = (mat3x2(-7.0, -4.0, 8.0, -5.0, 6.0, 3.0));
	blockE[2].j[4][1].mA = i8vec3(ivec3(4294967292, 7, 4294967293));
	blockE[2].j[4][1].mB = (mat3x2(-7.0, 9.0, -6.0, -7.0, -1.0, 9.0));
	blockE[2].j[4][2].mA = i8vec3(ivec3(1, 0, 9));
	blockE[2].j[4][2].mB = (mat3x2(-1.0, -7.0, 7.0, -3.0, -4.0, -4.0));
	blockE[2].j[4][3].mA = i8vec3(ivec3(4294967289, 4294967292, 4294967290));
	blockE[2].j[4][3].mB = (mat3x2(6.0, -7.0, -8.0, -4.0, 3.0, 4.0));
	blockE[2].j[5][0].mA = i8vec3(ivec3(8, 9, 4294967289));
	blockE[2].j[5][0].mB = (mat3x2(-8.0, -4.0, -8.0, 9.0, -3.0, 9.0));
	blockE[2].j[5][1].mA = i8vec3(ivec3(9, 6, 2));
	blockE[2].j[5][1].mB = (mat3x2(8.0, 8.0, -1.0, -8.0, 8.0, 0.0));
	blockE[2].j[5][2].mA = i8vec3(ivec3(4294967295, 4, 4294967291));
	blockE[2].j[5][2].mB = (mat3x2(2.0, -6.0, 8.0, -9.0, -1.0, 2.0));
	blockE[2].j[5][3].mA = i8vec3(ivec3(7, 4294967292, 4294967293));
	blockE[2].j[5][3].mB = (mat3x2(8.0, -9.0, -8.0, -7.0, -7.0, 9.0));
}
#version 450
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
	lowp mat3x2 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec3 a;
	i8vec2 b;
	lowp uint c;
	sA d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump vec2 e;
	uint8_t f;
	u8vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c), 9u) && allOk;
	allOk = compare_vec2((blockC.e), vec2(6.0, 1.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC.f), 0u) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g[0]), uvec4(2u, 5u, 0u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g[1]), uvec4(2u, 5u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g[2]), uvec4(6u, 2u, 3u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g[3]), uvec4(0u, 4u, 0u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g[4]), uvec4(4u, 0u, 0u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.d[0].mA = (9u);
	blockB.d[0].mB = (mat3x2(-2.0, 5.0, -9.0, -3.0, -1.0, -9.0));
	blockB.d[1].mA = (4u);
	blockB.d[1].mB = (mat3x2(1.0, 1.0, 7.0, 8.0, 9.0, -7.0));
	blockB.d[2].mA = (8u);
	blockB.d[2].mB = (mat3x2(-1.0, -6.0, 5.0, 6.0, 5.0, 6.0));
	blockC.f = uint8_t(3u);
	blockC.g[0] = u8vec4(uvec4(7u, 3u, 2u, 6u));
	blockC.g[1] = u8vec4(uvec4(7u, 0u, 4u, 8u));
	blockC.g[2] = u8vec4(uvec4(1u, 5u, 1u, 5u));
	blockC.g[3] = u8vec4(uvec4(6u, 5u, 5u, 4u));
	blockC.g[4] = u8vec4(uvec4(3u, 5u, 6u, 3u));
}
#version 450
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
	bvec4 a;
	highp uvec2 b;
	mediump uvec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(5u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(0u, 3u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.b = (uvec2(4u, 7u));
	blockB.c = (uvec4(2u, 7u, 2u, 6u));
}
#version 450
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
	lowp uint mA;
	lowp uint mB;
	bvec3 mC;
};
struct sC
{
	u8vec4 mA;
	highp mat3x2 mB;
	bvec3 mC;
	sB mD;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	sA a;
	mediump ivec2 b[][8];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sC c[][3];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec2 d;
	uint8_t e;
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	mediump vec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
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
	allOk = compare_u8vec4(uvec4(blockC.c[0][0].mA), uvec4(4u, 0u, 2u, 1u)) && allOk;
	allOk = compare_mat3x2(blockC.c[0][0].mB, mat3x2(-1.0, -9.0, -6.0, -3.0, -4.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockC.c[0][0].mC), bvec3(true, false, false)) && allOk;
	allOk = compare_uint((blockC.c[0][0].mD.mA), 2u) && allOk;
	allOk = compare_uint((blockC.c[0][0].mD.mB), 8u) && allOk;
	allOk = compare_bvec3((blockC.c[0][0].mD.mC), bvec3(true, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c[0][1].mA), uvec4(5u, 5u, 4u, 3u)) && allOk;
	allOk = compare_mat3x2(blockC.c[0][1].mB, mat3x2(4.0, -1.0, -1.0, -8.0, -3.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockC.c[0][1].mC), bvec3(false, true, false)) && allOk;
	allOk = compare_uint((blockC.c[0][1].mD.mA), 5u) && allOk;
	allOk = compare_uint((blockC.c[0][1].mD.mB), 9u) && allOk;
	allOk = compare_bvec3((blockC.c[0][1].mD.mC), bvec3(true, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c[0][2].mA), uvec4(0u, 1u, 1u, 5u)) && allOk;
	allOk = compare_mat3x2(blockC.c[0][2].mB, mat3x2(-6.0, -4.0, 4.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockC.c[0][2].mC), bvec3(true, false, false)) && allOk;
	allOk = compare_uint((blockC.c[0][2].mD.mA), 9u) && allOk;
	allOk = compare_uint((blockC.c[0][2].mD.mB), 1u) && allOk;
	allOk = compare_bvec3((blockC.c[0][2].mD.mC), bvec3(true, false, false)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c[1][0].mA), uvec4(0u, 1u, 2u, 5u)) && allOk;
	allOk = compare_mat3x2(blockC.c[1][0].mB, mat3x2(-7.0, 0.0, -2.0, -1.0, 8.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockC.c[1][0].mC), bvec3(true, true, true)) && allOk;
	allOk = compare_uint((blockC.c[1][0].mD.mA), 8u) && allOk;
	allOk = compare_uint((blockC.c[1][0].mD.mB), 9u) && allOk;
	allOk = compare_bvec3((blockC.c[1][0].mD.mC), bvec3(false, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c[1][1].mA), uvec4(0u, 5u, 1u, 5u)) && allOk;
	allOk = compare_mat3x2(blockC.c[1][1].mB, mat3x2(-8.0, 1.0, 6.0, -7.0, 9.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockC.c[1][1].mC), bvec3(false, false, true)) && allOk;
	allOk = compare_uint((blockC.c[1][1].mD.mA), 5u) && allOk;
	allOk = compare_uint((blockC.c[1][1].mD.mB), 6u) && allOk;
	allOk = compare_bvec3((blockC.c[1][1].mD.mC), bvec3(false, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c[1][2].mA), uvec4(0u, 9u, 3u, 8u)) && allOk;
	allOk = compare_mat3x2(blockC.c[1][2].mB, mat3x2(-6.0, -4.0, 8.0, 2.0, -7.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockC.c[1][2].mC), bvec3(true, true, false)) && allOk;
	allOk = compare_uint((blockC.c[1][2].mD.mA), 8u) && allOk;
	allOk = compare_uint((blockC.c[1][2].mD.mB), 7u) && allOk;
	allOk = compare_bvec3((blockC.c[1][2].mD.mC), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0][0].mA = u8vec4(uvec4(1u, 4u, 5u, 3u));
	blockC.c[0][0].mB = (mat3x2(3.0, -5.0, -8.0, 4.0, -8.0, 1.0));
	blockC.c[0][0].mC = (bvec3(true, true, true));
	blockC.c[0][0].mD.mA = (0u);
	blockC.c[0][0].mD.mB = (0u);
	blockC.c[0][0].mD.mC = (bvec3(true, true, true));
	blockC.c[0][1].mA = u8vec4(uvec4(9u, 8u, 3u, 8u));
	blockC.c[0][1].mB = (mat3x2(8.0, -7.0, -5.0, 0.0, 0.0, -8.0));
	blockC.c[0][1].mC = (bvec3(false, false, false));
	blockC.c[0][1].mD.mA = (8u);
	blockC.c[0][1].mD.mB = (3u);
	blockC.c[0][1].mD.mC = (bvec3(true, false, false));
	blockC.c[0][2].mA = u8vec4(uvec4(5u, 1u, 2u, 6u));
	blockC.c[0][2].mB = (mat3x2(-3.0, -4.0, 3.0, 7.0, 9.0, -1.0));
	blockC.c[0][2].mC = (bvec3(false, false, true));
	blockC.c[0][2].mD.mA = (9u);
	blockC.c[0][2].mD.mB = (3u);
	blockC.c[0][2].mD.mC = (bvec3(false, false, true));
	blockC.c[1][0].mA = u8vec4(uvec4(6u, 9u, 9u, 6u));
	blockC.c[1][0].mB = (mat3x2(-6.0, 2.0, -6.0, 1.0, 8.0, -2.0));
	blockC.c[1][0].mC = (bvec3(false, true, false));
	blockC.c[1][0].mD.mA = (2u);
	blockC.c[1][0].mD.mB = (9u);
	blockC.c[1][0].mD.mC = (bvec3(true, false, true));
	blockC.c[1][1].mA = u8vec4(uvec4(4u, 4u, 9u, 4u));
	blockC.c[1][1].mB = (mat3x2(4.0, 3.0, 6.0, 1.0, -1.0, -1.0));
	blockC.c[1][1].mC = (bvec3(true, true, false));
	blockC.c[1][1].mD.mA = (3u);
	blockC.c[1][1].mD.mB = (5u);
	blockC.c[1][1].mD.mC = (bvec3(false, true, true));
	blockC.c[1][2].mA = u8vec4(uvec4(7u, 6u, 1u, 4u));
	blockC.c[1][2].mB = (mat3x2(5.0, 0.0, -8.0, -1.0, 6.0, -4.0));
	blockC.c[1][2].mC = (bvec3(true, true, true));
	blockC.c[1][2].mD.mA = (2u);
	blockC.c[1][2].mD.mB = (2u);
	blockC.c[1][2].mD.mC = (bvec3(false, true, true));
	blockD.e = uint8_t(8u);
	blockE.f[0] = (vec4(-8.0, -8.0, 5.0, 0.0));
	blockE.f[1] = (vec4(-4.0, -8.0, -8.0, 5.0));
	blockE.f[2] = (vec4(1.0, -1.0, 0.0, -8.0));
	blockE.f[3] = (vec4(-4.0, 4.0, 4.0, 4.0));
	blockE.f[4] = (vec4(7.0, -4.0, -9.0, -6.0));
	blockE.f[5] = (vec4(-4.0, -4.0, -1.0, -9.0));
}
