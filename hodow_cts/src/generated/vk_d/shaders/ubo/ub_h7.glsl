#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp int var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
	highp uvec4 var[3][4];
};

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
	bool var[3][4];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((var[0][0]), false);
	result *= compare_bool((var[0][1]), false);
	result *= compare_bool((var[0][2]), false);
	result *= compare_bool((var[0][3]), false);
	result *= compare_bool((var[1][0]), false);
	result *= compare_bool((var[1][1]), false);
	result *= compare_bool((var[1][2]), false);
	result *= compare_bool((var[1][3]), false);
	result *= compare_bool((var[2][0]), false);
	result *= compare_bool((var[2][1]), false);
	result *= compare_bool((var[2][2]), false);
	result *= compare_bool((var[2][3]), false);
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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
	int padding;
	highp ivec2 var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	highp ivec4 var[3][4];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec4((var[0][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][2]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][3]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][2]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][3]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][2]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][3]), ivec4(0, 0, 0, 0));
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
	bvec2 var[3][4];
};

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
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
	highp mat4 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
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
	highp mat2x3 var[3][4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec4 var[3][4];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec4 var[3][4];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	u8vec4 var[3][4];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec2 var[3][4];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	result *= compare_int16_t(int(padding), 0);
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

layout(set = 0, binding = 0, std140) uniform Block
{
	highp float var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp ivec2 var[3][4][2];
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
    imageStore(outImage, coord, vec4(result));
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
	highp ivec4 var[3][4][2];
};

mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec4((var[0][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[0][3][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[1][3][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][0][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][0][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][1][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][1][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][2][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][2][1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][3][0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((var[2][3][1]), ivec4(0, 0, 0, 0));
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

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec4 var[3][4][2];
};

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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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
	uint8_t var[3][4][2];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(var[0][0][0]), 0u);
	result *= compare_uint8_t(uint(var[0][0][1]), 0u);
	result *= compare_uint8_t(uint(var[0][1][0]), 0u);
	result *= compare_uint8_t(uint(var[0][1][1]), 0u);
	result *= compare_uint8_t(uint(var[0][2][0]), 0u);
	result *= compare_uint8_t(uint(var[0][2][1]), 0u);
	result *= compare_uint8_t(uint(var[0][3][0]), 0u);
	result *= compare_uint8_t(uint(var[0][3][1]), 0u);
	result *= compare_uint8_t(uint(var[1][0][0]), 0u);
	result *= compare_uint8_t(uint(var[1][0][1]), 0u);
	result *= compare_uint8_t(uint(var[1][1][0]), 0u);
	result *= compare_uint8_t(uint(var[1][1][1]), 0u);
	result *= compare_uint8_t(uint(var[1][2][0]), 0u);
	result *= compare_uint8_t(uint(var[1][2][1]), 0u);
	result *= compare_uint8_t(uint(var[1][3][0]), 0u);
	result *= compare_uint8_t(uint(var[1][3][1]), 0u);
	result *= compare_uint8_t(uint(var[2][0][0]), 0u);
	result *= compare_uint8_t(uint(var[2][0][1]), 0u);
	result *= compare_uint8_t(uint(var[2][1][0]), 0u);
	result *= compare_uint8_t(uint(var[2][1][1]), 0u);
	result *= compare_uint8_t(uint(var[2][2][0]), 0u);
	result *= compare_uint8_t(uint(var[2][2][1]), 0u);
	result *= compare_uint8_t(uint(var[2][3][0]), 0u);
	result *= compare_uint8_t(uint(var[2][3][1]), 0u);
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
	u8vec3 var[3][4][2];
};

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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec3 var[3][4][2];
};

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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec3 var[3][4][2];
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat2x3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat3x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	highp mat4x2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	uint8_t var[3][4][2];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(var[0][0][0]), 0u);
	result *= compare_uint8_t(uint(var[0][0][1]), 0u);
	result *= compare_uint8_t(uint(var[0][1][0]), 0u);
	result *= compare_uint8_t(uint(var[0][1][1]), 0u);
	result *= compare_uint8_t(uint(var[0][2][0]), 0u);
	result *= compare_uint8_t(uint(var[0][2][1]), 0u);
	result *= compare_uint8_t(uint(var[0][3][0]), 0u);
	result *= compare_uint8_t(uint(var[0][3][1]), 0u);
	result *= compare_uint8_t(uint(var[1][0][0]), 0u);
	result *= compare_uint8_t(uint(var[1][0][1]), 0u);
	result *= compare_uint8_t(uint(var[1][1][0]), 0u);
	result *= compare_uint8_t(uint(var[1][1][1]), 0u);
	result *= compare_uint8_t(uint(var[1][2][0]), 0u);
	result *= compare_uint8_t(uint(var[1][2][1]), 0u);
	result *= compare_uint8_t(uint(var[1][3][0]), 0u);
	result *= compare_uint8_t(uint(var[1][3][1]), 0u);
	result *= compare_uint8_t(uint(var[2][0][0]), 0u);
	result *= compare_uint8_t(uint(var[2][0][1]), 0u);
	result *= compare_uint8_t(uint(var[2][1][0]), 0u);
	result *= compare_uint8_t(uint(var[2][1][1]), 0u);
	result *= compare_uint8_t(uint(var[2][2][0]), 0u);
	result *= compare_uint8_t(uint(var[2][2][1]), 0u);
	result *= compare_uint8_t(uint(var[2][3][0]), 0u);
	result *= compare_uint8_t(uint(var[2][3][1]), 0u);
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

layout(set = 0, binding = 0, std430) uniform Block
{
	int8_t var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	i16vec4 var[3][4][2];
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	f16vec4 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec3 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((var[0][0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[0][0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[0][1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[0][1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[0][2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[0][2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[0][3][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[0][3][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][3][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[1][3][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][0][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][0][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][1][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][1][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][2][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][2][1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][3][0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((var[2][3][1]), vec3(0.0, 0.0, 0.0));
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
	highp int var[3][4][2];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
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
	highp int var[3][4][2];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	highp uvec4 var[3][4][2];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
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
	highp mat2 var[3][4][2];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }

void main (void)
{
    gl_Position = a_position;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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
	i8vec2 var[3][4][2];
};

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int8_t(int(padding), 0);
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
	uint16_t padding;
	u16vec4 var[3][4][2];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
	int16_t var[3][4][2];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec4 var;
};

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
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	i8vec4 var;
};

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec2 var;
};

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	f16vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(var), vec4(0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140) uniform Block
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
	result *= compare_int((var), 0);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp uvec3 var;
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

layout(set = 0, binding = 0, std140) uniform Block
{
	lowp uvec4 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
	lowp mat4 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
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
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
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
	lowp mat2x4 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
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
	result *= compare_mat4x3((var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	mediump mat3 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	mediump mat4 var;
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	mediump mat4x3 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x3((var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp mat4 var;
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat4x2 var;
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	u8vec3 var;
};

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec4 var;
};

mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(var), ivec4(0, 0, 0, 0));
    v_vtxResult = result;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec4 var;
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	int16_t var;
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int16_t(int(var), 0);
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
	f16vec3 var;
};

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
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
	lowp uint var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((var), 0u);
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
	lowp mat4 var;
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	lowp mat4 var;
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	lowp mat2x4 var;
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
	result *= compare_mat4x3((var), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump ivec4 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump uint var;
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

layout(set = 0, binding = 0, std430) uniform Block
{
	mediump uvec2 var;
};

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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
	highp float var;
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp float var;
};

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
	highp vec4 var;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp ivec2 var;
};

mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

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
	highp uvec2 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat4 var;
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
	highp mat4 var;
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool var;
};

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
};

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t var;
};

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t padding;
	f16vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec4(vec4(var), vec4(0.0, 0.0, 0.0, 0.0));
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
	f16vec4 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float16_t(float(padding), 0.0);
	result *= compare_f16vec4(vec4(var), vec4(0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	lowp uint var;
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	lowp uint var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((var), 0u);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	lowp uvec2 var;
};

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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2((var), mat2(0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
	result *= compare_mat2x3((var), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
{
	float padding;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	lowp mat3x2 var;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

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

layout(set = 0, binding = 0, scalar) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
	mediump uvec2 var;
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
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
	mediump mat2x3 var;
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

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec2 var;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec3 var;
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
	result *= compare_ivec3((var), ivec3(0, 0, 0));
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
	highp ivec4 var;
};

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


mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp mat3 var;
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

layout(set = 0, binding = 0, scalar) uniform Block
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
	result *= compare_float((padding), 0.0);
	result *= compare_mat4((var), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430, column_major) uniform Block
{
	highp mat3 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat3((var[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((var[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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

layout(set = 0, binding = 0, std430) uniform Block
{
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

layout(set = 0, binding = 0, std430) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp mat4x2 var[3];
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
	highp mat4x2 var[3];
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
	i8vec3 var[3];
};

mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec3(ivec3(var[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(var[2]), ivec3(0, 0, 0));
    imageStore(outImage, coord, vec4(result));
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

layout(set = 0, binding = 0, std430) uniform Block
{
	u16vec4 var[3];
};

mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec4(uvec4(var[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(var[2]), uvec4(0u, 0u, 0u, 0u));
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
	highp float var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((var[0]), 0.0);
	result *= compare_float((var[1]), 0.0);
	result *= compare_float((var[2]), 0.0);
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
	highp ivec4 var[3];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	int padding;
	highp ivec4 var[3];
};

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((padding), 0);
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint padding;
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
	highp uvec4 var[3];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((padding), 0u);
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	float padding;
	highp mat4 var[3];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((padding), 0.0);
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint8_t padding;
	u8vec3 var[3];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(padding), 0u);
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
	uint16_t padding;
	u16vec3 var[3];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(padding), 0u);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int16_t padding;
	int16_t var[3];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_int16_t(int(var[0]), 0);
	result *= compare_int16_t(int(var[1]), 0);
	result *= compare_int16_t(int(var[2]), 0);
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
	i16vec3 var[3];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_i16vec3(ivec3(var[0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2]), ivec3(0, 0, 0));
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
	i16vec3 var[3];
};

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(padding), 0);
	result *= compare_i16vec3(ivec3(var[0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(var[2]), ivec3(0, 0, 0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	bvec2 var[];
};

mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec2((var[0]), bvec2(false, false));
	result *= compare_bvec2((var[1]), bvec2(false, false));
	result *= compare_bvec2((var[2]), bvec2(false, false));
	result *= compare_bvec2((var[3]), bvec2(false, false));
	result *= compare_bvec2((var[4]), bvec2(false, false));
	result *= compare_bvec2((var[5]), bvec2(false, false));
	result *= compare_bvec2((var[6]), bvec2(false, false));
	result *= compare_bvec2((var[7]), bvec2(false, false));
	result *= compare_bvec2((var[8]), bvec2(false, false));
	result *= compare_bvec2((var[9]), bvec2(false, false));
	result *= compare_bvec2((var[10]), bvec2(false, false));
	result *= compare_bvec2((var[11]), bvec2(false, false));
	result *= compare_bvec2((var[12]), bvec2(false, false));
	result *= compare_bvec2((var[13]), bvec2(false, false));
	result *= compare_bvec2((var[14]), bvec2(false, false));
	result *= compare_bvec2((var[15]), bvec2(false, false));
	result *= compare_bvec2((var[16]), bvec2(false, false));
	result *= compare_bvec2((var[17]), bvec2(false, false));
	result *= compare_bvec2((var[18]), bvec2(false, false));
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
{
	highp mat3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std140, column_major) uniform Block
{
	highp mat2x3 var[];
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	uint8_t var[];
};

mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
	u16vec2 var[];
};

mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[4]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[5]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[6]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[7]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[8]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[9]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[10]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[11]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[12]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[13]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[14]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[15]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[16]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[17]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[18]), uvec2(0u, 0u));
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
	u16vec2 var[];
};

mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[4]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[5]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[6]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[7]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[8]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[9]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[10]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[11]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[12]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[13]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[14]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[15]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[16]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[17]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[18]), uvec2(0u, 0u));
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
	f16vec4 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(var[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[1]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[2]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[3]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[4]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[5]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[6]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[7]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[8]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[9]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[10]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[11]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[12]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[13]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[14]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[15]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[16]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[17]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(var[18]), vec4(0.0, 0.0, 0.0, 0.0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp vec4 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
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
	highp uint var[];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((var[0]), 0u);
	result *= compare_uint((var[1]), 0u);
	result *= compare_uint((var[2]), 0u);
	result *= compare_uint((var[3]), 0u);
	result *= compare_uint((var[4]), 0u);
	result *= compare_uint((var[5]), 0u);
	result *= compare_uint((var[6]), 0u);
	result *= compare_uint((var[7]), 0u);
	result *= compare_uint((var[8]), 0u);
	result *= compare_uint((var[9]), 0u);
	result *= compare_uint((var[10]), 0u);
	result *= compare_uint((var[11]), 0u);
	result *= compare_uint((var[12]), 0u);
	result *= compare_uint((var[13]), 0u);
	result *= compare_uint((var[14]), 0u);
	result *= compare_uint((var[15]), 0u);
	result *= compare_uint((var[16]), 0u);
	result *= compare_uint((var[17]), 0u);
	result *= compare_uint((var[18]), 0u);
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
	highp uint var[];
};

mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((var[0]), 0u);
	result *= compare_uint((var[1]), 0u);
	result *= compare_uint((var[2]), 0u);
	result *= compare_uint((var[3]), 0u);
	result *= compare_uint((var[4]), 0u);
	result *= compare_uint((var[5]), 0u);
	result *= compare_uint((var[6]), 0u);
	result *= compare_uint((var[7]), 0u);
	result *= compare_uint((var[8]), 0u);
	result *= compare_uint((var[9]), 0u);
	result *= compare_uint((var[10]), 0u);
	result *= compare_uint((var[11]), 0u);
	result *= compare_uint((var[12]), 0u);
	result *= compare_uint((var[13]), 0u);
	result *= compare_uint((var[14]), 0u);
	result *= compare_uint((var[15]), 0u);
	result *= compare_uint((var[16]), 0u);
	result *= compare_uint((var[17]), 0u);
	result *= compare_uint((var[18]), 0u);
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp uvec3 var[];
};

mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec3((var[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[4]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[5]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[6]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[7]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[8]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[9]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[10]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[11]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[12]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[13]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[14]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[15]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[16]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[17]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((var[18]), uvec3(0u, 0u, 0u));
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, row_major) uniform Block
{
	highp mat4x3 var[];
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp ivec3 var[];
};

mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((var[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[1]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[2]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[3]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[4]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[5]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[6]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[7]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[8]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[9]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[10]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[11]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[12]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[13]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[14]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[15]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[16]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[17]), ivec3(0, 0, 0));
	result *= compare_ivec3((var[18]), ivec3(0, 0, 0));
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
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

layout(set = 0, binding = 0, scalar) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	highp mat3 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	highp mat4 var[];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
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

layout(set = 0, binding = 0, scalar, row_major) uniform Block
{
	highp mat3x2 var[];
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	uint16_t var[];
};

mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(var[0]), 0u);
	result *= compare_uint16_t(uint(var[1]), 0u);
	result *= compare_uint16_t(uint(var[2]), 0u);
	result *= compare_uint16_t(uint(var[3]), 0u);
	result *= compare_uint16_t(uint(var[4]), 0u);
	result *= compare_uint16_t(uint(var[5]), 0u);
	result *= compare_uint16_t(uint(var[6]), 0u);
	result *= compare_uint16_t(uint(var[7]), 0u);
	result *= compare_uint16_t(uint(var[8]), 0u);
	result *= compare_uint16_t(uint(var[9]), 0u);
	result *= compare_uint16_t(uint(var[10]), 0u);
	result *= compare_uint16_t(uint(var[11]), 0u);
	result *= compare_uint16_t(uint(var[12]), 0u);
	result *= compare_uint16_t(uint(var[13]), 0u);
	result *= compare_uint16_t(uint(var[14]), 0u);
	result *= compare_uint16_t(uint(var[15]), 0u);
	result *= compare_uint16_t(uint(var[16]), 0u);
	result *= compare_uint16_t(uint(var[17]), 0u);
	result *= compare_uint16_t(uint(var[18]), 0u);
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
	u16vec2 var[];
};

mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u16vec2(uvec2(var[0]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[1]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[2]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[3]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[4]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[5]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[6]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[7]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[8]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[9]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[10]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[11]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[12]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[13]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[14]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[15]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[16]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[17]), uvec2(0u, 0u));
	result *= compare_u16vec2(uvec2(var[18]), uvec2(0u, 0u));
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
	i16vec4 var[];
};

mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
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
#extension GL_EXT_uniform_buffer_unsized_array : enable
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
{
	float16_t var[];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
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
	float16_t var[];
};

mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

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
	highp ivec3 a; // unused in both shaders
	mediump mat3 b[4];
	highp vec4 c;
};
layout(set = 0, binding = 0, scalar) uniform Block
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
    mediump float result = 1.0;
	result *= compare_mat3((s.b[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.b[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((s.c), vec4(0.0, 0.0, 0.0, 0.0));
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
layout(set = 0, binding = 0, std140) uniform Block
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
	result *= compare_uint((u), 0u);
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
	result *= compare_vec4((v), vec4(0.0, 0.0, 0.0, 0.0));
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
layout(set = 0, binding = 0, std430) uniform Block
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
    mediump float result = 1.0;
	result *= compare_ivec3((s.a), ivec3(0, 0, 0));
	result *= compare_ivec2((s.b[0]), ivec2(0, 0));
	result *= compare_ivec2((s.b[1]), ivec2(0, 0));
	result *= compare_ivec2((s.b[2]), ivec2(0, 0));
	result *= compare_ivec2((s.b[3]), ivec2(0, 0));
	result *= compare_mat3((t[0].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[0].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[0].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[0].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[3]), ivec2(0, 0));
	result *= compare_mat3((t[1].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[1].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[1].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[1].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[3]), ivec2(0, 0));
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
	result *= compare_ivec3((s.a), ivec3(0, 0, 0));
	result *= compare_ivec2((s.b[0]), ivec2(0, 0));
	result *= compare_ivec2((s.b[1]), ivec2(0, 0));
	result *= compare_ivec2((s.b[2]), ivec2(0, 0));
	result *= compare_ivec2((s.b[3]), ivec2(0, 0));
	result *= compare_mat3((t[0].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[0].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[0].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[0].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[0].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[0].b[2].b[3]), ivec2(0, 0));
	result *= compare_mat3((t[1].a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t[1].b[0].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[0].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[0].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[1].b[1].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[1].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[1].b[3]), ivec2(0, 0));
	result *= compare_ivec3((t[1].b[2].a), ivec3(0, 0, 0));
	result *= compare_ivec2((t[1].b[2].b[0]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[1]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[2]), ivec2(0, 0));
	result *= compare_ivec2((t[1].b[2].b[3]), ivec2(0, 0));
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
	highp float var;
} block[3];

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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140) uniform Block
{
	highp uint var;
} block[3];

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
	bool var;
} block[3];

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((block[0].var), false);
	result *= compare_bool((block[1].var), false);
	result *= compare_bool((block[2].var), false);
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
} block[3];

mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec3((block[0].var), bvec3(false, false, false));
	result *= compare_bvec3((block[1].var), bvec3(false, false, false));
	result *= compare_bvec3((block[2].var), bvec3(false, false, false));
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, row_major) uniform Block
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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140, column_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

layout(set = 0, binding = 0, std140, row_major) uniform Block
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

layout(set = 0, binding = 0, std140) uniform Block
{
	i8vec3 var;
} block[3];

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
	result *= compare_int16_t(int(block[0].var), 0);
	result *= compare_int16_t(int(block[1].var), 0);
	result *= compare_int16_t(int(block[2].var), 0);
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	highp float var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

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
	highp float var;
} block[3];

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, std430) uniform Block
{
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
	result *= compare_ivec3((block[0].var), ivec3(0, 0, 0));
	result *= compare_ivec3((block[1].var), ivec3(0, 0, 0));
	result *= compare_ivec3((block[2].var), ivec3(0, 0, 0));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, std430) uniform Block
{
	bvec3 var;
} block[3];

mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

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

layout(set = 0, binding = 0, std430, row_major) uniform Block
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

layout(set = 0, binding = 0, std430, column_major) uniform Block
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

layout(set = 0, binding = 0, std430) uniform Block
{
	u8vec3 var;
} block[3];

mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

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
	u8vec4 var;
} block[3];

mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec4(uvec4(block[0].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(block[1].var), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(block[2].var), uvec4(0u, 0u, 0u, 0u));
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
	i8vec3 var;
} block[3];

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

layout(set = 0, binding = 0, std430) uniform Block
{
	i8vec3 var;
} block[3];

mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

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
	i16vec2 var;
} block[3];

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(block[0].var), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(block[1].var), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(block[2].var), ivec2(0, 0));
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
	i16vec2 var;
} block[3];

mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_i16vec2(ivec2(block[0].var), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(block[1].var), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(block[2].var), ivec2(0, 0));
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
	i16vec3 var;
} block[3];

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

layout(set = 0, binding = 0, scalar) uniform Block
{
	float padding;
	highp vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_vec2((block[0].var), vec2(0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_vec2((block[1].var), vec2(0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_vec2((block[2].var), vec2(0.0, 0.0));
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
	highp vec2 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_vec2((block[0].var), vec2(0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_vec2((block[1].var), vec2(0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_vec2((block[2].var), vec2(0.0, 0.0));
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
	highp vec3 var;
} block[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_vec3((block[0].var), vec3(0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_vec3((block[1].var), vec3(0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_vec3((block[2].var), vec3(0.0, 0.0, 0.0));
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
	highp vec4 var;
} block[3];

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
	int padding;
	highp ivec2 var;
} block[3];

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((block[0].padding), 0);
	result *= compare_ivec2((block[0].var), ivec2(0, 0));
	result *= compare_int((block[1].padding), 0);
	result *= compare_ivec2((block[1].var), ivec2(0, 0));
	result *= compare_int((block[2].padding), 0);
	result *= compare_ivec2((block[2].var), ivec2(0, 0));
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
	highp ivec2 var;
} block[3];

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((block[0].padding), 0);
	result *= compare_ivec2((block[0].var), ivec2(0, 0));
	result *= compare_int((block[1].padding), 0);
	result *= compare_ivec2((block[1].var), ivec2(0, 0));
	result *= compare_int((block[2].padding), 0);
	result *= compare_ivec2((block[2].var), ivec2(0, 0));
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
	highp ivec3 var;
} block[3];

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((block[0].padding), 0);
	result *= compare_ivec3((block[0].var), ivec3(0, 0, 0));
	result *= compare_int((block[1].padding), 0);
	result *= compare_ivec3((block[1].var), ivec3(0, 0, 0));
	result *= compare_int((block[2].padding), 0);
	result *= compare_ivec3((block[2].var), ivec3(0, 0, 0));
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
	int padding;
	highp ivec4 var;
} block[3];

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((block[0].padding), 0);
	result *= compare_ivec4((block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_int((block[1].padding), 0);
	result *= compare_ivec4((block[1].var), ivec4(0, 0, 0, 0));
	result *= compare_int((block[2].padding), 0);
	result *= compare_ivec4((block[2].var), ivec4(0, 0, 0, 0));
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
} block[3];

mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int((block[0].padding), 0);
	result *= compare_ivec4((block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_int((block[1].padding), 0);
	result *= compare_ivec4((block[1].var), ivec4(0, 0, 0, 0));
	result *= compare_int((block[2].padding), 0);
	result *= compare_ivec4((block[2].var), ivec4(0, 0, 0, 0));
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

layout(set = 0, binding = 0, scalar) uniform Block
{
	bool var;
} block[3];

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bool((block[0].var), false);
	result *= compare_bool((block[1].var), false);
	result *= compare_bool((block[2].var), false);
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
	bool var;
} block[3];

mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bool((block[0].var), false);
	result *= compare_bool((block[1].var), false);
	result *= compare_bool((block[2].var), false);
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
	bvec2 var;
} block[3];

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar) uniform Block
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
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump float v_vtxResult;

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
layout(location = 0) in mediump float v_vtxResult;
layout(location = 0) out mediump vec4 dEQP_FragColor;

layout(set = 0, binding = 0, scalar, column_major) uniform Block
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
	result *= compare_float((block[0].padding), 0.0);
	result *= compare_mat3x4((block[0].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[1].padding), 0.0);
	result *= compare_mat3x4((block[1].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((block[2].padding), 0.0);
	result *= compare_mat3x4((block[2].var), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	uint8_t var;
} block[3];

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

layout(set = 0, binding = 0, scalar) uniform Block
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 1, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 0, scalar) uniform Block
{
	int8_t padding;
	i8vec3 var;
} block[3];

mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

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
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_int16_t(int(block[0].padding), 0);
	result *= compare_i16vec4(ivec4(block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(block[1].padding), 0);
	result *= compare_i16vec4(ivec4(block[1].var), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(block[2].padding), 0);
	result *= compare_i16vec4(ivec4(block[2].var), ivec4(0, 0, 0, 0));
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
} block[3];

mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int16_t(int(block[0].padding), 0);
	result *= compare_i16vec4(ivec4(block[0].var), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(block[1].padding), 0);
	result *= compare_i16vec4(ivec4(block[1].var), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(block[2].padding), 0);
	result *= compare_i16vec4(ivec4(block[2].var), ivec4(0, 0, 0, 0));
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
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 2, rgba8) writeonly uniform image2D outImage;

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
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2(blockA.c[0], vec2(0.0, 0.0));
	result *= compare_vec2(blockA.c[1], vec2(0.0, 0.0));
	result *= compare_float(blockA.c[0][0], 0.0);
	result *= compare_float(blockA.c[0][1], 0.0);
	result *= compare_float(blockA.c[1][0], 0.0);
	result *= compare_float(blockA.c[1][1], 0.0);
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
layout(set = 0, binding = 0, std140) uniform BlockA
{
	highp float a;
	S b;
	lowp uvec3 c; // unused in both shaders
} blockA;
layout(set = 0, binding = 1, std140) uniform BlockB
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
	result *= compare_float((blockA.a), 0.0);
	result *= compare_mat3((blockA.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockA.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockA.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockA.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockB.a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockB.b.b.a), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockB.b.b.b[0]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[1]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[2]), ivec2(0, 0));
	result *= compare_ivec2((blockB.b.b.b[3]), ivec2(0, 0));
	result *= compare_vec4((blockB.b.b.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockB.b.c), bvec4(false, false, false, false));
	result *= compare_bool((blockB.d), false);
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
} blockA;
layout(set = 0, binding = 1, std140) uniform BlockB
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
layout(set = 0, binding = 1, std140) uniform BlockB
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
layout(set = 0, binding = 0, std140) uniform BlockA
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

layout(set = 0, binding = 0, std140) uniform BlockB
{
	lowp int a;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump uint b;
	bool c;
} blockC;
layout(set = 0, binding = 3) uniform BlockE
{
	bool e;
	lowp float f;
	lowp uint g;
	highp float h; // unused in vertex shader
} blockE;
layout(set = 0, binding = 4) uniform BlockF
{
	highp int i; // unused in vertex shader
	lowp int j; // unused in fragment shader
	lowp float k;
	lowp int l;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_int((blockB.a), 0);
	result *= compare_uint((blockC.b), 0u);
	result *= compare_bool((blockC.c), false);
	result *= compare_bool((blockE.e), false);
	result *= compare_float((blockE.f), 0.0);
	result *= compare_uint((blockE.g), 0u);
	result *= compare_float((blockE.h), 0.0);
	result *= compare_int((blockF.i), 0);
	result *= compare_float((blockF.k), 0.0);
	result *= compare_int((blockF.l), 0);
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
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump uint b;
	bool c;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	bool d;
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
	result *= compare_uint((blockC.b), 0u);
	result *= compare_bool((blockC.c), false);
	result *= compare_bool((blockD.d), false);
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
	mediump uint a; // unused in fragment shader
	highp uint b;
	mediump int c; // unused in fragment shader
	bool d;
};
layout(set = 0, binding = 1) uniform BlockC
{
	lowp float e;
	mediump int f;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp float g; // unused in fragment shader
	lowp float h;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp float i;
	lowp uint j;
	bool k;
	lowp int l; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((b), 0u);
	result *= compare_bool((d), false);
	result *= compare_float((blockC.e), 0.0);
	result *= compare_int((blockC.f), 0);
	result *= compare_float((blockD.h), 0.0);
	result *= compare_float((blockE.i), 0.0);
	result *= compare_uint((blockE.j), 0u);
	result *= compare_bool((blockE.k), false);
	result *= compare_int((blockE.l), 0);
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
	mediump uint a; // unused in fragment shader
	highp uint b;
	mediump int c; // unused in fragment shader
	bool d;
};
layout(set = 0, binding = 1) uniform BlockC
{
	lowp float e;
	mediump int f;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp float g; // unused in fragment shader
	lowp float h;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	lowp float i;
	lowp uint j;
	bool k;
	lowp int l; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((a), 0u);
	result *= compare_uint((b), 0u);
	result *= compare_int((c), 0);
	result *= compare_bool((d), false);
	result *= compare_float((blockC.e), 0.0);
	result *= compare_int((blockC.f), 0);
	result *= compare_float((blockD.g), 0.0);
	result *= compare_float((blockD.h), 0.0);
	result *= compare_float((blockE.i), 0.0);
	result *= compare_uint((blockE.j), 0u);
	result *= compare_bool((blockE.k), false);
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
	mediump float q;
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	mediump float r;
	mediump int s;
	mediump uint t;
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	highp float u; // unused in fragment shader
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockF.q), 0.0);
	result *= compare_float((blockG.r), 0.0);
	result *= compare_int((blockG.s), 0);
	result *= compare_uint((blockG.t), 0u);
	result *= compare_float((blockH.u), 0.0);
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
	bvec4 b;
	bvec2 c; // unused in vertex shader
	lowp vec4 d;
	lowp vec4 e;
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	highp ivec2 k;
};
layout(set = 0, binding = 3) uniform BlockE
{
	mediump vec2 l; // unused in fragment shader
	bvec3 m;
} blockE;
layout(set = 0, binding = 4, std140) uniform BlockF
{
	highp uvec3 n;
	bvec3 o; // unused in fragment shader
	mediump int p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_bvec4((a), bvec4(false, false, false, false));
	result *= compare_bvec4((b), bvec4(false, false, false, false));
	result *= compare_bvec2((c), bvec2(false, false));
	result *= compare_vec4((d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((k), ivec2(0, 0));
	result *= compare_bvec3((blockE.m), bvec3(false, false, false));
	result *= compare_uvec3((n), uvec3(0u, 0u, 0u));
	result *= compare_int((p), 0);
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
	bvec4 b;
	bvec2 c; // unused in vertex shader
	lowp vec4 d;
	lowp vec4 e;
};
layout(set = 0, binding = 1) uniform BlockC
{
	lowp uvec2 f;
	mediump ivec3 g; // unused in fragment shader
	bool h;
	highp ivec2 i;
	highp uvec3 j; // unused in vertex shader
} blockC;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_bvec4((a), bvec4(false, false, false, false));
	result *= compare_bvec4((b), bvec4(false, false, false, false));
	result *= compare_vec4((d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockC.f), uvec2(0u, 0u));
	result *= compare_ivec3((blockC.g), ivec3(0, 0, 0));
	result *= compare_bool((blockC.h), false);
	result *= compare_ivec2((blockC.i), ivec2(0, 0));
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5) uniform BlockG
{
	mediump int m; // unused in vertex shader
	mediump vec3 n;
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	mediump ivec3 o;
	bvec2 p;
	mediump vec4 q; // unused in vertex shader
	highp ivec4 r; // unused in fragment shader
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	highp uvec3 s;
	bvec3 t;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
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
	result *= compare_int((blockG.m), 0);
	result *= compare_vec3((blockG.n), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH.o), ivec3(0, 0, 0));
	result *= compare_bvec2((blockH.p), bvec2(false, false));
	result *= compare_vec4((blockH.q), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockH.r), ivec4(0, 0, 0, 0));
	result *= compare_uvec3((s), uvec3(0u, 0u, 0u));
	result *= compare_bvec3((t), bvec3(false, false, false));
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
	highp ivec3 q; // unused in fragment shader
	highp mat3x2 r; // unused in vertex shader
	bool s;
	lowp mat2x3 t;
	bvec4 u; // unused in vertex shader
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	highp vec2 v;
	bvec2 w;
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
	result *= compare_ivec3((q), ivec3(0, 0, 0));
	result *= compare_mat3x2((r), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((s), false);
	result *= compare_mat2x3((t), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((u), bvec4(false, false, false, false));
	result *= compare_vec2((v), vec2(0.0, 0.0));
	result *= compare_bvec2((w), bvec2(false, false));
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
	lowp vec4 a;
	lowp uvec2 b; // unused in vertex shader
	mediump mat4x2 c;
	mediump mat3x2 d;
	lowp ivec4 e;
};
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	mediump float t[6];
	mediump uvec4 u; // unused in fragment shader
	mediump mat4 v;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp mat4x2 w[6];
	bool x; // unused in vertex shader
	lowp ivec2 y;
	bool z;
	bvec2 aa; // unused in fragment shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4((a), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((b), uvec2(0u, 0u));
	result *= compare_mat4x2((c), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((d), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((e), ivec4(0, 0, 0, 0));
	result *= compare_float((t[0]), 0.0);
	result *= compare_float((t[1]), 0.0);
	result *= compare_float((t[2]), 0.0);
	result *= compare_float((t[3]), 0.0);
	result *= compare_float((t[4]), 0.0);
	result *= compare_float((t[5]), 0.0);
	result *= compare_mat4((v), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.w[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.w[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.w[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.w[3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.w[4]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.w[5]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockG.x), false);
	result *= compare_ivec2((blockG.y), ivec2(0, 0));
	result *= compare_bool((blockG.z), false);
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
	lowp vec4 a;
	lowp uvec2 b; // unused in vertex shader
	mediump mat4x2 c;
	mediump mat3x2 d;
	lowp ivec4 e;
};
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	highp vec3 f[2];
	lowp mat3x2 g;
	highp mat3x2 h;
	bool i; // unused in vertex shader
	highp vec3 j;
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	mediump mat3 k;
	highp mat2 l;
	highp uvec4 m;
	lowp uvec4 n[7];
	highp ivec4 o;
} blockD;
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	highp mat3 p;
	highp mat4x2 q;
	highp float r;
	bvec3 s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4((a), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((c), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((d), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((e), ivec4(0, 0, 0, 0));
	result *= compare_vec3((blockC.f[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockC.f[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.g), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.h), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockC.j), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3((blockD.k), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockD.l), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockD.m), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.n[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.n[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.n[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.n[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.n[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.n[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((blockD.n[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((blockD.o), ivec4(0, 0, 0, 0));
	result *= compare_mat3((p), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((q), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((r), 0.0);
	result *= compare_bvec3((s), bvec3(false, false, false));
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
	lowp vec2 a;
	mediump int b;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	bvec3 c;
	highp uint d;
	highp ivec4 e;
	highp uvec2 f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	mediump mat2 l; // unused in fragment shader
	mediump mat2x3 m; // unused in vertex shader
	highp uint n;
} blockF[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2((a), vec2(0.0, 0.0));
	result *= compare_int((b), 0);
	result *= compare_bvec3((blockC.c), bvec3(false, false, false));
	result *= compare_uint((blockC.d), 0u);
	result *= compare_ivec4((blockC.e), ivec4(0, 0, 0, 0));
	result *= compare_uvec2((blockC.f), uvec2(0u, 0u));
	result *= compare_mat2x3((blockF[0].m), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockF[0].n), 0u);
	result *= compare_mat2x3((blockF[1].m), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockF[1].n), 0u);
	result *= compare_mat2x3((blockF[2].m), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockF[2].n), 0u);
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
	lowp vec2 a;
	mediump int b;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	bvec3 c;
	highp uint d;
	highp ivec4 e;
	highp uvec2 f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	lowp mat3x4 g; // unused in fragment shader
} blockD;
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	mediump mat2 h;
	mediump vec4 i;
	mediump mat4x3 j;
	lowp vec4 k; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2((a), vec2(0.0, 0.0));
	result *= compare_int((b), 0);
	result *= compare_bvec3((blockC.c), bvec3(false, false, false));
	result *= compare_uint((blockC.d), 0u);
	result *= compare_ivec4((blockC.e), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((blockD.g), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((h), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((i), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((j), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((k), vec4(0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
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
	highp ivec3 e;
	bvec4 f;
	highp mat4x2 g;
	lowp ivec3 h;
	lowp ivec4 i;
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	mediump int j; // unused in vertex shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((blockF.e), ivec3(0, 0, 0));
	result *= compare_bvec4((blockF.f), bvec4(false, false, false, false));
	result *= compare_mat4x2((blockF.g), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockF.h), ivec3(0, 0, 0));
	result *= compare_ivec4((blockF.i), ivec4(0, 0, 0, 0));
	result *= compare_int((blockG.j), 0);
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
	mediump vec3 mA;
};
layout(set = 0, binding = 0) uniform BlockB
{
	highp mat4 a;
	mediump uvec3 b; // unused in both shaders
	highp mat3x2 c;
	mediump vec4 d;
	bvec2 e;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	highp uvec3 f;
};
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp vec2 g; // unused in fragment shader
	lowp mat3x4 h;
	highp uvec4 i; // unused in fragment shader
	bvec3 j; // unused in vertex shader
	highp ivec2 k;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	sA l;
	lowp vec2 m;
	mediump ivec3 n;
	mediump vec2 o; // unused in vertex shader
	highp ivec4 p;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((blockB.a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.c), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockB.d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockB.e), bvec2(false, false));
	result *= compare_uvec3((f), uvec3(0u, 0u, 0u));
	result *= compare_mat3x4((blockD.h), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockD.j), bvec3(false, false, false));
	result *= compare_ivec2((blockD.k), ivec2(0, 0));
	result *= compare_vec3((blockE.l.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_vec2((blockE.m), vec2(0.0, 0.0));
	result *= compare_ivec3((blockE.n), ivec3(0, 0, 0));
	result *= compare_vec2((blockE.o), vec2(0.0, 0.0));
	result *= compare_ivec4((blockE.p), ivec4(0, 0, 0, 0));
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
	mediump vec3 mA;
};
layout(set = 0, binding = 0) uniform BlockB
{
	highp mat4 a;
	mediump uvec3 b; // unused in both shaders
	highp mat3x2 c;
	mediump vec4 d;
	bvec2 e;
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	highp uvec3 f;
};
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	highp vec2 g; // unused in fragment shader
	lowp mat3x4 h;
	highp uvec4 i; // unused in fragment shader
	bvec3 j; // unused in vertex shader
	highp ivec2 k;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	sA l;
	lowp vec2 m;
	mediump ivec3 n;
	mediump vec2 o; // unused in vertex shader
	highp ivec4 p;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((blockB.a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.c), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockB.d), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockB.e), bvec2(false, false));
	result *= compare_uvec3((f), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockD.g), vec2(0.0, 0.0));
	result *= compare_mat3x4((blockD.h), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockD.i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((blockD.k), ivec2(0, 0));
	result *= compare_vec3((blockE.l.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_vec2((blockE.m), vec2(0.0, 0.0));
	result *= compare_ivec3((blockE.n), ivec3(0, 0, 0));
	result *= compare_ivec4((blockE.p), ivec4(0, 0, 0, 0));
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
	highp uvec2 mA;
	highp vec2 mB;
	bvec3 mC;
	mediump ivec4 mD;
};
struct sB
{
	lowp mat4x3 mA;
	highp mat2x3 mB;
	mediump vec4 mC;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp vec4 w;
	lowp uvec4 x;
	highp mat3 y;
	highp mat4 z;
};
layout(set = 0, binding = 6) uniform BlockH
{
	highp mat4x3 aa;
	highp int ab;
	highp mat2 ac;
	lowp mat3x2 ad; // unused in vertex shader
	mediump vec3 ae; // unused in vertex shader
};

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec4((w), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((x), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((y), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((z), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((aa), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((ab), 0);
	result *= compare_mat2((ac), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((ad), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((ae), vec3(0.0, 0.0, 0.0));
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
	mediump float mA; // unused in vertex shader
	bvec3 mB;
	mediump uvec4 mC;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	sA n;
	highp mat4x3 o; // unused in fragment shader
	lowp ivec4 p;
} blockG;

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockG.n.mA), 0.0);
	result *= compare_bvec3((blockG.n.mB), bvec3(false, false, false));
	result *= compare_uvec4((blockG.n.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x3((blockG.o), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockG.p), ivec4(0, 0, 0, 0));
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
	mediump vec3 mA;
	highp mat2x3 mB;
	lowp mat2x3 mC; // unused in fragment shader
	mediump vec4 mD;
};
struct sB
{
	sA mA;
	bool mB;
};
struct sC
{
	lowp mat2 mA;
	lowp mat4 mB;
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	bvec4 p;
	highp uvec4 q; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	highp uvec4 r;
	lowp mat3x2 s;
	mediump ivec3 t; // unused in fragment shader
};
layout(set = 0, binding = 6) uniform BlockH
{
	highp float u; // unused in fragment shader
	lowp ivec2 v;
	highp ivec3 w; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((blockF.p), bvec4(false, false, false, false));
	result *= compare_uvec4((blockF.q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((r), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x2((s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((t), ivec3(0, 0, 0));
	result *= compare_float((u), 0.0);
	result *= compare_ivec2((v), ivec2(0, 0));
	result *= compare_ivec3((w), ivec3(0, 0, 0));
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
	lowp uint mA[1]; // unused in both shaders
	highp uvec4 mB;
};
struct sB
{
	lowp ivec4 mA; // unused in both shaders
};
struct sC
{
	lowp int mA;
	mediump ivec4 mB;
};
struct sD
{
	lowp int mA; // unused in fragment shader
	highp mat3 mB; // unused in fragment shader
	mediump float mC;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	lowp mat2x3 a; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	sA b;
	mediump ivec3 c; // unused in fragment shader
};
layout(set = 0, binding = 2) uniform BlockD
{
	lowp mat3x2 d; // unused in vertex shader
	mediump mat4x2 e;
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	sD i;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec4((b.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x2((d), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((e), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockF.i.mC), 0.0);
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
	lowp uint mA[1]; // unused in both shaders
	highp uvec4 mB;
};
struct sB
{
	lowp ivec4 mA; // unused in both shaders
};
struct sC
{
	lowp int mA;
	mediump ivec4 mB;
};
struct sD
{
	lowp int mA; // unused in fragment shader
	highp mat3 mB; // unused in fragment shader
	mediump float mC;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	lowp mat2x3 a; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	sA b;
	mediump ivec3 c; // unused in fragment shader
};
layout(set = 0, binding = 2) uniform BlockD
{
	lowp mat3x2 d; // unused in vertex shader
	mediump mat4x2 e;
};
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	highp uvec2 f;
	sB g;
	sC h;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((blockB.a), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((b.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec3((c), ivec3(0, 0, 0));
	result *= compare_mat4x2((e), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE.f), uvec2(0u, 0u));
	result *= compare_int((blockE.h.mA), 0);
	result *= compare_ivec4((blockE.h.mB), ivec4(0, 0, 0, 0));
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
	lowp uint mA;
	mediump int mB; // unused in fragment shader
	bool mC; // unused in fragment shader
};
struct sB
{
	mediump uvec2 mA;
};
struct sC
{
	highp uvec4 mA;
};
struct sD
{
	sB mA;
	lowp uvec4 mB;
	mediump mat3x2 mC; // unused in vertex shader
	sC mD;
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	mediump mat4x3 p; // unused in vertex shader
	lowp uvec4 q; // unused in both shaders
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	highp ivec4 r;
	lowp vec4 s;
	highp vec3 t;
	bool u;
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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x3((blockF.p), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockF.q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec4((blockG.r), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockG.s), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockG.t), vec3(0.0, 0.0, 0.0));
	result *= compare_bool((blockG.u), false);
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
	bvec2 mA;
};
layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp uint s;
	bvec2 t;
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
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint((s), 0u);
	result *= compare_bvec2((t), bvec2(false, false));
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
	lowp uint mA;
};
struct sB
{
	highp uint mA;
	sA mB[7];
	highp mat2x3 mC;
	mediump float mD;
};
struct sC
{
	highp mat3 mA;
};
struct sD
{
	lowp mat3x2 mA;
};
struct sE
{
	sD mA; // unused in vertex shader
	mediump uint mB; // unused in fragment shader
	highp int mC; // unused in vertex shader
	bvec4 mD;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	mediump ivec4 q;
	lowp mat2x3 r;
	lowp uvec3 s;
	lowp ivec2 t;
} blockG;
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump mat2x3 u[2]; // unused in both shaders
	mediump ivec4 v;
	lowp mat3x2 w; // unused in fragment shader
	bvec2 x;
	highp mat3x2 y; // unused in vertex shader
} blockH;

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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec4((blockG.q), ivec4(0, 0, 0, 0));
	result *= compare_mat2x3((blockG.r), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockG.s), uvec3(0u, 0u, 0u));
	result *= compare_ivec2((blockG.t), ivec2(0, 0));
	result *= compare_mat2x3((blockH.u[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((blockH.u[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockH.v), ivec4(0, 0, 0, 0));
	result *= compare_mat3x2((blockH.w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockH.x), bvec2(false, false));
	result *= compare_mat3x2((blockH.y), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump ivec2 mA;
	lowp mat3x2 mB;
	highp float mC; // unused in fragment shader
};
struct sB
{
	highp uint mA;
	highp mat3x4 mB;
	mediump float mC;
	highp int mD;
};
struct sC
{
	lowp mat4 mA;
	mediump uint mB;
	bvec3 mC; // unused in both shaders
	highp float mD;
};
struct sD
{
	mediump ivec4 mA;
	bool mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	sA a; // unused in fragment shader
	lowp float b;
	highp mat2x3 c;
};
layout(set = 0, binding = 1) uniform BlockC
{
	mediump mat4 d;
	lowp mat3 e;
	mediump mat3x4 f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	bool g;
	sB h;
	highp ivec2 i; // unused in vertex shader
	bvec2 j;
	highp mat3 k;
} blockD;
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	lowp vec4 p;
	mediump mat2x3 q; // unused in fragment shader
	lowp mat3 r;
	mediump float s; // unused in vertex shader
	sD t;
} blockF;

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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((b), 0.0);
	result *= compare_mat2x3((c), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockC.d), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockC.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockC.f), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.g), false);
	result *= compare_uint((blockD.h.mA), 0u);
	result *= compare_mat3x4((blockD.h.mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockD.h.mC), 0.0);
	result *= compare_int((blockD.h.mD), 0);
	result *= compare_ivec2((blockD.i), ivec2(0, 0));
	result *= compare_bvec2((blockD.j), bvec2(false, false));
	result *= compare_mat3((blockD.k), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockF.p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF.r), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockF.s), 0.0);
	result *= compare_ivec4((blockF.t.mA), ivec4(0, 0, 0, 0));
	result *= compare_bool((blockF.t.mB), false);
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
	lowp mat3x2 mB;
	highp float mC; // unused in fragment shader
};
struct sB
{
	highp uint mA;
	highp mat3x4 mB;
	mediump float mC;
	highp int mD;
};
struct sC
{
	lowp mat4 mA;
	mediump uint mB;
	bvec3 mC; // unused in both shaders
	highp float mD;
};
struct sD
{
	mediump ivec4 mA;
	bool mB;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	sA a; // unused in fragment shader
	lowp float b;
	highp mat2x3 c;
};
layout(set = 0, binding = 1) uniform BlockC
{
	mediump mat4 d;
	lowp mat3 e;
	mediump mat3x4 f; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	bool g;
	sB h;
	highp ivec2 i; // unused in vertex shader
	bvec2 j;
	highp mat3 k;
} blockD;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	mediump float l;
	highp float m;
	sC n;
	mediump uint o; // unused in fragment shader
} blockE[2];

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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec2((a.mA), ivec2(0, 0));
	result *= compare_mat3x2((a.mB), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((a.mC), 0.0);
	result *= compare_float((b), 0.0);
	result *= compare_mat2x3((c), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockC.d), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockC.e), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockD.g), false);
	result *= compare_uint((blockD.h.mA), 0u);
	result *= compare_mat3x4((blockD.h.mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockD.h.mC), 0.0);
	result *= compare_int((blockD.h.mD), 0);
	result *= compare_bvec2((blockD.j), bvec2(false, false));
	result *= compare_mat3((blockD.k), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockE[0].l), 0.0);
	result *= compare_float((blockE[0].m), 0.0);
	result *= compare_mat4((blockE[0].n.mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockE[0].n.mB), 0u);
	result *= compare_float((blockE[0].n.mD), 0.0);
	result *= compare_uint((blockE[0].o), 0u);
	result *= compare_float((blockE[1].l), 0.0);
	result *= compare_float((blockE[1].m), 0.0);
	result *= compare_mat4((blockE[1].n.mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockE[1].n.mB), 0u);
	result *= compare_float((blockE[1].n.mD), 0.0);
	result *= compare_uint((blockE[1].o), 0u);
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
	bvec4 mA;
	mediump mat4x2 mB; // unused in fragment shader
	highp int mC; // unused in fragment shader
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	highp mat4 a;
	mediump vec3 b;
	highp mat3x4 c;
} blockB[3];
layout(set = 0, binding = 3) uniform BlockE
{
	highp vec4 g;
} blockE;
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	highp vec2 h;
	highp mat4x3 i;
	lowp mat3x4 j; // unused in both shaders
	highp mat3x4 k;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	bvec2 l;
} blockG[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((blockB[0].a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].b), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB[0].c), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB[1].a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].b), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB[1].c), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB[2].a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[2].b), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB[2].c), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockE.g), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((h), vec2(0.0, 0.0));
	result *= compare_mat4x3((i), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((k), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockG[0].l), bvec2(false, false));
	result *= compare_bvec2((blockG[1].l), bvec2(false, false));
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
	mediump mat4x2 mB; // unused in fragment shader
	highp int mC; // unused in fragment shader
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	highp mat4 a;
	mediump vec3 b;
	highp mat3x4 c;
} blockB[3];
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	sA d;
};
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	mediump mat2x3 e;
	highp ivec4 f;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((blockB[0].a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[0].b), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB[0].c), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB[1].a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[1].b), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB[1].c), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB[2].a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB[2].b), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockB[2].c), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((d.mA), bvec4(false, false, false, false));
	result *= compare_mat4x2((d.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((d.mC), 0);
	result *= compare_mat2x3((e), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((f), ivec4(0, 0, 0, 0));
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
	mediump uint mA;
	lowp mat3x2 mB; // unused in both shaders
	lowp vec3 mC;
	bool mD;
};
layout(set = 0, binding = 5) uniform BlockG
{
	bvec4 r;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((blockG.r), bvec4(false, false, false, false));
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
	mediump mat2x3 mA; // unused in vertex shader
	highp ivec4 mB;
	mediump vec3 mC;
};
struct sB
{
	sA mA; // unused in vertex shader
	mediump mat4x3 mB;
	highp mat4x2 mC;
	mediump mat3x2 mD;
};
struct sC
{
	bvec4 mA;
	lowp mat4x2 mB;
};
struct sD
{
	mediump mat2 mA;
	bool mB;
	mediump uvec4 mC;
	lowp mat3x2 mD;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	mediump uvec2 s; // unused in fragment shader
} blockG[1];
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	highp mat4 t;
} blockH;
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	lowp mat4x3 u;
} blockI;
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	lowp uint v;
	lowp uvec3 w;
	mediump vec2 x;
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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec2((blockG[0].s), uvec2(0u, 0u));
	result *= compare_mat4((blockH.t), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockI.u), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((v), 0u);
	result *= compare_uvec3((w), uvec3(0u, 0u, 0u));
	result *= compare_vec2((x), vec2(0.0, 0.0));
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
	mediump int mA; // unused in fragment shader
};
struct sB
{
	highp mat3x2 mA;
	bvec3 mB;
	mediump ivec3 mC;
};
layout(set = 0, binding = 4) uniform BlockF
{
	lowp ivec3 n[1];
	mediump mat3 o;
	mediump float p;
	highp mat4x2 q;
	highp uvec3 r;
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	lowp ivec4 s;
} blockG[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((n[0]), ivec3(0, 0, 0));
	result *= compare_mat3((o), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((p), 0.0);
	result *= compare_mat4x2((q), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((r), uvec3(0u, 0u, 0u));
	result *= compare_ivec4((blockG[0].s), ivec4(0, 0, 0, 0));
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
	lowp vec4 mA[3];
};
struct sB
{
	lowp vec2 mA; // unused in fragment shader
	mediump ivec4 mB; // unused in vertex shader
	highp ivec4 mC;
	lowp ivec3 mD;
};
struct sC
{
	mediump vec2 mA;
};
struct sD
{
	mediump mat4 mA;
};
layout(set = 0, binding = 5) uniform BlockG
{
	mediump ivec2 r; // unused in fragment shader
	highp mat4 s;
	lowp ivec2 t;
	lowp ivec3 u;
} blockG;
layout(set = 0, binding = 6) uniform BlockH
{
	highp ivec3 v[6];
	lowp mat3x2 w;
} blockH[3];
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	bvec2 x;
	sD y;
} blockI;
layout(set = 0, binding = 8, column_major) uniform BlockJ
{
	highp ivec2 z;
	mediump ivec3 aa;
	highp mat2x3 ab; // unused in vertex shader
	mediump vec4 ac;
};

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec2((blockG.r), ivec2(0, 0));
	result *= compare_mat4((blockG.s), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockG.t), ivec2(0, 0));
	result *= compare_ivec3((blockG.u), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[0].v[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[0].v[1]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[0].v[2]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[0].v[3]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[0].v[4]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[0].v[5]), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockH[0].w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH[1].v[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[1].v[1]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[1].v[2]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[1].v[3]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[1].v[4]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[1].v[5]), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockH[1].w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockH[2].v[0]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[2].v[1]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[2].v[2]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[2].v[3]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[2].v[4]), ivec3(0, 0, 0));
	result *= compare_ivec3((blockH[2].v[5]), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockH[2].w), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockI.x), bvec2(false, false));
	result *= compare_mat4((blockI.y.mA), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((z), ivec2(0, 0));
	result *= compare_ivec3((aa), ivec3(0, 0, 0));
	result *= compare_mat2x3((ab), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((ac), vec4(0.0, 0.0, 0.0, 0.0));
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
	lowp vec4 mA;
	highp ivec3 mB;
};
struct sB
{
	bool mA;
	mediump mat4 mB; // unused in vertex shader
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	bvec2 j;
	lowp mat3 k[4];
	mediump uint l[1];
	mediump ivec3 m; // unused in vertex shader
	highp uvec2 n;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
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
	result *= compare_bvec2((blockF.j), bvec2(false, false));
	result *= compare_mat3((blockF.k[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF.k[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF.k[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockF.k[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockF.l[0]), 0u);
	result *= compare_ivec3((blockF.m), ivec3(0, 0, 0));
	result *= compare_uvec2((blockF.n), uvec2(0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 5, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, row_major) uniform BlockF
{
	bvec3 i;
	lowp vec4 j;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((blockF.i), bvec3(false, false, false));
	result *= compare_vec4((blockF.j), vec4(0.0, 0.0, 0.0, 0.0));
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
	lowp ivec3 mA;
};
struct sB
{
	lowp uvec4 mA;
};
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	mediump mat4x2 r;
	mediump mat3x2 s; // unused in fragment shader
	mediump mat3x4 t[3][1];
} blockH[3];
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	bvec4 u;
	sB v;
	mediump mat4 w; // unused in both shaders
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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((blockH[0].r), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[0].s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[0].t[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[0].t[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[0].t[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH[1].r), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[1].s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[1].t[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[1].t[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[1].t[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH[2].r), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockH[2].s), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[2].t[0][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[2].t[1][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockH[2].t[2][0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((u), bvec4(false, false, false, false));
	result *= compare_uvec4((v.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4((w), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, row_major) uniform BlockF
{
	layout(offset = 8) highp int l; // unused in fragment shader
	layout(offset = 0) highp vec2 k;
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	layout(offset = 80) lowp vec4 o; // unused in fragment shader
	layout(offset = 0) highp vec2 m; // unused in vertex shader
	layout(offset = 16) highp mat4x3 n; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	layout(offset = 80) mediump float r[7];
	layout(offset = 0) mediump uvec3 p;
	layout(offset = 16) mediump mat4x2 q[2];
} blockH[3];

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
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((blockF.k), vec2(0.0, 0.0));
	result *= compare_int((blockF.l), 0);
	result *= compare_vec2((blockG.m), vec2(0.0, 0.0));
	result *= compare_mat4x3((blockG.n), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockG.o), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockH[0].p), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockH[0].q[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH[0].q[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockH[0].r[0]), 0.0);
	result *= compare_float((blockH[0].r[1]), 0.0);
	result *= compare_float((blockH[0].r[2]), 0.0);
	result *= compare_float((blockH[0].r[3]), 0.0);
	result *= compare_float((blockH[0].r[4]), 0.0);
	result *= compare_float((blockH[0].r[5]), 0.0);
	result *= compare_float((blockH[0].r[6]), 0.0);
	result *= compare_uvec3((blockH[1].p), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockH[1].q[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH[1].q[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockH[1].r[0]), 0.0);
	result *= compare_float((blockH[1].r[1]), 0.0);
	result *= compare_float((blockH[1].r[2]), 0.0);
	result *= compare_float((blockH[1].r[3]), 0.0);
	result *= compare_float((blockH[1].r[4]), 0.0);
	result *= compare_float((blockH[1].r[5]), 0.0);
	result *= compare_float((blockH[1].r[6]), 0.0);
	result *= compare_uvec3((blockH[2].p), uvec3(0u, 0u, 0u));
	result *= compare_mat4x2((blockH[2].q[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockH[2].q[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockH[2].r[0]), 0.0);
	result *= compare_float((blockH[2].r[1]), 0.0);
	result *= compare_float((blockH[2].r[2]), 0.0);
	result *= compare_float((blockH[2].r[3]), 0.0);
	result *= compare_float((blockH[2].r[4]), 0.0);
	result *= compare_float((blockH[2].r[5]), 0.0);
	result *= compare_float((blockH[2].r[6]), 0.0);
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
	lowp mat2 mA;
};
struct sB
{
	highp mat3x2 mA[2]; // unused in vertex shader
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 16) sB s; // unused in fragment shader
	layout(offset = 0) highp uint q;
	layout(offset = 8) bvec2 r;
};
layout(set = 0, binding = 6, scalar, column_major) uniform BlockH
{
	layout(offset = 24) highp mat4x3 v;
	layout(offset = 0) highp uvec4 t;
	layout(offset = 16) lowp ivec2 u; // unused in both shaders
};
layout(set = 0, binding = 7, scalar, column_major) uniform BlockI
{
	layout(offset = 144) lowp mat4x3 z;
	layout(offset = 0) highp mat3 w;
	layout(offset = 48) highp mat3x4 y[2];
	layout(offset = 36) bvec3 x;
} blockI[3];
layout(set = 0, binding = 8, column_major) uniform BlockJ
{
	layout(offset = 16) highp mat3x2 ab; // unused in fragment shader
	layout(offset = 0) bvec4 aa;
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
	result *= compare_uint((q), 0u);
	result *= compare_bvec2((r), bvec2(false, false));
	result *= compare_mat3x2((s.mA[0]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((s.mA[1]), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((t), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((u), ivec2(0, 0));
	result *= compare_mat4x3((v), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockI[0].w), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockI[0].x), bvec3(false, false, false));
	result *= compare_mat3x4((blockI[0].y[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockI[0].y[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockI[0].z), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockI[1].w), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockI[1].x), bvec3(false, false, false));
	result *= compare_mat3x4((blockI[1].y[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockI[1].y[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockI[1].z), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockI[2].w), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockI[2].x), bvec3(false, false, false));
	result *= compare_mat3x4((blockI[2].y[0]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockI[2].y[1]), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockI[2].z), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((aa), bvec4(false, false, false, false));
	result *= compare_mat3x2((ab), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp vec4 mA;
	lowp float mB;
	mediump vec4 mC;
};
struct sB
{
	mediump vec3 mA[1];
};
struct sC
{
	highp ivec4 mA;
};
struct sD
{
	highp mat3x2 mA; // unused in fragment shader
	sC mB; // unused in both shaders
	mediump int mC;
	lowp mat2 mD;
};
struct sE
{
	highp uint mA;
	lowp ivec4 mB; // unused in fragment shader
	mediump float mC; // unused in vertex shader
	bvec3 mD;
};
struct sF
{
	highp int mA; // unused in fragment shader
};
layout(set = 0, binding = 4, scalar) uniform BlockF
{
	layout(offset = 4) sB m;
	layout(offset = 0) bool l;
};
layout(set = 0, binding = 5) uniform BlockG
{
	layout(offset = 32) lowp mat3 q;
	layout(offset = 0) lowp uint n;
	layout(offset = 28) bool p;
	layout(offset = 16) mediump uvec3 o;
};
layout(set = 0, binding = 6, std430, column_major) uniform BlockH
{
	layout(offset = 128) sE u[1]; // unused in fragment shader
	layout(offset = 0) lowp mat4x2 r; // unused in fragment shader
	layout(offset = 112) lowp uvec3 t; // unused in both shaders
	layout(offset = 32) sD s; // unused in vertex shader
};
layout(set = 0, binding = 7, std430, row_major) uniform BlockI
{
	layout(offset = 64) sF x; // unused in vertex shader
	layout(offset = 0) bool v;
	layout(offset = 16) mediump mat4x3 w;
} blockI[2];

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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bool((l), false);
	result *= compare_vec3((m.mA[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((n), 0u);
	result *= compare_uvec3((o), uvec3(0u, 0u, 0u));
	result *= compare_bool((p), false);
	result *= compare_mat3((q), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((r), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((s.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((s.mB.mA), ivec4(0, 0, 0, 0));
	result *= compare_int((s.mC), 0);
	result *= compare_mat2((s.mD), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((t), uvec3(0u, 0u, 0u));
	result *= compare_uint((u[0].mA), 0u);
	result *= compare_ivec4((u[0].mB), ivec4(0, 0, 0, 0));
	result *= compare_float((u[0].mC), 0.0);
	result *= compare_bvec3((u[0].mD), bvec3(false, false, false));
	result *= compare_bool((blockI[0].v), false);
	result *= compare_mat4x3((blockI[0].w), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockI[0].x.mA), 0);
	result *= compare_bool((blockI[1].v), false);
	result *= compare_mat4x3((blockI[1].w), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockI[1].x.mA), 0);
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
	mediump uvec3 mA;
	highp mat4x3 mB;
	bool mC[4];
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	layout(offset = 192) lowp uint s;
	layout(offset = 0) highp mat4 q; // unused in vertex shader
	layout(offset = 64) highp int r[8];
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
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
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4((blockF.q), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockF.r[0]), 0);
	result *= compare_int((blockF.r[1]), 0);
	result *= compare_int((blockF.r[2]), 0);
	result *= compare_int((blockF.r[3]), 0);
	result *= compare_int((blockF.r[4]), 0);
	result *= compare_int((blockF.r[5]), 0);
	result *= compare_int((blockF.r[6]), 0);
	result *= compare_int((blockF.r[7]), 0);
	result *= compare_uint((blockF.s), 0u);
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
	highp ivec2 mA; // unused in vertex shader
};
struct sB
{
	highp mat3x4 mA; // unused in vertex shader
	highp vec4 mB; // unused in vertex shader
};
struct sC
{
	bool mA;
	lowp int mB[4][2];
	mediump mat3x2 mC;
};
layout(set = 0, binding = 5) uniform BlockG
{
	layout(offset = 112) highp ivec4 s;
	layout(offset = 0) lowp mat3x4 q; // unused in fragment shader
	layout(offset = 48) highp mat4x3 r;
} blockG;
layout(set = 0, binding = 6, std430, column_major) uniform BlockH
{
	layout(offset = 80) mediump vec2 v;
	layout(offset = 0) lowp uvec4 t;
	layout(offset = 16) mediump mat4 u[1]; // unused in fragment shader
} blockH;
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	layout(offset = 192) mediump ivec4 aa;
	layout(offset = 0) lowp mat4x2 w;
	layout(offset = 128) highp mat4 z;
	layout(offset = 64) bool x;
	layout(offset = 80) lowp float y[3]; // unused in both shaders
} blockI[3];

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
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((blockG.q), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockG.r), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockG.s), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((blockH.t), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4((blockH.u[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockH.v), vec2(0.0, 0.0));
	result *= compare_mat4x2((blockI[0].w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockI[0].x), false);
	result *= compare_float((blockI[0].y[0]), 0.0);
	result *= compare_float((blockI[0].y[1]), 0.0);
	result *= compare_float((blockI[0].y[2]), 0.0);
	result *= compare_mat4((blockI[0].z), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockI[0].aa), ivec4(0, 0, 0, 0));
	result *= compare_mat4x2((blockI[1].w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockI[1].x), false);
	result *= compare_float((blockI[1].y[0]), 0.0);
	result *= compare_float((blockI[1].y[1]), 0.0);
	result *= compare_float((blockI[1].y[2]), 0.0);
	result *= compare_mat4((blockI[1].z), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockI[1].aa), ivec4(0, 0, 0, 0));
	result *= compare_mat4x2((blockI[2].w), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockI[2].x), false);
	result *= compare_float((blockI[2].y[0]), 0.0);
	result *= compare_float((blockI[2].y[1]), 0.0);
	result *= compare_float((blockI[2].y[2]), 0.0);
	result *= compare_mat4((blockI[2].z), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockI[2].aa), ivec4(0, 0, 0, 0));
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
	mediump ivec4 mA;
	highp mat2x3 mB;
	lowp mat4 mC; // unused in fragment shader
	mediump mat2 mD;
};
struct sB
{
	lowp float mA;
};
struct sC
{
	highp mat2x3 mA;
};
struct sD
{
	highp ivec3 mA; // unused in vertex shader
	lowp mat2 mB[6]; // unused in vertex shader
};
struct sE
{
	lowp ivec4 mA[2];
	highp ivec4 mB;
	mediump vec2 mC;
};
struct sF
{
	mediump uvec2 mA;
	highp ivec3 mB;
	highp uvec4 mC;
	bvec4 mD;
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 96) lowp float aa; // unused in fragment shader
	layout(offset = 0) lowp float w;
	layout(offset = 92) mediump float z; // unused in vertex shader
	layout(offset = 16) lowp mat4 x; // unused in fragment shader
	layout(offset = 80) highp vec3 y;
} blockH;
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	layout(offset = 16) sE ac;
	layout(offset = 0) lowp float ab; // unused in fragment shader
};
layout(set = 0, binding = 8, scalar) uniform BlockJ
{
	layout(offset = 96) bvec2 ah;
	layout(offset = 0) lowp mat2x3 ad;
	layout(offset = 80) lowp mat2 ag;
	layout(offset = 24) sF ae;
	layout(offset = 76) lowp uint af;
};
layout(set = 0, binding = 9, std430) uniform BlockK
{
	layout(offset = 32) lowp float aj;
	layout(offset = 0) mediump mat4x2 ai;
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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float((blockH.w), 0.0);
	result *= compare_mat4((blockH.x), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockH.y), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockH.z), 0.0);
	result *= compare_float((blockH.aa), 0.0);
	result *= compare_float((ab), 0.0);
	result *= compare_ivec4((ac.mA[0]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((ac.mA[1]), ivec4(0, 0, 0, 0));
	result *= compare_ivec4((ac.mB), ivec4(0, 0, 0, 0));
	result *= compare_vec2((ac.mC), vec2(0.0, 0.0));
	result *= compare_mat2x3((ad), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((ae.mA), uvec2(0u, 0u));
	result *= compare_ivec3((ae.mB), ivec3(0, 0, 0));
	result *= compare_uvec4((ae.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_bvec4((ae.mD), bvec4(false, false, false, false));
	result *= compare_uint((af), 0u);
	result *= compare_mat2((ag), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((ah), bvec2(false, false));
	result *= compare_mat4x2((ai), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_float((aj), 0.0);
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
	lowp float a;
	int16_t b;
	int16_t c;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	uint16_t d;
	float16_t e;
	bool f;
	mediump float g;
};
layout(set = 0, binding = 2) uniform BlockD
{
	bool h;
	bool i;
	highp uint j;
	lowp float k;
	uint16_t l; // unused in fragment shader
};
layout(set = 0, binding = 4) uniform BlockF
{
	int16_t q; // unused in fragment shader
	float16_t r;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_float((a), 0.0);
	result *= compare_int16_t(int(b), 0);
	result *= compare_int16_t(int(c), 0);
	result *= compare_uint16_t(uint(d), 0u);
	result *= compare_float16_t(float(e), 0.0);
	result *= compare_bool((f), false);
	result *= compare_float((g), 0.0);
	result *= compare_bool((h), false);
	result *= compare_bool((i), false);
	result *= compare_uint((j), 0u);
	result *= compare_float((k), 0.0);
	result *= compare_float16_t(float(r), 0.0);
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
	int16_t b;
	int16_t c;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	uint16_t d;
	float16_t e;
	bool f;
	mediump float g;
};
layout(set = 0, binding = 2) uniform BlockD
{
	bool h;
	bool i;
	highp uint j;
	lowp float k;
	uint16_t l; // unused in fragment shader
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	float16_t m; // unused in both shaders
	uint16_t n;
	mediump uint o; // unused in fragment shader
	bool p;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((a), 0.0);
	result *= compare_int16_t(int(b), 0);
	result *= compare_int16_t(int(c), 0);
	result *= compare_uint16_t(uint(d), 0u);
	result *= compare_float16_t(float(e), 0.0);
	result *= compare_bool((f), false);
	result *= compare_float((g), 0.0);
	result *= compare_bool((h), false);
	result *= compare_bool((i), false);
	result *= compare_uint((j), 0u);
	result *= compare_float((k), 0.0);
	result *= compare_uint16_t(uint(l), 0u);
	result *= compare_uint16_t(uint(blockE.n), 0u);
	result *= compare_uint((blockE.o), 0u);
	result *= compare_bool((blockE.p), false);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 5, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140) uniform BlockF
{
	float16_t o; // unused in both shaders
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_float16_t(float(o), 0.0);
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
	float16_t k;
	mediump int l;
} blockF;
layout(set = 0, binding = 5) uniform BlockG
{
	highp float m;
	bool n;
	bool o; // unused in fragment shader
	uint16_t p;
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	highp float q;
	highp float r;
	highp int s;
};
layout(set = 0, binding = 7) uniform BlockI
{
	mediump float t;
	uint16_t u;
	lowp uint v;
	uint16_t w;
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
	result *= compare_float16_t(float(blockF.k), 0.0);
	result *= compare_int((blockF.l), 0);
	result *= compare_float((blockG.m), 0.0);
	result *= compare_bool((blockG.n), false);
	result *= compare_bool((blockG.o), false);
	result *= compare_uint16_t(uint(blockG.p), 0u);
	result *= compare_float((q), 0.0);
	result *= compare_float((r), 0.0);
	result *= compare_int((s), 0);
	result *= compare_float((blockI.t), 0.0);
	result *= compare_uint16_t(uint(blockI.u), 0u);
	result *= compare_uint((blockI.v), 0u);
	result *= compare_uint16_t(uint(blockI.w), 0u);
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
	bvec3 p;
	u16vec3 q;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((blockG.p), bvec3(false, false, false));
	result *= compare_u16vec3(uvec3(blockG.q), uvec3(0u, 0u, 0u));
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
	f16vec4 k;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	bool l; // unused in vertex shader
	f16vec3 m; // unused in fragment shader
	lowp uvec2 n;
	f16vec4 o; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	bool p;
	highp vec3 q;
	mediump vec2 r;
} blockH;
layout(set = 0, binding = 7) uniform BlockI
{
	mediump uvec4 s;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(k), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockG.l), false);
	result *= compare_f16vec3(vec3(blockG.m), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockG.n), uvec2(0u, 0u));
	result *= compare_f16vec4(vec4(blockG.o), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockH.p), false);
	result *= compare_vec3((blockH.q), vec3(0.0, 0.0, 0.0));
	result *= compare_vec2((blockH.r), vec2(0.0, 0.0));
	result *= compare_uvec4((s), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 7, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	mediump ivec3 t; // unused in fragment shader
	f16vec4 u; // unused in fragment shader
} blockG;
layout(set = 0, binding = 6, std140) uniform BlockH
{
	f16vec3 v; // unused in fragment shader
	i16vec4 w;
	u16vec3 x;
	bool y;
	highp uvec3 z; // unused in fragment shader
};

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
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_ivec3((blockG.t), ivec3(0, 0, 0));
	result *= compare_f16vec4(vec4(blockG.u), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(v), vec3(0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(w), ivec4(0, 0, 0, 0));
	result *= compare_u16vec3(uvec3(x), uvec3(0u, 0u, 0u));
	result *= compare_bool((y), false);
	result *= compare_uvec3((z), uvec3(0u, 0u, 0u));
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
	mediump mat2 a; // unused in vertex shader
	mediump mat2x3 b[4];
	f16vec3 c[8]; // unused in fragment shader
	u16vec4 d;
	mediump ivec3 e;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp mat3x2 f;
	highp ivec2 g;
	f16vec4 h;
	i16vec4 i; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	mediump uvec2 j;
	lowp mat3 k;
};
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	i16vec2 l;
	f16vec3 m;
	lowp uvec3 n[7];
	highp ivec3 o; // unused in vertex shader
	i16vec2 p; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat2((a), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((b[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((b[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((b[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((b[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec3((e), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockC.f), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC.g), ivec2(0, 0));
	result *= compare_f16vec4(vec4(blockC.h), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((j), uvec2(0u, 0u));
	result *= compare_mat3((k), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(l), ivec2(0, 0));
	result *= compare_f16vec3(vec3(m), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((n[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[4]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[5]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[6]), uvec3(0u, 0u, 0u));
	result *= compare_ivec3((o), ivec3(0, 0, 0));
	result *= compare_i16vec2(ivec2(p), ivec2(0, 0));
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
	mediump mat2 a; // unused in vertex shader
	mediump mat2x3 b[4];
	f16vec3 c[8]; // unused in fragment shader
	u16vec4 d;
	mediump ivec3 e;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp mat3x2 f;
	highp ivec2 g;
	f16vec4 h;
	i16vec4 i; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	mediump uvec2 j;
	lowp mat3 k;
};
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	i16vec2 l;
	f16vec3 m;
	lowp uvec3 n[7];
	highp ivec3 o; // unused in vertex shader
	i16vec2 p; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat2x3((b[0]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((b[1]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((b[2]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2x3((b[3]), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[6]), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(c[7]), vec3(0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec3((e), ivec3(0, 0, 0));
	result *= compare_mat3x2((blockC.f), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockC.g), ivec2(0, 0));
	result *= compare_f16vec4(vec4(blockC.h), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(blockC.i), ivec4(0, 0, 0, 0));
	result *= compare_uvec2((j), uvec2(0u, 0u));
	result *= compare_mat3((k), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(l), ivec2(0, 0));
	result *= compare_f16vec3(vec3(m), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((n[0]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[1]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[2]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[3]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[4]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[5]), uvec3(0u, 0u, 0u));
	result *= compare_uvec3((n[6]), uvec3(0u, 0u, 0u));
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
	highp vec3 a[4];
	highp vec3 b; // unused in fragment shader
	lowp uvec2 c; // unused in vertex shader
	lowp vec3 d;
	highp uvec4 e; // unused in both shaders
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump int f;
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	mediump mat3x4 g;
	lowp vec4 h[1];
	mediump ivec3 i; // unused in vertex shader
} blockD;
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	lowp vec2 k[6];
	u16vec3 l;
	int16_t m;
	highp mat2 n;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec3((blockB.a[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.a[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.a[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.a[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockB.c), uvec2(0u, 0u));
	result *= compare_vec3((blockB.d), vec3(0.0, 0.0, 0.0));
	result *= compare_int((blockC.f), 0);
	result *= compare_mat3x4((blockD.g), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockD.h[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec3((blockD.i), ivec3(0, 0, 0));
	result *= compare_vec2((blockF.k[0]), vec2(0.0, 0.0));
	result *= compare_vec2((blockF.k[1]), vec2(0.0, 0.0));
	result *= compare_vec2((blockF.k[2]), vec2(0.0, 0.0));
	result *= compare_vec2((blockF.k[3]), vec2(0.0, 0.0));
	result *= compare_vec2((blockF.k[4]), vec2(0.0, 0.0));
	result *= compare_vec2((blockF.k[5]), vec2(0.0, 0.0));
	result *= compare_u16vec3(uvec3(blockF.l), uvec3(0u, 0u, 0u));
	result *= compare_int16_t(int(blockF.m), 0);
	result *= compare_mat2((blockF.n), mat2(0.0, 0.0, 0.0, 0.0));
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
	highp vec3 a[4];
	highp vec3 b; // unused in fragment shader
	lowp uvec2 c; // unused in vertex shader
	lowp vec3 d;
	highp uvec4 e; // unused in both shaders
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump int f;
} blockC;
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	mediump mat3x4 g;
	lowp vec4 h[1];
	mediump ivec3 i; // unused in vertex shader
} blockD;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	mediump mat2 j;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec3((blockB.a[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.a[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.a[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.a[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.b), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.d), vec3(0.0, 0.0, 0.0));
	result *= compare_int((blockC.f), 0);
	result *= compare_mat3x4((blockD.g), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockD.h[0]), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockE.j), mat2(0.0, 0.0, 0.0, 0.0));
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
	mediump vec4 a;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump mat3x4 b;
	u16vec4 c;
} blockC;
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	mediump mat4x2 j;
	highp mat3 k; // unused in fragment shader
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	u16vec3 l; // unused in both shaders
	u16vec4 m;
	f16vec3 n; // unused in fragment shader
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec4((a), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockC.b), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockC.c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x2((j), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockG.m), uvec4(0u, 0u, 0u, 0u));
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
	mediump vec4 a;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump mat3x4 b;
	u16vec4 c;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	u16vec4 d[1];
	uint16_t e;
	lowp mat3x2 f;
} blockD;
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	f16vec3 g;
	mediump uvec2 h;
	u16vec3 i; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec4((a), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockC.b), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockC.c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(blockD.d[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint16_t(uint(blockD.e), 0u);
	result *= compare_mat3x2((blockD.f), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockE.g), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec2((blockE.h), uvec2(0u, 0u));
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
	mediump mat3 j;
	f16vec3 k; // unused in fragment shader
	highp ivec3 l; // unused in vertex shader
	f16vec4 m;
} blockG[3];
layout(set = 0, binding = 6) uniform BlockH
{
	mediump uvec3 n; // unused in fragment shader
	highp mat2 o; // unused in fragment shader
} blockH;
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	highp int p;
	lowp vec3 q;
} blockI[1];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3((blockG[0].j), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockG[0].k), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[0].l), ivec3(0, 0, 0));
	result *= compare_f16vec4(vec4(blockG[0].m), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG[1].j), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockG[1].k), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[1].l), ivec3(0, 0, 0));
	result *= compare_f16vec4(vec4(blockG[1].m), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG[2].j), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec3(vec3(blockG[2].k), vec3(0.0, 0.0, 0.0));
	result *= compare_ivec3((blockG[2].l), ivec3(0, 0, 0));
	result *= compare_f16vec4(vec4(blockG[2].m), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockH.n), uvec3(0u, 0u, 0u));
	result *= compare_mat2((blockH.o), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockI[0].p), 0);
	result *= compare_vec3((blockI[0].q), vec3(0.0, 0.0, 0.0));
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
	lowp float mA;
	u16vec4 mB;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	highp uint a;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	f16vec4 b; // unused in fragment shader
	sA c;
} blockC;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	mediump mat2x3 g;
	int16_t h; // unused in vertex shader
	mediump mat3x2 i;
	i16vec2 j;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	highp float k;
	highp mat2 l; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((blockB.a), 0u);
	result *= compare_float((blockC.c.mA), 0.0);
	result *= compare_u16vec4(uvec4(blockC.c.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2x3((g), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int16_t(int(h), 0);
	result *= compare_mat3x2((i), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec2(ivec2(j), ivec2(0, 0));
	result *= compare_float((k), 0.0);
	result *= compare_mat2((l), mat2(0.0, 0.0, 0.0, 0.0));
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
	lowp float mA;
	u16vec4 mB;
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	highp uint a;
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	f16vec4 b; // unused in fragment shader
	sA c;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	u16vec4 d;
	lowp mat2 e;
	lowp ivec2 f;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint((blockB.a), 0u);
	result *= compare_f16vec4(vec4(blockC.b), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((blockC.c.mA), 0.0);
	result *= compare_u16vec4(uvec4(blockC.c.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2((e), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((f), ivec2(0, 0));
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
	i16vec4 mA;
};
layout(set = 0, binding = 0) uniform BlockB
{
	lowp ivec2 a;
} blockB;
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	mediump ivec4 b;
	highp uint c; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	sA d;
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	highp uvec3 h; // unused in fragment shader
	mediump float i;
	f16vec2 j; // unused in vertex shader
	f16vec4 k; // unused in vertex shader
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec2((blockB.a), ivec2(0, 0));
	result *= compare_ivec4((blockC.b), ivec4(0, 0, 0, 0));
	result *= compare_uint((blockC.c), 0u);
	result *= compare_i16vec4(ivec4(d.mA), ivec4(0, 0, 0, 0));
	result *= compare_float((blockF.i), 0.0);
	result *= compare_f16vec2(vec2(blockF.j), vec2(0.0, 0.0));
	result *= compare_f16vec4(vec4(blockF.k), vec4(0.0, 0.0, 0.0, 0.0));
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
	i16vec4 mA;
};
layout(set = 0, binding = 0) uniform BlockB
{
	lowp ivec2 a;
} blockB;
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	mediump ivec4 b;
	highp uint c; // unused in vertex shader
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	sA d;
};
layout(set = 0, binding = 3, std140, row_major) uniform BlockE
{
	lowp vec2 e;
	highp vec4 f;
	i16vec4 g;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec2((blockB.a), ivec2(0, 0));
	result *= compare_ivec4((blockC.b), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(d.mA), ivec4(0, 0, 0, 0));
	result *= compare_vec2((e), vec2(0.0, 0.0));
	result *= compare_vec4((f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(g), ivec4(0, 0, 0, 0));
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
	mediump mat3x4 mA;
	mediump vec2 mB;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	u16vec3 a;
	highp mat3 b;
	highp int c; // unused in fragment shader
	highp mat4x3 d; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp mat3x2 e;
	lowp int f;
	i16vec3 g;
	bvec2 h;
	lowp uvec4 i;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	mediump mat2 j; // unused in vertex shader
	lowp vec3 k; // unused in fragment shader
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	lowp mat3x4 l;
	lowp uint m;
	float16_t n;
	mediump int o; // unused in fragment shader
	sA p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(blockB.a), uvec3(0u, 0u, 0u));
	result *= compare_mat3((blockB.b), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.e), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockC.f), 0);
	result *= compare_i16vec3(ivec3(blockC.g), ivec3(0, 0, 0));
	result *= compare_bvec2((blockC.h), bvec2(false, false));
	result *= compare_uvec4((blockC.i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat2((j), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((l), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((m), 0u);
	result *= compare_float16_t(float(n), 0.0);
	result *= compare_mat3x4((p.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((p.mB), vec2(0.0, 0.0));
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
	mediump mat3x4 mA;
	mediump vec2 mB;
};
layout(set = 0, binding = 0, std140, column_major) uniform BlockB
{
	u16vec3 a;
	highp mat3 b;
	highp int c; // unused in fragment shader
	highp mat4x3 d; // unused in fragment shader
} blockB;
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp mat3x2 e;
	lowp int f;
	i16vec3 g;
	bvec2 h;
	lowp uvec4 i;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	mediump mat2 j; // unused in vertex shader
	lowp vec3 k; // unused in fragment shader
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	lowp mat3x4 l;
	lowp uint m;
	float16_t n;
	mediump int o; // unused in fragment shader
	sA p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_u16vec3(uvec3(blockB.a), uvec3(0u, 0u, 0u));
	result *= compare_mat3((blockB.b), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockB.c), 0);
	result *= compare_mat4x3((blockB.d), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockC.e), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockC.f), 0);
	result *= compare_i16vec3(ivec3(blockC.g), ivec3(0, 0, 0));
	result *= compare_bvec2((blockC.h), bvec2(false, false));
	result *= compare_uvec4((blockC.i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec3((k), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((l), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((m), 0u);
	result *= compare_float16_t(float(n), 0.0);
	result *= compare_int((o), 0);
	result *= compare_mat3x4((p.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((p.mB), vec2(0.0, 0.0));
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
	bool mA;
	mediump mat2 mB; // unused in fragment shader
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	f16vec2 a;
	mediump vec4 b;
	float16_t c; // unused in vertex shader
} blockB;
layout(set = 0, binding = 2) uniform BlockD
{
	bvec2 i;
	mediump mat4x3 j; // unused in vertex shader
} blockD;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(blockB.a), vec2(0.0, 0.0));
	result *= compare_vec4((blockB.b), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float16_t(float(blockB.c), 0.0);
	result *= compare_bvec2((blockD.i), bvec2(false, false));
	result *= compare_mat4x3((blockD.j), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	bool mA;
	mediump mat2 mB; // unused in fragment shader
};
layout(set = 0, binding = 0, row_major) uniform BlockB
{
	f16vec2 a;
	mediump vec4 b;
	float16_t c; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	mediump uvec2 d;
	f16vec3 e; // unused in vertex shader
	lowp ivec4 f; // unused in both shaders
	sA g;
	mediump uvec2 h; // unused in fragment shader
} blockC;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_f16vec2(vec2(blockB.a), vec2(0.0, 0.0));
	result *= compare_vec4((blockB.b), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockC.d), uvec2(0u, 0u));
	result *= compare_bool((blockC.g.mA), false);
	result *= compare_mat2((blockC.g.mB), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockC.h), uvec2(0u, 0u));
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
	highp uvec2 a;
};
layout(set = 0, binding = 3, column_major) uniform BlockE
{
	highp mat3 j;
	u16vec3 k;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uvec2((a), uvec2(0u, 0u));
	result *= compare_mat3((blockE.j), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec3(uvec3(blockE.k), uvec3(0u, 0u, 0u));
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
	highp uvec2 a;
};
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	mediump mat3x4 b;
	lowp mat2 c;
	bvec3 d;
	u16vec4 e; // unused in both shaders
} blockC;
layout(set = 0, binding = 2, row_major) uniform BlockD
{
	bvec3 f; // unused in fragment shader
	float16_t g;
	u16vec4 h;
	lowp mat2x3 i; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uvec2((a), uvec2(0u, 0u));
	result *= compare_mat3x4((blockC.b), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockC.c), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockC.d), bvec3(false, false, false));
	result *= compare_bvec3((f), bvec3(false, false, false));
	result *= compare_float16_t(float(g), 0.0);
	result *= compare_u16vec4(uvec4(h), uvec4(0u, 0u, 0u, 0u));
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
	lowp ivec3 mA;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp ivec3 a;
	lowp int b;
};
layout(set = 0, binding = 1) uniform BlockC
{
	u16vec4 c;
	lowp ivec2 d;
} blockC;
layout(set = 0, binding = 3, row_major) uniform BlockE
{
	lowp uvec3 i;
	mediump vec3 j;
	bvec4 k; // unused in vertex shader
};
layout(set = 0, binding = 4, column_major) uniform BlockF
{
	sA l;
	f16vec3 m; // unused in vertex shader
	highp mat3x4 n;
	u16vec2 o;
	uint16_t p;
} blockF[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((a), ivec3(0, 0, 0));
	result *= compare_int((b), 0);
	result *= compare_u16vec4(uvec4(blockC.c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((blockC.d), ivec2(0, 0));
	result *= compare_uvec3((i), uvec3(0u, 0u, 0u));
	result *= compare_vec3((j), vec3(0.0, 0.0, 0.0));
	result *= compare_bvec4((k), bvec4(false, false, false, false));
	result *= compare_ivec3((blockF[0].l.mA), ivec3(0, 0, 0));
	result *= compare_f16vec3(vec3(blockF[0].m), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF[0].n), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockF[0].o), uvec2(0u, 0u));
	result *= compare_uint16_t(uint(blockF[0].p), 0u);
	result *= compare_ivec3((blockF[1].l.mA), ivec3(0, 0, 0));
	result *= compare_f16vec3(vec3(blockF[1].m), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF[1].n), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockF[1].o), uvec2(0u, 0u));
	result *= compare_uint16_t(uint(blockF[1].p), 0u);
	result *= compare_ivec3((blockF[2].l.mA), ivec3(0, 0, 0));
	result *= compare_f16vec3(vec3(blockF[2].m), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF[2].n), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec2(uvec2(blockF[2].o), uvec2(0u, 0u));
	result *= compare_uint16_t(uint(blockF[2].p), 0u);
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
	lowp ivec3 mA;
};
layout(set = 0, binding = 0, column_major) uniform BlockB
{
	highp ivec3 a;
	lowp int b;
};
layout(set = 0, binding = 1) uniform BlockC
{
	u16vec4 c;
	lowp ivec2 d;
} blockC;
layout(set = 0, binding = 2, std140, column_major) uniform BlockD
{
	i16vec4 e; // unused in fragment shader
	f16vec4 f;
	mediump ivec4 g;
	int16_t h;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((a), ivec3(0, 0, 0));
	result *= compare_int((b), 0);
	result *= compare_u16vec4(uvec4(blockC.c), uvec4(0u, 0u, 0u, 0u));
	result *= compare_ivec2((blockC.d), ivec2(0, 0));
	result *= compare_i16vec4(ivec4(e), ivec4(0, 0, 0, 0));
	result *= compare_f16vec4(vec4(f), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((g), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(h), 0);
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
	int16_t mA;
	float16_t mB; // unused in vertex shader
};
struct sB
{
	highp float mA;
	u16vec2 mB;
	lowp vec4 mC;
};
struct sC
{
	mediump mat4 mA;
	sB mB; // unused in vertex shader
	u16vec3 mC; // unused in vertex shader
};
layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	uint16_t j;
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	highp vec2 k; // unused in fragment shader
	highp vec4 l;
};
layout(set = 0, binding = 6) uniform BlockH
{
	highp float m; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(blockF.j), 0u);
	result *= compare_vec2((k), vec2(0.0, 0.0));
	result *= compare_vec4((l), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_float((m), 0.0);
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
	highp mat3x2 o;
	bvec3 p;
};
layout(set = 0, binding = 6, std140, row_major) uniform BlockH
{
	highp mat4 q[3];
	i16vec3 r[5];
	mediump vec2 s;
	float16_t t;
	bvec3 u; // unused in fragment shader
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	f16vec2 v;
	highp ivec4 w;
};
layout(set = 0, binding = 8, std140, column_major) uniform BlockJ
{
	int16_t x;
} blockJ[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((o), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((p), bvec3(false, false, false));
	result *= compare_mat4((q[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((q[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((q[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec3(ivec3(r[0]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(r[1]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(r[2]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(r[3]), ivec3(0, 0, 0));
	result *= compare_i16vec3(ivec3(r[4]), ivec3(0, 0, 0));
	result *= compare_vec2((s), vec2(0.0, 0.0));
	result *= compare_float16_t(float(t), 0.0);
	result *= compare_bvec3((u), bvec3(false, false, false));
	result *= compare_f16vec2(vec2(v), vec2(0.0, 0.0));
	result *= compare_ivec4((w), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(blockJ[0].x), 0);
	result *= compare_int16_t(int(blockJ[1].x), 0);
	result *= compare_int16_t(int(blockJ[2].x), 0);
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
	highp mat2 mA;
};
struct sB
{
	bvec4 mA;
	i16vec2 mB;
	lowp mat3 mC;
};
struct sC
{
	u16vec4 mA;
	mediump mat3x4 mB;
	f16vec2 mC; // unused in both shaders
};
struct sD
{
	lowp uvec4 mA;
	highp int mB;
	u16vec4 mC; // unused in fragment shader
	lowp uvec2 mD; // unused in vertex shader
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	uint16_t s;
	mediump ivec3 t; // unused in fragment shader
	i16vec4 u[7];
	mediump mat4 v; // unused in vertex shader
	mediump ivec2 w; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5, std140) uniform BlockG
{
	highp mat4x2 x;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	bvec2 y; // unused in fragment shader
	i16vec2 z[8]; // unused in both shaders
	uint16_t aa;
};
layout(set = 0, binding = 7, std140) uniform BlockI
{
	highp mat3x2 ab; // unused in vertex shader
	bvec2 ac;
	sD ad;
	int16_t ae;
	highp uint af;
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
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uint16_t(uint(blockF.s), 0u);
	result *= compare_ivec3((blockF.t), ivec3(0, 0, 0));
	result *= compare_i16vec4(ivec4(blockF.u[0]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockF.u[1]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockF.u[2]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockF.u[3]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockF.u[4]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockF.u[5]), ivec4(0, 0, 0, 0));
	result *= compare_i16vec4(ivec4(blockF.u[6]), ivec4(0, 0, 0, 0));
	result *= compare_mat4((blockF.v), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((blockF.w), ivec2(0, 0));
	result *= compare_mat4x2((x), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((y), bvec2(false, false));
	result *= compare_i16vec2(ivec2(z[0]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(z[1]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(z[2]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(z[3]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(z[4]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(z[5]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(z[6]), ivec2(0, 0));
	result *= compare_i16vec2(ivec2(z[7]), ivec2(0, 0));
	result *= compare_uint16_t(uint(aa), 0u);
	result *= compare_mat3x2((ab), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((ac), bvec2(false, false));
	result *= compare_uvec4((ad.mA), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((ad.mB), 0);
	result *= compare_u16vec4(uvec4(ad.mC), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((ad.mD), uvec2(0u, 0u));
	result *= compare_int16_t(int(ae), 0);
	result *= compare_uint((af), 0u);
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
};
struct sB
{
	mediump mat4x3 mA;
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	layout(offset = 64) mediump mat4x3 l;
	layout(offset = 0) lowp mat4 k; // unused in vertex shader
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 16) mediump mat4x2 n[5];
	layout(offset = 0) f16vec4 m;
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 16) mediump mat2x3 q;
	layout(offset = 0) i16vec4 o; // unused in fragment shader
	layout(offset = 8) int16_t p;
};
layout(set = 0, binding = 7, std140, row_major) uniform BlockI
{
	layout(offset = 144) lowp mat3x2 v;
	layout(offset = 0) highp mat4 r; // unused in fragment shader
	layout(offset = 96) sB u; // unused in fragment shader
	layout(offset = 64) mediump uvec3 s; // unused in vertex shader
	layout(offset = 80) highp ivec4 t;
} blockI;

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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4((k), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((l), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_f16vec4(vec4(blockG.m), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.n[0]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.n[1]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.n[2]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.n[3]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockG.n[4]), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i16vec4(ivec4(o), ivec4(0, 0, 0, 0));
	result *= compare_int16_t(int(p), 0);
	result *= compare_mat2x3((q), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockI.r), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockI.s), uvec3(0u, 0u, 0u));
	result *= compare_ivec4((blockI.t), ivec4(0, 0, 0, 0));
	result *= compare_mat4x3((blockI.u.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockI.v), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 60) uint16_t o; // unused in vertex shader
	layout(offset = 0) bvec2 m[3];
	layout(offset = 48) highp vec3 n; // unused in both shaders
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 0) u16vec3 p;
} blockH[2];
layout(set = 0, binding = 7, row_major) uniform BlockI
{
	layout(offset = 0) mediump ivec2 q;
} blockI[2];
layout(set = 0, binding = 8) uniform BlockJ
{
	layout(offset = 0) u16vec3 r;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec2((blockG.m[0]), bvec2(false, false));
	result *= compare_bvec2((blockG.m[1]), bvec2(false, false));
	result *= compare_bvec2((blockG.m[2]), bvec2(false, false));
	result *= compare_vec3((blockG.n), vec3(0.0, 0.0, 0.0));
	result *= compare_uint16_t(uint(blockG.o), 0u);
	result *= compare_u16vec3(uvec3(blockH[0].p), uvec3(0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(blockH[1].p), uvec3(0u, 0u, 0u));
	result *= compare_ivec2((blockI[0].q), ivec2(0, 0));
	result *= compare_ivec2((blockI[1].q), ivec2(0, 0));
	result *= compare_u16vec3(uvec3(r), uvec3(0u, 0u, 0u));
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
	lowp mat3x2 mA; // unused in fragment shader
	mediump uvec4 mB; // unused in vertex shader
};
struct sB
{
	highp mat4x3 mA;
	highp mat2x3 mB;
	mediump uvec4 mC;
	lowp ivec3 mD; // unused in fragment shader
};
struct sC
{
	u16vec4 mA[4];
};
layout(set = 0, binding = 4, scalar, column_major) uniform BlockF
{
	layout(offset = 28) sC s;
	layout(offset = 0) lowp vec3 q; // unused in fragment shader
	layout(offset = 12) mediump vec4 r;
};
layout(set = 0, binding = 5, scalar, row_major) uniform BlockG
{
	layout(offset = 24) mediump uint v;
	layout(offset = 0) u16vec3 t; // unused in both shaders
	layout(offset = 8) mediump float u[4];
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((q), vec3(0.0, 0.0, 0.0));
	result *= compare_vec4((r), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(s.mA[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(s.mA[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(s.mA[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec4(uvec4(s.mA[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u16vec3(uvec3(t), uvec3(0u, 0u, 0u));
	result *= compare_float((u[0]), 0.0);
	result *= compare_float((u[1]), 0.0);
	result *= compare_float((u[2]), 0.0);
	result *= compare_float((u[3]), 0.0);
	result *= compare_uint((v), 0u);
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std430) uniform BlockG
{
	bool o;
	highp mat4x2 p;
	u16vec4 q;
	highp mat3 r;
} blockG;
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	uint16_t s;
} blockH;
layout(set = 0, binding = 7, std140, column_major) uniform BlockI
{
	highp int t; // unused in vertex shader
	highp ivec2 u;
	highp uvec4 v;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int16_t  (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bool((blockG.o), false);
	result *= compare_mat4x2((blockG.p), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(blockG.q), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((blockG.r), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint16_t(uint(blockH.s), 0u);
	result *= compare_int((t), 0);
	result *= compare_ivec2((u), ivec2(0, 0));
	result *= compare_uvec4((v), uvec4(0u, 0u, 0u, 0u));
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
	f16vec4 n;
	u16vec4 o;
	f16vec4 p;
	highp int q;
	uint16_t r; // unused in fragment shader
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	highp ivec2 s;
};
layout(set = 0, binding = 7, column_major) uniform BlockI
{
	mediump vec4 t;
	lowp mat3 u;
	highp uvec4 v;
	mediump mat4 w;
};
layout(set = 0, binding = 8, std430, column_major) uniform BlockJ
{
	lowp uvec3 x;
	bvec2 y;
	mediump vec4 z;
	bvec4 aa; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_f16vec4(vec4(n), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_u16vec4(uvec4(o), uvec4(0u, 0u, 0u, 0u));
	result *= compare_f16vec4(vec4(p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((q), 0);
	result *= compare_uint16_t(uint(r), 0u);
	result *= compare_ivec2((s), ivec2(0, 0));
	result *= compare_vec4((t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((u), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((v), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4((w), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((x), uvec3(0u, 0u, 0u));
	result *= compare_bvec2((y), bvec2(false, false));
	result *= compare_vec4((z), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((aa), bvec4(false, false, false, false));
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
	lowp vec3 n;
	f16vec2 o;
	f16vec4 p;
	mediump int q;
} blockF;
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	bvec2 r;
};
layout(set = 0, binding = 6, std430) uniform BlockH
{
	f16vec4 s;
	lowp mat4x3 t;
	mediump uint u;
} blockH;
layout(set = 0, binding = 7, std430, column_major) uniform BlockI
{
	bool v;
} blockI;

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
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint16_t (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((blockF.n), vec3(0.0, 0.0, 0.0));
	result *= compare_f16vec2(vec2(blockF.o), vec2(0.0, 0.0));
	result *= compare_f16vec4(vec4(blockF.p), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_int((blockF.q), 0);
	result *= compare_bvec2((r), bvec2(false, false));
	result *= compare_f16vec4(vec4(blockH.s), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockH.t), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((blockH.u), 0u);
	result *= compare_bool((blockI.v), false);
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
	lowp uint a; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	highp float b; // unused in vertex shader
	lowp uint c; // unused in vertex shader
	mediump float d; // unused in fragment shader
	int8_t e; // unused in vertex shader
};
layout(set = 0, binding = 4, std140) uniform BlockF
{
	bool n;
	lowp int o;
	highp uint p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((blockB.a), 0u);
	result *= compare_float((b), 0.0);
	result *= compare_uint((c), 0u);
	result *= compare_int8_t(int(e), 0);
	result *= compare_bool((n), false);
	result *= compare_int((o), 0);
	result *= compare_uint((p), 0u);
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
	lowp uint a; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	highp float b; // unused in vertex shader
	lowp uint c; // unused in vertex shader
	mediump float d; // unused in fragment shader
	int8_t e; // unused in vertex shader
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	bool f;
	uint8_t g; // unused in vertex shader
	mediump uint h; // unused in both shaders
	int8_t i;
	int8_t j; // unused in both shaders
};
layout(set = 0, binding = 3) uniform BlockE
{
	int8_t k;
	mediump float l; // unused in fragment shader
	uint8_t m; // unused in vertex shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_float((d), 0.0);
	result *= compare_bool((f), false);
	result *= compare_int8_t(int(i), 0);
	result *= compare_int8_t(int(blockE.k), 0);
	result *= compare_float((blockE.l), 0.0);
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
	uint8_t a;
	bool b; // unused in fragment shader
	bool c;
	bool d;
	highp int e; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump float f; // unused in both shaders
	lowp uint g;
	highp uint h;
	mediump float i; // unused in vertex shader
	mediump uint j; // unused in vertex shader
};
layout(set = 0, binding = 2) uniform BlockD
{
	uint8_t k;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	int8_t l;
	lowp int m;
	highp float n;
	lowp int o;
	bool p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockB.a), 0u);
	result *= compare_bool((blockB.c), false);
	result *= compare_bool((blockB.d), false);
	result *= compare_int((blockB.e), 0);
	result *= compare_uint((g), 0u);
	result *= compare_uint((h), 0u);
	result *= compare_float((i), 0.0);
	result *= compare_uint((j), 0u);
	result *= compare_uint8_t(uint(blockD.k), 0u);
	result *= compare_int8_t(int(l), 0);
	result *= compare_int((m), 0);
	result *= compare_float((n), 0.0);
	result *= compare_int((o), 0);
	result *= compare_bool((p), false);
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
	bool b; // unused in fragment shader
	bool c;
	bool d;
	highp int e; // unused in vertex shader
} blockB;
layout(set = 0, binding = 1) uniform BlockC
{
	mediump float f; // unused in both shaders
	lowp uint g;
	highp uint h;
	mediump float i; // unused in vertex shader
	mediump uint j; // unused in vertex shader
};
layout(set = 0, binding = 2) uniform BlockD
{
	uint8_t k;
} blockD;
layout(set = 0, binding = 3) uniform BlockE
{
	int8_t l;
	lowp int m;
	highp float n;
	lowp int o;
	bool p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_uint8_t(uint(blockB.a), 0u);
	result *= compare_bool((blockB.b), false);
	result *= compare_bool((blockB.c), false);
	result *= compare_bool((blockB.d), false);
	result *= compare_uint((g), 0u);
	result *= compare_uint((h), 0u);
	result *= compare_uint8_t(uint(blockD.k), 0u);
	result *= compare_int8_t(int(l), 0);
	result *= compare_int((m), 0);
	result *= compare_float((n), 0.0);
	result *= compare_int((o), 0);
	result *= compare_bool((p), false);
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
	mediump ivec4 a; // unused in fragment shader
	highp uvec4 b; // unused in fragment shader
	lowp uint c;
	lowp int d; // unused in vertex shader
	highp vec4 e;
};
layout(set = 0, binding = 2, std140) uniform BlockD
{
	mediump uvec2 g; // unused in vertex shader
	lowp vec2 h;
	mediump vec4 i;
};
layout(set = 0, binding = 3) uniform BlockE
{
	u8vec3 j; // unused in fragment shader
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_uint((c), 0u);
	result *= compare_int((d), 0);
	result *= compare_vec4((e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((g), uvec2(0u, 0u));
	result *= compare_vec2((h), vec2(0.0, 0.0));
	result *= compare_vec4((i), vec4(0.0, 0.0, 0.0, 0.0));
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
	mediump ivec4 a; // unused in fragment shader
	highp uvec4 b; // unused in fragment shader
	lowp uint c;
	lowp int d; // unused in vertex shader
	highp vec4 e;
};
layout(set = 0, binding = 1, std140) uniform BlockC
{
	highp uint f; // unused in fragment shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec4((a), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((b), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uint((c), 0u);
	result *= compare_vec4((e), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((f), 0u);
    v_vtxResult = result;
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 5, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140) uniform BlockF
{
	bvec4 j; // unused in fragment shader
	lowp uvec4 k; // unused in vertex shader
	i8vec3 l;
	highp vec2 m;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec4((blockF.j), bvec4(false, false, false, false));
	result *= compare_uvec4((blockF.k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec3(ivec3(blockF.l), ivec3(0, 0, 0));
	result *= compare_vec2((blockF.m), vec2(0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 5, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140, column_major) uniform BlockF
{
	lowp mat3x2 h;
	lowp mat2 i;
	bvec2 j;
	highp uvec2 k; // unused in vertex shader
	mediump mat2x3 l; // unused in fragment shader
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x2((blockF.h), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockF.i), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((blockF.j), bvec2(false, false));
	result *= compare_uvec2((blockF.k), uvec2(0u, 0u));
	result *= compare_mat2x3((blockF.l), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp mat4 a;
	highp ivec4 b;
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	mediump vec3 c;
	u8vec4 d;
};
layout(set = 0, binding = 3, std140) uniform BlockE
{
	u8vec3 f;
	mediump mat3x2 g;
} blockE;
layout(set = 0, binding = 4, std140, row_major) uniform BlockF
{
	lowp mat3 h; // unused in vertex shader
	i8vec4 i;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_mat4((blockB.a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockB.b), ivec4(0, 0, 0, 0));
	result *= compare_vec3((c), vec3(0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockE.f), uvec3(0u, 0u, 0u));
	result *= compare_mat3x2((blockE.g), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((h), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(i), ivec4(0, 0, 0, 0));
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
	lowp mat4 a;
	highp ivec4 b;
} blockB;
layout(set = 0, binding = 1, std140, row_major) uniform BlockC
{
	mediump vec3 c;
	u8vec4 d;
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	highp int e;
} blockD;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_mat4((blockB.a), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockB.b), ivec4(0, 0, 0, 0));
	result *= compare_vec3((c), vec3(0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(d), uvec4(0u, 0u, 0u, 0u));
	result *= compare_int((blockD.e), 0);
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
	lowp mat4x3 mA;
	bvec3 mB;
	bool mC;
};
layout(set = 0, binding = 0) uniform BlockB
{
	lowp ivec3 a;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	int8_t b;
	lowp vec4 c;
	bvec4 d;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp mat4x3 e;
	sA f;
	highp mat4 g;
} blockD;
layout(set = 0, binding = 4) uniform BlockF
{
	lowp mat3x4 l;
} blockF;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_int8_t(int(blockC.b), 0);
	result *= compare_vec4((blockC.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockC.d), bvec4(false, false, false, false));
	result *= compare_mat4x3((blockD.e), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockD.f.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockD.f.mB), bvec3(false, false, false));
	result *= compare_bool((blockD.f.mC), false);
	result *= compare_mat4((blockD.g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockF.l), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	lowp mat4x3 mA;
	bvec3 mB;
	bool mC;
};
layout(set = 0, binding = 0) uniform BlockB
{
	lowp ivec3 a;
} blockB;
layout(set = 0, binding = 1, column_major) uniform BlockC
{
	int8_t b;
	lowp vec4 c;
	bvec4 d;
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	highp mat4x3 e;
	sA f;
	highp mat4 g;
} blockD;
layout(set = 0, binding = 3, std140) uniform BlockE
{
	u8vec4 h;
	mediump uvec4 i;
	i8vec2 j;
	mediump uvec2 k;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec3((blockB.a), ivec3(0, 0, 0));
	result *= compare_int8_t(int(blockC.b), 0);
	result *= compare_vec4((blockC.c), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec4((blockC.d), bvec4(false, false, false, false));
	result *= compare_mat4x3((blockD.e), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockD.f.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockD.f.mB), bvec3(false, false, false));
	result *= compare_bool((blockD.f.mC), false);
	result *= compare_mat4((blockD.g), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(h), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec4((i), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec2(ivec2(j), ivec2(0, 0));
	result *= compare_uvec2((k), uvec2(0u, 0u));
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
	mediump mat3x2 mA; // unused in fragment shader
};
struct sB
{
	mediump uint mA;
	u8vec3 mB[6]; // unused in fragment shader
};
struct sC
{
	sB mA;
};
layout(set = 0, binding = 0) uniform BlockB
{
	highp vec2 a;
	bool b;
	highp mat4 c; // unused in vertex shader
	highp mat4x3 d[7];
	lowp mat2 e;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat3x4 f;
	bool g;
	lowp mat2x3 h; // unused in vertex shader
	highp mat2 i; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	uint8_t j;
	highp mat2x3 k;
	sA l;
	i8vec2 m; // unused in vertex shader
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	sC n;
	mediump vec3 o;
	lowp mat3x4 p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_vec2((a), vec2(0.0, 0.0));
	result *= compare_bool((b), false);
	result *= compare_mat4((c), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((e), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockC.f), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockC.g), false);
	result *= compare_mat2x3((blockC.h), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(j), 0u);
	result *= compare_mat2x3((k), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(m), ivec2(0, 0));
	result *= compare_uint((n.mA.mA), 0u);
	result *= compare_vec3((o), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump mat3x2 mA; // unused in fragment shader
};
struct sB
{
	mediump uint mA;
	u8vec3 mB[6]; // unused in fragment shader
};
struct sC
{
	sB mA;
};
layout(set = 0, binding = 0) uniform BlockB
{
	highp vec2 a;
	bool b;
	highp mat4 c; // unused in vertex shader
	highp mat4x3 d[7];
	lowp mat2 e;
};
layout(set = 0, binding = 1, row_major) uniform BlockC
{
	lowp mat3x4 f;
	bool g;
	lowp mat2x3 h; // unused in vertex shader
	highp mat2 i; // unused in fragment shader
} blockC;
layout(set = 0, binding = 2) uniform BlockD
{
	uint8_t j;
	highp mat2x3 k;
	sA l;
	i8vec2 m; // unused in vertex shader
};
layout(set = 0, binding = 3, std140, column_major) uniform BlockE
{
	sC n;
	mediump vec3 o;
	lowp mat3x4 p;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_vec2((a), vec2(0.0, 0.0));
	result *= compare_bool((b), false);
	result *= compare_mat4x3((d[0]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[1]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[2]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[3]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[4]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[5]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((d[6]), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((e), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x4((blockC.f), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((blockC.g), false);
	result *= compare_mat2((blockC.i), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_uint8_t(uint(j), 0u);
	result *= compare_mat2x3((k), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((l.mA), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uint((n.mA.mA), 0u);
	result *= compare_u8vec3(uvec3(n.mA.mB[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(n.mA.mB[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(n.mA.mB[2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(n.mA.mB[3]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(n.mA.mB[4]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(n.mA.mB[5]), uvec3(0u, 0u, 0u));
	result *= compare_vec3((o), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3x4((p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	u8vec2 mA;
	highp uint mB; // unused in fragment shader
	lowp mat2 mC; // unused in vertex shader
};
struct sB
{
	u8vec2 mA;
	highp mat4x3 mB; // unused in vertex shader
	uint8_t mC;
};
struct sC
{
	bool mA; // unused in vertex shader
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	i8vec4 q;
	bvec4 r[2];
};
layout(set = 0, binding = 6) uniform BlockH
{
	highp ivec4 s;
	highp vec4 t;
	i8vec2 u; // unused in vertex shader
	i8vec4 v; // unused in vertex shader
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_i8vec4(ivec4(q), ivec4(0, 0, 0, 0));
	result *= compare_bvec4((r[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((r[1]), bvec4(false, false, false, false));
	result *= compare_ivec4((blockH.s), ivec4(0, 0, 0, 0));
	result *= compare_vec4((blockH.t), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockH.u), ivec2(0, 0));
	result *= compare_i8vec4(ivec4(blockH.v), ivec4(0, 0, 0, 0));
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
	mediump ivec2 mA;
	mediump mat4 mB;
	lowp mat3x2 mC;
	lowp vec4 mD;
};
struct sB
{
	sA mA;
	mediump mat3x2 mB;
	mediump mat4 mC;
};
struct sC
{
	bvec4 mA; // unused in vertex shader
	mediump float mB;
	lowp mat3x2 mC;
	i8vec2 mD;
};
struct sD
{
	i8vec2 mA[3];
	sC mB;
	mediump mat3x4 mC;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	sB a;
	sD b; // unused in fragment shader
	highp vec3 c;
	mediump uint d;
	mediump uvec2 e;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump mat3x2 f;
	highp mat4 g[5];
	bool h;
};
layout(set = 0, binding = 3) uniform BlockE
{
	u8vec4 k[7];
	i8vec4 l;
	bvec4 m;
	lowp mat3x4 n; // unused in fragment shader
	highp mat3x4 o;
} blockE;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    mediump float result = 1.0;
	result *= compare_ivec2((blockB.a.mA.mA), ivec2(0, 0));
	result *= compare_mat4((blockB.a.mA.mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a.mA.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockB.a.mA.mD), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a.mB), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB.a.mC), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.c), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((blockB.d), 0u);
	result *= compare_uvec2((blockB.e), uvec2(0u, 0u));
	result *= compare_mat3x2((f), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[4]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((h), false);
	result *= compare_u8vec4(uvec4(blockE.k[0]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockE.k[1]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockE.k[2]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockE.k[3]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockE.k[4]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockE.k[5]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_u8vec4(uvec4(blockE.k[6]), uvec4(0u, 0u, 0u, 0u));
	result *= compare_i8vec4(ivec4(blockE.l), ivec4(0, 0, 0, 0));
	result *= compare_bvec4((blockE.m), bvec4(false, false, false, false));
	result *= compare_mat3x4((blockE.o), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	mediump mat4 mB;
	lowp mat3x2 mC;
	lowp vec4 mD;
};
struct sB
{
	sA mA;
	mediump mat3x2 mB;
	mediump mat4 mC;
};
struct sC
{
	bvec4 mA; // unused in vertex shader
	mediump float mB;
	lowp mat3x2 mC;
	i8vec2 mD;
};
struct sD
{
	i8vec2 mA[3];
	sC mB;
	mediump mat3x4 mC;
};
layout(set = 0, binding = 0, std140) uniform BlockB
{
	sB a;
	sD b; // unused in fragment shader
	highp vec3 c;
	mediump uint d;
	mediump uvec2 e;
} blockB;
layout(set = 0, binding = 1, std140, column_major) uniform BlockC
{
	mediump mat3x2 f;
	highp mat4 g[5];
	bool h;
};
layout(set = 0, binding = 2, std140, row_major) uniform BlockD
{
	highp vec4 i;
	highp mat4 j;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    gl_Position = a_position;
    mediump float result = 1.0;
	result *= compare_ivec2((blockB.a.mA.mA), ivec2(0, 0));
	result *= compare_mat4((blockB.a.mA.mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a.mA.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((blockB.a.mA.mD), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3x2((blockB.a.mB), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((blockB.a.mC), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockB.b.mA[0]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(blockB.b.mA[1]), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(blockB.b.mA[2]), ivec2(0, 0));
	result *= compare_float((blockB.b.mB.mB), 0.0);
	result *= compare_mat3x2((blockB.b.mB.mC), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(blockB.b.mB.mD), ivec2(0, 0));
	result *= compare_mat3x4((blockB.b.mC), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockB.c), vec3(0.0, 0.0, 0.0));
	result *= compare_uint((blockB.d), 0u);
	result *= compare_uvec2((blockB.e), uvec2(0u, 0u));
	result *= compare_mat3x2((f), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[0]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[1]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[2]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[3]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((g[4]), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((h), false);
	result *= compare_vec4((i), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((j), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
    v_vtxResult = result;
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
	highp vec3 i;
	mediump mat2 j;
	highp vec4 k;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	i8vec4 l;
	bvec3 m;
	bool n;
	i8vec3 o;
};
layout(set = 0, binding = 6) uniform BlockH
{
	highp uint p;
	highp int q;
	lowp ivec4 r;
};
layout(set = 0, binding = 7) uniform BlockI
{
	lowp uvec4 s; // unused in fragment shader
	highp uvec3 t; // unused in both shaders
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((i), vec3(0.0, 0.0, 0.0));
	result *= compare_mat2((j), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((k), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec4(ivec4(l), ivec4(0, 0, 0, 0));
	result *= compare_bvec3((m), bvec3(false, false, false));
	result *= compare_bool((n), false);
	result *= compare_i8vec3(ivec3(o), ivec3(0, 0, 0));
	result *= compare_uint((p), 0u);
	result *= compare_int((q), 0);
	result *= compare_ivec4((r), ivec4(0, 0, 0, 0));
	result *= compare_uvec4((blockI.s), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec3((blockI.t), uvec3(0u, 0u, 0u));
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
	u8vec3 mA; // unused in fragment shader
};
layout(set = 0, binding = 6) uniform BlockH
{
	u8vec3 t; // unused in both shaders
	mediump vec2 u;
	highp uvec3 v; // unused in vertex shader
} blockH[1];
layout(set = 0, binding = 7) uniform BlockI
{
	mediump vec2 w;
	bvec4 x;
	mediump mat4x3 y;
	i8vec3 z;
} blockI;
layout(set = 0, binding = 8, std140, row_major) uniform BlockJ
{
	bool aa;
	u8vec3 ab; // unused in vertex shader
} blockJ[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_u8vec3(uvec3(blockH[0].t), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockH[0].u), vec2(0.0, 0.0));
	result *= compare_uvec3((blockH[0].v), uvec3(0u, 0u, 0u));
	result *= compare_vec2((blockI.w), vec2(0.0, 0.0));
	result *= compare_bvec4((blockI.x), bvec4(false, false, false, false));
	result *= compare_mat4x3((blockI.y), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockI.z), ivec3(0, 0, 0));
	result *= compare_bool((blockJ[0].aa), false);
	result *= compare_u8vec3(uvec3(blockJ[0].ab), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockJ[1].aa), false);
	result *= compare_u8vec3(uvec3(blockJ[1].ab), uvec3(0u, 0u, 0u));
	result *= compare_bool((blockJ[2].aa), false);
	result *= compare_u8vec3(uvec3(blockJ[2].ab), uvec3(0u, 0u, 0u));
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
	highp mat2x3 mB; // unused in vertex shader
	mediump mat4x2 mC;
};
struct sB
{
	bvec4 mA;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	lowp mat2x3 p;
	u8vec4 q;
} blockG;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat2x3((blockG.p), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(blockG.q), uvec4(0u, 0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
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
	highp uvec3 i;
	bvec3 j[5];
	u8vec4 k;
};
layout(set = 0, binding = 5, column_major) uniform BlockG
{
	highp mat3x2 l;
	int8_t m;
	highp vec2 n;
	bvec4 o; // unused in fragment shader
	mediump ivec2 p;
};
layout(set = 0, binding = 6) uniform BlockH
{
	lowp vec3 q;
	mediump uvec3 r;
	uint8_t s; // unused in fragment shader
	lowp uint t;
	u8vec3 u;
} blockH[2];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec3((i), uvec3(0u, 0u, 0u));
	result *= compare_bvec3((j[0]), bvec3(false, false, false));
	result *= compare_bvec3((j[1]), bvec3(false, false, false));
	result *= compare_bvec3((j[2]), bvec3(false, false, false));
	result *= compare_bvec3((j[3]), bvec3(false, false, false));
	result *= compare_bvec3((j[4]), bvec3(false, false, false));
	result *= compare_u8vec4(uvec4(k), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3x2((l), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_int8_t(int(m), 0);
	result *= compare_vec2((n), vec2(0.0, 0.0));
	result *= compare_bvec4((o), bvec4(false, false, false, false));
	result *= compare_ivec2((p), ivec2(0, 0));
	result *= compare_vec3((blockH[0].q), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockH[0].r), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(blockH[0].s), 0u);
	result *= compare_uint((blockH[0].t), 0u);
	result *= compare_u8vec3(uvec3(blockH[0].u), uvec3(0u, 0u, 0u));
	result *= compare_vec3((blockH[1].q), vec3(0.0, 0.0, 0.0));
	result *= compare_uvec3((blockH[1].r), uvec3(0u, 0u, 0u));
	result *= compare_uint8_t(uint(blockH[1].s), 0u);
	result *= compare_uint((blockH[1].t), 0u);
	result *= compare_u8vec3(uvec3(blockH[1].u), uvec3(0u, 0u, 0u));
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
	lowp mat4x3 mA; // unused in fragment shader
	lowp uvec4 mB;
	highp mat3 mC;
};
struct sB
{
	bool mA;
	highp mat3x4 mB; // unused in vertex shader
	lowp mat2 mC; // unused in fragment shader
	bool mD;
};
layout(set = 0, binding = 5, std140, column_major) uniform BlockG
{
	bvec3 m;
	sA n;
	bool o;
	lowp mat3x2 p;
	sB q;
};
layout(set = 0, binding = 6, column_major) uniform BlockH
{
	lowp mat3x2 r;
};
layout(set = 0, binding = 7) uniform BlockI
{
	bvec2 s; // unused in vertex shader
	u8vec4 t;
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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec3((m), bvec3(false, false, false));
	result *= compare_mat4x3((n.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((n.mB), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat3((n.mC), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((o), false);
	result *= compare_mat3x2((p), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((q.mA), false);
	result *= compare_mat3x4((q.mB), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((q.mC), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_bool((q.mD), false);
	result *= compare_mat3x2((r), mat3x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((s), bvec2(false, false));
	result *= compare_u8vec4(uvec4(t), uvec4(0u, 0u, 0u, 0u));
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
	bool mA; // unused in vertex shader
};
struct sB
{
	highp uint mA[4]; // unused in fragment shader
};
struct sC
{
	bool mA; // unused in vertex shader
	mediump mat3 mB;
	u8vec3 mC;
};
struct sD
{
	mediump mat4x2 mA;
	lowp mat4 mB; // unused in vertex shader
};
struct sE
{
	highp mat4x3 mA;
	mediump mat3 mB;
	u8vec2 mC; // unused in fragment shader
	lowp mat2 mD; // unused in vertex shader
};
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	sD r; // unused in fragment shader
	sE s;
};

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
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat4x2((r.mA), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4((r.mB), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((s.mA), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((s.mB), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec2(uvec2(s.mC), uvec2(0u, 0u));
	result *= compare_mat2((s.mD), mat2(0.0, 0.0, 0.0, 0.0));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 6, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 4, std140) uniform BlockF
{
	mediump mat3x4 j;
	lowp ivec4 k;
	i8vec4 l;
	mediump mat3x4 m; // unused in fragment shader
} blockF;
layout(set = 0, binding = 5, std140, row_major) uniform BlockG
{
	u8vec3 n[8]; // unused in vertex shader
	mediump float o;
	i8vec4 p;
	highp mat3 q; // unused in vertex shader
	lowp vec2 r;
} blockG[3];

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
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((blockF.j), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec4((blockF.k), ivec4(0, 0, 0, 0));
	result *= compare_i8vec4(ivec4(blockF.l), ivec4(0, 0, 0, 0));
	result *= compare_mat3x4((blockF.m), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockG[0].n[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[0].n[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[0].n[2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[0].n[3]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[0].n[4]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[0].n[5]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[0].n[6]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[0].n[7]), uvec3(0u, 0u, 0u));
	result *= compare_float((blockG[0].o), 0.0);
	result *= compare_i8vec4(ivec4(blockG[0].p), ivec4(0, 0, 0, 0));
	result *= compare_mat3((blockG[0].q), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockG[0].r), vec2(0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockG[1].n[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].n[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].n[2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].n[3]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].n[4]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].n[5]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].n[6]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[1].n[7]), uvec3(0u, 0u, 0u));
	result *= compare_float((blockG[1].o), 0.0);
	result *= compare_i8vec4(ivec4(blockG[1].p), ivec4(0, 0, 0, 0));
	result *= compare_mat3((blockG[1].q), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockG[1].r), vec2(0.0, 0.0));
	result *= compare_u8vec3(uvec3(blockG[2].n[0]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[2].n[1]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[2].n[2]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[2].n[3]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[2].n[4]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[2].n[5]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[2].n[6]), uvec3(0u, 0u, 0u));
	result *= compare_u8vec3(uvec3(blockG[2].n[7]), uvec3(0u, 0u, 0u));
	result *= compare_float((blockG[2].o), 0.0);
	result *= compare_i8vec4(ivec4(blockG[2].p), ivec4(0, 0, 0, 0));
	result *= compare_mat3((blockG[2].q), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec2((blockG[2].r), vec2(0.0, 0.0));
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
	int8_t mA;
	highp uint mB;
};
struct sB
{
	highp mat3x4 mA; // unused in vertex shader
};
layout(set = 0, binding = 6, std140) uniform BlockH
{
	sB r;
	lowp uvec4 s;
} blockH;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((blockH.r.mA), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec4((blockH.s), uvec4(0u, 0u, 0u, 0u));
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
	bvec3 mA;
	i8vec3 mB; // unused in fragment shader
	highp mat3 mC;
	mediump int mD;
};
struct sB
{
	highp vec3 mA;
	highp ivec3 mB;
	highp vec3 mC; // unused in vertex shader
	i8vec4 mD[2];
};
struct sC
{
	lowp uint mA;
	sB mB;
};
struct sD
{
	i8vec2 mA;
};
struct sE
{
	highp vec4 mA; // unused in vertex shader
	uint8_t mB;
	uint8_t mC;
	mediump int mD;
};
struct sF
{
	lowp ivec4 mA; // unused in both shaders
	lowp mat4x2 mB; // unused in fragment shader
};
layout(set = 0, binding = 4, row_major) uniform BlockF
{
	layout(offset = 16) sF t;
	layout(offset = 0) lowp vec2 r;
	layout(offset = 8) i8vec2 s;
};
layout(set = 0, binding = 5, row_major) uniform BlockG
{
	layout(offset = 16) highp mat4 v;
	layout(offset = 0) bvec3 u; // unused in vertex shader
} blockG[3];
layout(set = 0, binding = 6, std140, column_major) uniform BlockH
{
	layout(offset = 0) highp uvec3 w;
} blockH;

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
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec2((r), vec2(0.0, 0.0));
	result *= compare_i8vec2(ivec2(s), ivec2(0, 0));
	result *= compare_ivec4((t.mA), ivec4(0, 0, 0, 0));
	result *= compare_mat4x2((t.mB), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockG[0].u), bvec3(false, false, false));
	result *= compare_mat4((blockG[0].v), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockG[1].u), bvec3(false, false, false));
	result *= compare_mat4((blockG[1].v), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockG[2].u), bvec3(false, false, false));
	result *= compare_mat4((blockG[2].v), mat4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec3((blockH.w), uvec3(0u, 0u, 0u));
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
	lowp uvec2 mA;
	highp ivec2 mB;
	lowp mat3 mC;
};
struct sB
{
	lowp vec3 mA;
	u8vec2 mB;
	mediump vec4 mC;
	lowp mat4x3 mD;
};
struct sC
{
	mediump mat2 mA;
};
struct sD
{
	mediump vec3 mA;
	mediump int mB;
	lowp ivec4 mC;
};
layout(set = 0, binding = 6, scalar) uniform BlockH
{
	layout(offset = 0) mediump vec3 s; // unused in both shaders
} blockH;
layout(set = 0, binding = 7, scalar) uniform BlockI
{
	layout(offset = 96) lowp mat4x2 u;
	layout(offset = 0) mediump vec3 t[8];
} blockI;
layout(set = 0, binding = 8, std430) uniform BlockJ
{
	layout(offset = 50) i8vec2 y;
	layout(offset = 0) lowp mat2 v;
	layout(offset = 48) i8vec2 x;
	layout(offset = 16) sD w;
} blockJ;
layout(set = 0, binding = 9, row_major) uniform BlockK
{
	layout(offset = 16) mediump uint ab;
	layout(offset = 0) u8vec4 z;
	layout(offset = 8) lowp vec2 aa;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((blockH.s), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[0]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[1]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[2]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[3]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[4]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[5]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[6]), vec3(0.0, 0.0, 0.0));
	result *= compare_vec3((blockI.t[7]), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x2((blockI.u), mat4x2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat2((blockJ.v), mat2(0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockJ.w.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_int((blockJ.w.mB), 0);
	result *= compare_ivec4((blockJ.w.mC), ivec4(0, 0, 0, 0));
	result *= compare_i8vec2(ivec2(blockJ.x), ivec2(0, 0));
	result *= compare_i8vec2(ivec2(blockJ.y), ivec2(0, 0));
	result *= compare_u8vec4(uvec4(z), uvec4(0u, 0u, 0u, 0u));
	result *= compare_vec2((aa), vec2(0.0, 0.0));
	result *= compare_uint((ab), 0u);
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
	i8vec2 mA;
};
struct sB
{
	sA mA;
	bvec2 mB; // unused in vertex shader
	bvec2 mC;
	mediump ivec3 mD;
};
struct sC
{
	mediump vec4 mA;
	int8_t mB;
	i8vec2 mC;
	lowp mat3x4 mD;
};
struct sD
{
	mediump mat3 mA;
	bvec3 mB;
};
layout(set = 0, binding = 5, scalar, column_major) uniform BlockG
{
	layout(offset = 284) i8vec3 u;
	layout(offset = 0) lowp vec3 q;
	layout(offset = 272) lowp vec3 t; // unused in vertex shader
	layout(offset = 12) highp mat3 r[7];
	layout(offset = 264) mediump uvec2 s;
} blockG;
layout(set = 0, binding = 6, scalar) uniform BlockH
{
	layout(offset = 48) highp mat3 w; // unused in fragment shader
	layout(offset = 0) mediump mat4x3 v;
} blockH;
layout(set = 0, binding = 7, scalar, row_major) uniform BlockI
{
	layout(offset = 56) lowp uvec3 aa;
	layout(offset = 0) i8vec3 x;
	layout(offset = 52) bool z; // unused in fragment shader
	layout(offset = 4) sD y;
} blockI;
layout(set = 0, binding = 8, std430) uniform BlockJ
{
	layout(offset = 0) lowp mat4x3 ab; // unused in fragment shader
} blockJ[3];

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_uint8_t  (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_vec3((blockG.q), vec3(0.0, 0.0, 0.0));
	result *= compare_mat3((blockG.r[0]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG.r[1]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG.r[2]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG.r[3]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG.r[4]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG.r[5]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockG.r[6]), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_uvec2((blockG.s), uvec2(0u, 0u));
	result *= compare_vec3((blockG.t), vec3(0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockG.u), ivec3(0, 0, 0));
	result *= compare_mat4x3((blockH.v), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat3((blockH.w), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockI.x), ivec3(0, 0, 0));
	result *= compare_mat3((blockI.y.mA), mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec3((blockI.y.mB), bvec3(false, false, false));
	result *= compare_bool((blockI.z), false);
	result *= compare_uvec3((blockI.aa), uvec3(0u, 0u, 0u));
	result *= compare_mat4x3((blockJ[0].ab), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockJ[1].ab), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockJ[2].ab), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
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
	highp mat4 mA;
	u8vec3 mB; // unused in vertex shader
	mediump uvec3 mC;
	highp mat2 mD;
};
layout(set = 0, binding = 4, scalar) uniform BlockF
{
	layout(offset = 12) mediump int r;
	layout(offset = 0) mediump uvec3 q;
};
layout(set = 0, binding = 5, std430, row_major) uniform BlockG
{
	layout(offset = 80) lowp mat4x3 v;
	layout(offset = 0) i8vec3 s[5];
	layout(offset = 32) bvec4 u[3];
	layout(offset = 20) u8vec3 t;
} blockG[2];
layout(set = 0, binding = 6, scalar) uniform BlockH
{
	layout(offset = 12) mediump mat4x3 x;
	layout(offset = 0) lowp vec3 w; // unused in vertex shader
} blockH;
layout(set = 0, binding = 7, std430) uniform BlockI
{
	layout(offset = 8) lowp uvec2 z;
	layout(offset = 0) u8vec4 y;
} blockI;

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_uvec3((q), uvec3(0u, 0u, 0u));
	result *= compare_int((r), 0);
	result *= compare_i8vec3(ivec3(blockG[0].s[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[0].s[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[0].s[2]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[0].s[3]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[0].s[4]), ivec3(0, 0, 0));
	result *= compare_u8vec3(uvec3(blockG[0].t), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockG[0].u[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockG[0].u[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockG[0].u[2]), bvec4(false, false, false, false));
	result *= compare_mat4x3((blockG[0].v), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec3(ivec3(blockG[1].s[0]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[1].s[1]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[1].s[2]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[1].s[3]), ivec3(0, 0, 0));
	result *= compare_i8vec3(ivec3(blockG[1].s[4]), ivec3(0, 0, 0));
	result *= compare_u8vec3(uvec3(blockG[1].t), uvec3(0u, 0u, 0u));
	result *= compare_bvec4((blockG[1].u[0]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockG[1].u[1]), bvec4(false, false, false, false));
	result *= compare_bvec4((blockG[1].u[2]), bvec4(false, false, false, false));
	result *= compare_mat4x3((blockG[1].v), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec3((blockH.w), vec3(0.0, 0.0, 0.0));
	result *= compare_mat4x3((blockH.x), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_u8vec4(uvec4(blockI.y), uvec4(0u, 0u, 0u, 0u));
	result *= compare_uvec2((blockI.z), uvec2(0u, 0u));
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
	u8vec4 mA;
	bvec2 mB;
	mediump mat2 mC; // unused in vertex shader
};
layout(set = 0, binding = 5, scalar, row_major) uniform BlockG
{
	layout(offset = 64) mediump ivec2 r;
	layout(offset = 0) lowp mat3x4 p;
	layout(offset = 48) lowp vec4 q; // unused in vertex shader
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_mat3x4((p), mat3x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_vec4((q), vec4(0.0, 0.0, 0.0, 0.0));
	result *= compare_ivec2((r), ivec2(0, 0));
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
	lowp ivec3 mA;
	mediump mat4x2 mB[1];
	highp int mC; // unused in vertex shader
};
struct sB
{
	uint8_t mA; // unused in fragment shader
	lowp vec3 mB;
};
struct sC
{
	sB mA;
};
struct sD
{
	int8_t mA[1];
	i8vec3 mB;
	uint8_t mC;
};
struct sE
{
	highp vec3 mA;
};
layout(set = 0, binding = 6, row_major) uniform BlockH
{
	layout(offset = 80) mediump float u;
	layout(offset = 0) highp uint q;
	layout(offset = 64) sE t;
	layout(offset = 16) sD r; // unused in vertex shader
	layout(offset = 48) i8vec2 s;
} blockH[2];
layout(set = 0, binding = 7, scalar, column_major) uniform BlockI
{
	layout(offset = 8) i8vec4 w; // unused in fragment shader
	layout(offset = 0) highp vec2 v; // unused in vertex shader
};
layout(set = 0, binding = 8, std430, row_major) uniform BlockJ
{
	layout(offset = 6) int8_t z;
	layout(offset = 0) u8vec3 x;
	layout(offset = 4) u8vec2 y;
};
layout(set = 0, binding = 9, column_major) uniform BlockK
{
	layout(offset = 32) highp uvec3 ae; // unused in vertex shader
	layout(offset = 0) bvec3 aa;
	layout(offset = 24) uint8_t ad; // unused in fragment shader
	layout(offset = 12) mediump int ab;
	layout(offset = 16) bvec2 ac;
} blockK[1];

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
mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }
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
	result *= compare_uint((blockH[0].q), 0u);
	result *= compare_int8_t(int(blockH[0].r.mA[0]), 0);
	result *= compare_i8vec3(ivec3(blockH[0].r.mB), ivec3(0, 0, 0));
	result *= compare_uint8_t(uint(blockH[0].r.mC), 0u);
	result *= compare_i8vec2(ivec2(blockH[0].s), ivec2(0, 0));
	result *= compare_vec3((blockH[0].t.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockH[0].u), 0.0);
	result *= compare_uint((blockH[1].q), 0u);
	result *= compare_int8_t(int(blockH[1].r.mA[0]), 0);
	result *= compare_i8vec3(ivec3(blockH[1].r.mB), ivec3(0, 0, 0));
	result *= compare_uint8_t(uint(blockH[1].r.mC), 0u);
	result *= compare_i8vec2(ivec2(blockH[1].s), ivec2(0, 0));
	result *= compare_vec3((blockH[1].t.mA), vec3(0.0, 0.0, 0.0));
	result *= compare_float((blockH[1].u), 0.0);
	result *= compare_vec2((v), vec2(0.0, 0.0));
	result *= compare_i8vec4(ivec4(w), ivec4(0, 0, 0, 0));
	result *= compare_u8vec3(uvec3(x), uvec3(0u, 0u, 0u));
	result *= compare_u8vec2(uvec2(y), uvec2(0u, 0u));
	result *= compare_int8_t(int(z), 0);
	result *= compare_bvec3((blockK[0].aa), bvec3(false, false, false));
	result *= compare_int((blockK[0].ab), 0);
	result *= compare_bvec2((blockK[0].ac), bvec2(false, false));
	result *= compare_uint8_t(uint(blockK[0].ad), 0u);
	result *= compare_uvec3((blockK[0].ae), uvec3(0u, 0u, 0u));
    imageStore(outImage, coord, vec4(result));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 8, rgba8) writeonly uniform image2D outImage;

layout(set = 0, binding = 5, std430, column_major) uniform BlockG
{
	bvec2 o; // unused in both shaders
	u8vec4 p; // unused in fragment shader
	highp mat4x3 q; // unused in vertex shader
};
layout(set = 0, binding = 6, std430, row_major) uniform BlockH
{
	i8vec2 r;
	highp int s;
	mediump ivec3 t;
};
layout(set = 0, binding = 7, scalar, column_major) uniform BlockI
{
	lowp mat2x3 u;
	bvec2 v;
	lowp float w;
};

mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }
mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }
mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }
mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }
mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }
mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }
mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }
mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }
mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_int8_t   (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }
mediump float compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }

void main (void)
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    mediump float result = 1.0;
	result *= compare_bvec2((o), bvec2(false, false));
	result *= compare_u8vec4(uvec4(p), uvec4(0u, 0u, 0u, 0u));
	result *= compare_mat4x3((q), mat4x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_i8vec2(ivec2(r), ivec2(0, 0));
	result *= compare_int((s), 0);
	result *= compare_ivec3((t), ivec3(0, 0, 0));
	result *= compare_mat2x3((u), mat2x3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
	result *= compare_bvec2((v), bvec2(false, false));
	result *= compare_float((w), 0.0);
    imageStore(outImage, coord, vec4(result));
}
