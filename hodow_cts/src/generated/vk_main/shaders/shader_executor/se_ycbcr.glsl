#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 texCoord = a_texCoord;
	highp vec4 result;
	result = texture(u_image, texCoord);
	vtx_out_result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp vec4 vtx_out_result;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec2 vtx_out_texCoord;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_texCoord = a_texCoord;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result;

	result = texture(u_image, texCoord);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result;

	result = texture(u_image, texCoord);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp vec4 geom_out_result;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp vec2 vtx_out_texCoord;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	highp vec2 texCoord = vtx_out_texCoord;
	highp vec4 result;
	result = texture(u_image, texCoord);
	o_result = result;
}
#version 450
void main (void)
{
    gl_Position = vec4(gl_VertexIndex/2, gl_VertexIndex%2, 0.0, 1.0);
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(vertices = 1) out;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result;

	result = texture(u_image, texCoord);

	outputs[invocationId].result = result;
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(triangles, ccw) in;

void main (void)
{
	gl_Position = vec4(gl_TessCoord.xy, 0.0, 1.0);
}
#version 450
layout(location=0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.0);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result;

	result = texture(u_image, texCoord);

	outputs[invocationId].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 texCoord = vec2(inputs[invocationNdx].texCoord);
	vec4 result;

	result = texture(u_image, texCoord);

	outputs[invocationNdx].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 texCoord = a_texCoord;
	highp vec4 result;
	result = texture(u_image, vec3(texCoord, 1u));
	vtx_out_result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(location = 0) flat in highp vec4 vtx_out_result;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec2 vtx_out_texCoord;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_texCoord = a_texCoord;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result;

	result = texture(u_image, vec3(texCoord, 1u));
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result;

	result = texture(u_image, vec3(texCoord, 1u));
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(location = 0) flat in highp vec4 geom_out_result;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(location = 0) flat in highp vec2 vtx_out_texCoord;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	highp vec2 texCoord = vtx_out_texCoord;
	highp vec4 result;
	result = texture(u_image, vec3(texCoord, 1u));
	o_result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;


layout(vertices = 1) out;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result;

	result = texture(u_image, vec3(texCoord, 1u));

	outputs[invocationId].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result;

	result = texture(u_image, vec3(texCoord, 1u));

	outputs[invocationId].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 texCoord = vec2(inputs[invocationNdx].texCoord);
	vec4 result;

	result = texture(u_image, vec3(texCoord, 1u));

	outputs[invocationNdx].result = result;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 texCoord = a_texCoord;
	highp vec4 result0;
	highp vec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec2 vtx_out_texCoord;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_texCoord = a_texCoord;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result0;
layout(location = 1) flat out highp vec4 geom_out_result1;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result0;
	highp vec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result0;
layout(location = 1) flat out highp vec4 geom_out_result1;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result0;
	highp vec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(location = 0) flat in highp vec4 geom_out_result0;
layout(location = 1) flat in highp vec4 geom_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(location = 0) flat in highp vec2 vtx_out_texCoord;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;

void main (void)
{
	highp vec2 texCoord = vtx_out_texCoord;
	highp vec4 result0;
	highp vec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));
	o_result0 = result0;
	o_result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;


layout(vertices = 1) out;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	vec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	vec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 texCoord = vec2(inputs[invocationNdx].texCoord);
	vec4 result0;
	vec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 texCoord = a_texCoord;
	highp vec4 result0;
	highp ivec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec2 vtx_out_texCoord;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_texCoord = a_texCoord;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result0;
layout(location = 1) flat out highp ivec4 geom_out_result1;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result0;
	highp ivec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result0;
layout(location = 1) flat out highp ivec4 geom_out_result1;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result0;
	highp ivec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) flat in highp vec4 geom_out_result0;
layout(location = 1) flat in highp ivec4 geom_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) flat in highp vec2 vtx_out_texCoord;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;

void main (void)
{
	highp vec2 texCoord = vtx_out_texCoord;
	highp vec4 result0;
	highp ivec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));
	o_result0 = result0;
	o_result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;


