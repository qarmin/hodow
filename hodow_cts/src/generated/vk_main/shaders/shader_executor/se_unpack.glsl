#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_in0;
layout(location = 0) flat out highp uint vtx_out_in0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_in0 = a_in0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec2 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint in0 = vtx_out_in0[0];
	highp vec2 out0;

	out0 = unpackSnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec2 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint in0 = vtx_out_in0[0];
	highp vec2 out0;

	out0 = unpackSnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp vec2 geom_out_out0;
layout(location = 0) out highp vec2 o_out0;

void main (void)
{
	o_out0 = geom_out_out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec2 out0;
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
	uint in0 = uint(inputs[invocationNdx].in0);
	vec2 out0;

	out0 = unpackSnorm2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec2 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint in0 = vtx_out_in0[0];
	highp vec2 out0;

	out0 = unpackUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec2 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint in0 = vtx_out_in0[0];
	highp vec2 out0;

	out0 = unpackUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec2 out0;
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
	uint in0 = uint(inputs[invocationNdx].in0);
	vec2 out0;

	out0 = unpackUnorm2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_in0;
layout(location = 0) flat out highp vec4 vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint in0 = a_in0;
	highp vec4 out0;
	out0 = unpackSnorm4x8(in0);
	vtx_out_out0 = out0;
}
#version 450
layout(location = 0) flat in highp vec4 vtx_out_out0;
layout(location = 0) out highp vec4 o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec4 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint in0 = vtx_out_in0[0];
	highp vec4 out0;

	out0 = unpackSnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec4 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint in0 = vtx_out_in0[0];
	highp vec4 out0;

	out0 = unpackSnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp vec4 geom_out_out0;
layout(location = 0) out highp vec4 o_out0;

void main (void)
{
	o_out0 = geom_out_out0;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_in0;
layout(location = 0) out highp vec4 o_out0;

void main (void)
{
	highp uint in0 = vtx_out_in0;
	highp vec4 out0;
	out0 = unpackSnorm4x8(in0);
	o_out0 = out0;
}
#version 450
void main (void)
{
    gl_Position = vec4(gl_VertexIndex/2, gl_VertexIndex%2, 0.0, 1.0);
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec4 out0;
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
	uint in0 = uint(inputs[invocationId].in0);
	vec4 out0;

	out0 = unpackSnorm4x8(in0);

	outputs[invocationId].out0 = out0;
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

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec4 out0;
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
	uint in0 = uint(inputs[invocationId].in0);
	vec4 out0;

	out0 = unpackSnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec4 out0;
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
	uint in0 = uint(inputs[invocationNdx].in0);
	vec4 out0;

	out0 = unpackSnorm4x8(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_in0;
layout(location = 0) flat out highp vec4 vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint in0 = a_in0;
	highp vec4 out0;
	out0 = unpackUnorm4x8(in0);
	vtx_out_out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec4 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint in0 = vtx_out_in0[0];
	highp vec4 out0;

	out0 = unpackUnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out highp vec4 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint in0 = vtx_out_in0[0];
	highp vec4 out0;

	out0 = unpackUnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint vtx_out_in0;
layout(location = 0) out highp vec4 o_out0;

void main (void)
{
	highp uint in0 = vtx_out_in0;
	highp vec4 out0;
	out0 = unpackUnorm4x8(in0);
	o_out0 = out0;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec4 out0;
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
	uint in0 = uint(inputs[invocationId].in0);
	vec4 out0;

	out0 = unpackUnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec4 out0;
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
	uint in0 = uint(inputs[invocationId].in0);
	vec4 out0;

	out0 = unpackUnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec4 out0;
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
	uint in0 = uint(inputs[invocationNdx].in0);
	vec4 out0;

	out0 = unpackUnorm4x8(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out mediump vec2 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint in0 = vtx_out_in0[0];
	mediump vec2 out0;

	out0 = unpackHalf2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_in0[];
layout(location = 0) flat out mediump vec2 geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint in0 = vtx_out_in0[0];
	mediump vec2 out0;

	out0 = unpackHalf2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump vec2 geom_out_out0;
layout(location = 0) out mediump vec2 o_out0;

void main (void)
{
	o_out0 = geom_out_out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	mediump vec2 out0;
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
	uint in0 = uint(inputs[invocationNdx].in0);
	vec2 out0;

	out0 = unpackHalf2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
