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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
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

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec4 var[3][4];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(var[0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][3]), uvec4(0u, 0u, 0u, 0u));
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
	int16_t var[3][4];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(var[0][0]), 0);
	result *= compare_int16_t(int(var[0][1]), 0);
	result *= compare_int16_t(int(var[0][2]), 0);
	result *= compare_int16_t(int(var[0][3]), 0);
	result *= compare_int16_t(int(var[1][0]), 0);
	result *= compare_int16_t(int(var[1][1]), 0);
	result *= compare_int16_t(int(var[1][2]), 0);
	result *= compare_int16_t(int(var[1][3]), 0);
	result *= compare_int16_t(int(var[2][0]), 0);
	result *= compare_int16_t(int(var[2][1]), 0);
	result *= compare_int16_t(int(var[2][2]), 0);
	result *= compare_int16_t(int(var[2][3]), 0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec4 var[3][4];
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(var[0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][3]), vec3(0.0, 0.0, 0.0));
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
	highp vec4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4((var[0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][3]), vec4(0.0, 0.0, 0.0, 0.0));
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
	highp vec4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4((var[0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][3]), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec2 var[3][4];
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec2((var[0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][2]), ivec2(0, 0));
	result *= compare_ivec2((var[0][3]), ivec2(0, 0));
	result *= compare_ivec2((var[1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][2]), ivec2(0, 0));
	result *= compare_ivec2((var[1][3]), ivec2(0, 0));
	result *= compare_ivec2((var[2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][2]), ivec2(0, 0));
	result *= compare_ivec2((var[2][3]), ivec2(0, 0));
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
	bvec2 var[3][4];
};

mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec2((var[0][0]), bvec2(false, false));
	result *= compare_bvec2((var[0][1]), bvec2(false, false));
	result *= compare_bvec2((var[0][2]), bvec2(false, false));
	result *= compare_bvec2((var[0][3]), bvec2(false, false));
	result *= compare_bvec2((var[1][0]), bvec2(false, false));
	result *= compare_bvec2((var[1][1]), bvec2(false, false));
	result *= compare_bvec2((var[1][2]), bvec2(false, false));
	result *= compare_bvec2((var[1][3]), bvec2(false, false));
	result *= compare_bvec2((var[2][0]), bvec2(false, false));
	result *= compare_bvec2((var[2][1]), bvec2(false, false));
	result *= compare_bvec2((var[2][2]), bvec2(false, false));
	result *= compare_bvec2((var[2][3]), bvec2(false, false));
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
	bvec2 var[3][4];
};

mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec2((var[0][0]), bvec2(false, false));
	result *= compare_bvec2((var[0][1]), bvec2(false, false));
	result *= compare_bvec2((var[0][2]), bvec2(false, false));
	result *= compare_bvec2((var[0][3]), bvec2(false, false));
	result *= compare_bvec2((var[1][0]), bvec2(false, false));
	result *= compare_bvec2((var[1][1]), bvec2(false, false));
	result *= compare_bvec2((var[1][2]), bvec2(false, false));
	result *= compare_bvec2((var[1][3]), bvec2(false, false));
	result *= compare_bvec2((var[2][0]), bvec2(false, false));
	result *= compare_bvec2((var[2][1]), bvec2(false, false));
	result *= compare_bvec2((var[2][2]), bvec2(false, false));
	result *= compare_bvec2((var[2][3]), bvec2(false, false));
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat3x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat3x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec4 var[3][4];
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	i8vec4 var[3][4];
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
	float padding;
	highp vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec2 var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec2((var[0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][2]), ivec2(0, 0));
	result *= compare_ivec2((var[0][3]), ivec2(0, 0));
	result *= compare_ivec2((var[1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][2]), ivec2(0, 0));
	result *= compare_ivec2((var[1][3]), ivec2(0, 0));
	result *= compare_ivec2((var[2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][2]), ivec2(0, 0));
	result *= compare_ivec2((var[2][3]), ivec2(0, 0));
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
	highp uint var[3][4];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((var[0][0]), 0u);
	result *= compare_uint((var[0][1]), 0u);
	result *= compare_uint((var[0][2]), 0u);
	result *= compare_uint((var[0][3]), 0u);
	result *= compare_uint((var[1][0]), 0u);
	result *= compare_uint((var[1][1]), 0u);
	result *= compare_uint((var[1][2]), 0u);
	result *= compare_uint((var[1][3]), 0u);
	result *= compare_uint((var[2][0]), 0u);
	result *= compare_uint((var[2][1]), 0u);
	result *= compare_uint((var[2][2]), 0u);
	result *= compare_uint((var[2][3]), 0u);
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
	highp uint var[3][4];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((var[0][0]), 0u);
	result *= compare_uint((var[0][1]), 0u);
	result *= compare_uint((var[0][2]), 0u);
	result *= compare_uint((var[0][3]), 0u);
	result *= compare_uint((var[1][0]), 0u);
	result *= compare_uint((var[1][1]), 0u);
	result *= compare_uint((var[1][2]), 0u);
	result *= compare_uint((var[1][3]), 0u);
	result *= compare_uint((var[2][0]), 0u);
	result *= compare_uint((var[2][1]), 0u);
	result *= compare_uint((var[2][2]), 0u);
	result *= compare_uint((var[2][3]), 0u);
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
	highp uint var[3][4];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((var[0][0]), 0u);
	result *= compare_uint((var[0][1]), 0u);
	result *= compare_uint((var[0][2]), 0u);
	result *= compare_uint((var[0][3]), 0u);
	result *= compare_uint((var[1][0]), 0u);
	result *= compare_uint((var[1][1]), 0u);
	result *= compare_uint((var[1][2]), 0u);
	result *= compare_uint((var[1][3]), 0u);
	result *= compare_uint((var[2][0]), 0u);
	result *= compare_uint((var[2][1]), 0u);
	result *= compare_uint((var[2][2]), 0u);
	result *= compare_uint((var[2][3]), 0u);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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
	highp mat2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	highp mat3x2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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
	u8vec2 var[3][4];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var[3][4];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(var[0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[0][3]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1][3]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2][3]), uvec3(0u, 0u, 0u));
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
	uint16_t padding;
	u16vec2 var[3][4];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
	result *= compare_u16vec2(uvec2(var[0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][3]), uvec2(0u, 0u));
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
	u16vec2 var[3][4];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
	result *= compare_u16vec2(uvec2(var[0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][3]), uvec2(0u, 0u));
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
	int16_t padding;
	i16vec3 var[3][4];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t padding;
	i16vec3 var[3][4];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t padding;
	float16_t var[3][4];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
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
	float16_t var[3][4];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
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
	float16_t padding;
	f16vec3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec3(vec3(var[0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][3]), vec3(0.0, 0.0, 0.0));
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
	float16_t padding;
	f16vec4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	bool var[3][4][2];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bool((var[0][0][0]), false);
	result *= compare_bool((var[0][0][1]), false);
	result *= compare_bool((var[0][1][0]), false);
	result *= compare_bool((var[0][1][1]), false);
	result *= compare_bool((var[0][2][0]), false);
	result *= compare_bool((var[0][2][1]), false);
	result *= compare_bool((var[0][3][0]), false);
	result *= compare_bool((var[0][3][1]), false);
	result *= compare_bool((var[1][0][0]), false);
	result *= compare_bool((var[1][0][1]), false);
	result *= compare_bool((var[1][1][0]), false);
	result *= compare_bool((var[1][1][1]), false);
	result *= compare_bool((var[1][2][0]), false);
	result *= compare_bool((var[1][2][1]), false);
	result *= compare_bool((var[1][3][0]), false);
	result *= compare_bool((var[1][3][1]), false);
	result *= compare_bool((var[2][0][0]), false);
	result *= compare_bool((var[2][0][1]), false);
	result *= compare_bool((var[2][1][0]), false);
	result *= compare_bool((var[2][1][1]), false);
	result *= compare_bool((var[2][2][0]), false);
	result *= compare_bool((var[2][2][1]), false);
	result *= compare_bool((var[2][3][0]), false);
	result *= compare_bool((var[2][3][1]), false);
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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


mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

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
	int16_t var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(var[0][0][0]), 0);
	result *= compare_int16_t(int(var[0][0][1]), 0);
	result *= compare_int16_t(int(var[0][1][0]), 0);
	result *= compare_int16_t(int(var[0][1][1]), 0);
	result *= compare_int16_t(int(var[0][2][0]), 0);
	result *= compare_int16_t(int(var[0][2][1]), 0);
	result *= compare_int16_t(int(var[0][3][0]), 0);
	result *= compare_int16_t(int(var[0][3][1]), 0);
	result *= compare_int16_t(int(var[1][0][0]), 0);
	result *= compare_int16_t(int(var[1][0][1]), 0);
	result *= compare_int16_t(int(var[1][1][0]), 0);
	result *= compare_int16_t(int(var[1][1][1]), 0);
	result *= compare_int16_t(int(var[1][2][0]), 0);
	result *= compare_int16_t(int(var[1][2][1]), 0);
	result *= compare_int16_t(int(var[1][3][0]), 0);
	result *= compare_int16_t(int(var[1][3][1]), 0);
	result *= compare_int16_t(int(var[2][0][0]), 0);
	result *= compare_int16_t(int(var[2][0][1]), 0);
	result *= compare_int16_t(int(var[2][1][0]), 0);
	result *= compare_int16_t(int(var[2][1][1]), 0);
	result *= compare_int16_t(int(var[2][2][0]), 0);
	result *= compare_int16_t(int(var[2][2][1]), 0);
	result *= compare_int16_t(int(var[2][3][0]), 0);
	result *= compare_int16_t(int(var[2][3][1]), 0);
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
	highp float var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((var[0][0][0]), 0.0);
	result *= compare_float((var[0][0][1]), 0.0);
	result *= compare_float((var[0][1][0]), 0.0);
	result *= compare_float((var[0][1][1]), 0.0);
	result *= compare_float((var[0][2][0]), 0.0);
	result *= compare_float((var[0][2][1]), 0.0);
	result *= compare_float((var[0][3][0]), 0.0);
	result *= compare_float((var[0][3][1]), 0.0);
	result *= compare_float((var[1][0][0]), 0.0);
	result *= compare_float((var[1][0][1]), 0.0);
	result *= compare_float((var[1][1][0]), 0.0);
	result *= compare_float((var[1][1][1]), 0.0);
	result *= compare_float((var[1][2][0]), 0.0);
	result *= compare_float((var[1][2][1]), 0.0);
	result *= compare_float((var[1][3][0]), 0.0);
	result *= compare_float((var[1][3][1]), 0.0);
	result *= compare_float((var[2][0][0]), 0.0);
	result *= compare_float((var[2][0][1]), 0.0);
	result *= compare_float((var[2][1][0]), 0.0);
	result *= compare_float((var[2][1][1]), 0.0);
	result *= compare_float((var[2][2][0]), 0.0);
	result *= compare_float((var[2][2][1]), 0.0);
	result *= compare_float((var[2][3][0]), 0.0);
	result *= compare_float((var[2][3][1]), 0.0);
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
	highp mat3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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
	highp mat3x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
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
	i8vec4 var[3][4][2];
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(var[0][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[0][3][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1][3][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2][3][1]), ivec4(0, 0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


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

layout(set = 0, binding = 0, std430) uniform Block
{
	uint16_t var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0][0][0]), 0u);
	result *= compare_uint16_t(uint(var[0][0][1]), 0u);
	result *= compare_uint16_t(uint(var[0][1][0]), 0u);
	result *= compare_uint16_t(uint(var[0][1][1]), 0u);
	result *= compare_uint16_t(uint(var[0][2][0]), 0u);
	result *= compare_uint16_t(uint(var[0][2][1]), 0u);
	result *= compare_uint16_t(uint(var[0][3][0]), 0u);
	result *= compare_uint16_t(uint(var[0][3][1]), 0u);
	result *= compare_uint16_t(uint(var[1][0][0]), 0u);
	result *= compare_uint16_t(uint(var[1][0][1]), 0u);
	result *= compare_uint16_t(uint(var[1][1][0]), 0u);
	result *= compare_uint16_t(uint(var[1][1][1]), 0u);
	result *= compare_uint16_t(uint(var[1][2][0]), 0u);
	result *= compare_uint16_t(uint(var[1][2][1]), 0u);
	result *= compare_uint16_t(uint(var[1][3][0]), 0u);
	result *= compare_uint16_t(uint(var[1][3][1]), 0u);
	result *= compare_uint16_t(uint(var[2][0][0]), 0u);
	result *= compare_uint16_t(uint(var[2][0][1]), 0u);
	result *= compare_uint16_t(uint(var[2][1][0]), 0u);
	result *= compare_uint16_t(uint(var[2][1][1]), 0u);
	result *= compare_uint16_t(uint(var[2][2][0]), 0u);
	result *= compare_uint16_t(uint(var[2][2][1]), 0u);
	result *= compare_uint16_t(uint(var[2][3][0]), 0u);
	result *= compare_uint16_t(uint(var[2][3][1]), 0u);
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	uint16_t var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0][0][0]), 0u);
	result *= compare_uint16_t(uint(var[0][0][1]), 0u);
	result *= compare_uint16_t(uint(var[0][1][0]), 0u);
	result *= compare_uint16_t(uint(var[0][1][1]), 0u);
	result *= compare_uint16_t(uint(var[0][2][0]), 0u);
	result *= compare_uint16_t(uint(var[0][2][1]), 0u);
	result *= compare_uint16_t(uint(var[0][3][0]), 0u);
	result *= compare_uint16_t(uint(var[0][3][1]), 0u);
	result *= compare_uint16_t(uint(var[1][0][0]), 0u);
	result *= compare_uint16_t(uint(var[1][0][1]), 0u);
	result *= compare_uint16_t(uint(var[1][1][0]), 0u);
	result *= compare_uint16_t(uint(var[1][1][1]), 0u);
	result *= compare_uint16_t(uint(var[1][2][0]), 0u);
	result *= compare_uint16_t(uint(var[1][2][1]), 0u);
	result *= compare_uint16_t(uint(var[1][3][0]), 0u);
	result *= compare_uint16_t(uint(var[1][3][1]), 0u);
	result *= compare_uint16_t(uint(var[2][0][0]), 0u);
	result *= compare_uint16_t(uint(var[2][0][1]), 0u);
	result *= compare_uint16_t(uint(var[2][1][0]), 0u);
	result *= compare_uint16_t(uint(var[2][1][1]), 0u);
	result *= compare_uint16_t(uint(var[2][2][0]), 0u);
	result *= compare_uint16_t(uint(var[2][2][1]), 0u);
	result *= compare_uint16_t(uint(var[2][3][0]), 0u);
	result *= compare_uint16_t(uint(var[2][3][1]), 0u);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

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
	float16_t var[3][4][2];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(var[0][0][0]), 0.0);
	result *= compare_float16_t(float(var[0][0][1]), 0.0);
	result *= compare_float16_t(float(var[0][1][0]), 0.0);
	result *= compare_float16_t(float(var[0][1][1]), 0.0);
	result *= compare_float16_t(float(var[0][2][0]), 0.0);
	result *= compare_float16_t(float(var[0][2][1]), 0.0);
	result *= compare_float16_t(float(var[0][3][0]), 0.0);
	result *= compare_float16_t(float(var[0][3][1]), 0.0);
	result *= compare_float16_t(float(var[1][0][0]), 0.0);
	result *= compare_float16_t(float(var[1][0][1]), 0.0);
	result *= compare_float16_t(float(var[1][1][0]), 0.0);
	result *= compare_float16_t(float(var[1][1][1]), 0.0);
	result *= compare_float16_t(float(var[1][2][0]), 0.0);
	result *= compare_float16_t(float(var[1][2][1]), 0.0);
	result *= compare_float16_t(float(var[1][3][0]), 0.0);
	result *= compare_float16_t(float(var[1][3][1]), 0.0);
	result *= compare_float16_t(float(var[2][0][0]), 0.0);
	result *= compare_float16_t(float(var[2][0][1]), 0.0);
	result *= compare_float16_t(float(var[2][1][0]), 0.0);
	result *= compare_float16_t(float(var[2][1][1]), 0.0);
	result *= compare_float16_t(float(var[2][2][0]), 0.0);
	result *= compare_float16_t(float(var[2][2][1]), 0.0);
	result *= compare_float16_t(float(var[2][3][0]), 0.0);
	result *= compare_float16_t(float(var[2][3][1]), 0.0);
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
	highp ivec3 var[3][4][2];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((var[0][0][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[0][0][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[0][1][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[0][1][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[0][2][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[0][2][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[0][3][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[0][3][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][0][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][0][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][1][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][1][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][2][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][2][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][3][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1][3][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][0][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][0][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][1][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][1][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][2][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][2][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][3][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2][3][1]), ivec3(0, 0, 0));
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
	bool padding;
	bvec2 var[3][4][2];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec3 var[3][4][2];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec3((var[0][0][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][0][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][1][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][1][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][2][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][2][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][3][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[0][3][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][0][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][0][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][1][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][1][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][2][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][2][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][3][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1][3][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][0][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][0][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][1][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][1][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][2][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][2][1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][3][0]), bvec3(false, false, false));
	result *= compare_bvec3((var[2][3][1]), bvec3(false, false, false));
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
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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
	highp mat3x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec3 var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(var[0][0][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][0][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][1][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][1][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][2][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][2][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][3][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][3][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][0][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][0][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][1][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][1][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][2][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][2][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][3][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][3][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][0][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][0][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][1][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][1][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][2][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][2][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][3][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][3][1]), ivec3(0, 0, 0));
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
	uint16_t padding;
	u16vec4 var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
	result *= compare_u16vec4(uvec4(var[0][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[0][3][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1][3][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2][3][1]), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

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
	int16_t padding;
	i16vec2 var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
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
	i16vec2 var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t padding;
	i16vec4 var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(var[0][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[0][3][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1][3][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2][3][1]), ivec4(0, 0, 0, 0));
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
	f16vec2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
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
	f16vec2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t padding;
	f16vec3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec3(vec3(var[0][0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][3][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[0][3][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][3][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1][3][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][3][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2][3][1]), vec3(0.0, 0.0, 0.0));
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
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

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
	f16vec4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec4(vec4(var[0][0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][3][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[0][3][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][3][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1][3][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][3][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2][3][1]), vec4(0.0, 0.0, 0.0, 0.0));
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

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

struct S
{
	highp uvec3 a; // unused in both shaders
	mediump mat2 b[4];
	lowp uint c;
};
layout(set = 0, binding = 0, std430) uniform Block
{
	mediump int u;
	S s[2][3];
	mediump vec2 v;
} block[3];

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
	result *= compare_int((block[0].u), 0);
	result *= compare_mat2((block[0].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][0].c), 0u);
	result *= compare_mat2((block[0].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][1].c), 0u);
	result *= compare_mat2((block[0].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][2].c), 0u);
	result *= compare_mat2((block[0].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][0].c), 0u);
	result *= compare_mat2((block[0].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][1].c), 0u);
	result *= compare_mat2((block[0].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][2].c), 0u);
	result *= compare_vec2((block[0].v), vec2(0.0, 0.0));
	result *= compare_int((block[1].u), 0);
	result *= compare_mat2((block[1].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][0].c), 0u);
	result *= compare_mat2((block[1].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][1].c), 0u);
	result *= compare_mat2((block[1].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][2].c), 0u);
	result *= compare_mat2((block[1].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][0].c), 0u);
	result *= compare_mat2((block[1].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][1].c), 0u);
	result *= compare_mat2((block[1].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][2].c), 0u);
	result *= compare_vec2((block[1].v), vec2(0.0, 0.0));
	result *= compare_int((block[2].u), 0);
	result *= compare_mat2((block[2].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][0].c), 0u);
	result *= compare_mat2((block[2].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][1].c), 0u);
	result *= compare_mat2((block[2].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][2].c), 0u);
	result *= compare_mat2((block[2].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][0].c), 0u);
	result *= compare_mat2((block[2].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][1].c), 0u);
	result *= compare_mat2((block[2].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][2].c), 0u);
	result *= compare_vec2((block[2].v), vec2(0.0, 0.0));
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
layout(set = 0, binding = 0, std430) uniform Block
{
	mediump int u;
	S s[2][3];
	mediump vec2 v;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((block[0].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][0].c), 0u);
	result *= compare_mat2((block[0].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][1].c), 0u);
	result *= compare_mat2((block[0].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][2].c), 0u);
	result *= compare_mat2((block[0].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][0].c), 0u);
	result *= compare_mat2((block[0].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][1].c), 0u);
	result *= compare_mat2((block[0].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][2].c), 0u);
	result *= compare_mat2((block[1].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][0].c), 0u);
	result *= compare_mat2((block[1].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][1].c), 0u);
	result *= compare_mat2((block[1].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][2].c), 0u);
	result *= compare_mat2((block[1].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][0].c), 0u);
	result *= compare_mat2((block[1].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][1].c), 0u);
	result *= compare_mat2((block[1].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][2].c), 0u);
	result *= compare_mat2((block[2].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][0].c), 0u);
	result *= compare_mat2((block[2].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][1].c), 0u);
	result *= compare_mat2((block[2].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][2].c), 0u);
	result *= compare_mat2((block[2].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][0].c), 0u);
	result *= compare_mat2((block[2].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][1].c), 0u);
	result *= compare_mat2((block[2].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][2].c), 0u);
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
layout(set = 0, binding = 0, std430) uniform Block
{
	mediump int u;
	S s[2][3];
	mediump vec2 v;
} block[3];

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
	result *= compare_mat2((block[0].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][0].c), 0u);
	result *= compare_mat2((block[0].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][1].c), 0u);
	result *= compare_mat2((block[0].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[0][2].c), 0u);
	result *= compare_mat2((block[0].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][0].c), 0u);
	result *= compare_mat2((block[0].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][1].c), 0u);
	result *= compare_mat2((block[0].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[0].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[0].s[1][2].c), 0u);
	result *= compare_mat2((block[1].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][0].c), 0u);
	result *= compare_mat2((block[1].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][1].c), 0u);
	result *= compare_mat2((block[1].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[0][2].c), 0u);
	result *= compare_mat2((block[1].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][0].c), 0u);
	result *= compare_mat2((block[1].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][1].c), 0u);
	result *= compare_mat2((block[1].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[1].s[1][2].c), 0u);
	result *= compare_mat2((block[2].s[0][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][0].c), 0u);
	result *= compare_mat2((block[2].s[0][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][1].c), 0u);
	result *= compare_mat2((block[2].s[0][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[0][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[0][2].c), 0u);
	result *= compare_mat2((block[2].s[1][0].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][0].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][0].c), 0u);
	result *= compare_mat2((block[2].s[1][1].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][1].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][1].c), 0u);
	result *= compare_mat2((block[2].s[1][2].b[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].s[1][2].b[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((block[2].s[1][2].c), 0u);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

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
	i8vec2 var;
};

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(var), ivec2(0, 0));
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
	i8vec4 var;
};

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

