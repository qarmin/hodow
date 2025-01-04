#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec4 var[3][4];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, std140) uniform Block
{
	uint16_t var[3][4];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0][0]), 0u);
	result *= compare_uint16_t(uint(var[0][1]), 0u);
	result *= compare_uint16_t(uint(var[0][2]), 0u);
	result *= compare_uint16_t(uint(var[0][3]), 0u);
	result *= compare_uint16_t(uint(var[1][0]), 0u);
	result *= compare_uint16_t(uint(var[1][1]), 0u);
	result *= compare_uint16_t(uint(var[1][2]), 0u);
	result *= compare_uint16_t(uint(var[1][3]), 0u);
	result *= compare_uint16_t(uint(var[2][0]), 0u);
	result *= compare_uint16_t(uint(var[2][1]), 0u);
	result *= compare_uint16_t(uint(var[2][2]), 0u);
	result *= compare_uint16_t(uint(var[2][3]), 0u);
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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
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
	highp vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat2x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec2 var[3][4];
};

mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	i8vec3 var[3][4];
};

mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(var[0][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][2]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[0][3]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][2]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1][3]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][2]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2][3]), ivec3(0, 0, 0));
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;


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
	float padding;
	highp float var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_float((var[0][0]), 0.0);
	result *= compare_float((var[0][1]), 0.0);
	result *= compare_float((var[0][2]), 0.0);
	result *= compare_float((var[0][3]), 0.0);
	result *= compare_float((var[1][0]), 0.0);
	result *= compare_float((var[1][1]), 0.0);
	result *= compare_float((var[1][2]), 0.0);
	result *= compare_float((var[1][3]), 0.0);
	result *= compare_float((var[2][0]), 0.0);
	result *= compare_float((var[2][1]), 0.0);
	result *= compare_float((var[2][2]), 0.0);
	result *= compare_float((var[2][3]), 0.0);
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
	highp vec2 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
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
	highp uvec2 var[3][4];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec2((var[0][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][2]), uvec2(0u, 0u));
	result *= compare_uvec2((var[0][3]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][2]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1][3]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][2]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2][3]), uvec2(0u, 0u));
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
	result *= compare_uint((padding), 0u);
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


mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
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
	result *= compare_float((padding), 0.0);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat2x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat3x4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	uint16_t var[3][4];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0][0]), 0u);
	result *= compare_uint16_t(uint(var[0][1]), 0u);
	result *= compare_uint16_t(uint(var[0][2]), 0u);
	result *= compare_uint16_t(uint(var[0][3]), 0u);
	result *= compare_uint16_t(uint(var[1][0]), 0u);
	result *= compare_uint16_t(uint(var[1][1]), 0u);
	result *= compare_uint16_t(uint(var[1][2]), 0u);
	result *= compare_uint16_t(uint(var[1][3]), 0u);
	result *= compare_uint16_t(uint(var[2][0]), 0u);
	result *= compare_uint16_t(uint(var[2][1]), 0u);
	result *= compare_uint16_t(uint(var[2][2]), 0u);
	result *= compare_uint16_t(uint(var[2][3]), 0u);
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
	uint16_t var[3][4];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0][0]), 0u);
	result *= compare_uint16_t(uint(var[0][1]), 0u);
	result *= compare_uint16_t(uint(var[0][2]), 0u);
	result *= compare_uint16_t(uint(var[0][3]), 0u);
	result *= compare_uint16_t(uint(var[1][0]), 0u);
	result *= compare_uint16_t(uint(var[1][1]), 0u);
	result *= compare_uint16_t(uint(var[1][2]), 0u);
	result *= compare_uint16_t(uint(var[1][3]), 0u);
	result *= compare_uint16_t(uint(var[2][0]), 0u);
	result *= compare_uint16_t(uint(var[2][1]), 0u);
	result *= compare_uint16_t(uint(var[2][2]), 0u);
	result *= compare_uint16_t(uint(var[2][3]), 0u);
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
	i16vec2 var[3][4];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	float16_t var[3][4];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

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
	f16vec3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
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
	highp vec4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4((var[0][0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][3][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[0][3][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][3][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[1][3][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][0][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][0][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][1][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][1][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][2][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][2][1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][3][0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((var[2][3][1]), vec4(0.0, 0.0, 0.0, 0.0));
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
	highp uvec2 var[3][4][2];
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uvec3 var[3][4][2];
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec3((var[0][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][3][1]), uvec3(0u, 0u, 0u));
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
	bvec3 var[3][4][2];
};

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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec4 var[3][4][2];
};

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec4 var[3][4][2];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	u8vec4 var[3][4][2];
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
	i8vec4 var[3][4][2];
};

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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec2 var[3][4][2];
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec2((var[0][0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][3][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][3][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][3][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][3][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][3][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][3][1]), ivec2(0, 0));
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
	highp ivec2 var[3][4][2];
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec2((var[0][0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[0][3][0]), ivec2(0, 0));
	result *= compare_ivec2((var[0][3][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[1][3][0]), ivec2(0, 0));
	result *= compare_ivec2((var[1][3][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][0][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][0][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][1][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][1][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][2][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][2][1]), ivec2(0, 0));
	result *= compare_ivec2((var[2][3][0]), ivec2(0, 0));
	result *= compare_ivec2((var[2][3][1]), ivec2(0, 0));
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

layout(set = 0, binding = 0, std430) uniform Block
{
	bool var[3][4][2];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat2x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat3x4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
	i8vec3 var[3][4][2];
};

mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
	int16_t var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp vec2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	uint padding;
	highp uvec2 var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
	highp uvec3 var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec3((var[0][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[0][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1][3][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][0][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][0][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][1][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][1][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][2][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][2][1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][3][0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2][3][1]), uvec3(0u, 0u, 0u));
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
	highp uvec4 var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bool var[3][4][2];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	bool padding;
	bvec2 var[3][4][2];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat2x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, scalar) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
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
	u8vec3 var[3][4][2];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var[3][4][2];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
	int8_t var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
	result *= compare_int8_t(int(var[0][0][0]), 0);
	result *= compare_int8_t(int(var[0][0][1]), 0);
	result *= compare_int8_t(int(var[0][1][0]), 0);
	result *= compare_int8_t(int(var[0][1][1]), 0);
	result *= compare_int8_t(int(var[0][2][0]), 0);
	result *= compare_int8_t(int(var[0][2][1]), 0);
	result *= compare_int8_t(int(var[0][3][0]), 0);
	result *= compare_int8_t(int(var[0][3][1]), 0);
	result *= compare_int8_t(int(var[1][0][0]), 0);
	result *= compare_int8_t(int(var[1][0][1]), 0);
	result *= compare_int8_t(int(var[1][1][0]), 0);
	result *= compare_int8_t(int(var[1][1][1]), 0);
	result *= compare_int8_t(int(var[1][2][0]), 0);
	result *= compare_int8_t(int(var[1][2][1]), 0);
	result *= compare_int8_t(int(var[1][3][0]), 0);
	result *= compare_int8_t(int(var[1][3][1]), 0);
	result *= compare_int8_t(int(var[2][0][0]), 0);
	result *= compare_int8_t(int(var[2][0][1]), 0);
	result *= compare_int8_t(int(var[2][1][0]), 0);
	result *= compare_int8_t(int(var[2][1][1]), 0);
	result *= compare_int8_t(int(var[2][2][0]), 0);
	result *= compare_int8_t(int(var[2][2][1]), 0);
	result *= compare_int8_t(int(var[2][3][0]), 0);
	result *= compare_int8_t(int(var[2][3][1]), 0);
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
	int8_t var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
	result *= compare_int8_t(int(var[0][0][0]), 0);
	result *= compare_int8_t(int(var[0][0][1]), 0);
	result *= compare_int8_t(int(var[0][1][0]), 0);
	result *= compare_int8_t(int(var[0][1][1]), 0);
	result *= compare_int8_t(int(var[0][2][0]), 0);
	result *= compare_int8_t(int(var[0][2][1]), 0);
	result *= compare_int8_t(int(var[0][3][0]), 0);
	result *= compare_int8_t(int(var[0][3][1]), 0);
	result *= compare_int8_t(int(var[1][0][0]), 0);
	result *= compare_int8_t(int(var[1][0][1]), 0);
	result *= compare_int8_t(int(var[1][1][0]), 0);
	result *= compare_int8_t(int(var[1][1][1]), 0);
	result *= compare_int8_t(int(var[1][2][0]), 0);
	result *= compare_int8_t(int(var[1][2][1]), 0);
	result *= compare_int8_t(int(var[1][3][0]), 0);
	result *= compare_int8_t(int(var[1][3][1]), 0);
	result *= compare_int8_t(int(var[2][0][0]), 0);
	result *= compare_int8_t(int(var[2][0][1]), 0);
	result *= compare_int8_t(int(var[2][1][0]), 0);
	result *= compare_int8_t(int(var[2][1][1]), 0);
	result *= compare_int8_t(int(var[2][2][0]), 0);
	result *= compare_int8_t(int(var[2][2][1]), 0);
	result *= compare_int8_t(int(var[2][3][0]), 0);
	result *= compare_int8_t(int(var[2][3][1]), 0);
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
	int16_t var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	int16_t var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	result *= compare_int16_t(int(padding), 0);
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

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec3 var;
};

mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec4 var;
};

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(var), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
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
	result *= compare_u16vec3(uvec3(var), uvec3(0u, 0u, 0u));
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
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(var), 0);
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

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp vec2 var;
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp uvec3 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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
	mediump float var;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	mediump vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4((var), vec4(0.0, 0.0, 0.0, 0.0));
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
	mediump uvec2 var;
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec2((var), uvec2(0u, 0u));
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
	mediump uvec2 var;
};

mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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
	mediump uvec4 var;
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	mediump mat2 var;
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
	mediump mat2 var;
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uvec4 var;
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec2 var;
};

mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(var), uvec2(0u, 0u));
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
	u16vec4 var;
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
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
	f16vec2 var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp vec3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((var), vec3(0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	lowp mat4 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
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
	lowp mat4x2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x2((var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump ivec3 var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump uvec3 var;
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp int var;
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
	highp uvec4 var;
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
	highp uvec4 var;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec4 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat3 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat4x3 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec2 var;
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
	result *= compare_u8vec2(uvec2(var), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;


mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec2 var;
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
	result *= compare_u16vec2(uvec2(var), uvec2(0u, 0u));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t var;
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(var), 0.0);
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
	f16vec2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec2(vec2(var), vec2(0.0, 0.0));
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
	lowp uvec4 var;
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
	lowp mat2 var;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	lowp mat3x4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	lowp mat4x2 var;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	result *= compare_float((padding), 0.0);
	result *= compare_mat4x2((var), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	mediump float var;
};

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
	result *= compare_float((padding), 0.0);
	result *= compare_vec3((var), vec3(0.0, 0.0, 0.0));
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
	mediump int var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((var), 0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	mediump int var;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	mediump int var;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	mediump ivec2 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
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
	mediump ivec3 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	mediump mat3 var;
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3x2((var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec3 var;
};

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
	highp ivec3 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec2 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat3((var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x4((var), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x4 var;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat4x2 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp ivec3 var[3];
};

mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp ivec4 var[3];
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((var[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2]), ivec4(0, 0, 0, 0));
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
	bool var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2x3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((var[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((var[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x4((var[0]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[1]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x4((var[2]), mat2x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	i16vec4 var[3];
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(var[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(var[2]), ivec4(0, 0, 0, 0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec2 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2((var[0]), vec2(0.0, 0.0));
	result *= compare_vec2((var[1]), vec2(0.0, 0.0));
	result *= compare_vec2((var[2]), vec2(0.0, 0.0));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3((var[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2]), vec3(0.0, 0.0, 0.0));
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
	highp vec3 var[3];
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uint var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uint var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec2 var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec2((var[0]), uvec2(0u, 0u));
	result *= compare_uvec2((var[1]), uvec2(0u, 0u));
	result *= compare_uvec2((var[2]), uvec2(0u, 0u));
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
	highp uvec3 var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec3 var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec3((var[0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2]), bvec3(false, false, false));
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
	bvec3 var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec3((var[0]), bvec3(false, false, false));
	result *= compare_bvec3((var[1]), bvec3(false, false, false));
	result *= compare_bvec3((var[2]), bvec3(false, false, false));
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
	bvec4 var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((padding), false);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec4 var[3];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
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
	result *= compare_float((padding), 0.0);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x3((var[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((var[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	i8vec2 var[3];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec2 var[3];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec3 var[3];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(var[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2]), ivec3(0, 0, 0));
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
	uint16_t padding;
	u16vec2 var[3];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2]), uvec2(0u, 0u));
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
	int16_t var[3];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_int16_t(int(var[0]), 0);
	result *= compare_int16_t(int(var[1]), 0);
	result *= compare_int16_t(int(var[2]), 0);
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
	int16_t var[3];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(var[0]), 0);
	result *= compare_int16_t(int(var[1]), 0);
	result *= compare_int16_t(int(var[2]), 0);
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp float var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec3 var[];
};

mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(var[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[3]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[4]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[5]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[6]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[7]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[8]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[9]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[10]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[11]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[12]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[13]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[14]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[15]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[16]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[17]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(var[18]), uvec3(0u, 0u, 0u));
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
	int16_t var[];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	i16vec3 var[];
};

mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec4 var[];
};

mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, std430) uniform Block
{
	bool var[];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bool((var[0]), false);
	result *= compare_bool((var[1]), false);
	result *= compare_bool((var[2]), false);
	result *= compare_bool((var[3]), false);
	result *= compare_bool((var[4]), false);
	result *= compare_bool((var[5]), false);
	result *= compare_bool((var[6]), false);
	result *= compare_bool((var[7]), false);
	result *= compare_bool((var[8]), false);
	result *= compare_bool((var[9]), false);
	result *= compare_bool((var[10]), false);
	result *= compare_bool((var[11]), false);
	result *= compare_bool((var[12]), false);
	result *= compare_bool((var[13]), false);
	result *= compare_bool((var[14]), false);
	result *= compare_bool((var[15]), false);
	result *= compare_bool((var[16]), false);
	result *= compare_bool((var[17]), false);
	result *= compare_bool((var[18]), false);
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat2x4 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	u8vec2 var[];
};

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[4]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[5]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[6]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[7]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[8]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[9]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[10]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[11]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[12]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[13]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[14]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[15]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[16]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[17]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[18]), uvec2(0u, 0u));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	int8_t var[];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(var[0]), 0);
	result *= compare_int8_t(int(var[1]), 0);
	result *= compare_int8_t(int(var[2]), 0);
	result *= compare_int8_t(int(var[3]), 0);
	result *= compare_int8_t(int(var[4]), 0);
	result *= compare_int8_t(int(var[5]), 0);
	result *= compare_int8_t(int(var[6]), 0);
	result *= compare_int8_t(int(var[7]), 0);
	result *= compare_int8_t(int(var[8]), 0);
	result *= compare_int8_t(int(var[9]), 0);
	result *= compare_int8_t(int(var[10]), 0);
	result *= compare_int8_t(int(var[11]), 0);
	result *= compare_int8_t(int(var[12]), 0);
	result *= compare_int8_t(int(var[13]), 0);
	result *= compare_int8_t(int(var[14]), 0);
	result *= compare_int8_t(int(var[15]), 0);
	result *= compare_int8_t(int(var[16]), 0);
	result *= compare_int8_t(int(var[17]), 0);
	result *= compare_int8_t(int(var[18]), 0);
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


mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp ivec4 var[];
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	u8vec2 var[];
};

mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[4]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[5]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[6]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[7]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[8]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[9]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[10]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[11]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[12]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[13]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[14]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[15]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[16]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[17]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(var[18]), uvec2(0u, 0u));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	u16vec3 var[];
};

mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((s.a), ivec3(0, 0, 0));
	result *= compare_mat3((s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((s.c), vec4(0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp vec2 var;
} block[3];

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec2 var;
} block[3];

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
	result *= compare_bvec3((block[0].var), bvec3(false, false, false));
	result *= compare_bvec3((block[1].var), bvec3(false, false, false));
	result *= compare_bvec3((block[2].var), bvec3(false, false, false));
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
	highp mat3 var;
} block[3];

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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
	result *= compare_u8vec2(uvec2(block[0].var), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(block[1].var), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(block[2].var), uvec2(0u, 0u));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	u8vec3 var;
} block[3];

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

layout(set = 0, binding = 0, std140) uniform Block
{
	int8_t var;
} block[3];

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


mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

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
	i8vec4 var;
} block[3];

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(block[1].var), ivec4(0, 0, 0, 0));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	i8vec4 var;
} block[3];

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(block[1].var), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(block[2].var), ivec4(0, 0, 0, 0));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	float16_t var;
} block[3];

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(block[0].var), 0.0);
	result *= compare_float16_t(float(block[1].var), 0.0);
	result *= compare_float16_t(float(block[2].var), 0.0);
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
	f16vec3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(block[0].var), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(block[1].var), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(block[2].var), vec3(0.0, 0.0, 0.0));
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
	f16vec3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec3(vec3(block[0].var), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(block[1].var), vec3(0.0, 0.0, 0.0));
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
	f16vec3 var;
} block[3];

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp vec3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3((block[0].var), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((block[1].var), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((block[2].var), vec3(0.0, 0.0, 0.0));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat3x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((block[0].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((block[1].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat3x4 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }

void main (void)
{
    gl_Position = a_position;
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
	result *= compare_u8vec3(uvec3(block[0].var), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(block[1].var), uvec3(0u, 0u, 0u));
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

layout(set = 0, binding = 0, std430) uniform Block
{
	u8vec3 var;
} block[3];

mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(block[0].var), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(block[1].var), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(block[2].var), uvec3(0u, 0u, 0u));
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
	int16_t var;
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int16_t(int(block[0].var), 0);
	result *= compare_int16_t(int(block[1].var), 0);
	result *= compare_int16_t(int(block[2].var), 0);
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
	i16vec2 var;
} block[3];

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

layout(set = 0, binding = 0, std430) uniform Block
{
	float16_t var;
} block[3];

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
	float16_t var;
} block[3];

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	f16vec3 var;
} block[3];

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec4 var;
} block[3];

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool padding;
	bvec3 var;
} block[3];

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bool((block[0].padding), false);
	result *= compare_bvec3((block[0].var), bvec3(false, false, false));
	result *= compare_bool((block[1].padding), false);
	result *= compare_bvec3((block[1].var), bvec3(false, false, false));
	result *= compare_bool((block[2].padding), false);
	result *= compare_bvec3((block[2].var), bvec3(false, false, false));
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
	highp mat3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat3((block[0].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat3((block[1].var), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	highp mat3x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat3x2((block[0].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat3x2((block[1].var), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
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
	highp mat4x2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat4x3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	i8vec2 var;
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(block[0].padding), 0);
	result *= compare_i8vec2(ivec2(block[0].var), ivec2(0, 0));
	result *= compare_int8_t(int(block[1].padding), 0);
	result *= compare_i8vec2(ivec2(block[1].var), ivec2(0, 0));
	result *= compare_int8_t(int(block[2].padding), 0);
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


mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(block[0].padding), 0);
	result *= compare_i8vec4(ivec4(block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_int8_t(int(block[1].padding), 0);
	result *= compare_i8vec4(ivec4(block[1].var), ivec4(0, 0, 0, 0));
	result *= compare_int8_t(int(block[2].padding), 0);
	result *= compare_i8vec4(ivec4(block[2].var), ivec4(0, 0, 0, 0));
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
} block[3];

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec4 var;
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec3 var;
} block[3];

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(block[0].padding), 0u);
	result *= compare_u16vec3(uvec3(block[0].var), uvec3(0u, 0u, 0u));
	result *= compare_uint16_t(uint(block[1].padding), 0u);
	result *= compare_u16vec3(uvec3(block[1].var), uvec3(0u, 0u, 0u));
	result *= compare_uint16_t(uint(block[2].padding), 0u);
	result *= compare_u16vec3(uvec3(block[2].var), uvec3(0u, 0u, 0u));
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
	u16vec3 var;
} block[3];

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t padding;
	u16vec3 var;
} block[3];

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

layout(set = 0, binding = 0, std140) uniform BlockA
{
	highp float a;
	lowp uvec3 b; // unused in both shaders
	mediump mat2 c;
} blockA[3];
layout(set = 0, binding = 1, std140) uniform BlockB
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
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 2, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform BlockA
{
	highp float a;
	lowp uvec3 b; // unused in both shaders
	mediump mat2 c;
} blockA;
layout(set = 0, binding = 1, std430) uniform BlockB
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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockA.a), 0.0);
	result *= compare_uvec3((blockA.b), uvec3(0u, 0u, 0u));
	result *= compare_mat2((blockA.c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB.b), ivec2(0, 0));
	result *= compare_vec4((blockB.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockB.d), false);
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
layout(set = 0, binding = 1, scalar) uniform BlockB
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
	result *= compare_vec2(blockB[0].a[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockB[0].a[1], vec2(0.0, 0.0));
	result *= compare_float(blockB[0].a[0][0], 0.0);
	result *= compare_float(blockB[0].a[0][1], 0.0);
	result *= compare_float(blockB[0].a[1][0], 0.0);
	result *= compare_float(blockB[0].a[1][1], 0.0);
	result *= compare_mat3((blockB[0].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[0].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[0].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[0].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[0].b.c), bvec4(false, false, false, false));
	result *= compare_vec2(blockB[1].a[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockB[1].a[1], vec2(0.0, 0.0));
	result *= compare_float(blockB[1].a[0][0], 0.0);
	result *= compare_float(blockB[1].a[0][1], 0.0);
	result *= compare_float(blockB[1].a[1][0], 0.0);
	result *= compare_float(blockB[1].a[1][1], 0.0);
	result *= compare_mat3((blockB[1].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[1].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[1].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[1].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[1].b.c), bvec4(false, false, false, false));
	result *= compare_vec2(blockB[2].a[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockB[2].a[1], vec2(0.0, 0.0));
	result *= compare_float(blockB[2].a[0][0], 0.0);
	result *= compare_float(blockB[2].a[0][1], 0.0);
	result *= compare_float(blockB[2].a[1][0], 0.0);
	result *= compare_float(blockB[2].a[1][1], 0.0);
	result *= compare_mat3((blockB[2].b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB[2].b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB[2].b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB[2].b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB[2].b.c), bvec4(false, false, false, false));
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
} blockA[3];

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
	result *= compare_mat3((blockA[0].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[0].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[0].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[0].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockA[1].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[1].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[1].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[1].b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockA[2].b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA[2].b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA[2].b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA[2].b.c), vec4(0.0, 0.0, 0.0, 0.0));
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
	mediump int a;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	bool b; // unused in vertex shader
};
layout(set = 0, binding = 3) uniform BlockE
{
	highp int d; // unused in fragment shader
} blockE;

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((a), 0);
	result *= compare_bool((b), false);
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
	mediump int a;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	bool b; // unused in vertex shader
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bool c;
} blockD;

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((a), 0);
	result *= compare_bool((blockD.c), false);
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
	lowp int a;
};
layout(set = 0, binding = 1) uniform BlockC
{
	bvec4 b;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bvec2 c;
	mediump int d;
	highp ivec4 e;
	highp vec2 f;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp ivec2 g;
	mediump uint h;
	mediump uvec3 i;
	bvec4 j;
	highp uvec3 k;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((a), 0);
	result *= compare_bvec4((blockC.b), bvec4(false, false, false, false));
	result *= compare_bvec2((blockD.c), bvec2(false, false));
	result *= compare_int((blockD.d), 0);
	result *= compare_ivec4((blockD.e), ivec4(0, 0, 0, 0));
	result *= compare_vec2((blockD.f), vec2(0.0, 0.0));
	result *= compare_ivec2((blockE.g), ivec2(0, 0));
	result *= compare_uint((blockE.h), 0u);
	result *= compare_uvec3((blockE.i), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockE.j), bvec4(false, false, false, false));
	result *= compare_uvec3((blockE.k), uvec3(0u, 0u, 0u));
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
};
layout(set = 0, binding = 1) uniform BlockC
{
	bvec4 b;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bvec2 c;
	mediump int d;
	highp ivec4 e;
	highp vec2 f;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp ivec2 g;
	mediump uint h;
	mediump uvec3 i;
	bvec4 j;
	highp uvec3 k;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((a), 0);
	result *= compare_bvec4((blockC.b), bvec4(false, false, false, false));
	result *= compare_bvec2((blockD.c), bvec2(false, false));
	result *= compare_int((blockD.d), 0);
	result *= compare_ivec4((blockD.e), ivec4(0, 0, 0, 0));
	result *= compare_vec2((blockD.f), vec2(0.0, 0.0));
	result *= compare_ivec2((blockE.g), ivec2(0, 0));
	result *= compare_uint((blockE.h), 0u);
	result *= compare_uvec3((blockE.i), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockE.j), bvec4(false, false, false, false));
	result *= compare_uvec3((blockE.k), uvec3(0u, 0u, 0u));
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
	highp mat4x2 a;
};
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	lowp mat2x3 b; // unused in fragment shader
	highp mat4x3 c; // unused in vertex shader
	lowp uvec3 d;
	mediump ivec4 e;
	highp float f;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump uvec3 g;
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	bvec2 h; // unused in fragment shader
	highp mat4x2 i;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockC.c), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockC.d), uvec3(0u, 0u, 0u));
	result *= compare_ivec4((blockC.e), ivec4(0, 0, 0, 0));
	result *= compare_float((blockC.f), 0.0);
	result *= compare_uvec3((g), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((i), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat4x2 a;
};
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	lowp mat2x3 b; // unused in fragment shader
	highp mat4x3 c; // unused in vertex shader
	lowp uvec3 d;
	mediump ivec4 e;
	highp float f;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump uvec3 g;
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	bvec2 h; // unused in fragment shader
	highp mat4x2 i;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4x2((a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockC.b), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockC.d), uvec3(0u, 0u, 0u));
	result *= compare_ivec4((blockC.e), ivec4(0, 0, 0, 0));
	result *= compare_float((blockC.f), 0.0);
	result *= compare_uvec3((g), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((h), bvec2(false, false));
	result *= compare_mat4x2((i), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump vec4 a;
	lowp int b; // unused in fragment shader
	lowp mat4x3 c;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump mat4 d; // unused in vertex shader
	bvec3 e; // unused in vertex shader
	mediump uvec2 f; // unused in fragment shader
	highp ivec3 g;
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	bvec4 h;
	lowp mat2x3 i;
	lowp uvec2 j; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	highp ivec3 k;
	bvec2 l;
	lowp uvec4 m[1];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4((blockB.a), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockB.c), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockC.d), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockC.e), bvec3(false, false, false));
	result *= compare_ivec3((blockC.g), ivec3(0, 0, 0));
	result *= compare_bvec4((blockD.h), bvec4(false, false, false, false));
	result *= compare_mat2x3((blockD.i), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockD.j), uvec2(0u, 0u));
	result *= compare_ivec3((k), ivec3(0, 0, 0));
	result *= compare_bvec2((l), bvec2(false, false));
	result *= compare_uvec4((m[0]), uvec4(0u, 0u, 0u, 0u));
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
	mediump vec4 a;
	lowp int b; // unused in fragment shader
	lowp mat4x3 c;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump mat4 d; // unused in vertex shader
	bvec3 e; // unused in vertex shader
	mediump uvec2 f; // unused in fragment shader
	highp ivec3 g;
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	bvec4 h;
	lowp mat2x3 i;
	lowp uvec2 j; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	highp ivec3 k;
	bvec2 l;
	lowp uvec4 m[1];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4((blockB.a), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockB.b), 0);
	result *= compare_mat4x3((blockB.c), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockC.f), uvec2(0u, 0u));
	result *= compare_ivec3((blockC.g), ivec3(0, 0, 0));
	result *= compare_bvec4((blockD.h), bvec4(false, false, false, false));
	result *= compare_mat2x3((blockD.i), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((k), ivec3(0, 0, 0));
	result *= compare_bvec2((l), bvec2(false, false));
	result *= compare_uvec4((m[0]), uvec4(0u, 0u, 0u, 0u));
    v_vtxResult = result;
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
	mediump mat4x2 a;
	mediump uvec2 b;
	mediump mat2x3 c;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	lowp ivec4 d;
	bvec2 e;
	mediump vec4 f;
	mediump vec3 g;
	mediump mat2x3 h; // unused in vertex shader
} blockC[3];
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	mediump uvec3 j;
	mediump vec4 k;
	mediump ivec3 l; // unused in fragment shader
	lowp uvec2 m;
	highp uvec2 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4x2((a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((b), uvec2(0u, 0u));
	result *= compare_mat2x3((c), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockC[0].d), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((blockC[0].e), bvec2(false, false));
	result *= compare_vec4((blockC[0].f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC[0].g), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockC[0].h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockC[1].d), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((blockC[1].e), bvec2(false, false));
	result *= compare_vec4((blockC[1].f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC[1].g), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockC[1].h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockC[2].d), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((blockC[2].e), bvec2(false, false));
	result *= compare_vec4((blockC[2].f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC[2].g), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockC[2].h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((j), uvec3(0u, 0u, 0u));
	result *= compare_vec4((k), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((m), uvec2(0u, 0u));
	result *= compare_uvec2((n), uvec2(0u, 0u));
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
	mediump mat4x2 a;
	mediump uvec2 b;
	mediump mat2x3 c;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	lowp ivec4 d;
	bvec2 e;
	mediump vec4 f;
	mediump vec3 g;
	mediump mat2x3 h; // unused in vertex shader
} blockC[3];
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bool i;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
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
	result *= compare_mat4x2((a), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((b), uvec2(0u, 0u));
	result *= compare_mat2x3((c), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockC[0].d), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((blockC[0].e), bvec2(false, false));
	result *= compare_vec4((blockC[0].f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC[0].g), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec4((blockC[1].d), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((blockC[1].e), bvec2(false, false));
	result *= compare_vec4((blockC[1].f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC[1].g), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec4((blockC[2].d), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((blockC[2].e), bvec2(false, false));
	result *= compare_vec4((blockC[2].f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC[2].g), vec3(0.0, 0.0, 0.0));
	result *= compare_bool((i), false);
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
	lowp uvec3 mA; // unused in fragment shader
	mediump uvec3 mB; // unused in vertex shader
	lowp mat4x3 mC;
};
struct sB
{
	lowp vec2 mA;
};
struct sC
{
	lowp mat3x4 mA;
	mediump int mB;
};
struct sD
{
	mediump mat3x4 mA; // unused in vertex shader
	bvec4 mB;
	highp mat2x3 mC;
};
struct sE
{
	mediump float mA; // unused in vertex shader
	bvec3 mB;
	mediump uvec4 mC;
};
struct sF
{
	lowp int mA; // unused in fragment shader
};
struct sG
{
	highp mat3x4 mA; // unused in fragment shader
	highp int mB; // unused in fragment shader
	highp mat3x2 mC;
	highp ivec3 mD; // unused in both shaders
};
struct sH
{
	highp float mA;
	mediump ivec4 mB;
	lowp vec4 mC;
	bvec4 mD; // unused in fragment shader
};
struct sI
{
	sG mA; // unused in fragment shader
	mediump ivec2 mB;
	sH mC;
	lowp mat3 mD; // unused in vertex shader
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	lowp ivec3 a;
	sA b;
	mediump uint c;
	sB d;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	sC e;
	bool f;
	sD g;
	highp ivec2 h; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	sE i;
	highp mat4x3 j; // unused in fragment shader
	lowp ivec4 k;
} blockD;
layout(set = 0, binding = 4) uniform BlockF
{
	highp uvec3 o;
	highp mat2x3 p;
	highp mat3x4 q;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_uvec3((blockB.b.mB), uvec3(0u, 0u, 0u));
	result *= compare_mat4x3((blockB.b.mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB.c), 0u);
	result *= compare_vec2((blockB.d.mA), vec2(0.0, 0.0));
	result *= compare_mat3x4((blockC.e.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockC.e.mB), 0);
	result *= compare_bool((blockC.f), false);
	result *= compare_mat3x4((blockC.g.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockC.g.mB), bvec4(false, false, false, false));
	result *= compare_mat2x3((blockC.g.mC), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockD.i.mA), 0.0);
	result *= compare_bvec3((blockD.i.mB), bvec3(false, false, false));
	result *= compare_uvec4((blockD.i.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((blockD.k), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((o), uvec3(0u, 0u, 0u));
	result *= compare_mat2x3((p), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((q), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp uvec3 mA; // unused in fragment shader
	mediump uvec3 mB; // unused in vertex shader
	lowp mat4x3 mC;
};
struct sB
{
	lowp vec2 mA;
};
struct sC
{
	lowp mat3x4 mA;
	mediump int mB;
};
struct sD
{
	mediump mat3x4 mA; // unused in vertex shader
	bvec4 mB;
	highp mat2x3 mC;
};
struct sE
{
	mediump float mA; // unused in vertex shader
	bvec3 mB;
	mediump uvec4 mC;
};
struct sF
{
	lowp int mA; // unused in fragment shader
};
struct sG
{
	highp mat3x4 mA; // unused in fragment shader
	highp int mB; // unused in fragment shader
	highp mat3x2 mC;
	highp ivec3 mD; // unused in both shaders
};
struct sH
{
	highp float mA;
	mediump ivec4 mB;
	lowp vec4 mC;
	bvec4 mD; // unused in fragment shader
};
struct sI
{
	sG mA; // unused in fragment shader
	mediump ivec2 mB;
	sH mC;
	lowp mat3 mD; // unused in vertex shader
};
layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	lowp ivec3 a;
	sA b;
	mediump uint c;
	sB d;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	sC e;
	bool f;
	sD g;
	highp ivec2 h; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	sE i;
	highp mat4x3 j; // unused in fragment shader
	lowp ivec4 k;
} blockD;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	sF l; // unused in fragment shader
	sI m; // unused in fragment shader
	lowp mat2x3 n;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_uvec3((blockB.b.mA), uvec3(0u, 0u, 0u));
	result *= compare_mat4x3((blockB.b.mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockB.c), 0u);
	result *= compare_vec2((blockB.d.mA), vec2(0.0, 0.0));
	result *= compare_mat3x4((blockC.e.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockC.e.mB), 0);
	result *= compare_bool((blockC.f), false);
	result *= compare_bvec4((blockC.g.mB), bvec4(false, false, false, false));
	result *= compare_mat2x3((blockC.g.mC), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC.h), ivec2(0, 0));
	result *= compare_bvec3((blockD.i.mB), bvec3(false, false, false));
	result *= compare_uvec4((blockD.i.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x3((blockD.j), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockD.k), ivec4(0, 0, 0, 0));
	result *= compare_int((blockE.l.mA), 0);
	result *= compare_mat3x4((blockE.m.mA.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockE.m.mA.mB), 0);
	result *= compare_mat3x2((blockE.m.mA.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockE.m.mB), ivec2(0, 0));
	result *= compare_float((blockE.m.mC.mA), 0.0);
	result *= compare_ivec4((blockE.m.mC.mB), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockE.m.mC.mC), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockE.m.mC.mD), bvec4(false, false, false, false));
	result *= compare_mat2x3((blockE.n), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	bvec3 mA;
	mediump ivec3 mB;
};
struct sB
{
	lowp mat3x4 mA;
	bool mB;
	mediump mat4x2 mC;
	mediump uvec2 mD;
};
layout(set = 0, binding = 4) uniform BlockF
{
	mediump uint o;
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	mediump mat3 p;
} blockG;
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	lowp vec4 q;
	sB r;
	lowp ivec2 s;
};
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	bool t;
	highp mat2 u; // unused in both shaders
	mediump mat2 v; // unused in vertex shader
	mediump uvec4 w;
	bvec4 x;
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
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_uint((blockF.o), 0u);
	result *= compare_mat3((blockG.p), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((q), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((r.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((r.mB), false);
	result *= compare_mat4x2((r.mC), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((r.mD), uvec2(0u, 0u));
	result *= compare_ivec2((s), ivec2(0, 0));
	result *= compare_bool((t), false);
	result *= compare_mat2((u), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((v), mat2(0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

struct sA
{
	lowp mat4 mA;
	mediump ivec2 mB;
	mediump ivec3 mC;
	highp mat3x2 mD;
};
struct sB
{
	lowp int mA;
	highp mat4 mB; // unused in fragment shader
	highp mat4x2 mC;
	sA mD;
};
struct sC
{
	highp vec2 mA;
	mediump mat3 mB; // unused in fragment shader
	mediump vec2 mC; // unused in fragment shader
	bvec2 mD;
};
struct sD
{
	lowp vec4 mA; // unused in vertex shader
	mediump uint mB;
	mediump mat3x4 mC[2]; // unused in vertex shader
	lowp ivec2 mD;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	bvec2 u;
	lowp ivec2 v;
	lowp mat4x3 w;
	lowp uint x; // unused in vertex shader
	highp vec2 y;
};
layout(set = 0, binding = 6) uniform BlockH
{
	sC z;
	sD aa;
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec2((u), bvec2(false, false));
	result *= compare_ivec2((v), ivec2(0, 0));
	result *= compare_mat4x3((w), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((x), 0u);
	result *= compare_vec2((y), vec2(0.0, 0.0));
	result *= compare_vec2((z.mA), vec2(0.0, 0.0));
	result *= compare_mat3((z.mB), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((z.mC), vec2(0.0, 0.0));
	result *= compare_bvec2((z.mD), bvec2(false, false));
	result *= compare_vec4((aa.mA), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((aa.mB), 0u);
	result *= compare_mat3x4((aa.mC[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((aa.mC[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((aa.mD), ivec2(0, 0));
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
	mediump mat3x4 mA[1]; // unused in vertex shader
	mediump vec4 mB;
};
struct sB
{
	lowp uvec2 mA;
	highp vec4 mB[1]; // unused in fragment shader
	lowp uvec2 mC;
};
struct sC
{
	sB mA[6]; // unused in both shaders
	highp mat4x3 mB; // unused in vertex shader
	mediump mat2 mC[5];
	highp mat4 mD;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	bvec3 j;
	mediump mat4x3 k;
	mediump int l; // unused in vertex shader
};
layout(set = 0, binding = 5) uniform BlockG
{
	mediump ivec3 m;
	mediump mat2x3 n; // unused in fragment shader
	bvec3 o; // unused in vertex shader
	highp mat2x3 p[2];
	sA q;
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp uvec4 r;
	bvec2 s;
	highp mat4x2 t;
} blockH;
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	highp mat2x3 u;
	mediump mat4x2 v; // unused in both shaders
	sC w;
} blockI[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((j), bvec3(false, false, false));
	result *= compare_mat4x3((k), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((l), 0);
	result *= compare_ivec3((blockG.m), ivec3(0, 0, 0));
	result *= compare_mat2x3((blockG.n), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockG.o), bvec3(false, false, false));
	result *= compare_mat2x3((blockG.p[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG.p[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockG.q.mA[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG.q.mB), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockH.r), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec2((blockH.s), bvec2(false, false));
	result *= compare_mat4x2((blockH.t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI[0].u), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI[0].v), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[0].w.mA[0].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[0].w.mA[0].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[0].w.mA[0].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[0].w.mA[1].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[0].w.mA[1].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[0].w.mA[1].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[0].w.mA[2].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[0].w.mA[2].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[0].w.mA[2].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[0].w.mA[3].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[0].w.mA[3].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[0].w.mA[3].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[0].w.mA[4].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[0].w.mA[4].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[0].w.mA[4].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[0].w.mA[5].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[0].w.mA[5].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[0].w.mA[5].mC), uvec2(0u, 0u));
	result *= compare_mat4x3((blockI[0].w.mB), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[0].w.mC[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[0].w.mC[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[0].w.mC[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[0].w.mC[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[0].w.mC[4]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockI[0].w.mD), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI[1].u), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI[1].v), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[1].w.mA[0].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[1].w.mA[0].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[1].w.mA[0].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[1].w.mA[1].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[1].w.mA[1].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[1].w.mA[1].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[1].w.mA[2].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[1].w.mA[2].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[1].w.mA[2].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[1].w.mA[3].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[1].w.mA[3].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[1].w.mA[3].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[1].w.mA[4].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[1].w.mA[4].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[1].w.mA[4].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[1].w.mA[5].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[1].w.mA[5].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[1].w.mA[5].mC), uvec2(0u, 0u));
	result *= compare_mat4x3((blockI[1].w.mB), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[1].w.mC[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[1].w.mC[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[1].w.mC[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[1].w.mC[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[1].w.mC[4]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockI[1].w.mD), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI[2].u), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI[2].v), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[2].w.mA[0].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[2].w.mA[0].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[2].w.mA[0].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[2].w.mA[1].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[2].w.mA[1].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[2].w.mA[1].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[2].w.mA[2].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[2].w.mA[2].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[2].w.mA[2].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[2].w.mA[3].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[2].w.mA[3].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[2].w.mA[3].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[2].w.mA[4].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[2].w.mA[4].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[2].w.mA[4].mC), uvec2(0u, 0u));
	result *= compare_uvec2((blockI[2].w.mA[5].mA), uvec2(0u, 0u));
	result *= compare_vec4((blockI[2].w.mA[5].mB[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockI[2].w.mA[5].mC), uvec2(0u, 0u));
	result *= compare_mat4x3((blockI[2].w.mB), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[2].w.mC[0]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[2].w.mC[1]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[2].w.mC[2]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[2].w.mC[3]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockI[2].w.mC[4]), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockI[2].w.mD), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp uint mA;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	mediump mat4x2 p;
} blockG[1];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	bvec3 q; // unused in fragment shader
} blockH;
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	lowp vec2 r;
	lowp mat4x2 s;
	highp uint t;
	mediump mat3 u; // unused in fragment shader
} blockI[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((blockG[0].p), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockH.q), bvec3(false, false, false));
	result *= compare_vec2((blockI[0].r), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockI[0].s), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockI[0].t), 0u);
	result *= compare_mat3((blockI[0].u), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockI[1].r), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockI[1].s), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockI[1].t), 0u);
	result *= compare_mat3((blockI[1].u), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp uvec4 mA;
	highp mat4x3 mB; // unused in vertex shader
	bvec3 mC;
	lowp ivec4 mD;
};
struct sB
{
	bvec2 mA;
	mediump vec4 mB; // unused in vertex shader
	highp mat2 mC;
};
struct sC
{
	highp mat3 mA[7]; // unused in fragment shader
};
struct sD
{
	sB mA;
	bvec3 mB[7];
	sC mC;
	lowp mat4x3 mD;
};
struct sE
{
	mediump int mA; // unused in fragment shader
	highp float mB;
	mediump mat4 mC;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	highp uvec4 r;
	mediump int s; // unused in fragment shader
	lowp mat4x3 t[5];
	lowp ivec2 u;
} blockG[3];
layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp vec3 v;
	lowp mat3x2 w;
	sE x;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	lowp ivec4 y;
	lowp mat3x2 z;
	highp uvec4 aa; // unused in vertex shader
	lowp ivec3 ab;
	mediump mat3 ac; // unused in both shaders
} blockI;
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	lowp mat4x3 ad; // unused in vertex shader
	bool ae;
	highp float af;
	highp mat2x3 ag; // unused in fragment shader
} blockJ;

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
	result *= compare_uvec4((blockG[0].r), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockG[0].s), 0);
	result *= compare_mat4x3((blockG[0].t[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[0].t[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[0].t[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[0].t[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[0].t[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG[0].u), ivec2(0, 0));
	result *= compare_uvec4((blockG[1].r), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockG[1].s), 0);
	result *= compare_mat4x3((blockG[1].t[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[1].t[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[1].t[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[1].t[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[1].t[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG[1].u), ivec2(0, 0));
	result *= compare_uvec4((blockG[2].r), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockG[2].s), 0);
	result *= compare_mat4x3((blockG[2].t[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[2].t[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[2].t[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[2].t[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG[2].t[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG[2].u), ivec2(0, 0));
	result *= compare_vec3((blockH.v), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH.w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockH.x.mA), 0);
	result *= compare_float((blockH.x.mB), 0.0);
	result *= compare_mat4((blockH.x.mC), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockI.y), ivec4(0, 0, 0, 0));
	result *= compare_mat3x2((blockI.z), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockI.aa), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec3((blockI.ab), ivec3(0, 0, 0));
	result *= compare_mat3((blockI.ac), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockJ.ad), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockJ.ae), false);
	result *= compare_float((blockJ.af), 0.0);
	result *= compare_mat2x3((blockJ.ag), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2 mA;
};
struct sB
{
	mediump uvec3 mA;
	sA mB;
	lowp mat4 mC; // unused in vertex shader
};
struct sC
{
	lowp mat4x2 mA;
	highp mat4x2 mB;
	highp uvec3 mC;
	lowp vec4 mD[8];
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	lowp mat2x3 o;
	highp uvec4 p;
	sC q; // unused in both shaders
	highp mat4x2 r[2];
	mediump mat2x3 s;
} blockG[3];
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	bvec2 t; // unused in vertex shader
	lowp mat4x2 u;
	bvec3 v;
	highp mat2x3 w;
	lowp ivec4 x;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	lowp uvec4 y; // unused in fragment shader
	lowp mat2x3 z[8];
} blockI;
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	highp int aa;
	mediump uvec4 ab;
	lowp uvec4 ac[4];
	highp mat3 ad;
	bvec4 ae;
} blockJ;

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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((blockG[0].o), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockG[0].p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x2((blockG[0].q.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].q.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockG[0].q.mC), uvec3(0u, 0u, 0u));
	result *= compare_vec4((blockG[0].q.mD[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].q.mD[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].q.mD[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].q.mD[3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].q.mD[4]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].q.mD[5]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].q.mD[6]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[0].q.mD[7]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].r[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[0].r[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[0].s), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[1].o), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockG[1].p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x2((blockG[1].q.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].q.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockG[1].q.mC), uvec3(0u, 0u, 0u));
	result *= compare_vec4((blockG[1].q.mD[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[1].q.mD[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[1].q.mD[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[1].q.mD[3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[1].q.mD[4]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[1].q.mD[5]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[1].q.mD[6]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[1].q.mD[7]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].r[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[1].r[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[1].s), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[2].o), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockG[2].p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x2((blockG[2].q.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].q.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockG[2].q.mC), uvec3(0u, 0u, 0u));
	result *= compare_vec4((blockG[2].q.mD[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[2].q.mD[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[2].q.mD[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[2].q.mD[3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[2].q.mD[4]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[2].q.mD[5]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[2].q.mD[6]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG[2].q.mD[7]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].r[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG[2].r[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockG[2].s), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH.t), bvec2(false, false));
	result *= compare_mat4x2((blockH.u), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockH.v), bvec3(false, false, false));
	result *= compare_mat2x3((blockH.w), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockH.x), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((blockI.y), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((blockI.z[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.z[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.z[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.z[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.z[4]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.z[5]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.z[6]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.z[7]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockJ.aa), 0);
	result *= compare_uvec4((blockJ.ab), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockJ.ac[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockJ.ac[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockJ.ac[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockJ.ac[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockJ.ad), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockJ.ae), bvec4(false, false, false, false));
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
	highp mat3x2 mA;
	lowp uvec2 mB; // unused in vertex shader
};
struct sB
{
	highp mat3x2 mA; // unused in fragment shader
	lowp float mB; // unused in fragment shader
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	highp ivec2 m;
	mediump mat3x2 n; // unused in vertex shader
	highp mat4x2 o;
	sB p;
	mediump vec4 q;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((m), ivec2(0, 0));
	result *= compare_mat3x2((n), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((o), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((p.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((p.mB), 0.0);
	result *= compare_vec4((q), vec4(0.0, 0.0, 0.0, 0.0));
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
	mediump mat2x3 mA;
	highp mat2x3 mB;
	highp vec2 mC;
};
struct sB
{
	mediump mat2 mA; // unused in vertex shader
	mediump mat4x2 mB;
	lowp uvec4 mC;
};
struct sC
{
	bvec4 mA[2];
	sB mB;
	highp mat4x3 mC; // unused in vertex shader
};
struct sD
{
	mediump ivec2 mA;
	mediump uint mB;
	mediump mat4x2 mC;
	mediump uint mD; // unused in vertex shader
};
layout(set = 0, binding = 5, std430, row_major) uniform BlockG
{
	layout(offset = 192) lowp ivec3 u;
	layout(offset = 0) bvec2 q;
	layout(offset = 128) highp mat3x4 t;
	layout(offset = 16) highp mat4x3 r; // unused in vertex shader
	layout(offset = 64) sD s; // unused in vertex shader
} blockG[2];
layout(set = 0, binding = 6, scalar, row_major) uniform BlockH
{
	layout(offset = 84) highp mat3x2 z[1]; // unused in fragment shader
	layout(offset = 0) bvec2 v; // unused in vertex shader
	layout(offset = 76) highp int y[2];
	layout(offset = 8) highp mat4x2 w;
	layout(offset = 40) highp mat3 x;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	layout(offset = 0) highp mat4 aa;
} blockI;
layout(set = 0, binding = 8, scalar) uniform BlockJ
{
	layout(offset = 0) bvec2 ab;
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
	result *= compare_bvec2((blockG[0].q), bvec2(false, false));
	result *= compare_mat4x3((blockG[0].r), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG[0].s.mA), ivec2(0, 0));
	result *= compare_uint((blockG[0].s.mB), 0u);
	result *= compare_mat4x2((blockG[0].s.mC), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockG[0].s.mD), 0u);
	result *= compare_mat3x4((blockG[0].t), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[0].u), ivec3(0, 0, 0));
	result *= compare_bvec2((blockG[1].q), bvec2(false, false));
	result *= compare_mat4x3((blockG[1].r), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG[1].s.mA), ivec2(0, 0));
	result *= compare_uint((blockG[1].s.mB), 0u);
	result *= compare_mat4x2((blockG[1].s.mC), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockG[1].s.mD), 0u);
	result *= compare_mat3x4((blockG[1].t), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[1].u), ivec3(0, 0, 0));
	result *= compare_bvec2((v), bvec2(false, false));
	result *= compare_mat4x2((w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((x), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((y[0]), 0);
	result *= compare_int((y[1]), 0);
	result *= compare_mat3x2((z[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockI.aa), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((ab), bvec2(false, false));
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
	lowp vec4 mA; // unused in both shaders
};
struct sB
{
	bvec4 mA;
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	layout(offset = 0) lowp mat3x2 r[7];
} blockF;
layout(set = 0, binding = 5, std430, column_major) uniform BlockG
{
	layout(offset = 48) lowp int v;
	layout(offset = 0) lowp ivec4 s;
	layout(offset = 32) sB u;
	layout(offset = 16) mediump ivec2 t;
} blockG[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((blockF.r[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF.r[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF.r[2]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF.r[3]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF.r[4]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF.r[5]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockF.r[6]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockG[0].s), ivec4(0, 0, 0, 0));
	result *= compare_ivec2((blockG[0].t), ivec2(0, 0));
	result *= compare_bvec4((blockG[0].u.mA), bvec4(false, false, false, false));
	result *= compare_int((blockG[0].v), 0);
	result *= compare_ivec4((blockG[1].s), ivec4(0, 0, 0, 0));
	result *= compare_ivec2((blockG[1].t), ivec2(0, 0));
	result *= compare_bvec4((blockG[1].u.mA), bvec4(false, false, false, false));
	result *= compare_int((blockG[1].v), 0);
	result *= compare_ivec4((blockG[2].s), ivec4(0, 0, 0, 0));
	result *= compare_ivec2((blockG[2].t), ivec2(0, 0));
	result *= compare_bvec4((blockG[2].u.mA), bvec4(false, false, false, false));
	result *= compare_int((blockG[2].v), 0);
    imageStore(outImage, coord, vec4(result));
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
	layout(offset = 224) lowp mat4x3 p; // unused in vertex shader
	layout(offset = 0) mediump vec2 m;
	layout(offset = 208) mediump int o;
	layout(offset = 16) highp uvec2 n[4][3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_vec2((m), vec2(0.0, 0.0));
	result *= compare_uvec2((n[0][0]), uvec2(0u, 0u));
	result *= compare_uvec2((n[0][1]), uvec2(0u, 0u));
	result *= compare_uvec2((n[0][2]), uvec2(0u, 0u));
	result *= compare_uvec2((n[1][0]), uvec2(0u, 0u));
	result *= compare_uvec2((n[1][1]), uvec2(0u, 0u));
	result *= compare_uvec2((n[1][2]), uvec2(0u, 0u));
	result *= compare_uvec2((n[2][0]), uvec2(0u, 0u));
	result *= compare_uvec2((n[2][1]), uvec2(0u, 0u));
	result *= compare_uvec2((n[2][2]), uvec2(0u, 0u));
	result *= compare_uvec2((n[3][0]), uvec2(0u, 0u));
	result *= compare_uvec2((n[3][1]), uvec2(0u, 0u));
	result *= compare_uvec2((n[3][2]), uvec2(0u, 0u));
	result *= compare_int((o), 0);
	result *= compare_mat4x3((p), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump ivec2 mA;
	mediump mat4x2 mB;
};
struct sB
{
	lowp uvec4 mA;
};
layout(set = 0, binding = 5, std430, column_major) uniform BlockG
{
	layout(offset = 0) mediump mat3x4 l;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((blockG.l), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, scalar) uniform BlockG
{
	lowp float l; // unused in vertex shader
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	mediump vec4 m;
	lowp mat3x2 n;
	bool o;
} blockH;
layout(set = 0, binding = 7, scalar) uniform BlockI
{
	bvec4 p;
};
layout(set = 0, binding = 8) uniform BlockJ
{
	lowp vec2 q;
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockG.l), 0.0);
	result *= compare_vec4((blockH.m), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH.n), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockH.o), false);
	result *= compare_bvec4((p), bvec4(false, false, false, false));
	result *= compare_vec2((blockJ.q), vec2(0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std430) uniform BlockG
{
	highp vec4 j;
	highp mat4 k; // unused in fragment shader
};
layout(set = 0, binding = 6) uniform BlockH
{
	highp ivec2 l;
	mediump mat3x2 m;
	highp int n; // unused in fragment shader
};
layout(set = 0, binding = 7, std430) uniform BlockI
{
	mediump uvec3 o;
	mediump ivec2 p;
	lowp uvec4 q;
} blockI;
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	mediump uint r; // unused in fragment shader
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((j), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((k), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((l), ivec2(0, 0));
	result *= compare_mat3x2((m), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((n), 0);
	result *= compare_uvec3((blockI.o), uvec3(0u, 0u, 0u));
	result *= compare_ivec2((blockI.p), ivec2(0, 0));
	result *= compare_uvec4((blockI.q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((blockJ.r), 0u);
    imageStore(outImage, coord, vec4(result));
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
	bvec3 v;
	highp vec3 w; // unused in vertex shader
};
layout(set = 0, binding = 7) uniform BlockI
{
	u16vec2 x;
	i16vec3 y;
	highp ivec4 z;
};
layout(set = 0, binding = 8, std140) uniform BlockJ
{
	highp ivec2 aa;
	f16vec2 ab;
	f16vec3 ac; // unused in fragment shader
	float16_t ad;
	bool ae; // unused in fragment shader
} blockJ;
layout(set = 0, binding = 9) uniform BlockK
{
	highp int af; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((v), bvec3(false, false, false));
	result *= compare_vec3((w), vec3(0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(x), uvec2(0u, 0u));
	result *= compare_i16vec3(ivec3(y), ivec3(0, 0, 0));
	result *= compare_ivec4((z), ivec4(0, 0, 0, 0));
	result *= compare_ivec2((blockJ.aa), ivec2(0, 0));
	result *= compare_f16vec2(vec2(blockJ.ab), vec2(0.0, 0.0));
	result *= compare_f16vec3(vec3(blockJ.ac), vec3(0.0, 0.0, 0.0));
	result *= compare_float16_t(float(blockJ.ad), 0.0);
	result *= compare_bool((blockJ.ae), false);
	result *= compare_int((af), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 9, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 6, std140) uniform BlockH
{
	bool y;
	lowp float z; // unused in vertex shader
	bvec4 aa;
	bvec3 ab;
	u16vec4 ac;
};
layout(set = 0, binding = 7, std140) uniform BlockI
{
	float16_t ad;
	highp vec3 ae;
	mediump vec2 af;
	f16vec2 ag; // unused in both shaders
} blockI;
layout(set = 0, binding = 8) uniform BlockJ
{
	float16_t ah;
	int16_t ai;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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
	result *= compare_bool((y), false);
	result *= compare_float((z), 0.0);
	result *= compare_bvec4((aa), bvec4(false, false, false, false));
	result *= compare_bvec3((ab), bvec3(false, false, false));
	result *= compare_u16vec4(uvec4(ac), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float16_t(float(blockI.ad), 0.0);
	result *= compare_vec3((blockI.ae), vec3(0.0, 0.0, 0.0));
	result *= compare_vec2((blockI.af), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(blockI.ag), vec2(0.0, 0.0));
	result *= compare_float16_t(float(ah), 0.0);
	result *= compare_int16_t(int(ai), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, column_major) uniform BlockG
{
	i16vec2 q;
	mediump int r;
	i16vec4 s;
	mediump mat4x2 t;
} blockG[2];
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	u16vec3 u; // unused in vertex shader
	mediump ivec2 v;
	i16vec2 w;
	mediump int x;
	lowp vec2 y;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(blockG[0].q), ivec2(0, 0));
	result *= compare_int((blockG[0].r), 0);
	result *= compare_i16vec4(ivec4(blockG[0].s), ivec4(0, 0, 0, 0));
	result *= compare_mat4x2((blockG[0].t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(blockG[1].q), ivec2(0, 0));
	result *= compare_int((blockG[1].r), 0);
	result *= compare_i16vec4(ivec4(blockG[1].s), ivec4(0, 0, 0, 0));
	result *= compare_mat4x2((blockG[1].t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec3(uvec3(u), uvec3(0u, 0u, 0u));
	result *= compare_ivec2((v), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(w), ivec2(0, 0));
	result *= compare_int((x), 0);
	result *= compare_vec2((y), vec2(0.0, 0.0));
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
	highp mat3x2 mA; // unused in vertex shader
	highp mat2 mB;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	i16vec4 k;
	bvec2 l;
	lowp mat3x2 m;
	sA n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec4(ivec4(k), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((l), bvec2(false, false));
	result *= compare_mat3x2((m), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((n.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((n.mB), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp mat3 mA; // unused in vertex shader
};
struct sB
{
	highp uvec3 mA;
	int16_t mB;
	highp ivec4 mC; // unused in fragment shader
	sA mD; // unused in vertex shader
};
struct sC
{
	lowp float mA;
	mediump ivec3 mB;
};
struct sD
{
	u16vec2 mA;
};
struct sE
{
	sC mA;
	bvec2 mB;
	mediump vec3 mC; // unused in fragment shader
	sD mD;
};
struct sF
{
	mediump uvec2 mA; // unused in fragment shader
	highp uvec2 mB;
	f16vec3 mC;
	lowp int mD;
};
struct sG
{
	f16vec3 mA;
	lowp vec2 mB;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	lowp mat3x2 m;
	mediump ivec3 n;
	sG o;
	f16vec2 p;
	highp vec3 q; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	lowp vec3 r; // unused in fragment shader
	mediump mat4x2 s;
};
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	u16vec4 t;
} blockI;
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	f16vec4 u;
	int16_t v;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((blockG.m), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG.n), ivec3(0, 0, 0));
	result *= compare_f16vec3(vec3(blockG.o.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_vec2((blockG.o.mB), vec2(0.0, 0.0));
	result *= compare_f16vec2(vec2(blockG.p), vec2(0.0, 0.0));
	result *= compare_vec3((blockG.q), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((r), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((s), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockI.t), uvec4(0u, 0u, 0u, 0u));
	result *= compare_f16vec4(vec4(u), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(v), 0);
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
	lowp vec2 mA; // unused in vertex shader
	u16vec3 mB;
	i16vec4 mC; // unused in fragment shader
};
struct sB
{
	u16vec4 mA;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	u16vec3 a; // unused in fragment shader
	bvec3 b; // unused in vertex shader
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp vec2 c;
	sA d;
	highp vec4 e; // unused in vertex shader
	mediump int f;
	u16vec3 g; // unused in fragment shader
} blockC;
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	lowp mat3 p; // unused in vertex shader
	uint16_t q;
	mediump uvec2 r;
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	lowp int s;
	bvec2 t;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec3((b), bvec3(false, false, false));
	result *= compare_vec2((blockC.c), vec2(0.0, 0.0));
	result *= compare_vec2((blockC.d.mA), vec2(0.0, 0.0));
	result *= compare_u16vec3(uvec3(blockC.d.mB), uvec3(0u, 0u, 0u));
	result *= compare_vec4((blockC.e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockC.f), 0);
	result *= compare_mat3((blockF.p), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint16_t(uint(blockF.q), 0u);
	result *= compare_uvec2((blockF.r), uvec2(0u, 0u));
	result *= compare_int((blockG.s), 0);
	result *= compare_bvec2((blockG.t), bvec2(false, false));
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
	lowp vec2 mA; // unused in vertex shader
	u16vec3 mB;
	i16vec4 mC; // unused in fragment shader
};
struct sB
{
	u16vec4 mA;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	u16vec3 a; // unused in fragment shader
	bvec3 b; // unused in vertex shader
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp vec2 c;
	sA d;
	highp vec4 e; // unused in vertex shader
	mediump int f;
	u16vec3 g; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	mediump float h;
	lowp uvec2 i;
	int16_t j;
} blockD[3];
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	mediump mat4 k;
	sB l;
	float16_t m;
	highp ivec2 n; // unused in fragment shader
	bvec3 o;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(a), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockC.c), vec2(0.0, 0.0));
	result *= compare_u16vec3(uvec3(blockC.d.mB), uvec3(0u, 0u, 0u));
	result *= compare_i16vec4(ivec4(blockC.d.mC), ivec4(0, 0, 0, 0));
	result *= compare_int((blockC.f), 0);
	result *= compare_u16vec3(uvec3(blockC.g), uvec3(0u, 0u, 0u));
	result *= compare_float((blockD[0].h), 0.0);
	result *= compare_uvec2((blockD[0].i), uvec2(0u, 0u));
	result *= compare_int16_t(int(blockD[0].j), 0);
	result *= compare_float((blockD[1].h), 0.0);
	result *= compare_uvec2((blockD[1].i), uvec2(0u, 0u));
	result *= compare_int16_t(int(blockD[1].j), 0);
	result *= compare_float((blockD[2].h), 0.0);
	result *= compare_uvec2((blockD[2].i), uvec2(0u, 0u));
	result *= compare_int16_t(int(blockD[2].j), 0);
	result *= compare_mat4((blockE.k), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockE.l.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_float16_t(float(blockE.m), 0.0);
	result *= compare_ivec2((blockE.n), ivec2(0, 0));
	result *= compare_bvec3((blockE.o), bvec3(false, false, false));
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
	mediump mat3 mA; // unused in fragment shader
	mediump uvec2 mB;
	mediump mat3 mC; // unused in fragment shader
	lowp ivec2 mD;
};
struct sB
{
	f16vec3 mA;
	bvec2 mB;
	mediump mat3x4 mC;
	f16vec3 mD;
};
struct sC
{
	sB mA;
	mediump vec4 mB;
	f16vec3 mC;
	i16vec3 mD;
};
struct sD
{
	highp uvec2 mA;
	highp mat2 mB; // unused in fragment shader
	mediump vec3 mC;
	mediump uvec2 mD;
};
struct sE
{
	i16vec4 mA;
	u16vec2 mB;
	highp mat2 mC;
};
struct sF
{
	lowp mat2x3 mA;
	bvec4 mB; // unused in vertex shader
	highp int mC; // unused in fragment shader
	highp uvec4 mD;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	sA a;
	sC b;
	u16vec4 c; // unused in vertex shader
	uint16_t d;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump uvec3 e; // unused in vertex shader
	mediump vec4 f; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp mat4 g; // unused in vertex shader
	lowp mat2x3 h;
	mediump ivec4 i;
	int16_t j; // unused in fragment shader
	bool k; // unused in vertex shader
};
layout(set = 0, binding = 4) uniform BlockF
{
	sF o; // unused in fragment shader
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec2((a.mB), uvec2(0u, 0u));
	result *= compare_ivec2((a.mD), ivec2(0, 0));
	result *= compare_f16vec3(vec3(b.mA.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec2((b.mA.mB), bvec2(false, false));
	result *= compare_mat3x4((b.mA.mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(b.mA.mD), vec3(0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(b.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(b.mD), ivec3(0, 0, 0));
	result *= compare_u16vec4(uvec4(c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint16_t(uint(d), 0u);
	result *= compare_uvec3((blockC.e), uvec3(0u, 0u, 0u));
	result *= compare_mat4((g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((i), ivec4(0, 0, 0, 0));
	result *= compare_bool((k), false);
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
	mediump mat3 mA; // unused in fragment shader
	mediump uvec2 mB;
	mediump mat3 mC; // unused in fragment shader
	lowp ivec2 mD;
};
struct sB
{
	f16vec3 mA;
	bvec2 mB;
	mediump mat3x4 mC;
	f16vec3 mD;
};
struct sC
{
	sB mA;
	mediump vec4 mB;
	f16vec3 mC;
	i16vec3 mD;
};
struct sD
{
	highp uvec2 mA;
	highp mat2 mB; // unused in fragment shader
	mediump vec3 mC;
	mediump uvec2 mD;
};
struct sE
{
	i16vec4 mA;
	u16vec2 mB;
	highp mat2 mC;
};
struct sF
{
	lowp mat2x3 mA;
	bvec4 mB; // unused in vertex shader
	highp int mC; // unused in fragment shader
	highp uvec4 mD;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	sA a;
	sC b;
	u16vec4 c; // unused in vertex shader
	uint16_t d;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	mediump uvec3 e; // unused in vertex shader
	mediump vec4 f; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp mat4 g; // unused in vertex shader
	lowp mat2x3 h;
	mediump ivec4 i;
	int16_t j; // unused in fragment shader
	bool k; // unused in vertex shader
};
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	sD l;
	i16vec4 m;
	sE n; // unused in vertex shader
} blockE[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3((a.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((a.mB), uvec2(0u, 0u));
	result *= compare_mat3((a.mC), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((a.mD), ivec2(0, 0));
	result *= compare_f16vec3(vec3(b.mA.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec2((b.mA.mB), bvec2(false, false));
	result *= compare_mat3x4((b.mA.mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(b.mA.mD), vec3(0.0, 0.0, 0.0));
	result *= compare_vec4((b.mB), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(b.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(b.mD), ivec3(0, 0, 0));
	result *= compare_uint16_t(uint(d), 0u);
	result *= compare_vec4((blockC.f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((i), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(j), 0);
	result *= compare_uvec2((blockE[0].l.mA), uvec2(0u, 0u));
	result *= compare_mat2((blockE[0].l.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[0].l.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE[0].l.mD), uvec2(0u, 0u));
	result *= compare_i16vec4(ivec4(blockE[0].m), ivec4(0, 0, 0, 0));
	result *= compare_uvec2((blockE[1].l.mA), uvec2(0u, 0u));
	result *= compare_mat2((blockE[1].l.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockE[1].l.mC), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE[1].l.mD), uvec2(0u, 0u));
	result *= compare_i16vec4(ivec4(blockE[1].m), ivec4(0, 0, 0, 0));
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
	lowp vec3 mA;
};
struct sB
{
	highp ivec2 mA; // unused in vertex shader
};
struct sC
{
	bvec2 mA;
	bvec2 mB; // unused in vertex shader
	sA mC;
	sB mD;
};
struct sD
{
	i16vec3 mA; // unused in fragment shader
	bvec2 mB;
	bvec3 mC;
	highp ivec2 mD; // unused in vertex shader
};
struct sE
{
	bvec2 mA;
	highp mat2 mB;
	lowp ivec3 mC;
	highp mat3x2 mD;
};
struct sF
{
	lowp ivec2 mA;
	highp uvec2 mB;
	sE mC;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	i16vec2 n;
	sF o;
	mediump ivec4 p[2]; // unused in both shaders
	float16_t q[7];
	highp vec3 r[3];
} blockF[1];
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	int16_t s;
	f16vec2 t;
	lowp uint u;
	lowp ivec3 v;
	bvec3 w; // unused in vertex shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(blockF[0].n), ivec2(0, 0));
	result *= compare_ivec2((blockF[0].o.mA), ivec2(0, 0));
	result *= compare_uvec2((blockF[0].o.mB), uvec2(0u, 0u));
	result *= compare_bvec2((blockF[0].o.mC.mA), bvec2(false, false));
	result *= compare_mat2((blockF[0].o.mC.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockF[0].o.mC.mC), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockF[0].o.mC.mD), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockF[0].p[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockF[0].p[1]), ivec4(0, 0, 0, 0));
	result *= compare_float16_t(float(blockF[0].q[0]), 0.0);
	result *= compare_float16_t(float(blockF[0].q[1]), 0.0);
	result *= compare_float16_t(float(blockF[0].q[2]), 0.0);
	result *= compare_float16_t(float(blockF[0].q[3]), 0.0);
	result *= compare_float16_t(float(blockF[0].q[4]), 0.0);
	result *= compare_float16_t(float(blockF[0].q[5]), 0.0);
	result *= compare_float16_t(float(blockF[0].q[6]), 0.0);
	result *= compare_vec3((blockF[0].r[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockF[0].r[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockF[0].r[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockG.s), 0);
	result *= compare_f16vec2(vec2(blockG.t), vec2(0.0, 0.0));
	result *= compare_uint((blockG.u), 0u);
	result *= compare_ivec3((blockG.v), ivec3(0, 0, 0));
	result *= compare_bvec3((blockG.w), bvec3(false, false, false));
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
	lowp vec3 mA;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	lowp mat3x4 l;
	u16vec2 m;
	f16vec4 n;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	sA o; // unused in vertex shader
	lowp mat4 p; // unused in fragment shader
	i16vec4 q; // unused in fragment shader
	int16_t r;
	f16vec2 s;
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
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((l), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(m), uvec2(0u, 0u));
	result *= compare_f16vec4(vec4(n), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((o.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4((p), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(q), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(r), 0);
	result *= compare_f16vec2(vec2(s), vec2(0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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
	highp vec2 l;
	f16vec4 m;
	highp ivec2 n;
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	highp mat4x3 o;
	int16_t p; // unused in vertex shader
	u16vec3 q;
} blockH[1];
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	f16vec4 r;
	lowp int s;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((blockG.l), vec2(0.0, 0.0));
	result *= compare_f16vec4(vec4(blockG.m), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG.n), ivec2(0, 0));
	result *= compare_mat4x3((blockH[0].o), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockH[0].p), 0);
	result *= compare_u16vec3(uvec3(blockH[0].q), uvec3(0u, 0u, 0u));
	result *= compare_f16vec4(vec4(blockI.r), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockI.s), 0);
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
	uint16_t mA; // unused in fragment shader
	lowp vec4 mB;
	mediump float mC;
};
struct sB
{
	sA mA;
	highp mat2x3 mB;
	highp ivec4 mC; // unused in vertex shader
};
struct sC
{
	float16_t mA;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp ivec4 r;
	uint16_t s;
	mediump mat4 t; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((r), ivec4(0, 0, 0, 0));
	result *= compare_uint16_t(uint(s), 0u);
	result *= compare_mat4((t), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp vec2 mA;
};
struct sB
{
	bvec4 mA[6];
	i16vec3 mB;
	mediump uint mC;
};
struct sC
{
	lowp ivec2 mA[2];
	bvec2 mB;
	i16vec2 mC;
	highp vec4 mD[4]; // unused in vertex shader
};
struct sD
{
	lowp mat2x3 mA;
	lowp int mB;
};
struct sE
{
	f16vec4 mA;
	highp ivec4 mB;
};
struct sF
{
	u16vec3 mA;
	highp mat2 mB;
	highp mat3x2 mC;
};
struct sG
{
	bool mA;
	sF mB;
	u16vec4 mC;
	u16vec2 mD;
};
struct sH
{
	uint16_t mA;
	i16vec2 mB;
	lowp vec2 mC;
};
struct sI
{
	i16vec2 mA;
	bool mB;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 64) sG v;
	layout(offset = 0) highp mat2x3 t;
	layout(offset = 48) bvec3 u;
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	layout(offset = 176) mediump mat3x2 aa;
	layout(offset = 0) bvec4 w[1];
	layout(offset = 112) lowp mat4 z; // unused in vertex shader
	layout(offset = 16) sH x;
	layout(offset = 32) sI y[5];
} blockH[1];
layout(set = 0, binding = 7, std140) uniform BlockI
{
	layout(offset = 0) mediump ivec4 ab;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
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
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((t), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((u), bvec3(false, false, false));
	result *= compare_bool((v.mA), false);
	result *= compare_u16vec3(uvec3(v.mB.mA), uvec3(0u, 0u, 0u));
	result *= compare_mat2((v.mB.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((v.mB.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(v.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec2(uvec2(v.mD), uvec2(0u, 0u));
	result *= compare_bvec4((blockH[0].w[0]), bvec4(false, false, false, false));
	result *= compare_uint16_t(uint(blockH[0].x.mA), 0u);
	result *= compare_i16vec2(ivec2(blockH[0].x.mB), ivec2(0, 0));
	result *= compare_vec2((blockH[0].x.mC), vec2(0.0, 0.0));
	result *= compare_i16vec2(ivec2(blockH[0].y[0].mA), ivec2(0, 0));
	result *= compare_bool((blockH[0].y[0].mB), false);
	result *= compare_i16vec2(ivec2(blockH[0].y[1].mA), ivec2(0, 0));
	result *= compare_bool((blockH[0].y[1].mB), false);
	result *= compare_i16vec2(ivec2(blockH[0].y[2].mA), ivec2(0, 0));
	result *= compare_bool((blockH[0].y[2].mB), false);
	result *= compare_i16vec2(ivec2(blockH[0].y[3].mA), ivec2(0, 0));
	result *= compare_bool((blockH[0].y[3].mB), false);
	result *= compare_i16vec2(ivec2(blockH[0].y[4].mA), ivec2(0, 0));
	result *= compare_bool((blockH[0].y[4].mB), false);
	result *= compare_mat4((blockH[0].z), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[0].aa), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockI.ab), ivec4(0, 0, 0, 0));
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
	i16vec3 mA;
	highp mat3 mB;
	bvec3 mC;
};
struct sB
{
	bvec4 mA;
	i16vec3 mB;
	f16vec2 mC; // unused in fragment shader
	highp ivec2 mD;
};
struct sC
{
	f16vec4 mA; // unused in vertex shader
};
struct sD
{
	f16vec3 mA; // unused in fragment shader
	i16vec3 mB; // unused in both shaders
};
struct sE
{
	lowp ivec2 mA[8][5];
	sD mB;
	f16vec4 mC;
	u16vec2 mD;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	layout(offset = 16) highp mat3x4 o[1];
	layout(offset = 0) mediump ivec3 n;
} blockG;
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	layout(offset = 52) u16vec2 r; // unused in vertex shader
	layout(offset = 0) lowp mat3x4 p;
	layout(offset = 48) int16_t q;
};
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	layout(offset = 688) mediump uvec4 u;
	layout(offset = 0) sE s;
	layout(offset = 672) lowp vec2 t;
};
layout(set = 0, binding = 8) uniform BlockJ
{
	layout(offset = 80) lowp uint z;
	layout(offset = 0) mediump int v;
	layout(offset = 72) f16vec3 y;
	layout(offset = 16) u16vec3 w[3]; // unused in fragment shader
	layout(offset = 64) highp vec2 x; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((blockG.n), ivec3(0, 0, 0));
	result *= compare_mat3x4((blockG.o[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(q), 0);
	result *= compare_u16vec2(uvec2(r), uvec2(0u, 0u));
	result *= compare_ivec2((s.mA[0][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[0][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[0][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[0][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[0][4]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[1][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[1][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[1][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[1][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[1][4]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[2][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[2][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[2][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[2][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[2][4]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[3][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[3][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[3][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[3][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[3][4]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[4][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[4][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[4][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[4][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[4][4]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[5][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[5][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[5][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[5][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[5][4]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[6][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[6][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[6][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[6][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[6][4]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[7][0]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[7][1]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[7][2]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[7][3]), ivec2(0, 0));
	result *= compare_ivec2((s.mA[7][4]), ivec2(0, 0));
	result *= compare_f16vec3(vec3(s.mB.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(s.mB.mB), ivec3(0, 0, 0));
	result *= compare_f16vec4(vec4(s.mC), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(s.mD), uvec2(0u, 0u));
	result *= compare_vec2((t), vec2(0.0, 0.0));
	result *= compare_uvec4((u), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((v), 0);
	result *= compare_u16vec3(uvec3(w[0]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(w[1]), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(w[2]), uvec3(0u, 0u, 0u));
	result *= compare_vec2((x), vec2(0.0, 0.0));
	result *= compare_f16vec3(vec3(y), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((z), 0u);
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
	mediump vec2 mA;
	mediump mat4x2 mB;
};
struct sB
{
	highp mat3x4 mA;
	mediump mat3 mB;
};
struct sC
{
	highp uvec3 mA;
	mediump mat4x2 mB;
	int16_t mC; // unused in fragment shader
};
layout(set = 0, binding = 4, std430, column_major) uniform BlockF
{
	layout(offset = 0) lowp int l; // unused in fragment shader
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	layout(offset = 0) sB m;
};
layout(set = 0, binding = 6, scalar, column_major) uniform BlockH
{
	layout(offset = 72) highp ivec2 p; // unused in vertex shader
	layout(offset = 0) mediump mat4 n;
	layout(offset = 64) mediump uvec2 o[1]; // unused in vertex shader
};
layout(set = 0, binding = 7, std430, row_major) uniform BlockI
{
	layout(offset = 144) i16vec4 t;
	layout(offset = 0) u16vec3 q; // unused in fragment shader
	layout(offset = 80) sC s;
	layout(offset = 16) lowp mat3x4 r; // unused in vertex shader
} blockI;

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
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((l), 0);
	result *= compare_mat3x4((m.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((m.mB), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((n), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((o[0]), uvec2(0u, 0u));
	result *= compare_ivec2((p), ivec2(0, 0));
	result *= compare_u16vec3(uvec3(blockI.q), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockI.r), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockI.s.mA), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockI.s.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(blockI.s.mC), 0);
	result *= compare_i16vec4(ivec4(blockI.t), ivec4(0, 0, 0, 0));
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
	uint16_t mA;
	highp uvec2 mB;
};
struct sB
{
	mediump vec2 mA;
	i16vec2 mB;
	highp vec2 mC; // unused in fragment shader
};
struct sC
{
	highp mat4x3 mA; // unused in fragment shader
	bvec2 mB;
	bvec2 mC;
};
layout(set = 0, binding = 5, std430) uniform BlockG
{
	layout(offset = 88) f16vec3 s; // unused in fragment shader
	layout(offset = 0) mediump mat4 o;
	layout(offset = 80) highp float r;
	layout(offset = 64) mediump float p;
	layout(offset = 72) f16vec4 q;
};
layout(set = 0, binding = 6, scalar, row_major) uniform BlockH
{
	layout(offset = 12) lowp mat2x3 u; // unused in fragment shader
	layout(offset = 0) lowp ivec3 t;
} blockH;
layout(set = 0, binding = 7, scalar, row_major) uniform BlockI
{
	layout(offset = 112) highp mat2 z; // unused in fragment shader
	layout(offset = 0) lowp mat3x2 v;
	layout(offset = 104) f16vec3 y;
	layout(offset = 24) lowp mat2 w;
	layout(offset = 40) sC x; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4((o), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((p), 0.0);
	result *= compare_f16vec4(vec4(q), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((r), 0.0);
	result *= compare_f16vec3(vec3(s), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH.t), ivec3(0, 0, 0));
	result *= compare_mat2x3((blockH.u), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((v), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((w), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((x.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((x.mB), bvec2(false, false));
	result *= compare_bvec2((x.mC), bvec2(false, false));
	result *= compare_f16vec3(vec3(y), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((z), mat2(0.0, 0.0, 0.0, 0.0));
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
	u16vec2 mA; // unused in fragment shader
};
struct sB
{
	highp ivec2 mA;
};
struct sC
{
	lowp mat3 mA; // unused in vertex shader
	lowp uint mB;
};
layout(set = 0, binding = 5) uniform BlockG
{
	layout(offset = 112) f16vec2 t;
	layout(offset = 0) u16vec4 q;
	layout(offset = 80) lowp mat2 s;
	layout(offset = 16) mediump mat4x2 r;
};
layout(set = 0, binding = 6, scalar) uniform BlockH
{
	layout(offset = 0) mediump uvec3 u;
};
layout(set = 0, binding = 7) uniform BlockI
{
	layout(offset = 0) mediump ivec4 v; // unused in vertex shader
} blockI;
layout(set = 0, binding = 8, std430, row_major) uniform BlockJ
{
	layout(offset = 16) sC x;
	layout(offset = 0) f16vec4 w;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_u16vec4(uvec4(q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x2((r), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((s), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec2(vec2(t), vec2(0.0, 0.0));
	result *= compare_uvec3((u), uvec3(0u, 0u, 0u));
	result *= compare_ivec4((blockI.v), ivec4(0, 0, 0, 0));
	result *= compare_f16vec4(vec4(w), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((x.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((x.mB), 0u);
    imageStore(outImage, coord, vec4(result));
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
	highp mat3x4 p;
	lowp ivec4 q;
	i16vec3 r;
	lowp mat3x4 s; // unused in fragment shader
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	u16vec4 t;
	u16vec2 u;
	lowp vec2 v; // unused in fragment shader
	mediump ivec2 w;
} blockH;
layout(set = 0, binding = 7, scalar) uniform BlockI
{
	mediump uvec2 x;
	bvec3 y;
	mediump mat3 z;
	i16vec2 aa;
	highp int ab;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((q), ivec4(0, 0, 0, 0));
	result *= compare_i16vec3(ivec3(r), ivec3(0, 0, 0));
	result *= compare_mat3x4((s), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockH.t), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec2(uvec2(blockH.u), uvec2(0u, 0u));
	result *= compare_vec2((blockH.v), vec2(0.0, 0.0));
	result *= compare_ivec2((blockH.w), ivec2(0, 0));
	result *= compare_uvec2((blockI.x), uvec2(0u, 0u));
	result *= compare_bvec3((blockI.y), bvec3(false, false, false));
	result *= compare_mat3((blockI.z), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(blockI.aa), ivec2(0, 0));
	result *= compare_int((blockI.ab), 0);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4) uniform BlockF
{
	uint8_t l;
	int8_t m;
	uint8_t n;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	lowp float o; // unused in vertex shader
	uint8_t p;
	uint8_t q;
	uint8_t r; // unused in fragment shader
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	uint8_t s;
	lowp int t;
	lowp float u;
	lowp uint v;
	highp int w;
} blockH;
layout(set = 0, binding = 7, std140) uniform BlockI
{
	uint8_t x;
	int8_t y;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(l), 0u);
	result *= compare_int8_t(int(m), 0);
	result *= compare_uint8_t(uint(n), 0u);
	result *= compare_float((o), 0.0);
	result *= compare_uint8_t(uint(p), 0u);
	result *= compare_uint8_t(uint(q), 0u);
	result *= compare_uint8_t(uint(r), 0u);
	result *= compare_uint8_t(uint(blockH.s), 0u);
	result *= compare_int((blockH.t), 0);
	result *= compare_float((blockH.u), 0.0);
	result *= compare_uint((blockH.v), 0u);
	result *= compare_int((blockH.w), 0);
	result *= compare_uint8_t(uint(blockI.x), 0u);
	result *= compare_int8_t(int(blockI.y), 0);
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
	mediump ivec3 a;
	lowp ivec2 b;
	i8vec4 c;
	mediump vec4 d; // unused in vertex shader
};
layout(set = 0, binding = 3) uniform BlockE
{
	mediump uvec3 m;
	int8_t n;
};
layout(set = 0, binding = 4) uniform BlockF
{
	bvec3 o;
	i8vec4 p; // unused in fragment shader
	lowp int q;
	highp uvec2 r;
	uint8_t s;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	bool t; // unused in vertex shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((a), ivec3(0, 0, 0));
	result *= compare_ivec2((b), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(c), ivec4(0, 0, 0, 0));
	result *= compare_vec4((d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((m), uvec3(0u, 0u, 0u));
	result *= compare_int8_t(int(n), 0);
	result *= compare_bvec3((o), bvec3(false, false, false));
	result *= compare_int((q), 0);
	result *= compare_uvec2((r), uvec2(0u, 0u));
	result *= compare_uint8_t(uint(s), 0u);
	result *= compare_bool((blockG.t), false);
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
	lowp ivec2 b;
	i8vec4 c;
	mediump vec4 d; // unused in vertex shader
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	i8vec4 e;
	mediump vec3 f;
	i8vec2 g;
	lowp vec3 h; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp float i;
	bvec2 j;
	mediump ivec4 k;
	mediump uint l; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((a), ivec3(0, 0, 0));
	result *= compare_ivec2((b), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(c), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockC.e), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockC.f), vec3(0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockC.g), ivec2(0, 0));
	result *= compare_vec3((blockC.h), vec3(0.0, 0.0, 0.0));
	result *= compare_float((i), 0.0);
	result *= compare_bvec2((j), bvec2(false, false));
	result *= compare_ivec4((k), ivec4(0, 0, 0, 0));
	result *= compare_uint((l), 0u);
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
	highp ivec4 a; // unused in both shaders
	int8_t b; // unused in vertex shader
	bvec3 c;
	lowp float d; // unused in vertex shader
	u8vec4 e; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp uvec3 f; // unused in fragment shader
	lowp uvec2 g; // unused in both shaders
	highp uint h;
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump vec2 i;
	int8_t j; // unused in vertex shader
	u8vec4 k;
	u8vec4 l;
};
layout(set = 0, binding = 3) uniform BlockE
{
	bvec4 m; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int8_t(int(blockB.b), 0);
	result *= compare_bvec3((blockB.c), bvec3(false, false, false));
	result *= compare_float((blockB.d), 0.0);
	result *= compare_uint((h), 0u);
	result *= compare_vec2((i), vec2(0.0, 0.0));
	result *= compare_int8_t(int(j), 0);
	result *= compare_u8vec4(uvec4(k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(l), uvec4(0u, 0u, 0u, 0u));
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
	highp ivec4 a; // unused in both shaders
	int8_t b; // unused in vertex shader
	bvec3 c;
	lowp float d; // unused in vertex shader
	u8vec4 e; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp uvec3 f; // unused in fragment shader
	lowp uvec2 g; // unused in both shaders
	highp uint h;
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump vec2 i;
	int8_t j; // unused in vertex shader
	u8vec4 k;
	u8vec4 l;
};
layout(set = 0, binding = 3) uniform BlockE
{
	bvec4 m; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec3((blockB.c), bvec3(false, false, false));
	result *= compare_u8vec4(uvec4(blockB.e), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec3((f), uvec3(0u, 0u, 0u));
	result *= compare_uint((h), 0u);
	result *= compare_vec2((i), vec2(0.0, 0.0));
	result *= compare_u8vec4(uvec4(k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(l), uvec4(0u, 0u, 0u, 0u));
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
	u8vec2 a;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump float b;
	mediump ivec2 c;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	i8vec3 d; // unused in vertex shader
	uint8_t e; // unused in fragment shader
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	mediump uvec4 g;
	lowp vec3 h;
	uint8_t i; // unused in fragment shader
	bvec2 j;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(blockB.a), uvec2(0u, 0u));
	result *= compare_float((blockC.b), 0.0);
	result *= compare_ivec2((blockC.c), ivec2(0, 0));
	result *= compare_i8vec3(ivec3(d), ivec3(0, 0, 0));
	result *= compare_uvec4((blockF.g), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((blockF.h), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec2((blockF.j), bvec2(false, false));
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
	u8vec2 a;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump float b;
	mediump ivec2 c;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	i8vec3 d; // unused in vertex shader
	uint8_t e; // unused in fragment shader
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	i8vec3 f; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u8vec2(uvec2(blockB.a), uvec2(0u, 0u));
	result *= compare_float((blockC.b), 0.0);
	result *= compare_ivec2((blockC.c), ivec2(0, 0));
	result *= compare_uint8_t(uint(e), 0u);
	result *= compare_i8vec3(ivec3(blockE.f), ivec3(0, 0, 0));
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
	i8vec2 a;
	u8vec4 b;
	mediump mat4 c;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump uvec3 d; // unused in fragment shader
	lowp uvec2 e; // unused in fragment shader
	bvec3 f;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump ivec2 g; // unused in fragment shader
	u8vec2 h;
	bvec2 i;
	highp float j;
};
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	lowp mat3x4 k; // unused in fragment shader
	uint8_t l;
	uint8_t m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(blockB.a), ivec2(0, 0));
	result *= compare_u8vec4(uvec4(blockB.b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4((blockB.c), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockC.f), bvec3(false, false, false));
	result *= compare_u8vec2(uvec2(h), uvec2(0u, 0u));
	result *= compare_bvec2((i), bvec2(false, false));
	result *= compare_float((j), 0.0);
	result *= compare_uint8_t(uint(blockE.l), 0u);
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
	i8vec2 a;
	u8vec4 b;
	mediump mat4 c;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump uvec3 d; // unused in fragment shader
	lowp uvec2 e; // unused in fragment shader
	bvec3 f;
} blockC;
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump ivec2 g; // unused in fragment shader
	u8vec2 h;
	bvec2 i;
	highp float j;
};
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	lowp mat3x4 k; // unused in fragment shader
	uint8_t l;
	uint8_t m;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(blockB.a), ivec2(0, 0));
	result *= compare_u8vec4(uvec4(blockB.b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4((blockB.c), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockC.d), uvec3(0u, 0u, 0u));
	result *= compare_uvec2((blockC.e), uvec2(0u, 0u));
	result *= compare_bvec3((blockC.f), bvec3(false, false, false));
	result *= compare_ivec2((g), ivec2(0, 0));
	result *= compare_u8vec2(uvec2(h), uvec2(0u, 0u));
	result *= compare_bvec2((i), bvec2(false, false));
	result *= compare_float((j), 0.0);
	result *= compare_mat3x4((blockE.k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(blockE.l), 0u);
	result *= compare_uint8_t(uint(blockE.m), 0u);
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
	i8vec2 a;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat2 b;
	lowp int c;
	lowp vec4 d;
	u8vec2 e; // unused in fragment shader
	lowp float f;
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	lowp mat4 g;
	i8vec2 h; // unused in fragment shader
	bool i;
} blockD;
layout(set = 0, binding = 4, std140) uniform BlockF
{
	bvec4 l; // unused in both shaders
	u8vec2 m; // unused in fragment shader
	lowp uvec4 n;
	lowp vec2 o;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(a), ivec2(0, 0));
	result *= compare_mat2((blockC.b), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockC.c), 0);
	result *= compare_vec4((blockC.d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockC.f), 0.0);
	result *= compare_mat4((blockD.g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.i), false);
	result *= compare_uvec4((n), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec2((o), vec2(0.0, 0.0));
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
	i8vec2 a;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat2 b;
	lowp int c;
	lowp vec4 d;
	u8vec2 e; // unused in fragment shader
	lowp float f;
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	lowp mat4 g;
	i8vec2 h; // unused in fragment shader
	bool i;
} blockD;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	mediump ivec4 j; // unused in vertex shader
	mediump mat3 k; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(a), ivec2(0, 0));
	result *= compare_mat2((blockC.b), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockC.c), 0);
	result *= compare_vec4((blockC.d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec2(uvec2(blockC.e), uvec2(0u, 0u));
	result *= compare_float((blockC.f), 0.0);
	result *= compare_mat4((blockD.g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockD.h), ivec2(0, 0));
	result *= compare_bool((blockD.i), false);
	result *= compare_mat3((k), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp uvec4 n;
	lowp uvec3 o;
} blockG;
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	bvec2 p; // unused in vertex shader
	lowp vec2 q;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec4((blockG.n), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec3((blockG.o), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((p), bvec2(false, false));
	result *= compare_vec2((q), vec2(0.0, 0.0));
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
	lowp mat3x4 a;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp ivec2 b; // unused in vertex shader
	highp vec4 c;
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	mediump mat4x2 f;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((b), ivec2(0, 0));
	result *= compare_vec4((c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((f), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp mat3x4 a;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp ivec2 b; // unused in vertex shader
	highp vec4 c;
};
layout(set = 0, binding = 2, column_major) uniform BlockD
{
	mediump mat2x3 d;
	highp mat4 e;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((d), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((e), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
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
	mediump mat3x4 a;
	lowp vec4 b;
	u8vec3 c;
	highp uint d; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	i8vec4 e;
};
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	bvec2 f;
	u8vec2 g[6];
	lowp uint h; // unused in fragment shader
	highp mat2x3 i;
};
layout(set = 0, binding = 4) uniform BlockF
{
	highp int m; // unused in fragment shader
	mediump vec3 n;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3x4((blockB.a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockB.b), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockB.c), uvec3(0u, 0u, 0u));
	result *= compare_i8vec4(ivec4(e), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((f), bvec2(false, false));
	result *= compare_u8vec2(uvec2(g[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[4]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[5]), uvec2(0u, 0u));
	result *= compare_mat2x3((i), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140, row_major) uniform BlockB
{
	mediump mat3x4 a;
	lowp vec4 b;
	u8vec3 c;
	highp uint d; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	i8vec4 e;
};
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	bvec2 f;
	u8vec2 g[6];
	lowp uint h; // unused in fragment shader
	highp mat2x3 i;
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	bool j;
	mediump ivec2 k;
	i8vec2 l;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat3x4((blockB.a), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockB.b), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockB.c), uvec3(0u, 0u, 0u));
	result *= compare_uint((blockB.d), 0u);
	result *= compare_i8vec4(ivec4(e), ivec4(0, 0, 0, 0));
	result *= compare_bvec2((f), bvec2(false, false));
	result *= compare_u8vec2(uvec2(g[0]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[1]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[2]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[3]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[4]), uvec2(0u, 0u));
	result *= compare_u8vec2(uvec2(g[5]), uvec2(0u, 0u));
	result *= compare_uint((h), 0u);
	result *= compare_mat2x3((i), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockE.j), false);
	result *= compare_ivec2((blockE.k), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(blockE.l), ivec2(0, 0));
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
	i8vec4 p; // unused in both shaders
	lowp mat3 q; // unused in fragment shader
	uint8_t r;
	lowp uvec4 s;
	lowp uvec3 t;
};
layout(set = 0, binding = 5) uniform BlockG
{
	lowp mat4x2 u;
	bool v; // unused in fragment shader
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	highp vec4 w;
	i8vec2 x;
	highp mat2x3 y; // unused in fragment shader
	mediump mat2 z;
} blockH[2];

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
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(p), ivec4(0, 0, 0, 0));
	result *= compare_mat3((q), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(r), 0u);
	result *= compare_uvec4((s), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec3((t), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((u), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((v), false);
	result *= compare_vec4((blockH[0].w), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockH[0].x), ivec2(0, 0));
	result *= compare_mat2x3((blockH[0].y), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH[0].z), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockH[1].w), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockH[1].x), ivec2(0, 0));
	result *= compare_mat2x3((blockH[1].y), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockH[1].z), mat2(0.0, 0.0, 0.0, 0.0));
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
	int8_t mA;
	mediump vec3 mB; // unused in vertex shader
	highp mat2x3 mC; // unused in fragment shader
	lowp mat2 mD; // unused in both shaders
};
struct sB
{
	int8_t mA;
	u8vec2 mB; // unused in both shaders
	mediump ivec4 mC;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	highp vec4 i;
	highp mat2x3 j;
	mediump vec2 k;
	u8vec2 l;
};
layout(set = 0, binding = 5) uniform BlockG
{
	sA m;
	sB n; // unused in vertex shader
	highp mat4x3 o;
	lowp ivec3 p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((i), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((j), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((k), vec2(0.0, 0.0));
	result *= compare_u8vec2(uvec2(l), uvec2(0u, 0u));
	result *= compare_int8_t(int(m.mA), 0);
	result *= compare_vec3((m.mB), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2x3((m.mC), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((m.mD), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(n.mA), 0);
	result *= compare_u8vec2(uvec2(n.mB), uvec2(0u, 0u));
	result *= compare_ivec4((n.mC), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((o), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((p), ivec3(0, 0, 0));
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
	highp vec2 mB;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	uint8_t a;
	u8vec2 b; // unused in both shaders
	bvec4 c; // unused in fragment shader
	u8vec3 d;
} blockB[2];
layout(set = 0, binding = 2, std140) uniform BlockD
{
	sA h; // unused in both shaders
} blockD;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	highp uvec3 i;
	bvec2 j;
	highp mat3x4 k; // unused in both shaders
} blockE[3];
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	lowp mat3x4 l;
	highp ivec2 m;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockB[0].a), 0u);
	result *= compare_u8vec3(uvec3(blockB[0].d), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(blockB[1].a), 0u);
	result *= compare_u8vec3(uvec3(blockB[1].d), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((blockE[0].i), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((blockE[0].j), bvec2(false, false));
	result *= compare_uvec3((blockE[1].i), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((blockE[1].j), bvec2(false, false));
	result *= compare_uvec3((blockE[2].i), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((blockE[2].j), bvec2(false, false));
	result *= compare_mat3x4((blockF.l), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockF.m), ivec2(0, 0));
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
	highp vec2 mB;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	uint8_t a;
	u8vec2 b; // unused in both shaders
	bvec4 c; // unused in fragment shader
	u8vec3 d;
} blockB[2];
layout(set = 0, binding = 1, std140) uniform BlockC
{
	u8vec4 e; // unused in both shaders
	lowp mat3 f;
	lowp vec3 g;
} blockC;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockB[0].a), 0u);
	result *= compare_bvec4((blockB[0].c), bvec4(false, false, false, false));
	result *= compare_u8vec3(uvec3(blockB[0].d), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(blockB[1].a), 0u);
	result *= compare_bvec4((blockB[1].c), bvec4(false, false, false, false));
	result *= compare_u8vec3(uvec3(blockB[1].d), uvec3(0u, 0u, 0u));
	result *= compare_mat3((blockC.f), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC.g), vec3(0.0, 0.0, 0.0));
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
	mediump mat3x2 mA;
	lowp mat4 mB;
	highp uvec3 mC; // unused in vertex shader
	lowp mat3x2 mD; // unused in both shaders
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	i8vec2 a;
	i8vec4 b[7];
} blockB;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	mediump uvec4 e; // unused in vertex shader
	mediump uvec2 f;
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	highp uvec2 g;
	i8vec2 h; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(blockB.a), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[4]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[5]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[6]), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((blockD.e), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((blockD.f), uvec2(0u, 0u));
	result *= compare_uvec2((blockE.g), uvec2(0u, 0u));
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
	mediump mat3x2 mA;
	lowp mat4 mB;
	highp uvec3 mC; // unused in vertex shader
	lowp mat3x2 mD; // unused in both shaders
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	i8vec2 a;
	i8vec4 b[7];
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	sA c;
	mediump mat4x3 d;
} blockC;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec2(ivec2(blockB.a), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[0]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[1]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[2]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[3]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[4]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[5]), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockB.b[6]), ivec4(0, 0, 0, 0));
	result *= compare_mat3x2((blockC.c.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockC.c.mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockC.d), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x3 mA;
};
struct sB
{
	highp mat4x2 mA; // unused in both shaders
	bvec4 mB;
	sA mC; // unused in fragment shader
	lowp mat4x3 mD;
};
struct sC
{
	lowp mat3x4 mA[6]; // unused in fragment shader
	highp vec4 mB;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	uint8_t a;
	u8vec4 b;
	sB c; // unused in fragment shader
	lowp uint d;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp float e;
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	highp uint f;
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	sC g;
	lowp ivec4 h; // unused in vertex shader
	bool i; // unused in fragment shader
	highp mat3x4 j;
	u8vec4 k; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(a), 0u);
	result *= compare_u8vec4(uvec4(b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((d), 0u);
	result *= compare_float((e), 0.0);
	result *= compare_uint((f), 0u);
	result *= compare_vec4((g.mB), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((h), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((j), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat2x3 mA;
};
struct sB
{
	highp mat4x2 mA; // unused in both shaders
	bvec4 mB;
	sA mC; // unused in fragment shader
	lowp mat4x3 mD;
};
struct sC
{
	lowp mat3x4 mA[6]; // unused in fragment shader
	highp vec4 mB;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	uint8_t a;
	u8vec4 b;
	sB c; // unused in fragment shader
	lowp uint d;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp float e;
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	highp uint f;
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	sC g;
	lowp ivec4 h; // unused in vertex shader
	bool i; // unused in fragment shader
	highp mat3x4 j;
	u8vec4 k; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(a), 0u);
	result *= compare_u8vec4(uvec4(b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((c.mB), bvec4(false, false, false, false));
	result *= compare_mat2x3((c.mC.mA), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((c.mD), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((d), 0u);
	result *= compare_float((e), 0.0);
	result *= compare_uint((f), 0u);
	result *= compare_mat3x4((g.mA[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((g.mA[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((g.mA[2]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((g.mA[3]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((g.mA[4]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((g.mA[5]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((g.mB), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((i), false);
	result *= compare_mat3x4((j), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp uvec3 a;
	lowp mat2 b;
	mediump ivec4 c; // unused in vertex shader
	mediump mat3x4 d;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump ivec2 e;
} blockC[2];
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp vec2 f;
} blockD;
layout(set = 0, binding = 4, std140) uniform BlockF
{
	highp float i;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec3((a), uvec3(0u, 0u, 0u));
	result *= compare_mat2((b), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((c), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((d), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC[0].e), ivec2(0, 0));
	result *= compare_ivec2((blockC[1].e), ivec2(0, 0));
	result *= compare_vec2((blockD.f), vec2(0.0, 0.0));
	result *= compare_float((i), 0.0);
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
	lowp uvec3 a;
	lowp mat2 b;
	mediump ivec4 c; // unused in vertex shader
	mediump mat3x4 d;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump ivec2 e;
} blockC[2];
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp vec2 f;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	highp vec2 g[6];
	u8vec4 h[1]; // unused in fragment shader
} blockE[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec3((a), uvec3(0u, 0u, 0u));
	result *= compare_mat2((b), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((d), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC[0].e), ivec2(0, 0));
	result *= compare_ivec2((blockC[1].e), ivec2(0, 0));
	result *= compare_vec2((blockD.f), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[0].g[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[0].g[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[0].g[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[0].g[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[0].g[4]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[0].g[5]), vec2(0.0, 0.0));
	result *= compare_u8vec4(uvec4(blockE[0].h[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec2((blockE[1].g[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[1].g[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[1].g[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[1].g[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[1].g[4]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[1].g[5]), vec2(0.0, 0.0));
	result *= compare_u8vec4(uvec4(blockE[1].h[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec2((blockE[2].g[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[2].g[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[2].g[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[2].g[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[2].g[4]), vec2(0.0, 0.0));
	result *= compare_vec2((blockE[2].g[5]), vec2(0.0, 0.0));
	result *= compare_u8vec4(uvec4(blockE[2].h[0]), uvec4(0u, 0u, 0u, 0u));
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
	lowp int mA;
	lowp mat3x2 mB; // unused in vertex shader
	mediump ivec2 mC; // unused in fragment shader
};
struct sB
{
	int8_t mA;
	mediump uvec4 mB[7];
	i8vec3 mC;
};
struct sC
{
	i8vec3 mA;
	sB mB;
};
struct sD
{
	mediump uvec3 mA;
	i8vec4 mB; // unused in vertex shader
	lowp mat4 mC;
	highp mat3 mD;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	mediump uvec4 o[2];
	sC p[6];
	highp uvec3 q;
	highp mat3 r;
	i8vec3 s;
};
layout(set = 0, binding = 5) uniform BlockG
{
	mediump int t;
	uint8_t u;
	sD v;
	lowp mat4 w;
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	highp ivec2 x; // unused in fragment shader
	u8vec2 y; // unused in vertex shader
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec4((o[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((o[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(p[0].mA), ivec3(0, 0, 0));
	result *= compare_int8_t(int(p[0].mB.mA), 0);
	result *= compare_uvec4((p[0].mB.mB[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[0].mB.mB[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[0].mB.mB[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[0].mB.mB[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[0].mB.mB[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[0].mB.mB[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[0].mB.mB[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(p[0].mB.mC), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(p[1].mA), ivec3(0, 0, 0));
	result *= compare_int8_t(int(p[1].mB.mA), 0);
	result *= compare_uvec4((p[1].mB.mB[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[1].mB.mB[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[1].mB.mB[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[1].mB.mB[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[1].mB.mB[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[1].mB.mB[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[1].mB.mB[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(p[1].mB.mC), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(p[2].mA), ivec3(0, 0, 0));
	result *= compare_int8_t(int(p[2].mB.mA), 0);
	result *= compare_uvec4((p[2].mB.mB[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[2].mB.mB[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[2].mB.mB[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[2].mB.mB[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[2].mB.mB[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[2].mB.mB[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[2].mB.mB[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(p[2].mB.mC), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(p[3].mA), ivec3(0, 0, 0));
	result *= compare_int8_t(int(p[3].mB.mA), 0);
	result *= compare_uvec4((p[3].mB.mB[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[3].mB.mB[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[3].mB.mB[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[3].mB.mB[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[3].mB.mB[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[3].mB.mB[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[3].mB.mB[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(p[3].mB.mC), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(p[4].mA), ivec3(0, 0, 0));
	result *= compare_int8_t(int(p[4].mB.mA), 0);
	result *= compare_uvec4((p[4].mB.mB[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[4].mB.mB[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[4].mB.mB[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[4].mB.mB[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[4].mB.mB[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[4].mB.mB[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[4].mB.mB[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(p[4].mB.mC), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(p[5].mA), ivec3(0, 0, 0));
	result *= compare_int8_t(int(p[5].mB.mA), 0);
	result *= compare_uvec4((p[5].mB.mB[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[5].mB.mB[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[5].mB.mB[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[5].mB.mB[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[5].mB.mB[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[5].mB.mB[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((p[5].mB.mB[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(p[5].mB.mC), ivec3(0, 0, 0));
	result *= compare_uvec3((q), uvec3(0u, 0u, 0u));
	result *= compare_mat3((r), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(s), ivec3(0, 0, 0));
	result *= compare_int((t), 0);
	result *= compare_uint8_t(uint(u), 0u);
	result *= compare_uvec3((v.mA), uvec3(0u, 0u, 0u));
	result *= compare_i8vec4(ivec4(v.mB), ivec4(0, 0, 0, 0));
	result *= compare_mat4((v.mC), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((v.mD), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((w), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockH.x), ivec2(0, 0));
	result *= compare_u8vec2(uvec2(blockH.y), uvec2(0u, 0u));
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
	uint8_t mA;
	lowp vec4 mB;
};
struct sB
{
	lowp float mA;
	sA mB;
	u8vec3 mC;
};
struct sC
{
	int8_t mA; // unused in both shaders
	u8vec3 mB;
};
struct sD
{
	highp float mA;
	mediump mat3x2 mB;
	lowp mat4x3 mC;
};
layout(set = 0, binding = 5) uniform BlockG
{
	lowp mat2 p;
	highp mat2 q;
	bool r;
	u8vec4 s;
};
layout(set = 0, binding = 6) uniform BlockH
{
	mediump ivec4 t[8];
	sD u;
	mediump vec2 v;
	i8vec4 w; // unused in vertex shader
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	lowp mat3x2 x;
	mediump mat2 y;
	mediump vec4 z;
};
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	i8vec4 aa;
	u8vec4 ab;
	bvec3 ac;
	u8vec3 ad;
} blockJ;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
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
	result *= compare_mat2((p), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((q), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((r), false);
	result *= compare_u8vec4(uvec4(s), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((blockH.t[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.t[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.t[2]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.t[3]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.t[4]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.t[5]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.t[6]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((blockH.t[7]), ivec4(0, 0, 0, 0));
	result *= compare_float((blockH.u.mA), 0.0);
	result *= compare_mat3x2((blockH.u.mB), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockH.u.mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockH.v), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockH.w), ivec4(0, 0, 0, 0));
	result *= compare_mat3x2((x), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((y), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((z), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(blockJ.aa), ivec4(0, 0, 0, 0));
	result *= compare_u8vec4(uvec4(blockJ.ab), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec3((blockJ.ac), bvec3(false, false, false));
	result *= compare_u8vec3(uvec3(blockJ.ad), uvec3(0u, 0u, 0u));
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
	i8vec3 mA; // unused in fragment shader
	bool mB;
};
struct sB
{
	sA mA;
	bvec2 mB; // unused in vertex shader
	u8vec4 mC;
};
struct sC
{
	bool mA;
	u8vec3 mB;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	uint8_t k; // unused in fragment shader
	bvec3 l[6];
	bvec2 m;
	sB n;
	highp mat3x4 o; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	bvec4 p; // unused in vertex shader
	highp vec3 q;
	lowp mat4 r;
	int8_t s; // unused in vertex shader
	mediump mat4x2 t; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	lowp mat3x2 u; // unused in fragment shader
	sC v[6]; // unused in vertex shader
	lowp vec2 w;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	bvec3 x;
	highp uint y;
	highp uint z;
	lowp mat3x4 aa; // unused in fragment shader
	u8vec4 ab;
} blockI[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockF.k), 0u);
	result *= compare_bvec3((blockF.l[0]), bvec3(false, false, false));
	result *= compare_bvec3((blockF.l[1]), bvec3(false, false, false));
	result *= compare_bvec3((blockF.l[2]), bvec3(false, false, false));
	result *= compare_bvec3((blockF.l[3]), bvec3(false, false, false));
	result *= compare_bvec3((blockF.l[4]), bvec3(false, false, false));
	result *= compare_bvec3((blockF.l[5]), bvec3(false, false, false));
	result *= compare_bvec2((blockF.m), bvec2(false, false));
	result *= compare_i8vec3(ivec3(blockF.n.mA.mA), ivec3(0, 0, 0));
	result *= compare_bool((blockF.n.mA.mB), false);
	result *= compare_bvec2((blockF.n.mB), bvec2(false, false));
	result *= compare_u8vec4(uvec4(blockF.n.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x4((blockF.o), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockG.p), bvec4(false, false, false, false));
	result *= compare_vec3((blockG.q), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4((blockG.r), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(blockG.s), 0);
	result *= compare_mat4x2((blockG.t), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH.u), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockH.v[0].mA), false);
	result *= compare_u8vec3(uvec3(blockH.v[0].mB), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockH.v[1].mA), false);
	result *= compare_u8vec3(uvec3(blockH.v[1].mB), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockH.v[2].mA), false);
	result *= compare_u8vec3(uvec3(blockH.v[2].mB), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockH.v[3].mA), false);
	result *= compare_u8vec3(uvec3(blockH.v[3].mB), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockH.v[4].mA), false);
	result *= compare_u8vec3(uvec3(blockH.v[4].mB), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockH.v[5].mA), false);
	result *= compare_u8vec3(uvec3(blockH.v[5].mB), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockH.w), vec2(0.0, 0.0));
	result *= compare_bvec3((blockI[0].x), bvec3(false, false, false));
	result *= compare_uint((blockI[0].y), 0u);
	result *= compare_uint((blockI[0].z), 0u);
	result *= compare_mat3x4((blockI[0].aa), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(blockI[0].ab), uvec4(0u, 0u, 0u, 0u));
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
	mediump uvec4 mA;
	lowp mat3x4 mB; // unused in fragment shader
	highp mat3x2 mC; // unused in fragment shader
	highp vec2 mD[7];
};
layout(set = 0, binding = 4) uniform BlockF
{
	lowp mat3 r[6];
	u8vec2 s;
	highp mat2 t;
	bvec2 u;
	highp uvec2 v;
} blockF[2];
layout(set = 0, binding = 5) uniform BlockG
{
	sA w;
	mediump mat3 x;
	u8vec2 y; // unused in both shaders
	highp uint z;
	lowp float aa;
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
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((blockF[0].r[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].r[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].r[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].r[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].r[4]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[0].r[5]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec2(uvec2(blockF[0].s), uvec2(0u, 0u));
	result *= compare_mat2((blockF[0].t), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockF[0].u), bvec2(false, false));
	result *= compare_uvec2((blockF[0].v), uvec2(0u, 0u));
	result *= compare_mat3((blockF[1].r[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].r[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].r[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].r[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].r[4]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF[1].r[5]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec2(uvec2(blockF[1].s), uvec2(0u, 0u));
	result *= compare_mat2((blockF[1].t), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockF[1].u), bvec2(false, false));
	result *= compare_uvec2((blockF[1].v), uvec2(0u, 0u));
	result *= compare_uvec4((blockG.w.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x4((blockG.w.mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockG.w.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockG.w.mD[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockG.w.mD[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockG.w.mD[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockG.w.mD[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockG.w.mD[4]), vec2(0.0, 0.0));
	result *= compare_vec2((blockG.w.mD[5]), vec2(0.0, 0.0));
	result *= compare_vec2((blockG.w.mD[6]), vec2(0.0, 0.0));
	result *= compare_mat3((blockG.x), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec2(uvec2(blockG.y), uvec2(0u, 0u));
	result *= compare_uint((blockG.z), 0u);
	result *= compare_float((blockG.aa), 0.0);
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
	mediump vec2 mA; // unused in fragment shader
	u8vec3 mB;
	highp mat2 mC;
};
struct sB
{
	highp mat3 mA; // unused in vertex shader
	highp mat4 mB[1];
	bvec2 mC;
	highp ivec2 mD;
};
layout(set = 0, binding = 4, scalar, column_major) uniform BlockF
{
	layout(offset = 152) mediump uvec4 p; // unused in both shaders
	layout(offset = 0) sA l; // unused in fragment shader
	layout(offset = 104) mediump mat4x3 o;
	layout(offset = 28) lowp mat4 m;
	layout(offset = 92) bvec3 n;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 64) sB r; // unused in vertex shader
	layout(offset = 0) u8vec4 q[4]; // unused in vertex shader
};
layout(set = 0, binding = 6, std430, row_major) uniform BlockH
{
	layout(offset = 36) i8vec3 u; // unused in both shaders
	layout(offset = 0) lowp ivec2 s[4]; // unused in vertex shader
	layout(offset = 32) mediump int t;
} blockH[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((l.mA), vec2(0.0, 0.0));
	result *= compare_u8vec3(uvec3(l.mB), uvec3(0u, 0u, 0u));
	result *= compare_mat2((l.mC), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((m), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((n), bvec3(false, false, false));
	result *= compare_mat4x3((o), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(q[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(q[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(q[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(q[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((r.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((r.mB[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((r.mC), bvec2(false, false));
	result *= compare_ivec2((r.mD), ivec2(0, 0));
	result *= compare_ivec2((blockH[0].s[0]), ivec2(0, 0));
	result *= compare_ivec2((blockH[0].s[1]), ivec2(0, 0));
	result *= compare_ivec2((blockH[0].s[2]), ivec2(0, 0));
	result *= compare_ivec2((blockH[0].s[3]), ivec2(0, 0));
	result *= compare_int((blockH[0].t), 0);
	result *= compare_i8vec3(ivec3(blockH[0].u), ivec3(0, 0, 0));
	result *= compare_ivec2((blockH[1].s[0]), ivec2(0, 0));
	result *= compare_ivec2((blockH[1].s[1]), ivec2(0, 0));
	result *= compare_ivec2((blockH[1].s[2]), ivec2(0, 0));
	result *= compare_ivec2((blockH[1].s[3]), ivec2(0, 0));
	result *= compare_int((blockH[1].t), 0);
	result *= compare_i8vec3(ivec3(blockH[1].u), ivec3(0, 0, 0));
	result *= compare_ivec2((blockH[2].s[0]), ivec2(0, 0));
	result *= compare_ivec2((blockH[2].s[1]), ivec2(0, 0));
	result *= compare_ivec2((blockH[2].s[2]), ivec2(0, 0));
	result *= compare_ivec2((blockH[2].s[3]), ivec2(0, 0));
	result *= compare_int((blockH[2].t), 0);
	result *= compare_i8vec3(ivec3(blockH[2].u), ivec3(0, 0, 0));
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
	highp mat4 mA;
	u8vec4 mB; // unused in fragment shader
	highp mat3x4 mC; // unused in fragment shader
};
struct sB
{
	lowp mat2x3 mA;
	highp mat4x3 mB;
	mediump mat4x2 mC;
	sA mD;
};
struct sC
{
	mediump mat4 mA; // unused in fragment shader
	highp vec3 mB; // unused in both shaders
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	layout(offset = 0) mediump mat3 v;
} blockH;
layout(set = 0, binding = 7, std430, column_major) uniform BlockI
{
	layout(offset = 35) uint8_t aa; // unused in fragment shader
	layout(offset = 0) highp mat3x2 w;
	layout(offset = 34) int8_t z;
	layout(offset = 24) mediump ivec2 x;
	layout(offset = 32) u8vec2 y; // unused in vertex shader
};
layout(set = 0, binding = 8, scalar, column_major) uniform BlockJ
{
	layout(offset = 80) bvec3 ad;
	layout(offset = 0) sC ab;
	layout(offset = 76) i8vec4 ac; // unused in fragment shader
};
layout(set = 0, binding = 9) uniform BlockK
{
	layout(offset = 16) highp uint af[8];
	layout(offset = 0) highp uvec4 ae; // unused in fragment shader
} blockK;

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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((blockH.v), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((x), ivec2(0, 0));
	result *= compare_u8vec2(uvec2(y), uvec2(0u, 0u));
	result *= compare_int8_t(int(z), 0);
	result *= compare_uint8_t(uint(aa), 0u);
	result *= compare_mat4((ab.mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((ab.mB), vec3(0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(ac), ivec4(0, 0, 0, 0));
	result *= compare_bvec3((ad), bvec3(false, false, false));
	result *= compare_uvec4((blockK.ae), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((blockK.af[0]), 0u);
	result *= compare_uint((blockK.af[1]), 0u);
	result *= compare_uint((blockK.af[2]), 0u);
	result *= compare_uint((blockK.af[3]), 0u);
	result *= compare_uint((blockK.af[4]), 0u);
	result *= compare_uint((blockK.af[5]), 0u);
	result *= compare_uint((blockK.af[6]), 0u);
	result *= compare_uint((blockK.af[7]), 0u);
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
	mediump uint mA; // unused in fragment shader
	highp uvec2 mB;
	mediump mat3 mC;
	bvec3 mD;
};
struct sB
{
	highp ivec3 mA;
	lowp mat4x2 mB;
};
struct sC
{
	uint8_t mA;
	mediump vec2 mB;
	highp mat4x3 mC;
	bool mD;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	layout(offset = 0) mediump mat3x4 m;
};
layout(set = 0, binding = 5, scalar) uniform BlockG
{
	layout(offset = 44) i8vec2 r; // unused in vertex shader
	layout(offset = 0) highp uvec4 n;
	layout(offset = 28) bvec4 q;
	layout(offset = 16) highp int o; // unused in both shaders
	layout(offset = 20) highp vec2 p; // unused in fragment shader
};
layout(set = 0, binding = 6) uniform BlockH
{
	layout(offset = 192) lowp ivec4 v[6];
	layout(offset = 0) sB s;
	layout(offset = 96) sC u;
	layout(offset = 80) bvec4 t;
};

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((m), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((n), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((o), 0);
	result *= compare_vec2((p), vec2(0.0, 0.0));
	result *= compare_bvec4((q), bvec4(false, false, false, false));
	result *= compare_i8vec2(ivec2(r), ivec2(0, 0));
	result *= compare_ivec3((s.mA), ivec3(0, 0, 0));
	result *= compare_mat4x2((s.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((t), bvec4(false, false, false, false));
	result *= compare_uint8_t(uint(u.mA), 0u);
	result *= compare_vec2((u.mB), vec2(0.0, 0.0));
	result *= compare_mat4x3((u.mC), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((u.mD), false);
	result *= compare_ivec4((v[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((v[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((v[2]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((v[3]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((v[4]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((v[5]), ivec4(0, 0, 0, 0));
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
	mediump float mA;
	lowp uint mB; // unused in fragment shader
	i8vec3 mC; // unused in fragment shader
	lowp vec4 mD; // unused in vertex shader
};
struct sB
{
	uint8_t mA;
};
layout(set = 0, binding = 4, scalar) uniform BlockF
{
	layout(offset = 0) int8_t m;
} blockF[3];
layout(set = 0, binding = 5) uniform BlockG
{
	layout(offset = 32) mediump int o[8]; // unused in fragment shader
	layout(offset = 0) highp mat2 n; // unused in vertex shader
};
layout(set = 0, binding = 6, std430, row_major) uniform BlockH
{
	layout(offset = 56) highp mat2x3 s; // unused in fragment shader
	layout(offset = 0) bvec4 p; // unused in fragment shader
	layout(offset = 48) mediump uint r;
	layout(offset = 16) highp mat3x2 q;
} blockH;
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	layout(offset = 96) i8vec2 v;
	layout(offset = 0) highp mat2x3 t;
	layout(offset = 48) lowp mat3 u;
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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int8_t(int(blockF[0].m), 0);
	result *= compare_int8_t(int(blockF[1].m), 0);
	result *= compare_int8_t(int(blockF[2].m), 0);
	result *= compare_mat2((n), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((o[0]), 0);
	result *= compare_int((o[1]), 0);
	result *= compare_int((o[2]), 0);
	result *= compare_int((o[3]), 0);
	result *= compare_int((o[4]), 0);
	result *= compare_int((o[5]), 0);
	result *= compare_int((o[6]), 0);
	result *= compare_int((o[7]), 0);
	result *= compare_bvec4((blockH.p), bvec4(false, false, false, false));
	result *= compare_mat3x2((blockH.q), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockH.r), 0u);
	result *= compare_mat2x3((blockH.s), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockI.t), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockI.u), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockI.v), ivec2(0, 0));
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
	bool mA;
	highp vec3 mB; // unused in fragment shader
	highp uvec3 mC;
};
struct sB
{
	highp int mA; // unused in vertex shader
	sA mB;
};
struct sC
{
	highp mat4 mA;
};
struct sD
{
	i8vec4 mA;
};
layout(set = 0, binding = 4, scalar, row_major) uniform BlockF
{
	layout(offset = 0) bvec4 j; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	layout(offset = 32) int8_t m;
	layout(offset = 0) uint8_t k; // unused in vertex shader
	layout(offset = 16) highp vec4 l;
};
layout(set = 0, binding = 6) uniform BlockH
{
	layout(offset = 32) lowp mat3x2 r;
	layout(offset = 0) i8vec3 n;
	layout(offset = 16) mediump vec3 q; // unused in vertex shader
	layout(offset = 3) int8_t o;
	layout(offset = 4) u8vec2 p;
} blockH[3];
layout(set = 0, binding = 7, scalar) uniform BlockI
{
	layout(offset = 0) lowp vec3 s; // unused in vertex shader
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((blockF.j), bvec4(false, false, false, false));
	result *= compare_uint8_t(uint(k), 0u);
	result *= compare_vec4((l), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(m), 0);
	result *= compare_i8vec3(ivec3(blockH[0].n), ivec3(0, 0, 0));
	result *= compare_int8_t(int(blockH[0].o), 0);
	result *= compare_u8vec2(uvec2(blockH[0].p), uvec2(0u, 0u));
	result *= compare_vec3((blockH[0].q), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[0].r), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockH[1].n), ivec3(0, 0, 0));
	result *= compare_int8_t(int(blockH[1].o), 0);
	result *= compare_u8vec2(uvec2(blockH[1].p), uvec2(0u, 0u));
	result *= compare_vec3((blockH[1].q), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[1].r), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockH[2].n), ivec3(0, 0, 0));
	result *= compare_int8_t(int(blockH[2].o), 0);
	result *= compare_u8vec2(uvec2(blockH[2].p), uvec2(0u, 0u));
	result *= compare_vec3((blockH[2].q), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[2].r), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.s), vec3(0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
