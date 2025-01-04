#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp int var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((var[0][0]), 0);
	result *= compare_int((var[0][1]), 0);
	result *= compare_int((var[0][2]), 0);
	result *= compare_int((var[0][3]), 0);
	result *= compare_int((var[1][0]), 0);
	result *= compare_int((var[1][1]), 0);
	result *= compare_int((var[1][2]), 0);
	result *= compare_int((var[1][3]), 0);
	result *= compare_int((var[2][0]), 0);
	result *= compare_int((var[2][1]), 0);
	result *= compare_int((var[2][2]), 0);
	result *= compare_int((var[2][3]), 0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp int var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((var[0][0]), 0);
	result *= compare_int((var[0][1]), 0);
	result *= compare_int((var[0][2]), 0);
	result *= compare_int((var[0][3]), 0);
	result *= compare_int((var[1][0]), 0);
	result *= compare_int((var[1][1]), 0);
	result *= compare_int((var[1][2]), 0);
	result *= compare_int((var[1][3]), 0);
	result *= compare_int((var[2][0]), 0);
	result *= compare_int((var[2][1]), 0);
	result *= compare_int((var[2][2]), 0);
	result *= compare_int((var[2][3]), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var[0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3]), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((var[0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat3x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((var[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat3x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((var[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((var[0][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x2((var[0][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat4x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec3 var[3][4];
};

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec3(ivec3(var[0][0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[0][1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[0][2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[0][3]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][3]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][3]), ivec3(0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec3 var[3][4];
};

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec3(ivec3(var[0][0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[0][1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[0][2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[0][3]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1][3]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2][3]), ivec3(0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	float16_t var[3][4];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(var[0][0]), 0.0);
	result *= compare_float16_t(float(var[0][1]), 0.0);
	result *= compare_float16_t(float(var[0][2]), 0.0);
	result *= compare_float16_t(float(var[0][3]), 0.0);
	result *= compare_float16_t(float(var[1][0]), 0.0);
	result *= compare_float16_t(float(var[1][1]), 0.0);
	result *= compare_float16_t(float(var[1][2]), 0.0);
	result *= compare_float16_t(float(var[1][3]), 0.0);
	result *= compare_float16_t(float(var[2][0]), 0.0);
	result *= compare_float16_t(float(var[2][1]), 0.0);
	result *= compare_float16_t(float(var[2][2]), 0.0);
	result *= compare_float16_t(float(var[2][3]), 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec3 var[3][4];
};

mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec3((var[0][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][3]), bvec3(false, false, false));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec3 var[3][4];
};

mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec3((var[0][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][3]), bvec3(false, false, false));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((var[0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((var[0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((var[0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x4((var[0][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][3]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][3]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][3]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat4x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat4x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat4x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec4 var[3][4];
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(var[0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][3]), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec4 var[3][4];
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(var[0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][3]), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(var[0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][3]), vec4(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(var[0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][3]), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_vec2((var[0][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][2]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][3]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][2]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][3]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][2]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][3]), vec2(0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp int var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_int((var[0][0]), 0);
	result *= compare_int((var[0][1]), 0);
	result *= compare_int((var[0][2]), 0);
	result *= compare_int((var[0][3]), 0);
	result *= compare_int((var[1][0]), 0);
	result *= compare_int((var[1][1]), 0);
	result *= compare_int((var[1][2]), 0);
	result *= compare_int((var[1][3]), 0);
	result *= compare_int((var[2][0]), 0);
	result *= compare_int((var[2][1]), 0);
	result *= compare_int((var[2][2]), 0);
	result *= compare_int((var[2][3]), 0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp int var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_int((var[0][0]), 0);
	result *= compare_int((var[0][1]), 0);
	result *= compare_int((var[0][2]), 0);
	result *= compare_int((var[0][3]), 0);
	result *= compare_int((var[1][0]), 0);
	result *= compare_int((var[1][1]), 0);
	result *= compare_int((var[1][2]), 0);
	result *= compare_int((var[1][3]), 0);
	result *= compare_int((var[2][0]), 0);
	result *= compare_int((var[2][1]), 0);
	result *= compare_int((var[2][2]), 0);
	result *= compare_int((var[2][3]), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp int var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((var[0][0]), 0);
	result *= compare_int((var[0][1]), 0);
	result *= compare_int((var[0][2]), 0);
	result *= compare_int((var[0][3]), 0);
	result *= compare_int((var[1][0]), 0);
	result *= compare_int((var[1][1]), 0);
	result *= compare_int((var[1][2]), 0);
	result *= compare_int((var[1][3]), 0);
	result *= compare_int((var[2][0]), 0);
	result *= compare_int((var[2][1]), 0);
	result *= compare_int((var[2][2]), 0);
	result *= compare_int((var[2][3]), 0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp int var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((var[0][0]), 0);
	result *= compare_int((var[0][1]), 0);
	result *= compare_int((var[0][2]), 0);
	result *= compare_int((var[0][3]), 0);
	result *= compare_int((var[1][0]), 0);
	result *= compare_int((var[1][1]), 0);
	result *= compare_int((var[1][2]), 0);
	result *= compare_int((var[1][3]), 0);
	result *= compare_int((var[2][0]), 0);
	result *= compare_int((var[2][1]), 0);
	result *= compare_int((var[2][2]), 0);
	result *= compare_int((var[2][3]), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec3 var[3][4];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
	result *= compare_bvec3((var[0][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][3]), bvec3(false, false, false));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec3 var[3][4];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
	result *= compare_bvec3((var[0][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][3]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][2]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][3]), bvec3(false, false, false));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3((var[0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3((var[0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((var[0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x3((var[0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x2((var[0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((var[0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x2((var[0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x4((var[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((var[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat3x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x4((var[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat4x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((var[0][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat4x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4x3((var[0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec2 var[3][4];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(var[0][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][3]), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec2 var[3][4];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
	result *= compare_i8vec2(ivec2(var[0][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][3]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][3]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][3]), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec2 var[3][4];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
	result *= compare_i8vec2(ivec2(var[0][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][3]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][3]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][3]), ivec2(0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec4 var[3][4];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
	result *= compare_i8vec4(ivec4(var[0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][3]), ivec4(0, 0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec4 var[3][4];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(var[0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][3]), ivec4(0, 0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t padding;
	i16vec4 var[3][4];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(var[0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][3]), ivec4(0, 0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t padding;
	f16vec4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec4(vec4(var[0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][3]), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uvec4 var[3][4][2];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec4((var[0][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][3][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][3][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][3][1]), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((var[0][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(var[0][0][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][0][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][1][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][1][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][2][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][2][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][3][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][3][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][0][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][0][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][1][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][1][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][2][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][2][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][3][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][3][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][0][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][0][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][1][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][1][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][2][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][2][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][3][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][3][1]), vec2(0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp int var[3][4][2];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((var[0][0][0]), 0);
	result *= compare_int((var[0][0][1]), 0);
	result *= compare_int((var[0][1][0]), 0);
	result *= compare_int((var[0][1][1]), 0);
	result *= compare_int((var[0][2][0]), 0);
	result *= compare_int((var[0][2][1]), 0);
	result *= compare_int((var[0][3][0]), 0);
	result *= compare_int((var[0][3][1]), 0);
	result *= compare_int((var[1][0][0]), 0);
	result *= compare_int((var[1][0][1]), 0);
	result *= compare_int((var[1][1][0]), 0);
	result *= compare_int((var[1][1][1]), 0);
	result *= compare_int((var[1][2][0]), 0);
	result *= compare_int((var[1][2][1]), 0);
	result *= compare_int((var[1][3][0]), 0);
	result *= compare_int((var[1][3][1]), 0);
	result *= compare_int((var[2][0][0]), 0);
	result *= compare_int((var[2][0][1]), 0);
	result *= compare_int((var[2][1][0]), 0);
	result *= compare_int((var[2][1][1]), 0);
	result *= compare_int((var[2][2][0]), 0);
	result *= compare_int((var[2][2][1]), 0);
	result *= compare_int((var[2][3][0]), 0);
	result *= compare_int((var[2][3][1]), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uint var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((var[0][0][0]), 0u);
	result *= compare_uint((var[0][0][1]), 0u);
	result *= compare_uint((var[0][1][0]), 0u);
	result *= compare_uint((var[0][1][1]), 0u);
	result *= compare_uint((var[0][2][0]), 0u);
	result *= compare_uint((var[0][2][1]), 0u);
	result *= compare_uint((var[0][3][0]), 0u);
	result *= compare_uint((var[0][3][1]), 0u);
	result *= compare_uint((var[1][0][0]), 0u);
	result *= compare_uint((var[1][0][1]), 0u);
	result *= compare_uint((var[1][1][0]), 0u);
	result *= compare_uint((var[1][1][1]), 0u);
	result *= compare_uint((var[1][2][0]), 0u);
	result *= compare_uint((var[1][2][1]), 0u);
	result *= compare_uint((var[1][3][0]), 0u);
	result *= compare_uint((var[1][3][1]), 0u);
	result *= compare_uint((var[2][0][0]), 0u);
	result *= compare_uint((var[2][0][1]), 0u);
	result *= compare_uint((var[2][1][0]), 0u);
	result *= compare_uint((var[2][1][1]), 0u);
	result *= compare_uint((var[2][2][0]), 0u);
	result *= compare_uint((var[2][2][1]), 0u);
	result *= compare_uint((var[2][3][0]), 0u);
	result *= compare_uint((var[2][3][1]), 0u);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec2 var[3][4][2];
};

mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec2((var[0][0][0]), bvec2(false, false));
	result *= compare_bvec2((var[0][0][1]), bvec2(false, false));
	result *= compare_bvec2((var[0][1][0]), bvec2(false, false));
	result *= compare_bvec2((var[0][1][1]), bvec2(false, false));
	result *= compare_bvec2((var[0][2][0]), bvec2(false, false));
	result *= compare_bvec2((var[0][2][1]), bvec2(false, false));
	result *= compare_bvec2((var[0][3][0]), bvec2(false, false));
	result *= compare_bvec2((var[0][3][1]), bvec2(false, false));
	result *= compare_bvec2((var[1][0][0]), bvec2(false, false));
	result *= compare_bvec2((var[1][0][1]), bvec2(false, false));
	result *= compare_bvec2((var[1][1][0]), bvec2(false, false));
	result *= compare_bvec2((var[1][1][1]), bvec2(false, false));
	result *= compare_bvec2((var[1][2][0]), bvec2(false, false));
	result *= compare_bvec2((var[1][2][1]), bvec2(false, false));
	result *= compare_bvec2((var[1][3][0]), bvec2(false, false));
	result *= compare_bvec2((var[1][3][1]), bvec2(false, false));
	result *= compare_bvec2((var[2][0][0]), bvec2(false, false));
	result *= compare_bvec2((var[2][0][1]), bvec2(false, false));
	result *= compare_bvec2((var[2][1][0]), bvec2(false, false));
	result *= compare_bvec2((var[2][1][1]), bvec2(false, false));
	result *= compare_bvec2((var[2][2][0]), bvec2(false, false));
	result *= compare_bvec2((var[2][2][1]), bvec2(false, false));
	result *= compare_bvec2((var[2][3][0]), bvec2(false, false));
	result *= compare_bvec2((var[2][3][1]), bvec2(false, false));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var[0][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((var[0][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var[0][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((var[0][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((var[0][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((var[0][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x4((var[0][0][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][0][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][1][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][1][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][2][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][2][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][3][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][3][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][0][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][0][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][1][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][1][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][2][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][2][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][3][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][3][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][0][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][0][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][1][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][1][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][2][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][2][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][3][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][3][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((var[0][0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][3][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[0][3][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][3][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1][3][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][0][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][1][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][2][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][3][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2][3][1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec2 var[3][4][2];
};

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(var[0][0][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][0][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][1][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][1][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][2][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][2][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][3][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][3][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][0][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][0][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][1][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][1][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][2][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][2][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][3][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][3][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][0][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][0][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][1][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][1][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][2][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][2][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][3][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][3][1]), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec2 var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec2((var[0][0][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][0][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][1][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][1][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][2][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][2][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][3][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][3][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][0][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][0][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][1][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][1][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][2][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][2][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][3][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][3][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][0][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][0][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][1][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][1][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][2][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][2][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][3][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][3][1]), uvec2(0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec4 var[3][4][2];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((var[0][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[0][0][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[0][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[0][1][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[0][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[0][2][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[0][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[0][3][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][0][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][1][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][2][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1][3][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][0][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][1][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][2][1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2][3][1]), bvec4(false, false, false, false));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var[0][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((var[0][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[0][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][0][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][1][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][2][1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2][3][1]), mat2(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3((var[0][0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3((var[0][0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[0][3][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1][3][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][0][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][1][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][2][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3][0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2][3][1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((var[0][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[0][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][0][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][1][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][2][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2][3][1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x3((var[0][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[0][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][0][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][1][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][2][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2][3][1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x4((var[0][0][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][0][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][1][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][1][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][2][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][2][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][3][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[0][3][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][0][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][0][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][1][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][1][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][2][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][2][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][3][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1][3][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][0][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][0][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][1][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][1][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][2][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][2][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][3][0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2][3][1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x2((var[0][0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][3][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][3][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][3][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][3][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][3][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][3][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((var[0][0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][3][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[0][3][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][3][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1][3][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][0][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][0][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][1][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][1][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][2][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][2][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][3][0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2][3][1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat4x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4x2((var[0][0][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][0][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][1][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][1][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][2][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][2][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][3][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[0][3][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][0][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][0][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][1][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][1][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][2][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][2][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][3][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1][3][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][0][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][0][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][1][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][1][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][2][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][2][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][3][0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2][3][1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat4x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0][0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat4x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0][0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[0][3][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1][3][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][0][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][1][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][2][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3][0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2][3][1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var[3][4][2];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(var[0][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][3][1]), uvec3(0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct S
{
	highp uvec3 a; // unused in both shaders
	mediump mat2 b[4];
	lowp uint c;
};
layout(set = 0, binding = 0, scalar) uniform Block
{
	mediump int u;
	S s[2][3];
	mediump vec2 v;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((s[0][0].c), 0u);
	result *= compare_mat2((s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((s[0][1].c), 0u);
	result *= compare_mat2((s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((s[0][2].c), 0u);
	result *= compare_mat2((s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((s[1][0].c), 0u);
	result *= compare_mat2((s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((s[1][1].c), 0u);
	result *= compare_mat2((s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((s[1][2].c), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct S
{
	highp uvec3 a; // unused in both shaders
	mediump mat2 b[4];
	lowp uint c;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec2 var;
};

mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	uint8_t var;
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec3 var;
};

mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(var), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	u16vec4 var;
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec2 var;
};

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(var), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	float16_t var;
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float16_t(float(var), 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	float16_t var;
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(var), 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(var), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp vec3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp ivec2 var;
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp ivec2 var;
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	lowp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	lowp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	lowp mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x3((var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x3((var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump vec2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump int var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((var), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump ivec4 var;
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec4((var), ivec4(0, 0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump uvec2 var;
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	mediump mat3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3((var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	mediump mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_vec2(var[2], vec2(0.0, 0.0));
	result *= compare_vec2(var[3], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	mediump mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_vec2(var[2], vec2(0.0, 0.0));
	result *= compare_vec2(var[3], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	mediump mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_vec2(var[2], vec2(0.0, 0.0));
	result *= compare_vec2(var[3], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	mediump mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_vec2(var[2], vec2(0.0, 0.0));
	result *= compare_vec2(var[3], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp int var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp ivec2 var;
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec2((var), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec4 var;
};

mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((var), bvec4(false, false, false, false));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec4 var;
};

mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	uint8_t var;
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(var), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	uint8_t var;
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(var), 0u);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	u8vec2 var;
};

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(var), uvec2(0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec4 var;
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec4 var;
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(var), ivec4(0, 0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp vec3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp uvec4 var;
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((var), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp uvec4 var;
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec4((var), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	lowp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3(var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	lowp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	lowp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[2][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	lowp mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_vec2(var[2], vec2(0.0, 0.0));
	result *= compare_vec2(var[3], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	lowp mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump vec2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump vec2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump ivec3 var;
};

mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((var), ivec3(0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	mediump mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3((var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	mediump mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	mediump mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	mediump mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec2 var;
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec3 var;
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec3((var), uvec3(0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec3 var;
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec3((var), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_vec2(var[2], vec2(0.0, 0.0));
	result *= compare_vec2(var[3], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec2 var;
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
	result *= compare_bvec2((var), bvec2(false, false));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec2 var;
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec3 var;
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t var;
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(var), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t var;
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec4 var;
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
	result *= compare_u16vec4(uvec4(var), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec4 var;
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
	result *= compare_u16vec4(uvec4(var), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	lowp float var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((var), 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	lowp uvec3 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	lowp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	lowp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec3(var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	lowp mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	lowp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[2][3], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	mediump float var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((var), 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	mediump uvec2 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec2((var), uvec2(0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	mediump uvec3 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	mediump uvec3 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	mediump uvec4 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	mediump mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[2][3], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
	result *= compare_float(var[3][2], 0.0);
	result *= compare_float(var[3][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	mediump mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[2][3], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
	result *= compare_float(var[3][2], 0.0);
	result *= compare_float(var[3][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	mediump mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec3(var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	mediump mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x4((var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	mediump mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x4((var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	mediump mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4x2((var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	mediump mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4x3((var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec4 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_ivec4((var), ivec4(0, 0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec4 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_ivec4((var), ivec4(0, 0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp uint var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((var), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec3 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec3 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec4 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec4((var), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec4 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec4((var), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[2][3], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
	result *= compare_float(var[3][2], 0.0);
	result *= compare_float(var[3][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[2][3], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
	result *= compare_float(var[3][2], 0.0);
	result *= compare_float(var[3][3], 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[0][3], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[1][3], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[2][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x4((var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec3(var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(var[2], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(var[3], vec3(0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
	result *= compare_float(var[2][0], 0.0);
	result *= compare_float(var[2][1], 0.0);
	result *= compare_float(var[2][2], 0.0);
	result *= compare_float(var[3][0], 0.0);
	result *= compare_float(var[3][1], 0.0);
	result *= compare_float(var[3][2], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uint var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((var[0]), 0u);
	result *= compare_uint((var[1]), 0u);
	result *= compare_uint((var[2]), 0u);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uint var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((var[0]), 0u);
	result *= compare_uint((var[1]), 0u);
	result *= compare_uint((var[2]), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uint var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((var[0]), 0u);
	result *= compare_uint((var[1]), 0u);
	result *= compare_uint((var[2]), 0u);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((var[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat3x2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((var[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat3x4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((var[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec3 var[3];
};

mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec3 var[3];
};

mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	uint16_t var[3];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0]), 0u);
	result *= compare_uint16_t(uint(var[1]), 0u);
	result *= compare_uint16_t(uint(var[2]), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	uint16_t var[3];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0]), 0u);
	result *= compare_uint16_t(uint(var[1]), 0u);
	result *= compare_uint16_t(uint(var[2]), 0u);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	u16vec3 var[3];
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	u16vec3 var[3];
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec4 var[3];
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec4((var[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2]), ivec4(0, 0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec4 var[3];
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec4((var[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2]), ivec4(0, 0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec4 var[3];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2]), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((var[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2x4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x4((var[0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec3 var[3];
};

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec3(ivec3(var[0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2]), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp int var[3];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((var[0]), 0);
	result *= compare_int((var[1]), 0);
	result *= compare_int((var[2]), 0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp int var[3];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((var[0]), 0);
	result *= compare_int((var[1]), 0);
	result *= compare_int((var[2]), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec3 var[3];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_ivec3((var[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2]), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec3 var[3];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((var[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2]), ivec3(0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bool var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bool((var[0]), false);
	result *= compare_bool((var[1]), false);
	result *= compare_bool((var[2]), false);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2x4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x4((var[0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x4((var[0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x4((var[0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat3x2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((var[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4x3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var[3];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec3 var[3];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
	result *= compare_u16vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t padding;
	float16_t var[3];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_float16_t(float(var[0]), 0.0);
	result *= compare_float16_t(float(var[1]), 0.0);
	result *= compare_float16_t(float(var[2]), 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uvec4 var[];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[7]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[8]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[9]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[10]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[11]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[12]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[13]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[14]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[15]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[16]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[17]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[18]), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat2x3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[5]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[6]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[7]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[8]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[9]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[10]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[11]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[12]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[13]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[14]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[15]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[16]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[17]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[18]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2x3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[5]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[6]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[7]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[8]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[9]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[10]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[11]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[12]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[13]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[14]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[15]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[16]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[17]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[18]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat3x2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((var[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[4]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[5]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[6]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[7]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[8]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[9]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[10]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[11]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[12]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[13]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[14]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[15]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[16]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[17]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[18]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4x2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((var[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[4]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[5]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[6]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[7]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[8]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[9]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[10]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[11]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[12]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[13]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[14]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[15]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[16]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[17]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[18]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	uint8_t var[];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(var[0]), 0u);
	result *= compare_uint8_t(uint(var[1]), 0u);
	result *= compare_uint8_t(uint(var[2]), 0u);
	result *= compare_uint8_t(uint(var[3]), 0u);
	result *= compare_uint8_t(uint(var[4]), 0u);
	result *= compare_uint8_t(uint(var[5]), 0u);
	result *= compare_uint8_t(uint(var[6]), 0u);
	result *= compare_uint8_t(uint(var[7]), 0u);
	result *= compare_uint8_t(uint(var[8]), 0u);
	result *= compare_uint8_t(uint(var[9]), 0u);
	result *= compare_uint8_t(uint(var[10]), 0u);
	result *= compare_uint8_t(uint(var[11]), 0u);
	result *= compare_uint8_t(uint(var[12]), 0u);
	result *= compare_uint8_t(uint(var[13]), 0u);
	result *= compare_uint8_t(uint(var[14]), 0u);
	result *= compare_uint8_t(uint(var[15]), 0u);
	result *= compare_uint8_t(uint(var[16]), 0u);
	result *= compare_uint8_t(uint(var[17]), 0u);
	result *= compare_uint8_t(uint(var[18]), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	u16vec3 var[];
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[3]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[4]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[5]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[6]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[7]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[8]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[9]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[10]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[11]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[12]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[13]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[14]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[15]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[16]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[17]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[18]), uvec3(0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec2 var[];
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec2((var[0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2]), uvec2(0u, 0u));
	result *= compare_uvec2((var[3]), uvec2(0u, 0u));
	result *= compare_uvec2((var[4]), uvec2(0u, 0u));
	result *= compare_uvec2((var[5]), uvec2(0u, 0u));
	result *= compare_uvec2((var[6]), uvec2(0u, 0u));
	result *= compare_uvec2((var[7]), uvec2(0u, 0u));
	result *= compare_uvec2((var[8]), uvec2(0u, 0u));
	result *= compare_uvec2((var[9]), uvec2(0u, 0u));
	result *= compare_uvec2((var[10]), uvec2(0u, 0u));
	result *= compare_uvec2((var[11]), uvec2(0u, 0u));
	result *= compare_uvec2((var[12]), uvec2(0u, 0u));
	result *= compare_uvec2((var[13]), uvec2(0u, 0u));
	result *= compare_uvec2((var[14]), uvec2(0u, 0u));
	result *= compare_uvec2((var[15]), uvec2(0u, 0u));
	result *= compare_uvec2((var[16]), uvec2(0u, 0u));
	result *= compare_uvec2((var[17]), uvec2(0u, 0u));
	result *= compare_uvec2((var[18]), uvec2(0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec4 var[];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[7]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[8]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[9]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[10]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[11]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[12]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[13]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[14]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[15]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[16]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[17]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[18]), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec4 var[];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec4((var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[7]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[8]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[9]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[10]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[11]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[12]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[13]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[14]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[15]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[16]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[17]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[18]), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((var[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[4]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[5]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[6]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[7]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[8]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[9]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[10]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[11]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[12]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[13]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[14]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[15]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[16]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[17]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[18]), mat2(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat4 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((var[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[4]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[5]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[6]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[7]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[8]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[9]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[10]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[11]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[12]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[13]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[14]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[15]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[16]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[17]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((var[18]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3x4 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((var[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[4]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[5]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[6]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[7]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[8]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[9]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[10]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[11]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[12]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[13]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[14]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[15]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[16]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[17]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[18]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp uvec2 var[];
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((var[0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2]), uvec2(0u, 0u));
	result *= compare_uvec2((var[3]), uvec2(0u, 0u));
	result *= compare_uvec2((var[4]), uvec2(0u, 0u));
	result *= compare_uvec2((var[5]), uvec2(0u, 0u));
	result *= compare_uvec2((var[6]), uvec2(0u, 0u));
	result *= compare_uvec2((var[7]), uvec2(0u, 0u));
	result *= compare_uvec2((var[8]), uvec2(0u, 0u));
	result *= compare_uvec2((var[9]), uvec2(0u, 0u));
	result *= compare_uvec2((var[10]), uvec2(0u, 0u));
	result *= compare_uvec2((var[11]), uvec2(0u, 0u));
	result *= compare_uvec2((var[12]), uvec2(0u, 0u));
	result *= compare_uvec2((var[13]), uvec2(0u, 0u));
	result *= compare_uvec2((var[14]), uvec2(0u, 0u));
	result *= compare_uvec2((var[15]), uvec2(0u, 0u));
	result *= compare_uvec2((var[16]), uvec2(0u, 0u));
	result *= compare_uvec2((var[17]), uvec2(0u, 0u));
	result *= compare_uvec2((var[18]), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bvec4 var[];
};

mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec4((var[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[3]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[4]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[5]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[6]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[7]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[8]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[9]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[10]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[11]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[12]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[13]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[14]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[15]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[16]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[17]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[18]), bvec4(false, false, false, false));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct S
{
	highp ivec3 a; // unused in both shaders
	mediump mat3 b[4];
	highp vec4 c;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct S
{
	highp ivec3 a; // unused in both shaders
	mediump mat3 b[4];
	highp vec4 c;
};
layout(set = 0, binding = 0, std140) uniform Block
{
	S s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((s.c), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

struct S
{
	highp ivec3 a; // unused in both shaders
	mediump mat3 b[4];
	highp vec4 c;
};
layout(set = 0, binding = 0, std430) uniform Block
{
	S s;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((block[0].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[0].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[0].s.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[1].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[1].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[1].s.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[2].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[2].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[2].s.c), vec4(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c; // unused in both shaders
};
struct T
{
	mediump mat3 a;
	S b;
};
layout(set = 0, binding = 0, scalar) uniform Block
{
	S s;
	lowp vec2 v; // unused in both shaders
	T t;
	highp uint u;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((block[0].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[0].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[0].t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[0].t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[1].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[1].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[1].t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[1].t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[2].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[2].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[2].t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[2].t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c; // unused in both shaders
};
struct T
{
	mediump mat3 a;
	S b;
};
layout(set = 0, binding = 0, scalar) uniform Block
{
	S s;
	lowp vec2 v; // unused in both shaders
	T t;
	highp uint u;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((block[0].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[0].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[0].t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[0].t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[1].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[1].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[1].t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[1].t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[2].s.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[2].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[2].t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((block[2].t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct S
{
	highp ivec3 a;
	mediump ivec2 b[4];
	highp vec4 c; // unused in both shaders
};
struct T
{
	mediump mat3 a;
	S b[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct S
{
	highp ivec3 a;
	mediump ivec2 b[4];
	highp vec4 c; // unused in both shaders
};
struct T
{
	mediump mat3 a;
	S b[3];
};
layout(set = 0, binding = 0, scalar) uniform Block
{
	S s;
	lowp vec2 v; // unused in both shaders
	T t[2];
	highp uint u;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((block[0].s.a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[0].s.b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[0].s.b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[0].s.b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[0].s.b[3]), ivec2(0, 0));
	result *= compare_mat3((block[0].t[0].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[0].t[0].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[0].t[0].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[0].t[0].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(0, 0));
	result *= compare_mat3((block[0].t[1].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[0].t[1].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[0].t[1].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[0].t[1].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[1].s.a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[1].s.b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[1].s.b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[1].s.b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[1].s.b[3]), ivec2(0, 0));
	result *= compare_mat3((block[1].t[0].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[1].t[0].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[1].t[0].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[1].t[0].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(0, 0));
	result *= compare_mat3((block[1].t[1].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[1].t[1].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[1].t[1].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[1].t[1].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[2].s.a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[2].s.b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[2].s.b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[2].s.b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[2].s.b[3]), ivec2(0, 0));
	result *= compare_mat3((block[2].t[0].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[2].t[0].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[2].t[0].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[2].t[0].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(0, 0));
	result *= compare_mat3((block[2].t[1].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((block[2].t[1].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[2].t[1].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((block[2].t[1].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp vec3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp vec3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp int var;
} block[3];

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp int var;
} block[3];

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uint var;
} block[3];

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uvec4 var;
} block[3];

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	bool var;
} block[3];

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	bool var;
} block[3];

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	bool var;
} block[3];

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4(block[0].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[0][3], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_float(block[0].var[1][3], 0.0);
	result *= compare_float(block[0].var[2][0], 0.0);
	result *= compare_float(block[0].var[2][1], 0.0);
	result *= compare_float(block[0].var[2][2], 0.0);
	result *= compare_float(block[0].var[2][3], 0.0);
	result *= compare_float(block[0].var[3][0], 0.0);
	result *= compare_float(block[0].var[3][1], 0.0);
	result *= compare_float(block[0].var[3][2], 0.0);
	result *= compare_float(block[0].var[3][3], 0.0);
	result *= compare_vec4(block[1].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[0][3], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_float(block[1].var[1][3], 0.0);
	result *= compare_float(block[1].var[2][0], 0.0);
	result *= compare_float(block[1].var[2][1], 0.0);
	result *= compare_float(block[1].var[2][2], 0.0);
	result *= compare_float(block[1].var[2][3], 0.0);
	result *= compare_float(block[1].var[3][0], 0.0);
	result *= compare_float(block[1].var[3][1], 0.0);
	result *= compare_float(block[1].var[3][2], 0.0);
	result *= compare_float(block[1].var[3][3], 0.0);
	result *= compare_vec4(block[2].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[0][3], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
	result *= compare_float(block[2].var[1][3], 0.0);
	result *= compare_float(block[2].var[2][0], 0.0);
	result *= compare_float(block[2].var[2][1], 0.0);
	result *= compare_float(block[2].var[2][2], 0.0);
	result *= compare_float(block[2].var[2][3], 0.0);
	result *= compare_float(block[2].var[3][0], 0.0);
	result *= compare_float(block[2].var[3][1], 0.0);
	result *= compare_float(block[2].var[3][2], 0.0);
	result *= compare_float(block[2].var[3][3], 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((block[0].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((block[1].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((block[2].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3(block[0].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[0].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_vec3(block[1].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[1].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_vec3(block[2].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[2].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec3(block[0].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[0].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_vec3(block[1].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[1].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_vec3(block[2].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[2].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((block[0].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[1].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[2].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x2((block[0].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[1].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[2].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((block[0].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[1].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[2].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((block[0].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[1].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[2].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x2((block[0].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[1].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((block[2].var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec2 var;
} block[3];

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec2 var;
} block[3];

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	i8vec3 var;
} block[3];

mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(block[0].var), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(block[1].var), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(block[2].var), ivec3(0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	i8vec3 var;
} block[3];

mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(block[0].var), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(block[1].var), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(block[2].var), ivec3(0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec3 var;
} block[3];

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec3(ivec3(block[0].var), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(block[1].var), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(block[2].var), ivec3(0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec3 var;
} block[3];

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec3(ivec3(block[0].var), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(block[1].var), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(block[2].var), ivec3(0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec2 var;
} block[3];

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec2((block[0].var), ivec2(0, 0));
	result *= compare_ivec2((block[1].var), ivec2(0, 0));
	result *= compare_ivec2((block[2].var), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec3 var;
} block[3];

mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((block[0].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3(block[0].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[0].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_vec3(block[1].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[1].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_vec3(block[2].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[2].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4(block[0].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[0][3], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_float(block[0].var[1][3], 0.0);
	result *= compare_vec4(block[1].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[0][3], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_float(block[1].var[1][3], 0.0);
	result *= compare_vec4(block[2].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[0][3], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
	result *= compare_float(block[2].var[1][3], 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x4((block[0].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[1].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[2].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(block[0].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[0][3], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_float(block[0].var[1][3], 0.0);
	result *= compare_vec4(block[1].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[0][3], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_float(block[1].var[1][3], 0.0);
	result *= compare_vec4(block[2].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[0][3], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
	result *= compare_float(block[2].var[1][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4(block[0].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[0][3], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_float(block[0].var[1][3], 0.0);
	result *= compare_vec4(block[1].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[0][3], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_float(block[1].var[1][3], 0.0);
	result *= compare_vec4(block[2].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[0][3], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
	result *= compare_float(block[2].var[1][3], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec2 var;
} block[3];

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(block[0].var), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(block[1].var), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(block[2].var), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec4 var;
} block[3];

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec3 var;
} block[3];

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2(block[0].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[0].var[1], vec2(0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_vec2(block[1].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[1].var[1], vec2(0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_vec2(block[2].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[2].var[1], vec2(0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2(block[0].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[0].var[1], vec2(0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_vec2(block[1].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[1].var[1], vec2(0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_vec2(block[2].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[2].var[1], vec2(0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(block[0].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[0][3], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_float(block[0].var[1][3], 0.0);
	result *= compare_float(block[0].var[2][0], 0.0);
	result *= compare_float(block[0].var[2][1], 0.0);
	result *= compare_float(block[0].var[2][2], 0.0);
	result *= compare_float(block[0].var[2][3], 0.0);
	result *= compare_float(block[0].var[3][0], 0.0);
	result *= compare_float(block[0].var[3][1], 0.0);
	result *= compare_float(block[0].var[3][2], 0.0);
	result *= compare_float(block[0].var[3][3], 0.0);
	result *= compare_vec4(block[1].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[0][3], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_float(block[1].var[1][3], 0.0);
	result *= compare_float(block[1].var[2][0], 0.0);
	result *= compare_float(block[1].var[2][1], 0.0);
	result *= compare_float(block[1].var[2][2], 0.0);
	result *= compare_float(block[1].var[2][3], 0.0);
	result *= compare_float(block[1].var[3][0], 0.0);
	result *= compare_float(block[1].var[3][1], 0.0);
	result *= compare_float(block[1].var[3][2], 0.0);
	result *= compare_float(block[1].var[3][3], 0.0);
	result *= compare_vec4(block[2].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[3], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[0][3], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
	result *= compare_float(block[2].var[1][3], 0.0);
	result *= compare_float(block[2].var[2][0], 0.0);
	result *= compare_float(block[2].var[2][1], 0.0);
	result *= compare_float(block[2].var[2][2], 0.0);
	result *= compare_float(block[2].var[2][3], 0.0);
	result *= compare_float(block[2].var[3][0], 0.0);
	result *= compare_float(block[2].var[3][1], 0.0);
	result *= compare_float(block[2].var[3][2], 0.0);
	result *= compare_float(block[2].var[3][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat2x3((block[0].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat2x3((block[1].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat2x3((block[2].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3(block[0].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[0].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_vec3(block[1].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[1].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_vec3(block[2].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[2].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat3x4((block[0].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat3x4((block[1].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat3x4((block[2].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4(block[0].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[0].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[0][3], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_float(block[0].var[1][3], 0.0);
	result *= compare_float(block[0].var[2][0], 0.0);
	result *= compare_float(block[0].var[2][1], 0.0);
	result *= compare_float(block[0].var[2][2], 0.0);
	result *= compare_float(block[0].var[2][3], 0.0);
	result *= compare_vec4(block[1].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[1].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[0][3], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_float(block[1].var[1][3], 0.0);
	result *= compare_float(block[1].var[2][0], 0.0);
	result *= compare_float(block[1].var[2][1], 0.0);
	result *= compare_float(block[1].var[2][2], 0.0);
	result *= compare_float(block[1].var[2][3], 0.0);
	result *= compare_vec4(block[2].var[0], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[1], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4(block[2].var[2], vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[0][3], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
	result *= compare_float(block[2].var[1][3], 0.0);
	result *= compare_float(block[2].var[2][0], 0.0);
	result *= compare_float(block[2].var[2][1], 0.0);
	result *= compare_float(block[2].var[2][2], 0.0);
	result *= compare_float(block[2].var[2][3], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat4x3((block[0].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat4x3((block[1].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat4x3((block[2].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat4x3((block[0].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat4x3((block[1].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat4x3((block[2].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec2 var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec4 var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(block[0].padding), 0u);
	result *= compare_u8vec4(uvec4(block[0].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint8_t(uint(block[1].padding), 0u);
	result *= compare_u8vec4(uvec4(block[1].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint8_t(uint(block[2].padding), 0u);
	result *= compare_u8vec4(uvec4(block[2].var), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec4 var;
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(block[0].padding), 0);
	result *= compare_i8vec4(ivec4(block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_int8_t(int(block[1].padding), 0);
	result *= compare_i8vec4(ivec4(block[1].var), ivec4(0, 0, 0, 0));
	result *= compare_int8_t(int(block[2].padding), 0);
	result *= compare_i8vec4(ivec4(block[2].var), ivec4(0, 0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec4 var;
} block[3];

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(block[0].padding), 0u);
	result *= compare_u16vec4(uvec4(block[0].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint16_t(uint(block[1].padding), 0u);
	result *= compare_u16vec4(uvec4(block[1].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint16_t(uint(block[2].padding), 0u);
	result *= compare_u16vec4(uvec4(block[2].var), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t padding;
	i16vec3 var;
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int16_t(int(block[0].padding), 0);
	result *= compare_i16vec3(ivec3(block[0].var), ivec3(0, 0, 0));
	result *= compare_int16_t(int(block[1].padding), 0);
	result *= compare_i16vec3(ivec3(block[1].var), ivec3(0, 0, 0));
	result *= compare_int16_t(int(block[2].padding), 0);
	result *= compare_i16vec3(ivec3(block[2].var), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t padding;
	f16vec3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(block[0].padding), 0.0);
	result *= compare_f16vec3(vec3(block[0].var), vec3(0.0, 0.0, 0.0));
	result *= compare_float16_t(float(block[1].padding), 0.0);
	result *= compare_f16vec3(vec3(block[1].var), vec3(0.0, 0.0, 0.0));
	result *= compare_float16_t(float(block[2].padding), 0.0);
	result *= compare_f16vec3(vec3(block[2].var), vec3(0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform BlockA
{
	highp float a;
	lowp uvec3 b; // unused in both shaders
	mediump mat2 c;
} blockA[3];
layout(set = 0, binding = 1, std430) uniform BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c; // unused in both shaders
	bool d;
} blockB[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((blockA[0].a), 0.0);
	result *= compare_mat2((blockA[0].c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockA[1].a), 0.0);
	result *= compare_mat2((blockA[1].c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockA[2].a), 0.0);
	result *= compare_mat2((blockA[2].c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB[0].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[0].b), ivec2(0, 0));
	result *= compare_bool((blockB[0].d), false);
	result *= compare_mat3((blockB[1].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[1].b), ivec2(0, 0));
	result *= compare_bool((blockB[1].d), false);
	result *= compare_mat3((blockB[2].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[2].b), ivec2(0, 0));
	result *= compare_bool((blockB[2].d), false);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 2, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform BlockA
{
	highp float a;
	lowp uvec3 b; // unused in both shaders
	mediump mat2 c;
} blockA[3];
layout(set = 0, binding = 1, scalar) uniform BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c; // unused in both shaders
	bool d;
} blockB[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2(blockA[0].c[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockA[0].c[1], vec2(0.0, 0.0));
	result *= compare_float(blockA[0].c[0][0], 0.0);
	result *= compare_float(blockA[0].c[0][1], 0.0);
	result *= compare_float(blockA[0].c[1][0], 0.0);
	result *= compare_float(blockA[0].c[1][1], 0.0);
	result *= compare_vec2(blockA[1].c[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockA[1].c[1], vec2(0.0, 0.0));
	result *= compare_float(blockA[1].c[0][0], 0.0);
	result *= compare_float(blockA[1].c[0][1], 0.0);
	result *= compare_float(blockA[1].c[1][0], 0.0);
	result *= compare_float(blockA[1].c[1][1], 0.0);
	result *= compare_vec2(blockA[2].c[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockA[2].c[1], vec2(0.0, 0.0));
	result *= compare_float(blockA[2].c[0][0], 0.0);
	result *= compare_float(blockA[2].c[0][1], 0.0);
	result *= compare_float(blockA[2].c[1][0], 0.0);
	result *= compare_float(blockA[2].c[1][1], 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 2, rgba8) writeonly uniform image2D outImage;

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unused in both shaders
	S b;
	bvec4 c;
};
layout(set = 0, binding = 0, std140) uniform BlockA
{
	highp float a;
	S b;
	lowp uvec3 c; // unused in both shaders
} blockA[3];
layout(set = 0, binding = 1, std140) uniform BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c; // unused in both shaders
	bool d;
} blockB[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockA[0].a), 0.0);
	result *= compare_mat3((blockA[0].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[0].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[0].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockA[0].c), uvec3(0u, 0u, 0u));
	result *= compare_float((blockA[1].a), 0.0);
	result *= compare_mat3((blockA[1].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[1].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[1].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockA[1].c), uvec3(0u, 0u, 0u));
	result *= compare_float((blockA[2].a), 0.0);
	result *= compare_mat3((blockA[2].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[2].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[2].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockA[2].c), uvec3(0u, 0u, 0u));
	result *= compare_mat2((blockB[0].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB[0].b.a), 0u);
	result *= compare_mat3((blockB[0].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[0].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[0].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[0].b.c), bvec4(false, false, false, false));
	result *= compare_bvec4((blockB[0].c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[0].d), false);
	result *= compare_mat2((blockB[1].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB[1].b.a), 0u);
	result *= compare_mat3((blockB[1].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[1].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[1].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[1].b.c), bvec4(false, false, false, false));
	result *= compare_bvec4((blockB[1].c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[1].d), false);
	result *= compare_mat2((blockB[2].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB[2].b.a), 0u);
	result *= compare_mat3((blockB[2].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[2].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[2].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[2].b.c), bvec4(false, false, false, false));
	result *= compare_bvec4((blockB[2].c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[2].d), false);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unused in both shaders
	S b;
	bvec4 c;
};
layout(set = 0, binding = 0, std430) uniform BlockA
{
	highp float a;
	S b;
	lowp uvec3 c; // unused in both shaders
} blockA;
layout(set = 0, binding = 1, std430) uniform BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c; // unused in both shaders
	bool d;
} blockB;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3((blockA.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2(blockB.a[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockB.a[1], vec2(0.0, 0.0));
	result *= compare_float(blockB.a[0][0], 0.0);
	result *= compare_float(blockB.a[0][1], 0.0);
	result *= compare_float(blockB.a[1][0], 0.0);
	result *= compare_float(blockB.a[1][1], 0.0);
	result *= compare_mat3((blockB.b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB.b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB.b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB.b.c), bvec4(false, false, false, false));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unused in both shaders
	S b;
	bvec4 c;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unused in both shaders
	S b;
	bvec4 c;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unused in both shaders
	S b;
	bvec4 c;
};
layout(set = 0, binding = 0, scalar) uniform BlockA
{
	highp float a;
	S b;
	lowp uvec3 c; // unused in both shaders
} blockA;
layout(set = 0, binding = 1, scalar) uniform BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c; // unused in both shaders
	bool d;
} blockB;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((blockA.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2(blockB.a[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockB.a[1], vec2(0.0, 0.0));
	result *= compare_float(blockB.a[0][0], 0.0);
	result *= compare_float(blockB.a[0][1], 0.0);
	result *= compare_float(blockB.a[1][0], 0.0);
	result *= compare_float(blockB.a[1][1], 0.0);
	result *= compare_mat3((blockB.b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB.b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB.b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB.b.c), bvec4(false, false, false, false));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 2, rgba8) writeonly uniform image2D outImage;

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unused in both shaders
	S b;
	bvec4 c;
};
layout(set = 0, binding = 0, scalar) uniform BlockA
{
	highp float a;
	S b;
	lowp uvec3 c; // unused in both shaders
} blockA;
layout(set = 0, binding = 1, scalar) uniform BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c; // unused in both shaders
	bool d;
} blockB;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((blockA.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2(blockB.a[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockB.a[1], vec2(0.0, 0.0));
	result *= compare_float(blockB.a[0][0], 0.0);
	result *= compare_float(blockB.a[0][1], 0.0);
	result *= compare_float(blockB.a[1][0], 0.0);
	result *= compare_float(blockB.a[1][1], 0.0);
	result *= compare_uint((blockB.b.a), 0u);
	result *= compare_mat3((blockB.b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB.b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB.b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB.b.c), bvec4(false, false, false, false));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0) uniform BlockB
{
	lowp int a;
	highp int b; // unused in fragment shader
	mediump float c;
	lowp float d; // unused in vertex shader
	mediump float e; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp uint f;
	bool g; // unused in both shaders
	bool h; // unused in vertex shader
	lowp float i;
	bool j; // unused in vertex shader
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bool k; // unused in fragment shader
	mediump float l;
	lowp int m; // unused in vertex shader
	lowp int n;
};
layout(set = 0, binding = 3) uniform BlockE
{
	lowp int o;
	mediump float p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((blockB.a), 0);
	result *= compare_float((blockB.c), 0.0);
	result *= compare_float((blockB.d), 0.0);
	result *= compare_float((blockB.e), 0.0);
	result *= compare_uint((f), 0u);
	result *= compare_bool((h), false);
	result *= compare_float((i), 0.0);
	result *= compare_bool((j), false);
	result *= compare_float((l), 0.0);
	result *= compare_int((m), 0);
	result *= compare_int((n), 0);
	result *= compare_int((o), 0);
	result *= compare_float((p), 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0) uniform BlockB
{
	lowp int a;
	highp int b; // unused in fragment shader
	mediump float c;
	lowp float d; // unused in vertex shader
	mediump float e; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp uint f;
	bool g; // unused in both shaders
	bool h; // unused in vertex shader
	lowp float i;
	bool j; // unused in vertex shader
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bool k; // unused in fragment shader
	mediump float l;
	lowp int m; // unused in vertex shader
	lowp int n;
};
layout(set = 0, binding = 3) uniform BlockE
{
	lowp int o;
	mediump float p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((blockB.a), 0);
	result *= compare_int((blockB.b), 0);
	result *= compare_float((blockB.c), 0.0);
	result *= compare_uint((f), 0u);
	result *= compare_float((i), 0.0);
	result *= compare_bool((k), false);
	result *= compare_float((l), 0.0);
	result *= compare_int((n), 0);
	result *= compare_int((o), 0);
	result *= compare_float((p), 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4) uniform BlockF
{
	lowp float j;
	lowp uint k;
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	lowp float l;
};
layout(set = 0, binding = 6) uniform BlockH
{
	lowp uint m;
	bool n;
	lowp float o;
	lowp float p;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockF.j), 0.0);
	result *= compare_uint((blockF.k), 0u);
	result *= compare_float((l), 0.0);
	result *= compare_uint((blockH.m), 0u);
	result *= compare_bool((blockH.n), false);
	result *= compare_float((blockH.o), 0.0);
	result *= compare_float((blockH.p), 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0) uniform BlockB
{
	bvec4 a;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump vec3 b;
	lowp uint c; // unused in fragment shader
	bool d;
	mediump ivec4 e;
	mediump ivec4 f;
} blockC;
layout(set = 0, binding = 4, std140) uniform BlockF
{
	highp vec4 p;
	mediump float q;
	bvec4 r;
	bvec3 s;
	mediump uvec4 t;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec4((a), bvec4(false, false, false, false));
	result *= compare_vec3((blockC.b), vec3(0.0, 0.0, 0.0));
	result *= compare_bool((blockC.d), false);
	result *= compare_ivec4((blockC.e), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockC.f), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockF.p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockF.q), 0.0);
	result *= compare_bvec4((blockF.r), bvec4(false, false, false, false));
	result *= compare_bvec3((blockF.s), bvec3(false, false, false));
	result *= compare_uvec4((blockF.t), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0) uniform BlockB
{
	bvec4 a;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump vec3 b;
	lowp uint c; // unused in fragment shader
	bool d;
	mediump ivec4 e;
	mediump ivec4 f;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	mediump float g;
	highp ivec3 h;
	highp vec2 i;
	lowp uvec3 j;
	lowp uvec3 k; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp uvec3 l;
	mediump uvec4 m; // unused in fragment shader
	mediump vec4 n;
	highp vec3 o; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((a), bvec4(false, false, false, false));
	result *= compare_vec3((blockC.b), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((blockC.c), 0u);
	result *= compare_bool((blockC.d), false);
	result *= compare_ivec4((blockC.e), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockC.f), ivec4(0, 0, 0, 0));
	result *= compare_float((blockD.g), 0.0);
	result *= compare_ivec3((blockD.h), ivec3(0, 0, 0));
	result *= compare_vec2((blockD.i), vec2(0.0, 0.0));
	result *= compare_uvec3((blockD.j), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockE.l), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockE.m), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec4((blockE.n), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	mediump mat4 a;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	highp mat3 o;
	lowp float p;
	highp mat2x3 q;
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	mediump ivec2 r;
};
layout(set = 0, binding = 6) uniform BlockH
{
	mediump mat3 s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF.o), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockF.p), 0.0);
	result *= compare_mat2x3((blockF.q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((r), ivec2(0, 0));
	result *= compare_mat3((s), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	mediump mat4 a;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp ivec2 b;
	bvec4 c; // unused in vertex shader
	mediump uvec2 d;
	highp vec4 e;
	highp float f;
};
layout(set = 0, binding = 2) uniform BlockD
{
	highp uvec4 g; // unused in vertex shader
	highp uvec4 h;
	mediump uvec2 i; // unused in vertex shader
	highp mat4x2 j; // unused in both shaders
} blockD;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	mediump ivec4 k;
	lowp mat3x2 l; // unused in vertex shader
	mediump uvec3 m;
	mediump float n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((b), ivec2(0, 0));
	result *= compare_uvec2((d), uvec2(0u, 0u));
	result *= compare_vec4((e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((f), 0.0);
	result *= compare_uvec4((blockD.h), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((k), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((m), uvec3(0u, 0u, 0u));
	result *= compare_float((n), 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 5, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, column_major) uniform BlockF
{
	highp uint j;
	bvec4 k;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((blockF.j), 0u);
	result *= compare_bvec4((blockF.k), bvec4(false, false, false, false));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct sA
{
	bvec4 mA;
	highp vec2 mB;
	bvec4 mC;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	highp mat3x4 a;
	lowp vec2 b;
	mediump mat4 c;
	lowp ivec3 d;
	mediump mat4 e; // unused in vertex shader
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump ivec2 f;
	mediump vec2 g; // unused in vertex shader
	lowp vec3 h;
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	lowp ivec4 i;
	sA j; // unused in fragment shader
	mediump vec4 k; // unused in both shaders
	mediump mat3x2 l; // unused in fragment shader
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp vec2 m; // unused in vertex shader
	mediump uvec2 n;
	mediump int o; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((b), vec2(0.0, 0.0));
	result *= compare_mat4((c), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((d), ivec3(0, 0, 0));
	result *= compare_mat4((e), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((f), ivec2(0, 0));
	result *= compare_vec2((g), vec2(0.0, 0.0));
	result *= compare_vec3((h), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec4((blockD.i), ivec4(0, 0, 0, 0));
	result *= compare_vec2((blockE.m), vec2(0.0, 0.0));
	result *= compare_uvec2((blockE.n), uvec2(0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct sA
{
	bvec4 mA;
	highp vec2 mB;
	bvec4 mC;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	highp mat3x4 a;
	lowp vec2 b;
	mediump mat4 c;
	lowp ivec3 d;
	mediump mat4 e; // unused in vertex shader
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump ivec2 f;
	mediump vec2 g; // unused in vertex shader
	lowp vec3 h;
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	lowp ivec4 i;
	sA j; // unused in fragment shader
	mediump vec4 k; // unused in both shaders
	mediump mat3x2 l; // unused in fragment shader
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp vec2 m; // unused in vertex shader
	mediump uvec2 n;
	mediump int o; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((b), vec2(0.0, 0.0));
	result *= compare_mat4((c), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((d), ivec3(0, 0, 0));
	result *= compare_ivec2((f), ivec2(0, 0));
	result *= compare_vec3((h), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec4((blockD.i), ivec4(0, 0, 0, 0));
	result *= compare_bvec4((blockD.j.mA), bvec4(false, false, false, false));
	result *= compare_vec2((blockD.j.mB), vec2(0.0, 0.0));
	result *= compare_bvec4((blockD.j.mC), bvec4(false, false, false, false));
	result *= compare_mat3x2((blockD.l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE.n), uvec2(0u, 0u));
	result *= compare_int((blockE.o), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 5, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4) uniform BlockF
{
	mediump mat3x4 i;
	lowp vec3 j;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((i), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((j), vec3(0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	bvec2 o;
	mediump mat2 p; // unused in vertex shader
	highp float q;
	bvec2 r;
	lowp mat4 s; // unused in vertex shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec2((blockG.o), bvec2(false, false));
	result *= compare_mat2((blockG.p), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockG.q), 0.0);
	result *= compare_bvec2((blockG.r), bvec2(false, false));
	result *= compare_mat4((blockG.s), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct sA
{
	lowp vec3 mA;
	lowp mat4 mB; // unused in vertex shader
	highp mat3x2 mC;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	mediump mat4x2 a;
	lowp uvec3 b;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	sA c;
	highp mat4x2 d;
	highp ivec2 e;
	lowp mat3x2 f;
	highp uint g;
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp mat2x3 h;
	lowp mat4 i;
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	mediump uvec2 j;
	mediump ivec4 k; // unused in both shaders
	bvec2 l;
	mediump mat2x3 m; // unused in fragment shader
	lowp uvec4 n;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((blockB.a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockB.b), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockC.c.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4((blockC.c.mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.c.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockC.d), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC.e), ivec2(0, 0));
	result *= compare_mat3x2((blockC.f), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockC.g), 0u);
	result *= compare_mat2x3((blockD.h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockD.i), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE.j), uvec2(0u, 0u));
	result *= compare_bvec2((blockE.l), bvec2(false, false));
	result *= compare_uvec4((blockE.n), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct sA
{
	lowp vec3 mA;
	lowp mat4 mB; // unused in vertex shader
	highp mat3x2 mC;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	mediump mat4x2 a;
	lowp uvec3 b;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	sA c;
	highp mat4x2 d;
	highp ivec2 e;
	lowp mat3x2 f;
	highp uint g;
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp mat2x3 h;
	lowp mat4 i;
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	mediump uvec2 j;
	mediump ivec4 k; // unused in both shaders
	bvec2 l;
	mediump mat2x3 m; // unused in fragment shader
	lowp uvec4 n;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x2((blockB.a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockB.b), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockC.c.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.c.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockC.d), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC.e), ivec2(0, 0));
	result *= compare_mat3x2((blockC.f), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockC.g), 0u);
	result *= compare_mat2x3((blockD.h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockD.i), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE.j), uvec2(0u, 0u));
	result *= compare_bvec2((blockE.l), bvec2(false, false));
	result *= compare_mat2x3((blockE.m), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockE.n), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct sA
{
	mediump ivec3 mA; // unused in both shaders
	mediump ivec3 mB;
	lowp ivec4 mC;
	mediump uvec2 mD;
};
struct sB
{
	bool mA;
	sA mB;
	highp ivec4 mC; // unused in vertex shader
	lowp mat2 mD;
};
struct sC
{
	mediump mat2 mA; // unused in vertex shader
	bvec4 mB;
};
struct sD
{
	highp float mA;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	mediump mat4 a; // unused in vertex shader
	highp float b;
	sB c;
	lowp vec4 d;
};
layout(set = 0, binding = 1) uniform BlockC
{
	highp vec2 e;
	sC f;
	bvec4 g;
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	sD h;
	lowp vec2 i[8];
	mediump mat2 j;
	highp ivec3 k; // unused in vertex shader
	bvec2 l[7];
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	highp mat3x4 m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((b), 0.0);
	result *= compare_bool((c.mA), false);
	result *= compare_ivec3((c.mB.mB), ivec3(0, 0, 0));
	result *= compare_ivec4((c.mB.mC), ivec4(0, 0, 0, 0));
	result *= compare_uvec2((c.mB.mD), uvec2(0u, 0u));
	result *= compare_ivec4((c.mC), ivec4(0, 0, 0, 0));
	result *= compare_mat2((c.mD), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockC.e), vec2(0.0, 0.0));
	result *= compare_mat2((blockC.f.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockC.f.mB), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.g), bvec4(false, false, false, false));
	result *= compare_float((h.mA), 0.0);
	result *= compare_vec2((i[0]), vec2(0.0, 0.0));
	result *= compare_vec2((i[1]), vec2(0.0, 0.0));
	result *= compare_vec2((i[2]), vec2(0.0, 0.0));
	result *= compare_vec2((i[3]), vec2(0.0, 0.0));
	result *= compare_vec2((i[4]), vec2(0.0, 0.0));
	result *= compare_vec2((i[5]), vec2(0.0, 0.0));
	result *= compare_vec2((i[6]), vec2(0.0, 0.0));
	result *= compare_vec2((i[7]), vec2(0.0, 0.0));
	result *= compare_mat2((j), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((k), ivec3(0, 0, 0));
	result *= compare_bvec2((l[0]), bvec2(false, false));
	result *= compare_bvec2((l[1]), bvec2(false, false));
	result *= compare_bvec2((l[2]), bvec2(false, false));
	result *= compare_bvec2((l[3]), bvec2(false, false));
	result *= compare_bvec2((l[4]), bvec2(false, false));
	result *= compare_bvec2((l[5]), bvec2(false, false));
	result *= compare_bvec2((l[6]), bvec2(false, false));
	result *= compare_mat3x4((blockE.m), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct sA
{
	mediump ivec3 mA; // unused in both shaders
	mediump ivec3 mB;
	lowp ivec4 mC;
	mediump uvec2 mD;
};
struct sB
{
	bool mA;
	sA mB;
	highp ivec4 mC; // unused in vertex shader
	lowp mat2 mD;
};
struct sC
{
	mediump mat2 mA; // unused in vertex shader
	bvec4 mB;
};
struct sD
{
	highp float mA;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	mediump mat4 a; // unused in vertex shader
	highp float b;
	sB c;
	lowp vec4 d;
};
layout(set = 0, binding = 1) uniform BlockC
{
	highp vec2 e;
	sC f;
	bvec4 g;
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	sD h;
	lowp vec2 i[8];
	mediump mat2 j;
	highp ivec3 k; // unused in vertex shader
	bvec2 l[7];
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	highp mat3x4 m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((b), 0.0);
	result *= compare_bool((c.mA), false);
	result *= compare_ivec3((c.mB.mB), ivec3(0, 0, 0));
	result *= compare_ivec4((c.mB.mC), ivec4(0, 0, 0, 0));
	result *= compare_uvec2((c.mB.mD), uvec2(0u, 0u));
	result *= compare_mat2((c.mD), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockC.e), vec2(0.0, 0.0));
	result *= compare_bvec4((blockC.f.mB), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.g), bvec4(false, false, false, false));
	result *= compare_float((h.mA), 0.0);
	result *= compare_vec2((i[0]), vec2(0.0, 0.0));
	result *= compare_vec2((i[1]), vec2(0.0, 0.0));
	result *= compare_vec2((i[2]), vec2(0.0, 0.0));
	result *= compare_vec2((i[3]), vec2(0.0, 0.0));
	result *= compare_vec2((i[4]), vec2(0.0, 0.0));
	result *= compare_vec2((i[5]), vec2(0.0, 0.0));
	result *= compare_vec2((i[6]), vec2(0.0, 0.0));
	result *= compare_vec2((i[7]), vec2(0.0, 0.0));
	result *= compare_mat2((j), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((l[0]), bvec2(false, false));
	result *= compare_bvec2((l[1]), bvec2(false, false));
	result *= compare_bvec2((l[2]), bvec2(false, false));
	result *= compare_bvec2((l[3]), bvec2(false, false));
	result *= compare_bvec2((l[4]), bvec2(false, false));
	result *= compare_bvec2((l[5]), bvec2(false, false));
	result *= compare_bvec2((l[6]), bvec2(false, false));
	result *= compare_mat3x4((blockE.m), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bool mA[7];
};
struct sB
{
	highp mat3x2 mA; // unused in fragment shader
	bool mB;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	sB h;
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	bool i; // unused in fragment shader
	highp uvec4 j; // unused in fragment shader
	highp uint k;
	mediump int l[7];
	highp float m;
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp float n;
	lowp vec3 o[2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((blockF.h.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockF.h.mB), false);
	result *= compare_bool((i), false);
	result *= compare_uvec4((j), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((k), 0u);
	result *= compare_int((l[0]), 0);
	result *= compare_int((l[1]), 0);
	result *= compare_int((l[2]), 0);
	result *= compare_int((l[3]), 0);
	result *= compare_int((l[4]), 0);
	result *= compare_int((l[5]), 0);
	result *= compare_int((l[6]), 0);
	result *= compare_float((m), 0.0);
	result *= compare_float((n), 0.0);
	result *= compare_vec3((o[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((o[1]), vec3(0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	mediump vec3 mA;
	highp uint mB;
	lowp mat3x2 mC; // unused in fragment shader
	lowp mat4x2 mD;
};
struct sB
{
	mediump mat2 mA;
	sA mB;
	mediump ivec4 mC;
};
struct sC
{
	lowp mat4x3 mA;
	highp float mB;
	lowp mat3x4 mC;
};
struct sD
{
	mediump mat3x2 mA; // unused in fragment shader
	bvec4 mB; // unused in vertex shader
	mediump mat3x4 mC;
	bvec2 mD;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	bool j;
	mediump mat4x2 k;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp ivec4 l; // unused in fragment shader
} blockG[2];
layout(set = 0, binding = 6) uniform BlockH
{
	highp uvec4 m; // unused in fragment shader
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	bvec4 n;
	sC o; // unused in vertex shader
	mediump uvec4 p;
	bool q;
	sD r[4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bool((j), false);
	result *= compare_mat4x2((k), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockG[0].l), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockG[1].l), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((m), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((n), bvec4(false, false, false, false));
	result *= compare_mat4x3((o.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((o.mB), 0.0);
	result *= compare_mat3x4((o.mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bool((q), false);
	result *= compare_mat3x2((r[0].mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((r[0].mB), bvec4(false, false, false, false));
	result *= compare_mat3x4((r[0].mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((r[0].mD), bvec2(false, false));
	result *= compare_mat3x2((r[1].mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((r[1].mB), bvec4(false, false, false, false));
	result *= compare_mat3x4((r[1].mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((r[1].mD), bvec2(false, false));
	result *= compare_mat3x2((r[2].mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((r[2].mB), bvec4(false, false, false, false));
	result *= compare_mat3x4((r[2].mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((r[2].mD), bvec2(false, false));
	result *= compare_mat3x2((r[3].mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((r[3].mB), bvec4(false, false, false, false));
	result *= compare_mat3x4((r[3].mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((r[3].mD), bvec2(false, false));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

struct sA
{
	mediump vec4 mA; // unused in fragment shader
};
struct sB
{
	mediump vec3 mA;
};
struct sC
{
	bvec4 mA;
	mediump mat3x4 mB;
};
struct sD
{
	lowp mat4x3 mA;
};
layout(set = 0, binding = 4) uniform BlockF
{
	highp mat4x2 r;
	lowp vec3 s;
	lowp vec4 t;
	mediump mat3x4 u;
	sC v; // unused in vertex shader
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	mediump mat4 w[4];
	highp mat4x2 x; // unused in fragment shader
	lowp vec4 y;
	sD z; // unused in fragment shader
	mediump uvec4 aa; // unused in vertex shader
} blockG[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((blockF.r), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockF.s), vec3(0.0, 0.0, 0.0));
	result *= compare_vec4((blockF.t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF.u), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockF.v.mA), bvec4(false, false, false, false));
	result *= compare_mat3x4((blockF.v.mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockG[0].w[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockG[0].w[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockG[0].w[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockG[0].w[3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].x), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[0].z.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockG[0].aa), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	highp uvec2 mA;
	mediump mat4x2 mB[3];
	lowp mat4 mC; // unused in vertex shader
	mediump mat2 mD; // unused in vertex shader
};
struct sB
{
	lowp mat3x2 mA; // unused in fragment shader
	lowp mat3 mB; // unused in fragment shader
	lowp vec4 mC[4]; // unused in vertex shader
};
struct sC
{
	highp mat3x4 mA; // unused in vertex shader
};
struct sD
{
	lowp mat3x4 mA; // unused in fragment shader
};
struct sE
{
	lowp uvec3 mA;
};
layout(set = 0, binding = 6, std430, column_major) uniform BlockH
{
	layout(offset = 16) highp uvec3 w; // unused in fragment shader
	layout(offset = 0) bvec3 v;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	layout(offset = 80) mediump vec2 z[6];
	layout(offset = 0) lowp mat4 x;
	layout(offset = 64) mediump uint y;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((v), bvec3(false, false, false));
	result *= compare_uvec3((w), uvec3(0u, 0u, 0u));
	result *= compare_mat4((x), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((y), 0u);
	result *= compare_vec2((z[0]), vec2(0.0, 0.0));
	result *= compare_vec2((z[1]), vec2(0.0, 0.0));
	result *= compare_vec2((z[2]), vec2(0.0, 0.0));
	result *= compare_vec2((z[3]), vec2(0.0, 0.0));
	result *= compare_vec2((z[4]), vec2(0.0, 0.0));
	result *= compare_vec2((z[5]), vec2(0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	mediump vec3 l; // unused in vertex shader
} blockG;
layout(set = 0, binding = 6, std430) uniform BlockH
{
	lowp mat3x2 m; // unused in fragment shader
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((blockG.l), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH.m), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp uint r;
	float16_t s;
	highp int t;
};
layout(set = 0, binding = 7) uniform BlockI
{
	highp float u;
	int16_t v;
	mediump int w; // unused in fragment shader
	int16_t x;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((r), 0u);
	result *= compare_float16_t(float(s), 0.0);
	result *= compare_int((t), 0);
	result *= compare_float((blockI.u), 0.0);
	result *= compare_int16_t(int(blockI.v), 0);
	result *= compare_int((blockI.w), 0);
	result *= compare_int16_t(int(blockI.x), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4) uniform BlockF
{
	int16_t j;
	bool k;
	bool l; // unused in vertex shader
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	uint16_t m;
	highp float n;
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	mediump float o;
	highp uint p; // unused in vertex shader
	lowp uint q;
	int16_t r;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int16_t(int(blockF.j), 0);
	result *= compare_bool((blockF.k), false);
	result *= compare_bool((blockF.l), false);
	result *= compare_uint16_t(uint(m), 0u);
	result *= compare_float((n), 0.0);
	result *= compare_float((blockH.o), 0.0);
	result *= compare_uint((blockH.p), 0u);
	result *= compare_uint((blockH.q), 0u);
	result *= compare_int16_t(int(blockH.r), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	u16vec4 a; // unused in fragment shader
	mediump vec3 b;
	i16vec3 c;
	highp mat3x4 d;
};
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp mat2 f;
	lowp mat4 g;
	mediump mat3 h;
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	lowp mat4 i;
	mediump uvec2 j;
	bvec4 k;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3((b), vec3(0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(c), ivec3(0, 0, 0));
	result *= compare_mat3x4((d), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((f), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((h), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((i), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((j), uvec2(0u, 0u));
	result *= compare_bvec4((k), bvec4(false, false, false, false));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	u16vec4 a; // unused in fragment shader
	mediump vec3 b;
	i16vec3 c;
	highp mat3x4 d;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	highp vec2 e;
} blockC;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(a), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((b), vec3(0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(c), ivec3(0, 0, 0));
	result *= compare_mat3x4((d), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockC.e), vec2(0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5) uniform BlockG
{
	mediump vec4 n;
	mediump mat3x2 o; // unused in vertex shader
	lowp uint p; // unused in both shaders
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((blockG.n), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.o), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockG.p), 0u);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	highp mat4x2 a;
	lowp uint b;
	u16vec3 c;
	float16_t d; // unused in vertex shader
	int16_t e;
} blockB;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	u16vec4 o;
	highp vec3 p;
	lowp mat4x3 q;
} blockE;
layout(set = 0, binding = 4) uniform BlockF
{
	bvec4 r;
	mediump mat2x3 s;
	lowp mat2 t; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((blockB.a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB.b), 0u);
	result *= compare_u16vec3(uvec3(blockB.c), uvec3(0u, 0u, 0u));
	result *= compare_float16_t(float(blockB.d), 0.0);
	result *= compare_int16_t(int(blockB.e), 0);
	result *= compare_u16vec4(uvec4(blockE.o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((blockE.p), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockE.q), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((r), bvec4(false, false, false, false));
	result *= compare_mat2x3((s), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	highp mat4x2 a;
	lowp uint b;
	u16vec3 c;
	float16_t d; // unused in vertex shader
	int16_t e;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	lowp ivec4 f;
	highp mat3 g;
	lowp ivec4 h;
	i16vec2 i;
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	highp uvec4 j; // unused in fragment shader
	lowp vec3 k;
	bool l; // unused in vertex shader
	bvec3 m[3];
	int16_t n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x2((blockB.a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB.b), 0u);
	result *= compare_u16vec3(uvec3(blockB.c), uvec3(0u, 0u, 0u));
	result *= compare_int16_t(int(blockB.e), 0);
	result *= compare_ivec4((blockC.f), ivec4(0, 0, 0, 0));
	result *= compare_mat3((blockC.g), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockC.h), ivec4(0, 0, 0, 0));
	result *= compare_i16vec2(ivec2(blockC.i), ivec2(0, 0));
	result *= compare_uvec4((j), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((k), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec3((m[0]), bvec3(false, false, false));
	result *= compare_bvec3((m[1]), bvec3(false, false, false));
	result *= compare_bvec3((m[2]), bvec3(false, false, false));
	result *= compare_int16_t(int(n), 0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5) uniform BlockG
{
	bvec4 r;
	mediump mat2x3 s;
	lowp mat2 t; // unused in fragment shader
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	mediump mat3x4 u;
	mediump ivec3 v; // unused in fragment shader
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((r), bvec4(false, false, false, false));
	result *= compare_mat2x3((s), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((t), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH.u), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH.v), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp mat4 a;
	f16vec3 b; // unused in vertex shader
	f16vec2 c;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat4x2 d;
	int16_t e;
	u16vec2 f; // unused in both shaders
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	int16_t k; // unused in fragment shader
	f16vec4 l; // unused in vertex shader
	highp mat4x2 m; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(b), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec2(vec2(c), vec2(0.0, 0.0));
	result *= compare_mat4x2((d), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(e), 0);
	result *= compare_f16vec4(vec4(blockE.l), vec4(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp mat4 a;
	f16vec3 b; // unused in vertex shader
	f16vec2 c;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat4x2 d;
	int16_t e;
	u16vec2 f; // unused in both shaders
};
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	lowp mat4 g;
	mediump uvec2 h; // unused in vertex shader
	highp mat3x4 i;
	f16vec4 j;
} blockD[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec2(vec2(c), vec2(0.0, 0.0));
	result *= compare_mat4x2((d), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(e), 0);
	result *= compare_mat4((blockD[0].g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockD[0].i), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockD[0].j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockD[1].g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockD[1].i), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockD[1].j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockD[2].g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockD[2].i), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockD[2].j), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 5, rgba8) writeonly uniform image2D outImage;

struct sA
{
	highp ivec2 mA;
	mediump float mB;
	mediump mat4x3 mC;
	mediump mat4x3 mD;
};
struct sB
{
	sA mA; // unused in fragment shader
	highp mat4x3 mB[2];
	highp mat3 mC; // unused in vertex shader
};
struct sC
{
	highp mat4 mA[2];
};
struct sD
{
	mediump mat4x3 mA[1]; // unused in fragment shader
	lowp uvec2 mB;
};
struct sE
{
	mediump uvec3 mA[4];
	sC mB;
	bvec4 mC[3];
	sD mD;
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	lowp mat4x3 m;
	highp mat3 n; // unused in vertex shader
	int16_t o;
	sE p;
	i16vec4 q;
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	u16vec4 r;
	mediump mat2 s;
	lowp uvec2 t;
	bvec2 u;
	int16_t v[4];
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x3((m), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((n), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(o), 0);
	result *= compare_uvec3((p.mA[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((p.mA[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((p.mA[2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((p.mA[3]), uvec3(0u, 0u, 0u));
	result *= compare_mat4((p.mB.mA[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((p.mB.mA[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((p.mC[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((p.mC[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((p.mC[2]), bvec4(false, false, false, false));
	result *= compare_mat4x3((p.mD.mA[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((p.mD.mB), uvec2(0u, 0u));
	result *= compare_i16vec4(ivec4(q), ivec4(0, 0, 0, 0));
	result *= compare_u16vec4(uvec4(blockF.r), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2((blockF.s), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockF.t), uvec2(0u, 0u));
	result *= compare_bvec2((blockF.u), bvec2(false, false));
	result *= compare_int16_t(int(blockF.v[0]), 0);
	result *= compare_int16_t(int(blockF.v[1]), 0);
	result *= compare_int16_t(int(blockF.v[2]), 0);
	result *= compare_int16_t(int(blockF.v[3]), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct sA
{
	f16vec3 mA; // unused in vertex shader
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	i16vec4 a;
	mediump uvec3 b; // unused in fragment shader
	highp vec2 c;
	lowp uvec4 d;
	i16vec3 e;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	highp mat4x3 f;
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	mediump mat3x4 g; // unused in fragment shader
	highp uint h;
	bvec4 i;
} blockD;
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	f16vec4 o;
	highp ivec2 p;
	sA q; // unused in fragment shader
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(blockB.a), ivec4(0, 0, 0, 0));
	result *= compare_vec2((blockB.c), vec2(0.0, 0.0));
	result *= compare_uvec4((blockB.d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i16vec3(ivec3(blockB.e), ivec3(0, 0, 0));
	result *= compare_mat4x3((blockC.f), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockD.h), 0u);
	result *= compare_bvec4((blockD.i), bvec4(false, false, false, false));
	result *= compare_f16vec4(vec4(blockF.o), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockF.p), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct sA
{
	f16vec3 mA; // unused in vertex shader
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	i16vec4 a;
	mediump uvec3 b; // unused in fragment shader
	highp vec2 c;
	lowp uvec4 d;
	i16vec3 e;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	highp mat4x3 f;
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	mediump mat3x4 g; // unused in fragment shader
	highp uint h;
	bvec4 i;
} blockD;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	f16vec3 j;
	i16vec3 k; // unused in vertex shader
	highp vec3 l;
	i16vec3 m;
	mediump uvec3 n; // unused in both shaders
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(blockB.a), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((blockB.b), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockB.c), vec2(0.0, 0.0));
	result *= compare_uvec4((blockB.d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i16vec3(ivec3(blockB.e), ivec3(0, 0, 0));
	result *= compare_mat4x3((blockC.f), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockD.g), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockD.h), 0u);
	result *= compare_bvec4((blockD.i), bvec4(false, false, false, false));
	result *= compare_f16vec3(vec3(blockE.j), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockE.l), vec3(0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(blockE.m), ivec3(0, 0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

struct sA
{
	mediump float mA;
	i16vec2 mB; // unused in vertex shader
};
struct sB
{
	u16vec3 mA;
	mediump uvec4 mB;
};
struct sC
{
	sB mA; // unused in fragment shader
	u16vec2 mB;
	lowp vec3 mC;
};
struct sD
{
	bvec2 mA;
	highp uvec3 mB;
};
layout(set = 0, binding = 0) uniform BlockB
{
	bvec4 a;
	sA b;
	bool c;
	bool d;
	bool e;
} blockB[3];
layout(set = 0, binding = 2) uniform BlockD
{
	sC g;
	mediump uvec3 h; // unused in both shaders
	lowp uvec3 i;
	highp mat4x2 j;
	lowp mat4x2 k;
} blockD[3];
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	mediump mat3x4 l; // unused in fragment shader
	i16vec2 m;
	bvec4 n;
	lowp uvec4 o;
	int16_t p;
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	lowp int q;
	sD r[6]; // unused in both shaders
	lowp mat4x2 s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec4((blockB[0].a), bvec4(false, false, false, false));
	result *= compare_float((blockB[0].b.mA), 0.0);
	result *= compare_i16vec2(ivec2(blockB[0].b.mB), ivec2(0, 0));
	result *= compare_bool((blockB[0].c), false);
	result *= compare_bool((blockB[0].d), false);
	result *= compare_bool((blockB[0].e), false);
	result *= compare_bvec4((blockB[1].a), bvec4(false, false, false, false));
	result *= compare_float((blockB[1].b.mA), 0.0);
	result *= compare_i16vec2(ivec2(blockB[1].b.mB), ivec2(0, 0));
	result *= compare_bool((blockB[1].c), false);
	result *= compare_bool((blockB[1].d), false);
	result *= compare_bool((blockB[1].e), false);
	result *= compare_bvec4((blockB[2].a), bvec4(false, false, false, false));
	result *= compare_float((blockB[2].b.mA), 0.0);
	result *= compare_i16vec2(ivec2(blockB[2].b.mB), ivec2(0, 0));
	result *= compare_bool((blockB[2].c), false);
	result *= compare_bool((blockB[2].d), false);
	result *= compare_bool((blockB[2].e), false);
	result *= compare_u16vec2(uvec2(blockD[0].g.mB), uvec2(0u, 0u));
	result *= compare_vec3((blockD[0].g.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockD[0].i), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockD[0].j), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockD[0].k), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockD[1].g.mB), uvec2(0u, 0u));
	result *= compare_vec3((blockD[1].g.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockD[1].i), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockD[1].j), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockD[1].k), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockD[2].g.mB), uvec2(0u, 0u));
	result *= compare_vec3((blockD[2].g.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockD[2].i), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockD[2].j), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockD[2].k), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(m), ivec2(0, 0));
	result *= compare_bvec4((n), bvec4(false, false, false, false));
	result *= compare_uvec4((o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int16_t(int(p), 0);
	result *= compare_int((q), 0);
	result *= compare_mat4x2((s), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

struct sA
{
	mediump float mA;
	i16vec2 mB; // unused in vertex shader
};
struct sB
{
	u16vec3 mA;
	mediump uvec4 mB;
};
struct sC
{
	sB mA; // unused in fragment shader
	u16vec2 mB;
	lowp vec3 mC;
};
struct sD
{
	bvec2 mA;
	highp uvec3 mB;
};
layout(set = 0, binding = 0) uniform BlockB
{
	bvec4 a;
	sA b;
	bool c;
	bool d;
	bool e;
} blockB[3];
layout(set = 0, binding = 1, std140) uniform BlockC
{
	u16vec3 f;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((blockB[0].a), bvec4(false, false, false, false));
	result *= compare_float((blockB[0].b.mA), 0.0);
	result *= compare_bool((blockB[0].c), false);
	result *= compare_bool((blockB[0].d), false);
	result *= compare_bool((blockB[0].e), false);
	result *= compare_bvec4((blockB[1].a), bvec4(false, false, false, false));
	result *= compare_float((blockB[1].b.mA), 0.0);
	result *= compare_bool((blockB[1].c), false);
	result *= compare_bool((blockB[1].d), false);
	result *= compare_bool((blockB[1].e), false);
	result *= compare_bvec4((blockB[2].a), bvec4(false, false, false, false));
	result *= compare_float((blockB[2].b.mA), 0.0);
	result *= compare_bool((blockB[2].c), false);
	result *= compare_bool((blockB[2].d), false);
	result *= compare_bool((blockB[2].e), false);
	result *= compare_u16vec3(uvec3(f), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

struct sA
{
	lowp vec3 mA;
	i16vec2 mB; // unused in vertex shader
	highp mat3x4 mC;
	lowp uvec4 mD;
};
struct sB
{
	sA mA;
	lowp vec4 mB; // unused in fragment shader
	mediump ivec2 mC;
};
struct sC
{
	bvec2 mA; // unused in vertex shader
	highp uvec3 mB;
	highp ivec3 mC;
};
struct sD
{
	mediump float mA;
	highp uvec4 mB; // unused in fragment shader
};
struct sE
{
	float16_t mA; // unused in vertex shader
	i16vec4 mB; // unused in fragment shader
};
struct sF
{
	f16vec2 mA;
	lowp mat3 mB;
	i16vec4 mC[2];
};
struct sG
{
	sD mA; // unused in fragment shader
	sE mB; // unused in vertex shader
	lowp mat3 mC;
	sF mD;
};
struct sH
{
	mediump uvec3 mA;
	lowp uint mB;
	u16vec3 mC[5];
	lowp uint mD;
};
struct sI
{
	mediump mat3 mA;
	i16vec4 mB; // unused in fragment shader
	sH mC;
	u16vec3 mD;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	i16vec4 m; // unused in both shaders
	bvec4 n; // unused in vertex shader
	mediump mat4 o; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	sG p;
	u16vec4 q;
	uint16_t r; // unused in vertex shader
} blockG[1];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	sI s;
} blockH[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(blockF.m), ivec4(0, 0, 0, 0));
	result *= compare_bvec4((blockF.n), bvec4(false, false, false, false));
	result *= compare_mat4((blockF.o), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockG[0].p.mA.mA), 0.0);
	result *= compare_uvec4((blockG[0].p.mA.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float16_t(float(blockG[0].p.mB.mA), 0.0);
	result *= compare_i16vec4(ivec4(blockG[0].p.mB.mB), ivec4(0, 0, 0, 0));
	result *= compare_mat3((blockG[0].p.mC), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec2(vec2(blockG[0].p.mD.mA), vec2(0.0, 0.0));
	result *= compare_mat3((blockG[0].p.mD.mB), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockG[0].p.mD.mC[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockG[0].p.mD.mC[1]), ivec4(0, 0, 0, 0));
	result *= compare_u16vec4(uvec4(blockG[0].q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint16_t(uint(blockG[0].r), 0u);
	result *= compare_mat3((blockH[0].s.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockH[0].s.mB), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((blockH[0].s.mC.mA), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockH[0].s.mC.mB), 0u);
	result *= compare_u16vec3(uvec3(blockH[0].s.mC.mC[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[0].s.mC.mC[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[0].s.mC.mC[2]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[0].s.mC.mC[3]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[0].s.mC.mC[4]), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockH[0].s.mC.mD), 0u);
	result *= compare_u16vec3(uvec3(blockH[0].s.mD), uvec3(0u, 0u, 0u));
	result *= compare_mat3((blockH[1].s.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockH[1].s.mB), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((blockH[1].s.mC.mA), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockH[1].s.mC.mB), 0u);
	result *= compare_u16vec3(uvec3(blockH[1].s.mC.mC[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[1].s.mC.mC[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[1].s.mC.mC[2]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[1].s.mC.mC[3]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[1].s.mC.mC[4]), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockH[1].s.mC.mD), 0u);
	result *= compare_u16vec3(uvec3(blockH[1].s.mD), uvec3(0u, 0u, 0u));
	result *= compare_mat3((blockH[2].s.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockH[2].s.mB), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((blockH[2].s.mC.mA), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockH[2].s.mC.mB), 0u);
	result *= compare_u16vec3(uvec3(blockH[2].s.mC.mC[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[2].s.mC.mC[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[2].s.mC.mC[2]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[2].s.mC.mC[3]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[2].s.mC.mC[4]), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockH[2].s.mC.mD), 0u);
	result *= compare_u16vec3(uvec3(blockH[2].s.mD), uvec3(0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

struct sA
{
	mediump uvec2 mA; // unused in vertex shader
	highp mat2x3 mB;
};
struct sB
{
	highp mat4x3 mA;
};
struct sC
{
	i16vec2 mA;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	bvec2 o; // unused in vertex shader
	mediump ivec4 p;
	bool q;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	sC r;
	u16vec2 s;
	lowp ivec2 t;
	highp ivec2 u;
	bvec2 v;
};
layout(set = 0, binding = 6) uniform BlockH
{
	mediump mat4x3 w; // unused in vertex shader
	bvec3 x;
	i16vec4 y[7];
	mediump mat3x4 z; // unused in fragment shader
	bool aa;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec2((o), bvec2(false, false));
	result *= compare_ivec4((p), ivec4(0, 0, 0, 0));
	result *= compare_bool((q), false);
	result *= compare_i16vec2(ivec2(r.mA), ivec2(0, 0));
	result *= compare_u16vec2(uvec2(s), uvec2(0u, 0u));
	result *= compare_ivec2((t), ivec2(0, 0));
	result *= compare_ivec2((u), ivec2(0, 0));
	result *= compare_bvec2((v), bvec2(false, false));
	result *= compare_mat4x3((w), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((x), bvec3(false, false, false));
	result *= compare_i16vec4(ivec4(y[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(y[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(y[2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(y[3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(y[4]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(y[5]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(y[6]), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((z), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((aa), false);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

struct sA
{
	u16vec2 mA[6]; // unused in vertex shader
	i16vec2 mB;
};
struct sB
{
	lowp ivec4 mA;
	u16vec2 mB;
	sA mC;
	f16vec2 mD; // unused in fragment shader
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	sB t;
	highp ivec2 u;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((t.mA), ivec4(0, 0, 0, 0));
	result *= compare_u16vec2(uvec2(t.mB), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(t.mC.mA[0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(t.mC.mA[1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(t.mC.mA[2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(t.mC.mA[3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(t.mC.mA[4]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(t.mC.mA[5]), uvec2(0u, 0u));
	result *= compare_i16vec2(ivec2(t.mC.mB), ivec2(0, 0));
	result *= compare_f16vec2(vec2(t.mD), vec2(0.0, 0.0));
	result *= compare_ivec2((u), ivec2(0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	i16vec4 mA; // unused in fragment shader
};
struct sB
{
	int16_t mA;
	lowp vec3 mB;
	mediump mat3 mC;
	mediump mat3x4 mD;
};
struct sC
{
	mediump mat2x3 mA;
	f16vec3 mB;
	uint16_t mC; // unused in fragment shader
};
struct sD
{
	sC mA;
};
struct sE
{
	i16vec3 mA;
};
struct sF
{
	lowp uvec3 mA;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp mat4x2 p;
	mediump mat2x3 q; // unused in vertex shader
	highp mat2 r; // unused in vertex shader
	lowp vec3 s[2];
	u16vec2 t;
} blockG;
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	bvec3 u;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	highp vec3 v;
	bvec2 w[6];
	lowp ivec3 x; // unused in vertex shader
	lowp int y;
	highp mat4 z;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((blockG.p), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG.q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockG.r), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockG.s[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockG.s[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockG.t), uvec2(0u, 0u));
	result *= compare_bvec3((u), bvec3(false, false, false));
	result *= compare_vec3((v), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec2((w[0]), bvec2(false, false));
	result *= compare_bvec2((w[1]), bvec2(false, false));
	result *= compare_bvec2((w[2]), bvec2(false, false));
	result *= compare_bvec2((w[3]), bvec2(false, false));
	result *= compare_bvec2((w[4]), bvec2(false, false));
	result *= compare_bvec2((w[5]), bvec2(false, false));
	result *= compare_ivec3((x), ivec3(0, 0, 0));
	result *= compare_int((y), 0);
	result *= compare_mat4((z), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bool mA;
	lowp uint mB;
	lowp uvec4 mC[8][1];
	uint16_t mD;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	bvec3 j;
	u16vec3 k; // unused in fragment shader
	int16_t l;
} blockF[2];
layout(set = 0, binding = 5) uniform BlockG
{
	highp float m;
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	lowp ivec2 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((blockF[0].j), bvec3(false, false, false));
	result *= compare_u16vec3(uvec3(blockF[0].k), uvec3(0u, 0u, 0u));
	result *= compare_int16_t(int(blockF[0].l), 0);
	result *= compare_bvec3((blockF[1].j), bvec3(false, false, false));
	result *= compare_u16vec3(uvec3(blockF[1].k), uvec3(0u, 0u, 0u));
	result *= compare_int16_t(int(blockF[1].l), 0);
	result *= compare_float((m), 0.0);
	result *= compare_ivec2((n), ivec2(0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

struct sA
{
	u16vec4 mA; // unused in vertex shader
	float16_t mB[2];
	lowp ivec2 mC;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	lowp ivec3 o;
	highp ivec3 p;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	mediump int q; // unused in both shaders
	int16_t r;
	highp uint s;
	i16vec3 t;
	i16vec2 u; // unused in vertex shader
} blockG[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((o), ivec3(0, 0, 0));
	result *= compare_ivec3((p), ivec3(0, 0, 0));
	result *= compare_int((blockG[0].q), 0);
	result *= compare_int16_t(int(blockG[0].r), 0);
	result *= compare_uint((blockG[0].s), 0u);
	result *= compare_i16vec3(ivec3(blockG[0].t), ivec3(0, 0, 0));
	result *= compare_i16vec2(ivec2(blockG[0].u), ivec2(0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	f16vec4 mA;
	float16_t mB; // unused in both shaders
};
struct sB
{
	i16vec4 mA; // unused in both shaders
	f16vec3 mB;
	mediump uvec2 mC; // unused in fragment shader
};
struct sC
{
	sB mA;
};
struct sD
{
	mediump vec4 mA; // unused in fragment shader
	lowp vec3 mB;
	bvec3 mC;
	i16vec3 mD;
};
struct sE
{
	u16vec3 mA;
	lowp vec3 mB;
};
struct sF
{
	mediump uvec2 mA; // unused in vertex shader
	i16vec3 mB; // unused in vertex shader
	lowp uvec2 mC;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	sE o; // unused in vertex shader
	u16vec2 p;
	lowp mat4x3 q;
} blockF[2];
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp mat2 r[1]; // unused in both shaders
	sF s;
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	lowp vec4 t;
	lowp mat4 u[1];
	u16vec2 v;
};
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	int16_t w;
} blockI[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(blockF[0].o.mA), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockF[0].o.mB), vec3(0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockF[0].p), uvec2(0u, 0u));
	result *= compare_mat4x3((blockF[0].q), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec3(uvec3(blockF[1].o.mA), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockF[1].o.mB), vec3(0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockF[1].p), uvec2(0u, 0u));
	result *= compare_mat4x3((blockF[1].q), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockG.r[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockG.s.mA), uvec2(0u, 0u));
	result *= compare_i16vec3(ivec3(blockG.s.mB), ivec3(0, 0, 0));
	result *= compare_uvec2((blockG.s.mC), uvec2(0u, 0u));
	result *= compare_vec4((t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((u[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(v), uvec2(0u, 0u));
	result *= compare_int16_t(int(blockI[0].w), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	layout(offset = 4) u16vec2 o;
	layout(offset = 0) mediump uint n; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((n), 0u);
	result *= compare_u16vec2(uvec2(o), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std430, row_major) uniform BlockF
{
	layout(offset = 16) bvec2 k;
	layout(offset = 0) u16vec4 i;
	layout(offset = 8) i16vec2 j;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	layout(offset = 0) bvec4 l; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, scalar, row_major) uniform BlockH
{
	layout(offset = 0) lowp uvec3 m;
} blockH;
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	layout(offset = 8) lowp float o;
	layout(offset = 0) f16vec4 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i16vec2(ivec2(j), ivec2(0, 0));
	result *= compare_bvec2((k), bvec2(false, false));
	result *= compare_bvec4((blockG.l), bvec4(false, false, false, false));
	result *= compare_uvec3((blockH.m), uvec3(0u, 0u, 0u));
	result *= compare_f16vec4(vec4(n), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((o), 0.0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 4, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bvec3 mA;
	mediump mat4 mB;
};
struct sB
{
	highp mat3 mA[4];
	sA mB;
	mediump int mC;
};
layout(set = 0, binding = 3, scalar) uniform BlockE
{
	layout(offset = 0) mediump mat2x3 h[2];
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((blockE.h[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockE.h[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

struct sA
{
	lowp mat4x2 mA; // unused in vertex shader
	bvec4 mB;
};
struct sB
{
	lowp uint mA; // unused in both shaders
};
struct sC
{
	f16vec4 mA;
	bvec4 mB;
};
struct sD
{
	highp mat4x3 mA; // unused in vertex shader
	sB mB; // unused in fragment shader
	lowp ivec4 mC;
	sC mD; // unused in fragment shader
};
struct sE
{
	mediump vec4 mA;
};
struct sF
{
	bool mA;
	sE mB;
	highp uint mC;
	f16vec4 mD; // unused in vertex shader
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	layout(offset = 204) highp int p;
	layout(offset = 0) sD l;
	layout(offset = 200) u16vec2 o;
	layout(offset = 128) highp mat4 m;
	layout(offset = 192) f16vec4 n;
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 192) sF u;
	layout(offset = 0) mediump ivec4 q[5][2];
	layout(offset = 184) mediump ivec2 t;
	layout(offset = 160) highp ivec3 r;
	layout(offset = 176) highp ivec2 s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x3((l.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((l.mB.mA), 0u);
	result *= compare_ivec4((l.mC), ivec4(0, 0, 0, 0));
	result *= compare_f16vec4(vec4(l.mD.mA), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((l.mD.mB), bvec4(false, false, false, false));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(n), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(o), uvec2(0u, 0u));
	result *= compare_int((p), 0);
	result *= compare_ivec4((q[0][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[0][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[1][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[1][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[2][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[2][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[3][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[3][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[4][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((q[4][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec3((r), ivec3(0, 0, 0));
	result *= compare_ivec2((s), ivec2(0, 0));
	result *= compare_ivec2((t), ivec2(0, 0));
	result *= compare_bool((u.mA), false);
	result *= compare_vec4((u.mB.mA), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((u.mC), 0u);
	result *= compare_f16vec4(vec4(u.mD), vec4(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, row_major) uniform BlockG
{
	mediump uvec3 k;
	i16vec2 l;
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	highp mat3x2 m;
};
layout(set = 0, binding = 7, std430, column_major) uniform BlockI
{
	highp mat3x2 n;
	highp uvec4 o;
	lowp mat3x2 p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec3((blockG.k), uvec3(0u, 0u, 0u));
	result *= compare_i16vec2(ivec2(blockG.l), ivec2(0, 0));
	result *= compare_mat3x2((m), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((n), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x2((p), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform BlockB
{
	uint8_t a;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	lowp uint b; // unused in both shaders
	uint8_t c;
} blockC;
layout(set = 0, binding = 3) uniform BlockE
{
	highp float f; // unused in vertex shader
	mediump uint g;
	lowp int h;
	lowp uint i;
	lowp int j; // unused in both shaders
} blockE;
layout(set = 0, binding = 4) uniform BlockF
{
	lowp float k; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockB.a), 0u);
	result *= compare_uint8_t(uint(blockC.c), 0u);
	result *= compare_float((blockE.f), 0.0);
	result *= compare_uint((blockE.g), 0u);
	result *= compare_int((blockE.h), 0);
	result *= compare_uint((blockE.i), 0u);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform BlockB
{
	uint8_t a;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	lowp uint b; // unused in both shaders
	uint8_t c;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	uint8_t d; // unused in fragment shader
	lowp float e;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockB.a), 0u);
	result *= compare_uint8_t(uint(blockC.c), 0u);
	result *= compare_uint8_t(uint(d), 0u);
	result *= compare_float((e), 0.0);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140) uniform BlockF
{
	uint8_t i; // unused in vertex shader
	int8_t j;
	u8vec2 k;
	uint8_t l;
	highp float m;
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	mediump vec3 n;
	bvec4 o;
	mediump vec2 p;
	mediump ivec4 q;
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	lowp float r;
	highp ivec2 s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockF.i), 0u);
	result *= compare_int8_t(int(blockF.j), 0);
	result *= compare_u8vec2(uvec2(blockF.k), uvec2(0u, 0u));
	result *= compare_uint8_t(uint(blockF.l), 0u);
	result *= compare_float((blockF.m), 0.0);
	result *= compare_vec3((blockG.n), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec4((blockG.o), bvec4(false, false, false, false));
	result *= compare_vec2((blockG.p), vec2(0.0, 0.0));
	result *= compare_ivec4((blockG.q), ivec4(0, 0, 0, 0));
	result *= compare_float((r), 0.0);
	result *= compare_ivec2((s), ivec2(0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	highp mat3x4 a;
	mediump mat3x2 b; // unused in vertex shader
	bvec2 c; // unused in vertex shader
	lowp mat2 d;
	i8vec3 e; // unused in both shaders
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp mat4 f; // unused in vertex shader
	i8vec2 g; // unused in both shaders
	highp ivec3 h;
	bvec4 i[5];
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	i8vec2 j[7];
	highp mat4 k;
	highp mat4x2 l;
	mediump mat4 m;
	mediump vec2 n;
};
layout(set = 0, binding = 3) uniform BlockE
{
	mediump mat4x2 o; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((b), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((c), bvec2(false, false));
	result *= compare_mat2((d), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockC.f), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockC.h), ivec3(0, 0, 0));
	result *= compare_bvec4((blockC.i[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[2]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[3]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[4]), bvec4(false, false, false, false));
	result *= compare_i8vec2(ivec2(j[0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[3]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[4]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[5]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[6]), ivec2(0, 0));
	result *= compare_mat4((k), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((l), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((n), vec2(0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	highp mat3x4 a;
	mediump mat3x2 b; // unused in vertex shader
	bvec2 c; // unused in vertex shader
	lowp mat2 d;
	i8vec3 e; // unused in both shaders
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp mat4 f; // unused in vertex shader
	i8vec2 g; // unused in both shaders
	highp ivec3 h;
	bvec4 i[5];
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	i8vec2 j[7];
	highp mat4 k;
	highp mat4x2 l;
	mediump mat4 m;
	mediump vec2 n;
};
layout(set = 0, binding = 3) uniform BlockE
{
	mediump mat4x2 o; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((d), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockC.h), ivec3(0, 0, 0));
	result *= compare_bvec4((blockC.i[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[2]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[3]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.i[4]), bvec4(false, false, false, false));
	result *= compare_i8vec2(ivec2(j[0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[3]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[4]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[5]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(j[6]), ivec2(0, 0));
	result *= compare_mat4((k), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((l), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((n), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockE.o), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 7, column_major) uniform BlockI
{
	int8_t w;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int8_t(int(blockI.w), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform BlockB
{
	i8vec2 a; // unused in vertex shader
	i8vec3 b;
	lowp mat2 c;
};
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	mediump uint h;
	highp mat3x2 i; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(a), ivec2(0, 0));
	result *= compare_i8vec3(ivec3(b), ivec3(0, 0, 0));
	result *= compare_mat2((c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((h), 0u);
	result *= compare_mat3x2((i), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform BlockB
{
	i8vec2 a; // unused in vertex shader
	i8vec3 b;
	lowp mat2 c;
};
layout(set = 0, binding = 1) uniform BlockC
{
	highp mat2x3 d; // unused in vertex shader
	lowp mat4 e;
	mediump mat4x2 f; // unused in vertex shader
	lowp mat3 g;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(b), ivec3(0, 0, 0));
	result *= compare_mat2((c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((e), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((g), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bvec4 mA;
};
struct sB
{
	bool mA;
	bvec2 mB;
	u8vec4 mC; // unused in vertex shader
};
struct sC
{
	uint8_t mA; // unused in vertex shader
	lowp uvec3 mB;
};
struct sD
{
	lowp uvec3 mA;
	highp mat4x2 mB;
	sC mC; // unused in fragment shader
	bool mD; // unused in fragment shader
};
struct sE
{
	lowp ivec4 mA; // unused in vertex shader
	lowp uint mB;
	mediump int mC;
};
struct sF
{
	sE mA; // unused in fragment shader
	u8vec4 mB;
	bvec2 mC; // unused in both shaders
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	sF r; // unused in vertex shader
	highp ivec2 s;
	bvec3 t;
	mediump int u;
} blockG;
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	u8vec2 v;
	mediump int w;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	mediump mat2 x;
	mediump mat2 y;
	i8vec4 z;
	u8vec3 aa; // unused in both shaders
	i8vec3 ab;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((blockG.r.mA.mA), ivec4(0, 0, 0, 0));
	result *= compare_uint((blockG.r.mA.mB), 0u);
	result *= compare_int((blockG.r.mA.mC), 0);
	result *= compare_u8vec4(uvec4(blockG.r.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec2((blockG.r.mC), bvec2(false, false));
	result *= compare_ivec2((blockG.s), ivec2(0, 0));
	result *= compare_bvec3((blockG.t), bvec3(false, false, false));
	result *= compare_int((blockG.u), 0);
	result *= compare_u8vec2(uvec2(v), uvec2(0u, 0u));
	result *= compare_int((w), 0);
	result *= compare_mat2((x), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((y), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(z), ivec4(0, 0, 0, 0));
	result *= compare_u8vec3(uvec3(aa), uvec3(0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(ab), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

struct sA
{
	lowp mat2x3 mA; // unused in both shaders
	i8vec4 mB;
	lowp mat4x2 mC; // unused in vertex shader
};
struct sB
{
	lowp uvec4 mA; // unused in vertex shader
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	sB n;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec4((blockG.n.mA), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

struct sA
{
	highp mat3x4 mA[5][3];
	mediump vec4 mB; // unused in vertex shader
};
struct sB
{
	mediump mat4x3 mA[1]; // unused in vertex shader
	lowp uvec3 mB;
	sA mC; // unused in fragment shader
	highp mat2 mD; // unused in vertex shader
};
struct sC
{
	highp vec4 mA;
};
struct sD
{
	lowp ivec4 mA; // unused in fragment shader
	mediump mat3x4 mB;
	mediump vec4 mC;
	sC mD;
};
layout(set = 0, binding = 5) uniform BlockG
{
	bvec3 q;
	highp uint r;
	highp uvec2 s; // unused in both shaders
	mediump mat3x2 t;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	mediump mat4 u;
	lowp mat2 v;
	lowp uint w;
	i8vec3 x[4]; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((q), bvec3(false, false, false));
	result *= compare_uint((r), 0u);
	result *= compare_uvec2((s), uvec2(0u, 0u));
	result *= compare_mat3x2((t), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((u), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((v), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((w), 0u);
	result *= compare_i8vec3(ivec3(x[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(x[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(x[2]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(x[3]), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bvec2 mA; // unused in fragment shader
};
struct sB
{
	i8vec2 mA;
	highp ivec4 mB;
	i8vec2 mC; // unused in fragment shader
};
struct sC
{
	mediump mat3x2 mA;
	sB mB;
};
struct sD
{
	mediump mat4x2 mA; // unused in fragment shader
	int8_t mB;
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	highp mat3 m; // unused in both shaders
	i8vec3 n;
	sC o; // unused in fragment shader
	u8vec2 p; // unused in vertex shader
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp mat3x2 q[8];
	bool r;
	bool s[3][2]; // unused in vertex shader
	lowp float t; // unused in vertex shader
	highp int u; // unused in vertex shader
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	sD v;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	i8vec4 w; // unused in both shaders
	highp ivec4 x;
	lowp vec4 y;
} blockI[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((m), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(n), ivec3(0, 0, 0));
	result *= compare_mat3x2((o.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(o.mB.mA), ivec2(0, 0));
	result *= compare_ivec4((o.mB.mB), ivec4(0, 0, 0, 0));
	result *= compare_i8vec2(ivec2(o.mB.mC), ivec2(0, 0));
	result *= compare_u8vec2(uvec2(p), uvec2(0u, 0u));
	result *= compare_mat3x2((blockG.q[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.q[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.q[2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.q[3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.q[4]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.q[5]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.q[6]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.q[7]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockG.r), false);
	result *= compare_bool((blockG.s[0][0]), false);
	result *= compare_bool((blockG.s[0][1]), false);
	result *= compare_bool((blockG.s[1][0]), false);
	result *= compare_bool((blockG.s[1][1]), false);
	result *= compare_bool((blockG.s[2][0]), false);
	result *= compare_bool((blockG.s[2][1]), false);
	result *= compare_float((blockG.t), 0.0);
	result *= compare_int((blockG.u), 0);
	result *= compare_mat4x2((v.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(v.mB), 0);
	result *= compare_i8vec4(ivec4(blockI[0].w), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockI[0].x), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockI[0].y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockI[1].w), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockI[1].x), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockI[1].y), vec4(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bool mA;
};
struct sB
{
	bvec2 mA; // unused in vertex shader
	lowp ivec3 mB; // unused in fragment shader
	u8vec4 mC; // unused in vertex shader
	u8vec2 mD[5];
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp mat3x4 r; // unused in fragment shader
	highp ivec3 s; // unused in vertex shader
	i8vec4 t;
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp ivec2 u;
	lowp uvec3 v;
	mediump vec4 w;
	mediump mat2 x;
	i8vec2 y;
} blockH[3];
layout(set = 0, binding = 7, std140) uniform BlockI
{
	lowp vec2 z[3];
	mediump uvec4 aa;
	highp mat3x2 ab;
};
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	mediump mat3x2 ac; // unused in fragment shader
	highp vec3 ad;
	sB ae; // unused in fragment shader
	mediump uint af; // unused in fragment shader
	highp ivec3 ag[2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((r), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((s), ivec3(0, 0, 0));
	result *= compare_i8vec4(ivec4(t), ivec4(0, 0, 0, 0));
	result *= compare_ivec2((blockH[0].u), ivec2(0, 0));
	result *= compare_uvec3((blockH[0].v), uvec3(0u, 0u, 0u));
	result *= compare_vec4((blockH[0].w), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH[0].x), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockH[0].y), ivec2(0, 0));
	result *= compare_ivec2((blockH[1].u), ivec2(0, 0));
	result *= compare_uvec3((blockH[1].v), uvec3(0u, 0u, 0u));
	result *= compare_vec4((blockH[1].w), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH[1].x), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockH[1].y), ivec2(0, 0));
	result *= compare_ivec2((blockH[2].u), ivec2(0, 0));
	result *= compare_uvec3((blockH[2].v), uvec3(0u, 0u, 0u));
	result *= compare_vec4((blockH[2].w), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH[2].x), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockH[2].y), ivec2(0, 0));
	result *= compare_vec2((z[0]), vec2(0.0, 0.0));
	result *= compare_vec2((z[1]), vec2(0.0, 0.0));
	result *= compare_vec2((z[2]), vec2(0.0, 0.0));
	result *= compare_uvec4((aa), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x2((ab), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((ac), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((ad), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec2((ae.mA), bvec2(false, false));
	result *= compare_ivec3((ae.mB), ivec3(0, 0, 0));
	result *= compare_u8vec4(uvec4(ae.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec2(uvec2(ae.mD[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(ae.mD[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(ae.mD[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(ae.mD[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(ae.mD[4]), uvec2(0u, 0u));
	result *= compare_uint((af), 0u);
	result *= compare_ivec3((ag[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((ag[1]), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	i8vec4 mA[5];
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	u8vec3 t;
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	lowp uvec4 u;
} blockH[3];
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	bvec4 v;
	lowp uint w; // unused in fragment shader
	bool x; // unused in fragment shader
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(t), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockH[0].u), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockH[1].u), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockH[2].u), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((blockI.v), bvec4(false, false, false, false));
	result *= compare_uint((blockI.w), 0u);
	result *= compare_bool((blockI.x), false);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bvec3 mA;
};
struct sB
{
	highp uint mA;
	u8vec4 mB;
};
struct sC
{
	lowp mat4x2 mA;
	lowp vec4 mB;
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	layout(offset = 0) sB n;
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	layout(offset = 144) uint8_t r[7][3]; // unused in vertex shader
	layout(offset = 0) lowp float o;
	layout(offset = 64) sC q;
	layout(offset = 16) highp mat3x4 p; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((blockF.n.mA), 0u);
	result *= compare_u8vec4(uvec4(blockF.n.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((o), 0.0);
	result *= compare_mat3x4((p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((q.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((q.mB), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(r[0][0]), 0u);
	result *= compare_uint8_t(uint(r[0][1]), 0u);
	result *= compare_uint8_t(uint(r[0][2]), 0u);
	result *= compare_uint8_t(uint(r[1][0]), 0u);
	result *= compare_uint8_t(uint(r[1][1]), 0u);
	result *= compare_uint8_t(uint(r[1][2]), 0u);
	result *= compare_uint8_t(uint(r[2][0]), 0u);
	result *= compare_uint8_t(uint(r[2][1]), 0u);
	result *= compare_uint8_t(uint(r[2][2]), 0u);
	result *= compare_uint8_t(uint(r[3][0]), 0u);
	result *= compare_uint8_t(uint(r[3][1]), 0u);
	result *= compare_uint8_t(uint(r[3][2]), 0u);
	result *= compare_uint8_t(uint(r[4][0]), 0u);
	result *= compare_uint8_t(uint(r[4][1]), 0u);
	result *= compare_uint8_t(uint(r[4][2]), 0u);
	result *= compare_uint8_t(uint(r[5][0]), 0u);
	result *= compare_uint8_t(uint(r[5][1]), 0u);
	result *= compare_uint8_t(uint(r[5][2]), 0u);
	result *= compare_uint8_t(uint(r[6][0]), 0u);
	result *= compare_uint8_t(uint(r[6][1]), 0u);
	result *= compare_uint8_t(uint(r[6][2]), 0u);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	mediump mat3x4 mA; // unused in fragment shader
	highp float mB; // unused in fragment shader
	highp mat3 mC;
	highp vec4 mD;
};
struct sB
{
	i8vec3 mA; // unused in both shaders
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	layout(offset = 128) mediump vec3 q;
	layout(offset = 0) highp uvec4 m; // unused in fragment shader
	layout(offset = 112) sB p;
	layout(offset = 16) bvec3 n;
	layout(offset = 32) highp uint o[5];
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	layout(offset = 112) lowp mat3 v; // unused in vertex shader
	layout(offset = 0) lowp uvec4 r; // unused in fragment shader
	layout(offset = 96) lowp uvec3 u;
	layout(offset = 16) bvec2 s;
	layout(offset = 32) mediump mat4x2 t;
} blockH;
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	layout(offset = 16) i8vec2 x;
	layout(offset = 0) mediump uvec4 w; // unused in fragment shader
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec4((blockG.m), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec3((blockG.n), bvec3(false, false, false));
	result *= compare_uint((blockG.o[0]), 0u);
	result *= compare_uint((blockG.o[1]), 0u);
	result *= compare_uint((blockG.o[2]), 0u);
	result *= compare_uint((blockG.o[3]), 0u);
	result *= compare_uint((blockG.o[4]), 0u);
	result *= compare_i8vec3(ivec3(blockG.p.mA), ivec3(0, 0, 0));
	result *= compare_vec3((blockG.q), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec4((blockH.r), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec2((blockH.s), bvec2(false, false));
	result *= compare_mat4x2((blockH.t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockH.u), uvec3(0u, 0u, 0u));
	result *= compare_mat3((blockH.v), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockI.w), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec2(ivec2(blockI.x), ivec2(0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bool mA;
	mediump mat4x2 mB; // unused in vertex shader
	bvec4 mC;
};
struct sB
{
	mediump mat2 mA;
	uint8_t mB; // unused in both shaders
};
struct sC
{
	lowp ivec3 mA; // unused in fragment shader
	mediump float mB;
	mediump ivec4 mC;
};
struct sD
{
	highp uvec4 mA;
	sC mB; // unused in fragment shader
	highp uvec4 mC;
	lowp vec3 mD;
};
struct sE
{
	i8vec2 mA;
	mediump mat3 mB;
	mediump uvec2 mC; // unused in fragment shader
};
struct sF
{
	sE mA;
};
layout(set = 0, binding = 5) uniform BlockG
{
	layout(offset = 2) u8vec2 v; // unused in fragment shader
	layout(offset = 0) int8_t u;
} blockG[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int8_t(int(blockG[0].u), 0);
	result *= compare_u8vec2(uvec2(blockG[0].v), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	highp vec3 mA;
	mediump ivec2 mB; // unused in vertex shader
};
struct sB
{
	bvec4 mA;
	int8_t mB;
	u8vec3 mC;
};
struct sC
{
	i8vec4 mA; // unused in vertex shader
	highp vec3 mB; // unused in fragment shader
	mediump float mC; // unused in vertex shader
};
struct sD
{
	sC mA[4]; // unused in vertex shader
	u8vec4 mB;
};
struct sE
{
	bvec2 mA;
	bvec4 mB;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 272) mediump uint t;
	layout(offset = 0) sD p;
	layout(offset = 240) highp mat2 s; // unused in both shaders
	layout(offset = 144) lowp mat3 q[1];
	layout(offset = 192) highp mat2x3 r;
} blockG[2];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 0) u8vec3 u;
} blockH[1];
layout(set = 0, binding = 7) uniform BlockI
{
	layout(offset = 128) i8vec4 z;
	layout(offset = 0) uint8_t v;
	layout(offset = 112) lowp vec4 y;
	layout(offset = 4) highp float w;
	layout(offset = 16) sE x[3]; // unused in vertex shader
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(blockG[0].p.mA[0].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[0].p.mA[0].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[0].p.mA[0].mC), 0.0);
	result *= compare_i8vec4(ivec4(blockG[0].p.mA[1].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[0].p.mA[1].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[0].p.mA[1].mC), 0.0);
	result *= compare_i8vec4(ivec4(blockG[0].p.mA[2].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[0].p.mA[2].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[0].p.mA[2].mC), 0.0);
	result *= compare_i8vec4(ivec4(blockG[0].p.mA[3].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[0].p.mA[3].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[0].p.mA[3].mC), 0.0);
	result *= compare_u8vec4(uvec4(blockG[0].p.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockG[0].q[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[0].r), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockG[0].s), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockG[0].t), 0u);
	result *= compare_i8vec4(ivec4(blockG[1].p.mA[0].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[1].p.mA[0].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[1].p.mA[0].mC), 0.0);
	result *= compare_i8vec4(ivec4(blockG[1].p.mA[1].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[1].p.mA[1].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[1].p.mA[1].mC), 0.0);
	result *= compare_i8vec4(ivec4(blockG[1].p.mA[2].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[1].p.mA[2].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[1].p.mA[2].mC), 0.0);
	result *= compare_i8vec4(ivec4(blockG[1].p.mA[3].mA), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockG[1].p.mA[3].mB), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockG[1].p.mA[3].mC), 0.0);
	result *= compare_u8vec4(uvec4(blockG[1].p.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockG[1].q[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[1].r), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockG[1].s), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockG[1].t), 0u);
	result *= compare_u8vec3(uvec3(blockH[0].u), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(blockI.v), 0u);
	result *= compare_float((blockI.w), 0.0);
	result *= compare_bvec2((blockI.x[0].mA), bvec2(false, false));
	result *= compare_bvec4((blockI.x[0].mB), bvec4(false, false, false, false));
	result *= compare_bvec2((blockI.x[1].mA), bvec2(false, false));
	result *= compare_bvec4((blockI.x[1].mB), bvec4(false, false, false, false));
	result *= compare_bvec2((blockI.x[2].mA), bvec2(false, false));
	result *= compare_bvec4((blockI.x[2].mB), bvec4(false, false, false, false));
	result *= compare_vec4((blockI.y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockI.z), ivec4(0, 0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

struct sA
{
	lowp ivec4 mA;
};
struct sB
{
	lowp uvec4 mA;
	mediump ivec2 mB;
};
struct sC
{
	lowp mat4x2 mA; // unused in fragment shader
	i8vec3 mB;
	u8vec2 mC; // unused in fragment shader
};
layout(set = 0, binding = 5, std430, row_major) uniform BlockG
{
	layout(offset = 0) highp vec4 y; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, scalar, column_major) uniform BlockH
{
	layout(offset = 28) lowp uint ab;
	layout(offset = 0) mediump mat3x2 z;
	layout(offset = 24) bool aa;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	layout(offset = 80) sC ag;
	layout(offset = 0) lowp mat2 ac;
	layout(offset = 72) lowp uvec2 af; // unused in fragment shader
	layout(offset = 32) lowp mat2x3 ad;
	layout(offset = 64) lowp uint ae;
} blockI[2];
layout(set = 0, binding = 8, std430, column_major) uniform BlockJ
{
	layout(offset = 16) lowp mat4x2 ai; // unused in vertex shader
	layout(offset = 0) lowp ivec3 ah; // unused in fragment shader
} blockJ[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((blockG.y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((z), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((aa), false);
	result *= compare_uint((ab), 0u);
	result *= compare_mat2((blockI[0].ac), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI[0].ad), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockI[0].ae), 0u);
	result *= compare_uvec2((blockI[0].af), uvec2(0u, 0u));
	result *= compare_mat4x2((blockI[0].ag.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockI[0].ag.mB), ivec3(0, 0, 0));
	result *= compare_u8vec2(uvec2(blockI[0].ag.mC), uvec2(0u, 0u));
	result *= compare_mat2((blockI[1].ac), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI[1].ad), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockI[1].ae), 0u);
	result *= compare_uvec2((blockI[1].af), uvec2(0u, 0u));
	result *= compare_mat4x2((blockI[1].ag.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockI[1].ag.mB), ivec3(0, 0, 0));
	result *= compare_u8vec2(uvec2(blockI[1].ag.mC), uvec2(0u, 0u));
	result *= compare_ivec3((blockJ[0].ah), ivec3(0, 0, 0));
	result *= compare_mat4x2((blockJ[0].ai), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockJ[1].ah), ivec3(0, 0, 0));
	result *= compare_mat4x2((blockJ[1].ai), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

struct sA
{
	mediump mat2x3 mA;
};
struct sB
{
	sA mA[6];
};
struct sC
{
	u8vec2 mA[8];
	highp float mB;
};
struct sD
{
	sC mA; // unused in vertex shader
	mediump ivec4 mB;
};
struct sE
{
	i8vec4 mA;
	lowp mat4x2 mB;
	highp uvec2 mC;
	u8vec2 mD;
};
struct sF
{
	highp vec4 mA;
	i8vec3 mB[8]; // unused in fragment shader
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 224) highp mat3x4 y; // unused in vertex shader
	layout(offset = 0) sF u;
	layout(offset = 212) i8vec3 x;
	layout(offset = 144) mediump mat4 v;
	layout(offset = 208) i8vec3 w; // unused in both shaders
};
layout(set = 0, binding = 6, std430, row_major) uniform BlockH
{
	layout(offset = 32) highp uvec2 ab; // unused in fragment shader
	layout(offset = 0) lowp ivec4 z;
	layout(offset = 16) highp mat2 aa;
} blockH;
layout(set = 0, binding = 7, scalar, column_major) uniform BlockI
{
	layout(offset = 28) lowp uvec2 af;
	layout(offset = 0) bvec4 ac;
	layout(offset = 24) i8vec4 ae; // unused in vertex shader
	layout(offset = 16) mediump ivec2 ad;
} blockI[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((u.mA), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(u.mB[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(u.mB[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(u.mB[2]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(u.mB[3]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(u.mB[4]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(u.mB[5]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(u.mB[6]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(u.mB[7]), ivec3(0, 0, 0));
	result *= compare_mat4((v), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(w), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(x), ivec3(0, 0, 0));
	result *= compare_mat3x4((y), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockH.z), ivec4(0, 0, 0, 0));
	result *= compare_mat2((blockH.aa), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockH.ab), uvec2(0u, 0u));
	result *= compare_bvec4((blockI[0].ac), bvec4(false, false, false, false));
	result *= compare_ivec2((blockI[0].ad), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(blockI[0].ae), ivec4(0, 0, 0, 0));
	result *= compare_uvec2((blockI[0].af), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, scalar, row_major) uniform BlockG
{
	highp ivec2 o;
};
layout(set = 0, binding = 6, std430) uniform BlockH
{
	highp vec4 p; // unused in both shaders
	mediump vec3 q; // unused in vertex shader
	lowp mat2x3 r;
	mediump mat3x2 s;
};
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	bvec2 t;
	lowp mat2x3 u;
	mediump ivec2 v;
	mediump mat4 w; // unused in fragment shader
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((o), ivec2(0, 0));
	result *= compare_vec4((p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((q), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((r), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockI.t), bvec2(false, false));
	result *= compare_mat2x3((blockI.u), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockI.v), ivec2(0, 0));
	result *= compare_mat4((blockI.w), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
