#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(6.0, -8.0, -3.0, 3.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(3.0, 3.0, 6.0, 4.0, -3.0, 2.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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

	var = (mat4x3(2.0, -6.0, -3.0, 1.0, -1.0, 0.0, 4.0, -4.0, -6.0, 0.0, 2.0, -7.0));
}
#version 450
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
	mediump vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(-2.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec4(-3.0, 6.0, 7.0, 3.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-5.0, 1.0));
	var[1] = (vec2(1.0, -5.0));
	var[2] = (vec2(1.0, -4.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(3.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec3(-7.0, -7.0, -7.0));
	var[1] = (vec3(6.0, 9.0, 5.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(7.0, 7.0, -6.0, -4.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat3x2(7.0, 6.0, 9.0, -6.0, 8.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-9.0, -5.0, 4.0, 9.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat3x2(7.0, -6.0, -3.0, -3.0, 0.0, 9.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var = (mat3x2(-6.0, 0.0, -8.0, -3.0, 3.0, -5.0));
}
#version 450
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

	padding = (2.0);
	var[0] = (vec2(4.0, 8.0));
	var[1] = (vec2(4.0, 0.0));
	var[2] = (vec2(7.0, 4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 0.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], 0.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, -7.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 5.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(1.0, -2.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var[0] = (vec4(0.0, -4.0, 9.0, -6.0));
	var[1] = (vec4(6.0, -7.0, -9.0, -7.0));
	var[2] = (vec4(0.0, -5.0, -8.0, 6.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(6.0, 9.0));
	var[0][1] = (vec2(-4.0, -4.0));
	var[0][2] = (vec2(2.0, 0.0));
	var[0][3] = (vec2(-7.0, 3.0));
	var[1][0] = (vec2(9.0, -6.0));
	var[1][1] = (vec2(8.0, -9.0));
	var[1][2] = (vec2(-9.0, -6.0));
	var[1][3] = (vec2(-4.0, -6.0));
	var[2][0] = (vec2(-8.0, 5.0));
	var[2][1] = (vec2(6.0, -8.0));
	var[2][2] = (vec2(-8.0, 3.0));
	var[2][3] = (vec2(2.0, 8.0));
}
#version 450
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

	var[0] = (8);
	var[1] = (2);
	var[2] = (-5);
}
#version 450
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	var[1] = (mat4x3(-2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0));
	var[2] = (mat4x3(7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0));
}
#version 450
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

	var[0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[3][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[3][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[4][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[4][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[5][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[5][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[6][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[6][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[7][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[7][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[8][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[8][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[9][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[9][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[10][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[10][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[11][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[11][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[12][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	var[12][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	var[13][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	var[13][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	var[14][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	var[14][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	var[15][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	var[15][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	var[16][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	var[16][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	var[17][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	var[17][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	var[18][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	var[18][1] = (vec4(1.0, -2.0, 4.0, 5.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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

	var[0] = i16vec2(ivec2(6, -2));
	var[1] = i16vec2(ivec2(-2, -8));
	var[2] = i16vec2(ivec2(3, 5));
	var[3] = i16vec2(ivec2(-9, -9));
	var[4] = i16vec2(ivec2(-4, -3));
	var[5] = i16vec2(ivec2(-2, 6));
	var[6] = i16vec2(ivec2(0, -1));
	var[7] = i16vec2(ivec2(3, -9));
	var[8] = i16vec2(ivec2(9, -6));
	var[9] = i16vec2(ivec2(-1, -7));
	var[10] = i16vec2(ivec2(-1, -6));
	var[11] = i16vec2(ivec2(6, 5));
	var[12] = i16vec2(ivec2(6, 9));
	var[13] = i16vec2(ivec2(0, 9));
	var[14] = i16vec2(ivec2(0, 5));
	var[15] = i16vec2(ivec2(9, -8));
	var[16] = i16vec2(ivec2(4, 6));
	var[17] = i16vec2(ivec2(-9, -9));
	var[18] = i16vec2(ivec2(4, 1));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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

	var[0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	var[3] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	var[4] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	var[5] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	var[6] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	var[7] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	var[8] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	var[9] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	var[10] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	var[11] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	var[12] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	var[13] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	var[14] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	var[15] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	var[16] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	var[17] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	var[18] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[3][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[3][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[3][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[4][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[4][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[4][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[5][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[5][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[5][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[6][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[6][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[6][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[7][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[7][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[7][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[8][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[8][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[8][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[9][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[9][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[9][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[10][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[10][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[10][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[11][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[11][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[11][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	var[12][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	var[12][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	var[12][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	var[13][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	var[13][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	var[13][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	var[14][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	var[14][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	var[14][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	var[15][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	var[15][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	var[15][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	var[16][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	var[16][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	var[16][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	var[17][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	var[17][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	var[17][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	var[18][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	var[18][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	var[18][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
}
#version 450
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
	highp ivec3 var[4][3];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[0][2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[1][0]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[1][1]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[1][2]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[2][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[2][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[2][2]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[3][0]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[3][1]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[3][2]), ivec3(1, -4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (ivec3(-5, 0, -9));
	var[0][1] = (ivec3(2, 4, 1));
	var[0][2] = (ivec3(6, 6, 2));
	var[1][0] = (ivec3(4, 4, 2));
	var[1][1] = (ivec3(-4, -1, -7));
	var[1][2] = (ivec3(8, -4, 1));
	var[2][0] = (ivec3(-4, -1, 5));
	var[2][1] = (ivec3(-4, 2, -2));
	var[2][2] = (ivec3(6, 7, -1));
	var[3][0] = (ivec3(-1, -3, -1));
	var[3][1] = (ivec3(-4, -1, -3));
	var[3][2] = (ivec3(6, -3, 8));
}
#version 450
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
	float16_t var[4][3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[1][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[1][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[2][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[3][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[3][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[3][2]), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = float16_t(-8.0);
	var[0][1] = float16_t(9.0);
	var[0][2] = float16_t(-2.0);
	var[1][0] = float16_t(7.0);
	var[1][1] = float16_t(8.0);
	var[1][2] = float16_t(-9.0);
	var[2][0] = float16_t(2.0);
	var[2][1] = float16_t(-8.0);
	var[2][2] = float16_t(-1.0);
	var[3][0] = float16_t(6.0);
	var[3][1] = float16_t(-7.0);
	var[3][2] = float16_t(-5.0);
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	var[1][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	var[1][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	var[1][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	var[2][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	var[2][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	var[2][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	var[3][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	var[3][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	var[3][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[0][2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[1][0] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[1][1] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[1][2] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[2][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[2][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[2][2] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[3][0] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[3][1] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[3][2] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(1.0, -8.0, 8.0, 4.0, 5.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(0.0, 8.0, 4.0, 8.0, -5.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-5.0, 9.0, -7.0, 7.0, 1.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(8.0, 0.0, -5.0, 3.0, 2.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(0.0, -5.0, -5.0, 9.0, -4.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	var[0][0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[0][0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	var[0][0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[0][0][2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	var[0][0][2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[0][1][0][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	var[0][1][0][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	var[0][1][1][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	var[0][1][1][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	var[0][1][2][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	var[0][1][2][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	var[1][0][0][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	var[1][0][0][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[1][0][1][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	var[1][0][1][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[1][0][2][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	var[1][0][2][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[1][1][0][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	var[1][1][0][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	var[1][1][1][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	var[1][1][1][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	var[1][1][2][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	var[1][1][2][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	var[2][0][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	var[2][0][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[2][0][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	var[2][0][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[2][0][2][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	var[2][0][2][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[2][1][0][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	var[2][1][0][1] = (vec4(8.0, -6.0, 8.0, -7.0));
	var[2][1][1][0] = (vec4(8.0, 0.0, 1.0, -6.0));
	var[2][1][1][1] = (vec4(0.0, 1.0, 1.0, -9.0));
	var[2][1][2][0] = (vec4(-6.0, 9.0, 2.0, -5.0));
	var[2][1][2][1] = (vec4(-7.0, -6.0, 3.0, -2.0));
	var[3][0][0][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	var[3][0][0][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[3][0][1][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	var[3][0][1][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[3][0][2][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	var[3][0][2][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	var[3][1][0][0] = (vec4(1.0, -8.0, 4.0, -7.0));
	var[3][1][0][1] = (vec4(-3.0, 9.0, 4.0, -6.0));
	var[3][1][1][0] = (vec4(-7.0, -3.0, 9.0, -8.0));
	var[3][1][1][1] = (vec4(1.0, -6.0, 7.0, 1.0));
	var[3][1][2][0] = (vec4(5.0, -9.0, 3.0, -2.0));
	var[3][1][2][1] = (vec4(-1.0, 1.0, -7.0, 8.0));
}
#version 450
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
	i8vec3 var[4][2][3];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0][0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][0]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][1]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][2]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][0]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][1]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][0]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][1]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][2]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][2]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][0]), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][1]), ivec3(4294967289, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][2]), ivec3(3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][0]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][1]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][2]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][0]), ivec3(3, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][1]), ivec3(4294967292, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][2]), ivec3(4294967295, 4294967291, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec3(ivec3(4294967292, 0, 0));
	var[0][0][1] = i8vec3(ivec3(7, 9, 4294967290));
	var[0][0][2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[0][1][0] = i8vec3(ivec3(7, 4294967293, 7));
	var[0][1][1] = i8vec3(ivec3(4294967293, 4294967288, 2));
	var[0][1][2] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	var[1][0][0] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[1][0][1] = i8vec3(ivec3(9, 7, 5));
	var[1][0][2] = i8vec3(ivec3(5, 4294967293, 6));
	var[1][1][0] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	var[1][1][1] = i8vec3(ivec3(4294967287, 1, 4294967288));
	var[1][1][2] = i8vec3(ivec3(4294967291, 8, 6));
	var[2][0][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[2][0][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[2][0][2] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[2][1][0] = i8vec3(ivec3(4294967288, 4, 8));
	var[2][1][1] = i8vec3(ivec3(4294967288, 4294967293, 1));
	var[2][1][2] = i8vec3(ivec3(4294967290, 4294967289, 6));
	var[3][0][0] = i8vec3(ivec3(3, 7, 4));
	var[3][0][1] = i8vec3(ivec3(4294967292, 8, 8));
	var[3][0][2] = i8vec3(ivec3(4294967294, 8, 1));
	var[3][1][0] = i8vec3(ivec3(4294967295, 4294967289, 1));
	var[3][1][1] = i8vec3(ivec3(4294967292, 4294967295, 4294967292));
	var[3][1][2] = i8vec3(ivec3(4294967287, 1, 8));
}
#version 450
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
	highp ivec3 var[4][2][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 7) && allOk;
	allOk = compare_ivec3((var[0][0][0]), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_ivec3((var[0][0][1]), ivec3(-6, -8, 3)) && allOk;
	allOk = compare_ivec3((var[0][0][2]), ivec3(-1, -7, -1)) && allOk;
	allOk = compare_ivec3((var[0][1][0]), ivec3(-2, 7, 5)) && allOk;
	allOk = compare_ivec3((var[0][1][1]), ivec3(2, 0, 9)) && allOk;
	allOk = compare_ivec3((var[0][1][2]), ivec3(6, 7, 0)) && allOk;
	allOk = compare_ivec3((var[1][0][0]), ivec3(2, 9, -8)) && allOk;
	allOk = compare_ivec3((var[1][0][1]), ivec3(4, 9, -3)) && allOk;
	allOk = compare_ivec3((var[1][0][2]), ivec3(-3, -9, 9)) && allOk;
	allOk = compare_ivec3((var[1][1][0]), ivec3(4, -6, 1)) && allOk;
	allOk = compare_ivec3((var[1][1][1]), ivec3(7, 4, -6)) && allOk;
	allOk = compare_ivec3((var[1][1][2]), ivec3(9, 3, 1)) && allOk;
	allOk = compare_ivec3((var[2][0][0]), ivec3(3, -6, -6)) && allOk;
	allOk = compare_ivec3((var[2][0][1]), ivec3(7, 3, 6)) && allOk;
	allOk = compare_ivec3((var[2][0][2]), ivec3(9, 0, 5)) && allOk;
	allOk = compare_ivec3((var[2][1][0]), ivec3(5, -6, -1)) && allOk;
	allOk = compare_ivec3((var[2][1][1]), ivec3(8, 8, 3)) && allOk;
	allOk = compare_ivec3((var[2][1][2]), ivec3(3, -7, 5)) && allOk;
	allOk = compare_ivec3((var[3][0][0]), ivec3(8, 2, 7)) && allOk;
	allOk = compare_ivec3((var[3][0][1]), ivec3(-7, 2, 1)) && allOk;
	allOk = compare_ivec3((var[3][0][2]), ivec3(-4, 0, 2)) && allOk;
	allOk = compare_ivec3((var[3][1][0]), ivec3(7, 6, 2)) && allOk;
	allOk = compare_ivec3((var[3][1][1]), ivec3(0, 3, -5)) && allOk;
	allOk = compare_ivec3((var[3][1][2]), ivec3(-9, 4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5);
	var[0][0][0] = (ivec3(0, -9, 2));
	var[0][0][1] = (ivec3(4, 1, 6));
	var[0][0][2] = (ivec3(6, 2, 4));
	var[0][1][0] = (ivec3(-8, 1, -5));
	var[0][1][1] = (ivec3(-4, 9, -2));
	var[0][1][2] = (ivec3(6, -6, -7));
	var[1][0][0] = (ivec3(4, 2, -4));
	var[1][0][1] = (ivec3(-1, -7, 8));
	var[1][0][2] = (ivec3(-4, 1, -4));
	var[1][1][0] = (ivec3(3, 0, -7));
	var[1][1][1] = (ivec3(-5, -7, -7));
	var[1][1][2] = (ivec3(-2, -9, 6));
	var[2][0][0] = (ivec3(-1, 5, -4));
	var[2][0][1] = (ivec3(2, -2, 6));
	var[2][0][2] = (ivec3(7, -1, -1));
	var[2][1][0] = (ivec3(7, -4, -8));
	var[2][1][1] = (ivec3(7, 7, -7));
	var[2][1][2] = (ivec3(-8, 6, 4));
	var[3][0][0] = (ivec3(-3, -1, -4));
	var[3][0][1] = (ivec3(-1, -3, 6));
	var[3][0][2] = (ivec3(-3, 8, 6));
	var[3][1][0] = (ivec3(2, 3, 4));
	var[3][1][1] = (ivec3(-3, -7, 1));
	var[3][1][2] = (ivec3(-3, -9, -1));
}
#version 450
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
	u8vec4 var[4][2][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][0]), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][1]), uvec4(5u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][2]), uvec4(4u, 6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][0]), uvec4(5u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][1]), uvec4(7u, 8u, 5u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][2]), uvec4(5u, 6u, 6u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][0]), uvec4(7u, 6u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][1]), uvec4(3u, 3u, 2u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][2]), uvec4(2u, 2u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][0]), uvec4(5u, 4u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][1]), uvec4(0u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][2]), uvec4(3u, 8u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][0]), uvec4(9u, 5u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][1]), uvec4(2u, 0u, 2u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][2]), uvec4(3u, 7u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][0]), uvec4(4u, 1u, 6u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][1]), uvec4(8u, 2u, 2u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][2]), uvec4(3u, 4u, 1u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][0]), uvec4(7u, 4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][1]), uvec4(8u, 5u, 7u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][2]), uvec4(6u, 3u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][0]), uvec4(9u, 9u, 5u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][1]), uvec4(8u, 0u, 2u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][2]), uvec4(3u, 9u, 6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(9u);
	var[0][0][0] = u8vec4(uvec4(5u, 9u, 4u, 6u));
	var[0][0][1] = u8vec4(uvec4(8u, 7u, 3u, 6u));
	var[0][0][2] = u8vec4(uvec4(7u, 1u, 9u, 8u));
	var[0][1][0] = u8vec4(uvec4(2u, 7u, 4u, 8u));
	var[0][1][1] = u8vec4(uvec4(9u, 1u, 4u, 7u));
	var[0][1][2] = u8vec4(uvec4(0u, 8u, 1u, 0u));
	var[1][0][0] = u8vec4(uvec4(9u, 3u, 3u, 3u));
	var[1][0][1] = u8vec4(uvec4(9u, 0u, 6u, 8u));
	var[1][0][2] = u8vec4(uvec4(7u, 6u, 7u, 7u));
	var[1][1][0] = u8vec4(uvec4(4u, 9u, 9u, 9u));
	var[1][1][1] = u8vec4(uvec4(3u, 5u, 3u, 1u));
	var[1][1][2] = u8vec4(uvec4(4u, 3u, 3u, 8u));
	var[2][0][0] = u8vec4(uvec4(7u, 4u, 8u, 8u));
	var[2][0][1] = u8vec4(uvec4(5u, 3u, 1u, 1u));
	var[2][0][2] = u8vec4(uvec4(4u, 7u, 1u, 3u));
	var[2][1][0] = u8vec4(uvec4(9u, 4u, 7u, 0u));
	var[2][1][1] = u8vec4(uvec4(4u, 6u, 7u, 4u));
	var[2][1][2] = u8vec4(uvec4(2u, 8u, 9u, 9u));
	var[3][0][0] = u8vec4(uvec4(6u, 3u, 3u, 4u));
	var[3][0][1] = u8vec4(uvec4(7u, 8u, 8u, 1u));
	var[3][0][2] = u8vec4(uvec4(7u, 7u, 2u, 5u));
	var[3][1][0] = u8vec4(uvec4(8u, 8u, 1u, 2u));
	var[3][1][1] = u8vec4(uvec4(6u, 8u, 6u, 9u));
	var[3][1][2] = u8vec4(uvec4(6u, 5u, 0u, 1u));
}
#version 450
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
	int8_t var[4][2][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][0][0]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][0][1]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][0][2]), 1) && allOk;
	allOk = compare_int8_t(int(var[0][1][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[0][1][1]), 7) && allOk;
	allOk = compare_int8_t(int(var[0][1][2]), 4294967293) && allOk;
	allOk = compare_int8_t(int(var[1][0][0]), 6) && allOk;
	allOk = compare_int8_t(int(var[1][0][1]), 8) && allOk;
	allOk = compare_int8_t(int(var[1][0][2]), 5) && allOk;
	allOk = compare_int8_t(int(var[1][1][0]), 8) && allOk;
	allOk = compare_int8_t(int(var[1][1][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[1][1][2]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[2][0][0]), 2) && allOk;
	allOk = compare_int8_t(int(var[2][0][1]), 0) && allOk;
	allOk = compare_int8_t(int(var[2][0][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[2][1][0]), 9) && allOk;
	allOk = compare_int8_t(int(var[2][1][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[2][1][2]), 6) && allOk;
	allOk = compare_int8_t(int(var[3][0][0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[3][0][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[3][0][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[3][1][0]), 7) && allOk;
	allOk = compare_int8_t(int(var[3][1][1]), 8) && allOk;
	allOk = compare_int8_t(int(var[3][1][2]), 4294967288) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967290);
	var[0][0][0] = int8_t(4294967294);
	var[0][0][1] = int8_t(3);
	var[0][0][2] = int8_t(4294967288);
	var[0][1][0] = int8_t(4294967289);
	var[0][1][1] = int8_t(1);
	var[0][1][2] = int8_t(7);
	var[1][0][0] = int8_t(1);
	var[1][0][1] = int8_t(2);
	var[1][0][2] = int8_t(4294967288);
	var[1][1][0] = int8_t(4294967287);
	var[1][1][1] = int8_t(4294967289);
	var[1][1][2] = int8_t(6);
	var[2][0][0] = int8_t(4294967294);
	var[2][0][1] = int8_t(7);
	var[2][0][2] = int8_t(9);
	var[2][1][0] = int8_t(1);
	var[2][1][1] = int8_t(4294967293);
	var[2][1][2] = int8_t(2);
	var[3][0][0] = int8_t(0);
	var[3][0][1] = int8_t(4294967292);
	var[3][0][2] = int8_t(0);
	var[3][1][0] = int8_t(5);
	var[3][1][1] = int8_t(4294967289);
	var[3][1][2] = int8_t(3);
}
#version 450
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
	bvec4 var[][4][2];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[0][0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[0][1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[0][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[0][2][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][2][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][3][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((var[0][3][1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0][1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1][1][0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[1][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[1][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[1][3][0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[1][3][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[2][0][0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((var[2][0][1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[2][1][0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[2][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][3][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[2][3][1]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec4(true, true, true, false));
	var[0][0][1] = (bvec4(true, false, false, false));
	var[0][1][0] = (bvec4(false, true, true, false));
	var[0][1][1] = (bvec4(true, true, true, false));
	var[0][2][0] = (bvec4(false, true, false, true));
	var[0][2][1] = (bvec4(true, true, true, false));
	var[0][3][0] = (bvec4(false, false, true, true));
	var[0][3][1] = (bvec4(false, false, true, false));
	var[1][0][0] = (bvec4(false, true, true, true));
	var[1][0][1] = (bvec4(true, true, true, false));
	var[1][1][0] = (bvec4(false, false, true, true));
	var[1][1][1] = (bvec4(true, false, true, false));
	var[1][2][0] = (bvec4(false, true, false, false));
	var[1][2][1] = (bvec4(true, false, false, true));
	var[1][3][0] = (bvec4(true, false, false, true));
	var[1][3][1] = (bvec4(true, false, true, false));
	var[2][0][0] = (bvec4(true, false, true, false));
	var[2][0][1] = (bvec4(true, false, false, true));
	var[2][1][0] = (bvec4(true, true, true, true));
	var[2][1][1] = (bvec4(false, true, false, true));
	var[2][2][0] = (bvec4(true, true, true, false));
	var[2][2][1] = (bvec4(true, false, false, false));
	var[2][3][0] = (bvec4(false, true, false, true));
	var[2][3][1] = (bvec4(false, true, true, true));
}
#version 450
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
	bool var[][4][2];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0][0][0]), false) && allOk;
	allOk = compare_bool((var[0][0][1]), true) && allOk;
	allOk = compare_bool((var[0][1][0]), true) && allOk;
	allOk = compare_bool((var[0][1][1]), false) && allOk;
	allOk = compare_bool((var[0][2][0]), true) && allOk;
	allOk = compare_bool((var[0][2][1]), false) && allOk;
	allOk = compare_bool((var[0][3][0]), false) && allOk;
	allOk = compare_bool((var[0][3][1]), false) && allOk;
	allOk = compare_bool((var[1][0][0]), true) && allOk;
	allOk = compare_bool((var[1][0][1]), false) && allOk;
	allOk = compare_bool((var[1][1][0]), false) && allOk;
	allOk = compare_bool((var[1][1][1]), false) && allOk;
	allOk = compare_bool((var[1][2][0]), true) && allOk;
	allOk = compare_bool((var[1][2][1]), true) && allOk;
	allOk = compare_bool((var[1][3][0]), false) && allOk;
	allOk = compare_bool((var[1][3][1]), true) && allOk;
	allOk = compare_bool((var[2][0][0]), false) && allOk;
	allOk = compare_bool((var[2][0][1]), true) && allOk;
	allOk = compare_bool((var[2][1][0]), false) && allOk;
	allOk = compare_bool((var[2][1][1]), true) && allOk;
	allOk = compare_bool((var[2][2][0]), false) && allOk;
	allOk = compare_bool((var[2][2][1]), true) && allOk;
	allOk = compare_bool((var[2][3][0]), false) && allOk;
	allOk = compare_bool((var[2][3][1]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (false);
	var[0][0][1] = (false);
	var[0][1][0] = (true);
	var[0][1][1] = (true);
	var[0][2][0] = (false);
	var[0][2][1] = (false);
	var[0][3][0] = (true);
	var[0][3][1] = (true);
	var[1][0][0] = (true);
	var[1][0][1] = (true);
	var[1][1][0] = (true);
	var[1][1][1] = (true);
	var[1][2][0] = (true);
	var[1][2][1] = (false);
	var[1][3][0] = (true);
	var[1][3][1] = (true);
	var[2][0][0] = (false);
	var[2][0][1] = (false);
	var[2][1][0] = (false);
	var[2][1][1] = (false);
	var[2][2][0] = (true);
	var[2][2][1] = (false);
	var[2][3][0] = (true);
	var[2][3][1] = (false);
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(7.0, -3.0));
	var[0][0][0][1] = (vec2(-2.0, 4.0));
	var[0][0][1][0] = (vec2(1.0, -3.0));
	var[0][0][1][1] = (vec2(2.0, -4.0));
	var[0][1][0][0] = (vec2(1.0, 5.0));
	var[0][1][0][1] = (vec2(9.0, -6.0));
	var[0][1][1][0] = (vec2(-7.0, 5.0));
	var[0][1][1][1] = (vec2(7.0, 4.0));
	var[0][2][0][0] = (vec2(-5.0, 8.0));
	var[0][2][0][1] = (vec2(3.0, 1.0));
	var[0][2][1][0] = (vec2(-9.0, 7.0));
	var[0][2][1][1] = (vec2(7.0, 1.0));
	var[0][3][0][0] = (vec2(-8.0, 7.0));
	var[0][3][0][1] = (vec2(0.0, 2.0));
	var[0][3][1][0] = (vec2(-7.0, -7.0));
	var[0][3][1][1] = (vec2(5.0, -3.0));
	var[1][0][0][0] = (vec2(-1.0, 1.0));
	var[1][0][0][1] = (vec2(-4.0, 3.0));
	var[1][0][1][0] = (vec2(7.0, -7.0));
	var[1][0][1][1] = (vec2(2.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -9.0));
	var[1][1][0][1] = (vec2(0.0, 6.0));
	var[1][1][1][0] = (vec2(-1.0, -7.0));
	var[1][1][1][1] = (vec2(-8.0, 4.0));
	var[1][2][0][0] = (vec2(-3.0, -9.0));
	var[1][2][0][1] = (vec2(-7.0, 1.0));
	var[1][2][1][0] = (vec2(-7.0, 6.0));
	var[1][2][1][1] = (vec2(2.0, -5.0));
	var[1][3][0][0] = (vec2(-1.0, -1.0));
	var[1][3][0][1] = (vec2(1.0, 1.0));
	var[1][3][1][0] = (vec2(7.0, 1.0));
	var[1][3][1][1] = (vec2(2.0, -8.0));
	var[2][0][0][0] = (vec2(-8.0, 4.0));
	var[2][0][0][1] = (vec2(8.0, 1.0));
	var[2][0][1][0] = (vec2(4.0, 6.0));
	var[2][0][1][1] = (vec2(-9.0, 9.0));
	var[2][1][0][0] = (vec2(5.0, 6.0));
	var[2][1][0][1] = (vec2(-7.0, 7.0));
	var[2][1][1][0] = (vec2(-1.0, -5.0));
	var[2][1][1][1] = (vec2(9.0, -7.0));
	var[2][2][0][0] = (vec2(6.0, -3.0));
	var[2][2][0][1] = (vec2(-5.0, -6.0));
	var[2][2][1][0] = (vec2(-3.0, 7.0));
	var[2][2][1][1] = (vec2(9.0, 6.0));
	var[2][3][0][0] = (vec2(-1.0, 1.0));
	var[2][3][0][1] = (vec2(2.0, -4.0));
	var[2][3][1][0] = (vec2(-9.0, -4.0));
	var[2][3][1][1] = (vec2(7.0, 0.0));
}
#version 450
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	var[0][1][0][0] = (vec3(-6.0, 3.0, 9.0));
	var[0][1][0][1] = (vec3(3.0, -2.0, -9.0));
	var[0][1][1][0] = (vec3(-7.0, -8.0, -6.0));
	var[0][1][1][1] = (vec3(-7.0, 2.0, -3.0));
	var[0][2][0][0] = (vec3(5.0, 5.0, -4.0));
	var[0][2][0][1] = (vec3(1.0, -9.0, 1.0));
	var[0][2][1][0] = (vec3(3.0, 0.0, -6.0));
	var[0][2][1][1] = (vec3(5.0, -6.0, -6.0));
	var[0][3][0][0] = (vec3(1.0, -4.0, 2.0));
	var[0][3][0][1] = (vec3(0.0, 1.0, -8.0));
	var[0][3][1][0] = (vec3(-3.0, -9.0, 6.0));
	var[0][3][1][1] = (vec3(-3.0, 6.0, 6.0));
	var[1][0][0][0] = (vec3(6.0, -5.0, -7.0));
	var[1][0][0][1] = (vec3(1.0, 1.0, -3.0));
	var[1][0][1][0] = (vec3(9.0, -7.0, 2.0));
	var[1][0][1][1] = (vec3(5.0, -4.0, 6.0));
	var[1][1][0][0] = (vec3(1.0, -1.0, 8.0));
	var[1][1][0][1] = (vec3(7.0, -2.0, -6.0));
	var[1][1][1][0] = (vec3(-1.0, -1.0, -5.0));
	var[1][1][1][1] = (vec3(-1.0, 1.0, -1.0));
	var[1][2][0][0] = (vec3(7.0, 1.0, -9.0));
	var[1][2][0][1] = (vec3(7.0, -8.0, -1.0));
	var[1][2][1][0] = (vec3(5.0, -3.0, 9.0));
	var[1][2][1][1] = (vec3(-6.0, 4.0, -4.0));
	var[1][3][0][0] = (vec3(-6.0, 1.0, 4.0));
	var[1][3][0][1] = (vec3(7.0, 9.0, -9.0));
	var[1][3][1][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][3][1][1] = (vec3(7.0, 1.0, -4.0));
	var[2][0][0][0] = (vec3(-3.0, -8.0, 6.0));
	var[2][0][0][1] = (vec3(8.0, 2.0, 4.0));
	var[2][0][1][0] = (vec3(0.0, 8.0, 0.0));
	var[2][0][1][1] = (vec3(-2.0, 1.0, -3.0));
	var[2][1][0][0] = (vec3(5.0, 5.0, -6.0));
	var[2][1][0][1] = (vec3(6.0, 7.0, -2.0));
	var[2][1][1][0] = (vec3(-5.0, -7.0, -1.0));
	var[2][1][1][1] = (vec3(4.0, -3.0, -7.0));
	var[2][2][0][0] = (vec3(2.0, 5.0, 0.0));
	var[2][2][0][1] = (vec3(1.0, -8.0, 0.0));
	var[2][2][1][0] = (vec3(7.0, -2.0, -7.0));
	var[2][2][1][1] = (vec3(-6.0, -5.0, 3.0));
	var[2][3][0][0] = (vec3(-3.0, 5.0, -5.0));
	var[2][3][0][1] = (vec3(4.0, 1.0, 9.0));
	var[2][3][1][0] = (vec3(3.0, -8.0, 6.0));
	var[2][3][1][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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
	highp ivec3 var[][4][2];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0][0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[0][0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[0][1][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[0][1][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[0][2][0]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((var[0][2][1]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((var[0][3][0]), ivec3(1, 5, -6)) && allOk;
	allOk = compare_ivec3((var[0][3][1]), ivec3(-1, 8, 8)) && allOk;
	allOk = compare_ivec3((var[1][0][0]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[1][0][1]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[1][1][0]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[1][1][1]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[1][2][0]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((var[1][2][1]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((var[1][3][0]), ivec3(3, 3, -7)) && allOk;
	allOk = compare_ivec3((var[1][3][1]), ivec3(5, 7, 6)) && allOk;
	allOk = compare_ivec3((var[2][0][0]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[2][0][1]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[2][1][0]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[2][1][1]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((var[2][2][0]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((var[2][2][1]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((var[2][3][0]), ivec3(2, 0, 3)) && allOk;
	allOk = compare_ivec3((var[2][3][1]), ivec3(-5, -9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec3(-5, 0, -9));
	var[0][0][1] = (ivec3(2, 4, 1));
	var[0][1][0] = (ivec3(-4, -1, 5));
	var[0][1][1] = (ivec3(-4, 2, -2));
	var[0][2][0] = (ivec3(6, -8, 1));
	var[0][2][1] = (ivec3(-5, -4, 9));
	var[0][3][0] = (ivec3(6, 7, -4));
	var[0][3][1] = (ivec3(-8, 7, 7));
	var[1][0][0] = (ivec3(6, 6, 2));
	var[1][0][1] = (ivec3(4, 4, 2));
	var[1][1][0] = (ivec3(6, 7, -1));
	var[1][1][1] = (ivec3(-1, -3, -1));
	var[1][2][0] = (ivec3(-2, 6, -6));
	var[1][2][1] = (ivec3(-7, 3, 0));
	var[1][3][0] = (ivec3(-7, -8, 6));
	var[1][3][1] = (ivec3(4, 2, 3));
	var[2][0][0] = (ivec3(-4, -1, -7));
	var[2][0][1] = (ivec3(8, -4, 1));
	var[2][1][0] = (ivec3(-4, -1, -3));
	var[2][1][1] = (ivec3(6, -3, 8));
	var[2][2][0] = (ivec3(-7, -5, -7));
	var[2][2][1] = (ivec3(-7, -2, -9));
	var[2][3][0] = (ivec3(4, -3, -7));
	var[2][3][1] = (ivec3(1, -3, -9));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[0][1][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[0][1][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[0][2][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	var[0][2][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	var[0][3][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	var[0][3][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	var[1][0][0] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[1][0][1] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[1][1][0] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[1][1][1] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[1][2][0] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	var[1][2][1] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	var[1][3][0] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	var[1][3][1] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	var[2][0][0] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[2][0][1] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[2][1][0] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[2][1][1] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	var[2][2][0] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	var[2][2][1] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	var[2][3][0] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	var[2][3][1] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(6, -9, 7)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-3.0, 7.0, 0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-4.0, 3.0, 4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(6.0, -1.0, 2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(5.0, 1.0, 1.0, -9.0, 2.0, -5.0, 7.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(4.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(0, -9, 5)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-1.0, -7.0, 9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-9.0, -8.0, 3.0, 0.0, 3.0, -1.0, 1.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(6.0, 3.0, -4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-1.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(4, -3, -2)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(0.0, 5.0, -3.0, 6.0, -6.0, -7.0, -5.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(7.0, -3.0, -7.0, 0.0, 6.0, -5.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-1.0, -5.0, 0.0, 8.0, -2.0, -4.0, 5.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(4.0, 1.0, 5.0, -1.0, 9.0, -3.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-8.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(-4, 5, 9)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(4.0, 7.0, 1.0, -9.0, -1.0, -3.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(9.0, -2.0, 6.0, 4.0, 9.0, -4.0, 8.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-5.0, 0.0, 8.0, -5.0, 1.0, 0.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(3.0, 5.0, 6.0, -7.0, 2.0, 2.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(5.0, 2.0, -2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(4, -2, -6)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(1.0, 5.0, -7.0, -8.0, 1.0, -6.0, 6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-2.0, -1.0, -5.0, 4.0, 7.0, -9.0, 9.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(8.0, -2.0, 0.0, -7.0, -2.0, 5.0, -4.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-8.0, -2.0, -4.0, -5.0, -8.0, 6.0, 3.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(9.0, -3.0, -8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(5, 6, -3)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(0.0, -5.0, 5.0, 4.0, 3.0, 1.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(2.0, 0.0, -1.0, 6.0, -6.0, -8.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-8.0, -9.0, -9.0, -1.0, 5.0, 9.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(4.0, 8.0, 6.0, -1.0, -7.0, -4.0, 5.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(2.0, -3.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(8, 7, -3)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(1.0, -6.0, -2.0, 5.0, 0.0, -2.0, 5.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(4.0, 5.0, 2.0, 6.0, 9.0, -7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(3.0, 8.0, -9.0, -6.0, -9.0, 9.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(8.0, -1.0, -9.0, 3.0, 7.0, -8.0, 3.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-8.0, 1.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-4, -8, 8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(-2.0, 0.0, 5.0, -4.0, 9.0, 0.0, -8.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-8.0, 4.0, -9.0, -9.0, -6.0, 4.0, -4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(2.0, -4.0, 0.0, 1.0, -5.0, -5.0, -9.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(-3.0, 3.0, -5.0, -8.0, 5.0, 7.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(1.0, -3.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-9, -3, -7)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(6.0, -3.0, 9.0, -6.0, -1.0, 5.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-2.0, 0.0, 7.0, 9.0, 3.0, 7.0, -6.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-3.0, 4.0, 2.0, -7.0, 1.0, -4.0, 0.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(4.0, -2.0, -4.0, 9.0, -9.0, -2.0, 5.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(7.0, -8.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-4, 1, 7));
	block[0].s[0].b[0][0] = (vec3(-9.0, 7.0, 5.0));
	block[0].s[0].b[0][1] = (vec3(-5.0, 3.0, 0.0));
	block[0].s[0].b[0][2] = (vec3(-9.0, 3.0, 8.0));
	block[0].s[0].b[1][0] = (vec3(8.0, -7.0, -3.0));
	block[0].s[0].b[1][1] = (vec3(2.0, -6.0, 3.0));
	block[0].s[0].b[1][2] = (vec3(0.0, -1.0, -5.0));
	block[0].s[0].b[2][0] = (vec3(7.0, 3.0, 2.0));
	block[0].s[0].b[2][1] = (vec3(-6.0, 8.0, 7.0));
	block[0].s[0].b[2][2] = (vec3(8.0, -7.0, 8.0));
	block[0].s[0].b[3][0] = (vec3(-1.0, 0.0, 7.0));
	block[0].s[0].b[3][1] = (vec3(2.0, 2.0, -3.0));
	block[0].s[0].b[3][2] = (vec3(-7.0, 7.0, 3.0));
	block[0].s[0].c = (vec4(8.0, -4.0, 9.0, -4.0));
	block[0].s[1].a = (ivec3(-2, 8, -4));
	block[0].s[1].b[0][0] = (vec3(8.0, 1.0, 8.0));
	block[0].s[1].b[0][1] = (vec3(-1.0, -6.0, -7.0));
	block[0].s[1].b[0][2] = (vec3(7.0, 5.0, -6.0));
	block[0].s[1].b[1][0] = (vec3(7.0, -3.0, 6.0));
	block[0].s[1].b[1][1] = (vec3(0.0, -6.0, -3.0));
	block[0].s[1].b[1][2] = (vec3(-3.0, 7.0, -4.0));
	block[0].s[1].b[2][0] = (vec3(5.0, -2.0, 3.0));
	block[0].s[1].b[2][1] = (vec3(-3.0, 7.0, 2.0));
	block[0].s[1].b[2][2] = (vec3(-4.0, 4.0, 4.0));
	block[0].s[1].b[3][0] = (vec3(-4.0, 2.0, -4.0));
	block[0].s[1].b[3][1] = (vec3(9.0, 0.0, -7.0));
	block[0].s[1].b[3][2] = (vec3(-5.0, 0.0, 7.0));
	block[0].s[1].c = (vec4(4.0, -7.0, 2.0, -6.0));
	block[0].s[2].a = (ivec3(-3, 2, -3));
	block[0].s[2].b[0][0] = (vec3(-6.0, 5.0, -5.0));
	block[0].s[2].b[0][1] = (vec3(4.0, -5.0, -5.0));
	block[0].s[2].b[0][2] = (vec3(7.0, 5.0, -1.0));
	block[0].s[2].b[1][0] = (vec3(3.0, -9.0, 0.0));
	block[0].s[2].b[1][1] = (vec3(7.0, -3.0, 8.0));
	block[0].s[2].b[1][2] = (vec3(-3.0, -9.0, -2.0));
	block[0].s[2].b[2][0] = (vec3(1.0, -8.0, 3.0));
	block[0].s[2].b[2][1] = (vec3(6.0, -9.0, -9.0));
	block[0].s[2].b[2][2] = (vec3(-9.0, -7.0, 0.0));
	block[0].s[2].b[3][0] = (vec3(1.0, -5.0, -6.0));
	block[0].s[2].b[3][1] = (vec3(4.0, -9.0, 8.0));
	block[0].s[2].b[3][2] = (vec3(5.0, 9.0, 4.0));
	block[0].s[2].c = (vec4(9.0, 6.0, -1.0, -9.0));
	block[0].v = (vec4(-4.0, 8.0, 3.0, 6.0));
	block[1].s[0].a = (ivec3(-5, -8, 7));
	block[1].s[0].b[0][0] = (vec3(5.0, -2.0, 8.0));
	block[1].s[0].b[0][1] = (vec3(-1.0, -5.0, 8.0));
	block[1].s[0].b[0][2] = (vec3(-7.0, 7.0, -6.0));
	block[1].s[0].b[1][0] = (vec3(-9.0, -1.0, 2.0));
	block[1].s[0].b[1][1] = (vec3(2.0, 4.0, 9.0));
	block[1].s[0].b[1][2] = (vec3(-9.0, 1.0, 1.0));
	block[1].s[0].b[2][0] = (vec3(7.0, 5.0, -8.0));
	block[1].s[0].b[2][1] = (vec3(-7.0, -8.0, 6.0));
	block[1].s[0].b[2][2] = (vec3(6.0, 5.0, 7.0));
	block[1].s[0].b[3][0] = (vec3(5.0, 5.0, 3.0));
	block[1].s[0].b[3][1] = (vec3(3.0, 3.0, 8.0));
	block[1].s[0].b[3][2] = (vec3(4.0, -6.0, -3.0));
	block[1].s[0].c = (vec4(3.0, -6.0, 6.0, -2.0));
	block[1].s[1].a = (ivec3(-7, 5, 5));
	block[1].s[1].b[0][0] = (vec3(-9.0, -2.0, 8.0));
	block[1].s[1].b[0][1] = (vec3(-7.0, -8.0, 3.0));
	block[1].s[1].b[0][2] = (vec3(-9.0, 7.0, 3.0));
	block[1].s[1].b[1][0] = (vec3(-3.0, -6.0, 2.0));
	block[1].s[1].b[1][1] = (vec3(4.0, -4.0, -5.0));
	block[1].s[1].b[1][2] = (vec3(-3.0, -5.0, -6.0));
	block[1].s[1].b[2][0] = (vec3(9.0, -6.0, -3.0));
	block[1].s[1].b[2][1] = (vec3(-1.0, -6.0, 6.0));
	block[1].s[1].b[2][2] = (vec3(8.0, 3.0, 0.0));
	block[1].s[1].b[3][0] = (vec3(3.0, 7.0, 0.0));
	block[1].s[1].b[3][1] = (vec3(-7.0, 8.0, 1.0));
	block[1].s[1].b[3][2] = (vec3(5.0, -6.0, -8.0));
	block[1].s[1].c = (vec4(-3.0, -9.0, -8.0, -2.0));
	block[1].s[2].a = (ivec3(5, 4, 5));
	block[1].s[2].b[0][0] = (vec3(7.0, 2.0, -2.0));
	block[1].s[2].b[0][1] = (vec3(-8.0, -9.0, -1.0));
	block[1].s[2].b[0][2] = (vec3(9.0, -2.0, 8.0));
	block[1].s[2].b[1][0] = (vec3(9.0, 6.0, -8.0));
	block[1].s[2].b[1][1] = (vec3(-6.0, -3.0, 9.0));
	block[1].s[2].b[1][2] = (vec3(1.0, 0.0, 3.0));
	block[1].s[2].b[2][0] = (vec3(6.0, 5.0, 0.0));
	block[1].s[2].b[2][1] = (vec3(-3.0, -3.0, 0.0));
	block[1].s[2].b[2][2] = (vec3(6.0, 0.0, -4.0));
	block[1].s[2].b[3][0] = (vec3(-4.0, -6.0, -4.0));
	block[1].s[2].b[3][1] = (vec3(-1.0, 2.0, -3.0));
	block[1].s[2].b[3][2] = (vec3(6.0, 8.0, -1.0));
	block[1].s[2].c = (vec4(5.0, 6.0, 9.0, 0.0));
	block[1].v = (vec4(3.0, 0.0, 0.0, 4.0));
	block[2].s[0].a = (ivec3(6, 1, 3));
	block[2].s[0].b[0][0] = (vec3(-1.0, -4.0, 6.0));
	block[2].s[0].b[0][1] = (vec3(-1.0, 4.0, 6.0));
	block[2].s[0].b[0][2] = (vec3(5.0, -4.0, -9.0));
	block[2].s[0].b[1][0] = (vec3(1.0, 5.0, 9.0));
	block[2].s[0].b[1][1] = (vec3(-2.0, -2.0, -1.0));
	block[2].s[0].b[1][2] = (vec3(4.0, -5.0, 5.0));
	block[2].s[0].b[2][0] = (vec3(2.0, -7.0, -8.0));
	block[2].s[0].b[2][1] = (vec3(-7.0, -4.0, 7.0));
	block[2].s[0].b[2][2] = (vec3(-2.0, -4.0, -2.0));
	block[2].s[0].b[3][0] = (vec3(-1.0, 7.0, -5.0));
	block[2].s[0].b[3][1] = (vec3(7.0, 5.0, 2.0));
	block[2].s[0].b[3][2] = (vec3(3.0, 9.0, -2.0));
	block[2].s[0].c = (vec4(-2.0, 0.0, -5.0, -1.0));
	block[2].s[1].a = (ivec3(-3, -4, 5));
	block[2].s[1].b[0][0] = (vec3(-5.0, -1.0, -9.0));
	block[2].s[1].b[0][1] = (vec3(-8.0, 0.0, 1.0));
	block[2].s[1].b[0][2] = (vec3(6.0, 1.0, 8.0));
	block[2].s[1].b[1][0] = (vec3(3.0, 1.0, -7.0));
	block[2].s[1].b[1][1] = (vec3(5.0, 5.0, -8.0));
	block[2].s[1].b[1][2] = (vec3(-9.0, -7.0, 9.0));
	block[2].s[1].b[2][0] = (vec3(-9.0, -2.0, 2.0));
	block[2].s[1].b[2][1] = (vec3(-8.0, 5.0, -4.0));
	block[2].s[1].b[2][2] = (vec3(3.0, 8.0, -5.0));
	block[2].s[1].b[3][0] = (vec3(6.0, -7.0, 3.0));
	block[2].s[1].b[3][1] = (vec3(-6.0, 4.0, -7.0));
	block[2].s[1].b[3][2] = (vec3(-8.0, -5.0, 5.0));
	block[2].s[1].c = (vec4(2.0, 1.0, -2.0, -6.0));
	block[2].s[2].a = (ivec3(1, 0, -4));
	block[2].s[2].b[0][0] = (vec3(9.0, 6.0, 7.0));
	block[2].s[2].b[0][1] = (vec3(-7.0, -7.0, 9.0));
	block[2].s[2].b[0][2] = (vec3(-5.0, -4.0, 7.0));
	block[2].s[2].b[1][0] = (vec3(-2.0, 4.0, 1.0));
	block[2].s[2].b[1][1] = (vec3(-8.0, -8.0, -7.0));
	block[2].s[2].b[1][2] = (vec3(2.0, -1.0, 2.0));
	block[2].s[2].b[2][0] = (vec3(6.0, 1.0, 7.0));
	block[2].s[2].b[2][1] = (vec3(3.0, -6.0, -3.0));
	block[2].s[2].b[2][2] = (vec3(2.0, 1.0, -7.0));
	block[2].s[2].b[3][0] = (vec3(-2.0, 6.0, 8.0));
	block[2].s[2].b[3][1] = (vec3(3.0, -4.0, -1.0));
	block[2].s[2].b[3][2] = (vec3(2.0, 4.0, 1.0));
	block[2].s[2].c = (vec4(-4.0, 3.0, -4.0, -2.0));
	block[2].v = (vec4(-1.0, 2.0, 9.0, 5.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	highp uint u;
	T t[];
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
	allOk = compare_uint((u), 1u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(2.0, 0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(9u, 0u, 6u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-6.0, -7.0, 4.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-9.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(2.0, -5.0, 2.0, -7.0)) && allOk;
	allOk = compare_int((t[0].c), 1) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0, -3.0, 6.0, 1.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(8u, 7u, 7u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(4.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(2u, 8u, 3u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(-5.0, -1.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(4.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(7u, 1u, 8u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-4.0, 2.0, 9.0, -3.0)) && allOk;
	allOk = compare_int((t[1].c), -4) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(1.0, 0.0, 6.0, -9.0, -3.0, 2.0, 5.0, -4.0, -1.0, 9.0, 4.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(4u, 1u, 1u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(6.0, 3.0, -2.0, -8.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(0u, 3u, 9u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(3.0, -6.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(0.0, -4.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(0.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(5u, 7u, 4u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(3.0, -7.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(-5.0, -1.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(3.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_int((t[2].c), 8) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(-3.0, 2.0, 4.0, 9.0, -7.0, -5.0, -9.0, -6.0, 8.0, -6.0, 7.0, 0.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(2u, 7u, 0u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(9.0, -2.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(3.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(4u, 9u, 9u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(0.0, 5.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(8.0, 9.0, -8.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(-4.0, -7.0, 5.0, 9.0)) && allOk;
	allOk = compare_int((t[3].c), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(7u, 4u, 2u));
	s.b[0] = (vec2(-9.0, 5.0));
	s.b[1] = (vec2(2.0, 9.0));
	s.b[2] = (vec2(-9.0, -9.0));
	s.b[3] = (vec2(0.0, -3.0));
	s.c = (vec4(7.0, -9.0, 8.0, -2.0));
	u = (5u);
}
#version 450
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
	highp vec4 var;
} block[3];

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

layout(std140, binding = 1) buffer Block
{
	highp uvec2 var;
} block[3];

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block[0].var), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block[1].var), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block[2].var), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec2(6u, 1u));
	block[1].var = (uvec2(8u, 1u));
	block[2].var = (uvec2(7u, 4u));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-2.0, 4.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(6.0, 4.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 4.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(1.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-6.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block[1].var = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block[2].var = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 6.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(-8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0, 3.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0, 4.0, 3.0, -8.0, 4.0, -1.0, 7.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var[0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block[0].var[1] = (vec4(0.0, 4.0, -1.0, -5.0));
	block[0].var[2] = (vec4(4.0, 0.0, -6.0, -6.0));
	block[0].var[3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	block[1].padding = (2.0);
	block[1].var[0] = (vec4(1.0, -4.0, 3.0, 5.0));
	block[1].var[1] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block[1].var[2] = (vec4(3.0, 9.0, -6.0, 1.0));
	block[1].var[3] = (vec4(5.0, 4.0, -7.0, -9.0));
	block[2].padding = (-2.0);
	block[2].var[0] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block[2].var[1] = (vec4(6.0, 0.0, 8.0, 4.0));
	block[2].var[2] = (vec4(0.0, 8.0, 4.0, 4.0));
	block[2].var[3] = (vec4(-5.0, -6.0, -8.0, 6.0));
}
#version 450
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
	uint16_t var;
} block[3];

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block[0].var), 9u) && allOk;
	allOk = compare_uint16_t(uint(block[1].var), 5u) && allOk;
	allOk = compare_uint16_t(uint(block[2].var), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = uint16_t(9u);
	block[1].var = uint16_t(1u);
	block[2].var = uint16_t(1u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA[3];
layout(std430, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA[0].a), -5.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(0.0, -9.0, 5.0, 4.0)) && allOk;
	allOk = compare_float((blockA[1].a), -3.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(0.0, -9.0, -6.0, -1.0)) && allOk;
	allOk = compare_float((blockA[2].a), 8.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(3.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-9, 0)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-5, -2)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-8, 3)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (3.0);
	blockA[1].a = (2.0);
	blockA[2].a = (-9.0);
	blockB[0].a[0] = (vec3(3.0, 0.0, -1.0));
	blockB[0].a[1] = (vec3(-5.0, 7.0, 3.0));
	blockB[0].a[2] = (vec3(2.0, -6.0, 8.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec3(2.0, -3.0, -7.0));
	blockB[1].a[1] = (vec3(7.0, 3.0, 8.0));
	blockB[1].a[2] = (vec3(1.0, 8.0, -1.0));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec3(0.0, -6.0, -3.0));
	blockB[2].a[1] = (vec3(-3.0, 7.0, -4.0));
	blockB[2].a[2] = (vec3(5.0, -2.0, 3.0));
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

layout(std430, binding = 1) buffer BlockB
{
	lowp int a;
	mediump float b;
	mediump int c[1];
	mediump float d;
	mediump uint e[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 3.0) && allOk;
	allOk = compare_int((blockB.c[0]), 3) && allOk;
	allOk = compare_uint((blockB.e[0]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5);
	blockB.b = (-5.0);
	blockB.c[0] = (3);
	blockB.d = (9.0);
}
#version 450
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
	layout(offset = 16) bvec3 b;
	layout(offset = 32) bvec3 c[1];
	layout(offset = 48) lowp ivec2 d;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uint e;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 f;
	layout(offset = 16) lowp vec3 g;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a), bvec2(true, true)) && allOk;
	allOk = compare_bvec3((blockB[0].b), bvec3(true, true, true)) && allOk;
	allOk = compare_ivec2((blockB[0].d), ivec2(5, 1)) && allOk;
	allOk = compare_uint((blockC.e), 7u) && allOk;
	allOk = compare_bvec4((blockD.f), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec2(true, true));
	blockB[0].b = (bvec3(false, false, true));
	blockB[0].c[0] = (bvec3(false, true, true));
	blockB[0].d = (ivec2(1, 7));
	blockC.e = (7u);
	blockD.f = (bvec4(true, true, true, true));
	blockD.g = (vec3(-8.0, -3.0, 0.0));
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 16) lowp uvec4 b;
	layout(offset = 32) highp uint c;
	layout(offset = 36) lowp ivec3 d;
	layout(offset = 48) lowp int e[1];
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec4 f;
	layout(offset = 16) bvec2 g;
	layout(offset = 24) mediump uint h;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump ivec3 i;
	layout(offset = 12) bool j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((d), ivec3(-4, 4, -5)) && allOk;
	allOk = compare_int((e[0]), 6) && allOk;
	allOk = compare_uint((blockC.h), 3u) && allOk;
	allOk = compare_bool((j), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(1.0, 8.0, 5.0));
	b = (uvec4(0u, 8u, 5u, 1u));
	c = (8u);
	d = (ivec3(-9, 8, 5));
	e[0] = (-8);
	blockC.f = (vec4(5.0, 2.0, 2.0, 3.0));
	blockC.g = (bvec2(false, false));
	blockC.h = (2u);
	i = (ivec3(6, 5, 3));
}
#version 450
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
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp mat3x2 b;
	mediump ivec3 c;
	highp vec4 d[];
} blockC;
layout(scalar, column_major, binding = 3) readonly buffer BlockD
{
	highp ivec4 e[5];
	lowp mat4x2 f[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(-3, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[1]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((blockB.a[2]), ivec2(9, 3)) && allOk;
	allOk = compare_ivec2((blockB.a[3]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((blockB.a[4]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((blockB.a[5]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((blockB.a[6]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(6, 2, 3)) && allOk;
	allOk = compare_vec4((blockC.d[0]), vec4(9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.d[1]), vec4(-2.0, 9.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.d[2]), vec4(-4.0, 1.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.d[3]), vec4(1.0, 9.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.d[4]), vec4(-6.0, -3.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.d[5]), vec4(5.0, -7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].f[0], mat4x2(6.0, -3.0, 6.0, -9.0, 4.0, -1.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].f[0], mat4x2(2.0, -7.0, 8.0, 6.0, -5.0, -5.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].f[1], mat4x2(4.0, 6.0, -7.0, -3.0, 5.0, 3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].f[2], mat4x2(8.0, -1.0, 3.0, -5.0, -6.0, 6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].f[3], mat4x2(5.0, -5.0, -8.0, -6.0, 2.0, 4.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].f[4], mat4x2(-5.0, 2.0, 5.0, -4.0, -5.0, -1.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].f[5], mat4x2(7.0, -4.0, -5.0, -3.0, -5.0, -7.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].f[6], mat4x2(-3.0, 2.0, -5.0, 5.0, -7.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].f[0], mat4x2(-6.0, -6.0, -4.0, -6.0, 8.0, 0.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3x2(-2.0, -7.0, 5.0, -2.0, -6.0, -7.0));
	blockC.c = (ivec3(4, 1, -8));
	blockC.d[0] = (vec4(-6.0, -1.0, 7.0, -9.0));
	blockC.d[1] = (vec4(-1.0, -6.0, 4.0, 6.0));
	blockC.d[2] = (vec4(5.0, 3.0, 9.0, -5.0));
	blockC.d[3] = (vec4(-1.0, 2.0, 2.0, -8.0));
	blockC.d[4] = (vec4(2.0, 6.0, 0.0, 5.0));
	blockC.d[5] = (vec4(9.0, 4.0, -2.0, -3.0));
}
#version 450
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
	bvec2 a;
	lowp mat3x4 b;
	lowp mat3 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[nonuniformEXT(0)].a), bvec2(true, true)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].b, mat3x4(-4.0, -4.0, -1.0, 6.0, -5.0, -6.0, -2.0, 5.0, 9.0, -1.0, 1.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(1)].a), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].b, mat3x4(-1.0, -4.0, -4.0, -4.0, -7.0, -3.0, -9.0, 0.0, 7.0, 1.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec2(true, true));
	blockB[nonuniformEXT(0)].c = (mat3(-1.0, -6.0, -4.0, 4.0, -7.0, 8.0, -4.0, -7.0, 2.0));
	blockB[nonuniformEXT(1)].a = (bvec2(false, true));
	blockB[nonuniformEXT(1)].c = (mat3(-4.0, 2.0, -1.0, 8.0, -2.0, -1.0, -5.0, 8.0, 1.0));
}
#version 450
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
	int16_t e[6];
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
	allOk = compare_int16_t(int(blockC.e[1]), -1) && allOk;
	allOk = compare_int16_t(int(blockC.e[2]), -9) && allOk;
	allOk = compare_int16_t(int(blockC.e[3]), -6) && allOk;
	allOk = compare_int16_t(int(blockC.e[4]), -9) && allOk;
	allOk = compare_int16_t(int(blockC.e[5]), 6) && allOk;
	allOk = compare_int((blockC.f), 1) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.i), uvec2(8u, 4u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.j), ivec4(-5, 1, 2, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(4u, 4u, 9u));
	blockB.c = int16_t(4);
	blockC.d = uint16_t(8u);
	blockC.e[0] = int16_t(-2);
	blockC.e[1] = int16_t(-8);
	blockC.e[2] = int16_t(-6);
	blockC.e[3] = int16_t(9);
	blockC.e[4] = int16_t(4);
	blockC.e[5] = int16_t(-5);
	blockC.f = (5);
	blockC.g = f16vec2(vec2(-1.0, 4.0));
	h = (ivec4(-7, 5, -6, 4));
	blockE.i = u16vec2(uvec2(1u, 3u));
	blockE.j = i16vec4(ivec4(0, -8, 6, -8));
}
#version 450
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
	i16vec4 a;
	lowp mat2 b;
	sA c;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp vec3 d;
	mediump mat4 e[5];
	highp ivec3 f;
	highp uint g;
	highp mat3x4 h[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump ivec3 i[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	highp uint j;
	lowp mat3x2 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b, mat2(0.0, 7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(h[0], mat3x4(2.0, -8.0, 5.0, -7.0, 6.0, -9.0, -3.0, 7.0, 0.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_uint((blockE.j), 0u) && allOk;
	allOk = compare_mat3x2(blockE.k[0], mat3x2(-9.0, 7.0, 4.0, -7.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE.k[1], mat3x2(7.0, 9.0, 0.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE.k[2], mat3x2(-2.0, -2.0, 5.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE.k[3], mat3x2(-3.0, -2.0, 9.0, -5.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE.k[4], mat3x2(-4.0, 0.0, -3.0, -1.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(8, 9, -5, 5));
	blockB.b = (mat2(-4.0, -1.0, 2.0, 9.0));
	blockB.c.mA = (-3);
	e[0] = (mat4(4.0, 1.0, -2.0, -8.0, -6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0));
	e[1] = (mat4(9.0, 0.0, -8.0, 6.0, -8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0));
	e[2] = (mat4(-2.0, 8.0, -7.0, 4.0, 0.0, 7.0, 2.0, -4.0, 1.0, 6.0, -2.0, 5.0, 7.0, -9.0, -4.0, 7.0));
	e[3] = (mat4(-9.0, 7.0, 7.0, -8.0, 5.0, -2.0, -3.0, -9.0, 7.0, -4.0, -6.0, 3.0, -7.0, -4.0, 2.0, -4.0));
	e[4] = (mat4(-3.0, 3.0, 2.0, 0.0, 8.0, 8.0, -2.0, -6.0, 7.0, 1.0, 9.0, -1.0, -8.0, 1.0, 0.0, -2.0));
	f = (ivec3(-8, 7, -6));
	g = (7u);
	blockD.i[0] = (ivec3(-1, 3, -2));
	blockD.i[1] = (ivec3(-5, -7, 9));
	blockD.i[2] = (ivec3(-9, 7, -4));
	blockE.j = (6u);
	blockE.k[0] = (mat3x2(-6.0, -2.0, -4.0, -7.0, -5.0, 4.0));
	blockE.k[1] = (mat3x2(-3.0, -2.0, -3.0, 7.0, -6.0, -4.0));
	blockE.k[2] = (mat3x2(-8.0, -4.0, -7.0, -2.0, -8.0, 0.0));
	blockE.k[3] = (mat3x2(6.0, -8.0, -4.0, -6.0, -7.0, 1.0));
	blockE.k[4] = (mat3x2(-2.0, -3.0, 3.0, -3.0, -3.0, -4.0));
}
#version 450
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
	uint16_t mB;
	u16vec2 mC;
	u16vec3 mD;
};
struct sB
{
	i16vec4 mA;
	sA mB;
	f16vec4 mC;
	u16vec4 mD;
};
struct sC
{
	lowp mat4 mA;
	float16_t mB;
};
struct sD
{
	highp vec4 mA;
	lowp mat4 mB;
	lowp float mC;
};
struct sE
{
	sC mA;
	sD mB;
};
layout(std430, row_major, binding = 1) readonly buffer BlockB
{
	float16_t a;
	bvec2 b[8];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	sB c;
	sE d[2];
	u16vec2 e;
	mediump ivec2 f[];
} blockC[1];
layout(std140, row_major, binding = 3) buffer BlockD
{
	u16vec2 g;
	u16vec2 h[1];
	float16_t i;
	lowp ivec4 j;
	highp mat2 k[];
};
layout(std140, binding = 4) buffer BlockE
{
	bvec4 l;
	mediump mat4 m;
	float16_t n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((b[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[6]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[7]), bvec2(false, false)) && allOk;
	allOk = compare_mat4(blockC[0].d[0].mA.mA, mat4(6.0, -3.0, 3.0, -3.0, 8.0, 2.0, -7.0, 8.0, 5.0, 2.0, 7.0, 3.0, 9.0, 3.0, -3.0, -1.0)) && allOk;
	allOk = compare_float16_t(float(blockC[0].d[0].mA.mB), -1.0) && allOk;
	allOk = compare_vec4((blockC[0].d[0].mB.mA), vec4(-4.0, -4.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[0].d[0].mB.mB, mat4(-1.0, -9.0, -3.0, -5.0, 4.0, -9.0, 8.0, -3.0, 5.0, 8.0, 2.0, 3.0, 7.0, 9.0, 7.0, 4.0)) && allOk;
	allOk = compare_float((blockC[0].d[0].mB.mC), -3.0) && allOk;
	allOk = compare_mat4(blockC[0].d[1].mA.mA, mat4(0.0, -5.0, 5.0, -1.0, -6.0, 2.0, -4.0, -4.0, -5.0, -9.0, 4.0, -1.0, -3.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_float16_t(float(blockC[0].d[1].mA.mB), 9.0) && allOk;
	allOk = compare_vec4((blockC[0].d[1].mB.mA), vec4(-5.0, 7.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[0].d[1].mB.mB, mat4(-7.0, 2.0, 9.0, 6.0, 0.0, 3.0, 3.0, -9.0, 2.0, 2.0, 4.0, 2.0, -2.0, 0.0, -4.0, 1.0)) && allOk;
	allOk = compare_float((blockC[0].d[1].mB.mC), 4.0) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e), uvec2(0u, 5u)) && allOk;
	allOk = compare_ivec2((blockC[0].f[0]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((blockC[0].f[1]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((blockC[0].f[2]), ivec2(3, -7)) && allOk;
	allOk = compare_ivec2((blockC[0].f[3]), ivec2(-6, 0)) && allOk;
	allOk = compare_u16vec2(uvec2(g), uvec2(5u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[0]), uvec2(7u, 5u)) && allOk;
	allOk = compare_float16_t(float(i), -7.0) && allOk;
	allOk = compare_ivec4((j), ivec4(6, -9, 8, -6)) && allOk;
	allOk = compare_mat4(m, mat4(3.0, 9.0, -5.0, 2.0, 7.0, -8.0, -6.0, 8.0, -8.0, -4.0, 9.0, -4.0, -8.0, -3.0, -4.0, -7.0)) && allOk;
	allOk = compare_float16_t(float(n), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c.mA = i16vec4(ivec4(9, 0, 6, -5));
	blockC[0].c.mB.mA = (5);
	blockC[0].c.mB.mB = uint16_t(0u);
	blockC[0].c.mB.mC = u16vec2(uvec2(5u, 2u));
	blockC[0].c.mB.mD = u16vec3(uvec3(9u, 4u, 5u));
	blockC[0].c.mC = f16vec4(vec4(-5.0, 4.0, -3.0, -8.0));
	blockC[0].c.mD = u16vec4(uvec4(3u, 6u, 1u, 4u));
	blockC[0].d[0].mA.mA = (mat4(-3.0, -6.0, -9.0, -2.0, 8.0, -9.0, -4.0, -5.0, -6.0, 2.0, 6.0, -5.0, -2.0, 6.0, 0.0, -4.0));
	blockC[0].d[0].mA.mB = float16_t(6.0);
	blockC[0].d[0].mB.mA = (vec4(2.0, 7.0, 8.0, 7.0));
	blockC[0].d[0].mB.mB = (mat4(-6.0, -8.0, 1.0, 6.0, 1.0, 6.0, -9.0, 0.0, -8.0, -7.0, -4.0, 2.0, 1.0, 0.0, 1.0, 3.0));
	blockC[0].d[0].mB.mC = (-5.0);
	blockC[0].d[1].mA.mA = (mat4(-9.0, 9.0, -5.0, 0.0, 7.0, 2.0, 0.0, -5.0, -1.0, 5.0, -4.0, 8.0, -8.0, -2.0, 9.0, -4.0));
	blockC[0].d[1].mA.mB = float16_t(-6.0);
	blockC[0].d[1].mB.mA = (vec4(-6.0, -2.0, 8.0, 6.0));
	blockC[0].d[1].mB.mB = (mat4(6.0, 9.0, -3.0, 1.0, -6.0, -7.0, -1.0, 9.0, -2.0, -1.0, 7.0, -8.0, 4.0, 9.0, -6.0, 6.0));
	blockC[0].d[1].mB.mC = (-2.0);
	blockC[0].e = u16vec2(uvec2(2u, 1u));
	blockC[0].f[0] = (ivec2(7, -9));
	blockC[0].f[1] = (ivec2(9, -8));
	blockC[0].f[2] = (ivec2(6, 3));
	blockC[0].f[3] = (ivec2(-5, -6));
	g = u16vec2(uvec2(3u, 8u));
	h[0] = u16vec2(uvec2(8u, 1u));
	i = float16_t(-9.0);
	j = (ivec4(-7, 0, -7, 8));
	k[0] = (mat2(-5.0, -8.0, -2.0, 5.0));
	k[1] = (mat2(0.0, -3.0, -5.0, -8.0));
	k[2] = (mat2(-2.0, 3.0, -4.0, 3.0));
	k[3] = (mat2(-7.0, -9.0, -1.0, 0.0));
	k[4] = (mat2(-5.0, -4.0, 1.0, 6.0));
	l = (bvec4(true, true, true, true));
	m = (mat4(-8.0, -9.0, 1.0, 9.0, -5.0, -8.0, 9.0, -6.0, 7.0, 6.0, -4.0, 4.0, -7.0, 1.0, -5.0, -2.0));
	n = float16_t(7.0);
}
#version 450
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
	lowp mat3x4 a;
	f16vec2 b;
	highp ivec3 c;
	bvec2 d;
	highp mat4 e[][5];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec2 f;
	mediump mat2 g;
	f16vec2 h;
	u16vec4 i[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(b), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC[0].g, mat2(-9.0, 8.0, 5.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].h), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[0]), uvec4(8u, 7u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[1]), uvec4(8u, 6u, 6u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[2]), uvec4(4u, 2u, 5u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[3]), uvec4(6u, 3u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[4]), uvec4(8u, 8u, 1u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[5]), uvec4(4u, 6u, 1u, 9u)) && allOk;
	allOk = compare_mat2(blockC[1].g, mat2(7.0, -6.0, -4.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].h), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].i[0]), uvec4(4u, 7u, 1u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].i[1]), uvec4(7u, 6u, 8u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = f16vec2(vec2(4.0, 1.0));
	blockC[0].f = (bvec2(true, false));
	blockC[0].i[0] = u16vec4(uvec4(3u, 0u, 8u, 1u));
	blockC[0].i[1] = u16vec4(uvec4(4u, 1u, 6u, 3u));
	blockC[0].i[2] = u16vec4(uvec4(8u, 8u, 4u, 2u));
	blockC[0].i[3] = u16vec4(uvec4(8u, 6u, 2u, 5u));
	blockC[0].i[4] = u16vec4(uvec4(7u, 8u, 4u, 6u));
	blockC[0].i[5] = u16vec4(uvec4(0u, 9u, 8u, 9u));
	blockC[1].f = (bvec2(false, true));
	blockC[1].i[0] = u16vec4(uvec4(0u, 4u, 2u, 1u));
	blockC[1].i[1] = u16vec4(uvec4(2u, 9u, 2u, 0u));
}
#version 450
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
	lowp ivec3 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	f16vec2 a[];
} blockB[2];
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp uvec3 b;
	lowp vec4 c[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp uint d;
	f16vec2 e;
	sA f;
	u16vec2 g;
	float16_t h[];
} blockD[3];
layout(std430, binding = 4) buffer BlockE
{
	i16vec3 i;
	lowp vec2 j;
	highp vec2 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a[0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[1].a[0]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_uvec3((b), uvec3(4u, 2u, 5u)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[0].e), vec2(2.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[1].e), vec2(0.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[2].e), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_vec2((j), vec2(-6.0, 5.0)) && allOk;
	allOk = compare_vec2((k[0]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2((k[1]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((k[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((k[3]), vec2(-2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = f16vec2(vec2(6.0, 3.0));
	blockB[1].a[0] = f16vec2(vec2(-9.0, 0.0));
	b = (uvec3(4u, 6u, 1u));
	c[0] = (vec4(6.0, -6.0, 3.0, 5.0));
	c[1] = (vec4(-8.0, -7.0, -8.0, 3.0));
	c[2] = (vec4(-6.0, -9.0, 9.0, -9.0));
	c[3] = (vec4(9.0, 8.0, -1.0, -4.0));
	c[4] = (vec4(0.0, -4.0, 2.0, 1.0));
	c[5] = (vec4(2.0, 9.0, -3.0, -2.0));
	blockD[0].d = (3u);
	blockD[0].e = f16vec2(vec2(-2.0, 5.0));
	blockD[0].f.mA = (true);
	blockD[0].f.mB = (ivec3(0, 0, 2));
	blockD[0].g = u16vec2(uvec2(3u, 6u));
	blockD[1].d = (2u);
	blockD[1].e = f16vec2(vec2(2.0, -4.0));
	blockD[1].f.mA = (true);
	blockD[1].f.mB = (ivec3(7, -4, -3));
	blockD[1].g = u16vec2(uvec2(1u, 3u));
	blockD[2].d = (7u);
	blockD[2].e = f16vec2(vec2(-8.0, -4.0));
	blockD[2].f.mA = (true);
	blockD[2].f.mB = (ivec3(8, -8, 3));
	blockD[2].g = u16vec2(uvec2(8u, 4u));
	i = i16vec3(ivec3(-1, -7, 2));
	j = (vec2(-7.0, 3.0));
	k[0] = (vec2(-2.0, -4.0));
	k[1] = (vec2(9.0, -4.0));
	k[2] = (vec2(0.0, 5.0));
	k[3] = (vec2(-5.0, 1.0));
}
#version 450
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
	layout(offset = 0) highp int a;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 b;
	layout(offset = 16) i16vec4 c;
};
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) mediump vec3 d;
} blockD[1];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec4 e[1];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((b), bvec4(true, true, false, true)) && allOk;
	allOk = compare_i16vec4(ivec4(c), ivec4(6, -5, -8, 2)) && allOk;
	allOk = compare_vec3((blockD[0].d), vec3(7.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6);
	blockB[1].a = (-2);
	b = (bvec4(false, true, true, true));
	c = i16vec4(ivec4(9, 5, -4, -9));
	blockE[0].e[0] = (bvec4(false, true, false, false));
	blockE[1].e[0] = (bvec4(false, false, true, false));
	blockE[2].e[0] = (bvec4(true, false, true, false));
}
#version 450
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
	layout(offset = 16) u16vec2 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec2 c[1];
	layout(offset = 16) highp uvec3 d;
	layout(offset = 32) f16vec4 e;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bool f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(b), uvec2(9u, 6u)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.e), vec4(4.0, -6.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-1.0, 9.0, 1.0, 3.0));
	b = u16vec2(uvec2(7u, 8u));
	blockC.c[0] = (bvec2(false, false));
	blockC.d = (uvec3(9u, 1u, 9u));
	f = (true);
}
#version 450
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
	float16_t a[1];
	mediump mat4x3 b;
	f16vec3 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].a[0]), 1.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].b, mat4x3(2.0, 2.0, 2.0, -1.0, -3.0, 2.0, -3.0, -9.0, 2.0, -1.0, -3.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(0)].c), vec3(-8.0, 0.0, -6.0)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].a[0]), -5.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].b, mat4x3(-1.0, -3.0, 5.0, 3.0, -3.0, 5.0, -7.0, 1.0, 9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(1)].c), vec3(2.0, 1.0, 3.0)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(2)].a[0]), -3.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].b, mat4x3(2.0, 4.0, 2.0, -1.0, 5.0, -5.0, 7.0, -6.0, 2.0, -9.0, -7.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(2)].c), vec3(-9.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = float16_t(-8.0);
	blockB[nonuniformEXT(0)].c = f16vec3(vec3(4.0, -7.0, 6.0));
	blockB[nonuniformEXT(1)].a[0] = float16_t(-5.0);
	blockB[nonuniformEXT(1)].c = f16vec3(vec3(9.0, 5.0, 6.0));
	blockB[nonuniformEXT(2)].a[0] = float16_t(5.0);
	blockB[nonuniformEXT(2)].c = f16vec3(vec3(-2.0, 4.0, 9.0));
}
#version 450
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
	layout(offset = 16) lowp mat3 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(0)].a), ivec3(0, 7, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(1)].a), ivec3(-1, -9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat3(-5.0, 8.0, -6.0, -1.0, -8.0, -8.0, -6.0, 1.0, -2.0));
	blockB[nonuniformEXT(1)].b = (mat3(-5.0, 8.0, 3.0, -1.0, 7.0, -2.0, -7.0, -4.0, -2.0));
}
#version 450
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
	uint8_t a;
	highp float b;
	bool c;
	lowp uint d[1];
	uint8_t e;
};
layout(std430, binding = 2) buffer BlockC
{
	int8_t f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(a), 8u) && allOk;
	allOk = compare_float((b), 9.0) && allOk;
	allOk = compare_bool((c), true) && allOk;
	allOk = compare_uint((d[0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(e), 7u) && allOk;
	allOk = compare_int8_t(int(f), 4294967290) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint8_t(9u);
	c = (true);
	d[0] = (9u);
	e = uint8_t(6u);
	f = int8_t(4294967292);
}
#version 450
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
	lowp ivec2 a;
	highp uvec3 b;
	highp mat2x3 c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump mat2x3 d[8];
	lowp float e;
	lowp ivec3 f;
	bool g;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	i8vec3 h;
	mediump ivec3 i;
	highp int j;
	mediump uint k[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	uint8_t l;
	highp uvec2 m;
	lowp ivec4 n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(0u, 1u, 6u)) && allOk;
	allOk = compare_mat2x3(c[0], mat2x3(0.0, 9.0, 0.0, -3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(c[1], mat2x3(-3.0, -3.0, 8.0, 2.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2x3(c[2], mat2x3(8.0, -7.0, -9.0, 5.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(c[3], mat2x3(-9.0, 4.0, 7.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(c[4], mat2x3(9.0, -2.0, 6.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2x3(c[5], mat2x3(-8.0, -2.0, -1.0, -7.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(c[6], mat2x3(1.0, -6.0, 0.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(d[0], mat2x3(-8.0, -6.0, 0.0, -3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x3(d[1], mat2x3(0.0, -9.0, -3.0, -4.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(d[2], mat2x3(7.0, 8.0, 7.0, 8.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(d[3], mat2x3(7.0, -7.0, -2.0, -8.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x3(d[4], mat2x3(6.0, -1.0, -2.0, 4.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(d[5], mat2x3(6.0, 5.0, -2.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x3(d[6], mat2x3(-5.0, -3.0, 2.0, 0.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(d[7], mat2x3(5.0, 5.0, 1.0, -9.0, -7.0, 8.0)) && allOk;
	allOk = compare_float((e), 1.0) && allOk;
	allOk = compare_bool((g), true) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.h), ivec3(4, 4294967288, 4294967292)) && allOk;
	allOk = compare_int((blockD.j), -2) && allOk;
	allOk = compare_uint8_t(uint(blockE.l), 3u) && allOk;
	allOk = compare_ivec4((blockE.n[0]), ivec4(-8, -1, 7, -9)) && allOk;
	allOk = compare_ivec4((blockE.n[1]), ivec4(-3, 6, -2, -7)) && allOk;
	allOk = compare_ivec4((blockE.n[2]), ivec4(4, 5, -8, -4)) && allOk;
	allOk = compare_ivec4((blockE.n[3]), ivec4(-4, 2, -8, -3)) && allOk;
	allOk = compare_ivec4((blockE.n[4]), ivec4(-2, 4, 3, 1)) && allOk;
	allOk = compare_ivec4((blockE.n[5]), ivec4(-2, 7, -8, 8)) && allOk;
	allOk = compare_ivec4((blockE.n[6]), ivec4(1, 0, -9, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-7, 4));
	b = (uvec3(2u, 4u, 6u));
	e = (-2.0);
	f = (ivec3(-4, 2, 9));
	g = (true);
	blockD.h = i8vec3(ivec3(6, 4294967292, 4294967291));
	blockD.j = (-4);
	blockD.k[0] = (9u);
	blockE.n[0] = (ivec4(-3, -5, -7, -8));
	blockE.n[1] = (ivec4(-8, 1, 6, 6));
	blockE.n[2] = (ivec4(-6, -4, -7, -9));
	blockE.n[3] = (ivec4(-2, -5, 1, 7));
	blockE.n[4] = (ivec4(0, -3, 5, -2));
	blockE.n[5] = (ivec4(4, -4, 0, -5));
	blockE.n[6] = (ivec4(-5, 1, 3, -8));
}
#version 450
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
	i8vec4 a;
	mediump ivec3 b;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec3 c[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump mat4 d;
	lowp mat3x4 e[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b), ivec3(4, 6, -2)) && allOk;
	allOk = compare_bvec3((blockC.c[0]), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec4(ivec4(8, 7, 4294967294, 6));
	blockC.c[0] = (bvec3(false, false, false));
	blockD.d = (mat4(-1.0, 6.0, 5.0, 8.0, 6.0, 2.0, -7.0, -2.0, -4.0, -2.0, 4.0, -2.0, 3.0, 0.0, -8.0, 6.0));
	blockD.e[0] = (mat3x4(-7.0, 4.0, 6.0, -2.0, -5.0, 3.0, 0.0, 9.0, -2.0, 3.0, -3.0, 3.0));
}
#version 450
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
	mediump mat3 mA[8];
	i8vec4 mB[3];
	bvec3 mC;
};
struct sB
{
	lowp vec3 mA;
	mediump mat4x3 mB;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump uint a;
	lowp mat2x3 b;
	lowp mat2 c;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	sA d;
	mediump vec4 e[];
};
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	highp mat2x3 f[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	u8vec4 g;
	highp ivec2 h;
	highp ivec4 i;
	sB j[][1];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(8.0, 2.0, 0.0, 8.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(6.0, 5.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(d.mA[0], mat3(9.0, -2.0, -9.0, 2.0, 0.0, -9.0, 0.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(d.mA[1], mat3(0.0, -2.0, -5.0, 2.0, 4.0, -7.0, -2.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(d.mA[2], mat3(9.0, 0.0, -5.0, 2.0, 3.0, 8.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(d.mA[3], mat3(1.0, 4.0, -9.0, 2.0, 7.0, -1.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3(d.mA[4], mat3(2.0, 7.0, 3.0, 3.0, 8.0, -4.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(d.mA[5], mat3(4.0, 1.0, -5.0, -5.0, 7.0, 6.0, -9.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3(d.mA[6], mat3(5.0, 1.0, -9.0, -6.0, -5.0, -8.0, -6.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(d.mA[7], mat3(0.0, -1.0, 7.0, 0.0, 1.0, 5.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mB[0]), ivec4(6, 5, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mB[1]), ivec4(4294967295, 4294967294, 9, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(d.mB[2]), ivec4(4294967295, 4294967288, 4294967295, 4294967295)) && allOk;
	allOk = compare_bvec3((d.mC), bvec3(true, true, false)) && allOk;
	allOk = compare_vec4((e[0]), vec4(-6.0, 6.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec4((e[1]), vec4(0.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec4((e[2]), vec4(8.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec4((e[3]), vec4(-2.0, 4.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4((e[4]), vec4(5.0, 7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(f[0], mat2x3(3.0, 2.0, -4.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(f[1], mat2x3(2.0, -1.0, -8.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(f[2], mat2x3(9.0, -7.0, -6.0, 5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x3(f[3], mat2x3(-6.0, 5.0, -4.0, 5.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(f[4], mat2x3(-3.0, 0.0, 8.0, 5.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(f[5], mat2x3(4.0, 4.0, -4.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(f[6], mat2x3(6.0, 9.0, 8.0, 5.0, 7.0, 8.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.g), uvec4(3u, 0u, 1u, 7u)) && allOk;
	allOk = compare_ivec2((blockE.h), ivec2(9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2x3(-7.0, -2.0, -7.0, 3.0, 2.0, 4.0));
	d.mA[0] = (mat3(3.0, -3.0, -1.0, 6.0, 9.0, 5.0, -6.0, -1.0, -2.0));
	d.mA[1] = (mat3(2.0, -3.0, -9.0, -5.0, 3.0, 5.0, -5.0, -2.0, -2.0));
	d.mA[2] = (mat3(8.0, -3.0, -3.0, -8.0, 1.0, -3.0, -1.0, 3.0, 7.0));
	d.mA[3] = (mat3(-4.0, -5.0, -1.0, -3.0, 1.0, -9.0, 8.0, 9.0, -8.0));
	d.mA[4] = (mat3(-8.0, 3.0, -3.0, 0.0, 4.0, 6.0, 1.0, -4.0, 6.0));
	d.mA[5] = (mat3(0.0, -2.0, -1.0, 5.0, 2.0, -7.0, -6.0, -2.0, -6.0));
	d.mA[6] = (mat3(9.0, 9.0, -9.0, 5.0, -3.0, 9.0, -9.0, -7.0, 6.0));
	d.mA[7] = (mat3(9.0, 0.0, 4.0, 5.0, -3.0, 0.0, 5.0, 0.0, 1.0));
	d.mB[0] = i8vec4(ivec4(4294967295, 0, 4294967289, 4294967290));
	d.mB[1] = i8vec4(ivec4(7, 4294967294, 4294967295, 4294967291));
	d.mB[2] = i8vec4(ivec4(4294967290, 4294967290, 2, 5));
	d.mC = (bvec3(false, false, true));
	e[0] = (vec4(3.0, 5.0, 0.0, 3.0));
	e[1] = (vec4(2.0, -8.0, -4.0, -3.0));
	e[2] = (vec4(-7.0, 3.0, 1.0, 6.0));
	e[3] = (vec4(1.0, -9.0, -9.0, 0.0));
	e[4] = (vec4(-8.0, -1.0, -3.0, 8.0));
	blockE.g = u8vec4(uvec4(7u, 1u, 5u, 8u));
	blockE.h = (ivec2(4, -3));
	blockE.j[0][0].mA = (vec3(2.0, -3.0, -7.0));
	blockE.j[0][0].mB = (mat4x3(9.0, -4.0, 2.0, 4.0, -8.0, -8.0, -5.0, 0.0, -4.0, 3.0, 1.0, -5.0));
	blockE.j[1][0].mA = (vec3(1.0, 8.0, 9.0));
	blockE.j[1][0].mB = (mat4x3(-1.0, -5.0, 9.0, 1.0, 3.0, 8.0, 8.0, 8.0, -6.0, -6.0, -4.0, -1.0));
}
#version 450
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
struct sB
{
	bvec3 mA;
	lowp mat4 mB;
	highp ivec4 mC;
	u8vec4 mD[5];
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat2 a;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	i8vec4 b;
	sA c;
	u8vec3 d[];
};
layout(std430, binding = 3) readonly buffer BlockD
{
	i8vec3 e;
	lowp uvec3 f;
	sB g[];
} blockD[3];
layout(std430, row_major, binding = 4) buffer BlockE
{
	u8vec4 h;
	mediump uint i;
	mediump ivec2 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(b), ivec4(5, 5, 5, 4294967291)) && allOk;
	allOk = compare_uvec3((blockD[0].f), uvec3(6u, 8u, 7u)) && allOk;
	allOk = compare_bvec3((blockD[0].g[0].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4(blockD[0].g[0].mB, mat4(7.0, -8.0, -4.0, -3.0, 5.0, 0.0, -2.0, 3.0, 0.0, 8.0, -4.0, -1.0, 6.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockD[0].g[0].mC), ivec4(0, -4, -6, -1)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].g[0].mD[0]), uvec4(4u, 1u, 0u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].g[0].mD[1]), uvec4(1u, 6u, 0u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].g[0].mD[2]), uvec4(6u, 7u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].g[0].mD[3]), uvec4(1u, 0u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].g[0].mD[4]), uvec4(6u, 3u, 2u, 8u)) && allOk;
	allOk = compare_uvec3((blockD[1].f), uvec3(5u, 7u, 3u)) && allOk;
	allOk = compare_bvec3((blockD[1].g[0].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_mat4(blockD[1].g[0].mB, mat4(-9.0, 2.0, 7.0, 3.0, -4.0, -9.0, -3.0, 0.0, 4.0, 9.0, 5.0, 7.0, -3.0, -7.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockD[1].g[0].mC), ivec4(7, 4, 3, 4)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[0].mD[0]), uvec4(1u, 2u, 1u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[0].mD[1]), uvec4(6u, 0u, 3u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[0].mD[2]), uvec4(1u, 8u, 9u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[0].mD[3]), uvec4(9u, 8u, 1u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[0].mD[4]), uvec4(4u, 4u, 6u, 6u)) && allOk;
	allOk = compare_bvec3((blockD[1].g[1].mA), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4(blockD[1].g[1].mB, mat4(-1.0, 7.0, 2.0, 7.0, 7.0, -3.0, -7.0, -7.0, 1.0, -2.0, 2.0, 2.0, -8.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockD[1].g[1].mC), ivec4(-1, -7, -8, 1)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[1].mD[0]), uvec4(3u, 3u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[1].mD[1]), uvec4(8u, 0u, 5u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[1].mD[2]), uvec4(2u, 3u, 0u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[1].mD[3]), uvec4(1u, 8u, 7u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].g[1].mD[4]), uvec4(9u, 1u, 4u, 0u)) && allOk;
	allOk = compare_uvec3((blockD[2].f), uvec3(2u, 9u, 9u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[0].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4(blockD[2].g[0].mB, mat4(-1.0, 4.0, -5.0, 6.0, 7.0, -1.0, -9.0, 6.0, 5.0, 3.0, 2.0, 4.0, -9.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[0].mC), ivec4(3, 8, 7, -9)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[0].mD[0]), uvec4(8u, 2u, 2u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[0].mD[1]), uvec4(6u, 5u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[0].mD[2]), uvec4(8u, 7u, 4u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[0].mD[3]), uvec4(4u, 5u, 7u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[0].mD[4]), uvec4(0u, 6u, 5u, 7u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[1].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4(blockD[2].g[1].mB, mat4(-9.0, 6.0, 5.0, 5.0, -5.0, -6.0, 7.0, -3.0, 8.0, 3.0, -5.0, -4.0, 0.0, 8.0, 7.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[1].mC), ivec4(5, -4, 3, -2)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[1].mD[0]), uvec4(6u, 7u, 0u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[1].mD[1]), uvec4(8u, 3u, 6u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[1].mD[2]), uvec4(9u, 9u, 4u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[1].mD[3]), uvec4(7u, 9u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[1].mD[4]), uvec4(9u, 8u, 6u, 8u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[2].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4(blockD[2].g[2].mB, mat4(1.0, -3.0, -7.0, -4.0, 1.0, -6.0, 9.0, 8.0, 6.0, -2.0, -1.0, -5.0, 7.0, -9.0, 1.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[2].mC), ivec4(1, 5, 1, -6)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[2].mD[0]), uvec4(5u, 9u, 2u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[2].mD[1]), uvec4(4u, 5u, 5u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[2].mD[2]), uvec4(8u, 7u, 4u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[2].mD[3]), uvec4(9u, 1u, 3u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[2].mD[4]), uvec4(8u, 9u, 1u, 3u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[3].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4(blockD[2].g[3].mB, mat4(8.0, 5.0, 1.0, -9.0, 1.0, -5.0, -9.0, 2.0, 7.0, 7.0, 5.0, -5.0, 1.0, 4.0, -2.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[3].mC), ivec4(-4, 9, 2, -6)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[3].mD[0]), uvec4(5u, 1u, 9u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[3].mD[1]), uvec4(2u, 7u, 8u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[3].mD[2]), uvec4(9u, 3u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[3].mD[3]), uvec4(7u, 4u, 6u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[3].mD[4]), uvec4(5u, 6u, 1u, 3u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[4].mA), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4(blockD[2].g[4].mB, mat4(0.0, 4.0, -6.0, -7.0, -6.0, -4.0, -6.0, 0.0, -2.0, 7.0, -4.0, -9.0, 6.0, 8.0, 7.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[4].mC), ivec4(5, 5, 4, 7)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[4].mD[0]), uvec4(9u, 4u, 2u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[4].mD[1]), uvec4(5u, 3u, 9u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[4].mD[2]), uvec4(1u, 2u, 2u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[4].mD[3]), uvec4(1u, 3u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[4].mD[4]), uvec4(5u, 1u, 7u, 8u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[5].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4(blockD[2].g[5].mB, mat4(4.0, 0.0, -3.0, 8.0, -8.0, -5.0, 1.0, 1.0, 9.0, -9.0, -7.0, 1.0, -2.0, 6.0, -1.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[5].mC), ivec4(-4, 9, 4, -1)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[5].mD[0]), uvec4(2u, 9u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[5].mD[1]), uvec4(2u, 2u, 8u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[5].mD[2]), uvec4(3u, 7u, 6u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[5].mD[3]), uvec4(5u, 7u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[5].mD[4]), uvec4(6u, 7u, 8u, 8u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[6].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4(blockD[2].g[6].mB, mat4(-5.0, -2.0, 8.0, 0.0, 6.0, -1.0, -6.0, -6.0, -8.0, 0.0, 2.0, -5.0, 5.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[6].mC), ivec4(6, 4, -5, 7)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[6].mD[0]), uvec4(7u, 7u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[6].mD[1]), uvec4(6u, 7u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[6].mD[2]), uvec4(0u, 7u, 1u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[6].mD[3]), uvec4(2u, 4u, 5u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[6].mD[4]), uvec4(1u, 3u, 6u, 0u)) && allOk;
	allOk = compare_bvec3((blockD[2].g[7].mA), bvec3(true, true, true)) && allOk;
	allOk = compare_mat4(blockD[2].g[7].mB, mat4(0.0, -2.0, -9.0, -1.0, -3.0, -3.0, 1.0, -4.0, -6.0, -6.0, -8.0, -3.0, -2.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockD[2].g[7].mC), ivec4(3, -5, -8, 8)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[7].mD[0]), uvec4(3u, 1u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[7].mD[1]), uvec4(7u, 5u, 4u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[7].mD[2]), uvec4(1u, 6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[7].mD[3]), uvec4(8u, 3u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].g[7].mD[4]), uvec4(3u, 3u, 5u, 8u)) && allOk;
	allOk = compare_uint((blockE.i), 8u) && allOk;
	allOk = compare_ivec2((blockE.j[0]), ivec2(3, -6)) && allOk;
	allOk = compare_ivec2((blockE.j[1]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((blockE.j[2]), ivec2(5, 1)) && allOk;
	allOk = compare_ivec2((blockE.j[3]), ivec2(-1, -4)) && allOk;
	allOk = compare_ivec2((blockE.j[4]), ivec2(4, 8)) && allOk;
	allOk = compare_ivec2((blockE.j[5]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((blockE.j[6]), ivec2(7, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-9.0, -3.0, 8.0, 0.0));
	b = i8vec4(ivec4(4294967293, 9, 4294967291, 2));
	c.mA = u8vec4(uvec4(9u, 4u, 3u, 9u));
	blockE.h = u8vec4(uvec4(3u, 1u, 1u, 0u));
}
#version 450
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
	bvec2 mB;
	lowp uint mC;
};
struct sB
{
	uint8_t mA;
	bvec2 mB;
	sA mC;
	mediump mat2 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	uint8_t a;
	u8vec4 b;
	i8vec3 c;
	mediump uint d[];
} blockB[1];
layout(std140, column_major, binding = 2) buffer BlockC
{
	sB e;
	highp int f[1];
	u8vec3 g;
	lowp mat4x3 h[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	uint8_t i;
	lowp mat4 j;
	mediump mat3x2 k;
	bvec4 l;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[0].a), 1u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b), uvec4(9u, 8u, 5u, 3u)) && allOk;
	allOk = compare_int((blockC.f[0]), 1) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g), uvec3(4u, 8u, 8u)) && allOk;
	allOk = compare_bvec4((blockD.l), bvec4(true, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = uint8_t(5u);
	blockB[0].b = u8vec4(uvec4(2u, 5u, 7u, 0u));
	blockB[0].c = i8vec3(ivec3(4294967291, 0, 0));
	blockC.e.mA = uint8_t(3u);
	blockC.e.mB = (bvec2(true, false));
	blockC.e.mC.mA = u8vec4(uvec4(3u, 1u, 2u, 9u));
	blockC.e.mC.mB = (bvec2(false, false));
	blockC.e.mC.mC = (7u);
	blockC.e.mD = (mat2(-5.0, 7.0, -9.0, -5.0));
	blockC.f[0] = (5);
	blockD.j = (mat4(-7.0, 2.0, 5.0, 9.0, 3.0, -4.0, 6.0, 4.0, 5.0, 5.0, 6.0, 8.0, 1.0, -8.0, 3.0, -9.0));
	blockD.l = (bvec4(true, true, true, false));
}
#version 450
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
	allOk = compare_mat4(var, mat4(3.0, -4.0, 1.0, -6.0, 0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-3.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-2.0, -3.0, -4.0, 2.0, 7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], 6.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(8.0, -8.0, -9.0, -5.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat2(var, mat2(4.0, -2.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-9.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-4.0, 8.0, -4.0, -3.0, -1.0, -9.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec4 var[3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2]), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-7.0, 8.0, 7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-2.0, 1.0, -7.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(7.0, 2.0, -2.0, -3.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
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

layout(std140, buffer_reference) buffer Block
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

layout(std140, column_major, buffer_reference) buffer Block
{
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
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(7.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-7.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(6.0, -1.0, 9.0));
	block.var[1] = (vec3(-9.0, -2.0, -3.0));
	block.var[2] = (vec3(6.0, 6.0, -4.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block.var, mat4(1.0, -7.0, -7.0, -8.0, -2.0, 6.0, -6.0, 5.0, -8.0, -5.0, -8.0, -4.0, 4.0, -4.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-9.0, 1.0, 7.0, 9.0, -7.0, 2.0, -9.0, -7.0, 1.0, 9.0, 5.0, 4.0, -3.0, 0.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(1.0, -7.0, -7.0, -5.0, -4.0, 7.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(6.0, -2.0, -6.0, -3.0));
	block.var[1] = (vec4(1.0, -2.0, -4.0, 2.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
{
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
	allOk = compare_mat3(block.var, mat3(6.0, -1.0, 3.0, 8.0, -4.0, 9.0, 0.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-6.0, -9.0, 5.0));
	block.var[1] = (vec3(8.0, -2.0, 3.0));
	block.var[2] = (vec3(2.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(1.0, -7.0, -7.0, -5.0, -4.0, 7.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(6.0, -2.0, -6.0, -3.0));
	block.var[1] = (vec4(1.0, -2.0, -4.0, 2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(0.0, -4.0, 4.0, -5.0, 1.0, 9.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	int padding;
	lowp ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -7) && allOk;
	allOk = compare_ivec4((block.var), ivec4(7, 7, -6, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2);
	block.var = (ivec4(0, -7, -6, 1));
}
#version 450
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
	bvec4 var;
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
	allOk = compare_bvec4((block.var), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var = (bvec4(true, true, false, true));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3(block.var, mat3(-4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var = (mat3(6.0, 1.0, 6.0, -7.0, -8.0, -7.0, -6.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat3(block.var, mat3(5.0, 1.0, 7.0, 4.0, -7.0, -4.0, 8.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat3(7.0, 7.0, -3.0, -9.0, 7.0, 9.0, -5.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3(block.var, mat3(1.0, -6.0, 5.0, 1.0, 0.0, -8.0, -1.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (vec3(-4.0, 0.0, 5.0));
	block.var[1] = (vec3(5.0, 5.0, -8.0));
	block.var[2] = (vec3(-1.0, 4.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-8.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-9.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var = (mat2x3(-2.0, -7.0, 8.0, -4.0, 9.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][0], 0.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], -1.0) && allOk;
	allOk = compare_float(block.var[3][1], -7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat4x2(4.0, -1.0, 9.0, -3.0, 8.0, 3.0, 2.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	u8vec3 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[2] = u8vec3(uvec3(7u, 1u, 5u));
}
#version 450
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
	int8_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[2]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int8_t(4294967290);
	block.var[1] = int8_t(4294967294);
	block.var[2] = int8_t(3);
}
#version 450
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
	int8_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[2]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[3]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[4]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[5]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[6]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[7]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[8]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[9]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[10]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[11]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[12]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[13]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[14]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[15]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[16]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[17]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[18]), 4294967291) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int8_t(4294967290);
	block.var[1] = int8_t(4294967294);
	block.var[2] = int8_t(3);
	block.var[3] = int8_t(4294967288);
	block.var[4] = int8_t(1);
	block.var[5] = int8_t(2);
	block.var[6] = int8_t(4294967288);
	block.var[7] = int8_t(4294967294);
	block.var[8] = int8_t(7);
	block.var[9] = int8_t(9);
	block.var[10] = int8_t(0);
	block.var[11] = int8_t(4294967292);
	block.var[12] = int8_t(0);
	block.var[13] = int8_t(4294967289);
	block.var[14] = int8_t(1);
	block.var[15] = int8_t(7);
	block.var[16] = int8_t(4294967287);
	block.var[17] = int8_t(4294967289);
	block.var[18] = int8_t(6);
}
#version 450
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
	bvec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[7]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[8]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[9]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[10]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[11]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[12]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[13]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[14]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[15]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[16]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[17]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[18]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec2(true, false));
	block.var[1] = (bvec2(true, true));
	block.var[2] = (bvec2(false, false));
	block.var[3] = (bvec2(false, false));
	block.var[4] = (bvec2(false, true));
	block.var[5] = (bvec2(true, true));
	block.var[6] = (bvec2(false, false));
	block.var[7] = (bvec2(false, true));
	block.var[8] = (bvec2(true, true));
	block.var[9] = (bvec2(false, false));
	block.var[10] = (bvec2(true, false));
	block.var[11] = (bvec2(true, false));
	block.var[12] = (bvec2(false, true));
	block.var[13] = (bvec2(true, true));
	block.var[14] = (bvec2(false, false));
	block.var[15] = (bvec2(true, true));
	block.var[16] = (bvec2(true, false));
	block.var[17] = (bvec2(false, false));
	block.var[18] = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	block.var[3] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	block.var[4] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	block.var[5] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	block.var[6] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	block.var[7] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	block.var[8] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	block.var[9] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	block.var[10] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	block.var[11] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	block.var[12] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	block.var[13] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	block.var[14] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	block.var[15] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	block.var[16] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	block.var[17] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	block.var[18] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block.var[0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block.var[0][2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	block.var[1][0] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	block.var[1][1] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	block.var[1][2] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	block.var[2][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	block.var[2][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	block.var[2][2] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	block.var[3][0] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	block.var[3][1] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	block.var[3][2] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[0][2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	block.var[1][0] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	block.var[1][1] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	block.var[1][2] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	block.var[2][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	block.var[2][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	block.var[2][2] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	block.var[3][0] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	block.var[3][1] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	block.var[3][2] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
}
#version 450
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
	f16vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[1][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[1][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[1][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[2][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[2][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[2][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[3][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[3][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[3][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(7.0, -5.0, -9.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(8.0, 9.0, 2.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-5.0, -8.0, 2.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(8.0, -5.0, 6.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(2.0, 2.0, -8.0, 3.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-7.0, 0.0, 7.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-8.0, 7.0, -3.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-4.0, 6.0, 2.0, 0.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-2.0, 0.0, 8.0, -6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(5.0, -9.0, -6.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(4.0, -7.0, 6.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(0.0, 3.0, -9.0, -9.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][0][1] = (vec3(-1.0, 1.0, -5.0));
	block.var[0][1][0] = (vec3(3.0, -3.0, 7.0));
	block.var[0][1][1] = (vec3(6.0, 6.0, -9.0));
	block.var[0][2][0] = (vec3(7.0, 0.0, -8.0));
	block.var[0][2][1] = (vec3(-2.0, -7.0, 0.0));
	block.var[1][0][0] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][0][1] = (vec3(-5.0, 5.0, -3.0));
	block.var[1][1][0] = (vec3(-3.0, -1.0, -9.0));
	block.var[1][1][1] = (vec3(-4.0, 7.0, 2.0));
	block.var[1][2][0] = (vec3(-4.0, 8.0, 2.0));
	block.var[1][2][1] = (vec3(-3.0, 6.0, 6.0));
	block.var[2][0][0] = (vec3(3.0, 4.0, -6.0));
	block.var[2][0][1] = (vec3(-2.0, 0.0, 3.0));
	block.var[2][1][0] = (vec3(4.0, -8.0, 0.0));
	block.var[2][1][1] = (vec3(-6.0, 2.0, -3.0));
	block.var[2][2][0] = (vec3(-6.0, -8.0, 8.0));
	block.var[2][2][1] = (vec3(3.0, 5.0, 4.0));
	block.var[3][0][0] = (vec3(-6.0, 7.0, -3.0));
	block.var[3][0][1] = (vec3(-9.0, -1.0, 2.0));
	block.var[3][1][0] = (vec3(-3.0, -5.0, 9.0));
	block.var[3][1][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[3][2][0] = (vec3(2.0, 0.0, 5.0));
	block.var[3][2][1] = (vec3(-1.0, 7.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0] = (vec3(-6.0, 6.0, 1.0));
	block.var[0][0][1] = (vec3(-4.0, -3.0, -3.0));
	block.var[0][0][2] = (vec3(3.0, -2.0, -7.0));
	block.var[0][0][3] = (vec3(1.0, -5.0, -1.0));
	block.var[0][1][0] = (vec3(-5.0, 7.0, 1.0));
	block.var[0][1][1] = (vec3(-2.0, -4.0, -4.0));
	block.var[0][1][2] = (vec3(-6.0, 5.0, -2.0));
	block.var[0][1][3] = (vec3(6.0, -9.0, 5.0));
	block.var[0][2][0] = (vec3(-5.0, 7.0, -4.0));
	block.var[0][2][1] = (vec3(8.0, -3.0, -2.0));
	block.var[0][2][2] = (vec3(0.0, 8.0, -2.0));
	block.var[0][2][3] = (vec3(6.0, -3.0, -9.0));
	block.var[1][0][0] = (vec3(-2.0, -2.0, 7.0));
	block.var[1][0][1] = (vec3(9.0, -4.0, 3.0));
	block.var[1][0][2] = (vec3(1.0, 0.0, -9.0));
	block.var[1][0][3] = (vec3(-2.0, -7.0, -5.0));
	block.var[1][1][0] = (vec3(-6.0, 5.0, -2.0));
	block.var[1][1][1] = (vec3(-7.0, 5.0, -2.0));
	block.var[1][1][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[1][1][3] = (vec3(5.0, -9.0, -3.0));
	block.var[1][2][0] = (vec3(3.0, 7.0, 3.0));
	block.var[1][2][1] = (vec3(-4.0, -8.0, -2.0));
	block.var[1][2][2] = (vec3(2.0, -1.0, 1.0));
	block.var[1][2][3] = (vec3(-9.0, 9.0, -7.0));
	block.var[2][0][0] = (vec3(-7.0, -7.0, 6.0));
	block.var[2][0][1] = (vec3(-9.0, 3.0, -5.0));
	block.var[2][0][2] = (vec3(2.0, 4.0, -2.0));
	block.var[2][0][3] = (vec3(-4.0, -6.0, -1.0));
	block.var[2][1][0] = (vec3(5.0, 5.0, -9.0));
	block.var[2][1][1] = (vec3(-3.0, -9.0, 3.0));
	block.var[2][1][2] = (vec3(2.0, 0.0, 0.0));
	block.var[2][1][3] = (vec3(-9.0, 7.0, 5.0));
	block.var[2][2][0] = (vec3(-5.0, -2.0, 6.0));
	block.var[2][2][1] = (vec3(5.0, -4.0, -2.0));
	block.var[2][2][2] = (vec3(9.0, -3.0, 2.0));
	block.var[2][2][3] = (vec3(5.0, -4.0, 6.0));
	block.var[3][0][0] = (vec3(4.0, 7.0, 1.0));
	block.var[3][0][1] = (vec3(-4.0, -6.0, 4.0));
	block.var[3][0][2] = (vec3(-6.0, -5.0, 5.0));
	block.var[3][0][3] = (vec3(6.0, -1.0, 6.0));
	block.var[3][1][0] = (vec3(3.0, -9.0, -7.0));
	block.var[3][1][1] = (vec3(3.0, -4.0, 1.0));
	block.var[3][1][2] = (vec3(2.0, 6.0, -2.0));
	block.var[3][1][3] = (vec3(3.0, 7.0, -5.0));
	block.var[3][2][0] = (vec3(8.0, -9.0, -4.0));
	block.var[3][2][1] = (vec3(-1.0, -9.0, 5.0));
	block.var[3][2][2] = (vec3(5.0, 6.0, -8.0));
	block.var[3][2][3] = (vec3(1.0, -7.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(2.0, 4.0, -4.0, 9.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(5.0, -9.0, -2.0, 8.0, 7.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(8.0, -9.0, -2.0, -7.0, 6.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(4.0, -2.0, -9.0, 4.0, 9.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(6.0, 9.0, 2.0, 5.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[0][0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[0][0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[0][1][0] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	block.var[0][1][1] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	block.var[0][1][2] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	block.var[1][0][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[1][0][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[1][0][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[1][1][0] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	block.var[1][1][1] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	block.var[1][1][2] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	block.var[2][0][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[2][0][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[2][0][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[2][1][0] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
	block.var[2][1][1] = (mat4x2(1.0, 9.0, -4.0, -5.0, 1.0, -2.0, 7.0, 1.0));
	block.var[2][1][2] = (mat4x2(-3.0, -1.0, 4.0, 9.0, 6.0, 3.0, -9.0, 2.0));
	block.var[3][0][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[3][0][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[3][0][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	block.var[3][1][0] = (mat4x2(-3.0, 9.0, 7.0, -5.0, -4.0, 0.0, -9.0, 9.0));
	block.var[3][1][1] = (mat4x2(6.0, 8.0, -4.0, -2.0, -7.0, -7.0, -4.0, 9.0));
	block.var[3][1][2] = (mat4x2(6.0, 7.0, -4.0, 6.0, -5.0, -4.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(1.0, -8.0, 8.0, 4.0, 5.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(0.0, 8.0, 4.0, 8.0, -5.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-5.0, 9.0, -7.0, 7.0, 1.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(8.0, 0.0, -5.0, 3.0, 2.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(0.0, -5.0, -5.0, 9.0, -4.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[0][0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][0][2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[0][0][2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[0][1][0][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	block.var[0][1][0][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	block.var[0][1][1][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	block.var[0][1][1][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	block.var[0][1][2][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	block.var[0][1][2][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	block.var[1][0][0][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	block.var[1][0][0][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][0][1][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	block.var[1][0][1][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[1][0][2][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	block.var[1][0][2][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[1][1][0][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	block.var[1][1][0][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	block.var[1][1][1][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	block.var[1][1][1][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	block.var[1][1][2][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	block.var[1][1][2][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	block.var[2][0][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	block.var[2][0][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[2][0][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	block.var[2][0][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[2][0][2][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	block.var[2][0][2][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[2][1][0][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	block.var[2][1][0][1] = (vec4(8.0, -6.0, 8.0, -7.0));
	block.var[2][1][1][0] = (vec4(8.0, 0.0, 1.0, -6.0));
	block.var[2][1][1][1] = (vec4(0.0, 1.0, 1.0, -9.0));
	block.var[2][1][2][0] = (vec4(-6.0, 9.0, 2.0, -5.0));
	block.var[2][1][2][1] = (vec4(-7.0, -6.0, 3.0, -2.0));
	block.var[3][0][0][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	block.var[3][0][0][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[3][0][1][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	block.var[3][0][1][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[3][0][2][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	block.var[3][0][2][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	block.var[3][1][0][0] = (vec4(1.0, -8.0, 4.0, -7.0));
	block.var[3][1][0][1] = (vec4(-3.0, 9.0, 4.0, -6.0));
	block.var[3][1][1][0] = (vec4(-7.0, -3.0, 9.0, -8.0));
	block.var[3][1][1][1] = (vec4(1.0, -6.0, 7.0, 1.0));
	block.var[3][1][2][0] = (vec4(5.0, -9.0, 3.0, -2.0));
	block.var[3][1][2][1] = (vec4(-1.0, 1.0, -7.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-3.0, 6.0, 4.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, -9.0, -7.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-3.0, 9.0, 2.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-3.0, 1.0, 6.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(2.0, -2.0, -9.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[0][0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[0][0][2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[0][1][0] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	block.var[0][1][1] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	block.var[0][1][2] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	block.var[1][0][0] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[1][0][1] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[1][0][2] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[1][1][0] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	block.var[1][1][1] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	block.var[1][1][2] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	block.var[2][0][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[2][0][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[2][0][2] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[2][1][0] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
	block.var[2][1][1] = (mat3x2(-4.0, 1.0, -6.0, -5.0, -1.0, 0.0));
	block.var[2][1][2] = (mat3x2(-7.0, -3.0, -5.0, -9.0, 7.0, -3.0));
	block.var[3][0][0] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[3][0][1] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[3][0][2] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	block.var[3][1][0] = (mat3x2(4.0, 1.0, 0.0, 2.0, -6.0, -1.0));
	block.var[3][1][1] = (mat3x2(-4.0, 4.0, 0.0, -1.0, -4.0, -4.0));
	block.var[3][1][2] = (mat3x2(-2.0, 9.0, 8.0, 9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-8.0, -4.0));
	block.var[0][0][0][1] = (vec2(-3.0, 5.0));
	block.var[0][0][0][2] = (vec2(-9.0, 4.0));
	block.var[0][0][1][0] = (vec2(-2.0, -1.0));
	block.var[0][0][1][1] = (vec2(8.0, 3.0));
	block.var[0][0][1][2] = (vec2(7.0, 2.0));
	block.var[0][0][2][0] = (vec2(-4.0, 4.0));
	block.var[0][0][2][1] = (vec2(3.0, -6.0));
	block.var[0][0][2][2] = (vec2(-4.0, 3.0));
	block.var[0][1][0][0] = (vec2(2.0, 6.0));
	block.var[0][1][0][1] = (vec2(6.0, 1.0));
	block.var[0][1][0][2] = (vec2(4.0, -8.0));
	block.var[0][1][1][0] = (vec2(2.0, -5.0));
	block.var[0][1][1][1] = (vec2(-5.0, 5.0));
	block.var[0][1][1][2] = (vec2(2.0, -1.0));
	block.var[0][1][2][0] = (vec2(-9.0, 3.0));
	block.var[0][1][2][1] = (vec2(6.0, 5.0));
	block.var[0][1][2][2] = (vec2(-1.0, -8.0));
	block.var[1][0][0][0] = (vec2(4.0, 6.0));
	block.var[1][0][0][1] = (vec2(3.0, 6.0));
	block.var[1][0][0][2] = (vec2(-2.0, -9.0));
	block.var[1][0][1][0] = (vec2(-9.0, 0.0));
	block.var[1][0][1][1] = (vec2(-4.0, 9.0));
	block.var[1][0][1][2] = (vec2(-1.0, -1.0));
	block.var[1][0][2][0] = (vec2(-8.0, 6.0));
	block.var[1][0][2][1] = (vec2(5.0, -2.0));
	block.var[1][0][2][2] = (vec2(1.0, 4.0));
	block.var[1][1][0][0] = (vec2(2.0, -1.0));
	block.var[1][1][0][1] = (vec2(0.0, -2.0));
	block.var[1][1][0][2] = (vec2(-4.0, 6.0));
	block.var[1][1][1][0] = (vec2(2.0, -3.0));
	block.var[1][1][1][1] = (vec2(-2.0, 1.0));
	block.var[1][1][1][2] = (vec2(-3.0, 8.0));
	block.var[1][1][2][0] = (vec2(5.0, -1.0));
	block.var[1][1][2][1] = (vec2(-4.0, -4.0));
	block.var[1][1][2][2] = (vec2(7.0, -6.0));
	block.var[2][0][0][0] = (vec2(2.0, -5.0));
	block.var[2][0][0][1] = (vec2(-5.0, -9.0));
	block.var[2][0][0][2] = (vec2(-7.0, 3.0));
	block.var[2][0][1][0] = (vec2(-1.0, 0.0));
	block.var[2][0][1][1] = (vec2(-1.0, 4.0));
	block.var[2][0][1][2] = (vec2(-1.0, -6.0));
	block.var[2][0][2][0] = (vec2(-8.0, -6.0));
	block.var[2][0][2][1] = (vec2(8.0, 7.0));
	block.var[2][0][2][2] = (vec2(4.0, -9.0));
	block.var[2][1][0][0] = (vec2(-2.0, -8.0));
	block.var[2][1][0][1] = (vec2(0.0, -2.0));
	block.var[2][1][0][2] = (vec2(8.0, -2.0));
	block.var[2][1][1][0] = (vec2(3.0, 7.0));
	block.var[2][1][1][1] = (vec2(-9.0, -1.0));
	block.var[2][1][1][2] = (vec2(5.0, 7.0));
	block.var[2][1][2][0] = (vec2(-5.0, 7.0));
	block.var[2][1][2][1] = (vec2(6.0, 2.0));
	block.var[2][1][2][2] = (vec2(-4.0, -3.0));
	block.var[3][0][0][0] = (vec2(-4.0, -1.0));
	block.var[3][0][0][1] = (vec2(-3.0, -2.0));
	block.var[3][0][0][2] = (vec2(-5.0, -2.0));
	block.var[3][0][1][0] = (vec2(-7.0, -3.0));
	block.var[3][0][1][1] = (vec2(5.0, 4.0));
	block.var[3][0][1][2] = (vec2(4.0, 1.0));
	block.var[3][0][2][0] = (vec2(-3.0, -6.0));
	block.var[3][0][2][1] = (vec2(-4.0, -2.0));
	block.var[3][0][2][2] = (vec2(-5.0, -7.0));
	block.var[3][1][0][0] = (vec2(-5.0, 2.0));
	block.var[3][1][0][1] = (vec2(-7.0, 8.0));
	block.var[3][1][0][2] = (vec2(-6.0, 3.0));
	block.var[3][1][1][0] = (vec2(-3.0, -4.0));
	block.var[3][1][1][1] = (vec2(-5.0, -9.0));
	block.var[3][1][1][2] = (vec2(-8.0, -7.0));
	block.var[3][1][2][0] = (vec2(8.0, -8.0));
	block.var[3][1][2][1] = (vec2(-2.0, 7.0));
	block.var[3][1][2][2] = (vec2(5.0, -5.0));
}
#version 450
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
	highp uvec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var[0][0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][2][0]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[0][2][1]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][3][0]), uvec4(9u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[0][3][1]), uvec4(5u, 5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][0]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][1]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][0]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][1]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][2][0]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][2][1]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[1][3][0]), uvec4(1u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[1][3][1]), uvec4(8u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][0]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][1]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][0]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][1]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[2][2][0]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[2][2][1]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[2][3][0]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[2][3][1]), uvec4(2u, 3u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[0][0][1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[0][1][0] = (uvec4(4u, 9u, 1u, 3u));
	block.var[0][1][1] = (uvec4(8u, 8u, 8u, 1u));
	block.var[0][2][0] = (uvec4(6u, 1u, 9u, 4u));
	block.var[0][2][1] = (uvec4(5u, 7u, 7u, 0u));
	block.var[0][3][0] = (uvec4(2u, 0u, 0u, 4u));
	block.var[0][3][1] = (uvec4(4u, 2u, 5u, 9u));
	block.var[1][0][0] = (uvec4(3u, 4u, 4u, 2u));
	block.var[1][0][1] = (uvec4(0u, 5u, 6u, 2u));
	block.var[1][1][0] = (uvec4(7u, 5u, 4u, 8u));
	block.var[1][1][1] = (uvec4(6u, 6u, 0u, 9u));
	block.var[1][2][0] = (uvec4(2u, 5u, 1u, 3u));
	block.var[1][2][1] = (uvec4(9u, 6u, 1u, 2u));
	block.var[1][3][0] = (uvec4(6u, 9u, 6u, 2u));
	block.var[1][3][1] = (uvec4(3u, 6u, 1u, 7u));
	block.var[2][0][0] = (uvec4(9u, 5u, 7u, 7u));
	block.var[2][0][1] = (uvec4(0u, 3u, 8u, 1u));
	block.var[2][1][0] = (uvec4(7u, 2u, 3u, 0u));
	block.var[2][1][1] = (uvec4(4u, 4u, 8u, 5u));
	block.var[2][2][0] = (uvec4(0u, 0u, 8u, 4u));
	block.var[2][2][1] = (uvec4(9u, 5u, 7u, 1u));
	block.var[2][3][0] = (uvec4(5u, 6u, 4u, 8u));
	block.var[2][3][1] = (uvec4(6u, 3u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[0][1][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[0][1][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[0][2][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[0][2][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[0][3][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	block.var[0][3][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	block.var[1][0][0] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[1][0][1] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[1][1][0] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[1][1][1] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[1][2][0] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[1][2][1] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[1][3][0] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	block.var[1][3][1] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	block.var[2][0][0] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[2][0][1] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[2][1][0] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[2][1][1] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[2][2][0] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[2][2][1] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[2][3][0] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	block.var[2][3][1] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][1][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[0][1][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[0][1][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[0][1][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[0][1][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[0][1][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[0][2][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	block.var[0][2][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	block.var[0][2][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	block.var[0][2][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	block.var[0][2][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	block.var[0][2][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	block.var[0][3][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	block.var[0][3][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	block.var[0][3][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	block.var[0][3][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	block.var[0][3][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	block.var[0][3][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	block.var[1][0][0][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[1][0][0][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[1][0][0][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[1][0][1][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[1][0][1][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][1][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][1][0][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[1][1][0][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[1][1][0][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[1][1][1][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[1][1][1][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[1][1][1][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[1][2][0][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	block.var[1][2][0][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	block.var[1][2][0][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	block.var[1][2][1][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	block.var[1][2][1][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	block.var[1][2][1][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	block.var[1][3][0][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	block.var[1][3][0][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	block.var[1][3][0][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	block.var[1][3][1][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	block.var[1][3][1][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	block.var[1][3][1][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	block.var[2][0][0][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[2][0][0][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[2][0][0][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[2][0][1][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[2][0][1][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[2][0][1][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[2][1][0][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[2][1][0][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[2][1][0][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[2][1][1][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[2][1][1][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[2][1][1][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[2][2][0][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	block.var[2][2][0][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	block.var[2][2][0][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	block.var[2][2][1][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	block.var[2][2][1][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	block.var[2][2][1][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	block.var[2][3][0][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	block.var[2][3][0][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	block.var[2][3][0][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	block.var[2][3][1][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	block.var[2][3][1][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	block.var[2][3][1][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(2.0, -4.0));
	block.var[0][0][0][1] = (vec2(-5.0, 3.0));
	block.var[0][0][0][2] = (vec2(7.0, 1.0));
	block.var[0][0][0][3] = (vec2(8.0, -5.0));
	block.var[0][0][1][0] = (vec2(7.0, -3.0));
	block.var[0][0][1][1] = (vec2(1.0, -6.0));
	block.var[0][0][1][2] = (vec2(9.0, -3.0));
	block.var[0][0][1][3] = (vec2(1.0, -5.0));
	block.var[0][1][0][0] = (vec2(3.0, -4.0));
	block.var[0][1][0][1] = (vec2(2.0, -3.0));
	block.var[0][1][0][2] = (vec2(6.0, 5.0));
	block.var[0][1][0][3] = (vec2(0.0, -2.0));
	block.var[0][1][1][0] = (vec2(-3.0, -2.0));
	block.var[0][1][1][1] = (vec2(-7.0, 3.0));
	block.var[0][1][1][2] = (vec2(-6.0, 2.0));
	block.var[0][1][1][3] = (vec2(9.0, 6.0));
	block.var[0][2][0][0] = (vec2(4.0, 2.0));
	block.var[0][2][0][1] = (vec2(-4.0, 1.0));
	block.var[0][2][0][2] = (vec2(5.0, -7.0));
	block.var[0][2][0][3] = (vec2(5.0, 5.0));
	block.var[0][2][1][0] = (vec2(-5.0, 1.0));
	block.var[0][2][1][1] = (vec2(-7.0, -3.0));
	block.var[0][2][1][2] = (vec2(-1.0, 1.0));
	block.var[0][2][1][3] = (vec2(4.0, 7.0));
	block.var[0][3][0][0] = (vec2(-8.0, -5.0));
	block.var[0][3][0][1] = (vec2(8.0, -8.0));
	block.var[0][3][0][2] = (vec2(7.0, -2.0));
	block.var[0][3][0][3] = (vec2(-7.0, -7.0));
	block.var[0][3][1][0] = (vec2(6.0, -1.0));
	block.var[0][3][1][1] = (vec2(0.0, -4.0));
	block.var[0][3][1][2] = (vec2(-5.0, -3.0));
	block.var[0][3][1][3] = (vec2(-7.0, -5.0));
	block.var[1][0][0][0] = (vec2(-8.0, 4.0));
	block.var[1][0][0][1] = (vec2(5.0, -9.0));
	block.var[1][0][0][2] = (vec2(1.0, -5.0));
	block.var[1][0][0][3] = (vec2(-4.0, -2.0));
	block.var[1][0][1][0] = (vec2(6.0, -1.0));
	block.var[1][0][1][1] = (vec2(-7.0, -5.0));
	block.var[1][0][1][2] = (vec2(-2.0, -8.0));
	block.var[1][0][1][3] = (vec2(1.0, 3.0));
	block.var[1][1][0][0] = (vec2(-4.0, 4.0));
	block.var[1][1][0][1] = (vec2(0.0, -3.0));
	block.var[1][1][0][2] = (vec2(-7.0, 0.0));
	block.var[1][1][0][3] = (vec2(-9.0, 1.0));
	block.var[1][1][1][0] = (vec2(7.0, 2.0));
	block.var[1][1][1][1] = (vec2(1.0, 9.0));
	block.var[1][1][1][2] = (vec2(-3.0, 3.0));
	block.var[1][1][1][3] = (vec2(-7.0, 9.0));
	block.var[1][2][0][0] = (vec2(-9.0, 1.0));
	block.var[1][2][0][1] = (vec2(-6.0, 7.0));
	block.var[1][2][0][2] = (vec2(8.0, -7.0));
	block.var[1][2][0][3] = (vec2(2.0, 1.0));
	block.var[1][2][1][0] = (vec2(-7.0, 4.0));
	block.var[1][2][1][1] = (vec2(-4.0, 4.0));
	block.var[1][2][1][2] = (vec2(0.0, 7.0));
	block.var[1][2][1][3] = (vec2(7.0, -1.0));
	block.var[1][3][0][0] = (vec2(-7.0, -7.0));
	block.var[1][3][0][1] = (vec2(-6.0, -7.0));
	block.var[1][3][0][2] = (vec2(3.0, 1.0));
	block.var[1][3][0][3] = (vec2(9.0, -1.0));
	block.var[1][3][1][0] = (vec2(-5.0, 4.0));
	block.var[1][3][1][1] = (vec2(6.0, 6.0));
	block.var[1][3][1][2] = (vec2(-4.0, -7.0));
	block.var[1][3][1][3] = (vec2(1.0, -7.0));
	block.var[2][0][0][0] = (vec2(4.0, 2.0));
	block.var[2][0][0][1] = (vec2(-9.0, 2.0));
	block.var[2][0][0][2] = (vec2(-3.0, 3.0));
	block.var[2][0][0][3] = (vec2(0.0, 1.0));
	block.var[2][0][1][0] = (vec2(-5.0, -9.0));
	block.var[2][0][1][1] = (vec2(2.0, -2.0));
	block.var[2][0][1][2] = (vec2(-3.0, 0.0));
	block.var[2][0][1][3] = (vec2(9.0, 6.0));
	block.var[2][1][0][0] = (vec2(-4.0, -1.0));
	block.var[2][1][0][1] = (vec2(3.0, 6.0));
	block.var[2][1][0][2] = (vec2(8.0, 3.0));
	block.var[2][1][0][3] = (vec2(1.0, 5.0));
	block.var[2][1][1][0] = (vec2(7.0, 0.0));
	block.var[2][1][1][1] = (vec2(0.0, -2.0));
	block.var[2][1][1][2] = (vec2(3.0, -7.0));
	block.var[2][1][1][3] = (vec2(-3.0, 1.0));
	block.var[2][2][0][0] = (vec2(0.0, -2.0));
	block.var[2][2][0][1] = (vec2(-8.0, 2.0));
	block.var[2][2][0][2] = (vec2(8.0, -1.0));
	block.var[2][2][0][3] = (vec2(5.0, 2.0));
	block.var[2][2][1][0] = (vec2(4.0, 1.0));
	block.var[2][2][1][1] = (vec2(-6.0, 7.0));
	block.var[2][2][1][2] = (vec2(-7.0, 1.0));
	block.var[2][2][1][3] = (vec2(2.0, -4.0));
	block.var[2][3][0][0] = (vec2(-5.0, 3.0));
	block.var[2][3][0][1] = (vec2(-7.0, -3.0));
	block.var[2][3][0][2] = (vec2(-6.0, 7.0));
	block.var[2][3][0][3] = (vec2(-4.0, 1.0));
	block.var[2][3][1][0] = (vec2(-7.0, -7.0));
	block.var[2][3][1][1] = (vec2(0.0, 4.0));
	block.var[2][3][1][2] = (vec2(4.0, -9.0));
	block.var[2][3][1][3] = (vec2(-5.0, -8.0));
}
#version 450
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
layout(std140, buffer_reference) buffer Block
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
	allOk = compare_uint((block.u), 8u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(5.0, -5.0, 5.0, 3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0, -4.0, -5.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(1u, 5u, 9u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(9.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(1.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(6u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-6.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(7.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-2.0, 8.0, 9.0, 0.0)) && allOk;
	allOk = compare_int((block.t[0].c), 3) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0, 9.0, 0.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(3u, 7u, 2u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-4.0, 8.0, -9.0, -2.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(0u, 8u, 8u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-4.0, 6.0, -3.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(9u, 6u, 2u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-4.0, -7.0, -4.0, -1.0)) && allOk;
	allOk = compare_int((block.t[1].c), 9) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(8.0, 0.0, 8.0, -7.0, 3.0, 4.0, 6.0, -9.0, 1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(2u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(-2.0, -7.0, 1.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(3u, 2u, 1u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(-9.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(-1.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_int((block.t[2].c), 7) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(1.0, 6.0, -2.0, -8.0, 3.0, -3.0, -9.0, -3.0, 8.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(8u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(-3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(9u, 5u, 8u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(0.0, 0.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(-6.0, 1.0, -3.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(7u, 4u, 9u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(4.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_int((block.t[3].c), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(3u, 1u, 7u));
	block.s.b[0] = (vec2(4.0, 0.0));
	block.s.b[1] = (vec2(-1.0, -9.0));
	block.s.b[2] = (vec2(-8.0, 0.0));
	block.s.b[3] = (vec2(7.0, 2.0));
	block.s.c = (vec4(7.0, -7.0, 5.0, 1.0));
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block[0].var, mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(0.0, 5.0, 5.0));
	block[0].var[1] = (vec3(0.0, -7.0, 8.0));
	block[1].var[0] = (vec3(-7.0, -4.0, 6.0));
	block[1].var[1] = (vec3(1.0, 3.0, 2.0));
	block[2].var[0] = (vec3(-6.0, 5.0, 2.0));
	block[2].var[1] = (vec3(1.0, 8.0, -8.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -6.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(2.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, 3.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-4.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(9.0, 3.0, 2.0, -4.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(3.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(3.0, 2.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-7.0, 0.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block[0].var[1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block[0].var[2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block[1].var[0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block[1].var[1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block[1].var[2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block[2].var[0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block[2].var[1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block[2].var[2] = (vec4(-7.0, 8.0, 0.0, -6.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -6.0) && allOk;
	allOk = compare_mat2(block[0].var, mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, 3.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-4.0, 0.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var[0] = (vec2(1.0, -7.0));
	block[0].var[1] = (vec2(-1.0, 5.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec2(4.0, 8.0));
	block[1].var[1] = (vec2(-2.0, -6.0));
	block[2].padding = (-5.0);
	block[2].var[0] = (vec2(-1.0, 3.0));
	block[2].var[1] = (vec2(4.0, -8.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(-2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(-6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-6.0);
	block[0].var = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	block[1].padding = (-8.0);
	block[1].var = (mat3(-2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0, 5.0));
	block[2].padding = (7.0);
	block[2].var = (mat3(4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0, 1.0, 2.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-1.0, -7.0, 3.0, -8.0, 3.0, 7.0)) && allOk;
	allOk = compare_float((block[2].padding), 0.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(5.0, 0.0, -5.0, 5.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-4.0);
	block[0].var[0] = (vec2(-6.0, 1.0));
	block[0].var[1] = (vec2(-3.0, -1.0));
	block[0].var[2] = (vec2(-9.0, 3.0));
	block[1].padding = (-2.0);
	block[1].var[0] = (vec2(5.0, -8.0));
	block[1].var[1] = (vec2(2.0, -9.0));
	block[1].var[2] = (vec2(1.0, -5.0));
	block[2].padding = (0.0);
	block[2].var[0] = (vec2(-2.0, 2.0));
	block[2].var[1] = (vec2(-1.0, -7.0));
	block[2].var[2] = (vec2(9.0, -8.0));
}
#version 450
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
	i8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(block[0].var), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_int8_t(int(block[1].padding), 4294967289) && allOk;
	allOk = compare_i8vec3(ivec3(block[1].var), ivec3(3, 7, 9)) && allOk;
	allOk = compare_int8_t(int(block[2].padding), 4294967292) && allOk;
	allOk = compare_i8vec3(ivec3(block[2].var), ivec3(5, 4294967288, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int8_t(4294967292);
	block[0].var = i8vec3(ivec3(0, 0, 7));
	block[1].padding = int8_t(9);
	block[1].var = i8vec3(ivec3(4294967290, 4294967288, 9));
	block[2].padding = int8_t(4294967288);
	block[2].var = i8vec3(ivec3(4294967293, 3, 4294967295));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
};
layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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
	allOk = compare_mat2(blockA[0].c, mat2(2.0, -6.0, -8.0, 5.0)) && allOk;
	allOk = compare_float((blockA[1].a), -1.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(3.0, 9.0, -9.0, 1.0)) && allOk;
	allOk = compare_float((blockA[2].a), -6.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(-9.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-7, 5)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(7, -3)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(6, 7)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-6.0);
	blockA[1].a = (-8.0);
	blockA[2].a = (1.0);
	blockB[0].a[0] = (vec3(6.0, 1.0, -5.0));
	blockB[0].a[1] = (vec3(2.0, -4.0, 0.0));
	blockB[0].a[2] = (vec3(-9.0, -9.0, 0.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(-2.0, 8.0, -7.0));
	blockB[1].a[1] = (vec3(3.0, -2.0, -9.0));
	blockB[1].a[2] = (vec3(-7.0, 7.0, -8.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(0.0, -6.0, 0.0));
	blockB[2].a[1] = (vec3(-9.0, 9.0, -3.0));
	blockB[2].a[2] = (vec3(8.0, -6.0, -3.0));
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
layout(std430, buffer_reference) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
};
layout(std430, buffer_reference) buffer BlockB
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

layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp mat4x2 a;
	highp mat2 b;
	mediump mat2 c;
	lowp int d;
	lowp mat3x2 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat3 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp int g;
	mediump mat4 h;
	bvec4 i;
	mediump mat4x3 j;
	highp uvec3 k;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockE
{
	lowp mat3 l[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b, mat2(-6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[0], mat3x2(-4.0, 3.0, -9.0, 0.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[1], mat3x2(1.0, 9.0, 8.0, -1.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[2], mat3x2(-7.0, -3.0, 7.0, 1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.f[0], mat3(-9.0, 0.0, 6.0, 1.0, 2.0, 2.0, -4.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.f[1], mat3(-5.0, -1.0, -9.0, -1.0, -9.0, -8.0, -5.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.f[2], mat3(-2.0, 2.0, -5.0, 3.0, -7.0, 4.0, 7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.f[3], mat3(-9.0, -8.0, 0.0, -8.0, -2.0, -8.0, -2.0, -9.0, -3.0)) && allOk;
	allOk = compare_int((blockD.g), 8) && allOk;
	allOk = compare_mat4(blockD.h, mat4(-7.0, 9.0, -9.0, 2.0, 4.0, 7.0, 4.0, -6.0, -8.0, 5.0, -7.0, 8.0, -2.0, 6.0, 2.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockD.i), bvec4(false, true, true, true)) && allOk;
	allOk = compare_mat4x3(blockD.j, mat4x3(6.0, 9.0, 8.0, -8.0, 8.0, 4.0, 4.0, 9.0, -9.0, -6.0, 7.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockD.k), uvec3(7u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2(-7.0, 5.0, 8.0, -6.0));
	blockB.c = (mat2(-7.0, 2.0, -2.0, 3.0));
	blockB.d = (-1);
	blockB.e[0] = (mat3x2(4.0, -7.0, -4.0, -7.0, -6.0, -4.0));
	blockB.e[1] = (mat3x2(8.0, 0.0, 2.0, 4.0, -9.0, 3.0));
	blockB.e[2] = (mat3x2(-1.0, -5.0, -6.0, 3.0, -4.0, -5.0));
	blockC.f[0] = (mat3(6.0, -8.0, 8.0, -6.0, 5.0, -5.0, -2.0, -4.0, 2.0));
	blockC.f[1] = (mat3(-2.0, -1.0, 8.0, 8.0, 1.0, 7.0, -1.0, 7.0, 0.0));
	blockC.f[2] = (mat3(-5.0, -6.0, 6.0, 6.0, -6.0, -6.0, 5.0, 6.0, 3.0));
	blockC.f[3] = (mat3(2.0, -9.0, -5.0, -4.0, 5.0, -1.0, 5.0, -9.0, -8.0));
	blockD.h = (mat4(8.0, 2.0, 8.0, -1.0, -1.0, 3.0, -6.0, 6.0, -1.0, -9.0, 7.0, 5.0, -7.0, 5.0, -3.0, -4.0));
	blockD.i = (bvec4(true, true, false, false));
	blockD.j = (mat4x3(-9.0, -7.0, 3.0, 3.0, -2.0, 8.0, 2.0, -1.0, 7.0, -4.0, -2.0, 7.0));
	blockD.k = (uvec3(3u, 6u, 3u));
}
#version 450
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
	mediump mat3 mA;
	highp mat4x2 mB;
	mediump mat3x4 mC[7];
	mediump uint mD;
};
struct sB
{
	lowp int mA;
	bvec2 mB;
	sA mC[5];
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump vec2 a;
	highp mat4 b;
	highp uvec4 c;
	lowp mat4x2 d[3];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat2x3 e;
	lowp vec4 f;
	bvec4 g;
};
layout(std140, buffer_reference) buffer BlockD
{
	sB h;
	lowp float i;
	bool j;
	lowp ivec4 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[2];
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].d[0], mat4x2(9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].d[1], mat4x2(-3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].d[2], mat4x2(-3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC[0].f), vec4(-4.0, 0.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC[1].f), vec4(1.0, -8.0, -9.0, 5.0)) && allOk;
	allOk = compare_int((blockD[0].h.mA), 4) && allOk;
	allOk = compare_bvec2((blockD[0].h.mB), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[0].mA, mat3(6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[0].mB, mat4x2(6.0, -3.0, -4.0, 5.0, -9.0, 6.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[0], mat3x4(-6.0, 4.0, -8.0, 7.0, 1.0, -6.0, 8.0, 4.0, -4.0, 6.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[1], mat3x4(-2.0, -7.0, 4.0, 1.0, -2.0, 4.0, -3.0, 6.0, 1.0, -2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[2], mat3x4(-8.0, -6.0, -5.0, 7.0, 5.0, -6.0, 5.0, -5.0, 3.0, -8.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[3], mat3x4(-9.0, 7.0, 5.0, -8.0, 9.0, -8.0, -7.0, 9.0, -9.0, 2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[4], mat3x4(-1.0, 7.0, -7.0, 9.0, -1.0, 7.0, 7.0, -6.0, 9.0, -4.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[5], mat3x4(4.0, 1.0, -6.0, -2.0, -8.0, 6.0, 6.0, 2.0, 9.0, 7.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[6], mat3x4(8.0, -3.0, -5.0, 7.0, -3.0, -5.0, 7.0, -2.0, 1.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[0].mD), 2u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[1].mA, mat3(-8.0, -2.0, -1.0, -1.0, -7.0, -9.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[1].mB, mat4x2(7.0, 7.0, 1.0, -8.0, 7.0, 1.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[0], mat3x4(-1.0, 9.0, 0.0, -1.0, 7.0, 5.0, -2.0, 0.0, -2.0, 2.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[1], mat3x4(-9.0, 4.0, 2.0, 6.0, 2.0, -1.0, -8.0, 8.0, 0.0, -7.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[2], mat3x4(3.0, 6.0, 3.0, -3.0, -2.0, 0.0, 4.0, 4.0, -2.0, 8.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[3], mat3x4(-2.0, 0.0, -5.0, 4.0, 9.0, -6.0, -1.0, 8.0, 5.0, 0.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[4], mat3x4(5.0, 1.0, 7.0, -3.0, -8.0, -5.0, 6.0, -9.0, 6.0, -4.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[5], mat3x4(2.0, 9.0, 2.0, -5.0, 8.0, -6.0, 3.0, -9.0, 4.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[6], mat3x4(4.0, 0.0, 4.0, 5.0, -7.0, 7.0, 6.0, 4.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[1].mD), 4u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[2].mA, mat3(-2.0, 2.0, -3.0, 7.0, 7.0, -3.0, -2.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[2].mB, mat4x2(-4.0, -8.0, 9.0, -4.0, 8.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[0], mat3x4(-4.0, 1.0, -8.0, 1.0, 7.0, 2.0, 3.0, -6.0, 3.0, -3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[1], mat3x4(7.0, 4.0, -9.0, 5.0, 5.0, -2.0, -4.0, 5.0, -9.0, -7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[2], mat3x4(9.0, 9.0, -7.0, -6.0, 1.0, 8.0, -2.0, 5.0, 6.0, 1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[3], mat3x4(8.0, 0.0, -8.0, -6.0, 6.0, -3.0, 4.0, -5.0, 7.0, 4.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[4], mat3x4(1.0, 1.0, -1.0, 6.0, -2.0, -3.0, -6.0, 9.0, 6.0, -9.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[5], mat3x4(0.0, -4.0, 6.0, 6.0, -9.0, -2.0, 9.0, 4.0, -7.0, 3.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[6], mat3x4(-8.0, 8.0, -1.0, -8.0, 6.0, 4.0, 2.0, -2.0, 1.0, -8.0, -3.0, 0.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[2].mD), 4u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[3].mA, mat3(-6.0, 6.0, 7.0, -1.0, -8.0, -5.0, -2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[3].mB, mat4x2(1.0, -4.0, -2.0, -8.0, -3.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[0], mat3x4(9.0, -1.0, -4.0, 8.0, 1.0, 1.0, -1.0, -2.0, 6.0, 7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[1], mat3x4(3.0, 8.0, 8.0, 2.0, -4.0, 9.0, 9.0, -6.0, 3.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[2], mat3x4(5.0, 1.0, -5.0, -3.0, 2.0, -8.0, 2.0, 3.0, -4.0, 2.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[3], mat3x4(-9.0, 5.0, -6.0, 0.0, 0.0, -3.0, -9.0, -7.0, -4.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[4], mat3x4(0.0, 0.0, 6.0, -5.0, -8.0, 7.0, -5.0, -6.0, 6.0, 5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[5], mat3x4(-1.0, 0.0, -5.0, 9.0, -3.0, 5.0, -4.0, -5.0, 9.0, -7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[6], mat3x4(3.0, 2.0, 5.0, 4.0, -2.0, 7.0, 8.0, 3.0, 9.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[3].mD), 0u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[4].mA, mat3(-1.0, -3.0, -7.0, 8.0, -9.0, -6.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[4].mB, mat4x2(2.0, -4.0, -1.0, 8.0, -5.0, -5.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[0], mat3x4(3.0, -5.0, 0.0, 4.0, 6.0, 3.0, -2.0, 1.0, 3.0, -6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[1], mat3x4(4.0, 9.0, 7.0, -4.0, 7.0, -9.0, 5.0, 8.0, -7.0, 0.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[2], mat3x4(-7.0, -9.0, -8.0, -4.0, 1.0, -7.0, 5.0, 8.0, 1.0, -8.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[3], mat3x4(-9.0, -7.0, 4.0, 7.0, 8.0, 8.0, 0.0, -1.0, 0.0, -2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[4], mat3x4(2.0, 2.0, -6.0, -4.0, -3.0, 6.0, 4.0, -3.0, 5.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[5], mat3x4(-7.0, -6.0, 4.0, -2.0, 0.0, -5.0, 1.0, 8.0, 0.0, -3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[6], mat3x4(7.0, -3.0, 2.0, 8.0, 7.0, 6.0, 6.0, 3.0, -2.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[4].mD), 3u) && allOk;
	allOk = compare_bool((blockD[0].j), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(2.0, 7.0));
	blockB[0].b = (mat4(-5.0, -4.0, -8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0, 8.0, 0.0));
	blockB[0].c = (uvec4(7u, 5u, 3u, 1u));
	blockC[0].g = (bvec4(false, true, true, true));
	blockC[1].g = (bvec4(true, false, true, false));
	blockD[0].h.mA = (3);
	blockD[0].h.mB = (bvec2(false, true));
	blockD[0].h.mC[0].mA = (mat3(9.0, -7.0, 2.0, 5.0, 9.0, 3.0, -4.0, 6.0, 4.0));
	blockD[0].h.mC[0].mB = (mat4x2(5.0, 5.0, 6.0, 8.0, 1.0, -8.0, 3.0, -9.0));
	blockD[0].h.mC[0].mC[0] = (mat3x4(5.0, -8.0, 0.0, 5.0, 0.0, -7.0, 7.0, -2.0, 9.0, 8.0, 0.0, 5.0));
	blockD[0].h.mC[0].mC[1] = (mat3x4(-3.0, 8.0, 7.0, 4.0, 7.0, -3.0, 9.0, -4.0, 7.0, -1.0, 5.0, 3.0));
	blockD[0].h.mC[0].mC[2] = (mat3x4(-8.0, 4.0, 2.0, -4.0, 1.0, 6.0, -8.0, -2.0, -6.0, 8.0, -6.0, 2.0));
	blockD[0].h.mC[0].mC[3] = (mat3x4(-5.0, -8.0, -5.0, -4.0, 2.0, 2.0, 2.0, -1.0, -2.0, 6.0, -1.0, 1.0));
	blockD[0].h.mC[0].mC[4] = (mat3x4(-7.0, 3.0, -3.0, 3.0, 4.0, 9.0, 3.0, -7.0, -9.0, -8.0, -7.0, 1.0));
	blockD[0].h.mC[0].mC[5] = (mat3x4(-5.0, -5.0, 6.0, 0.0, 1.0, -6.0, -1.0, -7.0, 0.0, 9.0, -3.0, -4.0));
	blockD[0].h.mC[0].mC[6] = (mat3x4(-9.0, -1.0, -3.0, -9.0, 4.0, 2.0, -2.0, -7.0, 5.0, -4.0, -7.0, -6.0));
	blockD[0].h.mC[0].mD = (6u);
	blockD[0].h.mC[1].mA = (mat3(2.0, 1.0, 2.0, -3.0, 2.0, -2.0, -6.0, 9.0, 3.0));
	blockD[0].h.mC[1].mB = (mat4x2(1.0, -9.0, -9.0, 5.0, -1.0, -4.0, -7.0, 5.0));
	blockD[0].h.mC[1].mC[0] = (mat3x4(6.0, 3.0, 7.0, -6.0, -5.0, -4.0, -5.0, -6.0, 5.0, 0.0, 5.0, -3.0));
	blockD[0].h.mC[1].mC[1] = (mat3x4(9.0, -7.0, 9.0, 9.0, -3.0, -7.0, -3.0, 8.0, -1.0, -1.0, -1.0, 1.0));
	blockD[0].h.mC[1].mC[2] = (mat3x4(7.0, -6.0, -2.0, -8.0, -1.0, -6.0, 2.0, 1.0, 4.0, 1.0, 8.0, 1.0));
	blockD[0].h.mC[1].mC[3] = (mat3x4(6.0, 6.0, -8.0, -5.0, 1.0, -5.0, -4.0, 5.0, -7.0, 7.0, 2.0, -3.0));
	blockD[0].h.mC[1].mC[4] = (mat3x4(5.0, 1.0, 8.0, 6.0, 4.0, -3.0, 0.0, -6.0, -6.0, 3.0, -8.0, 8.0));
	blockD[0].h.mC[1].mC[5] = (mat3x4(-6.0, -4.0, 6.0, 4.0, 5.0, 2.0, -1.0, -3.0, 4.0, 5.0, 3.0, -8.0));
	blockD[0].h.mC[1].mC[6] = (mat3x4(5.0, 1.0, 2.0, -1.0, 4.0, -8.0, -9.0, -2.0, -6.0, -2.0, -6.0, 3.0));
	blockD[0].h.mC[1].mD = (4u);
	blockD[0].h.mC[2].mA = (mat3(-9.0, 0.0, -7.0, -5.0, -5.0, -1.0, 2.0, 2.0, -5.0));
	blockD[0].h.mC[2].mB = (mat4x2(3.0, 9.0, -4.0, -8.0, 6.0, 4.0, 6.0, -5.0));
	blockD[0].h.mC[2].mC[0] = (mat3x4(2.0, 5.0, -1.0, -8.0, -9.0, 6.0, -4.0, 8.0, -9.0, -6.0, -6.0, 2.0));
	blockD[0].h.mC[2].mC[1] = (mat3x4(8.0, 8.0, -4.0, -5.0, 4.0, 5.0, 2.0, -6.0, 3.0, -5.0, -9.0, -6.0));
	blockD[0].h.mC[2].mC[2] = (mat3x4(-2.0, -5.0, 4.0, -2.0, -9.0, 2.0, 9.0, -8.0, 1.0, -7.0, -4.0, 1.0));
	blockD[0].h.mC[2].mC[3] = (mat3x4(-5.0, -4.0, 8.0, 0.0, -5.0, 0.0, 0.0, 3.0, -3.0, 5.0, 2.0, 9.0));
	blockD[0].h.mC[2].mC[4] = (mat3x4(-3.0, 4.0, -4.0, -7.0, 7.0, 3.0, -7.0, -5.0, -3.0, -6.0, -6.0, 2.0));
	blockD[0].h.mC[2].mC[5] = (mat3x4(5.0, 3.0, -2.0, 5.0, 9.0, 8.0, -9.0, 7.0, 0.0, 8.0, -9.0, -9.0));
	blockD[0].h.mC[2].mC[6] = (mat3x4(7.0, -6.0, 2.0, 9.0, -4.0, -5.0, -1.0, -4.0, -5.0, 8.0, 4.0, -7.0));
	blockD[0].h.mC[2].mD = (1u);
	blockD[0].h.mC[3].mA = (mat3(-4.0, 0.0, -7.0, 7.0, 4.0, -2.0, 9.0, 7.0, 8.0));
	blockD[0].h.mC[3].mB = (mat4x2(3.0, -9.0, 4.0, -3.0, 3.0, 4.0, 4.0, 8.0));
	blockD[0].h.mC[3].mC[0] = (mat3x4(-6.0, -2.0, 1.0, 0.0, 6.0, 2.0, 1.0, 3.0, 3.0, 2.0, 8.0, -3.0));
	blockD[0].h.mC[3].mC[1] = (mat3x4(-6.0, -6.0, -2.0, -7.0, -5.0, -7.0, 5.0, 8.0, -8.0, -9.0, -9.0, -8.0));
	blockD[0].h.mC[3].mC[2] = (mat3x4(-9.0, -1.0, 7.0, 1.0, -8.0, -1.0, -7.0, 9.0, 6.0, 3.0, -4.0, 3.0));
	blockD[0].h.mC[3].mC[3] = (mat3x4(4.0, -3.0, 6.0, -4.0, -4.0, 0.0, 2.0, -8.0, -4.0, -1.0, 8.0, 4.0));
	blockD[0].h.mC[3].mC[4] = (mat3x4(-5.0, 8.0, 1.0, -3.0, 4.0, 9.0, 7.0, -8.0, 0.0, 9.0, -3.0, -3.0));
	blockD[0].h.mC[3].mC[5] = (mat3x4(8.0, 9.0, 3.0, -9.0, -7.0, -2.0, -8.0, -4.0, 4.0, 3.0, -7.0, -8.0));
	blockD[0].h.mC[3].mC[6] = (mat3x4(0.0, -7.0, 6.0, 0.0, -2.0, -8.0, 4.0, -6.0, 8.0, -2.0, -4.0, -7.0));
	blockD[0].h.mC[3].mD = (7u);
	blockD[0].h.mC[4].mA = (mat3(7.0, -7.0, -9.0, -1.0, 5.0, 6.0, 1.0, 4.0, -6.0));
	blockD[0].h.mC[4].mB = (mat4x2(-9.0, 1.0, 7.0, 1.0, 1.0, 1.0, 1.0, 6.0));
	blockD[0].h.mC[4].mC[0] = (mat3x4(-7.0, 0.0, 8.0, -2.0, -7.0, 3.0, -2.0, 1.0, 1.0, -5.0, -9.0, 6.0));
	blockD[0].h.mC[4].mC[1] = (mat3x4(6.0, 0.0, 2.0, 1.0, 7.0, -4.0, -8.0, 9.0, 2.0, 7.0, -6.0, 6.0));
	blockD[0].h.mC[4].mC[2] = (mat3x4(0.0, -5.0, -8.0, -1.0, 1.0, 4.0, 2.0, 6.0, 8.0, -3.0, -3.0, 6.0));
	blockD[0].h.mC[4].mC[3] = (mat3x4(-9.0, 3.0, 9.0, -3.0, 1.0, -8.0, 0.0, -1.0, -4.0, 0.0, -3.0, 2.0));
	blockD[0].h.mC[4].mC[4] = (mat3x4(-9.0, -1.0, 3.0, 5.0, 0.0, -3.0, -9.0, -6.0, -7.0, 5.0, -4.0, -3.0));
	blockD[0].h.mC[4].mC[5] = (mat3x4(-5.0, 9.0, -2.0, 7.0, 1.0, 9.0, 8.0, 7.0, -8.0, -5.0, 8.0, -7.0));
	blockD[0].h.mC[4].mC[6] = (mat3x4(5.0, 7.0, 0.0, -5.0, -3.0, 9.0, -3.0, 6.0, -6.0, -8.0, -8.0, 5.0));
	blockD[0].h.mC[4].mD = (3u);
	blockD[0].i = (4.0);
	blockD[0].j = (true);
}
#version 450
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
	highp ivec4 mB;
	lowp ivec4 mC;
};
struct sB
{
	sA mA;
	highp vec2 mB;
	lowp float mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	bvec2 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sB b[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec2 c;
	lowp ivec4 d;
	mediump vec4 e;
	mediump vec3 f;
	lowp mat4x2 g[][5];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp ivec3 h;
	bvec4 i;
	mediump ivec3 j;
	lowp ivec3 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC[0].b[0].mA.mA), vec2(9.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[0].mA.mB), ivec4(5, 2, -4, 7)) && allOk;
	allOk = compare_ivec4((blockC[0].b[0].mA.mC), ivec4(-1, 4, -9, 7)) && allOk;
	allOk = compare_vec2((blockC[0].b[0].mB), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_float((blockC[0].b[0].mC), 2.0) && allOk;
	allOk = compare_vec2((blockC[0].b[1].mA.mA), vec2(7.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[1].mA.mB), ivec4(7, -1, 3, -2)) && allOk;
	allOk = compare_ivec4((blockC[0].b[1].mA.mC), ivec4(1, -4, 7, -6)) && allOk;
	allOk = compare_vec2((blockC[0].b[1].mB), vec2(8.0, 3.0)) && allOk;
	allOk = compare_float((blockC[0].b[1].mC), -9.0) && allOk;
	allOk = compare_vec2((blockC[0].b[2].mA.mA), vec2(0.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[2].mA.mB), ivec4(-1, -5, 5, 3)) && allOk;
	allOk = compare_ivec4((blockC[0].b[2].mA.mC), ivec4(0, 6, 8, 5)) && allOk;
	allOk = compare_vec2((blockC[0].b[2].mB), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_float((blockC[0].b[2].mC), 0.0) && allOk;
	allOk = compare_vec2((blockC[0].b[3].mA.mA), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[3].mA.mB), ivec4(9, -5, 1, 8)) && allOk;
	allOk = compare_ivec4((blockC[0].b[3].mA.mC), ivec4(9, -3, 2, 2)) && allOk;
	allOk = compare_vec2((blockC[0].b[3].mB), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_float((blockC[0].b[3].mC), 5.0) && allOk;
	allOk = compare_vec2((blockC[0].b[4].mA.mA), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[4].mA.mB), ivec4(-8, 4, -8, -3)) && allOk;
	allOk = compare_ivec4((blockC[0].b[4].mA.mC), ivec4(3, 3, -7, 7)) && allOk;
	allOk = compare_vec2((blockC[0].b[4].mB), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_float((blockC[0].b[4].mC), -4.0) && allOk;
	allOk = compare_vec2((blockC[1].b[0].mA.mA), vec2(4.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[0].mA.mB), ivec4(-4, -4, -8, 9)) && allOk;
	allOk = compare_ivec4((blockC[1].b[0].mA.mC), ivec4(-3, 8, 2, 7)) && allOk;
	allOk = compare_vec2((blockC[1].b[0].mB), vec2(9.0, 3.0)) && allOk;
	allOk = compare_float((blockC[1].b[0].mC), -3.0) && allOk;
	allOk = compare_vec2((blockC[1].b[1].mA.mA), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[1].mA.mB), ivec4(-5, 7, -8, -2)) && allOk;
	allOk = compare_ivec4((blockC[1].b[1].mA.mC), ivec4(-5, -3, 3, 4)) && allOk;
	allOk = compare_vec2((blockC[1].b[1].mB), vec2(4.0, -4.0)) && allOk;
	allOk = compare_float((blockC[1].b[1].mC), 4.0) && allOk;
	allOk = compare_vec2((blockC[1].b[2].mA.mA), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[2].mA.mB), ivec4(-1, 4, 5, 7)) && allOk;
	allOk = compare_ivec4((blockC[1].b[2].mA.mC), ivec4(-7, 0, 2, -2)) && allOk;
	allOk = compare_vec2((blockC[1].b[2].mB), vec2(6.0, -9.0)) && allOk;
	allOk = compare_float((blockC[1].b[2].mC), -2.0) && allOk;
	allOk = compare_vec2((blockC[1].b[3].mA.mA), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[3].mA.mB), ivec4(-9, -9, 8, 9)) && allOk;
	allOk = compare_ivec4((blockC[1].b[3].mA.mC), ivec4(2, 3, 2, 0)) && allOk;
	allOk = compare_vec2((blockC[1].b[3].mB), vec2(2.0, 1.0)) && allOk;
	allOk = compare_float((blockC[1].b[3].mC), 5.0) && allOk;
	allOk = compare_vec2((blockC[2].b[0].mA.mA), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[0].mA.mB), ivec4(-6, 4, 1, -3)) && allOk;
	allOk = compare_ivec4((blockC[2].b[0].mA.mC), ivec4(7, -8, -6, 8)) && allOk;
	allOk = compare_vec2((blockC[2].b[0].mB), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_float((blockC[2].b[0].mC), -7.0) && allOk;
	allOk = compare_vec2((blockC[2].b[1].mA.mA), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[1].mA.mB), ivec4(0, 9, -2, 9)) && allOk;
	allOk = compare_ivec4((blockC[2].b[1].mA.mC), ivec4(-8, -4, 9, -4)) && allOk;
	allOk = compare_vec2((blockC[2].b[1].mB), vec2(4.0, -5.0)) && allOk;
	allOk = compare_float((blockC[2].b[1].mC), 9.0) && allOk;
	allOk = compare_vec2((blockC[2].b[2].mA.mA), vec2(3.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[2].mA.mB), ivec4(9, -5, 8, -7)) && allOk;
	allOk = compare_ivec4((blockC[2].b[2].mA.mC), ivec4(-8, -3, -4, -7)) && allOk;
	allOk = compare_vec2((blockC[2].b[2].mB), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_float((blockC[2].b[2].mC), 2.0) && allOk;
	allOk = compare_vec2((blockC[2].b[3].mA.mA), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[3].mA.mB), ivec4(-5, -3, 0, -9)) && allOk;
	allOk = compare_ivec4((blockC[2].b[3].mA.mC), ivec4(-3, -5, -7, -3)) && allOk;
	allOk = compare_vec2((blockC[2].b[3].mB), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_float((blockC[2].b[3].mC), -3.0) && allOk;
	allOk = compare_vec2((blockC[2].b[4].mA.mA), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[4].mA.mB), ivec4(-8, -3, -5, 5)) && allOk;
	allOk = compare_ivec4((blockC[2].b[4].mA.mC), ivec4(-6, 1, -8, 2)) && allOk;
	allOk = compare_vec2((blockC[2].b[4].mB), vec2(1.0, 3.0)) && allOk;
	allOk = compare_float((blockC[2].b[4].mC), -1.0) && allOk;
	allOk = compare_vec2((blockC[2].b[5].mA.mA), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[5].mA.mB), ivec4(6, 1, -5, 0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[5].mA.mC), ivec4(-4, 8, 5, 6)) && allOk;
	allOk = compare_vec2((blockC[2].b[5].mB), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_float((blockC[2].b[5].mC), -2.0) && allOk;
	allOk = compare_vec2((blockC[2].b[6].mA.mA), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[6].mA.mB), ivec4(2, 6, 1, 6)) && allOk;
	allOk = compare_ivec4((blockC[2].b[6].mA.mC), ivec4(-8, -4, 7, -1)) && allOk;
	allOk = compare_vec2((blockC[2].b[6].mB), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_float((blockC[2].b[6].mC), 9.0) && allOk;
	allOk = compare_vec2((blockC[2].b[7].mA.mA), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[7].mA.mB), ivec4(3, 9, -5, 2)) && allOk;
	allOk = compare_ivec4((blockC[2].b[7].mA.mC), ivec4(9, -2, 4, -6)) && allOk;
	allOk = compare_vec2((blockC[2].b[7].mB), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_float((blockC[2].b[7].mC), -6.0) && allOk;
	allOk = compare_ivec2((blockD.c), ivec2(-5, 1)) && allOk;
	allOk = compare_vec3((blockD.f), vec3(-3.0, 0.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockE.i), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec3((blockE.j), ivec3(1, -8, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (bvec2(true, false));
	blockC[0].b[0].mA.mA = (vec2(2.0, 4.0));
	blockC[0].b[0].mA.mB = (ivec4(-5, 4, -6, -8));
	blockC[0].b[0].mA.mC = (ivec4(-9, -5, 4, -3));
	blockC[0].b[0].mB = (vec2(0.0, -2.0));
	blockC[0].b[0].mC = (2.0);
	blockC[0].b[1].mA.mA = (vec2(9.0, -2.0));
	blockC[0].b[1].mA.mB = (ivec4(-5, 0, 4, 7));
	blockC[0].b[1].mA.mC = (ivec4(-8, -8, 9, 4));
	blockC[0].b[1].mB = (vec2(-5.0, -5.0));
	blockC[0].b[1].mC = (5.0);
	blockC[0].b[2].mA.mA = (vec2(-4.0, -9.0));
	blockC[0].b[2].mA.mB = (ivec4(3, -2, 9, 0));
	blockC[0].b[2].mA.mC = (ivec4(4, -3, 8, -6));
	blockC[0].b[2].mB = (vec2(-4.0, -9.0));
	blockC[0].b[2].mC = (-2.0);
	blockC[0].b[3].mA.mA = (vec2(-2.0, 0.0));
	blockC[0].b[3].mA.mB = (ivec4(6, -5, 5, 5));
	blockC[0].b[3].mA.mC = (ivec4(-2, -6, -9, 2));
	blockC[0].b[3].mB = (vec2(7.0, -1.0));
	blockC[0].b[3].mC = (-5.0);
	blockC[0].b[4].mA.mA = (vec2(9.0, 8.0));
	blockC[0].b[4].mA.mB = (ivec4(-5, -2, -4, -4));
	blockC[0].b[4].mA.mC = (ivec4(6, -9, -4, 6));
	blockC[0].b[4].mB = (vec2(-8.0, 9.0));
	blockC[0].b[4].mC = (0.0);
	blockC[1].b[0].mA.mA = (vec2(-4.0, 9.0));
	blockC[1].b[0].mA.mB = (ivec4(2, 7, 8, 7));
	blockC[1].b[0].mA.mC = (ivec4(1, -9, -4, 1));
	blockC[1].b[0].mB = (vec2(-3.0, -1.0));
	blockC[1].b[0].mC = (-5.0);
	blockC[1].b[1].mA.mA = (vec2(0.0, -5.0));
	blockC[1].b[1].mA.mB = (ivec4(-6, -2, 8, 6));
	blockC[1].b[1].mA.mC = (ivec4(6, 0, 2, 3));
	blockC[1].b[1].mB = (vec2(7.0, -6.0));
	blockC[1].b[1].mC = (-2.0);
	blockC[1].b[2].mA.mA = (vec2(8.0, -4.0));
	blockC[1].b[2].mA.mB = (ivec4(-6, 1, -8, 1));
	blockC[1].b[2].mA.mC = (ivec4(6, -6, -2, 4));
	blockC[1].b[2].mB = (vec2(1.0, 9.0));
	blockC[1].b[2].mC = (2.0);
	blockC[1].b[3].mA.mA = (vec2(6.0, -6.0));
	blockC[1].b[3].mA.mB = (ivec4(-8, 6, -7, 0));
	blockC[1].b[3].mA.mC = (ivec4(9, -7, -1, 9));
	blockC[1].b[3].mB = (vec2(-8.0, 6.0));
	blockC[1].b[3].mC = (1.0);
	blockC[2].b[0].mA.mA = (vec2(7.0, -9.0));
	blockC[2].b[0].mA.mB = (ivec4(8, -5, -2, -8));
	blockC[2].b[0].mA.mC = (ivec4(9, -5, -8, 9));
	blockC[2].b[0].mB = (vec2(1.0, 3.0));
	blockC[2].b[0].mC = (-3.0);
	blockC[2].b[1].mA.mA = (vec2(9.0, -8.0));
	blockC[2].b[1].mA.mB = (ivec4(5, 0, -5, -3));
	blockC[2].b[1].mA.mC = (ivec4(-6, 7, 6, -4));
	blockC[2].b[1].mB = (vec2(4.0, 6.0));
	blockC[2].b[1].mC = (5.0);
	blockC[2].b[2].mA.mA = (vec2(6.0, 3.0));
	blockC[2].b[2].mA.mB = (ivec4(-8, -2, -4, 3));
	blockC[2].b[2].mA.mC = (ivec4(4, -7, 1, -5));
	blockC[2].b[2].mB = (vec2(8.0, -8.0));
	blockC[2].b[2].mC = (-1.0);
	blockC[2].b[3].mA.mA = (vec2(-5.0, -6.0));
	blockC[2].b[3].mA.mB = (ivec4(3, -7, -1, -9));
	blockC[2].b[3].mA.mC = (ivec4(-2, 7, -9, -1));
	blockC[2].b[3].mB = (vec2(-9.0, -4.0));
	blockC[2].b[3].mC = (-5.0);
	blockC[2].b[4].mA.mA = (vec2(4.0, 2.0));
	blockC[2].b[4].mA.mB = (ivec4(0, -5, 1, -4));
	blockC[2].b[4].mA.mC = (ivec4(0, 2, 3, 2));
	blockC[2].b[4].mB = (vec2(-4.0, -7.0));
	blockC[2].b[4].mC = (-9.0);
	blockC[2].b[5].mA.mA = (vec2(7.0, -8.0));
	blockC[2].b[5].mA.mB = (ivec4(6, 0, -8, 9));
	blockC[2].b[5].mA.mC = (ivec4(9, 3, 1, -3));
	blockC[2].b[5].mB = (vec2(-4.0, -6.0));
	blockC[2].b[5].mC = (7.0);
	blockC[2].b[6].mA.mA = (vec2(-9.0, -7.0));
	blockC[2].b[6].mA.mB = (ivec4(8, 0, -7, 3));
	blockC[2].b[6].mA.mC = (ivec4(0, 8, 3, -1));
	blockC[2].b[6].mB = (vec2(-7.0, -3.0));
	blockC[2].b[6].mC = (-7.0);
	blockC[2].b[7].mA.mA = (vec2(0.0, -7.0));
	blockC[2].b[7].mA.mB = (ivec4(7, -8, -9, 1));
	blockC[2].b[7].mA.mC = (ivec4(-3, -2, -2, -9));
	blockC[2].b[7].mB = (vec2(-1.0, -2.0));
	blockC[2].b[7].mC = (-9.0);
	blockD.e = (vec4(7.0, -3.0, -3.0, -9.0));
	blockD.f = (vec3(4.0, 4.0, 4.0));
	blockE.h = (ivec3(6, -1, 3));
	blockE.i = (bvec4(true, true, true, false));
	blockE.j = (ivec3(6, -3, -9));
}
#version 450
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
	layout(offset = 8) lowp uint b;
	layout(offset = 16) bvec4 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec2 d;
	layout(offset = 16) mediump vec3 e;
	layout(offset = 32) bvec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB[1].a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB[2].a), bvec2(false, false)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(5u, 6u)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(-8.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (4u);
	blockB[0].c = (bvec4(false, true, true, true));
	blockB[1].b = (9u);
	blockB[1].c = (bvec4(false, true, false, false));
	blockB[2].b = (8u);
	blockB[2].c = (bvec4(false, true, false, false));
	blockC.d = (uvec2(6u, 3u));
	blockC.e = (vec3(2.0, 8.0, 0.0));
	blockC.f = (bvec4(false, true, false, false));
}
#version 450
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
	layout(offset = 0) mediump uint a[1];
	layout(offset = 4) lowp float b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec3 c;
	layout(offset = 12) lowp uint d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a[0]), 3u) && allOk;
	allOk = compare_float((blockB[0].b), -7.0) && allOk;
	allOk = compare_uint((blockB[1].a[0]), 1u) && allOk;
	allOk = compare_float((blockB[1].b), 4.0) && allOk;
	allOk = compare_uvec3((blockC[0].c), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_uint((blockC[0].d), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (5u);
	blockB[1].a[0] = (0u);
	blockC[0].c = (uvec3(1u, 7u, 4u));
	blockC[0].d = (1u);
}
#version 450
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
	layout(offset = 0) bvec3 a;
	layout(offset = 16) lowp vec3 b;
	layout(offset = 32) highp vec2 c;
	layout(offset = 40) highp uint d[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uint e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].b), vec3(4.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB[1].b), vec3(9.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB[2].b), vec3(2.0, -4.0, -2.0)) && allOk;
	allOk = compare_uint((blockC.e), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec3(true, false, true));
	blockB[0].c = (vec2(6.0, 9.0));
	blockB[0].d[0] = (2u);
	blockB[1].a = (bvec3(true, false, false));
	blockB[1].c = (vec2(8.0, -4.0));
	blockB[1].d[0] = (1u);
	blockB[2].a = (bvec3(true, true, false));
	blockB[2].c = (vec2(-3.0, -8.0));
	blockB[2].d[0] = (4u);
	blockC.e = (8u);
}
#version 450
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
	layout(offset = 16) highp uvec3 b;
	layout(offset = 32) lowp vec4 c;
	layout(offset = 48) highp uvec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(6.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(4u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, false, true));
	blockB.b = (uvec3(5u, 1u, 5u));
	blockB.c = (vec4(-6.0, -6.0, -7.0, -9.0));
	blockB.d = (uvec2(1u, 9u));
}
#version 450
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
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	mediump ivec3 a;
	mediump uvec3 b;
	highp mat4x2 c;
	highp mat2 d;
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockC
{
	sA e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-1, 5, -9)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(2.0, -9.0, 4.0, 5.0, -7.0, 4.0, 0.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockC.e[0].mA), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.e[1].mA), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat4x2(-7.0, -7.0, 6.0, 0.0, 6.0, -9.0, -2.0, -5.0));
	blockB.d = (mat2(-3.0, -5.0, -1.0, 9.0));
}
#version 450
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
	mediump float b;
	bool c;
	highp int d;
	int16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 3.0) && allOk;
	allOk = compare_int((blockB.d), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (3.0);
	blockB.d = (-5);
	blockB.e = int16_t(-5);
}
#version 450
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
	i16vec3 b;
	u16vec3 c;
	lowp int d;
	i16vec3 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 f;
	u16vec2 g;
	bvec3 h;
	int16_t i;
	u16vec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(1, -7, 1)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.c), uvec3(6u, 2u, 7u)) && allOk;
	allOk = compare_int((blockB.d), 9) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(5u, 6u, 4u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g), uvec2(2u, 0u)) && allOk;
	allOk = compare_bvec3((blockC.h), bvec3(false, true, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.j), uvec3(0u, 6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec3(ivec3(-5, 0, 0));
	blockB.c = u16vec3(uvec3(5u, 8u, 1u));
	blockB.d = (4);
	blockB.e = i16vec3(ivec3(7, 8, 3));
	blockC.g = u16vec2(uvec2(5u, 3u));
	blockC.h = (bvec3(true, false, false));
	blockC.j = u16vec3(uvec3(7u, 8u, 4u));
}
#version 450
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
	u16vec2 a;
	highp vec4 b;
	lowp int c;
	highp vec3 d;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uvec3 e;
	bvec3 f;
	lowp ivec2 g;
	float16_t h;
};
layout(std140, buffer_reference) buffer BlockD
{
	i16vec3 i;
	mediump vec2 j;
	highp float k[1];
	bvec3 l;
};
layout(std140, buffer_reference) buffer BlockE
{
	float16_t m;
	i16vec2 n[1];
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(9.0, 7.0, -5.0, 2.0)) && allOk;
	allOk = compare_int((blockB.c), -1) && allOk;
	allOk = compare_vec3((blockB.d), vec3(-8.0, 2.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(7u, 6u, 1u)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(false, false, true)) && allOk;
	allOk = compare_float16_t(float(blockC.h), 2.0) && allOk;
	allOk = compare_bvec3((blockD.l), bvec3(true, false, true)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.n[0]), ivec2(4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec4(-3.0, -7.0, 6.0, 2.0));
	blockB.c = (-8);
	blockB.d = (vec3(7.0, 6.0, -4.0));
	blockC.f = (bvec3(true, true, false));
	blockC.h = float16_t(1.0);
	blockD.j = (vec2(5.0, 2.0));
	blockD.l = (bvec3(true, false, false));
	blockE.n[0] = i16vec2(ivec2(9, -8));
}
#version 450
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
	highp uint b[1];
	int16_t c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockB.b[0]), 2u) && allOk;
	allOk = compare_int16_t(int(blockB.c), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (5u);
}
#version 450
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
	int16_t c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

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
	allOk = compare_int16_t(int(blockB.c), 8) && allOk;
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

layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp vec3 a;
	mediump uvec4 b;
	lowp mat3x2 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	f16vec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(8u, 1u, 5u, 1u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[3]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[4]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[5]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[6]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[7]), vec2(-9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-6.0, -2.0, 3.0));
	blockB.b = (uvec4(2u, 9u, 4u, 8u));
	blockC.d[0] = f16vec2(vec2(-8.0, 6.0));
	blockC.d[1] = f16vec2(vec2(-4.0, -9.0));
	blockC.d[2] = f16vec2(vec2(8.0, -8.0));
	blockC.d[3] = f16vec2(vec2(-5.0, 1.0));
	blockC.d[4] = f16vec2(vec2(4.0, 3.0));
	blockC.d[5] = f16vec2(vec2(-9.0, -3.0));
	blockC.d[6] = f16vec2(vec2(8.0, 5.0));
	blockC.d[7] = f16vec2(vec2(8.0, 1.0));
}
#version 450
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
	highp ivec3 b;
	f16vec4 c;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec4 d[1];
	mediump ivec2 e;
	f16vec2 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat3x4 g;
	bvec2 h[1];
	i16vec4 i;
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump uint j;
	float16_t k;
	highp vec3 l[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(1, -5, -9)) && allOk;
	allOk = compare_ivec2((blockC[0].e), ivec2(-5, 7)) && allOk;
	allOk = compare_ivec2((blockC[1].e), ivec2(-5, 1)) && allOk;
	allOk = compare_mat3x4(blockD.g, mat3x4(5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockD.h[0]), bvec2(true, false)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.i), ivec4(-3, -9, -7, -4)) && allOk;
	allOk = compare_uint((blockE.j), 6u) && allOk;
	allOk = compare_float16_t(float(blockE.k), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(-4, -8, -5));
	blockC[0].e = (ivec2(8, 8));
	blockC[1].e = (ivec2(-9, -2));
	blockD.g = (mat3x4(7.0, -9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0));
	blockD.i = i16vec4(ivec4(5, 3, 5, -4));
	blockE.j = (9u);
	blockE.k = float16_t(8.0);
}
#version 450
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
	highp vec2 a;
	mediump mat2x3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	i16vec2 c;
	highp mat2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat2x3(-4.0, 1.0, 8.0, -4.0, 1.0, -9.0));
	blockC.c = i16vec2(ivec2(3, 0));
}
#version 450
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
	i16vec3 a;
};
layout(std430, buffer_reference) buffer BlockC
{
	uint16_t b;
	mediump uvec3 c;
	lowp float d[1];
	i16vec4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	int16_t f;
	mediump mat3 g;
	lowp mat3 h;
	lowp mat4x2 i;
	int16_t j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a), ivec3(-4, 4, -6)) && allOk;
	allOk = compare_uint16_t(uint(blockC.b), 4u) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(9u, 5u, 7u)) && allOk;
	allOk = compare_float((blockC.d[0]), 3.0) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[0]), ivec4(2, 3, -6, -4)) && allOk;
	allOk = compare_int16_t(int(blockD[0].f), -6) && allOk;
	allOk = compare_mat3(blockD[0].g, mat3(-3.0, -1.0, 4.0, 8.0, -1.0, 6.0, 5.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD[0].h, mat3(5.0, -1.0, -5.0, -3.0, 4.0, -8.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].i, mat4x2(-4.0, 3.0, 0.0, -2.0, -5.0, 0.0, 1.0, -8.0)) && allOk;
	allOk = compare_int16_t(int(blockD[1].f), -1) && allOk;
	allOk = compare_mat3(blockD[1].g, mat3(0.0, -2.0, 5.0, -4.0, -6.0, 7.0, 0.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD[1].h, mat3(-7.0, 3.0, 6.0, -3.0, -1.0, 7.0, 5.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].i, mat4x2(9.0, -8.0, 4.0, -5.0, 8.0, 9.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = uint16_t(8u);
	blockC.c = (uvec3(8u, 2u, 9u));
	blockD[0].g = (mat3(5.0, 4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0));
	blockD[0].h = (mat3(-9.0, 3.0, -9.0, -1.0, 6.0, 2.0, 7.0, -1.0, -6.0));
	blockD[0].j = int16_t(3);
	blockD[1].g = (mat3(-9.0, 9.0, -5.0, -2.0, -2.0, -6.0, 4.0, 9.0, -2.0));
	blockD[1].h = (mat3(-6.0, 3.0, 6.0, 8.0, -7.0, 5.0, 6.0, -4.0, 7.0));
	blockD[1].j = int16_t(1);
}
#version 450
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
	highp ivec3 mB[7];
};
struct sB
{
	bool mA;
	highp mat3 mB;
	f16vec3 mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	sB b[][2][6];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 c;
	u16vec4 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat3 e;
	lowp mat2 f;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	uint16_t g;
	bool h;
	int16_t i[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockC.c, mat4x2(-6.0, -8.0, -6.0, -6.0, -4.0, 6.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD.e, mat3(9.0, 3.0, -2.0, 4.0, -2.0, -2.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_bool((blockE.h), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat3x4(-5.0, 0.0, -6.0, 8.0, -3.0, -6.0, 3.0, 5.0, -2.0, 6.0, -7.0, -6.0));
	blockB.a.mB[0] = (ivec3(-7, -2, 2));
	blockB.a.mB[1] = (ivec3(3, -1, 4));
	blockB.a.mB[2] = (ivec3(-4, -6, -7));
	blockB.a.mB[3] = (ivec3(-7, -4, 8));
	blockB.a.mB[4] = (ivec3(2, -9, 0));
	blockB.a.mB[5] = (ivec3(4, 3, -1));
	blockB.a.mB[6] = (ivec3(-6, -4, -5));
	blockB.b[0][0][0].mA = (true);
	blockB.b[0][0][0].mB = (mat3(-5.0, 8.0, 1.0, 2.0, -1.0, 7.0, -2.0, -1.0, 8.0));
	blockB.b[0][0][0].mC = f16vec3(vec3(-4.0, -1.0, 7.0));
	blockB.b[0][0][1].mA = (true);
	blockB.b[0][0][1].mB = (mat3(0.0, 4.0, 2.0, 0.0, 2.0, 5.0, 4.0, 7.0, 2.0));
	blockB.b[0][0][1].mC = f16vec3(vec3(-7.0, 4.0, -9.0));
	blockB.b[0][0][2].mA = (false);
	blockB.b[0][0][2].mB = (mat3(8.0, 7.0, -5.0, 1.0, 9.0, -8.0, 9.0, 9.0, -1.0));
	blockB.b[0][0][2].mC = f16vec3(vec3(0.0, 0.0, -1.0));
	blockB.b[0][0][3].mA = (false);
	blockB.b[0][0][3].mB = (mat3(-5.0, -7.0, -5.0, 0.0, 3.0, 0.0, -4.0, 8.0, -1.0));
	blockB.b[0][0][3].mC = f16vec3(vec3(6.0, -2.0, -2.0));
	blockB.b[0][0][4].mA = (false);
	blockB.b[0][0][4].mB = (mat3(-3.0, -9.0, 6.0, 6.0, -9.0, 9.0, -7.0, 9.0, -2.0));
	blockB.b[0][0][4].mC = f16vec3(vec3(-8.0, -1.0, 1.0));
	blockB.b[0][0][5].mA = (true);
	blockB.b[0][0][5].mB = (mat3(-8.0, -4.0, 7.0, -2.0, -6.0, -4.0, 4.0, -4.0, 0.0));
	blockB.b[0][0][5].mC = f16vec3(vec3(-3.0, -5.0, -9.0));
	blockB.b[0][1][0].mA = (true);
	blockB.b[0][1][0].mB = (mat3(7.0, 4.0, 8.0, 6.0, 9.0, 8.0, -4.0, -3.0, -7.0));
	blockB.b[0][1][0].mC = f16vec3(vec3(2.0, 0.0, -5.0));
	blockB.b[0][1][1].mA = (true);
	blockB.b[0][1][1].mB = (mat3(8.0, 3.0, 2.0, -3.0, 5.0, 4.0, 5.0, -2.0, -3.0));
	blockB.b[0][1][1].mC = f16vec3(vec3(-7.0, -1.0, -1.0));
	blockB.b[0][1][2].mA = (false);
	blockB.b[0][1][2].mB = (mat3(-1.0, -8.0, -7.0, 1.0, -9.0, 4.0, -2.0, -9.0, -7.0));
	blockB.b[0][1][2].mC = f16vec3(vec3(4.0, 4.0, 4.0));
	blockB.b[0][1][3].mA = (true);
	blockB.b[0][1][3].mB = (mat3(1.0, -7.0, -1.0, 1.0, -6.0, -1.0, 7.0, -8.0, 5.0));
	blockB.b[0][1][3].mC = f16vec3(vec3(-6.0, -5.0, -6.0));
	blockB.b[0][1][4].mA = (true);
	blockB.b[0][1][4].mB = (mat3(-5.0, 6.0, 8.0, 6.0, 3.0, 4.0, -2.0, -1.0, -3.0));
	blockB.b[0][1][4].mC = f16vec3(vec3(3.0, 1.0, -6.0));
	blockB.b[0][1][5].mA = (true);
	blockB.b[0][1][5].mB = (mat3(1.0, 7.0, -1.0, 7.0, 2.0, -5.0, 6.0, 5.0, -2.0));
	blockB.b[0][1][5].mC = f16vec3(vec3(7.0, -4.0, -5.0));
	blockB.b[1][0][0].mA = (true);
	blockB.b[1][0][0].mB = (mat3(7.0, 6.0, -6.0, 0.0, 5.0, 6.0, -5.0, -6.0, 6.0));
	blockB.b[1][0][0].mC = f16vec3(vec3(-9.0, 2.0, -7.0));
	blockB.b[1][0][1].mA = (true);
	blockB.b[1][0][1].mB = (mat3(-5.0, -3.0, -1.0, 0.0, -2.0, -6.0, -8.0, -4.0, 2.0));
	blockB.b[1][0][1].mC = f16vec3(vec3(3.0, -4.0, 8.0));
	blockB.b[1][0][2].mA = (true);
	blockB.b[1][0][2].mB = (mat3(6.0, -7.0, 4.0, 9.0, -2.0, 7.0, -1.0, -4.0, 0.0));
	blockB.b[1][0][2].mC = f16vec3(vec3(3.0, -3.0, -2.0));
	blockB.b[1][0][3].mA = (false);
	blockB.b[1][0][3].mB = (mat3(7.0, 0.0, -8.0, 2.0, -9.0, -5.0, -7.0, 1.0, -5.0));
	blockB.b[1][0][3].mC = f16vec3(vec3(-3.0, 3.0, -2.0));
	blockB.b[1][0][4].mA = (true);
	blockB.b[1][0][4].mB = (mat3(-7.0, 2.0, -5.0, 6.0, 3.0, 2.0, 6.0, 0.0, 1.0));
	blockB.b[1][0][4].mC = f16vec3(vec3(-8.0, 6.0, 7.0));
	blockB.b[1][0][5].mA = (false);
	blockB.b[1][0][5].mB = (mat3(1.0, 5.0, -1.0, 9.0, -2.0, -2.0, 7.0, -3.0, 1.0));
	blockB.b[1][0][5].mC = f16vec3(vec3(7.0, -2.0, -5.0));
	blockB.b[1][1][0].mA = (false);
	blockB.b[1][1][0].mB = (mat3(-8.0, -4.0, 4.0, -2.0, 9.0, -4.0, -3.0, -9.0, 5.0));
	blockB.b[1][1][0].mC = f16vec3(vec3(-6.0, 4.0, -4.0));
	blockB.b[1][1][1].mA = (true);
	blockB.b[1][1][1].mB = (mat3(-1.0, 9.0, 5.0, 8.0, 3.0, 2.0, -8.0, -8.0, 8.0));
	blockB.b[1][1][1].mC = f16vec3(vec3(5.0, -6.0, -2.0));
	blockB.b[1][1][2].mA = (false);
	blockB.b[1][1][2].mB = (mat3(-4.0, 0.0, -4.0, -7.0, 6.0, 9.0, -8.0, -3.0, 0.0));
	blockB.b[1][1][2].mC = f16vec3(vec3(0.0, -5.0, -7.0));
	blockB.b[1][1][3].mA = (false);
	blockB.b[1][1][3].mB = (mat3(8.0, 9.0, -3.0, -2.0, 0.0, -2.0, 6.0, 6.0, 6.0));
	blockB.b[1][1][3].mC = f16vec3(vec3(-1.0, -1.0, -7.0));
	blockB.b[1][1][4].mA = (false);
	blockB.b[1][1][4].mB = (mat3(-5.0, 5.0, -3.0, -2.0, 8.0, -4.0, -3.0, 1.0, -3.0));
	blockB.b[1][1][4].mC = f16vec3(vec3(-5.0, -9.0, 9.0));
	blockB.b[1][1][5].mA = (false);
	blockB.b[1][1][5].mB = (mat3(1.0, -3.0, 5.0, -1.0, -4.0, 5.0, 5.0, 3.0, 3.0));
	blockB.b[1][1][5].mC = f16vec3(vec3(-5.0, 4.0, 1.0));
	blockB.b[2][0][0].mA = (true);
	blockB.b[2][0][0].mB = (mat3(-6.0, -4.0, 5.0, 3.0, 5.0, -9.0, 2.0, -9.0, -5.0));
	blockB.b[2][0][0].mC = f16vec3(vec3(1.0, -9.0, -7.0));
	blockB.b[2][0][1].mA = (false);
	blockB.b[2][0][1].mB = (mat3(5.0, -6.0, 2.0, -8.0, -2.0, 9.0, -3.0, 5.0, -3.0));
	blockB.b[2][0][1].mC = f16vec3(vec3(1.0, -4.0, 4.0));
	blockB.b[2][0][2].mA = (false);
	blockB.b[2][0][2].mB = (mat3(6.0, -8.0, -1.0, -8.0, -5.0, 1.0, 8.0, 6.0, -3.0));
	blockB.b[2][0][2].mC = f16vec3(vec3(-3.0, -5.0, 0.0));
	blockB.b[2][0][3].mA = (true);
	blockB.b[2][0][3].mB = (mat3(0.0, -3.0, 5.0, 3.0, -6.0, -3.0, 3.0, -5.0, 9.0));
	blockB.b[2][0][3].mC = f16vec3(vec3(-8.0, -8.0, -1.0));
	blockB.b[2][0][4].mA = (true);
	blockB.b[2][0][4].mB = (mat3(2.0, 6.0, -2.0, 4.0, -6.0, 4.0, -7.0, 4.0, 9.0));
	blockB.b[2][0][4].mC = f16vec3(vec3(5.0, -5.0, -1.0));
	blockB.b[2][0][5].mA = (true);
	blockB.b[2][0][5].mB = (mat3(0.0, -8.0, 1.0, 8.0, 6.0, -3.0, -4.0, -2.0, 1.0));
	blockB.b[2][0][5].mC = f16vec3(vec3(-2.0, 6.0, 3.0));
	blockB.b[2][1][0].mA = (false);
	blockB.b[2][1][0].mB = (mat3(-8.0, 9.0, 5.0, -1.0, 9.0, 0.0, -4.0, 3.0, 6.0));
	blockB.b[2][1][0].mC = f16vec3(vec3(6.0, 6.0, -4.0));
	blockB.b[2][1][1].mA = (true);
	blockB.b[2][1][1].mB = (mat3(-1.0, 8.0, 7.0, -5.0, 5.0, -5.0, 6.0, -6.0, 5.0));
	blockB.b[2][1][1].mC = f16vec3(vec3(1.0, -1.0, -6.0));
	blockB.b[2][1][2].mA = (true);
	blockB.b[2][1][2].mB = (mat3(5.0, 0.0, -4.0, 8.0, 3.0, -9.0, 4.0, 1.0, 0.0));
	blockB.b[2][1][2].mC = f16vec3(vec3(-9.0, 1.0, -1.0));
	blockB.b[2][1][3].mA = (true);
	blockB.b[2][1][3].mB = (mat3(4.0, -3.0, 4.0, -8.0, 2.0, 6.0, -5.0, -9.0, -5.0));
	blockB.b[2][1][3].mC = f16vec3(vec3(4.0, 1.0, 7.0));
	blockB.b[2][1][4].mA = (true);
	blockB.b[2][1][4].mB = (mat3(-6.0, 9.0, -7.0, 5.0, 0.0, 3.0, -2.0, 5.0, -4.0));
	blockB.b[2][1][4].mC = f16vec3(vec3(4.0, -7.0, -5.0));
	blockB.b[2][1][5].mA = (false);
	blockB.b[2][1][5].mB = (mat3(-6.0, 7.0, 0.0, -9.0, 8.0, -1.0, -6.0, 3.0, 9.0));
	blockB.b[2][1][5].mC = f16vec3(vec3(2.0, -7.0, -4.0));
	blockB.b[3][0][0].mA = (true);
	blockB.b[3][0][0].mB = (mat3(-1.0, 8.0, -1.0, -8.0, 2.0, -1.0, -7.0, 8.0, 3.0));
	blockB.b[3][0][0].mC = f16vec3(vec3(3.0, 3.0, -2.0));
	blockB.b[3][0][1].mA = (true);
	blockB.b[3][0][1].mB = (mat3(-4.0, 9.0, 8.0, 3.0, -8.0, -2.0, -4.0, 0.0, 7.0));
	blockB.b[3][0][1].mC = f16vec3(vec3(1.0, 8.0, -6.0));
	blockB.b[3][0][2].mA = (true);
	blockB.b[3][0][2].mB = (mat3(9.0, 1.0, 2.0, -1.0, -1.0, 6.0, 3.0, 4.0, -3.0));
	blockB.b[3][0][2].mC = f16vec3(vec3(-9.0, -6.0, 5.0));
	blockB.b[3][0][3].mA = (false);
	blockB.b[3][0][3].mB = (mat3(-5.0, 7.0, 6.0, -4.0, -5.0, 9.0, 8.0, 3.0, 3.0));
	blockB.b[3][0][3].mC = f16vec3(vec3(-3.0, -8.0, -6.0));
	blockB.b[3][0][4].mA = (false);
	blockB.b[3][0][4].mB = (mat3(-1.0, 2.0, 7.0, -1.0, -2.0, -1.0, -6.0, -8.0, 8.0));
	blockB.b[3][0][4].mC = f16vec3(vec3(-1.0, -1.0, 6.0));
	blockB.b[3][0][5].mA = (false);
	blockB.b[3][0][5].mB = (mat3(5.0, 8.0, 7.0, -7.0, 4.0, -6.0, 0.0, -2.0, 8.0));
	blockB.b[3][0][5].mC = f16vec3(vec3(2.0, 2.0, 3.0));
	blockB.b[3][1][0].mA = (true);
	blockB.b[3][1][0].mB = (mat3(-5.0, 4.0, 9.0, 8.0, -9.0, 2.0, -3.0, 1.0, -7.0));
	blockB.b[3][1][0].mC = f16vec3(vec3(8.0, 2.0, 0.0));
	blockB.b[3][1][1].mA = (true);
	blockB.b[3][1][1].mB = (mat3(4.0, -8.0, -1.0, 7.0, 8.0, -4.0, -6.0, 4.0, -6.0));
	blockB.b[3][1][1].mC = f16vec3(vec3(7.0, 1.0, 1.0));
	blockB.b[3][1][2].mA = (true);
	blockB.b[3][1][2].mB = (mat3(-6.0, 2.0, 2.0, 7.0, -8.0, -4.0, 4.0, -4.0, 1.0));
	blockB.b[3][1][2].mC = f16vec3(vec3(-2.0, -6.0, 3.0));
	blockB.b[3][1][3].mA = (true);
	blockB.b[3][1][3].mB = (mat3(1.0, -8.0, 8.0, -1.0, 9.0, -2.0, -8.0, -8.0, 8.0));
	blockB.b[3][1][3].mC = f16vec3(vec3(9.0, -9.0, -6.0));
	blockB.b[3][1][4].mA = (true);
	blockB.b[3][1][4].mB = (mat3(3.0, 8.0, -5.0, 2.0, 9.0, 6.0, 5.0, -9.0, 5.0));
	blockB.b[3][1][4].mC = f16vec3(vec3(-6.0, 4.0, 8.0));
	blockB.b[3][1][5].mA = (false);
	blockB.b[3][1][5].mB = (mat3(8.0, -6.0, 3.0, 5.0, -5.0, 8.0, 8.0, 2.0, -5.0));
	blockB.b[3][1][5].mC = f16vec3(vec3(-8.0, 8.0, -6.0));
	blockB.b[4][0][0].mA = (false);
	blockB.b[4][0][0].mB = (mat3(-6.0, -9.0, -7.0, 6.0, 7.0, 5.0, -1.0, 5.0, -3.0));
	blockB.b[4][0][0].mC = f16vec3(vec3(8.0, 2.0, -1.0));
	blockB.b[4][0][1].mA = (true);
	blockB.b[4][0][1].mB = (mat3(-8.0, -6.0, 7.0, 6.0, -1.0, 4.0, -5.0, 4.0, 6.0));
	blockB.b[4][0][1].mC = f16vec3(vec3(-5.0, -3.0, -7.0));
	blockB.b[4][0][2].mA = (true);
	blockB.b[4][0][2].mB = (mat3(-3.0, -4.0, 8.0, 2.0, -7.0, 5.0, 3.0, 8.0, -6.0));
	blockB.b[4][0][2].mC = f16vec3(vec3(1.0, 4.0, -6.0));
	blockB.b[4][0][3].mA = (false);
	blockB.b[4][0][3].mB = (mat3(-4.0, -6.0, 4.0, 6.0, 3.0, -7.0, -4.0, -5.0, 4.0));
	blockB.b[4][0][3].mC = f16vec3(vec3(4.0, 3.0, -2.0));
	blockB.b[4][0][4].mA = (true);
	blockB.b[4][0][4].mB = (mat3(-6.0, -3.0, 3.0, 9.0, 0.0, -8.0, 8.0, 8.0, 0.0));
	blockB.b[4][0][4].mC = f16vec3(vec3(-9.0, -9.0, 5.0));
	blockB.b[4][0][5].mA = (true);
	blockB.b[4][0][5].mB = (mat3(-8.0, 6.0, -6.0, -2.0, 7.0, -9.0, 0.0, -7.0, -9.0));
	blockB.b[4][0][5].mC = f16vec3(vec3(8.0, -2.0, 3.0));
	blockB.b[4][1][0].mA = (false);
	blockB.b[4][1][0].mB = (mat3(-8.0, -1.0, 5.0, 2.0, -7.0, -4.0, 2.0, -6.0, -3.0));
	blockB.b[4][1][0].mC = f16vec3(vec3(0.0, 2.0, -8.0));
	blockB.b[4][1][1].mA = (false);
	blockB.b[4][1][1].mB = (mat3(3.0, -3.0, 5.0, -7.0, 2.0, -8.0, -9.0, 1.0, -9.0));
	blockB.b[4][1][1].mC = f16vec3(vec3(6.0, -4.0, 4.0));
	blockB.b[4][1][2].mA = (true);
	blockB.b[4][1][2].mB = (mat3(-3.0, -6.0, 4.0, -4.0, 1.0, -1.0, 4.0, 0.0, -8.0));
	blockB.b[4][1][2].mC = f16vec3(vec3(-3.0, 9.0, -9.0));
	blockB.b[4][1][3].mA = (false);
	blockB.b[4][1][3].mB = (mat3(9.0, 5.0, 7.0, 6.0, -9.0, -6.0, 2.0, 4.0, -4.0));
	blockB.b[4][1][3].mC = f16vec3(vec3(-7.0, 1.0, -7.0));
	blockB.b[4][1][4].mA = (false);
	blockB.b[4][1][4].mB = (mat3(5.0, -3.0, 4.0, -2.0, 5.0, 9.0, 0.0, 6.0, 4.0));
	blockB.b[4][1][4].mC = f16vec3(vec3(3.0, 7.0, 1.0));
	blockB.b[4][1][5].mA = (false);
	blockB.b[4][1][5].mB = (mat3(5.0, -3.0, 2.0, -1.0, -8.0, 6.0, -8.0, -7.0, -7.0));
	blockB.b[4][1][5].mC = f16vec3(vec3(-6.0, 1.0, 3.0));
	blockC.d[0] = u16vec4(uvec4(8u, 0u, 9u, 1u));
	blockC.d[1] = u16vec4(uvec4(8u, 9u, 1u, 7u));
	blockC.d[2] = u16vec4(uvec4(7u, 6u, 0u, 4u));
	blockC.d[3] = u16vec4(uvec4(0u, 6u, 8u, 7u));
	blockC.d[4] = u16vec4(uvec4(5u, 8u, 1u, 6u));
	blockD.e = (mat3(-2.0, -8.0, 3.0, 0.0, -2.0, -5.0, -5.0, -2.0, -4.0));
	blockE.g = uint16_t(0u);
	blockE.h = (false);
	blockE.i[0] = int16_t(3);
}
#version 450
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
	mediump ivec2 mB;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	u16vec3 a;
	uint16_t b;
	mediump mat3 c;
	f16vec4 d;
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	sA e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB[0].a), uvec3(8u, 2u, 7u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[0].d), vec4(-7.0, 9.0, -3.0, -8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[0].mA), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((blockC.e[0].mB), ivec2(2, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[1].mA), ivec2(-1, -3)) && allOk;
	allOk = compare_ivec2((blockC.e[1].mB), ivec2(8, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[2].mA), ivec2(0, -1)) && allOk;
	allOk = compare_ivec2((blockC.e[2].mB), ivec2(4, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[3].mA), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((blockC.e[3].mB), ivec2(-1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[4].mA), ivec2(6, 9)) && allOk;
	allOk = compare_ivec2((blockC.e[4].mB), ivec2(-8, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[5].mA), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((blockC.e[5].mB), ivec2(5, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[6].mA), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((blockC.e[6].mB), ivec2(-3, 9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e[7].mA), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((blockC.e[7].mB), ivec2(1, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u16vec3(uvec3(9u, 2u, 1u));
	blockB[0].b = uint16_t(0u);
	blockB[0].c = (mat3(1.0, -4.0, -2.0, -7.0, -6.0, 4.0, -4.0, -5.0, -2.0));
	blockB[0].d = f16vec4(vec4(5.0, -9.0, -3.0, -1.0));
}
#version 450
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
	layout(offset = 4) f16vec2 b;
	layout(offset = 8) uint16_t c;
	layout(offset = 10) int16_t d;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) u16vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(9.0, -7.0)) && allOk;
	allOk = compare_int16_t(int(blockB.d), -4) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e), uvec2(6u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].e), uvec2(4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.c = uint16_t(9u);
	blockB.d = int16_t(-7);
}
#version 450
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
	layout(offset = 16) highp vec4 b;
	layout(offset = 32) highp uvec3 c;
	layout(offset = 48) f16vec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec2 e;
	layout(offset = 16) bvec4 f[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-4.0, -9.0, 0.0, -2.0)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(5u, 4u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(8u, 0u, 3u));
	blockB.c = (uvec3(7u, 8u, 8u));
	blockB.d = f16vec4(vec4(-8.0, 5.0, -1.0, -9.0));
	blockC.e = (uvec2(2u, 6u));
	blockC.f[0] = (bvec4(true, true, true, true));
}
#version 450
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
	mediump float a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	u16vec4 b;
	mediump vec2 c;
	uint16_t d;
	highp ivec2 e;
	mediump float f;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	i16vec4 g;
	i16vec2 h[4];
	bvec2 i[3];
	u16vec4 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a[0]), 7.0) && allOk;
	allOk = compare_float((blockB[0].a[1]), -4.0) && allOk;
	allOk = compare_float((blockB[0].a[2]), 4.0) && allOk;
	allOk = compare_float((blockB[0].a[3]), 3.0) && allOk;
	allOk = compare_float((blockB[0].a[4]), 7.0) && allOk;
	allOk = compare_float((blockB[1].a[0]), -3.0) && allOk;
	allOk = compare_float((blockB[1].a[1]), 2.0) && allOk;
	allOk = compare_float((blockB[1].a[2]), -1.0) && allOk;
	allOk = compare_float((blockB[1].a[3]), 9.0) && allOk;
	allOk = compare_float((blockB[1].a[4]), -8.0) && allOk;
	allOk = compare_float((blockB[1].a[5]), 0.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.b), uvec4(5u, 3u, 8u, 6u)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC.d), 1u) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(2, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.g), ivec4(-6, -5, -6, -1)) && allOk;
	allOk = compare_bvec2((blockD.i[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.i[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.i[2]), bvec2(true, false)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.j), uvec4(2u, 0u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7.0);
	blockB[0].a[1] = (-2.0);
	blockB[0].a[2] = (8.0);
	blockB[0].a[3] = (-4.0);
	blockB[0].a[4] = (-8.0);
	blockB[1].a[0] = (5.0);
	blockB[1].a[1] = (3.0);
	blockB[1].a[2] = (3.0);
	blockB[1].a[3] = (9.0);
	blockB[1].a[4] = (-4.0);
	blockB[1].a[5] = (3.0);
	blockC.b = u16vec4(uvec4(8u, 4u, 0u, 5u));
	blockC.c = (vec2(2.0, -8.0));
	blockC.d = uint16_t(9u);
	blockC.f = (6.0);
	blockD.h[0] = i16vec2(ivec2(-6, -5));
	blockD.h[1] = i16vec2(ivec2(-4, -2));
	blockD.h[2] = i16vec2(ivec2(-5, 9));
	blockD.h[3] = i16vec2(ivec2(-5, -6));
	blockD.i[0] = (bvec2(true, false));
	blockD.i[1] = (bvec2(false, false));
	blockD.i[2] = (bvec2(false, true));
	blockD.j = u16vec4(uvec4(4u, 5u, 6u, 6u));
}
#version 450
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
	highp vec2 a;
	highp uint b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec2(-7.0, 3.0));
	blockB[nonuniformEXT(0)].b = (0u);
	blockB[nonuniformEXT(1)].a = (vec2(-7.0, -4.0));
	blockB[nonuniformEXT(1)].b = (4u);
	blockB[nonuniformEXT(2)].a = (vec2(9.0, -4.0));
	blockB[nonuniformEXT(2)].b = (6u);
}
#version 450
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
	layout(offset = 0) lowp uvec3 a[1];
	layout(offset = 16) highp mat4 b;
	layout(offset = 80) f16vec4 c;
	layout(offset = 88) highp vec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].a[0]), uvec3(3u, 1u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(0)].c), vec4(5.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].d), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].a[0]), uvec3(6u, 5u, 0u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(1)].c), vec4(3.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].d), vec2(-1.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].a[0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(2)].c), vec4(-6.0, -2.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].d), vec2(1.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].a[0]), uvec3(3u, 3u, 1u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(3)].c), vec4(3.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].d), vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4(-7.0, 6.0, 5.0, 0.0, -8.0, -5.0, 2.0, 9.0, 8.0, -5.0, -4.0, 3.0, 4.0, -7.0, -8.0, 1.0));
	blockB[nonuniformEXT(0)].d = (vec2(9.0, 3.0));
	blockB[nonuniformEXT(1)].b = (mat4(5.0, 5.0, 4.0, 7.0, -2.0, 0.0, -9.0, -1.0, -7.0, -1.0, -1.0, -7.0, -2.0, 5.0, -1.0, 7.0));
	blockB[nonuniformEXT(1)].d = (vec2(5.0, 8.0));
	blockB[nonuniformEXT(2)].b = (mat4(-1.0, -2.0, -3.0, -1.0, 2.0, -8.0, 3.0, -1.0, -8.0, 1.0, -6.0, 1.0, -1.0, -7.0, 1.0, 2.0));
	blockB[nonuniformEXT(2)].d = (vec2(-2.0, 8.0));
	blockB[nonuniformEXT(3)].b = (mat4(3.0, 5.0, 2.0, 9.0, 1.0, -1.0, -7.0, -6.0, -5.0, 0.0, -7.0, -8.0, -2.0, -2.0, -7.0, 6.0));
	blockB[nonuniformEXT(3)].d = (vec2(-9.0, 9.0));
}
#version 450
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
	u8vec2 a;
	int8_t b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	u8vec3 c;
	lowp mat3 d;
	mediump float e;
	highp vec2 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat2x3 g;
	highp uvec3 h;
	lowp int i[1];
	bool j;
	highp ivec2 k[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(8u, 0u)) && allOk;
	allOk = compare_int8_t(int(blockB.b[0]), 4294967288) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_mat3(blockC.d, mat3(-6.0, -4.0, 4.0, 1.0, -3.0, 9.0, 9.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(0u, 7u));
	blockB.b[0] = int8_t(0);
	blockC.c = u8vec3(uvec3(6u, 7u, 2u));
	blockC.d = (mat3(-7.0, -4.0, -2.0, 6.0, -6.0, 5.0, -8.0, 3.0, -2.0));
	blockC.e = (6.0);
	blockC.f[0] = (vec2(7.0, -5.0));
	blockD.h = (uvec3(7u, 4u, 2u));
	blockD.i[0] = (-7);
}
#version 450
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
	mediump mat3x2 mB;
};
struct sB
{
	uint8_t mA;
	highp mat4 mB;
	lowp uvec3 mC;
	sA mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	highp uvec3 b;
	mediump ivec2 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec4 d;
	lowp vec3 e;
	mediump mat4 f;
	highp mat3x2 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump uvec2 h;
	mediump float i[1];
	lowp mat3x4 j;
	u8vec2 k[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	uint8_t l;
	lowp uvec4 m;
	sB n[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_ivec2((blockB.c[0]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((blockB.c[1]), ivec2(8, 7)) && allOk;
	allOk = compare_ivec2((blockB.c[2]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((blockB.c[3]), ivec2(2, 9)) && allOk;
	allOk = compare_ivec2((blockB.c[4]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((blockB.c[5]), ivec2(7, 3)) && allOk;
	allOk = compare_ivec2((blockB.c[6]), ivec2(-3, 7)) && allOk;
	allOk = compare_ivec2((blockB.c[7]), ivec2(4, -2)) && allOk;
	allOk = compare_bvec4((blockC.d), bvec4(false, false, true, false)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC.f, mat4(-3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(2u, 7u)) && allOk;
	allOk = compare_float((blockD.i[0]), 6.0) && allOk;
	allOk = compare_uint8_t(uint(blockE.l), 9u) && allOk;
	allOk = compare_uvec4((blockE.m), uvec4(0u, 3u, 7u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (uvec3(0u, 4u, 9u));
	blockC.d = (bvec4(false, false, false, true));
	blockC.e = (vec3(7.0, -9.0, -5.0));
	blockC.f = (mat4(5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0, -8.0, 4.0, 8.0, 5.0, 3.0, 5.0, -4.0));
	blockC.g[0] = (mat3x2(8.0, 8.0, 0.0, -8.0, 1.0, -8.0));
	blockC.g[1] = (mat3x2(2.0, -7.0, -2.0, 2.0, -5.0, -5.0));
	blockC.g[2] = (mat3x2(-8.0, -6.0, -3.0, -6.0, -4.0, -7.0));
	blockC.g[3] = (mat3x2(7.0, 6.0, 9.0, -9.0, 3.0, 4.0));
	blockC.g[4] = (mat3x2(2.0, -6.0, 4.0, -6.0, -4.0, -8.0));
	blockD.h = (uvec2(5u, 5u));
	blockD.i[0] = (3.0);
	blockD.k[0] = u8vec2(uvec2(6u, 7u));
	blockD.k[1] = u8vec2(uvec2(8u, 0u));
	blockD.k[2] = u8vec2(uvec2(3u, 3u));
	blockD.k[3] = u8vec2(uvec2(8u, 6u));
	blockD.k[4] = u8vec2(uvec2(1u, 5u));
	blockD.k[5] = u8vec2(uvec2(5u, 5u));
	blockE.l = uint8_t(1u);
	blockE.m = (uvec4(7u, 9u, 9u, 0u));
}
#version 450
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
	uint8_t mB;
};
struct sB
{
	mediump ivec4 mA;
	i8vec2 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	sB b;
	mediump mat2x3 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	int8_t d;
	lowp uvec4 e;
	mediump mat2x3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a.mA), ivec3(8, -5, -1)) && allOk;
	allOk = compare_uint8_t(uint(blockB.a.mB), 9u) && allOk;
	allOk = compare_int8_t(int(blockC[0].d), 8) && allOk;
	allOk = compare_mat2x3(blockC[0].f[0], mat2x3(4.0, -6.0, 0.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[1], mat2x3(4.0, 6.0, 4.0, -1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[2], mat2x3(1.0, 6.0, -6.0, 6.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[3], mat2x3(-6.0, -1.0, -3.0, 3.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[4], mat2x3(-4.0, 4.0, 9.0, -8.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[5], mat2x3(-2.0, 8.0, 3.0, -2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[6], mat2x3(0.0, -3.0, -5.0, -6.0, 8.0, 6.0)) && allOk;
	allOk = compare_int8_t(int(blockC[1].d), 4294967289) && allOk;
	allOk = compare_mat2x3(blockC[1].f[0], mat2x3(6.0, 7.0, -2.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[1], mat2x3(6.0, 4.0, 7.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[2], mat2x3(-9.0, 5.0, 0.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[3], mat2x3(-4.0, -4.0, -2.0, 1.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[4], mat2x3(-2.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[5], mat2x3(4.0, 1.0, -8.0, -1.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[6], mat2x3(-2.0, 0.0, 4.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[7], mat2x3(5.0, -2.0, -5.0, 0.0, 8.0, 2.0)) && allOk;
	allOk = compare_int8_t(int(blockC[2].d), 4294967295) && allOk;
	allOk = compare_mat2x3(blockC[2].f[0], mat2x3(9.0, 4.0, -8.0, -2.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockC[2].f[1], mat2x3(-9.0, 4.0, 2.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC[2].f[2], mat2x3(7.0, -5.0, 9.0, -3.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (ivec3(8, 2, -4));
	blockB.a.mB = uint8_t(4u);
	blockB.b.mA = (ivec4(-3, 7, -3, 4));
	blockB.b.mB = i8vec2(ivec2(3, 4294967287));
	blockC[0].f[0] = (mat2x3(-1.0, 4.0, -1.0, 1.0, -4.0, -7.0));
	blockC[0].f[1] = (mat2x3(1.0, 2.0, 8.0, -5.0, 6.0, -7.0));
	blockC[0].f[2] = (mat2x3(5.0, -6.0, 5.0, 3.0, 1.0, -2.0));
	blockC[0].f[3] = (mat2x3(-6.0, -1.0, -7.0, -6.0, 7.0, 0.0));
	blockC[0].f[4] = (mat2x3(1.0, -3.0, 5.0, -7.0, -9.0, -1.0));
	blockC[0].f[5] = (mat2x3(-9.0, -4.0, -5.0, 7.0, 9.0, -3.0));
	blockC[0].f[6] = (mat2x3(4.0, -6.0, 6.0, 7.0, -4.0, 1.0));
	blockC[1].f[0] = (mat2x3(-7.0, -9.0, 0.0, 9.0, 9.0, 5.0));
	blockC[1].f[1] = (mat2x3(-2.0, -1.0, -4.0, 8.0, -7.0, -8.0));
	blockC[1].f[2] = (mat2x3(6.0, 9.0, -8.0, -1.0, -7.0, 3.0));
	blockC[1].f[3] = (mat2x3(2.0, -3.0, 0.0, -1.0, -2.0, 6.0));
	blockC[1].f[4] = (mat2x3(-8.0, -8.0, 1.0, 7.0, 1.0, -4.0));
	blockC[1].f[5] = (mat2x3(-4.0, 6.0, 3.0, -5.0, 2.0, 8.0));
	blockC[1].f[6] = (mat2x3(-2.0, 7.0, 0.0, 3.0, 6.0, -8.0));
	blockC[1].f[7] = (mat2x3(4.0, 6.0, 6.0, 3.0, 5.0, 7.0));
	blockC[2].f[0] = (mat2x3(1.0, 3.0, -8.0, 2.0, 9.0, -7.0));
	blockC[2].f[1] = (mat2x3(8.0, -9.0, 9.0, 4.0, -2.0, 7.0));
	blockC[2].f[2] = (mat2x3(8.0, -7.0, 3.0, 9.0, 5.0, -1.0));
}
#version 450
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
	layout(offset = 0) uint8_t a;
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) i8vec2 c;
	layout(offset = 36) mediump uvec2 d;
	layout(offset = 44) u8vec2 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i8vec2 f;
	layout(offset = 4) lowp ivec2 g;
	layout(offset = 16) bvec4 h;
	layout(offset = 32) highp uint i;
	layout(offset = 36) lowp uint j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(4294967292, 4)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(0u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.e), uvec2(1u, 7u)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(6, 3)) && allOk;
	allOk = compare_uint((blockC.i), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(4u);
	blockB.b = (uvec4(0u, 2u, 8u, 3u));
	blockB.c = i8vec2(ivec2(2, 4294967291));
	blockB.d = (uvec2(2u, 5u));
	blockC.f = i8vec2(ivec2(4, 4294967288));
	blockC.h = (bvec4(true, false, true, true));
	blockC.i = (0u);
	blockC.j = (6u);
}
#version 450
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
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) mediump ivec2 b;
	layout(offset = 16) bvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockC.b), ivec2(0, -5)) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(2.0, -9.0));
}
#version 450
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
	highp uint b;
	highp ivec3 c;
	highp mat3x4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].a, mat4(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].d, mat3x4(-4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].a, mat4(0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].d, mat3x4(-7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0, -8.0, -4.0, -6.0, 3.0, -2.0, 5.0, -2.0, 6.0));
	blockB[nonuniformEXT(0)].c = (ivec3(-5, -5, -2));
	blockB[nonuniformEXT(0)].d = (mat3x4(-2.0, 7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0));
	blockB[nonuniformEXT(1)].a = (mat4(8.0, 4.0, -4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0));
	blockB[nonuniformEXT(1)].c = (ivec3(6, 8, 9));
	blockB[nonuniformEXT(1)].d = (mat3x4(0.0, -7.0, -6.0, -3.0, 8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0));
}