layout(vertices = 1) out;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp ivec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	ivec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp ivec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	ivec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp ivec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 texCoord = vec2(inputs[invocationNdx].texCoord);
	vec4 result0;
	ivec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 texCoord = a_texCoord;
	highp vec4 result0;
	highp uvec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec2 vtx_out_texCoord;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_texCoord = a_texCoord;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result0;
layout(location = 1) flat out highp uvec4 geom_out_result1;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result0;
	highp uvec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_texCoord[];
layout(location = 0) flat out highp vec4 geom_out_result0;
layout(location = 1) flat out highp uvec4 geom_out_result1;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 texCoord = vtx_out_texCoord[0];
	highp vec4 result0;
	highp uvec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(location = 0) flat in highp vec4 geom_out_result0;
layout(location = 1) flat in highp uvec4 geom_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(location = 0) flat in highp vec2 vtx_out_texCoord;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;

void main (void)
{
	highp vec2 texCoord = vtx_out_texCoord;
	highp vec4 result0;
	highp uvec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));
	o_result0 = result0;
	o_result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;


layout(vertices = 1) out;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp uvec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	uvec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp uvec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	uvec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp uvec4 result1;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 texCoord = vec2(inputs[invocationNdx].texCoord);
	vec4 result0;
	uvec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_lod;
layout(location = 0) flat out highp ivec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int lod = a_lod;
	highp ivec2 result;
	result = textureSize(u_image, lod);
	vtx_out_result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp ivec2 vtx_out_result;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_lod;