layout(set = 0, binding = 0, std140) uniform Block
{
	uint16_t var;
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

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
	i16vec3 var;
};

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

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


mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

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
	lowp ivec4 var;
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp ivec4 var;
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
	lowp uvec4 var;
};

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp mat3 var;
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat4 var;
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat4x2 var;
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
	result *= compare_vec2((var), vec2(0.0, 0.0));
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
	mediump vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((var), vec4(0.0, 0.0, 0.0, 0.0));
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
	mediump ivec4 var;
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((var), ivec4(0, 0, 0, 0));
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
	mediump uvec4 var;
};

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
	mediump uvec4 var;
};

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	mediump mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	mediump mat2x3 var;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
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
	mediump mat4x3 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp vec3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3((var), vec3(0.0, 0.0, 0.0));
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
	highp ivec3 var;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp ivec3 var;
};

mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((var), ivec3(0, 0, 0));
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
	highp ivec4 var;
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp ivec4 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2 var;
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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
	highp mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x4((var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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
	highp mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat3x2 var;
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat4x3 var;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec2 var;
};

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(var), ivec2(0, 0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	uint16_t var;
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

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
	u16vec3 var;
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var), uvec3(0u, 0u, 0u));
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
	u16vec3 var;
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var), uvec3(0u, 0u, 0u));
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
	i16vec2 var;
};

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(var), ivec2(0, 0));
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
	lowp vec2 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp vec3 var;
};

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
	lowp uint var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	lowp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
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
	lowp mat3 var;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	lowp mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	lowp mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430) uniform Block
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
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump uvec2 var;
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((var), uvec2(0u, 0u));
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
	mediump mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2(var[0], vec2(0.0, 0.0));
	result *= compare_vec2(var[1], vec2(0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
    imageStore(outImage, coord, vec4(result));
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
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat3 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	mediump mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat3x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp ivec4 var;
};

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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec4 var;
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3x2 var;
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec3 var;
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
	result *= compare_bvec3((var), bvec3(false, false, false));
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
	result *= compare_bool((padding), false);
	result *= compare_bvec3((var), bvec3(false, false, false));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var;
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
	result *= compare_u8vec3(uvec3(var), uvec3(0u, 0u, 0u));
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
	u8vec3 var;
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
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


mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

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
	int8_t padding;
	i8vec4 var;
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
	result *= compare_i8vec4(ivec4(var), ivec4(0, 0, 0, 0));
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
	int8_t padding;
	i8vec4 var;
};

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
	int8_t padding;
	i8vec4 var;
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

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


mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

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
	uint16_t var;
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var), 0u);
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
	int16_t padding;
	i16vec3 var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_i16vec3(ivec3(var), ivec3(0, 0, 0));
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
	int16_t padding;
	i16vec3 var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_i16vec3(ivec3(var), ivec3(0, 0, 0));
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
	lowp float var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((var), 0.0);
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
	lowp vec2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_vec2((var), vec2(0.0, 0.0));
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
	lowp uvec2 var;
};

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
	result *= compare_uint((padding), 0u);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	lowp mat3 var;
};

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	lowp mat3 var;
};

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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	lowp mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4((var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp mat2x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x4((var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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
	lowp mat4x3 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	mediump vec3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_vec3((var), vec3(0.0, 0.0, 0.0));
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
	mediump ivec2 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_ivec2((var), ivec2(0, 0));
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
	mediump uint var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	mediump uvec3 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec3((var), uvec3(0u, 0u, 0u));
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
	mediump mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4((var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	mediump mat2x3 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

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
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	mediump mat3x2 var;
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	mediump mat3x2 var;
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	mediump mat3x2 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	mediump mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_vec4((var), vec4(0.0, 0.0, 0.0, 0.0));
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
	highp vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_vec4((var), vec4(0.0, 0.0, 0.0, 0.0));
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
	highp ivec2 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_ivec2((var), ivec2(0, 0));
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3(var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_float(var[0][0], 0.0);
	result *= compare_float(var[0][1], 0.0);
	result *= compare_float(var[0][2], 0.0);
	result *= compare_float(var[1][0], 0.0);
	result *= compare_float(var[1][1], 0.0);
	result *= compare_float(var[1][2], 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x4 var;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x2 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2]), mat2(0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4x2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((var[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	u8vec4 var[3];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
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
	i8vec2 var[3];
};

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(var[0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2]), ivec2(0, 0));
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
	i8vec2 var[3];
};

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(var[0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2]), ivec2(0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec3 var[3];
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec3((var[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2]), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
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
	bvec4 var[3];
};

mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((var[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2]), bvec4(false, false, false, false));
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
	highp mat3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((var[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat3x2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x2((var[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((var[2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	u8vec2 var[3];
};

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2]), uvec2(0u, 0u));
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
	u8vec2 var[3];
};

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2]), uvec2(0u, 0u));
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
	u8vec4 var[3];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

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
	i8vec3 var[3];
};

mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(var[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2]), ivec3(0, 0, 0));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec4 var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec4((var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2]), uvec4(0u, 0u, 0u, 0u));
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
	bvec2 var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
	result *= compare_bvec2((var[0]), bvec2(false, false));
	result *= compare_bvec2((var[1]), bvec2(false, false));
	result *= compare_bvec2((var[2]), bvec2(false, false));
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
	highp mat2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2((var[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2]), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2((var[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2]), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((var[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2]), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2((var[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2]), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2((var[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((var[2]), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3((var[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((var[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((var[2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat4x2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4x2((var[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((var[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	result *= compare_float((padding), 0.0);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	uint8_t var[3];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
	result *= compare_uint8_t(uint(var[0]), 0u);
	result *= compare_uint8_t(uint(var[1]), 0u);
	result *= compare_uint8_t(uint(var[2]), 0u);
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
	uint8_t padding;
	u8vec4 var[3];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
	result *= compare_u8vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
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
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

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
	uint16_t padding;
	u16vec3 var[3];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
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
	float16_t padding;
	float16_t var[3];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(var[0]), 0.0);
	result *= compare_float16_t(float(var[1]), 0.0);
	result *= compare_float16_t(float(var[2]), 0.0);
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
	f16vec3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(var[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2]), vec3(0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
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
	highp float var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((var[0]), 0.0);
	result *= compare_float((var[1]), 0.0);
	result *= compare_float((var[2]), 0.0);
	result *= compare_float((var[3]), 0.0);
	result *= compare_float((var[4]), 0.0);
	result *= compare_float((var[5]), 0.0);
	result *= compare_float((var[6]), 0.0);
	result *= compare_float((var[7]), 0.0);
	result *= compare_float((var[8]), 0.0);
	result *= compare_float((var[9]), 0.0);
	result *= compare_float((var[10]), 0.0);
	result *= compare_float((var[11]), 0.0);
	result *= compare_float((var[12]), 0.0);
	result *= compare_float((var[13]), 0.0);
	result *= compare_float((var[14]), 0.0);
	result *= compare_float((var[15]), 0.0);
	result *= compare_float((var[16]), 0.0);
	result *= compare_float((var[17]), 0.0);
	result *= compare_float((var[18]), 0.0);
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((var[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[4]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[5]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[6]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[7]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[8]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[9]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[10]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[11]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[12]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[13]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[14]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[15]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[16]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[17]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[18]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4x2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	u8vec4 var[];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[7]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[8]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[9]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[10]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[11]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[12]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[13]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[14]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[15]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[16]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[17]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[18]), uvec4(0u, 0u, 0u, 0u));
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
	u8vec4 var[];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[7]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[8]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[9]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[10]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[11]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[12]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[13]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[14]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[15]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[16]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[17]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[18]), uvec4(0u, 0u, 0u, 0u));
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
	float16_t var[];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(var[0]), 0.0);
	result *= compare_float16_t(float(var[1]), 0.0);
	result *= compare_float16_t(float(var[2]), 0.0);
	result *= compare_float16_t(float(var[3]), 0.0);
	result *= compare_float16_t(float(var[4]), 0.0);
	result *= compare_float16_t(float(var[5]), 0.0);
	result *= compare_float16_t(float(var[6]), 0.0);
	result *= compare_float16_t(float(var[7]), 0.0);
	result *= compare_float16_t(float(var[8]), 0.0);
	result *= compare_float16_t(float(var[9]), 0.0);
	result *= compare_float16_t(float(var[10]), 0.0);
	result *= compare_float16_t(float(var[11]), 0.0);
	result *= compare_float16_t(float(var[12]), 0.0);
	result *= compare_float16_t(float(var[13]), 0.0);
	result *= compare_float16_t(float(var[14]), 0.0);
	result *= compare_float16_t(float(var[15]), 0.0);
	result *= compare_float16_t(float(var[16]), 0.0);
	result *= compare_float16_t(float(var[17]), 0.0);
	result *= compare_float16_t(float(var[18]), 0.0);
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp vec4 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4((var[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[4]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[5]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[6]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[7]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[8]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[9]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[10]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[11]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[12]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[13]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[14]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[15]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[16]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[17]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[18]), vec4(0.0, 0.0, 0.0, 0.0));
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
	highp mat2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2x4 var[];
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
	result *= compare_mat2x4((var[3]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[4]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[5]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[6]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[7]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[8]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[9]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[10]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[11]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[12]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[13]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[14]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[15]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[16]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[17]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[18]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat4x2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat4x3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[8]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[9]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[10]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[11]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[12]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[13]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[14]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[15]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[16]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[17]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[18]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	int16_t var[];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int16_t(int(var[0]), 0);
	result *= compare_int16_t(int(var[1]), 0);
	result *= compare_int16_t(int(var[2]), 0);
	result *= compare_int16_t(int(var[3]), 0);
	result *= compare_int16_t(int(var[4]), 0);
	result *= compare_int16_t(int(var[5]), 0);
	result *= compare_int16_t(int(var[6]), 0);
	result *= compare_int16_t(int(var[7]), 0);
	result *= compare_int16_t(int(var[8]), 0);
	result *= compare_int16_t(int(var[9]), 0);
	result *= compare_int16_t(int(var[10]), 0);
	result *= compare_int16_t(int(var[11]), 0);
	result *= compare_int16_t(int(var[12]), 0);
	result *= compare_int16_t(int(var[13]), 0);
	result *= compare_int16_t(int(var[14]), 0);
	result *= compare_int16_t(int(var[15]), 0);
	result *= compare_int16_t(int(var[16]), 0);
	result *= compare_int16_t(int(var[17]), 0);
	result *= compare_int16_t(int(var[18]), 0);
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


mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

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
	i16vec2 var[];
};

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(var[0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[3]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[4]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[5]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[6]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[7]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[8]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[9]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[10]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[11]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[12]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[13]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[14]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[15]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[16]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[17]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[18]), ivec2(0, 0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(var[0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[3]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[4]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[5]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[6]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[7]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[8]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[9]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[10]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[11]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[12]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[13]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[14]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[15]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[16]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[17]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[18]), vec2(0.0, 0.0));
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
	f16vec3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(var[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[6]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[7]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[8]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[9]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[10]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[11]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[12]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[13]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[14]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[15]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[16]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[17]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[18]), vec3(0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(var[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[6]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[7]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[8]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[9]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[10]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[11]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[12]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[13]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[14]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[15]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[16]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[17]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[18]), vec3(0.0, 0.0, 0.0));
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
	f16vec3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(var[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[6]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[7]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[8]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[9]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[10]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[11]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[12]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[13]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[14]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[15]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[16]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[17]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(var[18]), vec3(0.0, 0.0, 0.0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	highp mat4 var[];
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	highp mat3x2 var[];
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp mat3x4 var[];
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	highp mat4x3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[8]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[9]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[10]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[11]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[12]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[13]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[14]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[15]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[16]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[17]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[18]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	u16vec4 var[];
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[7]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[8]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[9]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[10]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[11]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[12]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[13]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[14]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[15]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[16]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[17]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[18]), uvec4(0u, 0u, 0u, 0u));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	u16vec4 var[];
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[7]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[8]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[9]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[10]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[11]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[12]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[13]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[14]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[15]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[16]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[17]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[18]), uvec4(0u, 0u, 0u, 0u));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	i16vec4 var[];
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(var[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[4]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[5]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[6]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[7]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[8]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[9]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[10]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[11]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[12]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[13]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[14]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[15]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[16]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[17]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[18]), ivec4(0, 0, 0, 0));
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
	highp ivec3 a; // unused in both shaders
	mediump mat3 b[4];
	highp vec4 c;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
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
	highp ivec3 a; // unused in both shaders
	mediump mat3 b[4];
	highp vec4 c;
};
layout(set = 0, binding = 0, scalar) uniform Block
{
	lowp uint u;
	S s[3];
	mediump vec4 v;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((s[0].b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[0].b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[0].b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[0].b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((s[0].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[1].b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[1].b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[1].b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[1].b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((s[1].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[2].b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[2].b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[2].b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s[2].b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((s[2].c), vec4(0.0, 0.0, 0.0, 0.0));
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
	mediump mat3 b[4];
	highp vec4 c; // unused in both shaders
};
struct T
{
	mediump mat3 a;
	S b;
};
layout(set = 0, binding = 0, std140) uniform Block
{
	S s;
	lowp vec2 v; // unused in both shaders
	T t;
	highp uint u;
};

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
	result *= compare_ivec3((s.a), ivec3(0, 0, 0));
	result *= compare_mat3((s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((u), 0u);
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
	mediump mat3 b[4];
	highp vec4 c; // unused in both shaders
};
struct T
{
	mediump mat3 a;
	S b;
};
layout(set = 0, binding = 0, std430) uniform Block
{
	S s;
	lowp vec2 v; // unused in both shaders
	T t;
	highp uint u;
};

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
	result *= compare_ivec3((s.a), ivec3(0, 0, 0));
	result *= compare_mat3((s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t.b.a), ivec3(0, 0, 0));
	result *= compare_mat3((t.b.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.b.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.b.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t.b.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
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
layout(set = 0, binding = 0, std140) uniform Block
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
	result *= compare_uint((block[0].u), 0u);
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
	result *= compare_uint((block[1].u), 0u);
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
	result *= compare_uint((block[2].u), 0u);
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
    v_vtxResult = result;
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
	highp float var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

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
	highp vec3 var;
} block[3];

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
	bvec3 var;
} block[3];

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

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec3 var;
} block[3];

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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((block[0].var), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].var), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].var), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((block[0].var), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[1].var), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((block[2].var), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4((block[0].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((block[1].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((block[2].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((block[0].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((block[1].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((block[2].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x4((block[0].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[1].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[2].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x2((block[0].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[1].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[2].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((block[0].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[1].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[2].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat4x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3(block[0].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[0].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[0].var[2], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[0].var[3], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[0][2], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[1][2], 0.0);
	result *= compare_float(block[0].var[2][0], 0.0);
	result *= compare_float(block[0].var[2][1], 0.0);
	result *= compare_float(block[0].var[2][2], 0.0);
	result *= compare_float(block[0].var[3][0], 0.0);
	result *= compare_float(block[0].var[3][1], 0.0);
	result *= compare_float(block[0].var[3][2], 0.0);
	result *= compare_vec3(block[1].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[1].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[1].var[2], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[1].var[3], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[0][2], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[1][2], 0.0);
	result *= compare_float(block[1].var[2][0], 0.0);
	result *= compare_float(block[1].var[2][1], 0.0);
	result *= compare_float(block[1].var[2][2], 0.0);
	result *= compare_float(block[1].var[3][0], 0.0);
	result *= compare_float(block[1].var[3][1], 0.0);
	result *= compare_float(block[1].var[3][2], 0.0);
	result *= compare_vec3(block[2].var[0], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[2].var[1], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[2].var[2], vec3(0.0, 0.0, 0.0));
	result *= compare_vec3(block[2].var[3], vec3(0.0, 0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[0][2], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[1][2], 0.0);
	result *= compare_float(block[2].var[2][0], 0.0);
	result *= compare_float(block[2].var[2][1], 0.0);
	result *= compare_float(block[2].var[2][2], 0.0);
	result *= compare_float(block[2].var[3][0], 0.0);
	result *= compare_float(block[2].var[3][1], 0.0);
	result *= compare_float(block[2].var[3][2], 0.0);
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
	u8vec2 var;
} block[3];

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

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


mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

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
	u16vec2 var;
} block[3];

mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

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
	int16_t var;
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

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
	int16_t var;
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

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
	i16vec2 var;
} block[3];

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(block[0].var), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(block[1].var), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(block[2].var), ivec2(0, 0));
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
	f16vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(block[0].var), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(block[1].var), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(block[2].var), vec2(0.0, 0.0));
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
	f16vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(block[0].var), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(block[1].var), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(block[2].var), vec2(0.0, 0.0));
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
	f16vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(block[0].var), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(block[1].var), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(block[2].var), vec2(0.0, 0.0));
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
	highp ivec4 var;
} block[3];

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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec4 var;
} block[3];

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec3 var;
} block[3];

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

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec3 var;
} block[3];

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec4 var;
} block[3];

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
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
	result *= compare_mat4((block[0].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((block[1].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((block[2].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x4((block[0].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[1].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[2].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	result *= compare_mat2x4((block[0].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[1].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[2].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x2((block[0].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[1].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[2].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((block[0].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[1].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((block[2].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
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
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2(block[0].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[0].var[1], vec2(0.0, 0.0));
	result *= compare_vec2(block[0].var[2], vec2(0.0, 0.0));
	result *= compare_vec2(block[0].var[3], vec2(0.0, 0.0));
	result *= compare_float(block[0].var[0][0], 0.0);
	result *= compare_float(block[0].var[0][1], 0.0);
	result *= compare_float(block[0].var[1][0], 0.0);
	result *= compare_float(block[0].var[1][1], 0.0);
	result *= compare_float(block[0].var[2][0], 0.0);
	result *= compare_float(block[0].var[2][1], 0.0);
	result *= compare_float(block[0].var[3][0], 0.0);
	result *= compare_float(block[0].var[3][1], 0.0);
	result *= compare_vec2(block[1].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[1].var[1], vec2(0.0, 0.0));
	result *= compare_vec2(block[1].var[2], vec2(0.0, 0.0));
	result *= compare_vec2(block[1].var[3], vec2(0.0, 0.0));
	result *= compare_float(block[1].var[0][0], 0.0);
	result *= compare_float(block[1].var[0][1], 0.0);
	result *= compare_float(block[1].var[1][0], 0.0);
	result *= compare_float(block[1].var[1][1], 0.0);
	result *= compare_float(block[1].var[2][0], 0.0);
	result *= compare_float(block[1].var[2][1], 0.0);
	result *= compare_float(block[1].var[3][0], 0.0);
	result *= compare_float(block[1].var[3][1], 0.0);
	result *= compare_vec2(block[2].var[0], vec2(0.0, 0.0));
	result *= compare_vec2(block[2].var[1], vec2(0.0, 0.0));
	result *= compare_vec2(block[2].var[2], vec2(0.0, 0.0));
	result *= compare_vec2(block[2].var[3], vec2(0.0, 0.0));
	result *= compare_float(block[2].var[0][0], 0.0);
	result *= compare_float(block[2].var[0][1], 0.0);
	result *= compare_float(block[2].var[1][0], 0.0);
	result *= compare_float(block[2].var[1][1], 0.0);
	result *= compare_float(block[2].var[2][0], 0.0);
	result *= compare_float(block[2].var[2][1], 0.0);
	result *= compare_float(block[2].var[3][0], 0.0);
	result *= compare_float(block[2].var[3][1], 0.0);
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
	u8vec3 var;
} block[3];

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

layout(set = 0, binding = 0, std430) uniform Block
{
	u8vec4 var;
} block[3];

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(block[0].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(block[1].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(block[2].var), uvec4(0u, 0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

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
	int8_t var;
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(block[0].var), 0);
	result *= compare_int8_t(int(block[1].var), 0);
	result *= compare_int8_t(int(block[2].var), 0);
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
	int8_t var;
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(block[0].var), 0);
	result *= compare_int8_t(int(block[1].var), 0);
	result *= compare_int8_t(int(block[2].var), 0);
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
	float16_t var;
} block[3];

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

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
	result *= compare_f16vec4(vec4(block[0].var), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(block[1].var), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(block[2].var), vec4(0.0, 0.0, 0.0, 0.0));
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
	f16vec4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec4 var;
} block[3];

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((block[0].padding), 0u);
	result *= compare_uvec4((block[0].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((block[1].padding), 0u);
	result *= compare_uvec4((block[1].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((block[2].padding), 0u);
	result *= compare_uvec4((block[2].var), uvec4(0u, 0u, 0u, 0u));
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
	highp mat2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat2((block[0].var), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat2((block[1].var), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat2((block[2].var), mat2(0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat3((block[0].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat3((block[1].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat3((block[2].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat4((block[0].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat4((block[1].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat4((block[2].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat4((block[0].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat4((block[1].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat4((block[2].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	float padding;
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat2x4((block[0].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat2x4((block[1].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat2x4((block[2].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat2x4((block[0].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat2x4((block[1].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat2x4((block[2].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar) uniform Block
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
	uint8_t var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(block[0].var), 0u);
	result *= compare_uint8_t(uint(block[1].var), 0u);
	result *= compare_uint8_t(uint(block[2].var), 0u);
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
	uint8_t padding;
	u8vec2 var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(block[0].padding), 0u);
	result *= compare_u8vec2(uvec2(block[0].var), uvec2(0u, 0u));
	result *= compare_uint8_t(uint(block[1].padding), 0u);
	result *= compare_u8vec2(uvec2(block[1].var), uvec2(0u, 0u));
	result *= compare_uint8_t(uint(block[2].padding), 0u);
	result *= compare_u8vec2(uvec2(block[2].var), uvec2(0u, 0u));
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
	u8vec3 var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(block[0].padding), 0u);
	result *= compare_u8vec3(uvec3(block[0].var), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(block[1].padding), 0u);
	result *= compare_u8vec3(uvec3(block[1].var), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(block[2].padding), 0u);
	result *= compare_u8vec3(uvec3(block[2].var), uvec3(0u, 0u, 0u));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t var;
} block[3];

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

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
	int16_t padding;
	i16vec2 var;
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

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


mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
	int16_t padding;
	i16vec3 var;
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(block[0].padding), 0);
	result *= compare_i16vec3(ivec3(block[0].var), ivec3(0, 0, 0));
	result *= compare_int16_t(int(block[1].padding), 0);
	result *= compare_i16vec3(ivec3(block[1].var), ivec3(0, 0, 0));
	result *= compare_int16_t(int(block[2].padding), 0);
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


mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, scalar) uniform BlockA
{
	highp float a;
	lowp uvec3 b; // unused in both shaders
	mediump mat2 c;
} blockA;
layout(set = 0, binding = 1, scalar) uniform BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c; // unused in both shaders
	bool d;
} blockB;

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
	result *= compare_vec2(blockA.c[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockA.c[1], vec2(0.0, 0.0));
	result *= compare_float(blockA.c[0][0], 0.0);
	result *= compare_float(blockA.c[0][1], 0.0);
	result *= compare_float(blockA.c[1][0], 0.0);
	result *= compare_float(blockA.c[1][1], 0.0);
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform BlockA
{
	highp float a;
	lowp uvec3 b; // unused in both shaders
	mediump mat2 c;
} blockA;
layout(set = 0, binding = 1, scalar) uniform BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c; // unused in both shaders
	bool d;
} blockB;

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
	result *= compare_vec2(blockA.c[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockA.c[1], vec2(0.0, 0.0));
	result *= compare_float(blockA.c[0][0], 0.0);
	result *= compare_float(blockA.c[0][1], 0.0);
	result *= compare_float(blockA.c[1][0], 0.0);
	result *= compare_float(blockA.c[1][1], 0.0);
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
    mediump float result = 1.0;
	result *= compare_float((blockA[0].a), 0.0);
	result *= compare_mat3((blockA[0].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[0].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[0].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockA[1].a), 0.0);
	result *= compare_mat3((blockA[1].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[1].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[1].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockA[2].a), 0.0);
	result *= compare_mat3((blockA[2].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[2].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[2].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockB[0].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB[0].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[0].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[0].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[0].b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[0].d), false);
	result *= compare_mat2((blockB[1].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB[1].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[1].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[1].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[1].b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[1].d), false);
	result *= compare_mat2((blockB[2].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB[2].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[2].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[2].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[2].b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[2].d), false);
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
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((blockA[0].a), 0.0);
	result *= compare_mat3((blockA[0].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[0].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[0].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockA[1].a), 0.0);
	result *= compare_mat3((blockA[1].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[1].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[1].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockA[2].a), 0.0);
	result *= compare_mat3((blockA[2].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[2].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[2].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockB[0].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB[0].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[0].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[0].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[0].b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[0].d), false);
	result *= compare_mat2((blockB[1].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB[1].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[1].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[1].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[1].b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[1].d), false);
	result *= compare_mat2((blockB[2].a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB[2].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[2].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[2].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[2].b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB[2].d), false);
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
	result *= compare_mat2((blockB.a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB.b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB.b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB.b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB.b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB.d), false);
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
layout(set = 0, binding = 0, std430) uniform BlockA
{
	highp float a;
	S b;
	lowp uvec3 c; // unused in both shaders
} blockA;

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
	result *= compare_float((blockA.a), 0.0);
	result *= compare_mat3((blockA.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA.b.c), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
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
	lowp uvec3 a;
	mediump uvec4 b;
	lowp int c; // unused in vertex shader
	bool d; // unused in fragment shader
	bvec4 e;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump ivec4 f;
	bvec3 g; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	lowp vec2 h; // unused in fragment shader
	bvec3 i; // unused in fragment shader
	highp vec4 j;
	mediump vec2 k;
	highp uvec2 l; // unused in fragment shader
};
layout(set = 0, binding = 3) uniform BlockE
{
	bvec2 m;
	bvec2 n;
	highp float o;
	highp uint p; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec3((blockB.a), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockB.b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockB.c), 0);
	result *= compare_bvec4((blockB.e), bvec4(false, false, false, false));
	result *= compare_ivec4((blockC.f), ivec4(0, 0, 0, 0));
	result *= compare_bvec3((blockC.g), bvec3(false, false, false));
	result *= compare_vec4((j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((k), vec2(0.0, 0.0));
	result *= compare_bvec2((m), bvec2(false, false));
	result *= compare_bvec2((n), bvec2(false, false));
	result *= compare_float((o), 0.0);
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
	lowp uvec3 a;
	mediump uvec4 b;
	lowp int c; // unused in vertex shader
	bool d; // unused in fragment shader
	bvec4 e;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump ivec4 f;
	bvec3 g; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	lowp vec2 h; // unused in fragment shader
	bvec3 i; // unused in fragment shader
	highp vec4 j;
	mediump vec2 k;
	highp uvec2 l; // unused in fragment shader
};
layout(set = 0, binding = 3) uniform BlockE
{
	bvec2 m;
	bvec2 n;
	highp float o;
	highp uint p; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec3((blockB.a), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockB.b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bool((blockB.d), false);
	result *= compare_bvec4((blockB.e), bvec4(false, false, false, false));
	result *= compare_ivec4((blockC.f), ivec4(0, 0, 0, 0));
	result *= compare_vec2((h), vec2(0.0, 0.0));
	result *= compare_bvec3((i), bvec3(false, false, false));
	result *= compare_vec4((j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((k), vec2(0.0, 0.0));
	result *= compare_uvec2((l), uvec2(0u, 0u));
	result *= compare_bvec2((m), bvec2(false, false));
	result *= compare_bvec2((n), bvec2(false, false));
	result *= compare_float((o), 0.0);
	result *= compare_uint((p), 0u);
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
	lowp ivec4 i; // unused in fragment shader
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp ivec4 j;
	mediump uvec4 k;
	mediump ivec4 l; // unused in vertex shader
	lowp uvec4 m;
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	lowp uint n;
	lowp vec3 o;
	lowp int p;
	highp ivec3 q;
	lowp uint r;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((i), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockG.j), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((blockG.k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((blockG.l), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((blockG.m), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((blockH.n), 0u);
	result *= compare_vec3((blockH.o), vec3(0.0, 0.0, 0.0));
	result *= compare_int((blockH.p), 0);
	result *= compare_ivec3((blockH.q), ivec3(0, 0, 0));
	result *= compare_uint((blockH.r), 0u);
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
	lowp vec4 a; // unused in vertex shader
	lowp mat3x4 b; // unused in vertex shader
	lowp ivec3 c;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	lowp mat3x2 d;
	mediump uvec2 e;
	mediump ivec2 f;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp ivec3 g;
	highp mat4x2 h; // unused in both shaders
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	lowp mat2x3 i;
	lowp mat3x4 j; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4((blockB.a), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB.b), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockB.c), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockC.d), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockC.e), uvec2(0u, 0u));
	result *= compare_ivec2((blockC.f), ivec2(0, 0));
	result *= compare_ivec3((g), ivec3(0, 0, 0));
	result *= compare_mat2x3((blockE.i), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp vec4 a; // unused in vertex shader
	lowp mat3x4 b; // unused in vertex shader
	lowp ivec3 c;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	lowp mat3x2 d;
	mediump uvec2 e;
	mediump ivec2 f;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp ivec3 g;
	highp mat4x2 h; // unused in both shaders
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	lowp mat2x3 i;
	lowp mat3x4 j; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((blockB.c), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockC.d), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockC.e), uvec2(0u, 0u));
	result *= compare_ivec2((blockC.f), ivec2(0, 0));
	result *= compare_ivec3((g), ivec3(0, 0, 0));
	result *= compare_mat2x3((blockE.i), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockE.j), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	mediump uvec3 j;
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	highp vec3 k;
	lowp mat4x2 l;
	lowp float m;
} blockG;
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	bvec2 n;
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	highp mat3x2 o;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec3((blockF.j), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockG.k), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.l), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockG.m), 0.0);
	result *= compare_bvec2((blockH.n), bvec2(false, false));
	result *= compare_mat3x2((blockI.o), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp vec2 a;
};
layout(set = 0, binding = 1) uniform BlockC
{
	lowp ivec2 b; // unused in fragment shader
	mediump uint c; // unused in vertex shader
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	highp uvec2 i;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2((a), vec2(0.0, 0.0));
	result *= compare_uint((c), 0u);
	result *= compare_uvec2((i), uvec2(0u, 0u));
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
	lowp vec2 a;
};
layout(set = 0, binding = 1) uniform BlockC
{
	lowp ivec2 b; // unused in fragment shader
	mediump uint c; // unused in vertex shader
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	highp ivec3 d;
	bvec2 e;
	highp uvec2 f;
	lowp vec2 g;
	lowp mat3x4 h[5];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2((a), vec2(0.0, 0.0));
	result *= compare_ivec2((b), ivec2(0, 0));
	result *= compare_ivec3((d), ivec3(0, 0, 0));
	result *= compare_bvec2((e), bvec2(false, false));
	result *= compare_uvec2((f), uvec2(0u, 0u));
	result *= compare_vec2((g), vec2(0.0, 0.0));
	result *= compare_mat3x4((h[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((h[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((h[2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((h[3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((h[4]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, row_major) uniform BlockG
{
	bvec3 s; // unused in fragment shader
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	highp int t;
	highp uvec3 u[2]; // unused in both shaders
	highp vec2 v;
	mediump uvec2 w;
} blockH;
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	mediump vec2 x;
	bvec2 y;
} blockI;
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	bvec2 z;
	lowp mat4x2 aa[2]; // unused in vertex shader
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((s), bvec3(false, false, false));
	result *= compare_int((blockH.t), 0);
	result *= compare_uvec3((blockH.u[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockH.u[1]), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockH.v), vec2(0.0, 0.0));
	result *= compare_uvec2((blockH.w), uvec2(0u, 0u));
	result *= compare_vec2((blockI.x), vec2(0.0, 0.0));
	result *= compare_bvec2((blockI.y), bvec2(false, false));
	result *= compare_bvec2((blockJ.z), bvec2(false, false));
	result *= compare_mat4x2((blockJ.aa[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockJ.aa[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump mat4 a;
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	mediump mat4 h; // unused in vertex shader
	bvec3 i;
	mediump mat4x3 j;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp vec3 k; // unused in both shaders
	bvec3 l; // unused in vertex shader
	lowp uvec2 m;
	mediump ivec4 n;
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	highp vec2 o; // unused in vertex shader
	bvec3 p; // unused in fragment shader
	mediump ivec4 q;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((h), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((i), bvec3(false, false, false));
	result *= compare_mat4x3((j), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((l), bvec3(false, false, false));
	result *= compare_uvec2((m), uvec2(0u, 0u));
	result *= compare_ivec4((n), ivec4(0, 0, 0, 0));
	result *= compare_vec2((o), vec2(0.0, 0.0));
	result *= compare_ivec4((q), ivec4(0, 0, 0, 0));
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
	mediump mat4 a;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	mediump int b;
};
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	highp int c;
	lowp uvec2 d;
	highp mat4 e;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp ivec2 f;
	mediump mat4x2 g;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((b), 0);
	result *= compare_int((blockD.c), 0);
	result *= compare_uvec2((blockD.d), uvec2(0u, 0u));
	result *= compare_mat4((blockD.e), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((f), ivec2(0, 0));
	result *= compare_mat4x2((g), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump uint mA;
	lowp mat4 mB;
	lowp mat2 mC;
};
struct sB
{
	bool mA; // unused in vertex shader
};
struct sC
{
	bvec3 mA;
	highp uvec3 mB; // unused in fragment shader
	mediump float mC;
	highp mat3x4 mD;
};
struct sD
{
	mediump mat2x3 mA; // unused in both shaders
	sC mB; // unused in fragment shader
};
struct sE
{
	bvec3 mA;
	mediump mat4x3 mB; // unused in vertex shader
	bvec2 mC; // unused in fragment shader
	highp vec3 mD;
};
struct sF
{
	highp mat3x4 mA;
	sE mB;
	mediump vec2 mC;
};
struct sG
{
	lowp mat4 mA;
	bvec4 mB;
};
struct sH
{
	lowp ivec3 mA;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	highp mat3x2 r; // unused in vertex shader
	sG s; // unused in fragment shader
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	mediump mat3 t; // unused in fragment shader
	highp vec2 u;
	mediump mat4x3 v;
	sH w;
};
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	mediump vec4 x;
	highp ivec4 y;
	lowp mat4x3 z; // unused in fragment shader
	lowp vec4 aa;
	highp ivec3 ab; // unused in fragment shader
} blockI;

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((r), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((s.mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((s.mB), bvec4(false, false, false, false));
	result *= compare_mat3((t), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((u), vec2(0.0, 0.0));
	result *= compare_mat4x3((v), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((w.mA), ivec3(0, 0, 0));
	result *= compare_vec4((blockI.x), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockI.y), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((blockI.z), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockI.aa), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockI.ab), ivec3(0, 0, 0));
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
	mediump ivec3 mA;
	lowp ivec2 mB;
	highp int mC[4];
	bvec3 mD; // unused in fragment shader
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp vec2 t;
	lowp mat3x4 u;
	lowp vec3 v;
	lowp mat2x3 w;
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	highp ivec2 x;
	mediump mat4 y; // unused in vertex shader
	lowp vec4 z;
} blockH;
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	sA aa;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((t), vec2(0.0, 0.0));
	result *= compare_mat3x4((u), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((v), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((w), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockH.x), ivec2(0, 0));
	result *= compare_mat4((blockH.y), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockH.z), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockI.aa.mA), ivec3(0, 0, 0));
	result *= compare_ivec2((blockI.aa.mB), ivec2(0, 0));
	result *= compare_int((blockI.aa.mC[0]), 0);
	result *= compare_int((blockI.aa.mC[1]), 0);
	result *= compare_int((blockI.aa.mC[2]), 0);
	result *= compare_int((blockI.aa.mC[3]), 0);
	result *= compare_bvec3((blockI.aa.mD), bvec3(false, false, false));
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
	bvec3 mA;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	lowp float a;
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	lowp mat4x2 b;
	sA c;
};
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	mediump ivec3 d;
};
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	lowp ivec4 e;
	highp mat4x3 f;
	lowp mat4x3 g; // unused in fragment shader
	highp uvec3 h; // unused in vertex shader
	bvec4 i; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((blockB.a), 0.0);
	result *= compare_mat4x2((b), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((c.mA), bvec3(false, false, false));
	result *= compare_ivec3((d), ivec3(0, 0, 0));
	result *= compare_ivec4((e), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((f), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((h), uvec3(0u, 0u, 0u));
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
	bvec3 mA;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	lowp float a;
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	lowp mat4x2 b;
	sA c;
};
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	mediump ivec3 d;
};
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	lowp ivec4 e;
	highp mat4x3 f;
	lowp mat4x3 g; // unused in fragment shader
	highp uvec3 h; // unused in vertex shader
	bvec4 i; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((blockB.a), 0.0);
	result *= compare_mat4x2((b), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((c.mA), bvec3(false, false, false));
	result *= compare_ivec3((d), ivec3(0, 0, 0));
	result *= compare_ivec4((e), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((f), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((g), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump ivec2 mA;
};
struct sB
{
	mediump mat3 mA;
	bool mB;
	highp ivec2 mC;
};
struct sC
{
	mediump mat3 mA;
	highp mat4 mB;
};
struct sD
{
	sC mA;
	mediump mat4x3 mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp mat2x3 a; // unused in vertex shader
	highp uvec2 b;
	mediump int c; // unused in fragment shader
	bool d;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	lowp mat4x3 e;
};
layout(set = 0, binding = 2) uniform BlockD
{
	lowp ivec2 f;
	highp uvec4 g[2];
	sA h; // unused in fragment shader
	sB i;
	sD j;
} blockD;
layout(set = 0, binding = 4) uniform BlockF
{
	highp mat2x3 o;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((blockB.a), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.b), uvec2(0u, 0u));
	result *= compare_bool((blockB.d), false);
	result *= compare_mat4x3((e), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockD.f), ivec2(0, 0));
	result *= compare_uvec4((blockD.g[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.g[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockD.i.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.i.mB), false);
	result *= compare_ivec2((blockD.i.mC), ivec2(0, 0));
	result *= compare_mat3((blockD.j.mA.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockD.j.mA.mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockD.j.mB), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockF.o), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump ivec2 mA;
};
struct sB
{
	mediump mat3 mA;
	bool mB;
	highp ivec2 mC;
};
struct sC
{
	mediump mat3 mA;
	highp mat4 mB;
};
struct sD
{
	sC mA;
	mediump mat4x3 mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp mat2x3 a; // unused in vertex shader
	highp uvec2 b;
	mediump int c; // unused in fragment shader
	bool d;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	lowp mat4x3 e;
};
layout(set = 0, binding = 2) uniform BlockD
{
	lowp ivec2 f;
	highp uvec4 g[2];
	sA h; // unused in fragment shader
	sB i;
	sD j;
} blockD;
layout(set = 0, binding = 3, std140) uniform BlockE
{
	mediump mat3x2 k;
	mediump mat3x2 l;
	bool m;
	mediump uvec2 n;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec2((blockB.b), uvec2(0u, 0u));
	result *= compare_int((blockB.c), 0);
	result *= compare_bool((blockB.d), false);
	result *= compare_mat4x3((e), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockD.f), ivec2(0, 0));
	result *= compare_uvec4((blockD.g[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.g[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((blockD.h.mA), ivec2(0, 0));
	result *= compare_mat3((blockD.i.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.i.mB), false);
	result *= compare_ivec2((blockD.i.mC), ivec2(0, 0));
	result *= compare_mat3((blockD.j.mA.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockD.j.mA.mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockD.j.mB), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE.k), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE.l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockE.m), false);
	result *= compare_uvec2((blockE.n), uvec2(0u, 0u));
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
	mediump ivec3 mA;
	highp mat2 mB;
	lowp vec2 mC;
	bool mD;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	mediump mat3x2 a[2];
	highp uint b;
	sA c;
} blockB;
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	highp vec2 d[3];
	mediump mat3 e;
	bvec4 f[3];
	lowp uvec4 g;
	lowp float h;
} blockC;
layout(set = 0, binding = 3) uniform BlockE
{
	mediump mat4x2 n;
	highp mat4x2 o;
	bvec4 p;
	mediump int q;
	lowp float r; // unused in fragment shader
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	mediump mat2 s;
	mediump mat4x3 t;
	mediump mat3 u[2];
} blockF[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x2((blockB.a[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB.b), 0u);
	result *= compare_ivec3((blockB.c.mA), ivec3(0, 0, 0));
	result *= compare_mat2((blockB.c.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockB.c.mC), vec2(0.0, 0.0));
	result *= compare_bool((blockB.c.mD), false);
	result *= compare_vec2((blockC.d[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockC.d[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockC.d[2]), vec2(0.0, 0.0));
	result *= compare_mat3((blockC.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockC.f[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.f[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.f[2]), bvec4(false, false, false, false));
	result *= compare_uvec4((blockC.g), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((blockC.h), 0.0);
	result *= compare_mat4x2((n), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((o), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((p), bvec4(false, false, false, false));
	result *= compare_int((q), 0);
	result *= compare_mat2((blockF[0].s), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockF[0].t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].u[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].u[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockF[1].s), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockF[1].t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].u[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].u[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockF[2].s), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockF[2].t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[2].u[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[2].u[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump ivec3 mA;
	highp mat2 mB;
	lowp vec2 mC;
	bool mD;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	mediump mat3x2 a[2];
	highp uint b;
	sA c;
} blockB;
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	highp vec2 d[3];
	mediump mat3 e;
	bvec4 f[3];
	lowp uvec4 g;
	lowp float h;
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	lowp uvec4 i;
	highp vec3 j;
	lowp mat2x3 k;
	bvec2 l;
	highp mat4x2 m; // unused in vertex shader
} blockD;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((blockB.a[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB.b), 0u);
	result *= compare_ivec3((blockB.c.mA), ivec3(0, 0, 0));
	result *= compare_mat2((blockB.c.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockB.c.mC), vec2(0.0, 0.0));
	result *= compare_bool((blockB.c.mD), false);
	result *= compare_vec2((blockC.d[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockC.d[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockC.d[2]), vec2(0.0, 0.0));
	result *= compare_mat3((blockC.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockC.f[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.f[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockC.f[2]), bvec4(false, false, false, false));
	result *= compare_uvec4((blockC.g), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((blockC.h), 0.0);
	result *= compare_uvec4((blockD.i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((blockD.j), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD.k), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockD.l), bvec2(false, false));
    v_vtxResult = result;
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
	lowp uvec3 mB;
};
struct sB
{
	mediump uvec4 mA; // unused in fragment shader
	lowp mat3x4 mB;
	mediump ivec4 mC; // unused in vertex shader
	sA mD;
};
struct sC
{
	bool mA;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	highp ivec4 r;
	mediump uvec2 s; // unused in vertex shader
	mediump vec4 t; // unused in both shaders
	bvec4 u; // unused in fragment shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((blockG.r), ivec4(0, 0, 0, 0));
	result *= compare_uvec2((blockG.s), uvec2(0u, 0u));
	result *= compare_vec4((blockG.t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockG.u), bvec4(false, false, false, false));
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
	lowp uvec4 mA;
	highp mat2x3 mB;
};
struct sB
{
	highp mat2x3 mA;
	highp mat2 mB; // unused in vertex shader
	lowp uint mC[3];
	bvec2 mD;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	bvec4 t;
	mediump float u; // unused in vertex shader
	mediump ivec2 v;
	mediump mat4x2 w; // unused in fragment shader
} blockG[1];
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	highp mat2x3 x;
	lowp mat2 y;
	bvec2 z;
} blockH;
layout(set = 0, binding = 7, std140) uniform BlockI
{
	highp vec4 aa; // unused in vertex shader
	lowp mat3 ab;
	highp vec4 ac;
	lowp mat2 ad;
	bvec2 ae; // unused in both shaders
} blockI;
layout(set = 0, binding = 8, column_major) uniform BlockJ
{
	highp int af;
	highp mat4x2 ag;
	highp ivec4 ah;
	sB ai[2];
	lowp vec4 aj;
} blockJ;

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
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((blockG[0].t), bvec4(false, false, false, false));
	result *= compare_float((blockG[0].u), 0.0);
	result *= compare_ivec2((blockG[0].v), ivec2(0, 0));
	result *= compare_mat4x2((blockG[0].w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH.x), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH.y), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH.z), bvec2(false, false));
	result *= compare_vec4((blockI.aa), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockI.ab), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockI.ac), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI.ad), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockI.ae), bvec2(false, false));
	result *= compare_int((blockJ.af), 0);
	result *= compare_mat4x2((blockJ.ag), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockJ.ah), ivec4(0, 0, 0, 0));
	result *= compare_mat2x3((blockJ.ai[0].mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockJ.ai[0].mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockJ.ai[0].mC[0]), 0u);
	result *= compare_uint((blockJ.ai[0].mC[1]), 0u);
	result *= compare_uint((blockJ.ai[0].mC[2]), 0u);
	result *= compare_bvec2((blockJ.ai[0].mD), bvec2(false, false));
	result *= compare_mat2x3((blockJ.ai[1].mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockJ.ai[1].mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockJ.ai[1].mC[0]), 0u);
	result *= compare_uint((blockJ.ai[1].mC[1]), 0u);
	result *= compare_uint((blockJ.ai[1].mC[2]), 0u);
	result *= compare_bvec2((blockJ.ai[1].mD), bvec2(false, false));
	result *= compare_vec4((blockJ.aj), vec4(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 10, rgba8) writeonly uniform image2D outImage;

struct sA
{
	bool mA;
	mediump ivec4 mB; // unused in vertex shader
	highp uvec4 mC;
};
struct sB
{
	highp mat2x3 mA[3];
};
struct sC
{
	mediump vec3 mA; // unused in vertex shader
	highp uvec2 mB; // unused in vertex shader
	lowp ivec2 mC;
	mediump float mD; // unused in fragment shader
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump vec4 v[3]; // unused in vertex shader
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	mediump vec2 w;
	sC x;
};
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	lowp ivec3 y;
	mediump ivec3 z;
} blockJ[1];
layout(set = 0, binding = 9, column_major) uniform BlockK
{
	highp uvec4 aa; // unused in vertex shader
	highp ivec3 ab; // unused in fragment shader
	lowp uvec3 ac;
	highp ivec2 ad;
} blockK[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((v[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((v[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((v[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((w), vec2(0.0, 0.0));
	result *= compare_vec3((x.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((x.mB), uvec2(0u, 0u));
	result *= compare_ivec2((x.mC), ivec2(0, 0));
	result *= compare_float((x.mD), 0.0);
	result *= compare_ivec3((blockJ[0].y), ivec3(0, 0, 0));
	result *= compare_ivec3((blockJ[0].z), ivec3(0, 0, 0));
	result *= compare_uvec4((blockK[0].aa), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec3((blockK[0].ab), ivec3(0, 0, 0));
	result *= compare_uvec3((blockK[0].ac), uvec3(0u, 0u, 0u));
	result *= compare_ivec2((blockK[0].ad), ivec2(0, 0));
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
	highp ivec2 o;
	lowp mat2 p; // unused in both shaders
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	highp mat2x3 q;
	lowp ivec3 r;
	bvec4 s;
	highp mat3x2 t;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((o), ivec2(0, 0));
	result *= compare_mat2((p), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH.q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH.r), ivec3(0, 0, 0));
	result *= compare_bvec4((blockH.s), bvec4(false, false, false, false));
	result *= compare_mat3x2((blockH.t), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump mat4x2 mA;
	lowp mat2 mB; // unused in both shaders
};
struct sB
{
	highp ivec3 mA;
	bvec2 mB;
	mediump uvec4 mC; // unused in vertex shader
};
struct sC
{
	sB mA; // unused in both shaders
};
struct sD
{
	lowp mat4x3 mA; // unused in vertex shader
	bvec2 mB;
	mediump mat4x2 mC;
};
struct sE
{
	mediump vec2 mA; // unused in vertex shader
	bvec2 mB;
	highp ivec2 mC; // unused in fragment shader
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	lowp vec3 o;
	highp vec2 p;
	bool q;
	lowp vec2 r; // unused in both shaders
	sE s;
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	mediump mat2 t;
	mediump mat3x2 u; // unused in fragment shader
	bvec4 v;
} blockG[2];

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
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((blockF.o), vec3(0.0, 0.0, 0.0));
	result *= compare_vec2((blockF.p), vec2(0.0, 0.0));
	result *= compare_bool((blockF.q), false);
	result *= compare_vec2((blockF.r), vec2(0.0, 0.0));
	result *= compare_vec2((blockF.s.mA), vec2(0.0, 0.0));
	result *= compare_bvec2((blockF.s.mB), bvec2(false, false));
	result *= compare_ivec2((blockF.s.mC), ivec2(0, 0));
	result *= compare_mat2((blockG[0].t), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG[0].u), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockG[0].v), bvec4(false, false, false, false));
	result *= compare_mat2((blockG[1].t), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG[1].u), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockG[1].v), bvec4(false, false, false, false));
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
	lowp mat2x3 mA;
};
struct sB
{
	mediump mat3x2 mA;
	lowp uvec4 mB;
	lowp float mC;
	lowp mat3 mD;
};
struct sC
{
	bvec2 mA;
	lowp mat4 mB; // unused in fragment shader
};
struct sD
{
	lowp mat4x2 mA;
	mediump mat2x3 mB; // unused in fragment shader
	sC mC;
	lowp float mD[6];
};
struct sE
{
	highp vec2 mA;
	highp mat4x2 mB;
	mediump uvec2 mC;
};
struct sF
{
	sE mA;
	bvec4 mB; // unused in both shaders
};
struct sG
{
	highp mat2 mA;
	bvec4 mB; // unused in vertex shader
	mediump uvec4 mC; // unused in vertex shader
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	mediump vec2 l; // unused in fragment shader
	mediump uint m;
	lowp ivec3 n;
	highp uvec2 o;
	mediump mat3x4 p;
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	bvec3 q; // unused in vertex shader
	highp float r;
	bvec4 s; // unused in vertex shader
	sF t;
} blockG[3];
layout(set = 0, binding = 6) uniform BlockH
{
	sG u;
	mediump uvec2 v;
	bool w;
	mediump ivec3 x; // unused in both shaders
	mediump vec4 y;
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((blockF.l), vec2(0.0, 0.0));
	result *= compare_uint((blockF.m), 0u);
	result *= compare_ivec3((blockF.n), ivec3(0, 0, 0));
	result *= compare_uvec2((blockF.o), uvec2(0u, 0u));
	result *= compare_mat3x4((blockF.p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockG[0].q), bvec3(false, false, false));
	result *= compare_float((blockG[0].r), 0.0);
	result *= compare_bvec4((blockG[0].s), bvec4(false, false, false, false));
	result *= compare_vec2((blockG[0].t.mA.mA), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockG[0].t.mA.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockG[0].t.mA.mC), uvec2(0u, 0u));
	result *= compare_bvec4((blockG[0].t.mB), bvec4(false, false, false, false));
	result *= compare_bvec3((blockG[1].q), bvec3(false, false, false));
	result *= compare_float((blockG[1].r), 0.0);
	result *= compare_bvec4((blockG[1].s), bvec4(false, false, false, false));
	result *= compare_vec2((blockG[1].t.mA.mA), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockG[1].t.mA.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockG[1].t.mA.mC), uvec2(0u, 0u));
	result *= compare_bvec4((blockG[1].t.mB), bvec4(false, false, false, false));
	result *= compare_bvec3((blockG[2].q), bvec3(false, false, false));
	result *= compare_float((blockG[2].r), 0.0);
	result *= compare_bvec4((blockG[2].s), bvec4(false, false, false, false));
	result *= compare_vec2((blockG[2].t.mA.mA), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockG[2].t.mA.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockG[2].t.mA.mC), uvec2(0u, 0u));
	result *= compare_bvec4((blockG[2].t.mB), bvec4(false, false, false, false));
	result *= compare_mat2((u.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((u.mB), bvec4(false, false, false, false));
	result *= compare_uvec4((u.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((v), uvec2(0u, 0u));
	result *= compare_bool((w), false);
	result *= compare_ivec3((x), ivec3(0, 0, 0));
	result *= compare_vec4((y), vec4(0.0, 0.0, 0.0, 0.0));
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
	mediump int mA;
	highp mat3x4 mB;
	highp mat4x3 mC;
	bvec4 mD; // unused in both shaders
};
struct sB
{
	lowp uint mA;
	highp uvec2 mB;
};
struct sC
{
	highp mat4 mA;
	sB mB;
	bvec4 mC;
};
struct sD
{
	lowp vec3 mA; // unused in both shaders
	highp mat2 mB; // unused in vertex shader
	bvec2 mC; // unused in vertex shader
	lowp uvec4 mD;
};
struct sE
{
	sD mA;
	highp vec3 mB;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	sC o;
	highp mat4x2 p; // unused in both shaders
	bvec4 q; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump ivec4 r;
	bvec3 s;
};
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	sE t;
	bvec4 u[7][6][1]; // unused in fragment shader
	mediump vec3 v; // unused in fragment shader
	lowp float w[6]; // unused in vertex shader
	lowp vec3 x;
};
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	mediump uint y;
	bool z;
	mediump mat3x4 aa;
	highp uvec3 ab;
} blockJ[3];

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
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4((blockG.o.mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockG.o.mB.mA), 0u);
	result *= compare_uvec2((blockG.o.mB.mB), uvec2(0u, 0u));
	result *= compare_bvec4((blockG.o.mC), bvec4(false, false, false, false));
	result *= compare_mat4x2((blockG.p), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockG.q), bvec4(false, false, false, false));
	result *= compare_ivec4((r), ivec4(0, 0, 0, 0));
	result *= compare_bvec3((s), bvec3(false, false, false));
	result *= compare_vec3((t.mA.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((t.mA.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((t.mA.mC), bvec2(false, false));
	result *= compare_uvec4((t.mA.mD), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((t.mB), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec4((u[0][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[0][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[0][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[0][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[0][4][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[0][5][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[1][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[1][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[1][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[1][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[1][4][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[1][5][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[2][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[2][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[2][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[2][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[2][4][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[2][5][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[3][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[3][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[3][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[3][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[3][4][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[3][5][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[4][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[4][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[4][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[4][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[4][4][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[4][5][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[5][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[5][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[5][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[5][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[5][4][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[5][5][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[6][0][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[6][1][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[6][2][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[6][3][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[6][4][0]), bvec4(false, false, false, false));
	result *= compare_bvec4((u[6][5][0]), bvec4(false, false, false, false));
	result *= compare_vec3((v), vec3(0.0, 0.0, 0.0));
	result *= compare_float((w[0]), 0.0);
	result *= compare_float((w[1]), 0.0);
	result *= compare_float((w[2]), 0.0);
	result *= compare_float((w[3]), 0.0);
	result *= compare_float((w[4]), 0.0);
	result *= compare_float((w[5]), 0.0);
	result *= compare_vec3((x), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((blockJ[0].y), 0u);
	result *= compare_bool((blockJ[0].z), false);
	result *= compare_mat3x4((blockJ[0].aa), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockJ[0].ab), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockJ[1].y), 0u);
	result *= compare_bool((blockJ[1].z), false);
	result *= compare_mat3x4((blockJ[1].aa), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockJ[1].ab), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockJ[2].y), 0u);
	result *= compare_bool((blockJ[2].z), false);
	result *= compare_mat3x4((blockJ[2].aa), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockJ[2].ab), uvec3(0u, 0u, 0u));
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
	highp vec2 mA[7];
	highp ivec4 mB;
	lowp ivec4 mC;
};
struct sB
{
	sA mA;
	bvec3 mB; // unused in vertex shader
};
struct sC
{
	lowp mat4 mA;
};
struct sD
{
	sC mA;
};
struct sE
{
	highp uint mA;
	lowp int mB;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	lowp ivec2 k;
	mediump mat2 l;
	highp vec3 m; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp ivec3 n[1][6];
	lowp float o;
	bvec3 p;
	highp uint q;
	mediump mat4x3 r;
} blockG[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((blockF.k), ivec2(0, 0));
	result *= compare_mat2((blockF.l), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockF.m), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[0].n[0][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[0].n[0][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[0].n[0][2]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[0].n[0][3]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[0].n[0][4]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[0].n[0][5]), ivec3(0, 0, 0));
	result *= compare_float((blockG[0].o), 0.0);
	result *= compare_bvec3((blockG[0].p), bvec3(false, false, false));
	result *= compare_uint((blockG[0].q), 0u);
	result *= compare_mat4x3((blockG[0].r), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[1].n[0][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[1].n[0][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[1].n[0][2]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[1].n[0][3]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[1].n[0][4]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[1].n[0][5]), ivec3(0, 0, 0));
	result *= compare_float((blockG[1].o), 0.0);
	result *= compare_bvec3((blockG[1].p), bvec3(false, false, false));
	result *= compare_uint((blockG[1].q), 0u);
	result *= compare_mat4x3((blockG[1].r), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[2].n[0][0]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[2].n[0][1]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[2].n[0][2]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[2].n[0][3]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[2].n[0][4]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG[2].n[0][5]), ivec3(0, 0, 0));
	result *= compare_float((blockG[2].o), 0.0);
	result *= compare_bvec3((blockG[2].p), bvec3(false, false, false));
	result *= compare_uint((blockG[2].q), 0u);
	result *= compare_mat4x3((blockG[2].r), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, row_major) uniform BlockF
{
	highp ivec2 m;
	lowp vec2 n; // unused in vertex shader
	mediump mat3x2 o;
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	mediump mat3 p; // unused in fragment shader
	bvec4 q; // unused in both shaders
	bool r;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((blockF.m), ivec2(0, 0));
	result *= compare_vec2((blockF.n), vec2(0.0, 0.0));
	result *= compare_mat3x2((blockF.o), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((p), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((q), bvec4(false, false, false, false));
	result *= compare_bool((r), false);
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
	highp mat3x2 mA; // unused in fragment shader
	mediump float mB;
	lowp mat2 mC; // unused in both shaders
	lowp vec2 mD;
};
struct sB
{
	highp mat2 mA;
	bvec4 mB;
	mediump mat4x2 mC[2];
};
struct sC
{
	mediump float mA;
	mediump uint mB; // unused in fragment shader
	bool mC;
};
struct sD
{
	sB mA;
	lowp mat3 mB;
	sC mC;
};
struct sE
{
	mediump vec2 mA;
	lowp mat4 mB;
};
layout(set = 0, binding = 5) uniform BlockG
{
	mediump vec4 p;
	bool q;
	highp vec3 r[1]; // unused in vertex shader
	mediump uint s; // unused in fragment shader
	highp int t;
} blockG[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((blockG[0].p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockG[0].q), false);
	result *= compare_vec3((blockG[0].r[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((blockG[0].s), 0u);
	result *= compare_int((blockG[0].t), 0);
	result *= compare_vec4((blockG[1].p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockG[1].q), false);
	result *= compare_vec3((blockG[1].r[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((blockG[1].s), 0u);
	result *= compare_int((blockG[1].t), 0);
	result *= compare_vec4((blockG[2].p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockG[2].q), false);
	result *= compare_vec3((blockG[2].r[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((blockG[2].s), 0u);
	result *= compare_int((blockG[2].t), 0);
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
	mediump uvec4 mA;
	highp mat2x3 mB;
};
struct sB
{
	highp mat4x2 mA; // unused in vertex shader
	bvec4 mB;
};
struct sC
{
	highp vec2 mA;
	mediump mat4x2 mB; // unused in vertex shader
};
struct sD
{
	highp uint mA;
};
struct sE
{
	sD mA[2];
	lowp mat4x3 mB;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	layout(offset = 80) highp mat3x2 p;
	layout(offset = 0) sC o;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	layout(offset = 80) sE s;
	layout(offset = 0) lowp vec2 q[4];
	layout(offset = 64) bvec2 r; // unused in both shaders
};
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	layout(offset = 0) highp mat3 t;
};
layout(set = 0, binding = 8, std140, column_major) uniform BlockJ
{
	layout(offset = 64) bool v; // unused in both shaders
	layout(offset = 0) mediump mat4x3 u;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((o.mA), vec2(0.0, 0.0));
	result *= compare_mat4x2((o.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((p), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((q[0]), vec2(0.0, 0.0));
	result *= compare_vec2((q[1]), vec2(0.0, 0.0));
	result *= compare_vec2((q[2]), vec2(0.0, 0.0));
	result *= compare_vec2((q[3]), vec2(0.0, 0.0));
	result *= compare_bvec2((r), bvec2(false, false));
	result *= compare_uint((s.mA[0].mA), 0u);
	result *= compare_uint((s.mA[1].mA), 0u);
	result *= compare_mat4x3((s.mB), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((u), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((v), false);
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
	mediump mat4 mA;
	highp ivec3 mB;
};
struct sB
{
	lowp ivec4 mA;
	mediump mat2 mB;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	layout(offset = 0) lowp ivec3 n[8];
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	layout(offset = 96) mediump uint q;
	layout(offset = 0) highp ivec4 o[3]; // unused in fragment shader
	layout(offset = 48) mediump mat3x2 p; // unused in fragment shader
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	layout(offset = 16) lowp mat3 s;
	layout(offset = 0) highp int r[1];
} blockI[2];
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	layout(offset = 64) highp mat2 u[2]; // unused in fragment shader
	layout(offset = 0) highp int t[1][4];
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((n[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((n[1]), ivec3(0, 0, 0));
	result *= compare_ivec3((n[2]), ivec3(0, 0, 0));
	result *= compare_ivec3((n[3]), ivec3(0, 0, 0));
	result *= compare_ivec3((n[4]), ivec3(0, 0, 0));
	result *= compare_ivec3((n[5]), ivec3(0, 0, 0));
	result *= compare_ivec3((n[6]), ivec3(0, 0, 0));
	result *= compare_ivec3((n[7]), ivec3(0, 0, 0));
	result *= compare_ivec4((blockH.o[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.o[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.o[2]), ivec4(0, 0, 0, 0));
	result *= compare_mat3x2((blockH.p), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockH.q), 0u);
	result *= compare_int((blockI[0].r[0]), 0);
	result *= compare_mat3((blockI[0].s), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockI[1].r[0]), 0);
	result *= compare_mat3((blockI[1].s), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockJ.t[0][0]), 0);
	result *= compare_int((blockJ.t[0][1]), 0);
	result *= compare_int((blockJ.t[0][2]), 0);
	result *= compare_int((blockJ.t[0][3]), 0);
	result *= compare_mat2((blockJ.u[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockJ.u[1]), mat2(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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
	layout(offset = 144) highp int q; // unused in vertex shader
	layout(offset = 0) mediump uint m;
	layout(offset = 96) mediump mat3x4 p; // unused in fragment shader
	layout(offset = 16) lowp ivec3 n; // unused in vertex shader
	layout(offset = 32) highp mat4x3 o; // unused in fragment shader
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((blockF.m), 0u);
	result *= compare_ivec3((blockF.n), ivec3(0, 0, 0));
	result *= compare_mat4x3((blockF.o), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF.p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockF.q), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 10, rgba8) writeonly uniform image2D outImage;

struct sA
{
	lowp int mA;
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	layout(offset = 16) lowp ivec3 w;
	layout(offset = 0) highp uint v;
};
layout(set = 0, binding = 7) uniform BlockI
{
	layout(offset = 80) mediump vec3 ab;
	layout(offset = 0) bvec2 x;
	layout(offset = 64) highp int aa; // unused in vertex shader
	layout(offset = 16) mediump ivec3 y;
	layout(offset = 32) lowp mat2x3 z; // unused in fragment shader
};
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	layout(offset = 64) mediump uvec4 af; // unused in fragment shader
	layout(offset = 0) lowp mat3x2 ac;
	layout(offset = 48) bool ae;
	layout(offset = 32) mediump ivec4 ad; // unused in vertex shader
};
layout(set = 0, binding = 9, row_major) uniform BlockK
{
	layout(offset = 0) bvec2 ag;
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
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((v), 0u);
	result *= compare_ivec3((w), ivec3(0, 0, 0));
	result *= compare_bvec2((x), bvec2(false, false));
	result *= compare_ivec3((y), ivec3(0, 0, 0));
	result *= compare_mat2x3((z), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((aa), 0);
	result *= compare_vec3((ab), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((ac), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((ad), ivec4(0, 0, 0, 0));
	result *= compare_bool((ae), false);
	result *= compare_uvec4((af), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec2((ag), bvec2(false, false));
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
	highp vec3 mA; // unused in vertex shader
	lowp vec3 mB;
	mediump mat3 mC;
};
struct sB
{
	bvec2 mA[4];
	lowp uvec2 mB;
	highp mat4 mC;
};
struct sC
{
	lowp uint mA;
	lowp uvec2 mB;
	sB mC;
};
struct sD
{
	lowp mat3x4 mA; // unused in vertex shader
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	layout(offset = 48) mediump int n;
	layout(offset = 0) sD m;
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	layout(offset = 48) highp mat4x3 p;
	layout(offset = 0) lowp mat2x3 o;
} blockG[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((blockF.m.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockF.n), 0);
	result *= compare_mat2x3((blockG[0].o), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[0].p), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[1].o), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[1].p), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6, scalar, column_major) uniform BlockH
{
	layout(offset = 28) bool u;
	layout(offset = 0) mediump vec3 s;
	layout(offset = 12) mediump mat2 t;
};
layout(set = 0, binding = 7, scalar) uniform BlockI
{
	layout(offset = 100) mediump mat2 z; // unused in fragment shader
	layout(offset = 0) lowp mat2x3 v;
	layout(offset = 64) highp mat3 y;
	layout(offset = 24) bvec4 w; // unused in fragment shader
	layout(offset = 40) highp mat2x3 x;
} blockI[1];
layout(set = 0, binding = 8, std430, row_major) uniform BlockJ
{
	layout(offset = 64) mediump mat3x2 ac; // unused in fragment shader
	layout(offset = 0) mediump mat4x3 aa;
	layout(offset = 48) lowp int ab;
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
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((s), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((t), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((u), false);
	result *= compare_mat2x3((blockI[0].v), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockI[0].w), bvec4(false, false, false, false));
	result *= compare_mat2x3((blockI[0].x), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockI[0].y), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[0].z), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((aa), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((ab), 0);
	result *= compare_mat3x2((ac), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump uint mA;
};
layout(set = 0, binding = 5, std430) uniform BlockG
{
	layout(offset = 32) lowp mat3x2 m;
	layout(offset = 0) mediump uvec2 k; // unused in both shaders
	layout(offset = 16) lowp vec4 l;
} blockG;
layout(set = 0, binding = 6, scalar) uniform BlockH
{
	layout(offset = 32) highp uvec2 p;
	layout(offset = 0) highp mat2x3 n;
	layout(offset = 24) bvec2 o;
} blockH;
layout(set = 0, binding = 7, scalar) uniform BlockI
{
	layout(offset = 0) sA q;
} blockI[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((blockG.k), uvec2(0u, 0u));
	result *= compare_vec4((blockG.l), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.m), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH.n), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH.o), bvec2(false, false));
	result *= compare_uvec2((blockH.p), uvec2(0u, 0u));
	result *= compare_uint((blockI[0].q.mA), 0u);
	result *= compare_uint((blockI[1].q.mA), 0u);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	highp vec4 x;
	lowp uvec4 y;
	bvec4 z;
} blockI;
layout(set = 0, binding = 8, column_major) uniform BlockJ
{
	lowp mat4x3 aa;
	highp mat2x3 ab; // unused in fragment shader
	mediump uvec4 ac;
	lowp mat2 ad; // unused in both shaders
	bvec3 ae;
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
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((blockI.x), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockI.y), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((blockI.z), bvec4(false, false, false, false));
	result *= compare_mat4x3((aa), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((ab), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((ac), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2((ad), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((ae), bvec3(false, false, false));
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
	int16_t a; // unused in vertex shader
	bool b;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump int c; // unused in both shaders
	highp int d;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	highp uint e;
	uint16_t f;
	mediump float g;
	mediump float h;
	mediump float i;
} blockD;
layout(set = 0, binding = 4, std140) uniform BlockF
{
	float16_t m;
	highp int n;
	uint16_t o;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(blockB.a), 0);
	result *= compare_bool((blockB.b), false);
	result *= compare_int((blockC.d), 0);
	result *= compare_uint((blockD.e), 0u);
	result *= compare_uint16_t(uint(blockD.f), 0u);
	result *= compare_float((blockD.g), 0.0);
	result *= compare_float((blockD.h), 0.0);
	result *= compare_float((blockD.i), 0.0);
	result *= compare_float16_t(float(blockF.m), 0.0);
	result *= compare_int((blockF.n), 0);
	result *= compare_uint16_t(uint(blockF.o), 0u);
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
	int16_t a; // unused in vertex shader
	bool b;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump int c; // unused in both shaders
	highp int d;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	highp uint e;
	uint16_t f;
	mediump float g;
	mediump float h;
	mediump float i;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	mediump int j; // unused in fragment shader
	float16_t k;
	int16_t l;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((blockB.b), false);
	result *= compare_int((blockC.d), 0);
	result *= compare_uint((blockD.e), 0u);
	result *= compare_uint16_t(uint(blockD.f), 0u);
	result *= compare_float((blockD.g), 0.0);
	result *= compare_float((blockD.h), 0.0);
	result *= compare_float((blockD.i), 0.0);
	result *= compare_int((blockE.j), 0);
	result *= compare_float16_t(float(blockE.k), 0.0);
	result *= compare_int16_t(int(blockE.l), 0);
    v_vtxResult = result;
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
	lowp float a;
	highp float b;
	int16_t c;
	int16_t d; // unused in both shaders
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	uint16_t e; // unused in vertex shader
	bool f; // unused in vertex shader
	int16_t g;
	float16_t h;
	int16_t i;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	bool j;
	uint16_t k;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	float16_t l;
	mediump int m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((a), 0.0);
	result *= compare_float((b), 0.0);
	result *= compare_int16_t(int(c), 0);
	result *= compare_uint16_t(uint(blockC.e), 0u);
	result *= compare_bool((blockC.f), false);
	result *= compare_int16_t(int(blockC.g), 0);
	result *= compare_float16_t(float(blockC.h), 0.0);
	result *= compare_int16_t(int(blockC.i), 0);
	result *= compare_bool((blockD.j), false);
	result *= compare_uint16_t(uint(blockD.k), 0u);
	result *= compare_float16_t(float(blockE.l), 0.0);
	result *= compare_int((blockE.m), 0);
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
	lowp float a;
	highp float b;
	int16_t c;
	int16_t d; // unused in both shaders
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	uint16_t e; // unused in vertex shader
	bool f; // unused in vertex shader
	int16_t g;
	float16_t h;
	int16_t i;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	bool j;
	uint16_t k;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	float16_t l;
	mediump int m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((a), 0.0);
	result *= compare_float((b), 0.0);
	result *= compare_int16_t(int(c), 0);
	result *= compare_int16_t(int(blockC.g), 0);
	result *= compare_float16_t(float(blockC.h), 0.0);
	result *= compare_int16_t(int(blockC.i), 0);
	result *= compare_bool((blockD.j), false);
	result *= compare_uint16_t(uint(blockD.k), 0u);
	result *= compare_float16_t(float(blockE.l), 0.0);
	result *= compare_int((blockE.m), 0);
    v_vtxResult = result;
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
	lowp ivec3 a;
	i16vec2 b;
	u16vec2 c;
	lowp uvec3 d;
	mediump vec2 e;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump ivec2 f; // unused in fragment shader
	lowp uvec3 g;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp vec4 h;
	lowp uvec3 i;
	highp vec3 j; // unused in fragment shader
	i16vec4 k; // unused in vertex shader
	lowp uvec4 l; // unused in fragment shader
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	bool m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_i16vec2(ivec2(blockB.b), ivec2(0, 0));
	result *= compare_u16vec2(uvec2(blockB.c), uvec2(0u, 0u));
	result *= compare_uvec3((blockB.d), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockB.e), vec2(0.0, 0.0));
	result *= compare_uvec3((blockC.g), uvec3(0u, 0u, 0u));
	result *= compare_vec4((h), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((i), uvec3(0u, 0u, 0u));
	result *= compare_i16vec4(ivec4(k), ivec4(0, 0, 0, 0));
	result *= compare_bool((blockE.m), false);
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
	lowp ivec3 a;
	i16vec2 b;
	u16vec2 c;
	lowp uvec3 d;
	mediump vec2 e;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump ivec2 f; // unused in fragment shader
	lowp uvec3 g;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp vec4 h;
	lowp uvec3 i;
	highp vec3 j; // unused in fragment shader
	i16vec4 k; // unused in vertex shader
	lowp uvec4 l; // unused in fragment shader
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	bool m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_i16vec2(ivec2(blockB.b), ivec2(0, 0));
	result *= compare_u16vec2(uvec2(blockB.c), uvec2(0u, 0u));
	result *= compare_uvec3((blockB.d), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockB.e), vec2(0.0, 0.0));
	result *= compare_ivec2((blockC.f), ivec2(0, 0));
	result *= compare_uvec3((blockC.g), uvec3(0u, 0u, 0u));
	result *= compare_vec4((h), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((i), uvec3(0u, 0u, 0u));
	result *= compare_vec3((j), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec4((l), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bool((blockE.m), false);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140) uniform BlockG
{
	mediump vec4 u;
	highp vec3 v; // unused in vertex shader
	mediump vec3 w;
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	int16_t x;
	lowp int y;
	bvec4 z;
	uint16_t aa;
	lowp ivec3 ab;
} blockH;
layout(set = 0, binding = 7, std140) uniform BlockI
{
	bvec4 ac;
	int16_t ad;
	lowp float ae;
	highp uvec4 af;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((blockG.u), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockG.v), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockG.w), vec3(0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockH.x), 0);
	result *= compare_int((blockH.y), 0);
	result *= compare_bvec4((blockH.z), bvec4(false, false, false, false));
	result *= compare_uint16_t(uint(blockH.aa), 0u);
	result *= compare_ivec3((blockH.ab), ivec3(0, 0, 0));
	result *= compare_bvec4((blockI.ac), bvec4(false, false, false, false));
	result *= compare_int16_t(int(blockI.ad), 0);
	result *= compare_float((blockI.ae), 0.0);
	result *= compare_uvec4((blockI.af), uvec4(0u, 0u, 0u, 0u));
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
	mediump uint a; // unused in fragment shader
	mediump uvec2 b;
	highp mat2 c; // unused in vertex shader
	highp vec2 d;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	uint16_t e;
	highp vec3 f; // unused in fragment shader
	lowp ivec3 g; // unused in vertex shader
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	mediump mat4x3 h;
	mediump uvec2 i;
} blockD;
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	highp ivec3 o;
	lowp uint p;
	float16_t q; // unused in vertex shader
	uint16_t r;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec2((blockB.b), uvec2(0u, 0u));
	result *= compare_mat2((blockB.c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockB.d), vec2(0.0, 0.0));
	result *= compare_uint16_t(uint(e), 0u);
	result *= compare_ivec3((g), ivec3(0, 0, 0));
	result *= compare_mat4x3((blockD.h), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockD.i), uvec2(0u, 0u));
	result *= compare_ivec3((o), ivec3(0, 0, 0));
	result *= compare_uint((p), 0u);
	result *= compare_float16_t(float(q), 0.0);
	result *= compare_uint16_t(uint(r), 0u);
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
	mediump uint a; // unused in fragment shader
	mediump uvec2 b;
	highp mat2 c; // unused in vertex shader
	highp vec2 d;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	uint16_t e;
	highp vec3 f; // unused in fragment shader
	lowp ivec3 g; // unused in vertex shader
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	mediump mat4x3 h;
	mediump uvec2 i;
} blockD;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	i16vec3 j;
	i16vec4 k;
	u16vec4 l;
	mediump mat4 m; // unused in fragment shader
	lowp float n; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((blockB.a), 0u);
	result *= compare_uvec2((blockB.b), uvec2(0u, 0u));
	result *= compare_vec2((blockB.d), vec2(0.0, 0.0));
	result *= compare_uint16_t(uint(e), 0u);
	result *= compare_vec3((f), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockD.h), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockD.i), uvec2(0u, 0u));
	result *= compare_i16vec3(ivec3(j), ivec3(0, 0, 0));
	result *= compare_i16vec4(ivec4(k), ivec4(0, 0, 0, 0));
	result *= compare_u16vec4(uvec4(l), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2 k;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2((k), mat2(0.0, 0.0, 0.0, 0.0));
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
	bvec3 a;
	mediump mat3x2 b;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	highp uvec4 c;
	highp uint d; // unused in vertex shader
	highp mat3 e;
	lowp mat4x3 f;
	float16_t g;
} blockC;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	lowp ivec2 k; // unused in fragment shader
	float16_t l;
	bool m;
	lowp ivec3 n; // unused in vertex shader
	mediump ivec2 o;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	int16_t p;
	bool q;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec3((a), bvec3(false, false, false));
	result *= compare_mat3x2((b), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockC.c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((blockC.d), 0u);
	result *= compare_mat3((blockC.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockC.f), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float16_t(float(blockC.g), 0.0);
	result *= compare_float16_t(float(l), 0.0);
	result *= compare_bool((m), false);
	result *= compare_ivec3((n), ivec3(0, 0, 0));
	result *= compare_ivec2((o), ivec2(0, 0));
	result *= compare_int16_t(int(blockF.p), 0);
	result *= compare_bool((blockF.q), false);
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
	bvec3 a;
	mediump mat3x2 b;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	highp uvec4 c;
	highp uint d; // unused in vertex shader
	highp mat3 e;
	lowp mat4x3 f;
	float16_t g;
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	highp mat3x2 h;
	lowp mat4x2 i; // unused in vertex shader
	i16vec4 j; // unused in vertex shader
} blockD[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec3((a), bvec3(false, false, false));
	result *= compare_mat3x2((b), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockC.c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockC.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockC.f), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float16_t(float(blockC.g), 0.0);
	result *= compare_mat3x2((blockD[0].h), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockD[1].h), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockD[2].h), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, row_major) uniform BlockB
{
	highp mat4x3 a;
	mediump float b; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat3x2 c; // unused in fragment shader
	lowp ivec3 d;
	i16vec2 e; // unused in vertex shader
} blockC[1];
layout(set = 0, binding = 3, std140) uniform BlockE
{
	lowp ivec2 j; // unused in fragment shader
	float16_t k; // unused in vertex shader
} blockE;
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	mediump vec3 l;
	bvec3 m; // unused in vertex shader
	highp ivec4 n;
	highp mat4x3 o;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x3((blockB.a), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockB.b), 0.0);
	result *= compare_ivec3((blockC[0].d), ivec3(0, 0, 0));
	result *= compare_i16vec2(ivec2(blockC[0].e), ivec2(0, 0));
	result *= compare_float16_t(float(blockE.k), 0.0);
	result *= compare_vec3((blockF.l), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec3((blockF.m), bvec3(false, false, false));
	result *= compare_ivec4((blockF.n), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((blockF.o), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, row_major) uniform BlockB
{
	highp mat4x3 a;
	mediump float b; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat3x2 c; // unused in fragment shader
	lowp ivec3 d;
	i16vec2 e; // unused in vertex shader
} blockC[1];
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	mediump mat2x3 f; // unused in vertex shader
	mediump ivec3 g; // unused in vertex shader
	u16vec2 h;
	u16vec2 i;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((blockB.a), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC[0].c), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockC[0].d), ivec3(0, 0, 0));
	result *= compare_u16vec2(uvec2(h), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(i), uvec2(0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	float16_t t; // unused in fragment shader
	uint16_t u; // unused in vertex shader
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	mediump mat3x2 v; // unused in vertex shader
	float16_t w;
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	highp vec4 x;
	highp int y;
	mediump int z;
} blockI;

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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(t), 0.0);
	result *= compare_uint16_t(uint(u), 0u);
	result *= compare_mat3x2((blockH.v), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float16_t(float(blockH.w), 0.0);
	result *= compare_vec4((blockI.x), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockI.y), 0);
	result *= compare_int((blockI.z), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, column_major) uniform BlockG
{
	float16_t m;
	lowp mat2x3 n;
	highp uvec4 o;
	lowp uvec4 p;
	lowp ivec3 q;
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	uint16_t r; // unused in vertex shader
	highp mat3x2 s;
	bvec2 t;
	lowp mat3x4 u;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	mediump uvec3 v;
};
layout(set = 0, binding = 8) uniform BlockJ
{
	f16vec4 w; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_float16_t(float(m), 0.0);
	result *= compare_mat2x3((n), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec3((q), ivec3(0, 0, 0));
	result *= compare_uint16_t(uint(blockH.r), 0u);
	result *= compare_mat3x2((blockH.s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH.t), bvec2(false, false));
	result *= compare_mat3x4((blockH.u), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((v), uvec3(0u, 0u, 0u));
	result *= compare_f16vec4(vec4(w), vec4(0.0, 0.0, 0.0, 0.0));
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
	i16vec4 mA;
	u16vec3 mB;
	mediump vec3 mC;
};
struct sB
{
	uint16_t mA;
	lowp mat3x2 mB;
	f16vec3 mC;
};
struct sC
{
	highp uvec2 mA;
};
struct sD
{
	mediump vec3 mA;
};
struct sE
{
	lowp mat3 mA;
	f16vec4 mB;
	highp uvec4 mC;
	sD mD; // unused in vertex shader
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	i16vec3 q;
	mediump ivec2 r;
	f16vec3 s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec3(ivec3(q), ivec3(0, 0, 0));
	result *= compare_ivec2((r), ivec2(0, 0));
	result *= compare_f16vec3(vec3(s), vec3(0.0, 0.0, 0.0));
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
	mediump mat4x2 mA;
};
struct sB
{
	f16vec4 mA;
};
struct sC
{
	lowp mat4 mA;
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	i16vec4 m;
} blockF;
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp mat3 n;
	highp ivec3 o;
	u16vec4 p;
	highp vec3 q;
} blockG;
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	lowp mat4x2 r;
	bvec2 s;
} blockH;

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
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(blockF.m), ivec4(0, 0, 0, 0));
	result *= compare_mat3((blockG.n), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG.o), ivec3(0, 0, 0));
	result *= compare_u16vec4(uvec4(blockG.p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((blockG.q), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH.r), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH.s), bvec2(false, false));
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
	f16vec4 mA;
	bvec3 mB;
};
struct sB
{
	i16vec3 mA;
	bool mB;
	bvec2 mC;
};
struct sC
{
	highp mat4x3 mA;
	lowp mat2 mB;
};
struct sD
{
	int16_t mA;
	mediump vec2 mB; // unused in fragment shader
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	i16vec4 a;
	highp mat3x4 b;
	mediump uvec2 c;
	f16vec3 d;
	sA e;
} blockB;
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	sD o; // unused in vertex shader
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp vec2 p;
	lowp vec3 q; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	float16_t r[8];
	lowp mat3x4 s;
	lowp mat4x3 t;
	highp mat3 u[5];
	highp mat3 v; // unused in both shaders
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(blockB.a), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((blockB.b), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.c), uvec2(0u, 0u));
	result *= compare_f16vec3(vec3(blockB.d), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockB.e.mA), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockB.e.mB), bvec3(false, false, false));
	result *= compare_int16_t(int(o.mA), 0);
	result *= compare_vec2((blockG.p), vec2(0.0, 0.0));
	result *= compare_float16_t(float(blockH.r[0]), 0.0);
	result *= compare_float16_t(float(blockH.r[1]), 0.0);
	result *= compare_float16_t(float(blockH.r[2]), 0.0);
	result *= compare_float16_t(float(blockH.r[3]), 0.0);
	result *= compare_float16_t(float(blockH.r[4]), 0.0);
	result *= compare_float16_t(float(blockH.r[5]), 0.0);
	result *= compare_float16_t(float(blockH.r[6]), 0.0);
	result *= compare_float16_t(float(blockH.r[7]), 0.0);
	result *= compare_mat3x4((blockH.s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockH.t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.u[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.u[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.u[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.u[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.u[4]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	f16vec4 mA;
	bvec3 mB;
};
struct sB
{
	i16vec3 mA;
	bool mB;
	bvec2 mC;
};
struct sC
{
	highp mat4x3 mA;
	lowp mat2 mB;
};
struct sD
{
	int16_t mA;
	mediump vec2 mB; // unused in fragment shader
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	i16vec4 a;
	highp mat3x4 b;
	mediump uvec2 c;
	f16vec3 d;
	sA e;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	sB f; // unused in fragment shader
	highp ivec2 g;
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	mediump uint h; // unused in both shaders
	mediump uint i;
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	i16vec4 j;
	sC k;
	float16_t l;
	lowp mat4x3 m;
	lowp int n; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(blockB.a), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((blockB.b), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.c), uvec2(0u, 0u));
	result *= compare_f16vec3(vec3(blockB.d), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockB.e.mA), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockB.e.mB), bvec3(false, false, false));
	result *= compare_i16vec3(ivec3(blockC.f.mA), ivec3(0, 0, 0));
	result *= compare_bool((blockC.f.mB), false);
	result *= compare_bvec2((blockC.f.mC), bvec2(false, false));
	result *= compare_ivec2((blockC.g), ivec2(0, 0));
	result *= compare_uint((blockD.i), 0u);
	result *= compare_i16vec4(ivec4(blockE.j), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((blockE.k.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockE.k.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float16_t(float(blockE.l), 0.0);
	result *= compare_mat4x3((blockE.m), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockE.n), 0);
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
	bvec4 mA;
};
struct sB
{
	bvec4 mA; // unused in fragment shader
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	mediump uvec3 r;
	lowp int s[5]; // unused in fragment shader
	highp mat3x2 t;
	i16vec3 u; // unused in vertex shader
	f16vec3 v;
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp ivec2 w;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec3((blockG.r), uvec3(0u, 0u, 0u));
	result *= compare_int((blockG.s[0]), 0);
	result *= compare_int((blockG.s[1]), 0);
	result *= compare_int((blockG.s[2]), 0);
	result *= compare_int((blockG.s[3]), 0);
	result *= compare_int((blockG.s[4]), 0);
	result *= compare_mat3x2((blockG.t), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(blockG.u), ivec3(0, 0, 0));
	result *= compare_f16vec3(vec3(blockG.v), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec2((blockH.w), ivec2(0, 0));
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
	bvec4 a;
	lowp mat4x2 b; // unused in vertex shader
} blockB;
layout(set = 0, binding = 2) uniform BlockD
{
	mediump mat4x2 e;
	f16vec4 f; // unused in vertex shader
	lowp vec2 g;
} blockD[1];
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	i16vec4 h;
	bvec4 i;
	mediump uvec4 j;
	lowp ivec2 k; // unused in vertex shader
	f16vec2 l;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec4((blockB.a), bvec4(false, false, false, false));
	result *= compare_mat4x2((blockB.b), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockD[0].e), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockD[0].f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockD[0].g), vec2(0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockE.h), ivec4(0, 0, 0, 0));
	result *= compare_bvec4((blockE.i), bvec4(false, false, false, false));
	result *= compare_uvec4((blockE.j), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((blockE.k), ivec2(0, 0));
	result *= compare_f16vec2(vec2(blockE.l), vec2(0.0, 0.0));
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
	bvec4 a;
	lowp mat4x2 b; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	lowp mat2 c; // unused in fragment shader
	bvec3 d;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((blockB.a), bvec4(false, false, false, false));
	result *= compare_mat2((c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((d), bvec3(false, false, false));
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
	highp uvec2 mA[6]; // unused in vertex shader
	mediump float mB;
	mediump uvec3 mC[8]; // unused in both shaders
};
struct sB
{
	lowp ivec3 mA;
	uint16_t mB;
};
struct sC
{
	u16vec2 mA;
	i16vec2 mB; // unused in both shaders
	f16vec3 mC;
	highp float mD; // unused in vertex shader
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp vec2 a[5];
	sA b; // unused in vertex shader
	i16vec2 c;
	i16vec4 d[5];
} blockB[2];
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	sB e[1]; // unused in vertex shader
	sC f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 4) uniform BlockF
{
	mediump mat4x3 l;
	i16vec4 m;
} blockF[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2((blockB[0].a[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[4]), vec2(0.0, 0.0));
	result *= compare_uvec2((blockB[0].b.mA[0]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[0].b.mA[1]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[0].b.mA[2]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[0].b.mA[3]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[0].b.mA[4]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[0].b.mA[5]), uvec2(0u, 0u));
	result *= compare_float((blockB[0].b.mB), 0.0);
	result *= compare_i16vec2(ivec2(blockB[0].c), ivec2(0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[4]), ivec4(0, 0, 0, 0));
	result *= compare_vec2((blockB[1].a[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[4]), vec2(0.0, 0.0));
	result *= compare_uvec2((blockB[1].b.mA[0]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[1].b.mA[1]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[1].b.mA[2]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[1].b.mA[3]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[1].b.mA[4]), uvec2(0u, 0u));
	result *= compare_uvec2((blockB[1].b.mA[5]), uvec2(0u, 0u));
	result *= compare_float((blockB[1].b.mB), 0.0);
	result *= compare_i16vec2(ivec2(blockB[1].c), ivec2(0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[4]), ivec4(0, 0, 0, 0));
	result *= compare_ivec3((blockC.e[0].mA), ivec3(0, 0, 0));
	result *= compare_uint16_t(uint(blockC.e[0].mB), 0u);
	result *= compare_u16vec2(uvec2(blockC.f.mA), uvec2(0u, 0u));
	result *= compare_f16vec3(vec3(blockC.f.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockC.f.mD), 0.0);
	result *= compare_mat4x3((blockF[0].l), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockF[0].m), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((blockF[1].l), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockF[1].m), ivec4(0, 0, 0, 0));
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
	highp uvec2 mA[6]; // unused in vertex shader
	mediump float mB;
	mediump uvec3 mC[8]; // unused in both shaders
};
struct sB
{
	lowp ivec3 mA;
	uint16_t mB;
};
struct sC
{
	u16vec2 mA;
	i16vec2 mB; // unused in both shaders
	f16vec3 mC;
	highp float mD; // unused in vertex shader
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp vec2 a[5];
	sA b; // unused in vertex shader
	i16vec2 c;
	i16vec4 d[5];
} blockB[2];
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	sB e[1]; // unused in vertex shader
	sC f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	f16vec3 g;
} blockD[3];
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	bvec4 h;
	highp vec4 i;
	bvec3 j;
	uint16_t k[1];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2((blockB[0].a[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[0].a[4]), vec2(0.0, 0.0));
	result *= compare_i16vec2(ivec2(blockB[0].c), ivec2(0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[0].d[4]), ivec4(0, 0, 0, 0));
	result *= compare_vec2((blockB[1].a[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockB[1].a[4]), vec2(0.0, 0.0));
	result *= compare_i16vec2(ivec2(blockB[1].c), ivec2(0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockB[1].d[4]), ivec4(0, 0, 0, 0));
	result *= compare_f16vec3(vec3(blockD[0].g), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockD[1].g), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockD[2].g), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec4((h), bvec4(false, false, false, false));
	result *= compare_vec4((i), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((j), bvec3(false, false, false));
	result *= compare_uint16_t(uint(k[0]), 0u);
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
	f16vec2 mA[7]; // unused in fragment shader
	mediump mat4x2 mB;
	lowp float mC; // unused in vertex shader
};
struct sB
{
	uint16_t mA[5];
	sA mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	bool a; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump mat4 b;
	lowp mat2 c;
	lowp float d;
	lowp vec2 e;
} blockC[1];
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	sB f; // unused in vertex shader
	highp mat2 g; // unused in fragment shader
	lowp mat3 h;
	int16_t i; // unused in vertex shader
	f16vec3 j;
} blockD[2];
layout(set = 0, binding = 3) uniform BlockE
{
	mediump uvec3 k;
	highp mat4 l;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((blockC[0].b), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockC[0].c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockC[0].d), 0.0);
	result *= compare_vec2((blockC[0].e), vec2(0.0, 0.0));
	result *= compare_uint16_t(uint(blockD[0].f.mA[0]), 0u);
	result *= compare_uint16_t(uint(blockD[0].f.mA[1]), 0u);
	result *= compare_uint16_t(uint(blockD[0].f.mA[2]), 0u);
	result *= compare_uint16_t(uint(blockD[0].f.mA[3]), 0u);
	result *= compare_uint16_t(uint(blockD[0].f.mA[4]), 0u);
	result *= compare_mat4x2((blockD[0].f.mB.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockD[0].f.mB.mC), 0.0);
	result *= compare_mat3((blockD[0].h), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockD[0].i), 0);
	result *= compare_f16vec3(vec3(blockD[0].j), vec3(0.0, 0.0, 0.0));
	result *= compare_uint16_t(uint(blockD[1].f.mA[0]), 0u);
	result *= compare_uint16_t(uint(blockD[1].f.mA[1]), 0u);
	result *= compare_uint16_t(uint(blockD[1].f.mA[2]), 0u);
	result *= compare_uint16_t(uint(blockD[1].f.mA[3]), 0u);
	result *= compare_uint16_t(uint(blockD[1].f.mA[4]), 0u);
	result *= compare_mat4x2((blockD[1].f.mB.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockD[1].f.mB.mC), 0.0);
	result *= compare_mat3((blockD[1].h), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockD[1].i), 0);
	result *= compare_f16vec3(vec3(blockD[1].j), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockE.k), uvec3(0u, 0u, 0u));
	result *= compare_mat4((blockE.l), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	f16vec2 mA[7]; // unused in fragment shader
	mediump mat4x2 mB;
	lowp float mC; // unused in vertex shader
};
struct sB
{
	uint16_t mA[5];
	sA mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	bool a; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump mat4 b;
	lowp mat2 c;
	lowp float d;
	lowp vec2 e;
} blockC[1];
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	sB f; // unused in vertex shader
	highp mat2 g; // unused in fragment shader
	lowp mat3 h;
	int16_t i; // unused in vertex shader
	f16vec3 j;
} blockD[2];
layout(set = 0, binding = 3) uniform BlockE
{
	mediump uvec3 k;
	highp mat4 l;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((blockB.a), false);
	result *= compare_mat4((blockC[0].b), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockC[0].c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockC[0].d), 0.0);
	result *= compare_vec2((blockC[0].e), vec2(0.0, 0.0));
	result *= compare_mat2((blockD[0].g), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockD[0].h), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockD[0].j), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((blockD[1].g), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockD[1].h), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockD[1].j), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockE.k), uvec3(0u, 0u, 0u));
	result *= compare_mat4((blockE.l), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	f16vec3 h; // unused in fragment shader
	highp mat4x3 i;
	mediump mat4x2 j;
	bvec2 k;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(h), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x3((i), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((j), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((k), bvec2(false, false));
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
	int16_t mA;
	highp vec4 mB; // unused in vertex shader
};
struct sB
{
	highp ivec2 mA; // unused in vertex shader
	highp uint mB; // unused in both shaders
	mediump mat3x2 mC;
};
struct sC
{
	u16vec4 mA;
	highp ivec3 mB;
};
struct sD
{
	u16vec3 mA;
	i16vec3 mB; // unused in fragment shader
	highp uvec2 mC; // unused in vertex shader
	mediump mat2x3 mD;
};
struct sE
{
	mediump uint mA;
	sD mB;
	highp vec4 mC;
	bvec4 mD;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	layout(offset = 88) highp ivec2 z;
	layout(offset = 0) mediump float v; // unused in both shaders
	layout(offset = 80) bool y; // unused in fragment shader
	layout(offset = 4) bool w;
	layout(offset = 16) lowp mat4 x;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	layout(offset = 64) i16vec3 ac;
	layout(offset = 0) lowp vec3 aa; // unused in vertex shader
	layout(offset = 16) lowp mat3x4 ab;
};
layout(set = 0, binding = 8) uniform BlockJ
{
	layout(offset = 80) int16_t ah;
	layout(offset = 0) mediump uint ad;
	layout(offset = 64) highp uvec4 ag;
	layout(offset = 16) highp mat2x3 ae;
	layout(offset = 48) f16vec2 af; // unused in vertex shader
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockH.v), 0.0);
	result *= compare_bool((blockH.w), false);
	result *= compare_mat4((blockH.x), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockH.y), false);
	result *= compare_ivec2((blockH.z), ivec2(0, 0));
	result *= compare_vec3((aa), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(ac), ivec3(0, 0, 0));
	result *= compare_uint((blockJ.ad), 0u);
	result *= compare_mat2x3((blockJ.ae), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec2(vec2(blockJ.af), vec2(0.0, 0.0));
	result *= compare_uvec4((blockJ.ag), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int16_t(int(blockJ.ah), 0);
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
	f16vec4 mA;
};
struct sB
{
	lowp uvec3 mA; // unused in both shaders
	highp uvec4 mB;
	mediump ivec4 mC; // unused in vertex shader
	highp float mD; // unused in vertex shader
};
struct sC
{
	i16vec2 mA;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	layout(offset = 32) mediump mat3x4 q; // unused in fragment shader
	layout(offset = 0) bvec3 o; // unused in fragment shader
	layout(offset = 16) lowp ivec3 p; // unused in vertex shader
} blockG;
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	layout(offset = 16) sC t; // unused in fragment shader
	layout(offset = 0) i16vec2 r;
	layout(offset = 8) u16vec4 s;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((blockG.o), bvec3(false, false, false));
	result *= compare_ivec3((blockG.p), ivec3(0, 0, 0));
	result *= compare_mat3x4((blockG.q), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(blockH.r), ivec2(0, 0));
	result *= compare_u16vec4(uvec4(blockH.s), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i16vec2(ivec2(blockH.t.mA), ivec2(0, 0));
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
	bvec2 mA; // unused in vertex shader
	lowp uint mB;
	u16vec3 mC;
	bvec2 mD;
};
struct sB
{
	mediump mat2x3 mA; // unused in fragment shader
	bvec3 mB;
	u16vec2 mC;
};
layout(set = 0, binding = 4) uniform BlockF
{
	layout(offset = 0) mediump mat3x2 s; // unused in fragment shader
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	layout(offset = 24) f16vec2 w;
	layout(offset = 0) highp ivec2 t; // unused in fragment shader
	layout(offset = 16) lowp ivec2 v; // unused in fragment shader
	layout(offset = 8) highp uvec2 u;
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 32) f16vec4 y;
	layout(offset = 0) mediump mat4x2 x; // unused in fragment shader
} blockH[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG.t), ivec2(0, 0));
	result *= compare_uvec2((blockG.u), uvec2(0u, 0u));
	result *= compare_ivec2((blockG.v), ivec2(0, 0));
	result *= compare_f16vec2(vec2(blockG.w), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockH[0].x), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockH[0].y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH[1].x), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockH[1].y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH[2].x), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockH[2].y), vec4(0.0, 0.0, 0.0, 0.0));
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
	bvec2 mA; // unused in vertex shader
};
struct sB
{
	highp mat2x3 mA;
	i16vec4 mB; // unused in vertex shader
};
layout(set = 0, binding = 4, std430, column_major) uniform BlockF
{
	layout(offset = 32) highp mat3 m;
	layout(offset = 0) mediump vec3 k;
	layout(offset = 16) bvec3 l;
} blockF;
layout(set = 0, binding = 5, scalar, column_major) uniform BlockG
{
	layout(offset = 92) lowp int r; // unused in vertex shader
	layout(offset = 0) u16vec2 n;
	layout(offset = 68) lowp mat2x3 q;
	layout(offset = 4) lowp mat4x2 o;
	layout(offset = 36) sB p;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((blockF.k), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec3((blockF.l), bvec3(false, false, false));
	result *= compare_mat3((blockF.m), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockG.n), uvec2(0u, 0u));
	result *= compare_mat4x2((blockG.o), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG.p.mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockG.p.mB), ivec4(0, 0, 0, 0));
	result *= compare_mat2x3((blockG.q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockG.r), 0);
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
	bvec2 mA;
	lowp vec2 mB;
	bvec2 mC;
};
struct sB
{
	u16vec4 mA;
	lowp int mB;
	f16vec3 mC[8];
	lowp mat4 mD[5]; // unused in both shaders
};
struct sC
{
	highp mat2x3 mA; // unused in both shaders
};
layout(set = 0, binding = 5) uniform BlockG
{
	layout(offset = 96) int16_t q[5];
	layout(offset = 0) mediump mat4x2 o;
	layout(offset = 64) sC p;
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 80) mediump mat2x3 v;
	layout(offset = 0) lowp uint r; // unused in vertex shader
	layout(offset = 64) uint16_t u;
	layout(offset = 16) lowp vec3 s;
	layout(offset = 32) mediump mat3x2 t;
} blockH[1];
layout(set = 0, binding = 7, std430, column_major) uniform BlockI
{
	layout(offset = 0) lowp mat3x2 w; // unused in vertex shader
} blockI[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((blockG.o), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG.p.mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockG.q[0]), 0);
	result *= compare_int16_t(int(blockG.q[1]), 0);
	result *= compare_int16_t(int(blockG.q[2]), 0);
	result *= compare_int16_t(int(blockG.q[3]), 0);
	result *= compare_int16_t(int(blockG.q[4]), 0);
	result *= compare_uint((blockH[0].r), 0u);
	result *= compare_vec3((blockH[0].s), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[0].t), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint16_t(uint(blockH[0].u), 0u);
	result *= compare_mat2x3((blockH[0].v), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockI[0].w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockI[1].w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockI[2].w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 10, rgba8) writeonly uniform image2D outImage;

struct sA
{
	f16vec2 mA;
	uint16_t mB; // unused in vertex shader
	u16vec4 mC; // unused in vertex shader
};
struct sB
{
	i16vec3 mA;
};
struct sC
{
	lowp mat2 mA;
	mediump mat2x3 mB;
};
struct sD
{
	highp uvec3 mA; // unused in vertex shader
};
struct sE
{
	lowp mat3x4 mA;
	bvec4 mB;
	mediump mat4x2 mC;
};
struct sF
{
	lowp ivec2 mA;
};
layout(set = 0, binding = 6) uniform BlockH
{
	layout(offset = 128) highp mat4x3 t;
	layout(offset = 0) sE s;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	layout(offset = 0) bool u;
} blockI;
layout(set = 0, binding = 8, std430) uniform BlockJ
{
	layout(offset = 0) sF v; // unused in fragment shader
};
layout(set = 0, binding = 9, std430) uniform BlockK
{
	layout(offset = 0) f16vec2 w;
} blockK[3];

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
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((blockH.s.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockH.s.mB), bvec4(false, false, false, false));
	result *= compare_mat4x2((blockH.s.mC), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockH.t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockI.u), false);
	result *= compare_ivec2((v.mA), ivec2(0, 0));
	result *= compare_f16vec2(vec2(blockK[0].w), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(blockK[1].w), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(blockK[2].w), vec2(0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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
	f16vec2 mA;
	mediump vec4 mB;
};
layout(set = 0, binding = 4, std430) uniform BlockF
{
	layout(offset = 48) highp uvec2 q[4];
	layout(offset = 0) float16_t m;
	layout(offset = 16) sA p;
	layout(offset = 2) float16_t n;
	layout(offset = 8) i16vec4 o;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(m), 0.0);
	result *= compare_float16_t(float(n), 0.0);
	result *= compare_i16vec4(ivec4(o), ivec4(0, 0, 0, 0));
	result *= compare_f16vec2(vec2(p.mA), vec2(0.0, 0.0));
	result *= compare_vec4((p.mB), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((q[0]), uvec2(0u, 0u));
	result *= compare_uvec2((q[1]), uvec2(0u, 0u));
	result *= compare_uvec2((q[2]), uvec2(0u, 0u));
	result *= compare_uvec2((q[3]), uvec2(0u, 0u));
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
	lowp uint mA[4];
};
struct sB
{
	u16vec2 mA; // unused in vertex shader
};
layout(set = 0, binding = 5, scalar, column_major) uniform BlockG
{
	layout(offset = 4) lowp mat3 u;
	layout(offset = 0) sB t;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(t.mA), uvec2(0u, 0u));
	result *= compare_mat3((u), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std430) uniform BlockF
{
	layout(offset = 48) bvec4 m;
	layout(offset = 0) mediump ivec2 j;
	layout(offset = 32) lowp float l; // unused in vertex shader
	layout(offset = 16) mediump uvec4 k;
};
layout(set = 0, binding = 5, scalar, column_major) uniform BlockG
{
	layout(offset = 0) highp mat3x4 n; // unused in vertex shader
} blockG;
layout(set = 0, binding = 6, std430, row_major) uniform BlockH
{
	layout(offset = 16) bvec2 p;
	layout(offset = 0) mediump mat2 o; // unused in vertex shader
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((j), ivec2(0, 0));
	result *= compare_uvec4((k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((l), 0.0);
	result *= compare_bvec4((m), bvec4(false, false, false, false));
	result *= compare_mat3x4((blockG.n), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH.o), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH.p), bvec2(false, false));
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
	mediump vec3 mA; // unused in vertex shader
	bvec3 mB[1];
	highp mat4 mC;
};
struct sB
{
	float16_t mA[4];
	sA mB;
	bvec2 mC;
};
layout(set = 0, binding = 5, scalar, column_major) uniform BlockG
{
	layout(offset = 0) lowp ivec2 q;
} blockG[2];
layout(set = 0, binding = 6, std430) uniform BlockH
{
	layout(offset = 80) highp uvec3 u; // unused in vertex shader
	layout(offset = 0) highp uint r;
	layout(offset = 64) u16vec2 t; // unused in vertex shader
	layout(offset = 16) mediump mat3x4 s;
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	layout(offset = 0) lowp ivec2 v; // unused in fragment shader
} blockI[3];
layout(set = 0, binding = 8, scalar) uniform BlockJ
{
	layout(offset = 28) lowp mat4 aa;
	layout(offset = 0) uint16_t w; // unused in vertex shader
	layout(offset = 16) lowp uvec3 z;
	layout(offset = 4) mediump float x;
	layout(offset = 8) highp uvec2 y;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((blockG[0].q), ivec2(0, 0));
	result *= compare_ivec2((blockG[1].q), ivec2(0, 0));
	result *= compare_uint((blockH.r), 0u);
	result *= compare_mat3x4((blockH.s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockH.t), uvec2(0u, 0u));
	result *= compare_uvec3((blockH.u), uvec3(0u, 0u, 0u));
	result *= compare_ivec2((blockI[0].v), ivec2(0, 0));
	result *= compare_ivec2((blockI[1].v), ivec2(0, 0));
	result *= compare_ivec2((blockI[2].v), ivec2(0, 0));
	result *= compare_uint16_t(uint(w), 0u);
	result *= compare_float((x), 0.0);
	result *= compare_uvec2((y), uvec2(0u, 0u));
	result *= compare_uvec3((z), uvec3(0u, 0u, 0u));
	result *= compare_mat4((aa), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, row_major) uniform BlockF
{
	bvec3 k; // unused in vertex shader
	f16vec4 l;
	highp uvec3 m;
	i16vec2 n;
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	lowp mat3x2 o; // unused in fragment shader
	highp vec4 p;
	i16vec4 q; // unused in fragment shader
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	bool r;
	highp uint s;
	mediump uvec3 t;
	lowp mat3x2 u;
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	bvec3 v;
	i16vec2 w;
	u16vec3 x;
	uint16_t y;
	lowp ivec2 z; // unused in fragment shader
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((blockF.k), bvec3(false, false, false));
	result *= compare_f16vec4(vec4(blockF.l), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockF.m), uvec3(0u, 0u, 0u));
	result *= compare_i16vec2(ivec2(blockF.n), ivec2(0, 0));
	result *= compare_mat3x2((o), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(q), ivec4(0, 0, 0, 0));
	result *= compare_bool((blockH.r), false);
	result *= compare_uint((blockH.s), 0u);
	result *= compare_uvec3((blockH.t), uvec3(0u, 0u, 0u));
	result *= compare_mat3x2((blockH.u), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockI.v), bvec3(false, false, false));
	result *= compare_i16vec2(ivec2(blockI.w), ivec2(0, 0));
	result *= compare_u16vec3(uvec3(blockI.x), uvec3(0u, 0u, 0u));
	result *= compare_uint16_t(uint(blockI.y), 0u);
	result *= compare_ivec2((blockI.z), ivec2(0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4) uniform BlockF
{
	lowp mat3 q; // unused in vertex shader
	lowp ivec4 r;
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	lowp ivec4 s; // unused in vertex shader
	highp mat4 t;
	f16vec3 u;
} blockG;

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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((blockF.q), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockF.r), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockG.s), ivec4(0, 0, 0, 0));
	result *= compare_mat4((blockG.t), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockG.u), vec3(0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140) uniform BlockF
{
	mediump mat4 m;
	bvec3 n; // unused in fragment shader
	lowp ivec3 o;
	highp mat4x2 p;
	highp mat2x3 q;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	u8vec3 r;
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump uvec4 s; // unused in vertex shader
} blockH;
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	highp mat4x2 t;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((n), bvec3(false, false, false));
	result *= compare_ivec3((o), ivec3(0, 0, 0));
	result *= compare_mat4x2((p), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(r), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockH.s), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x2((t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6) uniform BlockH
{
	i8vec3 q;
	mediump vec2 r; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(q), ivec3(0, 0, 0));
	result *= compare_vec2((r), vec2(0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140) uniform BlockF
{
	lowp uvec2 i; // unused in both shaders
	highp mat2 j;
	lowp uint k; // unused in fragment shader
	bvec3 l;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp int m;
	highp mat2x3 n;
	bvec3 o;
	int8_t p;
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	mediump uvec4 q;
};
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	lowp vec2 r;
	mediump uvec4 s;
	mediump mat2x3 t;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((i), uvec2(0u, 0u));
	result *= compare_mat2((j), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((k), 0u);
	result *= compare_bvec3((l), bvec3(false, false, false));
	result *= compare_int((blockG.m), 0);
	result *= compare_mat2x3((blockG.n), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockG.o), bvec3(false, false, false));
	result *= compare_int8_t(int(blockG.p), 0);
	result *= compare_uvec4((q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec2((r), vec2(0.0, 0.0));
	result *= compare_uvec4((s), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((t), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140) uniform BlockG
{
	bvec3 l; // unused in fragment shader
	mediump mat4 m;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((l), bvec3(false, false, false));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	bvec2 mA;
};
struct sB
{
	int8_t mA;
	bvec3 mB;
	i8vec2 mC;
};
struct sC
{
	highp mat4x2 mA;
	bool mB;
	bvec2 mC;
	mediump uint mD;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	sA a;
	mediump vec2 b;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	bvec2 c; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	sB d;
	lowp uvec3 e[8];
	mediump vec3 f;
	sC g;
} blockD;
layout(set = 0, binding = 4, std140) uniform BlockF
{
	bool k;
	lowp mat3 l;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec2((a.mA), bvec2(false, false));
	result *= compare_vec2((b), vec2(0.0, 0.0));
	result *= compare_bvec2((blockC.c), bvec2(false, false));
	result *= compare_int8_t(int(blockD.d.mA), 0);
	result *= compare_bvec3((blockD.d.mB), bvec3(false, false, false));
	result *= compare_i8vec2(ivec2(blockD.d.mC), ivec2(0, 0));
	result *= compare_uvec3((blockD.e[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[4]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[5]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[6]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[7]), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockD.f), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockD.g.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.g.mB), false);
	result *= compare_bvec2((blockD.g.mC), bvec2(false, false));
	result *= compare_uint((blockD.g.mD), 0u);
	result *= compare_bool((k), false);
	result *= compare_mat3((l), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	bvec2 mA;
};
struct sB
{
	int8_t mA;
	bvec3 mB;
	i8vec2 mC;
};
struct sC
{
	highp mat4x2 mA;
	bool mB;
	bvec2 mC;
	mediump uint mD;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	sA a;
	mediump vec2 b;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	bvec2 c; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	sB d;
	lowp uvec3 e[8];
	mediump vec3 f;
	sC g;
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	mediump mat3x4 h;
	i8vec4 i;
	mediump mat3 j;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec2((a.mA), bvec2(false, false));
	result *= compare_vec2((b), vec2(0.0, 0.0));
	result *= compare_int8_t(int(blockD.d.mA), 0);
	result *= compare_bvec3((blockD.d.mB), bvec3(false, false, false));
	result *= compare_i8vec2(ivec2(blockD.d.mC), ivec2(0, 0));
	result *= compare_uvec3((blockD.e[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[4]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[5]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[6]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockD.e[7]), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockD.f), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockD.g.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.g.mB), false);
	result *= compare_bvec2((blockD.g.mC), bvec2(false, false));
	result *= compare_uint((blockD.g.mD), 0u);
	result *= compare_mat3x4((blockE.h), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockE.i), ivec4(0, 0, 0, 0));
	result *= compare_mat3((blockE.j), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	i8vec2 mA;
	highp vec2 mB; // unused in fragment shader
};
struct sB
{
	mediump ivec4 mA;
	lowp uvec4 mB;
	sA mC;
	highp mat2 mD; // unused in both shaders
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	bvec3 i; // unused in vertex shader
	i8vec3 j;
	u8vec2 k;
} blockF;
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	mediump mat3 l; // unused in vertex shader
	lowp mat4 m;
	i8vec2 n;
	u8vec4 o; // unused in both shaders
};
layout(set = 0, binding = 6) uniform BlockH
{
	mediump uint p;
	highp mat3 q;
	lowp ivec3 r;
	int8_t s;
	highp mat4x3 t;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((blockF.i), bvec3(false, false, false));
	result *= compare_i8vec3(ivec3(blockF.j), ivec3(0, 0, 0));
	result *= compare_u8vec2(uvec2(blockF.k), uvec2(0u, 0u));
	result *= compare_mat3((l), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(n), ivec2(0, 0));
	result *= compare_u8vec4(uvec4(o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((blockH.p), 0u);
	result *= compare_mat3((blockH.q), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH.r), ivec3(0, 0, 0));
	result *= compare_int8_t(int(blockH.s), 0);
	result *= compare_mat4x3((blockH.t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, row_major) uniform BlockB
{
	lowp mat2 a; // unused in fragment shader
	mediump mat4 b;
	highp ivec3 c; // unused in fragment shader
	highp uvec4 d;
	highp mat3 e;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	lowp uvec4 f;
	mediump uvec3 g;
	bvec4 h;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	bvec2 i;
	lowp mat2x3 j;
	highp uvec4 k;
	u8vec3 l;
	u8vec2 m; // unused in vertex shader
} blockD;
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	highp vec3 r;
	bvec3 s; // unused in fragment shader
	mediump ivec4 t;
	lowp ivec4 u;
	lowp ivec2 v;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((blockB.b), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockB.d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockB.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockC.f), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec3((blockC.g), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockC.h), bvec4(false, false, false, false));
	result *= compare_bvec2((blockD.i), bvec2(false, false));
	result *= compare_mat2x3((blockD.j), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockD.k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockD.l), uvec3(0u, 0u, 0u));
	result *= compare_u8vec2(uvec2(blockD.m), uvec2(0u, 0u));
	result *= compare_vec3((r), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec4((t), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((u), ivec4(0, 0, 0, 0));
	result *= compare_ivec2((v), ivec2(0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, row_major) uniform BlockB
{
	lowp mat2 a; // unused in fragment shader
	mediump mat4 b;
	highp ivec3 c; // unused in fragment shader
	highp uvec4 d;
	highp mat3 e;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	lowp uvec4 f;
	mediump uvec3 g;
	bvec4 h;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	bvec2 i;
	lowp mat2x3 j;
	highp uvec4 k;
	u8vec3 l;
	u8vec2 m; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	bvec4 n; // unused in vertex shader
	lowp vec2 o;
	i8vec2 p; // unused in fragment shader
	u8vec2 q; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((blockB.a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB.b), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockB.c), ivec3(0, 0, 0));
	result *= compare_uvec4((blockB.d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockB.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockC.f), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec3((blockC.g), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockC.h), bvec4(false, false, false, false));
	result *= compare_bvec2((blockD.i), bvec2(false, false));
	result *= compare_mat2x3((blockD.j), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockD.k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockD.l), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockE.o), vec2(0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockE.p), ivec2(0, 0));
	result *= compare_u8vec2(uvec2(blockE.q), uvec2(0u, 0u));
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
	highp mat2x3 mB;
};
struct sB
{
	mediump vec2 mA;
	i8vec4 mB;
	int8_t mC; // unused in vertex shader
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	i8vec2 a;
	lowp uvec4 b; // unused in both shaders
	u8vec3 c;
};
layout(set = 0, binding = 1) uniform BlockC
{
	u8vec4 d;
	sA e;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	sB f;
	lowp vec4 g;
	mediump uvec4 h; // unused in vertex shader
	lowp int i[1];
} blockD[3];
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	mediump vec3 j; // unused in vertex shader
	i8vec3 k; // unused in fragment shader
	highp ivec4 l;
	bool m; // unused in fragment shader
	mediump vec2 n; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(a), ivec2(0, 0));
	result *= compare_u8vec3(uvec3(c), uvec3(0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockC.d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((blockC.e.mA), 0.0);
	result *= compare_mat2x3((blockC.e.mB), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockD[0].f.mA), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockD[0].f.mB), ivec4(0, 0, 0, 0));
	result *= compare_int8_t(int(blockD[0].f.mC), 0);
	result *= compare_vec4((blockD[0].g), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockD[0].h), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockD[0].i[0]), 0);
	result *= compare_vec2((blockD[1].f.mA), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockD[1].f.mB), ivec4(0, 0, 0, 0));
	result *= compare_int8_t(int(blockD[1].f.mC), 0);
	result *= compare_vec4((blockD[1].g), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockD[1].h), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockD[1].i[0]), 0);
	result *= compare_vec2((blockD[2].f.mA), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockD[2].f.mB), ivec4(0, 0, 0, 0));
	result *= compare_int8_t(int(blockD[2].f.mC), 0);
	result *= compare_vec4((blockD[2].g), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockD[2].h), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockD[2].i[0]), 0);
	result *= compare_vec3((j), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec4((l), ivec4(0, 0, 0, 0));
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

struct sA
{
	mediump float mA;
	highp mat2x3 mB;
};
struct sB
{
	mediump vec2 mA;
	i8vec4 mB;
	int8_t mC; // unused in vertex shader
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	i8vec2 a;
	lowp uvec4 b; // unused in both shaders
	u8vec3 c;
};
layout(set = 0, binding = 1) uniform BlockC
{
	u8vec4 d;
	sA e;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	sB f;
	lowp vec4 g;
	mediump uvec4 h; // unused in vertex shader
	lowp int i[1];
} blockD[3];
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	mediump vec3 j; // unused in vertex shader
	i8vec3 k; // unused in fragment shader
	highp ivec4 l;
	bool m; // unused in fragment shader
	mediump vec2 n; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(a), ivec2(0, 0));
	result *= compare_u8vec3(uvec3(c), uvec3(0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockC.d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((blockC.e.mA), 0.0);
	result *= compare_mat2x3((blockC.e.mB), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockD[0].f.mA), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockD[0].f.mB), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockD[0].g), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockD[0].i[0]), 0);
	result *= compare_vec2((blockD[1].f.mA), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockD[1].f.mB), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockD[1].g), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockD[1].i[0]), 0);
	result *= compare_vec2((blockD[2].f.mA), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockD[2].f.mB), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockD[2].g), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockD[2].i[0]), 0);
	result *= compare_i8vec3(ivec3(k), ivec3(0, 0, 0));
	result *= compare_ivec4((l), ivec4(0, 0, 0, 0));
	result *= compare_bool((m), false);
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
	highp mat3x2 mA;
	int8_t mB;
	mediump vec2 mC;
	mediump ivec2 mD;
};
struct sB
{
	lowp uint mA;
};
struct sC
{
	highp mat2x3 mA;
	sA mB; // unused in vertex shader
	lowp vec4 mC; // unused in vertex shader
	sB mD;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	mediump vec3 a[5];
	highp uvec2 b;
	i8vec2 c;
	highp uvec3 d;
} blockB[2];
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	u8vec3 e; // unused in vertex shader
} blockC;
layout(set = 0, binding = 4, std140) uniform BlockF
{
	highp uvec4 k;
	mediump uvec2 l; // unused in fragment shader
	lowp uvec2 m;
	lowp mat2x3 n; // unused in fragment shader
} blockF[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3((blockB[0].a[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB[0].b), uvec2(0u, 0u));
	result *= compare_i8vec2(ivec2(blockB[0].c), ivec2(0, 0));
	result *= compare_uvec3((blockB[0].d), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockB[1].a[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB[1].b), uvec2(0u, 0u));
	result *= compare_i8vec2(ivec2(blockB[1].c), ivec2(0, 0));
	result *= compare_uvec3((blockB[1].d), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockC.e), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockF[0].k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((blockF[0].m), uvec2(0u, 0u));
	result *= compare_uvec4((blockF[1].k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((blockF[1].m), uvec2(0u, 0u));
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
	highp mat3x2 mA;
	int8_t mB;
	mediump vec2 mC;
	mediump ivec2 mD;
};
struct sB
{
	lowp uint mA;
};
struct sC
{
	highp mat2x3 mA;
	sA mB; // unused in vertex shader
	lowp vec4 mC; // unused in vertex shader
	sB mD;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	mediump vec3 a[5];
	highp uvec2 b;
	i8vec2 c;
	highp uvec3 d;
} blockB[2];
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	u8vec3 e; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	uint8_t f;
	lowp mat2x3 g[6];
	lowp vec3 h;
	i8vec3 i; // unused in fragment shader
} blockD[2];
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	sC j;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec3((blockB[0].a[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].a[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB[0].b), uvec2(0u, 0u));
	result *= compare_i8vec2(ivec2(blockB[0].c), ivec2(0, 0));
	result *= compare_uvec3((blockB[0].d), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockB[1].a[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].a[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB[1].b), uvec2(0u, 0u));
	result *= compare_i8vec2(ivec2(blockB[1].c), ivec2(0, 0));
	result *= compare_uvec3((blockB[1].d), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(blockD[0].f), 0u);
	result *= compare_mat2x3((blockD[0].g[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[0].g[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[0].g[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[0].g[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[0].g[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[0].g[5]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockD[0].h), vec3(0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockD[0].i), ivec3(0, 0, 0));
	result *= compare_uint8_t(uint(blockD[1].f), 0u);
	result *= compare_mat2x3((blockD[1].g[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[1].g[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[1].g[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[1].g[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[1].g[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockD[1].g[5]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockD[1].h), vec3(0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockD[1].i), ivec3(0, 0, 0));
	result *= compare_mat2x3((j.mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((j.mD.mA), 0u);
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
	highp vec4 mA[7];
};
struct sB
{
	mediump vec2 mA; // unused in fragment shader
	sA mB;
};
struct sC
{
	i8vec3 mA;
};
struct sD
{
	i8vec4 mA;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	mediump ivec3 a;
	sB b;
	u8vec4 c;
	mediump uvec2 d;
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	sD f;
	u8vec3 g;
	mediump int h;
	lowp uvec3 i;
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	lowp uvec2 j;
	u8vec3 k;
} blockE;
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	mediump mat3x2 l;
} blockF[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((a), ivec3(0, 0, 0));
	result *= compare_vec4((b.mB.mA[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[4]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[5]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[6]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((d), uvec2(0u, 0u));
	result *= compare_i8vec4(ivec4(blockD.f.mA), ivec4(0, 0, 0, 0));
	result *= compare_u8vec3(uvec3(blockD.g), uvec3(0u, 0u, 0u));
	result *= compare_int((blockD.h), 0);
	result *= compare_uvec3((blockD.i), uvec3(0u, 0u, 0u));
	result *= compare_uvec2((blockE.j), uvec2(0u, 0u));
	result *= compare_u8vec3(uvec3(blockE.k), uvec3(0u, 0u, 0u));
	result *= compare_mat3x2((blockF[0].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF[1].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF[2].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp vec4 mA[7];
};
struct sB
{
	mediump vec2 mA; // unused in fragment shader
	sA mB;
};
struct sC
{
	i8vec3 mA;
};
struct sD
{
	i8vec4 mA;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	mediump ivec3 a;
	sB b;
	u8vec4 c;
	mediump uvec2 d;
};
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	sC e;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((a), ivec3(0, 0, 0));
	result *= compare_vec2((b.mA), vec2(0.0, 0.0));
	result *= compare_vec4((b.mB.mA[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[4]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[5]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB.mA[6]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((d), uvec2(0u, 0u));
	result *= compare_i8vec3(ivec3(e.mA), ivec3(0, 0, 0));
    v_vtxResult = result;
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
	uint8_t mA;
	mediump mat3 mB[2]; // unused in fragment shader
};
struct sB
{
	mediump uvec2 mA;
	highp mat3x2 mB[3]; // unused in vertex shader
	highp mat2 mC;
};
layout(set = 0, binding = 5) uniform BlockG
{
	u8vec3 s;
} blockG[2];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	mediump mat4x2 t; // unused in fragment shader
	highp ivec2 u;
} blockH[1];
layout(set = 0, binding = 7, std140) uniform BlockI
{
	u8vec2 v;
	int8_t w;
};
layout(set = 0, binding = 8, column_major) uniform BlockJ
{
	lowp vec3 x;
};

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
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(blockG[0].s), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].s), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockH[0].t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockH[0].u), ivec2(0, 0));
	result *= compare_u8vec2(uvec2(v), uvec2(0u, 0u));
	result *= compare_int8_t(int(w), 0);
	result *= compare_vec3((x), vec3(0.0, 0.0, 0.0));
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
	mediump ivec4 mA;
};
struct sB
{
	i8vec4 mA;
	mediump uvec3 mB; // unused in fragment shader
	u8vec2 mC;
};
struct sC
{
	sB mA;
	lowp uvec3 mB; // unused in fragment shader
	mediump mat3x4 mC; // unused in both shaders
	mediump mat4x3 mD[3];
};
struct sD
{
	lowp mat3x4 mA;
	highp mat3 mB; // unused in vertex shader
	mediump mat3 mC;
	u8vec4 mD;
};
struct sE
{
	highp mat3x2 mA; // unused in vertex shader
	mediump mat4 mB; // unused in fragment shader
	highp uvec3 mC[7];
};
struct sF
{
	mediump uvec3 mA; // unused in both shaders
	lowp float mB; // unused in fragment shader
	bvec3 mC; // unused in fragment shader
	sE mD; // unused in vertex shader
};
struct sG
{
	u8vec4 mA;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	bool u; // unused in both shaders
	lowp vec4 v; // unused in vertex shader
} blockI;
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	mediump mat4x2 w; // unused in vertex shader
	mediump mat2 x;
} blockJ;

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
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bool((blockI.u), false);
	result *= compare_vec4((blockI.v), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockJ.w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockJ.x), mat2(0.0, 0.0, 0.0, 0.0));
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
	mediump int mA;
	mediump vec3 mB;
	mediump int mC;
};
struct sB
{
	highp mat2 mA; // unused in fragment shader
	lowp mat3x2 mB;
	lowp mat3 mC;
};
struct sC
{
	bvec2 mA;
	i8vec2 mB;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 208) bvec3 p[2];
	layout(offset = 0) lowp ivec3 l;
	layout(offset = 192) i8vec3 o;
	layout(offset = 16) bool m[8]; // unused in vertex shader
	layout(offset = 144) mediump mat4x3 n; // unused in fragment shader
} blockG[3];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 48) mediump ivec3 r; // unused in vertex shader
	layout(offset = 0) lowp mat2x3 q; // unused in vertex shader
} blockH;
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	layout(offset = 96) u8vec4 w;
	layout(offset = 0) mediump mat4x3 s;
	layout(offset = 80) sC v;
	layout(offset = 48) bvec4 t;
	layout(offset = 64) highp ivec4 u; // unused in vertex shader
} blockI;
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	layout(offset = 0) highp mat2 x;
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
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((blockG[0].l), ivec3(0, 0, 0));
	result *= compare_bool((blockG[0].m[0]), false);
	result *= compare_bool((blockG[0].m[1]), false);
	result *= compare_bool((blockG[0].m[2]), false);
	result *= compare_bool((blockG[0].m[3]), false);
	result *= compare_bool((blockG[0].m[4]), false);
	result *= compare_bool((blockG[0].m[5]), false);
	result *= compare_bool((blockG[0].m[6]), false);
	result *= compare_bool((blockG[0].m[7]), false);
	result *= compare_mat4x3((blockG[0].n), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockG[0].o), ivec3(0, 0, 0));
	result *= compare_bvec3((blockG[0].p[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockG[0].p[1]), bvec3(false, false, false));
	result *= compare_ivec3((blockG[1].l), ivec3(0, 0, 0));
	result *= compare_bool((blockG[1].m[0]), false);
	result *= compare_bool((blockG[1].m[1]), false);
	result *= compare_bool((blockG[1].m[2]), false);
	result *= compare_bool((blockG[1].m[3]), false);
	result *= compare_bool((blockG[1].m[4]), false);
	result *= compare_bool((blockG[1].m[5]), false);
	result *= compare_bool((blockG[1].m[6]), false);
	result *= compare_bool((blockG[1].m[7]), false);
	result *= compare_mat4x3((blockG[1].n), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockG[1].o), ivec3(0, 0, 0));
	result *= compare_bvec3((blockG[1].p[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockG[1].p[1]), bvec3(false, false, false));
	result *= compare_ivec3((blockG[2].l), ivec3(0, 0, 0));
	result *= compare_bool((blockG[2].m[0]), false);
	result *= compare_bool((blockG[2].m[1]), false);
	result *= compare_bool((blockG[2].m[2]), false);
	result *= compare_bool((blockG[2].m[3]), false);
	result *= compare_bool((blockG[2].m[4]), false);
	result *= compare_bool((blockG[2].m[5]), false);
	result *= compare_bool((blockG[2].m[6]), false);
	result *= compare_bool((blockG[2].m[7]), false);
	result *= compare_mat4x3((blockG[2].n), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockG[2].o), ivec3(0, 0, 0));
	result *= compare_bvec3((blockG[2].p[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockG[2].p[1]), bvec3(false, false, false));
	result *= compare_mat2x3((blockH.q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH.r), ivec3(0, 0, 0));
	result *= compare_mat4x3((blockI.s), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockI.t), bvec4(false, false, false, false));
	result *= compare_ivec4((blockI.u), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((blockI.v.mA), bvec2(false, false));
	result *= compare_i8vec2(ivec2(blockI.v.mB), ivec2(0, 0));
	result *= compare_u8vec4(uvec4(blockI.w), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2((x), mat2(0.0, 0.0, 0.0, 0.0));
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
	i8vec4 mA; // unused in fragment shader
};
layout(set = 0, binding = 5, std430) uniform BlockG
{
	layout(offset = 12) uint8_t r; // unused in vertex shader
	layout(offset = 0) mediump vec2 p;
	layout(offset = 8) sA q; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 4) i8vec2 t;
	layout(offset = 0) u8vec3 s;
} blockH;
layout(set = 0, binding = 7, scalar) uniform BlockI
{
	layout(offset = 16) lowp mat4x2 x;
	layout(offset = 0) bool u; // unused in fragment shader
	layout(offset = 5) i8vec3 w[3];
	layout(offset = 4) int8_t v;
};
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	layout(offset = 176) i8vec4 ac;
	layout(offset = 0) uint8_t y[1];
	layout(offset = 64) bvec3 ab[7];
	layout(offset = 16) lowp uvec3 z[2];
	layout(offset = 48) i8vec3 aa;
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((blockG.p), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockG.q.mA), ivec4(0, 0, 0, 0));
	result *= compare_uint8_t(uint(blockG.r), 0u);
	result *= compare_u8vec3(uvec3(blockH.s), uvec3(0u, 0u, 0u));
	result *= compare_i8vec2(ivec2(blockH.t), ivec2(0, 0));
	result *= compare_bool((u), false);
	result *= compare_int8_t(int(v), 0);
	result *= compare_i8vec3(ivec3(w[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(w[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(w[2]), ivec3(0, 0, 0));
	result *= compare_mat4x2((x), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(blockJ.y[0]), 0u);
	result *= compare_uvec3((blockJ.z[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockJ.z[1]), uvec3(0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(blockJ.aa), ivec3(0, 0, 0));
	result *= compare_bvec3((blockJ.ab[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockJ.ab[1]), bvec3(false, false, false));
	result *= compare_bvec3((blockJ.ab[2]), bvec3(false, false, false));
	result *= compare_bvec3((blockJ.ab[3]), bvec3(false, false, false));
	result *= compare_bvec3((blockJ.ab[4]), bvec3(false, false, false));
	result *= compare_bvec3((blockJ.ab[5]), bvec3(false, false, false));
	result *= compare_bvec3((blockJ.ab[6]), bvec3(false, false, false));
	result *= compare_i8vec4(ivec4(blockJ.ac), ivec4(0, 0, 0, 0));
    imageStore(outImage, coord, vec4(result));
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
	mediump mat3x4 mA; // unused in vertex shader
	highp ivec3 mB;
};
layout(set = 0, binding = 4, scalar, column_major) uniform BlockF
{
	layout(offset = 0) highp uint o; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((o), 0u);
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
	highp vec2 mA[1];
	highp uvec4 mB; // unused in fragment shader
};
struct sB
{
	bvec3 mA; // unused in fragment shader
	bvec4 mB;
};
struct sC
{
	highp ivec2 mA;
	sB mB;
};
struct sD
{
	u8vec4 mA;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	layout(offset = 8) lowp float s;
	layout(offset = 0) lowp int q;
	layout(offset = 4) u8vec2 r;
} blockG;
layout(set = 0, binding = 6, scalar) uniform BlockH
{
	layout(offset = 36) highp mat3 u;
	layout(offset = 0) sC t; // unused in vertex shader
};
layout(set = 0, binding = 7, std430) uniform BlockI
{
	layout(offset = 116) sD z;
	layout(offset = 0) lowp vec2 v;
	layout(offset = 112) i8vec2 y;
	layout(offset = 8) bvec2 w[4];
	layout(offset = 48) highp mat4 x;
} blockI;
layout(set = 0, binding = 8, scalar, row_major) uniform BlockJ
{
	layout(offset = 0) mediump mat4x2 aa;
};

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((blockG.q), 0);
	result *= compare_u8vec2(uvec2(blockG.r), uvec2(0u, 0u));
	result *= compare_float((blockG.s), 0.0);
	result *= compare_ivec2((t.mA), ivec2(0, 0));
	result *= compare_bvec3((t.mB.mA), bvec3(false, false, false));
	result *= compare_bvec4((t.mB.mB), bvec4(false, false, false, false));
	result *= compare_mat3((u), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockI.v), vec2(0.0, 0.0));
	result *= compare_bvec2((blockI.w[0]), bvec2(false, false));
	result *= compare_bvec2((blockI.w[1]), bvec2(false, false));
	result *= compare_bvec2((blockI.w[2]), bvec2(false, false));
	result *= compare_bvec2((blockI.w[3]), bvec2(false, false));
	result *= compare_mat4((blockI.x), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockI.y), ivec2(0, 0));
	result *= compare_u8vec4(uvec4(blockI.z.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x2((aa), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp mat3x2 mA; // unused in vertex shader
	lowp mat2x3 mB;
	highp mat2 mC;
	i8vec2 mD;
};
struct sB
{
	mediump mat3 mA; // unused in fragment shader
};
struct sC
{
	sB mA; // unused in fragment shader
};
struct sD
{
	i8vec2 mA; // unused in fragment shader
	uint8_t mB; // unused in vertex shader
};
layout(set = 0, binding = 4, std430) uniform BlockF
{
	layout(offset = 204) uint8_t s;
	layout(offset = 0) mediump mat3x4 o[3];
	layout(offset = 192) mediump ivec3 r;
	layout(offset = 144) highp uvec4 p;
	layout(offset = 160) highp mat2x3 q;
} blockF;
layout(set = 0, binding = 5, std430, column_major) uniform BlockG
{
	layout(offset = 88) lowp mat2 x; // unused in both shaders
	layout(offset = 0) highp int t; // unused in vertex shader
	layout(offset = 80) int8_t w;
	layout(offset = 4) mediump float u;
	layout(offset = 16) lowp mat4x3 v;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((blockF.o[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF.o[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF.o[2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockF.p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((blockF.q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockF.r), ivec3(0, 0, 0));
	result *= compare_uint8_t(uint(blockF.s), 0u);
	result *= compare_int((blockG.t), 0);
	result *= compare_float((blockG.u), 0.0);
	result *= compare_mat4x3((blockG.v), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(blockG.w), 0);
	result *= compare_mat2((blockG.x), mat2(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
