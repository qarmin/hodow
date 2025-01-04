#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec2 var[3][4];
};

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

layout(set = 0, binding = 0, std430) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
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

layout(set = 0, binding = 0, std430) uniform Block
{
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec3 var[3][4];
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var[0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][2]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][3]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][2]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][3]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][2]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][3]), uvec3(0u, 0u, 0u));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


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

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec2 var[3][4];
};

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(var[0][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][3]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][3]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][3]), ivec2(0, 0));
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
	i16vec2 var[3][4];
};

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(var[0][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[0][3]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1][3]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2][3]), ivec2(0, 0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec3 var[3][4];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec3((var[0][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][3]), uvec3(0u, 0u, 0u));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec4 var[3][4];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((var[0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][3]), uvec4(0u, 0u, 0u, 0u));
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
	highp uvec4 var[3][4];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec4((var[0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[0][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[1][3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((var[2][3]), uvec4(0u, 0u, 0u, 0u));
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
	bvec2 var[3][4];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
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
	highp mat4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat2x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat2x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	u8vec3 var[3][4];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
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


mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
	i8vec4 var[3][4];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec4 var[3][4];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
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


mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t padding;
	i16vec3 var[3][4];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	f16vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec2(vec2(var[0][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][3]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][3]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][3]), vec2(0.0, 0.0));
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
	float16_t padding;
	f16vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(var[0][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][3]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][3]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][3]), vec2(0.0, 0.0));
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
	f16vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(var[0][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[0][3]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[1][3]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][0]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][1]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][2]), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(var[2][3]), vec2(0.0, 0.0));
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
	highp vec2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2((var[0][0][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][0][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][1][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][1][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][2][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][2][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][3][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][3][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][0][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][0][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][1][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][1][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][2][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][2][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][3][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][3][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][0][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][0][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][1][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][1][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][2][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][2][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][3][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][3][1]), vec2(0.0, 0.0));
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
	highp vec2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2((var[0][0][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][0][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][1][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][1][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][2][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][2][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][3][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[0][3][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][0][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][0][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][1][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][1][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][2][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][2][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][3][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1][3][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][0][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][0][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][1][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][1][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][2][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][2][1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][3][0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2][3][1]), vec2(0.0, 0.0));
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
	highp uint var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	highp uint var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec2 var[3][4][2];
};

mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat4x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat4x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp uvec2 var[3][4][2];
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
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
	highp uvec4 var[3][4][2];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	highp uvec4 var[3][4][2];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std430) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	u8vec2 var[3][4][2];
};

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(var[0][0][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][0][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][1][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][1][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][2][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][2][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][3][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[0][3][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][0][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][0][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][1][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][1][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][2][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][2][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][3][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1][3][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][0][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][0][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][1][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][1][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][2][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][2][1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][3][0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2][3][1]), uvec2(0u, 0u));
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

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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
	highp uvec2 var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

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
    gl_Position = a_position;
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
	highp mat2x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat4x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	u8vec4 var[3][4][2];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(var[0][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[0][3][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[1][3][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][0][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][0][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][1][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][1][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][2][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][2][1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][3][0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(var[2][3][1]), uvec4(0u, 0u, 0u, 0u));
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
	int8_t padding;
	i8vec2 var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(var[0][0][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][0][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][1][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][1][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][2][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][2][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][3][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[0][3][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][0][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][0][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][1][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][1][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][2][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][2][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][3][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1][3][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][0][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][0][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][1][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][1][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][2][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][2][1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][3][0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2][3][1]), ivec2(0, 0));
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
	i8vec3 var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
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
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

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
	int8_t padding;
	i8vec4 var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	u16vec2 var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(var[0][0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][3][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][3][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][3][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][3][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][3][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][3][1]), uvec2(0u, 0u));
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec2 var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(var[0][0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][3][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[0][3][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][3][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1][3][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][0][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][0][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][1][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][1][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][2][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][2][1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][3][0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2][3][1]), uvec2(0u, 0u));
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
	u16vec3 var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var[0][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][3][1]), uvec3(0u, 0u, 0u));
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
	u16vec3 var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var[0][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[0][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[1][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(var[2][3][1]), uvec3(0u, 0u, 0u));
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
	int16_t var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
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


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
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
	f16vec4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
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
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((var), false);
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
	uint8_t var;
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

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
	i8vec2 var;
};

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(var), ivec2(0, 0));
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
	i8vec4 var;
};

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


mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

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
	u16vec3 var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	u16vec4 var;
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(var), uvec4(0u, 0u, 0u, 0u));
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
	i16vec3 var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec4 var;
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(var), ivec4(0, 0, 0, 0));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp vec4 var;
};

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

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp mat2 var;
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

layout(set = 0, binding = 0, std140) uniform Block
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
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat2x3 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	lowp mat4x2 var;
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

layout(set = 0, binding = 0, std140) uniform Block
{
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump vec3 var;
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
	mediump mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
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
	mediump mat2x4 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	mediump mat3x4 var;
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
	highp mat3 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec4 var;
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(var), ivec4(0, 0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
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

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec2 var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec3 var;
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(var), uvec3(0u, 0u, 0u));
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
	u16vec3 var;
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

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
	u16vec3 var;
};

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

layout(set = 0, binding = 0, std430) uniform Block
{
	int16_t var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(var), 0);
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
	int16_t var;
};

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

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec3 var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

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
};

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
};

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

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp int var;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp int var;
};

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

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp ivec3 var;
};

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	lowp mat4x2 var;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump vec2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2((var), vec2(0.0, 0.0));
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
	result *= compare_vec2((var), vec2(0.0, 0.0));
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
	mediump int var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((var), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


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

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump uint var;
};

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

