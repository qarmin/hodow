#version 450
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
	allOk = compare_mat3(var, mat3(6.0, -1.0, -9.0, 1.0, -6.0, 5.0, 1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-1.0, -1.0, 4.0));
	var[1] = (vec3(-4.0, 0.0, 5.0));
	var[2] = (vec3(5.0, 5.0, -8.0));
}
#version 450
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

	var = (mat3(0.0, 7.0, -3.0, -8.0, 8.0, -8.0, -6.0, 5.0, -2.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-9.0, -8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(4.0, 4.0, 6.0));
	var[1] = (vec3(-7.0, 9.0, -1.0));
	var[2] = (vec3(-5.0, 5.0, 3.0));
}
#version 450
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

	var = (mat2x4(-4.0, 9.0, -1.0, 0.0, 4.0, -8.0, 1.0, 9.0));
}
#version 450
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

	var[0] = (vec2(-5.0, 6.0));
	var[1] = (vec2(4.0, 3.0));
	var[2] = (vec2(-5.0, -6.0));
	var[3] = (vec2(-8.0, -8.0));
}
#version 450
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
	lowp uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec2(6u, 3u));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(3.0, 5.0));
	var[1] = (vec2(-2.0, 7.0));
	var[2] = (vec2(-7.0, 3.0));
	var[3] = (vec2(4.0, -1.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	bool padding;
	bvec2 var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec2((var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var = (bvec2(false, true));
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-7.0, -8.0, -5.0, -7.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0] = (vec3(1.0, 8.0, 1.0));
	var[1] = (vec3(9.0, -4.0, -4.0));
}
#version 450
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

	padding = (9.0);
	var[0] = (vec3(8.0, -3.0, -5.0));
	var[1] = (vec3(9.0, 9.0, -9.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(2.0, -1.0, 0.0, 6.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec3(5.0, -4.0, -7.0));
	var[1] = (vec3(8.0, 5.0, -3.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-6.0, 8.0, -5.0, -4.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var = (mat3x2(-3.0, -6.0, -5.0, -4.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec2(1.0, -5.0));
	var[1] = (vec2(1.0, -4.0));
	var[2] = (vec2(1.0, -1.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 6.0) && allOk;
	allOk = compare_float(var[0][3], 1.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], 6.0) && allOk;
	allOk = compare_float(var[2][0], 0.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], -3.0) && allOk;
	allOk = compare_float(var[2][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(7.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(0.0, -1.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat3x4(-8.0, -1.0, 8.0, 1.0, -5.0, -8.0, -1.0, 2.0, -9.0, -2.0, 8.0, 5.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], -2.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat4x2(7.0, -1.0, -3.0, 6.0, 9.0, -7.0, 5.0, 8.0));
}
#version 450
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

	padding = (9.0);
	var[0] = (vec3(-6.0, -4.0, 9.0));
	var[1] = (vec3(-8.0, -2.0, -1.0));
	var[2] = (vec3(9.0, 8.0, 7.0));
	var[3] = (vec3(4.0, 3.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 2.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-9.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-7.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (vec3(0.0, 6.0, -6.0));
	var[1] = (vec3(-6.0, -2.0, 5.0));
	var[2] = (vec3(4.0, -9.0, -4.0));
	var[3] = (vec3(-2.0, 2.0, 6.0));
}
#version 450
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
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(var), uvec3(3u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(4u);
	var = u8vec3(uvec3(5u, 9u, 6u));
}
#version 450
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
	bvec2 var[3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec2(true, false));
	var[1] = (bvec2(true, true));
	var[2] = (bvec2(false, false));
}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4(var[0], mat4(6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	var[0][1] = (vec4(6.0, 1.0, -6.0, 6.0));
	var[0][2] = (vec4(0.0, -6.0, 3.0, 3.0));
	var[0][3] = (vec4(3.0, -3.0, 2.0, -8.0));
	var[1][0] = (vec4(9.0, -6.0, 6.0, 1.0));
	var[1][1] = (vec4(9.0, -7.0, 4.0, -5.0));
	var[1][2] = (vec4(5.0, -6.0, 5.0, 7.0));
	var[1][3] = (vec4(7.0, -5.0, -9.0, 7.0));
	var[2][0] = (vec4(-2.0, -1.0, -4.0, -3.0));
	var[2][1] = (vec4(3.0, -8.0, 7.0, -8.0));
	var[2][2] = (vec4(-5.0, -9.0, -1.0, 0.0));
	var[2][3] = (vec4(-7.0, 7.0, 8.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	var[0][1] = (vec4(2.0, 7.0, -9.0, -9.0));
	var[1][0] = (vec4(-5.0, 4.0, 7.0, 5.0));
	var[1][1] = (vec4(8.0, -8.0, -8.0, 6.0));
	var[2][0] = (vec4(-3.0, 7.0, 0.0, 4.0));
	var[2][1] = (vec4(6.0, -4.0, 0.0, -5.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

layout(std430, column_major, binding = 1) buffer Block
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

layout(scalar, binding = 1) buffer Block
{
	highp mat4x3 var[];
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
	allOk = compare_mat4x3(var[3], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[3] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[4] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[5] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[6] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[7] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[8] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[9] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[10] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[11] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[12] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[13] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[14] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[15] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[16] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[17] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[18] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
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
	allOk = compare_mat3(var[0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[0][2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[1][0] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[1][1] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[1][2] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[2][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[2][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[2][2] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[3][0] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[3][1] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[3][2] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
}
#version 450
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
	i8vec4 var[4][3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][2]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[0][2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[1][0] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[1][1] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[1][2] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[2][0] = i8vec4(ivec4(8, 5, 4, 5));
	var[2][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[2][2] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[3][0] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[3][1] = i8vec4(ivec4(2, 5, 4, 6));
	var[3][2] = i8vec4(ivec4(4294967292, 7, 8, 9));
}
#version 450
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
	bvec4 var[4][2][3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[0][0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[0][0][2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[0][1][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][1][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][1][2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1][0][1]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((var[1][0][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[1][1][0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[1][1][1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][1][2]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[2][0][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][0][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[2][1][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((var[2][1][1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[2][1][2]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][0][0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][0][1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[3][0][2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][1][0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[3][1][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[3][1][2]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec4(true, true, true, false));
	var[0][0][1] = (bvec4(true, false, false, false));
	var[0][0][2] = (bvec4(false, true, true, true));
	var[0][1][0] = (bvec4(false, true, false, true));
	var[0][1][1] = (bvec4(true, true, true, false));
	var[0][1][2] = (bvec4(false, true, false, false));
	var[1][0][0] = (bvec4(true, true, true, false));
	var[1][0][1] = (bvec4(true, false, true, false));
	var[1][0][2] = (bvec4(true, false, false, true));
	var[1][1][0] = (bvec4(true, false, false, true));
	var[1][1][1] = (bvec4(true, true, true, false));
	var[1][1][2] = (bvec4(true, false, false, false));
	var[2][0][0] = (bvec4(false, true, true, false));
	var[2][0][1] = (bvec4(true, true, true, false));
	var[2][0][2] = (bvec4(false, false, true, true));
	var[2][1][0] = (bvec4(false, false, true, true));
	var[2][1][1] = (bvec4(false, false, true, false));
	var[2][1][2] = (bvec4(true, false, false, true));
	var[3][0][0] = (bvec4(true, false, true, false));
	var[3][0][1] = (bvec4(true, true, true, true));
	var[3][0][2] = (bvec4(false, true, false, true));
	var[3][1][0] = (bvec4(true, false, true, false));
	var[3][1][1] = (bvec4(false, true, false, true));
	var[3][1][2] = (bvec4(false, true, true, true));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[0][0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	var[0][1][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	var[0][1][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	var[0][1][2] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	var[1][0][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	var[1][0][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	var[1][0][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	var[1][1][0] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	var[1][1][1] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	var[1][1][2] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	var[2][0][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	var[2][0][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	var[2][0][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	var[2][1][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	var[2][1][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	var[2][1][2] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	var[3][0][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	var[3][0][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	var[3][0][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	var[3][1][0] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	var[3][1][1] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	var[3][1][2] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
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
	var[0][0][2][0] = (vec2(-8.0, 5.0));
	var[0][0][2][1] = (vec2(6.0, -8.0));
	var[0][0][2][2] = (vec2(-8.0, 3.0));
	var[0][0][2][3] = (vec2(2.0, 8.0));
	var[0][1][0][0] = (vec2(-9.0, -3.0));
	var[0][1][0][1] = (vec2(5.0, -5.0));
	var[0][1][0][2] = (vec2(3.0, 4.0));
	var[0][1][0][3] = (vec2(-9.0, 1.0));
	var[0][1][1][0] = (vec2(0.0, 8.0));
	var[0][1][1][1] = (vec2(-8.0, 3.0));
	var[0][1][1][2] = (vec2(-7.0, 9.0));
	var[0][1][1][3] = (vec2(-8.0, -7.0));
	var[0][1][2][0] = (vec2(7.0, 1.0));
	var[0][1][2][1] = (vec2(-1.0, -2.0));
	var[0][1][2][2] = (vec2(-8.0, -3.0));
	var[0][1][2][3] = (vec2(9.0, -1.0));
	var[1][0][0][0] = (vec2(-8.0, -1.0));
	var[1][0][0][1] = (vec2(-3.0, 0.0));
	var[1][0][0][2] = (vec2(7.0, 5.0));
	var[1][0][0][3] = (vec2(-8.0, 5.0));
	var[1][0][1][0] = (vec2(7.0, 8.0));
	var[1][0][1][1] = (vec2(4.0, -2.0));
	var[1][0][1][2] = (vec2(4.0, -2.0));
	var[1][0][1][3] = (vec2(-2.0, 9.0));
	var[1][0][2][0] = (vec2(4.0, -4.0));
	var[1][0][2][1] = (vec2(-5.0, -5.0));
	var[1][0][2][2] = (vec2(-6.0, 8.0));
	var[1][0][2][3] = (vec2(9.0, -5.0));
	var[1][1][0][0] = (vec2(-2.0, 1.0));
	var[1][1][0][1] = (vec2(-8.0, -7.0));
	var[1][1][0][2] = (vec2(-5.0, 7.0));
	var[1][1][0][3] = (vec2(-5.0, -7.0));
	var[1][1][1][0] = (vec2(-5.0, 2.0));
	var[1][1][1][1] = (vec2(-4.0, 8.0));
	var[1][1][1][2] = (vec2(-7.0, 6.0));
	var[1][1][1][3] = (vec2(5.0, 2.0));
	var[1][1][2][0] = (vec2(-5.0, 3.0));
	var[1][1][2][1] = (vec2(-9.0, 7.0));
	var[1][1][2][2] = (vec2(-3.0, -3.0));
	var[1][1][2][3] = (vec2(-7.0, -4.0));
	var[2][0][0][0] = (vec2(-2.0, 1.0));
	var[2][0][0][1] = (vec2(6.0, -2.0));
	var[2][0][0][2] = (vec2(2.0, -5.0));
	var[2][0][0][3] = (vec2(3.0, -3.0));
	var[2][0][1][0] = (vec2(-6.0, -4.0));
	var[2][0][1][1] = (vec2(-6.0, -7.0));
	var[2][0][1][2] = (vec2(9.0, 1.0));
	var[2][0][1][3] = (vec2(-4.0, 3.0));
	var[2][0][2][0] = (vec2(7.0, -9.0));
	var[2][0][2][1] = (vec2(7.0, -4.0));
	var[2][0][2][2] = (vec2(8.0, -2.0));
	var[2][0][2][3] = (vec2(9.0, 0.0));
	var[2][1][0][0] = (vec2(3.0, 7.0));
	var[2][1][0][1] = (vec2(-6.0, -7.0));
	var[2][1][0][2] = (vec2(-7.0, 5.0));
	var[2][1][0][3] = (vec2(-8.0, 4.0));
	var[2][1][1][0] = (vec2(4.0, -5.0));
	var[2][1][1][1] = (vec2(-6.0, -9.0));
	var[2][1][1][2] = (vec2(7.0, 7.0));
	var[2][1][1][3] = (vec2(-2.0, 6.0));
	var[2][1][2][0] = (vec2(1.0, -9.0));
	var[2][1][2][1] = (vec2(7.0, 6.0));
	var[2][1][2][2] = (vec2(-4.0, 2.0));
	var[2][1][2][3] = (vec2(1.0, 5.0));
	var[3][0][0][0] = (vec2(-9.0, 7.0));
	var[3][0][0][1] = (vec2(1.0, 4.0));
	var[3][0][0][2] = (vec2(-7.0, 9.0));
	var[3][0][0][3] = (vec2(-5.0, 2.0));
	var[3][0][1][0] = (vec2(-9.0, -3.0));
	var[3][0][1][1] = (vec2(-8.0, 5.0));
	var[3][0][1][2] = (vec2(-2.0, -8.0));
	var[3][0][1][3] = (vec2(7.0, -6.0));
	var[3][0][2][0] = (vec2(-7.0, 1.0));
	var[3][0][2][1] = (vec2(-3.0, 7.0));
	var[3][0][2][2] = (vec2(6.0, -5.0));
	var[3][0][2][3] = (vec2(9.0, -2.0));
	var[3][1][0][0] = (vec2(-8.0, -6.0));
	var[3][1][0][1] = (vec2(-6.0, 4.0));
	var[3][1][0][2] = (vec2(4.0, 7.0));
	var[3][1][0][3] = (vec2(-7.0, -9.0));
	var[3][1][1][0] = (vec2(7.0, -6.0));
	var[3][1][1][1] = (vec2(8.0, -8.0));
	var[3][1][1][2] = (vec2(-6.0, -7.0));
	var[3][1][1][3] = (vec2(-4.0, -2.0));
	var[3][1][2][0] = (vec2(-9.0, 9.0));
	var[3][1][2][1] = (vec2(4.0, -6.0));
	var[3][1][2][2] = (vec2(2.0, 3.0));
	var[3][1][2][3] = (vec2(6.0, 8.0));
}
#version 450
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
	highp uint var[4][2][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 3u) && allOk;
	allOk = compare_uint((var[0][0][0]), 6u) && allOk;
	allOk = compare_uint((var[0][0][1]), 9u) && allOk;
	allOk = compare_uint((var[0][0][2]), 0u) && allOk;
	allOk = compare_uint((var[0][1][0]), 8u) && allOk;
	allOk = compare_uint((var[0][1][1]), 6u) && allOk;
	allOk = compare_uint((var[0][1][2]), 9u) && allOk;
	allOk = compare_uint((var[1][0][0]), 3u) && allOk;
	allOk = compare_uint((var[1][0][1]), 7u) && allOk;
	allOk = compare_uint((var[1][0][2]), 6u) && allOk;
	allOk = compare_uint((var[1][1][0]), 0u) && allOk;
	allOk = compare_uint((var[1][1][1]), 1u) && allOk;
	allOk = compare_uint((var[1][1][2]), 4u) && allOk;
	allOk = compare_uint((var[2][0][0]), 4u) && allOk;
	allOk = compare_uint((var[2][0][1]), 2u) && allOk;
	allOk = compare_uint((var[2][0][2]), 5u) && allOk;
	allOk = compare_uint((var[2][1][0]), 8u) && allOk;
	allOk = compare_uint((var[2][1][1]), 7u) && allOk;
	allOk = compare_uint((var[2][1][2]), 9u) && allOk;
	allOk = compare_uint((var[3][0][0]), 7u) && allOk;
	allOk = compare_uint((var[3][0][1]), 5u) && allOk;
	allOk = compare_uint((var[3][0][2]), 7u) && allOk;
	allOk = compare_uint((var[3][1][0]), 7u) && allOk;
	allOk = compare_uint((var[3][1][1]), 7u) && allOk;
	allOk = compare_uint((var[3][1][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7u);
	var[0][0][0] = (9u);
	var[0][0][1] = (1u);
	var[0][0][2] = (0u);
	var[0][1][0] = (8u);
	var[0][1][1] = (6u);
	var[0][1][2] = (1u);
	var[1][0][0] = (7u);
	var[1][0][1] = (7u);
	var[1][0][2] = (4u);
	var[1][1][0] = (9u);
	var[1][1][1] = (8u);
	var[1][1][2] = (6u);
	var[2][0][0] = (8u);
	var[2][0][1] = (7u);
	var[2][0][2] = (5u);
	var[2][1][0] = (8u);
	var[2][1][1] = (6u);
	var[2][1][2] = (2u);
	var[3][0][0] = (7u);
	var[3][0][1] = (2u);
	var[3][0][2] = (7u);
	var[3][1][0] = (5u);
	var[3][1][1] = (3u);
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-9.0, 9.0, -5.0, 9.0, -3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-6.0, 7.0, 6.0, -8.0, 7.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-7.0, 0.0, -1.0, 6.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-3.0, -5.0, -2.0, -9.0, 3.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-6.0, -2.0, -3.0, -3.0, -9.0, 4.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(4.0, -9.0));
	var[0][0][0][1] = (vec2(-2.0, 8.0));
	var[0][0][0][2] = (vec2(-4.0, 4.0));
	var[0][0][0][3] = (vec2(9.0, 5.0));
	var[0][0][1][0] = (vec2(-2.0, 4.0));
	var[0][0][1][1] = (vec2(6.0, -8.0));
	var[0][0][1][2] = (vec2(-5.0, -1.0));
	var[0][0][1][3] = (vec2(9.0, 0.0));
	var[0][1][0][0] = (vec2(6.0, 4.0));
	var[0][1][0][1] = (vec2(5.0, 2.0));
	var[0][1][0][2] = (vec2(6.0, -4.0));
	var[0][1][0][3] = (vec2(-4.0, 8.0));
	var[0][1][1][0] = (vec2(5.0, -1.0));
	var[0][1][1][1] = (vec2(7.0, 0.0));
	var[0][1][1][2] = (vec2(-7.0, -4.0));
	var[0][1][1][3] = (vec2(1.0, -1.0));
	var[0][2][0][0] = (vec2(-8.0, 0.0));
	var[0][2][0][1] = (vec2(-4.0, 6.0));
	var[0][2][0][2] = (vec2(-7.0, 4.0));
	var[0][2][0][3] = (vec2(-6.0, -5.0));
	var[0][2][1][0] = (vec2(-2.0, 7.0));
	var[0][2][1][1] = (vec2(-3.0, 0.0));
	var[0][2][1][2] = (vec2(-8.0, -9.0));
	var[0][2][1][3] = (vec2(6.0, 0.0));
	var[0][3][0][0] = (vec2(6.0, 5.0));
	var[0][3][0][1] = (vec2(3.0, 5.0));
	var[0][3][0][2] = (vec2(2.0, 5.0));
	var[0][3][0][3] = (vec2(-8.0, 8.0));
	var[0][3][1][0] = (vec2(-9.0, 3.0));
	var[0][3][1][1] = (vec2(-5.0, 3.0));
	var[0][3][1][2] = (vec2(3.0, 5.0));
	var[0][3][1][3] = (vec2(9.0, -6.0));
	var[1][0][0][0] = (vec2(5.0, -2.0));
	var[1][0][0][1] = (vec2(4.0, -5.0));
	var[1][0][0][2] = (vec2(-2.0, -4.0));
	var[1][0][0][3] = (vec2(6.0, 4.0));
	var[1][0][1][0] = (vec2(5.0, 5.0));
	var[1][0][1][1] = (vec2(-6.0, -5.0));
	var[1][0][1][2] = (vec2(7.0, -6.0));
	var[1][0][1][3] = (vec2(8.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -6.0));
	var[1][1][0][1] = (vec2(9.0, -9.0));
	var[1][1][0][2] = (vec2(7.0, -8.0));
	var[1][1][0][3] = (vec2(5.0, -4.0));
	var[1][1][1][0] = (vec2(4.0, 3.0));
	var[1][1][1][1] = (vec2(9.0, 1.0));
	var[1][1][1][2] = (vec2(-6.0, -3.0));
	var[1][1][1][3] = (vec2(-7.0, 9.0));
	var[1][2][0][0] = (vec2(6.0, -7.0));
	var[1][2][0][1] = (vec2(2.0, 3.0));
	var[1][2][0][2] = (vec2(-4.0, -6.0));
	var[1][2][0][3] = (vec2(5.0, -1.0));
	var[1][2][1][0] = (vec2(-8.0, 7.0));
	var[1][2][1][1] = (vec2(0.0, 0.0));
	var[1][2][1][2] = (vec2(-7.0, -3.0));
	var[1][2][1][3] = (vec2(-7.0, -3.0));
	var[1][3][0][0] = (vec2(4.0, -3.0));
	var[1][3][0][1] = (vec2(-1.0, 3.0));
	var[1][3][0][2] = (vec2(0.0, 0.0));
	var[1][3][0][3] = (vec2(-4.0, 6.0));
	var[1][3][1][0] = (vec2(-3.0, 9.0));
	var[1][3][1][1] = (vec2(-9.0, 4.0));
	var[1][3][1][2] = (vec2(0.0, 1.0));
	var[1][3][1][3] = (vec2(4.0, 4.0));
	var[2][0][0][0] = (vec2(5.0, -5.0));
	var[2][0][0][1] = (vec2(-6.0, -3.0));
	var[2][0][0][2] = (vec2(-1.0, -1.0));
	var[2][0][0][3] = (vec2(-2.0, 6.0));
	var[2][0][1][0] = (vec2(-1.0, -8.0));
	var[2][0][1][1] = (vec2(-5.0, 5.0));
	var[2][0][1][2] = (vec2(5.0, 9.0));
	var[2][0][1][3] = (vec2(-7.0, 0.0));
	var[2][1][0][0] = (vec2(3.0, 5.0));
	var[2][1][0][1] = (vec2(3.0, -7.0));
	var[2][1][0][2] = (vec2(0.0, 6.0));
	var[2][1][0][3] = (vec2(-8.0, -2.0));
	var[2][1][1][0] = (vec2(7.0, -6.0));
	var[2][1][1][1] = (vec2(2.0, -2.0));
	var[2][1][1][2] = (vec2(8.0, 8.0));
	var[2][1][1][3] = (vec2(1.0, -3.0));
	var[2][2][0][0] = (vec2(2.0, 6.0));
	var[2][2][0][1] = (vec2(3.0, 3.0));
	var[2][2][0][2] = (vec2(-8.0, -2.0));
	var[2][2][0][3] = (vec2(-4.0, 0.0));
	var[2][2][1][0] = (vec2(2.0, 5.0));
	var[2][2][1][1] = (vec2(2.0, 3.0));
	var[2][2][1][2] = (vec2(-3.0, 2.0));
	var[2][2][1][3] = (vec2(4.0, 1.0));
	var[2][3][0][0] = (vec2(9.0, -8.0));
	var[2][3][0][1] = (vec2(-6.0, 2.0));
	var[2][3][0][2] = (vec2(-2.0, -9.0));
	var[2][3][0][3] = (vec2(-4.0, 6.0));
	var[2][3][1][0] = (vec2(1.0, 7.0));
	var[2][3][1][1] = (vec2(-8.0, -1.0));
	var[2][3][1][2] = (vec2(8.0, 4.0));
	var[2][3][1][3] = (vec2(7.0, -3.0));
}
#version 450
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
	u8vec3 var[][4][2];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0][0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][3][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][3][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][0]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][1]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][1]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2][0]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][3][0]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][3][1]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][0]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][1]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][0]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2][0]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2][1]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][3][0]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][3][1]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	var[0][1][0] = u8vec3(uvec3(5u, 4u, 7u));
	var[0][1][1] = u8vec3(uvec3(0u, 0u, 5u));
	var[0][2][0] = u8vec3(uvec3(5u, 7u, 3u));
	var[0][2][1] = u8vec3(uvec3(9u, 8u, 1u));
	var[0][3][0] = u8vec3(uvec3(3u, 6u, 6u));
	var[0][3][1] = u8vec3(uvec3(2u, 7u, 9u));
	var[1][0][0] = u8vec3(uvec3(7u, 1u, 5u));
	var[1][0][1] = u8vec3(uvec3(1u, 7u, 9u));
	var[1][1][0] = u8vec3(uvec3(2u, 5u, 5u));
	var[1][1][1] = u8vec3(uvec3(5u, 9u, 6u));
	var[1][2][0] = u8vec3(uvec3(6u, 2u, 7u));
	var[1][2][1] = u8vec3(uvec3(0u, 2u, 7u));
	var[1][3][0] = u8vec3(uvec3(4u, 0u, 2u));
	var[1][3][1] = u8vec3(uvec3(1u, 5u, 4u));
	var[2][0][0] = u8vec3(uvec3(3u, 4u, 3u));
	var[2][0][1] = u8vec3(uvec3(5u, 7u, 4u));
	var[2][1][0] = u8vec3(uvec3(9u, 7u, 3u));
	var[2][1][1] = u8vec3(uvec3(9u, 4u, 9u));
	var[2][2][0] = u8vec3(uvec3(4u, 8u, 8u));
	var[2][2][1] = u8vec3(uvec3(6u, 1u, 2u));
	var[2][3][0] = u8vec3(uvec3(3u, 7u, 7u));
	var[2][3][1] = u8vec3(uvec3(3u, 8u, 8u));
}
#version 450
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
	allOk = compare_uvec2((s[0].a), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(-1.0, 8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(5.0, 2.0, 6.0, -8.0, 2.0, 1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(-9.0, 7.0, 4.0, 0.0, 7.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(6.0, 4.0, 8.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(9.0, -2.0, -1.0, -7.0, -7.0, 6.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(2.0, 5.0, -4.0, 3.0, -4.0, 7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(4.0, 7.0, -7.0, 6.0, 8.0, 9.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(0.0, -2.0, 6.0, 8.0, 7.0, 1.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(-8.0, 0.0, -7.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(1.0, 3.0, -6.0, -1.0, 3.0, -9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(6.0, 9.0, 5.0, 9.0, -7.0, -8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(-1.0, 1.0, 3.0, 9.0, -8.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(-3.0, -3.0, 4.0, 4.0, 8.0, 6.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(-2.0, 7.0, 0.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(0u, 1u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(-3.0, 8.0, -7.0, -5.0, 4.0, -9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(9.0, 2.0, -3.0, -8.0, -7.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(1.0, -1.0, 3.0, 2.0, 4.0, -7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(9.0, 8.0, -9.0, -8.0, 6.0, 7.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(7.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (1u);
	s[0].a = (uvec2(9u, 7u));
	s[0].b[0] = (mat2x4(3.0, -9.0, 6.0, 9.0, 2.0, -1.0, -2.0, 5.0));
	s[0].b[1] = (mat2x4(9.0, -5.0, -8.0, -7.0, -6.0, -9.0, 0.0, 9.0));
	s[0].b[2] = (mat2x4(-1.0, 1.0, -8.0, 9.0, 7.0, 8.0, -1.0, 0.0));
	s[0].b[3] = (mat2x4(7.0, -1.0, -6.0, -7.0, 7.0, 6.0, 8.0, 2.0));
	s[0].c = (vec3(0.0, 7.0, 8.0));
	s[1].a = (uvec2(2u, 9u));
	s[1].b[0] = (mat2x4(-4.0, 5.0, 4.0, 1.0, -4.0, -8.0, 4.0, -2.0));
	s[1].b[1] = (mat2x4(3.0, -8.0, -4.0, -3.0, -7.0, 1.0, -1.0, 4.0));
	s[1].b[2] = (mat2x4(0.0, -5.0, 8.0, -1.0, 3.0, -9.0, 4.0, 4.0));
	s[1].b[3] = (mat2x4(-5.0, -1.0, 9.0, 5.0, 4.0, -5.0, 9.0, -4.0));
	s[1].c = (vec3(-5.0, -1.0, -4.0));
	s[2].a = (uvec2(2u, 0u));
	s[2].b[0] = (mat2x4(7.0, -8.0, -6.0, 4.0, 5.0, -3.0, 3.0, 5.0));
	s[2].b[1] = (mat2x4(4.0, -6.0, -4.0, -2.0, -6.0, 4.0, 5.0, -8.0));
	s[2].b[2] = (mat2x4(-8.0, 6.0, -2.0, -6.0, 3.0, -4.0, -1.0, -1.0));
	s[2].b[3] = (mat2x4(-9.0, 1.0, 8.0, 2.0, 0.0, 4.0, -8.0, 1.0));
	s[2].c = (vec3(4.0, 1.0, -1.0));
	s[3].a = (uvec2(3u, 1u));
	s[3].b[0] = (mat2x4(-9.0, -1.0, -7.0, -2.0, -6.0, -2.0, -3.0, 4.0));
	s[3].b[1] = (mat2x4(9.0, -1.0, 3.0, -7.0, 6.0, -4.0, 9.0, -8.0));
	s[3].b[2] = (mat2x4(9.0, -7.0, -3.0, -9.0, 4.0, 9.0, -5.0, -3.0));
	s[3].b[3] = (mat2x4(-3.0, 0.0, 0.0, -2.0, -9.0, 0.0, -3.0, 6.0));
	s[3].c = (vec3(9.0, -2.0, 6.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s[0][0].a), ivec3(6, -3, 7)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(-2.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(9, 1, -6)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(-1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(5, -8, 9)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(-4.0, 7.0, 5.0, -8.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(4, -9, 3)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(-4.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(8, 2, -7)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(-7, -4, -4)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(-6.0, 3.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(-9.0, 6.0, -6.0, -2.0));
	s[0][0].a = (ivec3(4, -5, -9));
	s[0][0].c = (vec4(-7.0, 9.0, 9.0, -1.0));
	s[0][1].a = (ivec3(-1, -1, -7));
	s[0][1].c = (vec4(-6.0, 1.0, -5.0, 9.0));
	s[1][0].a = (ivec3(-7, -1, 2));
	s[1][0].c = (vec4(-4.0, 4.0, -4.0, 9.0));
	s[1][1].a = (ivec3(-3, 6, -5));
	s[1][1].c = (vec4(1.0, 4.0, -5.0, -1.0));
	s[2][0].a = (ivec3(2, -5, 0));
	s[2][0].c = (vec4(8.0, 0.0, -8.0, -7.0));
	s[2][1].a = (ivec3(4, -9, 3));
	s[2][1].c = (vec4(8.0, -9.0, 7.0, -4.0));
}
#version 450
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
} block[3];

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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block[0].var, mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-2.0, 1.0));
	block[0].var[1] = (vec2(-7.0, -1.0));
	block[1].var[0] = (vec2(5.0, -3.0));
	block[1].var[1] = (vec2(4.0, 8.0));
	block[2].var[0] = (vec2(-2.0, -6.0));
	block[2].var[1] = (vec2(-5.0, -1.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	i16vec3 var;
} block[3];

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

layout(scalar, binding = 1) buffer Block
{
	uint padding;
	highp uvec4 var;
} block[3];

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].padding), 4u) && allOk;
	allOk = compare_uvec4((block[0].var), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uint((block[1].padding), 9u) && allOk;
	allOk = compare_uvec4((block[1].var), uvec4(5u, 9u, 3u, 6u)) && allOk;
	allOk = compare_uint((block[2].padding), 5u) && allOk;
	allOk = compare_uvec4((block[2].var), uvec4(1u, 2u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2u);
	block[0].var = (uvec4(7u, 2u, 9u, 7u));
	block[1].padding = (9u);
	block[1].var = (uvec4(5u, 1u, 3u, 4u));
	block[2].padding = (4u);
	block[2].var = (uvec4(2u, 0u, 5u, 6u));
}
#version 450
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
	i16vec2 var;
} block[3];

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block[0].padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(block[0].var), ivec2(-1, 8)) && allOk;
	allOk = compare_int16_t(int(block[1].padding), -3) && allOk;
	allOk = compare_i16vec2(ivec2(block[1].var), ivec2(-4, 2)) && allOk;
	allOk = compare_int16_t(int(block[2].padding), -1) && allOk;
	allOk = compare_i16vec2(ivec2(block[2].var), ivec2(-3, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int16_t(6);
	block[0].var = i16vec2(ivec2(-2, -2));
	block[1].padding = int16_t(-8);
	block[1].var = i16vec2(ivec2(3, 5));
	block[2].padding = int16_t(-9);
	block[2].var = i16vec2(ivec2(-9, -4));
}
#version 450
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
	bvec3 a;
	highp uvec2 b;
	bool c;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((b), uvec2(9u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, false, true));
}
#version 450
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
	highp mat3x2 mA;
	mediump mat4x2 mB;
};
layout(std430, binding = 1) readonly buffer BlockB
{
	sA a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a[0].mA, mat3x2(1.0, -5.0, -9.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(a[0].mB, mat4x2(1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 a;
	mediump float b;
	lowp uvec2 c;
	bool d;
	lowp float e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat4x2 f;
	lowp mat2x3 g;
	bool h;
	bvec3 i[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b), -1.0) && allOk;
	allOk = compare_uvec2((c), uvec2(5u, 7u)) && allOk;
	allOk = compare_bool((d), false) && allOk;
	allOk = compare_float((e[0]), 2.0) && allOk;
	allOk = compare_float((e[1]), 3.0) && allOk;
	allOk = compare_float((e[2]), -6.0) && allOk;
	allOk = compare_float((e[3]), -4.0) && allOk;
	allOk = compare_float((e[4]), -6.0) && allOk;
	allOk = compare_float((e[5]), -3.0) && allOk;
	allOk = compare_float((e[6]), -1.0) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(4.0, 5.0, 8.0, -8.0, -1.0, -6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.g, mat2x3(-1.0, -3.0, -8.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_bool((blockC.h), true) && allOk;
	allOk = compare_bvec3((blockC.i[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.i[1]), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(6.0, 0.0, 5.0, 1.0));
	b = (-7.0);
	c = (uvec2(2u, 9u));
	d = (false);
	e[0] = (-9.0);
	e[1] = (8.0);
	e[2] = (0.0);
	e[3] = (-8.0);
	e[4] = (-9.0);
	e[5] = (5.0);
	e[6] = (4.0);
	blockC.f = (mat4x2(-2.0, 3.0, -5.0, -5.0, 5.0, 0.0, -6.0, -9.0));
	blockC.g = (mat2x3(3.0, -1.0, 2.0, -9.0, 6.0, 7.0));
	blockC.h = (true);
	blockC.i[0] = (bvec3(true, false, true));
	blockC.i[1] = (bvec3(true, true, true));
}
#version 450
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
	highp uvec2 a;
	highp ivec2 b;
	lowp vec2 c[3];
	mediump uvec3 d[7];
	highp vec3 e[];
};
layout(std430, binding = 2) buffer BlockC
{
	bool f;
	mediump int g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((b), ivec2(-9, 7)) && allOk;
	allOk = compare_uvec3((d[0]), uvec3(7u, 3u, 9u)) && allOk;
	allOk = compare_uvec3((d[1]), uvec3(3u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((d[2]), uvec3(5u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((d[3]), uvec3(6u, 2u, 5u)) && allOk;
	allOk = compare_uvec3((d[4]), uvec3(3u, 0u, 0u)) && allOk;
	allOk = compare_uvec3((d[5]), uvec3(8u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((d[6]), uvec3(7u, 1u, 0u)) && allOk;
	allOk = compare_vec3((e[0]), vec3(2.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3((e[1]), vec3(1.0, 2.0, -3.0)) && allOk;
	allOk = compare_int((blockC.g), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (vec2(-1.0, 3.0));
	c[1] = (vec2(-7.0, -7.0));
	c[2] = (vec2(6.0, 0.0));
	d[0] = (uvec3(9u, 7u, 9u));
	d[1] = (uvec3(0u, 4u, 0u));
	d[2] = (uvec3(0u, 6u, 5u));
	d[3] = (uvec3(7u, 9u, 9u));
	d[4] = (uvec3(4u, 0u, 7u));
	d[5] = (uvec3(2u, 8u, 2u));
	d[6] = (uvec3(4u, 0u, 3u));
	blockC.g = (-3);
}
#version 450
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
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) bvec3 c;
	layout(offset = 44) bool d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump int e[1];
	layout(offset = 16) lowp vec4 f;
	layout(offset = 32) mediump ivec4 g;
	layout(offset = 48) bvec3 h;
	layout(offset = 64) lowp vec3 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 1.0) && allOk;
	allOk = compare_vec4((blockB.b), vec4(-6.0, -5.0, 7.0, 2.0)) && allOk;
	allOk = compare_int((e[0]), 3) && allOk;
	allOk = compare_vec4((f), vec4(8.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_ivec4((g), ivec4(-4, 1, -4, -4)) && allOk;
	allOk = compare_bvec3((h), bvec3(false, false, true)) && allOk;
	allOk = compare_vec3((i), vec3(9.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (bvec3(true, true, false));
	blockB.d = (false);
	e[0] = (0);
	f = (vec4(0.0, 6.0, -6.0, -5.0));
	g = (ivec4(2, 3, 0, 4));
	h = (bvec3(true, true, true));
}
#version 450
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
	layout(offset = 16) highp uvec4 b;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec2 c;
	layout(offset = 8) lowp uvec2 d[1];
	layout(offset = 16) highp ivec3 e;
	layout(offset = 28) highp int f;
	layout(offset = 32) highp float g;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uvec3 h;
	layout(offset = 16) lowp ivec2 i;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec3 j[1];
	layout(offset = 16) highp uvec4 k;
	layout(offset = 32) mediump uvec4 l;
	layout(offset = 48) lowp int m;
	layout(offset = 52) highp vec3 n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec2((d[0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_int((f), 5) && allOk;
	allOk = compare_float((g), 8.0) && allOk;
	allOk = compare_ivec2((blockD.i), ivec2(6, 2)) && allOk;
	allOk = compare_bvec3((j[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec4((k), uvec4(7u, 9u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((l), uvec4(5u, 7u, 2u, 4u)) && allOk;
	allOk = compare_int((m), 6) && allOk;
	allOk = compare_vec3((n), vec3(7.0, 5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, false, false));
	blockB[0].b = (uvec4(3u, 8u, 3u, 7u));
	c = (ivec2(6, 7));
	d[0] = (uvec2(8u, 3u));
	e = (ivec3(-2, 7, 4));
	f = (7);
	g = (0.0);
	blockD.h = (uvec3(6u, 4u, 7u));
	blockD.i = (ivec2(4, 9));
	j[0] = (bvec3(false, true, false));
	k = (uvec4(0u, 5u, 4u, 6u));
	m = (-7);
	n = (vec3(-1.0, 4.0, -7.0));
}
#version 450
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
	lowp float mB;
	lowp uvec4 mC;
	mediump uvec4 mD;
};
struct sB
{
	highp mat4x2 mA;
	highp int mB;
	sA mC;
	mediump vec2 mD;
};
struct sC
{
	mediump mat4x3 mA;
	mediump mat4 mB;
};
struct sD
{
	mediump mat4 mA;
	sC mB;
	mediump mat3x2 mC;
	mediump int mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sB a;
	mediump float b;
	bool c;
	sD d[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp mat4x3 e;
	mediump mat4x3 f;
	mediump uvec2 g;
	lowp mat4x2 h[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a.mA, mat4x2(-6.0, -5.0, 3.0, -9.0, -7.0, 9.0, -5.0, 0.0)) && allOk;
	allOk = compare_int((blockB.a.mB), -5) && allOk;
	allOk = compare_mat4(blockB.a.mC.mA, mat4(-1.0, 2.0, -2.0, 4.0, 6.0, 8.0, 2.0, -6.0, -8.0, 6.0, -4.0, 2.0, -2.0, 5.0, 0.0, 9.0)) && allOk;
	allOk = compare_float((blockB.a.mC.mB), -5.0) && allOk;
	allOk = compare_uvec4((blockB.a.mC.mC), uvec4(9u, 6u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a.mC.mD), uvec4(2u, 8u, 2u, 4u)) && allOk;
	allOk = compare_vec2((blockB.a.mD), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_float((blockB.b), 4.0) && allOk;
	allOk = compare_mat4(blockB.d[0].mA, mat4(1.0, -1.0, 8.0, 0.0, 7.0, -1.0, -7.0, 9.0, 5.0, 5.0, 9.0, -9.0, 5.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[0].mB.mA, mat4x3(3.0, 2.0, -9.0, -8.0, -9.0, -2.0, -1.0, 1.0, -9.0, -7.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB.d[0].mB.mB, mat4(-9.0, 5.0, -3.0, -6.0, 3.0, 1.0, 4.0, -1.0, -4.0, 6.0, 3.0, 5.0, -8.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0].mC, mat3x2(5.0, -4.0, 1.0, 8.0, -3.0, -1.0)) && allOk;
	allOk = compare_int((blockB.d[0].mD), -8) && allOk;
	allOk = compare_mat4(blockB.d[1].mA, mat4(9.0, -7.0, 6.0, -5.0, -5.0, 1.0, -3.0, 4.0, -4.0, -8.0, -4.0, 8.0, 4.0, 4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[1].mB.mA, mat4x3(1.0, 7.0, -3.0, 2.0, -7.0, -2.0, 4.0, 9.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.d[1].mB.mB, mat4(-6.0, 7.0, -3.0, 8.0, -1.0, 2.0, 2.0, -4.0, 4.0, 7.0, -4.0, 3.0, -2.0, -1.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1].mC, mat3x2(6.0, 7.0, -7.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_int((blockB.d[1].mD), 0) && allOk;
	allOk = compare_mat4(blockB.d[2].mA, mat4(2.0, 3.0, 5.0, -9.0, -5.0, -6.0, 1.0, -1.0, 1.0, 6.0, 5.0, 3.0, 2.0, 6.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[2].mB.mA, mat4x3(6.0, -3.0, -7.0, -8.0, 6.0, 8.0, -8.0, -7.0, -7.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB.d[2].mB.mB, mat4(0.0, -2.0, 3.0, -1.0, -5.0, -5.0, 3.0, 0.0, -9.0, -5.0, -8.0, 6.0, 4.0, -5.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[2].mC, mat3x2(-3.0, 0.0, 2.0, 8.0, -3.0, -1.0)) && allOk;
	allOk = compare_int((blockB.d[2].mD), -6) && allOk;
	allOk = compare_mat4(blockB.d[3].mA, mat4(-8.0, 4.0, 0.0, -4.0, 8.0, -2.0, -5.0, -8.0, -4.0, -7.0, 6.0, 6.0, 3.0, -7.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[3].mB.mA, mat4x3(-8.0, -5.0, 4.0, -4.0, 2.0, -4.0, 8.0, 4.0, 4.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB.d[3].mB.mB, mat4(5.0, 3.0, 9.0, -5.0, -9.0, -7.0, -1.0, 8.0, -2.0, 3.0, -3.0, 9.0, -5.0, 5.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[3].mC, mat3x2(2.0, 6.0, 1.0, 6.0, 3.0, 3.0)) && allOk;
	allOk = compare_int((blockB.d[3].mD), 3) && allOk;
	allOk = compare_mat4(blockB.d[4].mA, mat4(0.0, 4.0, 8.0, -8.0, -5.0, 1.0, 7.0, -2.0, -4.0, 7.0, -2.0, 2.0, 9.0, -8.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[4].mB.mA, mat4x3(8.0, 0.0, 1.0, 5.0, 8.0, -1.0, -7.0, 4.0, -4.0, 2.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB.d[4].mB.mB, mat4(-6.0, 2.0, -8.0, 5.0, -7.0, 3.0, 6.0, 6.0, -5.0, -1.0, -6.0, -6.0, 1.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[4].mC, mat3x2(-8.0, 9.0, -3.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_int((blockB.d[4].mD), 7) && allOk;
	allOk = compare_mat4x3(blockC[0].f, mat4x3(6.0, -5.0, 3.0, -3.0, 0.0, 5.0, -8.0, -1.0, 6.0, -8.0, -9.0, 1.0)) && allOk;
	allOk = compare_uvec2((blockC[0].g), uvec2(8u, 9u)) && allOk;
	allOk = compare_mat4x2(blockC[0].h[0], mat4x2(-5.0, -5.0, 4.0, 9.0, -9.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].h[1], mat4x2(4.0, 0.0, 5.0, 5.0, 4.0, -8.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].h[2], mat4x2(-6.0, -5.0, -8.0, -2.0, -1.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].h[3], mat4x2(-6.0, 4.0, 9.0, 7.0, -2.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].h[4], mat4x2(3.0, 0.0, 3.0, -4.0, -5.0, 3.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].h[5], mat4x2(4.0, 2.0, 1.0, -7.0, -7.0, -9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].f, mat4x3(8.0, 3.0, 2.0, -3.0, -4.0, 7.0, 4.0, 3.0, 8.0, -3.0, 0.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockC[1].g), uvec2(9u, 6u)) && allOk;
	allOk = compare_mat4x2(blockC[1].h[0], mat4x2(-1.0, -1.0, -2.0, -9.0, 2.0, -6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].h[1], mat4x2(2.0, 8.0, 9.0, -7.0, -6.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].h[2], mat4x2(-4.0, -3.0, -2.0, -5.0, -4.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].h[3], mat4x2(-8.0, 5.0, -5.0, 4.0, -3.0, -8.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].h[4], mat4x2(1.0, 6.0, -1.0, 9.0, 0.0, 7.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].f, mat4x3(-5.0, -7.0, 5.0, -3.0, 2.0, -8.0, 9.0, 3.0, 9.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockC[2].g), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat4x2(blockC[2].h[0], mat4x2(-1.0, 5.0, -7.0, 4.0, 9.0, -8.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].h[1], mat4x2(9.0, -4.0, 6.0, -9.0, -1.0, -9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].h[2], mat4x2(-9.0, -4.0, -3.0, -7.0, -8.0, 9.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat4x2(0.0, 9.0, 5.0, -7.0, -6.0, 9.0, -5.0, 2.0));
	blockB.a.mB = (-5);
	blockB.a.mC.mA = (mat4(0.0, 0.0, 7.0, 4.0, -9.0, 1.0, 4.0, -5.0, -3.0, -4.0, 6.0, 5.0, 7.0, -4.0, 8.0, -5.0));
	blockB.a.mC.mB = (-3.0);
	blockB.a.mC.mC = (uvec4(1u, 4u, 1u, 4u));
	blockB.a.mC.mD = (uvec4(9u, 6u, 2u, 4u));
	blockB.a.mD = (vec2(9.0, 3.0));
	blockB.c = (true);
	blockB.d[0].mA = (mat4(4.0, 5.0, -9.0, 8.0, -7.0, -6.0, -4.0, 8.0, -8.0, -2.0, 0.0, 9.0, -3.0, 4.0, -6.0, 3.0));
	blockB.d[0].mB.mA = (mat4x3(-2.0, -8.0, 6.0, 4.0, 7.0, 2.0, 3.0, -9.0, -4.0, 5.0, -8.0, 7.0));
	blockB.d[0].mB.mB = (mat4(-1.0, 2.0, 6.0, -2.0, -7.0, 1.0, 6.0, 1.0, -5.0, 3.0, 7.0, 6.0, 5.0, 3.0, 6.0, -8.0));
	blockB.d[0].mC = (mat3x2(-2.0, -1.0, -5.0, 0.0, -8.0, -4.0));
	blockB.d[0].mD = (5);
	blockB.d[1].mA = (mat4(-4.0, -1.0, -8.0, -8.0, 8.0, 0.0, 0.0, 4.0, -5.0, 1.0, -8.0, 7.0, 5.0, -4.0, -9.0, 5.0));
	blockB.d[1].mB.mA = (mat4x3(-7.0, -9.0, 8.0, 1.0, -2.0, 5.0, 6.0, 2.0, 7.0, 7.0, -3.0, 4.0));
	blockB.d[1].mB.mB = (mat4(0.0, 8.0, 7.0, -8.0, 1.0, -5.0, -7.0, -3.0, 4.0, 3.0, -1.0, -3.0, 7.0, -7.0, -9.0, 4.0));
	blockB.d[1].mC = (mat3x2(1.0, 8.0, 2.0, 3.0, -7.0, 0.0));
	blockB.d[1].mD = (9);
	blockB.d[2].mA = (mat4(4.0, 8.0, 7.0, -9.0, 1.0, 9.0, 5.0, -5.0, 6.0, -6.0, -4.0, -5.0, 7.0, 4.0, 7.0, 8.0));
	blockB.d[2].mB.mA = (mat4x3(-6.0, 5.0, 2.0, 8.0, 6.0, -9.0, -4.0, -2.0, -9.0, -2.0, 5.0, 1.0));
	blockB.d[2].mB.mB = (mat4(-5.0, 5.0, 6.0, -9.0, -3.0, -4.0, 7.0, -6.0, -8.0, 8.0, -5.0, 1.0, -1.0, -1.0, -9.0, -9.0));
	blockB.d[2].mC = (mat3x2(3.0, -6.0, 9.0, -8.0, 7.0, -3.0));
	blockB.d[2].mD = (5);
	blockB.d[3].mA = (mat4(7.0, 7.0, -1.0, -6.0, -3.0, -6.0, -6.0, -6.0, 0.0, -9.0, 3.0, -2.0, 8.0, -6.0, 1.0, -2.0));
	blockB.d[3].mB.mA = (mat4x3(0.0, -9.0, 5.0, 4.0, 5.0, -1.0, 9.0, -7.0, 8.0, -8.0, -9.0, -1.0));
	blockB.d[3].mB.mB = (mat4(1.0, 0.0, 1.0, 4.0, -5.0, -1.0, 2.0, -2.0, -3.0, -5.0, -2.0, 3.0, 8.0, 1.0, 4.0, -3.0));
	blockB.d[3].mC = (mat3x2(-4.0, 7.0, 1.0, -8.0, -7.0, 8.0));
	blockB.d[3].mD = (8);
	blockB.d[4].mA = (mat4(-6.0, -8.0, -7.0, 6.0, -7.0, -8.0, -3.0, -3.0, 4.0, 5.0, -5.0, 5.0, -8.0, -2.0, 0.0, 0.0));
	blockB.d[4].mB.mA = (mat4x3(-7.0, 1.0, -3.0, 8.0, 9.0, 3.0, 9.0, 7.0, 7.0, -2.0, 7.0, -4.0));
	blockB.d[4].mB.mB = (mat4(7.0, 8.0, -5.0, -9.0, 5.0, 4.0, 0.0, 3.0, 5.0, -2.0, 2.0, 9.0, 8.0, 0.0, -4.0, 7.0));
	blockB.d[4].mC = (mat3x2(-7.0, 7.0, -4.0, 0.0, -4.0, 8.0));
	blockB.d[4].mD = (-1);
	blockC[0].f = (mat4x3(-4.0, 5.0, -5.0, 2.0, -6.0, -4.0, -1.0, -8.0, 0.0, -3.0, -6.0, -5.0));
	blockC[0].h[0] = (mat4x2(-7.0, 2.0, 1.0, -5.0, -7.0, 6.0, -1.0, -7.0));
	blockC[0].h[1] = (mat4x2(5.0, 6.0, 0.0, 4.0, 4.0, 1.0, 3.0, 1.0));
	blockC[0].h[2] = (mat4x2(-7.0, -1.0, -1.0, -5.0, -5.0, -4.0, 1.0, 7.0));
	blockC[0].h[3] = (mat4x2(-9.0, 0.0, 0.0, 5.0, -1.0, 9.0, 5.0, 8.0));
	blockC[0].h[4] = (mat4x2(2.0, -6.0, 0.0, 2.0, 3.0, 8.0, 4.0, 6.0));
	blockC[0].h[5] = (mat4x2(-5.0, -4.0, 1.0, 9.0, 4.0, 1.0, -7.0, 1.0));
	blockC[1].f = (mat4x3(8.0, -9.0, -4.0, 5.0, 7.0, 2.0, -1.0, -4.0, -5.0, 7.0, -5.0, 9.0));
	blockC[1].h[0] = (mat4x2(-1.0, 6.0, 6.0, -1.0, 2.0, 4.0, -4.0, 6.0));
	blockC[1].h[1] = (mat4x2(-2.0, -6.0, -2.0, 4.0, 8.0, 0.0, 5.0, 3.0));
	blockC[1].h[2] = (mat4x2(-6.0, 1.0, -9.0, 4.0, -4.0, 1.0, 9.0, 5.0));
	blockC[1].h[3] = (mat4x2(-2.0, 2.0, -6.0, -3.0, 8.0, -1.0, 9.0, -5.0));
	blockC[1].h[4] = (mat4x2(3.0, 8.0, 4.0, 3.0, 9.0, -5.0, -1.0, -2.0));
	blockC[2].f = (mat4x3(-4.0, 1.0, -9.0, -5.0, 7.0, -5.0, 3.0, -3.0, 8.0, -9.0, 0.0, 3.0));
	blockC[2].h[0] = (mat4x2(-2.0, 3.0, 7.0, -8.0, -4.0, 1.0, 4.0, -9.0));
	blockC[2].h[1] = (mat4x2(-6.0, 1.0, 1.0, 4.0, 6.0, 7.0, 1.0, -3.0));
	blockC[2].h[2] = (mat4x2(4.0, 1.0, -4.0, -5.0, -5.0, -7.0, -6.0, 5.0));
}
#version 450
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
	layout(offset = 0) mediump mat4x2 a;
	layout(offset = 32) lowp mat3 b;
	layout(offset = 80) highp uint c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) bvec4 a[1];
	layout(offset = 16) lowp ivec3 b[1];
	layout(offset = 32) mediump mat4x3 c;
	layout(offset = 96) lowp uvec4 d;
	layout(offset = 112) mediump vec3 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].a[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(-2.0, -4.0, -5.0, -1.0, 2.0, -2.0, -4.0, 7.0, -1.0, -1.0, -9.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].a[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(-2.0, 1.0, 7.0, 6.0, 6.0, 2.0, 7.0, 0.0, -1.0, 7.0, 5.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].a[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].c, mat4x3(-3.0, 2.0, -9.0, -1.0, 2.0, 9.0, 7.0, -3.0, -3.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].a[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(3)].c, mat4x3(6.0, 7.0, 0.0, -4.0, -5.0, 0.0, -5.0, 7.0, -9.0, -6.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (bvec4(true, false, true, false));
	blockB[nonuniformEXT(0)].c = (mat4x3(-5.0, 9.0, 0.0, 6.0, 2.0, 7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0));
	blockB[nonuniformEXT(0)].e = (vec3(-9.0, 3.0, 7.0));
	blockB[nonuniformEXT(1)].a[0] = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(1)].c = (mat4x3(1.0, -8.0, 3.0, -8.0, 0.0, 2.0, 4.0, 2.0, -3.0, -1.0, 5.0, -5.0));
	blockB[nonuniformEXT(1)].e = (vec3(-6.0, 8.0, 1.0));
	blockB[nonuniformEXT(2)].a[0] = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(2)].c = (mat4x3(0.0, 7.0, 2.0, 0.0, -4.0, 0.0, 6.0, -5.0, -7.0, -1.0, -3.0, -9.0));
	blockB[nonuniformEXT(2)].e = (vec3(3.0, -3.0, 9.0));
	blockB[nonuniformEXT(3)].a[0] = (bvec4(true, false, false, true));
	blockB[nonuniformEXT(3)].c = (mat4x3(2.0, -3.0, -6.0, 1.0, 5.0, -4.0, -2.0, -9.0, 9.0, 9.0, -1.0, 8.0));
	blockB[nonuniformEXT(3)].e = (vec3(5.0, -4.0, -3.0));
}
#version 450
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
	int16_t b;
	highp uint c;
	float16_t d;
};
layout(std430, binding = 2) buffer BlockC
{
	bool e[1];
	lowp int f;
};
layout(std140, binding = 3) buffer BlockD
{
	lowp uint g;
	lowp uint h;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(a), 6.0) && allOk;
	allOk = compare_uint((c), 0u) && allOk;
	allOk = compare_float16_t(float(d), 0.0) && allOk;
	allOk = compare_uint((g), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = float16_t(-5.0);
	c = (0u);
	f = (-6);
	g = (8u);
	h = (6u);
}
#version 450
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
};
layout(std140, binding = 2) buffer BlockC
{
	uint16_t b;
	float16_t c;
	float16_t d;
	lowp uint e;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	uint16_t f;
	highp float g;
	uint16_t h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_uint16_t(uint(blockC.b), 2u) && allOk;
	allOk = compare_float16_t(float(blockC.c), -4.0) && allOk;
	allOk = compare_uint16_t(uint(f), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
	blockC.b = uint16_t(1u);
	blockC.c = float16_t(6.0);
	blockC.d = float16_t(0.0);
	blockC.e = (7u);
	g = (-5.0);
}
#version 450
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
	highp mat2 a;
	lowp int b;
	bool c;
	highp mat4x3 d[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	mediump float e;
	bvec2 f;
	mediump uvec3 g;
	lowp int h;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	bvec4 i;
	lowp ivec4 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), 0) && allOk;
	allOk = compare_bool((c), true) && allOk;
	allOk = compare_mat4x3(d[0], mat4x3(-5.0, 6.0, 3.0, -2.0, 2.0, 5.0, -7.0, 3.0, -5.0, 3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(d[1], mat4x3(-6.0, -3.0, 2.0, 6.0, -9.0, 4.0, -8.0, 9.0, -4.0, 7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(d[2], mat4x3(1.0, -9.0, 7.0, 9.0, -2.0, -4.0, -1.0, -2.0, -5.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(d[3], mat4x3(1.0, -6.0, 1.0, 9.0, -3.0, 3.0, -8.0, 6.0, 4.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(d[4], mat4x3(0.0, -3.0, 7.0, 9.0, -4.0, -6.0, -5.0, -1.0, -8.0, -2.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x3(d[5], mat4x3(8.0, -7.0, 4.0, 9.0, -6.0, 7.0, 2.0, -7.0, 2.0, 0.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(d[6], mat4x3(-3.0, 5.0, 0.0, 6.0, 8.0, 5.0, 7.0, 5.0, 8.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_bvec2((f), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((i), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-5);
	d[0] = (mat4x3(-1.0, -8.0, -3.0, -9.0, -4.0, -7.0, 2.0, 8.0, -4.0, -4.0, 6.0, -2.0));
	d[1] = (mat4x3(-9.0, -1.0, -8.0, -8.0, 1.0, -6.0, -5.0, 7.0, 4.0, 9.0, 9.0, 8.0));
	d[2] = (mat4x3(-8.0, 5.0, 0.0, 4.0, 6.0, -1.0, 6.0, 1.0, -3.0, -9.0, 3.0, -8.0));
	d[3] = (mat4x3(-6.0, 2.0, 6.0, 3.0, -9.0, 2.0, 2.0, 1.0, -1.0, 7.0, -9.0, 2.0));
	d[4] = (mat4x3(-5.0, -9.0, -7.0, -8.0, 2.0, 2.0, -7.0, -2.0, 0.0, 8.0, 3.0, 4.0));
	d[5] = (mat4x3(-1.0, -7.0, 6.0, -7.0, -8.0, 0.0, -2.0, -9.0, -7.0, -2.0, -2.0, 3.0));
	d[6] = (mat4x3(-7.0, 4.0, 0.0, -1.0, -3.0, 7.0, -5.0, 4.0, -5.0, 1.0, 5.0, 0.0));
	e = (-3.0);
	f = (bvec2(false, false));
	g = (uvec3(3u, 5u, 4u));
	h = (-7);
	i = (bvec4(true, true, false, false));
}
#version 450
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
	f16vec4 a[];
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	highp ivec4 b;
	bvec3 c[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	u16vec3 d;
	highp ivec3 e[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	lowp int f;
	highp vec4 g;
	float16_t h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a[0]), vec4(-9.0, 9.0, 2.0, 0.0)) && allOk;
	allOk = compare_float16_t(float(h[0]), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = f16vec4(vec4(-9.0, -3.0, 8.0, 0.0));
	blockD.e[0] = (ivec3(8, -1, 7));
	g = (vec4(-3.0, -1.0, 6.0, -2.0));
	h[0] = float16_t(-4.0);
}
#version 450
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
layout(std430, column_major, binding = 1) buffer BlockB
{
	bvec4 a;
	lowp uvec4 b;
	highp uvec2 c[1];
	sA d;
	i16vec4 e[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp uvec4 f;
	lowp mat3 g;
	f16vec4 h;
	highp uint i;
	f16vec4 j[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp vec4 k;
	f16vec2 l;
	highp uvec3 m[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp mat3x2 n;
	highp mat2x3 o;
	i16vec4 p;
	bvec3 q;
	mediump mat2x3 r[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.c[0]), uvec2(8u, 9u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.e[0]), ivec4(-8, -6, 5, -1)) && allOk;
	allOk = compare_mat3(blockC.g, mat3(7.0, -4.0, -9.0, -4.0, 3.0, 0.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_uint((blockC.i), 3u) && allOk;
	allOk = compare_f16vec4(vec4(blockC.j[0]), vec4(-2.0, 5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(o, mat2x3(4.0, -5.0, 8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_bvec3((q), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockB.b = (uvec4(3u, 3u, 1u, 6u));
	blockB.d.mA = uint16_t(6u);
	blockB.d.mB = float16_t(4.0);
	blockB.d.mC = u16vec4(uvec4(8u, 1u, 7u, 9u));
	blockB.d.mD = i16vec3(ivec3(3, -5, 0));
	blockC.h = f16vec4(vec4(3.0, 5.0, -9.0, 9.0));
	blockD.k = (vec4(9.0, -2.0, -6.0, 3.0));
	blockD.l = f16vec2(vec2(6.0, 8.0));
	blockD.m[0] = (uvec3(5u, 5u, 7u));
	o = (mat2x3(8.0, 5.0, 8.0, 6.0, 1.0, 5.0));
	p = i16vec4(ivec4(-8, 5, 4, -7));
	q = (bvec3(false, false, false));
	r[0] = (mat2x3(-6.0, 0.0, 2.0, 4.0, 3.0, -1.0));
}
#version 450
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
	lowp ivec4 a;
	u16vec2 b;
	lowp uvec3 c;
	bvec4 d[];
} blockB;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-9, 9, 2, 0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(7u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(8u, 8u, 8u)) && allOk;
	allOk = compare_bvec4((blockB.d[0]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.d[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.d[2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[3]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.d[4]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[5]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[6]), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-9, -3, 8, 0));
	blockB.b = u16vec2(uvec2(8u, 7u));
	blockB.c = (uvec3(2u, 2u, 9u));
}
#version 450
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
layout(std140, row_major, binding = 1) buffer BlockB
{
	f16vec4 a;
	mediump uvec3 b;
	sA c;
	u16vec3 d;
	lowp vec3 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(a), vec4(2.0, -4.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec3((c.mA), vec3(-6.0, -4.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(d), uvec3(4u, 9u, 9u)) && allOk;
	allOk = compare_vec3((e), vec3(-6.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec4(vec4(-1.0, 9.0, 1.0, 3.0));
	b = (uvec3(7u, 8u, 0u));
	c.mA = (vec3(2.0, -7.0, 3.0));
	d = u16vec3(uvec3(9u, 5u, 0u));
}
#version 450
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
	int16_t mB;
	int16_t mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump mat3 a;
	sA b;
	lowp float c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.b.mA), uvec4(3u, 8u, 3u, 7u)) && allOk;
	allOk = compare_int16_t(int(blockB.b.mB), -5) && allOk;
	allOk = compare_int16_t(int(blockB.b.mC), -2) && allOk;
	allOk = compare_float((blockB.c[0]), -5.0) && allOk;
	allOk = compare_float((blockB.c[1]), 1.0) && allOk;
	allOk = compare_float((blockB.c[2]), 0.0) && allOk;
	allOk = compare_float((blockB.c[3]), 3.0) && allOk;
	allOk = compare_float((blockB.c[4]), 5.0) && allOk;
	allOk = compare_float((blockB.c[5]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(7.0, -6.0, 8.0, 6.0, -3.0, 9.0, 8.0, 1.0, -6.0));
	blockB.b.mA = u16vec4(uvec4(7u, 2u, 7u, 2u));
	blockB.b.mB = int16_t(9);
	blockB.b.mC = int16_t(-2);
	blockB.c[0] = (-9.0);
	blockB.c[1] = (8.0);
	blockB.c[2] = (3.0);
	blockB.c[3] = (4.0);
	blockB.c[4] = (9.0);
	blockB.c[5] = (-6.0);
}
#version 450
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
	bool mA;
	i16vec4 mB[5];
	highp uvec4 mC[2];
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	lowp mat4 a;
	i16vec2 b[1];
	sA c;
};
layout(scalar, binding = 2) buffer BlockC
{
	highp vec2 d;
	mediump mat4 e;
	sB f[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a, mat4(2.0, 0.0, -7.0, 9.0, 0.0, 2.0, -8.0, 8.0, 3.0, 4.0, 1.0, 9.0, 9.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_bvec3((c.mA), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = i16vec2(ivec2(3, -5));
	c.mA = (bvec3(false, false, false));
	blockC[0].d = (vec2(8.0, -3.0));
	blockC[0].f[0].mA = (false);
	blockC[0].f[0].mB[0] = i16vec4(ivec4(0, 7, 8, 8));
	blockC[0].f[0].mB[1] = i16vec4(ivec4(-5, 9, 8, -4));
	blockC[0].f[0].mB[2] = i16vec4(ivec4(-4, -1, 3, 4));
	blockC[0].f[0].mB[3] = i16vec4(ivec4(-7, 9, 8, -9));
	blockC[0].f[0].mB[4] = i16vec4(ivec4(-1, 5, -2, 4));
	blockC[0].f[0].mC[0] = (uvec4(1u, 6u, 2u, 9u));
	blockC[0].f[0].mC[1] = (uvec4(7u, 9u, 4u, 0u));
	blockC[0].f[1].mA = (false);
	blockC[0].f[1].mB[0] = i16vec4(ivec4(-4, -7, -5, 0));
	blockC[0].f[1].mB[1] = i16vec4(ivec4(-4, 5, 6, 4));
	blockC[0].f[1].mB[2] = i16vec4(ivec4(-4, 5, 4, 6));
	blockC[0].f[1].mB[3] = i16vec4(ivec4(1, -2, 8, -2));
	blockC[0].f[1].mB[4] = i16vec4(ivec4(-2, 7, 0, 4));
	blockC[0].f[1].mC[0] = (uvec4(1u, 8u, 0u, 3u));
	blockC[0].f[1].mC[1] = (uvec4(2u, 5u, 9u, 9u));
	blockC[0].f[2].mA = (false);
	blockC[0].f[2].mB[0] = i16vec4(ivec4(-5, 5, 5, 0));
	blockC[0].f[2].mB[1] = i16vec4(ivec4(4, 4, 4, -8));
	blockC[0].f[2].mB[2] = i16vec4(ivec4(8, -9, 8, 6));
	blockC[0].f[2].mB[3] = i16vec4(ivec4(9, 6, -1, -5));
	blockC[0].f[2].mB[4] = i16vec4(ivec4(-9, -1, -4, -5));
	blockC[0].f[2].mC[0] = (uvec4(8u, 0u, 2u, 3u));
	blockC[0].f[2].mC[1] = (uvec4(7u, 3u, 7u, 4u));
	blockC[0].f[3].mA = (false);
	blockC[0].f[3].mB[0] = i16vec4(ivec4(-8, -6, 4, 2));
	blockC[0].f[3].mB[1] = i16vec4(ivec4(5, 1, -6, -5));
	blockC[0].f[3].mB[2] = i16vec4(ivec4(1, -9, -4, -7));
	blockC[0].f[3].mB[3] = i16vec4(ivec4(3, 3, 1, -1));
	blockC[0].f[3].mB[4] = i16vec4(ivec4(7, -1, 2, 9));
	blockC[0].f[3].mC[0] = (uvec4(8u, 2u, 9u, 1u));
	blockC[0].f[3].mC[1] = (uvec4(3u, 7u, 1u, 2u));
	blockC[0].f[4].mA = (false);
	blockC[0].f[4].mB[0] = i16vec4(ivec4(2, -6, 0, -1));
	blockC[0].f[4].mB[1] = i16vec4(ivec4(1, 5, -3, -2));
	blockC[0].f[4].mB[2] = i16vec4(ivec4(-2, -4, -8, 7));
	blockC[0].f[4].mB[3] = i16vec4(ivec4(-7, 7, -2, -3));
	blockC[0].f[4].mB[4] = i16vec4(ivec4(8, 8, 6, -9));
	blockC[0].f[4].mC[0] = (uvec4(3u, 4u, 4u, 0u));
	blockC[0].f[4].mC[1] = (uvec4(7u, 4u, 8u, 9u));
	blockC[0].f[5].mA = (false);
	blockC[0].f[5].mB[0] = i16vec4(ivec4(6, -3, -2, 3));
	blockC[0].f[5].mB[1] = i16vec4(ivec4(0, -4, 6, -7));
	blockC[0].f[5].mB[2] = i16vec4(ivec4(-8, 1, -1, -1));
	blockC[0].f[5].mB[3] = i16vec4(ivec4(9, -1, -5, 8));
	blockC[0].f[5].mB[4] = i16vec4(ivec4(5, -8, -2, 2));
	blockC[0].f[5].mC[0] = (uvec4(7u, 6u, 2u, 8u));
	blockC[0].f[5].mC[1] = (uvec4(1u, 0u, 6u, 1u));
	blockC[1].d = (vec2(-8.0, -6.0));
	blockC[1].f[0].mA = (false);
	blockC[1].f[0].mB[0] = i16vec4(ivec4(9, -6, 3, 1));
	blockC[1].f[0].mB[1] = i16vec4(ivec4(5, 2, -5, -6));
	blockC[1].f[0].mB[2] = i16vec4(ivec4(7, -4, 8, 8));
	blockC[1].f[0].mB[3] = i16vec4(ivec4(-9, -8, 5, 1));
	blockC[1].f[0].mB[4] = i16vec4(ivec4(-7, 4, 3, 2));
	blockC[1].f[0].mC[0] = (uvec4(8u, 5u, 6u, 1u));
	blockC[1].f[0].mC[1] = (uvec4(1u, 5u, 5u, 8u));
	blockC[1].f[1].mA = (true);
	blockC[1].f[1].mB[0] = i16vec4(ivec4(-1, -9, 4, 8));
	blockC[1].f[1].mB[1] = i16vec4(ivec4(-3, 4, -6, -4));
	blockC[1].f[1].mB[2] = i16vec4(ivec4(8, 3, -1, 1));
	blockC[1].f[1].mB[3] = i16vec4(ivec4(6, 2, 8, 1));
	blockC[1].f[1].mB[4] = i16vec4(ivec4(-4, -1, -9, 0));
	blockC[1].f[1].mC[0] = (uvec4(2u, 5u, 1u, 2u));
	blockC[1].f[1].mC[1] = (uvec4(8u, 8u, 9u, 8u));
	blockC[1].f[2].mA = (false);
	blockC[1].f[2].mB[0] = i16vec4(ivec4(3, 9, 5, 4));
	blockC[1].f[2].mB[1] = i16vec4(ivec4(-9, -9, 5, -9));
	blockC[1].f[2].mB[2] = i16vec4(ivec4(-9, 6, 0, 3));
	blockC[1].f[2].mB[3] = i16vec4(ivec4(6, 4, 1, -4));
	blockC[1].f[2].mB[4] = i16vec4(ivec4(1, 5, -5, -1));
	blockC[1].f[2].mC[0] = (uvec4(1u, 6u, 3u, 8u));
	blockC[1].f[2].mC[1] = (uvec4(3u, 2u, 8u, 0u));
	blockC[1].f[3].mA = (true);
	blockC[1].f[3].mB[0] = i16vec4(ivec4(8, -4, -4, -1));
	blockC[1].f[3].mB[1] = i16vec4(ivec4(2, 5, -4, -7));
	blockC[1].f[3].mB[2] = i16vec4(ivec4(-7, 0, 1, -6));
	blockC[1].f[3].mB[3] = i16vec4(ivec4(9, -4, 9, -3));
	blockC[1].f[3].mB[4] = i16vec4(ivec4(3, -3, 6, -2));
	blockC[1].f[3].mC[0] = (uvec4(1u, 8u, 6u, 3u));
	blockC[1].f[3].mC[1] = (uvec4(1u, 2u, 0u, 6u));
	blockC[2].d = (vec2(5.0, -3.0));
	blockC[2].f[0].mA = (true);
	blockC[2].f[0].mB[0] = i16vec4(ivec4(8, 8, -2, 3));
	blockC[2].f[0].mB[1] = i16vec4(ivec4(8, 3, -6, 7));
	blockC[2].f[0].mB[2] = i16vec4(ivec4(4, -1, -2, -9));
	blockC[2].f[0].mB[3] = i16vec4(ivec4(-3, 3, -9, 9));
	blockC[2].f[0].mB[4] = i16vec4(ivec4(0, 4, 8, 5));
	blockC[2].f[0].mC[0] = (uvec4(1u, 6u, 6u, 9u));
	blockC[2].f[0].mC[1] = (uvec4(7u, 4u, 9u, 6u));
	blockC[2].f[1].mA = (false);
	blockC[2].f[1].mB[0] = i16vec4(ivec4(0, -4, 7, 7));
	blockC[2].f[1].mB[1] = i16vec4(ivec4(7, -8, 4, 3));
	blockC[2].f[1].mB[2] = i16vec4(ivec4(-3, -6, -3, -7));
	blockC[2].f[1].mB[3] = i16vec4(ivec4(-4, 4, -3, 8));
	blockC[2].f[1].mB[4] = i16vec4(ivec4(-7, 7, -5, 2));
	blockC[2].f[1].mC[0] = (uvec4(4u, 2u, 5u, 0u));
	blockC[2].f[1].mC[1] = (uvec4(0u, 6u, 4u, 1u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer BlockB
{
	highp mat4x2 a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

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

layout(std430, binding = 1) buffer BlockB
{
	lowp int a;
	mediump int b;
	int8_t c;
	lowp int d;
	bool e;
} blockB;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 0) && allOk;
	allOk = compare_int((blockB.d), 2) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5);
	blockB.b = (-5);
	blockB.d = (9);
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

layout(std140, row_major, binding = 1) buffer BlockB
{
	int8_t a;
	bvec2 b[][4];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	mediump uvec3 c[];
} blockC;

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(a), 0) && allOk;
	allOk = compare_bvec2((b[0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[0][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[2][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((b[2][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[2][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[3][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[3][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((b[3][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[3][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[4][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[4][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((b[4][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((b[4][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[5][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[5][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((b[5][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[5][3]), bvec2(false, true)) && allOk;
	allOk = compare_uvec3((blockC.c[0]), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.c[1]), uvec3(2u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.c[2]), uvec3(4u, 7u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.c[3]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((blockC.c[4]), uvec3(4u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.c[5]), uvec3(0u, 6u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.c[6]), uvec3(7u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.c[7]), uvec3(1u, 8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0][0] = (bvec2(true, false));
	b[0][1] = (bvec2(true, true));
	b[0][2] = (bvec2(false, true));
	b[0][3] = (bvec2(false, false));
	b[1][0] = (bvec2(false, false));
	b[1][1] = (bvec2(true, true));
	b[1][2] = (bvec2(false, false));
	b[1][3] = (bvec2(false, true));
	b[2][0] = (bvec2(false, true));
	b[2][1] = (bvec2(false, true));
	b[2][2] = (bvec2(false, false));
	b[2][3] = (bvec2(false, false));
	b[3][0] = (bvec2(false, false));
	b[3][1] = (bvec2(true, false));
	b[3][2] = (bvec2(true, true));
	b[3][3] = (bvec2(false, true));
	b[4][0] = (bvec2(true, true));
	b[4][1] = (bvec2(false, false));
	b[4][2] = (bvec2(true, true));
	b[4][3] = (bvec2(false, true));
	b[5][0] = (bvec2(true, false));
	b[5][1] = (bvec2(true, false));
	b[5][2] = (bvec2(false, true));
	b[5][3] = (bvec2(true, true));
}
#version 450
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
	u8vec4 a[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp float b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	b[0] = (6.0);
}
#version 450
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
	lowp ivec4 a[1];
	lowp mat4x2 b;
	highp uvec3 c;
	uint8_t d;
	highp ivec3 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump mat2 f;
	lowp uint g;
	u8vec4 h;
	u8vec2 i[];
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	u8vec3 j;
	highp ivec4 k;
	int8_t l[1];
	mediump vec2 m[];
};
layout(std430, binding = 4) buffer BlockE
{
	bvec2 n;
	bool o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a[0]), ivec4(0, 3, 3, 2)) && allOk;
	allOk = compare_uvec3((c), uvec3(9u, 9u, 2u)) && allOk;
	allOk = compare_ivec3((e[0]), ivec3(5, -5, -2)) && allOk;
	allOk = compare_mat2(blockC[0].f, mat2(-6.0, 6.0, -8.0, 7.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].h), uvec4(6u, 1u, 9u, 6u)) && allOk;
	allOk = compare_mat2(blockC[1].f, mat2(-4.0, 1.0, 9.0, -1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[1].h), uvec4(6u, 6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(j), uvec3(3u, 3u, 7u)) && allOk;
	allOk = compare_ivec4((k), ivec4(9, -8, -7, -6)) && allOk;
	allOk = compare_bvec2((n), bvec2(true, true)) && allOk;
	allOk = compare_bool((o[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec4(5, -5, 3, 9));
	b = (mat4x2(-5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0));
	d = uint8_t(0u);
	e[0] = (ivec3(-7, -4, -2));
	blockC[0].h = u8vec4(uvec4(1u, 2u, 3u, 9u));
	blockC[0].i[0] = u8vec2(uvec2(4u, 2u));
	blockC[1].h = u8vec4(uvec4(8u, 1u, 4u, 8u));
	blockC[1].i[0] = u8vec2(uvec2(1u, 7u));
	j = u8vec3(uvec3(1u, 6u, 0u));
	k = (ivec4(3, 2, 7, 2));
	l[0] = int8_t(4294967287);
	m[0] = (vec2(1.0, -9.0));
	n = (bvec2(false, true));
	o[0] = (true);
}
#version 450
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
	lowp uvec4 mA;
};
struct sB
{
	sA mA;
	uint8_t mB;
	highp uint mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sB a;
	bvec3 b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bvec2 c;
	mediump vec3 d;
	u8vec4 e;
	bvec2 f;
	bvec2 g;
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp ivec4 h;
	highp uvec4 i;
	highp uvec4 j;
	lowp uint k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.b[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.b[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[4]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[5]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[6]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec2((c), bvec2(false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(e), uvec4(4u, 4u, 1u, 6u)) && allOk;
	allOk = compare_bvec2((f), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((g), bvec2(false, false)) && allOk;
	allOk = compare_ivec4((h), ivec4(-7, 7, -3, -3)) && allOk;
	allOk = compare_uvec4((j), uvec4(9u, 1u, 4u, 4u)) && allOk;
	allOk = compare_uint((k[0]), 0u) && allOk;
	allOk = compare_uint((k[1]), 9u) && allOk;
	allOk = compare_uint((k[2]), 0u) && allOk;
	allOk = compare_uint((k[3]), 4u) && allOk;
	allOk = compare_uint((k[4]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA.mA = (uvec4(7u, 4u, 8u, 3u));
	blockB.a.mB = uint8_t(7u);
	blockB.a.mC = (9u);
	blockB.b[0] = (bvec3(false, false, true));
	blockB.b[1] = (bvec3(false, false, true));
	blockB.b[2] = (bvec3(false, false, false));
	blockB.b[3] = (bvec3(true, false, true));
	blockB.b[4] = (bvec3(false, false, true));
	blockB.b[5] = (bvec3(true, false, true));
	blockB.b[6] = (bvec3(false, false, true));
	c = (bvec2(true, true));
	d = (vec3(9.0, 4.0, 4.0));
	e = u8vec4(uvec4(8u, 0u, 1u, 2u));
	f = (bvec2(false, false));
	g = (bvec2(true, false));
	h = (ivec4(-4, 6, 0, -2));
	i = (uvec4(6u, 5u, 6u, 8u));
	j = (uvec4(4u, 3u, 1u, 6u));
	k[0] = (0u);
	k[1] = (7u);
	k[2] = (2u);
	k[3] = (4u);
	k[4] = (3u);
}
#version 450
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
	lowp uvec3 b;
	uint8_t c;
	mediump mat4 d;
	u8vec2 e[][4];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	u8vec2 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(-4.0, 4.0, -6.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_uvec3((b), uvec3(7u, 6u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(c), 8u) && allOk;
	allOk = compare_mat4(d, mat4(-6.0, -4.0, -6.0, -3.0, -1.0, 4.0, 8.0, -1.0, 6.0, 5.0, -8.0, -6.0, 5.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_u8vec2(uvec2(f[0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(f[1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(f[2]), uvec2(9u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(f[3]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(f[4]), uvec2(1u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(f[5]), uvec2(8u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(f[6]), uvec2(4u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(f[7]), uvec2(8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec3(9u, 3u, 3u));
	c = uint8_t(1u);
}
#version 450
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
	lowp vec2 mB;
	highp mat3x2 mC;
};
struct sB
{
	highp mat3x4 mA;
	highp mat3 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp uvec2 a;
	mediump uvec4 b[];
} blockB[3];
layout(std430, binding = 2) buffer BlockC
{
	lowp vec4 c;
	sA d[];
} blockC[3];
layout(std430, binding = 3) buffer BlockD
{
	sB e;
	highp ivec2 f;
	mediump vec3 g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[1].a), uvec2(2u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[2].a), uvec2(7u, 5u)) && allOk;
	allOk = compare_vec4((blockC[0].c), vec4(-3.0, 3.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC[1].c), vec4(-9.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[2].c), vec4(4.0, -4.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.g[0]), vec3(3.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD.g[1]), vec3(-5.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD.g[2]), vec3(8.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.g[3]), vec3(-7.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.g[4]), vec3(-6.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.g[5]), vec3(-2.0, 7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (uvec4(7u, 8u, 8u, 2u));
	blockB[0].b[1] = (uvec4(9u, 3u, 3u, 1u));
	blockB[0].b[2] = (uvec4(6u, 3u, 9u, 6u));
	blockB[0].b[3] = (uvec4(2u, 8u, 1u, 7u));
	blockB[0].b[4] = (uvec4(9u, 4u, 1u, 4u));
	blockB[0].b[5] = (uvec4(3u, 8u, 9u, 1u));
	blockB[0].b[6] = (uvec4(6u, 3u, 6u, 5u));
	blockB[0].b[7] = (uvec4(5u, 6u, 5u, 2u));
	blockB[1].b[0] = (uvec4(1u, 7u, 5u, 4u));
	blockB[1].b[1] = (uvec4(5u, 0u, 0u, 5u));
	blockB[1].b[2] = (uvec4(8u, 2u, 0u, 9u));
	blockB[1].b[3] = (uvec4(1u, 8u, 5u, 8u));
	blockB[1].b[4] = (uvec4(1u, 6u, 5u, 5u));
	blockB[1].b[5] = (uvec4(7u, 2u, 2u, 9u));
	blockB[2].b[0] = (uvec4(5u, 2u, 8u, 1u));
	blockC[0].c = (vec4(6.0, 1.0, 5.0, -8.0));
	blockC[0].d[0].mA = u8vec4(uvec4(9u, 8u, 4u, 3u));
	blockC[0].d[0].mB = (vec2(5.0, 5.0));
	blockC[0].d[0].mC = (mat3x2(-7.0, -5.0, 6.0, -3.0, -6.0, 8.0));
	blockC[0].d[1].mA = u8vec4(uvec4(6u, 3u, 6u, 1u));
	blockC[0].d[1].mB = (vec2(-6.0, -2.0));
	blockC[0].d[1].mC = (mat3x2(4.0, 5.0, -5.0, 2.0, 9.0, 7.0));
	blockC[0].d[2].mA = u8vec4(uvec4(0u, 0u, 7u, 0u));
	blockC[0].d[2].mB = (vec2(6.0, 0.0));
	blockC[0].d[2].mC = (mat3x2(3.0, -9.0, 3.0, 4.0, 5.0, 8.0));
	blockC[0].d[3].mA = u8vec4(uvec4(8u, 4u, 3u, 8u));
	blockC[0].d[3].mB = (vec2(-9.0, 8.0));
	blockC[0].d[3].mC = (mat3x2(6.0, -3.0, 9.0, 4.0, -1.0, -2.0));
	blockC[0].d[4].mA = u8vec4(uvec4(5u, 4u, 9u, 4u));
	blockC[0].d[4].mB = (vec2(-7.0, 8.0));
	blockC[0].d[4].mC = (mat3x2(-2.0, -3.0, -6.0, -5.0, -8.0, 0.0));
	blockC[0].d[5].mA = u8vec4(uvec4(5u, 6u, 6u, 5u));
	blockC[0].d[5].mB = (vec2(6.0, -8.0));
	blockC[0].d[5].mC = (mat3x2(4.0, 1.0, 3.0, -9.0, 9.0, 1.0));
	blockC[1].c = (vec4(6.0, 8.0, 3.0, -1.0));
	blockC[1].d[0].mA = u8vec4(uvec4(8u, 8u, 2u, 4u));
	blockC[1].d[0].mB = (vec2(4.0, -5.0));
	blockC[1].d[0].mC = (mat3x2(6.0, 3.0, 3.0, -3.0, -2.0, -4.0));
	blockC[1].d[1].mA = u8vec4(uvec4(1u, 2u, 9u, 8u));
	blockC[1].d[1].mB = (vec2(7.0, 7.0));
	blockC[1].d[1].mC = (mat3x2(-9.0, -1.0, -9.0, -2.0, 5.0, 9.0));
	blockC[1].d[2].mA = u8vec4(uvec4(3u, 2u, 3u, 8u));
	blockC[1].d[2].mB = (vec2(-5.0, -8.0));
	blockC[1].d[2].mC = (mat3x2(8.0, -2.0, -8.0, 8.0, 6.0, 6.0));
	blockC[1].d[3].mA = u8vec4(uvec4(0u, 5u, 1u, 5u));
	blockC[1].d[3].mB = (vec2(2.0, 4.0));
	blockC[1].d[3].mC = (mat3x2(2.0, 6.0, -9.0, -5.0, -1.0, -7.0));
	blockC[1].d[4].mA = u8vec4(uvec4(2u, 6u, 6u, 7u));
	blockC[1].d[4].mB = (vec2(-6.0, 5.0));
	blockC[1].d[4].mC = (mat3x2(7.0, 4.0, -9.0, 5.0, 9.0, -5.0));
	blockC[1].d[5].mA = u8vec4(uvec4(7u, 7u, 4u, 0u));
	blockC[1].d[5].mB = (vec2(-3.0, -9.0));
	blockC[1].d[5].mC = (mat3x2(6.0, 4.0, -7.0, 5.0, -6.0, 2.0));
	blockC[1].d[6].mA = u8vec4(uvec4(8u, 1u, 2u, 9u));
	blockC[1].d[6].mB = (vec2(-3.0, -8.0));
	blockC[1].d[6].mC = (mat3x2(-2.0, -5.0, 0.0, -3.0, 1.0, 7.0));
	blockC[1].d[7].mA = u8vec4(uvec4(8u, 5u, 3u, 6u));
	blockC[1].d[7].mB = (vec2(9.0, -3.0));
	blockC[1].d[7].mC = (mat3x2(4.0, -9.0, 3.0, 2.0, 5.0, -3.0));
	blockC[2].c = (vec4(9.0, -9.0, -4.0, -6.0));
	blockC[2].d[0].mA = u8vec4(uvec4(5u, 6u, 6u, 5u));
	blockC[2].d[0].mB = (vec2(4.0, -7.0));
	blockC[2].d[0].mC = (mat3x2(-8.0, 4.0, -7.0, 5.0, 9.0, -3.0));
	blockC[2].d[1].mA = u8vec4(uvec4(8u, 1u, 5u, 9u));
	blockC[2].d[1].mB = (vec2(-4.0, -4.0));
	blockC[2].d[1].mC = (mat3x2(3.0, 9.0, 0.0, 4.0, 0.0, -2.0));
	blockC[2].d[2].mA = u8vec4(uvec4(9u, 9u, 8u, 6u));
	blockC[2].d[2].mB = (vec2(4.0, 3.0));
	blockC[2].d[2].mC = (mat3x2(-4.0, -7.0, -1.0, 3.0, -7.0, 8.0));
	blockC[2].d[3].mA = u8vec4(uvec4(0u, 3u, 9u, 3u));
	blockC[2].d[3].mB = (vec2(-1.0, 2.0));
	blockC[2].d[3].mC = (mat3x2(-8.0, 3.0, 0.0, 1.0, -7.0, 7.0));
	blockC[2].d[4].mA = u8vec4(uvec4(8u, 6u, 5u, 0u));
	blockC[2].d[4].mB = (vec2(8.0, 1.0));
	blockC[2].d[4].mC = (mat3x2(0.0, 6.0, -4.0, 9.0, 2.0, -6.0));
	blockC[2].d[5].mA = u8vec4(uvec4(1u, 5u, 5u, 8u));
	blockC[2].d[5].mB = (vec2(-1.0, -8.0));
	blockC[2].d[5].mC = (mat3x2(-4.0, -3.0, -8.0, -3.0, -3.0, -7.0));
	blockD.e.mA = (mat3x4(-4.0, 5.0, 9.0, -7.0, -8.0, 7.0, 3.0, 0.0, 9.0, 1.0, 6.0, 0.0));
	blockD.e.mB = (mat3(-3.0, 6.0, -9.0, 7.0, 4.0, -7.0, 7.0, 6.0, -8.0));
}
#version 450
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
	u8vec4 a[];
};
layout(std140, binding = 2) buffer BlockC
{
	lowp mat3x2 b;
	mediump vec3 c;
	highp mat4x3 d;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC.b, mat3x2(-5.0, -3.0, -1.0, 1.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u8vec4(uvec4(0u, 7u, 5u, 6u));
	a[1] = u8vec4(uvec4(7u, 2u, 9u, 7u));
	a[2] = u8vec4(uvec4(2u, 4u, 4u, 4u));
	a[3] = u8vec4(uvec4(3u, 2u, 5u, 6u));
	a[4] = u8vec4(uvec4(0u, 2u, 1u, 9u));
	a[5] = u8vec4(uvec4(4u, 8u, 0u, 4u));
	a[6] = u8vec4(uvec4(7u, 4u, 2u, 3u));
	blockC.b = (mat3x2(9.0, -9.0, 4.0, -1.0, 8.0, 4.0));
}
#version 450
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
	lowp uvec3 mB;
	highp mat3x4 mC;
	lowp uint mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	lowp ivec3 b;
	highp float c;
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a.mA), uvec4(4u, 0u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[0].a.mB), uvec3(8u, 7u, 2u)) && allOk;
	allOk = compare_mat3x4(blockB[0].a.mC, mat3x4(0.0, 3.0, -6.0, -9.0, -5.0, -9.0, -3.0, -7.0, 9.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_uint((blockB[0].a.mD), 8u) && allOk;
	allOk = compare_ivec3((blockB[0].b), ivec3(3, -6, 2)) && allOk;
	allOk = compare_float((blockB[0].c), -7.0) && allOk;
	allOk = compare_uvec4((blockB[1].a.mA), uvec4(5u, 2u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].a.mB), uvec3(8u, 4u, 3u)) && allOk;
	allOk = compare_mat3x4(blockB[1].a.mC, mat3x4(8.0, 3.0, -8.0, 4.0, 4.0, -2.0, -2.0, -2.0, 1.0, -9.0, 9.0, 0.0)) && allOk;
	allOk = compare_uint((blockB[1].a.mD), 5u) && allOk;
	allOk = compare_ivec3((blockB[1].b), ivec3(-3, -8, -4)) && allOk;
	allOk = compare_float((blockB[1].c), -3.0) && allOk;
	allOk = compare_uvec4((blockB[2].a.mA), uvec4(3u, 5u, 3u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[2].a.mB), uvec3(6u, 9u, 7u)) && allOk;
	allOk = compare_mat3x4(blockB[2].a.mC, mat3x4(7.0, 4.0, -2.0, -9.0, 2.0, 0.0, 4.0, 0.0, 8.0, 4.0, -3.0, -7.0)) && allOk;
	allOk = compare_uint((blockB[2].a.mD), 8u) && allOk;
	allOk = compare_ivec3((blockB[2].b), ivec3(1, 4, 4)) && allOk;
	allOk = compare_float((blockB[2].c), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (uvec4(4u, 4u, 5u, 2u));
	blockB[0].a.mB = (uvec3(7u, 4u, 8u));
	blockB[0].a.mC = (mat3x4(-4.0, 6.0, 4.0, -8.0, 0.0, -7.0, 3.0, -7.0, -8.0, 7.0, -8.0, 7.0));
	blockB[0].a.mD = (5u);
	blockB[0].b = (ivec3(-8, 7, 4));
	blockB[1].a.mA = (uvec4(7u, 6u, 7u, 0u));
	blockB[1].a.mB = (uvec3(5u, 2u, 5u));
	blockB[1].a.mC = (mat3x4(-7.0, -1.0, -8.0, 4.0, -7.0, 6.0, 6.0, -2.0, 4.0, 3.0, -7.0, 1.0));
	blockB[1].a.mD = (5u);
	blockB[1].b = (ivec3(-2, 0, -6));
	blockB[2].a.mA = (uvec4(4u, 1u, 3u, 0u));
	blockB[2].a.mB = (uvec3(9u, 8u, 8u));
	blockB[2].a.mC = (mat3x4(5.0, 9.0, 4.0, 5.0, 8.0, 3.0, 1.0, -4.0, 9.0, 4.0, -9.0, -4.0));
	blockB[2].a.mD = (8u);
	blockB[2].b = (ivec3(8, 2, 9));
}
#version 450
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
	lowp uvec3 mB;
};
struct sB
{
	i8vec4 mA[7];
	highp ivec4 mB[2][5];
	lowp mat3 mC;
	i8vec2 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	uint8_t a;
	lowp mat4x3 b;
	sA c[3];
} blockB[2];
layout(std430, binding = 2) buffer BlockC
{
	sB d;
	lowp uvec3 e;
	mediump mat3x2 f[];
};
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	bvec2 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[0].b, mat4x3(0.0, -7.0, -9.0, 0.0, -2.0, -6.0, 9.0, 7.0, -1.0, 0.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b, mat4x3(-6.0, -1.0, -1.0, 5.0, -1.0, 1.0, 0.0, -5.0, -5.0, 1.0, 2.0, 4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mA[0]), ivec4(0, 4, 8, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mA[1]), ivec4(9, 9, 9, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mA[2]), ivec4(4294967295, 4294967291, 8, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mA[3]), ivec4(4294967295, 4294967290, 4294967290, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mA[4]), ivec4(6, 4294967288, 4294967290, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mA[5]), ivec4(4294967287, 5, 4294967294, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mA[6]), ivec4(1, 8, 0, 4294967290)) && allOk;
	allOk = compare_ivec4((d.mB[0][0]), ivec4(-3, -5, 4, 3)) && allOk;
	allOk = compare_ivec4((d.mB[0][1]), ivec4(3, 4, -4, -4)) && allOk;
	allOk = compare_ivec4((d.mB[0][2]), ivec4(6, -9, 5, -8)) && allOk;
	allOk = compare_ivec4((d.mB[0][3]), ivec4(6, -4, -1, -7)) && allOk;
	allOk = compare_ivec4((d.mB[0][4]), ivec4(3, 9, -5, -6)) && allOk;
	allOk = compare_ivec4((d.mB[1][0]), ivec4(-7, -2, 9, -5)) && allOk;
	allOk = compare_ivec4((d.mB[1][1]), ivec4(-4, -2, 0, -5)) && allOk;
	allOk = compare_ivec4((d.mB[1][2]), ivec4(1, -1, -2, -1)) && allOk;
	allOk = compare_ivec4((d.mB[1][3]), ivec4(-8, -4, -9, -4)) && allOk;
	allOk = compare_ivec4((d.mB[1][4]), ivec4(-7, 5, -9, -2)) && allOk;
	allOk = compare_mat3(d.mC, mat3(-9.0, -6.0, -8.0, -6.0, -7.0, -5.0, -3.0, 6.0, -3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(d.mD), ivec2(7, 0)) && allOk;
	allOk = compare_uvec3((e), uvec3(4u, 0u, 0u)) && allOk;
	allOk = compare_mat3x2(f[0], mat3x2(5.0, -5.0, -9.0, -4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(f[1], mat3x2(4.0, 1.0, 1.0, -2.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(f[2], mat3x2(0.0, -9.0, 0.0, 0.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(f[3], mat3x2(-4.0, -6.0, 4.0, 2.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c[0].mA = (bvec4(false, true, false, false));
	blockB[0].c[0].mB = (uvec3(4u, 8u, 4u));
	blockB[0].c[1].mA = (bvec4(false, false, true, true));
	blockB[0].c[1].mB = (uvec3(6u, 5u, 2u));
	blockB[0].c[2].mA = (bvec4(true, true, true, true));
	blockB[0].c[2].mB = (uvec3(9u, 9u, 6u));
	blockB[1].c[0].mA = (bvec4(true, false, false, true));
	blockB[1].c[0].mB = (uvec3(5u, 1u, 6u));
	blockB[1].c[1].mA = (bvec4(false, false, true, true));
	blockB[1].c[1].mB = (uvec3(8u, 5u, 6u));
	blockB[1].c[2].mA = (bvec4(false, false, false, true));
	blockB[1].c[2].mB = (uvec3(2u, 2u, 3u));
	f[0] = (mat3x2(-1.0, 0.0, 8.0, -7.0, 5.0, 6.0));
	f[1] = (mat3x2(0.0, 6.0, 1.0, -5.0, 1.0, 5.0));
	f[2] = (mat3x2(4.0, -4.0, 5.0, 1.0, -3.0, 7.0));
	f[3] = (mat3x2(-7.0, 9.0, 4.0, 9.0, -3.0, -7.0));
}
#version 450
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
	mediump uvec2 mA;
	lowp int mB;
	highp vec3 mC;
	u8vec4 mD;
};
struct sB
{
	mediump mat3x4 mA;
	u8vec4 mB;
	mediump mat4x3 mC;
	sA mD;
};
struct sC
{
	highp vec4 mA[2];
	i8vec3 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	i8vec2 a[6];
	sB b;
	lowp uvec2 c;
	mediump uvec2 d[7][4];
	lowp mat3x4 e;
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	u8vec4 f;
	sC g[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp vec3 h[8];
	uint8_t i;
	highp mat2x3 j;
	bool k[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp mat4 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.b.mA, mat3x4(6.0, -6.0, -3.0, -6.0, 0.0, -1.0, 2.0, 9.0, 1.0, -6.0, -5.0, -6.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b.mB), uvec4(1u, 8u, 2u, 6u)) && allOk;
	allOk = compare_mat4x3(blockB.b.mC, mat4x3(-1.0, 1.0, 6.0, 2.0, 6.0, 8.0, -7.0, 3.0, 8.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_uvec2((blockB.b.mD.mA), uvec2(9u, 6u)) && allOk;
	allOk = compare_int((blockB.b.mD.mB), -6) && allOk;
	allOk = compare_vec3((blockB.b.mD.mC), vec3(-9.0, -9.0, 5.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b.mD.mD), uvec4(2u, 8u, 1u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.d[0][0]), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.d[0][1]), uvec2(3u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.d[0][2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.d[0][3]), uvec2(7u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.d[1][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.d[1][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.d[1][2]), uvec2(1u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.d[1][3]), uvec2(7u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.d[2][0]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.d[2][1]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.d[2][2]), uvec2(1u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.d[2][3]), uvec2(3u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.d[3][0]), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.d[3][1]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.d[3][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.d[3][3]), uvec2(5u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.d[4][0]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.d[4][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.d[4][2]), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.d[4][3]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.d[5][0]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.d[5][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.d[5][2]), uvec2(0u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.d[5][3]), uvec2(5u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.d[6][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.d[6][1]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.d[6][2]), uvec2(3u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.d[6][3]), uvec2(8u, 4u)) && allOk;
	allOk = compare_mat3x4(blockB.e, mat3x4(3.0, 2.0, 5.0, -4.0, 1.0, -4.0, -8.0, -2.0, 7.0, 3.0, 3.0, 1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.f), uvec4(0u, 9u, 0u, 3u)) && allOk;
	allOk = compare_vec3((h[0]), vec3(3.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec3((h[1]), vec3(5.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((h[2]), vec3(-7.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec3((h[3]), vec3(9.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((h[4]), vec3(-4.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3((h[5]), vec3(-1.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec3((h[6]), vec3(1.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((h[7]), vec3(0.0, -6.0, -5.0)) && allOk;
	allOk = compare_uint8_t(uint(i), 4u) && allOk;
	allOk = compare_mat4(blockE.l[0], mat4(3.0, 1.0, -6.0, -9.0, -4.0, 5.0, -3.0, 3.0, -6.0, 6.0, 7.0, -3.0, -1.0, -8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(blockE.l[1], mat4(-9.0, -1.0, -2.0, -8.0, -4.0, -2.0, 4.0, 7.0, 0.0, -8.0, 8.0, 6.0, -1.0, 0.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4(blockE.l[2], mat4(-1.0, 3.0, 4.0, -7.0, -2.0, -7.0, -9.0, 3.0, 5.0, 7.0, 9.0, 8.0, 5.0, 1.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4(blockE.l[3], mat4(0.0, 4.0, 0.0, -5.0, 6.0, -5.0, 6.0, 4.0, -6.0, 9.0, 9.0, -1.0, 2.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(blockE.l[4], mat4(3.0, -6.0, 5.0, -4.0, 3.0, -1.0, -3.0, -9.0, 5.0, 0.0, 5.0, -9.0, 5.0, -3.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i8vec2(ivec2(4294967289, 4294967294));
	blockB.a[1] = i8vec2(ivec2(8, 4294967292));
	blockB.a[2] = i8vec2(ivec2(4294967288, 5));
	blockB.a[3] = i8vec2(ivec2(3, 3));
	blockB.a[4] = i8vec2(ivec2(9, 4294967292));
	blockB.a[5] = i8vec2(ivec2(3, 4294967288));
	blockB.b.mA = (mat3x4(-8.0, -8.0, -4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0, -3.0, -9.0, 6.0));
	blockB.b.mB = u8vec4(uvec4(9u, 7u, 7u, 8u));
	blockB.b.mC = (mat4x3(-2.0, -5.0, 9.0, -5.0, -6.0, 0.0, -6.0, 4.0, -7.0, 9.0, 5.0, 9.0));
	blockB.b.mD.mA = (uvec2(3u, 4u));
	blockB.b.mD.mB = (3);
	blockB.b.mD.mC = (vec3(8.0, 4.0, 3.0));
	blockB.b.mD.mD = u8vec4(uvec4(5u, 5u, 9u, 8u));
	blockB.d[0][0] = (uvec2(1u, 2u));
	blockB.d[0][1] = (uvec2(4u, 2u));
	blockB.d[0][2] = (uvec2(1u, 6u));
	blockB.d[0][3] = (uvec2(7u, 9u));
	blockB.d[1][0] = (uvec2(5u, 5u));
	blockB.d[1][1] = (uvec2(5u, 7u));
	blockB.d[1][2] = (uvec2(6u, 4u));
	blockB.d[1][3] = (uvec2(9u, 9u));
	blockB.d[2][0] = (uvec2(5u, 4u));
	blockB.d[2][1] = (uvec2(0u, 3u));
	blockB.d[2][2] = (uvec2(0u, 7u));
	blockB.d[2][3] = (uvec2(0u, 9u));
	blockB.d[3][0] = (uvec2(7u, 1u));
	blockB.d[3][1] = (uvec2(2u, 9u));
	blockB.d[3][2] = (uvec2(2u, 4u));
	blockB.d[3][3] = (uvec2(7u, 6u));
	blockB.d[4][0] = (uvec2(6u, 5u));
	blockB.d[4][1] = (uvec2(0u, 4u));
	blockB.d[4][2] = (uvec2(4u, 6u));
	blockB.d[4][3] = (uvec2(1u, 9u));
	blockB.d[5][0] = (uvec2(2u, 9u));
	blockB.d[5][1] = (uvec2(1u, 2u));
	blockB.d[5][2] = (uvec2(1u, 4u));
	blockB.d[5][3] = (uvec2(8u, 3u));
	blockB.d[6][0] = (uvec2(2u, 9u));
	blockB.d[6][1] = (uvec2(7u, 9u));
	blockB.d[6][2] = (uvec2(3u, 1u));
	blockB.d[6][3] = (uvec2(1u, 8u));
	blockC.g[0].mA[0] = (vec4(-8.0, 1.0, 2.0, -3.0));
	blockC.g[0].mA[1] = (vec4(-8.0, -2.0, 0.0, 3.0));
	blockC.g[0].mB = i8vec3(ivec3(4294967290, 7, 4294967293));
	blockC.g[1].mA[0] = (vec4(8.0, -5.0, 8.0, -9.0));
	blockC.g[1].mA[1] = (vec4(4.0, 1.0, 7.0, 7.0));
	blockC.g[1].mB = i8vec3(ivec3(7, 4294967292, 3));
	blockC.g[2].mA[0] = (vec4(5.0, 8.0, -6.0, 8.0));
	blockC.g[2].mA[1] = (vec4(8.0, 8.0, 5.0, -9.0));
	blockC.g[2].mB = i8vec3(ivec3(4, 9, 4294967291));
	blockC.g[3].mA[0] = (vec4(-3.0, 4.0, -4.0, 5.0));
	blockC.g[3].mA[1] = (vec4(6.0, -6.0, 8.0, 8.0));
	blockC.g[3].mB = i8vec3(ivec3(4294967290, 9, 7));
	blockC.g[4].mA[0] = (vec4(9.0, -5.0, 8.0, -1.0));
	blockC.g[4].mA[1] = (vec4(9.0, -4.0, 2.0, 0.0));
	blockC.g[4].mB = i8vec3(ivec3(1, 4294967295, 4294967291));
	blockC.g[5].mA[0] = (vec4(3.0, -6.0, 1.0, 3.0));
	blockC.g[5].mA[1] = (vec4(-4.0, -3.0, -9.0, 3.0));
	blockC.g[5].mB = i8vec3(ivec3(4294967289, 0, 4294967292));
	blockC.g[6].mA[0] = (vec4(-5.0, -6.0, 4.0, -8.0));
	blockC.g[6].mA[1] = (vec4(-9.0, 6.0, 7.0, -3.0));
	blockC.g[6].mB = i8vec3(ivec3(4294967290, 4, 4294967290));
	h[0] = (vec3(-7.0, -9.0, 7.0));
	h[1] = (vec3(-3.0, 6.0, -3.0));
	h[2] = (vec3(-2.0, -8.0, -4.0));
	h[3] = (vec3(9.0, -9.0, -9.0));
	h[4] = (vec3(-9.0, 3.0, -2.0));
	h[5] = (vec3(-9.0, -8.0, 6.0));
	h[6] = (vec3(7.0, -5.0, -1.0));
	h[7] = (vec3(3.0, -4.0, 1.0));
	i = uint8_t(7u);
	blockE.l[0] = (mat4(-5.0, 2.0, -2.0, 6.0, 8.0, 3.0, 6.0, 7.0, 3.0, 9.0, -5.0, -8.0, 3.0, -4.0, -8.0, -4.0));
	blockE.l[1] = (mat4(-8.0, 2.0, 3.0, -6.0, -7.0, 4.0, 0.0, -8.0, 7.0, -6.0, 6.0, 0.0, 4.0, 0.0, 3.0, 6.0));
	blockE.l[2] = (mat4(9.0, -5.0, -6.0, -7.0, -3.0, 9.0, 0.0, -4.0, -7.0, 6.0, 9.0, 4.0, -2.0, 7.0, -3.0, 2.0));
	blockE.l[3] = (mat4(-4.0, -2.0, 0.0, 5.0, 5.0, 6.0, -4.0, -8.0, -6.0, -8.0, -2.0, 7.0, 0.0, 5.0, 3.0, 4.0));
	blockE.l[4] = (mat4(4.0, -1.0, -1.0, 1.0, 1.0, -7.0, 4.0, 3.0, 9.0, 6.0, -9.0, 3.0, 9.0, -1.0, 4.0, 6.0));
}
#version 450
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
	layout(offset = 0) highp uvec2 a[1];
	layout(offset = 16) lowp vec3 b;
	layout(offset = 28) bool c;
	layout(offset = 32) bvec2 d;
	layout(offset = 48) lowp vec4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a[0]), uvec2(5u, 7u)) && allOk;
	allOk = compare_vec3((b), vec3(9.0, 7.0, -5.0)) && allOk;
	allOk = compare_bool((c), false) && allOk;
	allOk = compare_vec4((e), vec4(5.0, -7.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(-3.0, -7.0, 6.0));
	c = (true);
	d = (bvec2(true, true));
	e = (vec4(7.0, 9.0, -2.0, 6.0));
}
#version 450
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
	layout(offset = 0) uint8_t a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec2 b;
	layout(offset = 8) int8_t c[1];
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i8vec3 d;
	layout(offset = 3) uint8_t e;
	layout(offset = 16) highp vec4 f[1];
	layout(offset = 32) highp float g;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((b), vec2(4.0, 3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.d), ivec3(3, 4294967291, 4294967292)) && allOk;
	allOk = compare_uint8_t(uint(blockD.e), 3u) && allOk;
	allOk = compare_vec4((blockD.f[0]), vec4(-3.0, -2.0, -3.0, 6.0)) && allOk;
	allOk = compare_float((blockD.g), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint8_t(4u);
	b = (vec2(3.0, -9.0));
	c[0] = int8_t(4294967289);
	blockD.d = i8vec3(ivec3(4294967292, 4294967295, 9));
	blockD.e = uint8_t(0u);
	blockD.f[0] = (vec4(-4.0, 3.0, -7.0, -4.0));
	blockD.g = (0.0);
}
#version 450
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
	bvec4 mB;
	int8_t mC;
};
struct sB
{
	mediump vec2 mA;
	mediump uint mB;
	sA mC;
	mediump mat3 mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp uvec3 a;
} blockB[1];
layout(scalar, binding = 2) readonly buffer BlockC
{
	highp mat2x3 b[][6];
} blockC[1];
layout(scalar, binding = 3) buffer BlockD
{
	sB c;
	u8vec3 d[5];
	lowp ivec4 e;
	highp ivec2 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(2u, 0u, 6u)) && allOk;
	allOk = compare_vec2((c.mA), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_uint((c.mB), 9u) && allOk;
	allOk = compare_vec3((c.mC.mA), vec3(3.0, -4.0, 4.0)) && allOk;
	allOk = compare_bvec4((c.mC.mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_int8_t(int(c.mC.mC), 4294967291) && allOk;
	allOk = compare_mat3(c.mD, mat3(-4.0, -6.0, 3.0, 2.0, 4.0, 8.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_u8vec3(uvec3(d[0]), uvec3(1u, 1u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[1]), uvec3(6u, 2u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[2]), uvec3(4u, 0u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[3]), uvec3(4u, 2u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[4]), uvec3(8u, 3u, 2u)) && allOk;
	allOk = compare_ivec4((e), ivec4(-9, -3, 9, 8)) && allOk;
	allOk = compare_ivec2((f[0]), ivec2(3, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(4u, 3u, 5u));
	c.mA = (vec2(-4.0, -2.0));
	c.mB = (7u);
	c.mC.mA = (vec3(-1.0, 1.0, 8.0));
	c.mC.mB = (bvec4(true, false, true, false));
	c.mC.mC = int8_t(4294967294);
	c.mD = (mat3(-7.0, 5.0, -2.0, -8.0, -7.0, 5.0, 0.0, 5.0, 5.0));
	d[0] = u8vec3(uvec3(7u, 0u, 7u));
	d[1] = u8vec3(uvec3(0u, 5u, 3u));
	d[2] = u8vec3(uvec3(4u, 0u, 3u));
	d[3] = u8vec3(uvec3(0u, 3u, 6u));
	d[4] = u8vec3(uvec3(5u, 0u, 9u));
	e = (ivec4(-4, 6, -7, 3));
	f[0] = (ivec2(1, -2));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer BlockB
{
	bvec3 a[];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((a[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((a[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((a[3]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((a[4]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(3.0, -9.0, -9.0, 1.0, -8.0, 0.0, 1.0, -9.0, 4.0, -4.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec4 var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec4((var), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -1.0, -4.0, 4.0, -7.0, 8.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-6.0, -3.0, -8.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, 8.0, -3.0, 0.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u16vec2 var[];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[4]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[5]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[6]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[7]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[8]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[9]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[10]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[11]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[13]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[14]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[15]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[16]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[17]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[18]), uvec2(1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-1.0, 3.0, -1.0));
	block.var[1] = (vec3(-2.0, -4.0, 1.0));
	block.var[2] = (vec3(2.0, 9.0, -2.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block.var, mat2x4(-3.0, -4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-9.0, 2.0, 2.0, -2.0, -9.0, 4.0, 6.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-2.0, -5.0, -2.0, 4.0, -3.0, -4.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-6.0, -9.0, 0.0, -8.0, -8.0, 5.0, -8.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, -9.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 2.0));
	block.var[1] = (vec2(2.0, -4.0));
	block.var[2] = (vec2(5.0, -4.0));
	block.var[3] = (vec2(-3.0, -3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], -1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-9.0, 4.0, -1.0, 9.0, -3.0, 8.0, 3.0, 2.0));
}
#version 450
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
	i16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var), ivec2(3, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i16vec2(ivec2(6, -2));
}
#version 450
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
	f16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var), vec2(-6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = f16vec2(vec2(-2.0, 4.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-8.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-7.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-8.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(0.0, 7.0, -3.0, -8.0, 8.0, -8.0, -6.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(6.0, 0.0, 4.0, 4.0, -2.0, 5.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-1.0, 4.0, -9.0, -4.0, 5.0, -3.0, 6.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-1.0, -9.0, 2.0, -8.0, 9.0, -1.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(1.0, 8.0, 5.0, -5.0));
	block.var[1] = (vec4(9.0, 8.0, -8.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(1.0, -3.0, -1.0, -4.0, 4.0, -7.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-1.0, 9.0, -3.0, 7.0));
	block.var[1] = (vec4(1.0, -1.0, 6.0, 9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(2.0, 4.0));
	block.var[1] = (vec2(8.0, 4.0));
	block.var[2] = (vec2(0.0, 7.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], 0.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, 0.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, -1.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, 1.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(9.0, 0.0, -4.0, 9.0));
	block.var[1] = (vec4(-6.0, 6.0, -7.0, -9.0));
	block.var[2] = (vec4(-7.0, 0.0, -5.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], 8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-7.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(8.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-4.0, 0.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-5.0, -1.0, -3.0));
	block.var[1] = (vec3(-8.0, 7.0, -1.0));
	block.var[2] = (vec3(-2.0, -9.0, 9.0));
	block.var[3] = (vec3(1.0, 7.0, 2.0));
}
#version 450
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
	u16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var), uvec4(6u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u16vec4(uvec4(0u, 6u, 9u, 4u));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat2(block.var, mat2(-8.0, -5.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var = (mat2(-1.0, -6.0, 9.0, 2.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(9.0, -1.0, 7.0, -5.0, -9.0, 2.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec4(9.0, 8.0, -8.0, -2.0));
	block.var[1] = (vec4(8.0, 5.0, -5.0, -7.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[0][3], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[1][3], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][3], 0.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-4.0, -6.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0] = (vec4(-3.0, -8.0, 8.0, 3.0));
	block.var[1] = (vec4(-2.0, 9.0, 7.0, 0.0));
	block.var[2] = (vec4(-1.0, -6.0, -7.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0, -3.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec3(-1.0, 5.0, -6.0));
	block.var[1] = (vec3(6.0, 0.0, 8.0));
	block.var[2] = (vec3(-4.0, -1.0, 2.0));
	block.var[3] = (vec3(0.0, -2.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_float(block.var[3][0], 6.0) && allOk;
	allOk = compare_float(block.var[3][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][2], 5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(6.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var = (mat4x3(-1.0, -5.0, 5.0, -9.0, -3.0, 5.0, 8.0, 4.0, 6.0, 0.0, 4.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-3.0, 3.0));
	block.var[0][1] = (vec2(4.0, 4.0));
	block.var[1][0] = (vec2(9.0, -9.0));
	block.var[1][1] = (vec2(-5.0, 8.0));
	block.var[2][0] = (vec2(0.0, 4.0));
	block.var[2][1] = (vec2(2.0, -4.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
}
#version 450
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
	u16vec2 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec2(uvec2(8u, 0u));
	block.var[1] = u16vec2(uvec2(6u, 0u));
	block.var[2] = u16vec2(uvec2(6u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0, 1.0, 3.0, -1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0] = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	block.var[1] = (mat3x4(-1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0));
	block.var[2] = (mat3x4(-7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0, 5.0, -9.0, -3.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-7.0, -4.0, 7.0, 7.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-9.0, -7.0, -1.0, 8.0, 0.0, 4.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0] = (vec2(-4.0, -4.0));
	block.var[0][1] = (vec2(2.0, 0.0));
	block.var[0][2] = (vec2(-7.0, 3.0));
	block.var[0][3] = (vec2(9.0, 9.0));
	block.var[1][0] = (vec2(8.0, -9.0));
	block.var[1][1] = (vec2(-9.0, -6.0));
	block.var[1][2] = (vec2(-4.0, -6.0));
	block.var[1][3] = (vec2(-6.0, -8.0));
	block.var[2][0] = (vec2(6.0, -8.0));
	block.var[2][1] = (vec2(-8.0, 3.0));
	block.var[2][2] = (vec2(2.0, 8.0));
	block.var[2][3] = (vec2(5.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[3] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[4] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[5] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[6] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[7] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[8] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[9] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[10] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[11] = (mat2(5.0, 8.0, -2.0, 4.0));
	block.var[12] = (mat2(8.0, -7.0, 0.0, -7.0));
	block.var[13] = (mat2(-6.0, 8.0, 5.0, 2.0));
	block.var[14] = (mat2(5.0, -4.0, 3.0, 8.0));
	block.var[15] = (mat2(0.0, -2.0, 7.0, 4.0));
	block.var[16] = (mat2(4.0, -4.0, 0.0, 7.0));
	block.var[17] = (mat2(-7.0, 7.0, -1.0, 4.0));
	block.var[18] = (mat2(6.0, 1.0, 8.0, -1.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(7.0, -3.0));
	block.var[0][1] = (vec2(-2.0, 4.0));
	block.var[1][0] = (vec2(1.0, -3.0));
	block.var[1][1] = (vec2(2.0, -4.0));
	block.var[2][0] = (vec2(-1.0, 1.0));
	block.var[2][1] = (vec2(-4.0, 3.0));
	block.var[3][0] = (vec2(7.0, -7.0));
	block.var[3][1] = (vec2(2.0, 5.0));
	block.var[4][0] = (vec2(-8.0, 4.0));
	block.var[4][1] = (vec2(8.0, 1.0));
	block.var[5][0] = (vec2(4.0, 6.0));
	block.var[5][1] = (vec2(-9.0, 9.0));
	block.var[6][0] = (vec2(1.0, 5.0));
	block.var[6][1] = (vec2(9.0, -6.0));
	block.var[7][0] = (vec2(-7.0, 5.0));
	block.var[7][1] = (vec2(7.0, 4.0));
	block.var[8][0] = (vec2(7.0, -9.0));
	block.var[8][1] = (vec2(0.0, 6.0));
	block.var[9][0] = (vec2(-1.0, -7.0));
	block.var[9][1] = (vec2(-8.0, 4.0));
	block.var[10][0] = (vec2(5.0, 6.0));
	block.var[10][1] = (vec2(-7.0, 7.0));
	block.var[11][0] = (vec2(-1.0, -5.0));
	block.var[11][1] = (vec2(9.0, -7.0));
	block.var[12][0] = (vec2(-5.0, 8.0));
	block.var[12][1] = (vec2(3.0, 1.0));
	block.var[13][0] = (vec2(-9.0, 7.0));
	block.var[13][1] = (vec2(7.0, 1.0));
	block.var[14][0] = (vec2(-3.0, -9.0));
	block.var[14][1] = (vec2(-7.0, 1.0));
	block.var[15][0] = (vec2(-7.0, 6.0));
	block.var[15][1] = (vec2(2.0, -5.0));
	block.var[16][0] = (vec2(6.0, -3.0));
	block.var[16][1] = (vec2(-5.0, -6.0));
	block.var[17][0] = (vec2(-3.0, 7.0));
	block.var[17][1] = (vec2(9.0, 6.0));
	block.var[18][0] = (vec2(-8.0, 7.0));
	block.var[18][1] = (vec2(0.0, 2.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[3] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[4] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[5] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[6] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[7] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[8] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[9] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[10] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[11] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	block.var[12] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	block.var[13] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	block.var[14] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	block.var[15] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	block.var[16] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	block.var[17] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	block.var[18] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[3][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	block.var[3][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[4][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	block.var[4][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[5][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	block.var[5][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[6][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	block.var[6][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[7][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	block.var[7][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[8][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	block.var[8][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[9][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	block.var[9][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[10][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	block.var[10][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[11][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	block.var[11][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	block.var[12][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	block.var[12][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	block.var[13][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	block.var[13][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	block.var[14][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	block.var[14][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	block.var[15][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	block.var[15][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	block.var[16][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	block.var[16][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	block.var[17][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	block.var[17][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	block.var[18][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	block.var[18][1] = (vec4(1.0, -2.0, 4.0, 5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-2.0, 1.0));
	block.var[0][0][1] = (vec2(-7.0, -1.0));
	block.var[0][1][0] = (vec2(5.0, -3.0));
	block.var[0][1][1] = (vec2(4.0, 8.0));
	block.var[0][2][0] = (vec2(-2.0, -6.0));
	block.var[0][2][1] = (vec2(-5.0, -1.0));
	block.var[1][0][0] = (vec2(3.0, 4.0));
	block.var[1][0][1] = (vec2(-8.0, 6.0));
	block.var[1][1][0] = (vec2(6.0, -2.0));
	block.var[1][1][1] = (vec2(1.0, 3.0));
	block.var[1][2][0] = (vec2(2.0, 1.0));
	block.var[1][2][1] = (vec2(7.0, -2.0));
	block.var[2][0][0] = (vec2(-4.0, 2.0));
	block.var[2][0][1] = (vec2(-1.0, -4.0));
	block.var[2][1][0] = (vec2(-5.0, -8.0));
	block.var[2][1][1] = (vec2(3.0, -7.0));
	block.var[2][2][0] = (vec2(5.0, 0.0));
	block.var[2][2][1] = (vec2(-4.0, -9.0));
	block.var[3][0][0] = (vec2(9.0, 1.0));
	block.var[3][0][1] = (vec2(7.0, 9.0));
	block.var[3][1][0] = (vec2(1.0, 3.0));
	block.var[3][1][1] = (vec2(-3.0, 7.0));
	block.var[3][2][0] = (vec2(1.0, 5.0));
	block.var[3][2][1] = (vec2(4.0, 1.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(5.0, -4.0));
	block.var[0][0][1] = (vec2(5.0, 1.0));
	block.var[0][1][0] = (vec2(-8.0, -1.0));
	block.var[0][1][1] = (vec2(9.0, -8.0));
	block.var[0][2][0] = (vec2(5.0, -4.0));
	block.var[0][2][1] = (vec2(5.0, -2.0));
	block.var[1][0][0] = (vec2(9.0, -9.0));
	block.var[1][0][1] = (vec2(-1.0, 6.0));
	block.var[1][1][0] = (vec2(-4.0, 7.0));
	block.var[1][1][1] = (vec2(-8.0, 1.0));
	block.var[1][2][0] = (vec2(4.0, -4.0));
	block.var[1][2][1] = (vec2(6.0, -5.0));
	block.var[2][0][0] = (vec2(4.0, -3.0));
	block.var[2][0][1] = (vec2(6.0, 7.0));
	block.var[2][1][0] = (vec2(-7.0, -9.0));
	block.var[2][1][1] = (vec2(5.0, 0.0));
	block.var[2][2][0] = (vec2(9.0, 2.0));
	block.var[2][2][1] = (vec2(1.0, -6.0));
	block.var[3][0][0] = (vec2(8.0, -8.0));
	block.var[3][0][1] = (vec2(5.0, -5.0));
	block.var[3][1][0] = (vec2(-5.0, 4.0));
	block.var[3][1][1] = (vec2(5.0, 0.0));
	block.var[3][2][0] = (vec2(6.0, 9.0));
	block.var[3][2][1] = (vec2(5.0, -8.0));
}
#version 450
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
	i8vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var[0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][2]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[0][2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[1][0] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[1][1] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[1][2] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[2][0] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[2][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[2][2] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[3][0] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[3][1] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[3][2] = i8vec4(ivec4(4294967292, 7, 8, 9));
}
#version 450
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
	float16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var[0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][2]), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = float16_t(-8.0);
	block.var[0][1] = float16_t(9.0);
	block.var[0][2] = float16_t(-2.0);
	block.var[1][0] = float16_t(7.0);
	block.var[1][1] = float16_t(8.0);
	block.var[1][2] = float16_t(-9.0);
	block.var[2][0] = float16_t(2.0);
	block.var[2][1] = float16_t(-8.0);
	block.var[2][2] = float16_t(-1.0);
	block.var[3][0] = float16_t(6.0);
	block.var[3][1] = float16_t(-7.0);
	block.var[3][2] = float16_t(-5.0);
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(-6.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-5.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(4.0, 5.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-1.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(2.0, -8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(0.0, 7.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-7.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-5.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-9.0, -1.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(4.0, -9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(6.0, 3.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0] = (mat2(2.0, -8.0, -6.0, 2.0));
	block.var[0][1] = (mat2(-3.0, 9.0, -5.0, 4.0));
	block.var[0][2] = (mat2(-2.0, -6.0, -9.0, -2.0));
	block.var[1][0] = (mat2(-5.0, -1.0, 4.0, 3.0));
	block.var[1][1] = (mat2(6.0, 0.0, 1.0, -2.0));
	block.var[1][2] = (mat2(2.0, 8.0, -5.0, -2.0));
	block.var[2][0] = (mat2(-8.0, 6.0, -7.0, 2.0));
	block.var[2][1] = (mat2(-8.0, 4.0, 3.0, 7.0));
	block.var[2][2] = (mat2(8.0, -1.0, -3.0, 7.0));
	block.var[3][0] = (mat2(5.0, -2.0, -8.0, -5.0));
	block.var[3][1] = (mat2(-2.0, 1.0, -2.0, 6.0));
	block.var[3][2] = (mat2(1.0, 8.0, 0.0, 1.0));
}
#version 450
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
	u8vec2 var[4][2][3];
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
	allOk = compare_u8vec2(uvec2(block.var[0][0][2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][2]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][1]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][1]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][2]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec2(uvec2(7u, 7u));
	block.var[0][0][1] = u8vec2(uvec2(9u, 6u));
	block.var[0][0][2] = u8vec2(uvec2(0u, 2u));
	block.var[0][1][0] = u8vec2(uvec2(1u, 8u));
	block.var[0][1][1] = u8vec2(uvec2(4u, 0u));
	block.var[0][1][2] = u8vec2(uvec2(2u, 7u));
	block.var[1][0][0] = u8vec2(uvec2(1u, 1u));
	block.var[1][0][1] = u8vec2(uvec2(0u, 8u));
	block.var[1][0][2] = u8vec2(uvec2(8u, 5u));
	block.var[1][1][0] = u8vec2(uvec2(2u, 0u));
	block.var[1][1][1] = u8vec2(uvec2(2u, 5u));
	block.var[1][1][2] = u8vec2(uvec2(3u, 4u));
	block.var[2][0][0] = u8vec2(uvec2(2u, 7u));
	block.var[2][0][1] = u8vec2(uvec2(4u, 4u));
	block.var[2][0][2] = u8vec2(uvec2(7u, 2u));
	block.var[2][1][0] = u8vec2(uvec2(7u, 4u));
	block.var[2][1][1] = u8vec2(uvec2(0u, 1u));
	block.var[2][1][2] = u8vec2(uvec2(2u, 3u));
	block.var[3][0][0] = u8vec2(uvec2(4u, 5u));
	block.var[3][0][1] = u8vec2(uvec2(0u, 2u));
	block.var[3][0][2] = u8vec2(uvec2(1u, 8u));
	block.var[3][1][0] = u8vec2(uvec2(5u, 4u));
	block.var[3][1][1] = u8vec2(uvec2(4u, 2u));
	block.var[3][1][2] = u8vec2(uvec2(1u, 9u));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 1.0));
	block.var[0][0][0][1] = (vec2(-7.0, -1.0));
	block.var[0][0][1][0] = (vec2(5.0, -3.0));
	block.var[0][0][1][1] = (vec2(4.0, 8.0));
	block.var[0][0][2][0] = (vec2(-2.0, -6.0));
	block.var[0][0][2][1] = (vec2(-5.0, -1.0));
	block.var[0][1][0][0] = (vec2(-7.0, 2.0));
	block.var[0][1][0][1] = (vec2(-9.0, 3.0));
	block.var[0][1][1][0] = (vec2(7.0, 9.0));
	block.var[0][1][1][1] = (vec2(-8.0, 3.0));
	block.var[0][1][2][0] = (vec2(-8.0, -9.0));
	block.var[0][1][2][1] = (vec2(3.0, -5.0));
	block.var[1][0][0][0] = (vec2(3.0, 4.0));
	block.var[1][0][0][1] = (vec2(-8.0, 6.0));
	block.var[1][0][1][0] = (vec2(6.0, -2.0));
	block.var[1][0][1][1] = (vec2(1.0, 3.0));
	block.var[1][0][2][0] = (vec2(2.0, 1.0));
	block.var[1][0][2][1] = (vec2(7.0, -2.0));
	block.var[1][1][0][0] = (vec2(7.0, 8.0));
	block.var[1][1][0][1] = (vec2(-8.0, 4.0));
	block.var[1][1][1][0] = (vec2(-4.0, 7.0));
	block.var[1][1][1][1] = (vec2(-4.0, -8.0));
	block.var[1][1][2][0] = (vec2(1.0, 0.0));
	block.var[1][1][2][1] = (vec2(0.0, -9.0));
	block.var[2][0][0][0] = (vec2(-4.0, 2.0));
	block.var[2][0][0][1] = (vec2(-1.0, -4.0));
	block.var[2][0][1][0] = (vec2(-5.0, -8.0));
	block.var[2][0][1][1] = (vec2(3.0, -7.0));
	block.var[2][0][2][0] = (vec2(5.0, 0.0));
	block.var[2][0][2][1] = (vec2(-4.0, -9.0));
	block.var[2][1][0][0] = (vec2(-4.0, 7.0));
	block.var[2][1][0][1] = (vec2(4.0, 1.0));
	block.var[2][1][1][0] = (vec2(-1.0, -7.0));
	block.var[2][1][1][1] = (vec2(-5.0, 1.0));
	block.var[2][1][2][0] = (vec2(-1.0, 7.0));
	block.var[2][1][2][1] = (vec2(0.0, 9.0));
	block.var[3][0][0][0] = (vec2(9.0, 1.0));
	block.var[3][0][0][1] = (vec2(7.0, 9.0));
	block.var[3][0][1][0] = (vec2(1.0, 3.0));
	block.var[3][0][1][1] = (vec2(-3.0, 7.0));
	block.var[3][0][2][0] = (vec2(1.0, 5.0));
	block.var[3][0][2][1] = (vec2(4.0, 1.0));
	block.var[3][1][0][0] = (vec2(-6.0, 1.0));
	block.var[3][1][0][1] = (vec2(-3.0, 1.0));
	block.var[3][1][1][0] = (vec2(2.0, -1.0));
	block.var[3][1][1][1] = (vec2(-3.0, 3.0));
	block.var[3][1][2][0] = (vec2(-3.0, -6.0));
	block.var[3][1][2][1] = (vec2(3.0, 2.0));
}
#version 450
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
	u8vec2 var[4][2][3];
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
	allOk = compare_u8vec2(uvec2(block.var[0][0][2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][2]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][1]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][1]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][2]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec2(uvec2(7u, 7u));
	block.var[0][0][1] = u8vec2(uvec2(9u, 6u));
	block.var[0][0][2] = u8vec2(uvec2(0u, 2u));
	block.var[0][1][0] = u8vec2(uvec2(1u, 8u));
	block.var[0][1][1] = u8vec2(uvec2(4u, 0u));
	block.var[0][1][2] = u8vec2(uvec2(2u, 7u));
	block.var[1][0][0] = u8vec2(uvec2(1u, 1u));
	block.var[1][0][1] = u8vec2(uvec2(0u, 8u));
	block.var[1][0][2] = u8vec2(uvec2(8u, 5u));
	block.var[1][1][0] = u8vec2(uvec2(2u, 0u));
	block.var[1][1][1] = u8vec2(uvec2(2u, 5u));
	block.var[1][1][2] = u8vec2(uvec2(3u, 4u));
	block.var[2][0][0] = u8vec2(uvec2(2u, 7u));
	block.var[2][0][1] = u8vec2(uvec2(4u, 4u));
	block.var[2][0][2] = u8vec2(uvec2(7u, 2u));
	block.var[2][1][0] = u8vec2(uvec2(7u, 4u));
	block.var[2][1][1] = u8vec2(uvec2(0u, 1u));
	block.var[2][1][2] = u8vec2(uvec2(2u, 3u));
	block.var[3][0][0] = u8vec2(uvec2(4u, 5u));
	block.var[3][0][1] = u8vec2(uvec2(0u, 2u));
	block.var[3][0][2] = u8vec2(uvec2(1u, 8u));
	block.var[3][1][0] = u8vec2(uvec2(5u, 4u));
	block.var[3][1][1] = u8vec2(uvec2(4u, 2u));
	block.var[3][1][2] = u8vec2(uvec2(1u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0, 1.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0, -7.0, 5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0, 0.0, 8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0, 6.0, -3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0, 1.0, -8.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0, 6.0, 3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0, 6.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0, 8.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0, -3.0, 9.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0, -7.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0, 3.0, 2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0, 3.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0, -2.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0, 5.0, -2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-8.0, -6.0, -3.0, -8.0, 4.0, 4.0, 5.0, -5.0, 3.0, 4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-7.0, 3.0, -2.0, -7.0, 6.0, 6.0, -1.0, -6.0, -8.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0, -8.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0, 4.0, 3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0, 0.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-6.0, -1.0, -5.0, -2.0, -6.0, 4.0, -8.0, 0.0, -4.0, -8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(4.0, -1.0, 1.0, -2.0, -5.0, 9.0, 2.0, -3.0, 9.0, 4.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-5.0, -1.0, 6.0, 9.0, -6.0, -3.0, -6.0, 0.0, -6.0, -8.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0] = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	block.var[0][0][1] = (mat3x4(-1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0));
	block.var[0][0][2] = (mat3x4(-7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0, 5.0, -9.0, -3.0, 0.0));
	block.var[0][1][0] = (mat3x4(7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0, -3.0, -1.0, -2.0, 4.0));
	block.var[0][1][1] = (mat3x4(4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0, -5.0, -8.0, -9.0, 7.0));
	block.var[0][1][2] = (mat3x4(-1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0, 6.0, -3.0, -6.0, -7.0));
	block.var[1][0][0] = (mat3x4(0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0, -2.0, -8.0, -5.0, -1.0));
	block.var[1][0][1] = (mat3x4(2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0, 7.0, 7.0, 7.0, 5.0));
	block.var[1][0][2] = (mat3x4(7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0, 8.0, 9.0, 8.0, -7.0));
	block.var[1][1][0] = (mat3x4(4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0, 4.0, 3.0, -4.0, 1.0));
	block.var[1][1][1] = (mat3x4(8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0, 2.0, 5.0, 6.0, -9.0));
	block.var[1][1][2] = (mat3x4(-8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0, -8.0, 4.0, 0.0, -9.0));
	block.var[2][0][0] = (mat3x4(-8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0, -8.0, -2.0, 9.0, 1.0));
	block.var[2][0][1] = (mat3x4(-4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0, 5.0, 7.0, 5.0, -1.0));
	block.var[2][0][2] = (mat3x4(-6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0, 2.0, 3.0, -5.0, -2.0));
	block.var[2][1][0] = (mat3x4(9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0, -9.0, 8.0, -1.0, 4.0));
	block.var[2][1][1] = (mat3x4(3.0, -7.0, 7.0, 6.0, 9.0, -4.0, 4.0, 0.0, -7.0, 2.0, 7.0, 7.0));
	block.var[2][1][2] = (mat3x4(1.0, 6.0, 4.0, 4.0, 3.0, -2.0, 6.0, -9.0, -5.0, 6.0, 4.0, -6.0));
	block.var[3][0][0] = (mat3x4(-5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0, 9.0, -8.0, 3.0, -3.0));
	block.var[3][0][1] = (mat3x4(-1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0, 2.0, 8.0, 3.0, -7.0));
	block.var[3][0][2] = (mat3x4(-7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0, -5.0, -3.0, 6.0, -3.0));
	block.var[3][1][0] = (mat3x4(-3.0, 7.0, -1.0, 4.0, 4.0, 5.0, 2.0, 5.0, 0.0, 0.0, -3.0, 1.0));
	block.var[3][1][1] = (mat3x4(-5.0, 7.0, -5.0, 0.0, -4.0, 2.0, 3.0, 5.0, 9.0, -5.0, -8.0, 4.0));
	block.var[3][1][2] = (mat3x4(5.0, -9.0, -8.0, -9.0, -7.0, 8.0, 4.0, -2.0, 2.0, 3.0, 5.0, -8.0));
}
#version 450
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
	i8vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0][0]), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0][1]), ivec3(4294967289, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0][2]), ivec3(9, 4294967292, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][0]), ivec3(1, 6, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][1]), ivec3(5, 0, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][2]), ivec3(1, 4294967294, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][1]), ivec3(0, 4294967291, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][2]), ivec3(4294967292, 1, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][0]), ivec3(7, 4294967293, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][1]), ivec3(4294967291, 4294967295, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][0]), ivec3(4294967293, 4294967295, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][1]), ivec3(6, 4294967295, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][2]), ivec3(3, 5, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][0]), ivec3(4294967293, 4294967294, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][1]), ivec3(4294967289, 8, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][2]), ivec3(4294967288, 9, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0][1]), ivec3(7, 4294967290, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0][2]), ivec3(4294967294, 0, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1][0]), ivec3(4294967293, 4294967295, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1][1]), ivec3(3, 4294967295, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1][2]), ivec3(4294967291, 2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967292);
	block.var[0][0][0] = i8vec3(ivec3(0, 0, 7));
	block.var[0][0][1] = i8vec3(ivec3(9, 4294967290, 4294967288));
	block.var[0][0][2] = i8vec3(ivec3(9, 4294967288, 4294967293));
	block.var[0][1][0] = i8vec3(ivec3(4294967293, 7, 4294967293));
	block.var[0][1][1] = i8vec3(ivec3(4294967288, 2, 4294967287));
	block.var[0][1][2] = i8vec3(ivec3(4294967295, 4294967293, 4294967292));
	block.var[1][0][0] = i8vec3(ivec3(3, 4294967295, 9));
	block.var[1][0][1] = i8vec3(ivec3(7, 5, 5));
	block.var[1][0][2] = i8vec3(ivec3(4294967293, 6, 4294967293));
	block.var[1][1][0] = i8vec3(ivec3(4294967290, 4294967295, 4294967287));
	block.var[1][1][1] = i8vec3(ivec3(1, 4294967288, 4294967291));
	block.var[1][1][2] = i8vec3(ivec3(8, 6, 4294967288));
	block.var[2][0][0] = i8vec3(ivec3(4294967295, 3, 5));
	block.var[2][0][1] = i8vec3(ivec3(4294967292, 4294967295, 4294967293));
	block.var[2][0][2] = i8vec3(ivec3(8, 4294967290, 3));
	block.var[2][1][0] = i8vec3(ivec3(4, 8, 4294967288));
	block.var[2][1][1] = i8vec3(ivec3(4294967293, 1, 4294967290));
	block.var[2][1][2] = i8vec3(ivec3(4294967289, 6, 4294967295));
	block.var[3][0][0] = i8vec3(ivec3(7, 4, 4294967292));
	block.var[3][0][1] = i8vec3(ivec3(8, 8, 4294967294));
	block.var[3][0][2] = i8vec3(ivec3(8, 1, 7));
	block.var[3][1][0] = i8vec3(ivec3(4294967289, 1, 4294967292));
	block.var[3][1][1] = i8vec3(ivec3(4294967295, 4294967292, 4294967287));
	block.var[3][1][2] = i8vec3(ivec3(1, 8, 3));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 1.0));
	block.var[0][0][0][1] = (vec2(-7.0, -1.0));
	block.var[0][0][1][0] = (vec2(5.0, -3.0));
	block.var[0][0][1][1] = (vec2(4.0, 8.0));
	block.var[0][1][0][0] = (vec2(-4.0, 2.0));
	block.var[0][1][0][1] = (vec2(-1.0, -4.0));
	block.var[0][1][1][0] = (vec2(-5.0, -8.0));
	block.var[0][1][1][1] = (vec2(3.0, -7.0));
	block.var[0][2][0][0] = (vec2(-7.0, 2.0));
	block.var[0][2][0][1] = (vec2(-9.0, 3.0));
	block.var[0][2][1][0] = (vec2(7.0, 9.0));
	block.var[0][2][1][1] = (vec2(-8.0, 3.0));
	block.var[0][3][0][0] = (vec2(-4.0, 7.0));
	block.var[0][3][0][1] = (vec2(4.0, 1.0));
	block.var[0][3][1][0] = (vec2(-1.0, -7.0));
	block.var[0][3][1][1] = (vec2(-5.0, 1.0));
	block.var[1][0][0][0] = (vec2(-2.0, -6.0));
	block.var[1][0][0][1] = (vec2(-5.0, -1.0));
	block.var[1][0][1][0] = (vec2(3.0, 4.0));
	block.var[1][0][1][1] = (vec2(-8.0, 6.0));
	block.var[1][1][0][0] = (vec2(5.0, 0.0));
	block.var[1][1][0][1] = (vec2(-4.0, -9.0));
	block.var[1][1][1][0] = (vec2(9.0, 1.0));
	block.var[1][1][1][1] = (vec2(7.0, 9.0));
	block.var[1][2][0][0] = (vec2(-8.0, -9.0));
	block.var[1][2][0][1] = (vec2(3.0, -5.0));
	block.var[1][2][1][0] = (vec2(7.0, 8.0));
	block.var[1][2][1][1] = (vec2(-8.0, 4.0));
	block.var[1][3][0][0] = (vec2(-1.0, 7.0));
	block.var[1][3][0][1] = (vec2(0.0, 9.0));
	block.var[1][3][1][0] = (vec2(-6.0, 1.0));
	block.var[1][3][1][1] = (vec2(-3.0, 1.0));
	block.var[2][0][0][0] = (vec2(6.0, -2.0));
	block.var[2][0][0][1] = (vec2(1.0, 3.0));
	block.var[2][0][1][0] = (vec2(2.0, 1.0));
	block.var[2][0][1][1] = (vec2(7.0, -2.0));
	block.var[2][1][0][0] = (vec2(1.0, 3.0));
	block.var[2][1][0][1] = (vec2(-3.0, 7.0));
	block.var[2][1][1][0] = (vec2(1.0, 5.0));
	block.var[2][1][1][1] = (vec2(4.0, 1.0));
	block.var[2][2][0][0] = (vec2(-4.0, 7.0));
	block.var[2][2][0][1] = (vec2(-4.0, -8.0));
	block.var[2][2][1][0] = (vec2(1.0, 0.0));
	block.var[2][2][1][1] = (vec2(0.0, -9.0));
	block.var[2][3][0][0] = (vec2(2.0, -1.0));
	block.var[2][3][0][1] = (vec2(-3.0, 3.0));
	block.var[2][3][1][0] = (vec2(-3.0, -6.0));
	block.var[2][3][1][1] = (vec2(3.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, -3.0, -9.0, 2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(5.0, 2.0, 7.0, -1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(9.0, 7.0, -8.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(7.0, -7.0, -2.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][0][1] = (vec2(1.0, 8.0));
	block.var[0][0][0][2] = (vec2(-7.0, 5.0));
	block.var[0][0][1][0] = (vec2(2.0, 0.0));
	block.var[0][0][1][1] = (vec2(-3.0, 1.0));
	block.var[0][0][1][2] = (vec2(2.0, -5.0));
	block.var[0][1][0][0] = (vec2(9.0, -9.0));
	block.var[0][1][0][1] = (vec2(0.0, -6.0));
	block.var[0][1][0][2] = (vec2(-7.0, 7.0));
	block.var[0][1][1][0] = (vec2(-8.0, 7.0));
	block.var[0][1][1][1] = (vec2(9.0, 6.0));
	block.var[0][1][1][2] = (vec2(-1.0, 0.0));
	block.var[0][2][0][0] = (vec2(2.0, -2.0));
	block.var[0][2][0][1] = (vec2(-2.0, -8.0));
	block.var[0][2][0][2] = (vec2(7.0, -7.0));
	block.var[0][2][1][0] = (vec2(-1.0, 6.0));
	block.var[0][2][1][1] = (vec2(-8.0, 4.0));
	block.var[0][2][1][2] = (vec2(-5.0, 3.0));
	block.var[0][3][0][0] = (vec2(4.0, -9.0));
	block.var[0][3][0][1] = (vec2(-4.0, 4.0));
	block.var[0][3][0][2] = (vec2(5.0, 3.0));
	block.var[0][3][1][0] = (vec2(-3.0, -5.0));
	block.var[0][3][1][1] = (vec2(5.0, 1.0));
	block.var[0][3][1][2] = (vec2(3.0, -3.0));
	block.var[1][0][0][0] = (vec2(6.0, 3.0));
	block.var[1][0][0][1] = (vec2(6.0, 5.0));
	block.var[1][0][0][2] = (vec2(-5.0, 9.0));
	block.var[1][0][1][0] = (vec2(-8.0, 9.0));
	block.var[1][0][1][1] = (vec2(3.0, -3.0));
	block.var[1][0][1][2] = (vec2(3.0, -5.0));
	block.var[1][1][0][0] = (vec2(-3.0, 6.0));
	block.var[1][1][0][1] = (vec2(-1.0, -6.0));
	block.var[1][1][0][2] = (vec2(-1.0, -3.0));
	block.var[1][1][1][0] = (vec2(0.0, -1.0));
	block.var[1][1][1][1] = (vec2(4.0, -9.0));
	block.var[1][1][1][2] = (vec2(1.0, 1.0));
	block.var[1][2][0][0] = (vec2(-9.0, -8.0));
	block.var[1][2][0][1] = (vec2(8.0, -9.0));
	block.var[1][2][0][2] = (vec2(-1.0, 1.0));
	block.var[1][2][1][0] = (vec2(0.0, 2.0));
	block.var[1][2][1][1] = (vec2(-1.0, -9.0));
	block.var[1][2][1][2] = (vec2(3.0, 4.0));
	block.var[1][3][0][0] = (vec2(-1.0, -6.0));
	block.var[1][3][0][1] = (vec2(-6.0, 8.0));
	block.var[1][3][0][2] = (vec2(-3.0, 7.0));
	block.var[1][3][1][0] = (vec2(-6.0, 6.0));
	block.var[1][3][1][1] = (vec2(6.0, 7.0));
	block.var[1][3][1][2] = (vec2(3.0, -9.0));
	block.var[2][0][0][0] = (vec2(7.0, -8.0));
	block.var[2][0][0][1] = (vec2(3.0, 1.0));
	block.var[2][0][0][2] = (vec2(-2.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, -9.0));
	block.var[2][0][1][1] = (vec2(3.0, 6.0));
	block.var[2][0][1][2] = (vec2(7.0, 1.0));
	block.var[2][1][0][0] = (vec2(-9.0, 7.0));
	block.var[2][1][0][1] = (vec2(0.0, 4.0));
	block.var[2][1][0][2] = (vec2(-3.0, -3.0));
	block.var[2][1][1][0] = (vec2(6.0, 8.0));
	block.var[2][1][1][1] = (vec2(-7.0, 5.0));
	block.var[2][1][1][2] = (vec2(-6.0, -5.0));
	block.var[2][2][0][0] = (vec2(6.0, -1.0));
	block.var[2][2][0][1] = (vec2(-4.0, -4.0));
	block.var[2][2][0][2] = (vec2(0.0, -6.0));
	block.var[2][2][1][0] = (vec2(5.0, -8.0));
	block.var[2][2][1][1] = (vec2(6.0, -8.0));
	block.var[2][2][1][2] = (vec2(-5.0, -8.0));
	block.var[2][3][0][0] = (vec2(-4.0, -6.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(6.0, -3.0));
	block.var[2][3][1][0] = (vec2(-1.0, -9.0));
	block.var[2][3][1][1] = (vec2(8.0, -4.0));
	block.var[2][3][1][2] = (vec2(-9.0, -4.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	i16vec4 var[][4][2];
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
	allOk = compare_i16vec4(ivec4(block.var[0][1][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][3][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][3][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][0]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][1]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][0]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][1]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2][0]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2][1]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][3][0]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][3][1]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][0]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][1]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][0]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][1]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2][0]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2][1]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][3][0]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][3][1]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[0][1][0] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[0][1][1] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[0][2][0] = i16vec4(ivec4(7, -1, 8, -5));
	block.var[0][2][1] = i16vec4(ivec4(-9, -6, -2, -2));
	block.var[0][3][0] = i16vec4(ivec4(7, 6, 4, -1));
	block.var[0][3][1] = i16vec4(ivec4(8, 3, 4, 5));
	block.var[1][0][0] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[1][0][1] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[1][1][0] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[1][1][1] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[1][2][0] = i16vec4(ivec4(-3, 8, 7, -4));
	block.var[1][2][1] = i16vec4(ivec4(-2, 0, 6, -2));
	block.var[1][3][0] = i16vec4(ivec4(-3, 5, -8, -5));
	block.var[1][3][1] = i16vec4(ivec4(9, 3, -3, 9));
	block.var[2][0][0] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[2][0][1] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[2][1][0] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[2][1][1] = i16vec4(ivec4(-6, -9, -6, 2));
	block.var[2][2][0] = i16vec4(ivec4(6, -5, -6, -3));
	block.var[2][2][1] = i16vec4(ivec4(4, -4, -4, 9));
	block.var[2][3][0] = i16vec4(ivec4(1, -5, 8, -2));
	block.var[2][3][1] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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
	f16vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var[0][0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][3][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][3][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][1]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][0]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2][0]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2][1]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][3][0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][3][1]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][1]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][1]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2][0]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][3][0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][3][1]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][1][0] = f16vec2(vec2(2.0, 2.0));
	block.var[0][1][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[0][2][0] = f16vec2(vec2(6.0, 0.0));
	block.var[0][2][1] = f16vec2(vec2(3.0, 5.0));
	block.var[0][3][0] = f16vec2(vec2(7.0, -6.0));
	block.var[0][3][1] = f16vec2(vec2(-2.0, -4.0));
	block.var[1][0][0] = f16vec2(vec2(-1.0, 1.0));
	block.var[1][0][1] = f16vec2(vec2(9.0, 4.0));
	block.var[1][1][0] = f16vec2(vec2(5.0, -7.0));
	block.var[1][1][1] = f16vec2(vec2(3.0, 0.0));
	block.var[1][2][0] = f16vec2(vec2(9.0, -9.0));
	block.var[1][2][1] = f16vec2(vec2(-6.0, 7.0));
	block.var[1][3][0] = f16vec2(vec2(5.0, -2.0));
	block.var[1][3][1] = f16vec2(vec2(5.0, 2.0));
	block.var[2][0][0] = f16vec2(vec2(8.0, -8.0));
	block.var[2][0][1] = f16vec2(vec2(1.0, -3.0));
	block.var[2][1][0] = f16vec2(vec2(-2.0, 3.0));
	block.var[2][1][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[2][2][0] = f16vec2(vec2(3.0, -7.0));
	block.var[2][2][1] = f16vec2(vec2(4.0, -5.0));
	block.var[2][3][0] = f16vec2(vec2(8.0, -7.0));
	block.var[2][3][1] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[0][1][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[0][1][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[0][2][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	block.var[0][2][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	block.var[0][3][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	block.var[0][3][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	block.var[1][0][0] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[1][0][1] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[1][1][0] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[1][1][1] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[1][2][0] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	block.var[1][2][1] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	block.var[1][3][0] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	block.var[1][3][1] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	block.var[2][0][0] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[2][0][1] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[2][1][0] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[2][1][1] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	block.var[2][2][0] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	block.var[2][2][1] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	block.var[2][3][0] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	block.var[2][3][1] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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
	bool var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0][0][0]), false) && allOk;
	allOk = compare_bool((block.var[0][0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][1][0]), true) && allOk;
	allOk = compare_bool((block.var[0][1][1]), false) && allOk;
	allOk = compare_bool((block.var[0][2][0]), true) && allOk;
	allOk = compare_bool((block.var[0][2][1]), false) && allOk;
	allOk = compare_bool((block.var[0][3][0]), false) && allOk;
	allOk = compare_bool((block.var[0][3][1]), false) && allOk;
	allOk = compare_bool((block.var[1][0][0]), true) && allOk;
	allOk = compare_bool((block.var[1][0][1]), false) && allOk;
	allOk = compare_bool((block.var[1][1][0]), false) && allOk;
	allOk = compare_bool((block.var[1][1][1]), false) && allOk;
	allOk = compare_bool((block.var[1][2][0]), true) && allOk;
	allOk = compare_bool((block.var[1][2][1]), true) && allOk;
	allOk = compare_bool((block.var[1][3][0]), false) && allOk;
	allOk = compare_bool((block.var[1][3][1]), true) && allOk;
	allOk = compare_bool((block.var[2][0][0]), false) && allOk;
	allOk = compare_bool((block.var[2][0][1]), true) && allOk;
	allOk = compare_bool((block.var[2][1][0]), false) && allOk;
	allOk = compare_bool((block.var[2][1][1]), true) && allOk;
	allOk = compare_bool((block.var[2][2][0]), false) && allOk;
	allOk = compare_bool((block.var[2][2][1]), true) && allOk;
	allOk = compare_bool((block.var[2][3][0]), false) && allOk;
	allOk = compare_bool((block.var[2][3][1]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (false);
	block.var[0][0][1] = (false);
	block.var[0][1][0] = (true);
	block.var[0][1][1] = (true);
	block.var[0][2][0] = (false);
	block.var[0][2][1] = (false);
	block.var[0][3][0] = (true);
	block.var[0][3][1] = (true);
	block.var[1][0][0] = (true);
	block.var[1][0][1] = (true);
	block.var[1][1][0] = (true);
	block.var[1][1][1] = (true);
	block.var[1][2][0] = (true);
	block.var[1][2][1] = (false);
	block.var[1][3][0] = (true);
	block.var[1][3][1] = (true);
	block.var[2][0][0] = (false);
	block.var[2][0][1] = (false);
	block.var[2][1][0] = (false);
	block.var[2][1][1] = (false);
	block.var[2][2][0] = (true);
	block.var[2][2][1] = (false);
	block.var[2][3][0] = (true);
	block.var[2][3][1] = (false);
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-8.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(6.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(9.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-7.0, 1.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-3.0, 3.0));
	block.var[0][0][0][1] = (vec2(4.0, 4.0));
	block.var[0][0][1][0] = (vec2(9.0, -9.0));
	block.var[0][0][1][1] = (vec2(-5.0, 8.0));
	block.var[0][1][0][0] = (vec2(-7.0, -5.0));
	block.var[0][1][0][1] = (vec2(6.0, -6.0));
	block.var[0][1][1][0] = (vec2(-4.0, 0.0));
	block.var[0][1][1][1] = (vec2(2.0, 3.0));
	block.var[0][2][0][0] = (vec2(-3.0, -8.0));
	block.var[0][2][0][1] = (vec2(-4.0, -7.0));
	block.var[0][2][1][0] = (vec2(-9.0, 5.0));
	block.var[0][2][1][1] = (vec2(5.0, -6.0));
	block.var[0][3][0][0] = (vec2(-6.0, -1.0));
	block.var[0][3][0][1] = (vec2(9.0, -5.0));
	block.var[0][3][1][0] = (vec2(-2.0, -2.0));
	block.var[0][3][1][1] = (vec2(9.0, -8.0));
	block.var[1][0][0][0] = (vec2(0.0, 4.0));
	block.var[1][0][0][1] = (vec2(2.0, -4.0));
	block.var[1][0][1][0] = (vec2(-3.0, 3.0));
	block.var[1][0][1][1] = (vec2(-8.0, -7.0));
	block.var[1][1][0][0] = (vec2(-2.0, -4.0));
	block.var[1][1][0][1] = (vec2(-1.0, 1.0));
	block.var[1][1][1][0] = (vec2(8.0, -9.0));
	block.var[1][1][1][1] = (vec2(8.0, -6.0));
	block.var[1][2][0][0] = (vec2(4.0, -1.0));
	block.var[1][2][0][1] = (vec2(-3.0, -8.0));
	block.var[1][2][1][0] = (vec2(1.0, -2.0));
	block.var[1][2][1][1] = (vec2(-6.0, -3.0));
	block.var[1][3][0][0] = (vec2(2.0, 6.0));
	block.var[1][3][0][1] = (vec2(-1.0, 7.0));
	block.var[1][3][1][0] = (vec2(4.0, -9.0));
	block.var[1][3][1][1] = (vec2(-8.0, -4.0));
	block.var[2][0][0][0] = (vec2(-7.0, -6.0));
	block.var[2][0][0][1] = (vec2(-2.0, 1.0));
	block.var[2][0][1][0] = (vec2(-4.0, 3.0));
	block.var[2][0][1][1] = (vec2(0.0, 7.0));
	block.var[2][1][0][0] = (vec2(7.0, -2.0));
	block.var[2][1][0][1] = (vec2(1.0, -2.0));
	block.var[2][1][1][0] = (vec2(-7.0, -6.0));
	block.var[2][1][1][1] = (vec2(8.0, -4.0));
	block.var[2][2][0][0] = (vec2(-5.0, 4.0));
	block.var[2][2][0][1] = (vec2(-7.0, -6.0));
	block.var[2][2][1][0] = (vec2(1.0, -9.0));
	block.var[2][2][1][1] = (vec2(7.0, -1.0));
	block.var[2][3][0][0] = (vec2(6.0, 9.0));
	block.var[2][3][0][1] = (vec2(-3.0, -1.0));
	block.var[2][3][1][0] = (vec2(-1.0, 5.0));
	block.var[2][3][1][1] = (vec2(-8.0, 1.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block.var[0][0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block.var[0][0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[0][0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[0][0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[0][1][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	block.var[0][1][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[0][1][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[0][1][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[0][1][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	block.var[0][1][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[0][1][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[0][1][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[0][2][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	block.var[0][2][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	block.var[0][2][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	block.var[0][2][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	block.var[0][2][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	block.var[0][2][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	block.var[0][2][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	block.var[0][2][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	block.var[0][3][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	block.var[0][3][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	block.var[0][3][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	block.var[0][3][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	block.var[0][3][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	block.var[0][3][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	block.var[0][3][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	block.var[0][3][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	block.var[1][0][0][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block.var[1][0][0][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[1][0][0][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[1][0][0][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[1][0][1][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	block.var[1][0][1][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][1][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][1][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][1][0][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	block.var[1][1][0][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[1][1][0][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[1][1][0][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[1][1][1][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	block.var[1][1][1][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[1][1][1][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[1][1][1][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[1][2][0][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	block.var[1][2][0][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	block.var[1][2][0][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	block.var[1][2][0][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	block.var[1][2][1][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	block.var[1][2][1][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	block.var[1][2][1][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	block.var[1][2][1][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	block.var[1][3][0][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	block.var[1][3][0][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	block.var[1][3][0][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	block.var[1][3][0][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	block.var[1][3][1][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	block.var[1][3][1][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	block.var[1][3][1][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	block.var[1][3][1][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	block.var[2][0][0][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	block.var[2][0][0][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[2][0][0][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[2][0][0][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[2][0][1][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	block.var[2][0][1][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[2][0][1][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[2][0][1][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[2][1][0][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	block.var[2][1][0][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[2][1][0][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[2][1][0][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[2][1][1][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	block.var[2][1][1][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[2][1][1][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[2][1][1][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	block.var[2][2][0][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	block.var[2][2][0][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	block.var[2][2][0][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	block.var[2][2][0][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	block.var[2][2][1][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	block.var[2][2][1][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	block.var[2][2][1][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	block.var[2][2][1][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	block.var[2][3][0][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	block.var[2][3][0][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	block.var[2][3][0][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	block.var[2][3][0][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	block.var[2][3][1][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	block.var[2][3][1][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	block.var[2][3][1][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	block.var[2][3][1][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, -3.0, -9.0, 2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(5.0, 2.0, 7.0, -1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(9.0, 7.0, -8.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(7.0, -7.0, -2.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][0][1] = (vec2(1.0, 8.0));
	block.var[0][0][0][2] = (vec2(-7.0, 5.0));
	block.var[0][0][1][0] = (vec2(2.0, 0.0));
	block.var[0][0][1][1] = (vec2(-3.0, 1.0));
	block.var[0][0][1][2] = (vec2(2.0, -5.0));
	block.var[0][1][0][0] = (vec2(9.0, -9.0));
	block.var[0][1][0][1] = (vec2(0.0, -6.0));
	block.var[0][1][0][2] = (vec2(-7.0, 7.0));
	block.var[0][1][1][0] = (vec2(-8.0, 7.0));
	block.var[0][1][1][1] = (vec2(9.0, 6.0));
	block.var[0][1][1][2] = (vec2(-1.0, 0.0));
	block.var[0][2][0][0] = (vec2(2.0, -2.0));
	block.var[0][2][0][1] = (vec2(-2.0, -8.0));
	block.var[0][2][0][2] = (vec2(7.0, -7.0));
	block.var[0][2][1][0] = (vec2(-1.0, 6.0));
	block.var[0][2][1][1] = (vec2(-8.0, 4.0));
	block.var[0][2][1][2] = (vec2(-5.0, 3.0));
	block.var[0][3][0][0] = (vec2(4.0, -9.0));
	block.var[0][3][0][1] = (vec2(-4.0, 4.0));
	block.var[0][3][0][2] = (vec2(5.0, 3.0));
	block.var[0][3][1][0] = (vec2(-3.0, -5.0));
	block.var[0][3][1][1] = (vec2(5.0, 1.0));
	block.var[0][3][1][2] = (vec2(3.0, -3.0));
	block.var[1][0][0][0] = (vec2(6.0, 3.0));
	block.var[1][0][0][1] = (vec2(6.0, 5.0));
	block.var[1][0][0][2] = (vec2(-5.0, 9.0));
	block.var[1][0][1][0] = (vec2(-8.0, 9.0));
	block.var[1][0][1][1] = (vec2(3.0, -3.0));
	block.var[1][0][1][2] = (vec2(3.0, -5.0));
	block.var[1][1][0][0] = (vec2(-3.0, 6.0));
	block.var[1][1][0][1] = (vec2(-1.0, -6.0));
	block.var[1][1][0][2] = (vec2(-1.0, -3.0));
	block.var[1][1][1][0] = (vec2(0.0, -1.0));
	block.var[1][1][1][1] = (vec2(4.0, -9.0));
	block.var[1][1][1][2] = (vec2(1.0, 1.0));
	block.var[1][2][0][0] = (vec2(-9.0, -8.0));
	block.var[1][2][0][1] = (vec2(8.0, -9.0));
	block.var[1][2][0][2] = (vec2(-1.0, 1.0));
	block.var[1][2][1][0] = (vec2(0.0, 2.0));
	block.var[1][2][1][1] = (vec2(-1.0, -9.0));
	block.var[1][2][1][2] = (vec2(3.0, 4.0));
	block.var[1][3][0][0] = (vec2(-1.0, -6.0));
	block.var[1][3][0][1] = (vec2(-6.0, 8.0));
	block.var[1][3][0][2] = (vec2(-3.0, 7.0));
	block.var[1][3][1][0] = (vec2(-6.0, 6.0));
	block.var[1][3][1][1] = (vec2(6.0, 7.0));
	block.var[1][3][1][2] = (vec2(3.0, -9.0));
	block.var[2][0][0][0] = (vec2(7.0, -8.0));
	block.var[2][0][0][1] = (vec2(3.0, 1.0));
	block.var[2][0][0][2] = (vec2(-2.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, -9.0));
	block.var[2][0][1][1] = (vec2(3.0, 6.0));
	block.var[2][0][1][2] = (vec2(7.0, 1.0));
	block.var[2][1][0][0] = (vec2(-9.0, 7.0));
	block.var[2][1][0][1] = (vec2(0.0, 4.0));
	block.var[2][1][0][2] = (vec2(-3.0, -3.0));
	block.var[2][1][1][0] = (vec2(6.0, 8.0));
	block.var[2][1][1][1] = (vec2(-7.0, 5.0));
	block.var[2][1][1][2] = (vec2(-6.0, -5.0));
	block.var[2][2][0][0] = (vec2(6.0, -1.0));
	block.var[2][2][0][1] = (vec2(-4.0, -4.0));
	block.var[2][2][0][2] = (vec2(0.0, -6.0));
	block.var[2][2][1][0] = (vec2(5.0, -8.0));
	block.var[2][2][1][1] = (vec2(6.0, -8.0));
	block.var[2][2][1][2] = (vec2(-5.0, -8.0));
	block.var[2][3][0][0] = (vec2(-4.0, -6.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(6.0, -3.0));
	block.var[2][3][1][0] = (vec2(-1.0, -9.0));
	block.var[2][3][1][1] = (vec2(8.0, -4.0));
	block.var[2][3][1][2] = (vec2(-9.0, -4.0));
}
#version 450
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

struct S
{
	highp ivec3 a;
	highp vec4 c;
};
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(2, 9, 0)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(-3.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-2, 8, -8)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(5, 4, 2)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(-4.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(-7, 8, -2)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(-7.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(5, -3, -2)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-5.0, -8.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(-6, -6, -8)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(1.0, 5.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(0.0, 1.0, 6.0, -6.0));
	block.s[0][0].a = (ivec3(5, 6, -9));
	block.s[0][0].c = (vec4(-2.0, -1.0, -5.0, -4.0));
	block.s[0][1].a = (ivec3(9, -4, 4));
	block.s[0][1].c = (vec4(-9.0, -1.0, 8.0, 7.0));
	block.s[1][0].a = (ivec3(8, 1, 4));
	block.s[1][0].c = (vec4(-2.0, 0.0, 2.0, 6.0));
	block.s[1][1].a = (ivec3(-1, -8, 7));
	block.s[1][1].c = (vec4(2.0, 7.0, -5.0, 3.0));
	block.s[2][0].a = (ivec3(-5, 1, 8));
	block.s[2][0].c = (vec4(8.0, 8.0, 8.0, 9.0));
	block.s[2][1].a = (ivec3(3, -6, 4));
	block.s[2][1].c = (vec4(-9.0, 7.0, -2.0, -2.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	highp uint u;
	T t[];
};
layout (push_constant, std430) uniform PC {
    Block block[3];
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
	allOk = compare_uint((block[0].u), 4u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(8.0, 2.0, -1.0, 5.0, -5.0, 5.0, -9.0, 1.0, -1.0, 7.0, -7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-8.0, -4.0, 5.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(2u, 7u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-6.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(4u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-8.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -6) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-3.0, 2.0, -1.0, -9.0, -9.0, -8.0, 2.0, -4.0, 7.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(3u, 9u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-5.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(1u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(3.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(3.0, 2.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-6.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -6) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(4.0, 1.0, 3.0, -6.0, -6.0, 2.0, 3.0, -2.0, -4.0, -8.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(8u, 8u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-6.0, 1.0, 2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(5u, 7u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-2.0, 7.0, -4.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(5u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(2.0, -5.0, -7.0, 1.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -2) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(1.0, -2.0, 2.0, 8.0, 1.0, 4.0, 6.0, 1.0, 7.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(0.0, 0.0, -4.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(6u, 9u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(4.0, 2.0, -1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-9.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-6.0, -3.0, 6.0, 8.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 6) && allOk;
	allOk = compare_uint((block[1].u), 7u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(4.0, -9.0, -1.0, 8.0, -9.0, -9.0, 8.0, -5.0, -4.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(1u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(5.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(2.0, 6.0, -2.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(1u, 3u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 0) && allOk;
	allOk = compare_uint((block[2].u), 6u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(0.0, 0.0, -6.0, 6.0, -5.0, -4.0, 7.0, 5.0, 1.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(8u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-2.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(8u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-4.0, 5.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(2u, 8u, 4u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(3.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-8.0, -7.0, 0.0, 3.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(1u, 5u, 1u));
	block[0].s.b[0] = (vec2(-9.0, 3.0));
	block[0].s.b[1] = (vec2(-7.0, -7.0));
	block[0].s.b[2] = (vec2(9.0, -9.0));
	block[0].s.b[3] = (vec2(-7.0, 6.0));
	block[0].s.c = (vec4(9.0, 4.0, -9.0, 3.0));
	block[0].u = (7u);
	block[1].s.a = (uvec3(8u, 9u, 1u));
	block[1].s.b[0] = (vec2(-9.0, 3.0));
	block[1].s.b[1] = (vec2(8.0, 9.0));
	block[1].s.b[2] = (vec2(1.0, -7.0));
	block[1].s.b[3] = (vec2(9.0, -4.0));
	block[1].s.c = (vec4(5.0, -6.0, -6.0, -5.0));
	block[1].u = (2u);
	block[2].s.a = (uvec3(4u, 0u, 2u));
	block[2].s.b[0] = (vec2(9.0, -6.0));
	block[2].s.b[1] = (vec2(-4.0, -8.0));
	block[2].s.b[2] = (vec2(-4.0, 4.0));
	block[2].s.b[3] = (vec2(-9.0, 3.0));
	block[2].s.c = (vec4(-4.0, 5.0, -7.0, 6.0));
	block[2].u = (6u);
}
#version 450
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
	highp vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block[0].var), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].var), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].var), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec4(-5.0, 8.0, 3.0, -4.0));
	block[1].var = (vec4(-6.0, -1.0, -3.0, 6.0));
	block[2].var = (vec4(5.0, -9.0, 4.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x3(block[0].var, mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block[1].var = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block[2].var = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	int16_t padding;
	i16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block[0].padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(block[0].var), ivec3(4, 8, 7)) && allOk;
	allOk = compare_int16_t(int(block[1].padding), -4) && allOk;
	allOk = compare_i16vec3(ivec3(block[1].var), ivec3(0, 6, -5)) && allOk;
	allOk = compare_int16_t(int(block[2].padding), -9) && allOk;
	allOk = compare_i16vec3(ivec3(block[2].var), ivec3(9, 4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int16_t(6);
	block[0].var = i16vec3(ivec3(1, -2, -3));
	block[1].padding = int16_t(-1);
	block[1].var = i16vec3(ivec3(-4, -2, -2));
	block[2].padding = int16_t(2);
	block[2].var = i16vec3(ivec3(0, -6, -2));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -2.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-5.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_float((blockA[1].a), 9.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(-2.0, -6.0, 3.0, -7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -5.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(-2.0, 5.0, 0.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(8, 3)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(4, 9)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(6, -5)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (1.0);
	blockA[1].a = (-7.0);
	blockA[2].a = (6.0);
	blockB[0].a = (mat3(8.0, -6.0, 6.0, 1.0, -8.0, 5.0, -6.0, -4.0, 9.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(-9.0, 6.0, -5.0, -7.0, 6.0, 3.0, 4.0, 6.0, 7.0));
	blockB[1].d = (true);
	blockB[2].a = (mat3(-2.0, 9.0, 0.0, -6.0, -7.0, 7.0, -5.0, 5.0, 9.0));
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
    BlockA blockA;
    BlockB blockB;
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
	allOk = compare_float((blockA.a), 6.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(1.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (2.0);
	blockA.b.a = (mat3(-5.0, -8.0, 6.0, -9.0, -9.0, -8.0, 0.0, -1.0, -9.0));
	blockA.b.b[0] = (ivec2(2, -5));
	blockA.b.b[1] = (ivec2(6, -6));
	blockA.b.b[2] = (ivec2(-5, -4));
	blockA.b.b[3] = (ivec2(-9, 4));
	blockA.b.c = (vec4(6.0, -9.0, 6.0, 7.0));
	blockB.a = (mat2(1.0, 5.0, 1.0, 7.0));
	blockB.b.a = (2u);
	blockB.b.b.a = (mat3(-3.0, -4.0, 9.0, -3.0, -3.0, -4.0, 4.0, -8.0, -1.0));
	blockB.b.b.b[0] = (ivec2(-1, -8));
	blockB.b.b.b[1] = (ivec2(4, -9));
	blockB.b.b.b[2] = (ivec2(-6, -5));
	blockB.b.b.b[3] = (ivec2(7, -8));
	blockB.b.b.c = (vec4(5.0, 2.0, -1.0, -3.0));
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

layout(std140, buffer_reference) buffer BlockB
{
	mediump int a;
	mediump int b;
	highp int c;
	lowp uint d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint e;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp int f;
	mediump int g;
	bool h[1];
	lowp uint i;
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
	allOk = compare_int((blockB.c), 8) && allOk;
	allOk = compare_uint((blockB.d), 4u) && allOk;
	allOk = compare_int((blockD.g), 9) && allOk;
	allOk = compare_bool((blockD.h[0]), false) && allOk;
	allOk = compare_uint((blockD.i), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5);
	blockB.b = (-3);
	blockC.e = (8u);
	blockD.h[0] = (false);
	blockD.i = (6u);
}
#version 450
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
	mediump uvec4 a[1];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump ivec4 b;
	mediump float c;
	highp ivec3 d;
	lowp float e;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp uvec3 f;
	mediump vec3 g;
	lowp ivec3 h;
	lowp uint i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockC.b), ivec4(0, -7, 7, -2)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(9, 1, -5)) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(7u, 0u, 5u)) && allOk;
	allOk = compare_vec3((blockD.g), vec3(-9.0, -6.0, -9.0)) && allOk;
	allOk = compare_uint((blockD.i), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(4u, 4u, 9u, 1u));
	blockC.b = (ivec4(-4, 2, -1, 9));
	blockC.c = (-3.0);
	blockC.d = (ivec3(5, -8, -2));
	blockD.g = (vec3(-6.0, 9.0, 4.0));
	blockD.i = (2u);
}
#version 450
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
	lowp mat4 a;
	lowp ivec2 b;
	mediump mat2 c;
	lowp ivec3 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bool e;
	bool f;
	lowp mat2 g[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump vec2 h;
	mediump ivec3 i[];
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat4x2 j;
	lowp uint k;
	lowp ivec2 l;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.c, mat2(0.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_bool((blockC.e), true) && allOk;
	allOk = compare_mat2(blockC.g[0], mat2(1.0, 7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2(blockC.g[1], mat2(8.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.g[2], mat2(-1.0, 1.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2(blockC.g[3], mat2(5.0, 0.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(blockC.g[4], mat2(1.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.g[5], mat2(-5.0, -7.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec2((blockD.h), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockE.l), ivec2(-1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(-1, -9));
	blockB.c = (mat2(1.0, 1.0, 7.0, 8.0));
	blockC.e = (true);
	blockC.f = (false);
	blockC.g[0] = (mat2(-9.0, 3.0, -7.0, -4.0));
	blockC.g[1] = (mat2(-6.0, -5.0, 3.0, -9.0));
	blockC.g[2] = (mat2(-6.0, -3.0, -7.0, -1.0));
	blockC.g[3] = (mat2(-5.0, 6.0, -5.0, -6.0));
	blockC.g[4] = (mat2(8.0, 9.0, 6.0, -9.0));
	blockC.g[5] = (mat2(4.0, 7.0, -3.0, 0.0));
	blockD.h = (vec2(8.0, -9.0));
	blockD.i[0] = (ivec3(-1, 8, 3));
	blockD.i[1] = (ivec3(-6, 7, 0));
	blockE.j = (mat4x2(5.0, -9.0, 0.0, -2.0, -6.0, -3.0, -7.0, 9.0));
	blockE.k = (2u);
	blockE.l = (ivec2(-5, -2));
}
#version 450
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
	lowp uvec4 mA;
};
struct sB
{
	highp mat4x3 mA;
	sA mB;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	mediump uvec2 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump uvec2 b;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat3x4 c;
	lowp ivec2 d;
	sB e;
	lowp uvec4 f[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	lowp float g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockD.c, mat3x4(4.0, 0.0, -5.0, -8.0, -6.0, 4.0, 5.0, 6.0, -6.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockD.d), ivec2(-7, 7)) && allOk;
	allOk = compare_mat4x3(blockD.e.mA, mat4x3(5.0, 8.0, 5.0, -9.0, -8.0, 6.0, 2.0, 3.0, -7.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockD.e.mB.mA), uvec4(7u, 9u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (uvec2(4u, 5u));
	blockD.c = (mat3x4(6.0, 0.0, 9.0, 5.0, 4.0, 8.0, 6.0, 7.0, -5.0, 5.0, -2.0, 7.0));
	blockD.d = (ivec2(4, 7));
	blockD.e.mA = (mat4x3(0.0, 9.0, -4.0, -5.0, 4.0, 9.0, -7.0, -6.0, -2.0, -4.0, 8.0, -6.0));
	blockD.e.mB.mA = (uvec4(4u, 6u, 3u, 4u));
}
#version 450
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
	bvec2 mB;
	highp ivec4 mC;
	mediump vec3 mD;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump ivec4 a;
	highp ivec4 b;
	lowp mat2 c;
	highp uvec3 d;
	bvec3 e[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	sA f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(6, 8, 4, -9)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(-4, 4, 0, 7)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_int((blockC.f[0].mA), 2) && allOk;
	allOk = compare_bvec2((blockC.f[0].mB), bvec2(false, true)) && allOk;
	allOk = compare_ivec4((blockC.f[0].mC), ivec4(4, 5, 6, -1)) && allOk;
	allOk = compare_vec3((blockC.f[0].mD), vec3(-1.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.e[0] = (bvec3(false, true, false));
	blockB.e[1] = (bvec3(true, true, true));
	blockB.e[2] = (bvec3(false, false, false));
	blockB.e[3] = (bvec3(false, false, true));
	blockB.e[4] = (bvec3(false, false, true));
	blockB.e[5] = (bvec3(false, true, false));
	blockB.e[6] = (bvec3(false, true, true));
	blockB.e[7] = (bvec3(true, true, false));
}
#version 450
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
	highp mat3x2 a;
	highp int b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(8.0, 6.0, 7.0, 0.0, -2.0, 5.0));
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 12) float16_t b;
	layout(offset = 16) i16vec2 c;
	layout(offset = 20) mediump vec2 d;
	layout(offset = 28) bool e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec3 g;
	layout(offset = 16) mediump vec4 h;
	layout(offset = 32) mediump uvec2 i;
	layout(offset = 40) lowp uint j;
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.c), ivec2(0, -3)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.g), uvec3(5u, 1u, 1u)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(6.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_uint((blockD.j), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(5.0, -5.0, 3.0));
	blockB.b = float16_t(9.0);
	blockB.c = i16vec2(ivec2(-5, -5));
	blockB.d = (vec2(0.0, -1.0));
	blockB.e = (false);
	blockC.f = (bvec4(true, false, false, false));
	blockD.g = u16vec3(uvec3(3u, 0u, 5u));
	blockD.h = (vec4(-4.0, -2.0, -9.0, -8.0));
	blockD.i = (uvec2(3u, 7u));
	blockD.j = (4u);
}
#version 450
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
	layout(offset = 0) lowp ivec3 a;
	layout(offset = 16) highp uvec3 b;
	layout(offset = 32) i16vec4 c;
	layout(offset = 40) highp vec2 d;
	layout(offset = 48) lowp float e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec4 f;
	layout(offset = 16) int16_t g;
	layout(offset = 20) highp vec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[0].a), ivec3(-7, 8, 8)) && allOk;
	allOk = compare_uvec3((blockB[0].b), uvec3(2u, 7u, 8u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c), ivec4(-2, 6, -1, 5)) && allOk;
	allOk = compare_vec2((blockB[0].d), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockB[1].a), ivec3(-9, 2, 0)) && allOk;
	allOk = compare_uvec3((blockB[1].b), uvec3(7u, 2u, 9u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c), ivec4(7, 0, -2, -5)) && allOk;
	allOk = compare_vec2((blockB[1].d), vec2(2.0, 4.0)) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(6u, 9u, 7u, 7u)) && allOk;
	allOk = compare_int16_t(int(blockC.g), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec3(0, -7, 3));
	blockB[0].c = i16vec4(ivec4(4, 6, -8, 8));
	blockB[0].e = (-3.0);
	blockB[1].a = (ivec3(-1, 6, 9));
	blockB[1].c = i16vec4(ivec4(-2, 2, -3, -9));
	blockB[1].e = (5.0);
	blockC.g = int16_t(-3);
	blockC.h = (vec2(-3.0, -8.0));
}
#version 450
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
	layout(offset = 0) highp float a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-8.0);
}
#version 450
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
	highp uvec3 mB;
	lowp uvec4 mC;
};
struct sB
{
	highp uvec3 mA;
	mediump mat3x4 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	f16vec4 a;
	highp float b;
	sA c;
	lowp mat3 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	i16vec4 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp mat3x2 f;
	highp ivec4 g;
	sB h[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(1.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.c.mA, mat3x2(-7.0, 1.0, 2.0, 8.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockB.c.mB), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.c.mC), uvec4(5u, 6u, 4u, 1u)) && allOk;
	allOk = compare_mat3(blockB.d[0], mat3(-3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.d[1], mat3(8.0, 5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.d[2], mat3(2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[0]), ivec4(-7, -4, -4, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[1]), ivec4(1, 3, -4, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[2]), ivec4(0, 1, -3, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[3]), ivec4(-6, 6, 5, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[4]), ivec4(2, 4, 9, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[5]), ivec4(5, -2, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[6]), ivec4(1, -8, -9, 5)) && allOk;
	allOk = compare_mat3x2(blockD.f, mat3x2(1.0, -3.0, -5.0, 6.0, 5.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(2, 4, 4, -3)) && allOk;
	allOk = compare_uvec3((blockD.h[0].mA), uvec3(2u, 3u, 4u)) && allOk;
	allOk = compare_mat3x4(blockD.h[0].mB, mat3x4(-2.0, -8.0, -6.0, -4.0, -6.0, 7.0, 8.0, 6.0, 4.0, 1.0, 4.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockD.h[1].mA), uvec3(3u, 7u, 5u)) && allOk;
	allOk = compare_mat3x4(blockD.h[1].mB, mat3x4(7.0, 4.0, 4.0, 1.0, -2.0, 1.0, -3.0, -2.0, -7.0, -2.0, 6.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockD.h[2].mA), uvec3(4u, 1u, 5u)) && allOk;
	allOk = compare_mat3x4(blockD.h[2].mB, mat3x4(2.0, -5.0, -6.0, 3.0, -8.0, 7.0, 5.0, -8.0, -6.0, 5.0, -5.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockD.h[3].mA), uvec3(2u, 0u, 9u)) && allOk;
	allOk = compare_mat3x4(blockD.h[3].mB, mat3x4(5.0, 5.0, -8.0, -9.0, -9.0, -8.0, -7.0, 2.0, 7.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockD.h[4].mA), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_mat3x4(blockD.h[4].mB, mat3x4(-1.0, -7.0, 7.0, 9.0, -1.0, 9.0, 7.0, -4.0, 7.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockD.h[5].mA), uvec3(2u, 8u, 9u)) && allOk;
	allOk = compare_mat3x4(blockD.h[5].mB, mat3x4(6.0, -6.0, 6.0, 9.0, 4.0, -2.0, 6.0, 7.0, 1.0, -8.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-8.0);
	blockB.c.mA = (mat3x2(-5.0, 0.0, 0.0, -7.0, 5.0, 3.0));
	blockB.c.mB = (uvec3(5u, 2u, 0u));
	blockB.c.mC = (uvec4(2u, 7u, 3u, 6u));
	blockB.d[0] = (mat3(8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0, -2.0, -7.0));
	blockB.d[1] = (mat3(-5.0, 7.0, -9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0));
	blockB.d[2] = (mat3(1.0, 8.0, 8.0, -9.0, -8.0, 4.0, 8.0, 5.0, 3.0));
	blockC.e[0] = i16vec4(ivec4(5, -4, 8, 8));
	blockC.e[1] = i16vec4(ivec4(0, -8, 1, -8));
	blockC.e[2] = i16vec4(ivec4(2, -7, -2, 2));
	blockC.e[3] = i16vec4(ivec4(-5, -5, -8, -6));
	blockC.e[4] = i16vec4(ivec4(-3, -6, -4, -7));
	blockC.e[5] = i16vec4(ivec4(7, 6, 9, -9));
	blockC.e[6] = i16vec4(ivec4(3, 4, 2, -6));
	blockD.g = (ivec4(3, -9, -6, 1));
}
#version 450
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
	u16vec4 mA[3];
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec3 a;
	sA b;
	lowp mat3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.b.mA[0]), uvec4(2u, 1u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b.mA[1]), uvec4(0u, 3u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b.mA[2]), uvec4(7u, 5u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.b.mA[0] = u16vec4(uvec4(0u, 6u, 4u, 7u));
	blockB.b.mA[1] = u16vec4(uvec4(2u, 7u, 2u, 6u));
	blockB.b.mA[2] = u16vec4(uvec4(8u, 3u, 8u, 3u));
	blockB.c[0] = (mat3(4.0, 9.0, -6.0, -6.0, 1.0, 9.0, -6.0, -6.0, 7.0));
	blockB.c[1] = (mat3(2.0, -1.0, -6.0, -2.0, 6.0, -9.0, -9.0, -1.0, 8.0));
	blockB.c[2] = (mat3(-9.0, 9.0, -9.0, 4.0, 0.0, 1.0, -2.0, 6.0, -4.0));
	blockB.c[3] = (mat3(-3.0, -9.0, 5.0, 7.0, -4.0, 0.0, -5.0, 6.0, -7.0));
	blockB.c[4] = (mat3(-7.0, -7.0, -1.0, -6.0, 9.0, 8.0, -3.0, -9.0, -3.0));
	blockB.c[5] = (mat3(-2.0, -1.0, 3.0, 7.0, -1.0, -3.0, -5.0, 7.0, -4.0));
	blockB.c[6] = (mat3(6.0, -6.0, -8.0, 6.0, -4.0, 8.0, 4.0, -8.0, 8.0));
}
#version 450
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
	f16vec4 mA;
};
struct sB
{
	mediump uvec3 mA;
	highp ivec2 mB;
	u16vec4 mC;
	sA mD;
};
struct sC
{
	highp uvec4 mA;
	mediump mat2 mB;
	f16vec3 mC;
	highp mat4 mD;
};
struct sD
{
	mediump uint mA;
	f16vec3 mB;
	mediump mat3x2 mC;
};
struct sE
{
	mediump mat4 mA;
};
struct sF
{
	lowp mat3x2 mA;
	sD mB;
	sE mC;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	highp mat2 a[2];
	int16_t b;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	sB c;
	sC d;
	u16vec3 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	sF f;
	u16vec4 g;
	bvec3 h;
	highp ivec2 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.b), -4) && allOk;
	allOk = compare_uvec4((blockC[0].d.mA), uvec4(7u, 9u, 3u, 0u)) && allOk;
	allOk = compare_mat2(blockC[0].d.mB, mat2(9.0, 2.0, -3.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].d.mC), vec3(8.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC[0].d.mD, mat4(7.0, -7.0, -1.0, 4.0, -4.0, 8.0, 7.0, -5.0, 6.0, 8.0, -8.0, 1.0, -8.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].e[0]), uvec3(1u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].e[1]), uvec3(5u, 6u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].e[2]), uvec3(5u, 7u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].e[3]), uvec3(6u, 3u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].e[4]), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].e[5]), uvec3(8u, 4u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].e[6]), uvec3(0u, 3u, 8u)) && allOk;
	allOk = compare_uvec4((blockC[1].d.mA), uvec4(3u, 2u, 2u, 4u)) && allOk;
	allOk = compare_mat2(blockC[1].d.mB, mat2(-2.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].d.mC), vec3(-4.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC[1].d.mD, mat4(-1.0, -8.0, 9.0, 8.0, -6.0, -1.0, 5.0, 8.0, -6.0, 8.0, -3.0, -7.0, -8.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].e[0]), uvec3(7u, 9u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].e[1]), uvec3(3u, 4u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].e[2]), uvec3(5u, 2u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].e[3]), uvec3(0u, 3u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].e[4]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].e[5]), uvec3(7u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].e[6]), uvec3(0u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockC[2].d.mA), uvec4(4u, 3u, 1u, 5u)) && allOk;
	allOk = compare_mat2(blockC[2].d.mB, mat2(9.0, 4.0, 2.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[2].d.mC), vec3(0.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[2].d.mD, mat4(4.0, 8.0, -8.0, 2.0, -9.0, 8.0, -2.0, -2.0, -9.0, -3.0, 7.0, -3.0, -8.0, 3.0, 1.0, -3.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].e[0]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].e[1]), uvec3(8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].e[2]), uvec3(7u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].e[3]), uvec3(0u, 2u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].e[4]), uvec3(6u, 0u, 9u)) && allOk;
	allOk = compare_mat3x2(blockD.f.mA, mat3x2(-1.0, 7.0, -8.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_uint((blockD.f.mB.mA), 5u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f.mB.mB), vec3(-6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.f.mB.mC, mat3x2(2.0, 3.0, -5.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4(blockD.f.mC.mA, mat4(-5.0, -9.0, -6.0, -1.0, -2.0, -4.0, 8.0, -5.0, -9.0, 9.0, -7.0, 6.0, -2.0, 2.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockD.i), ivec2(-4, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat2(-1.0, 9.0, 1.0, 3.0));
	blockB.a[1] = (mat2(5.0, -9.0, 8.0, 2.0));
	blockB.b = int16_t(-7);
	blockC[0].d.mA = (uvec4(7u, 1u, 4u, 2u));
	blockC[0].d.mB = (mat2(8.0, -8.0, 7.0, 2.0));
	blockC[0].d.mC = f16vec3(vec3(-5.0, 3.0, -3.0));
	blockC[0].d.mD = (mat4(5.0, -1.0, -3.0, -1.0, -3.0, 0.0, 2.0, 7.0, 8.0, 2.0, 9.0, 9.0, -5.0, 7.0, -6.0, -2.0));
	blockC[1].d.mA = (uvec4(9u, 5u, 1u, 3u));
	blockC[1].d.mB = (mat2(2.0, -8.0, -9.0, 1.0));
	blockC[1].d.mC = f16vec3(vec3(-3.0, 2.0, 2.0));
	blockC[1].d.mD = (mat4(0.0, -8.0, -5.0, 7.0, -7.0, 8.0, -1.0, 6.0, -9.0, 4.0, 8.0, -1.0, -2.0, -3.0, 8.0, -2.0));
	blockC[2].d.mA = (uvec4(3u, 9u, 1u, 0u));
	blockC[2].d.mB = (mat2(2.0, -5.0, -4.0, -4.0));
	blockC[2].d.mC = f16vec3(vec3(1.0, 8.0, 3.0));
	blockC[2].d.mD = (mat4(-7.0, 4.0, -1.0, -4.0, 3.0, 5.0, -4.0, -7.0, -3.0, 9.0, -4.0, -1.0, -6.0, 5.0, 0.0, 8.0));
	blockD.f.mA = (mat3x2(2.0, -8.0, -8.0, -1.0, 7.0, -4.0));
	blockD.f.mB.mA = (3u);
	blockD.f.mB.mB = f16vec3(vec3(-4.0, -2.0, -4.0));
	blockD.f.mB.mC = (mat3x2(-8.0, 5.0, 2.0, -8.0, 3.0, 6.0));
	blockD.f.mC.mA = (mat4(-5.0, 5.0, -7.0, -7.0, -2.0, -1.0, -5.0, -3.0, -5.0, 6.0, -6.0, -8.0, -4.0, -8.0, 2.0, 0.0));
	blockD.i = (ivec2(3, 8));
}
#version 450
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
	highp mat2 a;
	i16vec4 b;
	i16vec3 c;
	highp uint d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].a, mat2(8.0, -1.0, -5.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(0)].c), ivec3(8, -1, -8)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].a, mat2(-9.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(1)].c), ivec3(2, 1, -8)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(2)].a, mat2(-8.0, 9.0, -7.0, 8.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(2)].c), ivec3(3, 4, -7)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(3)].a, mat2(1.0, -5.0, 0.0, 4.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(3)].c), ivec3(3, 1, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat2(8.0, -4.0, 2.0, 3.0));
	blockB[nonuniformEXT(0)].b = i16vec4(ivec4(-3, 7, -3, 4));
	blockB[nonuniformEXT(0)].c = i16vec3(ivec3(3, -9, 5));
	blockB[nonuniformEXT(0)].d = (6u);
	blockB[nonuniformEXT(1)].a = (mat2(0.0, 2.0, 4.0, -9.0));
	blockB[nonuniformEXT(1)].b = i16vec4(ivec4(-8, 9, -6, -4));
	blockB[nonuniformEXT(1)].c = i16vec3(ivec3(5, -4, -6));
	blockB[nonuniformEXT(1)].d = (6u);
	blockB[nonuniformEXT(2)].a = (mat2(-2.0, 5.0, -8.0, -4.0));
	blockB[nonuniformEXT(2)].b = i16vec4(ivec4(-5, -9, -2, 8));
	blockB[nonuniformEXT(2)].c = i16vec3(ivec3(0, -1, 1));
	blockB[nonuniformEXT(2)].d = (8u);
	blockB[nonuniformEXT(3)].a = (mat2(-4.0, -7.0, -1.0, 1.0));
	blockB[nonuniformEXT(3)].b = i16vec4(ivec4(-5, 2, 6, 8));
	blockB[nonuniformEXT(3)].c = i16vec3(ivec3(-7, 5, 3));
	blockB[nonuniformEXT(3)].d = (8u);
}
#version 450
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
	highp uvec4 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump float d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec4 e;
	mediump int f;
	highp ivec3 g;
	bool h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-2, 4, 3)) && allOk;
	allOk = compare_uvec4((blockB.c[0]), uvec4(9u, 2u, 4u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.c[1]), uvec4(4u, 3u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.c[2]), uvec4(9u, 4u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.c[3]), uvec4(7u, 5u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.c[4]), uvec4(1u, 6u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.c[5]), uvec4(0u, 0u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.c[6]), uvec4(1u, 5u, 8u, 2u)) && allOk;
	allOk = compare_float((blockC.d[0]), -8.0) && allOk;
	allOk = compare_float((blockC.d[1]), 7.0) && allOk;
	allOk = compare_float((blockC.d[2]), 5.0) && allOk;
	allOk = compare_float((blockC.d[3]), -7.0) && allOk;
	allOk = compare_float((blockC.d[4]), -5.0) && allOk;
	allOk = compare_float((blockC.d[5]), -4.0) && allOk;
	allOk = compare_int((blockD.f), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (uvec4(9u, 4u, 3u, 0u));
	blockB.c[1] = (uvec4(6u, 4u, 5u, 2u));
	blockB.c[2] = (uvec4(2u, 0u, 6u, 3u));
	blockB.c[3] = (uvec4(5u, 3u, 4u, 1u));
	blockB.c[4] = (uvec4(8u, 5u, 4u, 0u));
	blockB.c[5] = (uvec4(3u, 6u, 3u, 2u));
	blockB.c[6] = (uvec4(6u, 2u, 9u, 2u));
	blockC.d[0] = (7.0);
	blockC.d[1] = (-2.0);
	blockC.d[2] = (9.0);
	blockC.d[3] = (-6.0);
	blockC.d[4] = (8.0);
	blockC.d[5] = (5.0);
	blockD.e = (bvec4(false, true, true, false));
	blockD.f = (5);
	blockD.g = (ivec3(5, 3, 8));
}
#version 450
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
	bvec3 a;
	highp ivec3 b;
	lowp vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.b = (ivec3(4, 6, -8));
}
#version 450
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
	mediump vec3 a;
	bool b;
	u8vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(4.0, 4.0, -4.0)) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.c[0] = u8vec2(uvec2(6u, 4u));
}
#version 450
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
	mediump mat2 mA;
};
struct sB
{
	mediump ivec4 mA;
	lowp mat4 mB;
	highp mat2x3 mC;
	highp mat3 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump mat4x3 a;
	highp ivec4 b;
	sA c;
	highp vec4 d;
	highp mat4 e[6];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat2x3 f;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	u8vec4 g;
	sB h[][1];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[0].a, mat4x3(-1.0, -5.0, -9.0, -9.0, -9.0, 0.0, 8.0, -9.0, -1.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB[0].d), vec4(-3.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[0], mat4(4.0, 0.0, 4.0, -7.0, 4.0, -5.0, 3.0, 0.0, -7.0, 8.0, -7.0, -8.0, -9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[1], mat4(7.0, -6.0, -6.0, -8.0, -6.0, 9.0, 4.0, 5.0, -1.0, 3.0, -1.0, 8.0, -6.0, 8.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[2], mat4(-1.0, 6.0, -3.0, 5.0, 4.0, 7.0, -9.0, -2.0, 2.0, 0.0, 1.0, -6.0, -7.0, -2.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[3], mat4(3.0, 4.0, -3.0, -5.0, 6.0, 3.0, 5.0, 6.0, -2.0, -8.0, -2.0, -3.0, -6.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[4], mat4(-7.0, 4.0, -9.0, 1.0, -8.0, 9.0, 9.0, -2.0, -6.0, 9.0, 7.0, 6.0, 1.0, 9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[5], mat4(-4.0, -1.0, -9.0, 4.0, 6.0, -7.0, 4.0, -2.0, 1.0, -3.0, 6.0, 4.0, 7.0, 3.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].a, mat4x3(-3.0, 0.0, 7.0, 7.0, 4.0, -7.0, -7.0, -7.0, -5.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB[1].d), vec4(4.0, -7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[0], mat4(2.0, -8.0, 2.0, -9.0, 8.0, -5.0, 1.0, 7.0, 6.0, 5.0, 1.0, 9.0, 4.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[1], mat4(3.0, 2.0, 3.0, 2.0, -4.0, 2.0, -1.0, 7.0, 9.0, 7.0, -7.0, 3.0, 5.0, -6.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[2], mat4(-5.0, -6.0, 9.0, 7.0, -6.0, -8.0, -8.0, -5.0, 5.0, -7.0, -2.0, 7.0, 4.0, 8.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[3], mat4(-5.0, -6.0, -9.0, -7.0, 8.0, -2.0, 8.0, 0.0, 7.0, -6.0, 5.0, 3.0, 2.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[4], mat4(-7.0, 9.0, 7.0, 3.0, -2.0, -4.0, -1.0, 7.0, -8.0, 5.0, 7.0, 5.0, 0.0, -6.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[5], mat4(-9.0, 7.0, -4.0, 4.0, 4.0, 9.0, -1.0, 3.0, 3.0, 4.0, -1.0, -6.0, -6.0, -3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(-9.0, -8.0, -6.0, 7.0, 4.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockD.h[0][0].mA), ivec4(-1, -4, 1, -7)) && allOk;
	allOk = compare_mat4(blockD.h[0][0].mB, mat4(8.0, 4.0, -5.0, 6.0, -7.0, -8.0, -8.0, 7.0, -2.0, 7.0, -8.0, -7.0, -5.0, 4.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[0][0].mC, mat2x3(-7.0, 5.0, -3.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD.h[0][0].mD, mat3(-3.0, 6.0, 8.0, 1.0, 1.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].d = (vec4(9.0, 7.0, -4.0, -2.0));
	blockB[0].e[0] = (mat4(-4.0, 8.0, -7.0, 8.0, -4.0, -3.0, -3.0, 9.0, -8.0, 0.0, -4.0, -2.0, -4.0, 9.0, -1.0, -7.0));
	blockB[0].e[1] = (mat4(9.0, 3.0, -6.0, 9.0, 0.0, 5.0, -4.0, 6.0, -8.0, 4.0, -1.0, -4.0, -6.0, 9.0, -7.0, 8.0));
	blockB[0].e[2] = (mat4(3.0, -2.0, 9.0, 2.0, 9.0, -7.0, 4.0, 2.0, -5.0, 5.0, 7.0, 9.0, 1.0, 4.0, 2.0, 2.0));
	blockB[0].e[3] = (mat4(-3.0, -7.0, -2.0, 2.0, 5.0, 4.0, 3.0, -9.0, -8.0, 2.0, 7.0, -5.0, -4.0, 9.0, 9.0, -3.0));
	blockB[0].e[4] = (mat4(-1.0, -7.0, -1.0, 7.0, 5.0, 1.0, -3.0, -7.0, 6.0, -3.0, 3.0, -5.0, 2.0, -6.0, 8.0, -3.0));
	blockB[0].e[5] = (mat4(-2.0, 4.0, -8.0, -5.0, 2.0, -9.0, -7.0, 9.0, -1.0, 9.0, 7.0, 3.0, -7.0, 1.0, 2.0, 8.0));
	blockB[1].d = (vec4(8.0, -5.0, 5.0, -1.0));
	blockB[1].e[0] = (mat4(-8.0, -9.0, 4.0, 4.0, 0.0, -4.0, 5.0, -8.0, -5.0, -7.0, 6.0, -5.0, 8.0, -3.0, -2.0, 7.0));
	blockB[1].e[1] = (mat4(6.0, -4.0, 0.0, -3.0, 3.0, -2.0, 5.0, -5.0, -1.0, -1.0, -5.0, 8.0, -6.0, 2.0, 6.0, 6.0));
	blockB[1].e[2] = (mat4(-1.0, 3.0, -6.0, 7.0, -2.0, 3.0, -5.0, 8.0, 5.0, -9.0, 5.0, 4.0, -5.0, -8.0, 6.0, 2.0));
	blockB[1].e[3] = (mat4(5.0, 7.0, 3.0, 7.0, -7.0, 3.0, -2.0, 1.0, -2.0, 3.0, 5.0, 0.0, 0.0, -7.0, -7.0, -9.0));
	blockB[1].e[4] = (mat4(1.0, 8.0, -5.0, -1.0, -6.0, -9.0, 2.0, -8.0, 4.0, -1.0, -6.0, -4.0, 3.0, 3.0, 0.0, 4.0));
	blockB[1].e[5] = (mat4(4.0, 2.0, -6.0, 4.0, 2.0, -2.0, 0.0, 0.0, -4.0, -5.0, 5.0, 8.0, 3.0, 6.0, -6.0, -5.0));
	blockC.f = (mat2x3(-3.0, 4.0, 9.0, -4.0, -7.0, 0.0));
	blockD.g = u8vec4(uvec4(0u, 0u, 2u, 2u));
	blockD.h[0][0].mA = (ivec4(-5, 4, 0, 3));
	blockD.h[0][0].mB = (mat4(2.0, 2.0, -4.0, -9.0, 9.0, -2.0, 0.0, 4.0, 6.0, 3.0, 1.0, -8.0, -8.0, -5.0, 9.0, -9.0));
	blockD.h[0][0].mC = (mat2x3(-4.0, -8.0, 5.0, 3.0, -7.0, 6.0));
	blockD.h[0][0].mD = (mat3(6.0, -1.0, 1.0, -4.0, -5.0, 8.0, 0.0, -4.0, 7.0));
}
#version 450
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
	layout(offset = 0) lowp uvec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec4 b;
	layout(offset = 16) i8vec4 c;
	layout(offset = 20) int8_t d;
	layout(offset = 24) mediump vec2 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 f;
	layout(offset = 8) i8vec2 g;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp ivec4 h;
	layout(offset = 16) highp vec3 i;
	layout(offset = 28) lowp int j;
	layout(offset = 32) u8vec4 k;
	layout(offset = 48) mediump ivec4 l[1];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockC.c), ivec4(9, 4294967292, 4294967293, 4)) && allOk;
	allOk = compare_int8_t(int(blockC.d), 4) && allOk;
	allOk = compare_bvec2((blockD.f), bvec2(true, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g), ivec2(0, 4)) && allOk;
	allOk = compare_ivec4((blockE[0].h), ivec4(-4, 7, 2, -1)) && allOk;
	allOk = compare_int((blockE[0].j), 3) && allOk;
	allOk = compare_u8vec4(uvec4(blockE[0].k), uvec4(0u, 5u, 6u, 5u)) && allOk;
	allOk = compare_ivec4((blockE[0].l[0]), ivec4(0, -3, 1, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(0u, 7u, 5u, 6u));
	blockC.b = (uvec4(7u, 2u, 9u, 7u));
	blockC.c = i8vec4(ivec4(4294967288, 4294967292, 4294967290, 3));
	blockC.e = (vec2(5.0, -2.0));
	blockD.f = (bvec2(false, true));
	blockD.g = i8vec2(ivec2(4294967291, 4294967294));
	blockE[0].i = (vec3(3.0, -9.0, -2.0));
	blockE[0].k = u8vec4(uvec4(4u, 6u, 5u, 2u));
	blockE[0].l[0] = (ivec4(8, 4, -4, 0));
}
#version 450
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
	layout(offset = 4) i8vec4 b[1];
	layout(offset = 16) highp vec4 c;
	layout(offset = 32) mediump int d[1];
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) lowp vec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[0]), ivec4(4294967291, 7, 2, 4294967295)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(4.0, 1.0, -8.0, -1.0)) && allOk;
	allOk = compare_int((blockB.d[0]), 4) && allOk;
	allOk = compare_vec4((blockC[0].e), vec4(-7.0, 3.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC[1].e), vec4(9.0, 5.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = i8vec4(ivec4(5, 4294967294, 9, 4294967290));
	blockB.c = (vec4(1.0, 2.0, -4.0, -1.0));
	blockB.d[0] = (-9);
}
#version 450
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
	layout(offset = 4) mediump ivec2 b;
	layout(offset = 12) highp uint c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec3 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec4 e;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) int8_t f;
	layout(offset = 4) mediump uvec3 g;
	layout(offset = 16) lowp float h;
	layout(offset = 20) u8vec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a), ivec2(3, 4294967287)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-2, -9)) && allOk;
	allOk = compare_uint((blockB[0].c), 8u) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[1].a), ivec2(4294967291, 4294967294)) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-7, 8)) && allOk;
	allOk = compare_uint((blockB[1].c), 8u) && allOk;
	allOk = compare_uvec4((blockD.e), uvec4(3u, 6u, 2u, 9u)) && allOk;
	allOk = compare_int8_t(int(blockE.f), 8) && allOk;
	allOk = compare_uvec3((blockE.g), uvec3(6u, 8u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.i), uvec4(5u, 4u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec2(ivec2(4294967295, 4294967294));
	blockB[0].b = (ivec2(8, -9));
	blockB[0].c = (8u);
	blockB[1].a = i8vec2(ivec2(0, 7));
	blockB[1].b = (ivec2(-6, 5));
	blockB[1].c = (2u);
	blockC.d = (vec3(1.0, -1.0, -7.0));
	blockD.e = (uvec4(6u, 6u, 5u, 0u));
	blockE.f = int8_t(4294967293);
	blockE.g = (uvec3(5u, 0u, 8u));
	blockE.h = (-1.0);
	blockE.i = u8vec4(uvec4(5u, 3u, 2u, 5u));
}
#version 450
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
	layout(offset = 4) i8vec2 b;
	layout(offset = 16) mediump uvec3 c;
	layout(offset = 28) u8vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(0u, 2u, 0u, 4u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(4294967287, 0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.d), uvec4(0u, 4u, 5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(2u, 8u, 3u, 3u));
	blockB.b = i8vec2(ivec2(0, 4));
	blockB.c = (uvec3(5u, 5u, 3u));
}
#version 450
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
	lowp mat2x3 mA;
};
layout(scalar, buffer_reference) buffer BlockB
{
	u8vec2 a;
	lowp int b;
	i8vec2 c;
	bvec4 d;
};
layout(scalar, buffer_reference) buffer BlockC
{
	sA e;
	i8vec2 f[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	i8vec2 g[1];
	uint8_t h;
	lowp mat3 i;
	i8vec4 j;
	mediump mat4x3 k;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(4294967291, 1)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat2x3(blockC.e.mA, mat2x3(9.0, 6.0, -5.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.f[0]), ivec2(7, 4)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.f[1]), ivec2(4294967294, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.f[2]), ivec2(2, 4294967291)) && allOk;
	allOk = compare_uint8_t(uint(blockD.h), 8u) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j), ivec4(9, 4294967293, 3, 1)) && allOk;
	allOk = compare_mat4x3(blockD.k, mat4x3(1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(5u, 2u));
	blockB.b = (-5);
	blockB.c = i8vec2(ivec2(4294967292, 4294967288));
	blockB.d = (bvec4(false, false, true, true));
	blockC.e.mA = (mat2x3(4.0, 7.0, 8.0, 3.0, 8.0, 8.0));
	blockC.f[0] = i8vec2(ivec2(0, 8));
	blockC.f[1] = i8vec2(ivec2(4294967290, 5));
	blockC.f[2] = i8vec2(ivec2(1, 7));
	blockD.g[0] = i8vec2(ivec2(4294967295, 4294967287));
	blockD.h = uint8_t(8u);
	blockD.i = (mat3(-7.0, -5.0, 7.0, -9.0, -5.0, 5.0, 3.0, 7.0, -7.0));
	blockD.j = i8vec4(ivec4(4294967290, 1, 8, 8));
	blockD.k = (mat4x3(-9.0, -8.0, 4.0, 8.0, 5.0, 3.0, 5.0, -4.0, 8.0, 8.0, 0.0, -8.0));
}
#version 450
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
	lowp float a;
	i8vec2 b;
	bvec3 c;
	mediump uvec4 d;
	i8vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(4294967288, 0)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(8u, 1u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2.0);
	blockB.b = i8vec2(ivec2(4294967287, 4294967293));
	blockB.c = (bvec3(true, true, true));
	blockB.d = (uvec4(9u, 6u, 6u, 2u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(column_major, buffer_reference) buffer BlockB
{
	layout(offset = 0) lowp mat3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3(9.0, -7.0, -5.0, -9.0, -8.0, 0.0, 8.0, 0.0, 8.0));
	blockB[nonuniformEXT(1)].a = (mat3(7.0, 1.0, 2.0, -5.0, 9.0, -6.0, -3.0, 9.0, 4.0));
	blockB[nonuniformEXT(2)].a = (mat3(0.0, 4.0, 5.0, -2.0, 4.0, -6.0, 5.0, -4.0, 9.0));
	blockB[nonuniformEXT(3)].a = (mat3(1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0, -1.0, -6.0));
}
#version 450
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
	mediump uvec4 a;
	i8vec3 b;
	u8vec4 c[1];
	mediump mat3 d;
	lowp int e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std140, buffer_reference) buffer BlockB
{
	highp vec2 a[1];
	highp int b;
	i8vec3 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	u8vec3 a;
	u8vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].a), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].b), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].a), uvec3(6u, 3u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].b), uvec3(1u, 0u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(2)].a), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(2)].b), uvec3(0u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u8vec3(uvec3(9u, 2u, 2u));
	blockB[nonuniformEXT(0)].b = u8vec3(uvec3(6u, 2u, 2u));
	blockB[nonuniformEXT(1)].a = u8vec3(uvec3(2u, 2u, 0u));
	blockB[nonuniformEXT(1)].b = u8vec3(uvec3(7u, 9u, 2u));
	blockB[nonuniformEXT(2)].a = u8vec3(uvec3(1u, 2u, 9u));
	blockB[nonuniformEXT(2)].b = u8vec3(uvec3(6u, 7u, 3u));
}
#version 450
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
	u8vec2 a;
	i8vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(0)].b), ivec3(8, 4294967287, 4)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(1)].b), ivec3(4294967294, 2, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(2)].b), ivec3(4294967289, 4294967291, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(3)].b), ivec3(0, 3, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