layout(location = 0) flat out highp int vtx_out_lod;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_lod = a_lod;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_lod[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int lod = vtx_out_lod[0];
	highp ivec2 result;

	result = textureSize(u_image, lod);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_lod[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int lod = vtx_out_lod[0];
	highp ivec2 result;

	result = textureSize(u_image, lod);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp ivec2 geom_out_result;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp int vtx_out_lod;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	highp int lod = vtx_out_lod;
	highp ivec2 result;
	result = textureSize(u_image, lod);
	o_result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(vertices = 1) out;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp ivec2 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	int lod = int(inputs[invocationId].lod);
	ivec2 result;

	result = textureSize(u_image, lod);

	outputs[invocationId].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp ivec2 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	int lod = int(inputs[invocationId].lod);
	ivec2 result;

	result = textureSize(u_image, lod);

	outputs[invocationId].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(local_size_x = 1) in;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp ivec2 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int lod = int(inputs[invocationNdx].lod);
	ivec2 result;

	result = textureSize(u_image, lod);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp ivec2 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int lod = int(inputs[invocationNdx].lod);
	ivec2 result;

	result = textureSize(u_image, lod);

	outputs[invocationNdx].result = result;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout(local_size_x=1, local_size_y=1, local_size_z=1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

void main (void)
{
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(local_size_x = 1) in;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp ivec2 result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int lod = int(inputs[invocationNdx].lod);
	ivec2 result;

	result = textureSize(u_image, lod);

	outputs[invocationNdx].result = result;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_lod;
layout(location = 0) flat out highp int vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int lod = a_lod;
	highp int result;
	result = textureQueryLevels(u_image);
	vtx_out_result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp int vtx_out_result;
layout(location = 0) out highp int o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_lod[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int lod = vtx_out_lod[0];
	highp int result;

	result = textureQueryLevels(u_image);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_lod[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int lod = vtx_out_lod[0];
	highp int result;

	result = textureQueryLevels(u_image);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp int geom_out_result;
layout(location = 0) out highp int o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp int vtx_out_lod;
layout(location = 0) out highp int o_result;

void main (void)
{
	highp int lod = vtx_out_lod;
	highp int result;
	result = textureQueryLevels(u_image);
	o_result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(vertices = 1) out;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp int result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	int lod = int(inputs[invocationId].lod);
	int result;

	result = textureQueryLevels(u_image);

	outputs[invocationId].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp int result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	int lod = int(inputs[invocationId].lod);
	int result;

	result = textureQueryLevels(u_image);

	outputs[invocationId].result = result;
}
#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(local_size_x = 1) in;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp int result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int lod = int(inputs[invocationNdx].lod);
	int result;

	result = textureQueryLevels(u_image);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp int result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int lod = int(inputs[invocationNdx].lod);
	int result;

	result = textureQueryLevels(u_image);

	outputs[invocationNdx].result = result;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(local_size_x = 1) in;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp int result;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	int lod = int(inputs[invocationNdx].lod);
	int result;

	result = textureQueryLevels(u_image);

	outputs[invocationNdx].result = result;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	vtx_out_o_color = o_color;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec4 vtx_out_o_color;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	o_o_color = vtx_out_o_color;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	o_o_color = o_color;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler;
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color;

	o_color = texture(u_sampler, uv);

	outputs[invocationNdx].o_color = o_color;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color0;
layout(location = 1) flat out highp vec4 vtx_out_o_color1;
layout(location = 2) flat out highp vec4 vtx_out_o_color2;
layout(location = 3) flat out highp vec4 vtx_out_o_color3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	vtx_out_o_color0 = o_color0;
	vtx_out_o_color1 = o_color1;
	vtx_out_o_color2 = o_color2;
	vtx_out_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec4 vtx_out_o_color0;
layout(location = 1) flat in highp vec4 vtx_out_o_color1;
layout(location = 2) flat in highp vec4 vtx_out_o_color2;
layout(location = 3) flat in highp vec4 vtx_out_o_color3;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	o_o_color0 = vtx_out_o_color0;
	o_o_color1 = vtx_out_o_color1;
	o_o_color2 = vtx_out_o_color2;
	o_o_color3 = vtx_out_o_color3;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	o_o_color0 = o_color0;
	o_o_color1 = o_color1;
	o_o_color2 = o_color2;
	o_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=0) uniform highp sampler2D u_sampler[4];
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color0;
	vec4 o_color1;
	vec4 o_color2;
	vec4 o_color3;

	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);

	outputs[invocationNdx].o_color0 = o_color0;
	outputs[invocationNdx].o_color1 = o_color1;
	outputs[invocationNdx].o_color2 = o_color2;
	outputs[invocationNdx].o_color3 = o_color3;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	vtx_out_o_color = o_color;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec4 vtx_out_o_color;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	o_o_color = vtx_out_o_color;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	o_o_color = o_color;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler;
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color;

	o_color = texture(u_sampler, uv);

	outputs[invocationNdx].o_color = o_color;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color0;
layout(location = 1) flat out highp vec4 vtx_out_o_color1;
layout(location = 2) flat out highp vec4 vtx_out_o_color2;
layout(location = 3) flat out highp vec4 vtx_out_o_color3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	vtx_out_o_color0 = o_color0;
	vtx_out_o_color1 = o_color1;
	vtx_out_o_color2 = o_color2;
	vtx_out_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec4 vtx_out_o_color0;
layout(location = 1) flat in highp vec4 vtx_out_o_color1;
layout(location = 2) flat in highp vec4 vtx_out_o_color2;
layout(location = 3) flat in highp vec4 vtx_out_o_color3;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	o_o_color0 = vtx_out_o_color0;
	o_o_color1 = vtx_out_o_color1;
	o_o_color2 = vtx_out_o_color2;
	o_o_color3 = vtx_out_o_color3;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	o_o_color0 = o_color0;
	o_o_color1 = o_color1;
	o_o_color2 = o_color2;
	o_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler[4];
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color0;
	vec4 o_color1;
	vec4 o_color2;
	vec4 o_color3;

	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);

	outputs[invocationNdx].o_color0 = o_color0;
	outputs[invocationNdx].o_color1 = o_color1;
	outputs[invocationNdx].o_color2 = o_color2;
	outputs[invocationNdx].o_color3 = o_color3;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	vtx_out_o_color = o_color;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec4 vtx_out_o_color;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	o_o_color = vtx_out_o_color;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	o_o_color = o_color;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler;
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color;

	o_color = texture(u_sampler, uv);

	outputs[invocationNdx].o_color = o_color;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color0;
layout(location = 1) flat out highp vec4 vtx_out_o_color1;
layout(location = 2) flat out highp vec4 vtx_out_o_color2;
layout(location = 3) flat out highp vec4 vtx_out_o_color3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	vtx_out_o_color0 = o_color0;
	vtx_out_o_color1 = o_color1;
	vtx_out_o_color2 = o_color2;
	vtx_out_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec4 vtx_out_o_color0;
layout(location = 1) flat in highp vec4 vtx_out_o_color1;
layout(location = 2) flat in highp vec4 vtx_out_o_color2;
layout(location = 3) flat in highp vec4 vtx_out_o_color3;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	o_o_color0 = vtx_out_o_color0;
	o_o_color1 = vtx_out_o_color1;
	o_o_color2 = vtx_out_o_color2;
	o_o_color3 = vtx_out_o_color3;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	o_o_color0 = o_color0;
	o_o_color1 = o_color1;
	o_o_color2 = o_color2;
	o_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=15) uniform highp sampler2D u_sampler[4];
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color0;
	vec4 o_color1;
	vec4 o_color2;
	vec4 o_color3;

	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);

	outputs[invocationNdx].o_color0 = o_color0;
	outputs[invocationNdx].o_color1 = o_color1;
	outputs[invocationNdx].o_color2 = o_color2;
	outputs[invocationNdx].o_color3 = o_color3;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	vtx_out_o_color = o_color;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec4 vtx_out_o_color;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	o_o_color = vtx_out_o_color;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler;
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler;
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color;
	o_color = texture(u_sampler, uv);
	o_o_color = o_color;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler;
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color;

	o_color = texture(u_sampler, uv);

	outputs[invocationNdx].o_color = o_color;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec4 vtx_out_o_color0;
layout(location = 1) flat out highp vec4 vtx_out_o_color1;
layout(location = 2) flat out highp vec4 vtx_out_o_color2;
layout(location = 3) flat out highp vec4 vtx_out_o_color3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 uv = a_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	vtx_out_o_color0 = o_color0;
	vtx_out_o_color1 = o_color1;
	vtx_out_o_color2 = o_color2;
	vtx_out_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec4 vtx_out_o_color0;
layout(location = 1) flat in highp vec4 vtx_out_o_color1;
layout(location = 2) flat in highp vec4 vtx_out_o_color2;
layout(location = 3) flat in highp vec4 vtx_out_o_color3;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	o_o_color0 = vtx_out_o_color0;
	o_o_color1 = vtx_out_o_color1;
	o_o_color2 = vtx_out_o_color2;
	o_o_color3 = vtx_out_o_color3;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler[4];
layout(location = 0) flat in highp vec2 vtx_out_uv;
layout(location = 0) out highp vec4 o_o_color0;
layout(location = 1) out highp vec4 o_o_color1;
layout(location = 2) out highp vec4 o_o_color2;
layout(location = 3) out highp vec4 o_o_color3;

void main (void)
{
	highp vec2 uv = vtx_out_uv;
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);
	o_o_color0 = o_color0;
	o_o_color1 = o_color1;
	o_o_color2 = o_color2;
	o_o_color3 = o_color3;
}
#version 450
layout(set=1, binding=31) uniform highp sampler2D u_sampler[4];
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 uv;
};
struct Outputs
{
	highp vec4 o_color0;
	highp vec4 o_color1;
	highp vec4 o_color2;
	highp vec4 o_color3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	vec2 uv = vec2(inputs[invocationNdx].uv);
	vec4 o_color0;
	vec4 o_color1;
	vec4 o_color2;
	vec4 o_color3;

	o_color0 = texture(u_sampler[0], uv);
	o_color1 = texture(u_sampler[1], uv);
	o_color2 = texture(u_sampler[2], uv);
	o_color3 = texture(u_sampler[3], uv);

	outputs[invocationNdx].o_color0 = o_color0;
	outputs[invocationNdx].o_color1 = o_color1;
	outputs[invocationNdx].o_color2 = o_color2;
	outputs[invocationNdx].o_color3 = o_color3;
}
