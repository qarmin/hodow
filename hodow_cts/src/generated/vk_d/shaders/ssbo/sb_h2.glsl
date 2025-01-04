#version 450
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
	lowp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(3.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec3(-8.0, -5.0, 8.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -7.0, 5.0, 2.0, 1.0, 1.0, -5.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(5.0, 1.0, 8.0, -8.0, -6.0, -2.0, 1.0, 6.0, 1.0));
}
#version 450
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

	var[0] = (vec4(3.0, -7.0, -8.0, -2.0));
	var[1] = (vec4(6.0, 5.0, 7.0, 1.0));
	var[2] = (vec4(-9.0, -8.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -9.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-5.0, 5.0, -3.0, 7.0));
	var[1] = (vec4(4.0, -6.0, 0.0, 2.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(2.0, -9.0, -3.0, 3.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-9.0, 0.0, 7.0, 6.0, 0.0, 3.0));
}
#version 450
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
	mediump vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_vec4((var), vec4(4.0, -7.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var = (vec4(6.0, 7.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var = (mat2(-6.0, -5.0, -4.0, 7.0));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec2(-9.0, -7.0));
	var[1] = (vec2(2.0, -2.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat2(4.0, -1.0, 3.0, 9.0));
}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(6.0, -4.0, 0.0, -4.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var = (mat3x2(6.0, -1.0, 9.0, 4.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
}
#version 450
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
	highp mat2x4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-4.0, -3.0, 8.0, 7.0, -3.0, -7.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-9.0, -1.0, 8.0, 8.0, 3.0, -1.0, 6.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0] = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	var[1] = (mat3(-5.0, -5.0, 8.0, -2.0, -5.0, 5.0, -1.0, 7.0, 3.0));
	var[2] = (mat3(-2.0, 3.0, 5.0, 5.0, 1.0, -6.0, 9.0, -7.0, -5.0));
}
#version 450
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
	u16vec3 var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(1u, 1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(1u);
	var[0] = u16vec3(uvec3(2u, 6u, 8u));
	var[1] = u16vec3(uvec3(3u, 3u, 4u));
	var[2] = u16vec3(uvec3(4u, 9u, 7u));
}
#version 450
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
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	var[3][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[3][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[3][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[3][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[4][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[4][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[4][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[4][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[5][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[5][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[5][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[5][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[6][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[6][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[6][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[6][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[7][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[7][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[7][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[7][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[8][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[8][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[8][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[8][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[9][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[9][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[9][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[9][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[10][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[10][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[10][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[10][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[11][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[11][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[11][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[11][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	var[12][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	var[12][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	var[12][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	var[12][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	var[13][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	var[13][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	var[13][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	var[13][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	var[14][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	var[14][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	var[14][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	var[14][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	var[15][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	var[15][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	var[15][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	var[15][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	var[16][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	var[16][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	var[16][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	var[16][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	var[17][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	var[17][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	var[17][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	var[17][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	var[18][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	var[18][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	var[18][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	var[18][3] = (vec4(5.0, 7.0, -3.0, -7.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[3] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[4] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[5] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[6] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[7] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[8] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[9] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[10] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[11] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	var[12] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	var[13] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	var[14] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	var[15] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	var[16] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	var[17] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	var[18] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[0][2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[0][2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[1][0][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[1][0][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][1][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[1][1][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[1][1][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[1][2][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[1][2][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[1][2][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[2][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[2][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[2][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[2][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[2][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[2][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[2][2][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[2][2][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[2][2][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[3][0][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[3][0][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[3][0][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[3][1][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[3][1][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[3][1][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[3][2][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[3][2][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[3][2][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
}
#version 450
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
	i8vec3 var[4][3];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][2]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][2]), ivec3(2, 4294967294, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i8vec3(ivec3(4294967292, 0, 0));
	var[0][1] = i8vec3(ivec3(7, 9, 4294967290));
	var[0][2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[1][0] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[1][1] = i8vec3(ivec3(9, 7, 5));
	var[1][2] = i8vec3(ivec3(5, 4294967293, 6));
	var[2][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[2][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[2][2] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[3][0] = i8vec3(ivec3(3, 7, 4));
	var[3][1] = i8vec3(ivec3(4294967292, 8, 8));
	var[3][2] = i8vec3(ivec3(4294967294, 8, 1));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[0][2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[1][0] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[1][1] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[1][2] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[2][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[2][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[2][2] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[3][0] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[3][1] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[3][2] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
}
#version 450
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
	u16vec4 var[4][3];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[1][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[1][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[1][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[2][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[2][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[2][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[3][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[3][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[3][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
}
#version 450
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
	highp ivec4 var[4][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -7) && allOk;
	allOk = compare_ivec4((var[0][0]), ivec4(9, -5, 6, 3)) && allOk;
	allOk = compare_ivec4((var[0][1]), ivec4(4, 2, -3, -3)) && allOk;
	allOk = compare_ivec4((var[0][2]), ivec4(-3, -5, -5, 3)) && allOk;
	allOk = compare_ivec4((var[1][0]), ivec4(-5, -9, -7, 1)) && allOk;
	allOk = compare_ivec4((var[1][1]), ivec4(5, 9, 7, -4)) && allOk;
	allOk = compare_ivec4((var[1][2]), ivec4(-1, 8, -1, 4)) && allOk;
	allOk = compare_ivec4((var[2][0]), ivec4(3, 6, -6, 1)) && allOk;
	allOk = compare_ivec4((var[2][1]), ivec4(-3, 0, 0, 1)) && allOk;
	allOk = compare_ivec4((var[2][2]), ivec4(-6, 0, -7, 6)) && allOk;
	allOk = compare_ivec4((var[3][0]), ivec4(-4, -4, 0, 8)) && allOk;
	allOk = compare_ivec4((var[3][1]), ivec4(-3, 3, 3, -3)) && allOk;
	allOk = compare_ivec4((var[3][2]), ivec4(1, 3, 1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5);
	var[0][0] = (ivec4(-9, 5, -6, -2));
	var[0][1] = (ivec4(-4, 1, -9, 7));
	var[0][2] = (ivec4(3, 6, 8, 6));
	var[1][0] = (ivec4(-4, 6, -7, 9));
	var[1][1] = (ivec4(-8, -9, 0, 5));
	var[1][2] = (ivec4(-7, 2, 9, 6));
	var[2][0] = (ivec4(5, 4, 0, 5));
	var[2][1] = (ivec4(9, 0, 0, -6));
	var[2][2] = (ivec4(4, 4, 2, 9));
	var[3][0] = (ivec4(7, 5, 5, 3));
	var[3][1] = (ivec4(-3, -9, -8, -6));
	var[3][2] = (ivec4(3, 2, 0, 7));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(3.0, -1.0, 3.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-8.0, 5.0, -4.0, 8.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-1.0, -9.0, -5.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(1.0, -2.0, -4.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(0.0, 1.0, 7.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(4.0, -7.0, 8.0, 0.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(1.0, -4.0, -3.0, 4.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(1.0, 0.0, 8.0, -1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(6.0, 8.0, 7.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-6.0, 0.0, 7.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-5.0, -6.0, 5.0, -8.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0] = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	var[0][1] = (mat3x2(-8.0, -2.0, 3.0, 4.0, 9.0, 4.0));
	var[0][2] = (mat3x2(-7.0, 9.0, 9.0, -1.0, 1.0, -9.0));
	var[1][0] = (mat3x2(0.0, -8.0, -3.0, 8.0, 3.0, 5.0));
	var[1][1] = (mat3x2(9.0, 0.0, 9.0, 8.0, 0.0, 2.0));
	var[1][2] = (mat3x2(0.0, 7.0, 6.0, 4.0, 6.0, 9.0));
	var[2][0] = (mat3x2(7.0, -2.0, 8.0, 3.0, 7.0, -9.0));
	var[2][1] = (mat3x2(4.0, -5.0, 3.0, -6.0, 8.0, 7.0));
	var[2][2] = (mat3x2(6.0, 3.0, 5.0, 1.0, 2.0, 0.0));
	var[3][0] = (mat3x2(-4.0, 0.0, -9.0, 0.0, 8.0, 7.0));
	var[3][1] = (mat3x2(5.0, -1.0, 3.0, -3.0, 3.0, -2.0));
	var[3][2] = (mat3x2(0.0, -5.0, -9.0, -4.0, 1.0, 7.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0][0] = (vec4(8.0, -2.0, 8.0, 8.0));
	var[0][0][1] = (vec4(3.0, 5.0, -5.0, 7.0));
	var[0][0][2] = (vec4(6.0, -9.0, 3.0, 0.0));
	var[0][1][0] = (vec4(-3.0, 1.0, -9.0, -9.0));
	var[0][1][1] = (vec4(-6.0, -5.0, 1.0, 9.0));
	var[0][1][2] = (vec4(0.0, -9.0, -2.0, -4.0));
	var[0][2][0] = (vec4(-3.0, -1.0, -6.0, 1.0));
	var[0][2][1] = (vec4(-2.0, -2.0, -1.0, -7.0));
	var[0][2][2] = (vec4(8.0, 0.0, -6.0, -1.0));
	var[1][0][0] = (vec4(7.0, -6.0, -1.0, -7.0));
	var[1][0][1] = (vec4(-8.0, 7.0, -8.0, 6.0));
	var[1][0][2] = (vec4(-8.0, 2.0, -5.0, 9.0));
	var[1][1][0] = (vec4(-7.0, 4.0, -1.0, -3.0));
	var[1][1][1] = (vec4(-8.0, -1.0, 1.0, -6.0));
	var[1][1][2] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[1][2][0] = (vec4(0.0, -6.0, 5.0, -1.0));
	var[1][2][1] = (vec4(4.0, 3.0, -6.0, 1.0));
	var[1][2][2] = (vec4(8.0, -2.0, 3.0, -1.0));
	var[2][0][0] = (vec4(-9.0, 4.0, 9.0, 0.0));
	var[2][0][1] = (vec4(2.0, -7.0, -7.0, -1.0));
	var[2][0][2] = (vec4(8.0, -9.0, -3.0, 5.0));
	var[2][1][0] = (vec4(7.0, -8.0, 1.0, -5.0));
	var[2][1][1] = (vec4(0.0, -7.0, -3.0, -5.0));
	var[2][1][2] = (vec4(-4.0, 3.0, -5.0, 4.0));
	var[2][2][0] = (vec4(5.0, -9.0, -6.0, 5.0));
	var[2][2][1] = (vec4(3.0, -6.0, -7.0, -3.0));
	var[2][2][2] = (vec4(9.0, 3.0, -7.0, -9.0));
	var[3][0][0] = (vec4(-9.0, 6.0, -9.0, 6.0));
	var[3][0][1] = (vec4(-1.0, -1.0, -4.0, 5.0));
	var[3][0][2] = (vec4(2.0, -6.0, 8.0, 4.0));
	var[3][1][0] = (vec4(2.0, 4.0, -3.0, 9.0));
	var[3][1][1] = (vec4(8.0, 5.0, -3.0, 7.0));
	var[3][1][2] = (vec4(-4.0, 6.0, 4.0, 0.0));
	var[3][2][0] = (vec4(-2.0, 1.0, 8.0, 1.0));
	var[3][2][1] = (vec4(4.0, 6.0, 4.0, -2.0));
	var[3][2][2] = (vec4(9.0, 9.0, 7.0, 4.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0] = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	var[0][1] = (mat4x2(8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0));
	var[0][2] = (mat4x2(-9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0, 8.0));
	var[1][0] = (mat4x2(7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0, 1.0));
	var[1][1] = (mat4x2(6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0, 3.0));
	var[1][2] = (mat4x2(-5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0, -4.0));
	var[2][0] = (mat4x2(4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0, 8.0));
	var[2][1] = (mat4x2(-4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0, -4.0));
	var[2][2] = (mat4x2(-8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0, -5.0));
	var[3][0] = (mat4x2(7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0, 6.0));
	var[3][1] = (mat4x2(-7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0, 3.0));
	var[3][2] = (mat4x2(-8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0, 8.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(2.0, -8.0, 8.0, -6.0, -1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(6.0, -4.0, -3.0, -9.0, -3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-7.0, 8.0, 6.0, 5.0, 7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(8.0, 6.0, 8.0, 2.0, -4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(2.0, -5.0, 8.0, -7.0, -1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[0][0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[0][0][2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	var[0][1][0] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	var[0][1][1] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	var[0][1][2] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	var[1][0][0] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	var[1][0][1] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	var[1][0][2] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	var[1][1][0] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	var[1][1][1] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	var[1][1][2] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	var[2][0][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	var[2][0][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	var[2][0][2] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	var[2][1][0] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
	var[2][1][1] = (mat4(-8.0, 1.0, -8.0, -4.0, 4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0));
	var[2][1][2] = (mat4(9.0, 7.0, -2.0, -4.0, 8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0));
	var[3][0][0] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	var[3][0][1] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	var[3][0][2] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	var[3][1][0] = (mat4(3.0, 4.0, 2.0, 1.0, -9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0));
	var[3][1][1] = (mat4(3.0, -6.0, -2.0, 7.0, -7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0));
	var[3][1][2] = (mat4(-5.0, -6.0, 4.0, 9.0, 2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(1.0, 4.0, -6.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(1.0, -7.0, -5.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(4.0, 5.0, 5.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-6.0, 0.0, -5.0, 2.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-6.0, -8.0, -1.0, -8.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[0][0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[0][0][2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	var[0][1][0] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	var[0][1][1] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	var[0][1][2] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	var[1][0][0] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	var[1][0][1] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	var[1][0][2] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	var[1][1][0] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	var[1][1][1] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	var[1][1][2] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	var[2][0][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	var[2][0][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	var[2][0][2] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	var[2][1][0] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
	var[2][1][1] = (mat2x3(3.0, 8.0, -9.0, 8.0, 6.0, 0.0));
	var[2][1][2] = (mat2x3(2.0, 3.0, 4.0, 3.0, 4.0, 2.0));
	var[3][0][0] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	var[3][0][1] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	var[3][0][2] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	var[3][1][0] = (mat2x3(-1.0, -4.0, 9.0, -8.0, 2.0, 8.0));
	var[3][1][1] = (mat2x3(6.0, -6.0, 4.0, -3.0, -1.0, -9.0));
	var[3][1][2] = (mat2x3(6.0, 3.0, -4.0, -2.0, 7.0, -7.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(3.0, -2.0, -1.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-5.0, -2.0, 9.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(4.0, -4.0, -3.0, -5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-2.0, 0.0, 3.0, 7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(7.0, 7.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][0][0][1] = (vec3(0.0, -8.0, -2.0));
	var[0][0][1][0] = (vec3(8.0, 8.0, 0.0));
	var[0][0][1][1] = (vec3(3.0, -6.0, -6.0));
	var[0][0][2][0] = (vec3(-1.0, 2.0, -9.0));
	var[0][0][2][1] = (vec3(1.0, 3.0, 2.0));
	var[0][1][0][0] = (vec3(-7.0, 8.0, -3.0));
	var[0][1][0][1] = (vec3(3.0, 8.0, 1.0));
	var[0][1][1][0] = (vec3(3.0, 6.0, 2.0));
	var[0][1][1][1] = (vec3(9.0, -2.0, -9.0));
	var[0][1][2][0] = (vec3(-9.0, 6.0, -2.0));
	var[0][1][2][1] = (vec3(-3.0, -8.0, -5.0));
	var[1][0][0][0] = (vec3(1.0, 5.0, -6.0));
	var[1][0][0][1] = (vec3(-8.0, -6.0, -5.0));
	var[1][0][1][0] = (vec3(-9.0, 6.0, -9.0));
	var[1][0][1][1] = (vec3(0.0, -1.0, -3.0));
	var[1][0][2][0] = (vec3(-6.0, 9.0, 7.0));
	var[1][0][2][1] = (vec3(-5.0, -7.0, -2.0));
	var[1][1][0][0] = (vec3(-2.0, -5.0, 0.0));
	var[1][1][0][1] = (vec3(-9.0, -9.0, -9.0));
	var[1][1][1][0] = (vec3(-9.0, -3.0, -1.0));
	var[1][1][1][1] = (vec3(7.0, 1.0, 1.0));
	var[1][1][2][0] = (vec3(4.0, -2.0, 7.0));
	var[1][1][2][1] = (vec3(0.0, 1.0, 9.0));
	var[2][0][0][0] = (vec3(-1.0, -3.0, 0.0));
	var[2][0][0][1] = (vec3(3.0, 3.0, 5.0));
	var[2][0][1][0] = (vec3(-1.0, -1.0, 3.0));
	var[2][0][1][1] = (vec3(-1.0, -7.0, 7.0));
	var[2][0][2][0] = (vec3(-6.0, -6.0, -8.0));
	var[2][0][2][1] = (vec3(2.0, -4.0, -3.0));
	var[2][1][0][0] = (vec3(-4.0, 0.0, -1.0));
	var[2][1][0][1] = (vec3(8.0, 9.0, -4.0));
	var[2][1][1][0] = (vec3(6.0, 5.0, -2.0));
	var[2][1][1][1] = (vec3(0.0, 6.0, 6.0));
	var[2][1][2][0] = (vec3(3.0, 8.0, 3.0));
	var[2][1][2][1] = (vec3(2.0, 2.0, -8.0));
	var[3][0][0][0] = (vec3(-3.0, 4.0, 8.0));
	var[3][0][0][1] = (vec3(7.0, -2.0, -7.0));
	var[3][0][1][0] = (vec3(-5.0, 5.0, -5.0));
	var[3][0][1][1] = (vec3(1.0, -1.0, 7.0));
	var[3][0][2][0] = (vec3(-5.0, 8.0, -7.0));
	var[3][0][2][1] = (vec3(-2.0, 4.0, 3.0));
	var[3][1][0][0] = (vec3(0.0, -1.0, 2.0));
	var[3][1][0][1] = (vec3(7.0, 7.0, 4.0));
	var[3][1][1][0] = (vec3(-1.0, -5.0, -6.0));
	var[3][1][1][1] = (vec3(-9.0, 7.0, 3.0));
	var[3][1][2][0] = (vec3(7.0, 3.0, -9.0));
	var[3][1][2][1] = (vec3(1.0, -3.0, 5.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(4.0, 1.0, -5.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(6.0, 2.0, -9.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(4.0, -5.0, 0.0, 0.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(6.0, 8.0, 9.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-6.0, -1.0, -9.0, 3.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[0][0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[0][0][2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	var[0][1][0] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	var[0][1][1] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	var[0][1][2] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	var[1][0][0] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	var[1][0][1] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	var[1][0][2] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	var[1][1][0] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	var[1][1][1] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	var[1][1][2] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	var[2][0][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	var[2][0][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	var[2][0][2] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	var[2][1][0] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
	var[2][1][1] = (mat2x3(-7.0, -4.0, 3.0, -6.0, -7.0, -9.0));
	var[2][1][2] = (mat2x3(-9.0, 8.0, -8.0, 7.0, 8.0, -9.0));
	var[3][0][0] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	var[3][0][1] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	var[3][0][2] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	var[3][1][0] = (mat2x3(0.0, -8.0, -9.0, 3.0, 8.0, -4.0));
	var[3][1][1] = (mat2x3(6.0, -9.0, -1.0, 5.0, 7.0, -4.0));
	var[3][1][2] = (mat2x3(0.0, -7.0, -9.0, -2.0, -6.0, -1.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-9.0, 6.0, 5.0, 1.0, 2.0, 1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-1.0, 0.0, -9.0, 6.0, 9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(9.0, -3.0, -8.0, 7.0, 2.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(0.0, 5.0, 8.0, -5.0, 9.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(1.0, 5.0, 6.0, -2.0, 0.0, -8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[0][0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[0][0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	var[0][1][0] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	var[0][1][1] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	var[0][1][2] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	var[1][0][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	var[1][0][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	var[1][0][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	var[1][1][0] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	var[1][1][1] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	var[1][1][2] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	var[2][0][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	var[2][0][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	var[2][0][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	var[2][1][0] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
	var[2][1][1] = (mat2x4(1.0, 8.0, 2.0, 3.0, 2.0, -5.0, 3.0, 3.0));
	var[2][1][2] = (mat2x4(-4.0, -9.0, -5.0, -3.0, 6.0, 8.0, 8.0, 7.0));
	var[3][0][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	var[3][0][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	var[3][0][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	var[3][1][0] = (mat2x4(-3.0, -4.0, -9.0, -1.0, -5.0, -2.0, 3.0, 1.0));
	var[3][1][1] = (mat2x4(-1.0, 9.0, -7.0, 4.0, -9.0, 0.0, -7.0, 1.0));
	var[3][1][2] = (mat2x4(9.0, -7.0, -5.0, 9.0, -5.0, 3.0, -8.0, 6.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-7.0, 5.0, 4.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-3.0, 5.0, -8.0, -2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(3.0, -9.0, 1.0, 3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-6.0, 5.0, 3.0, -1.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(6.0, -4.0, -1.0, 5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-1.0, -8.0, 7.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(9.0, 5.0, 3.0, -1.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(3.0, 8.0, -7.0, 8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(4.0, -2.0, -2.0, -6.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(5.0, -9.0, -5.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-4.0, 0.0, -3.0, 5.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-2.0, 6.0, 0.0, 3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-5.0, -3.0, -6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-6.0, 5.0, -2.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(1.0, 8.0, -7.0, 5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(0.0, 5.0, 6.0, -5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-2.0, -1.0, 5.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-2.0, 9.0, 2.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-2.0, -9.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-6.0, -3.0, 6.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-8.0, -9.0, -8.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-4.0, -3.0, -5.0, 8.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(0.0, 3.0, 7.0, -5.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(7.0, -2.0, -8.0, 8.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0][0][0] = (vec3(5.0, -6.0, 0.0));
	var[0][0][0][1] = (vec3(-8.0, -2.0, 8.0));
	var[0][0][1][0] = (vec3(8.0, 0.0, 3.0));
	var[0][0][1][1] = (vec3(-6.0, -6.0, -1.0));
	var[0][0][2][0] = (vec3(2.0, -9.0, 1.0));
	var[0][0][2][1] = (vec3(3.0, 2.0, 1.0));
	var[0][1][0][0] = (vec3(8.0, -3.0, 3.0));
	var[0][1][0][1] = (vec3(8.0, 1.0, 3.0));
	var[0][1][1][0] = (vec3(6.0, 2.0, 9.0));
	var[0][1][1][1] = (vec3(-2.0, -9.0, -9.0));
	var[0][1][2][0] = (vec3(6.0, -2.0, -3.0));
	var[0][1][2][1] = (vec3(-8.0, -5.0, -2.0));
	var[1][0][0][0] = (vec3(5.0, -6.0, -8.0));
	var[1][0][0][1] = (vec3(-6.0, -5.0, -9.0));
	var[1][0][1][0] = (vec3(6.0, -9.0, 0.0));
	var[1][0][1][1] = (vec3(-1.0, -3.0, -6.0));
	var[1][0][2][0] = (vec3(9.0, 7.0, -5.0));
	var[1][0][2][1] = (vec3(-7.0, -2.0, -1.0));
	var[1][1][0][0] = (vec3(-5.0, 0.0, -9.0));
	var[1][1][0][1] = (vec3(-9.0, -9.0, -9.0));
	var[1][1][1][0] = (vec3(-3.0, -1.0, 7.0));
	var[1][1][1][1] = (vec3(1.0, 1.0, 4.0));
	var[1][1][2][0] = (vec3(-2.0, 7.0, 0.0));
	var[1][1][2][1] = (vec3(1.0, 9.0, -4.0));
	var[2][0][0][0] = (vec3(-3.0, 0.0, 3.0));
	var[2][0][0][1] = (vec3(3.0, 5.0, -1.0));
	var[2][0][1][0] = (vec3(-1.0, 3.0, -1.0));
	var[2][0][1][1] = (vec3(-7.0, 7.0, -6.0));
	var[2][0][2][0] = (vec3(-6.0, -8.0, 2.0));
	var[2][0][2][1] = (vec3(-4.0, -3.0, -3.0));
	var[2][1][0][0] = (vec3(0.0, -1.0, 8.0));
	var[2][1][0][1] = (vec3(9.0, -4.0, 6.0));
	var[2][1][1][0] = (vec3(5.0, -2.0, 0.0));
	var[2][1][1][1] = (vec3(6.0, 6.0, 3.0));
	var[2][1][2][0] = (vec3(8.0, 3.0, 2.0));
	var[2][1][2][1] = (vec3(2.0, -8.0, 0.0));
	var[3][0][0][0] = (vec3(4.0, 8.0, 7.0));
	var[3][0][0][1] = (vec3(-2.0, -7.0, -5.0));
	var[3][0][1][0] = (vec3(5.0, -5.0, 1.0));
	var[3][0][1][1] = (vec3(-1.0, 7.0, -5.0));
	var[3][0][2][0] = (vec3(8.0, -7.0, -2.0));
	var[3][0][2][1] = (vec3(4.0, 3.0, -7.0));
	var[3][1][0][0] = (vec3(-1.0, 2.0, 7.0));
	var[3][1][0][1] = (vec3(7.0, 4.0, -1.0));
	var[3][1][1][0] = (vec3(-5.0, -6.0, -9.0));
	var[3][1][1][1] = (vec3(7.0, 3.0, 7.0));
	var[3][1][2][0] = (vec3(3.0, -9.0, 1.0));
	var[3][1][2][1] = (vec3(-3.0, 5.0, -4.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(3.0, -1.0, 3.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-8.0, 5.0, -4.0, 8.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-9.0, -3.0, 8.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(2.0, 2.0, -9.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(-2.0, 0.0, 0.0, 3.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-1.0, -9.0, -5.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(1.0, -2.0, -4.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(0.0, 1.0, 7.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(9.0, 8.0, 3.0, 2.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-4.0, 5.0, -3.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(4.0, 2.0, -9.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(4.0, -7.0, 8.0, 0.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(1.0, -4.0, -3.0, 4.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(1.0, 0.0, 8.0, -1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(3.0, 7.0, -8.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(8.0, 4.0, 6.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(-7.0, 4.0, -5.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(6.0, 8.0, 7.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-6.0, 0.0, 7.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-5.0, -6.0, 5.0, -8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-2.0, 1.0, 3.0, 0.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(9.0, 1.0, -3.0, -8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(9.0, -6.0, 5.0, -2.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0] = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	var[0][0][1] = (mat3x2(-8.0, -2.0, 3.0, 4.0, 9.0, 4.0));
	var[0][0][2] = (mat3x2(-7.0, 9.0, 9.0, -1.0, 1.0, -9.0));
	var[0][1][0] = (mat3x2(6.0, -9.0, -2.0, -7.0, -4.0, -2.0));
	var[0][1][1] = (mat3x2(-1.0, 7.0, 3.0, -9.0, -2.0, 6.0));
	var[0][1][2] = (mat3x2(1.0, -2.0, -2.0, 3.0, -8.0, -9.0));
	var[1][0][0] = (mat3x2(0.0, -8.0, -3.0, 8.0, 3.0, 5.0));
	var[1][0][1] = (mat3x2(9.0, 0.0, 9.0, 8.0, 0.0, 2.0));
	var[1][0][2] = (mat3x2(0.0, 7.0, 6.0, 4.0, 6.0, 9.0));
	var[1][1][0] = (mat3x2(3.0, 2.0, 3.0, 7.0, 8.0, -9.0));
	var[1][1][1] = (mat3x2(-6.0, -9.0, -4.0, -8.0, 3.0, 5.0));
	var[1][1][2] = (mat3x2(8.0, -6.0, -8.0, -4.0, 8.0, -3.0));
	var[2][0][0] = (mat3x2(7.0, -2.0, 8.0, 3.0, 7.0, -9.0));
	var[2][0][1] = (mat3x2(4.0, -5.0, 3.0, -6.0, 8.0, 7.0));
	var[2][0][2] = (mat3x2(6.0, 3.0, 5.0, 1.0, 2.0, 0.0));
	var[2][1][0] = (mat3x2(-3.0, -9.0, 1.0, -7.0, 2.0, 6.0));
	var[2][1][1] = (mat3x2(9.0, -6.0, 7.0, 1.0, -2.0, 9.0));
	var[2][1][2] = (mat3x2(-3.0, 1.0, -1.0, 0.0, 6.0, 3.0));
	var[3][0][0] = (mat3x2(-4.0, 0.0, -9.0, 0.0, 8.0, 7.0));
	var[3][0][1] = (mat3x2(5.0, -1.0, 3.0, -3.0, 3.0, -2.0));
	var[3][0][2] = (mat3x2(0.0, -5.0, -9.0, -4.0, 1.0, 7.0));
	var[3][1][0] = (mat3x2(6.0, 0.0, -2.0, 4.0, -9.0, 9.0));
	var[3][1][1] = (mat3x2(5.0, -7.0, 2.0, 1.0, 1.0, 8.0));
	var[3][1][2] = (mat3x2(9.0, 6.0, -1.0, 4.0, 8.0, -4.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
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
	var[0][1][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[0][1][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[0][1][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[0][1][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[0][1][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[0][1][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[0][1][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[0][1][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[0][2][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	var[0][2][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[0][2][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[0][2][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[0][2][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	var[0][2][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[0][2][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[0][2][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[0][3][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	var[0][3][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[0][3][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[0][3][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	var[0][3][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	var[0][3][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	var[0][3][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	var[0][3][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	var[1][0][0][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[1][0][0][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[1][0][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[1][0][0][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[1][0][1][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[1][0][1][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][1][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][1][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][1][0][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[1][1][0][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[1][1][0][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[1][1][0][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[1][1][1][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[1][1][1][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[1][1][1][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[1][1][1][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[1][2][0][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	var[1][2][0][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[1][2][0][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[1][2][0][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[1][2][1][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	var[1][2][1][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[1][2][1][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[1][2][1][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[1][3][0][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	var[1][3][0][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	var[1][3][0][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	var[1][3][0][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	var[1][3][1][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	var[1][3][1][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	var[1][3][1][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	var[1][3][1][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	var[2][0][0][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[2][0][0][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[2][0][0][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[2][0][0][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[2][0][1][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[2][0][1][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[2][0][1][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[2][0][1][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[2][1][0][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[2][1][0][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[2][1][0][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[2][1][0][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[2][1][1][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[2][1][1][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[2][1][1][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[2][1][1][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[2][2][0][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	var[2][2][0][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[2][2][0][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[2][2][0][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[2][2][1][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	var[2][2][1][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[2][2][1][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[2][2][1][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[2][3][0][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	var[2][3][0][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	var[2][3][0][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	var[2][3][0][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	var[2][3][1][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	var[2][3][1][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	var[2][3][1][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	var[2][3][1][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	highp int var[][4][2];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0][0][0]), 6) && allOk;
	allOk = compare_int((var[0][0][1]), 0) && allOk;
	allOk = compare_int((var[0][1][0]), 8) && allOk;
	allOk = compare_int((var[0][1][1]), -9) && allOk;
	allOk = compare_int((var[0][2][0]), 5) && allOk;
	allOk = compare_int((var[0][2][1]), -3) && allOk;
	allOk = compare_int((var[0][3][0]), 3) && allOk;
	allOk = compare_int((var[0][3][1]), -1) && allOk;
	allOk = compare_int((var[1][0][0]), 9) && allOk;
	allOk = compare_int((var[1][0][1]), -6) && allOk;
	allOk = compare_int((var[1][1][0]), -1) && allOk;
	allOk = compare_int((var[1][1][1]), 0) && allOk;
	allOk = compare_int((var[1][2][0]), 4) && allOk;
	allOk = compare_int((var[1][2][1]), 4) && allOk;
	allOk = compare_int((var[1][3][0]), -9) && allOk;
	allOk = compare_int((var[1][3][1]), -7) && allOk;
	allOk = compare_int((var[2][0][0]), -9) && allOk;
	allOk = compare_int((var[2][0][1]), -8) && allOk;
	allOk = compare_int((var[2][1][0]), -9) && allOk;
	allOk = compare_int((var[2][1][1]), 5) && allOk;
	allOk = compare_int((var[2][2][0]), -9) && allOk;
	allOk = compare_int((var[2][2][1]), -9) && allOk;
	allOk = compare_int((var[2][3][0]), 9) && allOk;
	allOk = compare_int((var[2][3][1]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (8);
	var[0][0][1] = (2);
	var[0][1][0] = (-8);
	var[0][1][1] = (6);
	var[0][2][0] = (-4);
	var[0][2][1] = (9);
	var[0][3][0] = (-3);
	var[0][3][1] = (-3);
	var[1][0][0] = (-5);
	var[1][0][1] = (0);
	var[1][1][0] = (-6);
	var[1][1][1] = (6);
	var[1][2][0] = (-8);
	var[1][2][1] = (4);
	var[1][3][0] = (6);
	var[1][3][1] = (-2);
	var[2][0][0] = (-7);
	var[2][0][1] = (-7);
	var[2][1][0] = (-5);
	var[2][1][1] = (5);
	var[2][2][0] = (-4);
	var[2][2][1] = (5);
	var[2][3][0] = (5);
	var[2][3][1] = (7);
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-2.0, 1.0));
	var[0][0][0][1] = (vec2(-7.0, -1.0));
	var[0][0][1][0] = (vec2(5.0, -3.0));
	var[0][0][1][1] = (vec2(4.0, 8.0));
	var[0][1][0][0] = (vec2(-4.0, 2.0));
	var[0][1][0][1] = (vec2(-1.0, -4.0));
	var[0][1][1][0] = (vec2(-5.0, -8.0));
	var[0][1][1][1] = (vec2(3.0, -7.0));
	var[0][2][0][0] = (vec2(-7.0, 2.0));
	var[0][2][0][1] = (vec2(-9.0, 3.0));
	var[0][2][1][0] = (vec2(7.0, 9.0));
	var[0][2][1][1] = (vec2(-8.0, 3.0));
	var[0][3][0][0] = (vec2(-4.0, 7.0));
	var[0][3][0][1] = (vec2(4.0, 1.0));
	var[0][3][1][0] = (vec2(-1.0, -7.0));
	var[0][3][1][1] = (vec2(-5.0, 1.0));
	var[1][0][0][0] = (vec2(-2.0, -6.0));
	var[1][0][0][1] = (vec2(-5.0, -1.0));
	var[1][0][1][0] = (vec2(3.0, 4.0));
	var[1][0][1][1] = (vec2(-8.0, 6.0));
	var[1][1][0][0] = (vec2(5.0, 0.0));
	var[1][1][0][1] = (vec2(-4.0, -9.0));
	var[1][1][1][0] = (vec2(9.0, 1.0));
	var[1][1][1][1] = (vec2(7.0, 9.0));
	var[1][2][0][0] = (vec2(-8.0, -9.0));
	var[1][2][0][1] = (vec2(3.0, -5.0));
	var[1][2][1][0] = (vec2(7.0, 8.0));
	var[1][2][1][1] = (vec2(-8.0, 4.0));
	var[1][3][0][0] = (vec2(-1.0, 7.0));
	var[1][3][0][1] = (vec2(0.0, 9.0));
	var[1][3][1][0] = (vec2(-6.0, 1.0));
	var[1][3][1][1] = (vec2(-3.0, 1.0));
	var[2][0][0][0] = (vec2(6.0, -2.0));
	var[2][0][0][1] = (vec2(1.0, 3.0));
	var[2][0][1][0] = (vec2(2.0, 1.0));
	var[2][0][1][1] = (vec2(7.0, -2.0));
	var[2][1][0][0] = (vec2(1.0, 3.0));
	var[2][1][0][1] = (vec2(-3.0, 7.0));
	var[2][1][1][0] = (vec2(1.0, 5.0));
	var[2][1][1][1] = (vec2(4.0, 1.0));
	var[2][2][0][0] = (vec2(-4.0, 7.0));
	var[2][2][0][1] = (vec2(-4.0, -8.0));
	var[2][2][1][0] = (vec2(1.0, 0.0));
	var[2][2][1][1] = (vec2(0.0, -9.0));
	var[2][3][0][0] = (vec2(2.0, -1.0));
	var[2][3][0][1] = (vec2(-3.0, 3.0));
	var[2][3][1][0] = (vec2(-3.0, -6.0));
	var[2][3][1][1] = (vec2(3.0, 2.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	var[0][0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[0][0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	var[0][0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[0][0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[0][0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[0][1][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[0][1][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[0][1][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[0][1][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[0][1][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[0][1][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[0][1][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[0][1][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[0][2][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	var[0][2][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[0][2][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[0][2][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[0][2][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	var[0][2][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[0][2][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[0][2][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[0][3][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	var[0][3][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[0][3][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[0][3][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	var[0][3][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	var[0][3][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	var[0][3][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	var[0][3][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	var[1][0][0][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[1][0][0][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[1][0][0][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[1][0][0][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[1][0][1][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[1][0][1][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[1][0][1][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[1][0][1][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[1][1][0][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[1][1][0][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[1][1][0][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[1][1][0][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[1][1][1][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[1][1][1][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[1][1][1][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[1][1][1][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[1][2][0][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	var[1][2][0][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[1][2][0][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[1][2][0][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[1][2][1][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	var[1][2][1][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[1][2][1][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[1][2][1][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[1][3][0][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	var[1][3][0][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	var[1][3][0][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	var[1][3][0][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	var[1][3][1][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	var[1][3][1][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	var[1][3][1][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	var[1][3][1][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	var[2][0][0][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[2][0][0][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[2][0][0][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[2][0][0][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[2][0][1][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[2][0][1][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[2][0][1][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[2][0][1][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[2][1][0][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[2][1][0][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[2][1][0][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[2][1][0][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[2][1][1][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[2][1][1][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[2][1][1][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[2][1][1][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[2][2][0][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	var[2][2][0][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[2][2][0][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[2][2][0][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[2][2][1][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	var[2][2][1][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[2][2][1][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[2][2][1][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[2][3][0][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	var[2][3][0][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	var[2][3][0][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	var[2][3][0][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	var[2][3][1][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	var[2][3][1][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	var[2][3][1][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	var[2][3][1][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(9, 6, -7)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(1.0, -7.0, 1.0, 8.0, 3.0, 7.0, -3.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-3.0, 3.0, -9.0, -1.0, 3.0, 8.0, -7.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(6.0, 2.0, -9.0, 6.0, -1.0, -7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(-6.0, -6.0, 3.0, -3.0, 0.0, 1.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-3.0, -7.0, -8.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-6, 4, 1)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-6.0, -2.0, 7.0, 5.0, -5.0, 9.0, -2.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-9.0, -2.0, 2.0, -3.0, 5.0, 4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-3.0, 5.0, 0.0, 2.0, -8.0, 2.0, -7.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(6.0, 4.0, 1.0, -4.0, -1.0, -5.0, 6.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-4.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-8, -7, -5)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(2.0, -4.0, -8.0, 7.0, -4.0, -7.0, -1.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(8.0, 9.0, 1.0, -6.0, 1.0, -1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(3.0, -3.0, -2.0, 4.0, 1.0, 0.0, -8.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(0.0, -6.0, 3.0, -8.0, 9.0, 2.0, -1.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-1.0, -9.0, -3.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(8, -2, -9)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(2.0, 6.0, 7.0, 4.0, -5.0, 6.0, -5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-2.0, 5.0, 5.0, 5.0, -5.0, 7.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-2.0, 6.0, 6.0, -2.0, 7.0, 9.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(0.0, -7.0, 4.0, -1.0, 6.0, 2.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(3.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(-3, 4, -8)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(3.0, -1.0, 9.0, 1.0, 7.0, 6.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(7.0, -5.0, -9.0, 8.0, -2.0, -1.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-5.0, 0.0, -6.0, 3.0, 3.0, -4.0, 5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-7.0, 3.0, -4.0, -9.0, 0.0, 6.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-8.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(9, 8, -4)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-6.0, -1.0, 1.0, 5.0, 9.0, -7.0, -1.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-3.0, -9.0, 6.0, -3.0, -5.0, -2.0, -4.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(3.0, 3.0, 2.0, -9.0, -9.0, -1.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(1.0, 1.0, -5.0, -3.0, 8.0, -3.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(-5.0, -6.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(1, -3, 9)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-9.0, 4.0, 4.0, -4.0, -5.0, 4.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-2.0, -3.0, 7.0, -4.0, 0.0, 4.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(6.0, 7.0, -6.0, 6.0, 0.0, -2.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-5.0, 9.0, 8.0, 9.0, 4.0, 9.0, 5.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-6.0, 8.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(0, -8, -8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(1.0, 7.0, 9.0, -8.0, 2.0, 3.0, 6.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-1.0, 3.0, 1.0, 3.0, -7.0, -7.0, 2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(6.0, 0.0, -1.0, -7.0, -7.0, 3.0, 2.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(3.0, -4.0, 4.0, 5.0, -1.0, -8.0, -6.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(2.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-9, 3, -2)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-3.0, 1.0, 4.0, 2.0, 8.0, 2.0, -9.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(8.0, 8.0, 7.0, 0.0, 1.0, 7.0, -3.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(7.0, 7.0, -1.0, 0.0, 8.0, 2.0, -5.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(8.0, -5.0, -9.0, 7.0, -1.0, -8.0, -2.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-5.0, -4.0, -6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-7, -8, 3));
	block[0].s[0].b[0] = (mat3(-7.0, 9.0, 0.0, 5.0, 7.0, 9.0, 3.0, -5.0, -5.0));
	block[0].s[0].b[1] = (mat3(4.0, 3.0, -2.0, -3.0, -4.0, 1.0, 2.0, 1.0, -8.0));
	block[0].s[0].b[2] = (mat3(-8.0, -4.0, 4.0, 0.0, -5.0, 2.0, 0.0, 7.0, 9.0));
	block[0].s[0].b[3] = (mat3(-3.0, -5.0, 3.0, 6.0, 3.0, 5.0, 4.0, 3.0, -6.0));
	block[0].s[0].c = (vec4(4.0, -2.0, -1.0, 2.0));
	block[0].s[1].a = (ivec3(7, 5, 6));
	block[0].s[1].b[0] = (mat3(8.0, 4.0, -6.0, 1.0, 8.0, -6.0, -3.0, -8.0, 9.0));
	block[0].s[1].b[1] = (mat3(-8.0, 6.0, 2.0, -2.0, 4.0, -6.0, 6.0, -4.0, -1.0));
	block[0].s[1].b[2] = (mat3(3.0, 0.0, -7.0, -3.0, 7.0, -6.0, 8.0, -3.0, -5.0));
	block[0].s[1].b[3] = (mat3(7.0, -5.0, 3.0, 2.0, -9.0, -5.0, 9.0, -3.0, -1.0));
	block[0].s[1].c = (vec4(-6.0, 6.0, -1.0, 3.0));
	block[0].s[2].a = (ivec3(5, 4, 6));
	block[0].s[2].b[0] = (mat3(-2.0, 5.0, -1.0, 0.0, -2.0, -1.0, 4.0, 8.0, -2.0));
	block[0].s[2].b[1] = (mat3(-4.0, 9.0, -5.0, -5.0, -5.0, 4.0, -7.0, 5.0, 6.0));
	block[0].s[2].b[2] = (mat3(7.0, -9.0, -6.0, -7.0, -8.0, -7.0, -8.0, 0.0, -8.0));
	block[0].s[2].b[3] = (mat3(5.0, 5.0, -3.0, 6.0, 4.0, -1.0, -8.0, 8.0, -5.0));
	block[0].s[2].c = (vec4(6.0, 2.0, 0.0, 8.0));
	block[0].v = (vec4(3.0, 0.0, 3.0, -6.0));
	block[1].s[0].a = (ivec3(3, -6, -4));
	block[1].s[0].b[0] = (mat3(4.0, -4.0, -2.0, 0.0, 3.0, 2.0, -5.0, -8.0, -3.0));
	block[1].s[0].b[1] = (mat3(6.0, 7.0, 9.0, -1.0, -7.0, 4.0, -6.0, -5.0, 2.0));
	block[1].s[0].b[2] = (mat3(2.0, 1.0, 4.0, -8.0, -3.0, -1.0, -4.0, 5.0, 6.0));
	block[1].s[0].b[3] = (mat3(0.0, 4.0, 9.0, 2.0, -9.0, 6.0, 7.0, 1.0, 3.0));
	block[1].s[0].c = (vec4(7.0, 7.0, 6.0, 9.0));
	block[1].s[1].a = (ivec3(-7, -1, 4));
	block[1].s[1].b[0] = (mat3(5.0, 5.0, -8.0, 6.0, 1.0, -5.0, 4.0, 0.0, -1.0));
	block[1].s[1].b[1] = (mat3(-4.0, -1.0, 4.0, 4.0, -4.0, 3.0, -7.0, 8.0, 4.0));
	block[1].s[1].b[2] = (mat3(0.0, -4.0, -3.0, 5.0, 0.0, -8.0, -7.0, 6.0, 9.0));
	block[1].s[1].b[3] = (mat3(5.0, 6.0, -7.0, 8.0, -7.0, 1.0, 4.0, 4.0, 5.0));
	block[1].s[1].c = (vec4(6.0, -3.0, -8.0, 2.0));
	block[1].s[2].a = (ivec3(0, 6, 6));
	block[1].s[2].b[0] = (mat3(-4.0, 2.0, 6.0, -8.0, 2.0, -1.0, -2.0, 2.0, -4.0));
	block[1].s[2].b[1] = (mat3(-3.0, -5.0, -7.0, -9.0, 7.0, -8.0, -9.0, 1.0, 3.0));
	block[1].s[2].b[2] = (mat3(-5.0, -5.0, -7.0, 7.0, -3.0, -5.0, 4.0, 1.0, 9.0));
	block[1].s[2].b[3] = (mat3(9.0, 4.0, 2.0, -2.0, -9.0, 2.0, -8.0, -9.0, 2.0));
	block[1].s[2].c = (vec4(5.0, -5.0, -6.0, 1.0));
	block[1].v = (vec4(4.0, -1.0, -8.0, -2.0));
	block[2].s[0].a = (ivec3(-1, -9, 8));
	block[2].s[0].b[0] = (mat3(-2.0, 1.0, 8.0, -5.0, -8.0, 8.0, -8.0, -5.0, 2.0));
	block[2].s[0].b[1] = (mat3(-2.0, 9.0, 3.0, -4.0, 3.0, -9.0, -4.0, 9.0, -7.0));
	block[2].s[0].b[2] = (mat3(-8.0, 6.0, -2.0, -9.0, 3.0, -1.0, -1.0, 8.0, -1.0));
	block[2].s[0].b[3] = (mat3(-2.0, 0.0, -1.0, -4.0, -6.0, 6.0, 4.0, -5.0, 7.0));
	block[2].s[0].c = (vec4(-7.0, 6.0, 3.0, -6.0));
	block[2].s[1].a = (ivec3(-9, -8, 5));
	block[2].s[1].b[0] = (mat3(-7.0, 8.0, -3.0, 5.0, -7.0, 3.0, -9.0, 0.0, 2.0));
	block[2].s[1].b[1] = (mat3(-4.0, 7.0, 5.0, -9.0, -8.0, -1.0, -2.0, -4.0, 8.0));
	block[2].s[1].b[2] = (mat3(7.0, -5.0, 8.0, -5.0, -9.0, -1.0, -5.0, -4.0, -4.0));
	block[2].s[1].b[3] = (mat3(-7.0, 5.0, -5.0, -6.0, -5.0, 1.0, 1.0, 4.0, 5.0));
	block[2].s[1].c = (vec4(7.0, -3.0, -4.0, 1.0));
	block[2].s[2].a = (ivec3(-6, 3, -8));
	block[2].s[2].b[0] = (mat3(5.0, -8.0, 3.0, 8.0, 1.0, -5.0, 7.0, 9.0, 3.0));
	block[2].s[2].b[1] = (mat3(-4.0, 7.0, 1.0, 0.0, -9.0, 0.0, 3.0, 0.0, -7.0));
	block[2].s[2].b[2] = (mat3(9.0, -6.0, -5.0, 9.0, 9.0, 3.0, -8.0, -8.0, -3.0));
	block[2].s[2].b[3] = (mat3(-2.0, 8.0, -3.0, -9.0, -9.0, -9.0, -4.0, -7.0, 8.0));
	block[2].s[2].c = (vec4(-2.0, 8.0, 9.0, 6.0));
	block[2].v = (vec4(7.0, 7.0, 9.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(2, 2, -2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(0.0, -3.0, -4.0, 0.0, -5.0, 5.0, 1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(8.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(3.0, 7.0, 8.0, 6.0, 9.0, -6.0, 1.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(-9, -2, 8)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(0.0, 8.0, 4.0, 0.0, -9.0, 5.0, 8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(9.0, -9.0, -4.0, 0.0, -4.0, -6.0, 1.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(5.0, -8.0, -4.0, 4.0, -3.0, -2.0, -5.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(0.0, 1.0, 9.0, -3.0, -2.0, -3.0, 8.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(-1.0, 5.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a = (mat3(5.0, -9.0, 7.0, 8.0, -1.0, -4.0, -3.0, -9.0, -1.0));
	t.b.a = (ivec3(4, 9, 3));
	t.b.b[0] = (mat3(-6.0, -7.0, -3.0, 5.0, 5.0, 3.0, -1.0, 6.0, -8.0));
	t.b.b[1] = (mat3(-1.0, 2.0, -5.0, 7.0, 7.0, 7.0, -2.0, -7.0, -3.0));
	t.b.b[2] = (mat3(-2.0, 6.0, 4.0, 3.0, -2.0, -9.0, -2.0, -3.0, -4.0));
	t.b.b[3] = (mat3(6.0, -2.0, 9.0, 3.0, -4.0, 4.0, 4.0, 8.0, 5.0));
	t.b.c = (vec4(6.0, -7.0, -7.0, 3.0));
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-3.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(4.0, 5.0, -4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(1.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-8.0, -2.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 4.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-3.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(1.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(4.0, 5.0, -6.0));
	block[0].var[1] = (vec3(0.0, -8.0, -2.0));
	block[1].var[0] = (vec3(8.0, 8.0, 0.0));
	block[1].var[1] = (vec3(3.0, -6.0, -6.0));
	block[2].var[0] = (vec3(-1.0, 2.0, -9.0));
	block[2].var[1] = (vec3(1.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(-2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(-2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0, 8.0, 1.0, 7.0, -9.0, -6.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -8.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-8.0, -3.0, 6.0, -5.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -2.0, -7.0, 6.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-6.0);
	block[0].var = (mat4(5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0, 6.0, -9.0, 9.0, -6.0));
	block[1].padding = (-2.0);
	block[1].var = (mat4(9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0, 3.0, -2.0, 2.0, -7.0, 6.0, -2.0, -6.0, -4.0));
	block[2].padding = (3.0);
	block[2].var = (mat4(-2.0, 9.0, -2.0, 6.0, -7.0, 8.0, 1.0, 6.0, 7.0, 8.0, -3.0, 6.0, -4.0, 7.0, -3.0, -4.0));
}
#version 450
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
	uint8_t var;
} block[3];

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].var), 7u) && allOk;
	allOk = compare_uint8_t(uint(block[1].var), 1u) && allOk;
	allOk = compare_uint8_t(uint(block[2].var), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = uint8_t(9u);
	block[1].var = uint8_t(5u);
	block[2].var = uint8_t(2u);
}
#version 450
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
	allOk = compare_float((blockA[0].a), -6.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], -4.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 8.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -3.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-2.0, -3.0)) && allOk;
	allOk = compare_float((blockA[1].a), -2.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -7.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], 7.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -2.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(7.0, -2.0)) && allOk;
	allOk = compare_float((blockA[2].a), -2.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -8.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -1.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -4.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 7.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-4.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(0, -9)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(2, 4)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(4, -4)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-2.0);
	blockA[1].a = (-9.0);
	blockA[2].a = (2.0);
	blockB[0].a = (mat3(-8.0, 3.0, 1.0, 8.0, -4.0, 1.0, -2.0, -2.0, 0.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(-1.0, -2.0, 3.0, 0.0, -5.0, -5.0, 6.0, -7.0, 5.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(6.0, -2.0, -6.0, -5.0, -6.0, -1.0, 6.0, 8.0, -7.0));
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

layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA;
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), -4.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 5.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 2.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -3.0) && allOk;
	allOk = compare_float(blockA.c[1][1], 7.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-3.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-4, 9)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (0.0);
	blockB.a = (mat3(-9.0, 5.0, -5.0, 3.0, -9.0, 6.0, 9.0, 2.0, -1.0));
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

layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA;
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), -5.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 6.0) && allOk;
	allOk = compare_float(blockA.c[0][1], -3.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -2.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-6.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(3, 6)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-9.0);
	blockB.a[0] = (vec3(1.0, -7.0, 9.0));
	blockB.a[1] = (vec3(9.0, -7.0, -8.0));
	blockB.a[2] = (vec3(3.0, -7.0, 8.0));
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
	lowp vec2 a;
	mediump ivec2 b;
	highp vec3 c;
	bool d;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump int e[1];
	bvec2 f;
	highp vec4 g;
	bvec2 h[1];
};
layout(std430, binding = 3) buffer BlockD
{
	lowp vec4 i;
	lowp ivec4 j;
	mediump vec4 k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_vec3((c), vec3(4.0, 0.0, -2.0)) && allOk;
	allOk = compare_bvec2((f), bvec2(true, true)) && allOk;
	allOk = compare_vec4((g), vec4(2.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_bvec2((h[0]), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockD.i), vec4(0.0, -2.0, -5.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockD.j), ivec4(4, -7, -2, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec2(3, -2));
	e[0] = (-8);
	f = (bvec2(true, false));
	h[0] = (bvec2(false, false));
	blockD.i = (vec4(-1.0, -2.0, 2.0, -3.0));
	blockD.k = (vec4(-5.0, -2.0, -2.0, 8.0));
}
#version 450
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
	lowp mat3x4 d[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump vec2 e;
	mediump uint f;
	lowp mat4 g;
	highp int h[];
};
layout(std140, binding = 3) buffer BlockD
{
	bvec2 i;
	bvec4 j;
	lowp uint k;
	bool l;
	highp ivec3 m[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump ivec2 n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_int((blockB.b), 9) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_mat3x4(blockB.d[0], mat3x4(-4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0, -9.0, -7.0, 9.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[1], mat3x4(6.0, 0.0, -1.0, -3.0, 0.0, -1.0, -7.0, -7.0, 6.0, 9.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[2], mat3x4(6.0, 1.0, 1.0, 7.0, 2.0, -6.0, 8.0, -2.0, 4.0, 0.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[3], mat3x4(-8.0, -9.0, 5.0, 0.0, -3.0, 9.0, 1.0, -6.0, 1.0, 0.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[4], mat3x4(-9.0, 6.0, -4.0, -1.0, 5.0, 3.0, 8.0, -2.0, 1.0, -3.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[5], mat3x4(0.0, -7.0, -9.0, 6.0, 4.0, 5.0, 3.0, -1.0, 1.0, 1.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec2((e), vec2(8.0, 0.0)) && allOk;
	allOk = compare_uint((f), 6u) && allOk;
	allOk = compare_mat4(g, mat4(-5.0, -6.0, -5.0, 9.0, -7.0, 5.0, 8.0, -7.0, -8.0, -8.0, -6.0, -9.0, 0.0, -5.0, -4.0, -8.0)) && allOk;
	allOk = compare_ivec2((n), ivec2(5, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (false);
	blockB.d[0] = (mat3x4(1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0));
	blockB.d[1] = (mat3x4(-1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0, 5.0, 6.0));
	blockB.d[2] = (mat3x4(5.0, 6.0, -6.0, -9.0, 3.0, -7.0, -4.0, -6.0, -5.0, 3.0, -9.0, -6.0));
	blockB.d[3] = (mat3x4(-3.0, -7.0, -1.0, -5.0, 6.0, -5.0, -6.0, 8.0, 9.0, 6.0, -9.0, 4.0));
	blockB.d[4] = (mat3x4(7.0, -3.0, 0.0, 8.0, -9.0, -1.0, 8.0, 3.0, -6.0, 7.0, 0.0, 5.0));
	blockB.d[5] = (mat3x4(-9.0, 0.0, -2.0, -6.0, -3.0, -7.0, 9.0, 5.0, -5.0, -2.0, 1.0, 8.0));
	e = (vec2(-2.0, -4.0));
	f = (1u);
	h[0] = (6);
	h[1] = (9);
	j = (bvec4(false, false, true, false));
	k = (8u);
	l = (true);
	n = (ivec2(-9, 6));
}
#version 450
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
	lowp mat2 a;
	bool b[];
} blockB[1];
layout(std140, binding = 2) buffer BlockC
{
	highp float c;
	bvec3 d[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump mat4x3 e;
	highp mat4 f;
	highp uvec2 g;
	highp float h;
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].a, mat2(2.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_float((c), -5.0) && allOk;
	allOk = compare_bvec3((d[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4x3(blockD[0].e, mat4x3(6.0, -6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0, 5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(blockD[0].f, mat4(6.0, 2.0, 3.0, -7.0, -8.0, 9.0, -9.0, 1.0, 1.0, 3.0, 6.0, -3.0, 8.0, 6.0, -4.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockD[0].g), uvec2(8u, 2u)) && allOk;
	allOk = compare_mat4x3(blockD[1].e, mat4x3(-9.0, -5.0, -1.0, -8.0, 9.0, 7.0, -8.0, 5.0, -1.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(blockD[1].f, mat4(-7.0, 7.0, 6.0, 7.0, 2.0, 9.0, 1.0, 5.0, 3.0, -6.0, -5.0, 6.0, 9.0, -5.0, 1.0, -3.0)) && allOk;
	allOk = compare_uvec2((blockD[1].g), uvec2(1u, 8u)) && allOk;
	allOk = compare_mat4x3(blockD[2].e, mat4x3(5.0, -2.0, -1.0, -4.0, 3.0, 2.0, -2.0, 8.0, 6.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4(blockD[2].f, mat4(7.0, 5.0, 9.0, -1.0, 7.0, -5.0, 3.0, -9.0, -4.0, -9.0, -2.0, 6.0, 3.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockD[2].g), uvec2(8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat2(8.0, -1.0, -2.0, -6.0));
	blockB[0].b[0] = (false);
	c = (0.0);
	d[0] = (bvec3(false, false, false));
	blockD[0].f = (mat4(-5.0, 4.0, 9.0, -7.0, -6.0, -2.0, -4.0, 8.0, -6.0, -4.0, 6.0, -3.0, -6.0, 8.0, -6.0, -7.0));
	blockD[0].g = (uvec2(0u, 3u));
	blockD[0].h = (-7.0);
	blockD[1].f = (mat4(7.0, 9.0, 8.0, -3.0, -4.0, 4.0, 9.0, 0.0, 1.0, 2.0, -3.0, -9.0, -9.0, 0.0, -6.0, -8.0));
	blockD[1].g = (uvec2(4u, 0u));
	blockD[1].h = (-8.0);
	blockD[2].f = (mat4(-5.0, -2.0, 0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0, 4.0, -1.0, 3.0, 8.0, -9.0, -7.0));
	blockD[2].g = (uvec2(9u, 4u));
	blockD[2].h = (-1.0);
}
#version 450
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
	mediump mat2x3 a;
	highp uvec4 b[];
} blockB[2];
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat3x2 c;
	highp mat4x2 d;
	bvec2 e[1];
	bvec2 f[];
} blockC[1];
layout(std430, binding = 3) buffer BlockD
{
	lowp mat4 g;
	highp mat3x4 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
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
	allOk = compare_mat4(g, mat4(-5.0, 6.0, 2.0, -7.0, -6.0, 2.0, 7.0, -8.0, -4.0, -7.0, -3.0, 0.0, -3.0, 2.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(h[0], mat3x4(-6.0, 1.0, 4.0, 9.0, -7.0, 4.0, 6.0, 5.0, 7.0, -4.0, 9.0, -3.0)) && allOk;
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
	g = (mat4(4.0, -7.0, -3.0, 7.0, 0.0, -9.0, 0.0, -8.0, 2.0, -1.0, 4.0, -7.0, 7.0, 8.0, -3.0, 5.0));
	h[0] = (mat3x4(-2.0, 6.0, 7.0, -8.0, -1.0, 4.0, 4.0, -2.0, 3.0, -2.0, -4.0, 1.0));
}
#version 450
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
	mediump mat3x4 mA;
	bvec2 mB;
};
struct sB
{
	mediump mat2x3 mA;
	lowp mat4x3 mB;
	lowp uint mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec2 a;
	bvec2 b[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	sA c;
	lowp int d;
	sB e;
	mediump mat3 f[];
} blockC[2];
layout(std430, binding = 3) buffer BlockD
{
	lowp vec3 g;
	lowp uvec4 h;
	mediump mat3x4 i;
	lowp vec3 j;
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp mat3x2 k;
	highp mat2x3 l;
	bvec2 m;
	lowp vec3 n[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockC[0].c.mA, mat3x4(0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0, -7.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockC[0].c.mB), bvec2(true, false)) && allOk;
	allOk = compare_int((blockC[0].d), 9) && allOk;
	allOk = compare_mat2x3(blockC[0].e.mA, mat2x3(-3.0, -6.0, 6.0, 6.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e.mB, mat4x3(-9.0, 2.0, -2.0, -3.0, 0.0, -4.0, 4.0, 0.0, 9.0, -5.0, 7.0, -4.0)) && allOk;
	allOk = compare_uint((blockC[0].e.mC), 4u) && allOk;
	allOk = compare_mat3(blockC[0].f[0], mat3(7.0, -8.0, -1.0, 8.0, 8.0, 7.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].c.mA, mat3x4(-6.0, -1.0, 5.0, 8.0, -9.0, -6.0, 2.0, -8.0, -9.0, 4.0, -8.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockC[1].c.mB), bvec2(true, false)) && allOk;
	allOk = compare_int((blockC[1].d), 4) && allOk;
	allOk = compare_mat2x3(blockC[1].e.mA, mat2x3(3.0, 6.0, 7.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e.mB, mat4x3(8.0, -4.0, -8.0, 8.0, 4.0, 7.0, 5.0, -5.0, -1.0, 6.0, -1.0, 3.0)) && allOk;
	allOk = compare_uint((blockC[1].e.mC), 2u) && allOk;
	allOk = compare_mat3(blockC[1].f[0], mat3(-9.0, 4.0, -7.0, -3.0, 2.0, 5.0, 1.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[1], mat3(-9.0, -3.0, 3.0, -7.0, -6.0, -3.0, 3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[2], mat3(-2.0, -4.0, 6.0, 4.0, -7.0, -1.0, 4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[3], mat3(-4.0, 8.0, 3.0, -8.0, 5.0, -9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[4], mat3(6.0, -5.0, -9.0, -1.0, -1.0, 8.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[5], mat3(-1.0, 8.0, -8.0, 2.0, 2.0, -6.0, 1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[6], mat3(-2.0, 6.0, -5.0, -2.0, -5.0, -3.0, 4.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[7], mat3(9.0, -3.0, 4.0, -9.0, 7.0, -2.0, 6.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((j), vec3(-1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(k, mat3x2(4.0, -5.0, 9.0, -3.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(l, mat2x3(-4.0, 0.0, -1.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_bvec2((m), bvec2(true, false)) && allOk;
	allOk = compare_vec3((n[0]), vec3(-9.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec3((n[1]), vec3(-7.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3((n[2]), vec3(9.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec3((n[3]), vec3(0.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3((n[4]), vec3(-3.0, -3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, false));
	blockC[0].c.mA = (mat3x4(-5.0, -9.0, -7.0, 0.0, 7.0, -2.0, 9.0, -6.0, 8.0, 5.0, 3.0, -3.0));
	blockC[0].c.mB = (bvec2(true, true));
	blockC[0].d = (5);
	blockC[0].f[0] = (mat3(1.0, 3.0, 6.0, -8.0, -8.0, -6.0, 7.0, 6.0, -5.0));
	blockC[1].c.mA = (mat3x4(7.0, 6.0, -6.0, 0.0, 7.0, -7.0, 4.0, -4.0, -8.0, 1.0, -6.0, 7.0));
	blockC[1].c.mB = (bvec2(false, true));
	blockC[1].d = (2);
	blockC[1].f[0] = (mat3(2.0, 1.0, 2.0, -8.0, 0.0, 6.0, -1.0, 1.0, -3.0));
	blockC[1].f[1] = (mat3(7.0, -9.0, 3.0, -1.0, 0.0, 8.0, -9.0, -5.0, 5.0));
	blockC[1].f[2] = (mat3(1.0, -1.0, -9.0, -5.0, -1.0, 2.0, -4.0, -1.0, -8.0));
	blockC[1].f[3] = (mat3(-3.0, 3.0, 3.0, 8.0, 2.0, -9.0, -2.0, -3.0, 4.0));
	blockC[1].f[4] = (mat3(-7.0, -6.0, 8.0, 5.0, 2.0, -1.0, 0.0, 4.0, 9.0));
	blockC[1].f[5] = (mat3(-2.0, 0.0, 9.0, 9.0, -2.0, -5.0, 9.0, -8.0, 8.0));
	blockC[1].f[6] = (mat3(-5.0, 5.0, -7.0, -4.0, 3.0, 4.0, -1.0, 6.0, 1.0));
	blockC[1].f[7] = (mat3(9.0, -3.0, -8.0, 0.0, -7.0, -9.0, 4.0, 3.0, 7.0));
	g = (vec3(0.0, -4.0, -4.0));
	k = (mat3x2(-8.0, 5.0, 8.0, -6.0, 9.0, -3.0));
	m = (bvec2(true, true));
	n[0] = (vec3(0.0, 3.0, -6.0));
	n[1] = (vec3(0.0, 3.0, -9.0));
	n[2] = (vec3(-7.0, -8.0, -9.0));
	n[3] = (vec3(7.0, 0.0, -1.0));
	n[4] = (vec3(-9.0, -5.0, -1.0));
}
#version 450
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
	i16vec4 a;
	mediump vec3 b;
};
layout(std140, binding = 2) buffer BlockC
{
	lowp ivec4 c;
	mediump uint d;
	lowp ivec2 e;
};
layout(std140, binding = 3) buffer BlockD
{
	lowp float f[1];
	bool g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b), vec3(-1.0, 0.0, -3.0)) && allOk;
	allOk = compare_ivec4((c), ivec4(9, -2, 0, 3)) && allOk;
	allOk = compare_ivec2((e), ivec2(2, -3)) && allOk;
	allOk = compare_float((f[0]), 8.0) && allOk;
	allOk = compare_bool((g), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec4(ivec4(-7, 4, -4, -7));
	b = (vec3(-3.0, -9.0, 1.0));
	c = (ivec4(2, 8, -2, 5));
	e = (ivec2(-5, -9));
	g = (false);
}
#version 450
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
	layout(offset = 4) highp ivec3 b;
	layout(offset = 16) u16vec4 c;
	layout(offset = 24) mediump vec2 d;
	layout(offset = 32) bvec3 e;
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[0].b), ivec3(4, -8, -2)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[0].c), uvec4(1u, 1u, 7u, 3u)) && allOk;
	allOk = compare_vec2((blockB[0].d), vec2(7.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockB[0].e), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockB[1].b), ivec3(-9, -1, -6)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[1].c), uvec4(1u, 9u, 8u, 6u)) && allOk;
	allOk = compare_vec2((blockB[1].d), vec2(0.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB[1].e), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].c = u16vec4(uvec4(4u, 2u, 9u, 7u));
	blockB[0].d = (vec2(-6.0, 1.0));
	blockB[0].e = (bvec3(false, true, false));
	blockB[1].a = (true);
	blockB[1].c = u16vec4(uvec4(6u, 0u, 6u, 4u));
	blockB[1].d = (vec2(0.0, -2.0));
	blockB[1].e = (bvec3(true, false, true));
}
#version 450
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
	mediump mat3 a[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp uvec3 b;
	float16_t c;
	bvec3 d[];
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp uvec4 e;
	lowp mat3 f;
	highp mat2x3 g;
	bvec3 h[8];
	f16vec3 i[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	u16vec2 j;
	bvec3 k;
	f16vec4 l;
	lowp mat4x2 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC.b), uvec3(0u, 0u, 2u)) && allOk;
	allOk = compare_float16_t(float(blockC.c), -3.0) && allOk;
	allOk = compare_bvec3((blockC.d[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.d[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.d[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec4((blockD.e), uvec4(6u, 6u, 1u, 8u)) && allOk;
	allOk = compare_mat3(blockD.f, mat3(-5.0, 3.0, 9.0, 8.0, 7.0, 9.0, 1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockD.g, mat2x3(-8.0, -2.0, 4.0, -5.0, 5.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockD.h[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.h[3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.h[4]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[5]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[6]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[7]), bvec3(true, true, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[0]), vec3(1.0, 6.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[1]), vec3(1.0, 8.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[2]), vec3(-7.0, 7.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[3]), vec3(-4.0, -1.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[4]), vec3(3.0, -6.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[5]), vec3(6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[6]), vec3(8.0, 7.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i[7]), vec3(-8.0, -4.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(l), vec4(6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(m[0], mat4x2(-6.0, 8.0, 7.0, 9.0, 0.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(m[1], mat4x2(-4.0, -2.0, 6.0, -7.0, 6.0, -1.0, -6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3(9.0, -2.0, 0.0, 5.0, 2.0, 1.0, -3.0, 0.0, 1.0));
	blockB.a[1] = (mat3(9.0, 3.0, -6.0, 1.0, -9.0, -6.0, 0.0, -8.0, -5.0));
	blockB.a[2] = (mat3(-3.0, -8.0, 5.0, 4.0, -1.0, -5.0, 6.0, 8.0, 4.0));
	blockB.a[3] = (mat3(4.0, -2.0, -5.0, -7.0, -5.0, -2.0, 4.0, -4.0, 1.0));
	blockB.a[4] = (mat3(-3.0, 1.0, -1.0, 8.0, -3.0, 5.0, 0.0, 4.0, 8.0));
	blockC.c = float16_t(-3.0);
	blockC.d[0] = (bvec3(true, true, false));
	blockC.d[1] = (bvec3(false, true, true));
	blockC.d[2] = (bvec3(false, false, false));
	blockD.e = (uvec4(4u, 7u, 9u, 0u));
	blockD.f = (mat3(-9.0, 7.0, -2.0, -7.0, -7.0, -4.0, 1.0, 7.0, -7.0));
	blockD.g = (mat2x3(3.0, 7.0, -5.0, -8.0, -5.0, 7.0));
	blockD.h[0] = (bvec3(false, true, false));
	blockD.h[1] = (bvec3(false, true, true));
	blockD.h[2] = (bvec3(false, false, true));
	blockD.h[3] = (bvec3(false, true, true));
	blockD.h[4] = (bvec3(false, true, true));
	blockD.h[5] = (bvec3(false, false, true));
	blockD.h[6] = (bvec3(false, false, false));
	blockD.h[7] = (bvec3(false, true, false));
	blockD.i[0] = f16vec3(vec3(-3.0, 5.0, -7.0));
	blockD.i[1] = f16vec3(vec3(-2.0, -2.0, 1.0));
	blockD.i[2] = f16vec3(vec3(-3.0, 2.0, -9.0));
	blockD.i[3] = f16vec3(vec3(8.0, 9.0, 1.0));
	blockD.i[4] = f16vec3(vec3(-7.0, -7.0, -3.0));
	blockD.i[5] = f16vec3(vec3(7.0, -3.0, 4.0));
	blockD.i[6] = f16vec3(vec3(-3.0, 5.0, 6.0));
	blockD.i[7] = f16vec3(vec3(5.0, -7.0, -4.0));
	j = u16vec2(uvec2(0u, 4u));
	l = f16vec4(vec4(1.0, -6.0, 1.0, 7.0));
	m[0] = (mat4x2(1.0, 0.0, -6.0, 5.0, -9.0, 5.0, -8.0, -4.0));
	m[1] = (mat4x2(3.0, -8.0, 6.0, -9.0, -4.0, -1.0, -8.0, -4.0));
}
#version 450
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
	lowp mat3x2 a;
	lowp mat3x4 b;
	highp mat2 c;
	f16vec2 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(6.0, -5.0, -3.0, -6.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(8.0, 9.0, 6.0, -9.0, 5.0, -2.0, -6.0, 5.0, -8.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(2.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d[0]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d[1]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d[2]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d[3]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d[4]), vec2(-7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-8.0, 9.0, 7.0, 4.0, -5.0, 0.0));
	blockB.c = (mat2(4.0, -2.0, 4.0, -9.0));
	blockB.d[0] = f16vec2(vec2(7.0, -5.0));
	blockB.d[1] = f16vec2(vec2(7.0, 4.0));
	blockB.d[2] = f16vec2(vec2(-6.0, -3.0));
	blockB.d[3] = f16vec2(vec2(-8.0, -9.0));
	blockB.d[4] = f16vec2(vec2(1.0, -3.0));
}
#version 450
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
	uint8_t a;
	highp int b[3];
	mediump mat4 c;
	uint8_t d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp mat3x2 e;
	i8vec4 f;
	u8vec3 g[];
};
layout(std430, binding = 3) buffer BlockD
{
	mediump mat2x3 h;
	lowp uvec4 i[];
};
layout(std430, binding = 4) readonly buffer BlockE
{
	uint8_t j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_int((blockB.b[0]), 9) && allOk;
	allOk = compare_int((blockB.b[1]), 9) && allOk;
	allOk = compare_int((blockB.b[2]), -7) && allOk;
	allOk = compare_uint8_t(uint(blockB.d), 9u) && allOk;
	allOk = compare_i8vec4(ivec4(f), ivec4(4294967295, 4294967295, 6, 1)) && allOk;
	allOk = compare_u8vec3(uvec3(g[0]), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(g[1]), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(g[2]), uvec3(5u, 8u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(g[3]), uvec3(6u, 2u, 3u)) && allOk;
	allOk = compare_mat2x3(h, mat2x3(5.0, 0.0, -3.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_uint8_t(uint(j), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(9u);
	blockB.b[0] = (0);
	blockB.b[1] = (9);
	blockB.b[2] = (4);
	blockB.c = (mat4(1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0));
	blockB.d = uint8_t(5u);
	e = (mat3x2(8.0, 9.0, -7.0, -1.0, -6.0, 5.0));
	f = i8vec4(ivec4(6, 5, 6, 4294967290));
	g[0] = u8vec3(uvec3(8u, 3u, 7u));
	g[1] = u8vec3(uvec3(3u, 2u, 6u));
	g[2] = u8vec3(uvec3(7u, 0u, 4u));
	g[3] = u8vec3(uvec3(8u, 1u, 5u));
	i[0] = (uvec4(3u, 5u, 6u, 3u));
	i[1] = (uvec4(2u, 7u, 1u, 5u));
	i[2] = (uvec4(3u, 4u, 7u, 5u));
	i[3] = (uvec4(6u, 5u, 5u, 1u));
	i[4] = (uvec4(2u, 4u, 4u, 1u));
	i[5] = (uvec4(3u, 9u, 2u, 2u));
	i[6] = (uvec4(6u, 1u, 4u, 7u));
}
#version 450
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
	i8vec4 a[4];
	u8vec4 b;
	bvec4 c;
	lowp mat2 d[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump mat4x2 e;
	highp ivec4 f[];
};
layout(std430, binding = 3) buffer BlockD
{
	highp uvec4 g;
	highp mat4 h;
	bvec2 i;
	i8vec3 j;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	u8vec3 k[2];
	bvec3 l;
	lowp uvec4 m;
	bvec2 n;
	mediump uvec2 o[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a[0]), ivec4(4294967288, 4294967294, 9, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[1]), ivec4(5, 6, 4294967295, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[2]), ivec4(4294967295, 6, 0, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[3]), ivec4(1, 8, 1, 4294967294)) && allOk;
	allOk = compare_mat2(blockB.d[0], mat2(-2.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2(blockB.d[1], mat2(5.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.d[2], mat2(4.0, 8.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(e, mat4x2(3.0, -1.0, 4.0, -2.0, -5.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_ivec4((f[0]), ivec4(-3, 6, 4, 1)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(7u, 7u, 0u, 4u)) && allOk;
	allOk = compare_mat4(blockD.h, mat4(-7.0, 5.0, -1.0, 6.0, 8.0, -2.0, 6.0, 1.0, -2.0, -3.0, -5.0, -7.0, 4.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.j), ivec3(3, 8, 5)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.k[0]), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.k[1]), uvec3(6u, 3u, 5u)) && allOk;
	allOk = compare_bvec2((blockE.n), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i8vec4(ivec4(1, 1, 4294967292, 1));
	blockB.a[1] = i8vec4(ivec4(8, 4294967292, 1, 4294967287));
	blockB.a[2] = i8vec4(ivec4(3, 0, 4294967287, 4294967290));
	blockB.a[3] = i8vec4(ivec4(3, 4, 4294967295, 4294967292));
	blockB.b = u8vec4(uvec4(2u, 3u, 6u, 4u));
	blockB.d[0] = (mat2(0.0, 3.0, 9.0, -8.0));
	blockB.d[1] = (mat2(-9.0, -2.0, 0.0, 2.0));
	blockB.d[2] = (mat2(6.0, -7.0, 3.0, 9.0));
	e = (mat4x2(8.0, 1.0, 7.0, -9.0, 2.0, 7.0, 0.0, -8.0));
	f[0] = (ivec4(-4, -2, -6, -2));
	blockD.g = (uvec4(2u, 8u, 0u, 1u));
	blockD.h = (mat4(1.0, 5.0, -8.0, -8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0, 3.0, 6.0, -8.0, 2.0, -3.0, 9.0));
	blockD.j = i8vec3(ivec3(7, 4, 1));
	blockE.l = (bvec3(true, true, true));
	blockE.m = (uvec4(5u, 2u, 5u, 2u));
	blockE.n = (bvec2(false, true));
}
#version 450
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
	highp uint mA;
	lowp uint mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp vec3 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	sA b;
	bvec4 c[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp mat3x2 d[1];
	mediump ivec4 e;
	highp vec3 f[1];
	bvec3 g;
	sB h[];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	uint8_t i;
	highp ivec2 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockD.d[0], mat3x2(5.0, 1.0, 6.0, 8.0, -6.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockD.e), ivec4(-7, 7, 5, 8)) && allOk;
	allOk = compare_vec3((blockD.f[0]), vec3(5.0, -9.0, -8.0)) && allOk;
	allOk = compare_uint8_t(uint(i), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(8.0, -2.0, -1.0));
	b.mA = (uvec2(5u, 8u));
	c[0] = (bvec4(false, false, false, false));
	blockD.f[0] = (vec3(9.0, -4.0, -5.0));
	i = uint8_t(7u);
}
#version 450
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
	lowp ivec2 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp ivec3 b;
	u8vec3 c;
	lowp mat3 d;
	u8vec2 e;
	highp ivec2 f[];
} blockC[1];
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump mat4x3 g;
	u8vec3 h;
	highp uvec4 i;
	bvec4 j;
	u8vec2 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((blockB.a[1]), ivec2(-9, 7)) && allOk;
	allOk = compare_ivec2((blockB.a[2]), ivec2(5, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[3]), ivec2(2, -9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].c), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_mat4x3(g, mat4x3(2.0, -2.0, -9.0, 1.0, 2.0, -3.0, 7.0, -4.0, -5.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_u8vec2(uvec2(k[0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(k[1]), uvec2(4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(0, -7));
	blockB.a[1] = (ivec2(3, 9));
	blockB.a[2] = (ivec2(-1, 3));
	blockB.a[3] = (ivec2(-7, -7));
	blockC[0].b = (ivec3(6, 0, 6));
	blockC[0].d = (mat3(-3.0, -5.0, -1.0, 9.0, 3.0, -2.0, -6.0, -4.0, -4.0));
	blockC[0].e = u8vec2(uvec2(0u, 7u));
	g = (mat4x3(3.0, 2.0, 3.0, 6.0, 8.0, 5.0, -5.0, -8.0, -3.0, -8.0, 6.0, -1.0));
	h = u8vec3(uvec3(6u, 7u, 2u));
	j = (bvec4(true, true, false, true));
	k[0] = u8vec2(uvec2(1u, 1u));
	k[1] = u8vec2(uvec2(4u, 7u));
}
#version 450
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
	layout(offset = 4) bvec3 b;
	layout(offset = 16) mediump ivec2 c;
	layout(offset = 32) mediump uvec4 d;
} blockB;
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) highp int e[1];
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec3 f;
	layout(offset = 16) bvec2 g[1];
	layout(offset = 24) i8vec3 h;
	layout(offset = 27) i8vec3 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(1, -7)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(8u, 6u, 2u, 7u)) && allOk;
	allOk = compare_int((blockC.e[0]), 9) && allOk;
	allOk = compare_vec3((f), vec3(-8.0, 2.0, 9.0)) && allOk;
	allOk = compare_bvec2((g[0]), bvec2(false, true)) && allOk;
	allOk = compare_i8vec3(ivec3(h), ivec3(3, 4294967293, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockB.c = (ivec2(-5, 0));
	blockB.d = (uvec4(0u, 5u, 8u, 1u));
	f = (vec3(7.0, 8.0, 3.0));
	h = i8vec3(ivec3(4294967290, 5, 1));
	i = i8vec3(ivec3(7, 4294967295, 4294967287));
}
#version 450
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
	layout(offset = 0) u8vec2 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp ivec2 b;
	layout(offset = 16) lowp uvec3 c;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 d;
	layout(offset = 16) u8vec2 e;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec4 f;
	layout(offset = 16) u8vec3 g;
	layout(offset = 20) mediump uvec3 h;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(a), uvec2(4u, 1u)) && allOk;
	allOk = compare_bvec4((f), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec2(uvec2(2u, 9u));
	b = (ivec2(8, 2));
	c = (uvec3(9u, 7u, 0u));
	d = (bvec4(true, true, true, false));
	e = u8vec2(uvec2(1u, 2u));
	f = (bvec4(true, false, false, true));
	g = u8vec3(uvec3(9u, 0u, 5u));
	h = (uvec3(2u, 2u, 3u));
}
#version 450
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
	i8vec3 a;
	mediump ivec4 b;
	bvec2 c;
	i8vec2 d;
	mediump float e[];
} blockB[2];
layout(scalar, binding = 2) buffer BlockC
{
	mediump mat4x3 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].b), ivec4(2, 4, 0, -2)) && allOk;
	allOk = compare_bvec2((blockB[0].c), bvec2(true, false)) && allOk;
	allOk = compare_float((blockB[0].e[0]), -2.0) && allOk;
	allOk = compare_ivec4((blockB[1].b), ivec4(-9, 0, -9, 7)) && allOk;
	allOk = compare_bvec2((blockB[1].c), bvec2(false, false)) && allOk;
	allOk = compare_float((blockB[1].e[0]), 4.0) && allOk;
	allOk = compare_float((blockB[1].e[1]), -7.0) && allOk;
	allOk = compare_float((blockB[1].e[2]), -2.0) && allOk;
	allOk = compare_float((blockB[1].e[3]), 9.0) && allOk;
	allOk = compare_float((blockB[1].e[4]), 8.0) && allOk;
	allOk = compare_float((blockB[1].e[5]), 9.0) && allOk;
	allOk = compare_float((blockB[1].e[6]), 0.0) && allOk;
	allOk = compare_mat4x3(blockC.f[0], mat4x3(-5.0, 2.0, 3.0, 8.0, 7.0, 9.0, -3.0, 1.0, 4.0, -9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[1], mat4x3(-1.0, -3.0, 5.0, 0.0, 2.0, 7.0, 3.0, 3.0, 8.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[2], mat4x3(0.0, 4.0, 1.0, -5.0, -5.0, 7.0, 6.0, -9.0, -1.0, -3.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c = (bvec2(false, false));
	blockB[0].d = i8vec2(ivec2(8, 4294967293));
	blockB[0].e[0] = (3.0);
	blockB[1].c = (bvec2(false, false));
	blockB[1].d = i8vec2(ivec2(4294967293, 4294967287));
	blockB[1].e[0] = (-5.0);
	blockB[1].e[1] = (3.0);
	blockB[1].e[2] = (5.0);
	blockB[1].e[3] = (-5.0);
	blockB[1].e[4] = (-2.0);
	blockB[1].e[5] = (-2.0);
	blockB[1].e[6] = (8.0);
	blockC.f[0] = (mat4x3(-3.0, -3.0, -8.0, 1.0, -3.0, -1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0));
	blockC.f[1] = (mat4x3(1.0, -9.0, 8.0, 9.0, -8.0, -8.0, 3.0, -3.0, 0.0, 4.0, 6.0, 1.0));
	blockC.f[2] = (mat4x3(-4.0, 6.0, 0.0, -2.0, -1.0, 5.0, 2.0, -7.0, -6.0, -2.0, -6.0, 9.0));
}
#version 450
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
	mediump int a[][7][4];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp mat4 b;
	lowp mat4x2 c;
	u8vec4 d[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	highp mat3x4 e;
	bvec3 f;
	bvec2 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockC.c, mat4x2(-5.0, 6.0, -1.0, -3.0, 0.0, 0.0, 8.0, -3.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d[0]), uvec4(5u, 2u, 5u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d[1]), uvec4(3u, 0u, 2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0][0][0] = (-7);
	a[0][0][1] = (3);
	a[0][0][2] = (-9);
	a[0][0][3] = (-7);
	a[0][1][0] = (4);
	a[0][1][1] = (1);
	a[0][1][2] = (-8);
	a[0][1][3] = (-2);
	a[0][2][0] = (5);
	a[0][2][1] = (5);
	a[0][2][2] = (3);
	a[0][2][3] = (6);
	a[0][3][0] = (-5);
	a[0][3][1] = (7);
	a[0][3][2] = (6);
	a[0][3][3] = (-6);
	a[0][4][0] = (7);
	a[0][4][1] = (8);
	a[0][4][2] = (-4);
	a[0][4][3] = (-5);
	a[0][5][0] = (-1);
	a[0][5][1] = (0);
	a[0][5][2] = (8);
	a[0][5][3] = (-9);
	a[0][6][0] = (-7);
	a[0][6][1] = (-6);
	a[0][6][2] = (8);
	a[0][6][3] = (5);
	a[1][0][0] = (-4);
	a[1][0][1] = (-1);
	a[1][0][2] = (9);
	a[1][0][3] = (-4);
	a[1][1][0] = (-5);
	a[1][1][1] = (-9);
	a[1][1][2] = (-7);
	a[1][1][3] = (0);
	a[1][2][0] = (5);
	a[1][2][1] = (1);
	a[1][2][2] = (1);
	a[1][2][3] = (-2);
	a[1][3][0] = (0);
	a[1][3][1] = (7);
	a[1][3][2] = (-7);
	a[1][3][3] = (4);
	a[1][4][0] = (-8);
	a[1][4][1] = (-1);
	a[1][4][2] = (-1);
	a[1][4][3] = (-9);
	a[1][5][0] = (-5);
	a[1][5][1] = (5);
	a[1][5][2] = (1);
	a[1][5][3] = (-1);
	a[1][6][0] = (2);
	a[1][6][1] = (-1);
	a[1][6][2] = (0);
	a[1][6][3] = (4);
	a[2][0][0] = (-4);
	a[2][0][1] = (3);
	a[2][0][2] = (-7);
	a[2][0][3] = (-4);
	a[2][1][0] = (7);
	a[2][1][1] = (-2);
	a[2][1][2] = (9);
	a[2][1][3] = (-6);
	a[2][2][0] = (-3);
	a[2][2][1] = (8);
	a[2][2][2] = (2);
	a[2][2][3] = (-1);
	a[2][3][0] = (-4);
	a[2][3][1] = (-8);
	a[2][3][2] = (1);
	a[2][3][3] = (-6);
	a[2][4][0] = (-8);
	a[2][4][1] = (1);
	a[2][4][2] = (9);
	a[2][4][3] = (-2);
	a[2][5][0] = (-9);
	a[2][5][1] = (-5);
	a[2][5][2] = (-1);
	a[2][5][3] = (2);
	a[2][6][0] = (9);
	a[2][6][1] = (-2);
	a[2][6][2] = (0);
	a[2][6][3] = (9);
	a[3][0][0] = (0);
	a[3][0][1] = (-7);
	a[3][0][2] = (-9);
	a[3][0][3] = (-8);
	a[3][1][0] = (8);
	a[3][1][1] = (5);
	a[3][1][2] = (3);
	a[3][1][3] = (-3);
	a[3][2][0] = (-8);
	a[3][2][1] = (9);
	a[3][2][2] = (-7);
	a[3][2][3] = (5);
	a[3][3][0] = (7);
	a[3][3][1] = (-7);
	a[3][3][2] = (7);
	a[3][3][3] = (-2);
	a[3][4][0] = (2);
	a[3][4][1] = (1);
	a[3][4][2] = (2);
	a[3][4][3] = (-8);
	a[3][5][0] = (-4);
	a[3][5][1] = (-1);
	a[3][5][2] = (-8);
	a[3][5][3] = (-3);
	a[3][6][0] = (9);
	a[3][6][1] = (-2);
	a[3][6][2] = (-5);
	a[3][6][3] = (9);
	a[4][0][0] = (-4);
	a[4][0][1] = (-7);
	a[4][0][2] = (2);
	a[4][0][3] = (-5);
	a[4][1][0] = (6);
	a[4][1][1] = (-2);
	a[4][1][2] = (2);
	a[4][1][3] = (-5);
	a[4][2][0] = (1);
	a[4][2][1] = (3);
	a[4][2][2] = (6);
	a[4][2][3] = (-8);
	a[4][3][0] = (2);
	a[4][3][1] = (2);
	a[4][3][2] = (4);
	a[4][3][3] = (-9);
	a[4][4][0] = (0);
	a[4][4][1] = (6);
	a[4][4][2] = (-1);
	a[4][4][3] = (1);
	a[4][5][0] = (3);
	a[4][5][1] = (3);
	a[4][5][2] = (8);
	a[4][5][3] = (2);
	a[4][6][0] = (-8);
	a[4][6][1] = (8);
	a[4][6][2] = (-5);
	a[4][6][3] = (5);
	a[5][0][0] = (-9);
	a[5][0][1] = (9);
	a[5][0][2] = (-1);
	a[5][0][3] = (9);
	a[5][1][0] = (5);
	a[5][1][1] = (5);
	a[5][1][2] = (3);
	a[5][1][3] = (8);
	a[5][2][0] = (-8);
	a[5][2][1] = (-6);
	a[5][2][2] = (7);
	a[5][2][3] = (6);
	a[5][3][0] = (9);
	a[5][3][1] = (-2);
	a[5][3][2] = (-4);
	a[5][3][3] = (-3);
	a[5][4][0] = (-3);
	a[5][4][1] = (7);
	a[5][4][2] = (-9);
	a[5][4][3] = (3);
	a[5][5][0] = (-9);
	a[5][5][1] = (-2);
	a[5][5][2] = (-3);
	a[5][5][3] = (4);
	a[5][6][0] = (-7);
	a[5][6][1] = (-4);
	a[5][6][2] = (3);
	a[5][6][3] = (4);
	blockC.b = (mat4(-1.0, 6.0, 1.0, 9.0, -3.0, -8.0, 0.0, -7.0, -9.0, 4.0, 3.0, 7.0, 0.0, -4.0, -4.0, -6.0));
	blockC.c = (mat4x2(4.0, 8.0, -1.0, -6.0, 4.0, 3.0, 2.0, 3.0));
	blockC.d[0] = u8vec4(uvec4(8u, 2u, 9u, 0u));
	blockC.d[1] = u8vec4(uvec4(0u, 3u, 2u, 3u));
	e = (mat3x4(-8.0, 8.0, -8.0, 5.0, 8.0, -6.0, 9.0, -3.0, -2.0, -4.0, 8.0, 7.0));
}
#version 450
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
	layout(offset = 0) lowp mat3 a;
} blockB[];

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

layout(std140, binding = 1) readonly buffer Block
{
	highp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(8.0, -4.0, -9.0, -6.0)) && allOk;
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
	lowp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(4.0, -8.0, -5.0, -3.0)) && allOk;
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(7.0, 7.0)) && allOk;
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
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], 0.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-1.0, -6.0, -7.0)) && allOk;
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
	allOk = compare_mat2x4(var, mat2x4(2.0, 8.0, 7.0, -3.0, 5.0, -4.0, 1.0, -2.0)) && allOk;
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
	bvec2 var;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var), bvec2(true, true)) && allOk;
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], 0.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-1.0, -6.0, -7.0)) && allOk;
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-2.0, 9.0, 9.0)) && allOk;
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, -5.0, 6.0, -5.0, -4.0, 8.0)) && allOk;
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0)) && allOk;
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
	f16vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var, mat3(1.0, -6.0, 5.0, 1.0, 0.0, -8.0, -1.0, -9.0, -9.0)) && allOk;
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], 7.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], 3.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_float(var[3][0], -2.0) && allOk;
	allOk = compare_float(var[3][1], -9.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_float(var[3][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-1.0, 8.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(4.0, -2.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, -4.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-2.0, -9.0, -5.0, 5.0)) && allOk;
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(3.0, -9.0, -5.0, -8.0, -3.0, -8.0)) && allOk;
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

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, -8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, 9.0)) && allOk;
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], 7.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], -8.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], 0.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-4.0, -6.0, -7.0, 0.0)) && allOk;
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[0][3], 1.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[1][3], -7.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(4.0, -3.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(4.0, -4.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 9.0, -5.0, -2.0)) && allOk;
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-1.0, 1.0, 7.0, -8.0, 9.0, -5.0, 9.0, -1.0)) && allOk;
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0, 8.0)) && allOk;
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

layout(scalar, binding = 1) readonly buffer Block
{
	int16_t var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var), -5) && allOk;
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

}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
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

layout(scalar, binding = 1) readonly buffer Block
{
	int padding;
	highp ivec2 var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 6) && allOk;
	allOk = compare_ivec2((var[0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((var[1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((var[2]), ivec2(8, -2)) && allOk;
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0, 8.0)) && allOk;
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

}
#version 450
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

}
#version 450
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
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
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

}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
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

layout(std430, binding = 1) readonly buffer Block
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

layout(scalar, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	mediump uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var), uvec3(8u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec3(6u, 0u, 5u));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-6.0, -3.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-2.0, -9.0));
	block.var[1] = (vec2(5.0, 8.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(6.0, 3.0, -1.0, -6.0, 2.0, 1.0, -4.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(2.0, -8.0, -5.0));
	block.var[1] = (vec3(-6.0, 3.0, -9.0));
	block.var[2] = (vec3(7.0, -3.0, 6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(9.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-8.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(3.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(7.0, -5.0, -9.0));
	block.var[1] = (vec3(6.0, 6.0, -2.0));
	block.var[2] = (vec3(6.0, 0.0, -8.0));
}
#version 450
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
	bvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (bvec2(true, false));
}
#version 450
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
	highp uint var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (7u);
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var = (mat2(2.0, 1.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat4(block.var, mat4(-4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0, 3.0, 1.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (vec4(6.0, -9.0, -1.0, -9.0));
	block.var[1] = (vec4(-4.0, -3.0, 5.0, 3.0));
	block.var[2] = (vec4(7.0, 6.0, 9.0, 0.0));
	block.var[3] = (vec4(8.0, -3.0, -1.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat3x2(-4.0, 4.0, -5.0, 1.0, 9.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(2.0, -7.0, 9.0, -8.0, 7.0, -7.0, -6.0, -6.0, 1.0, 3.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0] = (vec4(-8.0, -5.0, -7.0, 1.0));
	block.var[1] = (vec4(2.0, -4.0, -6.0, 6.0));
	block.var[2] = (vec4(2.0, 2.0, 0.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[2][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[2][1] = (vec3(1.0, 8.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
}
#version 450
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
	uint16_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = uint16_t(9u);
	block.var[1] = uint16_t(1u);
	block.var[2] = uint16_t(1u);
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0, -5.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][1] = (vec3(9.0, -2.0, 3.0));
	block.var[0][2] = (vec3(9.0, -9.0, 7.0));
	block.var[0][3] = (vec3(4.0, -4.0, 5.0));
	block.var[1][0] = (vec3(-1.0, -2.0, 6.0));
	block.var[1][1] = (vec3(-4.0, 6.0, 4.0));
	block.var[1][2] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][3] = (vec3(1.0, -9.0, -4.0));
	block.var[2][0] = (vec3(9.0, 2.0, 2.0));
	block.var[2][1] = (vec3(9.0, -7.0, 3.0));
	block.var[2][2] = (vec3(8.0, 2.0, 4.0));
	block.var[2][3] = (vec3(-9.0, 8.0, 2.0));
}
#version 450
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
	float16_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[4]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[5]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[6]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[7]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[8]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[9]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[10]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[11]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[12]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[13]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[14]), -8.0) && allOk;
	allOk = compare_float16_t(float(block.var[15]), -2.0) && allOk;
	allOk = compare_float16_t(float(block.var[16]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[17]), 3.0) && allOk;
	allOk = compare_float16_t(float(block.var[18]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = float16_t(-8.0);
	block.var[1] = float16_t(9.0);
	block.var[2] = float16_t(-2.0);
	block.var[3] = float16_t(7.0);
	block.var[4] = float16_t(8.0);
	block.var[5] = float16_t(-9.0);
	block.var[6] = float16_t(2.0);
	block.var[7] = float16_t(-8.0);
	block.var[8] = float16_t(-1.0);
	block.var[9] = float16_t(6.0);
	block.var[10] = float16_t(-7.0);
	block.var[11] = float16_t(-5.0);
	block.var[12] = float16_t(8.0);
	block.var[13] = float16_t(-3.0);
	block.var[14] = float16_t(6.0);
	block.var[15] = float16_t(-3.0);
	block.var[16] = float16_t(-8.0);
	block.var[17] = float16_t(1.0);
	block.var[18] = float16_t(3.0);
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
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
	block.var[3][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[3][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[3][2] = (vec3(7.0, 7.0, 9.0));
	block.var[4][0] = (vec3(4.0, 4.0, -3.0));
	block.var[4][1] = (vec3(9.0, 1.0, -6.0));
	block.var[4][2] = (vec3(7.0, -6.0, -1.0));
	block.var[5][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[5][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[5][2] = (vec3(2.0, -2.0, -7.0));
	block.var[6][0] = (vec3(6.0, -2.0, -1.0));
	block.var[6][1] = (vec3(9.0, 2.0, -4.0));
	block.var[6][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[7][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[7][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[7][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[8][0] = (vec3(0.0, -6.0, 0.0));
	block.var[8][1] = (vec3(8.0, 6.0, 4.0));
	block.var[8][2] = (vec3(7.0, -4.0, 4.0));
	block.var[9][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[9][1] = (vec3(0.0, -8.0, 6.0));
	block.var[9][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[10][0] = (vec3(4.0, -8.0, 1.0));
	block.var[10][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[10][2] = (vec3(6.0, 3.0, 0.0));
	block.var[11][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[11][1] = (vec3(1.0, 3.0, 4.0));
	block.var[11][2] = (vec3(5.0, -3.0, -6.0));
	block.var[12][0] = (vec3(-7.0, 1.0, -4.0));
	block.var[12][1] = (vec3(8.0, -5.0, 4.0));
	block.var[12][2] = (vec3(1.0, -7.0, 3.0));
	block.var[13][0] = (vec3(-3.0, -3.0, 6.0));
	block.var[13][1] = (vec3(8.0, 1.0, -8.0));
	block.var[13][2] = (vec3(5.0, 9.0, -2.0));
	block.var[14][0] = (vec3(4.0, -7.0, 4.0));
	block.var[14][1] = (vec3(-6.0, 5.0, -4.0));
	block.var[14][2] = (vec3(5.0, -3.0, 3.0));
	block.var[15][0] = (vec3(8.0, 6.0, 1.0));
	block.var[15][1] = (vec3(6.0, 5.0, 1.0));
	block.var[15][2] = (vec3(7.0, 9.0, 0.0));
	block.var[16][0] = (vec3(-7.0, 8.0, 6.0));
	block.var[16][1] = (vec3(4.0, -8.0, -8.0));
	block.var[16][2] = (vec3(8.0, 9.0, -9.0));
	block.var[17][0] = (vec3(-8.0, -3.0, -7.0));
	block.var[17][1] = (vec3(4.0, -6.0, -4.0));
	block.var[17][2] = (vec3(-6.0, 0.0, 0.0));
	block.var[18][0] = (vec3(-3.0, -9.0, 1.0));
	block.var[18][1] = (vec3(-2.0, 3.0, -3.0));
	block.var[18][2] = (vec3(-1.0, 5.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(5.0, -4.0));
	block.var[0][1] = (vec2(5.0, 1.0));
	block.var[1][0] = (vec2(-8.0, -1.0));
	block.var[1][1] = (vec2(9.0, -8.0));
	block.var[2][0] = (vec2(5.0, -4.0));
	block.var[2][1] = (vec2(5.0, -2.0));
	block.var[3][0] = (vec2(9.0, -9.0));
	block.var[3][1] = (vec2(-1.0, 6.0));
	block.var[4][0] = (vec2(-4.0, 7.0));
	block.var[4][1] = (vec2(-8.0, 1.0));
	block.var[5][0] = (vec2(4.0, -4.0));
	block.var[5][1] = (vec2(6.0, -5.0));
	block.var[6][0] = (vec2(4.0, -3.0));
	block.var[6][1] = (vec2(6.0, 7.0));
	block.var[7][0] = (vec2(-7.0, -9.0));
	block.var[7][1] = (vec2(5.0, 0.0));
	block.var[8][0] = (vec2(9.0, 2.0));
	block.var[8][1] = (vec2(1.0, -6.0));
	block.var[9][0] = (vec2(8.0, -8.0));
	block.var[9][1] = (vec2(5.0, -5.0));
	block.var[10][0] = (vec2(-5.0, 4.0));
	block.var[10][1] = (vec2(5.0, 0.0));
	block.var[11][0] = (vec2(6.0, 9.0));
	block.var[11][1] = (vec2(5.0, -8.0));
	block.var[12][0] = (vec2(7.0, 7.0));
	block.var[12][1] = (vec2(0.0, 2.0));
	block.var[13][0] = (vec2(4.0, -7.0));
	block.var[13][1] = (vec2(-5.0, -7.0));
	block.var[14][0] = (vec2(8.0, 2.0));
	block.var[14][1] = (vec2(1.0, -1.0));
	block.var[15][0] = (vec2(9.0, 0.0));
	block.var[15][1] = (vec2(-8.0, -9.0));
	block.var[16][0] = (vec2(-2.0, 7.0));
	block.var[16][1] = (vec2(8.0, 2.0));
	block.var[17][0] = (vec2(-3.0, -3.0));
	block.var[17][1] = (vec2(7.0, -2.0));
	block.var[18][0] = (vec2(4.0, -2.0));
	block.var[18][1] = (vec2(6.0, 1.0));
}
#version 450
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[3][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[3][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[3][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[4][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[4][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[4][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[5][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[5][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[5][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[6][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[6][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[6][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[7][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[7][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[7][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[8][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[8][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[8][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[9][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[9][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[9][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[10][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[10][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[10][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[11][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[11][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[11][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[12][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[12][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[12][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[13][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[13][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[13][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[14][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[14][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[14][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[15][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[15][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[15][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[16][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[16][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[16][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[17][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[17][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[17][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[18][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[18][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[18][2] = (vec4(7.0, -9.0, 0.0, -3.0));
}
#version 450
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
	f16vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[4]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[5]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[6]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[7]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[8]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[9]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[10]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[11]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[12]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[13]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[14]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[15]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[16]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[17]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[18]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[3] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[4] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[5] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[6] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[7] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[8] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[9] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[10] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[11] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	block.var[12] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	block.var[13] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	block.var[14] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	block.var[15] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	block.var[16] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	block.var[17] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	block.var[18] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, 4.0, -3.0, 1.0, -4.0, 4.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-5.0, -1.0, 4.0, 8.0, 7.0, 0.0, 8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-4.0, -1.0, 6.0, 8.0, -8.0, 8.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(9.0, -3.0, 1.0, 6.0, -6.0, -5.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(4.0, 5.0, 6.0, 1.0, 5.0, 9.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][0][0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][0][0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[0][0][1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[0][0][1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[0][0][1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[0][0][2][0] = (vec3(7.0, 9.0, -7.0));
	block.var[0][0][2][1] = (vec3(8.0, 2.0, 5.0));
	block.var[0][0][2][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[0][1][0][0] = (vec3(-7.0, 1.0, -4.0));
	block.var[0][1][0][1] = (vec3(8.0, -5.0, 4.0));
	block.var[0][1][0][2] = (vec3(1.0, -7.0, 3.0));
	block.var[0][1][1][0] = (vec3(-3.0, -3.0, 6.0));
	block.var[0][1][1][1] = (vec3(8.0, 1.0, -8.0));
	block.var[0][1][1][2] = (vec3(5.0, 9.0, -2.0));
	block.var[0][1][2][0] = (vec3(4.0, -7.0, 4.0));
	block.var[0][1][2][1] = (vec3(-6.0, 5.0, -4.0));
	block.var[0][1][2][2] = (vec3(5.0, -3.0, 3.0));
	block.var[1][0][0][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[1][0][0][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[1][0][0][2] = (vec3(7.0, 7.0, 9.0));
	block.var[1][0][1][0] = (vec3(4.0, 4.0, -3.0));
	block.var[1][0][1][1] = (vec3(9.0, 1.0, -6.0));
	block.var[1][0][1][2] = (vec3(7.0, -6.0, -1.0));
	block.var[1][0][2][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[1][0][2][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[1][0][2][2] = (vec3(2.0, -2.0, -7.0));
	block.var[1][1][0][0] = (vec3(8.0, 6.0, 1.0));
	block.var[1][1][0][1] = (vec3(6.0, 5.0, 1.0));
	block.var[1][1][0][2] = (vec3(7.0, 9.0, 0.0));
	block.var[1][1][1][0] = (vec3(-7.0, 8.0, 6.0));
	block.var[1][1][1][1] = (vec3(4.0, -8.0, -8.0));
	block.var[1][1][1][2] = (vec3(8.0, 9.0, -9.0));
	block.var[1][1][2][0] = (vec3(-8.0, -3.0, -7.0));
	block.var[1][1][2][1] = (vec3(4.0, -6.0, -4.0));
	block.var[1][1][2][2] = (vec3(-6.0, 0.0, 0.0));
	block.var[2][0][0][0] = (vec3(6.0, -2.0, -1.0));
	block.var[2][0][0][1] = (vec3(9.0, 2.0, -4.0));
	block.var[2][0][0][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[2][0][1][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[2][0][1][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[2][0][1][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[2][0][2][0] = (vec3(0.0, -6.0, 0.0));
	block.var[2][0][2][1] = (vec3(8.0, 6.0, 4.0));
	block.var[2][0][2][2] = (vec3(7.0, -4.0, 4.0));
	block.var[2][1][0][0] = (vec3(-3.0, -9.0, 1.0));
	block.var[2][1][0][1] = (vec3(-2.0, 3.0, -3.0));
	block.var[2][1][0][2] = (vec3(-1.0, 5.0, -8.0));
	block.var[2][1][1][0] = (vec3(3.0, -4.0, 8.0));
	block.var[2][1][1][1] = (vec3(-7.0, -8.0, -8.0));
	block.var[2][1][1][2] = (vec3(-6.0, 2.0, -1.0));
	block.var[2][1][2][0] = (vec3(5.0, 1.0, 3.0));
	block.var[2][1][2][1] = (vec3(-4.0, -5.0, 5.0));
	block.var[2][1][2][2] = (vec3(-6.0, 8.0, -7.0));
	block.var[3][0][0][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[3][0][0][1] = (vec3(0.0, -8.0, 6.0));
	block.var[3][0][0][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[3][0][1][0] = (vec3(4.0, -8.0, 1.0));
	block.var[3][0][1][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[3][0][1][2] = (vec3(6.0, 3.0, 0.0));
	block.var[3][0][2][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[3][0][2][1] = (vec3(1.0, 3.0, 4.0));
	block.var[3][0][2][2] = (vec3(5.0, -3.0, -6.0));
	block.var[3][1][0][0] = (vec3(0.0, -1.0, -9.0));
	block.var[3][1][0][1] = (vec3(-3.0, -5.0, 3.0));
	block.var[3][1][0][2] = (vec3(-3.0, -4.0, -7.0));
	block.var[3][1][1][0] = (vec3(-5.0, 4.0, -6.0));
	block.var[3][1][1][1] = (vec3(-3.0, -1.0, -3.0));
	block.var[3][1][1][2] = (vec3(3.0, 3.0, 9.0));
	block.var[3][1][2][0] = (vec3(-6.0, -4.0, -5.0));
	block.var[3][1][2][1] = (vec3(5.0, 6.0, 7.0));
	block.var[3][1][2][2] = (vec3(-1.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
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
	block.var[0][0][2][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[0][0][2][1] = (vec3(9.0, 5.0, -7.0));
	block.var[0][0][2][2] = (vec3(8.0, 9.0, 0.0));
	block.var[0][0][2][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[0][1][0][0] = (vec3(-5.0, 3.0, -5.0));
	block.var[0][1][0][1] = (vec3(-6.0, 6.0, 3.0));
	block.var[0][1][0][2] = (vec3(-6.0, 0.0, -5.0));
	block.var[0][1][0][3] = (vec3(-9.0, 8.0, -8.0));
	block.var[0][1][1][0] = (vec3(-5.0, 2.0, -7.0));
	block.var[0][1][1][1] = (vec3(-1.0, -2.0, 7.0));
	block.var[0][1][1][2] = (vec3(4.0, -7.0, 7.0));
	block.var[0][1][1][3] = (vec3(-3.0, 7.0, 6.0));
	block.var[0][1][2][0] = (vec3(9.0, -2.0, 2.0));
	block.var[0][1][2][1] = (vec3(-3.0, -6.0, 3.0));
	block.var[0][1][2][2] = (vec3(7.0, -7.0, -1.0));
	block.var[0][1][2][3] = (vec3(0.0, 1.0, -3.0));
	block.var[1][0][0][0] = (vec3(7.0, -8.0, -7.0));
	block.var[1][0][0][1] = (vec3(2.0, 7.0, 5.0));
	block.var[1][0][0][2] = (vec3(5.0, -7.0, 0.0));
	block.var[1][0][0][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[1][0][1][0] = (vec3(2.0, -9.0, 0.0));
	block.var[1][0][1][1] = (vec3(9.0, -2.0, -8.0));
	block.var[1][0][1][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[1][0][1][3] = (vec3(0.0, 8.0, -9.0));
	block.var[1][0][2][0] = (vec3(2.0, 1.0, -7.0));
	block.var[1][0][2][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[1][0][2][2] = (vec3(8.0, -8.0, -5.0));
	block.var[1][0][2][3] = (vec3(5.0, 1.0, -3.0));
	block.var[1][1][0][0] = (vec3(-6.0, 6.0, 2.0));
	block.var[1][1][0][1] = (vec3(-5.0, 0.0, 4.0));
	block.var[1][1][0][2] = (vec3(7.0, -6.0, -6.0));
	block.var[1][1][0][3] = (vec3(3.0, 8.0, 1.0));
	block.var[1][1][1][0] = (vec3(-3.0, -1.0, 7.0));
	block.var[1][1][1][1] = (vec3(-2.0, -7.0, -9.0));
	block.var[1][1][1][2] = (vec3(-8.0, -1.0, 4.0));
	block.var[1][1][1][3] = (vec3(0.0, -2.0, -5.0));
	block.var[1][1][2][0] = (vec3(2.0, -7.0, 3.0));
	block.var[1][1][2][1] = (vec3(-2.0, 4.0, -6.0));
	block.var[1][1][2][2] = (vec3(8.0, -7.0, -9.0));
	block.var[1][1][2][3] = (vec3(-4.0, 5.0, 4.0));
	block.var[2][0][0][0] = (vec3(2.0, 5.0, 2.0));
	block.var[2][0][0][1] = (vec3(2.0, 3.0, -2.0));
	block.var[2][0][0][2] = (vec3(5.0, 4.0, 6.0));
	block.var[2][0][0][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[2][0][1][0] = (vec3(1.0, 2.0, -4.0));
	block.var[2][0][1][1] = (vec3(9.0, -1.0, 6.0));
	block.var[2][0][1][2] = (vec3(9.0, -1.0, -2.0));
	block.var[2][0][1][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[2][0][2][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[2][0][2][1] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][2][2] = (vec3(1.0, -6.0, 1.0));
	block.var[2][0][2][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[2][1][0][0] = (vec3(1.0, -1.0, 8.0));
	block.var[2][1][0][1] = (vec3(8.0, 3.0, -9.0));
	block.var[2][1][0][2] = (vec3(1.0, -1.0, -7.0));
	block.var[2][1][0][3] = (vec3(-1.0, -7.0, -5.0));
	block.var[2][1][1][0] = (vec3(-5.0, 1.0, 8.0));
	block.var[2][1][1][1] = (vec3(5.0, 5.0, -8.0));
	block.var[2][1][1][2] = (vec3(-8.0, 2.0, 8.0));
	block.var[2][1][1][3] = (vec3(2.0, -8.0, -6.0));
	block.var[2][1][2][0] = (vec3(-9.0, 1.0, 5.0));
	block.var[2][1][2][1] = (vec3(4.0, 5.0, 1.0));
	block.var[2][1][2][2] = (vec3(-7.0, 4.0, -5.0));
	block.var[2][1][2][3] = (vec3(4.0, 8.0, 8.0));
	block.var[3][0][0][0] = (vec3(1.0, 9.0, -4.0));
	block.var[3][0][0][1] = (vec3(1.0, -5.0, 9.0));
	block.var[3][0][0][2] = (vec3(2.0, -1.0, -1.0));
	block.var[3][0][0][3] = (vec3(5.0, 7.0, -4.0));
	block.var[3][0][1][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[3][0][1][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[3][0][1][2] = (vec3(0.0, 7.0, 9.0));
	block.var[3][0][1][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[3][0][2][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[3][0][2][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[3][0][2][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[3][0][2][3] = (vec3(-5.0, -7.0, 7.0));
	block.var[3][1][0][0] = (vec3(-4.0, -2.0, -5.0));
	block.var[3][1][0][1] = (vec3(-5.0, -9.0, 8.0));
	block.var[3][1][0][2] = (vec3(4.0, 8.0, 0.0));
	block.var[3][1][0][3] = (vec3(0.0, 9.0, 5.0));
	block.var[3][1][1][0] = (vec3(-3.0, 8.0, 6.0));
	block.var[3][1][1][1] = (vec3(7.0, 8.0, -7.0));
	block.var[3][1][1][2] = (vec3(-3.0, -6.0, -2.0));
	block.var[3][1][1][3] = (vec3(-6.0, 0.0, -8.0));
	block.var[3][1][2][0] = (vec3(-6.0, 0.0, 6.0));
	block.var[3][1][2][1] = (vec3(-1.0, 6.0, -7.0));
	block.var[3][1][2][2] = (vec3(7.0, 0.0, 1.0));
	block.var[3][1][2][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, -3.0, -9.0, 2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(5.0, 2.0, 7.0, -1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(9.0, 7.0, -8.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(7.0, -7.0, -2.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][0][1] = (vec2(1.0, 8.0));
	block.var[0][0][0][2] = (vec2(-7.0, 5.0));
	block.var[0][0][1][0] = (vec2(2.0, 0.0));
	block.var[0][0][1][1] = (vec2(-3.0, 1.0));
	block.var[0][0][1][2] = (vec2(2.0, -5.0));
	block.var[0][0][2][0] = (vec2(6.0, 3.0));
	block.var[0][0][2][1] = (vec2(6.0, 5.0));
	block.var[0][0][2][2] = (vec2(-5.0, 9.0));
	block.var[0][1][0][0] = (vec2(2.0, -2.0));
	block.var[0][1][0][1] = (vec2(-2.0, -8.0));
	block.var[0][1][0][2] = (vec2(7.0, -7.0));
	block.var[0][1][1][0] = (vec2(-1.0, 6.0));
	block.var[0][1][1][1] = (vec2(-8.0, 4.0));
	block.var[0][1][1][2] = (vec2(-5.0, 3.0));
	block.var[0][1][2][0] = (vec2(-9.0, -8.0));
	block.var[0][1][2][1] = (vec2(8.0, -9.0));
	block.var[0][1][2][2] = (vec2(-1.0, 1.0));
	block.var[1][0][0][0] = (vec2(-8.0, 9.0));
	block.var[1][0][0][1] = (vec2(3.0, -3.0));
	block.var[1][0][0][2] = (vec2(3.0, -5.0));
	block.var[1][0][1][0] = (vec2(7.0, -8.0));
	block.var[1][0][1][1] = (vec2(3.0, 1.0));
	block.var[1][0][1][2] = (vec2(-2.0, 1.0));
	block.var[1][0][2][0] = (vec2(4.0, -9.0));
	block.var[1][0][2][1] = (vec2(3.0, 6.0));
	block.var[1][0][2][2] = (vec2(7.0, 1.0));
	block.var[1][1][0][0] = (vec2(0.0, 2.0));
	block.var[1][1][0][1] = (vec2(-1.0, -9.0));
	block.var[1][1][0][2] = (vec2(3.0, 4.0));
	block.var[1][1][1][0] = (vec2(6.0, -1.0));
	block.var[1][1][1][1] = (vec2(-4.0, -4.0));
	block.var[1][1][1][2] = (vec2(0.0, -6.0));
	block.var[1][1][2][0] = (vec2(5.0, -8.0));
	block.var[1][1][2][1] = (vec2(6.0, -8.0));
	block.var[1][1][2][2] = (vec2(-5.0, -8.0));
	block.var[2][0][0][0] = (vec2(9.0, -9.0));
	block.var[2][0][0][1] = (vec2(0.0, -6.0));
	block.var[2][0][0][2] = (vec2(-7.0, 7.0));
	block.var[2][0][1][0] = (vec2(-8.0, 7.0));
	block.var[2][0][1][1] = (vec2(9.0, 6.0));
	block.var[2][0][1][2] = (vec2(-1.0, 0.0));
	block.var[2][0][2][0] = (vec2(-3.0, 6.0));
	block.var[2][0][2][1] = (vec2(-1.0, -6.0));
	block.var[2][0][2][2] = (vec2(-1.0, -3.0));
	block.var[2][1][0][0] = (vec2(4.0, -9.0));
	block.var[2][1][0][1] = (vec2(-4.0, 4.0));
	block.var[2][1][0][2] = (vec2(5.0, 3.0));
	block.var[2][1][1][0] = (vec2(-3.0, -5.0));
	block.var[2][1][1][1] = (vec2(5.0, 1.0));
	block.var[2][1][1][2] = (vec2(3.0, -3.0));
	block.var[2][1][2][0] = (vec2(-1.0, -6.0));
	block.var[2][1][2][1] = (vec2(-6.0, 8.0));
	block.var[2][1][2][2] = (vec2(-3.0, 7.0));
	block.var[3][0][0][0] = (vec2(0.0, -1.0));
	block.var[3][0][0][1] = (vec2(4.0, -9.0));
	block.var[3][0][0][2] = (vec2(1.0, 1.0));
	block.var[3][0][1][0] = (vec2(-9.0, 7.0));
	block.var[3][0][1][1] = (vec2(0.0, 4.0));
	block.var[3][0][1][2] = (vec2(-3.0, -3.0));
	block.var[3][0][2][0] = (vec2(6.0, 8.0));
	block.var[3][0][2][1] = (vec2(-7.0, 5.0));
	block.var[3][0][2][2] = (vec2(-6.0, -5.0));
	block.var[3][1][0][0] = (vec2(-6.0, 6.0));
	block.var[3][1][0][1] = (vec2(6.0, 7.0));
	block.var[3][1][0][2] = (vec2(3.0, -9.0));
	block.var[3][1][1][0] = (vec2(-4.0, -6.0));
	block.var[3][1][1][1] = (vec2(-6.0, 2.0));
	block.var[3][1][1][2] = (vec2(6.0, -3.0));
	block.var[3][1][2][0] = (vec2(-1.0, -9.0));
	block.var[3][1][2][1] = (vec2(8.0, -4.0));
	block.var[3][1][2][2] = (vec2(-9.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0, -8.0, 6.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0, -5.0, 8.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0, -5.0, 4.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0, 0.0, -4.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0, 5.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0, -2.0, 3.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0, -3.0, 1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0, -2.0, 9.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0, 9.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0, 7.0, -2.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0, 6.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0, 8.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0, -3.0, -4.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0, -3.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0, 4.0, 7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0, -2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0, -5.0, 7.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0, 4.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0, 1.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0, 1.0, 1.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0, -2.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0, -9.0, 3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0][0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][0][1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][0][0][2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	block.var[0][0][1][0] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][0][1][1] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][0][1][2] = (vec4(-7.0, 6.0, -4.0, 2.0));
	block.var[0][0][2][0] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[0][0][2][1] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[0][0][2][2] = (vec4(-7.0, 2.0, -6.0, 3.0));
	block.var[0][1][0][0] = (vec4(-4.0, 6.0, -3.0, -6.0));
	block.var[0][1][0][1] = (vec4(2.0, -9.0, -8.0, 6.0));
	block.var[0][1][0][2] = (vec4(5.0, 1.0, 8.0, -7.0));
	block.var[0][1][1][0] = (vec4(9.0, 8.0, -6.0, -2.0));
	block.var[0][1][1][1] = (vec4(9.0, -5.0, 4.0, -4.0));
	block.var[0][1][1][2] = (vec4(0.0, 5.0, 8.0, -5.0));
	block.var[0][1][2][0] = (vec4(-2.0, 5.0, -5.0, 9.0));
	block.var[0][1][2][1] = (vec4(7.0, -5.0, -3.0, 0.0));
	block.var[0][1][2][2] = (vec4(-1.0, -2.0, -8.0, -5.0));
	block.var[1][0][0][0] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][0][1] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][0][0][2] = (vec4(-3.0, 5.0, 9.0, 3.0));
	block.var[1][0][1][0] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[1][0][1][1] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[1][0][1][2] = (vec4(4.0, -1.0, -5.0, -8.0));
	block.var[1][0][2][0] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[1][0][2][1] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[1][0][2][2] = (vec4(-2.0, 9.0, 8.0, 7.0));
	block.var[1][1][0][0] = (vec4(7.0, -8.0, -6.0, 0.0));
	block.var[1][1][0][1] = (vec4(7.0, -9.0, 2.0, 3.0));
	block.var[1][1][0][2] = (vec4(-6.0, 7.0, 0.0, 6.0));
	block.var[1][1][1][0] = (vec4(0.0, 2.0, 9.0, -1.0));
	block.var[1][1][1][1] = (vec4(3.0, -4.0, 9.0, -2.0));
	block.var[1][1][1][2] = (vec4(-9.0, -7.0, 6.0, -4.0));
	block.var[1][1][2][0] = (vec4(-4.0, 3.0, 1.0, -1.0));
	block.var[1][1][2][1] = (vec4(9.0, -4.0, -1.0, 3.0));
	block.var[1][1][2][2] = (vec4(6.0, 1.0, -2.0, -1.0));
	block.var[2][0][0][0] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[2][0][0][1] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[2][0][0][2] = (vec4(4.0, -2.0, -4.0, 2.0));
	block.var[2][0][1][0] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[2][0][1][1] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[2][0][1][2] = (vec4(3.0, -1.0, 9.0, -8.0));
	block.var[2][0][2][0] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[2][0][2][1] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[2][0][2][2] = (vec4(4.0, -8.0, 5.0, -2.0));
	block.var[2][1][0][0] = (vec4(6.0, 2.0, -2.0, 8.0));
	block.var[2][1][0][1] = (vec4(9.0, 2.0, -4.0, 7.0));
	block.var[2][1][0][2] = (vec4(-1.0, -9.0, -5.0, -8.0));
	block.var[2][1][1][0] = (vec4(-5.0, 2.0, -3.0, 5.0));
	block.var[2][1][1][1] = (vec4(-3.0, -2.0, -5.0, 3.0));
	block.var[2][1][1][2] = (vec4(-7.0, 8.0, -8.0, -3.0));
	block.var[2][1][2][0] = (vec4(-4.0, 6.0, -2.0, -2.0));
	block.var[2][1][2][1] = (vec4(-4.0, -3.0, -1.0, -3.0));
	block.var[2][1][2][2] = (vec4(8.0, -3.0, -6.0, 7.0));
	block.var[3][0][0][0] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[3][0][0][1] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[3][0][0][2] = (vec4(4.0, -9.0, -3.0, -6.0));
	block.var[3][0][1][0] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[3][0][1][1] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[3][0][1][2] = (vec4(2.0, 5.0, -5.0, 7.0));
	block.var[3][0][2][0] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[3][0][2][1] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[3][0][2][2] = (vec4(-4.0, -7.0, -3.0, 7.0));
	block.var[3][1][0][0] = (vec4(-6.0, 4.0, -4.0, -8.0));
	block.var[3][1][0][1] = (vec4(1.0, 2.0, 2.0, -4.0));
	block.var[3][1][0][2] = (vec4(9.0, -4.0, 8.0, -1.0));
	block.var[3][1][1][0] = (vec4(5.0, 9.0, 3.0, -7.0));
	block.var[3][1][1][1] = (vec4(7.0, -8.0, -1.0, -8.0));
	block.var[3][1][1][2] = (vec4(-9.0, 2.0, 6.0, 3.0));
	block.var[3][1][2][0] = (vec4(-5.0, 3.0, 5.0, -2.0));
	block.var[3][1][2][1] = (vec4(-3.0, 2.0, 1.0, 6.0));
	block.var[3][1][2][2] = (vec4(-4.0, 6.0, -5.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0, -9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(-2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0, 0.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0, -3.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0, 7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(-1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0, -7.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0, 8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0, -2.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(-4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0, -3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0, 7.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0, 1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0, 2.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0, 6.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(-3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0, -6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0, -5.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(-9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0, 2.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (mat4x3(4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0, 9.0, 6.0, -8.0));
	block.var[0][0][1] = (mat4x3(9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0, -2.0, 9.0, 6.0));
	block.var[0][0][2] = (mat4x3(9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0, 8.0, 8.0, -7.0));
	block.var[0][1][0] = (mat4x3(6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0, -6.0, 6.0, 0.0));
	block.var[0][1][1] = (mat4x3(0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0, 0.0, 8.0, -9.0));
	block.var[0][1][2] = (mat4x3(9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0, 8.0, 6.0, 1.0));
	block.var[1][0][0] = (mat4x3(-9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0, 2.0, -4.0, 0.0));
	block.var[1][0][1] = (mat4x3(-6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0, 1.0, -1.0, -9.0));
	block.var[1][0][2] = (mat4x3(-9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0, -1.0, -4.0, 0.0));
	block.var[1][1][0] = (mat4x3(9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0, -7.0, -5.0, 7.0));
	block.var[1][1][1] = (mat4x3(-5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0, -7.0, -2.0, 8.0));
	block.var[1][1][2] = (mat4x3(1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0, 7.0, -8.0, -3.0));
	block.var[2][0][0] = (mat4x3(-3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0, 5.0, -1.0, 2.0));
	block.var[2][0][1] = (mat4x3(5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0, 9.0, -6.0, 8.0));
	block.var[2][0][2] = (mat4x3(1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0, 9.0, 0.0, 2.0));
	block.var[2][1][0] = (mat4x3(5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0, -3.0, 9.0, 5.0));
	block.var[2][1][1] = (mat4x3(8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0, 0.0, 3.0, 6.0));
	block.var[2][1][2] = (mat4x3(-9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0, -8.0, -9.0, 5.0));
	block.var[3][0][0] = (mat4x3(1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0, 7.0, 3.0, -1.0));
	block.var[3][0][1] = (mat4x3(4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0, 7.0, 7.0, 9.0));
	block.var[3][0][2] = (mat4x3(-2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0, 4.0, 1.0, 7.0));
	block.var[3][1][0] = (mat4x3(-9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0, 2.0, 7.0, -1.0));
	block.var[3][1][1] = (mat4x3(4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0, 7.0, 7.0, 7.0));
	block.var[3][1][2] = (mat4x3(1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0, -1.0, -2.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[0][1][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[0][1][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[0][2][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	block.var[0][2][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	block.var[0][3][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	block.var[0][3][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	block.var[1][0][0] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[1][0][1] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[1][1][0] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[1][1][1] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[1][2][0] = (mat2(-7.0, -9.0, -5.0, 3.0));
	block.var[1][2][1] = (mat2(-1.0, -1.0, -6.0, -3.0));
	block.var[1][3][0] = (mat2(-8.0, 0.0, 8.0, 8.0));
	block.var[1][3][1] = (mat2(-3.0, -9.0, 5.0, -2.0));
	block.var[2][0][0] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[2][0][1] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[2][1][0] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[2][1][1] = (mat2(7.0, 2.0, -8.0, -7.0));
	block.var[2][2][0] = (mat2(-9.0, -4.0, -8.0, -1.0));
	block.var[2][2][1] = (mat2(-8.0, 1.0, -2.0, 9.0));
	block.var[2][3][0] = (mat2(1.0, 9.0, -3.0, -5.0));
	block.var[2][3][1] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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

layout(scalar, buffer_reference) buffer Block
{
	u16vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0][0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2][0]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2][1]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][3][0]), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][3][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][0]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][1]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][0]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][1]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2][0]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2][1]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][3][0]), uvec3(8u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][3][1]), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][0]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][1]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][0]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][1]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2][0]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2][1]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][3][0]), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][3][1]), uvec3(3u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[0][0][1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[0][1][0] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[0][1][1] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[0][2][0] = u16vec3(uvec3(1u, 3u, 3u));
	block.var[0][2][1] = u16vec3(uvec3(0u, 2u, 2u));
	block.var[0][3][0] = u16vec3(uvec3(6u, 1u, 7u));
	block.var[0][3][1] = u16vec3(uvec3(6u, 2u, 5u));
	block.var[1][0][0] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[1][0][1] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[1][1][0] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[1][1][1] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[1][2][0] = u16vec3(uvec3(7u, 9u, 1u));
	block.var[1][2][1] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[1][3][0] = u16vec3(uvec3(3u, 6u, 4u));
	block.var[1][3][1] = u16vec3(uvec3(6u, 5u, 2u));
	block.var[2][0][0] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[2][0][1] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[2][1][0] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[2][1][1] = u16vec3(uvec3(1u, 2u, 8u));
	block.var[2][2][0] = u16vec3(uvec3(9u, 6u, 3u));
	block.var[2][2][1] = u16vec3(uvec3(2u, 0u, 6u));
	block.var[2][3][0] = u16vec3(uvec3(3u, 1u, 1u));
	block.var[2][3][1] = u16vec3(uvec3(7u, 8u, 8u));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-9, 2, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(1.0, 5.0, 0.0, -2.0, -5.0, -5.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(0.0, 8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(-1, -7, -4)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(-9.0, 7.0, 0.0, 0.0, 2.0, 7.0, 1.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-3.0, -9.0, -3.0, -9.0, 1.0, 2.0, 6.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(0, 3, 3)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(5.0, -1.0, -2.0, -6.0, -4.0, -8.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(0.0, -9.0, 2.0, -9.0, 2.0, 8.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(0.0, 6.0, -3.0, -6.0, 8.0, -2.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-4.0, -2.0, -4.0, -3.0, 9.0, -4.0, -8.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(0.0, 3.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(5.0, -5.0, 5.0, -3.0, -2.0, -9.0, 9.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(3, -3, 9)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(6.0, -7.0, 0.0, 2.0, 5.0, 4.0, 9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(0.0, -1.0, 1.0, 3.0, 7.0, -4.0, 1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(-3.0, -3.0, 5.0, 2.0, 1.0, -1.0, -5.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-7.0, 5.0, 0.0, 7.0, 5.0, 0.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(7.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(8, -3, -1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-2.0, -2.0, -7.0, 1.0, -2.0, -9.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(1.0, 6.0, -2.0, 9.0, 8.0, -9.0, -4.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(5.0, 6.0, 2.0, -2.0, -6.0, 1.0, -7.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-3.0, -4.0, -7.0, -7.0, 1.0, -1.0, 4.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-7.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(0.0, -8.0, 2.0, -3.0, 4.0, -7.0, -3.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(-7, 7, 1)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(5.0, 5.0, 1.0, 1.0, -3.0, -8.0, -4.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(8.0, -5.0, -2.0, -3.0, -2.0, -9.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(-8.0, -6.0, -6.0, 5.0, 8.0, 4.0, 6.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-2.0, 1.0, -1.0, 6.0, 2.0, -7.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(1.0, -2.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(-2.0, -3.0, -5.0, -8.0, 9.0, 4.0, -6.0, 1.0, -4.0));
	block[0].t.b.a = (ivec3(-2, 9, 6));
	block[0].t.b.b[0] = (mat3(-3.0, -7.0, 7.0, 5.0, 2.0, -7.0, 6.0, 1.0, 3.0));
	block[0].t.b.b[1] = (mat3(6.0, -6.0, 5.0, -6.0, 3.0, 5.0, 5.0, 4.0, -7.0));
	block[0].t.b.b[2] = (mat3(-5.0, 6.0, -2.0, 8.0, -4.0, 1.0, 7.0, -9.0, 9.0));
	block[0].t.b.b[3] = (mat3(8.0, -9.0, 6.0, 0.0, 0.0, 7.0, 1.0, -9.0, -1.0));
	block[0].t.b.c = (vec4(-3.0, 1.0, 9.0, 0.0));
	block[0].u = (6u);
	block[1].t.a = (mat3(7.0, -6.0, 5.0, 4.0, 1.0, -5.0, -2.0, -5.0, -9.0));
	block[1].t.b.a = (ivec3(-6, 2, 7));
	block[1].t.b.b[0] = (mat3(3.0, -2.0, 4.0, -5.0, 9.0, -1.0, 1.0, 5.0, -4.0));
	block[1].t.b.b[1] = (mat3(9.0, 7.0, -9.0, -9.0, 1.0, 5.0, 5.0, -8.0, 8.0));
	block[1].t.b.b[2] = (mat3(7.0, 4.0, -3.0, -7.0, 4.0, 9.0, 9.0, 4.0, -6.0));
	block[1].t.b.b[3] = (mat3(-6.0, -7.0, 8.0, -4.0, 7.0, 7.0, 7.0, -1.0, 3.0));
	block[1].t.b.c = (vec4(4.0, -7.0, -6.0, 8.0));
	block[1].u = (4u);
	block[2].t.a = (mat3(-1.0, -2.0, -5.0, 3.0, -8.0, -5.0, 0.0, 2.0, -8.0));
	block[2].t.b.a = (ivec3(-9, -3, -6));
	block[2].t.b.b[0] = (mat3(1.0, -8.0, -2.0, -7.0, 5.0, 6.0, -6.0, 5.0, -1.0));
	block[2].t.b.b[1] = (mat3(7.0, -4.0, 4.0, 9.0, 8.0, 4.0, 6.0, 7.0, -7.0));
	block[2].t.b.b[2] = (mat3(9.0, 8.0, 5.0, -9.0, -1.0, -7.0, -3.0, -5.0, 5.0));
	block[2].t.b.b[3] = (mat3(-2.0, 4.0, -4.0, -9.0, -2.0, 1.0, -2.0, 6.0, 2.0));
	block[2].t.b.c = (vec4(-9.0, 7.0, -1.0, 8.0));
	block[2].u = (7u);
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(4, 1, -8)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(3.0, 7.0, -3.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-6, 9, 6)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-4.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-7, -5, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-8.0, -3.0, 3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(2, -9, 6)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(3.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(-7, 1, 8)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-1.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-1, -7, 0)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(-7.0, 4.0, -9.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-2, -4, 7)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-3.0, 5.0, 4.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(0, 2, -8)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(3.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-9, -2, 2)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(2.0, -2.0, -3.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(2, -7, -6)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-4.0, -1.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(7, -4, -7)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-1.0, 9.0, 7.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(9, 1, -6)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(1.0, -1.0, 0.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-7.0, -8.0, 3.0, 7.0));
	block[0].s[0][0].a = (ivec3(5, 6, 5));
	block[0].s[0][0].c = (vec4(7.0, 9.0, 3.0, -5.0));
	block[0].s[0][1].a = (ivec3(1, -8, -8));
	block[0].s[0][1].c = (vec4(7.0, 9.0, -3.0, -5.0));
	block[0].s[1][0].a = (ivec3(4, 6, -7));
	block[0].s[1][0].c = (vec4(-5.0, 4.0, 3.0, -2.0));
	block[0].s[1][1].a = (ivec3(-4, 4, 0));
	block[0].s[1][1].c = (vec4(3.0, 6.0, 3.0, 5.0));
	block[0].s[2][0].a = (ivec3(9, 0, 5));
	block[0].s[2][0].c = (vec4(-3.0, -4.0, 1.0, 2.0));
	block[0].s[2][1].a = (ivec3(-5, 2, 0));
	block[0].s[2][1].c = (vec4(4.0, 3.0, -6.0, 8.0));
	block[1].v = (vec4(-6.0, 1.0, 8.0, -6.0));
	block[1].s[0][0].a = (ivec3(-3, -8, 9));
	block[1].s[0][0].c = (vec4(-2.0, 4.0, -6.0, 6.0));
	block[1].s[0][1].a = (ivec3(-7, -3, 7));
	block[1].s[0][1].c = (vec4(-5.0, 7.0, -5.0, 3.0));
	block[1].s[1][0].a = (ivec3(-8, 6, 2));
	block[1].s[1][0].c = (vec4(-4.0, -1.0, 3.0, 0.0));
	block[1].s[1][1].a = (ivec3(-6, 8, -3));
	block[1].s[1][1].c = (vec4(2.0, -9.0, -5.0, 9.0));
	block[2].v = (vec4(-1.0, -2.0, 5.0, -1.0));
	block[2].s[0][0].a = (ivec3(0, -2, -1));
	block[2].s[0][0].c = (vec4(4.0, 8.0, -2.0, -4.0));
	block[2].s[0][1].a = (ivec3(9, -5, -5));
	block[2].s[0][1].c = (vec4(-5.0, 4.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_uint((block[0].u), 6u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(0.0, -7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 7u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(2.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(0.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(6u, 8u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(1.0, 5.0, -9.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(5u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-2.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -7) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0, -1.0, 9.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(2u, 1u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(2.0, 8.0, -4.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(9u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-3.0, 5.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(1u, 9u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-8.0, -7.0, 7.0, -4.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -3) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(-8.0, 5.0, 2.0, 0.0, 8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(7u, 5u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(3.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-6.0, 0.0, 6.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(4u, 4u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-1.0, -5.0, -2.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(8u, 2u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(9.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 9) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-1.0, -7.0, -4.0, 5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(8u, 8u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-6.0, 8.0, -2.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(6u, 3u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-7.0, 5.0, 0.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(5u, 5u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-8.0, 2.0, -3.0, 4.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -7) && allOk;
	allOk = compare_uint((block[1].u), 5u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-5.0, 3.0, -4.0, -8.0, -6.0, -6.0, 5.0, 8.0, 4.0, 6.0, -5.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(3u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-2.0, 6.0, 3.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-8.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(1u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(9.0, -3.0, -9.0, 8.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 1) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(8.0, -8.0, 7.0, 1.0, -9.0, -2.0, 7.0, 3.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(5u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-5.0, 4.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(7u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(8.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(0u, 8u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(4.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-1.0, -2.0, 6.0, 4.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(3u, 0u, 0u));
	block[0].s.b[0] = (vec2(5.0, 3.0));
	block[0].s.b[1] = (vec2(-9.0, -1.0));
	block[0].s.b[2] = (vec2(5.0, 9.0));
	block[0].s.b[3] = (vec2(-5.0, 5.0));
	block[0].s.c = (vec4(7.0, -1.0, -8.0, -6.0));
	block[0].u = (6u);
	block[1].s.a = (uvec3(3u, 9u, 9u));
	block[1].s.b[0] = (vec2(1.0, -8.0));
	block[1].s.b[1] = (vec2(-2.0, -7.0));
	block[1].s.b[2] = (vec2(5.0, 6.0));
	block[1].s.b[3] = (vec2(-6.0, 5.0));
	block[1].s.c = (vec4(-1.0, 7.0, -4.0, 4.0));
	block[1].u = (7u);
	block[2].s.a = (uvec3(0u, 6u, 8u));
	block[2].s.b[0] = (vec2(2.0, -3.0));
	block[2].s.b[1] = (vec2(-1.0, -1.0));
	block[2].s.b[2] = (vec2(-5.0, -7.0));
	block[2].s.b[3] = (vec2(-2.0, 1.0));
	block[2].s.c = (vec4(-8.0, 0.0, 4.0, 8.0));
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

layout(std140, buffer_reference) buffer Block
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2(block[0].var, mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-3.0, 3.0));
	block[0].var[1] = (vec2(4.0, 4.0));
	block[1].var[0] = (vec2(9.0, -9.0));
	block[1].var[1] = (vec2(-5.0, 8.0));
	block[2].var[0] = (vec2(0.0, 4.0));
	block[2].var[1] = (vec2(2.0, -4.0));
}
#version 450
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
    Block block[3];
};

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

layout(std140, buffer_reference) buffer Block
{
	u8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-4.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-7.0, 2.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(0.0, -3.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block[1].var = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block[2].var = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-6.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-3.0, 2.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block[1].var = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block[2].var = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
}
#version 450
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
	highp uint var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].var), 3u) && allOk;
	allOk = compare_uint((block[1].var), 6u) && allOk;
	allOk = compare_uint((block[2].var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (7u);
	block[1].var = (9u);
	block[2].var = (1u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(scalar, buffer_reference) buffer BlockB
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
	allOk = compare_float((blockA[0].a), 9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 1.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 7.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], 4.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], 2.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(4.0, 2.0)) && allOk;
	allOk = compare_float((blockA[1].a), 5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], 8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -5.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -3.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], 1.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-3.0, 1.0)) && allOk;
	allOk = compare_float((blockA[2].a), -6.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -1.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], 5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 5.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-5.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-9, -9)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-2, -4)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-2, 9)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (6.0);
	blockA[1].a = (-9.0);
	blockA[2].a = (4.0);
	blockB[0].a[0] = (vec3(4.0, 7.0, -7.0));
	blockB[0].a[1] = (vec3(-9.0, 8.0, -3.0));
	blockB[0].a[2] = (vec3(3.0, -3.0, -8.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec3(-7.0, 3.0, 5.0));
	blockB[1].a[1] = (vec3(7.0, 3.0, 6.0));
	blockB[1].a[2] = (vec3(3.0, 5.0, 3.0));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec3(6.0, 6.0, 8.0));
	blockB[2].a[1] = (vec3(5.0, -2.0, 3.0));
	blockB[2].a[2] = (vec3(-9.0, 0.0, 8.0));
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

layout(std140, buffer_reference) buffer BlockB
{
	highp float a;
	bvec3 b;
	mediump vec3 c;
	lowp float d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 0.0) && allOk;
	allOk = compare_float((blockB.d), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.c = (vec3(2.0, -6.0, 6.0));
	blockB.d = (-6.0);
}
#version 450
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
	highp vec3 a;
	lowp float b;
	lowp uvec3 c;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	highp uvec4 d;
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec3 e;
	bool f;
	highp ivec3 g[1];
	bvec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockC.d), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_bvec3((blockD.e), bvec3(true, true, false)) && allOk;
	allOk = compare_bool((blockD.f), false) && allOk;
	allOk = compare_ivec3((blockD.g[0]), ivec3(6, 0, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (4.0);
	blockB.c = (uvec3(9u, 6u, 3u));
	blockD.e = (bvec3(false, false, true));
	blockD.f = (true);
	blockD.g[0] = (ivec3(-9, 1, 1));
}
#version 450
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
	bvec3 a;
	highp int b;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp mat3x2 c;
	highp ivec3 d;
	mediump mat4x3 e;
	bvec3 f;
	lowp ivec2 g;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 5) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(-6, -8, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (9);
	blockC.c = (mat3x2(-5.0, 2.0, 1.0, 8.0, 6.0, 2.0));
	blockC.d = (ivec3(9, 8, 5));
	blockC.f = (bvec3(false, false, false));
}
#version 450
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
	mediump vec3 mA;
	highp uvec3 mB;
	highp ivec4 mC;
	highp ivec2 mD;
};
struct sC
{
	sB mA;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump mat4x2 a;
	sA b;
	sC c;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp vec3 d;
	bool e;
	highp mat2 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.c.mA.mA), vec3(8.0, -7.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockB.c.mA.mB), uvec3(8u, 5u, 0u)) && allOk;
	allOk = compare_ivec4((blockB.c.mA.mC), ivec4(-7, -7, -1, 9)) && allOk;
	allOk = compare_ivec2((blockB.c.mA.mD), ivec2(-6, 8)) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_mat2(blockC.f, mat2(-2.0, -3.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (mat3(4.0, 6.0, 6.0, 7.0, 5.0, 2.0, -1.0, 8.0, -7.0));
	blockB.c.mA.mA = (vec3(-2.0, -4.0, -2.0));
	blockB.c.mA.mB = (uvec3(5u, 8u, 0u));
	blockB.c.mA.mC = (ivec4(0, -8, 6, -7));
	blockB.c.mA.mD = (ivec2(4, 6));
	blockC.d = (vec3(-2.0, -5.0, 3.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	mediump mat4x2 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].a[0], mat4x2(9.0, -2.0, -1.0, 7.0, -1.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[1], mat4x2(2.0, 8.0, -9.0, 1.0, 7.0, 6.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[2], mat4x2(2.0, 8.0, 1.0, 4.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[3], mat4x2(0.0, -2.0, 8.0, -4.0, 1.0, 9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[4], mat4x2(0.0, 7.0, 3.0, -1.0, -3.0, 2.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].a[0], mat4x2(-8.0, 1.0, -2.0, -3.0, 1.0, 9.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[0], mat4x2(-9.0, -4.0, -3.0, 8.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[1], mat4x2(-2.0, 9.0, 2.0, 7.0, 4.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[2], mat4x2(3.0, 2.0, 9.0, 1.0, 3.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[3], mat4x2(-7.0, 9.0, 0.0, -4.0, 8.0, 4.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[4], mat4x2(6.0, 4.0, 2.0, -8.0, -5.0, 0.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[5], mat4x2(-8.0, 8.0, -5.0, -5.0, 8.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[6], mat4x2(8.0, 6.0, -3.0, 1.0, 2.0, -6.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[7], mat4x2(-4.0, 6.0, -6.0, 3.0, -2.0, -8.0, -9.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockC.b[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.b[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.b[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.b[3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.b[4]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.b[5]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.b[6]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.b[7]), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat4x2(1.0, -6.0, -2.0, 5.0, 1.0, -6.0, -5.0, -1.0));
	blockB[0].a[1] = (mat4x2(4.0, -7.0, -3.0, -5.0, 7.0, -3.0, -4.0, 3.0));
	blockB[0].a[2] = (mat4x2(-5.0, -1.0, -5.0, -6.0, 6.0, 5.0, -1.0, 2.0));
	blockB[0].a[3] = (mat4x2(8.0, 8.0, -2.0, -7.0, -6.0, 5.0, -2.0, -2.0));
	blockB[0].a[4] = (mat4x2(6.0, 8.0, -3.0, 7.0, 9.0, -9.0, -8.0, -5.0));
	blockB[1].a[0] = (mat4x2(3.0, -8.0, -7.0, -1.0, -1.0, -1.0, 9.0, 1.0));
	blockB[2].a[0] = (mat4x2(1.0, -3.0, -5.0, 0.0, -3.0, -2.0, 8.0, 3.0));
	blockB[2].a[1] = (mat4x2(7.0, -4.0, -2.0, -4.0, -8.0, 5.0, -6.0, 8.0));
	blockB[2].a[2] = (mat4x2(6.0, 4.0, 6.0, -4.0, -6.0, 3.0, 1.0, 7.0));
	blockB[2].a[3] = (mat4x2(7.0, 9.0, 0.0, 3.0, -3.0, 4.0, -1.0, 6.0));
	blockB[2].a[4] = (mat4x2(-2.0, 5.0, -6.0, -8.0, -5.0, 0.0, 4.0, 3.0));
	blockB[2].a[5] = (mat4x2(-1.0, 9.0, -6.0, -4.0, 3.0, -3.0, -1.0, 6.0));
	blockB[2].a[6] = (mat4x2(-6.0, -4.0, 3.0, 2.0, 9.0, 5.0, 2.0, -3.0));
	blockB[2].a[7] = (mat4x2(-7.0, 3.0, 0.0, 7.0, -4.0, 4.0, -4.0, 3.0));
	blockC.b[0] = (bvec3(true, true, true));
	blockC.b[1] = (bvec3(true, true, true));
	blockC.b[2] = (bvec3(false, true, true));
	blockC.b[3] = (bvec3(true, true, true));
	blockC.b[4] = (bvec3(true, true, false));
	blockC.b[5] = (bvec3(false, false, true));
	blockC.b[6] = (bvec3(false, false, true));
	blockC.b[7] = (bvec3(true, true, false));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool b[1];
	layout(offset = 4) lowp int c[1];
	layout(offset = 16) bvec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump vec3 e;
	layout(offset = 16) lowp uvec4 f[1];
	layout(offset = 32) mediump ivec2 g;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp ivec4 h;
	layout(offset = 16) lowp uvec3 i;
	layout(offset = 28) highp int j;
	layout(offset = 32) mediump uvec3 k;
	layout(offset = 48) lowp vec3 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-9, 1)) && allOk;
	allOk = compare_bool((blockC.b[0]), true) && allOk;
	allOk = compare_int((blockC.c[0]), 6) && allOk;
	allOk = compare_bvec4((blockC.d), bvec4(true, false, false, true)) && allOk;
	allOk = compare_vec3((blockD.e), vec3(4.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(4u, 8u, 2u)) && allOk;
	allOk = compare_int((blockE.j), -8) && allOk;
	allOk = compare_uvec3((blockE.k), uvec3(0u, 4u, 5u)) && allOk;
	allOk = compare_vec3((blockE.l), vec3(0.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-4, 7));
	blockC.b[0] = (true);
	blockC.d = (bvec4(false, false, true, true));
	blockD.e = (vec3(9.0, 6.0, 8.0));
	blockD.f[0] = (uvec4(1u, 2u, 5u, 5u));
	blockD.g = (ivec2(-8, -4));
	blockE.h = (ivec4(4, -6, -2, 3));
	blockE.j = (0);
	blockE.k = (uvec3(9u, 7u, 4u));
}
#version 450
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
	layout(offset = 0) mediump uvec2 a;
	layout(offset = 8) lowp int b;
	layout(offset = 12) highp int c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump float d;
	layout(offset = 4) mediump ivec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(7u, 6u)) && allOk;
	allOk = compare_int((blockB.b), 8) && allOk;
	allOk = compare_int((blockB.c), -7) && allOk;
	allOk = compare_float((blockC.d), -2.0) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(-8, -8, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (1);
	blockC.d = (-9.0);
	blockC.e = (ivec3(-8, 5, 8));
}
#version 450
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
	lowp vec4 mA[6];
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump vec4 a;
	lowp vec3 b;
	mediump uvec3 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sA d;
	highp float e;
	highp ivec4 f;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp ivec2 g;
	lowp vec3 h;
	highp uvec2 i;
	lowp mat3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-8.0, 4.0, -4.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockB.c[0]), uvec3(5u, 5u, 9u)) && allOk;
	allOk = compare_vec4((blockC[0].d.mA[0]), vec4(2.0, -5.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC[0].d.mA[1]), vec4(4.0, 1.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC[0].d.mA[2]), vec4(6.0, 8.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC[0].d.mA[3]), vec4(3.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC[0].d.mA[4]), vec4(1.0, 3.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].d.mA[5]), vec4(-6.0, -1.0, 6.0, 2.0)) && allOk;
	allOk = compare_float((blockC[0].e), 3.0) && allOk;
	allOk = compare_ivec4((blockC[0].f), ivec4(3, -3, 5, 7)) && allOk;
	allOk = compare_vec3((blockD.h), vec3(0.0, -8.0, -3.0)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat3(blockD.j[0], mat3(6.0, -5.0, 8.0, -8.0, -5.0, 9.0, 5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD.j[1], mat3(-6.0, 0.0, -7.0, -7.0, 5.0, -3.0, -9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD.j[2], mat3(0.0, 3.0, -1.0, -5.0, -5.0, 2.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD.j[3], mat3(2.0, 9.0, 3.0, 6.0, -1.0, 2.0, 9.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(blockD.j[4], mat3(7.0, 4.0, 0.0, -2.0, 0.0, -5.0, 5.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-9.0, -9.0, 8.0, -8.0));
	blockB.c[0] = (uvec3(7u, 1u, 9u));
	blockC[0].d.mA[0] = (vec4(4.0, 3.0, 3.0, 0.0));
	blockC[0].d.mA[1] = (vec4(7.0, -1.0, -7.0, -8.0));
	blockC[0].d.mA[2] = (vec4(6.0, -8.0, -5.0, -9.0));
	blockC[0].d.mA[3] = (vec4(-1.0, -5.0, -2.0, -8.0));
	blockC[0].d.mA[4] = (vec4(8.0, -2.0, 4.0, -6.0));
	blockC[0].d.mA[5] = (vec4(-7.0, 7.0, 7.0, 9.0));
	blockC[0].e = (-5.0);
	blockC[0].f = (ivec4(-7, 6, -1, 5));
	blockD.h = (vec3(7.0, 8.0, -9.0));
	blockD.i = (uvec2(4u, 1u));
	blockD.j[0] = (mat3(3.0, 5.0, -4.0, -7.0, 2.0, 8.0, -2.0, -4.0, -2.0));
	blockD.j[1] = (mat3(-4.0, -5.0, 3.0, -2.0, -3.0, -9.0, -5.0, -7.0, -9.0));
	blockD.j[2] = (mat3(-7.0, 4.0, -7.0, -9.0, 8.0, 4.0, -5.0, -5.0, 2.0));
	blockD.j[3] = (mat3(3.0, -6.0, 7.0, -1.0, 8.0, 3.0, 2.0, -4.0, -1.0));
	blockD.j[4] = (mat3(-9.0, 4.0, -9.0, -3.0, -6.0, 6.0, -7.0, 1.0, 3.0));
}
#version 450
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
	float16_t a;
	bool b;
	mediump uint c;
	lowp float d[1];
	bool e;
};
layout(std140, buffer_reference) buffer BlockC
{
	bool f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 2.0) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d[0] = (2.0);
	blockB.e = (true);
	blockC.f = (true);
}
#version 450
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
	int16_t a;
	mediump vec4 b;
	mediump int c;
};
layout(std140, buffer_reference) buffer BlockC
{
	f16vec3 d[1];
	f16vec3 e;
	mediump vec4 f[1];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec2 g;
	f16vec4 h;
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
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), -8) && allOk;
	allOk = compare_int((blockB.c), -4) && allOk;
	allOk = compare_f16vec3(vec3(blockC.d[0]), vec3(-6.0, -2.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.e), vec3(4.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.f[0]), vec4(-9.0, -7.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-8, 6)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.h), vec4(0.0, -1.0, -3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec4(0.0, 9.0, 4.0, 1.0));
	blockB.c = (-7);
	blockC.d[0] = f16vec3(vec3(-4.0, -4.0, -6.0));
	blockC.f[0] = (vec4(-2.0, 5.0, -9.0, -3.0));
	blockD.g = (ivec2(-1, -9));
	blockD.h = f16vec4(vec4(1.0, 1.0, 7.0, 8.0));
}
#version 450
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
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump ivec4 b;
	highp vec4 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec3 d;
	mediump vec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(5u, 5u, 0u, 5u)) && allOk;
	allOk = compare_ivec4((blockC.b), ivec4(0, 3, 7, -1)) && allOk;
	allOk = compare_bvec3((blockD.d), bvec3(false, false, false)) && allOk;
	allOk = compare_vec2((blockD.e[0]), vec2(-2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(5u, 5u, 6u, 2u));
	blockC.b = (ivec4(9, 2, -6, 6));
	blockC.c[0] = (vec4(-6.0, 3.0, 5.0, -8.0));
	blockD.d = (bvec3(false, true, false));
	blockD.e[0] = (vec2(-9.0, 9.0));
}
#version 450
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
	lowp mat4x3 a;
	mediump ivec4 b;
	mediump vec3 c;
	lowp mat3 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	f16vec4 e[2];
	mediump mat4x3 f;
	uint16_t g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	f16vec4 h;
	highp mat4x3 i;
	bool j;
	bvec4 k;
	u16vec3 l[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	highp uvec4 m;
	lowp ivec4 n;
	highp ivec3 o;
	mediump vec4 p;
	mediump vec2 q;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(1, 8, 1, -2)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.d[0], mat3(-8.0, -7.0, 7.0, 0.0, 9.0, -6.0, 5.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.e[0]), vec4(-1.0, -6.0, 5.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.e[1]), vec4(3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[2]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[3]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[4]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[5]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[6]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockC.g[7]), 5u) && allOk;
	allOk = compare_mat4x3(blockD.i, mat4x3(6.0, -5.0, 5.0, 1.0, -7.0, 9.0, -2.0, 4.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[0]), uvec3(2u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[1]), uvec3(5u, 8u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[2]), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[3]), uvec3(0u, 7u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[4]), uvec3(3u, 9u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[5]), uvec3(0u, 3u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[6]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[7]), uvec3(6u, 6u, 6u)) && allOk;
	allOk = compare_ivec4((blockE.n), ivec4(7, 2, -3, -8)) && allOk;
	allOk = compare_vec2((blockE.q), vec2(-8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(1.0, 1.0, -4.0, 1.0, 8.0, -4.0, 1.0, -9.0, 3.0, 0.0, -9.0, -6.0));
	blockB.b = (ivec4(3, 4, -1, -4));
	blockC.f = (mat4x3(3.0, 9.0, 8.0, 1.0, 7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0, -2.0));
	blockD.h = f16vec4(vec4(-8.0, -8.0, 9.0, -4.0));
	blockD.i = (mat4x3(9.0, 3.0, -3.0, -7.0, 6.0, 9.0, 5.0, -8.0, -5.0, 9.0, 2.0, -1.0));
	blockD.k = (bvec4(false, false, true, false));
	blockD.l[0] = u16vec3(uvec3(3u, 1u, 7u));
	blockD.l[1] = u16vec3(uvec3(5u, 5u, 1u));
	blockD.l[2] = u16vec3(uvec3(1u, 1u, 7u));
	blockD.l[3] = u16vec3(uvec3(7u, 5u, 2u));
	blockD.l[4] = u16vec3(uvec3(5u, 2u, 5u));
	blockD.l[5] = u16vec3(uvec3(4u, 9u, 8u));
	blockD.l[6] = u16vec3(uvec3(6u, 4u, 3u));
	blockD.l[7] = u16vec3(uvec3(6u, 5u, 9u));
	blockE.n = (ivec4(-2, -3, -2, -5));
	blockE.o = (ivec3(2, -5, -9));
	blockE.p = (vec4(-8.0, -1.0, 1.0, 8.0));
}
#version 450
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
	f16vec3 a[1];
	bvec3 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bool c;
	lowp ivec4 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp float e;
	float16_t f;
	highp float g[1];
	highp vec4 h;
	u16vec2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].b[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB[1].b[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_ivec4((blockC.d[0]), ivec4(0, 1, 6, -5)) && allOk;
	allOk = compare_float((blockD[0].e), 2.0) && allOk;
	allOk = compare_float16_t(float(blockD[0].f), 7.0) && allOk;
	allOk = compare_float((blockD[0].g[0]), -5.0) && allOk;
	allOk = compare_vec4((blockD[0].h), vec4(4.0, -7.0, 0.0, -9.0)) && allOk;
	allOk = compare_float((blockD[1].e), 0.0) && allOk;
	allOk = compare_float16_t(float(blockD[1].f), -6.0) && allOk;
	allOk = compare_float((blockD[1].g[0]), -3.0) && allOk;
	allOk = compare_vec4((blockD[1].h), vec4(1.0, 8.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = f16vec3(vec3(-6.0, -2.0, 3.0));
	blockB[0].b[0] = (bvec3(true, true, true));
	blockB[1].a[0] = f16vec3(vec3(9.0, 5.0, -4.0));
	blockB[1].b[0] = (bvec3(true, true, false));
	blockC.c = (true);
	blockD[0].e = (9.0);
	blockD[0].f = float16_t(-8.0);
	blockD[0].h = (vec4(3.0, -1.0, 4.0, 1.0));
	blockD[1].e = (-1.0);
	blockD[1].f = float16_t(-5.0);
	blockD[1].h = (vec4(-5.0, -3.0, -8.0, 6.0));
}
#version 450
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
	float16_t a;
	bool b;
	lowp vec3 c;
	bvec3 d[][5];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bool e;
	bool f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat4 g;
	lowp ivec3 h[5];
	highp mat3 i;
	lowp vec3 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump vec3 k;
	highp mat3x2 l[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -4.0) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_bvec3((blockB.d[0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[0][1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB.d[0][2]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.d[0][3]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[0][4]), bvec3(false, true, false)) && allOk;
	allOk = compare_bool((blockC.e), true) && allOk;
	allOk = compare_mat4(blockD.g, mat4(1.0, 8.0, -3.0, 7.0, -6.0, -9.0, -5.0, 6.0, -8.0, -8.0, 3.0, 3.0, 8.0, 4.0, -1.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockD.h[0]), ivec3(-6, 8, -6)) && allOk;
	allOk = compare_ivec3((blockD.h[1]), ivec3(2, -4, 9)) && allOk;
	allOk = compare_ivec3((blockD.h[2]), ivec3(9, 5, -2)) && allOk;
	allOk = compare_ivec3((blockD.h[3]), ivec3(4, 0, -7)) && allOk;
	allOk = compare_ivec3((blockD.h[4]), ivec3(-8, 2, 4)) && allOk;
	allOk = compare_mat3(blockD.i, mat3(7.0, -9.0, -3.0, 0.0, 4.0, -7.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockE.k), vec3(0.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (vec3(-9.0, -8.0, 0.0));
	blockB.d[0][0] = (bvec3(false, true, true));
	blockB.d[0][1] = (bvec3(true, true, true));
	blockB.d[0][2] = (bvec3(true, false, false));
	blockB.d[0][3] = (bvec3(true, false, false));
	blockB.d[0][4] = (bvec3(true, true, false));
	blockC.e = (false);
	blockC.f[0] = (true);
	blockC.f[1] = (true);
	blockC.f[2] = (false);
	blockC.f[3] = (false);
	blockC.f[4] = (false);
	blockC.f[5] = (false);
	blockD.g = (mat4(-9.0, 9.0, -2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0, 7.0, -1.0, -2.0, 2.0, -2.0, 1.0));
	blockD.h[0] = (ivec3(0, 2, -9));
	blockD.h[1] = (ivec3(0, 7, -3));
	blockD.h[2] = (ivec3(-5, 8, 2));
	blockD.h[3] = (ivec3(2, -2, -1));
	blockD.h[4] = (ivec3(4, -3, -1));
	blockD.i = (mat3(-2.0, 2.0, -3.0, -1.0, -6.0, -4.0, 3.0, -8.0, 6.0));
	blockD.j[0] = (vec3(7.0, -3.0, -2.0));
	blockD.j[1] = (vec3(-3.0, 0.0, 7.0));
	blockD.j[2] = (vec3(3.0, -1.0, -9.0));
	blockD.j[3] = (vec3(0.0, 3.0, -4.0));
	blockD.j[4] = (vec3(-5.0, 0.0, 2.0));
	blockD.j[5] = (vec3(-2.0, -7.0, -2.0));
	blockD.j[6] = (vec3(-2.0, -8.0, 1.0));
	blockE.k = (vec3(1.0, -6.0, -1.0));
}
#version 450
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
	lowp mat3 a;
	lowp float b;
	mediump uvec2 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp uvec2 d;
	mediump int e;
	highp ivec4 f;
	lowp uvec4 g;
	bool h;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp ivec3 i;
	mediump mat3x2 j[2];
	bool k;
	lowp int l;
	u16vec3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-6.0, -9.0, -5.0, -5.0, -7.0, 0.0, 3.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((blockB.b), -1.0) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(9u, 6u)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(-5, 6, 7, -4)) && allOk;
	allOk = compare_ivec3((blockD.i), ivec3(1, -1, 8)) && allOk;
	allOk = compare_mat3x2(blockD.j[0], mat3x2(0.0, -7.0, 7.0, 9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1], mat3x2(5.0, 5.0, 9.0, 5.0, -9.0, 3.0)) && allOk;
	allOk = compare_int((blockD.l), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(0.0, -7.0, -5.0, 9.0, -6.0, 2.0, 5.0, 9.0, -5.0));
	blockC.d = (uvec2(1u, 4u));
	blockC.e = (1);
	blockC.g = (uvec4(4u, 2u, 9u, 9u));
	blockD.j[0] = (mat3x2(8.0, -4.0, -7.0, 8.0, -6.0, -8.0));
	blockD.j[1] = (mat3x2(-2.0, -3.0, 0.0, 4.0, 9.0, -6.0));
	blockD.k = (false);
	blockD.l = (-4);
	blockD.m = u16vec3(uvec3(0u, 7u, 8u));
}
#version 450
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
	layout(offset = 4) highp ivec3 b;
	layout(offset = 16) u16vec4 c;
	layout(offset = 24) mediump vec2 d;
	layout(offset = 32) bvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[0].b), ivec3(4, -8, -2)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[0].c), uvec4(1u, 1u, 7u, 3u)) && allOk;
	allOk = compare_vec2((blockB[0].d), vec2(7.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockB[0].e), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockB[1].b), ivec3(-9, -1, -6)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[1].c), uvec4(1u, 9u, 8u, 6u)) && allOk;
	allOk = compare_vec2((blockB[1].d), vec2(0.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB[1].e), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].c = u16vec4(uvec4(4u, 2u, 9u, 7u));
	blockB[0].d = (vec2(-6.0, 1.0));
	blockB[0].e = (bvec3(false, true, false));
	blockB[1].a = (true);
	blockB[1].c = u16vec4(uvec4(6u, 0u, 6u, 4u));
	blockB[1].d = (vec2(0.0, -2.0));
	blockB[1].e = (bvec3(true, false, true));
}
#version 450
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
	i16vec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].b), ivec2(0, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].b), ivec2(0, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].b), ivec2(9, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(3)].b), ivec2(0, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int16_t(5);
	blockB[nonuniformEXT(1)].a = int16_t(9);
	blockB[nonuniformEXT(2)].a = int16_t(-5);
	blockB[nonuniformEXT(3)].a = int16_t(5);
}
#version 450
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
	uint8_t a;
	highp float b;
	int8_t c;
	mediump uint d;
};
layout(std430, buffer_reference) buffer BlockC
{
	bool e;
};
layout(std430, buffer_reference) buffer BlockD
{
	int8_t f;
	bool g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 5u) && allOk;
	allOk = compare_float((blockB.b), -3.0) && allOk;
	allOk = compare_int8_t(int(blockB.c), 9) && allOk;
	allOk = compare_uint((blockB.d), 7u) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_int8_t(int(blockD.f), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-2.0);
	blockB.d = (7u);
	blockC.e = (true);
	blockD.g = (true);
}
#version 450
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
	i8vec2 a;
	i8vec2 b;
	highp ivec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(1, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(5, 7));
	blockB.b = i8vec2(ivec2(4294967287, 4294967290));
	blockB.c = (ivec3(1, -2, -1));
}
#version 450
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
	highp mat4x3 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat3 b[][2];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	bvec2 c[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	bvec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0], mat4x3(4.0, 1.0, 2.0, -1.0, 9.0, -9.0, 1.0, -6.0, 6.0, 6.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1], mat4x3(-9.0, 7.0, -2.0, -6.0, -7.0, -7.0, -5.0, -1.0, 4.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2], mat4x3(-4.0, 9.0, -5.0, -1.0, -7.0, -9.0, 8.0, 9.0, 7.0, 3.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3], mat4x3(-6.0, -5.0, -1.0, -5.0, 8.0, -3.0, -3.0, -3.0, -6.0, -4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4], mat4x3(6.0, 3.0, 8.0, -7.0, 3.0, 7.0, 2.0, 1.0, -7.0, -2.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[5], mat4x3(-6.0, 4.0, 0.0, -6.0, 7.0, 2.0, 8.0, 4.0, -7.0, 5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[6], mat4x3(9.0, -5.0, -2.0, -6.0, 6.0, 7.0, -9.0, -1.0, -6.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC.b[0][0], mat3(3.0, 2.0, 9.0, -4.0, 1.0, 0.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.b[0][1], mat3(-8.0, 6.0, 9.0, -1.0, 0.0, -6.0, -1.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.b[1][0], mat3(2.0, -7.0, 5.0, -7.0, -7.0, -1.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.b[1][1], mat3(-8.0, 6.0, -8.0, -6.0, -5.0, 8.0, 6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.b[2][0], mat3(7.0, -7.0, -9.0, 6.0, -1.0, -6.0, -9.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.b[2][1], mat3(-9.0, 9.0, 0.0, -8.0, 6.0, -6.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.b[3][0], mat3(0.0, 5.0, -6.0, -9.0, -6.0, -7.0, -2.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.b[3][1], mat3(3.0, -9.0, -7.0, -1.0, 6.0, 9.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.b[4][0], mat3(6.0, -7.0, -3.0, -9.0, -1.0, -2.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.b[4][1], mat3(-6.0, -2.0, -4.0, 5.0, 9.0, -7.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.b[5][0], mat3(-6.0, -8.0, -8.0, -3.0, 5.0, -6.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(blockC.b[5][1], mat3(-8.0, 2.0, -8.0, -6.0, -8.0, 1.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockD.c[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.c[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.c[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.c[3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.c[4]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x3(5.0, 1.0, -9.0, 7.0, -2.0, -9.0, -9.0, -1.0, -2.0, -6.0, -3.0, -4.0));
	blockB.a[1] = (mat4x3(-4.0, 1.0, 9.0, 3.0, 2.0, 2.0, 4.0, -6.0, -1.0, 9.0, 5.0, -7.0));
	blockB.a[2] = (mat4x3(3.0, 5.0, 2.0, -7.0, 5.0, -2.0, -5.0, 7.0, 9.0, 7.0, -3.0, 5.0));
	blockB.a[3] = (mat4x3(7.0, 8.0, -9.0, -5.0, -3.0, -2.0, 9.0, 7.0, 9.0, -3.0, -4.0, 7.0));
	blockB.a[4] = (mat4x3(8.0, 9.0, -4.0, -1.0, -2.0, 0.0, 5.0, -5.0, 8.0, -4.0, -8.0, 2.0));
	blockB.a[5] = (mat4x3(6.0, -2.0, 0.0, 3.0, -9.0, 2.0, -7.0, 9.0, 3.0, -9.0, 7.0, -4.0));
	blockB.a[6] = (mat4x3(-9.0, -3.0, 9.0, -5.0, 3.0, -8.0, 4.0, 6.0, 4.0, -2.0, -6.0, 4.0));
	blockC.b[0][0] = (mat3(7.0, -6.0, 7.0, -9.0, -2.0, 3.0, -8.0, -8.0, 9.0));
	blockC.b[0][1] = (mat3(5.0, 1.0, -5.0, 8.0, -4.0, 5.0, 0.0, 6.0, 3.0));
	blockC.b[1][0] = (mat3(8.0, -7.0, 2.0, 8.0, -4.0, 1.0, -7.0, 6.0, -2.0));
	blockC.b[1][1] = (mat3(-4.0, 7.0, -9.0, 1.0, -9.0, -7.0, -7.0, -7.0, -1.0));
	blockC.b[2][0] = (mat3(-5.0, -5.0, -9.0, 4.0, -7.0, 3.0, -6.0, -6.0, 3.0));
	blockC.b[2][1] = (mat3(-5.0, -3.0, 2.0, 7.0, 5.0, 3.0, 4.0, -1.0, -3.0));
	blockC.b[3][0] = (mat3(-7.0, -6.0, 6.0, 6.0, 2.0, -7.0, 7.0, 8.0, 8.0));
	blockC.b[3][1] = (mat3(-5.0, 9.0, 3.0, -7.0, 1.0, -7.0, 8.0, -9.0, -9.0));
	blockC.b[4][0] = (mat3(3.0, -9.0, -7.0, 6.0, 9.0, -8.0, 9.0, -7.0, 1.0));
	blockC.b[4][1] = (mat3(-5.0, 5.0, 5.0, 2.0, 5.0, -6.0, 3.0, 2.0, -7.0));
	blockC.b[5][0] = (mat3(-9.0, 2.0, 4.0, 9.0, 1.0, 0.0, 6.0, 9.0, -1.0));
	blockC.b[5][1] = (mat3(7.0, 2.0, 8.0, -2.0, -8.0, -4.0, -4.0, -3.0, 5.0));
}
#version 450
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
	mediump mat2x3 mA;
	u8vec4 mB;
	lowp ivec2 mC;
	u8vec4 mD;
};
struct sB
{
	bvec4 mA;
	lowp mat4 mB;
	uint8_t mC;
};
struct sC
{
	bvec3 mA;
	uint8_t mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp mat3x2 a;
	highp mat4 b;
	sA c;
	bvec3 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sB e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	i8vec2 f;
	int8_t g;
	u8vec3 h;
	sC i;
	lowp mat4x2 j[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockE
{
	bool k;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-4.0, -7.0, 6.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(-4.0, -2.0, -3.0, -5.0, -9.0, -6.0, 2.0, -7.0, 8.0, 4.0, -9.0, 3.0, 6.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.c.mA, mat2x3(2.0, 0.0, 0.0, -9.0, -5.0, 1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.c.mB), uvec4(7u, 1u, 5u, 3u)) && allOk;
	allOk = compare_ivec2((blockB.c.mC), ivec2(5, -7)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.c.mD), uvec4(6u, 1u, 8u, 8u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.f), ivec2(4294967289, 4294967288)) && allOk;
	allOk = compare_bvec3((blockD.i.mA), bvec3(true, true, true)) && allOk;
	allOk = compare_uint8_t(uint(blockD.i.mB), 1u) && allOk;
	allOk = compare_mat4x2(blockD.j[0], mat4x2(-7.0, 1.0, -5.0, 6.0, -8.0, -5.0, 5.0, -2.0)) && allOk;
	allOk = compare_bool((blockE.k), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c.mA = (mat2x3(4.0, 5.0, 9.0, -6.0, -4.0, 1.0));
	blockB.c.mB = u8vec4(uvec4(2u, 5u, 3u, 0u));
	blockB.c.mC = (ivec2(4, -9));
	blockB.c.mD = u8vec4(uvec4(4u, 3u, 0u, 3u));
	blockB.d[0] = (bvec3(false, true, true));
	blockC.e[0].mA = (bvec4(true, true, true, true));
	blockC.e[0].mB = (mat4(-2.0, 2.0, -2.0, 1.0, 0.0, 2.0, -9.0, 0.0, 7.0, -3.0, -5.0, 8.0, 2.0, 2.0, -2.0, -1.0));
	blockC.e[0].mC = uint8_t(1u);
	blockD.f = i8vec2(ivec2(4294967293, 4294967295));
	blockD.g = int8_t(4294967294);
	blockD.i.mA = (bvec3(false, false, true));
	blockD.i.mB = uint8_t(1u);
	blockD.j[0] = (mat4x2(7.0, -3.0, -2.0, -3.0, 0.0, 7.0, 3.0, -1.0));
}
#version 450
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
	highp ivec3 mA;
	highp mat4x2 mB;
};
struct sB
{
	sA mA;
	highp mat2 mB;
	highp mat3x2 mC;
	mediump uvec2 mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp uvec2 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 b;
	highp uvec3 c;
	sB d;
	mediump uint e;
	highp ivec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(4u, 0u, 4u)) && allOk;
	allOk = compare_uint((blockC.e), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec2(4u, 0u));
	blockC.c = (uvec3(5u, 2u, 5u));
	blockC.f[0] = (ivec2(0, -6));
}
#version 450
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
struct sB
{
	u8vec3 mA;
	lowp ivec3 mB;
};
struct sC
{
	i8vec4 mA;
};
layout(std140, buffer_reference) readonly buffer BlockB
{
	bvec4 a[7];
	sA b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sB c[];
};
layout(std140, buffer_reference) buffer BlockD
{
	u8vec2 d;
	highp ivec3 e;
	sC f;
	i8vec3 g[][6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.a[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.a[4]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.a[5]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[6]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[0].mA), uvec3(5u, 2u, 9u)) && allOk;
	allOk = compare_ivec3((blockC.c[0].mB), ivec3(-4, -7, 2)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[1].mA), uvec3(7u, 6u, 2u)) && allOk;
	allOk = compare_ivec3((blockC.c[1].mB), ivec3(-6, -1, 5)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[2].mA), uvec3(5u, 0u, 3u)) && allOk;
	allOk = compare_ivec3((blockC.c[2].mB), ivec3(8, -9, -6)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[3].mA), uvec3(6u, 9u, 1u)) && allOk;
	allOk = compare_ivec3((blockC.c[3].mB), ivec3(2, -8, -9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[4].mA), uvec3(2u, 3u, 4u)) && allOk;
	allOk = compare_ivec3((blockC.c[4].mB), ivec3(4, -8, -1)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[5].mA), uvec3(3u, 3u, 7u)) && allOk;
	allOk = compare_ivec3((blockC.c[5].mB), ivec3(4, -9, -7)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[6].mA), uvec3(7u, 5u, 9u)) && allOk;
	allOk = compare_ivec3((blockC.c[6].mB), ivec3(4, 3, 6)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.d), uvec2(0u, 0u)) && allOk;
	allOk = compare_ivec3((blockD.e), ivec3(7, 6, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0].mA = u8vec3(uvec3(9u, 2u, 4u));
	blockC.c[0].mB = (ivec3(7, 6, -5));
	blockC.c[1].mA = u8vec3(uvec3(1u, 0u, 3u));
	blockC.c[1].mB = (ivec3(7, 6, -6));
	blockC.c[2].mA = u8vec3(uvec3(2u, 5u, 0u));
	blockC.c[2].mB = (ivec3(0, 7, -7));
	blockC.c[3].mA = u8vec3(uvec3(3u, 9u, 0u));
	blockC.c[3].mB = (ivec3(4, -4, -8));
	blockC.c[4].mA = u8vec3(uvec3(7u, 9u, 0u));
	blockC.c[4].mB = (ivec3(1, -6, 7));
	blockC.c[5].mA = u8vec3(uvec3(6u, 5u, 3u));
	blockC.c[5].mB = (ivec3(-7, 7, -2));
	blockC.c[6].mA = u8vec3(uvec3(5u, 8u, 1u));
	blockC.c[6].mB = (ivec3(2, 2, 4));
	blockD.d = u8vec2(uvec2(0u, 5u));
	blockD.f.mA = i8vec4(ivec4(7, 8, 4294967292, 4294967291));
}
#version 450
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
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp vec3 a;
	lowp ivec4 b;
	sA c;
	u8vec2 d;
	lowp mat3x4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	u8vec4 f;
	uint8_t g[6];
	highp int h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-1.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(7, 5, -8, 2)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d), uvec2(1u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockC.g[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC.g[1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockC.g[2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC.g[3]), 3u) && allOk;
	allOk = compare_uint8_t(uint(blockC.g[4]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC.g[5]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(9, -1, 3, -7));
	blockB.c.mA[0][0] = (mat4(-7.0, 6.0, 0.0, 6.0, -9.0, -2.0, -5.0, -3.0, -5.0, -1.0, 9.0, 3.0, -2.0, -6.0, -4.0, -4.0));
	blockB.c.mA[1][0] = (mat4(8.0, -4.0, -8.0, 9.0, 2.0, -7.0, -3.0, 6.0, 3.0, 2.0, 3.0, 6.0, 8.0, 5.0, -5.0, -8.0));
	blockB.c.mA[2][0] = (mat4(-3.0, -8.0, 6.0, -1.0, -5.0, -7.0, 0.0, 5.0, -9.0, -3.0, -1.0, 0.0, -3.0, 0.0, -4.0, -8.0));
	blockB.c.mB = (ivec4(-2, 2, -6, 3));
	blockB.c.mC[0] = (vec2(-6.0, 8.0));
	blockB.c.mC[1] = (vec2(-7.0, 4.0));
	blockB.c.mD[0] = (vec2(-3.0, 2.0));
	blockB.c.mD[1] = (vec2(0.0, 0.0));
	blockB.c.mD[2] = (vec2(-3.0, 0.0));
	blockB.e[0] = (mat3x4(6.0, -9.0, -1.0, 0.0, -6.0, -7.0, -4.0, 3.0, -4.0, -4.0, 5.0, -6.0));
	blockB.e[1] = (mat3x4(0.0, 0.0, 9.0, -2.0, -3.0, 1.0, -9.0, -6.0, -8.0, 9.0, -4.0, 0.0));
	blockB.e[2] = (mat3x4(6.0, 4.0, 7.0, -5.0, 9.0, 1.0, 5.0, -2.0, -4.0, 9.0, 7.0, 3.0));
	blockB.e[3] = (mat3x4(8.0, 7.0, 7.0, 3.0, 9.0, 8.0, 7.0, 0.0, 6.0, 5.0, -7.0, 6.0));
	blockB.e[4] = (mat3x4(1.0, -5.0, -8.0, 6.0, -5.0, -1.0, -2.0, 0.0, 5.0, 2.0, -9.0, 5.0));
	blockC.f = u8vec4(uvec4(5u, 9u, 0u, 8u));
	blockC.g[0] = uint8_t(8u);
	blockC.g[1] = uint8_t(6u);
	blockC.g[2] = uint8_t(5u);
	blockC.g[3] = uint8_t(9u);
	blockC.g[4] = uint8_t(3u);
	blockC.g[5] = uint8_t(7u);
	blockC.h[0] = (1);
	blockC.h[1] = (-2);
	blockC.h[2] = (9);
	blockC.h[3] = (-4);
	blockC.h[4] = (-7);
	blockC.h[5] = (-7);
	blockC.h[6] = (-1);
	blockC.h[7] = (4);
}
#version 450
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
	highp mat3x4 a;
	lowp int b[2];
	lowp mat3x2 c;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	highp vec4 d[][4];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), -7) && allOk;
	allOk = compare_int((blockB.b[1]), -5) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(-2.0, -5.0, 1.0, 0.0, 3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(7.0, -6.0, 8.0, 6.0, -3.0, 9.0, 8.0, 1.0, -6.0, 0.0, -8.0, 3.0));
	blockB.b[0] = (-3);
	blockB.b[1] = (9);
}
#version 450
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
	i8vec3 mA;
	u8vec4 mB;
};
struct sB
{
	i8vec3 mA;
};
struct sC
{
	sA mA;
	lowp mat4x2 mB;
	bvec2 mC;
	sB mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp float a;
	lowp vec2 b;
	mediump int c;
	mediump vec2 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	sC e;
	highp mat3 f;
	u8vec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 6.0) && allOk;
	allOk = compare_vec2((blockB.b), vec2(8.0, 8.0)) && allOk;
	allOk = compare_int((blockB.c), 0) && allOk;
	allOk = compare_vec2((blockB.d[0]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.d[1]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.d[2]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.d[3]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.e.mA.mA), ivec3(1, 6, 5)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.e.mA.mB), uvec4(2u, 3u, 1u, 5u)) && allOk;
	allOk = compare_mat4x2(blockC.e.mB, mat4x2(8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockC.e.mC), bvec2(false, true)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.e.mD.mA), ivec3(7, 4294967292, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec2(-3.0, -2.0));
	blockB.c = (0);
	blockB.d[0] = (vec2(-6.0, 6.0));
	blockB.d[1] = (vec2(-6.0, 3.0));
	blockB.d[2] = (vec2(-7.0, 8.0));
	blockB.d[3] = (vec2(5.0, -6.0));
	blockC.f = (mat3(3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0, -4.0, 8.0));
	blockC.g[0] = u8vec3(uvec3(2u, 2u, 0u));
	blockC.g[1] = u8vec3(uvec3(5u, 5u, 0u));
	blockC.g[2] = u8vec3(uvec3(2u, 5u, 5u));
	blockC.g[3] = u8vec3(uvec3(8u, 7u, 8u));
	blockC.g[4] = u8vec3(uvec3(8u, 8u, 8u));
	blockC.g[5] = u8vec3(uvec3(2u, 7u, 2u));
	blockC.g[6] = u8vec3(uvec3(6u, 6u, 4u));
}
#version 450
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
	highp ivec3 a;
	u8vec4 b;
	u8vec3 c;
	u8vec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

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

layout(scalar, buffer_reference) buffer BlockB
{
	i8vec3 a;
	mediump ivec4 b;
	bvec2 c;
	i8vec2 d;
	mediump float e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp uvec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].b), ivec4(2, 4, 0, -2)) && allOk;
	allOk = compare_bvec2((blockB[0].c), bvec2(true, false)) && allOk;
	allOk = compare_float((blockB[0].e[0]), -2.0) && allOk;
	allOk = compare_ivec4((blockB[1].b), ivec4(-9, 0, -9, 7)) && allOk;
	allOk = compare_bvec2((blockB[1].c), bvec2(false, false)) && allOk;
	allOk = compare_float((blockB[1].e[0]), 4.0) && allOk;
	allOk = compare_float((blockB[1].e[1]), -7.0) && allOk;
	allOk = compare_float((blockB[1].e[2]), -2.0) && allOk;
	allOk = compare_float((blockB[1].e[3]), 9.0) && allOk;
	allOk = compare_float((blockB[1].e[4]), 8.0) && allOk;
	allOk = compare_float((blockB[1].e[5]), 9.0) && allOk;
	allOk = compare_float((blockB[1].e[6]), 0.0) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(7u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c = (bvec2(false, false));
	blockB[0].d = i8vec2(ivec2(8, 4294967293));
	blockB[0].e[0] = (3.0);
	blockB[1].c = (bvec2(false, false));
	blockB[1].d = i8vec2(ivec2(4294967293, 4294967287));
	blockB[1].e[0] = (-5.0);
	blockB[1].e[1] = (3.0);
	blockB[1].e[2] = (5.0);
	blockB[1].e[3] = (-5.0);
	blockB[1].e[4] = (-2.0);
	blockB[1].e[5] = (-2.0);
	blockB[1].e[6] = (8.0);
	blockC.f = (uvec3(1u, 3u, 2u));
}
#version 450
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
	lowp uvec4 a;
	lowp uvec2 b;
	bvec2 c;
	u8vec2 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp ivec4 e;
	uint8_t f;
	lowp mat3x4 g;
	lowp mat2x3 h;
	bvec4 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].c), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB[1].c), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[2].c), bvec2(true, true)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(-5, 9, -1, -5)) && allOk;
	allOk = compare_uint8_t(uint(blockC.f), 9u) && allOk;
	allOk = compare_mat2x3(blockC.h, mat2x3(9.0, -4.0, -9.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockC.i[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.i[1]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.i[2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.i[3]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.i[4]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.i[5]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.i[6]), bvec4(true, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec4(1u, 0u, 1u, 3u));
	blockB[0].c = (bvec2(false, false));
	blockB[0].d[0] = u8vec2(uvec2(4u, 3u));
	blockB[0].d[1] = u8vec2(uvec2(2u, 8u));
	blockB[0].d[2] = u8vec2(uvec2(0u, 6u));
	blockB[0].d[3] = u8vec2(uvec2(9u, 2u));
	blockB[0].d[4] = u8vec2(uvec2(1u, 4u));
	blockB[1].a = (uvec4(5u, 5u, 1u, 4u));
	blockB[1].c = (bvec2(false, false));
	blockB[1].d[0] = u8vec2(uvec2(5u, 6u));
	blockB[1].d[1] = u8vec2(uvec2(2u, 4u));
	blockB[2].a = (uvec4(7u, 4u, 8u, 7u));
	blockB[2].c = (bvec2(false, true));
	blockB[2].d[0] = u8vec2(uvec2(9u, 8u));
	blockB[2].d[1] = u8vec2(uvec2(0u, 7u));
	blockB[2].d[2] = u8vec2(uvec2(7u, 6u));
	blockB[2].d[3] = u8vec2(uvec2(7u, 2u));
	blockB[2].d[4] = u8vec2(uvec2(0u, 6u));
	blockB[2].d[5] = u8vec2(uvec2(1u, 1u));
	blockB[2].d[6] = u8vec2(uvec2(5u, 8u));
	blockC.e = (ivec4(7, 6, -5, -3));
	blockC.f = uint8_t(6u);
	blockC.g = (mat3x4(5.0, 6.0, -1.0, -4.0, -3.0, -2.0, -8.0, 7.0, 9.0, -2.0, -5.0, 7.0));
}
#version 450
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
	lowp mat3 a;
	bvec4 b;
	mediump mat4x3 c;
	bvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].a, mat3(7.0, -4.0, 4.0, 3.0, 7.0, -3.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].b), bvec4(true, false, true, true)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].a, mat3(-7.0, 3.0, 8.0, -5.0, 3.0, -4.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].b), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].a, mat3(0.0, 0.0, 8.0, 7.0, 4.0, -2.0, -2.0, -1.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].b), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (bvec4(false, false, false, true));
	blockB[nonuniformEXT(1)].b = (bvec4(false, false, false, false));
	blockB[nonuniformEXT(2)].b = (bvec4(true, true, true, false));
}
