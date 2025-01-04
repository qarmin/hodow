#version 450
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
	lowp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (-7);
}
#version 450
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
	highp uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec2(2u, 7u));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-7.0, 2.0, -1.0, 0.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(6.0, 5.0, -4.0));
	var[1] = (vec3(-7.0, 8.0, 5.0));
}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[3][0], 6.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(4.0, 3.0));
	var[1] = (vec2(9.0, -6.0));
	var[2] = (vec2(6.0, -1.0));
	var[3] = (vec2(8.0, 1.0));
}
#version 450
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

	var = (mat4x2(-9.0, 5.0, 0.0, 9.0, -7.0, -5.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(4.0, -7.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(var, mat4(5.0, 3.0, 1.0, 5.0, -4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-2.0, 8.0, -3.0, -1.0));
	var[1] = (vec4(6.0, -9.0, -1.0, -9.0));
	var[2] = (vec4(-4.0, -3.0, 5.0, 3.0));
	var[3] = (vec4(7.0, 6.0, 9.0, 0.0));
}
#version 450
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

	var = (mat3x4(-5.0, 8.0, 7.0, 9.0, 5.0, -9.0, -3.0, -7.0, 1.0, -6.0, -2.0, -4.0));
}
#version 450
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
	lowp vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_vec2((var), vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (vec2(7.0, -4.0));
}
#version 450
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
	lowp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_vec4((var), vec4(4.0, 3.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var = (vec4(-3.0, 0.0, 1.0, -3.0));
}
#version 450
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

	padding = (-3.0);
	var[0] = (vec3(-3.0, 1.0, -6.0));
	var[1] = (vec3(-5.0, -7.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-2.0, -6.0, 5.0, 1.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (vec2(-2.0, 0.0));
	var[1] = (vec2(-2.0, -1.0));
	var[2] = (vec2(3.0, -3.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0, 9.0, 9.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var = (mat3x4(-8.0, -1.0, -6.0, -6.0, 4.0, 6.0, 1.0, 0.0, -7.0, -7.0, 0.0, 2.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-7.0, -3.0, 8.0, 1.0, 2.0, 8.0, -1.0, -4.0, 7.0, 5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (vec4(6.0, 5.0, 7.0, 1.0));
	var[1] = (vec4(-9.0, -8.0, -7.0, -3.0));
	var[2] = (vec4(-7.0, -8.0, -2.0, 7.0));
}
#version 450
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
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0] = (vec2(-2.0, -8.0));
	var[1] = (vec2(-4.0, 5.0));
	var[2] = (vec2(6.0, -2.0));
	var[3] = (vec2(5.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(9.0, 0.0, 0.0, 0.0, -4.0, 3.0, 0.0, 0.0, -6.0, 8.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0] = (vec3(8.0, 5.0, -4.0));
	var[1] = (vec3(7.0, -3.0, -3.0));
	var[2] = (vec3(2.0, -7.0, 4.0));
	var[3] = (vec3(1.0, -9.0, -7.0));
}
#version 450
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
	u8vec3 var[3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2]), uvec3(8u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u8vec3(uvec3(4u, 5u, 9u));
	var[1] = u8vec3(uvec3(6u, 9u, 4u));
	var[2] = u8vec3(uvec3(7u, 1u, 5u));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][1] = (vec3(-3.0, 9.0, -8.0));
	var[1][0] = (vec3(-5.0, 6.0, 6.0));
	var[1][1] = (vec3(3.0, -3.0, 7.0));
	var[2][0] = (vec3(-9.0, -2.0, -7.0));
	var[2][1] = (vec3(7.0, 0.0, -8.0));
}
#version 450
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

	padding = (true);
	var[0] = (bvec3(true, false, false));
	var[1] = (bvec3(true, true, false));
	var[2] = (bvec3(false, false, true));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(6.0, 2.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0] = (vec2(4.0, 4.0));
	var[0][1] = (vec2(3.0, 9.0));
	var[1][0] = (vec2(-5.0, 8.0));
	var[1][1] = (vec2(-9.0, 0.0));
	var[2][0] = (vec2(2.0, -4.0));
	var[2][1] = (vec2(4.0, -3.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 1.0, 4.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -8.0, -7.0, 1.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (mat2x3(-2.0, -5.0, 0.0, 7.0, -2.0, 0.0));
	var[1] = (mat2x3(9.0, 9.0, 8.0, -6.0, 3.0, -9.0));
	var[2] = (mat2x3(0.0, 1.0, 1.0, 7.0, -8.0, 7.0));
}
#version 450
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
	i8vec3 var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(var[0]), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1]), ivec3(4294967289, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2]), ivec3(9, 4294967292, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967292);
	var[0] = i8vec3(ivec3(0, 0, 7));
	var[1] = i8vec3(ivec3(9, 4294967290, 4294967288));
	var[2] = i8vec3(ivec3(9, 4294967288, 4294967293));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

layout(std430, column_major, binding = 1) buffer Block
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

	var[0][0] = (vec2(5.0, -4.0));
	var[0][1] = (vec2(5.0, 1.0));
	var[1][0] = (vec2(-8.0, -1.0));
	var[1][1] = (vec2(9.0, -8.0));
	var[2][0] = (vec2(5.0, -4.0));
	var[2][1] = (vec2(5.0, -2.0));
	var[3][0] = (vec2(9.0, -9.0));
	var[3][1] = (vec2(-1.0, 6.0));
	var[4][0] = (vec2(-4.0, 7.0));
	var[4][1] = (vec2(-8.0, 1.0));
	var[5][0] = (vec2(4.0, -4.0));
	var[5][1] = (vec2(6.0, -5.0));
	var[6][0] = (vec2(4.0, -3.0));
	var[6][1] = (vec2(6.0, 7.0));
	var[7][0] = (vec2(-7.0, -9.0));
	var[7][1] = (vec2(5.0, 0.0));
	var[8][0] = (vec2(9.0, 2.0));
	var[8][1] = (vec2(1.0, -6.0));
	var[9][0] = (vec2(8.0, -8.0));
	var[9][1] = (vec2(5.0, -5.0));
	var[10][0] = (vec2(-5.0, 4.0));
	var[10][1] = (vec2(5.0, 0.0));
	var[11][0] = (vec2(6.0, 9.0));
	var[11][1] = (vec2(5.0, -8.0));
	var[12][0] = (vec2(7.0, 7.0));
	var[12][1] = (vec2(0.0, 2.0));
	var[13][0] = (vec2(4.0, -7.0));
	var[13][1] = (vec2(-5.0, -7.0));
	var[14][0] = (vec2(8.0, 2.0));
	var[14][1] = (vec2(1.0, -1.0));
	var[15][0] = (vec2(9.0, 0.0));
	var[15][1] = (vec2(-8.0, -9.0));
	var[16][0] = (vec2(-2.0, 7.0));
	var[16][1] = (vec2(8.0, 2.0));
	var[17][0] = (vec2(-3.0, -3.0));
	var[17][1] = (vec2(7.0, -2.0));
	var[18][0] = (vec2(4.0, -2.0));
	var[18][1] = (vec2(6.0, 1.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[0][2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[1][0] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[1][1] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[1][2] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[2][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[2][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[2][2] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[3][0] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[3][1] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[3][2] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
}
#version 450
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
	bool var[4][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0][0]), false) && allOk;
	allOk = compare_bool((var[0][1]), true) && allOk;
	allOk = compare_bool((var[0][2]), true) && allOk;
	allOk = compare_bool((var[1][0]), false) && allOk;
	allOk = compare_bool((var[1][1]), false) && allOk;
	allOk = compare_bool((var[1][2]), true) && allOk;
	allOk = compare_bool((var[2][0]), true) && allOk;
	allOk = compare_bool((var[2][1]), false) && allOk;
	allOk = compare_bool((var[2][2]), false) && allOk;
	allOk = compare_bool((var[3][0]), false) && allOk;
	allOk = compare_bool((var[3][1]), false) && allOk;
	allOk = compare_bool((var[3][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (false);
	var[0][1] = (false);
	var[0][2] = (true);
	var[1][0] = (true);
	var[1][1] = (false);
	var[1][2] = (false);
	var[2][0] = (true);
	var[2][1] = (true);
	var[2][2] = (true);
	var[3][0] = (true);
	var[3][1] = (false);
	var[3][2] = (false);
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-4.0, -6.0));
	var[0][0][1] = (vec2(1.0, -3.0));
	var[0][0][2] = (vec2(-1.0, -9.0));
	var[0][1][0] = (vec2(3.0, -2.0));
	var[0][1][1] = (vec2(5.0, -8.0));
	var[0][1][2] = (vec2(2.0, -9.0));
	var[0][2][0] = (vec2(1.0, -5.0));
	var[0][2][1] = (vec2(0.0, -2.0));
	var[0][2][2] = (vec2(2.0, -1.0));
	var[1][0][0] = (vec2(-7.0, 9.0));
	var[1][0][1] = (vec2(-8.0, 7.0));
	var[1][0][2] = (vec2(1.0, -9.0));
	var[1][1][0] = (vec2(-5.0, -5.0));
	var[1][1][1] = (vec2(9.0, 3.0));
	var[1][1][2] = (vec2(-3.0, -6.0));
	var[1][2][0] = (vec2(1.0, 3.0));
	var[1][2][1] = (vec2(-3.0, -4.0));
	var[1][2][2] = (vec2(-9.0, 4.0));
	var[2][0][0] = (vec2(-2.0, -3.0));
	var[2][0][1] = (vec2(-5.0, 1.0));
	var[2][0][2] = (vec2(-5.0, 8.0));
	var[2][1][0] = (vec2(7.0, 8.0));
	var[2][1][1] = (vec2(-1.0, -3.0));
	var[2][1][2] = (vec2(-8.0, 5.0));
	var[2][2][0] = (vec2(6.0, 6.0));
	var[2][2][1] = (vec2(0.0, -8.0));
	var[2][2][2] = (vec2(-6.0, -4.0));
	var[3][0][0] = (vec2(-6.0, -5.0));
	var[3][0][1] = (vec2(8.0, 5.0));
	var[3][0][2] = (vec2(-9.0, 0.0));
	var[3][1][0] = (vec2(6.0, -3.0));
	var[3][1][1] = (vec2(6.0, 0.0));
	var[3][1][2] = (vec2(1.0, 6.0));
	var[3][2][0] = (vec2(4.0, 4.0));
	var[3][2][1] = (vec2(0.0, -1.0));
	var[3][2][2] = (vec2(-2.0, 2.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[0][2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[1][0] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[1][1] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[1][2] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[2][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[2][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[2][2] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[3][0] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[3][1] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[3][2] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0] = (mat3(-8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0, -4.0));
	var[0][1] = (mat3(3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0, -6.0));
	var[0][2] = (mat3(8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0, 8.0));
	var[1][0] = (mat3(-1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0, -2.0));
	var[1][1] = (mat3(9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0, -9.0));
	var[1][2] = (mat3(-7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0, -2.0));
	var[2][0] = (mat3(9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0, -5.0));
	var[2][1] = (mat3(6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0, 6.0));
	var[2][2] = (mat3(6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0, -1.0));
	var[3][0] = (mat3(6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0, 3.0));
	var[3][1] = (mat3(-9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0, -6.0));
	var[3][2] = (mat3(-9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0, 1.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0][0] = (mat3x4(-6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0, 3.0));
	var[0][1] = (mat3x4(-2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0, 1.0));
	var[0][2] = (mat3x4(-1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0, -6.0));
	var[1][0] = (mat3x4(7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0, 7.0));
	var[1][1] = (mat3x4(-8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0, -1.0));
	var[1][2] = (mat3x4(2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0, 6.0));
	var[2][0] = (mat3x4(6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0, 3.0));
	var[2][1] = (mat3x4(-3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0, 9.0));
	var[2][2] = (mat3x4(4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0, 5.0));
	var[3][0] = (mat3x4(0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0, 0.0));
	var[3][1] = (mat3x4(-3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0, 5.0));
	var[3][2] = (mat3x4(7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0, 9.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(-9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0] = (vec3(-6.0, 6.0, 1.0));
	var[0][0][1] = (vec3(-4.0, -3.0, -3.0));
	var[0][0][2] = (vec3(3.0, -2.0, -7.0));
	var[0][0][3] = (vec3(1.0, -5.0, -1.0));
	var[0][1][0] = (vec3(-5.0, 7.0, 1.0));
	var[0][1][1] = (vec3(-2.0, -4.0, -4.0));
	var[0][1][2] = (vec3(-6.0, 5.0, -2.0));
	var[0][1][3] = (vec3(6.0, -9.0, 5.0));
	var[0][2][0] = (vec3(-5.0, 7.0, -4.0));
	var[0][2][1] = (vec3(8.0, -3.0, -2.0));
	var[0][2][2] = (vec3(0.0, 8.0, -2.0));
	var[0][2][3] = (vec3(6.0, -3.0, -9.0));
	var[1][0][0] = (vec3(-2.0, -2.0, 7.0));
	var[1][0][1] = (vec3(9.0, -4.0, 3.0));
	var[1][0][2] = (vec3(1.0, 0.0, -9.0));
	var[1][0][3] = (vec3(-2.0, -7.0, -5.0));
	var[1][1][0] = (vec3(-6.0, 5.0, -2.0));
	var[1][1][1] = (vec3(-7.0, 5.0, -2.0));
	var[1][1][2] = (vec3(-6.0, 4.0, 9.0));
	var[1][1][3] = (vec3(5.0, -9.0, -3.0));
	var[1][2][0] = (vec3(3.0, 7.0, 3.0));
	var[1][2][1] = (vec3(-4.0, -8.0, -2.0));
	var[1][2][2] = (vec3(2.0, -1.0, 1.0));
	var[1][2][3] = (vec3(-9.0, 9.0, -7.0));
	var[2][0][0] = (vec3(-7.0, -7.0, 6.0));
	var[2][0][1] = (vec3(-9.0, 3.0, -5.0));
	var[2][0][2] = (vec3(2.0, 4.0, -2.0));
	var[2][0][3] = (vec3(-4.0, -6.0, -1.0));
	var[2][1][0] = (vec3(5.0, 5.0, -9.0));
	var[2][1][1] = (vec3(-3.0, -9.0, 3.0));
	var[2][1][2] = (vec3(2.0, 0.0, 0.0));
	var[2][1][3] = (vec3(-9.0, 7.0, 5.0));
	var[2][2][0] = (vec3(-5.0, -2.0, 6.0));
	var[2][2][1] = (vec3(5.0, -4.0, -2.0));
	var[2][2][2] = (vec3(9.0, -3.0, 2.0));
	var[2][2][3] = (vec3(5.0, -4.0, 6.0));
	var[3][0][0] = (vec3(4.0, 7.0, 1.0));
	var[3][0][1] = (vec3(-4.0, -6.0, 4.0));
	var[3][0][2] = (vec3(-6.0, -5.0, 5.0));
	var[3][0][3] = (vec3(6.0, -1.0, 6.0));
	var[3][1][0] = (vec3(3.0, -9.0, -7.0));
	var[3][1][1] = (vec3(3.0, -4.0, 1.0));
	var[3][1][2] = (vec3(2.0, 6.0, -2.0));
	var[3][1][3] = (vec3(3.0, 7.0, -5.0));
	var[3][2][0] = (vec3(8.0, -9.0, -4.0));
	var[3][2][1] = (vec3(-1.0, -9.0, 5.0));
	var[3][2][2] = (vec3(5.0, 6.0, -8.0));
	var[3][2][3] = (vec3(1.0, -7.0, -5.0));
}
#version 450
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
	u16vec2 var[4][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1]), uvec2(9u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2]), uvec2(1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0]), uvec2(5u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][2]), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(8u);
	var[0][0] = u16vec2(uvec2(0u, 6u));
	var[0][1] = u16vec2(uvec2(0u, 6u));
	var[0][2] = u16vec2(uvec2(9u, 3u));
	var[1][0] = u16vec2(uvec2(2u, 9u));
	var[1][1] = u16vec2(uvec2(2u, 4u));
	var[1][2] = u16vec2(uvec2(5u, 1u));
	var[2][0] = u16vec2(uvec2(1u, 2u));
	var[2][1] = u16vec2(uvec2(8u, 1u));
	var[2][2] = u16vec2(uvec2(5u, 0u));
	var[3][0] = u16vec2(uvec2(2u, 3u));
	var[3][1] = u16vec2(uvec2(8u, 1u));
	var[3][2] = u16vec2(uvec2(8u, 7u));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	var[0][0][2][0] = (vec3(-5.0, -3.0, -3.0));
	var[0][0][2][1] = (vec3(3.0, -5.0, -4.0));
	var[0][0][2][2] = (vec3(-7.0, 5.0, 3.0));
	var[0][1][0][0] = (vec3(-4.0, 8.0, 7.0));
	var[0][1][0][1] = (vec3(1.0, 7.0, -5.0));
	var[0][1][0][2] = (vec3(7.0, 9.0, 4.0));
	var[0][1][1][0] = (vec3(-2.0, 2.0, 1.0));
	var[0][1][1][1] = (vec3(-8.0, -6.0, 7.0));
	var[0][1][1][2] = (vec3(-3.0, 2.0, -5.0));
	var[0][1][2][0] = (vec3(-6.0, 6.0, -7.0));
	var[0][1][2][1] = (vec3(1.0, 3.0, -7.0));
	var[0][1][2][2] = (vec3(6.0, -8.0, 4.0));
	var[1][0][0][0] = (vec3(-8.0, 7.0, 8.0));
	var[1][0][0][1] = (vec3(8.0, 2.0, -9.0));
	var[1][0][0][2] = (vec3(-3.0, 6.0, -3.0));
	var[1][0][1][0] = (vec3(7.0, -3.0, 6.0));
	var[1][0][1][1] = (vec3(-7.0, 6.0, -7.0));
	var[1][0][1][2] = (vec3(2.0, 3.0, -3.0));
	var[1][0][2][0] = (vec3(-1.0, -5.0, -1.0));
	var[1][0][2][1] = (vec3(8.0, 4.0, -3.0));
	var[1][0][2][2] = (vec3(8.0, -6.0, 4.0));
	var[1][1][0][0] = (vec3(-3.0, -8.0, 3.0));
	var[1][1][0][1] = (vec3(-5.0, -8.0, 8.0));
	var[1][1][0][2] = (vec3(7.0, 2.0, -3.0));
	var[1][1][1][0] = (vec3(3.0, -1.0, -6.0));
	var[1][1][1][1] = (vec3(-1.0, 6.0, 7.0));
	var[1][1][1][2] = (vec3(9.0, -1.0, 2.0));
	var[1][1][2][0] = (vec3(-9.0, -6.0, 9.0));
	var[1][1][2][1] = (vec3(4.0, 9.0, 5.0));
	var[1][1][2][2] = (vec3(5.0, 4.0, -9.0));
	var[2][0][0][0] = (vec3(5.0, 9.0, -7.0));
	var[2][0][0][1] = (vec3(1.0, -3.0, -7.0));
	var[2][0][0][2] = (vec3(-5.0, 4.0, 1.0));
	var[2][0][1][0] = (vec3(-3.0, -5.0, -8.0));
	var[2][0][1][1] = (vec3(-5.0, 6.0, 2.0));
	var[2][0][1][2] = (vec3(-9.0, -9.0, -1.0));
	var[2][0][2][0] = (vec3(2.0, 8.0, -8.0));
	var[2][0][2][1] = (vec3(-6.0, 0.0, 3.0));
	var[2][0][2][2] = (vec3(9.0, -8.0, 3.0));
	var[2][1][0][0] = (vec3(3.0, 3.0, 8.0));
	var[2][1][0][1] = (vec3(1.0, -2.0, 0.0));
	var[2][1][0][2] = (vec3(-9.0, 5.0, 1.0));
	var[2][1][1][0] = (vec3(-2.0, 0.0, 0.0));
	var[2][1][1][1] = (vec3(-3.0, 7.0, -8.0));
	var[2][1][1][2] = (vec3(0.0, 1.0, -3.0));
	var[2][1][2][0] = (vec3(-7.0, 1.0, 4.0));
	var[2][1][2][1] = (vec3(-2.0, -1.0, -5.0));
	var[2][1][2][2] = (vec3(-1.0, 4.0, -2.0));
	var[3][0][0][0] = (vec3(-9.0, 9.0, 2.0));
	var[3][0][0][1] = (vec3(6.0, -4.0, -8.0));
	var[3][0][0][2] = (vec3(3.0, 8.0, 1.0));
	var[3][0][1][0] = (vec3(-9.0, -5.0, -7.0));
	var[3][0][1][1] = (vec3(-4.0, -1.0, -4.0));
	var[3][0][1][2] = (vec3(-6.0, 4.0, 9.0));
	var[3][0][2][0] = (vec3(-3.0, -9.0, 0.0));
	var[3][0][2][1] = (vec3(-9.0, -5.0, -9.0));
	var[3][0][2][2] = (vec3(-1.0, -9.0, 7.0));
	var[3][1][0][0] = (vec3(-9.0, -3.0, 6.0));
	var[3][1][0][1] = (vec3(-4.0, 8.0, 0.0));
	var[3][1][0][2] = (vec3(-5.0, -4.0, 2.0));
	var[3][1][1][0] = (vec3(-8.0, 0.0, -8.0));
	var[3][1][1][1] = (vec3(-8.0, 8.0, 0.0));
	var[3][1][1][2] = (vec3(-8.0, -6.0, -9.0));
	var[3][1][2][0] = (vec3(1.0, 3.0, 8.0));
	var[3][1][2][1] = (vec3(-2.0, 9.0, -6.0));
	var[3][1][2][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0, 2.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0, 5.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0, 2.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0, 1.0, -4.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0, -4.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0, 7.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0, 1.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0, 1.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0, 3.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0, -5.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0, 4.0, 5.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0, 0.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0, -1.0, 9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0, 5.0, 5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0, -1.0, -7.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0, 5.0, -5.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0, 1.0, 2.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0, 8.0, 8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0, 1.0, 0.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0, -6.0, -4.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0, 0.0, 2.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0][0][0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][0][0][1] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][0][0][2] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[0][0][0][3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	var[0][0][1][0] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[0][0][1][1] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[0][0][1][2] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[0][0][1][3] = (vec4(3.0, 9.0, -6.0, 1.0));
	var[0][0][2][0] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[0][0][2][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][0][2][2] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[0][0][2][3] = (vec4(6.0, 0.0, 8.0, 4.0));
	var[0][1][0][0] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[0][1][0][1] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[0][1][0][2] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[0][1][0][3] = (vec4(9.0, -9.0, 1.0, -3.0));
	var[0][1][1][0] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[0][1][1][1] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[0][1][1][2] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[0][1][1][3] = (vec4(-6.0, 6.0, -4.0, -8.0));
	var[0][1][2][0] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[0][1][2][1] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[0][1][2][2] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[0][1][2][3] = (vec4(2.0, 1.0, -8.0, 3.0));
	var[1][0][0][0] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][0][1] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][0][2] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][0][0][3] = (vec4(-5.0, 7.0, 9.0, -8.0));
	var[1][0][1][0] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[1][0][1][1] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[1][0][1][2] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[1][0][1][3] = (vec4(9.0, -5.0, 0.0, 7.0));
	var[1][0][2][0] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[1][0][2][1] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[1][0][2][2] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[1][0][2][3] = (vec4(-2.0, -9.0, 2.0, -7.0));
	var[1][1][0][0] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[1][1][0][1] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[1][1][0][2] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[1][1][0][3] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[1][1][1][0] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[1][1][1][1] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[1][1][1][2] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[1][1][1][3] = (vec4(-9.0, 8.0, -1.0, 6.0));
	var[1][1][2][0] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[1][1][2][1] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[1][1][2][2] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[1][1][2][3] = (vec4(3.0, 4.0, -9.0, -5.0));
	var[2][0][0][0] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[2][0][0][1] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[2][0][0][2] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[2][0][0][3] = (vec4(3.0, -4.0, -1.0, -4.0));
	var[2][0][1][0] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[2][0][1][1] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[2][0][1][2] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[2][0][1][3] = (vec4(-2.0, -3.0, 5.0, 1.0));
	var[2][0][2][0] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[2][0][2][1] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[2][0][2][2] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[2][0][2][3] = (vec4(1.0, 4.0, -2.0, 2.0));
	var[2][1][0][0] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[2][1][0][1] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[2][1][0][2] = (vec4(-1.0, 0.0, -7.0, 8.0));
	var[2][1][0][3] = (vec4(7.0, -6.0, -2.0, 5.0));
	var[2][1][1][0] = (vec4(3.0, 3.0, -7.0, 4.0));
	var[2][1][1][1] = (vec4(-5.0, 6.0, -8.0, -6.0));
	var[2][1][1][2] = (vec4(-1.0, 0.0, -2.0, -7.0));
	var[2][1][1][3] = (vec4(-1.0, -2.0, 8.0, -4.0));
	var[2][1][2][0] = (vec4(-6.0, -3.0, 8.0, 4.0));
	var[2][1][2][1] = (vec4(7.0, -4.0, 3.0, -5.0));
	var[2][1][2][2] = (vec4(-8.0, 0.0, -4.0, -3.0));
	var[2][1][2][3] = (vec4(-1.0, 3.0, 9.0, 7.0));
	var[3][0][0][0] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[3][0][0][1] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[3][0][0][2] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[3][0][0][3] = (vec4(-7.0, 5.0, 7.0, 6.0));
	var[3][0][1][0] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[3][0][1][1] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[3][0][1][2] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[3][0][1][3] = (vec4(3.0, 8.0, 9.0, -8.0));
	var[3][0][2][0] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][0][2][1] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[3][0][2][2] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[3][0][2][3] = (vec4(-5.0, 6.0, -7.0, 4.0));
	var[3][1][0][0] = (vec4(4.0, 4.0, -7.0, -2.0));
	var[3][1][0][1] = (vec4(9.0, -6.0, 6.0, 2.0));
	var[3][1][0][2] = (vec4(-2.0, -8.0, -8.0, -9.0));
	var[3][1][0][3] = (vec4(-8.0, -4.0, -8.0, 5.0));
	var[3][1][1][0] = (vec4(7.0, 2.0, 7.0, -8.0));
	var[3][1][1][1] = (vec4(-8.0, -4.0, -4.0, -1.0));
	var[3][1][1][2] = (vec4(-8.0, 3.0, 5.0, 3.0));
	var[3][1][1][3] = (vec4(-7.0, -8.0, 4.0, -9.0));
	var[3][1][2][0] = (vec4(6.0, -6.0, 7.0, -7.0));
	var[3][1][2][1] = (vec4(-5.0, -8.0, -2.0, -7.0));
	var[3][1][2][2] = (vec4(7.0, -4.0, -8.0, -1.0));
	var[3][1][2][3] = (vec4(4.0, 6.0, -2.0, -4.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[0][1][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[0][1][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[0][2][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	var[0][2][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	var[0][3][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	var[0][3][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	var[1][0][0] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[1][0][1] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[1][1][0] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[1][1][1] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[1][2][0] = (mat2(-2.0, -3.0, 3.0, -1.0));
	var[1][2][1] = (mat2(-2.0, -8.0, 1.0, -1.0));
	var[1][3][0] = (mat2(-6.0, -2.0, 3.0, -6.0));
	var[1][3][1] = (mat2(-9.0, -4.0, 0.0, -1.0));
	var[2][0][0] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[2][0][1] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[2][1][0] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[2][1][1] = (mat2(6.0, 0.0, 1.0, 8.0));
	var[2][2][0] = (mat2(9.0, -2.0, -3.0, 6.0));
	var[2][2][1] = (mat2(2.0, 6.0, -4.0, -6.0));
	var[2][3][0] = (mat2(0.0, 7.0, 4.0, 1.0));
	var[2][3][1] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[0][1][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[0][1][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[0][2][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	var[0][2][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	var[0][3][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	var[0][3][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	var[1][0][0] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[1][0][1] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[1][1][0] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[1][1][1] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[1][2][0] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	var[1][2][1] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	var[1][3][0] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	var[1][3][1] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	var[2][0][0] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[2][0][1] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[2][1][0] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[2][1][1] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	var[2][2][0] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	var[2][2][1] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	var[2][3][0] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	var[2][3][1] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
{
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(2.0, 6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(7.0, -2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(5.0, 9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, -2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(5.0, 1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[0][0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[0][0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[0][0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[0][1][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[0][1][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[0][1][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[0][1][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[0][1][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[0][1][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[0][2][0][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	var[0][2][0][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	var[0][2][0][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	var[0][2][1][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	var[0][2][1][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	var[0][2][1][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	var[0][3][0][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	var[0][3][0][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	var[0][3][0][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
	var[0][3][1][0] = (vec4(-2.0, 8.0, -6.0, 9.0));
	var[0][3][1][1] = (vec4(-3.0, 4.0, 1.0, -8.0));
	var[0][3][1][2] = (vec4(9.0, -1.0, 4.0, 6.0));
	var[1][0][0][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[1][0][0][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[1][0][0][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[1][0][1][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[1][0][1][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[1][0][1][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[1][1][0][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[1][1][0][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[1][1][0][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[1][1][1][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[1][1][1][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[1][1][1][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[1][2][0][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	var[1][2][0][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	var[1][2][0][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	var[1][2][1][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	var[1][2][1][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	var[1][2][1][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][3][0][0] = (vec4(6.0, -5.0, -8.0, -2.0));
	var[1][3][0][1] = (vec4(-3.0, -8.0, 3.0, 8.0));
	var[1][3][0][2] = (vec4(1.0, -5.0, 7.0, 2.0));
	var[1][3][1][0] = (vec4(4.0, 7.0, 0.0, -1.0));
	var[1][3][1][1] = (vec4(3.0, 8.0, -5.0, 9.0));
	var[1][3][1][2] = (vec4(-5.0, 8.0, -3.0, 1.0));
	var[2][0][0][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[2][0][0][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[2][0][0][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[2][0][1][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[2][0][1][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[2][0][1][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[2][1][0][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[2][1][0][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[2][1][0][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[2][1][1][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[2][1][1][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[2][1][1][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	var[2][2][0][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	var[2][2][0][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	var[2][2][0][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	var[2][2][1][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	var[2][2][1][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	var[2][2][1][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	var[2][3][0][0] = (vec4(7.0, 9.0, 3.0, -6.0));
	var[2][3][0][1] = (vec4(-1.0, -7.0, -5.0, 3.0));
	var[2][3][0][2] = (vec4(-1.0, -1.0, 9.0, 3.0));
	var[2][3][1][0] = (vec4(5.0, 6.0, -3.0, 6.0));
	var[2][3][1][1] = (vec4(-2.0, 2.0, -3.0, 0.0));
	var[2][3][1][2] = (vec4(7.0, 8.0, -4.0, -2.0));
}
#version 450
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
	i8vec3 var[][4][2];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0][0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][2][0]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][2][1]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][3][0]), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][3][1]), ivec3(4294967289, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][0]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][1]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][0]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][1]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][2][0]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][2][1]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][3][0]), ivec3(3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][3][1]), ivec3(3, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][0]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][1]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][0]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][1]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][2][0]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][2][1]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][3][0]), ivec3(4294967292, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][3][1]), ivec3(4294967295, 4294967291, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec3(ivec3(4294967292, 0, 0));
	var[0][0][1] = i8vec3(ivec3(7, 9, 4294967290));
	var[0][1][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[0][1][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[0][2][0] = i8vec3(ivec3(7, 4294967293, 7));
	var[0][2][1] = i8vec3(ivec3(4294967293, 4294967288, 2));
	var[0][3][0] = i8vec3(ivec3(4294967288, 4, 8));
	var[0][3][1] = i8vec3(ivec3(4294967288, 4294967293, 1));
	var[1][0][0] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[1][0][1] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[1][1][0] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[1][1][1] = i8vec3(ivec3(3, 7, 4));
	var[1][2][0] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	var[1][2][1] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	var[1][3][0] = i8vec3(ivec3(4294967290, 4294967289, 6));
	var[1][3][1] = i8vec3(ivec3(4294967295, 4294967289, 1));
	var[2][0][0] = i8vec3(ivec3(9, 7, 5));
	var[2][0][1] = i8vec3(ivec3(5, 4294967293, 6));
	var[2][1][0] = i8vec3(ivec3(4294967292, 8, 8));
	var[2][1][1] = i8vec3(ivec3(4294967294, 8, 1));
	var[2][2][0] = i8vec3(ivec3(4294967287, 1, 4294967288));
	var[2][2][1] = i8vec3(ivec3(4294967291, 8, 6));
	var[2][3][0] = i8vec3(ivec3(4294967292, 4294967295, 4294967292));
	var[2][3][1] = i8vec3(ivec3(4294967287, 1, 8));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(-7, 5, -3)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-9.0, 7.0, -8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(6.0, -4.0, -5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-2.0, -9.0, -5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(1.0, -5.0, 2.0, 1.0, 8.0, 5.0, -1.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-9.0, -6.0, 7.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-9, -7, -5)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(3.0, 3.0, 7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-8.0, 1.0, 5.0, 1.0, 9.0, -9.0, 9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(7.0, -9.0, 0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(0.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(1, -9, -1)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(1.0, 6.0, -9.0, 3.0, 7.0, -4.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(0.0, -4.0, -7.0, -8.0, -8.0, 6.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-7.0, 8.0, -9.0, 3.0, 0.0, 3.0, -2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-2.0, -6.0, 0.0, -9.0, 5.0, -4.0, -9.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-3.0, 4.0, 3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(1, -1, -5)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-6.0, 0.0, 8.0, 7.0, -7.0, 7.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(8.0, 6.0, -4.0, 3.0, 6.0, 5.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(4.0, -1.0, 9.0, 4.0, -6.0, -2.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(-3.0, 2.0, -4.0, -9.0, 5.0, -6.0, 4.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(-1.0, 2.0, 8.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(-4, 0, 2)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(9.0, 3.0, 4.0, -3.0, -5.0, 8.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(0.0, 4.0, 2.0, 8.0, 9.0, -7.0, 3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-4.0, 3.0, -4.0, -1.0, 3.0, -8.0, 0.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-9.0, -8.0, -4.0, 0.0, -8.0, -5.0, -6.0, -6.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(0.0, -3.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(1, 5, -6)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(6.0, 8.0, 2.0, -2.0, -9.0, -7.0, 8.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-4.0, 9.0, -7.0, 4.0, 0.0, 9.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-4.0, 3.0, -4.0, -5.0, -1.0, 0.0, -9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-9.0, 0.0, -3.0, 2.0, -7.0, -9.0, 3.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(7.0, -7.0, -2.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(4, -2, 8)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-7.0, 0.0, -8.0, -1.0, 2.0, 6.0, 6.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(2.0, -8.0, 2.0, 4.0, -9.0, 2.0, -3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(2.0, 6.0, 2.0, -5.0, 9.0, -9.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(3.0, -2.0, 1.0, -6.0, -5.0, 7.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-8.0, -6.0, 6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-7, 9, -8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(-2.0, -8.0, 6.0, 0.0, 7.0, -4.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-5.0, -2.0, 6.0, -3.0, -7.0, 8.0, -8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(8.0, -3.0, -1.0, 1.0, 0.0, 6.0, -7.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(-5.0, 6.0, 3.0, 1.0, 7.0, -4.0, -7.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(3.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-4, -6, -5)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(4.0, 0.0, 6.0, -2.0, -6.0, 4.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(4.0, 8.0, -9.0, 6.0, -5.0, -6.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-8.0, -5.0, 5.0, -9.0, -6.0, 2.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(6.0, 2.0, 2.0, 9.0, 0.0, 5.0, -5.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(5.0, 5.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(1, 0, -9));
	block[0].s[0].b[0][0] = (vec3(-8.0, 9.0, 4.0));
	block[0].s[0].b[0][1] = (vec3(-7.0, -4.0, -4.0));
	block[0].s[0].b[0][2] = (vec3(-1.0, 1.0, 6.0));
	block[0].s[0].b[1][0] = (vec3(1.0, -8.0, -5.0));
	block[0].s[0].b[1][1] = (vec3(-4.0, -6.0, -5.0));
	block[0].s[0].b[1][2] = (vec3(5.0, 6.0, 9.0));
	block[0].s[0].b[2][0] = (vec3(-6.0, -4.0, 0.0));
	block[0].s[0].b[2][1] = (vec3(-8.0, 5.0, 8.0));
	block[0].s[0].b[2][2] = (vec3(9.0, -4.0, -7.0));
	block[0].s[0].b[3][0] = (vec3(-8.0, -5.0, -4.0));
	block[0].s[0].b[3][1] = (vec3(-9.0, 8.0, -1.0));
	block[0].s[0].b[3][2] = (vec3(-6.0, 9.0, 2.0));
	block[0].s[0].c = (vec4(-1.0, 2.0, -2.0, 7.0));
	block[0].s[1].a = (ivec3(-4, -7, 3));
	block[0].s[1].b[0][0] = (vec3(-1.0, -7.0, -5.0));
	block[0].s[1].b[0][1] = (vec3(-4.0, -8.0, -3.0));
	block[0].s[1].b[0][2] = (vec3(-6.0, -8.0, 5.0));
	block[0].s[1].b[1][0] = (vec3(5.0, 5.0, 0.0));
	block[0].s[1].b[1][1] = (vec3(9.0, -9.0, -5.0));
	block[0].s[1].b[1][2] = (vec3(7.0, -7.0, 8.0));
	block[0].s[1].b[2][0] = (vec3(0.0, -1.0, 3.0));
	block[0].s[1].b[2][1] = (vec3(9.0, 1.0, 1.0));
	block[0].s[1].b[2][2] = (vec3(-8.0, 7.0, 8.0));
	block[0].s[1].b[3][0] = (vec3(3.0, 4.0, 7.0));
	block[0].s[1].b[3][1] = (vec3(5.0, 6.0, 4.0));
	block[0].s[1].b[3][2] = (vec3(0.0, -1.0, -2.0));
	block[0].s[1].c = (vec4(-7.0, 7.0, 3.0, -8.0));
	block[0].s[2].a = (ivec3(-8, 0, -3));
	block[0].s[2].b[0][0] = (vec3(-7.0, -8.0, 7.0));
	block[0].s[2].b[0][1] = (vec3(-9.0, 4.0, 6.0));
	block[0].s[2].b[0][2] = (vec3(3.0, 7.0, -6.0));
	block[0].s[2].b[1][0] = (vec3(1.0, -5.0, -4.0));
	block[0].s[2].b[1][1] = (vec3(0.0, -6.0, 9.0));
	block[0].s[2].b[1][2] = (vec3(1.0, 7.0, 6.0));
	block[0].s[2].b[2][0] = (vec3(8.0, 1.0, -2.0));
	block[0].s[2].b[2][1] = (vec3(-9.0, 5.0, -7.0));
	block[0].s[2].b[2][2] = (vec3(8.0, 5.0, 0.0));
	block[0].s[2].b[3][0] = (vec3(9.0, 6.0, 0.0));
	block[0].s[2].b[3][1] = (vec3(6.0, -9.0, 0.0));
	block[0].s[2].b[3][2] = (vec3(-4.0, 2.0, -7.0));
	block[0].s[2].c = (vec4(-8.0, 2.0, 2.0, 0.0));
	block[0].v = (vec4(-4.0, -7.0, 6.0, 5.0));
	block[1].s[0].a = (ivec3(-9, 5, -5));
	block[1].s[0].b[0][0] = (vec3(8.0, 9.0, 2.0));
	block[1].s[0].b[0][1] = (vec3(-4.0, -8.0, 3.0));
	block[1].s[0].b[0][2] = (vec3(-3.0, -6.0, -3.0));
	block[1].s[0].b[1][0] = (vec3(-5.0, -9.0, 9.0));
	block[1].s[0].b[1][1] = (vec3(-2.0, 1.0, -5.0));
	block[1].s[0].b[1][2] = (vec3(0.0, 7.0, -2.0));
	block[1].s[0].b[2][0] = (vec3(-7.0, -7.0, 5.0));
	block[1].s[0].b[2][1] = (vec3(-3.0, -2.0, -6.0));
	block[1].s[0].b[2][2] = (vec3(3.0, -8.0, 4.0));
	block[1].s[0].b[3][0] = (vec3(2.0, -9.0, 3.0));
	block[1].s[0].b[3][1] = (vec3(2.0, -2.0, 9.0));
	block[1].s[0].b[3][2] = (vec3(-8.0, -5.0, -8.0));
	block[1].s[0].c = (vec4(0.0, 7.0, 7.0, 7.0));
	block[1].s[1].a = (ivec3(0, -3, 0));
	block[1].s[1].b[0][0] = (vec3(-2.0, 8.0, 7.0));
	block[1].s[1].b[0][1] = (vec3(6.0, -4.0, 3.0));
	block[1].s[1].b[0][2] = (vec3(3.0, 3.0, -8.0));
	block[1].s[1].b[1][0] = (vec3(3.0, -3.0, -1.0));
	block[1].s[1].b[1][1] = (vec3(-4.0, 9.0, -7.0));
	block[1].s[1].b[1][2] = (vec3(-1.0, -2.0, -5.0));
	block[1].s[1].b[2][0] = (vec3(-7.0, -6.0, 3.0));
	block[1].s[1].b[2][1] = (vec3(5.0, -5.0, 6.0));
	block[1].s[1].b[2][2] = (vec3(-1.0, 5.0, -3.0));
	block[1].s[1].b[3][0] = (vec3(-7.0, -8.0, 7.0));
	block[1].s[1].b[3][1] = (vec3(1.0, 6.0, 9.0));
	block[1].s[1].b[3][2] = (vec3(-9.0, 3.0, -9.0));
	block[1].s[1].c = (vec4(-8.0, 2.0, -4.0, -3.0));
	block[1].s[2].a = (ivec3(6, -3, 0));
	block[1].s[2].b[0][0] = (vec3(-5.0, -7.0, -5.0));
	block[1].s[2].b[0][1] = (vec3(0.0, -4.0, 6.0));
	block[1].s[2].b[0][2] = (vec3(1.0, -9.0, 8.0));
	block[1].s[2].b[1][0] = (vec3(-2.0, -4.0, 5.0));
	block[1].s[2].b[1][1] = (vec3(0.0, -6.0, 1.0));
	block[1].s[2].b[1][2] = (vec3(-2.0, 0.0, -6.0));
	block[1].s[2].b[2][0] = (vec3(-8.0, 3.0, 8.0));
	block[1].s[2].b[2][1] = (vec3(8.0, -8.0, -4.0));
	block[1].s[2].b[2][2] = (vec3(-3.0, -6.0, 0.0));
	block[1].s[2].b[3][0] = (vec3(-1.0, 0.0, -7.0));
	block[1].s[2].b[3][1] = (vec3(-8.0, -9.0, 3.0));
	block[1].s[2].b[3][2] = (vec3(4.0, -9.0, 2.0));
	block[1].s[2].c = (vec4(0.0, 2.0, 4.0, 6.0));
	block[1].v = (vec4(-3.0, 0.0, 2.0, 2.0));
	block[2].s[0].a = (ivec3(-4, 2, 0));
	block[2].s[0].b[0][0] = (vec3(-9.0, -4.0, 5.0));
	block[2].s[0].b[0][1] = (vec3(2.0, 9.0, -6.0));
	block[2].s[0].b[0][2] = (vec3(-8.0, -5.0, 9.0));
	block[2].s[0].b[1][0] = (vec3(8.0, -8.0, 2.0));
	block[2].s[0].b[1][1] = (vec3(0.0, 9.0, -4.0));
	block[2].s[0].b[1][2] = (vec3(3.0, -3.0, -9.0));
	block[2].s[0].b[2][0] = (vec3(-4.0, -1.0, -1.0));
	block[2].s[0].b[2][1] = (vec3(6.0, 8.0, -2.0));
	block[2].s[0].b[2][2] = (vec3(-4.0, -2.0, -5.0));
	block[2].s[0].b[3][0] = (vec3(0.0, 9.0, -6.0));
	block[2].s[0].b[3][1] = (vec3(5.0, -6.0, -1.0));
	block[2].s[0].b[3][2] = (vec3(-5.0, 2.0, 7.0));
	block[2].s[0].c = (vec4(-3.0, 3.0, 1.0, -9.0));
	block[2].s[1].a = (ivec3(-3, 1, 9));
	block[2].s[1].b[0][0] = (vec3(-9.0, 4.0, -1.0));
	block[2].s[1].b[0][1] = (vec3(-5.0, -6.0, 6.0));
	block[2].s[1].b[0][2] = (vec3(-4.0, -7.0, 4.0));
	block[2].s[1].b[1][0] = (vec3(1.0, -7.0, 8.0));
	block[2].s[1].b[1][1] = (vec3(6.0, -9.0, 5.0));
	block[2].s[1].b[1][2] = (vec3(3.0, -1.0, 8.0));
	block[2].s[1].b[2][0] = (vec3(9.0, -9.0, 9.0));
	block[2].s[1].b[2][1] = (vec3(0.0, 7.0, -5.0));
	block[2].s[1].b[2][2] = (vec3(-9.0, -5.0, 3.0));
	block[2].s[1].b[3][0] = (vec3(3.0, 4.0, 0.0));
	block[2].s[1].b[3][1] = (vec3(0.0, 1.0, -3.0));
	block[2].s[1].b[3][2] = (vec3(9.0, -3.0, -5.0));
	block[2].s[1].c = (vec4(9.0, -3.0, 2.0, -3.0));
	block[2].s[2].a = (ivec3(-4, -9, -2));
	block[2].s[2].b[0][0] = (vec3(9.0, 6.0, 9.0));
	block[2].s[2].b[0][1] = (vec3(-8.0, -8.0, 8.0));
	block[2].s[2].b[0][2] = (vec3(-2.0, -1.0, 6.0));
	block[2].s[2].b[1][0] = (vec3(8.0, -7.0, -4.0));
	block[2].s[2].b[1][1] = (vec3(1.0, -9.0, -8.0));
	block[2].s[2].b[1][2] = (vec3(8.0, -5.0, -3.0));
	block[2].s[2].b[2][0] = (vec3(2.0, 5.0, -2.0));
	block[2].s[2].b[2][1] = (vec3(-6.0, -9.0, 8.0));
	block[2].s[2].b[2][2] = (vec3(-4.0, -4.0, -9.0));
	block[2].s[2].b[3][0] = (vec3(6.0, 4.0, 8.0));
	block[2].s[2].b[3][1] = (vec3(8.0, 2.0, 1.0));
	block[2].s[2].b[3][2] = (vec3(7.0, 2.0, 1.0));
	block[2].s[2].c = (vec4(3.0, -7.0, -5.0, 2.0));
	block[2].v = (vec4(-1.0, -7.0, -6.0, 9.0));
}
#version 450
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
	allOk = compare_uvec2((s[0].a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(-5.0, 2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(-1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(9.0, -4.0, 2.0, 9.0, 7.0, 3.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(8.0, -3.0, 3.0, 0.0, 1.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(9.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(1u, 6u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(4.0, 4.0, -9.0, -3.0, 1.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(-6.0, 6.0, 1.0, 0.0, -2.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(3.0, 1.0, -5.0, -3.0, -2.0, -2.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(7.0, 0.0, -4.0, 8.0, -5.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(5.0, -7.0, 1.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(-3.0, -6.0, 1.0, 1.0, 1.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(1.0, -1.0, 7.0, -3.0, -2.0, 1.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(9.0, -6.0, -9.0, -2.0, -9.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(2.0, 2.0, -2.0, -3.0, 4.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(-9.0, 0.0, 4.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(-7.0, 8.0, -8.0, 7.0, -9.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(9.0, 3.0, -3.0, 4.0, 4.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(2.0, -2.0, 4.0, -8.0, 0.0, 3.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(-1.0, 8.0, -1.0, -7.0, -3.0, -9.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(-3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (3u);
	s[0].a = (uvec2(4u, 9u));
	s[0].b[0] = (mat2x4(-5.0, 6.0, -6.0, -5.0, -4.0, -9.0, 4.0, 6.0));
	s[0].b[1] = (mat2x4(-9.0, 6.0, 7.0, -3.0, 2.0, -8.0, 1.0, 5.0));
	s[0].b[2] = (mat2x4(1.0, 7.0, -8.0, -3.0, -4.0, 9.0, -3.0, -3.0));
	s[0].b[3] = (mat2x4(-4.0, 4.0, -8.0, -1.0, -1.0, -8.0, 4.0, -9.0));
	s[0].c = (vec3(-9.0, -7.0, 4.0));
	s[1].a = (uvec2(3u, 8u));
	s[1].b[0] = (mat2x4(-6.0, -5.0, 7.0, -8.0, 5.0, 2.0, -1.0, -3.0));
	s[1].b[1] = (mat2x4(-6.0, 0.0, -5.0, 8.0, 2.0, -3.0, -7.0, 0.0));
	s[1].b[2] = (mat2x4(2.0, 8.0, 7.0, -6.0, -7.0, 2.0, -1.0, 5.0));
	s[1].b[3] = (mat2x4(3.0, -4.0, 0.0, 8.0, -7.0, -2.0, -4.0, 0.0));
	s[1].c = (vec3(-8.0, 3.0, 6.0));
	s[2].a = (uvec2(9u, 5u));
	s[2].b[0] = (mat2x4(5.0, -6.0, -4.0, 4.0, 9.0, 4.0, 1.0, -7.0));
	s[2].b[1] = (mat2x4(-5.0, 9.0, -9.0, 8.0, -8.0, 3.0, 9.0, 2.0));
	s[2].b[2] = (mat2x4(2.0, 6.0, 0.0, -4.0, 4.0, 9.0, -1.0, 9.0));
	s[2].b[3] = (mat2x4(-8.0, -5.0, -3.0, 3.0, 6.0, -6.0, 9.0, -9.0));
	s[2].c = (vec3(7.0, 7.0, 5.0));
	s[3].a = (uvec2(6u, 0u));
	s[3].b[0] = (mat2x4(-8.0, -8.0, 7.0, 2.0, 5.0, -5.0, -4.0, 5.0));
	s[3].b[1] = (mat2x4(-1.0, -8.0, -1.0, -9.0, 6.0, 7.0, 0.0, 8.0));
	s[3].b[2] = (mat2x4(2.0, -2.0, 2.0, 7.0, -1.0, -8.0, -7.0, 3.0));
	s[3].b[3] = (mat2x4(-3.0, 4.0, 2.0, 2.0, -4.0, -8.0, 6.0, 6.0));
	s[3].c = (vec3(0.0, 1.0, -5.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x2 var;
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	highp vec2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block[0].var), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].var), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block[2].var), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec2(3.0, 8.0));
	block[1].var = (vec2(7.0, -1.0));
	block[2].var = (vec2(-4.0, 8.0));
}
#version 450
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
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-2.0, 8.0));
	block[0].var[1] = (vec2(1.0, 8.0));
	block[0].var[2] = (vec2(-7.0, 5.0));
	block[1].var[0] = (vec2(2.0, 0.0));
	block[1].var[1] = (vec2(-3.0, 1.0));
	block[1].var[2] = (vec2(2.0, -5.0));
	block[2].var[0] = (vec2(6.0, 3.0));
	block[2].var[1] = (vec2(6.0, 5.0));
	block[2].var[2] = (vec2(-5.0, 9.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0, 6.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	block[1].padding = (-2.0);
	block[1].var = (mat4x3(2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0, -4.0));
	block[2].padding = (-4.0);
	block[2].var = (mat4x3(-1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0, -5.0, 6.0));
}
#version 450
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
	allOk = compare_float((blockA.a), -4.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-4, 1)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(1.0, -7.0, 9.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-8.0);
	blockA.b.a[0] = (vec3(-9.0, 6.0, -6.0));
	blockA.b.a[1] = (vec3(-2.0, 4.0, -5.0));
	blockA.b.a[2] = (vec3(-9.0, -7.0, -1.0));
	blockA.b.b[0] = (ivec2(2, 2));
	blockA.b.b[1] = (ivec2(-5, 0));
	blockA.b.b[2] = (ivec2(-7, 9));
	blockA.b.b[3] = (ivec2(9, -1));
	blockA.b.c = (vec4(-4.0, 4.0, -4.0, 9.0));
	blockB.a[0] = (vec2(-7.0, -1.0));
	blockB.a[1] = (vec2(-1.0, -7.0));
	blockB.b.a = (5u);
	blockB.b.b.a[0] = (vec3(6.0, -5.0, 4.0));
	blockB.b.b.a[1] = (vec3(-9.0, 3.0, -6.0));
	blockB.b.b.a[2] = (vec3(1.0, -5.0, 9.0));
	blockB.b.b.b[0] = (ivec2(1, 4));
	blockB.b.b.b[1] = (ivec2(-5, -1));
	blockB.b.b.b[2] = (ivec2(8, -9));
	blockB.b.b.b[3] = (ivec2(7, -4));
	blockB.b.b.c = (vec4(3.0, 9.0, 8.0, 5.0));
	blockB.b.c = (bvec4(false, false, true, true));
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

layout(std430, binding = 1) buffer BlockB
{
	highp uvec2 a[1];
};
layout(std430, binding = 2) buffer BlockC
{
	highp ivec4 b;
	bvec2 c;
	highp ivec3 d;
	lowp float e;
	bvec2 f;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bvec2 g;
	highp uint h[1];
	lowp vec3 i;
	lowp ivec2 j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockC.c), bvec2(true, true)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(1, -5, -2)) && allOk;
	allOk = compare_uint((blockD.h[0]), 1u) && allOk;
	allOk = compare_ivec2((blockD.j), ivec2(5, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec2(4u, 4u));
	blockC.b = (ivec4(-5, 5, -4, 2));
	blockC.d = (ivec3(5, -8, -2));
	blockD.g = (bvec2(true, true));
	blockD.j = (ivec2(5, -6));
}
#version 450
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
	bvec3 a;
	mediump mat3x4 b[];
} blockB;
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	highp mat4x3 c[][7][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[1], mat3x4(7.0, 3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[2], mat3x4(5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[3], mat3x4(1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[4], mat3x4(-4.0, 0.0, 1.0, -3.0, -9.0, -6.0, 6.0, 5.0, -5.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[5], mat3x4(2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0, 5.0, 1.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, false));
	blockB.b[0] = (mat3x4(-5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0, 8.0));
	blockB.b[1] = (mat3x4(0.0, 8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0, -2.0, -7.0, -5.0, 7.0));
	blockB.b[2] = (mat3x4(-9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0, -8.0));
	blockB.b[3] = (mat3x4(4.0, 8.0, 5.0, 3.0, 5.0, -4.0, 8.0, 8.0, 0.0, -8.0, 1.0, -8.0));
	blockB.b[4] = (mat3x4(2.0, -7.0, -2.0, 2.0, -5.0, -5.0, -8.0, -6.0, -3.0, -6.0, -4.0, -7.0));
	blockB.b[5] = (mat3x4(7.0, 6.0, 9.0, -9.0, 3.0, 4.0, 2.0, -6.0, 4.0, -6.0, -4.0, -8.0));
}
#version 450
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
	mediump mat3x4 a[4];
	bvec4 b[6];
	lowp ivec4 c;
	highp uint d[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp float e;
	lowp mat4 f;
	highp mat3 g[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat2x3 h[3];
	mediump int i;
	bvec4 j;
	lowp vec2 k;
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp vec2 l;
	mediump vec2 m;
	mediump mat3x2 n;
	bvec3 o;
	mediump uint p[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a[0], mat3x4(-8.0, -2.0, 9.0, -5.0, 5.0, 6.0, -1.0, 9.0, -1.0, 6.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1], mat3x4(1.0, 8.0, 1.0, -2.0, -8.0, -6.0, -1.0, -8.0, -7.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2], mat3x4(-6.0, 5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3], mat3x4(5.0, -4.0, 3.0, -1.0, 4.0, -2.0, -5.0, -9.0, -7.0, 6.0, -3.0, 6.0)) && allOk;
	allOk = compare_float((e), -2.0) && allOk;
	allOk = compare_mat4(f, mat4(-4.0, 0.0, 8.0, 8.0, 1.0, 1.0, 1.0, -6.0, -6.0, 1.0, -6.0, -3.0, -5.0, -5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(g[0], mat3(-1.0, 7.0, -8.0, -9.0, 2.0, 0.0, 9.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(g[1], mat3(1.0, -4.0, -2.0, -1.0, -8.0, -2.0, 9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[0], mat2x3(3.0, 1.0, -6.0, -8.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[1], mat2x3(-6.0, 8.0, -5.0, 1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[2], mat2x3(-2.0, 2.0, -3.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_int((blockD.i), 2) && allOk;
	allOk = compare_bvec4((blockD.j), bvec4(false, false, true, true)) && allOk;
	allOk = compare_vec2((blockD.k), vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2((blockE.l), vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2((blockE.m), vec2(7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE.n, mat3x2(-5.0, 3.0, 0.0, -5.0, 5.0, -8.0)) && allOk;
	allOk = compare_uint((blockE.p[0]), 4u) && allOk;
	allOk = compare_uint((blockE.p[1]), 1u) && allOk;
	allOk = compare_uint((blockE.p[2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(1.0, 1.0, -4.0, 1.0, 8.0, -4.0, 1.0, -9.0, 3.0, 0.0, -9.0, -6.0));
	blockB.a[1] = (mat3x4(3.0, 4.0, -1.0, -4.0, -7.0, -8.0, -3.0, 6.0, 5.0, -2.0, -1.0, -4.0));
	blockB.a[2] = (mat3x4(-8.0, 2.0, 0.0, 3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0, 6.0, -7.0));
	blockB.a[3] = (mat3x4(3.0, 9.0, 8.0, 1.0, 7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0, -2.0));
	e = (0.0);
	f = (mat4(-8.0, 2.0, -3.0, 2.0, -7.0, 0.0, -5.0, -4.0, -6.0, -3.0, -9.0, -2.0, -8.0, 4.0, 4.0, -3.0));
	g[0] = (mat3(-2.0, -5.0, -1.0, -5.0, -9.0, 1.0, 2.0, -8.0, 8.0));
	g[1] = (mat3(-6.0, 3.0, -3.0, -3.0, -6.0, -7.0, -4.0, -9.0, 5.0));
	blockD.i = (8);
	blockD.j = (bvec4(true, true, true, false));
	blockD.k = (vec2(7.0, 4.0));
	blockE.l = (vec2(8.0, 9.0));
	blockE.m = (vec2(4.0, 9.0));
	blockE.n = (mat3x2(3.0, 3.0, 3.0, 5.0, 5.0, 0.0));
	blockE.o = (bvec3(false, true, false));
	blockE.p[0] = (2u);
	blockE.p[1] = (9u);
	blockE.p[2] = (4u);
}
#version 450
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
};
struct sB
{
	mediump uvec4 mA;
	sA mB;
	lowp int mC;
};
layout(std430, binding = 1) buffer BlockB
{
	bvec3 a;
	bvec4 b[1];
	sB c;
	lowp uvec3 d;
	highp mat4x3 e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat3 f;
	bvec4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b[0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec4((blockB.c.mA), uvec4(1u, 7u, 0u, 5u)) && allOk;
	allOk = compare_mat4x3(blockB.c.mB.mA, mat4x3(-9.0, -6.0, -9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_int((blockB.c.mC), -7) && allOk;
	allOk = compare_bvec4((g[0]), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec4(true, false, true, true));
	blockB.c.mA = (uvec4(8u, 8u, 8u, 0u));
	blockB.c.mB.mA = (mat4x3(9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0));
	blockB.c.mC = (0);
	blockB.d = (uvec3(4u, 4u, 4u));
	blockB.e[0] = (mat4x3(-7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0));
	f = (mat3(8.0, 0.0, -4.0, -7.0, 7.0, 1.0, 4.0, 2.0, 6.0));
	g[0] = (bvec4(false, true, false, false));
}
#version 450
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
	bvec2 a;
	bvec4 b;
	mediump mat2x3 c;
	highp mat4x2 d[7];
	lowp mat3 e[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[0], mat4x2(-9.0, 0.0, 0.0, -2.0, -9.0, -5.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1], mat4x2(4.0, 8.0, -7.0, 9.0, -2.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2], mat4x2(2.0, 9.0, 3.0, -3.0, 8.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3], mat4x2(-9.0, -3.0, 2.0, 5.0, 7.0, 0.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4], mat4x2(7.0, -4.0, 3.0, 8.0, 3.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[5], mat4x2(4.0, 7.0, 1.0, 6.0, -5.0, -9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[6], mat4x2(-3.0, -6.0, 5.0, -5.0, 1.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.e[0], mat3(-8.0, -1.0, 1.0, -6.0, 7.0, 5.0, 0.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.e[1], mat3(3.0, 5.0, -1.0, 4.0, -9.0, -2.0, 6.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (bvec4(true, true, false, true));
	blockB.d[0] = (mat4x2(-6.0, -3.0, -1.0, -9.0, -2.0, -5.0, 2.0, 3.0));
	blockB.d[1] = (mat4x2(5.0, 8.0, -5.0, -3.0, -2.0, -3.0, -2.0, -8.0));
	blockB.d[2] = (mat4x2(1.0, 7.0, -3.0, -4.0, -1.0, -5.0, 3.0, -1.0));
	blockB.d[3] = (mat4x2(-3.0, 9.0, 1.0, -8.0, -9.0, -8.0, 8.0, 3.0));
	blockB.d[4] = (mat4x2(-3.0, 1.0, 0.0, -4.0, 4.0, 6.0, 6.0, 0.0));
	blockB.d[5] = (mat4x2(-2.0, -7.0, -1.0, -6.0, 5.0, -2.0, 2.0, -6.0));
	blockB.d[6] = (mat4x2(9.0, -3.0, 9.0, 9.0, -9.0, -9.0, 5.0, -7.0));
}
#version 450
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
	mediump uvec2 a;
	mediump mat4x3 b;
	lowp vec2 c;
	bvec2 d[];
} blockB[1];

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

layout(row_major, binding = 1) buffer BlockB
{
	layout(offset = 0) bvec3 a[1];
	layout(offset = 16) lowp ivec2 b[1];
	layout(offset = 24) highp mat2x3 c;
	layout(offset = 48) mediump vec2 d;
} blockB[];

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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) highp float a;
	layout(offset = 4) mediump uvec3 b;
	layout(offset = 16) i16vec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec3 d;
	layout(offset = 16) highp vec4 e;
	layout(offset = 32) bool f[1];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 6.0) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(7u, 0u, 2u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c), ivec4(5, -2, -2, -6)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(6, -6, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(8u, 5u, 6u));
	blockC.d = (ivec3(7, 7, -9));
	blockC.e = (vec4(-9.0, 4.0, -3.0, -7.0));
	blockC.f[0] = (false);
}
#version 450
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
	layout(offset = 0) mediump vec3 a[1];
	layout(offset = 16) bvec3 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) uint16_t c;
	layout(offset = 4) mediump int d;
	layout(offset = 8) bvec2 e;
	layout(offset = 16) mediump vec4 f;
	layout(offset = 32) lowp uvec4 g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a[0]), vec3(8.0, 1.0, 7.0)) && allOk;
	allOk = compare_bvec3((b), bvec3(true, true, true)) && allOk;
	allOk = compare_int((blockC.d), 9) && allOk;
	allOk = compare_vec4((blockC.f), vec4(7.0, 7.0, 1.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(3u, 5u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec3(9.0, 9.0, 3.0));
	b = (bvec3(true, false, false));
	blockC.c = uint16_t(0u);
	blockC.e = (bvec2(false, true));
	blockC.f = (vec4(-3.0, -1.0, 4.0, -5.0));
}
#version 450
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
	lowp ivec2 a;
	highp int b;
	mediump vec3 c;
	lowp uvec4 d[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].d[0]), uvec4(3u, 1u, 9u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[1]), uvec4(9u, 6u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[2]), uvec4(8u, 8u, 9u, 9u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[3]), uvec4(1u, 2u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[4]), uvec4(0u, 1u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec2(8, 7));
	blockB[0].b = (-2);
	blockB[0].c = (vec3(6.0, 0.0, 5.0));
	blockB[0].d[0] = (uvec4(3u, 5u, 7u, 7u));
	blockB[0].d[1] = (uvec4(0u, 3u, 5u, 5u));
	blockB[0].d[2] = (uvec4(3u, 6u, 0u, 8u));
	blockB[0].d[3] = (uvec4(6u, 1u, 5u, 8u));
	blockB[0].d[4] = (uvec4(0u, 2u, 6u, 3u));
}
#version 450
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
	lowp uvec3 mA;
};
struct sC
{
	uint16_t mA;
	bool mB;
	highp ivec4 mC[6];
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp uvec4 a;
	u16vec4 b;
	float16_t c;
	sA d[][2];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	uint16_t e;
	mediump mat3x4 f;
	lowp int g;
	i16vec4 h;
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	sB i;
	highp vec2 j;
	highp mat3x4 k;
	sC l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(d[0][0].mA), 0u) && allOk;
	allOk = compare_uvec3((d[0][0].mB), uvec3(1u, 4u, 2u)) && allOk;
	allOk = compare_bool((d[0][0].mC), true) && allOk;
	allOk = compare_uint16_t(uint(d[0][1].mA), 3u) && allOk;
	allOk = compare_uvec3((d[0][1].mB), uvec3(6u, 1u, 4u)) && allOk;
	allOk = compare_bool((d[0][1].mC), false) && allOk;
	allOk = compare_uint16_t(uint(d[1][0].mA), 5u) && allOk;
	allOk = compare_uvec3((d[1][0].mB), uvec3(4u, 9u, 3u)) && allOk;
	allOk = compare_bool((d[1][0].mC), true) && allOk;
	allOk = compare_uint16_t(uint(d[1][1].mA), 5u) && allOk;
	allOk = compare_uvec3((d[1][1].mB), uvec3(6u, 4u, 4u)) && allOk;
	allOk = compare_bool((d[1][1].mC), true) && allOk;
	allOk = compare_uint16_t(uint(d[2][0].mA), 3u) && allOk;
	allOk = compare_uvec3((d[2][0].mB), uvec3(1u, 0u, 7u)) && allOk;
	allOk = compare_bool((d[2][0].mC), true) && allOk;
	allOk = compare_uint16_t(uint(d[2][1].mA), 2u) && allOk;
	allOk = compare_uvec3((d[2][1].mB), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_bool((d[2][1].mC), true) && allOk;
	allOk = compare_uint16_t(uint(d[3][0].mA), 2u) && allOk;
	allOk = compare_uvec3((d[3][0].mB), uvec3(1u, 0u, 6u)) && allOk;
	allOk = compare_bool((d[3][0].mC), false) && allOk;
	allOk = compare_uint16_t(uint(d[3][1].mA), 0u) && allOk;
	allOk = compare_uvec3((d[3][1].mB), uvec3(2u, 2u, 3u)) && allOk;
	allOk = compare_bool((d[3][1].mC), true) && allOk;
	allOk = compare_uint16_t(uint(d[4][0].mA), 8u) && allOk;
	allOk = compare_uvec3((d[4][0].mB), uvec3(7u, 3u, 1u)) && allOk;
	allOk = compare_bool((d[4][0].mC), true) && allOk;
	allOk = compare_uint16_t(uint(d[4][1].mA), 5u) && allOk;
	allOk = compare_uvec3((d[4][1].mB), uvec3(3u, 0u, 2u)) && allOk;
	allOk = compare_bool((d[4][1].mC), true) && allOk;
	allOk = compare_mat3x4(f, mat3x4(-4.0, 0.0, 2.0, -9.0, -4.0, 3.0, 0.0, 6.0, 9.0, 4.0, -1.0, 3.0)) && allOk;
	allOk = compare_int((g), 7) && allOk;
	allOk = compare_i16vec4(ivec4(h), ivec4(4, 5, -6, -1)) && allOk;
	allOk = compare_uvec3((i.mA), uvec3(7u, 6u, 3u)) && allOk;
	allOk = compare_vec2((j), vec2(7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec4(1u, 3u, 1u, 1u));
	b = u16vec4(uvec4(0u, 5u, 5u, 0u));
	c = float16_t(-2.0);
	e = uint16_t(9u);
	f = (mat3x4(0.0, -3.0, 9.0, 8.0, -8.0, 8.0, -6.0, -6.0, -6.0, -9.0, -1.0, 8.0));
	i.mA = (uvec3(6u, 4u, 4u));
	l[0].mA = uint16_t(3u);
	l[0].mB = (true);
	l[0].mC[0] = (ivec4(1, -8, 8, 9));
	l[0].mC[1] = (ivec4(5, -3, 4, -3));
	l[0].mC[2] = (ivec4(-6, -7, 5, 3));
	l[0].mC[3] = (ivec4(-2, -6, 5, -9));
	l[0].mC[4] = (ivec4(2, 2, 6, 9));
	l[0].mC[5] = (ivec4(4, -4, -6, 7));
	l[1].mA = uint16_t(4u);
	l[1].mB = (true);
	l[1].mC[0] = (ivec4(-2, 6, 6, 4));
	l[1].mC[1] = (ivec4(-6, -7, 7, 3));
	l[1].mC[2] = (ivec4(8, -7, -5, -2));
	l[1].mC[3] = (ivec4(-4, -8, -1, 0));
	l[1].mC[4] = (ivec4(0, 3, 4, -8));
	l[1].mC[5] = (ivec4(4, -9, 8, 4));
	l[2].mA = uint16_t(3u);
	l[2].mB = (true);
	l[2].mC[0] = (ivec4(-4, -7, -1, -2));
	l[2].mC[1] = (ivec4(-2, 9, -1, 0));
	l[2].mC[2] = (ivec4(-4, 7, 6, -2));
	l[2].mC[3] = (ivec4(7, -8, -5, -6));
	l[2].mC[4] = (ivec4(-7, 9, -6, -5));
	l[2].mC[5] = (ivec4(-1, -4, 8, -6));
	l[3].mA = uint16_t(6u);
	l[3].mB = (false);
	l[3].mC[0] = (ivec4(3, 3, 1, 7));
	l[3].mC[1] = (ivec4(-2, -6, 9, 7));
	l[3].mC[2] = (ivec4(0, 3, 8, 8));
	l[3].mC[3] = (ivec4(-9, 2, -7, 0));
	l[3].mC[4] = (ivec4(-3, -9, 7, -3));
	l[3].mC[5] = (ivec4(-5, -6, 5, -1));
	l[4].mA = uint16_t(0u);
	l[4].mB = (false);
	l[4].mC[0] = (ivec4(-4, -9, -9, -6));
	l[4].mC[1] = (ivec4(-6, -7, 0, -2));
	l[4].mC[2] = (ivec4(-7, 6, -8, -4));
	l[4].mC[3] = (ivec4(-9, -3, -7, 5));
	l[4].mC[4] = (ivec4(-3, 6, -3, -9));
	l[4].mC[5] = (ivec4(-5, -7, -9, -9));
}
#version 450
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
	layout(offset = 0) uint16_t a;
	layout(offset = 2) f16vec4 b;
	layout(offset = 10) uint16_t c;
	layout(offset = 16) mediump uvec4 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(0)].a), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(1)].a), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(2)].a), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(3)].a), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = f16vec4(vec4(-1.0, 8.0, -4.0, 7.0));
	blockB[nonuniformEXT(0)].d = (uvec4(7u, 1u, 7u, 5u));
	blockB[nonuniformEXT(1)].b = f16vec4(vec4(1.0, 9.0, -4.0, -9.0));
	blockB[nonuniformEXT(1)].d = (uvec4(9u, 0u, 2u, 3u));
	blockB[nonuniformEXT(2)].b = f16vec4(vec4(9.0, -9.0, 4.0, -3.0));
	blockB[nonuniformEXT(2)].d = (uvec4(3u, 8u, 7u, 9u));
	blockB[nonuniformEXT(3)].b = f16vec4(vec4(-4.0, -9.0, -6.0, 4.0));
	blockB[nonuniformEXT(3)].d = (uvec4(5u, 9u, 7u, 1u));
}
#version 450
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
	highp float a[1];
	lowp float b;
	int8_t c;
	lowp uint d;
	mediump float e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a[0]), 1.0) && allOk;
	allOk = compare_float((blockB.b), -5.0) && allOk;
	allOk = compare_uint((blockB.d), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (2.0);
	blockB.b = (7.0);
	blockB.c = int8_t(4294967291);
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

layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat4 a;
	highp mat4x2 b;
	bvec4 c;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	uint8_t d;
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp uvec3 e;
	lowp vec2 f;
	mediump uvec3 g;
	bvec4 h;
	mediump uvec3 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uvec3((e), uvec3(4u, 9u, 5u)) && allOk;
	allOk = compare_vec2((f), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_bvec4((h), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec3((i), uvec3(4u, 1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(3.0, -4.0, 2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0));
	blockB.c = (bvec4(true, true, false, true));
	d = uint8_t(9u);
	e = (uvec3(4u, 5u, 1u));
	g = (uvec3(8u, 3u, 6u));
}
#version 450
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
	i8vec4 c;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat2 d;
	mediump mat3 e;
	lowp mat2 f[1];
	mediump uvec2 g;
	lowp mat3 h;
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
	allOk = compare_mat2(blockC.d, mat2(-3.0, 4.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(-1.0, -8.0, -1.0, 6.0, -6.0, -5.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(4.0, 7.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec3(-7, 9, -9));
	c = i8vec4(ivec4(8, 0, 4294967288, 4294967287));
	blockC.e = (mat3(5.0, -5.0, 3.0, -6.0, 0.0, -9.0, 3.0, -9.0, -1.0));
	blockC.f[0] = (mat2(6.0, 7.0, 2.0, -1.0));
	blockC.g = (uvec2(5u, 6u));
}
#version 450
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
	i8vec3 a;
	mediump uvec4 b;
	highp mat3x4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(a), ivec3(4, 4, 4294967292)) && allOk;
	allOk = compare_uvec4((b), uvec4(8u, 9u, 6u, 8u)) && allOk;
	allOk = compare_mat3x4(c[0], mat3x4(3.0, -5.0, -8.0, -6.0, 0.0, 7.0, -1.0, -1.0, 6.0, -5.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec3(ivec3(4294967291, 4, 4294967287));
	b = (uvec4(0u, 7u, 6u, 4u));
}
#version 450
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
	highp mat4x3 mB;
};
struct sB
{
	lowp ivec2 mA;
};
struct sC
{
	bvec4 mA;
	sB mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	i8vec4 a[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	sA b[4];
	lowp vec3 c;
	lowp mat2 d;
	sC e[][3];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	bvec4 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(a[0]), ivec4(0, 3, 3, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(a[1]), ivec4(0, 4294967293, 1, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(a[2]), ivec4(4294967294, 4294967289, 3, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(a[3]), ivec4(2, 3, 3, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(a[4]), ivec4(5, 4294967291, 4294967294, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = i8vec4(ivec4(5, 4294967291, 3, 9));
	a[1] = i8vec4(ivec4(4294967291, 4294967291, 0, 4294967295));
	a[2] = i8vec4(ivec4(4294967287, 2, 4294967292, 4294967288));
	a[3] = i8vec4(ivec4(4294967292, 8, 6, 4294967293));
	a[4] = i8vec4(ivec4(4294967289, 4294967292, 4294967294, 4294967287));
	b[0].mA = (ivec2(-8, -5));
	b[0].mB = (mat4x3(-6.0, 4.0, 6.0, 4.0, 6.0, 1.0, 8.0, -9.0, 3.0, -8.0, 5.0, 0.0));
	b[1].mA = (ivec2(9, -1));
	b[1].mB = (mat4x3(-1.0, 3.0, -9.0, -3.0, 2.0, 1.0, -8.0, 7.0, -9.0, -6.0, 2.0, 6.0));
	b[2].mA = (ivec2(1, 7));
	b[2].mB = (mat4x3(2.0, -8.0, 2.0, -1.0, -7.0, -2.0, 2.0, 8.0, 3.0, -5.0, -9.0, -7.0));
	b[3].mA = (ivec2(9, -8));
	b[3].mB = (mat4x3(2.0, -7.0, -8.0, 0.0, -2.0, -9.0, 4.0, -2.0, -2.0, -1.0, -7.0, 6.0));
	c = (vec3(0.0, -7.0, 3.0));
	f = (bvec4(true, true, false, false));
}
#version 450
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
	i8vec2 mA;
	highp vec2 mB;
	bvec3 mC;
	highp float mD;
};
layout(std140, binding = 1) buffer BlockB
{
	uint8_t a;
	highp vec4 b;
	lowp mat3x2 c;
	uint8_t d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	sB e[];
} blockC[2];
layout(std140, row_major, binding = 3) buffer BlockD
{
	sC f;
	bvec3 g[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	u8vec4 h;
	mediump mat3x2 i[6];
	highp uint j;
	lowp float k[4];
	bool l[][5];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(a), 0u) && allOk;
	allOk = compare_vec4((b), vec4(4.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(c, mat3x2(-5.0, -4.0, -5.0, -3.0, -2.0, -3.0)) && allOk;
	allOk = compare_uint8_t(uint(d[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(d[1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(d[2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(d[3]), 7u) && allOk;
	allOk = compare_uint8_t(uint(d[4]), 7u) && allOk;
	allOk = compare_uint8_t(uint(d[5]), 7u) && allOk;
	allOk = compare_uint8_t(uint(d[6]), 5u) && allOk;
	allOk = compare_uint8_t(uint(d[7]), 9u) && allOk;
	allOk = compare_mat3(blockC[0].e[0].mA.mA, mat3(-6.0, 1.0, 2.0, 4.0, 8.0, 8.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[0].mA.mB), uvec3(3u, 9u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[0].mA.mC), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat3(blockC[0].e[1].mA.mA, mat3(-9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[1].mA.mB), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[1].mA.mC), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat3(blockC[0].e[2].mA.mA, mat3(-4.0, 3.0, 5.0, 9.0, -3.0, -6.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[2].mA.mB), uvec3(0u, 9u, 4u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[2].mA.mC), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat3(blockC[0].e[3].mA.mA, mat3(1.0, -9.0, 2.0, -2.0, -3.0, 0.0, -4.0, 4.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[3].mA.mB), uvec3(3u, 2u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[3].mA.mC), uvec2(4u, 7u)) && allOk;
	allOk = compare_mat3(blockC[0].e[4].mA.mA, mat3(9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0, -1.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[4].mA.mB), uvec3(1u, 3u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[4].mA.mC), uvec2(6u, 0u)) && allOk;
	allOk = compare_mat3(blockC[0].e[5].mA.mA, mat3(8.0, 7.0, -4.0, -7.0, 2.0, -6.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[5].mA.mB), uvec3(8u, 5u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[5].mA.mC), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat3(blockC[0].e[6].mA.mA, mat3(-9.0, -6.0, 2.0, -8.0, -9.0, 4.0, -8.0, -1.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[6].mA.mB), uvec3(6u, 6u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[6].mA.mC), uvec2(3u, 1u)) && allOk;
	allOk = compare_mat3(blockC[1].e[0].mA.mA, mat3(-6.0, -3.0, 3.0, -1.0, 0.0, -2.0, -4.0, 6.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[0].mA.mB), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[0].mA.mC), uvec2(4u, 2u)) && allOk;
	allOk = compare_mat3(blockC[1].e[1].mA.mA, mat3(-7.0, -1.0, 4.0, -2.0, 8.0, -4.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[1].mA.mB), uvec3(1u, 0u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[1].mA.mC), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat3(blockC[1].e[2].mA.mA, mat3(5.0, -9.0, 3.0, 9.0, 1.0, 6.0, -5.0, -9.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[2].mA.mB), uvec3(6u, 9u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[2].mA.mC), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat3(blockC[1].e[3].mA.mA, mat3(-1.0, 8.0, -5.0, 8.0, 2.0, -1.0, 8.0, -8.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[3].mA.mB), uvec3(7u, 0u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[3].mA.mC), uvec2(1u, 3u)) && allOk;
	allOk = compare_mat3(blockC[1].e[4].mA.mA, mat3(2.0, -6.0, 1.0, 9.0, -2.0, -2.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[4].mA.mB), uvec3(5u, 2u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[4].mA.mC), uvec2(4u, 5u)) && allOk;
	allOk = compare_mat3(blockC[1].e[5].mA.mA, mat3(-5.0, -3.0, 4.0, 3.0, 2.0, 9.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[5].mA.mB), uvec3(0u, 3u, 0u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[5].mA.mC), uvec2(5u, 4u)) && allOk;
	allOk = compare_mat3(blockC[1].e[6].mA.mA, mat3(7.0, -2.0, 6.0, 0.0, 5.0, 5.0, 3.0, -9.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[6].mA.mB), uvec3(2u, 5u, 0u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[6].mA.mC), uvec2(9u, 2u)) && allOk;
	allOk = compare_i8vec2(ivec2(f.mA), ivec2(6, 4294967289)) && allOk;
	allOk = compare_vec2((f.mB), vec2(7.0, 9.0)) && allOk;
	allOk = compare_bvec3((f.mC), bvec3(false, true, true)) && allOk;
	allOk = compare_float((f.mD), 2.0) && allOk;
	allOk = compare_bvec3((g[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((g[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((g[2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((g[3]), bvec3(true, true, false)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.h), uvec4(4u, 8u, 4u, 2u)) && allOk;
	allOk = compare_uint((blockE.j), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec4(3.0, -9.0, -7.0, -4.0));
	c = (mat3x2(-1.0, 9.0, -4.0, -4.0, 3.0, -7.0));
	blockC[0].e[0].mA.mA = (mat3(-5.0, -9.0, 9.0, -1.0, 9.0, 4.0, 1.0, -8.0, -2.0));
	blockC[0].e[0].mA.mB = (uvec3(9u, 0u, 2u));
	blockC[0].e[0].mA.mC = (uvec2(1u, 5u));
	blockC[0].e[1].mA.mA = (mat3(-5.0, -9.0, -7.0, 0.0, 7.0, -2.0, 9.0, -6.0, 8.0));
	blockC[0].e[1].mA.mB = (uvec3(4u, 5u, 1u));
	blockC[0].e[1].mA.mC = (uvec2(3u, 4u));
	blockC[0].e[2].mA.mA = (mat3(5.0, 3.0, -3.0, 6.0, -2.0, 2.0, -5.0, 5.0, 5.0));
	blockC[0].e[2].mA.mB = (uvec3(9u, 6u, 8u));
	blockC[0].e[2].mA.mC = (uvec2(9u, 1u));
	blockC[0].e[3].mA.mA = (mat3(3.0, 8.0, 5.0, 5.0, 3.0, 6.0, 5.0, 1.0, 1.0));
	blockC[0].e[3].mA.mB = (uvec3(0u, 5u, 3u));
	blockC[0].e[3].mA.mC = (uvec2(1u, 1u));
	blockC[0].e[4].mA.mA = (mat3(-2.0, -3.0, 8.0, 2.0, -1.0, -8.0, 9.0, -7.0, 5.0));
	blockC[0].e[4].mA.mB = (uvec3(8u, 8u, 3u));
	blockC[0].e[4].mA.mC = (uvec2(5u, 7u));
	blockC[0].e[5].mA.mA = (mat3(1.0, 3.0, 6.0, -8.0, -8.0, -6.0, 7.0, 6.0, -5.0));
	blockC[0].e[5].mA.mB = (uvec3(6u, 5u, 7u));
	blockC[0].e[5].mA.mC = (uvec2(5u, 6u));
	blockC[0].e[6].mA.mA = (mat3(7.0, 6.0, -6.0, 0.0, 7.0, -7.0, 4.0, -4.0, -8.0));
	blockC[0].e[6].mA.mB = (uvec3(7u, 0u, 2u));
	blockC[0].e[6].mA.mC = (uvec2(5u, 3u));
	blockC[1].e[0].mA.mA = (mat3(7.0, -9.0, 3.0, -1.0, 0.0, 8.0, -9.0, -5.0, 5.0));
	blockC[1].e[0].mA.mB = (uvec3(2u, 5u, 9u));
	blockC[1].e[0].mA.mC = (uvec2(7u, 3u));
	blockC[1].e[1].mA.mA = (mat3(1.0, -1.0, -9.0, -5.0, -1.0, 2.0, -4.0, -1.0, -8.0));
	blockC[1].e[1].mA.mB = (uvec3(3u, 5u, 1u));
	blockC[1].e[1].mA.mC = (uvec2(2u, 8u));
	blockC[1].e[2].mA.mA = (mat3(-3.0, 3.0, 3.0, 8.0, 2.0, -9.0, -2.0, -3.0, 4.0));
	blockC[1].e[2].mA.mB = (uvec3(7u, 4u, 2u));
	blockC[1].e[2].mA.mC = (uvec2(7u, 6u));
	blockC[1].e[3].mA.mA = (mat3(-7.0, -6.0, 8.0, 5.0, 2.0, -1.0, 0.0, 4.0, 9.0));
	blockC[1].e[3].mA.mB = (uvec3(9u, 6u, 6u));
	blockC[1].e[3].mA.mC = (uvec2(7u, 9u));
	blockC[1].e[4].mA.mA = (mat3(-2.0, 0.0, 9.0, 9.0, -2.0, -5.0, 9.0, -8.0, 8.0));
	blockC[1].e[4].mA.mB = (uvec3(8u, 2u, 9u));
	blockC[1].e[4].mA.mC = (uvec2(6u, 9u));
	blockC[1].e[5].mA.mA = (mat3(-5.0, 5.0, -7.0, -4.0, 3.0, 4.0, -1.0, 6.0, 1.0));
	blockC[1].e[5].mA.mB = (uvec3(0u, 0u, 3u));
	blockC[1].e[5].mA.mC = (uvec2(2u, 1u));
	blockC[1].e[6].mA.mA = (mat3(9.0, -3.0, -8.0, 0.0, -7.0, -9.0, 4.0, 3.0, 7.0));
	blockC[1].e[6].mA.mB = (uvec3(2u, 3u, 6u));
	blockC[1].e[6].mA.mC = (uvec2(4u, 4u));
	f.mA = i8vec2(ivec2(0, 9));
	f.mB = (vec2(6.0, 0.0));
	f.mC = (bvec3(true, true, false));
	f.mD = (-7.0);
	g[0] = (bvec3(false, true, false));
	g[1] = (bvec3(true, true, true));
	g[2] = (bvec3(false, false, true));
	g[3] = (bvec3(false, false, true));
	blockE.h = u8vec4(uvec4(5u, 2u, 9u, 3u));
	blockE.j = (2u);
	blockE.l[0][0] = (false);
	blockE.l[0][1] = (false);
	blockE.l[0][2] = (true);
	blockE.l[0][3] = (false);
	blockE.l[0][4] = (true);
	blockE.l[1][0] = (true);
	blockE.l[1][1] = (true);
	blockE.l[1][2] = (false);
	blockE.l[1][3] = (false);
	blockE.l[1][4] = (true);
}
#version 450
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
	i8vec2 a;
	highp mat3x4 b;
	highp vec3 c;
	lowp uint d[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	bvec2 e;
	lowp uint f[4][7];
	highp int g;
	lowp int h;
	i8vec3 i[];
} blockC;
layout(std430, column_major, binding = 3) readonly buffer BlockD
{
	mediump mat4x2 j[];
} blockD[3];
layout(std140, row_major, binding = 4) buffer BlockE
{
	i8vec2 k;
	mediump mat4x3 l[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(a), ivec2(1, 3)) && allOk;
	allOk = compare_mat3x4(b, mat3x4(9.0, -2.0, -4.0, -5.0, -6.0, -8.0, -2.0, -1.0, 1.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_uint((d[0]), 0u) && allOk;
	allOk = compare_uint((d[1]), 2u) && allOk;
	allOk = compare_uint((d[2]), 2u) && allOk;
	allOk = compare_uint((d[3]), 0u) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(false, true)) && allOk;
	allOk = compare_int((blockC.h), -1) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.i[0]), ivec3(4294967290, 3, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.i[1]), ivec3(1, 6, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.i[2]), ivec3(4294967292, 5, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.i[3]), ivec3(4, 4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.i[4]), ivec3(2, 4294967287, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.i[5]), ivec3(2, 9, 7)) && allOk;
	allOk = compare_mat4x2(blockD[0].j[0], mat4x2(-3.0, -3.0, 3.0, 9.0, 2.0, 4.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].j[1], mat4x2(2.0, -1.0, 2.0, 7.0, -8.0, -3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].j[2], mat4x2(6.0, 0.0, 9.0, -1.0, 6.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].j[0], mat4x2(-5.0, 0.0, -5.0, 7.0, -9.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].j[1], mat4x2(5.0, -3.0, 3.0, 9.0, 3.0, -1.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].j[2], mat4x2(-7.0, 1.0, 8.0, 9.0, 2.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].j[0], mat4x2(7.0, 5.0, -8.0, -9.0, -8.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].j[1], mat4x2(6.0, -9.0, -5.0, -5.0, 4.0, -7.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].j[2], mat4x2(-1.0, 6.0, 2.0, -9.0, -6.0, 3.0, 2.0, -4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE[0].k), ivec2(9, 9)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[0], mat4x3(-6.0, -5.0, 7.0, 8.0, 2.0, -3.0, -8.0, -6.0, -6.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[1], mat4x3(-1.0, -5.0, 5.0, 8.0, -3.0, -1.0, 3.0, 6.0, -3.0, -7.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[2], mat4x3(2.0, -8.0, 7.0, 3.0, -3.0, -6.0, -8.0, 3.0, -6.0, 2.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[3], mat4x3(-8.0, 4.0, -5.0, -6.0, -5.0, 8.0, -1.0, 7.0, -3.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[4], mat4x3(-5.0, 8.0, -9.0, -8.0, -9.0, 3.0, 4.0, 9.0, 3.0, -5.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[5], mat4x3(5.0, -9.0, 6.0, 0.0, -7.0, 2.0, -5.0, 9.0, -3.0, 9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[6], mat4x3(-7.0, 8.0, 5.0, 0.0, 0.0, 5.0, 1.0, -1.0, 2.0, -6.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].l[7], mat4x3(4.0, 7.0, -8.0, 4.0, -7.0, 0.0, -3.0, -4.0, 5.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	d[0] = (0u);
	d[1] = (4u);
	d[2] = (5u);
	d[3] = (9u);
	blockC.e = (bvec2(true, true));
	blockC.g = (2);
	blockC.i[0] = i8vec3(ivec3(8, 1, 4294967291));
	blockC.i[1] = i8vec3(ivec3(4294967295, 4294967292, 5));
	blockC.i[2] = i8vec3(ivec3(2, 4294967287, 2));
	blockC.i[3] = i8vec3(ivec3(2, 1, 4));
	blockC.i[4] = i8vec3(ivec3(0, 7, 2));
	blockC.i[5] = i8vec3(ivec3(0, 4294967292, 0));
	blockE[0].k = i8vec2(ivec2(0, 7));
}
#version 450
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
	highp vec4 mB;
	highp ivec3 mC;
	u8vec4 mD;
};
struct sB
{
	bvec2 mA;
	mediump uvec2 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	highp ivec4 a;
	sA b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	uint8_t c;
	i8vec4 d;
	i8vec4 e;
	bvec3 f[5];
	bvec3 g;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	u8vec2 h;
	sB i;
	mediump mat4x3 j;
	i8vec2 k;
	bool l;
} blockD[1];
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp mat4x2 m[5];
	bool n;
	highp uvec3 o[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(c), 7u) && allOk;
	allOk = compare_bvec3((f[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((f[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f[4]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((g), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4x3(blockD[0].j, mat4x3(-4.0, 7.0, 3.0, -3.0, 2.0, 0.0, 4.0, 3.0, -8.0, 9.0, -6.0, 2.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD[0].k), ivec2(4294967293, 5)) && allOk;
	allOk = compare_bool((blockD[0].l), false) && allOk;
	allOk = compare_bool((blockE.n), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-8, -5, 7, 4));
	blockB.b[0].mA = (mat4x2(4.0, 8.0, 1.0, -4.0, 0.0, -8.0, 6.0, -7.0));
	blockB.b[0].mB = (vec4(-7.0, -2.0, 8.0, 5.0));
	blockB.b[0].mC = (ivec3(-9, 5, -1));
	blockB.b[0].mD = u8vec4(uvec4(7u, 0u, 5u, 5u));
	blockB.b[1].mA = (mat4x2(7.0, 4.0, 3.0, -8.0, -8.0, -7.0, 7.0, -9.0));
	blockB.b[1].mB = (vec4(8.0, 9.0, 9.0, 3.0));
	blockB.b[1].mC = (ivec3(8, -1, -9));
	blockB.b[1].mD = u8vec4(uvec4(6u, 1u, 8u, 7u));
	blockB.b[2].mA = (mat4x2(-8.0, 7.0, 4.0, 4.0, 3.0, -9.0, -9.0, -3.0));
	blockB.b[2].mB = (vec4(4.0, 4.0, 1.0, -9.0));
	blockB.b[2].mC = (ivec3(2, 3, 1));
	blockB.b[2].mD = u8vec4(uvec4(9u, 1u, 8u, 9u));
	blockB.b[3].mA = (mat4x2(8.0, 7.0, 9.0, -7.0, -7.0, 4.0, -1.0, 6.0));
	blockB.b[3].mB = (vec4(5.0, -4.0, -4.0, 5.0));
	blockB.b[3].mC = (ivec3(9, -6, 1));
	blockB.b[3].mD = u8vec4(uvec4(0u, 9u, 8u, 1u));
	blockB.b[4].mA = (mat4x2(3.0, -8.0, 6.0, -7.0, 4.0, -2.0, 1.0, -1.0));
	blockB.b[4].mB = (vec4(8.0, 2.0, 9.0, -2.0));
	blockB.b[4].mC = (ivec3(3, 1, 6));
	blockB.b[4].mD = u8vec4(uvec4(7u, 8u, 2u, 3u));
	blockB.b[5].mA = (mat4x2(-2.0, 0.0, -6.0, -7.0, 1.0, -7.0, -3.0, 3.0));
	blockB.b[5].mB = (vec4(2.0, 7.0, -6.0, -4.0));
	blockB.b[5].mC = (ivec3(-1, 4, 1));
	blockB.b[5].mD = u8vec4(uvec4(7u, 5u, 4u, 2u));
	c = uint8_t(3u);
	d = i8vec4(ivec4(8, 4294967293, 4294967290, 1));
	g = (bvec3(true, false, false));
	blockD[0].h = u8vec2(uvec2(3u, 8u));
	blockD[0].j = (mat4x3(1.0, -7.0, 7.0, -5.0, 8.0, 5.0, -2.0, -7.0, 0.0, 8.0, -7.0, 0.0));
	blockD[0].k = i8vec2(ivec2(4294967287, 4));
	blockD[0].l = (true);
	blockE.m[0] = (mat4x2(8.0, 5.0, 7.0, -5.0, 5.0, -4.0, -1.0, 9.0));
	blockE.m[1] = (mat4x2(7.0, -1.0, -6.0, 5.0, -8.0, -7.0, -4.0, -6.0));
	blockE.m[2] = (mat4x2(8.0, 6.0, -7.0, -8.0, -3.0, -1.0, 2.0, 7.0));
	blockE.m[3] = (mat4x2(7.0, 2.0, 6.0, 9.0, -2.0, -9.0, -9.0, -1.0));
	blockE.m[4] = (mat4x2(0.0, 8.0, -1.0, 3.0, -2.0, -5.0, -7.0, -6.0));
}
#version 450
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
	layout(offset = 16) highp vec4 b;
} blockB[3];

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

struct sA
{
	bvec2 mA[2];
	mediump mat4x3 mB;
	highp mat2 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump mat3 a;
	highp vec4 b;
	highp uvec4 c[7];
	i8vec4 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	lowp mat4 e;
	mediump ivec3 f;
	i8vec2 g;
	uint8_t h;
	highp int i[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat3 j;
	bvec2 k;
	bool l[8][6];
	sA m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(1.0, -5.0, -9.0, -5.0, 1.0, -7.0, 1.0, 2.0, 8.0)) && allOk;
	allOk = compare_uvec4((blockB.c[0]), uvec4(2u, 5u, 6u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.c[1]), uvec4(1u, 2u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.c[2]), uvec4(8u, 7u, 2u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.c[3]), uvec4(0u, 6u, 8u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.c[4]), uvec4(2u, 3u, 4u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.c[5]), uvec4(4u, 8u, 8u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.c[6]), uvec4(8u, 1u, 5u, 9u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[0]), ivec4(1, 4294967287, 4294967293, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[1]), ivec4(4294967289, 4294967292, 4294967292, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[2]), ivec4(1, 3, 4294967292, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[3]), ivec4(0, 1, 4294967293, 4294967287)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(-6.0, 2.0, 5.0, 1.0, 6.0, 4.0, -2.0, -8.0, 5.0, 9.0, -4.0, -9.0, -5.0, 2.0, 7.0, 5.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC.h), 7u) && allOk;
	allOk = compare_int((blockC.i[0]), 2) && allOk;
	allOk = compare_int((blockC.i[1]), 4) && allOk;
	allOk = compare_int((blockC.i[2]), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(2.0, 7.0, -5.0, -4.0, -8.0, -5.0, 0.0, 0.0, -7.0));
	blockB.b = (vec4(5.0, 3.0, 4.0, 7.0));
	blockB.c[0] = (uvec4(0u, 2u, 7u, 3u));
	blockB.c[1] = (uvec4(6u, 7u, 5u, 3u));
	blockB.c[2] = (uvec4(1u, 2u, 9u, 9u));
	blockB.c[3] = (uvec4(8u, 7u, 8u, 4u));
	blockB.c[4] = (uvec4(3u, 4u, 5u, 8u));
	blockB.c[5] = (uvec4(0u, 6u, 2u, 3u));
	blockB.c[6] = (uvec4(4u, 4u, 7u, 3u));
	blockB.d[0] = i8vec4(ivec4(4, 8, 5, 3));
	blockB.d[1] = i8vec4(ivec4(5, 4294967292, 8, 8));
	blockB.d[2] = i8vec4(ivec4(0, 4294967288, 1, 4294967288));
	blockB.d[3] = i8vec4(ivec4(2, 4294967289, 4294967294, 2));
	blockC.g = i8vec2(ivec2(4294967288, 6));
	blockC.h = uint8_t(5u);
	blockC.i[0] = (3);
	blockC.i[1] = (-9);
	blockC.i[2] = (-6);
	j = (mat3(1.0, 2.0, 3.0, 9.0, 5.0, -4.0, -7.0, 9.0, 6.0));
	k = (bvec2(false, true));
	l[0][0] = (false);
	l[0][1] = (false);
	l[0][2] = (true);
	l[0][3] = (true);
	l[0][4] = (false);
	l[0][5] = (true);
	l[1][0] = (false);
	l[1][1] = (false);
	l[1][2] = (false);
	l[1][3] = (true);
	l[1][4] = (true);
	l[1][5] = (true);
	l[2][0] = (false);
	l[2][1] = (false);
	l[2][2] = (false);
	l[2][3] = (true);
	l[2][4] = (true);
	l[2][5] = (true);
	l[3][0] = (false);
	l[3][1] = (false);
	l[3][2] = (false);
	l[3][3] = (true);
	l[3][4] = (false);
	l[3][5] = (false);
	l[4][0] = (true);
	l[4][1] = (true);
	l[4][2] = (true);
	l[4][3] = (false);
	l[4][4] = (false);
	l[4][5] = (false);
	l[5][0] = (true);
	l[5][1] = (false);
	l[5][2] = (true);
	l[5][3] = (false);
	l[5][4] = (false);
	l[5][5] = (false);
	l[6][0] = (false);
	l[6][1] = (false);
	l[6][2] = (true);
	l[6][3] = (true);
	l[6][4] = (true);
	l[6][5] = (false);
	l[7][0] = (false);
	l[7][1] = (true);
	l[7][2] = (true);
	l[7][3] = (true);
	l[7][4] = (true);
	l[7][5] = (false);
	m[0].mA[0] = (bvec2(true, true));
	m[0].mA[1] = (bvec2(false, true));
	m[0].mB = (mat4x3(2.0, -4.0, 2.0, -2.0, -7.0, 1.0, -7.0, -6.0, 2.0, 5.0, 1.0, -3.0));
	m[0].mC = (mat2(5.0, 3.0, 6.0, 7.0));
	m[1].mA[0] = (bvec2(false, true));
	m[1].mA[1] = (bvec2(false, true));
	m[1].mB = (mat4x3(2.0, 3.0, 5.0, -2.0, 1.0, -1.0, -6.0, -9.0, -4.0, 9.0, -9.0, -7.0));
	m[1].mC = (mat2(-6.0, -4.0, -5.0, -5.0));
}
#version 450
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
	highp mat2 a;
	u8vec2 b;
	lowp vec4 c;
	lowp mat4 d[];
} blockB[3];
layout(scalar, column_major, binding = 2) readonly buffer BlockC
{
	bvec2 e;
	lowp uvec2 f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
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
	allOk = compare_bvec2((blockC.e), bvec2(true, false)) && allOk;
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
}
#version 450
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
	bvec4 a[1];
	lowp ivec3 b;
	mediump uvec2 c;
	mediump int d;
	bvec4 e;
} blockB[];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].c), uvec2(0u, 0u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].e), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].c), uvec2(0u, 0u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].e), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].c), uvec2(3u, 3u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].e), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].c), uvec2(6u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].e), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (bvec4(true, false, true, false));
	blockB[nonuniformEXT(0)].e = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(1)].a[0] = (bvec4(false, true, true, false));
	blockB[nonuniformEXT(1)].e = (bvec4(false, true, false, true));
	blockB[nonuniformEXT(2)].a[0] = (bvec4(false, false, true, false));
	blockB[nonuniformEXT(2)].e = (bvec4(true, true, true, true));
	blockB[nonuniformEXT(3)].a[0] = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(3)].e = (bvec4(true, false, true, true));
}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	bvec3 var;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var), bvec3(true, true, true)) && allOk;
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-7.0, -6.0, -6.0, -9.0, -6.0, -9.0, 1.0, 5.0)) && allOk;
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], 7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 3.0, -2.0, -2.0)) && allOk;
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

}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 9.0)) && allOk;
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, -6.0)) && allOk;
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(-2.0, -6.0, 9.0, 2.0, 2.0, -8.0, -2.0, 7.0, -4.0, -6.0, 3.0, 2.0, 9.0, -2.0, -4.0, 2.0)) && allOk;
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

}
#version 450
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

}
#version 450
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

}
#version 450
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
	u8vec4 var;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var), uvec4(3u, 4u, 6u, 8u)) && allOk;
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

}
#version 450
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

}
#version 450
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
	int8_t padding;
	i8vec4 var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(var[0]), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1]), ivec4(4294967288, 4294967292, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2]), ivec4(3, 4294967290, 4294967293, 4294967289)) && allOk;
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
	allOk = compare_mat3(var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
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

}
#version 450
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
	i8vec2 var[];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[4]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[5]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[6]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[7]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[8]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[9]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[10]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[11]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[12]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[13]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[14]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[15]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[16]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[17]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[18]), ivec2(7, 4294967292)) && allOk;
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
	allOk = compare_mat4x2(var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
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

}
#version 450
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
	u16vec4 var[];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
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
	mediump ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var), ivec2(-2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec2(-4, 3));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-3.0, 2.0, 9.0, -4.0, -9.0, -4.0, -5.0, -8.0, 0.0, -8.0, 6.0, -4.0, -6.0, -7.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(2.0, 5.0, 1.0, -7.0, -8.0, 5.0, 6.0, 2.0, -2.0, 6.0, 3.0, -3.0, 5.0, -8.0, 1.0, 1.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block.var, mat2x3(5.0, -7.0, 8.0, -5.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-9.0, 1.0, -5.0, 1.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-8.0, 4.0, 7.0, -1.0, 7.0, 8.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, -2.0));
	block.var[1] = (vec2(9.0, 6.0));
	block.var[2] = (vec2(6.0, -5.0));
	block.var[3] = (vec2(-4.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(4.0, 1.0, 0.0, 3.0, 8.0, -3.0, -1.0, 2.0, -9.0, 8.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(2.0, 9.0, 9.0, -3.0, 6.0, 1.0, 1.0, -1.0, -1.0, -5.0, -7.0, -2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 6.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], -1.0) && allOk;
	allOk = compare_float(block.var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(4.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(1.0, 0.0, 4.0, -1.0, -5.0, 5.0, -9.0, -3.0, 5.0, 8.0, 4.0, 6.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(0.0, -6.0, -5.0, 0.0, 1.0, 3.0, -2.0, 5.0, -5.0, -6.0, 2.0, -1.0, 0.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-6.0, -5.0, -2.0, -2.0));
	block.var[1] = (vec4(-5.0, -9.0, -5.0, 1.0));
	block.var[2] = (vec4(4.0, 1.0, -2.0, -6.0));
	block.var[3] = (vec4(-7.0, -7.0, -1.0, 5.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[1][3], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(9.0, 0.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(7.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(6.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(3.0, -9.0, -2.0, 8.0, -8.0, -1.0, 8.0, 1.0, -5.0, -8.0, -1.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat2(block.var, mat2(-6.0, -2.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec2(7.0, 9.0));
	block.var[1] = (vec2(8.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-7.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-7.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec3(5.0, 6.0, -7.0));
	block.var[1] = (vec3(5.0, 4.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(1.0, -8.0, 7.0, -5.0, 4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var[0] = (vec2(-3.0, -2.0));
	block.var[1] = (vec2(-8.0, -6.0));
	block.var[2] = (vec2(0.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(2.0, -4.0));
	block.var[0][1] = (vec2(-5.0, 3.0));
	block.var[0][2] = (vec2(7.0, 1.0));
	block.var[0][3] = (vec2(8.0, -5.0));
	block.var[1][0] = (vec2(7.0, -3.0));
	block.var[1][1] = (vec2(1.0, -6.0));
	block.var[1][2] = (vec2(9.0, -3.0));
	block.var[1][3] = (vec2(1.0, -5.0));
	block.var[2][0] = (vec2(-8.0, 4.0));
	block.var[2][1] = (vec2(5.0, -9.0));
	block.var[2][2] = (vec2(1.0, -5.0));
	block.var[2][3] = (vec2(-4.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block.var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block.var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
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
}
#version 450
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
	u16vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
}
#version 450
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
	highp uint var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var[0]), 3u) && allOk;
	allOk = compare_uint((block.var[1]), 6u) && allOk;
	allOk = compare_uint((block.var[2]), 9u) && allOk;
	allOk = compare_uint((block.var[3]), 0u) && allOk;
	allOk = compare_uint((block.var[4]), 3u) && allOk;
	allOk = compare_uint((block.var[5]), 7u) && allOk;
	allOk = compare_uint((block.var[6]), 6u) && allOk;
	allOk = compare_uint((block.var[7]), 4u) && allOk;
	allOk = compare_uint((block.var[8]), 2u) && allOk;
	allOk = compare_uint((block.var[9]), 5u) && allOk;
	allOk = compare_uint((block.var[10]), 7u) && allOk;
	allOk = compare_uint((block.var[11]), 5u) && allOk;
	allOk = compare_uint((block.var[12]), 7u) && allOk;
	allOk = compare_uint((block.var[13]), 8u) && allOk;
	allOk = compare_uint((block.var[14]), 6u) && allOk;
	allOk = compare_uint((block.var[15]), 9u) && allOk;
	allOk = compare_uint((block.var[16]), 0u) && allOk;
	allOk = compare_uint((block.var[17]), 1u) && allOk;
	allOk = compare_uint((block.var[18]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (7u);
	block.var[1] = (9u);
	block.var[2] = (1u);
	block.var[3] = (0u);
	block.var[4] = (7u);
	block.var[5] = (7u);
	block.var[6] = (4u);
	block.var[7] = (8u);
	block.var[8] = (7u);
	block.var[9] = (5u);
	block.var[10] = (7u);
	block.var[11] = (2u);
	block.var[12] = (7u);
	block.var[13] = (8u);
	block.var[14] = (6u);
	block.var[15] = (1u);
	block.var[16] = (9u);
	block.var[17] = (8u);
	block.var[18] = (6u);
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[0][2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[1][0][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	block.var[1][0][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][1][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	block.var[1][1][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[1][2][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	block.var[1][2][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[2][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	block.var[2][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[2][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	block.var[2][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[2][2][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	block.var[2][2][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[3][0][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	block.var[3][0][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[3][1][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	block.var[3][1][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[3][2][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	block.var[3][2][1] = (vec4(4.0, 0.0, -9.0, 1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0][0] = (vec2(-2.0, 2.0));
	block.var[0][0][1] = (vec2(8.0, -5.0));
	block.var[0][0][2] = (vec2(3.0, -1.0));
	block.var[0][0][3] = (vec2(-7.0, 4.0));
	block.var[0][1][0] = (vec2(2.0, -4.0));
	block.var[0][1][1] = (vec2(8.0, 3.0));
	block.var[0][1][2] = (vec2(8.0, -1.0));
	block.var[0][1][3] = (vec2(6.0, -8.0));
	block.var[0][2][0] = (vec2(2.0, -5.0));
	block.var[0][2][1] = (vec2(5.0, -4.0));
	block.var[0][2][2] = (vec2(-9.0, 0.0));
	block.var[0][2][3] = (vec2(4.0, 8.0));
	block.var[1][0][0] = (vec2(2.0, -3.0));
	block.var[1][0][1] = (vec2(2.0, -4.0));
	block.var[1][0][2] = (vec2(-4.0, 2.0));
	block.var[1][0][3] = (vec2(-8.0, -4.0));
	block.var[1][1][0] = (vec2(8.0, 5.0));
	block.var[1][1][1] = (vec2(7.0, -4.0));
	block.var[1][1][2] = (vec2(6.0, 8.0));
	block.var[1][1][3] = (vec2(4.0, -9.0));
	block.var[1][2][0] = (vec2(-7.0, 7.0));
	block.var[1][2][1] = (vec2(-5.0, 1.0));
	block.var[1][2][2] = (vec2(-9.0, 9.0));
	block.var[1][2][3] = (vec2(5.0, 7.0));
	block.var[2][0][0] = (vec2(3.0, 3.0));
	block.var[2][0][1] = (vec2(3.0, -5.0));
	block.var[2][0][2] = (vec2(-9.0, 2.0));
	block.var[2][0][3] = (vec2(9.0, 3.0));
	block.var[2][1][0] = (vec2(8.0, 3.0));
	block.var[2][1][1] = (vec2(-4.0, 6.0));
	block.var[2][1][2] = (vec2(1.0, -3.0));
	block.var[2][1][3] = (vec2(1.0, -5.0));
	block.var[2][2][0] = (vec2(-2.0, 7.0));
	block.var[2][2][1] = (vec2(8.0, 4.0));
	block.var[2][2][2] = (vec2(7.0, -1.0));
	block.var[2][2][3] = (vec2(-8.0, -6.0));
	block.var[3][0][0] = (vec2(-6.0, -4.0));
	block.var[3][0][1] = (vec2(-2.0, 3.0));
	block.var[3][0][2] = (vec2(8.0, 4.0));
	block.var[3][0][3] = (vec2(4.0, -7.0));
	block.var[3][1][0] = (vec2(-6.0, 8.0));
	block.var[3][1][1] = (vec2(-6.0, 8.0));
	block.var[3][1][2] = (vec2(-3.0, -7.0));
	block.var[3][1][3] = (vec2(0.0, -9.0));
	block.var[3][2][0] = (vec2(2.0, -9.0));
	block.var[3][2][1] = (vec2(7.0, -2.0));
	block.var[3][2][2] = (vec2(2.0, -6.0));
	block.var[3][2][3] = (vec2(-1.0, 1.0));
}
#version 450
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
	u16vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0]), uvec4(0u, 8u, 3u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2]), uvec4(7u, 1u, 8u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0]), uvec4(0u, 5u, 8u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1]), uvec4(4u, 6u, 1u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2]), uvec4(3u, 6u, 0u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0]), uvec4(2u, 2u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1]), uvec4(9u, 3u, 0u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2]), uvec4(0u, 4u, 9u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0]), uvec4(7u, 1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1]), uvec4(7u, 4u, 5u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][2]), uvec4(0u, 8u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(0u);
	block.var[0][0] = u16vec4(uvec4(6u, 9u, 4u, 5u));
	block.var[0][1] = u16vec4(uvec4(0u, 1u, 0u, 7u));
	block.var[0][2] = u16vec4(uvec4(6u, 5u, 9u, 8u));
	block.var[1][0] = u16vec4(uvec4(3u, 6u, 1u, 7u));
	block.var[1][1] = u16vec4(uvec4(9u, 3u, 8u, 1u));
	block.var[1][2] = u16vec4(uvec4(4u, 3u, 9u, 9u));
	block.var[2][0] = u16vec4(uvec4(3u, 0u, 2u, 3u));
	block.var[2][1] = u16vec4(uvec4(5u, 0u, 2u, 5u));
	block.var[2][2] = u16vec4(uvec4(1u, 5u, 5u, 4u));
	block.var[3][0] = u16vec4(uvec4(0u, 8u, 4u, 0u));
	block.var[3][1] = u16vec4(uvec4(3u, 7u, 1u, 1u));
	block.var[3][2] = u16vec4(uvec4(8u, 4u, 7u, 6u));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(1.0, 4.0, -6.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(1.0, -7.0, -5.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(4.0, 5.0, 5.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-6.0, 0.0, -5.0, 2.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-6.0, -8.0, -1.0, -8.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[0][0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[0][0][2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[0][1][0] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	block.var[0][1][1] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	block.var[0][1][2] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	block.var[1][0][0] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[1][0][1] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[1][0][2] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[1][1][0] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	block.var[1][1][1] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	block.var[1][1][2] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	block.var[2][0][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[2][0][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[2][0][2] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[2][1][0] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
	block.var[2][1][1] = (mat2x3(3.0, 8.0, -9.0, 8.0, 6.0, 0.0));
	block.var[2][1][2] = (mat2x3(2.0, 3.0, 4.0, 3.0, 4.0, 2.0));
	block.var[3][0][0] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[3][0][1] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[3][0][2] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	block.var[3][1][0] = (mat2x3(-1.0, -4.0, 9.0, -8.0, 2.0, 8.0));
	block.var[3][1][1] = (mat2x3(6.0, -6.0, 4.0, -3.0, -1.0, -9.0));
	block.var[3][1][2] = (mat2x3(6.0, 3.0, -4.0, -2.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[0][0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[0][1][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	block.var[0][1][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	block.var[0][1][2] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	block.var[1][0][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[1][0][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[1][0][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[1][1][0] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	block.var[1][1][1] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	block.var[1][1][2] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	block.var[2][0][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[2][0][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[2][0][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[2][1][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	block.var[2][1][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	block.var[2][1][2] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	block.var[3][0][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[3][0][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[3][0][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	block.var[3][1][0] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	block.var[3][1][1] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	block.var[3][1][2] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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
	uint8_t var[4][2][3];
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
	allOk = compare_uint8_t(uint(block.var[0][0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][1]), 8u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][2]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][0]), 0u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][2]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint8_t(9u);
	block.var[0][0][1] = uint8_t(5u);
	block.var[0][0][2] = uint8_t(2u);
	block.var[0][1][0] = uint8_t(6u);
	block.var[0][1][1] = uint8_t(0u);
	block.var[0][1][2] = uint8_t(5u);
	block.var[1][0][0] = uint8_t(6u);
	block.var[1][0][1] = uint8_t(7u);
	block.var[1][0][2] = uint8_t(5u);
	block.var[1][1][0] = uint8_t(4u);
	block.var[1][1][1] = uint8_t(1u);
	block.var[1][1][2] = uint8_t(3u);
	block.var[2][0][0] = uint8_t(8u);
	block.var[2][0][1] = uint8_t(4u);
	block.var[2][0][2] = uint8_t(2u);
	block.var[2][1][0] = uint8_t(0u);
	block.var[2][1][1] = uint8_t(3u);
	block.var[2][1][2] = uint8_t(3u);
	block.var[3][0][0] = uint8_t(6u);
	block.var[3][0][1] = uint8_t(0u);
	block.var[3][0][2] = uint8_t(1u);
	block.var[3][1][0] = uint8_t(3u);
	block.var[3][1][1] = uint8_t(3u);
	block.var[3][1][2] = uint8_t(3u);
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(0.0, -5.0, 0.0, -1.0, -4.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(4.0, 0.0, 2.0, -3.0, -1.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(5.0, 4.0, 9.0, -2.0, -3.0, -4.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-3.0, -5.0, 3.0, -9.0, -8.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(0.0, 7.0, 9.0, -6.0, 6.0, -5.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-7.0, -8.0, 7.0, -1.0, -9.0, 5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(3.0, 6.0, 4.0, 3.0, 1.0, 2.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(3.0, -6.0, 6.0, 2.0, 6.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-4.0, 7.0, -1.0, -9.0, 2.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-1.0, -5.0, 7.0, -7.0, -5.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(6.0, -4.0, 1.0, 5.0, -6.0, 5.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(1.0, -9.0, -5.0, 0.0, -7.0, 0.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(5.0, 7.0, 5.0, 2.0, 0.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(5.0, -9.0, 6.0, 0.0, -3.0, 4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-6.0, -1.0, -9.0, -7.0, 9.0, 5.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-3.0, -1.0, -3.0, -9.0, -7.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-4.0, 9.0, 9.0, 7.0, -2.0, -8.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-2.0, 8.0, 7.0, 0.0, 5.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(3.0, 7.0, 1.0, -3.0, 6.0, -8.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(5.0, 6.0, 2.0, 0.0, 9.0, -9.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(4.0, 7.0, -2.0, 4.0, 5.0, -2.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-2.0, -7.0, 6.0, -6.0, -2.0, 8.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-9.0, 4.0, 9.0, 1.0, 2.0, 7.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(2.0, 5.0, -9.0, -3.0, 9.0, -3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0] = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	block.var[0][0][1] = (mat4x2(8.0, 3.0, 2.0, -6.0, 3.0, 8.0, -8.0, 8.0));
	block.var[0][0][2] = (mat4x2(-3.0, -9.0, -2.0, 6.0, -1.0, 6.0, 9.0, -5.0));
	block.var[0][1][0] = (mat4x2(-8.0, -6.0, -3.0, -4.0, 8.0, -4.0, 4.0, 6.0));
	block.var[0][1][1] = (mat4x2(-7.0, -3.0, -9.0, -6.0, -3.0, -8.0, -9.0, 8.0));
	block.var[0][1][2] = (mat4x2(-8.0, 4.0, 0.0, 4.0, -3.0, 8.0, -4.0, 0.0));
	block.var[1][0][0] = (mat4x2(-1.0, -9.0, 0.0, -4.0, 2.0, -7.0, -9.0, -3.0));
	block.var[1][0][1] = (mat4x2(1.0, -5.0, -1.0, 7.0, 4.0, 4.0, -5.0, -5.0));
	block.var[1][0][2] = (mat4x2(-4.0, -3.0, 0.0, 4.0, -7.0, 5.0, 2.0, 1.0));
	block.var[1][1][0] = (mat4x2(-2.0, -3.0, -5.0, 6.0, -2.0, 7.0, 7.0, 4.0));
	block.var[1][1][1] = (mat4x2(6.0, -2.0, 0.0, 7.0, 0.0, 2.0, -1.0, -7.0));
	block.var[1][1][2] = (mat4x2(-6.0, 8.0, -7.0, -4.0, 9.0, 9.0, -7.0, 4.0));
	block.var[2][0][0] = (mat4x2(0.0, -4.0, 2.0, 9.0, -5.0, -3.0, -9.0, 6.0));
	block.var[2][0][1] = (mat4x2(-9.0, 5.0, -5.0, -6.0, 8.0, -5.0, -4.0, -4.0));
	block.var[2][0][2] = (mat4x2(6.0, 9.0, -3.0, -4.0, 3.0, -7.0, -5.0, -8.0));
	block.var[2][1][0] = (mat4x2(-6.0, -3.0, 8.0, -1.0, -5.0, 5.0, -8.0, 1.0));
	block.var[2][1][1] = (mat4x2(-4.0, -5.0, 1.0, -2.0, 7.0, 1.0, 9.0, -3.0));
	block.var[2][1][2] = (mat4x2(4.0, 9.0, 6.0, 3.0, -9.0, 2.0, -1.0, -3.0));
	block.var[3][0][0] = (mat4x2(-4.0, -6.0, 0.0, -3.0, -6.0, -4.0, 8.0, 5.0));
	block.var[3][0][1] = (mat4x2(5.0, 7.0, 2.0, -7.0, 8.0, -3.0, 4.0, 8.0));
	block.var[3][0][2] = (mat4x2(0.0, -5.0, 4.0, 5.0, -6.0, -8.0, 7.0, -7.0));
	block.var[3][1][0] = (mat4x2(7.0, -5.0, -4.0, 0.0, -9.0, 9.0, 9.0, 6.0));
	block.var[3][1][1] = (mat4x2(-4.0, -2.0, -7.0, -7.0, -4.0, 9.0, 8.0, 6.0));
	block.var[3][1][2] = (mat4x2(-4.0, 6.0, -5.0, -4.0, 7.0, -1.0, 7.0, 9.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	block.var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	block.var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	block.var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	block.var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	block.var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	block.var[0][1][0][0] = (vec3(9.0, -3.0, -9.0));
	block.var[0][1][0][1] = (vec3(6.0, -1.0, -6.0));
	block.var[0][1][0][2] = (vec3(6.0, 2.0, -5.0));
	block.var[0][1][1][0] = (vec3(-1.0, -2.0, 2.0));
	block.var[0][1][1][1] = (vec3(9.0, 1.0, -8.0));
	block.var[0][1][1][2] = (vec3(6.0, -1.0, 7.0));
	block.var[0][2][0][0] = (vec3(-9.0, -8.0, 2.0));
	block.var[0][2][0][1] = (vec3(-6.0, 9.0, -7.0));
	block.var[0][2][0][2] = (vec3(9.0, 6.0, 1.0));
	block.var[0][2][1][0] = (vec3(-4.0, 8.0, -7.0));
	block.var[0][2][1][1] = (vec3(1.0, 0.0, 4.0));
	block.var[0][2][1][2] = (vec3(-6.0, -3.0, 3.0));
	block.var[0][3][0][0] = (vec3(-5.0, 7.0, 5.0));
	block.var[0][3][0][1] = (vec3(-2.0, -2.0, 8.0));
	block.var[0][3][0][2] = (vec3(-3.0, 1.0, 7.0));
	block.var[0][3][1][0] = (vec3(-9.0, 8.0, 7.0));
	block.var[0][3][1][1] = (vec3(2.0, 2.0, -5.0));
	block.var[0][3][1][2] = (vec3(-8.0, -5.0, 6.0));
	block.var[1][0][0][0] = (vec3(6.0, -5.0, -4.0));
	block.var[1][0][0][1] = (vec3(-8.0, -8.0, -2.0));
	block.var[1][0][0][2] = (vec3(9.0, -4.0, 4.0));
	block.var[1][0][1][0] = (vec3(4.0, -1.0, 5.0));
	block.var[1][0][1][1] = (vec3(-1.0, 0.0, 9.0));
	block.var[1][0][1][2] = (vec3(7.0, 7.0, 5.0));
	block.var[1][1][0][0] = (vec3(4.0, 2.0, -8.0));
	block.var[1][1][0][1] = (vec3(0.0, 3.0, 9.0));
	block.var[1][1][0][2] = (vec3(9.0, -8.0, -4.0));
	block.var[1][1][1][0] = (vec3(-8.0, 3.0, 4.0));
	block.var[1][1][1][1] = (vec3(-4.0, 4.0, 1.0));
	block.var[1][1][1][2] = (vec3(0.0, 4.0, 5.0));
	block.var[1][2][0][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[1][2][0][1] = (vec3(4.0, 3.0, -2.0));
	block.var[1][2][0][2] = (vec3(-6.0, -4.0, -1.0));
	block.var[1][2][1][0] = (vec3(4.0, 4.0, -6.0));
	block.var[1][2][1][1] = (vec3(0.0, 2.0, -5.0));
	block.var[1][2][1][2] = (vec3(5.0, 8.0, -2.0));
	block.var[1][3][0][0] = (vec3(4.0, 1.0, 9.0));
	block.var[1][3][0][1] = (vec3(5.0, -6.0, 7.0));
	block.var[1][3][0][2] = (vec3(-7.0, -2.0, -6.0));
	block.var[1][3][1][0] = (vec3(0.0, -9.0, 7.0));
	block.var[1][3][1][1] = (vec3(-2.0, 0.0, 5.0));
	block.var[1][3][1][2] = (vec3(8.0, 8.0, -1.0));
	block.var[2][0][0][0] = (vec3(8.0, -6.0, -1.0));
	block.var[2][0][0][1] = (vec3(-1.0, -2.0, -5.0));
	block.var[2][0][0][2] = (vec3(-5.0, 6.0, -3.0));
	block.var[2][0][1][0] = (vec3(-4.0, -6.0, 2.0));
	block.var[2][0][1][1] = (vec3(3.0, -1.0, 2.0));
	block.var[2][0][1][2] = (vec3(-3.0, 4.0, 1.0));
	block.var[2][1][0][0] = (vec3(-9.0, -4.0, 2.0));
	block.var[2][1][0][1] = (vec3(-6.0, 8.0, 3.0));
	block.var[2][1][0][2] = (vec3(2.0, 0.0, -1.0));
	block.var[2][1][1][0] = (vec3(7.0, 1.0, 3.0));
	block.var[2][1][1][1] = (vec3(5.0, 1.0, -6.0));
	block.var[2][1][1][2] = (vec3(2.0, -5.0, 4.0));
	block.var[2][2][0][0] = (vec3(3.0, -1.0, 7.0));
	block.var[2][2][0][1] = (vec3(-9.0, -9.0, -8.0));
	block.var[2][2][0][2] = (vec3(9.0, -9.0, -5.0));
	block.var[2][2][1][0] = (vec3(1.0, -2.0, 1.0));
	block.var[2][2][1][1] = (vec3(-8.0, -4.0, -3.0));
	block.var[2][2][1][2] = (vec3(3.0, -4.0, -3.0));
	block.var[2][3][0][0] = (vec3(-4.0, 3.0, 5.0));
	block.var[2][3][0][1] = (vec3(-9.0, 8.0, -7.0));
	block.var[2][3][0][2] = (vec3(7.0, -3.0, 4.0));
	block.var[2][3][1][0] = (vec3(-6.0, 3.0, 6.0));
	block.var[2][3][1][1] = (vec3(-9.0, 9.0, 3.0));
	block.var[2][3][1][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-3, -3, -8)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-9.0, 1.0, 3.0, -3.0, -7.0, 8.0, -8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(2.0, -2.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-5, -2, 8));
	block.s.b[0] = (mat3(8.0, -7.0, 8.0, -2.0, -2.0, -6.0, 6.0, 0.0, -6.0));
	block.s.b[1] = (mat3(-4.0, 3.0, -6.0, -4.0, -4.0, -3.0, -6.0, 0.0, -2.0));
	block.s.b[2] = (mat3(-1.0, -2.0, -2.0, -8.0, 7.0, -6.0, 9.0, -2.0, -5.0));
	block.s.b[3] = (mat3(7.0, -9.0, -9.0, 8.0, 1.0, 9.0, -5.0, -4.0, 1.0));
	block.s.c = (vec4(-6.0, 7.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0].a), ivec3(-3, -8, -9)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(2.0, 8.0, -2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(-9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(7.0, 6.0, -9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(8.0, -9.0, 2.0, -2.0, 6.0, 7.0, -3.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(-2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(1, 3, -3)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(9.0, 6.0, -5.0, -9.0, -5.0, -6.0, -4.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-4.0, -8.0, 5.0, -9.0, -1.0, 7.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(-5.0, 6.0, 8.0, 5.0, -9.0, -8.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(-4.0, 2.0, -6.0, 3.0, -8.0, 4.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(5.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(-7, 8, -8)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(6.0, -9.0, -4.0, -9.0, -8.0, -2.0, -8.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(-5.0, 7.0, 2.0, -5.0, 3.0, -9.0, -5.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(-7.0, 5.0, -9.0, -6.0, -3.0, 3.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(5.0, -9.0, -3.0, 2.0, -5.0, -5.0, 6.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(-2.0, 2.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(-2, 8, 8));
	block.s[0].b[0] = (mat3(0.0, -6.0, -4.0, 3.0, -6.0, -4.0, -4.0, -3.0, -6.0));
	block.s[0].b[1] = (mat3(0.0, -2.0, -1.0, -2.0, -2.0, -8.0, 7.0, -6.0, 9.0));
	block.s[0].b[2] = (mat3(-2.0, -5.0, 7.0, -9.0, -9.0, 8.0, 1.0, 9.0, -5.0));
	block.s[0].b[3] = (mat3(-4.0, 1.0, -6.0, 7.0, 8.0, -2.0, 0.0, 7.0, 6.0));
	block.s[0].c = (vec4(7.0, -3.0, 1.0, 6.0));
	block.s[1].a = (ivec3(-7, 8, -2));
	block.s[1].b[0] = (mat3(-5.0, 3.0, -7.0, 0.0, -5.0, 0.0, 7.0, 8.0, 4.0));
	block.s[1].b[1] = (mat3(8.0, 8.0, -5.0, 2.0, -2.0, 7.0, 2.0, -2.0, 0.0));
	block.s[1].b[2] = (mat3(-8.0, 5.0, 3.0, -5.0, 1.0, -7.0, -3.0, 2.0, -6.0));
	block.s[1].b[3] = (mat3(-6.0, -5.0, -6.0, 9.0, -8.0, -1.0, 8.0, 1.0, -1.0));
	block.s[1].c = (vec4(9.0, -7.0, 0.0, 1.0));
	block.s[2].a = (ivec3(-2, -6, 6));
	block.s[2].b[0] = (mat3(-9.0, -6.0, -8.0, -7.0, -3.0, 1.0, -4.0, 3.0, 5.0));
	block.s[2].b[1] = (mat3(7.0, -1.0, 7.0, 1.0, -2.0, 8.0, 5.0, 5.0, -4.0));
	block.s[2].b[2] = (mat3(3.0, -2.0, -3.0, -3.0, -3.0, 7.0, 8.0, -5.0, -3.0));
	block.s[2].b[3] = (mat3(5.0, 6.0, 1.0, -7.0, -8.0, 6.0, -4.0, 0.0, -8.0));
	block.s[2].c = (vec4(5.0, -4.0, 7.0, 5.0));
	block.v = (vec4(5.0, -3.0, -4.0, -4.0));
}
#version 450
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
layout(std140, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s.a), ivec3(-6, -4, 4)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, -4.0, 8.0, -2.0, -3.0, -2.0, -1.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, -7.0, 7.0, -2.0, -2.0, -4.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-1.0, -4.0, 7.0, -8.0, 2.0, -6.0, -5.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-1.0, -7.0, 9.0, 0.0, -9.0, 3.0, -2.0, -2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(1.0, 8.0, -7.0, 4.0, 2.0, 4.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(2, 3, -4)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(1.0, 1.0, -3.0, -4.0, 4.0, 3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(4.0, -4.0, 6.0, -6.0, 6.0, 4.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-3.0, -6.0, -8.0, -8.0, 9.0, -7.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(7.0, 3.0, 9.0, 6.0, -6.0, 2.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-7.0, 2.0, -5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(5, -9, 1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-2.0, -1.0, -1.0, 7.0, -6.0, 8.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-1.0, -5.0, -1.0, -3.0, 5.0, -6.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-8.0, 8.0, -5.0, -6.0, -4.0, -7.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(1.0, -4.0, -3.0, -2.0, 2.0, 1.0, 2.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(4.0, 2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(7.0, 2.0, 6.0, 4.0, -1.0, -7.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(-4, 1, 6)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(1.0, -8.0, -1.0, -5.0, 3.0, 6.0, 3.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(1.0, 1.0, 3.0, -1.0, 6.0, 1.0, 5.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(4.0, -8.0, 4.0, -8.0, -2.0, -3.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-5.0, -4.0, 9.0, 7.0, -6.0, -7.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(1.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-7, 7, -7)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-4.0, -8.0, 5.0, -3.0, 7.0, -9.0, 9.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-8.0, 8.0, 0.0, -2.0, -4.0, 2.0, 3.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(2.0, 6.0, 4.0, 6.0, -9.0, 5.0, 1.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-6.0, -5.0, -1.0, 5.0, -7.0, -2.0, 4.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-1.0, 2.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-2.0, 0.0, -7.0, 0.0, -8.0, 0.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(5, 6, -2)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(6.0, 4.0, -1.0, 2.0, -2.0, 1.0, 9.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-2.0, 7.0, 1.0, 4.0, -3.0, -6.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(-6.0, 5.0, -4.0, -5.0, 6.0, 1.0, 9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(8.0, -2.0, 2.0, 6.0, -7.0, 6.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(-3.0, -6.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(-5.0, -5.0, 6.0, -7.0, 5.0, 1.0, -5.0, 1.0, -5.0));
	block[0].t.b.a = (ivec3(6, -3, 0));
	block[0].t.b.b[0] = (mat3(6.0, -2.0, -6.0, -5.0, -6.0, -1.0, 6.0, 8.0, -7.0));
	block[0].t.b.b[1] = (mat3(-9.0, 0.0, 2.0, 1.0, 9.0, -3.0, 5.0, 3.0, -8.0));
	block[0].t.b.b[2] = (mat3(3.0, 0.0, 7.0, 6.0, 3.0, 7.0, -4.0, -5.0, -9.0));
	block[0].t.b.b[3] = (mat3(-2.0, 1.0, 3.0, -3.0, -3.0, 1.0, -4.0, 0.0, 5.0));
	block[0].t.b.c = (vec4(-9.0, 1.0, -4.0, -7.0));
	block[0].u = (3u);
	block[1].t.a = (mat3(-3.0, -1.0, 3.0, 1.0, 1.0, -8.0, -1.0, 9.0, -9.0));
	block[1].t.b.a = (ivec3(-9, 1, -4));
	block[1].t.b.b[0] = (mat3(-8.0, -9.0, 7.0, 1.0, 5.0, 4.0, -2.0, -9.0, 2.0));
	block[1].t.b.b[1] = (mat3(-6.0, -2.0, -8.0, 0.0, -1.0, -4.0, -9.0, 3.0, 7.0));
	block[1].t.b.b[2] = (mat3(-8.0, -9.0, -1.0, -3.0, 5.0, -1.0, -8.0, 7.0, -5.0));
	block[1].t.b.b[3] = (mat3(4.0, -4.0, -1.0, -4.0, 8.0, 6.0, 6.0, 1.0, -8.0));
	block[1].t.b.c = (vec4(3.0, -3.0, -1.0, -8.0));
	block[1].u = (3u);
	block[2].t.a = (mat3(-9.0, 9.0, 3.0, -6.0, 3.0, -8.0, -3.0, 3.0, 4.0));
	block[2].t.b.a = (ivec3(9, 7, -7));
	block[2].t.b.b[0] = (mat3(-4.0, 0.0, 6.0, -2.0, 6.0, 5.0, 7.0, -1.0, 9.0));
	block[2].t.b.b[1] = (mat3(7.0, 3.0, 0.0, -3.0, 0.0, 1.0, -8.0, -7.0, 3.0));
	block[2].t.b.b[2] = (mat3(-5.0, 9.0, 9.0, 2.0, 7.0, 4.0, 6.0, 5.0, -4.0));
	block[2].t.b.b[3] = (mat3(-9.0, 1.0, -4.0, -1.0, 0.0, 9.0, -2.0, 6.0, 8.0));
	block[2].t.b.c = (vec4(5.0, 4.0, 3.0, -9.0));
	block[2].u = (9u);
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(8, 0, 4)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(0.0, 6.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(8, 7, -6)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-9.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(5, 3, 3)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(1.0, 4.0, 9.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(1, 1, -3)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(-1, 2, -8)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-8.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-2, 0, 6)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(4.0, -4.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-6, 0, 6)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-2.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(8, -3, -5)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(0.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-3, -1, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(3.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(-3, -5, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-2.0, -9.0, -5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(4, -7, -1)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(8.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(8, 0, 8)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-6.0, 7.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-9.0, -8.0, 1.0, 8.0));
	block[0].s[0][0].a = (ivec3(-1, 4, -7));
	block[0].s[0][0].c = (vec4(3.0, -4.0, 2.0, 4.0));
	block[0].s[0][1].a = (ivec3(-4, 4, 3));
	block[0].s[0][1].c = (vec4(-9.0, -2.0, -8.0, -7.0));
	block[0].s[1][0].a = (ivec3(5, 5, 1));
	block[0].s[1][0].c = (vec4(9.0, 2.0, -3.0, 1.0));
	block[0].s[1][1].a = (ivec3(-1, 4, -3));
	block[0].s[1][1].c = (vec4(6.0, 8.0, -1.0, 8.0));
	block[0].s[2][0].a = (ivec3(-2, 7, 4));
	block[0].s[2][0].c = (vec4(9.0, 4.0, 9.0, 2.0));
	block[0].s[2][1].a = (ivec3(1, 2, 2));
	block[0].s[2][1].c = (vec4(-2.0, -4.0, 0.0, 7.0));
	block[1].v = (vec4(-1.0, -7.0, -2.0, 5.0));
	block[1].s[0][0].a = (ivec3(-1, 8, 0));
	block[1].s[0][0].c = (vec4(3.0, -2.0, -5.0, 6.0));
	block[1].s[0][1].a = (ivec3(-8, -5, -2));
	block[1].s[0][1].c = (vec4(4.0, 7.0, 2.0, -8.0));
	block[1].s[1][0].a = (ivec3(1, 9, -4));
	block[1].s[1][0].c = (vec4(-9.0, -8.0, 4.0, -6.0));
	block[1].s[1][1].a = (ivec3(8, 8, -2));
	block[1].s[1][1].c = (vec4(-6.0, -4.0, 0.0, 2.0));
	block[2].v = (vec4(-8.0, 2.0, 2.0, 1.0));
	block[2].s[0][0].a = (ivec3(-4, -7, -3));
	block[2].s[0][0].c = (vec4(1.0, 2.0, 9.0, 1.0));
	block[2].s[0][1].a = (ivec3(5, 1, -5));
	block[2].s[0][1].c = (vec4(8.0, -2.0, -7.0, 6.0));
}
#version 450
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
	f16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block[0].var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block[1].var), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block[2].var), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block[1].var = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block[2].var = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x2(block[0].var, mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block[1].var = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block[2].var = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block[0].var, mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block[1].var = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block[2].var = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
}
#version 450
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
	highp ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].padding), -7) && allOk;
	allOk = compare_ivec4((block[0].var), ivec4(9, -5, 6, 3)) && allOk;
	allOk = compare_int((block[1].padding), 4) && allOk;
	allOk = compare_ivec4((block[1].var), ivec4(2, -3, -3, -3)) && allOk;
	allOk = compare_int((block[2].padding), -5) && allOk;
	allOk = compare_ivec4((block[2].var), ivec4(-5, 3, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5);
	block[0].var = (ivec4(-9, 5, -6, -2));
	block[1].padding = (-4);
	block[1].var = (ivec4(1, -9, 7, 3));
	block[2].padding = (6);
	block[2].var = (ivec4(8, 6, -4, 6));
}
#version 450
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
	mediump ivec3 a;
	highp uint b;
	lowp float c;
	highp uvec3 d[1];
	mediump uint e;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp float f;
	highp vec3 g;
	highp uvec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(4, 4, -4)) && allOk;
	allOk = compare_uint((blockB.b), 8u) && allOk;
	allOk = compare_float((blockB.c), 4.0) && allOk;
	allOk = compare_uvec3((blockB.d[0]), uvec3(6u, 8u, 8u)) && allOk;
	allOk = compare_uint((blockB.e), 0u) && allOk;
	allOk = compare_vec3((blockC.g), vec3(-6.0, 0.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-5, 4, -9));
	blockB.b = (0u);
	blockB.c = (-8.0);
	blockB.d[0] = (uvec3(6u, 4u, 0u));
	blockB.e = (5u);
	blockC.f = (-5.0);
	blockC.g = (vec3(-7.0, 5.0, 2.0));
}
#version 450
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
	lowp mat4x2 a;
	highp mat2 b;
	mediump mat2 c;
	lowp int d;
	lowp mat3x2 e;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp vec4 f;
	highp mat3x2 g;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec2 h;
	bvec3 i;
	mediump uvec4 j;
	highp mat4 k;
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp uvec3 l;
	lowp float m;
	bool n;
	mediump mat4 o;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
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
	allOk = compare_mat2(blockB.b, mat2(-6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.e, mat3x2(-4.0, 3.0, -9.0, 0.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockD.j), uvec4(9u, 1u, 0u, 7u)) && allOk;
	allOk = compare_mat4(blockD.k, mat4(-5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockE.l), uvec3(8u, 6u, 5u)) && allOk;
	allOk = compare_float((blockE.m), -8.0) && allOk;
	allOk = compare_bool((blockE.n), true) && allOk;
	allOk = compare_mat4(blockE.o, mat4(-2.0, -3.0, -9.0, 4.0, -9.0, 8.0, 2.0, -6.0, 0.0, -7.0, 4.0, -8.0, -8.0, 9.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2(-7.0, 5.0, 8.0, -6.0));
	blockB.c = (mat2(-7.0, 2.0, -2.0, 3.0));
	blockB.d = (-1);
	blockB.e = (mat3x2(4.0, -7.0, -4.0, -7.0, -6.0, -4.0));
	blockC.f = (vec4(8.0, 2.0, -9.0, 0.0));
	blockC.g = (mat3x2(4.0, 3.0, -1.0, -6.0, -4.0, -5.0));
	blockD.h = (bvec2(true, true));
	blockD.i = (bvec3(true, true, false));
	blockD.j = (uvec4(2u, 2u, 0u, 5u));
	blockE.m = (-9.0);
	blockE.n = (false);
}
#version 450
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
	mediump uint mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp vec3 a;
	lowp int b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp float c;
	mediump mat3x2 d;
	sA e;
	mediump vec2 f;
	highp float g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), -5) && allOk;
	allOk = compare_int((blockB.b[1]), 0) && allOk;
	allOk = compare_int((blockB.b[2]), 3) && allOk;
	allOk = compare_int((blockB.b[3]), 7) && allOk;
	allOk = compare_int((blockB.b[4]), -1) && allOk;
	allOk = compare_int((blockB.b[5]), -8) && allOk;
	allOk = compare_float((blockC.c), 2.0) && allOk;
	allOk = compare_ivec2((blockC.e.mA), ivec2(-1, 1)) && allOk;
	allOk = compare_uint((blockC.e.mB), 5u) && allOk;
	allOk = compare_float((blockC.g[0]), -7.0) && allOk;
	allOk = compare_float((blockC.g[1]), 4.0) && allOk;
	allOk = compare_float((blockC.g[2]), 1.0) && allOk;
	allOk = compare_float((blockC.g[3]), -6.0) && allOk;
	allOk = compare_float((blockC.g[4]), -7.0) && allOk;
	allOk = compare_float((blockC.g[5]), 2.0) && allOk;
	allOk = compare_float((blockC.g[6]), 8.0) && allOk;
	allOk = compare_float((blockC.g[7]), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (0);
	blockB.b[1] = (9);
	blockB.b[2] = (2);
	blockB.b[3] = (-6);
	blockB.b[4] = (6);
	blockB.b[5] = (-6);
	blockC.d = (mat3x2(5.0, -8.0, -7.0, -8.0, 3.0, -6.0));
	blockC.f = (vec2(9.0, 8.0));
	blockC.g[0] = (-1.0);
	blockC.g[1] = (-4.0);
	blockC.g[2] = (0.0);
	blockC.g[3] = (-4.0);
	blockC.g[4] = (2.0);
	blockC.g[5] = (1.0);
	blockC.g[6] = (2.0);
	blockC.g[7] = (9.0);
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	sA a;
	mediump uvec4 b;
	bool c;
	mediump uint d;
	sB e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

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

struct sA
{
	mediump uvec2 mA[3];
	lowp int mB;
	lowp mat4 mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp vec4 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat4 b;
	mediump uvec3 c;
	sA d;
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec3 e;
	mediump float f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-1.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(2u, 5u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(0.0, -7.0, 3.0, 9.0));
	blockC.b = (mat4(-1.0, 3.0, -7.0, -7.0, 6.0, 0.0, 6.0, -9.0, -2.0, -5.0, -3.0, -5.0, -1.0, 9.0, 3.0, -2.0));
	blockC.c = (uvec3(9u, 9u, 4u));
	blockD[0].f[0] = (-1.0);
	blockD[0].f[1] = (0.0);
	blockD[0].f[2] = (-3.0);
	blockD[0].f[3] = (0.0);
	blockD[0].f[4] = (-4.0);
	blockD[0].f[5] = (-8.0);
	blockD[0].f[6] = (-2.0);
	blockD[0].f[7] = (2.0);
	blockD[1].f[0] = (-7.0);
	blockD[2].f[0] = (0.0);
	blockD[2].f[1] = (-3.0);
}
#version 450
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

layout(scalar, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	bvec2 b;
	mediump vec3 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp uvec4 d;
	mediump uvec2 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp uvec4 f;
	mediump vec3 g;
	lowp mat3x4 h[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	mediump mat3 i;
	highp mat3x2 j[5];
	bvec3 k[5];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(0.0, -6.0, 9.0, -5.0, 0.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_vec3((blockB.c[0]), vec3(8.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(0u, 3u, 4u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.e[0]), uvec2(0u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.e[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.e[2]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.e[3]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.e[4]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.e[5]), uvec2(2u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.e[6]), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.e[7]), uvec2(3u, 3u)) && allOk;
	allOk = compare_uvec4((blockD.f), uvec4(3u, 5u, 3u, 8u)) && allOk;
	allOk = compare_mat3x2(blockE.j[0], mat3x2(4.0, 4.0, 6.0, 7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE.j[1], mat3x2(1.0, -1.0, 5.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE.j[2], mat3x2(-3.0, -2.0, 7.0, 6.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE.j[3], mat3x2(6.0, -8.0, 8.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE.j[4], mat3x2(5.0, -9.0, -2.0, -8.0, 6.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockE.k[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE.k[1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE.k[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockE.k[3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockE.k[4]), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(6.0, 3.0, -9.0, 0.0, 9.0, 2.0, -6.0, 6.0));
	blockB.b = (bvec2(false, false));
	blockB.c[0] = (vec3(5.0, -8.0, -7.0));
	blockC.d = (uvec4(2u, 6u, 4u, 1u));
	blockC.e[0] = (uvec2(7u, 3u));
	blockC.e[1] = (uvec2(7u, 3u));
	blockC.e[2] = (uvec2(5u, 5u));
	blockC.e[3] = (uvec2(6u, 7u));
	blockC.e[4] = (uvec2(2u, 5u));
	blockC.e[5] = (uvec2(6u, 5u));
	blockC.e[6] = (uvec2(7u, 8u));
	blockC.e[7] = (uvec2(3u, 0u));
	blockD.f = (uvec4(4u, 1u, 6u, 7u));
	blockE.i = (mat3(-5.0, 9.0, -6.0, 0.0, 7.0, -6.0, -1.0, 1.0, -8.0));
	blockE.k[0] = (bvec3(true, false, true));
	blockE.k[1] = (bvec3(false, true, false));
	blockE.k[2] = (bvec3(false, false, true));
	blockE.k[3] = (bvec3(true, false, false));
	blockE.k[4] = (bvec3(true, false, false));
}
#version 450
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
	highp mat3x2 mB;
	bvec2 mC;
	highp mat4x2 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump mat3 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp float b;
	bvec4 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp vec4 d;
	sA e[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockC.c[0]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.c[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.c[2]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.c[3]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.c[4]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.c[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.c[6]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_vec4((blockD.d), vec4(3.0, -6.0, 4.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockD.e[0].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3x2(blockD.e[0].mB, mat3x2(8.0, 2.0, -7.0, 8.0, 6.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockD.e[0].mC), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(blockD.e[0].mD, mat4x2(2.0, 6.0, -6.0, 1.0, -1.0, -6.0, -6.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockD.e[1].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_mat3x2(blockD.e[1].mB, mat3x2(-5.0, -9.0, 3.0, 4.0, 6.0, -7.0)) && allOk;
	allOk = compare_bvec2((blockD.e[1].mC), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(blockD.e[1].mD, mat4x2(-6.0, 8.0, 0.0, 7.0, 4.0, 4.0, -3.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockD.e[2].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3x2(blockD.e[2].mB, mat3x2(-3.0, 5.0, 3.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_bvec2((blockD.e[2].mC), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(blockD.e[2].mD, mat4x2(4.0, 3.0, -9.0, 3.0, -2.0, -4.0, 8.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockD.e[3].mA), bvec3(true, true, true)) && allOk;
	allOk = compare_mat3x2(blockD.e[3].mB, mat3x2(-1.0, 3.0, -5.0, -6.0, 6.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockD.e[3].mC), bvec2(true, true)) && allOk;
	allOk = compare_mat4x2(blockD.e[3].mD, mat4x2(-9.0, -9.0, 2.0, 7.0, 2.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockD.e[4].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3x2(blockD.e[4].mB, mat3x2(-6.0, 5.0, -5.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockD.e[4].mC), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(blockD.e[4].mD, mat4x2(9.0, 1.0, -4.0, 0.0, 9.0, -7.0, 9.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockD.e[5].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3x2(blockD.e[5].mB, mat3x2(4.0, 9.0, 1.0, -5.0, 2.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockD.e[5].mC), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(blockD.e[5].mD, mat4x2(6.0, -6.0, 1.0, -7.0, -3.0, 5.0, -2.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockD.e[6].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_mat3x2(blockD.e[6].mB, mat3x2(-4.0, -5.0, -1.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockD.e[6].mC), bvec2(false, false)) && allOk;
	allOk = compare_mat4x2(blockD.e[6].mD, mat4x2(-3.0, -1.0, 4.0, -7.0, 1.0, -5.0, 4.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockD.e[7].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3x2(blockD.e[7].mB, mat3x2(-4.0, -5.0, -3.0, -5.0, -7.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockD.e[7].mC), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(blockD.e[7].mD, mat4x2(5.0, -3.0, 4.0, -4.0, -2.0, 5.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3(-9.0, -7.0, -4.0, 8.0, -8.0, -9.0, 8.0, 2.0, -6.0));
	blockC.b = (-3.0);
	blockC.c[0] = (bvec4(false, false, false, true));
	blockC.c[1] = (bvec4(false, true, true, true));
	blockC.c[2] = (bvec4(true, true, false, false));
	blockC.c[3] = (bvec4(false, false, true, false));
	blockC.c[4] = (bvec4(false, false, false, false));
	blockC.c[5] = (bvec4(false, false, false, false));
	blockC.c[6] = (bvec4(false, true, true, false));
	blockD.d = (vec4(-8.0, -7.0, -8.0, -5.0));
	blockD.e[0].mA = (bvec3(false, true, false));
	blockD.e[0].mB = (mat3x2(6.0, 9.0, -9.0, 8.0, 9.0, 3.0));
	blockD.e[0].mC = (bvec2(false, true));
	blockD.e[0].mD = (mat4x2(8.0, -8.0, 4.0, 0.0, -9.0, -5.0, 5.0, 0.0));
	blockD.e[1].mA = (bvec3(true, true, true));
	blockD.e[1].mB = (mat3x2(-9.0, -1.0, 3.0, -8.0, -7.0, 7.0));
	blockD.e[1].mC = (bvec2(false, false));
	blockD.e[1].mD = (mat4x2(6.0, -8.0, 8.0, -6.0, 6.0, 3.0, -2.0, -2.0));
	blockD.e[2].mA = (bvec3(true, true, false));
	blockD.e[2].mB = (mat3x2(-5.0, -7.0, -1.0, 4.0, 9.0, 2.0));
	blockD.e[2].mC = (bvec2(false, true));
	blockD.e[2].mD = (mat4x2(1.0, -8.0, -5.0, -6.0, 6.0, 5.0, 4.0, 9.0));
	blockD.e[3].mA = (bvec3(false, false, true));
	blockD.e[3].mB = (mat3x2(-8.0, -8.0, -4.0, 2.0, 3.0, 2.0));
	blockD.e[3].mC = (bvec2(false, false));
	blockD.e[3].mD = (mat4x2(-7.0, -7.0, 0.0, -4.0, 3.0, 0.0, -6.0, 7.0));
	blockD.e[4].mA = (bvec3(false, true, true));
	blockD.e[4].mB = (mat3x2(2.0, -2.0, -1.0, -7.0, -5.0, 8.0));
	blockD.e[4].mC = (bvec2(true, true));
	blockD.e[4].mD = (mat4x2(-6.0, -2.0, 7.0, -4.0, -4.0, 5.0, 5.0, 4.0));
	blockD.e[5].mA = (bvec3(true, false, false));
	blockD.e[5].mB = (mat3x2(0.0, 6.0, -5.0, -4.0, -3.0, -6.0));
	blockD.e[5].mC = (bvec2(false, true));
	blockD.e[5].mD = (mat4x2(1.0, -6.0, -6.0, 0.0, -2.0, 0.0, 5.0, -5.0));
	blockD.e[6].mA = (bvec3(false, true, true));
	blockD.e[6].mB = (mat3x2(5.0, -5.0, 4.0, 3.0, 3.0, 9.0));
	blockD.e[6].mC = (bvec2(false, false));
	blockD.e[6].mD = (mat4x2(-9.0, -8.0, 9.0, 7.0, 8.0, 6.0, -7.0, 0.0));
	blockD.e[7].mA = (bvec3(true, false, true));
	blockD.e[7].mB = (mat3x2(0.0, 9.0, 2.0, 2.0, -5.0, 5.0));
	blockD.e[7].mC = (bvec2(true, true));
	blockD.e[7].mD = (mat4x2(-8.0, 1.0, 5.0, 1.0, -3.0, 9.0, -3.0, 6.0));
}
#version 450
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
	bool b;
	highp ivec2 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp uvec3 d;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat3x4 e;
	bvec2 f;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp int g[2];
	highp mat2 h;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(2, 5, 9, -9)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-4, 4)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(0u, 4u, 1u)) && allOk;
	allOk = compare_mat3x4(blockD.e, mat3x4(5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockD.f), bvec2(false, false)) && allOk;
	allOk = compare_int((blockE.g[0]), -8) && allOk;
	allOk = compare_int((blockE.g[1]), 9) && allOk;
	allOk = compare_mat2(blockE.h, mat2(-9.0, -6.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(-1, -4, 2, -1));
	blockB.b = (true);
	blockB.c = (ivec2(-5, 7));
	blockC.d = (uvec3(5u, 2u, 2u));
	blockD.e = (mat3x4(4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0, -6.0));
	blockE.g[0] = (3);
	blockE.g[1] = (-9);
	blockE.h = (mat2(-1.0, -8.0, -5.0, 3.0));
}
#version 450
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
	f16vec3 a;
	lowp uint b;
	f16vec3 c;
	i16vec2 d;
	highp uvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 9u) && allOk;
	allOk = compare_uvec4((blockB.e), uvec4(8u, 5u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (1u);
	blockB.e = (uvec4(6u, 5u, 3u, 9u));
}
#version 450
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
	lowp mat4 a[];
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
	allOk = compare_mat4(blockB.a[0], mat4(-5.0, -1.0, -2.0, 2.0, -9.0, 0.0, 0.0, -3.0, -7.0, -3.0, 3.0, 8.0, 9.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.a[1], mat4(-3.0, -3.0, 7.0, -8.0, 8.0, -9.0, 4.0, 9.0, 5.0, 5.0, 6.0, 7.0, -7.0, -9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(-7.0, -3.0, 8.0, -5.0, 4.0, -9.0, -2.0, -9.0, -4.0, 1.0, 5.0, -9.0, -7.0, 2.0, -7.0, -7.0));
	blockB.a[1] = (mat4(3.0, -6.0, 1.0, 4.0, 1.0, 7.0, 3.0, -5.0, 2.0, 1.0, 9.0, -6.0, -4.0, 9.0, 6.0, 2.0));
}
#version 450
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
	f16vec4 a;
	bvec4 b[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	bool c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp vec4 d;
	i16vec2 e;
	lowp uvec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(0.0, 2.0, -8.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB.b[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_vec4((blockD.d), vec4(4.0, 4.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec4(false, false, true, false));
	blockD.d = (vec4(3.0, -2.0, 5.0, -2.0));
	blockD.f[0] = (uvec3(2u, 1u, 9u));
}
#version 450
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
};
struct sB
{
	lowp vec2 mA;
};
layout(std430, buffer_reference) readonly buffer BlockB
{
	mediump mat4 a;
	highp mat2 b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sA c;
	lowp mat2 d;
	sB e;
	i16vec3 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat4x3 g;
	f16vec2 h;
	i16vec2 i;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp uvec2 j;
	lowp mat4x2 k;
	mediump int l;
	mediump mat3 m;
	float16_t n[];
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
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b[0], mat2(3.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2(blockC.d, mat2(-2.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec2((blockC.e.mA), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.f[0]), ivec3(-6, 8, -7)) && allOk;
	allOk = compare_mat4x3(blockD[0].g, mat4x3(-4.0, -7.0, -2.0, 2.0, 7.0, 8.0, -1.0, 5.0, 9.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[0].h), vec2(2.0, 3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].i), ivec2(2, -3)) && allOk;
	allOk = compare_uvec2((blockE.j), uvec2(1u, 3u)) && allOk;
	allOk = compare_mat4x2(blockE.k, mat4x2(5.0, -8.0, -9.0, -5.0, -1.0, 5.0, 8.0, -5.0)) && allOk;
	allOk = compare_float16_t(float(blockE.n[0]), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c.mA = (true);
	blockC.d = (mat2(-6.0, 6.0, 5.0, -6.0));
	blockC.e.mA = (vec2(3.0, 7.0));
	blockC.f[0] = i16vec3(ivec3(-8, -2, -6));
	blockD[0].g = (mat4x3(-3.0, 0.0, 7.0, -1.0, -5.0, -8.0, 9.0, 7.0, -9.0, -8.0, -4.0, 0.0));
	blockD[0].h = f16vec2(vec2(-3.0, 9.0));
	blockD[0].i = i16vec2(ivec2(9, -2));
	blockE.k = (mat4x2(0.0, -6.0, -6.0, -4.0, -9.0, 4.0, -5.0, 8.0));
	blockE.l = (8);
	blockE.m = (mat3(-3.0, -1.0, 2.0, -2.0, 2.0, -1.0, 7.0, -1.0, 3.0));
	blockE.n[0] = float16_t(2.0);
}
#version 450
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
	layout(offset = 0) lowp vec3 b;
	layout(offset = 16) mediump uvec2 c;
	layout(offset = 24) highp vec2 d;
	layout(offset = 32) f16vec4 e;
	layout(offset = 48) lowp ivec4 f[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec4 g;
	layout(offset = 8) mediump int h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockC[0].b), vec3(7.0, -6.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockC[0].c), uvec2(9u, 4u)) && allOk;
	allOk = compare_vec2((blockC[0].d), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].e), vec4(-7.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockC[0].f[0]), ivec4(3, 1, 7, -5)) && allOk;
	allOk = compare_vec3((blockC[1].b), vec3(-4.0, -9.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockC[1].c), uvec2(7u, 9u)) && allOk;
	allOk = compare_vec2((blockC[1].d), vec2(9.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e), vec4(-9.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_ivec4((blockC[1].f[0]), ivec4(2, -6, 9, 2)) && allOk;
	allOk = compare_vec3((blockC[2].b), vec3(-6.0, -9.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockC[2].c), uvec2(5u, 3u)) && allOk;
	allOk = compare_vec2((blockC[2].d), vec2(2.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e), vec4(6.0, 4.0, -9.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockC[2].f[0]), ivec4(-9, -2, 4, 6)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].g), uvec4(0u, 1u, 9u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[1].g), uvec4(8u, 7u, 5u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[2].g), uvec4(8u, 3u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(6, -5, -1));
	blockC[0].b = (vec3(-3.0, -1.0, -2.0));
	blockC[0].d = (vec2(-5.0, -4.0));
	blockC[0].e = f16vec4(vec4(1.0, -7.0, 1.0, 1.0));
	blockC[0].f[0] = (ivec4(-9, -7, -8, 6));
	blockC[1].b = (vec3(5.0, 0.0, 1.0));
	blockC[1].d = (vec2(3.0, 6.0));
	blockC[1].e = f16vec4(vec4(-6.0, 2.0, 6.0, 9.0));
	blockC[1].f[0] = (ivec4(-9, 4, 4, -4));
	blockC[2].b = (vec3(-4.0, 0.0, 3.0));
	blockC[2].d = (vec2(0.0, 0.0));
	blockC[2].e = f16vec4(vec4(-5.0, -3.0, -7.0, -6.0));
	blockC[2].f[0] = (ivec4(-8, 0, 1, 6));
	blockD[0].h = (-3);
	blockD[1].h = (-1);
	blockD[2].h = (7);
}
#version 450
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
	layout(offset = 0) uint16_t a;
	layout(offset = 2) u16vec4 b;
	layout(offset = 16) mediump uvec3 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) f16vec4 d;
	layout(offset = 8) int16_t e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp ivec2 f;
	layout(offset = 16) bvec3 g;
	layout(offset = 28) i16vec2 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) f16vec3 i[1];
	layout(offset = 8) f16vec4 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 9u) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b), uvec4(4u, 4u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_int16_t(int(blockC.e), 2) && allOk;
	allOk = compare_ivec2((blockD.f), ivec2(-7, 2)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(false, true, false)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.h), ivec2(7, 9)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.i[0]), vec3(-6.0, -6.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.j), vec4(2.0, 1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(7u);
	blockB.b = u16vec4(uvec4(5u, 2u, 6u, 1u));
	blockB.c = (uvec3(1u, 2u, 8u));
	blockC.d = f16vec4(vec4(9.0, -1.0, -7.0, 5.0));
	blockC.e = int16_t(8);
	blockD.g = (bvec3(false, false, false));
	blockD.h = i16vec2(ivec2(-3, 6));
	blockE.i[0] = f16vec3(vec3(9.0, -9.0, 2.0));
	blockE.j = f16vec4(vec4(-4.0, -7.0, 9.0, 2.0));
}
#version 450
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
	highp mat4 a;
	mediump vec2 b[][4];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump ivec3 c;
};
layout(scalar, buffer_reference) buffer BlockD
{
	u16vec3 d;
	bvec4 e;
	u16vec4 f;
	highp vec3 g[8];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0)) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(9, -5, 7)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.d), uvec3(3u, 3u, 1u)) && allOk;
	allOk = compare_bvec4((blockD.e), bvec4(false, true, false, false)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f), uvec4(2u, 5u, 1u, 6u)) && allOk;
	allOk = compare_vec3((blockD.g[0]), vec3(2.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD.g[1]), vec3(-3.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.g[2]), vec3(-7.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.g[3]), vec3(-2.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD.g[4]), vec3(2.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD.g[5]), vec3(3.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD.g[6]), vec3(6.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.g[7]), vec3(1.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(3.0, -4.0, 2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0));
	blockB.b[0][0] = (vec2(-8.0, -5.0));
	blockB.b[0][1] = (vec2(0.0, 4.0));
	blockB.b[0][2] = (vec2(7.0, 3.0));
	blockB.b[0][3] = (vec2(-2.0, 9.0));
	blockB.b[1][0] = (vec2(0.0, 6.0));
	blockB.b[1][1] = (vec2(-5.0, 5.0));
	blockB.b[1][2] = (vec2(5.0, -5.0));
	blockB.b[1][3] = (vec2(-2.0, -4.0));
	blockB.b[2][0] = (vec2(-4.0, -9.0));
	blockB.b[2][1] = (vec2(-5.0, 4.0));
	blockB.b[2][2] = (vec2(-3.0, -8.0));
	blockB.b[2][3] = (vec2(-8.0, 9.0));
	blockB.b[3][0] = (vec2(4.0, 4.0));
	blockB.b[3][1] = (vec2(-3.0, 8.0));
	blockB.b[3][2] = (vec2(-6.0, -2.0));
	blockB.b[3][3] = (vec2(-6.0, -9.0));
	blockB.b[4][0] = (vec2(2.0, 6.0));
	blockB.b[4][1] = (vec2(-9.0, -4.0));
	blockB.b[4][2] = (vec2(6.0, 0.0));
	blockB.b[4][3] = (vec2(-2.0, -5.0));
	blockB.b[5][0] = (vec2(-5.0, -4.0));
	blockB.b[5][1] = (vec2(-9.0, 7.0));
	blockB.b[5][2] = (vec2(-1.0, -8.0));
	blockB.b[5][3] = (vec2(9.0, 2.0));
	blockB.b[6][0] = (vec2(5.0, -2.0));
	blockB.b[6][1] = (vec2(-5.0, 0.0));
	blockB.b[6][2] = (vec2(-4.0, 9.0));
	blockB.b[6][3] = (vec2(0.0, -5.0));
	blockB.b[7][0] = (vec2(8.0, -4.0));
	blockB.b[7][1] = (vec2(6.0, -6.0));
	blockB.b[7][2] = (vec2(2.0, 7.0));
	blockB.b[7][3] = (vec2(8.0, 7.0));
	blockC.c = (ivec3(-6, -2, 8));
	blockD.d = u16vec3(uvec3(8u, 1u, 5u));
	blockD.f = u16vec4(uvec4(9u, 7u, 1u, 6u));
}
#version 450
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
	lowp mat3x4 a[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	i16vec2 b;
	f16vec4 c[][1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockC.b), ivec2(-1, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(2.0, -9.0, 2.0, 8.0, 3.0, 5.0, -9.0, -4.0, 8.0, -1.0, -3.0, -1.0));
	blockB.a[1] = (mat3x4(9.0, 6.0, -8.0, -1.0, 1.0, -1.0, 3.0, 8.0, 1.0, 8.0, 4.0, 9.0));
	blockB.a[2] = (mat3x4(4.0, 2.0, -8.0, -2.0, 2.0, -1.0, 4.0, -2.0, 3.0, 8.0, 3.0, 7.0));
	blockB.a[3] = (mat3x4(-8.0, -9.0, 2.0, 5.0, 4.0, 5.0, -4.0, 2.0, -1.0, 9.0, -7.0, 1.0));
	blockB.a[4] = (mat3x4(-3.0, 3.0, 4.0, -5.0, 9.0, 7.0, -9.0, -6.0, 5.0, -6.0, -4.0, -5.0));
	blockB.a[5] = (mat3x4(-6.0, 1.0, 2.0, 2.0, -9.0, -1.0, 1.0, -8.0, -6.0, -2.0, 7.0, 7.0));
	blockB.a[6] = (mat3x4(-8.0, 8.0, 8.0, 4.0, -3.0, 3.0, -3.0, -3.0, -4.0, -3.0, -5.0, 7.0));
	blockB.a[7] = (mat3x4(-2.0, 4.0, -9.0, 4.0, -1.0, -7.0, 6.0, 7.0, -4.0, -4.0, 1.0, -3.0));
	blockC.b = i16vec2(ivec2(-8, 6));
}
#version 450
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
	highp int d[];
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
	blockB.d[0] = (5);
	blockB.d[1] = (3);
	blockB.d[2] = (-3);
	blockB.d[3] = (2);
	blockB.d[4] = (4);
}
#version 450
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
	mediump mat4x2 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a[0], mat4x2(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[1], mat4x2(-3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[2], mat4x2(-4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[3], mat4x2(-7.0, -1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[4], mat4x2(-6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[5], mat4x2(-1.0, -8.0, -3.0, -6.0, 1.0, 7.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0));
	blockB.a[1] = (mat4x2(4.0, 7.0, -1.0, 6.0, 5.0, 8.0, 6.0, 2.0));
	blockB.a[2] = (mat4x2(-7.0, -2.0, -4.0, -2.0, 4.0, -2.0, 3.0, 0.0));
	blockB.a[3] = (mat4x2(-8.0, 6.0, -7.0, 4.0, 6.0, -2.0, -5.0, 3.0));
	blockB.a[4] = (mat4x2(0.0, 9.0, -2.0, 3.0, -3.0, 3.0, 2.0, 2.0));
	blockB.a[5] = (mat4x2(-6.0, -8.0, -6.0, 4.0, -7.0, -9.0, 7.0, -3.0));
}
#version 450
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
	highp vec2 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp uint b;
	highp mat3 c;
	lowp uint d;
	mediump uvec2 e;
	lowp ivec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_uint((blockC.b), 6u) && allOk;
	allOk = compare_mat3(blockC.c, mat3(2.0, 1.0, -7.0, 0.0, -5.0, 3.0, -3.0, -2.0, 6.0)) && allOk;
	allOk = compare_uint((blockC.d), 9u) && allOk;
	allOk = compare_ivec2((blockC.f[0]), ivec2(3, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(5.0, -5.0));
	blockC.b = (1u);
	blockC.c = (mat3(9.0, 0.0, 2.0, -5.0, -1.0, -4.0, -5.0, -9.0, -8.0));
	blockC.e = (uvec2(8u, 3u));
	blockC.f[0] = (ivec2(-3, -7));
}
#version 450
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
	highp float mB;
};
struct sB
{
	i8vec4 mA;
	highp vec2 mB;
	lowp mat4x3 mC;
};
struct sC
{
	sB mA;
	uint8_t mB[5];
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	mediump vec3 b;
	highp int c;
	mediump mat3x4 d;
	lowp ivec3 e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	i8vec3 f;
	mediump mat3x4 g;
	lowp vec3 h;
	lowp ivec3 i;
	u8vec2 j[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp vec4 k;
	mediump ivec4 l;
	sC m;
	bool n[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a[0].mA), ivec3(2, -8, -4)) && allOk;
	allOk = compare_float((blockB.a[0].mB), 5.0) && allOk;
	allOk = compare_ivec3((blockB.a[1].mA), ivec3(7, 4, 0)) && allOk;
	allOk = compare_float((blockB.a[1].mB), 8.0) && allOk;
	allOk = compare_ivec3((blockB.a[2].mA), ivec3(-5, -8, -6)) && allOk;
	allOk = compare_float((blockB.a[2].mB), 5.0) && allOk;
	allOk = compare_ivec3((blockB.a[3].mA), ivec3(4, 5, 6)) && allOk;
	allOk = compare_float((blockB.a[3].mB), -9.0) && allOk;
	allOk = compare_ivec3((blockB.a[4].mA), ivec3(-6, 1, 8)) && allOk;
	allOk = compare_float((blockB.a[4].mB), -8.0) && allOk;
	allOk = compare_ivec3((blockB.a[5].mA), ivec3(1, -7, 7)) && allOk;
	allOk = compare_float((blockB.a[5].mB), 6.0) && allOk;
	allOk = compare_vec3((blockC.b), vec3(2.0, 3.0, -7.0)) && allOk;
	allOk = compare_int((blockC.c), -8) && allOk;
	allOk = compare_mat3x4(blockC.d, mat3x4(9.0, 1.0, -3.0, -4.0, -9.0, 3.0, 8.0, 6.0, 1.0, 6.0, 6.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockC.e[0]), ivec3(5, 8, -9)) && allOk;
	allOk = compare_ivec3((blockC.e[1]), ivec3(-5, -1, -8)) && allOk;
	allOk = compare_vec3((blockD.h), vec3(5.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockD.i), ivec3(-5, 6, 9)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j[0]), uvec2(5u, 0u)) && allOk;
	allOk = compare_vec4((blockE[0].k), vec4(-3.0, -3.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockE[0].l), ivec4(5, -2, -1, -4)) && allOk;
	allOk = compare_bool((blockE[0].n[0]), true) && allOk;
	allOk = compare_bool((blockE[0].n[1]), true) && allOk;
	allOk = compare_bool((blockE[0].n[2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (ivec3(8, -2, -1));
	blockB.a[0].mB = (0.0);
	blockB.a[1].mA = (ivec3(-6, 6, 0));
	blockB.a[1].mB = (9.0);
	blockB.a[2].mA = (ivec3(9, 5, 4));
	blockB.a[2].mB = (-4.0);
	blockB.a[3].mA = (ivec3(8, 6, 7));
	blockB.a[3].mB = (-5.0);
	blockB.a[4].mA = (ivec3(-5, 5, -2));
	blockB.a[4].mB = (4.0);
	blockB.a[5].mA = (ivec3(7, 4, 7));
	blockB.a[5].mB = (9.0);
	blockD.f = i8vec3(ivec3(4294967295, 4294967294, 4294967293));
	blockD.g = (mat3x4(-7.0, 8.0, -6.0, 7.0, 9.0, 8.0, -3.0, -4.0, 4.0, 9.0, 0.0, 1.0));
	blockD.h = (vec3(2.0, -3.0, -9.0));
	blockD.i = (ivec3(-9, 0, -6));
	blockD.j[0] = u8vec2(uvec2(5u, 4u));
	blockE[0].k = (vec4(-1.0, -8.0, -9.0, 0.0));
	blockE[0].l = (ivec4(0, 9, -9, 4));
	blockE[0].m.mA.mA = i8vec4(ivec4(7, 6, 6, 4294967291));
	blockE[0].m.mA.mB = (vec2(-4.0, 3.0));
	blockE[0].m.mA.mC = (mat4x3(-5.0, -2.0, 0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0, 4.0, -1.0));
	blockE[0].m.mB[0] = uint8_t(9u);
	blockE[0].m.mB[1] = uint8_t(8u);
	blockE[0].m.mB[2] = uint8_t(7u);
	blockE[0].m.mB[3] = uint8_t(5u);
	blockE[0].m.mB[4] = uint8_t(9u);
	blockE[0].n[0] = (true);
	blockE[0].n[1] = (false);
	blockE[0].n[2] = (true);
}
#version 450
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
	highp vec2 mB;
	lowp uvec4 mC;
};
struct sB
{
	mediump mat2x3 mA;
	sA mB;
	highp ivec3 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
	bvec2 b;
	sB c;
	i8vec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-8.0, 3.0, 3.0, 6.0, -9.0, 0.0, 4.0, 9.0, -9.0, -5.0, 1.0, -1.0, 3.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_mat2x3(blockB.c.mA, mat2x3(5.0, 4.0, 2.0, -7.0, 7.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockB.c.mB.mA), uvec4(4u, 1u, 7u, 8u)) && allOk;
	allOk = compare_vec2((blockB.c.mB.mB), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockB.c.mB.mC), uvec4(5u, 6u, 6u, 1u)) && allOk;
	allOk = compare_ivec3((blockB.c.mC), ivec3(-7, 2, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[0]), ivec2(4, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[1]), ivec2(8, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[2]), ivec2(6, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[3]), ivec2(4294967295, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[4]), ivec2(4294967290, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[5]), ivec2(9, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(7.0, 3.0, 9.0, 4.0, -8.0, 5.0, 3.0, 1.0, -6.0, -1.0, -7.0, 7.0, -6.0, 2.0, -7.0, -3.0));
	blockB.c.mA = (mat2x3(-7.0, -6.0, -8.0, 8.0, 1.0, -3.0));
	blockB.c.mB.mA = (uvec4(3u, 2u, 3u, 5u));
	blockB.c.mB.mB = (vec2(9.0, 6.0));
	blockB.c.mB.mC = (uvec4(1u, 1u, 0u, 4u));
	blockB.c.mC = (ivec3(6, -6, -2));
	blockB.d[0] = i8vec2(ivec2(6, 4294967291));
	blockB.d[1] = i8vec2(ivec2(6, 6));
	blockB.d[2] = i8vec2(ivec2(4294967293, 7));
	blockB.d[3] = i8vec2(ivec2(4294967293, 4294967294));
	blockB.d[4] = i8vec2(ivec2(5, 4294967294));
	blockB.d[5] = i8vec2(ivec2(7, 4294967287));
}
#version 450
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
	layout(offset = 8) bvec2 b[1];
	layout(offset = 16) lowp ivec3 c;
	layout(offset = 28) u8vec2 d;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) lowp vec2 e;
	layout(offset = 16) highp uvec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u8vec3 g[1];
	layout(offset = 4) highp uvec3 h;
	layout(offset = 16) u8vec4 i[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b[0]), bvec2(false, false)) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(-5, -3, 9)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d), uvec2(3u, 3u)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(2.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(0u, 1u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g[0]), uvec3(8u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.h), uvec3(2u, 5u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i[0]), uvec4(6u, 4u, 7u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(6u, 1u));
	blockB.b[0] = (bvec2(false, true));
	blockB.c = (ivec3(4, 8, -8));
	blockB.d = u8vec2(uvec2(1u, 5u));
	blockD.g[0] = u8vec3(uvec3(1u, 0u, 0u));
	blockD.h = (uvec3(3u, 7u, 9u));
	blockD.i[0] = u8vec4(uvec4(7u, 8u, 8u, 0u));
}
#version 450
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
	highp int mB;
	lowp uvec4 mC;
};
struct sB
{
	highp mat2 mA;
	highp mat4 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
};
layout(scalar, buffer_reference) buffer BlockC
{
	int8_t b[];
};
layout(scalar, buffer_reference) readonly buffer BlockD
{
	highp uvec2 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	u8vec2 d;
	mediump ivec3 e;
	highp int f[7];
	highp uvec3 g;
	sB h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[0].a.mA), uvec2(9u, 8u)) && allOk;
	allOk = compare_int((blockB[0].a.mB), -2) && allOk;
	allOk = compare_uvec4((blockB[0].a.mC), uvec4(8u, 1u, 5u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].a.mA), uvec2(9u, 5u)) && allOk;
	allOk = compare_int((blockB[1].a.mB), 6) && allOk;
	allOk = compare_uvec4((blockB[1].a.mC), uvec4(5u, 6u, 0u, 8u)) && allOk;
	allOk = compare_ivec3((blockE.e), ivec3(-5, -4, -6)) && allOk;
	allOk = compare_int((blockE.f[0]), -4) && allOk;
	allOk = compare_int((blockE.f[1]), 8) && allOk;
	allOk = compare_int((blockE.f[2]), 9) && allOk;
	allOk = compare_int((blockE.f[3]), -8) && allOk;
	allOk = compare_int((blockE.f[4]), 2) && allOk;
	allOk = compare_int((blockE.f[5]), 9) && allOk;
	allOk = compare_int((blockE.f[6]), 1) && allOk;
	allOk = compare_uvec3((blockE.g), uvec3(0u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = u8vec2(uvec2(1u, 5u));
	blockB[0].a.mB = (3);
	blockB[0].a.mC = (uvec4(2u, 9u, 4u, 8u));
	blockB[1].a.mA = u8vec2(uvec2(5u, 8u));
	blockB[1].a.mB = (9);
	blockB[1].a.mC = (uvec4(9u, 5u, 4u, 2u));
	blockC.b[0] = int8_t(7);
	blockC.b[1] = int8_t(3);
	blockC.b[2] = int8_t(2);
	blockC.b[3] = int8_t(4294967289);
	blockC.b[4] = int8_t(1);
	blockC.b[5] = int8_t(3);
	blockC.b[6] = int8_t(2);
	blockC.b[7] = int8_t(4294967289);
	blockE.f[0] = (-2);
	blockE.f[1] = (-9);
	blockE.f[2] = (-9);
	blockE.f[3] = (7);
	blockE.f[4] = (3);
	blockE.f[5] = (-9);
	blockE.f[6] = (1);
	blockE.g = (uvec3(0u, 0u, 7u));
	blockE.h[0].mA = (mat2(3.0, -6.0, 6.0, 6.0));
	blockE.h[0].mB = (mat4(-7.0, 1.0, 4.0, -1.0, -7.0, 1.0, 2.0, -3.0, -4.0, -6.0, -3.0, 1.0, 8.0, 2.0, 1.0, -9.0));
	blockE.h[1].mA = (mat2(0.0, -2.0, 8.0, -8.0));
	blockE.h[1].mB = (mat4(9.0, -5.0, 1.0, 6.0, -9.0, 5.0, -2.0, -5.0, -8.0, 4.0, 7.0, 4.0, 5.0, 5.0, -9.0, 3.0));
	blockE.h[2].mA = (mat2(-9.0, -9.0, -7.0, 9.0));
	blockE.h[2].mB = (mat4(3.0, -7.0, 9.0, 5.0, 3.0, 3.0, -7.0, 2.0, 8.0, -5.0, 3.0, 2.0, 7.0, -3.0, -5.0, -2.0));
	blockE.h[3].mA = (mat2(-7.0, -8.0, 7.0, 4.0));
	blockE.h[3].mB = (mat4(2.0, 8.0, 3.0, 9.0, -2.0, 5.0, -3.0, -1.0, -7.0, 6.0, -9.0, 5.0, -1.0, -3.0, -1.0, -7.0));
	blockE.h[4].mA = (mat2(-4.0, 4.0, -1.0, 7.0));
	blockE.h[4].mB = (mat4(-7.0, 2.0, -8.0, 2.0, -5.0, -9.0, -2.0, 9.0, -4.0, -7.0, 5.0, 8.0, 2.0, -6.0, 0.0, 7.0));
	blockE.h[5].mA = (mat2(-1.0, 4.0, -8.0, -7.0));
	blockE.h[5].mB = (mat4(-4.0, 5.0, 1.0, 0.0, 4.0, -1.0, 7.0, 6.0, 6.0, -6.0, -7.0, 5.0, -1.0, -3.0, 9.0, 2.0));
}
#version 450
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
	bvec3 mB[4];
	int8_t mC[6];
	highp mat4x2 mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	u8vec2 a;
	i8vec3 b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp mat3 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp mat3 d;
	lowp ivec2 e;
	sA f;
	mediump uvec2 g;
	highp mat3x4 h;
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockE
{
	lowp mat3x4 i[][3];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(1u, 2u)) && allOk;
	allOk = compare_mat3(blockC.c[0], mat3(-2.0, -6.0, 7.0, -7.0, -5.0, 1.0, -1.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3(blockC.c[1], mat3(-4.0, -5.0, -5.0, 9.0, -8.0, 8.0, 6.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.c[2], mat3(7.0, -2.0, 8.0, -1.0, -4.0, -3.0, -5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.c[3], mat3(7.0, -4.0, -8.0, 2.0, 9.0, -2.0, 1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(blockD.d, mat3(-1.0, -5.0, 2.0, -7.0, 9.0, 5.0, -2.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = i8vec3(ivec3(9, 4294967294, 4294967291));
	blockB.b[1] = i8vec3(ivec3(4294967289, 4294967292, 6));
	blockB.b[2] = i8vec3(ivec3(4294967294, 4294967290, 4294967290));
	blockC.c[0] = (mat3(4.0, 4.0, 3.0, 9.0, -2.0, 8.0, -6.0, -9.0, -8.0));
	blockC.c[1] = (mat3(-5.0, -7.0, 4.0, 4.0, -6.0, 4.0, 1.0, -9.0, 6.0));
	blockC.c[2] = (mat3(-2.0, 8.0, -3.0, -4.0, 3.0, 4.0, 7.0, -4.0, -2.0));
	blockC.c[3] = (mat3(8.0, -8.0, -7.0, 0.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	blockD.d = (mat3(6.0, 1.0, 2.0, -1.0, -4.0, -6.0, -9.0, -7.0, -4.0));
	blockD.e = (ivec2(-5, -2));
	blockD.f.mA = u8vec3(uvec3(0u, 9u, 0u));
	blockD.f.mB[0] = (bvec3(false, false, true));
	blockD.f.mB[1] = (bvec3(true, true, false));
	blockD.f.mB[2] = (bvec3(false, true, true));
	blockD.f.mB[3] = (bvec3(false, true, true));
	blockD.f.mC[0] = int8_t(6);
	blockD.f.mC[1] = int8_t(4294967290);
	blockD.f.mC[2] = int8_t(3);
	blockD.f.mC[3] = int8_t(0);
	blockD.f.mC[4] = int8_t(1);
	blockD.f.mC[5] = int8_t(9);
	blockD.f.mD = (mat4x2(5.0, -4.0, 1.0, 7.0, -6.0, -4.0, 6.0, -4.0));
	blockD.g = (uvec2(7u, 8u));
	blockD.h = (mat3x4(-7.0, 5.0, -1.0, 0.0, -4.0, 8.0, 1.0, 6.0, -3.0, 3.0, -5.0, -6.0));
}
#version 450
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
	mediump mat3x2 a;
	highp int b;
	i8vec3 c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp mat4x3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(6.0, 0.0, 2.0, 0.0, 8.0, -6.0));
	blockB.b = (6);
	blockB.c[0] = i8vec3(ivec3(1, 8, 4294967290));
	blockB.c[1] = i8vec3(ivec3(3, 4294967295, 4294967288));
	blockB.c[2] = i8vec3(ivec3(4294967292, 2, 9));
	blockB.c[3] = i8vec3(ivec3(1, 4294967290, 4294967293));
	blockC.d[0] = (mat4x3(-5.0, 3.0, 4.0, -2.0, 9.0, 2.0, 9.0, -4.0, 1.0, -3.0, 9.0, -9.0));
	blockC.d[1] = (mat4x3(-5.0, 9.0, 5.0, 4.0, -8.0, -3.0, 0.0, -3.0, -4.0, 2.0, -2.0, -9.0));
}
#version 450
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
	layout(offset = 0) u8vec3 a;
	layout(offset = 3) i8vec4 b;
	layout(offset = 16) mediump uvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].a), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(0)].b), ivec4(6, 1, 9, 4294967290)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].c), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].a), uvec3(0u, 7u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(1)].b), ivec4(4294967290, 4294967291, 4294967288, 7)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].c), uvec3(6u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(2)].a), uvec3(7u, 3u, 2u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(2)].b), ivec4(6, 4294967292, 4294967295, 8)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].c), uvec3(5u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(3)].a), uvec3(7u, 5u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(3)].b), ivec4(4294967287, 7, 3, 4294967290)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].c), uvec3(3u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u8vec3(uvec3(4u, 9u, 2u));
	blockB[nonuniformEXT(0)].b = i8vec4(ivec4(4294967290, 1, 4294967294, 4294967295));
	blockB[nonuniformEXT(1)].a = u8vec3(uvec3(8u, 6u, 7u));
	blockB[nonuniformEXT(1)].b = i8vec4(ivec4(3, 4, 9, 1));
	blockB[nonuniformEXT(2)].a = u8vec3(uvec3(4u, 3u, 7u));
	blockB[nonuniformEXT(2)].b = i8vec4(ivec4(4294967289, 3, 4294967289, 4294967291));
	blockB[nonuniformEXT(3)].a = u8vec3(uvec3(0u, 5u, 5u));
	blockB[nonuniformEXT(3)].b = i8vec4(ivec4(4294967294, 9, 5, 7));
}