layout(set = 0, binding = 0, std430) uniform Block
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
	mediump uvec3 var;
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
	mediump uvec3 var;
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump mat4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump mat2x3 var;
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat2x3 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	mediump mat3x2 var;
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	mediump mat3x4 var;
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uint var;
};

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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2 var;
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat3x2 var;
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat3x4 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat4x2 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

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
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_i16vec2(ivec2(var), ivec2(0, 0));
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
	i16vec2 var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_i16vec2(ivec2(var), ivec2(0, 0));
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
	i16vec4 var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_i16vec4(ivec4(var), ivec4(0, 0, 0, 0));
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
	i16vec4 var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

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
	i16vec4 var;
};

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
};

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	lowp vec4 var;
};

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	lowp int var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((var), 0);
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
	lowp uint var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	result *= compare_float((padding), 0.0);
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
	result *= compare_float((padding), 0.0);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	lowp mat3x2 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	lowp mat4x2 var;
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
	mediump vec3 var;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	mediump uint var;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

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
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
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
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat4((var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	result *= compare_float((padding), 0.0);
	result *= compare_mat4((var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2x3 var;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat2x3 var;
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
	highp mat2x3 var;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

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
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
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
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, std140) uniform Block
{
	bool var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((var[0]), false);
	result *= compare_bool((var[1]), false);
	result *= compare_bool((var[2]), false);
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


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
	f16vec2 var[3];
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp vec2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2((var[0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2]), vec2(0.0, 0.0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec3 var[3];
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec3((var[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2]), uvec3(0u, 0u, 0u));
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec4 var[3];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec4 var[3];
};

mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((var[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((var[2]), bvec4(false, false, false, false));
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

layout(set = 0, binding = 0, std430) uniform Block
{
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat4x3 var[3];
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

layout(set = 0, binding = 0, std430) uniform Block
{
	float16_t var[3];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430) uniform Block
{
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_vec2((var[0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2]), vec2(0.0, 0.0));
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
	highp vec4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((var[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2]), vec4(0.0, 0.0, 0.0, 0.0));
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
	highp uvec2 var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
	result *= compare_uvec2((var[0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2]), uvec2(0u, 0u));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bool var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
	result *= compare_bool((var[0]), false);
	result *= compare_bool((var[1]), false);
	result *= compare_bool((var[2]), false);
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
	bool var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
	result *= compare_bool((var[0]), false);
	result *= compare_bool((var[1]), false);
	result *= compare_bool((var[2]), false);
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat2x3 var[3];
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4x2 var[3];
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
	u8vec2 var[3];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec2 var[3];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t padding;
	i16vec2 var[3];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(var[0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(var[2]), ivec2(0, 0));
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
	f16vec4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(var[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2]), vec4(0.0, 0.0, 0.0, 0.0));
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
	highp vec3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3((var[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[6]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[7]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[8]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[9]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[10]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[11]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[12]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[13]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[14]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[15]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[16]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[17]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[18]), vec3(0.0, 0.0, 0.0));
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
	highp vec3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec3((var[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[6]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[7]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[8]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[9]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[10]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[11]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[12]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[13]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[14]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[15]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[16]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[17]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[18]), vec3(0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec4 var[];
};

mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat2x4 var[];
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	i8vec4 var[];
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(var[0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[4]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[5]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[6]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[7]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[8]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[9]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[10]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[11]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[12]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[13]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[14]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[15]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[16]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[17]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[18]), ivec4(0, 0, 0, 0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec3 var[];
};

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec3(ivec3(var[0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[3]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[4]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[5]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[6]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[7]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[8]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[9]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[10]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[11]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[12]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[13]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[14]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[15]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[16]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[17]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[18]), ivec3(0, 0, 0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec4 var[];
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
	f16vec2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
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


mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec4 var[];
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(var[0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[4]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[5]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[6]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[7]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[8]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[9]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[10]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[11]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[12]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[13]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[14]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[15]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[16]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[17]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[18]), ivec4(0, 0, 0, 0));
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
	i16vec2 var[];
};

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp vec2 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((var[0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2]), vec2(0.0, 0.0));
	result *= compare_vec2((var[3]), vec2(0.0, 0.0));
	result *= compare_vec2((var[4]), vec2(0.0, 0.0));
	result *= compare_vec2((var[5]), vec2(0.0, 0.0));
	result *= compare_vec2((var[6]), vec2(0.0, 0.0));
	result *= compare_vec2((var[7]), vec2(0.0, 0.0));
	result *= compare_vec2((var[8]), vec2(0.0, 0.0));
	result *= compare_vec2((var[9]), vec2(0.0, 0.0));
	result *= compare_vec2((var[10]), vec2(0.0, 0.0));
	result *= compare_vec2((var[11]), vec2(0.0, 0.0));
	result *= compare_vec2((var[12]), vec2(0.0, 0.0));
	result *= compare_vec2((var[13]), vec2(0.0, 0.0));
	result *= compare_vec2((var[14]), vec2(0.0, 0.0));
	result *= compare_vec2((var[15]), vec2(0.0, 0.0));
	result *= compare_vec2((var[16]), vec2(0.0, 0.0));
	result *= compare_vec2((var[17]), vec2(0.0, 0.0));
	result *= compare_vec2((var[18]), vec2(0.0, 0.0));
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
	highp ivec4 var[];
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((var[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[3]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[4]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[5]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[6]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[7]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[8]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[9]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[10]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[11]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[12]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[13]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[14]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[15]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[16]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[17]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[18]), ivec4(0, 0, 0, 0));
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
	highp uvec2 var[];
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp mat4x2 var[];
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	i8vec2 var[];
};

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(var[0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[2]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[3]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[4]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[5]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[6]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[7]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[8]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[9]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[10]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[11]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[12]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[13]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[14]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[15]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[16]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[17]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(var[18]), ivec2(0, 0));
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
	i8vec4 var[];
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(var[0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[4]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[5]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[6]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[7]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[8]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[9]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[10]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[11]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[12]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[13]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[14]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[15]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[16]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[17]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(var[18]), ivec4(0, 0, 0, 0));
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
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((block[0].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[0].s.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[1].s.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[2].s.c), vec4(0.0, 0.0, 0.0, 0.0));
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
    mediump float result = 1.0;
	result *= compare_mat3((block[0].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[0].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[0].s.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[1].s.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((block[2].s.c), vec4(0.0, 0.0, 0.0, 0.0));
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

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((s.a), ivec3(0, 0, 0));
	result *= compare_ivec2((s.b[0]), ivec2(0, 0));
	result *= compare_ivec2((s.b[1]), ivec2(0, 0));
	result *= compare_ivec2((s.b[2]), ivec2(0, 0));
	result *= compare_ivec2((s.b[3]), ivec2(0, 0));
	result *= compare_vec4((s.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((v), vec2(0.0, 0.0));
	result *= compare_mat3((t[0].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[0].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[3]), ivec2(0, 0));
	result *= compare_vec4((t[0].b[0].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[0].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[3]), ivec2(0, 0));
	result *= compare_vec4((t[0].b[1].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[0].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[3]), ivec2(0, 0));
	result *= compare_vec4((t[0].b[2].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((t[1].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[1].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[3]), ivec2(0, 0));
	result *= compare_vec4((t[1].b[0].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[1].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[3]), ivec2(0, 0));
	result *= compare_vec4((t[1].b[1].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[1].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[3]), ivec2(0, 0));
	result *= compare_vec4((t[1].b[2].c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((u), 0u);
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
layout(set = 0, binding = 0, std430) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp vec2 var;
} block[3];

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uvec2 var;
} block[3];

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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uvec4 var;
} block[3];

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((block[0].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((block[1].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((block[2].var), uvec4(0u, 0u, 0u, 0u));
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
	result *= compare_uvec4((block[0].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((block[1].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((block[2].var), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


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

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec2 var;
} block[3];

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((block[0].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((block[1].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((block[2].var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x3((block[0].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((block[1].var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	uint8_t var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(block[0].var), 0u);
	result *= compare_uint8_t(uint(block[1].var), 0u);
	result *= compare_uint8_t(uint(block[2].var), 0u);
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
	u8vec2 var;
} block[3];

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(block[0].var), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(block[1].var), uvec2(0u, 0u));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec4 var;
} block[3];

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
	u8vec4 var;
} block[3];

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

layout(set = 0, binding = 0, std140) uniform Block
{
	u16vec2 var;
} block[3];

mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(block[0].var), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(block[1].var), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(block[2].var), uvec2(0u, 0u));
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
	u16vec3 var;
} block[3];

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

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
	u16vec3 var;
} block[3];

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp vec4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

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
	highp uvec3 var;
} block[3];

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec3((block[0].var), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((block[1].var), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((block[2].var), uvec3(0u, 0u, 0u));
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

layout(set = 0, binding = 0, std430) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3((block[0].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((block[0].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[1].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((block[2].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2x3((block[0].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((block[1].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((block[2].var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
	result *= compare_mat2x4((block[0].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((block[1].var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	uint8_t var;
} block[3];

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(block[0].var), 0u);
	result *= compare_uint8_t(uint(block[1].var), 0u);
	result *= compare_uint8_t(uint(block[2].var), 0u);
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
	u16vec4 var;
} block[3];

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

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec2 var;
} block[3];

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat3x2((block[0].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat3x2((block[1].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat3x2((block[0].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat3x2((block[1].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat3x2((block[2].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec2 var;
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(block[0].padding), 0);
	result *= compare_i8vec2(ivec2(block[0].var), ivec2(0, 0));
	result *= compare_int8_t(int(block[1].padding), 0);
	result *= compare_i8vec2(ivec2(block[1].var), ivec2(0, 0));
	result *= compare_int8_t(int(block[2].padding), 0);
	result *= compare_i8vec2(ivec2(block[2].var), ivec2(0, 0));
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
	int16_t var;
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(block[0].var), 0);
	result *= compare_int16_t(int(block[1].var), 0);
	result *= compare_int16_t(int(block[2].var), 0);
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
	f16vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(block[0].padding), 0.0);
	result *= compare_f16vec2(vec2(block[0].var), vec2(0.0, 0.0));
	result *= compare_float16_t(float(block[1].padding), 0.0);
	result *= compare_f16vec2(vec2(block[1].var), vec2(0.0, 0.0));
	result *= compare_float16_t(float(block[2].padding), 0.0);
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

layout(set = 0, binding = 0, std140) uniform BlockB
{
	highp uint a; // unused in fragment shader
	mediump float b;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump int c;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	bool d; // unused in vertex shader
	highp int e;
	highp int f;
	bool g;
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	lowp int k;
	mediump float l;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((blockB.b), 0.0);
	result *= compare_int((blockC.c), 0);
	result *= compare_bool((d), false);
	result *= compare_int((e), 0);
	result *= compare_int((f), 0);
	result *= compare_bool((g), false);
	result *= compare_int((blockF.k), 0);
	result *= compare_float((blockF.l), 0.0);
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
	highp uint a; // unused in fragment shader
	mediump float b;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump int c;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	bool d; // unused in vertex shader
	highp int e;
	highp int f;
	bool g;
};
layout(set = 0, binding = 3) uniform BlockE
{
	mediump float h;
	bool i;
	lowp int j;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((blockB.a), 0u);
	result *= compare_float((blockB.b), 0.0);
	result *= compare_int((blockC.c), 0);
	result *= compare_int((e), 0);
	result *= compare_int((f), 0);
	result *= compare_bool((g), false);
	result *= compare_float((h), 0.0);
	result *= compare_bool((i), false);
	result *= compare_int((j), 0);
    v_vtxResult = result;
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
	lowp int a;
	lowp uint b; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	bool c; // unused in fragment shader
};
layout(set = 0, binding = 3) uniform BlockE
{
	mediump float i;
	mediump int j;
	bool k;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((blockB.a), 0);
	result *= compare_float((blockE.i), 0.0);
	result *= compare_int((blockE.j), 0);
	result *= compare_bool((blockE.k), false);
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
	lowp int a;
	lowp uint b; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	bool c; // unused in fragment shader
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bool d;
	bool e;
	highp uint f;
	mediump int g;
	bool h;
} blockD;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((blockB.a), 0);
	result *= compare_uint((blockB.b), 0u);
	result *= compare_bool((c), false);
	result *= compare_bool((blockD.d), false);
	result *= compare_bool((blockD.e), false);
	result *= compare_uint((blockD.f), 0u);
	result *= compare_int((blockD.g), 0);
	result *= compare_bool((blockD.h), false);
    v_vtxResult = result;
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
	highp uvec2 b;
	lowp int c; // unused in vertex shader
	lowp int d; // unused in fragment shader
	mediump uvec4 e;
};
layout(set = 0, binding = 3) uniform BlockE
{
	highp ivec4 k;
	bool l;
	bvec2 m;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec4((a), bvec4(false, false, false, false));
	result *= compare_uvec2((b), uvec2(0u, 0u));
	result *= compare_int((c), 0);
	result *= compare_uvec4((e), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((k), ivec4(0, 0, 0, 0));
	result *= compare_bool((l), false);
	result *= compare_bvec2((m), bvec2(false, false));
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
	highp uvec2 b;
	lowp int c; // unused in vertex shader
	lowp int d; // unused in fragment shader
	mediump uvec4 e;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	lowp vec2 f;
};
layout(set = 0, binding = 2) uniform BlockD
{
	lowp ivec3 g;
	bvec3 h;
	mediump uvec4 i; // unused in fragment shader
	lowp uint j;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((a), bvec4(false, false, false, false));
	result *= compare_uvec2((b), uvec2(0u, 0u));
	result *= compare_int((d), 0);
	result *= compare_uvec4((e), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec2((f), vec2(0.0, 0.0));
	result *= compare_ivec3((g), ivec3(0, 0, 0));
	result *= compare_bvec3((h), bvec3(false, false, false));
	result *= compare_uvec4((i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((j), 0u);
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
	highp uvec4 a;
	highp uvec2 b;
	highp int c; // unused in vertex shader
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp uvec2 d;
	bvec3 e;
} blockC;
layout(set = 0, binding = 3, std140) uniform BlockE
{
	mediump uvec3 g;
	bvec4 h;
} blockE;
layout(set = 0, binding = 4) uniform BlockF
{
	bvec2 i;
	mediump vec4 j;
	mediump vec2 k;
	highp float l;
	mediump uvec3 m;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
	result *= compare_uvec4((a), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((b), uvec2(0u, 0u));
	result *= compare_int((c), 0);
	result *= compare_uvec2((blockC.d), uvec2(0u, 0u));
	result *= compare_bvec3((blockC.e), bvec3(false, false, false));
	result *= compare_uvec3((blockE.g), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockE.h), bvec4(false, false, false, false));
	result *= compare_bvec2((i), bvec2(false, false));
	result *= compare_vec4((j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((k), vec2(0.0, 0.0));
	result *= compare_float((l), 0.0);
	result *= compare_uvec3((m), uvec3(0u, 0u, 0u));
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
	highp uvec4 a;
	highp uvec2 b;
	highp int c; // unused in vertex shader
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp uvec2 d;
	bvec3 e;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bool f;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
	result *= compare_uvec4((a), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((b), uvec2(0u, 0u));
	result *= compare_uvec2((blockC.d), uvec2(0u, 0u));
	result *= compare_bvec3((blockC.e), bvec3(false, false, false));
	result *= compare_bool((f), false);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 10, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6, std140) uniform BlockH
{
	mediump vec4 r;
	mediump ivec4 s;
	highp vec2 t;
};
layout(set = 0, binding = 7) uniform BlockI
{
	lowp uint u;
	highp vec4 v; // unused in fragment shader
} blockI;
layout(set = 0, binding = 8) uniform BlockJ
{
	lowp int w;
	highp uvec4 x;
} blockJ;
layout(set = 0, binding = 9) uniform BlockK
{
	lowp uint y; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_vec4((r), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((s), ivec4(0, 0, 0, 0));
	result *= compare_vec2((t), vec2(0.0, 0.0));
	result *= compare_uint((blockI.u), 0u);
	result *= compare_vec4((blockI.v), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockJ.w), 0);
	result *= compare_uvec4((blockJ.x), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((y), 0u);
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
	highp uvec2 o;
	lowp float p; // unused in vertex shader
	lowp float q;
	highp vec3 r;
	bool s;
};
layout(set = 0, binding = 7, std140) uniform BlockI
{
	highp vec2 t; // unused in both shaders
	bvec2 u;
	mediump float v;
	highp uvec4 w; // unused in vertex shader
	bvec4 x;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_uvec2((o), uvec2(0u, 0u));
	result *= compare_float((p), 0.0);
	result *= compare_float((q), 0.0);
	result *= compare_vec3((r), vec3(0.0, 0.0, 0.0));
	result *= compare_bool((s), false);
	result *= compare_vec2((t), vec2(0.0, 0.0));
	result *= compare_bvec2((u), bvec2(false, false));
	result *= compare_float((v), 0.0);
	result *= compare_uvec4((w), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((x), bvec4(false, false, false, false));
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
	highp ivec3 l;
};
layout(set = 0, binding = 6) uniform BlockH
{
	highp mat4 m;
	mediump mat3x4 n;
};
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	bvec4 o; // unused in vertex shader
	mediump mat3 p;
};
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	highp mat4 q;
	mediump float r; // unused in both shaders
	mediump ivec3 s; // unused in fragment shader
	lowp vec4 t;
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((l), ivec3(0, 0, 0));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((n), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((o), bvec4(false, false, false, false));
	result *= compare_mat3((p), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockJ.q), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockJ.r), 0.0);
	result *= compare_ivec3((blockJ.s), ivec3(0, 0, 0));
	result *= compare_vec4((blockJ.t), vec4(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, column_major) uniform BlockF
{
	bvec2 p;
	mediump uint q;
	mediump mat2 r;
	highp uint s;
	highp ivec4 t;
} blockF;
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	bool u;
	lowp mat2x3 v;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_bvec2((blockF.p), bvec2(false, false));
	result *= compare_uint((blockF.q), 0u);
	result *= compare_mat2((blockF.r), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockF.s), 0u);
	result *= compare_ivec4((blockF.t), ivec4(0, 0, 0, 0));
	result *= compare_bool((blockG.u), false);
	result *= compare_mat2x3((blockG.v), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2 a;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	lowp uint b[4];
	bool c;
	highp uvec4 d; // unused in vertex shader
	highp float e; // unused in fragment shader
	bvec2 f;
};
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	mediump ivec3 g;
	mediump mat3x2 h; // unused in fragment shader
	highp vec2 i[3];
	mediump vec4 j;
};
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	mediump mat3 k[3];
	lowp uvec4 l;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((b[0]), 0u);
	result *= compare_uint((b[1]), 0u);
	result *= compare_uint((b[2]), 0u);
	result *= compare_uint((b[3]), 0u);
	result *= compare_bool((c), false);
	result *= compare_uvec4((d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec2((f), bvec2(false, false));
	result *= compare_ivec3((g), ivec3(0, 0, 0));
	result *= compare_vec2((i[0]), vec2(0.0, 0.0));
	result *= compare_vec2((i[1]), vec2(0.0, 0.0));
	result *= compare_vec2((i[2]), vec2(0.0, 0.0));
	result *= compare_vec4((j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((k[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((k[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((k[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((l), uvec4(0u, 0u, 0u, 0u));
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
	highp mat2 a;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	lowp uint b[4];
	bool c;
	highp uvec4 d; // unused in vertex shader
	highp float e; // unused in fragment shader
	bvec2 f;
};
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	mediump ivec3 g;
	mediump mat3x2 h; // unused in fragment shader
	highp vec2 i[3];
	mediump vec4 j;
};
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	mediump mat3 k[3];
	lowp uvec4 l;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((b[0]), 0u);
	result *= compare_uint((b[1]), 0u);
	result *= compare_uint((b[2]), 0u);
	result *= compare_uint((b[3]), 0u);
	result *= compare_bool((c), false);
	result *= compare_float((e), 0.0);
	result *= compare_bvec2((f), bvec2(false, false));
	result *= compare_ivec3((g), ivec3(0, 0, 0));
	result *= compare_mat3x2((h), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((i[0]), vec2(0.0, 0.0));
	result *= compare_vec2((i[1]), vec2(0.0, 0.0));
	result *= compare_vec2((i[2]), vec2(0.0, 0.0));
	result *= compare_vec4((j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((k[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((k[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((k[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((l), uvec4(0u, 0u, 0u, 0u));
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
	highp int l;
	highp vec3 m;
	mediump mat2x3 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((l), 0);
	result *= compare_vec3((m), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((n), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2 a;
	highp ivec4 b;
	mediump mat4 c;
	lowp uvec2 d;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump mat2x3 e;
	lowp mat4 f;
	bvec2 g;
	highp vec4 h; // unused in fragment shader
} blockC[1];
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump vec3 i; // unused in fragment shader
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	mediump uvec3 n; // unused in fragment shader
	highp mat3x4 o;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((blockB.a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockB.b), ivec4(0, 0, 0, 0));
	result *= compare_mat4((blockB.c), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.d), uvec2(0u, 0u));
	result *= compare_mat2x3((blockC[0].e), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockC[0].f), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockC[0].g), bvec2(false, false));
	result *= compare_mat3x4((blockF.o), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2 a;
	highp ivec4 b;
	mediump mat4 c;
	lowp uvec2 d;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump mat2x3 e;
	lowp mat4 f;
	bvec2 g;
	highp vec4 h; // unused in fragment shader
} blockC[1];
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump vec3 i; // unused in fragment shader
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	bvec2 j; // unused in vertex shader
	bvec2 k; // unused in fragment shader
	highp mat3x2 l;
	mediump vec4 m; // unused in vertex shader
} blockE[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((blockB.a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockB.b), ivec4(0, 0, 0, 0));
	result *= compare_mat4((blockB.c), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.d), uvec2(0u, 0u));
	result *= compare_mat2x3((blockC[0].e), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockC[0].f), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockC[0].g), bvec2(false, false));
	result *= compare_vec4((blockC[0].h), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((i), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec2((blockE[0].k), bvec2(false, false));
	result *= compare_mat3x2((blockE[0].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockE[1].k), bvec2(false, false));
	result *= compare_mat3x2((blockE[1].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockE[2].k), bvec2(false, false));
	result *= compare_mat3x2((blockE[2].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
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
	mediump ivec2 a;
	lowp vec2 b;
} blockB[3];
layout(set = 0, binding = 1) uniform BlockC
{
	mediump vec2 c;
	mediump mat2 d; // unused in vertex shader
};
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	highp ivec3 e; // unused in vertex shader
} blockD;
layout(set = 0, binding = 4) uniform BlockF
{
	highp mat4x2 g;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec2((blockB[0].a), ivec2(0, 0));
	result *= compare_vec2((blockB[0].b), vec2(0.0, 0.0));
	result *= compare_ivec2((blockB[1].a), ivec2(0, 0));
	result *= compare_vec2((blockB[1].b), vec2(0.0, 0.0));
	result *= compare_ivec2((blockB[2].a), ivec2(0, 0));
	result *= compare_vec2((blockB[2].b), vec2(0.0, 0.0));
	result *= compare_vec2((c), vec2(0.0, 0.0));
	result *= compare_mat2((d), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockD.e), ivec3(0, 0, 0));
	result *= compare_mat4x2((g), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump ivec2 a;
	lowp vec2 b;
} blockB[3];
layout(set = 0, binding = 1) uniform BlockC
{
	mediump vec2 c;
	mediump mat2 d; // unused in vertex shader
};
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	highp ivec3 e; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3, std140) uniform BlockE
{
	lowp vec4 f;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec2((blockB[0].a), ivec2(0, 0));
	result *= compare_vec2((blockB[0].b), vec2(0.0, 0.0));
	result *= compare_ivec2((blockB[1].a), ivec2(0, 0));
	result *= compare_vec2((blockB[1].b), vec2(0.0, 0.0));
	result *= compare_ivec2((blockB[2].a), ivec2(0, 0));
	result *= compare_vec2((blockB[2].b), vec2(0.0, 0.0));
	result *= compare_vec2((c), vec2(0.0, 0.0));
	result *= compare_vec4((f), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, column_major) uniform BlockF
{
	mediump vec3 p;
	bvec3 q; // unused in vertex shader
	bool r; // unused in vertex shader
	highp mat3x4 s;
} blockF[1];
layout(set = 0, binding = 5) uniform BlockG
{
	highp mat2x3 t; // unused in fragment shader
	highp uvec2 u; // unused in vertex shader
	lowp ivec4 v;
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	lowp float w; // unused in both shaders
	highp uint x;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((blockF[0].p), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec3((blockF[0].q), bvec3(false, false, false));
	result *= compare_bool((blockF[0].r), false);
	result *= compare_mat3x4((blockF[0].s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((t), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((u), uvec2(0u, 0u));
	result *= compare_ivec4((v), ivec4(0, 0, 0, 0));
	result *= compare_float((blockH.w), 0.0);
	result *= compare_uint((blockH.x), 0u);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp vec2 o;
	highp vec4 p;
	highp mat4x2 q;
} blockG;
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	bvec3 r;
	mediump mat3x4 s; // unused in fragment shader
	highp mat3x2 t;
	lowp uint u;
} blockH;
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	bvec4 v;
	bvec2 w; // unused in fragment shader
	highp uvec3 x;
} blockI;
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	highp uvec3 y;
	mediump uvec3 z;
	bvec2 aa;
	mediump mat4x3 ab;
	lowp mat2x3 ac; // unused in fragment shader
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_vec2((blockG.o), vec2(0.0, 0.0));
	result *= compare_vec4((blockG.p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.q), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockH.r), bvec3(false, false, false));
	result *= compare_mat3x4((blockH.s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH.t), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockH.u), 0u);
	result *= compare_bvec4((blockI.v), bvec4(false, false, false, false));
	result *= compare_bvec2((blockI.w), bvec2(false, false));
	result *= compare_uvec3((blockI.x), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((y), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((z), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((aa), bvec2(false, false));
	result *= compare_mat4x3((ab), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((ac), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2 a;
	highp ivec4 b;
	bool c;
	highp int d; // unused in vertex shader
	highp vec4 e;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump uvec2 f; // unused in vertex shader
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	mediump int q;
	highp uvec3 r;
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	mediump mat3x4 s;
	highp mat4 t;
	lowp ivec4 u; // unused in vertex shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((b), ivec4(0, 0, 0, 0));
	result *= compare_bool((c), false);
	result *= compare_int((d), 0);
	result *= compare_vec4((e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((f), uvec2(0u, 0u));
	result *= compare_int((blockF.q), 0);
	result *= compare_uvec3((blockF.r), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockG.s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockG.t), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockG.u), ivec4(0, 0, 0, 0));
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
	highp mat2 a;
	highp ivec4 b;
	bool c;
	highp int d; // unused in vertex shader
	highp vec4 e;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump uvec2 f; // unused in vertex shader
};
layout(set = 0, binding = 2) uniform BlockD
{
	mediump ivec3 g;
	highp ivec3 h;
	lowp uvec2 i;
	bvec2 j; // unused in both shaders
	bvec2 k;
} blockD;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	lowp vec3 l;
	highp mat4x2 m; // unused in fragment shader
	bvec2 n; // unused in fragment shader
	lowp mat4 o;
	highp int p; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2((a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((b), ivec4(0, 0, 0, 0));
	result *= compare_bool((c), false);
	result *= compare_vec4((e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockD.g), ivec3(0, 0, 0));
	result *= compare_ivec3((blockD.h), ivec3(0, 0, 0));
	result *= compare_uvec2((blockD.i), uvec2(0u, 0u));
	result *= compare_bvec2((blockD.k), bvec2(false, false));
	result *= compare_vec3((blockE.l), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockE.m), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockE.n), bvec2(false, false));
	result *= compare_mat4((blockE.o), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	bool mA; // unused in fragment shader
};
struct sB
{
	highp ivec3 mA; // unused in fragment shader
	highp mat2 mB;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	mediump mat4x3 a; // unused in vertex shader
	bool b; // unused in vertex shader
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump mat3x2 c; // unused in fragment shader
	sA d; // unused in fragment shader
	mediump uvec2 e;
	mediump uvec2 f[2];
	lowp mat3x4 g;
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	bool h;
	highp mat3x2 i;
	lowp ivec3 j;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	highp vec3 k;
	lowp vec4 l; // unused in both shaders
	sB m;
	lowp ivec3 n; // unused in vertex shader
	highp ivec2 o; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x3((a), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((b), false);
	result *= compare_uvec2((e), uvec2(0u, 0u));
	result *= compare_uvec2((f[0]), uvec2(0u, 0u));
	result *= compare_uvec2((f[1]), uvec2(0u, 0u));
	result *= compare_mat3x4((g), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.h), false);
	result *= compare_mat3x2((blockD.i), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockD.j), ivec3(0, 0, 0));
	result *= compare_vec3((blockE.k), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((blockE.m.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockE.n), ivec3(0, 0, 0));
	result *= compare_ivec2((blockE.o), ivec2(0, 0));
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
	bool mA; // unused in fragment shader
};
struct sB
{
	highp ivec3 mA; // unused in fragment shader
	highp mat2 mB;
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	mediump mat4x3 a; // unused in vertex shader
	bool b; // unused in vertex shader
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump mat3x2 c; // unused in fragment shader
	sA d; // unused in fragment shader
	mediump uvec2 e;
	mediump uvec2 f[2];
	lowp mat3x4 g;
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	bool h;
	highp mat3x2 i;
	lowp ivec3 j;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	highp vec3 k;
	lowp vec4 l; // unused in both shaders
	sB m;
	lowp ivec3 n; // unused in vertex shader
	highp ivec2 o; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((c), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((d.mA), false);
	result *= compare_uvec2((e), uvec2(0u, 0u));
	result *= compare_uvec2((f[0]), uvec2(0u, 0u));
	result *= compare_uvec2((f[1]), uvec2(0u, 0u));
	result *= compare_mat3x4((g), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.h), false);
	result *= compare_mat3x2((blockD.i), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockD.j), ivec3(0, 0, 0));
	result *= compare_vec3((blockE.k), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((blockE.m.mA), ivec3(0, 0, 0));
	result *= compare_mat2((blockE.m.mB), mat2(0.0, 0.0, 0.0, 0.0));
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
	lowp mat2x3 mA[6];
	highp vec3 mB;
	mediump mat2 mC;
};
struct sB
{
	highp mat4x2 mA;
	sA mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	lowp mat3x2 a[2];
	lowp uvec2 b;
	highp mat4x2 c[1];
	mediump mat4 d;
	mediump mat3x4 e;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	bvec4 f;
	lowp mat4x3 g;
	lowp vec3 h[1];
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	lowp ivec3 i;
	bool j;
	bool k;
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	sB l;
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x2((blockB.a[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.b), uvec2(0u, 0u));
	result *= compare_mat4x2((blockB.c[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB.d), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB.e), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((f), bvec4(false, false, false, false));
	result *= compare_mat4x3((g), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((h[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((i), ivec3(0, 0, 0));
	result *= compare_bool((j), false);
	result *= compare_bool((k), false);
	result *= compare_mat4x2((l.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[5]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((l.mB.mB), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((l.mB.mC), mat2(0.0, 0.0, 0.0, 0.0));
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
	lowp mat2x3 mA[6];
	highp vec3 mB;
	mediump mat2 mC;
};
struct sB
{
	highp mat4x2 mA;
	sA mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	lowp mat3x2 a[2];
	lowp uvec2 b;
	highp mat4x2 c[1];
	mediump mat4 d;
	mediump mat3x4 e;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	bvec4 f;
	lowp mat4x3 g;
	lowp vec3 h[1];
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	lowp ivec3 i;
	bool j;
	bool k;
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	sB l;
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((blockB.a[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.b), uvec2(0u, 0u));
	result *= compare_mat4x2((blockB.c[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB.d), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB.e), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((f), bvec4(false, false, false, false));
	result *= compare_mat4x3((g), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((h[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((i), ivec3(0, 0, 0));
	result *= compare_bool((j), false);
	result *= compare_bool((k), false);
	result *= compare_mat4x2((l.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((l.mB.mA[5]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((l.mB.mB), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((l.mB.mC), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat3x4 mA; // unused in vertex shader
	highp ivec2 mB; // unused in vertex shader
};
struct sB
{
	mediump mat3x4 mA;
	lowp ivec4 mB;
	lowp mat2 mC; // unused in fragment shader
	lowp mat3x4 mD; // unused in vertex shader
};
struct sC
{
	bvec3 mA; // unused in vertex shader
	sB mB;
	bvec3 mC;
	mediump mat4 mD;
};
layout(set = 0, binding = 4) uniform BlockF
{
	highp ivec3 o; // unused in vertex shader
	highp uvec4 p;
};

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((o), ivec3(0, 0, 0));
	result *= compare_uvec4((p), uvec4(0u, 0u, 0u, 0u));
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
	highp mat2x3 mA;
};
struct sB
{
	bvec2 mA;
	bvec2 mB;
};
struct sC
{
	bvec2 mA;
	highp mat2 mB; // unused in both shaders
	mediump ivec2 mC;
};
struct sD
{
	highp float mA; // unused in both shaders
	highp ivec2 mB; // unused in both shaders
	sC mC;
	lowp mat4 mD;
};
layout(set = 0, binding = 6) uniform BlockH
{
	mediump mat3x4 q;
	lowp mat3x4 r;
	sA s; // unused in vertex shader
	highp mat4 t; // unused in both shaders
} blockH;
layout(set = 0, binding = 7, std140) uniform BlockI
{
	lowp ivec3 u;
	sB v;
	highp mat2x3 w;
} blockI;
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	highp uvec2 x;
	mediump ivec2 y; // unused in vertex shader
	bvec4 z;
	mediump int aa; // unused in both shaders
	highp uvec3 ab;
};
layout(set = 0, binding = 9, std140) uniform BlockK
{
	highp uvec4 ac;
	sD ad;
	lowp uvec4 ae;
	lowp mat2x3 af; // unused in vertex shader
} blockK[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_mat3x4((blockH.q), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH.r), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH.s.mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockH.t), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockI.u), ivec3(0, 0, 0));
	result *= compare_bvec2((blockI.v.mA), bvec2(false, false));
	result *= compare_bvec2((blockI.v.mB), bvec2(false, false));
	result *= compare_mat2x3((blockI.w), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((x), uvec2(0u, 0u));
	result *= compare_ivec2((y), ivec2(0, 0));
	result *= compare_bvec4((z), bvec4(false, false, false, false));
	result *= compare_int((aa), 0);
	result *= compare_uvec3((ab), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockK[0].ac), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((blockK[0].ad.mA), 0.0);
	result *= compare_ivec2((blockK[0].ad.mB), ivec2(0, 0));
	result *= compare_bvec2((blockK[0].ad.mC.mA), bvec2(false, false));
	result *= compare_mat2((blockK[0].ad.mC.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockK[0].ad.mC.mC), ivec2(0, 0));
	result *= compare_mat4((blockK[0].ad.mD), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockK[0].ae), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((blockK[0].af), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockK[1].ac), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((blockK[1].ad.mA), 0.0);
	result *= compare_ivec2((blockK[1].ad.mB), ivec2(0, 0));
	result *= compare_bvec2((blockK[1].ad.mC.mA), bvec2(false, false));
	result *= compare_mat2((blockK[1].ad.mC.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockK[1].ad.mC.mC), ivec2(0, 0));
	result *= compare_mat4((blockK[1].ad.mD), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockK[1].ae), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((blockK[1].af), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockK[2].ac), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((blockK[2].ad.mA), 0.0);
	result *= compare_ivec2((blockK[2].ad.mB), ivec2(0, 0));
	result *= compare_bvec2((blockK[2].ad.mC.mA), bvec2(false, false));
	result *= compare_mat2((blockK[2].ad.mC.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockK[2].ad.mC.mC), ivec2(0, 0));
	result *= compare_mat4((blockK[2].ad.mD), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockK[2].ae), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((blockK[2].af), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp int mA[7];
	highp vec2 mB; // unused in fragment shader
	highp uvec3 mC; // unused in fragment shader
	mediump ivec2 mD;
};
struct sB
{
	lowp mat2 mA;
	highp ivec4 mB;
	mediump mat3 mC; // unused in fragment shader
};
struct sC
{
	mediump mat2 mA; // unused in fragment shader
	bvec4 mB;
	lowp int mC;
	highp mat4x2 mD;
};
struct sD
{
	mediump mat2x3 mA; // unused in fragment shader
	mediump int mB; // unused in fragment shader
	mediump int mC;
	sC mD;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	mediump ivec3 r;
	highp uvec2 s;
	highp uvec2 t; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	highp mat3 u;
	bvec3 v;
	lowp ivec3 w;
} blockG;
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump mat4x3 x;
	highp mat2 y;
	sD z;
	mediump float aa;
	bvec3 ab[5];
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((blockF.r), ivec3(0, 0, 0));
	result *= compare_uvec2((blockF.s), uvec2(0u, 0u));
	result *= compare_uvec2((blockF.t), uvec2(0u, 0u));
	result *= compare_mat3((blockG.u), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockG.v), bvec3(false, false, false));
	result *= compare_ivec3((blockG.w), ivec3(0, 0, 0));
	result *= compare_mat4x3((blockH.x), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH.y), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH.z.mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockH.z.mB), 0);
	result *= compare_int((blockH.z.mC), 0);
	result *= compare_mat2((blockH.z.mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockH.z.mD.mB), bvec4(false, false, false, false));
	result *= compare_int((blockH.z.mD.mC), 0);
	result *= compare_mat4x2((blockH.z.mD.mD), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockH.aa), 0.0);
	result *= compare_bvec3((blockH.ab[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockH.ab[1]), bvec3(false, false, false));
	result *= compare_bvec3((blockH.ab[2]), bvec3(false, false, false));
	result *= compare_bvec3((blockH.ab[3]), bvec3(false, false, false));
	result *= compare_bvec3((blockH.ab[4]), bvec3(false, false, false));
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
	lowp float mA; // unused in vertex shader
	mediump int mB;
	lowp mat3x2 mC;
	bool mD;
};
struct sB
{
	sA mA;
	lowp mat3x2 mB;
};
layout(set = 0, binding = 4) uniform BlockF
{
	lowp uint g;
	highp uvec2 h;
	sB i;
	mediump mat4x3 j;
} blockF[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((blockF[0].g), 0u);
	result *= compare_uvec2((blockF[0].h), uvec2(0u, 0u));
	result *= compare_float((blockF[0].i.mA.mA), 0.0);
	result *= compare_int((blockF[0].i.mA.mB), 0);
	result *= compare_mat3x2((blockF[0].i.mA.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockF[0].i.mA.mD), false);
	result *= compare_mat3x2((blockF[0].i.mB), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockF[0].j), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockF[1].g), 0u);
	result *= compare_uvec2((blockF[1].h), uvec2(0u, 0u));
	result *= compare_float((blockF[1].i.mA.mA), 0.0);
	result *= compare_int((blockF[1].i.mA.mB), 0);
	result *= compare_mat3x2((blockF[1].i.mA.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockF[1].i.mA.mD), false);
	result *= compare_mat3x2((blockF[1].i.mB), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockF[1].j), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp ivec4 mA;
	mediump vec3 mB; // unused in fragment shader
	highp uvec3 mC; // unused in fragment shader
};
struct sB
{
	lowp mat4 mA[1]; // unused in fragment shader
	mediump vec2 mB;
	mediump int mC[7];
	highp vec4 mD;
};
struct sC
{
	sB mA[4];
};
struct sD
{
	lowp uvec3 mA; // unused in both shaders
	lowp int mB;
	highp vec3 mC; // unused in vertex shader
};
struct sE
{
	highp vec3 mA;
	mediump mat4x2 mB;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	layout(offset = 80) bool v;
	layout(offset = 0) lowp uvec4 t;
	layout(offset = 16) lowp mat4x3 u;
} blockH[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
	result *= compare_uvec4((blockH[0].t), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x3((blockH[0].u), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockH[0].v), false);
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
	highp int mA;
	mediump mat3 mB;
	lowp int mC;
};
struct sB
{
	lowp ivec3 mA; // unused in fragment shader
};
struct sC
{
	mediump mat2 mA; // unused in vertex shader
	mediump mat4x3 mB[8]; // unused in fragment shader
	lowp uvec3 mC;
};
struct sD
{
	highp mat4 mA; // unused in vertex shader
	lowp mat4 mB;
	bvec3 mC; // unused in vertex shader
	sC mD; // unused in vertex shader
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	layout(offset = 16) highp mat3x2 s;
	layout(offset = 0) lowp ivec3 r; // unused in both shaders
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	layout(offset = 16) highp uvec3 u;
	layout(offset = 0) lowp ivec2 t;
} blockG[2];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 144) highp ivec4 y; // unused in fragment shader
	layout(offset = 0) highp mat3 v; // unused in fragment shader
	layout(offset = 96) mediump mat3 x;
	layout(offset = 48) lowp mat3 w; // unused in fragment shader
} blockH;
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	layout(offset = 5008) lowp uvec3 ad; // unused in fragment shader
	layout(offset = 0) sD z[7];
	layout(offset = 4992) bvec3 ac;
	layout(offset = 4928) mediump mat3x2 aa;
	layout(offset = 4976) highp ivec2 ab;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
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

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((blockF.r), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockF.s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG[0].t), ivec2(0, 0));
	result *= compare_uvec3((blockG[0].u), uvec3(0u, 0u, 0u));
	result *= compare_ivec2((blockG[1].t), ivec2(0, 0));
	result *= compare_uvec3((blockG[1].u), uvec3(0u, 0u, 0u));
	result *= compare_mat3((blockH.v), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.w), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.x), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockH.y), ivec4(0, 0, 0, 0));
	result *= compare_mat4((z[0].mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z[0].mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((z[0].mC), bvec3(false, false, false));
	result *= compare_mat2((z[0].mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[0].mD.mB[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[0].mD.mC), uvec3(0u, 0u, 0u));
	result *= compare_mat4((z[1].mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z[1].mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((z[1].mC), bvec3(false, false, false));
	result *= compare_mat2((z[1].mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[1].mD.mB[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[1].mD.mC), uvec3(0u, 0u, 0u));
	result *= compare_mat4((z[2].mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z[2].mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((z[2].mC), bvec3(false, false, false));
	result *= compare_mat2((z[2].mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[2].mD.mB[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[2].mD.mC), uvec3(0u, 0u, 0u));
	result *= compare_mat4((z[3].mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z[3].mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((z[3].mC), bvec3(false, false, false));
	result *= compare_mat2((z[3].mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[3].mD.mB[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[3].mD.mC), uvec3(0u, 0u, 0u));
	result *= compare_mat4((z[4].mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z[4].mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((z[4].mC), bvec3(false, false, false));
	result *= compare_mat2((z[4].mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[4].mD.mB[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[4].mD.mC), uvec3(0u, 0u, 0u));
	result *= compare_mat4((z[5].mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z[5].mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((z[5].mC), bvec3(false, false, false));
	result *= compare_mat2((z[5].mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[5].mD.mB[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[5].mD.mC), uvec3(0u, 0u, 0u));
	result *= compare_mat4((z[6].mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z[6].mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((z[6].mC), bvec3(false, false, false));
	result *= compare_mat2((z[6].mD.mA), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z[6].mD.mB[7]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[6].mD.mC), uvec3(0u, 0u, 0u));
	result *= compare_mat3x2((aa), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((ab), ivec2(0, 0));
	result *= compare_bvec3((ac), bvec3(false, false, false));
	result *= compare_uvec3((ad), uvec3(0u, 0u, 0u));
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
	lowp mat3 mA;
	bvec3 mB;
};
struct sB
{
	mediump mat4x3 mA;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	layout(offset = 112) highp ivec4 u;
	layout(offset = 0) mediump vec3 r;
	layout(offset = 48) lowp mat4x3 t;
	layout(offset = 16) lowp mat2x3 s; // unused in fragment shader
};

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((r), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((s), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((u), ivec4(0, 0, 0, 0));
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
	mediump vec2 mA[2];
	bvec4 mB;
	bvec4 mC; // unused in vertex shader
};
struct sB
{
	mediump mat4x3 mA;
	highp mat3x4 mB; // unused in vertex shader
};
struct sC
{
	sB mA[7];
	highp int mB;
	lowp mat4 mC;
};
layout(set = 0, binding = 4, std430, column_major) uniform BlockF
{
	layout(offset = 72) highp ivec2 o;
	layout(offset = 0) bvec4 k;
	layout(offset = 64) highp vec2 n;
	layout(offset = 16) mediump uint l;
	layout(offset = 32) bvec3 m[2];
} blockF;
layout(set = 0, binding = 5, scalar, column_major) uniform BlockG
{
	layout(offset = 16) highp uvec3 r; // unused in vertex shader
	layout(offset = 0) mediump ivec3 p;
	layout(offset = 12) lowp uint q;
};
layout(set = 0, binding = 6) uniform BlockH
{
	layout(offset = 96) highp uint w;
	layout(offset = 0) highp ivec4 s;
	layout(offset = 48) mediump mat3x2 v;
	layout(offset = 16) highp vec4 t;
	layout(offset = 32) bool u;
} blockH;
layout(set = 0, binding = 7, scalar, row_major) uniform BlockI
{
	layout(offset = 68) sC ab;
	layout(offset = 0) highp uint x; // unused in vertex shader
	layout(offset = 52) highp vec4 aa;
	layout(offset = 4) lowp vec4 y;
	layout(offset = 20) mediump mat4x2 z;
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((blockF.k), bvec4(false, false, false, false));
	result *= compare_uint((blockF.l), 0u);
	result *= compare_bvec3((blockF.m[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockF.m[1]), bvec3(false, false, false));
	result *= compare_vec2((blockF.n), vec2(0.0, 0.0));
	result *= compare_ivec2((blockF.o), ivec2(0, 0));
	result *= compare_ivec3((p), ivec3(0, 0, 0));
	result *= compare_uint((q), 0u);
	result *= compare_uvec3((r), uvec3(0u, 0u, 0u));
	result *= compare_ivec4((blockH.s), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockH.t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockH.u), false);
	result *= compare_mat3x2((blockH.v), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockH.w), 0u);
	result *= compare_uint((x), 0u);
	result *= compare_vec4((y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((z), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((aa), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((ab.mA[0].mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab.mA[0].mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((ab.mA[1].mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab.mA[1].mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((ab.mA[2].mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab.mA[2].mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((ab.mA[3].mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab.mA[3].mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((ab.mA[4].mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab.mA[4].mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((ab.mA[5].mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab.mA[5].mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((ab.mA[6].mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((ab.mA[6].mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((ab.mB), 0);
	result *= compare_mat4((ab.mC), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, scalar, row_major) uniform BlockG
{
	layout(offset = 16) bvec4 q;
	layout(offset = 0) mediump vec4 p;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((blockG.p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockG.q), bvec4(false, false, false, false));
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
	mediump float a;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	bool b;
	mediump int c;
	lowp float d;
	highp float e;
};
layout(set = 0, binding = 2) uniform BlockD
{
	highp int f;
	float16_t g;
	int16_t h; // unused in fragment shader
	bool i; // unused in fragment shader
	bool j;
};
layout(set = 0, binding = 4) uniform BlockF
{
	uint16_t l; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((blockB.a), 0.0);
	result *= compare_bool((b), false);
	result *= compare_int((c), 0);
	result *= compare_float((d), 0.0);
	result *= compare_float((e), 0.0);
	result *= compare_int((f), 0);
	result *= compare_float16_t(float(g), 0.0);
	result *= compare_bool((j), false);
	result *= compare_uint16_t(uint(l), 0u);
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
	mediump float a;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	bool b;
	mediump int c;
	lowp float d;
	highp float e;
};
layout(set = 0, binding = 2) uniform BlockD
{
	highp int f;
	float16_t g;
	int16_t h; // unused in fragment shader
	bool i; // unused in fragment shader
	bool j;
};
layout(set = 0, binding = 3) uniform BlockE
{
	uint16_t k;
};

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
	result *= compare_float((blockB.a), 0.0);
	result *= compare_bool((b), false);
	result *= compare_int((c), 0);
	result *= compare_float((d), 0.0);
	result *= compare_float((e), 0.0);
	result *= compare_int((f), 0);
	result *= compare_float16_t(float(g), 0.0);
	result *= compare_int16_t(int(h), 0);
	result *= compare_bool((i), false);
	result *= compare_bool((j), false);
	result *= compare_uint16_t(uint(k), 0u);
    v_vtxResult = result;
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
	uint16_t a;
	highp vec3 b;
	mediump float c;
	f16vec3 d; // unused in vertex shader
	u16vec4 e;
} blockB;
layout(set = 0, binding = 3, std140) uniform BlockE
{
	highp int o;
};
layout(set = 0, binding = 4) uniform BlockF
{
	u16vec4 p; // unused in vertex shader
	uint16_t q;
	float16_t r;
	lowp uvec3 s;
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	bvec4 t;
	mediump uvec4 u; // unused in vertex shader
	highp uvec4 v; // unused in vertex shader
	lowp uint w; // unused in vertex shader
	u16vec4 x; // unused in fragment shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(blockB.a), 0u);
	result *= compare_vec3((blockB.b), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockB.c), 0.0);
	result *= compare_f16vec3(vec3(blockB.d), vec3(0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockB.e), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((o), 0);
	result *= compare_u16vec4(uvec4(blockF.p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint16_t(uint(blockF.q), 0u);
	result *= compare_float16_t(float(blockF.r), 0.0);
	result *= compare_uvec3((blockF.s), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockG.t), bvec4(false, false, false, false));
	result *= compare_uvec4((blockG.u), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockG.v), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((blockG.w), 0u);
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
	uint16_t a;
	highp vec3 b;
	mediump float c;
	f16vec3 d; // unused in vertex shader
	u16vec4 e;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	u16vec4 f;
	i16vec2 g; // unused in fragment shader
	u16vec3 h; // unused in vertex shader
	f16vec4 i;
	i16vec2 j; // unused in vertex shader
};
layout(set = 0, binding = 2) uniform BlockD
{
	highp vec4 k;
	lowp uvec4 l; // unused in fragment shader
	float16_t m; // unused in fragment shader
	u16vec3 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(blockB.a), 0u);
	result *= compare_vec3((blockB.b), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockB.c), 0.0);
	result *= compare_u16vec4(uvec4(blockB.e), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(f), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i16vec2(ivec2(g), ivec2(0, 0));
	result *= compare_f16vec4(vec4(i), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((k), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((l), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float16_t(float(m), 0.0);
	result *= compare_u16vec3(uvec3(n), uvec3(0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp uvec2 t;
	mediump ivec4 u; // unused in vertex shader
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	bvec4 v;
	u16vec4 w;
	highp vec2 x;
	lowp uvec2 y;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((blockG.t), uvec2(0u, 0u));
	result *= compare_ivec4((blockG.u), ivec4(0, 0, 0, 0));
	result *= compare_bvec4((v), bvec4(false, false, false, false));
	result *= compare_u16vec4(uvec4(w), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec2((x), vec2(0.0, 0.0));
	result *= compare_uvec2((y), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 10, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6, row_major) uniform BlockH
{
	u16vec3 r; // unused in fragment shader
	lowp uint s;
	bvec4 t;
	lowp uvec2 u; // unused in fragment shader
	i16vec4 v;
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	int16_t w;
};
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	highp mat4x2 x;
	lowp vec4 y;
	int16_t z;
	mediump uvec4 aa;
} blockJ;
layout(set = 0, binding = 9) uniform BlockK
{
	highp vec4 ab;
	i16vec3 ac;
	mediump mat2x3 ad; // unused in fragment shader
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(blockH.r), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockH.s), 0u);
	result *= compare_bvec4((blockH.t), bvec4(false, false, false, false));
	result *= compare_uvec2((blockH.u), uvec2(0u, 0u));
	result *= compare_i16vec4(ivec4(blockH.v), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(w), 0);
	result *= compare_mat4x2((blockJ.x), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockJ.y), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockJ.z), 0);
	result *= compare_uvec4((blockJ.aa), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec4((ab), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(ac), ivec3(0, 0, 0));
	result *= compare_mat2x3((ad), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, column_major) uniform BlockF
{
	lowp uvec3 m;
	int16_t n;
} blockF;
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp mat4x3 o;
	f16vec4 p;
	f16vec3 q[6];
	f16vec4 r;
};
layout(set = 0, binding = 6) uniform BlockH
{
	i16vec4 s;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	bvec2 t;
	mediump float u;
	lowp vec4 v;
	lowp vec4 w;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec3((blockF.m), uvec3(0u, 0u, 0u));
	result *= compare_int16_t(int(blockF.n), 0);
	result *= compare_mat4x3((o), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(q[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(q[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(q[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(q[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(q[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(q[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(r), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(s), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((t), bvec2(false, false));
	result *= compare_float((u), 0.0);
	result *= compare_vec4((v), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((w), vec4(0.0, 0.0, 0.0, 0.0));
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
	lowp uvec2 a;
	highp float b;
	bvec3 c;
	lowp mat4x3 d; // unused in fragment shader
};
layout(set = 0, binding = 1) uniform BlockC
{
	highp vec2 e;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	lowp ivec2 i;
	uint16_t j;
	mediump mat4x3 k;
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	i16vec2 l; // unused in vertex shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec2((a), uvec2(0u, 0u));
	result *= compare_float((b), 0.0);
	result *= compare_bvec3((c), bvec3(false, false, false));
	result *= compare_vec2((e), vec2(0.0, 0.0));
	result *= compare_ivec2((blockF.i), ivec2(0, 0));
	result *= compare_uint16_t(uint(blockF.j), 0u);
	result *= compare_mat4x3((blockF.k), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(blockG.l), ivec2(0, 0));
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
	lowp uvec2 a;
	highp float b;
	bvec3 c;
	lowp mat4x3 d; // unused in fragment shader
};
layout(set = 0, binding = 1) uniform BlockC
{
	highp vec2 e;
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	lowp mat3x4 f; // unused in vertex shader
	lowp uvec2 g;
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	f16vec3 h;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec2((a), uvec2(0u, 0u));
	result *= compare_float((b), 0.0);
	result *= compare_bvec3((c), bvec3(false, false, false));
	result *= compare_mat4x3((d), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((e), vec2(0.0, 0.0));
	result *= compare_uvec2((blockD.g), uvec2(0u, 0u));
	result *= compare_f16vec3(vec3(blockE.h), vec3(0.0, 0.0, 0.0));
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
	mediump uvec4 mA;
};
struct sB
{
	mediump ivec4 mA; // unused in vertex shader
	bvec3 mB; // unused in fragment shader
	mediump vec2 mC;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	lowp mat4x2 p[6];
	lowp vec2 q;
	mediump mat3 r;
	lowp mat3x4 s;
	f16vec4 t;
} blockG[3];
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump uvec4 u;
	u16vec4 v;
} blockH;
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	bvec3 w; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((blockG[0].p[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].p[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].p[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].p[3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].p[4]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].p[5]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockG[0].q), vec2(0.0, 0.0));
	result *= compare_mat3((blockG[0].r), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockG[0].t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].p[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].p[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].p[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].p[3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].p[4]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].p[5]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockG[1].q), vec2(0.0, 0.0));
	result *= compare_mat3((blockG[1].r), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[1].s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockG[1].t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].p[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].p[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].p[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].p[3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].p[4]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].p[5]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockG[2].q), vec2(0.0, 0.0));
	result *= compare_mat3((blockG[2].r), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[2].s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockG[2].t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockH.u), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(blockH.v), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec3((w), bvec3(false, false, false));
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
	bvec3 mA;
};
struct sB
{
	lowp mat4 mA;
	bvec3 mB;
};
struct sC
{
	mediump mat3x4 mA;
	lowp ivec4 mB; // unused in vertex shader
	highp vec3 mC;
};
struct sD
{
	i16vec3 mA;
	f16vec2 mB; // unused in vertex shader
	highp mat3x2 mC;
};
struct sE
{
	highp ivec4 mA;
	mediump mat3 mB; // unused in fragment shader
};
struct sF
{
	f16vec4 mA;
	sE mB;
};
struct sG
{
	highp ivec2 mA;
};
struct sH
{
	sG mA;
	lowp vec2 mB;
};
struct sI
{
	lowp ivec4 mA;
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	f16vec4 r;
	mediump mat3 s; // unused in fragment shader
} blockF[2];
layout(set = 0, binding = 5, std140) uniform BlockG
{
	sH t;
} blockG[3];
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump mat3x4 u;
	sI v;
	uint16_t w; // unused in fragment shader
	float16_t x[5]; // unused in vertex shader
};
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	highp mat4x2 y;
	lowp mat4x3 z; // unused in fragment shader
	highp mat3x2 aa[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(blockF[0].r), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].s), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockF[1].r), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].s), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG[0].t.mA.mA), ivec2(0, 0));
	result *= compare_vec2((blockG[0].t.mB), vec2(0.0, 0.0));
	result *= compare_ivec2((blockG[1].t.mA.mA), ivec2(0, 0));
	result *= compare_vec2((blockG[1].t.mB), vec2(0.0, 0.0));
	result *= compare_ivec2((blockG[2].t.mA.mA), ivec2(0, 0));
	result *= compare_vec2((blockG[2].t.mB), vec2(0.0, 0.0));
	result *= compare_mat3x4((u), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((v.mA), ivec4(0, 0, 0, 0));
	result *= compare_uint16_t(uint(w), 0u);
	result *= compare_float16_t(float(x[0]), 0.0);
	result *= compare_float16_t(float(x[1]), 0.0);
	result *= compare_float16_t(float(x[2]), 0.0);
	result *= compare_float16_t(float(x[3]), 0.0);
	result *= compare_float16_t(float(x[4]), 0.0);
	result *= compare_mat4x2((y), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((z), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((aa[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((aa[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((aa[2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	int16_t mA; // unused in vertex shader
};
struct sB
{
	mediump uvec4 mA; // unused in fragment shader
	bvec4 mB;
	uint16_t mC;
};
struct sC
{
	mediump mat4x3 mA;
	mediump uint mB;
	i16vec3 mC;
};
layout(set = 0, binding = 4) uniform BlockF
{
	mediump uvec4 k;
	sB l; // unused in fragment shader
	u16vec4 m;
} blockF;
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	mediump ivec4 n; // unused in fragment shader
	sC o;
} blockG[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec4((blockF.k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockF.l.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((blockF.l.mB), bvec4(false, false, false, false));
	result *= compare_uint16_t(uint(blockF.l.mC), 0u);
	result *= compare_u16vec4(uvec4(blockF.m), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((blockG[0].n), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((blockG[0].o.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockG[0].o.mB), 0u);
	result *= compare_i16vec3(ivec3(blockG[0].o.mC), ivec3(0, 0, 0));
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
	lowp vec3 mA;
};
struct sB
{
	f16vec3 mA; // unused in vertex shader
	highp mat4x3 mB; // unused in vertex shader
	highp mat2 mC;
	i16vec3 mD;
};
struct sC
{
	mediump uvec3 mA;
	bvec4 mB; // unused in vertex shader
	bvec2 mC; // unused in both shaders
	lowp mat4x3 mD;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	lowp mat3x2 v;
};
layout(set = 0, binding = 7) uniform BlockI
{
	u16vec4 w;
	lowp float x; // unused in both shaders
	bool y;
	lowp mat3 z;
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_mat3x2((v), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(w), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float((x), 0.0);
	result *= compare_bool((y), false);
	result *= compare_mat3((z), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat3x2 mA;
};
struct sB
{
	highp ivec3 mA;
	highp vec4 mB;
};
struct sC
{
	u16vec3 mA;
};
struct sD
{
	highp mat3 mA;
};
struct sE
{
	i16vec2 mA;
};
struct sF
{
	mediump uvec4 mA; // unused in vertex shader
	sE mB; // unused in vertex shader
	lowp mat3 mC;
};
struct sG
{
	highp uvec3 mA;
	lowp mat3x4 mB;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	highp vec2 v;
	mediump uvec3 w;
	sD x;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	i16vec4 y;
	f16vec4 z;
	sF aa;
} blockH;
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	uint16_t ab[8];
	i16vec3 ac;
	highp ivec2 ad;
	sG ae; // unused in fragment shader
} blockI;
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	lowp mat3x4 af; // unused in vertex shader
	highp ivec2 ag; // unused in vertex shader
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((v), vec2(0.0, 0.0));
	result *= compare_uvec3((w), uvec3(0u, 0u, 0u));
	result *= compare_mat3((x.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockH.y), ivec4(0, 0, 0, 0));
	result *= compare_f16vec4(vec4(blockH.z), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockH.aa.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i16vec2(ivec2(blockH.aa.mB.mA), ivec2(0, 0));
	result *= compare_mat3((blockH.aa.mC), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint16_t(uint(blockI.ab[0]), 0u);
	result *= compare_uint16_t(uint(blockI.ab[1]), 0u);
	result *= compare_uint16_t(uint(blockI.ab[2]), 0u);
	result *= compare_uint16_t(uint(blockI.ab[3]), 0u);
	result *= compare_uint16_t(uint(blockI.ab[4]), 0u);
	result *= compare_uint16_t(uint(blockI.ab[5]), 0u);
	result *= compare_uint16_t(uint(blockI.ab[6]), 0u);
	result *= compare_uint16_t(uint(blockI.ab[7]), 0u);
	result *= compare_i16vec3(ivec3(blockI.ac), ivec3(0, 0, 0));
	result *= compare_ivec2((blockI.ad), ivec2(0, 0));
	result *= compare_uvec3((blockI.ae.mA), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockI.ae.mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockJ.af), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockJ.ag), ivec2(0, 0));
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
	bvec2 mA;
};
struct sB
{
	highp vec4 mA;
	lowp ivec2 mB;
	mediump uint mC;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	layout(offset = 64) bvec3 x; // unused in fragment shader
	layout(offset = 0) u16vec3 u;
	layout(offset = 32) lowp mat4x2 w;
	layout(offset = 16) lowp ivec3 v;
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 32) sB ac;
	layout(offset = 0) f16vec2 y; // unused in vertex shader
	layout(offset = 16) sA ab; // unused in vertex shader
	layout(offset = 4) f16vec2 z; // unused in vertex shader
	layout(offset = 8) lowp vec2 aa;
} blockH;
layout(set = 0, binding = 7, std140) uniform BlockI
{
	layout(offset = 176) bvec3 ah;
	layout(offset = 0) f16vec3 ad;
	layout(offset = 144) bvec4 ag[2]; // unused in vertex shader
	layout(offset = 8) lowp float ae;
	layout(offset = 16) lowp uvec3 af[8];
} blockI;
layout(set = 0, binding = 8, std140, column_major) uniform BlockJ
{
	layout(offset = 0) int16_t ai;
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(u), uvec3(0u, 0u, 0u));
	result *= compare_ivec3((v), ivec3(0, 0, 0));
	result *= compare_mat4x2((w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((x), bvec3(false, false, false));
	result *= compare_f16vec2(vec2(blockH.y), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(blockH.z), vec2(0.0, 0.0));
	result *= compare_vec2((blockH.aa), vec2(0.0, 0.0));
	result *= compare_bvec2((blockH.ab.mA), bvec2(false, false));
	result *= compare_vec4((blockH.ac.mA), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockH.ac.mB), ivec2(0, 0));
	result *= compare_uint((blockH.ac.mC), 0u);
	result *= compare_f16vec3(vec3(blockI.ad), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockI.ae), 0.0);
	result *= compare_uvec3((blockI.af[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockI.af[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockI.af[2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockI.af[3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockI.af[4]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockI.af[5]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockI.af[6]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockI.af[7]), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockI.ag[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockI.ag[1]), bvec4(false, false, false, false));
	result *= compare_bvec3((blockI.ah), bvec3(false, false, false));
	result *= compare_int16_t(int(blockJ.ai), 0);
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
	u16vec4 mA;
	i16vec3 mB;
	highp mat3 mC; // unused in vertex shader
	mediump mat4x3 mD; // unused in vertex shader
};
struct sB
{
	highp vec3 mA; // unused in fragment shader
	bool mB;
	u16vec3 mC;
	highp mat4x2 mD;
};
struct sC
{
	lowp int mA;
};
struct sD
{
	u16vec3 mA;
	highp uvec4 mB;
};
layout(set = 0, binding = 5, scalar, column_major) uniform BlockG
{
	layout(offset = 8) highp mat2x3 p;
	layout(offset = 0) mediump uvec2 o;
};
layout(set = 0, binding = 6, scalar) uniform BlockH
{
	layout(offset = 28) sD t[5]; // unused in vertex shader
	layout(offset = 0) sC q;
	layout(offset = 16) bvec3 s;
	layout(offset = 4) lowp vec3 r;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	layout(offset = 160) mediump mat3x2 y;
	layout(offset = 0) highp mat4 u;
	layout(offset = 144) lowp vec2 x;
	layout(offset = 64) f16vec3 v;
	layout(offset = 80) lowp mat4x2 w; // unused in vertex shader
};
layout(set = 0, binding = 8, std430) uniform BlockJ
{
	layout(offset = 0) lowp mat4x3 z; // unused in both shaders
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((o), uvec2(0u, 0u));
	result *= compare_mat2x3((p), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockH.q.mA), 0);
	result *= compare_vec3((blockH.r), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec3((blockH.s), bvec3(false, false, false));
	result *= compare_u16vec3(uvec3(blockH.t[0].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockH.t[0].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH.t[1].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockH.t[1].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH.t[2].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockH.t[2].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH.t[3].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockH.t[3].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH.t[4].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((blockH.t[4].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4((u), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(v), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((x), vec2(0.0, 0.0));
	result *= compare_mat3x2((y), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockJ.z), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	u16vec2 mB; // unused in vertex shader
	f16vec2 mC;
	f16vec4 mD;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	layout(offset = 16) highp mat3x2 v[1];
	layout(offset = 0) highp ivec3 u;
};
layout(set = 0, binding = 7, std430, column_major) uniform BlockI
{
	layout(offset = 0) highp uint w; // unused in vertex shader
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((u), ivec3(0, 0, 0));
	result *= compare_mat3x2((v[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockI.w), 0u);
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
	highp ivec2 mA; // unused in fragment shader
	lowp mat4x2 mB; // unused in vertex shader
	highp mat4x2 mC;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 0) mediump int r;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((blockG.r), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std430) uniform BlockG
{
	layout(offset = 48) lowp mat3x4 q[8]; // unused in fragment shader
	layout(offset = 0) mediump ivec4 n;
	layout(offset = 20) u16vec2 p[4]; // unused in both shaders
	layout(offset = 16) u16vec2 o; // unused in vertex shader
} blockG[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((blockG[0].n), ivec4(0, 0, 0, 0));
	result *= compare_u16vec2(uvec2(blockG[0].o), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(blockG[0].p[0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(blockG[0].p[1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(blockG[0].p[2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(blockG[0].p[3]), uvec2(0u, 0u));
	result *= compare_mat3x4((blockG[0].q[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].q[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].q[2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].q[3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].q[4]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].q[5]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].q[6]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG[0].q[7]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp int mA; // unused in vertex shader
};
struct sB
{
	bvec2 mA;
	highp ivec2 mB;
	f16vec4 mC;
	u16vec2 mD;
};
struct sC
{
	mediump int mA;
	mediump vec4 mB;
};
struct sD
{
	bvec4 mA;
	i16vec4 mB;
	mediump mat2 mC; // unused in fragment shader
	int16_t mD;
};
layout(set = 0, binding = 5, std430, column_major) uniform BlockG
{
	layout(offset = 32) mediump vec4 v; // unused in fragment shader
	layout(offset = 0) highp ivec3 r;
	layout(offset = 24) f16vec3 u;
	layout(offset = 12) mediump int s;
	layout(offset = 16) int16_t t;
};
layout(set = 0, binding = 6, std430, column_major) uniform BlockH
{
	layout(offset = 48) float16_t x; // unused in fragment shader
	layout(offset = 0) sD w;
};
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	layout(offset = 24) bool ab;
	layout(offset = 0) highp float y;
	layout(offset = 16) u16vec3 aa;
	layout(offset = 8) i16vec4 z; // unused in vertex shader
} blockI;
layout(set = 0, binding = 8, std430) uniform BlockJ
{
	layout(offset = 16) bvec3 ad; // unused in vertex shader
	layout(offset = 0) mediump ivec3 ac; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((r), ivec3(0, 0, 0));
	result *= compare_int((s), 0);
	result *= compare_int16_t(int(t), 0);
	result *= compare_f16vec3(vec3(u), vec3(0.0, 0.0, 0.0));
	result *= compare_vec4((v), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((w.mA), bvec4(false, false, false, false));
	result *= compare_i16vec4(ivec4(w.mB), ivec4(0, 0, 0, 0));
	result *= compare_mat2((w.mC), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(w.mD), 0);
	result *= compare_float16_t(float(x), 0.0);
	result *= compare_float((blockI.y), 0.0);
	result *= compare_i16vec4(ivec4(blockI.z), ivec4(0, 0, 0, 0));
	result *= compare_u16vec3(uvec3(blockI.aa), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockI.ab), false);
	result *= compare_ivec3((ac), ivec3(0, 0, 0));
	result *= compare_bvec3((ad), bvec3(false, false, false));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6) uniform BlockH
{
	lowp uvec2 v;
	bool w;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	lowp vec3 x;
	highp ivec4 y;
	lowp int z; // unused in vertex shader
} blockI;
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	i8vec4 aa;
	u8vec4 ab;
	bvec3 ac;
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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
	result *= compare_uvec2((blockH.v), uvec2(0u, 0u));
	result *= compare_bool((blockH.w), false);
	result *= compare_vec3((blockI.x), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec4((blockI.y), ivec4(0, 0, 0, 0));
	result *= compare_int((blockI.z), 0);
	result *= compare_i8vec4(ivec4(blockJ.aa), ivec4(0, 0, 0, 0));
	result *= compare_u8vec4(uvec4(blockJ.ab), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec3((blockJ.ac), bvec3(false, false, false));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140) uniform BlockG
{
	bvec3 u; // unused in fragment shader
	i8vec2 v;
	int8_t w;
	bvec4 x;
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	bvec3 y; // unused in fragment shader
	bool z; // unused in vertex shader
	mediump uvec2 aa;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((u), bvec3(false, false, false));
	result *= compare_i8vec2(ivec2(v), ivec2(0, 0));
	result *= compare_int8_t(int(w), 0);
	result *= compare_bvec4((x), bvec4(false, false, false, false));
	result *= compare_bvec3((blockH.y), bvec3(false, false, false));
	result *= compare_bool((blockH.z), false);
	result *= compare_uvec2((blockH.aa), uvec2(0u, 0u));
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
	mediump uvec4 a;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp vec4 b; // unused in both shaders
	mediump uvec4 c;
	u8vec4 d;
	mediump mat2x3 e;
	highp mat3 f;
};
layout(set = 0, binding = 2) uniform BlockD
{
	i8vec2 g; // unused in fragment shader
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	i8vec3 h; // unused in fragment shader
	bool i; // unused in fragment shader
	highp ivec3 j;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((a), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((e), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((f), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((j), ivec3(0, 0, 0));
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
	mediump uvec4 a;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp vec4 b; // unused in both shaders
	mediump uvec4 c;
	u8vec4 d;
	mediump mat2x3 e;
	highp mat3 f;
};
layout(set = 0, binding = 2) uniform BlockD
{
	i8vec2 g; // unused in fragment shader
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	i8vec3 h; // unused in fragment shader
	bool i; // unused in fragment shader
	highp ivec3 j;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec4((a), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((e), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((f), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(g), ivec2(0, 0));
	result *= compare_i8vec3(ivec3(h), ivec3(0, 0, 0));
	result *= compare_bool((i), false);
	result *= compare_ivec3((j), ivec3(0, 0, 0));
    v_vtxResult = result;
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
	lowp mat3x2 a;
	lowp uvec4 b;
	highp ivec2 c;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	i8vec4 d;
	mediump float e; // unused in fragment shader
	u8vec3 f;
	int8_t g; // unused in vertex shader
};
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	mediump ivec3 h; // unused in both shaders
	int8_t i;
} blockD;
layout(set = 0, binding = 3, std140) uniform BlockE
{
	mediump vec2 j; // unused in vertex shader
	highp vec3 k;
	highp uvec4 l;
	uint8_t m; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x2((blockB.a), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockB.b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((blockB.c), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(d), ivec4(0, 0, 0, 0));
	result *= compare_u8vec3(uvec3(f), uvec3(0u, 0u, 0u));
	result *= compare_int8_t(int(g), 0);
	result *= compare_int8_t(int(blockD.i), 0);
	result *= compare_vec2((blockE.j), vec2(0.0, 0.0));
	result *= compare_vec3((blockE.k), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec4((blockE.l), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint8_t(uint(blockE.m), 0u);
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
	lowp mat3x2 a;
	lowp uvec4 b;
	highp ivec2 c;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	i8vec4 d;
	mediump float e; // unused in fragment shader
	u8vec3 f;
	int8_t g; // unused in vertex shader
};
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	mediump ivec3 h; // unused in both shaders
	int8_t i;
} blockD;
layout(set = 0, binding = 3, std140) uniform BlockE
{
	mediump vec2 j; // unused in vertex shader
	highp vec3 k;
	highp uvec4 l;
	uint8_t m; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x2((blockB.a), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockB.b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((blockB.c), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(d), ivec4(0, 0, 0, 0));
	result *= compare_float((e), 0.0);
	result *= compare_u8vec3(uvec3(f), uvec3(0u, 0u, 0u));
	result *= compare_int8_t(int(blockD.i), 0);
	result *= compare_vec3((blockE.k), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec4((blockE.l), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 10, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6, std140) uniform BlockH
{
	int8_t w;
	lowp uint x[4];
	int8_t y;
	bvec3 z[5];
	lowp mat4x3 aa;
};
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	u8vec3 ab; // unused in fragment shader
	lowp ivec3 ac;
	mediump vec3 ad;
	bvec3 ae[7];
	highp ivec4 af;
} blockI;
layout(set = 0, binding = 8, row_major) uniform BlockJ
{
	bvec3 ag;
	lowp uint ah; // unused in fragment shader
};
layout(set = 0, binding = 9) uniform BlockK
{
	u8vec4 ai;
	i8vec2 aj;
	mediump float ak; // unused in vertex shader
	highp int al;
	highp vec4 am;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
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
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int8_t(int(w), 0);
	result *= compare_uint((x[0]), 0u);
	result *= compare_uint((x[1]), 0u);
	result *= compare_uint((x[2]), 0u);
	result *= compare_uint((x[3]), 0u);
	result *= compare_int8_t(int(y), 0);
	result *= compare_bvec3((z[0]), bvec3(false, false, false));
	result *= compare_bvec3((z[1]), bvec3(false, false, false));
	result *= compare_bvec3((z[2]), bvec3(false, false, false));
	result *= compare_bvec3((z[3]), bvec3(false, false, false));
	result *= compare_bvec3((z[4]), bvec3(false, false, false));
	result *= compare_mat4x3((aa), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockI.ab), uvec3(0u, 0u, 0u));
	result *= compare_ivec3((blockI.ac), ivec3(0, 0, 0));
	result *= compare_vec3((blockI.ad), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec3((blockI.ae[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockI.ae[1]), bvec3(false, false, false));
	result *= compare_bvec3((blockI.ae[2]), bvec3(false, false, false));
	result *= compare_bvec3((blockI.ae[3]), bvec3(false, false, false));
	result *= compare_bvec3((blockI.ae[4]), bvec3(false, false, false));
	result *= compare_bvec3((blockI.ae[5]), bvec3(false, false, false));
	result *= compare_bvec3((blockI.ae[6]), bvec3(false, false, false));
	result *= compare_ivec4((blockI.af), ivec4(0, 0, 0, 0));
	result *= compare_bvec3((ag), bvec3(false, false, false));
	result *= compare_uint((ah), 0u);
	result *= compare_u8vec4(uvec4(ai), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec2(ivec2(aj), ivec2(0, 0));
	result *= compare_float((ak), 0.0);
	result *= compare_int((al), 0);
	result *= compare_vec4((am), vec4(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, column_major) uniform BlockF
{
	highp uvec2 k; // unused in vertex shader
	bvec3 l; // unused in vertex shader
	lowp mat3x4 m;
	lowp mat3x4 n;
	highp vec2 o;
};
layout(set = 0, binding = 5) uniform BlockG
{
	mediump uvec3 p;
	u8vec4 q;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((k), uvec2(0u, 0u));
	result *= compare_bvec3((l), bvec3(false, false, false));
	result *= compare_mat3x4((m), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((n), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((o), vec2(0.0, 0.0));
	result *= compare_uvec3((p), uvec3(0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(q), uvec4(0u, 0u, 0u, 0u));
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
	i8vec2 a; // unused in vertex shader
	u8vec4 b;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	highp vec4 c;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	lowp int d; // unused in vertex shader
	u8vec3 e; // unused in vertex shader
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	lowp mat2 h;
	mediump ivec3 i;
	bvec2 j;
	u8vec4 k;
	highp ivec3 l; // unused in vertex shader
} blockF[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(a), ivec2(0, 0));
	result *= compare_u8vec4(uvec4(b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec4((blockC.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((d), 0);
	result *= compare_u8vec3(uvec3(e), uvec3(0u, 0u, 0u));
	result *= compare_mat2((blockF[0].h), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockF[0].i), ivec3(0, 0, 0));
	result *= compare_bvec2((blockF[0].j), bvec2(false, false));
	result *= compare_u8vec4(uvec4(blockF[0].k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec3((blockF[0].l), ivec3(0, 0, 0));
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
	i8vec2 a; // unused in vertex shader
	u8vec4 b;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	highp vec4 c;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	lowp int d; // unused in vertex shader
	u8vec3 e; // unused in vertex shader
};
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	mediump mat2x3 f;
	bool g; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec4((blockC.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((f), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((g), false);
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
	bvec3 mA;
	highp mat4x3 mB; // unused in vertex shader
};
struct sB
{
	sA mA;
};
struct sC
{
	bool mA;
	mediump vec2 mB;
};
struct sD
{
	mediump mat3x2 mA;
	mediump mat4x2 mB;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	bvec3 a; // unused in vertex shader
	highp vec2 b;
	mediump uvec3 c;
	i8vec2 d;
	lowp mat4x3 e;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	lowp mat3 f; // unused in both shaders
	highp mat3x2 g;
	mediump mat4x3 h; // unused in vertex shader
	highp mat4x3 i;
} blockC;
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	int8_t q;
	uint8_t r; // unused in vertex shader
	highp uint s;
	uint8_t t;
	sB u;
};
layout(set = 0, binding = 5) uniform BlockG
{
	highp uvec3 v;
	sC w;
	bvec3 x;
	lowp mat3 y;
	sD z;
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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec3((a), bvec3(false, false, false));
	result *= compare_vec2((b), vec2(0.0, 0.0));
	result *= compare_uvec3((c), uvec3(0u, 0u, 0u));
	result *= compare_i8vec2(ivec2(d), ivec2(0, 0));
	result *= compare_mat4x3((e), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.g), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockC.h), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockC.i), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(q), 0);
	result *= compare_uint8_t(uint(r), 0u);
	result *= compare_uint((s), 0u);
	result *= compare_uint8_t(uint(t), 0u);
	result *= compare_bvec3((u.mA.mA), bvec3(false, false, false));
	result *= compare_mat4x3((u.mA.mB), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((v), uvec3(0u, 0u, 0u));
	result *= compare_bool((w.mA), false);
	result *= compare_vec2((w.mB), vec2(0.0, 0.0));
	result *= compare_bvec3((x), bvec3(false, false, false));
	result *= compare_mat3((y), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((z.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((z.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat4x3 mB; // unused in vertex shader
};
struct sB
{
	sA mA;
};
struct sC
{
	bool mA;
	mediump vec2 mB;
};
struct sD
{
	mediump mat3x2 mA;
	mediump mat4x2 mB;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	bvec3 a; // unused in vertex shader
	highp vec2 b;
	mediump uvec3 c;
	i8vec2 d;
	lowp mat4x3 e;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	lowp mat3 f; // unused in both shaders
	highp mat3x2 g;
	mediump mat4x3 h; // unused in vertex shader
	highp mat4x3 i;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	mediump mat2x3 j; // unused in vertex shader
	bvec2 k; // unused in vertex shader
	uint8_t l;
	lowp int m;
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	highp mat3x4 n;
	lowp uvec4 o; // unused in both shaders
	mediump mat4x3 p;
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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2((b), vec2(0.0, 0.0));
	result *= compare_uvec3((c), uvec3(0u, 0u, 0u));
	result *= compare_i8vec2(ivec2(d), ivec2(0, 0));
	result *= compare_mat4x3((e), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.g), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockC.i), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(l), 0u);
	result *= compare_int((m), 0);
	result *= compare_mat3x4((n), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((p), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump vec3 mA;
};
struct sB
{
	i8vec2 mA; // unused in fragment shader
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	int8_t l;
	uint8_t m;
	u8vec3 n;
	lowp float o;
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	lowp ivec3 p;
} blockH;
layout(set = 0, binding = 7, std140) uniform BlockI
{
	lowp int q; // unused in vertex shader
	lowp vec2 r;
	highp vec3 s; // unused in both shaders
	sA t;
	sB u;
} blockI;
layout(set = 0, binding = 8, column_major) uniform BlockJ
{
	u8vec2 v;
	i8vec4 w;
	mediump mat3x4 x;
	highp vec3 y; // unused in vertex shader
	mediump mat4x3 z;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_int8_t(int(l), 0);
	result *= compare_uint8_t(uint(m), 0u);
	result *= compare_u8vec3(uvec3(n), uvec3(0u, 0u, 0u));
	result *= compare_float((o), 0.0);
	result *= compare_ivec3((blockH.p), ivec3(0, 0, 0));
	result *= compare_int((blockI.q), 0);
	result *= compare_vec2((blockI.r), vec2(0.0, 0.0));
	result *= compare_vec3((blockI.s), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockI.u.mA), ivec2(0, 0));
	result *= compare_u8vec2(uvec2(v), uvec2(0u, 0u));
	result *= compare_i8vec4(ivec4(w), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((x), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((y), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x3((z), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp ivec4 mA;
	mediump mat3 mB;
	mediump mat4x3 mC;
	mediump ivec2 mD[7];
};
struct sB
{
	lowp ivec2 mA;
	lowp mat2x3 mB;
	highp mat3x4 mC;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	mediump mat4 a;
	mediump mat4 b;
} blockB;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	u8vec2 e;
	bvec3 f;
	u8vec4 g;
	bool h;
};
layout(set = 0, binding = 3) uniform BlockE
{
	uint8_t i;
	lowp mat4 j;
} blockE;
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	bvec4 k;
	mediump float l;
	sB m; // unused in vertex shader
	highp mat4x3 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((blockB.a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB.b), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec2(uvec2(e), uvec2(0u, 0u));
	result *= compare_bvec3((f), bvec3(false, false, false));
	result *= compare_u8vec4(uvec4(g), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bool((h), false);
	result *= compare_uint8_t(uint(blockE.i), 0u);
	result *= compare_mat4((blockE.j), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((k), bvec4(false, false, false, false));
	result *= compare_float((l), 0.0);
	result *= compare_ivec2((m.mA), ivec2(0, 0));
	result *= compare_mat2x3((m.mB), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((m.mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((n), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp ivec4 mA;
	mediump mat3 mB;
	mediump mat4x3 mC;
	mediump ivec2 mD[7];
};
struct sB
{
	lowp ivec2 mA;
	lowp mat2x3 mB;
	highp mat3x4 mC;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	mediump mat4 a;
	mediump mat4 b;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	sA c;
	i8vec4 d;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((blockB.a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB.b), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((c.mA), ivec4(0, 0, 0, 0));
	result *= compare_mat3((c.mB), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((c.mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((c.mD[0]), ivec2(0, 0));
	result *= compare_ivec2((c.mD[1]), ivec2(0, 0));
	result *= compare_ivec2((c.mD[2]), ivec2(0, 0));
	result *= compare_ivec2((c.mD[3]), ivec2(0, 0));
	result *= compare_ivec2((c.mD[4]), ivec2(0, 0));
	result *= compare_ivec2((c.mD[5]), ivec2(0, 0));
	result *= compare_ivec2((c.mD[6]), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(d), ivec4(0, 0, 0, 0));
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
	mediump ivec3 a;
	highp uvec4 b; // unused in fragment shader
	mediump mat3x2 c;
	highp ivec4 d;
} blockB;
layout(set = 0, binding = 2) uniform BlockD
{
	highp vec3 h; // unused in fragment shader
	mediump mat4x2 i; // unused in vertex shader
	bvec3 j; // unused in both shaders
	i8vec3 k;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp ivec2 l;
	lowp vec3 m;
	highp vec3 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockB.c), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockB.d), ivec4(0, 0, 0, 0));
	result *= compare_mat4x2((blockD.i), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockD.k), ivec3(0, 0, 0));
	result *= compare_ivec2((l), ivec2(0, 0));
	result *= compare_vec3((m), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((n), vec3(0.0, 0.0, 0.0));
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
	mediump ivec3 a;
	highp uvec4 b; // unused in fragment shader
	mediump mat3x2 c;
	highp ivec4 d;
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	highp mat2 e;
	mediump ivec3 f;
	bool g;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_uvec4((blockB.b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x2((blockB.c), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockB.d), ivec4(0, 0, 0, 0));
	result *= compare_mat2((e), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((f), ivec3(0, 0, 0));
	result *= compare_bool((g), false);
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
	i8vec3 a; // unused in vertex shader
	highp mat3 b;
	lowp vec4 c; // unused in vertex shader
};
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	highp ivec2 d; // unused in vertex shader
	mediump mat2 e; // unused in vertex shader
	bvec2 f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp mat4 g; // unused in vertex shader
	lowp ivec2 h; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	lowp uvec2 i; // unused in fragment shader
	u8vec3 j;
	highp mat3x4 k;
	mediump mat3x2 l;
	lowp vec3 m;
} blockE[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(a), ivec3(0, 0, 0));
	result *= compare_mat3((b), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC.d), ivec2(0, 0));
	result *= compare_mat2((blockC.e), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockC.f), bvec2(false, false));
	result *= compare_mat4((blockD.g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockD.h), ivec2(0, 0));
	result *= compare_u8vec3(uvec3(blockE[0].j), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockE[0].k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE[0].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[0].m), vec3(0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockE[1].j), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockE[1].k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE[1].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[1].m), vec3(0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockE[2].j), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockE[2].k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE[2].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[2].m), vec3(0.0, 0.0, 0.0));
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
	i8vec3 a; // unused in vertex shader
	highp mat3 b;
	lowp vec4 c; // unused in vertex shader
};
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	highp ivec2 d; // unused in vertex shader
	mediump mat2 e; // unused in vertex shader
	bvec2 f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp mat4 g; // unused in vertex shader
	lowp ivec2 h; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	lowp uvec2 i; // unused in fragment shader
	u8vec3 j;
	highp mat3x4 k;
	mediump mat3x2 l;
	lowp vec3 m;
} blockE[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((b), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE[0].i), uvec2(0u, 0u));
	result *= compare_u8vec3(uvec3(blockE[0].j), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockE[0].k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE[0].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[0].m), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE[1].i), uvec2(0u, 0u));
	result *= compare_u8vec3(uvec3(blockE[1].j), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockE[1].k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE[1].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[1].m), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE[2].i), uvec2(0u, 0u));
	result *= compare_u8vec3(uvec3(blockE[2].j), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockE[2].k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockE[2].l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[2].m), vec3(0.0, 0.0, 0.0));
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
	lowp ivec4 mA;
	mediump ivec4 mB;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	highp mat2x3 r[3];
	highp mat4x3 s;
	i8vec2 t;
	bvec2 u;
	highp mat2x3 v;
} blockG[1];
layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp ivec3 w;
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	lowp mat4x3 x;
	highp ivec3 y;
	sA z;
	highp uvec3 aa; // unused in both shaders
};
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	lowp ivec4 ab;
	highp int ac;
	u8vec2 ad[8];
	lowp mat3x4 ae; // unused in fragment shader
} blockJ[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((blockG[0].r[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[0].r[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[0].r[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[0].s), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockG[0].t), ivec2(0, 0));
	result *= compare_bvec2((blockG[0].u), bvec2(false, false));
	result *= compare_mat2x3((blockG[0].v), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH.w), ivec3(0, 0, 0));
	result *= compare_mat4x3((x), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((y), ivec3(0, 0, 0));
	result *= compare_ivec4((z.mA), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((z.mB), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((aa), uvec3(0u, 0u, 0u));
	result *= compare_ivec4((blockJ[0].ab), ivec4(0, 0, 0, 0));
	result *= compare_int((blockJ[0].ac), 0);
	result *= compare_u8vec2(uvec2(blockJ[0].ad[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[0].ad[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[0].ad[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[0].ad[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[0].ad[4]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[0].ad[5]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[0].ad[6]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[0].ad[7]), uvec2(0u, 0u));
	result *= compare_mat3x4((blockJ[0].ae), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockJ[1].ab), ivec4(0, 0, 0, 0));
	result *= compare_int((blockJ[1].ac), 0);
	result *= compare_u8vec2(uvec2(blockJ[1].ad[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[1].ad[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[1].ad[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[1].ad[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[1].ad[4]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[1].ad[5]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[1].ad[6]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[1].ad[7]), uvec2(0u, 0u));
	result *= compare_mat3x4((blockJ[1].ae), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockJ[2].ab), ivec4(0, 0, 0, 0));
	result *= compare_int((blockJ[2].ac), 0);
	result *= compare_u8vec2(uvec2(blockJ[2].ad[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[2].ad[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[2].ad[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[2].ad[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[2].ad[4]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[2].ad[5]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[2].ad[6]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(blockJ[2].ad[7]), uvec2(0u, 0u));
	result *= compare_mat3x4((blockJ[2].ae), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp uvec3 mA;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	bvec4 n; // unused in both shaders
	u8vec4 o;
} blockG;
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	highp mat2x3 p;
	lowp uvec4 q; // unused in vertex shader
	sA r;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((blockG.n), bvec4(false, false, false, false));
	result *= compare_u8vec4(uvec4(blockG.o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((blockH.p), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockH.q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec3((blockH.r.mA), uvec3(0u, 0u, 0u));
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
	highp uvec3 mA; // unused in vertex shader
	mediump float mB;
};
struct sB
{
	lowp mat4 mA;
	bvec2 mB;
	sA mC;
	mediump uvec2 mD;
};
struct sC
{
	mediump ivec3 mA; // unused in vertex shader
	highp mat2 mB;
	highp mat4x3 mC;
};
struct sD
{
	mediump mat3x2 mA;
	bvec2 mB[3];
};
struct sE
{
	lowp ivec4 mA; // unused in vertex shader
	highp mat3 mB;
	sD mC;
	i8vec2 mD[8];
};
struct sF
{
	i8vec4 mA;
};
struct sG
{
	bvec4 mA[5];
	mediump mat4 mB[7];
};
struct sH
{
	mediump mat4 mA; // unused in fragment shader
	lowp uvec4 mB; // unused in fragment shader
	sG mC;
	i8vec3 mD; // unused in fragment shader
};
struct sI
{
	bvec3 mA[7];
	bool mB;
	mediump float mC; // unused in fragment shader
};
layout(set = 0, binding = 4) uniform BlockF
{
	sH o;
	sI p[1];
	mediump uvec2 q; // unused in fragment shader
	highp ivec2 r;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	highp vec4 s;
	highp uvec3 t;
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
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
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
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4((o.mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((o.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((o.mC.mA[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((o.mC.mA[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((o.mC.mA[2]), bvec4(false, false, false, false));
	result *= compare_bvec4((o.mC.mA[3]), bvec4(false, false, false, false));
	result *= compare_bvec4((o.mC.mA[4]), bvec4(false, false, false, false));
	result *= compare_mat4((o.mC.mB[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((o.mC.mB[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((o.mC.mB[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((o.mC.mB[3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((o.mC.mB[4]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((o.mC.mB[5]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((o.mC.mB[6]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(o.mD), ivec3(0, 0, 0));
	result *= compare_bvec3((p[0].mA[0]), bvec3(false, false, false));
	result *= compare_bvec3((p[0].mA[1]), bvec3(false, false, false));
	result *= compare_bvec3((p[0].mA[2]), bvec3(false, false, false));
	result *= compare_bvec3((p[0].mA[3]), bvec3(false, false, false));
	result *= compare_bvec3((p[0].mA[4]), bvec3(false, false, false));
	result *= compare_bvec3((p[0].mA[5]), bvec3(false, false, false));
	result *= compare_bvec3((p[0].mA[6]), bvec3(false, false, false));
	result *= compare_bool((p[0].mB), false);
	result *= compare_float((p[0].mC), 0.0);
	result *= compare_uvec2((q), uvec2(0u, 0u));
	result *= compare_ivec2((r), ivec2(0, 0));
	result *= compare_vec4((blockG.s), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockG.t), uvec3(0u, 0u, 0u));
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
	u8vec3 mA[2];
	highp mat3 mB;
};
struct sB
{
	bvec3 mA;
	lowp uvec3 mB;
};
struct sC
{
	i8vec4 mA;
	i8vec3 mB; // unused in fragment shader
};
struct sD
{
	uint8_t mA; // unused in fragment shader
	highp mat2 mB;
};
struct sE
{
	highp uvec4 mA;
	mediump uint mB; // unused in fragment shader
	i8vec3 mC;
};
struct sF
{
	mediump int mA; // unused in vertex shader
	highp mat4x2 mB; // unused in vertex shader
};
struct sG
{
	mediump uvec3 mA; // unused in vertex shader
	highp int mB[2]; // unused in vertex shader
	highp vec3 mC; // unused in vertex shader
	sF mD;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp vec4 r;
} blockG[1];
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	sC s;
	uint8_t t;
	mediump mat4 u;
	sD v;
} blockH[3];
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	u8vec2 w;
	sE x; // unused in fragment shader
	lowp ivec2 y; // unused in fragment shader
	sG z[3];
	lowp ivec2 aa; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((blockG[0].r), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockH[0].s.mA), ivec4(0, 0, 0, 0));
	result *= compare_i8vec3(ivec3(blockH[0].s.mB), ivec3(0, 0, 0));
	result *= compare_uint8_t(uint(blockH[0].t), 0u);
	result *= compare_mat4((blockH[0].u), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(blockH[0].v.mA), 0u);
	result *= compare_mat2((blockH[0].v.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockH[1].s.mA), ivec4(0, 0, 0, 0));
	result *= compare_i8vec3(ivec3(blockH[1].s.mB), ivec3(0, 0, 0));
	result *= compare_uint8_t(uint(blockH[1].t), 0u);
	result *= compare_mat4((blockH[1].u), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(blockH[1].v.mA), 0u);
	result *= compare_mat2((blockH[1].v.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockH[2].s.mA), ivec4(0, 0, 0, 0));
	result *= compare_i8vec3(ivec3(blockH[2].s.mB), ivec3(0, 0, 0));
	result *= compare_uint8_t(uint(blockH[2].t), 0u);
	result *= compare_mat4((blockH[2].u), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(blockH[2].v.mA), 0u);
	result *= compare_mat2((blockH[2].v.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec2(uvec2(w), uvec2(0u, 0u));
	result *= compare_uvec4((x.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((x.mB), 0u);
	result *= compare_i8vec3(ivec3(x.mC), ivec3(0, 0, 0));
	result *= compare_ivec2((y), ivec2(0, 0));
	result *= compare_uvec3((z[0].mA), uvec3(0u, 0u, 0u));
	result *= compare_int((z[0].mB[0]), 0);
	result *= compare_int((z[0].mB[1]), 0);
	result *= compare_vec3((z[0].mC), vec3(0.0, 0.0, 0.0));
	result *= compare_int((z[0].mD.mA), 0);
	result *= compare_mat4x2((z[0].mD.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[1].mA), uvec3(0u, 0u, 0u));
	result *= compare_int((z[1].mB[0]), 0);
	result *= compare_int((z[1].mB[1]), 0);
	result *= compare_vec3((z[1].mC), vec3(0.0, 0.0, 0.0));
	result *= compare_int((z[1].mD.mA), 0);
	result *= compare_mat4x2((z[1].mD.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((z[2].mA), uvec3(0u, 0u, 0u));
	result *= compare_int((z[2].mB[0]), 0);
	result *= compare_int((z[2].mB[1]), 0);
	result *= compare_vec3((z[2].mC), vec3(0.0, 0.0, 0.0));
	result *= compare_int((z[2].mD.mA), 0);
	result *= compare_mat4x2((z[2].mD.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((aa), ivec2(0, 0));
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
	highp mat3 mA;
};
struct sB
{
	u8vec3 mA;
	highp uvec4 mB; // unused in fragment shader
	lowp mat4x3 mC; // unused in vertex shader
};
struct sC
{
	bvec3 mA;
	highp mat3 mB;
	highp int mC;
	mediump ivec4 mD;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	mediump uvec4 o;
	bvec4 p;
	lowp ivec4 q;
} blockG[1];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	sA r;
	sB s[3];
	lowp mat3x4 t;
	lowp vec3 u;
};
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	sC v;
	highp mat4 w;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec4((blockG[0].o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((blockG[0].p), bvec4(false, false, false, false));
	result *= compare_ivec4((blockG[0].q), ivec4(0, 0, 0, 0));
	result *= compare_mat3((r.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(s[0].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((s[0].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x3((s[0].mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(s[1].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((s[1].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x3((s[1].mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(s[2].mA), uvec3(0u, 0u, 0u));
	result *= compare_uvec4((s[2].mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x3((s[2].mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((t), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((u), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec3((blockI.v.mA), bvec3(false, false, false));
	result *= compare_mat3((blockI.v.mB), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockI.v.mC), 0);
	result *= compare_ivec4((blockI.v.mD), ivec4(0, 0, 0, 0));
	result *= compare_mat4((blockI.w), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump vec4 mA;
	i8vec2 mB;
	i8vec4 mC; // unused in fragment shader
};
struct sB
{
	mediump float mA;
};
struct sC
{
	sA mA; // unused in vertex shader
	sB mB;
	lowp uvec2 mC;
	u8vec3 mD;
};
struct sD
{
	lowp mat3x4 mA; // unused in vertex shader
	mediump vec4 mB;
};
struct sE
{
	sD mA; // unused in vertex shader
	mediump vec2 mB; // unused in vertex shader
	mediump mat2 mC;
	lowp mat3x2 mD;
};
struct sF
{
	lowp ivec3 mA; // unused in vertex shader
	lowp mat3x4 mB; // unused in vertex shader
	highp mat2x3 mC[1];
};
struct sG
{
	sF mA[6];
	mediump mat4x3 mB[5][1]; // unused in vertex shader
	bvec3 mC;
	i8vec4 mD;
};
struct sH
{
	bvec3 mA;
	lowp float mB[4];
	mediump vec3 mC[2];
	mediump mat4x2 mD;
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	bvec4 q;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	bvec4 r;
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	uint8_t s[8];
	lowp uvec4 t;
	i8vec4 u; // unused in fragment shader
	sH v;
} blockH;
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	lowp mat4 w;
	highp mat4x3 x;
	highp mat4x3 y; // unused in vertex shader
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((q), bvec4(false, false, false, false));
	result *= compare_bvec4((r), bvec4(false, false, false, false));
	result *= compare_uint8_t(uint(blockH.s[0]), 0u);
	result *= compare_uint8_t(uint(blockH.s[1]), 0u);
	result *= compare_uint8_t(uint(blockH.s[2]), 0u);
	result *= compare_uint8_t(uint(blockH.s[3]), 0u);
	result *= compare_uint8_t(uint(blockH.s[4]), 0u);
	result *= compare_uint8_t(uint(blockH.s[5]), 0u);
	result *= compare_uint8_t(uint(blockH.s[6]), 0u);
	result *= compare_uint8_t(uint(blockH.s[7]), 0u);
	result *= compare_uvec4((blockH.t), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec4(ivec4(blockH.u), ivec4(0, 0, 0, 0));
	result *= compare_bvec3((blockH.v.mA), bvec3(false, false, false));
	result *= compare_float((blockH.v.mB[0]), 0.0);
	result *= compare_float((blockH.v.mB[1]), 0.0);
	result *= compare_float((blockH.v.mB[2]), 0.0);
	result *= compare_float((blockH.v.mB[3]), 0.0);
	result *= compare_vec3((blockH.v.mC[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockH.v.mC[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH.v.mD), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((w), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((x), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((y), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat3 mA;
	lowp uvec4 mB; // unused in vertex shader
	mediump vec4 mC;
	bool mD; // unused in fragment shader
};
struct sB
{
	i8vec4 mA;
	lowp uvec2 mB;
	highp ivec2 mC; // unused in fragment shader
};
struct sC
{
	lowp ivec4 mA;
	bvec3 mB;
	mediump mat3x4 mC;
};
layout(set = 0, binding = 7) uniform BlockI
{
	sC x;
	mediump mat4x2 y[6];
	i8vec4 z;
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
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((blockI.x.mA), ivec4(0, 0, 0, 0));
	result *= compare_bvec3((blockI.x.mB), bvec3(false, false, false));
	result *= compare_mat3x4((blockI.x.mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI.y[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI.y[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI.y[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI.y[3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI.y[4]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI.y[5]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockI.z), ivec4(0, 0, 0, 0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6) uniform BlockH
{
	highp ivec2 q;
	mediump mat2x3 r[5];
	int8_t s; // unused in fragment shader
	mediump mat3x4 t;
	bvec2 u;
} blockH[3];
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	lowp vec2 v;
	int8_t w;
	i8vec2 x;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((blockH[0].q), ivec2(0, 0));
	result *= compare_mat2x3((blockH[0].r[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[0].r[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[0].r[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[0].r[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[0].r[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(blockH[0].s), 0);
	result *= compare_mat3x4((blockH[0].t), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH[0].u), bvec2(false, false));
	result *= compare_ivec2((blockH[1].q), ivec2(0, 0));
	result *= compare_mat2x3((blockH[1].r[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[1].r[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[1].r[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[1].r[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[1].r[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(blockH[1].s), 0);
	result *= compare_mat3x4((blockH[1].t), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH[1].u), bvec2(false, false));
	result *= compare_ivec2((blockH[2].q), ivec2(0, 0));
	result *= compare_mat2x3((blockH[2].r[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[2].r[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[2].r[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[2].r[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH[2].r[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(blockH[2].s), 0);
	result *= compare_mat3x4((blockH[2].t), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH[2].u), bvec2(false, false));
	result *= compare_vec2((v), vec2(0.0, 0.0));
	result *= compare_int8_t(int(w), 0);
	result *= compare_i8vec2(ivec2(x), ivec2(0, 0));
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
	lowp uvec4 mA; // unused in fragment shader
};
struct sB
{
	u8vec4 mA;
	i8vec3 mB;
	bvec2 mC;
	u8vec2 mD;
};
struct sC
{
	i8vec3 mA; // unused in fragment shader
	highp mat2 mB;
	i8vec2 mC[4];
};
struct sD
{
	sB mA;
	highp vec2 mB; // unused in vertex shader
	sC mC; // unused in vertex shader
	highp float mD;
};
struct sE
{
	int8_t mA; // unused in fragment shader
};
layout(set = 0, binding = 5) uniform BlockG
{
	mediump vec4 j;
	highp mat3 k;
	sE l;
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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((k), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(l.mA), 0);
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
	uint8_t mA;
};
struct sB
{
	highp mat2x3 mA;
};
layout(set = 0, binding = 4) uniform BlockF
{
	layout(offset = 112) sB s;
	layout(offset = 0) lowp mat4x2 p; // unused in fragment shader
	layout(offset = 96) u8vec3 r; // unused in fragment shader
	layout(offset = 64) mediump mat2 q;
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	layout(offset = 144) highp mat3 x;
	layout(offset = 0) mediump mat4x2 t;
	layout(offset = 96) bvec2 w[3];
	layout(offset = 64) lowp int u;
	layout(offset = 80) lowp uvec3 v;
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	layout(offset = 144) highp vec3 ac; // unused in vertex shader
	layout(offset = 0) highp mat4 y;
	layout(offset = 128) bvec3 ab;
	layout(offset = 64) mediump mat3x2 z;
	layout(offset = 112) u8vec4 aa;
} blockH;
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	layout(offset = 0) u8vec3 ad;
} blockI[3];

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
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((blockF.p), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockF.q), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockF.r), uvec3(0u, 0u, 0u));
	result *= compare_mat2x3((blockF.s.mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((u), 0);
	result *= compare_uvec3((v), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((w[0]), bvec2(false, false));
	result *= compare_bvec2((w[1]), bvec2(false, false));
	result *= compare_bvec2((w[2]), bvec2(false, false));
	result *= compare_mat3((x), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockH.y), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH.z), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(blockH.aa), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec3((blockH.ab), bvec3(false, false, false));
	result *= compare_vec3((blockH.ac), vec3(0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockI[0].ad), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockI[1].ad), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockI[2].ad), uvec3(0u, 0u, 0u));
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
	lowp float mA[1];
};
struct sB
{
	highp mat4x3 mA;
	mediump int mB;
	bool mC; // unused in fragment shader
	uint8_t mD;
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	layout(offset = 0) mediump mat2x3 j;
} blockF[1];
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 32) mediump uvec2 l; // unused in vertex shader
	layout(offset = 0) mediump ivec3 k[2];
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 112) i8vec3 o;
	layout(offset = 0) bvec3 m[6];
	layout(offset = 96) lowp ivec4 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((blockF[0].j), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG.k[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockG.k[1]), ivec3(0, 0, 0));
	result *= compare_uvec2((blockG.l), uvec2(0u, 0u));
	result *= compare_bvec3((m[0]), bvec3(false, false, false));
	result *= compare_bvec3((m[1]), bvec3(false, false, false));
	result *= compare_bvec3((m[2]), bvec3(false, false, false));
	result *= compare_bvec3((m[3]), bvec3(false, false, false));
	result *= compare_bvec3((m[4]), bvec3(false, false, false));
	result *= compare_bvec3((m[5]), bvec3(false, false, false));
	result *= compare_ivec4((n), ivec4(0, 0, 0, 0));
	result *= compare_i8vec3(ivec3(o), ivec3(0, 0, 0));
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
	highp uvec3 mA;
	highp mat4x2 mB;
};
struct sB
{
	sA mA; // unused in vertex shader
};
struct sC
{
	u8vec4 mA;
	highp uvec4 mB;
};
struct sD
{
	i8vec4 mA;
	sC mB;
};
struct sE
{
	bvec3 mA; // unused in fragment shader
};
struct sF
{
	uint8_t mA;
	highp ivec3 mB; // unused in vertex shader
	highp float mC; // unused in vertex shader
};
struct sG
{
	mediump uvec2 mA;
	highp uvec4 mB;
	u8vec2 mC;
	mediump mat3x4 mD; // unused in fragment shader
};
struct sH
{
	bvec4 mA;
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	layout(offset = 48) sH s; // unused in vertex shader
	layout(offset = 0) mediump mat3x4 r;
};
layout(set = 0, binding = 7) uniform BlockI
{
	layout(offset = 12) i8vec3 v;
	layout(offset = 0) lowp vec2 t;
	layout(offset = 8) u8vec3 u;
};
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	layout(offset = 32) i8vec3 aa;
	layout(offset = 0) i8vec4 w;
	layout(offset = 28) u8vec2 z;
	layout(offset = 8) mediump ivec2 x; // unused in vertex shader
	layout(offset = 16) bvec3 y;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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
	result *= compare_bvec4((s.mA), bvec4(false, false, false, false));
	result *= compare_vec2((t), vec2(0.0, 0.0));
	result *= compare_u8vec3(uvec3(u), uvec3(0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(v), ivec3(0, 0, 0));
	result *= compare_i8vec4(ivec4(w), ivec4(0, 0, 0, 0));
	result *= compare_ivec2((x), ivec2(0, 0));
	result *= compare_bvec3((y), bvec3(false, false, false));
	result *= compare_u8vec2(uvec2(z), uvec2(0u, 0u));
	result *= compare_i8vec3(ivec3(aa), ivec3(0, 0, 0));
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
	uint8_t mA;
	u8vec4 mB;
	mediump vec3 mC[3]; // unused in vertex shader
};
struct sB
{
	i8vec3 mA;
	int8_t mB;
	bool mC;
};
struct sC
{
	highp vec3 mA;
	sB mB;
	mediump uvec3 mC; // unused in fragment shader
};
layout(set = 0, binding = 5, std430, row_major) uniform BlockG
{
	layout(offset = 14) i8vec2 k;
	layout(offset = 0) i8vec4 g; // unused in fragment shader
	layout(offset = 12) i8vec2 j; // unused in fragment shader
	layout(offset = 4) mediump float h;
	layout(offset = 8) u8vec4 i;
} blockG[1];
layout(set = 0, binding = 6, std430, column_major) uniform BlockH
{
	layout(offset = 32) highp uvec3 o; // unused in vertex shader
	layout(offset = 0) u8vec3 l; // unused in fragment shader
	layout(offset = 16) lowp vec3 n;
	layout(offset = 8) bvec2 m;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
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
	result *= compare_i8vec4(ivec4(blockG[0].g), ivec4(0, 0, 0, 0));
	result *= compare_float((blockG[0].h), 0.0);
	result *= compare_u8vec4(uvec4(blockG[0].i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec2(ivec2(blockG[0].j), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(blockG[0].k), ivec2(0, 0));
	result *= compare_u8vec3(uvec3(blockH.l), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((blockH.m), bvec2(false, false));
	result *= compare_vec3((blockH.n), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockH.o), uvec3(0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
