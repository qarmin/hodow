#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(2.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(9.0, 9.0, 9.0));
	var[1] = (vec3(8.0, -3.0, -5.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(9.0, 8.0, -4.0));
	var[1] = (vec3(-4.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-5.0, -4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(-7.0, -4.0, 6.0, 8.0, -2.0, 2.0, -3.0, 9.0, 4.0, -4.0, 9.0, 0.0));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], 4.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -1.0) && allOk;
	allOk = compare_float(var[2][3], -7.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], -7.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, 5.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-4.0, 5.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(2.0, 6.0, -8.0, 9.0));
	var[1] = (vec4(-8.0, 4.0, -8.0, 7.0));
	var[2] = (vec4(9.0, -7.0, -2.0, -7.0));
	var[3] = (vec4(0.0, -7.0, 7.0, -8.0));
}
#version 450
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
	bvec3 var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec3((var), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var = (bvec3(true, false, false));
}
#version 450
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

	padding = (true);
	var = (bvec4(true, true, false, true));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(3.0, -9.0, 3.0, -3.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (mat2x3(-4.0, -4.0, 3.0, -2.0, 8.0, 1.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-3.0, 1.0, -9.0, 3.0, -3.0, -9.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var = (mat2x4(-7.0, 5.0, -2.0, 2.0, -1.0, -3.0, -3.0, 7.0));
}
#version 450
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], 5.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, 7.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec4(-3.0, 7.0, -9.0, 5.0));
	var[1] = (vec4(8.0, -8.0, 9.0, -7.0));
}
#version 450
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

	padding = (-1.0);
	var[0] = (vec4(9.0, -3.0, 7.0, 1.0));
	var[1] = (vec4(-1.0, 6.0, 9.0, -5.0));
}
#version 450
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

	padding = (-5.0);
	var[0] = (vec4(4.0, 5.0, 9.0, -8.0));
	var[1] = (vec4(-7.0, -1.0, -4.0, 6.0));
	var[2] = (vec4(3.0, -1.0, -4.0, -1.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(9.0, -9.0, 3.0, 0.0, 7.0, -1.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var = (mat4x2(-6.0, 7.0, 3.0, 8.0, 3.0, -6.0, 3.0, -5.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat4x3(-4.0, 6.0, 8.0, -2.0, 2.0, -3.0, 9.0, 4.0, -4.0, 9.0, 0.0, 5.0));
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][1] = (vec3(0.0, -8.0, -2.0));
	var[1][0] = (vec3(8.0, 8.0, 0.0));
	var[1][1] = (vec3(3.0, -6.0, -6.0));
	var[2][0] = (vec3(-1.0, 2.0, -9.0));
	var[2][1] = (vec3(1.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
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
}
#version 450
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
	f16vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(-8.0, -8.0, -3.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(6.0, 1.0, -8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(9.0);
	var[0] = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	var[1] = f16vec4(vec4(-4.0, 2.0, -5.0, 9.0));
	var[2] = f16vec4(vec4(1.0, -6.0, 3.0, -1.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
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

	var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	var[3] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	var[4] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	var[5] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	var[6] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	var[7] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	var[8] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	var[9] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	var[10] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	var[11] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	var[12] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	var[13] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	var[14] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	var[15] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	var[16] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	var[17] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	var[18] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[3] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[4] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[5] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[6] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[7] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[8] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[9] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[10] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[11] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	var[12] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	var[13] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	var[14] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	var[15] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	var[16] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	var[17] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	var[18] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
}
#version 450
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

	var[0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[1] = i16vec4(ivec4(2, 7, -4, 4));
	var[2] = i16vec4(ivec4(8, 9, 5, 1));
	var[3] = i16vec4(ivec4(-3, 3, 8, 7));
	var[4] = i16vec4(ivec4(2, 6, -9, 9));
	var[5] = i16vec4(ivec4(-2, 4, -8, -7));
	var[6] = i16vec4(ivec4(-9, -1, -8, -1));
	var[7] = i16vec4(ivec4(-1, -6, 5, 2));
	var[8] = i16vec4(ivec4(-3, 8, -7, -2));
	var[9] = i16vec4(ivec4(9, 7, 6, -9));
	var[10] = i16vec4(ivec4(5, -3, 8, 5));
	var[11] = i16vec4(ivec4(-6, -9, -6, 2));
	var[12] = i16vec4(ivec4(7, -1, 8, -5));
	var[13] = i16vec4(ivec4(-9, -6, -2, -2));
	var[14] = i16vec4(ivec4(-3, 8, 7, -4));
	var[15] = i16vec4(ivec4(-2, 0, 6, -2));
	var[16] = i16vec4(ivec4(6, -5, -6, -3));
	var[17] = i16vec4(ivec4(4, -4, -4, 9));
	var[18] = i16vec4(ivec4(7, 6, 4, -1));
}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[3] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[4] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[5] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[6] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[7] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[8] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[9] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[10] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[11] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	var[12] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	var[13] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	var[14] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	var[15] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	var[16] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	var[17] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	var[18] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	f16vec2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[4]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[5]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[6]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[7]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[8]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[9]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[10]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[11]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[12]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[13]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[14]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[15]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[16]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[17]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[18]), vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec2(vec2(-2.0, 4.0));
	var[1] = f16vec2(vec2(-2.0, 4.0));
	var[2] = f16vec2(vec2(-1.0, 1.0));
	var[3] = f16vec2(vec2(9.0, 4.0));
	var[4] = f16vec2(vec2(8.0, -8.0));
	var[5] = f16vec2(vec2(1.0, -3.0));
	var[6] = f16vec2(vec2(2.0, 2.0));
	var[7] = f16vec2(vec2(-6.0, 5.0));
	var[8] = f16vec2(vec2(5.0, -7.0));
	var[9] = f16vec2(vec2(3.0, 0.0));
	var[10] = f16vec2(vec2(-2.0, 3.0));
	var[11] = f16vec2(vec2(-6.0, 5.0));
	var[12] = f16vec2(vec2(6.0, 0.0));
	var[13] = f16vec2(vec2(3.0, 5.0));
	var[14] = f16vec2(vec2(9.0, -9.0));
	var[15] = f16vec2(vec2(-6.0, 7.0));
	var[16] = f16vec2(vec2(3.0, -7.0));
	var[17] = f16vec2(vec2(4.0, -5.0));
	var[18] = f16vec2(vec2(7.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-2.0, 1.0));
	var[0][0][1] = (vec2(-7.0, -1.0));
	var[0][1][0] = (vec2(5.0, -3.0));
	var[0][1][1] = (vec2(4.0, 8.0));
	var[0][2][0] = (vec2(-2.0, -6.0));
	var[0][2][1] = (vec2(-5.0, -1.0));
	var[1][0][0] = (vec2(3.0, 4.0));
	var[1][0][1] = (vec2(-8.0, 6.0));
	var[1][1][0] = (vec2(6.0, -2.0));
	var[1][1][1] = (vec2(1.0, 3.0));
	var[1][2][0] = (vec2(2.0, 1.0));
	var[1][2][1] = (vec2(7.0, -2.0));
	var[2][0][0] = (vec2(-4.0, 2.0));
	var[2][0][1] = (vec2(-1.0, -4.0));
	var[2][1][0] = (vec2(-5.0, -8.0));
	var[2][1][1] = (vec2(3.0, -7.0));
	var[2][2][0] = (vec2(5.0, 0.0));
	var[2][2][1] = (vec2(-4.0, -9.0));
	var[3][0][0] = (vec2(9.0, 1.0));
	var[3][0][1] = (vec2(7.0, 9.0));
	var[3][1][0] = (vec2(1.0, 3.0));
	var[3][1][1] = (vec2(-3.0, 7.0));
	var[3][2][0] = (vec2(1.0, 5.0));
	var[3][2][1] = (vec2(4.0, 1.0));
}
#version 450
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
	uint16_t var[4][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[1][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[3][2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = uint16_t(9u);
	var[0][1] = uint16_t(1u);
	var[0][2] = uint16_t(1u);
	var[1][0] = uint16_t(0u);
	var[1][1] = uint16_t(7u);
	var[1][2] = uint16_t(5u);
	var[2][0] = uint16_t(8u);
	var[2][1] = uint16_t(1u);
	var[2][2] = uint16_t(9u);
	var[3][0] = uint16_t(7u);
	var[3][1] = uint16_t(2u);
	var[3][2] = uint16_t(6u);
}
#version 450
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
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(-5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0, 3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0, -2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0, 0.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0, 8.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0, -9.0, -5.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0, -4.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0, -7.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0, -8.0, 2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0, 5.0, 8.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0, 3.0, 3.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0, -8.0, 8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0, 8.0, -7.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0][0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][0][1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][0][2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[0][0][3] = (vec4(0.0, -1.0, -4.0, 4.0));
	var[0][1][0] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[0][1][1] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[0][1][2] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[0][1][3] = (vec4(9.0, 4.0, -3.0, 1.0));
	var[0][2][0] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[0][2][1] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[0][2][2] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[0][2][3] = (vec4(-4.0, -6.0, 5.0, -9.0));
	var[1][0][0] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[1][0][1] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[1][0][2] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[1][0][3] = (vec4(5.0, 8.0, 6.0, -9.0));
	var[1][1][0] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[1][1][1] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[1][1][2] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[1][1][3] = (vec4(-1.0, -5.0, 7.0, -9.0));
	var[1][2][0] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[1][2][1] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[1][2][2] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[1][2][3] = (vec4(1.0, 2.0, -3.0, -5.0));
	var[2][0][0] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[2][0][1] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[2][0][2] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[2][0][3] = (vec4(9.0, 9.0, 4.0, 4.0));
	var[2][1][0] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[2][1][1] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[2][1][2] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[2][1][3] = (vec4(-8.0, -1.0, 0.0, 7.0));
	var[2][2][0] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[2][2][1] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[2][2][2] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[2][2][3] = (vec4(-2.0, -6.0, 9.0, 9.0));
	var[3][0][0] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[3][0][1] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[3][0][2] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[3][0][3] = (vec4(-1.0, -1.0, -3.0, -9.0));
	var[3][1][0] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[3][1][1] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[3][1][2] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[3][1][3] = (vec4(-4.0, 4.0, 6.0, 2.0));
	var[3][2][0] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[3][2][1] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[3][2][2] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[3][2][3] = (vec4(-1.0, 1.0, -1.0, -1.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(-7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0, -4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0, -6.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0, -4.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0, 3.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0, -4.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0, 0.0, -7.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0, 9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0, -2.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(-3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0, 1.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0, 5.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0, 4.0, 1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0][0][0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][0][2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	var[0][1][0] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][1][1] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][1][2] = (vec4(6.0, 0.0, 6.0, 3.0));
	var[0][2][0] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[0][2][1] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[0][2][2] = (vec4(-3.0, 6.0, -2.0, 6.0));
	var[1][0][0] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][1] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][0][2] = (vec4(4.0, -5.0, 8.0, 0.0));
	var[1][1][0] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[1][1][1] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[1][1][2] = (vec4(-6.0, 5.0, 1.0, 2.0));
	var[1][2][0] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[1][2][1] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[1][2][2] = (vec4(0.0, 5.0, -4.0, 0.0));
	var[2][0][0] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[2][0][1] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[2][0][2] = (vec4(-7.0, 3.0, -8.0, -2.0));
	var[2][1][0] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[2][1][1] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[2][1][2] = (vec4(-9.0, -7.0, -8.0, 9.0));
	var[2][2][0] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[2][2][1] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[2][2][2] = (vec4(-2.0, 7.0, -9.0, 0.0));
	var[3][0][0] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[3][0][1] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[3][0][2] = (vec4(9.0, -3.0, -9.0, -6.0));
	var[3][1][0] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[3][1][1] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[3][1][2] = (vec4(6.0, -8.0, -3.0, -7.0));
	var[3][2][0] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[3][2][1] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[3][2][2] = (vec4(-4.0, 9.0, 7.0, 6.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[0][0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[0][1][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	var[0][1][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	var[0][1][2] = (mat2(5.0, -4.0, 3.0, 8.0));
	var[1][0][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[1][0][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[1][0][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[1][1][0] = (mat2(0.0, -2.0, 7.0, 4.0));
	var[1][1][1] = (mat2(4.0, -4.0, 0.0, 7.0));
	var[1][1][2] = (mat2(-7.0, 7.0, -1.0, 4.0));
	var[2][0][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[2][0][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[2][0][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[2][1][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	var[2][1][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	var[2][1][2] = (mat2(1.0, -5.0, -9.0, -7.0));
	var[3][0][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[3][0][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[3][0][2] = (mat2(5.0, 8.0, -2.0, 4.0));
	var[3][1][0] = (mat2(-6.0, 7.0, 4.0, 1.0));
	var[3][1][1] = (mat2(-8.0, 7.0, -5.0, -1.0));
	var[3][1][2] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-1.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(5.0, 3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(7.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-5.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(9.0, 2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[0][0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[0][0][2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[0][1][0] = (mat2(5.0, 7.0, 7.0, -8.0));
	var[0][1][1] = (mat2(7.0, -9.0, -2.0, 4.0));
	var[0][1][2] = (mat2(3.0, 3.0, 3.0, -6.0));
	var[1][0][0] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[1][0][1] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[1][0][2] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[1][1][0] = (mat2(-4.0, -8.0, -2.0, 5.0));
	var[1][1][1] = (mat2(-3.0, 5.0, 0.0, -2.0));
	var[1][1][2] = (mat2(-3.0, 0.0, -9.0, 1.0));
	var[2][0][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[2][0][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[2][0][2] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[2][1][0] = (mat2(-8.0, 1.0, -1.0, -3.0));
	var[2][1][1] = (mat2(6.0, -9.0, -7.0, 6.0));
	var[2][1][2] = (mat2(-6.0, -2.0, 6.0, 0.0));
	var[3][0][0] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[3][0][1] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[3][0][2] = (mat2(4.0, 7.0, 4.0, -8.0));
	var[3][1][0] = (mat2(-4.0, -4.0, -6.0, -7.0));
	var[3][1][1] = (mat2(1.0, 6.0, -7.0, 7.0));
	var[3][1][2] = (mat2(9.0, -8.0, 3.0, -7.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(2.0, 1.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(2.0, 4.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-3.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(6.0, 9.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-9.0, 3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(8.0, 1.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(2.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-4.0, 5.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-1.0, -5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(8.0, -1.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-3.0, 4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, 7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(5.0, 2.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-8.0, -1.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(4.0, -8.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(4.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-1.0, -6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(9.0, -7.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(1.0, 5.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-3.0, 6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-7.0, 9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-2.0, -3.0, -7.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0][0][0] = (vec2(-4.0, 5.0));
	var[0][0][0][1] = (vec2(1.0, -8.0));
	var[0][0][1][0] = (vec2(-1.0, 9.0));
	var[0][0][1][1] = (vec2(-8.0, 5.0));
	var[0][0][2][0] = (vec2(-4.0, 5.0));
	var[0][0][2][1] = (vec2(-2.0, 9.0));
	var[0][1][0][0] = (vec2(7.0, 0.0));
	var[0][1][0][1] = (vec2(2.0, 4.0));
	var[0][1][1][0] = (vec2(-7.0, -5.0));
	var[0][1][1][1] = (vec2(-7.0, 8.0));
	var[0][1][2][0] = (vec2(2.0, 1.0));
	var[0][1][2][1] = (vec2(-1.0, 9.0));
	var[1][0][0][0] = (vec2(-9.0, -1.0));
	var[1][0][0][1] = (vec2(6.0, -4.0));
	var[1][0][1][0] = (vec2(7.0, -8.0));
	var[1][0][1][1] = (vec2(1.0, 4.0));
	var[1][0][2][0] = (vec2(-4.0, 6.0));
	var[1][0][2][1] = (vec2(-5.0, 4.0));
	var[1][1][0][0] = (vec2(0.0, -8.0));
	var[1][1][0][1] = (vec2(-9.0, -2.0));
	var[1][1][1][0] = (vec2(7.0, 8.0));
	var[1][1][1][1] = (vec2(2.0, -3.0));
	var[1][1][2][0] = (vec2(-3.0, 7.0));
	var[1][1][2][1] = (vec2(-2.0, 4.0));
	var[2][0][0][0] = (vec2(-3.0, 6.0));
	var[2][0][0][1] = (vec2(7.0, -7.0));
	var[2][0][1][0] = (vec2(-9.0, 5.0));
	var[2][0][1][1] = (vec2(0.0, 9.0));
	var[2][0][2][0] = (vec2(2.0, 1.0));
	var[2][0][2][1] = (vec2(-6.0, 8.0));
	var[2][1][0][0] = (vec2(-2.0, 6.0));
	var[2][1][0][1] = (vec2(1.0, -2.0));
	var[2][1][1][0] = (vec2(-8.0, 9.0));
	var[2][1][1][1] = (vec2(1.0, 3.0));
	var[2][1][2][0] = (vec2(4.0, -1.0));
	var[2][1][2][1] = (vec2(5.0, 2.0));
	var[3][0][0][0] = (vec2(-8.0, 5.0));
	var[3][0][0][1] = (vec2(-5.0, -5.0));
	var[3][0][1][0] = (vec2(4.0, 5.0));
	var[3][0][1][1] = (vec2(0.0, 6.0));
	var[3][0][2][0] = (vec2(9.0, 5.0));
	var[3][0][2][1] = (vec2(-8.0, 7.0));
	var[3][1][0][0] = (vec2(-6.0, 7.0));
	var[3][1][0][1] = (vec2(-4.0, 5.0));
	var[3][1][1][0] = (vec2(3.0, 9.0));
	var[3][1][1][1] = (vec2(-9.0, 7.0));
	var[3][1][2][0] = (vec2(1.0, -5.0));
	var[3][1][2][1] = (vec2(-7.0, 9.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[0][1][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[0][1][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[0][2][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	var[0][2][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	var[0][3][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	var[0][3][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	var[1][0][0] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[1][0][1] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[1][1][0] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[1][1][1] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[1][2][0] = (mat2(5.0, -4.0, 3.0, 8.0));
	var[1][2][1] = (mat2(0.0, -2.0, 7.0, 4.0));
	var[1][3][0] = (mat2(1.0, -5.0, -9.0, -7.0));
	var[1][3][1] = (mat2(-6.0, 7.0, 4.0, 1.0));
	var[2][0][0] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[2][0][1] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[2][1][0] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[2][1][1] = (mat2(5.0, 8.0, -2.0, 4.0));
	var[2][2][0] = (mat2(4.0, -4.0, 0.0, 7.0));
	var[2][2][1] = (mat2(-7.0, 7.0, -1.0, 4.0));
	var[2][3][0] = (mat2(-8.0, 7.0, -5.0, -1.0));
	var[2][3][1] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	var[0][1][0][0] = (vec3(5.0, 9.0, -7.0));
	var[0][1][0][1] = (vec3(1.0, -3.0, -7.0));
	var[0][1][0][2] = (vec3(-5.0, 4.0, 1.0));
	var[0][1][1][0] = (vec3(-3.0, -5.0, -8.0));
	var[0][1][1][1] = (vec3(-5.0, 6.0, 2.0));
	var[0][1][1][2] = (vec3(-9.0, -9.0, -1.0));
	var[0][2][0][0] = (vec3(-4.0, 8.0, 7.0));
	var[0][2][0][1] = (vec3(1.0, 7.0, -5.0));
	var[0][2][0][2] = (vec3(7.0, 9.0, 4.0));
	var[0][2][1][0] = (vec3(-2.0, 2.0, 1.0));
	var[0][2][1][1] = (vec3(-8.0, -6.0, 7.0));
	var[0][2][1][2] = (vec3(-3.0, 2.0, -5.0));
	var[0][3][0][0] = (vec3(3.0, 3.0, 8.0));
	var[0][3][0][1] = (vec3(1.0, -2.0, 0.0));
	var[0][3][0][2] = (vec3(-9.0, 5.0, 1.0));
	var[0][3][1][0] = (vec3(-2.0, 0.0, 0.0));
	var[0][3][1][1] = (vec3(-3.0, 7.0, -8.0));
	var[0][3][1][2] = (vec3(0.0, 1.0, -3.0));
	var[1][0][0][0] = (vec3(-5.0, -3.0, -3.0));
	var[1][0][0][1] = (vec3(3.0, -5.0, -4.0));
	var[1][0][0][2] = (vec3(-7.0, 5.0, 3.0));
	var[1][0][1][0] = (vec3(-8.0, 7.0, 8.0));
	var[1][0][1][1] = (vec3(8.0, 2.0, -9.0));
	var[1][0][1][2] = (vec3(-3.0, 6.0, -3.0));
	var[1][1][0][0] = (vec3(2.0, 8.0, -8.0));
	var[1][1][0][1] = (vec3(-6.0, 0.0, 3.0));
	var[1][1][0][2] = (vec3(9.0, -8.0, 3.0));
	var[1][1][1][0] = (vec3(-9.0, 9.0, 2.0));
	var[1][1][1][1] = (vec3(6.0, -4.0, -8.0));
	var[1][1][1][2] = (vec3(3.0, 8.0, 1.0));
	var[1][2][0][0] = (vec3(-6.0, 6.0, -7.0));
	var[1][2][0][1] = (vec3(1.0, 3.0, -7.0));
	var[1][2][0][2] = (vec3(6.0, -8.0, 4.0));
	var[1][2][1][0] = (vec3(-3.0, -8.0, 3.0));
	var[1][2][1][1] = (vec3(-5.0, -8.0, 8.0));
	var[1][2][1][2] = (vec3(7.0, 2.0, -3.0));
	var[1][3][0][0] = (vec3(-7.0, 1.0, 4.0));
	var[1][3][0][1] = (vec3(-2.0, -1.0, -5.0));
	var[1][3][0][2] = (vec3(-1.0, 4.0, -2.0));
	var[1][3][1][0] = (vec3(-9.0, -3.0, 6.0));
	var[1][3][1][1] = (vec3(-4.0, 8.0, 0.0));
	var[1][3][1][2] = (vec3(-5.0, -4.0, 2.0));
	var[2][0][0][0] = (vec3(7.0, -3.0, 6.0));
	var[2][0][0][1] = (vec3(-7.0, 6.0, -7.0));
	var[2][0][0][2] = (vec3(2.0, 3.0, -3.0));
	var[2][0][1][0] = (vec3(-1.0, -5.0, -1.0));
	var[2][0][1][1] = (vec3(8.0, 4.0, -3.0));
	var[2][0][1][2] = (vec3(8.0, -6.0, 4.0));
	var[2][1][0][0] = (vec3(-9.0, -5.0, -7.0));
	var[2][1][0][1] = (vec3(-4.0, -1.0, -4.0));
	var[2][1][0][2] = (vec3(-6.0, 4.0, 9.0));
	var[2][1][1][0] = (vec3(-3.0, -9.0, 0.0));
	var[2][1][1][1] = (vec3(-9.0, -5.0, -9.0));
	var[2][1][1][2] = (vec3(-1.0, -9.0, 7.0));
	var[2][2][0][0] = (vec3(3.0, -1.0, -6.0));
	var[2][2][0][1] = (vec3(-1.0, 6.0, 7.0));
	var[2][2][0][2] = (vec3(9.0, -1.0, 2.0));
	var[2][2][1][0] = (vec3(-9.0, -6.0, 9.0));
	var[2][2][1][1] = (vec3(4.0, 9.0, 5.0));
	var[2][2][1][2] = (vec3(5.0, 4.0, -9.0));
	var[2][3][0][0] = (vec3(-8.0, 0.0, -8.0));
	var[2][3][0][1] = (vec3(-8.0, 8.0, 0.0));
	var[2][3][0][2] = (vec3(-8.0, -6.0, -9.0));
	var[2][3][1][0] = (vec3(1.0, 3.0, 8.0));
	var[2][3][1][1] = (vec3(-2.0, 9.0, -6.0));
	var[2][3][1][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[0][1][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[0][1][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[0][1][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[0][1][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[0][2][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	var[0][2][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	var[0][2][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	var[0][2][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	var[0][3][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	var[0][3][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	var[0][3][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	var[0][3][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	var[1][0][0][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[1][0][0][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[1][0][1][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[1][0][1][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[1][1][0][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[1][1][0][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[1][1][1][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[1][1][1][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[1][2][0][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	var[1][2][0][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	var[1][2][1][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	var[1][2][1][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	var[1][3][0][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	var[1][3][0][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	var[1][3][1][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	var[1][3][1][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	var[2][0][0][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[2][0][0][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[2][0][1][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[2][0][1][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[2][1][0][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[2][1][0][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[2][1][1][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[2][1][1][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	var[2][2][0][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	var[2][2][0][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	var[2][2][1][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	var[2][2][1][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	var[2][3][0][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	var[2][3][0][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	var[2][3][1][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	var[2][3][1][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[0][1][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	var[0][1][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	var[0][2][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	var[0][2][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	var[0][3][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	var[0][3][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	var[1][0][0] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	var[1][0][1] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	var[1][1][0] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	var[1][1][1] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	var[1][2][0] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	var[1][2][1] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	var[1][3][0] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	var[1][3][1] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	var[2][0][0] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	var[2][0][1] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	var[2][1][0] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	var[2][1][1] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	var[2][2][0] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	var[2][2][1] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	var[2][3][0] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	var[2][3][1] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-3, -3, -8)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-9.0, 1.0, 3.0, -3.0, -7.0, 8.0, -8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(2.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(6.0, 9.0, 6.0, -5.0, -9.0, -5.0, -6.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(-8, -4, -8)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(5.0, -9.0, -1.0, 7.0, -9.0, -8.0, -4.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(8.0, 5.0, -9.0, -8.0, 2.0, 3.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(-6.0, 3.0, -8.0, 4.0, 5.0, 6.0, 2.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(-4.0, -9.0, -8.0, -2.0, -8.0, -9.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(2.0, -5.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a = (mat3(6.0, -5.0, 3.0, -7.0, 0.0, -5.0, 0.0, 7.0, 8.0));
	t.b.a = (ivec3(4, 8, 8));
	t.b.b[0] = (mat3(-5.0, 2.0, -2.0, 7.0, 2.0, -2.0, 0.0, -8.0, 5.0));
	t.b.b[1] = (mat3(3.0, -5.0, 1.0, -7.0, -3.0, 2.0, -6.0, -6.0, -5.0));
	t.b.b[2] = (mat3(-6.0, 9.0, -8.0, -1.0, 8.0, 1.0, -1.0, -9.0, -6.0));
	t.b.b[3] = (mat3(-8.0, -7.0, -3.0, 1.0, -4.0, 3.0, 5.0, 7.0, -1.0));
	t.b.c = (vec4(7.0, 1.0, -2.0, 8.0));
	u = (2u);
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-8, 6, -5)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-9.0, -4.0, 2.0, -6.0, 5.0, -9.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-7.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(0.0, 5.0, -2.0, 8.0, 4.0, -7.0, 5.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(0, -8, 5)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(-2.0, 8.0, 6.0, -9.0, 9.0, -7.0, -6.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(-9.0, 4.0, 2.0, -3.0, -2.0, 1.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(5.0, -6.0, 8.0, -9.0, 0.0, 6.0, 9.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(-8.0, -3.0, -7.0, 3.0, 4.0, -6.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(3.0, 7.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a[0] = (vec3(9.0, -1.0, -4.0));
	t.a[1] = (vec3(4.0, -7.0, 5.0));
	t.a[2] = (vec3(5.0, -7.0, 4.0));
	t.b.a = (ivec3(-7, 1, 6));
	t.b.b[0][0] = (vec3(8.0, 9.0, 5.0));
	t.b.b[0][1] = (vec3(6.0, -7.0, -9.0));
	t.b.b[0][2] = (vec3(1.0, 2.0, 5.0));
	t.b.b[1][0] = (vec3(0.0, 0.0, -1.0));
	t.b.b[1][1] = (vec3(9.0, -1.0, -2.0));
	t.b.b[1][2] = (vec3(1.0, -2.0, -4.0));
	t.b.b[2][0] = (vec3(-7.0, -9.0, -8.0));
	t.b.b[2][1] = (vec3(-3.0, -1.0, 7.0));
	t.b.b[2][2] = (vec3(-7.0, -1.0, -6.0));
	t.b.b[3][0] = (vec3(-5.0, 9.0, 2.0));
	t.b.b[3][1] = (vec3(-8.0, -5.0, -7.0));
	t.b.b[3][2] = (vec3(-6.0, 3.0, -4.0));
	t.b.c = (vec4(-9.0, 8.0, 1.0, 4.0));
	u = (7u);
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(-5.0, -4.0, 8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(6, 9, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(5, -4)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(-1, -5)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(-4, 9)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-7.0, 2.0, 7.0, -1.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(8, -5, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(8, 2)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(-2, 4)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-3.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-8, 9, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(8.0, 1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-2.0, 8.0, -8.0, -7.0, 8.0, -2.0, -6.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(9, -7, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(5, 0)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(4, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-6, -8)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-5.0, 4.0, 0.0, 6.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(0, 4, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(-2, 9)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(-8, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(-8, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(4, 9)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(0.0, -6.0, 6.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(3, 9, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-3, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(-4, 3)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_uint((u), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-1, 0, 1));
	s.b[0] = (ivec2(6, -6));
	s.b[1] = (ivec2(5, 6));
	s.b[2] = (ivec2(-9, 8));
	s.b[3] = (ivec2(1, 4));
	s.c = (vec4(-5.0, 1.0, 8.0, -2.0));
	u = (6u);
}
#version 450
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
	allOk = compare_uvec2((s[0].a), uvec2(6u, 9u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(-2.0, -7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(7.0, 8.0, -1.0, -2.0, -1.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(-3.0, 2.0, 8.0, 9.0, -8.0, -7.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(0.0, 9.0, 9.0, -8.0, 1.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(-2.0, 0.0, -1.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(2.0, -9.0, 7.0, -4.0, -9.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(2.0, 2.0, -7.0, -7.0, -6.0, -7.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(6.0, -3.0, 5.0, 2.0, -4.0, 7.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(-4.0, 5.0, -3.0, 5.0, 5.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(-2.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(2u, 9u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(1.0, -9.0, -3.0, -8.0, -7.0, -3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(8.0, 3.0, -7.0, 6.0, 0.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(-6.0, 8.0, 1.0, -8.0, -3.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(-4.0, -5.0, -6.0, 2.0, -2.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(7.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(-1.0, 5.0, 4.0, -8.0, -4.0, 1.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(-4.0, -5.0, 4.0, 2.0, 8.0, -8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(6.0, -7.0, -8.0, 8.0, 0.0, -6.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(-1.0, -6.0, 4.0, -1.0, 0.0, 7.0, -9.0, 5.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(6.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (9u);
	s[0].a = (uvec2(1u, 5u));
	s[0].b[0][0] = (vec4(-7.0, 9.0, -3.0, 9.0));
	s[0].b[0][1] = (vec4(8.0, 4.0, 0.0, -6.0));
	s[0].b[1][0] = (vec4(-4.0, -6.0, 7.0, -5.0));
	s[0].b[1][1] = (vec4(4.0, -2.0, 4.0, -1.0));
	s[0].b[2][0] = (vec4(-1.0, 6.0, 6.0, -5.0));
	s[0].b[2][1] = (vec4(-5.0, 3.0, -6.0, 5.0));
	s[0].b[3][0] = (vec4(2.0, 2.0, -9.0, -5.0));
	s[0].b[3][1] = (vec4(-5.0, 1.0, -2.0, 9.0));
	s[0].c = (vec3(-9.0, -5.0, -2.0));
	s[1].a = (uvec2(2u, 6u));
	s[1].b[0][0] = (vec4(-9.0, 4.0, 1.0, 6.0));
	s[1].b[0][1] = (vec4(5.0, 4.0, 1.0, -8.0));
	s[1].b[1][0] = (vec4(-1.0, -3.0, -7.0, -7.0));
	s[1].b[1][1] = (vec4(-4.0, -4.0, 6.0, -7.0));
	s[1].b[2][0] = (vec4(-1.0, -7.0, -2.0, 0.0));
	s[1].b[2][1] = (vec4(-2.0, 5.0, 2.0, 7.0));
	s[1].b[3][0] = (vec4(-6.0, 0.0, 2.0, 9.0));
	s[1].b[3][1] = (vec4(6.0, -7.0, 4.0, -3.0));
	s[1].c = (vec3(-7.0, 8.0, -7.0));
	s[2].a = (uvec2(8u, 8u));
	s[2].b[0][0] = (vec4(5.0, -3.0, 0.0, 9.0));
	s[2].b[0][1] = (vec4(0.0, 8.0, 7.0, -6.0));
	s[2].b[1][0] = (vec4(0.0, 5.0, -8.0, 1.0));
	s[2].b[1][1] = (vec4(4.0, 1.0, 3.0, -2.0));
	s[2].b[2][0] = (vec4(-7.0, -3.0, -3.0, -3.0));
	s[2].b[2][1] = (vec4(6.0, 4.0, 4.0, 1.0));
	s[2].b[3][0] = (vec4(-6.0, -1.0, -3.0, -2.0));
	s[2].b[3][1] = (vec4(-6.0, 8.0, -8.0, 0.0));
	s[2].c = (vec3(-6.0, 7.0, -6.0));
	s[3].a = (uvec2(7u, 9u));
	s[3].b[0][0] = (vec4(4.0, 1.0, -6.0, 7.0));
	s[3].b[0][1] = (vec4(-8.0, -1.0, 1.0, 2.0));
	s[3].b[1][0] = (vec4(-2.0, -9.0, 4.0, -7.0));
	s[3].b[1][1] = (vec4(-3.0, -6.0, 4.0, 3.0));
	s[3].b[2][0] = (vec4(-1.0, 3.0, 8.0, 7.0));
	s[3].b[2][1] = (vec4(-3.0, -4.0, 7.0, -5.0));
	s[3].b[3][0] = (vec4(-1.0, 6.0, 5.0, 1.0));
	s[3].b[3][1] = (vec4(8.0, 8.0, -2.0, -8.0));
	s[3].c = (vec3(9.0, 5.0, -7.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(2.0, -3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 7.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(5.0, -4.0));
	block[0].var[1] = (vec2(5.0, 1.0));
	block[1].var[0] = (vec2(-8.0, -1.0));
	block[1].var[1] = (vec2(9.0, -8.0));
	block[2].var[0] = (vec2(5.0, -4.0));
	block[2].var[1] = (vec2(5.0, -2.0));
}
#version 450
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
	highp mat4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(5.0, 8.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(6.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(6.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-6.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(1.0, 8.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-2.0, -9.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-1.0, -6.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-2.0, 9.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(4.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(9.0, -4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block[1].var = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block[2].var = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
}
#version 450
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
} block[3];

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block[0].padding), true) && allOk;
	allOk = compare_bvec2((block[0].var), bvec2(true, true)) && allOk;
	allOk = compare_bool((block[1].padding), true) && allOk;
	allOk = compare_bvec2((block[1].var), bvec2(false, true)) && allOk;
	allOk = compare_bool((block[2].padding), false) && allOk;
	allOk = compare_bvec2((block[2].var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (true);
	block[0].var = (bvec2(false, true));
	block[1].padding = (true);
	block[1].var = (bvec2(false, false));
	block[2].padding = (false);
	block[2].var = (bvec2(false, false));
}
#version 450
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
	allOk = compare_float((block[0].padding), -9.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -4.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-6.0, 9.0, -3.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-4.0, 5.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-2.0, 4.0, 2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block[0].var[1] = (vec4(4.0, -6.0, 2.0, -5.0));
	block[1].padding = (1.0);
	block[1].var[0] = (vec4(1.0, 6.0, 1.0, 8.0));
	block[1].var[1] = (vec4(7.0, 0.0, 9.0, -6.0));
	block[2].padding = (6.0);
	block[2].var[0] = (vec4(5.0, 5.0, -6.0, -8.0));
	block[2].var[1] = (vec4(-7.0, -4.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -4.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -6.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(6.0, -6.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-1.0, 1.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(0.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	block[1].padding = (8.0);
	block[1].var = (mat4x2(2.0, -6.0, 3.0, 8.0, -8.0, 8.0, 3.0, -3.0));
	block[2].padding = (-2.0);
	block[2].var = (mat4x2(-1.0, 6.0, 9.0, -5.0, -9.0, -1.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_float((blockA.a), -8.0) && allOk;
	allOk = compare_uint((blockB.b.a), 0u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(0, 5)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-2.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (2.0);
	blockA.b.a[0] = (vec3(-3.0, 7.0, 0.0));
	blockA.b.a[1] = (vec3(-9.0, 6.0, 1.0));
	blockA.b.a[2] = (vec3(-9.0, -8.0, -6.0));
	blockA.b.b[0] = (ivec2(5, 4));
	blockA.b.b[1] = (ivec2(-2, -8));
	blockA.b.b[2] = (ivec2(3, 7));
	blockA.b.b[3] = (ivec2(-4, -3));
	blockA.b.c = (vec4(-3.0, -4.0, 2.0, -2.0));
	blockB.a[0] = (vec2(-2.0, -5.0));
	blockB.a[1] = (vec2(-2.0, 3.0));
	blockB.b.a = (4u);
	blockB.b.b.a[0] = (vec3(5.0, 8.0, 0.0));
	blockB.b.b.a[1] = (vec3(4.0, -4.0, -7.0));
	blockB.b.b.a[2] = (vec3(-7.0, 1.0, 5.0));
	blockB.b.b.b[0] = (ivec2(2, 0));
	blockB.b.b.b[1] = (ivec2(-9, -6));
	blockB.b.b.b[2] = (ivec2(-7, -7));
	blockB.b.b.b[3] = (ivec2(9, -1));
	blockB.b.b.c = (vec4(-4.0, 4.0, -7.0, 5.0));
	blockB.b.c = (bvec4(false, true, true, false));
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
	lowp int a[][8];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a[0][0]), -5) && allOk;
	allOk = compare_int((a[0][1]), -9) && allOk;
	allOk = compare_int((a[0][2]), -7) && allOk;
	allOk = compare_int((a[0][3]), 9) && allOk;
	allOk = compare_int((a[0][4]), -1) && allOk;
	allOk = compare_int((a[0][5]), 0) && allOk;
	allOk = compare_int((a[0][6]), -3) && allOk;
	allOk = compare_int((a[0][7]), 9) && allOk;
	allOk = compare_int((a[1][0]), -2) && allOk;
	allOk = compare_int((a[1][1]), 0) && allOk;
	allOk = compare_int((a[1][2]), 3) && allOk;
	allOk = compare_int((a[1][3]), -3) && allOk;
	allOk = compare_int((a[1][4]), 2) && allOk;
	allOk = compare_int((a[1][5]), -3) && allOk;
	allOk = compare_int((a[1][6]), 8) && allOk;
	allOk = compare_int((a[1][7]), 8) && allOk;
	allOk = compare_int((a[2][0]), -3) && allOk;
	allOk = compare_int((a[2][1]), 8) && allOk;
	allOk = compare_int((a[2][2]), 5) && allOk;
	allOk = compare_int((a[2][3]), -7) && allOk;
	allOk = compare_int((a[2][4]), -3) && allOk;
	allOk = compare_int((a[2][5]), -9) && allOk;
	allOk = compare_int((a[2][6]), 5) && allOk;
	allOk = compare_int((a[2][7]), -9) && allOk;
	allOk = compare_int((a[3][0]), 7) && allOk;
	allOk = compare_int((a[3][1]), 4) && allOk;
	allOk = compare_int((a[3][2]), 6) && allOk;
	allOk = compare_int((a[3][3]), 7) && allOk;
	allOk = compare_int((a[3][4]), -8) && allOk;
	allOk = compare_int((a[3][5]), 9) && allOk;
	allOk = compare_int((a[3][6]), 7) && allOk;
	allOk = compare_int((a[3][7]), -2) && allOk;
	allOk = compare_int((a[4][0]), -8) && allOk;
	allOk = compare_int((a[4][1]), 6) && allOk;
	allOk = compare_int((a[4][2]), -3) && allOk;
	allOk = compare_int((a[4][3]), -8) && allOk;
	allOk = compare_int((a[4][4]), -7) && allOk;
	allOk = compare_int((a[4][5]), -2) && allOk;
	allOk = compare_int((a[4][6]), -8) && allOk;
	allOk = compare_int((a[4][7]), -1) && allOk;
	allOk = compare_int((a[5][0]), -9) && allOk;
	allOk = compare_int((a[5][1]), 1) && allOk;
	allOk = compare_int((a[5][2]), 3) && allOk;
	allOk = compare_int((a[5][3]), -6) && allOk;
	allOk = compare_int((a[5][4]), -8) && allOk;
	allOk = compare_int((a[5][5]), 0) && allOk;
	allOk = compare_int((a[5][6]), 3) && allOk;
	allOk = compare_int((a[5][7]), -8) && allOk;
	allOk = compare_int((a[6][0]), -3) && allOk;
	allOk = compare_int((a[6][1]), -6) && allOk;
	allOk = compare_int((a[6][2]), -9) && allOk;
	allOk = compare_int((a[6][3]), 0) && allOk;
	allOk = compare_int((a[6][4]), 9) && allOk;
	allOk = compare_int((a[6][5]), 0) && allOk;
	allOk = compare_int((a[6][6]), -4) && allOk;
	allOk = compare_int((a[6][7]), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0][0] = (-7);
	a[0][1] = (4);
	a[0][2] = (-4);
	a[0][3] = (-7);
	a[0][4] = (-3);
	a[0][5] = (-9);
	a[0][6] = (1);
	a[0][7] = (2);
	a[1][0] = (8);
	a[1][1] = (-2);
	a[1][2] = (5);
	a[1][3] = (-7);
	a[1][4] = (-5);
	a[1][5] = (-9);
	a[1][6] = (-9);
	a[1][7] = (-7);
	a[2][0] = (3);
	a[2][1] = (1);
	a[2][2] = (2);
	a[2][3] = (-4);
	a[2][4] = (-6);
	a[2][5] = (7);
	a[2][6] = (1);
	a[2][7] = (9);
	a[3][0] = (1);
	a[3][1] = (3);
	a[3][2] = (9);
	a[3][3] = (6);
	a[3][4] = (4);
	a[3][5] = (-5);
	a[3][6] = (-6);
	a[3][7] = (2);
	a[4][0] = (8);
	a[4][1] = (0);
	a[4][2] = (6);
	a[4][3] = (5);
	a[4][4] = (6);
	a[4][5] = (-3);
	a[4][6] = (-8);
	a[4][7] = (8);
	a[5][0] = (-8);
	a[5][1] = (-6);
	a[5][2] = (-5);
	a[5][3] = (0);
	a[5][4] = (0);
	a[5][5] = (2);
	a[5][6] = (-1);
	a[5][7] = (-4);
	a[6][0] = (-3);
	a[6][1] = (0);
	a[6][2] = (5);
	a[6][3] = (-3);
	a[6][4] = (7);
	a[6][5] = (4);
	a[6][6] = (0);
	a[6][7] = (-3);
}
#version 450
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
	mediump vec4 mB;
	bvec2 mC;
};
struct sB
{
	highp mat4x3 mA;
	mediump vec3 mB;
};
struct sC
{
	lowp mat4 mA;
	mediump vec4 mB;
	lowp uvec4 mC;
};
struct sD
{
	highp int mA;
	sC mB;
	lowp float mC[7];
};
layout(std430, column_major, binding = 1) readonly buffer BlockB
{
	sA a;
	sB b[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp mat3 c;
	mediump vec4 d;
	highp mat3x4 e[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bvec2 f;
	mediump mat3x2 g;
	sD h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(b[0].mA, mat4x3(9.0, -2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0, 2.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec3((b[0].mB), vec3(-8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(b[1].mA, mat4x3(0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3((b[1].mB), vec3(8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(b[2].mA, mat4x3(-4.0, 3.0, 5.0, 9.0, -3.0, -6.0, 6.0, 6.0, 0.0, 1.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((b[2].mB), vec3(-7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(b[3].mA, mat4x3(-2.0, -3.0, 0.0, -4.0, 4.0, 0.0, 9.0, -5.0, 7.0, -4.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((b[3].mB), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.d), vec4(-9.0, -7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.e[0], mat3x4(6.0, 7.0, 5.0, 7.0, 6.0, 8.0, -4.0, -8.0, 8.0, 4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(g, mat3x2(-1.0, 3.0, -4.0, -9.0, 4.0, -7.0)) && allOk;
	allOk = compare_int((h[0].mA), -3) && allOk;
	allOk = compare_mat4(h[0].mB.mA, mat4(5.0, 1.0, -9.0, -8.0, -9.0, -3.0, 3.0, -7.0, -6.0, -3.0, 3.0, -1.0, 0.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((h[0].mB.mB), vec4(-5.0, -9.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec4((h[0].mB.mC), uvec4(2u, 9u, 7u, 2u)) && allOk;
	allOk = compare_float((h[0].mC[0]), -2.0) && allOk;
	allOk = compare_float((h[0].mC[1]), -2.0) && allOk;
	allOk = compare_float((h[0].mC[2]), 6.0) && allOk;
	allOk = compare_float((h[0].mC[3]), -5.0) && allOk;
	allOk = compare_float((h[0].mC[4]), -2.0) && allOk;
	allOk = compare_float((h[0].mC[5]), -5.0) && allOk;
	allOk = compare_float((h[0].mC[6]), -3.0) && allOk;
	allOk = compare_int((h[1].mA), 2) && allOk;
	allOk = compare_mat4(h[1].mB.mA, mat4(4.0, -7.0, -1.0, 4.0, -2.0, 8.0, -4.0, 8.0, 3.0, -8.0, 5.0, -9.0, 3.0, 9.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4((h[1].mB.mB), vec4(8.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_uvec4((h[1].mB.mC), uvec4(1u, 8u, 6u, 8u)) && allOk;
	allOk = compare_float((h[1].mC[0]), 4.0) && allOk;
	allOk = compare_float((h[1].mC[1]), 3.0) && allOk;
	allOk = compare_float((h[1].mC[2]), 2.0) && allOk;
	allOk = compare_float((h[1].mC[3]), 9.0) && allOk;
	allOk = compare_float((h[1].mC[4]), -3.0) && allOk;
	allOk = compare_float((h[1].mC[5]), 4.0) && allOk;
	allOk = compare_float((h[1].mC[6]), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (mat3(6.0, -6.0, 0.0, 7.0, -7.0, 4.0, -4.0, -8.0, 1.0));
	blockC.d = (vec4(-6.0, 7.0, -7.0, 7.0));
	blockC.e[0] = (mat3x4(-2.0, 2.0, 2.0, 4.0, -9.0, 9.0, -2.0, -4.0, -3.0, 7.0, 8.0, -4.0));
	f = (bvec2(false, false));
	h[0].mA = (-2);
	h[0].mB.mA = (mat4(1.0, 2.0, -8.0, 0.0, 6.0, -1.0, 1.0, -3.0, 7.0, -9.0, 3.0, -1.0, 0.0, 8.0, -9.0, -5.0));
	h[0].mB.mB = (vec4(-2.0, -3.0, 4.0, -7.0));
	h[0].mB.mC = (uvec4(7u, 9u, 4u, 6u));
	h[0].mC[0] = (-2.0);
	h[0].mC[1] = (-5.0);
	h[0].mC[2] = (9.0);
	h[0].mC[3] = (-8.0);
	h[0].mC[4] = (8.0);
	h[0].mC[5] = (-5.0);
	h[0].mC[6] = (5.0);
	h[1].mA = (2);
	h[1].mB.mA = (mat4(5.0, 1.0, -1.0, -9.0, -5.0, -1.0, 2.0, -4.0, -1.0, -8.0, -3.0, 3.0, 3.0, 8.0, 2.0, -9.0));
	h[1].mB.mB = (vec4(-6.0, 8.0, 5.0, 2.0));
	h[1].mB.mC = (uvec4(5u, 1u, 1u, 9u));
	h[1].mC[0] = (-7.0);
	h[1].mC[1] = (-4.0);
	h[1].mC[2] = (3.0);
	h[1].mC[3] = (4.0);
	h[1].mC[4] = (-1.0);
	h[1].mC[5] = (6.0);
	h[1].mC[6] = (1.0);
}
#version 450
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
};
struct sB
{
	highp ivec3 mA;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	bvec4 b;
	sB c;
	lowp uvec3 d[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump vec4 e;
	mediump mat3x2 f;
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump mat3x4 g[1][7];
	mediump uvec2 h;
	lowp uint i;
	mediump mat4x2 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((d[0]), uvec3(1u, 5u, 2u)) && allOk;
	allOk = compare_uvec3((d[1]), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((d[2]), uvec3(0u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((d[3]), uvec3(8u, 9u, 8u)) && allOk;
	allOk = compare_uvec3((d[4]), uvec3(9u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((d[5]), uvec3(2u, 9u, 7u)) && allOk;
	allOk = compare_uvec3((d[6]), uvec3(9u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((d[7]), uvec3(6u, 5u, 7u)) && allOk;
	allOk = compare_vec4((blockC[0].e), vec4(-3.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC[1].e), vec4(-5.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[0][0], mat3x4(-1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[0][1], mat3x4(2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0, -7.0, -8.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[0][2], mat3x4(-4.0, -9.0, 2.0, -4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[0][3], mat3x4(-7.0, -8.0, -7.0, -3.0, 3.0, 2.0, -8.0, -1.0, -7.0, 0.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[0][4], mat3x4(4.0, -3.0, 7.0, -5.0, 1.0, 8.0, 0.0, -3.0, -8.0, 6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[0][5], mat3x4(8.0, 8.0, -5.0, 4.0, 9.0, -1.0, -4.0, 2.0, 4.0, 4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[0][6], mat3x4(4.0, 8.0, -9.0, -8.0, 6.0, -4.0, -4.0, -2.0, 5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	c.mA = (ivec3(-8, -4, -6));
	blockC[0].e = (vec4(0.0, 7.0, 6.0, 5.0));
	blockC[0].f = (mat3x2(3.0, 3.0, -4.0, -6.0, 4.0, 2.0));
	blockC[1].e = (vec4(-6.0, 7.0, -8.0, 5.0));
	blockC[1].f = (mat3x2(6.0, 8.0, 9.0, 0.0, -7.0, -6.0));
	blockD.g[0][0] = (mat3x4(-3.0, 8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0, 8.0, -6.0, 1.0));
	blockD.g[0][1] = (mat3x4(8.0, -5.0, 4.0, 8.0, 5.0, -5.0, -7.0, -3.0, -6.0, 4.0, -9.0, 5.0));
	blockD.g[0][2] = (mat3x4(1.0, -9.0, 6.0, -7.0, -8.0, -2.0, 6.0, 4.0, -3.0, 4.0, 9.0, -8.0));
	blockD.g[0][3] = (mat3x4(-8.0, 5.0, -9.0, -3.0, -3.0, -3.0, -1.0, -6.0, 6.0, 4.0, -3.0, 8.0));
	blockD.g[0][4] = (mat3x4(5.0, -7.0, -6.0, 0.0, -5.0, -7.0, 4.0, -8.0, -7.0, -7.0, -5.0, -3.0));
	blockD.g[0][5] = (mat3x4(-7.0, -5.0, 3.0, -1.0, -5.0, -9.0, -2.0, -7.0, -6.0, 9.0, 4.0, 1.0));
	blockD.g[0][6] = (mat3x4(-6.0, 8.0, 6.0, -1.0, -4.0, -9.0, -4.0, -7.0, 9.0, 0.0, -3.0, 8.0));
	blockD.j[0] = (mat4x2(-1.0, -9.0, -6.0, -1.0, 9.0, -8.0, -2.0, -4.0));
}
#version 450
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
	mediump vec4 b;
	lowp ivec3 c;
	mediump mat3x4 d[];
} blockB;
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	lowp ivec2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(-9, 8, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
}
#version 450
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
	int16_t c;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	uint16_t d;
	int16_t e[1];
	mediump int f;
	f16vec2 g;
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp ivec4 h;
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	u16vec2 i;
	i16vec4 j;
	mediump ivec2 k;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.c), -2) && allOk;
	allOk = compare_uint16_t(uint(blockC.d), 7u) && allOk;
	allOk = compare_int16_t(int(blockC.e[0]), 9) && allOk;
	allOk = compare_int((blockC.f), -1) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.i), uvec2(4u, 4u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.j), ivec4(5, 6, 4, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(4u, 4u, 9u));
	blockB.c = int16_t(4);
	blockC.d = uint16_t(8u);
	blockC.e[0] = int16_t(-2);
	blockC.f = (-8);
	blockC.g = f16vec2(vec2(-6.0, 9.0));
	h = (ivec4(4, -5, 5, -1));
	blockE.i = u16vec2(uvec2(2u, 8u));
	blockE.j = i16vec4(ivec4(5, -6, 4, -3));
}
#version 450
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
	f16vec4 a;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	f16vec2 b;
	bvec3 c;
	f16vec3 d;
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	bvec3 e;
	mediump mat4 f;
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	mediump int g;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(a), vec4(1.0, -6.0, -5.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.b), vec2(2.0, -1.0)) && allOk;
	allOk = compare_int((blockE.g), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec4(vec4(9.0, 7.0, 5.0, -2.0));
	blockC.b = f16vec2(vec2(9.0, -6.0));
	blockC.c = (bvec3(false, true, false));
	blockC.d = f16vec3(vec3(-9.0, 0.0, 0.0));
	blockD.e = (bvec3(false, false, true));
	blockE.g = (-6);
}
#version 450
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
	lowp vec4 a;
	highp mat2x3 b;
	uint16_t c[];
};
layout(std140, binding = 2) buffer BlockC
{
	uint16_t d;
	i16vec3 e[3];
};
layout(std430, binding = 3) buffer BlockD
{
	lowp uint f[4];
	mediump vec3 g;
	lowp vec2 h;
	lowp uvec4 i;
	f16vec3 j[];
} blockD;
layout(std140, binding = 4) readonly buffer BlockE
{
	uint16_t k;
	float16_t l;
	u16vec2 m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(b, mat2x3(-1.0, -3.0, -2.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_uint16_t(uint(d), 4u) && allOk;
	allOk = compare_uint((blockD.f[0]), 3u) && allOk;
	allOk = compare_uint((blockD.f[1]), 0u) && allOk;
	allOk = compare_uint((blockD.f[2]), 3u) && allOk;
	allOk = compare_uint((blockD.f[3]), 4u) && allOk;
	allOk = compare_vec2((blockD.h), vec2(6.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(8u, 1u, 0u, 4u)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j[0]), vec3(-1.0, -9.0, 1.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[1]), uvec2(8u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[2]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[3]), uvec2(8u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[4]), uvec2(2u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[5]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[6]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.m[7]), uvec2(3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-7.0, 4.0, -4.0, -7.0));
	b = (mat2x3(-3.0, 1.0, 8.0, -9.0, 2.0, -2.0));
	c[0] = uint16_t(6u);
	c[1] = uint16_t(4u);
	c[2] = uint16_t(4u);
	c[3] = uint16_t(1u);
	c[4] = uint16_t(9u);
	c[5] = uint16_t(5u);
	d = uint16_t(2u);
	e[0] = i16vec3(ivec3(1, 2, -4));
	e[1] = i16vec3(ivec3(-6, 7, 1));
	e[2] = i16vec3(ivec3(9, 1, 3));
	blockD.f[0] = (3u);
	blockD.f[1] = (3u);
	blockD.f[2] = (8u);
	blockD.f[3] = (6u);
	blockD.h = (vec2(0.0, 6.0));
}
#version 450
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
	f16vec3 a;
	lowp vec4 b;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(9.0, -2.0, -3.0));
}
#version 450
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
	bvec2 a;
	bvec4 b;
	uint16_t c;
	bvec2 d[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bvec3 e;
	u16vec3 f[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	u16vec4 g;
	f16vec3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 8u) && allOk;
	allOk = compare_bvec2((blockB.d[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.d[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.d[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.d[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.d[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.d[5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((e), bvec3(true, false, true)) && allOk;
	allOk = compare_f16vec3(vec3(h[0]), vec3(3.0, 6.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(h[1]), vec3(9.0, -1.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(h[2]), vec3(-3.0, 3.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(h[3]), vec3(1.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = uint16_t(1u);
	blockB.d[0] = (bvec2(true, true));
	blockB.d[1] = (bvec2(true, false));
	blockB.d[2] = (bvec2(false, true));
	blockB.d[3] = (bvec2(false, false));
	blockB.d[4] = (bvec2(false, true));
	blockB.d[5] = (bvec2(true, false));
	e = (bvec3(false, false, false));
	f[0] = u16vec3(uvec3(0u, 9u, 7u));
	f[1] = u16vec3(uvec3(5u, 0u, 1u));
	f[2] = u16vec3(uvec3(6u, 6u, 4u));
	g = u16vec4(uvec4(1u, 9u, 4u, 5u));
	h[0] = f16vec3(vec3(1.0, 6.0, 5.0));
	h[1] = f16vec3(vec3(8.0, 5.0, -1.0));
	h[2] = f16vec3(vec3(-1.0, -1.0, 2.0));
	h[3] = f16vec3(vec3(-8.0, -1.0, -2.0));
}
#version 450
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
	lowp mat4 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp mat2x3 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	f16vec4 b;
	float16_t c[];
};
layout(std430, binding = 3) buffer BlockD
{
	sA d;
	mediump mat3 e[];
};
layout(std430, binding = 4) buffer BlockE
{
	highp vec4 f;
	i16vec4 g;
	mediump ivec2 h[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0], mat2x3(2.0, -8.0, -4.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_float16_t(float(c[0]), 5.0) && allOk;
	allOk = compare_mat3(e[0], mat3(1.0, 3.0, 6.0, -3.0, 8.0, 6.0, -4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(e[1], mat3(5.0, 8.0, -9.0, -5.0, -1.0, -8.0, 9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(e[2], mat3(5.0, -1.0, 1.0, 7.0, -7.0, -7.0, 7.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(e[3], mat3(2.0, 9.0, 1.0, 5.0, 3.0, -6.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(e[4], mat3(-5.0, 1.0, -3.0, -3.0, -1.0, -9.0, 5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(e[5], mat3(-4.0, 3.0, 2.0, -2.0, 8.0, 6.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(e[6], mat3(7.0, 5.0, 9.0, -1.0, 7.0, -5.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3(e[7], mat3(-9.0, -2.0, 6.0, 3.0, -2.0, 1.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec4((blockE.f), vec4(9.0, 5.0, -7.0, 7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.g), ivec4(0, 0, 0, -5)) && allOk;
	allOk = compare_ivec2((blockE.h[0]), ivec2(3, -8)) && allOk;
	allOk = compare_ivec2((blockE.h[1]), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((blockE.h[2]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((blockE.h[3]), ivec2(-4, 2)) && allOk;
	allOk = compare_ivec2((blockE.h[4]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((blockE.h[5]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockE.h[6]), ivec2(4, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat2x3(8.0, -2.0, -1.0, -6.0, 6.0, 0.0));
	c[0] = float16_t(6.0);
	e[0] = (mat3(6.0, -3.0, -6.0, 8.0, -6.0, -7.0, -1.0, 4.0, -7.0));
	e[1] = (mat3(2.0, -1.0, 4.0, -6.0, 5.0, -5.0, -1.0, -2.0, -3.0));
	e[2] = (mat3(-7.0, 8.0, -6.0, 7.0, 9.0, 8.0, -3.0, -4.0, 4.0));
	e[3] = (mat3(9.0, 0.0, 1.0, 2.0, -3.0, -9.0, -9.0, 0.0, -6.0));
	e[4] = (mat3(-8.0, 4.0, -1.0, -8.0, -9.0, 0.0, 0.0, 9.0, -9.0));
	e[5] = (mat3(4.0, 7.0, 6.0, 6.0, -5.0, -4.0, 3.0, -5.0, -2.0));
	e[6] = (mat3(0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0, 4.0));
	e[7] = (mat3(-1.0, 3.0, 8.0, -9.0, -7.0, -2.0, -2.0, -1.0, -6.0));
	blockE.f = (vec4(8.0, -5.0, -3.0, 5.0));
	blockE.g = i16vec4(ivec4(9, -5, -8, -9));
	blockE.h[0] = (ivec2(9, 5));
	blockE.h[1] = (ivec2(1, -7));
	blockE.h[2] = (ivec2(3, -7));
	blockE.h[3] = (ivec2(-4, -6));
	blockE.h[4] = (ivec2(5, 3));
	blockE.h[5] = (ivec2(-1, 0));
	blockE.h[6] = (ivec2(4, 4));
}
#version 450
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
layout(std430, row_major, binding = 1) buffer BlockB
{
	float16_t a[1];
	highp vec4 b;
	f16vec3 c;
	lowp uvec3 d;
	sA e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp uint f[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp float g[];
};
layout(std140, binding = 4) buffer BlockE
{
	i16vec3 h;
	bvec4 i;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a[0]), 0.0) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(0u, 8u, 1u)) && allOk;
	allOk = compare_int((blockB.e[0].mA), 6) && allOk;
	allOk = compare_int((blockB.e[1].mA), 2) && allOk;
	allOk = compare_int((blockB.e[2].mA), 3) && allOk;
	allOk = compare_int((blockB.e[3].mA), 3) && allOk;
	allOk = compare_int((blockB.e[4].mA), 3) && allOk;
	allOk = compare_int((blockB.e[5].mA), 5) && allOk;
	allOk = compare_int((blockB.e[6].mA), -5) && allOk;
	allOk = compare_float((g[0]), 9.0) && allOk;
	allOk = compare_float((g[1]), 8.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.h), ivec3(2, 4, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = float16_t(5.0);
	blockB.b = (vec4(-5.0, 3.0, 9.0, -5.0));
	blockB.c = f16vec3(vec3(-5.0, 0.0, -1.0));
	blockB.d = (uvec3(0u, 5u, 7u));
	blockB.e[0].mA = (-8);
	blockB.e[1].mA = (-4);
	blockB.e[2].mA = (8);
	blockB.e[3].mA = (6);
	blockB.e[4].mA = (-3);
	blockB.e[5].mA = (-7);
	blockB.e[6].mA = (-4);
	f[0] = (3u);
	f[1] = (5u);
	f[2] = (5u);
	f[3] = (3u);
	f[4] = (7u);
	f[5] = (4u);
	f[6] = (1u);
	g[0] = (7.0);
	g[1] = (9.0);
	blockE.h = i16vec3(ivec3(-8, -6, 4));
	blockE.i = (bvec4(false, false, false, false));
}
#version 450
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
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec4 b;
	layout(offset = 16) u16vec4 c;
	layout(offset = 32) mediump uvec4 d;
	layout(offset = 48) bvec2 e;
	layout(offset = 64) mediump vec3 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[0].a), ivec2(2, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[1].a), ivec2(-9, 3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[2].a), ivec2(0, -7)) && allOk;
	allOk = compare_uvec4((b), uvec4(6u, 5u, 8u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(c), uvec4(5u, 1u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((d), uvec4(0u, 5u, 2u, 3u)) && allOk;
	allOk = compare_vec3((f), vec3(1.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i16vec2(ivec2(8, 9));
	blockB[1].a = i16vec2(ivec2(-5, 5));
	blockB[2].a = i16vec2(ivec2(-4, 2));
	b = (uvec4(9u, 4u, 7u, 6u));
	d = (uvec4(8u, 8u, 0u, 8u));
	e = (bvec2(true, true));
	f = (vec3(4.0, -7.0, 5.0));
}
#version 450
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
	layout(offset = 0) i16vec3 a;
	layout(offset = 8) highp vec2 b;
	layout(offset = 16) i16vec2 c;
	layout(offset = 20) highp float d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) f16vec2 e[1];
	layout(offset = 4) int16_t f;
	layout(offset = 6) i16vec3 g;
	layout(offset = 16) mediump uvec3 h;
	layout(offset = 32) lowp vec3 i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(7.0, 2.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c), ivec2(-1, 4)) && allOk;
	allOk = compare_float((blockB.d), 1.0) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e[0]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec3((blockC.i), vec3(-4.0, 1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(9, 7, 5));
	blockB.b = (vec2(-2.0, 9.0));
	blockB.d = (2.0);
	blockC.e[0] = f16vec2(vec2(-4.0, -1.0));
	blockC.f = int16_t(-9);
	blockC.g = i16vec3(ivec3(0, 0, 6));
	blockC.h = (uvec3(4u, 9u, 2u));
	blockC.i = (vec3(3.0, 0.0, 4.0));
}
#version 450
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
	layout(offset = 0) int16_t a;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) i16vec4 b;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i16vec2 c;
	layout(offset = 16) lowp uvec4 d;
	layout(offset = 32) lowp uint e;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump float f;
	layout(offset = 16) lowp uvec4 g;
	layout(offset = 32) highp vec2 h;
	layout(offset = 48) mediump vec3 i;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(a), 0) && allOk;
	allOk = compare_i16vec4(ivec4(blockC[0].b), ivec4(6, 5, 9, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(c), ivec2(6, -8)) && allOk;
	allOk = compare_float((blockE.f), -2.0) && allOk;
	allOk = compare_uvec4((blockE.g), uvec4(8u, 7u, 2u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	d = (uvec4(1u, 7u, 4u, 7u));
	e = (2u);
	blockE.g = (uvec4(9u, 0u, 6u, 1u));
	blockE.h = (vec2(-9.0, -4.0));
	blockE.i = (vec3(7.0, 1.0, -2.0));
}
#version 450
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
	highp vec4 a;
	f16vec3 b;
	highp mat4x3 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(0)].b), vec3(-6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(-1.0, -6.0, 3.0, -7.0, 9.0, 3.0, -3.0, 3.0, 1.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(1)].b), vec3(9.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(-8.0, -3.0, 3.0, 2.0, -6.0, 9.0, 2.0, -6.0, -9.0, 8.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec4(6.0, -5.0, -1.0, -3.0));
	blockB[nonuniformEXT(0)].b = f16vec3(vec3(-1.0, -2.0, 7.0));
	blockB[nonuniformEXT(0)].c = (mat4x3(-5.0, -5.0, -4.0, 1.0, -7.0, 1.0, 1.0, -9.0, -7.0, -8.0, 6.0, 5.0));
	blockB[nonuniformEXT(1)].a = (vec4(0.0, 1.0, -1.0, 6.0));
	blockB[nonuniformEXT(1)].b = f16vec3(vec3(3.0, 6.0, -6.0));
	blockB[nonuniformEXT(1)].c = (mat4x3(2.0, 6.0, 9.0, -9.0, 4.0, 4.0, -4.0, -4.0, 0.0, 3.0, -8.0, 1.0));
}
#version 450
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
	lowp vec4 a;
	highp mat4x2 b;
	mediump vec4 c;
	lowp vec2 d;
	mediump mat2x3 e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump mat3 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(b, mat4x2(4.0, 0.0, -5.0, -8.0, -6.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(f[0], mat3(6.0, 7.0, -9.0, -4.0, 5.0, -5.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(f[1], mat3(-8.0, -8.0, 1.0, 9.0, 5.0, 7.0, 7.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3(f[2], mat3(-7.0, 7.0, 1.0, 7.0, 2.0, 5.0, 6.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(f[3], mat3(-6.0, 9.0, -3.0, -5.0, -5.0, -3.0, 6.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(f[4], mat3(-9.0, -1.0, 2.0, 5.0, -4.0, -2.0, -2.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(f[5], mat3(6.0, 3.0, 9.0, -2.0, 7.0, -1.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(f[6], mat3(-5.0, -4.0, 6.0, 3.0, -9.0, 3.0, -9.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(8.0, -2.0, -1.0, -6.0));
	c = (vec4(-5.0, 5.0, -2.0, 7.0));
	d = (vec2(4.0, 7.0));
	e[0] = (mat2x3(0.0, 9.0, -4.0, -5.0, 4.0, 9.0));
	e[1] = (mat2x3(-7.0, -6.0, -2.0, -4.0, 8.0, -6.0));
	e[2] = (mat2x3(-4.0, 6.0, -3.0, -6.0, 8.0, -6.0));
	f[0] = (mat3(-7.0, -7.0, 4.0, -1.0, 2.0, -6.0, 4.0, -1.0, 5.0));
	f[1] = (mat3(-5.0, -3.0, -6.0, -1.0, -7.0, 7.0, -2.0, 8.0, 9.0));
	f[2] = (mat3(8.0, 4.0, 1.0, -3.0, 9.0, 2.0, -4.0, 0.0, -3.0));
	f[3] = (mat3(-9.0, -6.0, -1.0, -9.0, -8.0, -8.0, 0.0, 4.0, -9.0));
	f[4] = (mat3(0.0, -9.0, 6.0, 0.0, 4.0, 6.0, 9.0, 7.0, -5.0));
	f[5] = (mat3(-4.0, -2.0, 2.0, 3.0, 0.0, 9.0, -5.0, -5.0, -4.0));
	f[6] = (mat3(4.0, 4.0, 8.0, -2.0, -1.0, -9.0, -5.0, 3.0, -7.0));
}
#version 450
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
	uint8_t a[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec4 b;
	highp mat2 c;
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp uvec2 d;
	mediump mat3x4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(a[0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(a[1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(a[2]), 7u) && allOk;
	allOk = compare_uint8_t(uint(a[3]), 5u) && allOk;
	allOk = compare_uint8_t(uint(a[4]), 3u) && allOk;
	allOk = compare_uint8_t(uint(a[5]), 2u) && allOk;
	allOk = compare_uint8_t(uint(a[6]), 4u) && allOk;
	allOk = compare_ivec4((blockC.b), ivec4(-9, 8, 6, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (mat2(2.0, -5.0, 9.0, -6.0));
	d = (uvec2(4u, 0u));
}
#version 450
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
	int8_t a;
	mediump mat3x2 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b[0], mat3x2(9.0, 9.0, -7.0, -4.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1], mat3x2(-2.0, 8.0, 4.0, -4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(4);
	blockB.b[0] = (mat3x2(0.0, 9.0, 4.0, 1.0, -7.0, -4.0));
	blockB.b[1] = (mat3x2(-4.0, -6.0, -5.0, -2.0, 4.0, -2.0));
}
#version 450
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
	i8vec4 mB;
};
layout(std140, column_major, binding = 1) readonly buffer BlockB
{
	i8vec2 a;
	sA b[];
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
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

struct sA
{
	bvec2 mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp uvec3 a;
	mediump vec4 b;
	sA c;
	lowp float d[];
} blockB;
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	highp mat4x3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(2u, 3u, 7u)) && allOk;
	allOk = compare_vec4((blockB.b), vec4(-7.0, -9.0, 5.0, -4.0)) && allOk;
	allOk = compare_float((blockB.d[0]), -6.0) && allOk;
	allOk = compare_float((blockB.d[1]), 4.0) && allOk;
	allOk = compare_float((blockB.d[2]), -6.0) && allOk;
	allOk = compare_float((blockB.d[3]), -3.0) && allOk;
	allOk = compare_float((blockB.d[4]), 2.0) && allOk;
	allOk = compare_float((blockB.d[5]), -9.0) && allOk;
	allOk = compare_float((blockB.d[6]), -7.0) && allOk;
	allOk = compare_float((blockB.d[7]), -5.0) && allOk;
	allOk = compare_mat4x3(e[0], mat4x3(-7.0, -9.0, 1.0, 3.0, 0.0, -8.0, 5.0, -5.0, 0.0, 2.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(e[1], mat4x3(-5.0, -8.0, 8.0, 5.0, 2.0, -3.0, -7.0, 0.0, 7.0, 1.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(2u, 0u, 0u));
}
#version 450
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
	u8vec3 a;
	mediump mat4 b[][1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(3u, 1u, 0u));
}
#version 450
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
	layout(offset = 0) highp vec2 a[1];
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec4 b;
	layout(offset = 16) lowp uvec2 c;
	layout(offset = 24) mediump float d;
	layout(offset = 28) u8vec4 e;
	layout(offset = 32) int8_t f;
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump ivec4 g;
	layout(offset = 16) i8vec3 h[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC[0].b), vec4(3.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockC[0].c), uvec2(9u, 4u)) && allOk;
	allOk = compare_float((blockC[0].d), -6.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].e), uvec4(9u, 0u, 6u, 4u)) && allOk;
	allOk = compare_int8_t(int(blockC[0].f), 4294967293) && allOk;
	allOk = compare_vec4((blockC[1].b), vec4(3.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockC[1].c), uvec2(4u, 3u)) && allOk;
	allOk = compare_float((blockC[1].d), 3.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[1].e), uvec4(7u, 9u, 7u, 3u)) && allOk;
	allOk = compare_int8_t(int(blockC[1].f), 4294967287) && allOk;
	allOk = compare_vec4((blockC[2].b), vec4(-8.0, -3.0, 3.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockC[2].c), uvec2(7u, 2u)) && allOk;
	allOk = compare_float((blockC[2].d), 2.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[2].e), uvec4(8u, 6u, 5u, 5u)) && allOk;
	allOk = compare_int8_t(int(blockC[2].f), 4294967289) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec2(6.0, -5.0));
	blockC[0].b = (vec4(-1.0, -3.0, -1.0, -2.0));
	blockC[0].c = (uvec2(4u, 0u));
	blockC[0].d = (-5.0);
	blockC[0].e = u8vec4(uvec4(5u, 2u, 7u, 1u));
	blockC[0].f = int8_t(1);
	blockC[1].b = (vec4(-9.0, -7.0, -8.0, 6.0));
	blockC[1].c = (uvec2(9u, 3u));
	blockC[1].d = (1.0);
	blockC[1].e = u8vec4(uvec4(6u, 7u, 9u, 5u));
	blockC[1].f = int8_t(4294967290);
	blockC[2].b = (vec4(2.0, 6.0, 9.0, -9.0));
	blockC[2].c = (uvec2(7u, 0u));
	blockC[2].d = (-4.0);
	blockC[2].e = u8vec4(uvec4(4u, 5u, 9u, 0u));
	blockC[2].f = int8_t(1);
	g = (ivec4(0, 0, -5, -3));
	h[0] = i8vec3(ivec3(4294967289, 4294967290, 4294967288));
}
#version 450
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
	layout(offset = 0) mediump uint a;
	layout(offset = 4) bool b;
	layout(offset = 8) mediump uvec2 c;
	layout(offset = 16) u8vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec2 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) uint8_t f;
	layout(offset = 4) bool g;
	layout(offset = 8) lowp uint h;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) u8vec3 i;
	layout(offset = 3) u8vec2 j;
	layout(offset = 5) u8vec3 k;
	layout(offset = 8) lowp ivec2 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 8u) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_vec2((e), vec2(-2.0, 6.0)) && allOk;
	allOk = compare_bool((blockD[0].g), false) && allOk;
	allOk = compare_uint((blockD[0].h), 5u) && allOk;
	allOk = compare_bool((blockD[1].g), false) && allOk;
	allOk = compare_uint((blockD[1].h), 5u) && allOk;
	allOk = compare_bool((blockD[2].g), false) && allOk;
	allOk = compare_uint((blockD[2].h), 3u) && allOk;
	allOk = compare_u8vec3(uvec3(k), uvec3(7u, 9u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.b = (false);
	blockB.c = (uvec2(8u, 7u));
	blockB.d = u8vec2(uvec2(2u, 3u));
	e = (vec2(9.0, -3.0));
	blockD[0].f = uint8_t(5u);
	blockD[0].h = (8u);
	blockD[1].f = uint8_t(2u);
	blockD[1].h = (7u);
	blockD[2].f = uint8_t(4u);
	blockD[2].h = (1u);
	i = u8vec3(uvec3(3u, 0u, 4u));
	j = u8vec2(uvec2(9u, 8u));
	l = (ivec2(4, 9));
}
#version 450
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
	i8vec2 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	i8vec2 a;
	lowp mat3x2 b;
	lowp uvec2 c[8];
	highp float d;
	bvec3 e;
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sA f;
	i8vec4 g;
	bvec4 h;
	highp mat3 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b, mat3x2(9.0, -9.0, -9.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_float((blockB.d), -8.0) && allOk;
	allOk = compare_bvec3((blockB.e), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(4294967295, 4294967292));
	blockB.d = (5.0);
	blockB.e = (bvec3(true, false, true));
	h = (bvec4(false, true, true, true));
	i[0] = (mat3(7.0, -3.0, 1.0, -5.0, -4.0, -2.0, -2.0, 3.0, -3.0));
	i[1] = (mat3(-9.0, -3.0, 1.0, 9.0, -4.0, 0.0, -1.0, -3.0, -5.0));
	i[2] = (mat3(8.0, 5.0, 2.0, -3.0, 0.0, 6.0, 8.0, 1.0, 8.0));
	i[3] = (mat3(2.0, -6.0, 3.0, -3.0, -5.0, 0.0, -3.0, 3.0, -4.0));
	i[4] = (mat3(-9.0, -8.0, -7.0, 0.0, 8.0, 8.0, -3.0, -7.0, -9.0));
	i[5] = (mat3(4.0, 6.0, -7.0, -4.0, -7.0, 7.0, -1.0, -1.0, -5.0));
	i[6] = (mat3(1.0, 4.0, 6.0, -4.0, -7.0, -8.0, 8.0, -8.0, 6.0));
}
#version 450
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
	lowp mat3x4 mB;
	mediump mat3 mC;
};
struct sB
{
	highp float mA;
};
struct sC
{
	sB mA;
	i8vec4 mB;
	highp ivec4 mC;
	u8vec2 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	bvec2 a;
	mediump uvec3 b;
	sA c;
	lowp vec3 d;
	mediump uint e;
} blockB;
layout(scalar, row_major, binding = 2) readonly buffer BlockC
{
	highp mat4x2 f[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump ivec2 g;
	bvec3 h;
	highp uvec3 i[8];
	highp vec3 j[];
} blockD;
layout(scalar, column_major, binding = 4) readonly buffer BlockE
{
	sC k;
	mediump mat3 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(9.0, -3.0, -9.0)) && allOk;
	allOk = compare_uint((blockB.e), 1u) && allOk;
	allOk = compare_mat4x2(blockC.f[0], mat4x2(8.0, 6.0, -2.0, 6.0, 1.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[1], mat4x2(0.0, -2.0, -1.0, 6.0, 7.0, -7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[2], mat4x2(-1.0, 9.0, -1.0, 1.0, -6.0, 6.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[3], mat4x2(-4.0, -8.0, 5.0, -3.0, 7.0, 2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[4], mat4x2(-1.0, -3.0, 2.0, -3.0, 9.0, 3.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[5], mat4x2(2.0, 2.0, 4.0, -1.0, -1.0, 2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[6], mat4x2(-8.0, 6.0, -3.0, 0.0, 7.0, 9.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC.f[7], mat4x2(6.0, -5.0, 7.0, 0.0, 0.0, -5.0, -4.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-9, -6)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(true, true, false)) && allOk;
	allOk = compare_vec3((blockD.j[0]), vec3(-5.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD.j[1]), vec3(-2.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.j[2]), vec3(6.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.j[3]), vec3(-6.0, 3.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.j[4]), vec3(-4.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD.j[5]), vec3(-6.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(l[0], mat3(3.0, -7.0, -5.0, -3.0, 6.0, -9.0, 5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3(l[1], mat3(2.0, 2.0, 3.0, -8.0, 2.0, -8.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(l[2], mat3(7.0, -6.0, -6.0, -9.0, -8.0, -6.0, -1.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(l[3], mat3(-5.0, 7.0, -5.0, -5.0, 8.0, -3.0, 3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (uvec3(3u, 2u, 1u));
	blockB.c.mA = (bvec2(false, true));
	blockB.c.mB = (mat3x4(-5.0, 9.0, 0.0, 6.0, 2.0, 7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0));
	blockB.c.mC = (mat3(2.0, 4.0, -3.0, -5.0, -9.0, 3.0, 7.0, 6.0, 3.0));
	blockB.d = (vec3(-4.0, -1.0, 6.0));
	blockB.e = (5u);
	blockD.g = (ivec2(1, 5));
	blockD.i[0] = (uvec3(8u, 0u, 4u));
	blockD.i[1] = (uvec3(2u, 8u, 2u));
	blockD.i[2] = (uvec3(6u, 8u, 8u));
	blockD.i[3] = (uvec3(8u, 3u, 3u));
	blockD.i[4] = (uvec3(8u, 7u, 4u));
	blockD.i[5] = (uvec3(9u, 0u, 0u));
	blockD.i[6] = (uvec3(1u, 1u, 5u));
	blockD.i[7] = (uvec3(0u, 2u, 1u));
}
#version 450
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
	bvec4 mB;
	mediump uint mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp vec2 a;
	mediump mat4x2 b;
	u8vec2 c[2][2];
	mediump float d;
	sA e[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp mat2x3 f;
	highp ivec2 g[6];
	highp mat2 h;
	highp float i;
	lowp mat3x2 j[];
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	highp mat3x2 k;
	lowp mat3x2 l;
	mediump ivec4 m;
	u8vec3 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(c[0][0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(c[0][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(c[1][0]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(c[1][1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_float((d), -4.0) && allOk;
	allOk = compare_uvec4((e[0].mA), uvec4(7u, 0u, 7u, 2u)) && allOk;
	allOk = compare_bvec4((e[0].mB), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uint((e[0].mC), 9u) && allOk;
	allOk = compare_uvec4((e[1].mA), uvec4(8u, 7u, 6u, 1u)) && allOk;
	allOk = compare_bvec4((e[1].mB), bvec4(true, false, true, false)) && allOk;
	allOk = compare_uint((e[1].mC), 1u) && allOk;
	allOk = compare_uvec4((e[2].mA), uvec4(6u, 2u, 2u, 3u)) && allOk;
	allOk = compare_bvec4((e[2].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uint((e[2].mC), 5u) && allOk;
	allOk = compare_uvec4((e[3].mA), uvec4(2u, 4u, 2u, 7u)) && allOk;
	allOk = compare_bvec4((e[3].mB), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uint((e[3].mC), 0u) && allOk;
	allOk = compare_uvec4((e[4].mA), uvec4(0u, 7u, 9u, 1u)) && allOk;
	allOk = compare_bvec4((e[4].mB), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uint((e[4].mC), 1u) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(-2.0, -1.0, -8.0, 1.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC.h, mat2(-7.0, -5.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockC.j[0], mat3x2(0.0, 8.0, -1.0, 2.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.j[1], mat3x2(-2.0, 4.0, -6.0, -6.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.j[2], mat3x2(-1.0, -6.0, -9.0, -2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockC.j[3], mat3x2(3.0, -6.0, 3.0, 5.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC.j[4], mat3x2(4.0, 7.0, 4.0, 1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockC.j[5], mat3x2(7.0, 4.0, 2.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec4((m), ivec4(3, -6, 0, 6)) && allOk;
	allOk = compare_u8vec3(uvec3(n[0]), uvec3(2u, 4u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(n[1]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(n[2]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(n[3]), uvec3(5u, 5u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(n[4]), uvec3(4u, 4u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(n[5]), uvec3(2u, 5u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(n[6]), uvec3(9u, 3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(8.0, -4.0));
	b = (mat4x2(-1.0, -5.0, -1.0, 5.0, 8.0, 9.0, 6.0, 7.0));
	c[0][0] = u8vec2(uvec2(4u, 3u));
	c[0][1] = u8vec2(uvec2(7u, 5u));
	c[1][0] = u8vec2(uvec2(2u, 9u));
	c[1][1] = u8vec2(uvec2(3u, 1u));
	d = (-5.0);
	e[0].mA = (uvec4(9u, 2u, 4u, 7u));
	e[0].mB = (bvec4(true, false, true, true));
	e[0].mC = (0u);
	e[1].mA = (uvec4(6u, 5u, 4u, 4u));
	e[1].mB = (bvec4(false, true, false, false));
	e[1].mC = (8u);
	e[2].mA = (uvec4(6u, 8u, 7u, 1u));
	e[2].mB = (bvec4(true, false, true, true));
	e[2].mC = (9u);
	e[3].mA = (uvec4(5u, 0u, 2u, 5u));
	e[3].mB = (bvec4(true, false, true, true));
	e[3].mC = (6u);
	e[4].mA = (uvec4(3u, 7u, 7u, 9u));
	e[4].mB = (bvec4(false, false, false, true));
	e[4].mC = (0u);
	blockC.f = (mat2x3(9.0, -5.0, -8.0, 1.0, -2.0, -2.0));
	blockC.g[0] = (ivec2(0, -2));
	blockC.g[1] = (ivec2(-5, -4));
	blockC.g[2] = (ivec2(-8, 7));
	blockC.g[3] = (ivec2(2, -2));
	blockC.g[4] = (ivec2(1, 4));
	blockC.g[5] = (ivec2(8, 9));
	blockC.i = (7.0);
	blockC.j[0] = (mat3x2(0.0, 8.0, 9.0, -1.0, 9.0, -5.0));
	blockC.j[1] = (mat3x2(-1.0, -7.0, 7.0, -7.0, -4.0, -1.0));
	blockC.j[2] = (mat3x2(-1.0, 6.0, 9.0, 8.0, 6.0, -2.0));
	blockC.j[3] = (mat3x2(-4.0, -8.0, 4.0, 3.0, -5.0, -4.0));
	blockC.j[4] = (mat3x2(9.0, 0.0, 8.0, -6.0, 8.0, 8.0));
	blockC.j[5] = (mat3x2(-5.0, -8.0, 8.0, -7.0, 2.0, -4.0));
	l = (mat3x2(-5.0, 0.0, -6.0, 3.0, 5.0, 4.0));
	m = (ivec4(2, -4, 2, -1));
	n[0] = u8vec3(uvec3(3u, 2u, 0u));
	n[1] = u8vec3(uvec3(0u, 1u, 2u));
	n[2] = u8vec3(uvec3(3u, 4u, 3u));
	n[3] = u8vec3(uvec3(3u, 1u, 6u));
	n[4] = u8vec3(uvec3(3u, 5u, 5u));
	n[5] = u8vec3(uvec3(7u, 5u, 8u));
	n[6] = u8vec3(uvec3(0u, 9u, 7u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) readonly buffer BlockB
{
	highp mat4 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].a, mat4(1.0, -8.0, 7.0, -4.0, -9.0, 0.0, -2.0, -3.0, -3.0, -6.0, -8.0, 6.0, -6.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].a, mat4(3.0, 0.0, 0.0, 5.0, -8.0, 9.0, 3.0, -8.0, -4.0, 9.0, -2.0, 0.0, 3.0, 9.0, -7.0, -9.0)) && allOk;
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

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(-1.0, -9.0, 2.0, -8.0, 9.0, -1.0, 7.0, -5.0)) && allOk;
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
	int8_t var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var), 4294967292) && allOk;
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

layout(std430, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat2(var, mat2(6.0, 4.0, 9.0, 8.0)) && allOk;
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], -1.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 6.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_float(var[3][3], 3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-8.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-1.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, 6.0, -6.0, 3.0)) && allOk;
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, 1.0)) && allOk;
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-7.0, -1.0)) && allOk;
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

layout(scalar, binding = 1) readonly buffer Block
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

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, -1.0)) && allOk;
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat2(var, mat2(-6.0, -2.0, 7.0, 8.0)) && allOk;
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat4(var, mat4(-9.0, 1.0, 3.0, -2.0, -4.0, -7.0, -6.0, 1.0, 8.0, 9.0, 8.0, 8.0, 9.0, 8.0, 8.0, -1.0)) && allOk;
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(2.0, -1.0, 0.0, 6.0, 8.0, -6.0)) && allOk;
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

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(0.0, 2.0, 1.0, -5.0, 7.0, -3.0, -5.0, 8.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(2.0, -7.0, 9.0, -8.0, 7.0, -7.0, -6.0, -6.0, 1.0, 3.0, -5.0, -9.0)) && allOk;
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-6.0, -5.0)) && allOk;
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
	highp mat3x4 var[3];
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
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

}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var[0], mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -3.0, -4.0, 0.0)) && allOk;
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat4(var[0], mat4(-5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0, 3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0, -2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0, 0.0, 5.0, -6.0, -3.0)) && allOk;
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
	f16vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(-8.0, -8.0, -3.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(6.0, 1.0, -8.0, 4.0)) && allOk;
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
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

layout(std430, binding = 1) readonly buffer Block
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

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
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

}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
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
	allOk = compare_mat2(var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
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

}
#version 450
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
layout(scalar, binding = 1) readonly buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(1, -7, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, -9.0, -7.0, -5.0, 1.0, -9.0, -1.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-1, -3, -8)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(3.0, 3.0, 7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-8.0, 1.0, 5.0, 1.0, 9.0, -9.0, 9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(7.0, -9.0, 0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(1.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(7, -4, 1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(1.0, -4.0, 0.0, -4.0, -7.0, -8.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(2.0, -8.0, -7.0, 8.0, -9.0, 3.0, 0.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-8.0, -9.0, -2.0, -6.0, 0.0, -9.0, 5.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(6.0, 3.0, -9.0, -6.0, 7.0, 1.0, 0.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-2.0, -3.0, 4.0, 3.0)) && allOk;
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
	highp vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var), vec4(8.0, -4.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec4(-6.0, 1.0, 5.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(1.0, -9.0));
	block.var[1] = (vec2(-7.0, 2.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block.var, mat2(6.0, 4.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(5.0, -5.0));
	block.var[1] = (vec2(-3.0, 5.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x4(block.var, mat2x4(3.0, 7.0, 8.0, -7.0, -8.0, -2.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(6.0, -9.0, 1.0, -3.0));
	block.var[1] = (vec4(4.0, -7.0, 5.0, 6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[2][0], 5.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-5.0, 5.0, 7.0, -1.0, -3.0, 6.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-7.0, -2.0, 9.0, 1.0, 7.0, 8.0, 6.0, -6.0, -1.0, 4.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(1.0, 4.0, 5.0, -8.0, -8.0, 2.0, 7.0, 9.0, 8.0, 4.0, -9.0, 9.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-9.0, -5.0, -6.0, -1.0, 3.0, -5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, -4.0, -9.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(6.0, -1.0, -2.0, -5.0));
	block.var[1] = (vec4(5.0, -2.0, -8.0, -2.0));
	block.var[2] = (vec4(3.0, 1.0, -9.0, 1.0));
	block.var[3] = (vec4(0.0, 3.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(0.0, -5.0, 6.0, -5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(5.0, 1.0, 2.0, -5.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[0][3], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 0.0) && allOk;
	allOk = compare_float(block.var[1][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-1.0, 0.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, 5.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(1.0, -3.0, 7.0, -9.0));
	block.var[1] = (vec4(5.0, 8.0, -8.0, 9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-4.0, -6.0, 5.0, -5.0, 5.0, -9.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-2.0, -4.0, -2.0, 3.0, -1.0, -2.0, 0.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-6.0, -3.0, 6.0, -8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(6.0, 0.0, -2.0));
	block.var[1] = (vec3(-1.0, 5.0, -6.0));
	block.var[2] = (vec3(6.0, 0.0, 8.0));
	block.var[3] = (vec3(-4.0, -1.0, 2.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	uint padding;
	highp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 5u) && allOk;
	allOk = compare_uvec3((block.var), uvec3(4u, 7u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5u);
	block.var = (uvec3(3u, 8u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat2(block.var, mat2(8.0, -4.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat2(9.0, 7.0, -4.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(8.0, 4.0, 9.0, -4.0, -1.0, 1.0, 1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat4x2(1.0, -9.0, -6.0, 7.0, -3.0, 8.0, 7.0, -6.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[2]), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 8.0));
	block.var[1] = (vec2(7.0, -1.0));
	block.var[2] = (vec2(-4.0, 8.0));
}
#version 450
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
	highp int var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var[0]), 6) && allOk;
	allOk = compare_int((block.var[1]), 0) && allOk;
	allOk = compare_int((block.var[2]), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (8);
	block.var[1] = (2);
	block.var[2] = (-5);
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(7.0, -1.0, -4.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(7.0, -4.0, -3.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-3.0, 3.0, -5.0, -3.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0][0] = (vec2(-4.0, -3.0));
	block.var[0][1] = (vec2(5.0, -9.0));
	block.var[0][2] = (vec2(4.0, -2.0));
	block.var[1][0] = (vec2(-1.0, 8.0));
	block.var[1][1] = (vec2(3.0, 7.0));
	block.var[1][2] = (vec2(2.0, -4.0));
	block.var[2][0] = (vec2(4.0, 3.0));
	block.var[2][1] = (vec2(-6.0, -4.0));
	block.var[2][2] = (vec2(3.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[3] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[4] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[5] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[6] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[7] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[8] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[9] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[10] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[11] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	block.var[12] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	block.var[13] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	block.var[14] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	block.var[15] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	block.var[16] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	block.var[17] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	block.var[18] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	bool var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0]), false) && allOk;
	allOk = compare_bool((block.var[1]), true) && allOk;
	allOk = compare_bool((block.var[2]), true) && allOk;
	allOk = compare_bool((block.var[3]), false) && allOk;
	allOk = compare_bool((block.var[4]), false) && allOk;
	allOk = compare_bool((block.var[5]), true) && allOk;
	allOk = compare_bool((block.var[6]), true) && allOk;
	allOk = compare_bool((block.var[7]), false) && allOk;
	allOk = compare_bool((block.var[8]), false) && allOk;
	allOk = compare_bool((block.var[9]), false) && allOk;
	allOk = compare_bool((block.var[10]), false) && allOk;
	allOk = compare_bool((block.var[11]), true) && allOk;
	allOk = compare_bool((block.var[12]), true) && allOk;
	allOk = compare_bool((block.var[13]), false) && allOk;
	allOk = compare_bool((block.var[14]), true) && allOk;
	allOk = compare_bool((block.var[15]), true) && allOk;
	allOk = compare_bool((block.var[16]), false) && allOk;
	allOk = compare_bool((block.var[17]), true) && allOk;
	allOk = compare_bool((block.var[18]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (false);
	block.var[1] = (false);
	block.var[2] = (true);
	block.var[3] = (true);
	block.var[4] = (false);
	block.var[5] = (false);
	block.var[6] = (true);
	block.var[7] = (true);
	block.var[8] = (true);
	block.var[9] = (true);
	block.var[10] = (false);
	block.var[11] = (false);
	block.var[12] = (false);
	block.var[13] = (false);
	block.var[14] = (true);
	block.var[15] = (false);
	block.var[16] = (true);
	block.var[17] = (false);
	block.var[18] = (true);
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	block.var[3] = (mat2(0.0, 4.0, -3.0, -4.0));
	block.var[4] = (mat2(-6.0, 0.0, 5.0, 1.0));
	block.var[5] = (mat2(-6.0, 9.0, 5.0, 9.0));
	block.var[6] = (mat2(5.0, -3.0, -3.0, 6.0));
	block.var[7] = (mat2(-4.0, -6.0, -2.0, -6.0));
	block.var[8] = (mat2(-3.0, -4.0, -7.0, -9.0));
	block.var[9] = (mat2(8.0, 2.0, -6.0, 9.0));
	block.var[10] = (mat2(-5.0, -2.0, 4.0, 9.0));
	block.var[11] = (mat2(4.0, 7.0, 4.0, -8.0));
	block.var[12] = (mat2(5.0, 7.0, 7.0, -8.0));
	block.var[13] = (mat2(7.0, -9.0, -2.0, 4.0));
	block.var[14] = (mat2(3.0, 3.0, 3.0, -6.0));
	block.var[15] = (mat2(-4.0, -8.0, -2.0, 5.0));
	block.var[16] = (mat2(-3.0, 5.0, 0.0, -2.0));
	block.var[17] = (mat2(-3.0, 0.0, -9.0, 1.0));
	block.var[18] = (mat2(-8.0, 1.0, -1.0, -3.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[3] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[4] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[5] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[6] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[7] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[8] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[9] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[10] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[11] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	block.var[12] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	block.var[13] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	block.var[14] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	block.var[15] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	block.var[16] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	block.var[17] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	block.var[18] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(6.0, -2.0));
	block.var[0][1] = (vec2(2.0, 8.0));
	block.var[0][2] = (vec2(-5.0, 3.0));
	block.var[0][3] = (vec2(-1.0, -7.0));
	block.var[1][0] = (vec2(4.0, 2.0));
	block.var[1][1] = (vec2(-4.0, 8.0));
	block.var[1][2] = (vec2(3.0, 8.0));
	block.var[1][3] = (vec2(-1.0, 6.0));
	block.var[2][0] = (vec2(-8.0, 2.0));
	block.var[2][1] = (vec2(-5.0, 5.0));
	block.var[2][2] = (vec2(-4.0, -9.0));
	block.var[2][3] = (vec2(0.0, 4.0));
	block.var[3][0] = (vec2(8.0, 2.0));
	block.var[3][1] = (vec2(-3.0, 2.0));
	block.var[3][2] = (vec2(-4.0, -4.0));
	block.var[3][3] = (vec2(2.0, -8.0));
	block.var[4][0] = (vec2(-4.0, 8.0));
	block.var[4][1] = (vec2(5.0, 7.0));
	block.var[4][2] = (vec2(-4.0, 6.0));
	block.var[4][3] = (vec2(8.0, 4.0));
	block.var[5][0] = (vec2(-9.0, -7.0));
	block.var[5][1] = (vec2(7.0, -5.0));
	block.var[5][2] = (vec2(1.0, -9.0));
	block.var[5][3] = (vec2(9.0, 5.0));
	block.var[6][0] = (vec2(7.0, 3.0));
	block.var[6][1] = (vec2(3.0, 3.0));
	block.var[6][2] = (vec2(-5.0, -9.0));
	block.var[6][3] = (vec2(2.0, 9.0));
	block.var[7][0] = (vec2(3.0, 8.0));
	block.var[7][1] = (vec2(3.0, -4.0));
	block.var[7][2] = (vec2(6.0, 1.0));
	block.var[7][3] = (vec2(-3.0, 1.0));
	block.var[8][0] = (vec2(-5.0, -2.0));
	block.var[8][1] = (vec2(7.0, 8.0));
	block.var[8][2] = (vec2(4.0, 7.0));
	block.var[8][3] = (vec2(-1.0, -8.0));
	block.var[9][0] = (vec2(-6.0, -6.0));
	block.var[9][1] = (vec2(-4.0, -2.0));
	block.var[9][2] = (vec2(3.0, 8.0));
	block.var[9][3] = (vec2(4.0, 4.0));
	block.var[10][0] = (vec2(-7.0, -6.0));
	block.var[10][1] = (vec2(8.0, -6.0));
	block.var[10][2] = (vec2(8.0, -3.0));
	block.var[10][3] = (vec2(-7.0, 0.0));
	block.var[11][0] = (vec2(-9.0, 2.0));
	block.var[11][1] = (vec2(-9.0, 7.0));
	block.var[11][2] = (vec2(-2.0, 2.0));
	block.var[11][3] = (vec2(-6.0, -1.0));
	block.var[12][0] = (vec2(1.0, 7.0));
	block.var[12][1] = (vec2(0.0, -4.0));
	block.var[12][2] = (vec2(-1.0, 5.0));
	block.var[12][3] = (vec2(9.0, -8.0));
	block.var[13][0] = (vec2(-3.0, 8.0));
	block.var[13][1] = (vec2(-1.0, 7.0));
	block.var[13][2] = (vec2(5.0, -7.0));
	block.var[13][3] = (vec2(8.0, 0.0));
	block.var[14][0] = (vec2(-5.0, 7.0));
	block.var[14][1] = (vec2(8.0, 9.0));
	block.var[14][2] = (vec2(8.0, 9.0));
	block.var[14][3] = (vec2(1.0, 9.0));
	block.var[15][0] = (vec2(-9.0, 8.0));
	block.var[15][1] = (vec2(-2.0, 9.0));
	block.var[15][2] = (vec2(6.0, 6.0));
	block.var[15][3] = (vec2(3.0, -5.0));
	block.var[16][0] = (vec2(1.0, -4.0));
	block.var[16][1] = (vec2(-5.0, 7.0));
	block.var[16][2] = (vec2(-8.0, 7.0));
	block.var[16][3] = (vec2(-1.0, -1.0));
	block.var[17][0] = (vec2(-2.0, -7.0));
	block.var[17][1] = (vec2(4.0, -8.0));
	block.var[17][2] = (vec2(2.0, 4.0));
	block.var[17][3] = (vec2(3.0, 1.0));
	block.var[18][0] = (vec2(7.0, 8.0));
	block.var[18][1] = (vec2(2.0, -9.0));
	block.var[18][2] = (vec2(-8.0, -9.0));
	block.var[18][3] = (vec2(-1.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[3] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[4] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[5] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[6] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[7] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[8] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[9] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[10] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[11] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	block.var[12] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	block.var[13] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	block.var[14] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	block.var[15] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	block.var[16] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	block.var[17] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	block.var[18] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
}
#version 450
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
	u8vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[4]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[5]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[6]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[7]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[8]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[9]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[10]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[11]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[12]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[13]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[14]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[15]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[16]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[17]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[18]), uvec3(5u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[2] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[3] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[4] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[5] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[6] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[7] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[8] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[9] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[10] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[11] = u8vec3(uvec3(9u, 4u, 9u));
	block.var[12] = u8vec3(uvec3(5u, 7u, 3u));
	block.var[13] = u8vec3(uvec3(9u, 8u, 1u));
	block.var[14] = u8vec3(uvec3(6u, 2u, 7u));
	block.var[15] = u8vec3(uvec3(0u, 2u, 7u));
	block.var[16] = u8vec3(uvec3(4u, 8u, 8u));
	block.var[17] = u8vec3(uvec3(6u, 1u, 2u));
	block.var[18] = u8vec3(uvec3(3u, 6u, 6u));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block.var[0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block.var[0][2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	block.var[1][0] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	block.var[1][1] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	block.var[1][2] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	block.var[2][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	block.var[2][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	block.var[2][2] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	block.var[3][0] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	block.var[3][1] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	block.var[3][2] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[0][2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[1][0] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[1][1] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[1][2] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[2][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[2][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[2][2] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[3][0] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[3][1] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[3][2] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[0][2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[1][0] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[1][1] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[1][2] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[2][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[2][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[2][2] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[3][0] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[3][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[3][2] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[0][2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[1][0] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[1][1] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[1][2] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[2][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[2][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[2][2] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[3][0] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[3][1] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[3][2] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
}
#version 450
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
	bvec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec4((block.var[0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[0][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[0][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3][0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[3][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3][2]), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0][0] = (bvec4(true, true, false, true));
	block.var[0][1] = (bvec4(false, false, false, false));
	block.var[0][2] = (bvec4(true, true, true, true));
	block.var[1][0] = (bvec4(true, true, false, true));
	block.var[1][1] = (bvec4(false, true, false, true));
	block.var[1][2] = (bvec4(false, false, true, false));
	block.var[2][0] = (bvec4(true, true, false, true));
	block.var[2][1] = (bvec4(true, true, false, false));
	block.var[2][2] = (bvec4(false, true, true, true));
	block.var[3][0] = (bvec4(false, true, false, true));
	block.var[3][1] = (bvec4(true, true, true, false));
	block.var[3][2] = (bvec4(true, false, true, false));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(-3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0, 0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0, 4.0, 2.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0, -1.0, 7.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0, 0.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0, -3.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0, -6.0, 6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0, -3.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0, -1.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0, -4.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0, 2.0, 5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0, -5.0, 3.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0] = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	block.var[0][1] = (mat4(2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0));
	block.var[0][2] = (mat4(9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0));
	block.var[1][0] = (mat4(-1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0, 1.0, -5.0, 0.0, 4.0));
	block.var[1][1] = (mat4(5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0, 7.0, 2.0, 2.0, -6.0));
	block.var[1][2] = (mat4(-1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0, 0.0, -6.0, 3.0, 7.0));
	block.var[2][0] = (mat4(3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0, 9.0, -3.0, -6.0, 3.0));
	block.var[2][1] = (mat4(-1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0, -3.0, 1.0, 4.0, -6.0));
	block.var[2][2] = (mat4(-4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0, -5.0, 3.0, -8.0, -5.0));
	block.var[3][0] = (mat4(-7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0, 2.0, 1.0, 1.0, -4.0));
	block.var[3][1] = (mat4(4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0, -3.0, 2.0, -2.0, 6.0));
	block.var[3][2] = (mat4(-1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0, -9.0, 7.0, 7.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-3.0, -7.0, 1.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(7.0, -9.0, 1.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-9.0, 1.0, -7.0, -5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(4.0, -5.0, 9.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-7.0, -3.0, 0.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-6.0, -8.0, 2.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-1.0, -4.0, -9.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(2.0, -8.0, 9.0, -9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-8.0, -6.0, 2.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-2.0, -6.0, 1.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(7.0, 2.0, 9.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(5.0, 4.0, 1.0, 8.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0] = (mat2x3(-7.0, 9.0, -3.0, 0.0, 7.0, 1.0));
	block.var[0][1] = (mat2x3(-4.0, 1.0, 9.0, 6.0, -4.0, -1.0));
	block.var[0][2] = (mat2x3(-8.0, 4.0, 7.0, 8.0, 0.0, 9.0));
	block.var[1][0] = (mat2x3(4.0, 4.0, 2.0, 3.0, 8.0, 4.0));
	block.var[1][1] = (mat2x3(-5.0, 9.0, 7.0, -1.0, -6.0, -1.0));
	block.var[1][2] = (mat2x3(6.0, 4.0, 8.0, -3.0, -1.0, -2.0));
	block.var[2][0] = (mat2x3(5.0, -8.0, 8.0, -1.0, 6.0, -3.0));
	block.var[2][1] = (mat2x3(-9.0, 9.0, 7.0, 5.0, -8.0, -3.0));
	block.var[2][2] = (mat2x3(6.0, 2.0, -6.0, -1.0, -2.0, -7.0));
	block.var[3][0] = (mat2x3(-8.0, 5.0, -5.0, 6.0, 7.0, 5.0));
	block.var[3][1] = (mat2x3(-7.0, -3.0, -4.0, -1.0, 8.0, -5.0));
	block.var[3][2] = (mat2x3(9.0, -8.0, 3.0, 3.0, -8.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(9.0, -6.0, -8.0, -7.0, 2.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-4.0, 1.0, 5.0, 2.0, -6.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(8.0, 9.0, 2.0, -7.0, -8.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(6.0, 4.0, 1.0, -8.0, -6.0, -5.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-2.0, -3.0, 3.0, 9.0, -4.0, 6.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(6.0, -6.0, -5.0, -5.0, -2.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-8.0, 7.0, 2.0, -1.0, -4.0, 9.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(1.0, -3.0, -2.0, 3.0, 7.0, 1.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(4.0, 7.0, -8.0, 0.0, 4.0, 0.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(2.0, -4.0, -2.0, 1.0, -7.0, 6.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(1.0, 6.0, -5.0, -9.0, -6.0, 4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-2.0, 7.0, 8.0, -1.0, -1.0, -3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][1] = (vec2(-4.0, 4.0));
	block.var[0][0][2] = (vec2(9.0, 5.0));
	block.var[0][0][3] = (vec2(-9.0, -2.0));
	block.var[0][1][0] = (vec2(6.0, -8.0));
	block.var[0][1][1] = (vec2(-5.0, -1.0));
	block.var[0][1][2] = (vec2(9.0, 0.0));
	block.var[0][1][3] = (vec2(4.0, 5.0));
	block.var[0][2][0] = (vec2(4.0, -5.0));
	block.var[0][2][1] = (vec2(-2.0, -4.0));
	block.var[0][2][2] = (vec2(6.0, 4.0));
	block.var[0][2][3] = (vec2(-2.0, 5.0));
	block.var[1][0][0] = (vec2(-6.0, -5.0));
	block.var[1][0][1] = (vec2(7.0, -6.0));
	block.var[1][0][2] = (vec2(8.0, 5.0));
	block.var[1][0][3] = (vec2(5.0, 5.0));
	block.var[1][1][0] = (vec2(-6.0, -3.0));
	block.var[1][1][1] = (vec2(-1.0, -1.0));
	block.var[1][1][2] = (vec2(-2.0, 6.0));
	block.var[1][1][3] = (vec2(-5.0, -1.0));
	block.var[1][2][0] = (vec2(-5.0, 5.0));
	block.var[1][2][1] = (vec2(5.0, 9.0));
	block.var[1][2][2] = (vec2(-7.0, 0.0));
	block.var[1][2][3] = (vec2(-8.0, 6.0));
	block.var[2][0][0] = (vec2(5.0, 2.0));
	block.var[2][0][1] = (vec2(6.0, -4.0));
	block.var[2][0][2] = (vec2(-4.0, 8.0));
	block.var[2][0][3] = (vec2(4.0, 5.0));
	block.var[2][1][0] = (vec2(7.0, 0.0));
	block.var[2][1][1] = (vec2(-7.0, -4.0));
	block.var[2][1][2] = (vec2(1.0, -1.0));
	block.var[2][1][3] = (vec2(-1.0, 7.0));
	block.var[2][2][0] = (vec2(9.0, -9.0));
	block.var[2][2][1] = (vec2(7.0, -8.0));
	block.var[2][2][2] = (vec2(5.0, -4.0));
	block.var[2][2][3] = (vec2(-6.0, 4.0));
	block.var[3][0][0] = (vec2(9.0, 1.0));
	block.var[3][0][1] = (vec2(-6.0, -3.0));
	block.var[3][0][2] = (vec2(-7.0, 9.0));
	block.var[3][0][3] = (vec2(3.0, 3.0));
	block.var[3][1][0] = (vec2(3.0, -7.0));
	block.var[3][1][1] = (vec2(0.0, 6.0));
	block.var[3][1][2] = (vec2(-8.0, -2.0));
	block.var[3][1][3] = (vec2(5.0, 7.0));
	block.var[3][2][0] = (vec2(2.0, -2.0));
	block.var[3][2][1] = (vec2(8.0, 8.0));
	block.var[3][2][2] = (vec2(1.0, -3.0));
	block.var[3][2][3] = (vec2(-6.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[0][0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[0][1][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	block.var[0][1][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	block.var[0][1][2] = (mat2(5.0, -4.0, 3.0, 8.0));
	block.var[1][0][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[1][0][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[1][0][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[1][1][0] = (mat2(0.0, -2.0, 7.0, 4.0));
	block.var[1][1][1] = (mat2(4.0, -4.0, 0.0, 7.0));
	block.var[1][1][2] = (mat2(-7.0, 7.0, -1.0, 4.0));
	block.var[2][0][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[2][0][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[2][0][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[2][1][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	block.var[2][1][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	block.var[2][1][2] = (mat2(1.0, -5.0, -9.0, -7.0));
	block.var[3][0][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[3][0][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[3][0][2] = (mat2(5.0, 8.0, -2.0, 4.0));
	block.var[3][1][0] = (mat2(-6.0, 7.0, 4.0, 1.0));
	block.var[3][1][1] = (mat2(-8.0, 7.0, -5.0, -1.0));
	block.var[3][1][2] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
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
	block.var[0][0][2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[0][0][2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[0][0][2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[0][0][2][3] = (vec3(8.0, 2.0, 4.0));
	block.var[0][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[0][1][0][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[0][1][0][2] = (vec3(4.0, -3.0, -8.0));
	block.var[0][1][0][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[0][1][1][0] = (vec3(6.0, -2.0, 8.0));
	block.var[0][1][1][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[0][1][1][2] = (vec3(6.0, 8.0, -5.0));
	block.var[0][1][1][3] = (vec3(1.0, -6.0, 4.0));
	block.var[0][1][2][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[0][1][2][1] = (vec3(0.0, -5.0, -3.0));
	block.var[0][1][2][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[0][1][2][3] = (vec3(3.0, -6.0, 8.0));
	block.var[1][0][0][0] = (vec3(2.0, 4.0, -3.0));
	block.var[1][0][0][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][0][2] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][0][3] = (vec3(6.0, -9.0, 0.0));
	block.var[1][0][1][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[1][0][1][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[1][0][1][2] = (vec3(6.0, -3.0, -5.0));
	block.var[1][0][1][3] = (vec3(0.0, 8.0, -8.0));
	block.var[1][0][2][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[1][0][2][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[1][0][2][2] = (vec3(3.0, 3.0, 2.0));
	block.var[1][0][2][3] = (vec3(8.0, -8.0, -6.0));
	block.var[1][1][0][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[1][1][0][1] = (vec3(5.0, -1.0, 6.0));
	block.var[1][1][0][2] = (vec3(8.0, 7.0, 1.0));
	block.var[1][1][0][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[1][1][1][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[1][1][1][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[1][1][1][2] = (vec3(0.0, -7.0, 3.0));
	block.var[1][1][1][3] = (vec3(2.0, -7.0, 1.0));
	block.var[1][1][2][0] = (vec3(8.0, -1.0, -9.0));
	block.var[1][1][2][1] = (vec3(8.0, 8.0, 2.0));
	block.var[1][1][2][2] = (vec3(7.0, -5.0, -2.0));
	block.var[1][1][2][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[2][0][0][0] = (vec3(9.0, 1.0, -1.0));
	block.var[2][0][0][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[2][0][0][2] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][0][3] = (vec3(5.0, 6.0, -6.0));
	block.var[2][0][1][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[2][0][1][1] = (vec3(7.0, 9.0, 8.0));
	block.var[2][0][1][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[2][0][1][3] = (vec3(6.0, -7.0, -3.0));
	block.var[2][0][2][0] = (vec3(7.0, -1.0, -4.0));
	block.var[2][0][2][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[2][0][2][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[2][0][2][3] = (vec3(1.0, 4.0, 5.0));
	block.var[2][1][0][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[2][1][0][1] = (vec3(3.0, -4.0, -1.0));
	block.var[2][1][0][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[2][1][0][3] = (vec3(-5.0, 7.0, 5.0));
	block.var[2][1][1][0] = (vec3(-1.0, -1.0, 5.0));
	block.var[2][1][1][1] = (vec3(9.0, 7.0, -5.0));
	block.var[2][1][1][2] = (vec3(3.0, -1.0, 3.0));
	block.var[2][1][1][3] = (vec3(8.0, -5.0, 3.0));
	block.var[2][1][2][0] = (vec3(-6.0, 1.0, 0.0));
	block.var[2][1][2][1] = (vec3(8.0, -8.0, 5.0));
	block.var[2][1][2][2] = (vec3(-3.0, 5.0, -4.0));
	block.var[2][1][2][3] = (vec3(-3.0, -2.0, 2.0));
	block.var[3][0][0][0] = (vec3(9.0, 8.0, 7.0));
	block.var[3][0][0][1] = (vec3(5.0, 4.0, 7.0));
	block.var[3][0][0][2] = (vec3(3.0, -3.0, 4.0));
	block.var[3][0][0][3] = (vec3(3.0, -6.0, 5.0));
	block.var[3][0][1][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[3][0][1][1] = (vec3(4.0, 8.0, -3.0));
	block.var[3][0][1][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][0][1][3] = (vec3(0.0, -3.0, -3.0));
	block.var[3][0][2][0] = (vec3(4.0, -2.0, -4.0));
	block.var[3][0][2][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[3][0][2][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[3][0][2][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[3][1][0][0] = (vec3(-5.0, 3.0, -6.0));
	block.var[3][1][0][1] = (vec3(-6.0, -4.0, -2.0));
	block.var[3][1][0][2] = (vec3(-5.0, -2.0, -2.0));
	block.var[3][1][0][3] = (vec3(-8.0, 2.0, 4.0));
	block.var[3][1][1][0] = (vec3(-1.0, -1.0, 1.0));
	block.var[3][1][1][1] = (vec3(-9.0, -7.0, -8.0));
	block.var[3][1][1][2] = (vec3(-8.0, -5.0, -1.0));
	block.var[3][1][1][3] = (vec3(2.0, 0.0, -4.0));
	block.var[3][1][2][0] = (vec3(7.0, 6.0, 4.0));
	block.var[3][1][2][1] = (vec3(-5.0, -5.0, 8.0));
	block.var[3][1][2][2] = (vec3(-3.0, 4.0, -5.0));
	block.var[3][1][2][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[0][0][2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[0][1][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	block.var[0][1][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	block.var[0][1][2] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	block.var[1][0][0] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[1][0][1] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[1][0][2] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[1][1][0] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	block.var[1][1][1] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	block.var[1][1][2] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	block.var[2][0][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[2][0][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[2][0][2] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[2][1][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	block.var[2][1][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	block.var[2][1][2] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	block.var[3][0][0] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[3][0][1] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[3][0][2] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	block.var[3][1][0] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	block.var[3][1][1] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	block.var[3][1][2] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[0][0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[0][1][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	block.var[0][1][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	block.var[0][1][2] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	block.var[1][0][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[1][0][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[1][0][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[1][1][0] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	block.var[1][1][1] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	block.var[1][1][2] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	block.var[2][0][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[2][0][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[2][0][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[2][1][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	block.var[2][1][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	block.var[2][1][2] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	block.var[3][0][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[3][0][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[3][0][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	block.var[3][1][0] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	block.var[3][1][1] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	block.var[3][1][2] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0] = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	block.var[0][0][1] = (mat4(6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0));
	block.var[0][0][2] = (mat4(-7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0));
	block.var[0][1][0] = (mat4(1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0, -1.0));
	block.var[0][1][1] = (mat4(8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0, 2.0));
	block.var[0][1][2] = (mat4(8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0, -7.0));
	block.var[1][0][0] = (mat4(3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0, -4.0));
	block.var[1][0][1] = (mat4(-1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0, -5.0));
	block.var[1][0][2] = (mat4(-1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0, 3.0));
	block.var[1][1][0] = (mat4(-5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0, 7.0));
	block.var[1][1][1] = (mat4(2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0, -4.0));
	block.var[1][1][2] = (mat4(-1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0, -2.0));
	block.var[2][0][0] = (mat4(6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0, 1.0));
	block.var[2][0][1] = (mat4(2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0, 2.0));
	block.var[2][0][2] = (mat4(4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0, 8.0));
	block.var[2][1][0] = (mat4(-1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0, 9.0));
	block.var[2][1][1] = (mat4(-7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0, -5.0));
	block.var[2][1][2] = (mat4(-6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0, 7.0));
	block.var[3][0][0] = (mat4(9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0, -8.0));
	block.var[3][0][1] = (mat4(6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0, -2.0));
	block.var[3][0][2] = (mat4(0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0, 5.0));
	block.var[3][1][0] = (mat4(1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0, 4.0));
	block.var[3][1][1] = (mat4(2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0, -8.0));
	block.var[3][1][2] = (mat4(9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-4.0, -6.0));
	block.var[0][0][0][1] = (vec2(1.0, -3.0));
	block.var[0][0][0][2] = (vec2(-1.0, -9.0));
	block.var[0][0][1][0] = (vec2(3.0, -2.0));
	block.var[0][0][1][1] = (vec2(5.0, -8.0));
	block.var[0][0][1][2] = (vec2(2.0, -9.0));
	block.var[0][1][0][0] = (vec2(-2.0, -3.0));
	block.var[0][1][0][1] = (vec2(-5.0, 1.0));
	block.var[0][1][0][2] = (vec2(-5.0, 8.0));
	block.var[0][1][1][0] = (vec2(7.0, 8.0));
	block.var[0][1][1][1] = (vec2(-1.0, -3.0));
	block.var[0][1][1][2] = (vec2(-8.0, 5.0));
	block.var[0][2][0][0] = (vec2(-1.0, -9.0));
	block.var[0][2][0][1] = (vec2(-8.0, 9.0));
	block.var[0][2][0][2] = (vec2(-1.0, -6.0));
	block.var[0][2][1][0] = (vec2(-5.0, 7.0));
	block.var[0][2][1][1] = (vec2(-8.0, -6.0));
	block.var[0][2][1][2] = (vec2(1.0, -5.0));
	block.var[0][3][0][0] = (vec2(-6.0, 5.0));
	block.var[0][3][0][1] = (vec2(6.0, -8.0));
	block.var[0][3][0][2] = (vec2(-2.0, -1.0));
	block.var[0][3][1][0] = (vec2(-3.0, -3.0));
	block.var[0][3][1][1] = (vec2(-5.0, 8.0));
	block.var[0][3][1][2] = (vec2(8.0, -7.0));
	block.var[1][0][0][0] = (vec2(1.0, -5.0));
	block.var[1][0][0][1] = (vec2(0.0, -2.0));
	block.var[1][0][0][2] = (vec2(2.0, -1.0));
	block.var[1][0][1][0] = (vec2(-7.0, 9.0));
	block.var[1][0][1][1] = (vec2(-8.0, 7.0));
	block.var[1][0][1][2] = (vec2(1.0, -9.0));
	block.var[1][1][0][0] = (vec2(6.0, 6.0));
	block.var[1][1][0][1] = (vec2(0.0, -8.0));
	block.var[1][1][0][2] = (vec2(-6.0, -4.0));
	block.var[1][1][1][0] = (vec2(-6.0, -5.0));
	block.var[1][1][1][1] = (vec2(8.0, 5.0));
	block.var[1][1][1][2] = (vec2(-9.0, 0.0));
	block.var[1][2][0][0] = (vec2(-3.0, 8.0));
	block.var[1][2][0][1] = (vec2(-2.0, 3.0));
	block.var[1][2][0][2] = (vec2(-2.0, 5.0));
	block.var[1][2][1][0] = (vec2(7.0, -3.0));
	block.var[1][2][1][1] = (vec2(4.0, 5.0));
	block.var[1][2][1][2] = (vec2(-9.0, 3.0));
	block.var[1][3][0][0] = (vec2(-6.0, 6.0));
	block.var[1][3][0][1] = (vec2(-9.0, 5.0));
	block.var[1][3][0][2] = (vec2(-5.0, 8.0));
	block.var[1][3][1][0] = (vec2(4.0, -5.0));
	block.var[1][3][1][1] = (vec2(1.0, 4.0));
	block.var[1][3][1][2] = (vec2(8.0, 1.0));
	block.var[2][0][0][0] = (vec2(-5.0, -5.0));
	block.var[2][0][0][1] = (vec2(9.0, 3.0));
	block.var[2][0][0][2] = (vec2(-3.0, -6.0));
	block.var[2][0][1][0] = (vec2(1.0, 3.0));
	block.var[2][0][1][1] = (vec2(-3.0, -4.0));
	block.var[2][0][1][2] = (vec2(-9.0, 4.0));
	block.var[2][1][0][0] = (vec2(6.0, -3.0));
	block.var[2][1][0][1] = (vec2(6.0, 0.0));
	block.var[2][1][0][2] = (vec2(1.0, 6.0));
	block.var[2][1][1][0] = (vec2(4.0, 4.0));
	block.var[2][1][1][1] = (vec2(0.0, -1.0));
	block.var[2][1][1][2] = (vec2(-2.0, 2.0));
	block.var[2][2][0][0] = (vec2(6.0, -1.0));
	block.var[2][2][0][1] = (vec2(-6.0, -5.0));
	block.var[2][2][0][2] = (vec2(7.0, -6.0));
	block.var[2][2][1][0] = (vec2(1.0, 8.0));
	block.var[2][2][1][1] = (vec2(7.0, -1.0));
	block.var[2][2][1][2] = (vec2(2.0, 6.0));
	block.var[2][3][0][0] = (vec2(8.0, -4.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(-5.0, -5.0));
	block.var[2][3][1][0] = (vec2(-4.0, 1.0));
	block.var[2][3][1][1] = (vec2(2.0, 4.0));
	block.var[2][3][1][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[0][1][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[0][1][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[0][2][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	block.var[0][2][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	block.var[0][3][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	block.var[0][3][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	block.var[1][0][0] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[1][0][1] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[1][1][0] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[1][1][1] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[1][2][0] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	block.var[1][2][1] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	block.var[1][3][0] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	block.var[1][3][1] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	block.var[2][0][0] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[2][0][1] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[2][1][0] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[2][1][1] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	block.var[2][2][0] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	block.var[2][2][1] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	block.var[2][3][0] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	block.var[2][3][1] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_uint((block[0].u), 9u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(1.0, -5.0, 0.0, -5.0, -7.0, -8.0, -5.0, -6.0, -9.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(8u, 9u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-6.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(1u, 3u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(3.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(3u, 9u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(5.0, 2.0, -6.0, 3.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -4) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-7.0, 1.0, -6.0, -8.0, -2.0, 6.0, -8.0, 6.0, -5.0, -3.0, -7.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(7u, 7u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(8.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(7u, 5u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(2.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(4u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(0.0, 2.0, 1.0, -2.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -2) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(-5.0, -7.0, 9.0, -1.0, -9.0, 9.0, 4.0, -3.0, 2.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(6u, 7u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(6.0, 0.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(8u, 8u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-5.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(6u, 5u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(-9.0, 2.0, 6.0, -7.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 3) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(0.0, -2.0, 3.0, -2.0, 5.0, -2.0, 8.0, 8.0, 8.0, 0.0, 9.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(9.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(9u, 1u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(7.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(8u, 9u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-8.0, -4.0, -9.0, -8.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 5) && allOk;
	allOk = compare_uint((block[1].u), 5u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-7.0, -4.0, -8.0, 5.0, 9.0, 5.0, -3.0, 0.0, -6.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(0u, 4u, 5u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(4.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(1u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(-2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(4.0, 4.0, 5.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(2u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(8.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-5.0, 5.0, -7.0, 9.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -1) && allOk;
	allOk = compare_uint((block[2].u), 6u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(0.0, 8.0, -8.0, -5.0, -1.0, -6.0, -7.0, -6.0, 2.0, 6.0, 2.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-4.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(1u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(7.0, -3.0, 8.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(0u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-4.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(5u, 2u, 6u));
	block[0].s.b[0] = (vec2(-3.0, -2.0));
	block[0].s.b[1] = (vec2(2.0, 9.0));
	block[0].s.b[2] = (vec2(8.0, -5.0));
	block[0].s.b[3] = (vec2(1.0, -8.0));
	block[0].s.c = (vec4(9.0, 6.0, -3.0, 0.0));
	block[0].u = (4u);
	block[1].s.a = (uvec3(0u, 6u, 4u));
	block[1].s.b[0] = (vec2(-4.0, 5.0));
	block[1].s.b[1] = (vec2(9.0, 7.0));
	block[1].s.b[2] = (vec2(5.0, 4.0));
	block[1].s.b[3] = (vec2(-8.0, -8.0));
	block[1].s.c = (vec4(1.0, 9.0, -3.0, -3.0));
	block[1].u = (5u);
	block[2].s.a = (uvec3(3u, 4u, 3u));
	block[2].s.b[0] = (vec2(6.0, 2.0));
	block[2].s.b[1] = (vec2(1.0, -6.0));
	block[2].s.b[2] = (vec2(2.0, 1.0));
	block[2].s.b[3] = (vec2(-3.0, -6.0));
	block[2].s.c = (vec4(7.0, -8.0, -8.0, -7.0));
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[3][3], 8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-5.0, 8.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(4.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 7.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-1.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-9.0, -9.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(6.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(6.0, 0.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-1.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(1.0, -1.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(6.0, 4.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block[0].var[1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block[0].var[2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block[0].var[3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block[1].var[0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block[1].var[1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block[1].var[2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block[1].var[3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block[2].var[0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block[2].var[1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block[2].var[2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block[2].var[3] = (vec4(9.0, 9.0, -5.0, -7.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(5.0, 8.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(6.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(6.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-6.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(1.0, 8.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-2.0, -9.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-1.0, -6.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-2.0, 9.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(4.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(9.0, -4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block[1].var = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block[2].var = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump mat3x4 a;
	lowp vec3 b;
	lowp uint c[3];
	bvec2 d;
	highp mat3x2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.e[0], mat3x2(1.0, -6.0, 0.0, 2.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[1], mat3x2(4.0, 1.0, -7.0, -5.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(8.0, 9.0, -5.0, 5.0, -4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0));
	blockB.c[0] = (8u);
	blockB.c[1] = (0u);
	blockB.c[2] = (8u);
	blockB.e[0] = (mat3x2(4.0, -7.0, 5.0, -6.0, 4.0, -3.0));
	blockB.e[1] = (mat3x2(9.0, 0.0, -8.0, 6.0, -8.0, -7.0));
}
#version 450
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
	mediump mat3x2 a;
	lowp vec3 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp uvec4 c;
	bvec2 d;
	lowp uint e;
	bvec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-8.0, 9.0, 9.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.b[0]), vec3(-6.0, -2.0, 8.0)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (uvec4(9u, 4u, 8u, 4u));
}
#version 450
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
	mediump ivec4 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump uvec2 b;
	mediump ivec3 c;
	highp ivec2 d[5];
	lowp uvec3 e;
	mediump mat2x3 f[][3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.b), uvec2(6u, 8u)) && allOk;
	allOk = compare_ivec2((blockC.d[0]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((blockC.d[1]), ivec2(-2, -8)) && allOk;
	allOk = compare_ivec2((blockC.d[2]), ivec2(-6, -1)) && allOk;
	allOk = compare_ivec2((blockC.d[3]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((blockC.d[4]), ivec2(7, 0)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(1u, 7u, 3u)) && allOk;
	allOk = compare_mat2x3(blockC.f[0][0], mat2x3(-2.0, -1.0, 5.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[0][1], mat2x3(3.0, 4.0, 5.0, -9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[0][2], mat2x3(3.0, 4.0, -5.0, -1.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1][0], mat2x3(-7.0, -3.0, 4.0, 6.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1][1], mat2x3(-3.0, 0.0, -7.0, 4.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1][2], mat2x3(-1.0, 8.0, 6.0, 6.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2][0], mat2x3(-2.0, -5.0, 4.0, -3.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2][1], mat2x3(5.0, -1.0, -6.0, 9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2][2], mat2x3(8.0, 4.0, -2.0, 5.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3][0], mat2x3(-2.0, 3.0, 6.0, -6.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3][1], mat2x3(-2.0, 1.0, -5.0, -4.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3][2], mat2x3(1.0, -5.0, 1.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4][0], mat2x3(-7.0, -6.0, 2.0, 8.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4][1], mat2x3(-9.0, 7.0, -3.0, 9.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4][2], mat2x3(0.0, 1.0, 9.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[5][0], mat2x3(-8.0, -2.0, 3.0, -8.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[5][1], mat2x3(1.0, -8.0, -3.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[5][2], mat2x3(8.0, 1.0, -1.0, -5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[6][0], mat2x3(2.0, 7.0, 1.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[6][1], mat2x3(2.0, 5.0, -9.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[6][2], mat2x3(6.0, 3.0, 7.0, -3.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0] = (ivec2(4, -1));
	blockC.d[1] = (ivec2(-4, -7));
	blockC.d[2] = (ivec2(-8, -3));
	blockC.d[3] = (ivec2(6, 5));
	blockC.d[4] = (ivec2(-2, -1));
	blockC.e = (uvec3(7u, 5u, 6u));
}
#version 450
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
	lowp mat4x2 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump mat3x2 a;
	lowp vec2 b;
	sA c[4];
	highp mat3x4 d;
	bvec4 e;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump vec4 f[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-8.0, -8.0, 0.0, -9.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_float((blockB.c[0].mA), -2.0) && allOk;
	allOk = compare_mat4x2(blockB.c[0].mB, mat4x2(1.0, -6.0, 9.0, 8.0, 3.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_float((blockB.c[1].mA), -5.0) && allOk;
	allOk = compare_mat4x2(blockB.c[1].mB, mat4x2(5.0, -9.0, -2.0, 4.0, -1.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_float((blockB.c[2].mA), 1.0) && allOk;
	allOk = compare_mat4x2(blockB.c[2].mB, mat4x2(-6.0, 8.0, -7.0, -4.0, -7.0, -2.0, 2.0, 7.0)) && allOk;
	allOk = compare_float((blockB.c[3].mA), 5.0) && allOk;
	allOk = compare_mat4x2(blockB.c[3].mB, mat4x2(8.0, -1.0, 5.0, 9.0, -1.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.d, mat3x4(3.0, 2.0, -3.0, -9.0, -2.0, 5.0, -8.0, -9.0, -5.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB.e), bvec4(false, false, true, false)) && allOk;
	allOk = compare_vec4((blockC.f[0]), vec4(2.0, 2.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC.f[1]), vec4(8.0, -2.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.f[2]), vec4(-4.0, 7.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.f[3]), vec4(6.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.f[4]), vec4(-9.0, 2.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC.f[5]), vec4(1.0, -3.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.f[6]), vec4(-9.0, -3.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.f[7]), vec4(-8.0, 7.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0));
	blockB.d = (mat3x4(9.0, 9.0, -2.0, 2.0, -6.0, 0.0, -6.0, -6.0, -4.0, -9.0, 4.0, -5.0));
	blockB.e = (bvec4(false, false, false, false));
	blockC.f[0] = (vec4(2.0, -2.0, 2.0, -1.0));
	blockC.f[1] = (vec4(7.0, -1.0, 3.0, 2.0));
	blockC.f[2] = (vec4(-8.0, 9.0, -3.0, 8.0));
	blockC.f[3] = (vec4(-7.0, -9.0, -5.0, 9.0));
	blockC.f[4] = (vec4(0.0, -7.0, 7.0, 7.0));
	blockC.f[5] = (vec4(3.0, -6.0, -4.0, 5.0));
	blockC.f[6] = (vec4(-1.0, -8.0, -9.0, -7.0));
	blockC.f[7] = (vec4(-4.0, -1.0, -2.0, -1.0));
}
#version 450
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
	layout(offset = 16) highp ivec3 b;
	layout(offset = 32) highp vec4 c[1];
	layout(offset = 48) mediump uint d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec4 e;
	layout(offset = 16) bool f;
	layout(offset = 32) bvec4 g;
	layout(offset = 48) bvec2 h;
	layout(offset = 56) mediump uint i[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(-3, -6, -8)) && allOk;
	allOk = compare_vec4((blockB.c[0]), vec4(6.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_uint((blockB.d), 5u) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(3, 0, 0, 5)) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec2((blockC.h), bvec2(true, true)) && allOk;
	allOk = compare_uint((blockC.i[0]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b = (ivec3(2, -5, 1));
	blockC.f = (true);
	blockC.g = (bvec4(true, true, false, false));
	blockC.i[0] = (8u);
}
#version 450
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
	layout(offset = 0) lowp ivec2 a;
	layout(offset = 16) lowp ivec4 b;
	layout(offset = 32) bvec3 c;
	layout(offset = 48) bvec4 d;
	layout(offset = 64) mediump vec2 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec3 f;
	layout(offset = 12) bool g[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp ivec4 h[1];
	layout(offset = 16) mediump ivec3 i;
	layout(offset = 32) highp ivec4 j;
	layout(offset = 48) lowp ivec3 k;
	layout(offset = 60) highp int l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-2, 1)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(2, -9, -3, -2)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec2((blockB.e), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(false, true, false)) && allOk;
	allOk = compare_bool((blockC.g[0]), true) && allOk;
	allOk = compare_ivec4((blockD.h[0]), ivec4(3, 4, -3, 2)) && allOk;
	allOk = compare_ivec3((blockD.i), ivec3(-7, 9, 3)) && allOk;
	allOk = compare_ivec4((blockD.j), ivec4(0, -6, -7, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(6, 1, -5, -5));
	blockB.c = (bvec3(false, true, false));
	blockB.d = (bvec4(true, false, false, true));
	blockB.e = (vec2(5.0, 1.0));
	blockC.f = (bvec3(false, false, true));
	blockD.h[0] = (ivec4(9, -5, 1, 5));
	blockD.i = (ivec3(0, 1, 7));
	blockD.k = (ivec3(6, -7, -1));
	blockD.l = (1);
}
#version 450
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
	layout(offset = 0) mediump uvec4 a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) lowp uvec4 c[1];
	layout(offset = 48) highp ivec3 d;
	layout(offset = 60) mediump float e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp float f;
	layout(offset = 4) lowp ivec2 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp vec4 h[1];
	layout(offset = 16) bool i;
	layout(offset = 32) lowp ivec4 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a), uvec4(8u, 4u, 2u, 8u)) && allOk;
	allOk = compare_bvec4((blockB[0].b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uvec4((blockB[1].a), uvec4(0u, 4u, 7u, 0u)) && allOk;
	allOk = compare_bvec4((blockB[1].b), bvec4(false, false, true, false)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(1, -5)) && allOk;
	allOk = compare_vec4((blockD.h[0]), vec4(-7.0, -8.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockD.j), ivec4(-8, 5, -7, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c[0] = (uvec4(8u, 5u, 9u, 2u));
	blockB[0].d = (ivec3(-4, -4, 4));
	blockB[0].e = (-8.0);
	blockB[1].c[0] = (uvec4(9u, 1u, 3u, 2u));
	blockB[1].d = (ivec3(-2, -1, 0));
	blockB[1].e = (-6.0);
	blockC.f = (4.0);
	blockD.h[0] = (vec4(-3.0, 6.0, -4.0, -3.0));
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

struct sA
{
	highp mat2 mA;
};
struct sB
{
	lowp mat2x3 mA;
	highp mat3x2 mB[2];
	lowp vec3 mC;
	highp uvec3 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp vec3 a;
	mediump vec2 b;
	highp vec4 c;
	lowp uvec3 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sA e;
	bvec2 f;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	mediump mat4x3 g[8][1];
	bvec3 h;
	lowp uvec2 i;
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	highp float j;
	sB k;
	lowp uvec2 l[4];
	lowp mat2 m[][5];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(8.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-7.0, 4.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockB.d[0]), uvec3(0u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.d[1]), uvec3(8u, 1u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.d[2]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.d[3]), uvec3(3u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.d[4]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.d[5]), uvec3(5u, 2u, 2u)) && allOk;
	allOk = compare_mat2(blockC.e.mA, mat2(-8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(1u, 4u)) && allOk;
	allOk = compare_mat2x3(blockE[0].k.mA, mat2x3(-2.0, -9.0, 8.0, -4.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].k.mB[0], mat3x2(7.0, -1.0, 3.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].k.mB[1], mat3x2(6.0, -1.0, -6.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3((blockE[0].k.mC), vec3(-2.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockE[0].k.mD), uvec3(9u, 9u, 2u)) && allOk;
	allOk = compare_uvec2((blockE[0].l[0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((blockE[0].l[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_uvec2((blockE[0].l[2]), uvec2(9u, 1u)) && allOk;
	allOk = compare_uvec2((blockE[0].l[3]), uvec2(6u, 5u)) && allOk;
	allOk = compare_mat2x3(blockE[1].k.mA, mat2x3(-9.0, 6.0, 9.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].k.mB[0], mat3x2(-8.0, -6.0, -5.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].k.mB[1], mat3x2(-4.0, 6.0, -3.0, 9.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec3((blockE[1].k.mC), vec3(-8.0, 9.0, 1.0)) && allOk;
	allOk = compare_uvec3((blockE[1].k.mD), uvec3(1u, 2u, 7u)) && allOk;
	allOk = compare_uvec2((blockE[1].l[0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_uvec2((blockE[1].l[1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((blockE[1].l[2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_uvec2((blockE[1].l[3]), uvec2(9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-8.0, -5.0, 7.0));
	blockB.d[0] = (uvec3(1u, 3u, 8u));
	blockB.d[1] = (uvec3(5u, 1u, 2u));
	blockB.d[2] = (uvec3(0u, 5u, 4u));
	blockB.d[3] = (uvec3(9u, 5u, 3u));
	blockB.d[4] = (uvec3(4u, 1u, 9u));
	blockB.d[5] = (uvec3(7u, 6u, 7u));
	blockC.f = (bvec2(false, false));
	blockD.i = (uvec2(7u, 2u));
	blockE[0].j = (6.0);
	blockE[0].k.mA = (mat2x3(3.0, -7.0, 3.0, -8.0, -9.0, 2.0));
	blockE[0].k.mB[0] = (mat3x2(-1.0, -6.0, -3.0, -3.0, -1.0, 6.0));
	blockE[0].k.mB[1] = (mat3x2(-8.0, 6.0, 9.0, 9.0, -6.0, -3.0));
	blockE[0].k.mC = (vec3(-5.0, 3.0, -4.0));
	blockE[0].k.mD = (uvec3(2u, 4u, 0u));
	blockE[0].m[0][0] = (mat2(-7.0, 8.0, 0.0, -7.0));
	blockE[0].m[0][1] = (mat2(0.0, 4.0, -9.0, 1.0));
	blockE[0].m[0][2] = (mat2(3.0, 7.0, 8.0, 5.0));
	blockE[0].m[0][3] = (mat2(-1.0, -5.0, 5.0, -4.0));
	blockE[0].m[0][4] = (mat2(9.0, -6.0, 7.0, -8.0));
	blockE[0].m[1][0] = (mat2(-4.0, 5.0, -1.0, -7.0));
	blockE[0].m[1][1] = (mat2(-6.0, -7.0, 8.0, -3.0));
	blockE[0].m[1][2] = (mat2(2.0, -8.0, 6.0, -1.0));
	blockE[0].m[1][3] = (mat2(7.0, 6.0, 7.0, -2.0));
	blockE[0].m[1][4] = (mat2(-9.0, 9.0, 2.0, -9.0));
	blockE[0].m[2][0] = (mat2(-1.0, -1.0, 0.0, -2.0));
	blockE[0].m[2][1] = (mat2(-7.0, 3.0, 8.0, -5.0));
	blockE[0].m[2][2] = (mat2(-6.0, 7.0, -9.0, -6.0));
	blockE[0].m[2][3] = (mat2(-8.0, 6.0, -3.0, 0.0));
	blockE[0].m[2][4] = (mat2(-3.0, -3.0, -7.0, -1.0));
	blockE[1].j = (-3.0);
	blockE[1].k.mA = (mat2x3(-7.0, -6.0, 6.0, 1.0, 6.0, 3.0));
	blockE[1].k.mB[0] = (mat3x2(-4.0, 2.0, -9.0, -8.0, 3.0, 8.0));
	blockE[1].k.mB[1] = (mat3x2(1.0, 0.0, 7.0, 4.0, 5.0, 6.0));
	blockE[1].k.mC = (vec3(-9.0, -9.0, 6.0));
	blockE[1].k.mD = (uvec3(4u, 7u, 4u));
	blockE[1].m[0][0] = (mat2(3.0, 4.0, -2.0, -5.0));
	blockE[1].m[0][1] = (mat2(2.0, -2.0, -2.0, -2.0));
	blockE[1].m[0][2] = (mat2(7.0, -5.0, 7.0, 9.0));
	blockE[1].m[0][3] = (mat2(-6.0, -4.0, 3.0, -4.0));
	blockE[1].m[0][4] = (mat2(-6.0, -3.0, 3.0, 7.0));
	blockE[1].m[1][0] = (mat2(-5.0, -7.0, 3.0, -8.0));
	blockE[1].m[1][1] = (mat2(2.0, -9.0, 0.0, 1.0));
	blockE[1].m[1][2] = (mat2(1.0, 3.0, 8.0, 2.0));
	blockE[1].m[1][3] = (mat2(2.0, -3.0, -8.0, 0.0));
	blockE[1].m[1][4] = (mat2(1.0, -3.0, -1.0, 1.0));
	blockE[1].m[2][0] = (mat2(2.0, -2.0, -3.0, 2.0));
	blockE[1].m[2][1] = (mat2(-3.0, 3.0, -4.0, -5.0));
	blockE[1].m[2][2] = (mat2(-1.0, 0.0, -2.0, 3.0));
	blockE[1].m[2][3] = (mat2(-5.0, -9.0, -5.0, 3.0));
	blockE[1].m[2][4] = (mat2(-3.0, 1.0, -8.0, 9.0));
	blockE[1].m[3][0] = (mat2(6.0, -9.0, -9.0, 3.0));
	blockE[1].m[3][1] = (mat2(-6.0, 9.0, 2.0, -4.0));
	blockE[1].m[3][2] = (mat2(-5.0, 8.0, -9.0, -4.0));
	blockE[1].m[3][3] = (mat2(-1.0, -2.0, -7.0, -5.0));
	blockE[1].m[3][4] = (mat2(-6.0, 9.0, 1.0, 2.0));
	blockE[1].m[4][0] = (mat2(5.0, -6.0, 9.0, 2.0));
	blockE[1].m[4][1] = (mat2(-9.0, 5.0, 5.0, -8.0));
	blockE[1].m[4][2] = (mat2(0.0, -5.0, -2.0, -2.0));
	blockE[1].m[4][3] = (mat2(-5.0, -7.0, -7.0, 8.0));
	blockE[1].m[4][4] = (mat2(-1.0, 3.0, -1.0, 7.0));
	blockE[1].m[5][0] = (mat2(1.0, -4.0, 9.0, -8.0));
	blockE[1].m[5][1] = (mat2(-2.0, 9.0, 0.0, 9.0));
	blockE[1].m[5][2] = (mat2(-1.0, -8.0, 2.0, 7.0));
	blockE[1].m[5][3] = (mat2(-4.0, 6.0, -3.0, 5.0));
	blockE[1].m[5][4] = (mat2(-9.0, -2.0, 6.0, 8.0));
	blockE[1].m[6][0] = (mat2(4.0, 2.0, 5.0, -5.0));
	blockE[1].m[6][1] = (mat2(-6.0, 5.0, 4.0, 1.0));
	blockE[1].m[6][2] = (mat2(-8.0, -8.0, -8.0, -8.0));
	blockE[1].m[6][3] = (mat2(8.0, -9.0, -2.0, -6.0));
	blockE[1].m[6][4] = (mat2(-4.0, 1.0, 4.0, -9.0));
	blockE[1].m[7][0] = (mat2(5.0, 7.0, -2.0, -4.0));
	blockE[1].m[7][1] = (mat2(-3.0, 1.0, 4.0, 3.0));
	blockE[1].m[7][2] = (mat2(-1.0, -1.0, -9.0, -8.0));
	blockE[1].m[7][3] = (mat2(-3.0, -8.0, -7.0, 9.0));
	blockE[1].m[7][4] = (mat2(2.0, 2.0, -5.0, 2.0));
}
#version 450
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
	i16vec3 a[1];
	highp float b;
	lowp ivec2 c;
	highp uvec3 d;
	uint16_t e;
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec3 f[1];
	f16vec3 g;
	f16vec4 h;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a[0]), ivec3(6, 8, 8)) && allOk;
	allOk = compare_float((blockB.b), 0.0) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-4, -5)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.g), vec3(7.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.h), vec4(-9.0, 8.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec3(ivec3(-5, -3, -2));
	blockB.b = (0.0);
	blockB.c = (ivec2(-6, 6));
	blockB.d = (uvec3(2u, 8u, 6u));
	blockB.e = uint16_t(5u);
	blockC.h = f16vec4(vec4(-4.0, -6.0, -7.0, -7.0));
	blockD.i = (ivec3(-4, 8, 2));
}
#version 450
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
	uint16_t a;
	bool b;
	highp vec2 c[7];
	mediump mat4x3 d;
	lowp vec2 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp ivec2 f;
	lowp mat2x3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.c[0]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.c[1]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.c[2]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.c[3]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.c[4]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.c[5]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.c[6]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(1.0, -1.0, -6.0, 3.0, -7.0, 4.0, 1.0, -6.0, -7.0, 2.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.e[0]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.e[1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB.e[2]), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-6, 7)) && allOk;
	allOk = compare_mat2x3(blockC.g[0], mat2x3(-7.0, 9.0, -2.0, 7.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.g[1], mat2x3(-8.0, -8.0, 0.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC.g[2], mat2x3(-4.0, -9.0, -8.0, 2.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.g[3], mat2x3(1.0, 7.0, 8.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockC.g[4], mat2x3(8.0, 4.0, -3.0, 0.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(5u);
	blockB.b = (true);
	blockB.e[0] = (vec2(-3.0, -2.0));
	blockB.e[1] = (vec2(-6.0, -2.0));
	blockB.e[2] = (vec2(5.0, -3.0));
	blockC.f = (ivec2(2, 0));
}
#version 450
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
	mediump mat2 a;
	mediump float b[2];
	lowp vec2 c;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	float16_t d;
	u16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-2.0, 4.0, 8.0, -9.0)) && allOk;
	allOk = compare_float((blockB.b[0]), 4.0) && allOk;
	allOk = compare_float((blockB.b[1]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockC.d), 2.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.e), uvec3(3u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (vec2(8.0, 1.0));
	blockC.d = float16_t(-6.0);
}
#version 450
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
	layout(offset = 0) mediump uvec4 a;
	layout(offset = 16) highp int b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec4 c;
	layout(offset = 16) mediump ivec3 d[1];
	layout(offset = 32) bvec2 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec2 f;
	layout(offset = 8) mediump uint g[1];
	layout(offset = 16) bvec4 h;
	layout(offset = 32) float16_t i;
	layout(offset = 48) bvec4 j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp vec4 k;
	layout(offset = 16) mediump int l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a), uvec4(6u, 0u, 0u, 6u)) && allOk;
	allOk = compare_int((blockB[0].b), 4) && allOk;
	allOk = compare_uvec4((blockC.c), uvec4(3u, 6u, 2u, 8u)) && allOk;
	allOk = compare_ivec3((blockC.d[0]), ivec3(-9, -1, -4)) && allOk;
	allOk = compare_uint((blockD.g[0]), 1u) && allOk;
	allOk = compare_float16_t(float(blockD.i), 8.0) && allOk;
	allOk = compare_bvec4((blockD.j), bvec4(true, false, true, false)) && allOk;
	allOk = compare_vec4((blockE.k), vec4(-6.0, -3.0, -4.0, -8.0)) && allOk;
	allOk = compare_int((blockE.l), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (uvec4(9u, 3u, 8u, 9u));
	blockC.e = (bvec2(false, true));
	blockD.f = (uvec2(1u, 1u));
	blockD.g[0] = (6u);
	blockD.h = (bvec4(true, false, false, false));
	blockD.i = float16_t(-7.0);
	blockE.k = (vec4(-8.0, 3.0, -5.0, -8.0));
}
#version 450
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
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) u16vec4 c[1];
	layout(offset = 24) i16vec2 d;
	layout(offset = 32) f16vec4 e[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump float f[1];
	layout(offset = 4) mediump ivec3 g;
	layout(offset = 16) bool h[1];
	layout(offset = 20) i16vec4 i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec3 j;
	layout(offset = 16) mediump ivec3 k;
	layout(offset = 32) bvec2 l;
	layout(offset = 40) i16vec4 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].b), uvec2(6u, 8u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[0].d), ivec2(9, 0)) && allOk;
	allOk = compare_uvec2((blockB[1].b), uvec2(8u, 0u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[1].d), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.i), ivec4(0, 1, -5, -7)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.j), uvec3(2u, 7u, 2u)) && allOk;
	allOk = compare_bvec2((blockD.l), bvec2(true, false)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.m), ivec4(-9, -1, -5, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec2(true, true));
	blockB[0].c[0] = u16vec4(uvec4(6u, 5u, 2u, 8u));
	blockB[0].d = i16vec2(ivec2(-7, -5));
	blockB[0].e[0] = f16vec4(vec4(-1.0, -4.0, -4.0, 4.0));
	blockB[1].a = (bvec2(true, true));
	blockB[1].c[0] = u16vec4(uvec4(5u, 2u, 7u, 9u));
	blockB[1].d = i16vec2(ivec2(-7, -1));
	blockB[1].e[0] = f16vec4(vec4(0.0, -2.0, -1.0, 0.0));
	blockC.f[0] = (-6.0);
	blockC.g = (ivec3(4, -1, -2));
	blockC.h[0] = (false);
	blockC.i = i16vec4(ivec4(6, -4, -3, -1));
	blockD.j = u16vec3(uvec3(7u, 7u, 7u));
	blockD.k = (ivec3(-9, 2, 4));
	blockD.m = i16vec4(ivec4(-6, 4, -5, -7));
}
#version 450
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
	bvec3 mB;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	mediump mat4x2 a;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	sA b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp mat3 c[3];
	i16vec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockD.d), ivec3(-9, -1, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0].mA = u16vec2(uvec2(3u, 2u));
	blockC.b[0].mB = (bvec3(true, false, true));
	blockD.c[0] = (mat3(-7.0, 9.0, -7.0, 4.0, -5.0, 7.0, 4.0, 3.0, -6.0));
	blockD.c[1] = (mat3(7.0, -9.0, 4.0, 8.0, -4.0, 8.0, 7.0, 8.0, 5.0));
	blockD.c[2] = (mat3(7.0, -8.0, 3.0, -5.0, 6.0, 0.0, 4.0, 1.0, -8.0));
	blockD.d = i16vec3(ivec3(-1, -3, 5));
}
#version 450
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
	mediump uvec4 a[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	lowp mat2 b;
	highp mat4 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	u8vec4 d;
	i8vec3 e[1];
	bvec2 f;
	highp float g;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	bvec2 h;
	i8vec3 i;
	highp float j[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a[0]), uvec4(2u, 5u, 1u, 9u)) && allOk;
	allOk = compare_mat2(blockC.b, mat2(2.0, 4.0, -1.0, 1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.d), uvec4(8u, 0u, 4u, 0u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.e[0]), ivec3(4294967289, 4294967291, 4294967289)) && allOk;
	allOk = compare_bvec2((blockD.f), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.h), bvec2(false, true)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.i), ivec3(4294967293, 1, 4294967290)) && allOk;
	allOk = compare_float((blockE.j[0]), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(6u, 8u, 4u, 7u));
	blockD.d = u8vec4(uvec4(2u, 7u, 2u, 4u));
	blockD.e[0] = i8vec3(ivec3(2, 4294967291, 6));
	blockD.f = (bvec2(false, false));
	blockE.h = (bvec2(true, false));
}
#version 450
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
	i8vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[0]), ivec2(2, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[1]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[2]), ivec2(2, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[3]), ivec2(8, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[4]), ivec2(4294967288, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = i8vec2(ivec2(4294967292, 5));
	blockB.c[1] = i8vec2(ivec2(7, 9));
	blockB.c[2] = i8vec2(ivec2(4294967294, 6));
	blockB.c[3] = i8vec2(ivec2(4, 0));
	blockB.c[4] = i8vec2(ivec2(7, 5));
}
#version 450
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
	lowp ivec4 a[8];
	u8vec4 b[];
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	lowp ivec2 c;
	u8vec4 d;
	u8vec2 e;
	mediump uvec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB[0].b[0]), uvec4(7u, 1u, 6u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[1]), uvec4(6u, 3u, 5u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[2]), uvec4(9u, 0u, 3u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[3]), uvec4(9u, 1u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[4]), uvec4(2u, 5u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[5]), uvec4(8u, 3u, 1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[0]), uvec4(0u, 1u, 0u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[1]), uvec4(6u, 7u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[2]), uvec4(6u, 0u, 7u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[3]), uvec4(8u, 1u, 1u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[4]), uvec4(6u, 3u, 1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[5]), uvec4(9u, 5u, 5u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[6]), uvec4(4u, 1u, 6u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.f[0]), uvec3(3u, 4u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.f[1]), uvec3(1u, 7u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.f[2]), uvec3(5u, 3u, 9u)) && allOk;
	allOk = compare_uvec3((blockC.f[3]), uvec3(7u, 4u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.f[4]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.f[5]), uvec3(5u, 8u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.f[6]), uvec3(7u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.f[7]), uvec3(5u, 1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = u8vec4(uvec4(3u, 4u, 5u, 7u));
	blockB[0].b[1] = u8vec4(uvec4(3u, 8u, 1u, 8u));
	blockB[0].b[2] = u8vec4(uvec4(7u, 6u, 1u, 3u));
	blockB[0].b[3] = u8vec4(uvec4(3u, 0u, 3u, 6u));
	blockB[0].b[4] = u8vec4(uvec4(5u, 1u, 6u, 3u));
	blockB[0].b[5] = u8vec4(uvec4(3u, 3u, 1u, 0u));
	blockB[1].b[0] = u8vec4(uvec4(4u, 4u, 7u, 3u));
	blockB[1].b[1] = u8vec4(uvec4(0u, 7u, 7u, 0u));
	blockB[1].b[2] = u8vec4(uvec4(1u, 1u, 4u, 0u));
	blockB[1].b[3] = u8vec4(uvec4(6u, 9u, 3u, 3u));
	blockB[1].b[4] = u8vec4(uvec4(5u, 4u, 3u, 0u));
	blockB[1].b[5] = u8vec4(uvec4(0u, 8u, 6u, 4u));
	blockB[1].b[6] = u8vec4(uvec4(0u, 0u, 4u, 8u));
}
