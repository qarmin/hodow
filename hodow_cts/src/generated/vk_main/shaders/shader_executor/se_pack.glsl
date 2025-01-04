#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec2 a_in0;
layout(location = 0) flat out mediump vec2 vtx_out_in0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_in0 = a_in0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint geom_out_out0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	o_out0 = geom_out_out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec2 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	uint out0;

	out0 = packSnorm2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_in0;
layout(location = 0) flat out highp vec2 vtx_out_in0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_in0 = a_in0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	uint out0;

	out0 = packSnorm2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec2 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	uint out0;

	out0 = packUnorm2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	uint out0;

	out0 = packUnorm2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_in0;
layout(location = 0) flat out highp uint vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump vec4 in0 = a_in0;
	highp uint out0;
	out0 = packSnorm4x8(in0);
	vtx_out_out0 = out0;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_out0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_in0;
layout(location = 0) flat out mediump vec4 vtx_out_in0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_in0 = a_in0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump vec4 vtx_out_in0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	mediump vec4 in0 = vtx_out_in0;
	highp uint out0;
	out0 = packSnorm4x8(in0);
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
	mediump vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packSnorm4x8(in0);

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
	mediump vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packSnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	uint out0;

	out0 = packSnorm4x8(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_in0;
layout(location = 0) flat out highp uint vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 in0 = a_in0;
	highp uint out0;
	out0 = packSnorm4x8(in0);
	vtx_out_out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_in0;
layout(location = 0) flat out highp vec4 vtx_out_in0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_in0 = a_in0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packSnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp vec4 vtx_out_in0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	highp vec4 in0 = vtx_out_in0;
	highp uint out0;
	out0 = packSnorm4x8(in0);
	o_out0 = out0;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packSnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packSnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	uint out0;

	out0 = packSnorm4x8(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_in0;
layout(location = 0) flat out highp uint vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump vec4 in0 = a_in0;
	highp uint out0;
	out0 = packUnorm4x8(in0);
	vtx_out_out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump vec4 vtx_out_in0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	mediump vec4 in0 = vtx_out_in0;
	highp uint out0;
	out0 = packUnorm4x8(in0);
	o_out0 = out0;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packUnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packUnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	uint out0;

	out0 = packUnorm4x8(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_in0;
layout(location = 0) flat out highp uint vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 in0 = a_in0;
	highp uint out0;
	out0 = packUnorm4x8(in0);
	vtx_out_out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec4 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec4 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packUnorm4x8(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp vec4 vtx_out_in0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	highp vec4 in0 = vtx_out_in0;
	highp uint out0;
	out0 = packUnorm4x8(in0);
	o_out0 = out0;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packUnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packUnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationNdx].in0);
	uint out0;

	out0 = packUnorm4x8(in0);

	outputs[invocationNdx].out0 = out0;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packHalf2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp vec2 vtx_out_in0[];
layout(location = 0) flat out highp uint geom_out_out0;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp vec2 in0 = vtx_out_in0[0];
	highp uint out0;

	out0 = packHalf2x16(in0);
	geom_out_out0 = out0;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec2 in0 = vec2(inputs[invocationNdx].in0);
	uint out0;

	out0 = packHalf2x16(in0);

	outputs[invocationNdx].out0 = out0;
}
