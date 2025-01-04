#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_x;
layout(location = 2) in mediump uint a_y;
layout(location = 0) flat out mediump uint vtx_out_sum;
layout(location = 1) flat out lowp uint vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint x = a_x;
	mediump uint y = a_y;
	mediump uint sum;
	lowp uint carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_sum;
layout(location = 1) flat in lowp uint vtx_out_carry;
layout(location = 0) out mediump uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_x;
layout(location = 0) flat out mediump uint vtx_out_x;
layout(location = 2) in mediump uint a_y;
layout(location = 1) flat out mediump uint vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_x[];
layout(location = 1) flat in mediump uint vtx_out_y[];
layout(location = 0) flat out mediump uint geom_out_sum;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint x = vtx_out_x[0];
	mediump uint y = vtx_out_y[0];
	mediump uint sum;
	lowp uint carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_x[];
layout(location = 1) flat in mediump uint vtx_out_y[];
layout(location = 0) flat out mediump uint geom_out_sum;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint x = vtx_out_x[0];
	mediump uint y = vtx_out_y[0];
	mediump uint sum;
	lowp uint carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint geom_out_sum;
layout(location = 1) flat in lowp uint geom_out_carry;
layout(location = 0) out mediump uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_x;
layout(location = 1) flat in mediump uint vtx_out_y;
layout(location = 0) out mediump uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	mediump uint x = vtx_out_x;
	mediump uint y = vtx_out_y;
	mediump uint sum;
	lowp uint carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
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
	mediump uint x;
	mediump uint y;
};
struct Outputs
{
	mediump uint sum;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint sum;
	uint carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
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
	mediump uint x;
	mediump uint y;
};
struct Outputs
{
	mediump uint sum;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint sum;
	uint carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint x;
	mediump uint y;
};
struct Outputs
{
	mediump uint sum;
	lowp uint carry;
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
	uint x = uint(inputs[invocationNdx].x);
	uint y = uint(inputs[invocationNdx].y);
	uint sum;
	uint carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_x;
layout(location = 2) in highp uint a_y;
layout(location = 0) flat out highp uint vtx_out_sum;
layout(location = 1) flat out lowp uint vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint x = a_x;
	highp uint y = a_y;
	highp uint sum;
	lowp uint carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_sum;
layout(location = 1) flat in lowp uint vtx_out_carry;
layout(location = 0) out highp uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_x;
layout(location = 0) flat out highp uint vtx_out_x;
layout(location = 2) in highp uint a_y;
layout(location = 1) flat out highp uint vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_x[];
layout(location = 1) flat in highp uint vtx_out_y[];
layout(location = 0) flat out highp uint geom_out_sum;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint x = vtx_out_x[0];
	highp uint y = vtx_out_y[0];
	highp uint sum;
	lowp uint carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_x[];
layout(location = 1) flat in highp uint vtx_out_y[];
layout(location = 0) flat out highp uint geom_out_sum;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint x = vtx_out_x[0];
	highp uint y = vtx_out_y[0];
	highp uint sum;
	lowp uint carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint geom_out_sum;
layout(location = 1) flat in lowp uint geom_out_carry;
layout(location = 0) out highp uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_x;
layout(location = 1) flat in highp uint vtx_out_y;
layout(location = 0) out highp uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	highp uint x = vtx_out_x;
	highp uint y = vtx_out_y;
	highp uint sum;
	lowp uint carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint sum;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint sum;
	uint carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint sum;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint sum;
	uint carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint sum;
	lowp uint carry;
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
	uint x = uint(inputs[invocationNdx].x);
	uint y = uint(inputs[invocationNdx].y);
	uint sum;
	uint carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_x;
layout(location = 2) in mediump uvec2 a_y;
layout(location = 0) flat out mediump uvec2 vtx_out_sum;
layout(location = 1) flat out lowp uvec2 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 x = a_x;
	mediump uvec2 y = a_y;
	mediump uvec2 sum;
	lowp uvec2 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_sum;
layout(location = 1) flat in lowp uvec2 vtx_out_carry;
layout(location = 0) out mediump uvec2 o_sum;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_x;
layout(location = 0) flat out mediump uvec2 vtx_out_x;
layout(location = 2) in mediump uvec2 a_y;
layout(location = 1) flat out mediump uvec2 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_x[];
layout(location = 1) flat in mediump uvec2 vtx_out_y[];
layout(location = 0) flat out mediump uvec2 geom_out_sum;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 x = vtx_out_x[0];
	mediump uvec2 y = vtx_out_y[0];
	mediump uvec2 sum;
	lowp uvec2 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_x[];
layout(location = 1) flat in mediump uvec2 vtx_out_y[];
layout(location = 0) flat out mediump uvec2 geom_out_sum;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 x = vtx_out_x[0];
	mediump uvec2 y = vtx_out_y[0];
	mediump uvec2 sum;
	lowp uvec2 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 geom_out_sum;
layout(location = 1) flat in lowp uvec2 geom_out_carry;
layout(location = 0) out mediump uvec2 o_sum;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_x;
layout(location = 1) flat in mediump uvec2 vtx_out_y;
layout(location = 0) out mediump uvec2 o_sum;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	mediump uvec2 x = vtx_out_x;
	mediump uvec2 y = vtx_out_y;
	mediump uvec2 sum;
	lowp uvec2 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 x;
	mediump uvec2 y;
};
struct Outputs
{
	mediump uvec2 sum;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 sum;
	uvec2 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 x;
	mediump uvec2 y;
};
struct Outputs
{
	mediump uvec2 sum;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 sum;
	uvec2 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 x;
	mediump uvec2 y;
};
struct Outputs
{
	mediump uvec2 sum;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationNdx].x);
	uvec2 y = uvec2(inputs[invocationNdx].y);
	uvec2 sum;
	uvec2 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_x;
layout(location = 2) in highp uvec2 a_y;
layout(location = 0) flat out highp uvec2 vtx_out_sum;
layout(location = 1) flat out lowp uvec2 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 x = a_x;
	highp uvec2 y = a_y;
	highp uvec2 sum;
	lowp uvec2 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_sum;
layout(location = 1) flat in lowp uvec2 vtx_out_carry;
layout(location = 0) out highp uvec2 o_sum;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_x;
layout(location = 0) flat out highp uvec2 vtx_out_x;
layout(location = 2) in highp uvec2 a_y;
layout(location = 1) flat out highp uvec2 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_x[];
layout(location = 1) flat in highp uvec2 vtx_out_y[];
layout(location = 0) flat out highp uvec2 geom_out_sum;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 x = vtx_out_x[0];
	highp uvec2 y = vtx_out_y[0];
	highp uvec2 sum;
	lowp uvec2 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_x[];
layout(location = 1) flat in highp uvec2 vtx_out_y[];
layout(location = 0) flat out highp uvec2 geom_out_sum;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 x = vtx_out_x[0];
	highp uvec2 y = vtx_out_y[0];
	highp uvec2 sum;
	lowp uvec2 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 geom_out_sum;
layout(location = 1) flat in lowp uvec2 geom_out_carry;
layout(location = 0) out highp uvec2 o_sum;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_x;
layout(location = 1) flat in highp uvec2 vtx_out_y;
layout(location = 0) out highp uvec2 o_sum;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	highp uvec2 x = vtx_out_x;
	highp uvec2 y = vtx_out_y;
	highp uvec2 sum;
	lowp uvec2 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 sum;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 sum;
	uvec2 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 sum;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 sum;
	uvec2 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 sum;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationNdx].x);
	uvec2 y = uvec2(inputs[invocationNdx].y);
	uvec2 sum;
	uvec2 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_x;
layout(location = 2) in mediump uvec3 a_y;
layout(location = 0) flat out mediump uvec3 vtx_out_sum;
layout(location = 1) flat out lowp uvec3 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 x = a_x;
	mediump uvec3 y = a_y;
	mediump uvec3 sum;
	lowp uvec3 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_sum;
layout(location = 1) flat in lowp uvec3 vtx_out_carry;
layout(location = 0) out mediump uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_x;
layout(location = 0) flat out mediump uvec3 vtx_out_x;
layout(location = 2) in mediump uvec3 a_y;
layout(location = 1) flat out mediump uvec3 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_x[];
layout(location = 1) flat in mediump uvec3 vtx_out_y[];
layout(location = 0) flat out mediump uvec3 geom_out_sum;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 x = vtx_out_x[0];
	mediump uvec3 y = vtx_out_y[0];
	mediump uvec3 sum;
	lowp uvec3 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_x[];
layout(location = 1) flat in mediump uvec3 vtx_out_y[];
layout(location = 0) flat out mediump uvec3 geom_out_sum;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 x = vtx_out_x[0];
	mediump uvec3 y = vtx_out_y[0];
	mediump uvec3 sum;
	lowp uvec3 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 geom_out_sum;
layout(location = 1) flat in lowp uvec3 geom_out_carry;
layout(location = 0) out mediump uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_x;
layout(location = 1) flat in mediump uvec3 vtx_out_y;
layout(location = 0) out mediump uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	mediump uvec3 x = vtx_out_x;
	mediump uvec3 y = vtx_out_y;
	mediump uvec3 sum;
	lowp uvec3 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 x;
	mediump uvec3 y;
};
struct Outputs
{
	mediump uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 x;
	mediump uvec3 y;
};
struct Outputs
{
	mediump uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 x;
	mediump uvec3 y;
};
struct Outputs
{
	mediump uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationNdx].x);
	uvec3 y = uvec3(inputs[invocationNdx].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_x;
layout(location = 2) in highp uvec3 a_y;
layout(location = 0) flat out highp uvec3 vtx_out_sum;
layout(location = 1) flat out lowp uvec3 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 x = a_x;
	highp uvec3 y = a_y;
	highp uvec3 sum;
	lowp uvec3 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_sum;
layout(location = 1) flat in lowp uvec3 vtx_out_carry;
layout(location = 0) out highp uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_x;
layout(location = 0) flat out highp uvec3 vtx_out_x;
layout(location = 2) in highp uvec3 a_y;
layout(location = 1) flat out highp uvec3 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_x[];
layout(location = 1) flat in highp uvec3 vtx_out_y[];
layout(location = 0) flat out highp uvec3 geom_out_sum;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 x = vtx_out_x[0];
	highp uvec3 y = vtx_out_y[0];
	highp uvec3 sum;
	lowp uvec3 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_x[];
layout(location = 1) flat in highp uvec3 vtx_out_y[];
layout(location = 0) flat out highp uvec3 geom_out_sum;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 x = vtx_out_x[0];
	highp uvec3 y = vtx_out_y[0];
	highp uvec3 sum;
	lowp uvec3 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 geom_out_sum;
layout(location = 1) flat in lowp uvec3 geom_out_carry;
layout(location = 0) out highp uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_x;
layout(location = 1) flat in highp uvec3 vtx_out_y;
layout(location = 0) out highp uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	highp uvec3 x = vtx_out_x;
	highp uvec3 y = vtx_out_y;
	highp uvec3 sum;
	lowp uvec3 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationNdx].x);
	uvec3 y = uvec3(inputs[invocationNdx].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_x;
layout(location = 2) in mediump uvec4 a_y;
layout(location = 0) flat out mediump uvec4 vtx_out_sum;
layout(location = 1) flat out lowp uvec4 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 x = a_x;
	mediump uvec4 y = a_y;
	mediump uvec4 sum;
	lowp uvec4 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_sum;
layout(location = 1) flat in lowp uvec4 vtx_out_carry;
layout(location = 0) out mediump uvec4 o_sum;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_x;
layout(location = 0) flat out mediump uvec4 vtx_out_x;
layout(location = 2) in mediump uvec4 a_y;
layout(location = 1) flat out mediump uvec4 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_x[];
layout(location = 1) flat in mediump uvec4 vtx_out_y[];
layout(location = 0) flat out mediump uvec4 geom_out_sum;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 x = vtx_out_x[0];
	mediump uvec4 y = vtx_out_y[0];
	mediump uvec4 sum;
	lowp uvec4 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_x[];
layout(location = 1) flat in mediump uvec4 vtx_out_y[];
layout(location = 0) flat out mediump uvec4 geom_out_sum;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 x = vtx_out_x[0];
	mediump uvec4 y = vtx_out_y[0];
	mediump uvec4 sum;
	lowp uvec4 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 geom_out_sum;
layout(location = 1) flat in lowp uvec4 geom_out_carry;
layout(location = 0) out mediump uvec4 o_sum;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_x;
layout(location = 1) flat in mediump uvec4 vtx_out_y;
layout(location = 0) out mediump uvec4 o_sum;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	mediump uvec4 x = vtx_out_x;
	mediump uvec4 y = vtx_out_y;
	mediump uvec4 sum;
	lowp uvec4 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 sum;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 sum;
	uvec4 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 sum;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 sum;
	uvec4 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 sum;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationNdx].x);
	uvec4 y = uvec4(inputs[invocationNdx].y);
	uvec4 sum;
	uvec4 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_x;
layout(location = 2) in highp uvec4 a_y;
layout(location = 0) flat out highp uvec4 vtx_out_sum;
layout(location = 1) flat out lowp uvec4 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 x = a_x;
	highp uvec4 y = a_y;
	highp uvec4 sum;
	lowp uvec4 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_sum;
layout(location = 1) flat in lowp uvec4 vtx_out_carry;
layout(location = 0) out highp uvec4 o_sum;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_x;
layout(location = 0) flat out highp uvec4 vtx_out_x;
layout(location = 2) in highp uvec4 a_y;
layout(location = 1) flat out highp uvec4 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_x[];
layout(location = 1) flat in highp uvec4 vtx_out_y[];
layout(location = 0) flat out highp uvec4 geom_out_sum;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 x = vtx_out_x[0];
	highp uvec4 y = vtx_out_y[0];
	highp uvec4 sum;
	lowp uvec4 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_x[];
layout(location = 1) flat in highp uvec4 vtx_out_y[];
layout(location = 0) flat out highp uvec4 geom_out_sum;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 x = vtx_out_x[0];
	highp uvec4 y = vtx_out_y[0];
	highp uvec4 sum;
	lowp uvec4 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 geom_out_sum;
layout(location = 1) flat in lowp uvec4 geom_out_carry;
layout(location = 0) out highp uvec4 o_sum;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_x;
layout(location = 1) flat in highp uvec4 vtx_out_y;
layout(location = 0) out highp uvec4 o_sum;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	highp uvec4 x = vtx_out_x;
	highp uvec4 y = vtx_out_y;
	highp uvec4 sum;
	lowp uvec4 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 sum;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 sum;
	uvec4 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 sum;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 sum;
	uvec4 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 sum;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationNdx].x);
	uvec4 y = uvec4(inputs[invocationNdx].y);
	uvec4 sum;
	uvec4 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> x;
	mediump vector<uint, 5> y;
};
struct Outputs
{
	mediump vector<uint, 5> sum;
	lowp vector<uint, 5> carry;
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
	vector<uint, 5> x = vector<uint, 5>(inputs[invocationNdx].x);
	vector<uint, 5> y = vector<uint, 5>(inputs[invocationNdx].y);
	vector<uint, 5> sum;
	vector<uint, 5> carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> x;
	highp vector<uint, 5> y;
};
struct Outputs
{
	highp vector<uint, 5> sum;
	lowp vector<uint, 5> carry;
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
	vector<uint, 5> x = vector<uint, 5>(inputs[invocationNdx].x);
	vector<uint, 5> y = vector<uint, 5>(inputs[invocationNdx].y);
	vector<uint, 5> sum;
	vector<uint, 5> carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationNdx].sum = sum;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_x;
layout(location = 2) in mediump uint a_y;
layout(location = 0) flat out mediump uint vtx_out_diff;
layout(location = 1) flat out lowp uint vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint x = a_x;
	mediump uint y = a_y;
	mediump uint diff;
	lowp uint carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_diff;
layout(location = 1) flat in lowp uint vtx_out_carry;
layout(location = 0) out mediump uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_x[];
layout(location = 1) flat in mediump uint vtx_out_y[];
layout(location = 0) flat out mediump uint geom_out_diff;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint x = vtx_out_x[0];
	mediump uint y = vtx_out_y[0];
	mediump uint diff;
	lowp uint carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_x[];
layout(location = 1) flat in mediump uint vtx_out_y[];
layout(location = 0) flat out mediump uint geom_out_diff;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint x = vtx_out_x[0];
	mediump uint y = vtx_out_y[0];
	mediump uint diff;
	lowp uint carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint geom_out_diff;
layout(location = 1) flat in lowp uint geom_out_carry;
layout(location = 0) out mediump uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_x;
layout(location = 1) flat in mediump uint vtx_out_y;
layout(location = 0) out mediump uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	mediump uint x = vtx_out_x;
	mediump uint y = vtx_out_y;
	mediump uint diff;
	lowp uint carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uint x;
	mediump uint y;
};
struct Outputs
{
	mediump uint diff;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint diff;
	uint carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint x;
	mediump uint y;
};
struct Outputs
{
	mediump uint diff;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint diff;
	uint carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint x;
	mediump uint y;
};
struct Outputs
{
	mediump uint diff;
	lowp uint carry;
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
	uint x = uint(inputs[invocationNdx].x);
	uint y = uint(inputs[invocationNdx].y);
	uint diff;
	uint carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_x;
layout(location = 2) in highp uint a_y;
layout(location = 0) flat out highp uint vtx_out_diff;
layout(location = 1) flat out lowp uint vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint x = a_x;
	highp uint y = a_y;
	highp uint diff;
	lowp uint carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_diff;
layout(location = 1) flat in lowp uint vtx_out_carry;
layout(location = 0) out highp uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_x[];
layout(location = 1) flat in highp uint vtx_out_y[];
layout(location = 0) flat out highp uint geom_out_diff;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint x = vtx_out_x[0];
	highp uint y = vtx_out_y[0];
	highp uint diff;
	lowp uint carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_x[];
layout(location = 1) flat in highp uint vtx_out_y[];
layout(location = 0) flat out highp uint geom_out_diff;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint x = vtx_out_x[0];
	highp uint y = vtx_out_y[0];
	highp uint diff;
	lowp uint carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint geom_out_diff;
layout(location = 1) flat in lowp uint geom_out_carry;
layout(location = 0) out highp uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_x;
layout(location = 1) flat in highp uint vtx_out_y;
layout(location = 0) out highp uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	highp uint x = vtx_out_x;
	highp uint y = vtx_out_y;
	highp uint diff;
	lowp uint carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint diff;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint diff;
	uint carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint diff;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint diff;
	uint carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint diff;
	lowp uint carry;
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
	uint x = uint(inputs[invocationNdx].x);
	uint y = uint(inputs[invocationNdx].y);
	uint diff;
	uint carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_x;
layout(location = 2) in mediump uvec2 a_y;
layout(location = 0) flat out mediump uvec2 vtx_out_diff;
layout(location = 1) flat out lowp uvec2 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 x = a_x;
	mediump uvec2 y = a_y;
	mediump uvec2 diff;
	lowp uvec2 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_diff;
layout(location = 1) flat in lowp uvec2 vtx_out_carry;
layout(location = 0) out mediump uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_x[];
layout(location = 1) flat in mediump uvec2 vtx_out_y[];
layout(location = 0) flat out mediump uvec2 geom_out_diff;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 x = vtx_out_x[0];
	mediump uvec2 y = vtx_out_y[0];
	mediump uvec2 diff;
	lowp uvec2 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_x[];
layout(location = 1) flat in mediump uvec2 vtx_out_y[];
layout(location = 0) flat out mediump uvec2 geom_out_diff;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 x = vtx_out_x[0];
	mediump uvec2 y = vtx_out_y[0];
	mediump uvec2 diff;
	lowp uvec2 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 geom_out_diff;
layout(location = 1) flat in lowp uvec2 geom_out_carry;
layout(location = 0) out mediump uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_x;
layout(location = 1) flat in mediump uvec2 vtx_out_y;
layout(location = 0) out mediump uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	mediump uvec2 x = vtx_out_x;
	mediump uvec2 y = vtx_out_y;
	mediump uvec2 diff;
	lowp uvec2 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 x;
	mediump uvec2 y;
};
struct Outputs
{
	mediump uvec2 diff;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 x;
	mediump uvec2 y;
};
struct Outputs
{
	mediump uvec2 diff;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 x;
	mediump uvec2 y;
};
struct Outputs
{
	mediump uvec2 diff;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationNdx].x);
	uvec2 y = uvec2(inputs[invocationNdx].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_x;
layout(location = 2) in highp uvec2 a_y;
layout(location = 0) flat out highp uvec2 vtx_out_diff;
layout(location = 1) flat out lowp uvec2 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 x = a_x;
	highp uvec2 y = a_y;
	highp uvec2 diff;
	lowp uvec2 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_diff;
layout(location = 1) flat in lowp uvec2 vtx_out_carry;
layout(location = 0) out highp uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_x[];
layout(location = 1) flat in highp uvec2 vtx_out_y[];
layout(location = 0) flat out highp uvec2 geom_out_diff;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 x = vtx_out_x[0];
	highp uvec2 y = vtx_out_y[0];
	highp uvec2 diff;
	lowp uvec2 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_x[];
layout(location = 1) flat in highp uvec2 vtx_out_y[];
layout(location = 0) flat out highp uvec2 geom_out_diff;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 x = vtx_out_x[0];
	highp uvec2 y = vtx_out_y[0];
	highp uvec2 diff;
	lowp uvec2 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 geom_out_diff;
layout(location = 1) flat in lowp uvec2 geom_out_carry;
layout(location = 0) out highp uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_x;
layout(location = 1) flat in highp uvec2 vtx_out_y;
layout(location = 0) out highp uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	highp uvec2 x = vtx_out_x;
	highp uvec2 y = vtx_out_y;
	highp uvec2 diff;
	lowp uvec2 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 diff;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 diff;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 diff;
	lowp uvec2 carry;
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
	uvec2 x = uvec2(inputs[invocationNdx].x);
	uvec2 y = uvec2(inputs[invocationNdx].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_x;
layout(location = 2) in mediump uvec3 a_y;
layout(location = 0) flat out mediump uvec3 vtx_out_diff;
layout(location = 1) flat out lowp uvec3 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 x = a_x;
	mediump uvec3 y = a_y;
	mediump uvec3 diff;
	lowp uvec3 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_diff;
layout(location = 1) flat in lowp uvec3 vtx_out_carry;
layout(location = 0) out mediump uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_x[];
layout(location = 1) flat in mediump uvec3 vtx_out_y[];
layout(location = 0) flat out mediump uvec3 geom_out_diff;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 x = vtx_out_x[0];
	mediump uvec3 y = vtx_out_y[0];
	mediump uvec3 diff;
	lowp uvec3 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_x[];
layout(location = 1) flat in mediump uvec3 vtx_out_y[];
layout(location = 0) flat out mediump uvec3 geom_out_diff;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 x = vtx_out_x[0];
	mediump uvec3 y = vtx_out_y[0];
	mediump uvec3 diff;
	lowp uvec3 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 geom_out_diff;
layout(location = 1) flat in lowp uvec3 geom_out_carry;
layout(location = 0) out mediump uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_x;
layout(location = 1) flat in mediump uvec3 vtx_out_y;
layout(location = 0) out mediump uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	mediump uvec3 x = vtx_out_x;
	mediump uvec3 y = vtx_out_y;
	mediump uvec3 diff;
	lowp uvec3 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 x;
	mediump uvec3 y;
};
struct Outputs
{
	mediump uvec3 diff;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 diff;
	uvec3 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 x;
	mediump uvec3 y;
};
struct Outputs
{
	mediump uvec3 diff;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 diff;
	uvec3 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 x;
	mediump uvec3 y;
};
struct Outputs
{
	mediump uvec3 diff;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationNdx].x);
	uvec3 y = uvec3(inputs[invocationNdx].y);
	uvec3 diff;
	uvec3 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_x;
layout(location = 2) in highp uvec3 a_y;
layout(location = 0) flat out highp uvec3 vtx_out_diff;
layout(location = 1) flat out lowp uvec3 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 x = a_x;
	highp uvec3 y = a_y;
	highp uvec3 diff;
	lowp uvec3 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_diff;
layout(location = 1) flat in lowp uvec3 vtx_out_carry;
layout(location = 0) out highp uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_x[];
layout(location = 1) flat in highp uvec3 vtx_out_y[];
layout(location = 0) flat out highp uvec3 geom_out_diff;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 x = vtx_out_x[0];
	highp uvec3 y = vtx_out_y[0];
	highp uvec3 diff;
	lowp uvec3 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_x[];
layout(location = 1) flat in highp uvec3 vtx_out_y[];
layout(location = 0) flat out highp uvec3 geom_out_diff;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 x = vtx_out_x[0];
	highp uvec3 y = vtx_out_y[0];
	highp uvec3 diff;
	lowp uvec3 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 geom_out_diff;
layout(location = 1) flat in lowp uvec3 geom_out_carry;
layout(location = 0) out highp uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_x;
layout(location = 1) flat in highp uvec3 vtx_out_y;
layout(location = 0) out highp uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	highp uvec3 x = vtx_out_x;
	highp uvec3 y = vtx_out_y;
	highp uvec3 diff;
	lowp uvec3 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 diff;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 diff;
	uvec3 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 diff;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 diff;
	uvec3 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 diff;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationNdx].x);
	uvec3 y = uvec3(inputs[invocationNdx].y);
	uvec3 diff;
	uvec3 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_x;
layout(location = 2) in mediump uvec4 a_y;
layout(location = 0) flat out mediump uvec4 vtx_out_diff;
layout(location = 1) flat out lowp uvec4 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 x = a_x;
	mediump uvec4 y = a_y;
	mediump uvec4 diff;
	lowp uvec4 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_diff;
layout(location = 1) flat in lowp uvec4 vtx_out_carry;
layout(location = 0) out mediump uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_x[];
layout(location = 1) flat in mediump uvec4 vtx_out_y[];
layout(location = 0) flat out mediump uvec4 geom_out_diff;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 x = vtx_out_x[0];
	mediump uvec4 y = vtx_out_y[0];
	mediump uvec4 diff;
	lowp uvec4 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_x[];
layout(location = 1) flat in mediump uvec4 vtx_out_y[];
layout(location = 0) flat out mediump uvec4 geom_out_diff;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 x = vtx_out_x[0];
	mediump uvec4 y = vtx_out_y[0];
	mediump uvec4 diff;
	lowp uvec4 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 geom_out_diff;
layout(location = 1) flat in lowp uvec4 geom_out_carry;
layout(location = 0) out mediump uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_x;
layout(location = 1) flat in mediump uvec4 vtx_out_y;
layout(location = 0) out mediump uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	mediump uvec4 x = vtx_out_x;
	mediump uvec4 y = vtx_out_y;
	mediump uvec4 diff;
	lowp uvec4 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 diff;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 diff;
	uvec4 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 diff;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 diff;
	uvec4 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 diff;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationNdx].x);
	uvec4 y = uvec4(inputs[invocationNdx].y);
	uvec4 diff;
	uvec4 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_x;
layout(location = 2) in highp uvec4 a_y;
layout(location = 0) flat out highp uvec4 vtx_out_diff;
layout(location = 1) flat out lowp uvec4 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 x = a_x;
	highp uvec4 y = a_y;
	highp uvec4 diff;
	lowp uvec4 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_diff;
layout(location = 1) flat in lowp uvec4 vtx_out_carry;
layout(location = 0) out highp uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_x[];
layout(location = 1) flat in highp uvec4 vtx_out_y[];
layout(location = 0) flat out highp uvec4 geom_out_diff;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 x = vtx_out_x[0];
	highp uvec4 y = vtx_out_y[0];
	highp uvec4 diff;
	lowp uvec4 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_x[];
layout(location = 1) flat in highp uvec4 vtx_out_y[];
layout(location = 0) flat out highp uvec4 geom_out_diff;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 x = vtx_out_x[0];
	highp uvec4 y = vtx_out_y[0];
	highp uvec4 diff;
	lowp uvec4 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 geom_out_diff;
layout(location = 1) flat in lowp uvec4 geom_out_carry;
layout(location = 0) out highp uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_x;
layout(location = 1) flat in highp uvec4 vtx_out_y;
layout(location = 0) out highp uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	highp uvec4 x = vtx_out_x;
	highp uvec4 y = vtx_out_y;
	highp uvec4 diff;
	lowp uvec4 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 diff;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 diff;
	uvec4 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 diff;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 diff;
	uvec4 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 diff;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationNdx].x);
	uvec4 y = uvec4(inputs[invocationNdx].y);
	uvec4 diff;
	uvec4 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> x;
	mediump vector<uint, 5> y;
};
struct Outputs
{
	mediump vector<uint, 5> diff;
	lowp vector<uint, 5> carry;
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
	vector<uint, 5> x = vector<uint, 5>(inputs[invocationNdx].x);
	vector<uint, 5> y = vector<uint, 5>(inputs[invocationNdx].y);
	vector<uint, 5> diff;
	vector<uint, 5> carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> x;
	highp vector<uint, 5> y;
};
struct Outputs
{
	highp vector<uint, 5> diff;
	lowp vector<uint, 5> carry;
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
	vector<uint, 5> x = vector<uint, 5>(inputs[invocationNdx].x);
	vector<uint, 5> y = vector<uint, 5>(inputs[invocationNdx].y);
	vector<uint, 5> diff;
	vector<uint, 5> carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationNdx].diff = diff;
	outputs[invocationNdx].carry = carry;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_x;
layout(location = 2) in highp uint a_y;
layout(location = 0) flat out highp uint vtx_out_msb;
layout(location = 1) flat out highp uint vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint x = a_x;
	highp uint y = a_y;
	highp uint msb;
	highp uint lsb;
	umulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_msb;
layout(location = 1) flat in highp uint vtx_out_lsb;
layout(location = 0) out highp uint o_msb;
layout(location = 1) out highp uint o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_x[];
layout(location = 1) flat in highp uint vtx_out_y[];
layout(location = 0) flat out highp uint geom_out_msb;
layout(location = 1) flat out highp uint geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint x = vtx_out_x[0];
	highp uint y = vtx_out_y[0];
	highp uint msb;
	highp uint lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_x[];
layout(location = 1) flat in highp uint vtx_out_y[];
layout(location = 0) flat out highp uint geom_out_msb;
layout(location = 1) flat out highp uint geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint x = vtx_out_x[0];
	highp uint y = vtx_out_y[0];
	highp uint msb;
	highp uint lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint geom_out_msb;
layout(location = 1) flat in highp uint geom_out_lsb;
layout(location = 0) out highp uint o_msb;
layout(location = 1) out highp uint o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_x;
layout(location = 1) flat in highp uint vtx_out_y;
layout(location = 0) out highp uint o_msb;
layout(location = 1) out highp uint o_lsb;

void main (void)
{
	highp uint x = vtx_out_x;
	highp uint y = vtx_out_y;
	highp uint msb;
	highp uint lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint msb;
	highp uint lsb;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint msb;
	uint lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint msb;
	highp uint lsb;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint msb;
	uint lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint msb;
	highp uint lsb;
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
	uint x = uint(inputs[invocationNdx].x);
	uint y = uint(inputs[invocationNdx].y);
	uint msb;
	uint lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_x;
layout(location = 2) in highp uvec2 a_y;
layout(location = 0) flat out highp uvec2 vtx_out_msb;
layout(location = 1) flat out highp uvec2 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 x = a_x;
	highp uvec2 y = a_y;
	highp uvec2 msb;
	highp uvec2 lsb;
	umulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_msb;
layout(location = 1) flat in highp uvec2 vtx_out_lsb;
layout(location = 0) out highp uvec2 o_msb;
layout(location = 1) out highp uvec2 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_x[];
layout(location = 1) flat in highp uvec2 vtx_out_y[];
layout(location = 0) flat out highp uvec2 geom_out_msb;
layout(location = 1) flat out highp uvec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 x = vtx_out_x[0];
	highp uvec2 y = vtx_out_y[0];
	highp uvec2 msb;
	highp uvec2 lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_x[];
layout(location = 1) flat in highp uvec2 vtx_out_y[];
layout(location = 0) flat out highp uvec2 geom_out_msb;
layout(location = 1) flat out highp uvec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 x = vtx_out_x[0];
	highp uvec2 y = vtx_out_y[0];
	highp uvec2 msb;
	highp uvec2 lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 geom_out_msb;
layout(location = 1) flat in highp uvec2 geom_out_lsb;
layout(location = 0) out highp uvec2 o_msb;
layout(location = 1) out highp uvec2 o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_x;
layout(location = 1) flat in highp uvec2 vtx_out_y;
layout(location = 0) out highp uvec2 o_msb;
layout(location = 1) out highp uvec2 o_lsb;

void main (void)
{
	highp uvec2 x = vtx_out_x;
	highp uvec2 y = vtx_out_y;
	highp uvec2 msb;
	highp uvec2 lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 msb;
	highp uvec2 lsb;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 msb;
	uvec2 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 msb;
	highp uvec2 lsb;
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
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 msb;
	uvec2 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 msb;
	highp uvec2 lsb;
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
	uvec2 x = uvec2(inputs[invocationNdx].x);
	uvec2 y = uvec2(inputs[invocationNdx].y);
	uvec2 msb;
	uvec2 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_x;
layout(location = 2) in highp uvec3 a_y;
layout(location = 0) flat out highp uvec3 vtx_out_msb;
layout(location = 1) flat out highp uvec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 x = a_x;
	highp uvec3 y = a_y;
	highp uvec3 msb;
	highp uvec3 lsb;
	umulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_msb;
layout(location = 1) flat in highp uvec3 vtx_out_lsb;
layout(location = 0) out highp uvec3 o_msb;
layout(location = 1) out highp uvec3 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_x[];
layout(location = 1) flat in highp uvec3 vtx_out_y[];
layout(location = 0) flat out highp uvec3 geom_out_msb;
layout(location = 1) flat out highp uvec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 x = vtx_out_x[0];
	highp uvec3 y = vtx_out_y[0];
	highp uvec3 msb;
	highp uvec3 lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_x[];
layout(location = 1) flat in highp uvec3 vtx_out_y[];
layout(location = 0) flat out highp uvec3 geom_out_msb;
layout(location = 1) flat out highp uvec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 x = vtx_out_x[0];
	highp uvec3 y = vtx_out_y[0];
	highp uvec3 msb;
	highp uvec3 lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 geom_out_msb;
layout(location = 1) flat in highp uvec3 geom_out_lsb;
layout(location = 0) out highp uvec3 o_msb;
layout(location = 1) out highp uvec3 o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_x;
layout(location = 1) flat in highp uvec3 vtx_out_y;
layout(location = 0) out highp uvec3 o_msb;
layout(location = 1) out highp uvec3 o_lsb;

void main (void)
{
	highp uvec3 x = vtx_out_x;
	highp uvec3 y = vtx_out_y;
	highp uvec3 msb;
	highp uvec3 lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 msb;
	highp uvec3 lsb;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 msb;
	uvec3 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 msb;
	highp uvec3 lsb;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 msb;
	uvec3 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 msb;
	highp uvec3 lsb;
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
	uvec3 x = uvec3(inputs[invocationNdx].x);
	uvec3 y = uvec3(inputs[invocationNdx].y);
	uvec3 msb;
	uvec3 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_x;
layout(location = 2) in highp uvec4 a_y;
layout(location = 0) flat out highp uvec4 vtx_out_msb;
layout(location = 1) flat out highp uvec4 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 x = a_x;
	highp uvec4 y = a_y;
	highp uvec4 msb;
	highp uvec4 lsb;
	umulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_msb;
layout(location = 1) flat in highp uvec4 vtx_out_lsb;
layout(location = 0) out highp uvec4 o_msb;
layout(location = 1) out highp uvec4 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_x[];
layout(location = 1) flat in highp uvec4 vtx_out_y[];
layout(location = 0) flat out highp uvec4 geom_out_msb;
layout(location = 1) flat out highp uvec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 x = vtx_out_x[0];
	highp uvec4 y = vtx_out_y[0];
	highp uvec4 msb;
	highp uvec4 lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_x[];
layout(location = 1) flat in highp uvec4 vtx_out_y[];
layout(location = 0) flat out highp uvec4 geom_out_msb;
layout(location = 1) flat out highp uvec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 x = vtx_out_x[0];
	highp uvec4 y = vtx_out_y[0];
	highp uvec4 msb;
	highp uvec4 lsb;

	umulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 geom_out_msb;
layout(location = 1) flat in highp uvec4 geom_out_lsb;
layout(location = 0) out highp uvec4 o_msb;
layout(location = 1) out highp uvec4 o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_x;
layout(location = 1) flat in highp uvec4 vtx_out_y;
layout(location = 0) out highp uvec4 o_msb;
layout(location = 1) out highp uvec4 o_lsb;

void main (void)
{
	highp uvec4 x = vtx_out_x;
	highp uvec4 y = vtx_out_y;
	highp uvec4 msb;
	highp uvec4 lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 msb;
	highp uvec4 lsb;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 msb;
	uvec4 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 msb;
	highp uvec4 lsb;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 msb;
	uvec4 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 x;
	highp uvec4 y;
};
struct Outputs
{
	highp uvec4 msb;
	highp uvec4 lsb;
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
	uvec4 x = uvec4(inputs[invocationNdx].x);
	uvec4 y = uvec4(inputs[invocationNdx].y);
	uvec4 msb;
	uvec4 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> x;
	highp vector<uint, 5> y;
};
struct Outputs
{
	highp vector<uint, 5> msb;
	highp vector<uint, 5> lsb;
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
	vector<uint, 5> x = vector<uint, 5>(inputs[invocationNdx].x);
	vector<uint, 5> y = vector<uint, 5>(inputs[invocationNdx].y);
	vector<uint, 5> msb;
	vector<uint, 5> lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_x;
layout(location = 2) in highp int a_y;
layout(location = 0) flat out highp int vtx_out_msb;
layout(location = 1) flat out highp int vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int x = a_x;
	highp int y = a_y;
	highp int msb;
	highp int lsb;
	imulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp int vtx_out_msb;
layout(location = 1) flat in highp int vtx_out_lsb;
layout(location = 0) out highp int o_msb;
layout(location = 1) out highp int o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_x;
layout(location = 0) flat out highp int vtx_out_x;
layout(location = 2) in highp int a_y;
layout(location = 1) flat out highp int vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_x[];
layout(location = 1) flat in highp int vtx_out_y[];
layout(location = 0) flat out highp int geom_out_msb;
layout(location = 1) flat out highp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int x = vtx_out_x[0];
	highp int y = vtx_out_y[0];
	highp int msb;
	highp int lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_x[];
layout(location = 1) flat in highp int vtx_out_y[];
layout(location = 0) flat out highp int geom_out_msb;
layout(location = 1) flat out highp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int x = vtx_out_x[0];
	highp int y = vtx_out_y[0];
	highp int msb;
	highp int lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp int geom_out_msb;
layout(location = 1) flat in highp int geom_out_lsb;
layout(location = 0) out highp int o_msb;
layout(location = 1) out highp int o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp int vtx_out_x;
layout(location = 1) flat in highp int vtx_out_y;
layout(location = 0) out highp int o_msb;
layout(location = 1) out highp int o_lsb;

void main (void)
{
	highp int x = vtx_out_x;
	highp int y = vtx_out_y;
	highp int msb;
	highp int lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int x;
	highp int y;
};
struct Outputs
{
	highp int msb;
	highp int lsb;
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
	int x = int(inputs[invocationId].x);
	int y = int(inputs[invocationId].y);
	int msb;
	int lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int x;
	highp int y;
};
struct Outputs
{
	highp int msb;
	highp int lsb;
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
	int x = int(inputs[invocationId].x);
	int y = int(inputs[invocationId].y);
	int msb;
	int lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int x;
	highp int y;
};
struct Outputs
{
	highp int msb;
	highp int lsb;
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
	int x = int(inputs[invocationNdx].x);
	int y = int(inputs[invocationNdx].y);
	int msb;
	int lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_x;
layout(location = 2) in highp ivec2 a_y;
layout(location = 0) flat out highp ivec2 vtx_out_msb;
layout(location = 1) flat out highp ivec2 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 x = a_x;
	highp ivec2 y = a_y;
	highp ivec2 msb;
	highp ivec2 lsb;
	imulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_msb;
layout(location = 1) flat in highp ivec2 vtx_out_lsb;
layout(location = 0) out highp ivec2 o_msb;
layout(location = 1) out highp ivec2 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_x;
layout(location = 0) flat out highp ivec2 vtx_out_x;
layout(location = 2) in highp ivec2 a_y;
layout(location = 1) flat out highp ivec2 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_x[];
layout(location = 1) flat in highp ivec2 vtx_out_y[];
layout(location = 0) flat out highp ivec2 geom_out_msb;
layout(location = 1) flat out highp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 x = vtx_out_x[0];
	highp ivec2 y = vtx_out_y[0];
	highp ivec2 msb;
	highp ivec2 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_x[];
layout(location = 1) flat in highp ivec2 vtx_out_y[];
layout(location = 0) flat out highp ivec2 geom_out_msb;
layout(location = 1) flat out highp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 x = vtx_out_x[0];
	highp ivec2 y = vtx_out_y[0];
	highp ivec2 msb;
	highp ivec2 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec2 geom_out_msb;
layout(location = 1) flat in highp ivec2 geom_out_lsb;
layout(location = 0) out highp ivec2 o_msb;
layout(location = 1) out highp ivec2 o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_x;
layout(location = 1) flat in highp ivec2 vtx_out_y;
layout(location = 0) out highp ivec2 o_msb;
layout(location = 1) out highp ivec2 o_lsb;

void main (void)
{
	highp ivec2 x = vtx_out_x;
	highp ivec2 y = vtx_out_y;
	highp ivec2 msb;
	highp ivec2 lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec2 x;
	highp ivec2 y;
};
struct Outputs
{
	highp ivec2 msb;
	highp ivec2 lsb;
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
	ivec2 x = ivec2(inputs[invocationId].x);
	ivec2 y = ivec2(inputs[invocationId].y);
	ivec2 msb;
	ivec2 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 x;
	highp ivec2 y;
};
struct Outputs
{
	highp ivec2 msb;
	highp ivec2 lsb;
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
	ivec2 x = ivec2(inputs[invocationId].x);
	ivec2 y = ivec2(inputs[invocationId].y);
	ivec2 msb;
	ivec2 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 x;
	highp ivec2 y;
};
struct Outputs
{
	highp ivec2 msb;
	highp ivec2 lsb;
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
	ivec2 x = ivec2(inputs[invocationNdx].x);
	ivec2 y = ivec2(inputs[invocationNdx].y);
	ivec2 msb;
	ivec2 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_x;
layout(location = 2) in highp ivec3 a_y;
layout(location = 0) flat out highp ivec3 vtx_out_msb;
layout(location = 1) flat out highp ivec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 x = a_x;
	highp ivec3 y = a_y;
	highp ivec3 msb;
	highp ivec3 lsb;
	imulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_msb;
layout(location = 1) flat in highp ivec3 vtx_out_lsb;
layout(location = 0) out highp ivec3 o_msb;
layout(location = 1) out highp ivec3 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_x;
layout(location = 0) flat out highp ivec3 vtx_out_x;
layout(location = 2) in highp ivec3 a_y;
layout(location = 1) flat out highp ivec3 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_x[];
layout(location = 1) flat in highp ivec3 vtx_out_y[];
layout(location = 0) flat out highp ivec3 geom_out_msb;
layout(location = 1) flat out highp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 x = vtx_out_x[0];
	highp ivec3 y = vtx_out_y[0];
	highp ivec3 msb;
	highp ivec3 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_x[];
layout(location = 1) flat in highp ivec3 vtx_out_y[];
layout(location = 0) flat out highp ivec3 geom_out_msb;
layout(location = 1) flat out highp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec3 x = vtx_out_x[0];
	highp ivec3 y = vtx_out_y[0];
	highp ivec3 msb;
	highp ivec3 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec3 geom_out_msb;
layout(location = 1) flat in highp ivec3 geom_out_lsb;
layout(location = 0) out highp ivec3 o_msb;
layout(location = 1) out highp ivec3 o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_x;
layout(location = 1) flat in highp ivec3 vtx_out_y;
layout(location = 0) out highp ivec3 o_msb;
layout(location = 1) out highp ivec3 o_lsb;

void main (void)
{
	highp ivec3 x = vtx_out_x;
	highp ivec3 y = vtx_out_y;
	highp ivec3 msb;
	highp ivec3 lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 x;
	highp ivec3 y;
};
struct Outputs
{
	highp ivec3 msb;
	highp ivec3 lsb;
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
	ivec3 x = ivec3(inputs[invocationId].x);
	ivec3 y = ivec3(inputs[invocationId].y);
	ivec3 msb;
	ivec3 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec3 x;
	highp ivec3 y;
};
struct Outputs
{
	highp ivec3 msb;
	highp ivec3 lsb;
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
	ivec3 x = ivec3(inputs[invocationId].x);
	ivec3 y = ivec3(inputs[invocationId].y);
	ivec3 msb;
	ivec3 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 x;
	highp ivec3 y;
};
struct Outputs
{
	highp ivec3 msb;
	highp ivec3 lsb;
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
	ivec3 x = ivec3(inputs[invocationNdx].x);
	ivec3 y = ivec3(inputs[invocationNdx].y);
	ivec3 msb;
	ivec3 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_x;
layout(location = 2) in highp ivec4 a_y;
layout(location = 0) flat out highp ivec4 vtx_out_msb;
layout(location = 1) flat out highp ivec4 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 x = a_x;
	highp ivec4 y = a_y;
	highp ivec4 msb;
	highp ivec4 lsb;
	imulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_msb;
layout(location = 1) flat in highp ivec4 vtx_out_lsb;
layout(location = 0) out highp ivec4 o_msb;
layout(location = 1) out highp ivec4 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_x;
layout(location = 0) flat out highp ivec4 vtx_out_x;
layout(location = 2) in highp ivec4 a_y;
layout(location = 1) flat out highp ivec4 vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_x[];
layout(location = 1) flat in highp ivec4 vtx_out_y[];
layout(location = 0) flat out highp ivec4 geom_out_msb;
layout(location = 1) flat out highp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 x = vtx_out_x[0];
	highp ivec4 y = vtx_out_y[0];
	highp ivec4 msb;
	highp ivec4 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_x[];
layout(location = 1) flat in highp ivec4 vtx_out_y[];
layout(location = 0) flat out highp ivec4 geom_out_msb;
layout(location = 1) flat out highp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 x = vtx_out_x[0];
	highp ivec4 y = vtx_out_y[0];
	highp ivec4 msb;
	highp ivec4 lsb;

	imulExtended(x, y, msb, lsb);
	geom_out_msb = msb;
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec4 geom_out_msb;
layout(location = 1) flat in highp ivec4 geom_out_lsb;
layout(location = 0) out highp ivec4 o_msb;
layout(location = 1) out highp ivec4 o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_x;
layout(location = 1) flat in highp ivec4 vtx_out_y;
layout(location = 0) out highp ivec4 o_msb;
layout(location = 1) out highp ivec4 o_lsb;

void main (void)
{
	highp ivec4 x = vtx_out_x;
	highp ivec4 y = vtx_out_y;
	highp ivec4 msb;
	highp ivec4 lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 x;
	highp ivec4 y;
};
struct Outputs
{
	highp ivec4 msb;
	highp ivec4 lsb;
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
	ivec4 x = ivec4(inputs[invocationId].x);
	ivec4 y = ivec4(inputs[invocationId].y);
	ivec4 msb;
	ivec4 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 x;
	highp ivec4 y;
};
struct Outputs
{
	highp ivec4 msb;
	highp ivec4 lsb;
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
	ivec4 x = ivec4(inputs[invocationId].x);
	ivec4 y = ivec4(inputs[invocationId].y);
	ivec4 msb;
	ivec4 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 x;
	highp ivec4 y;
};
struct Outputs
{
	highp ivec4 msb;
	highp ivec4 lsb;
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
	ivec4 x = ivec4(inputs[invocationNdx].x);
	ivec4 y = ivec4(inputs[invocationNdx].y);
	ivec4 msb;
	ivec4 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> x;
	highp vector<int, 5> y;
};
struct Outputs
{
	highp vector<int, 5> msb;
	highp vector<int, 5> lsb;
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
	vector<int, 5> x = vector<int, 5>(inputs[invocationNdx].x);
	vector<int, 5> y = vector<int, 5>(inputs[invocationNdx].y);
	vector<int, 5> msb;
	vector<int, 5> lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationNdx].msb = msb;
	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump int vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump int value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump int extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_extracted;
layout(location = 0) out mediump int o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 0) flat out mediump int vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump int geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump int extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump int geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump int value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump int extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump int geom_out_extracted;
layout(location = 0) out mediump int o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump int o_extracted;

void main (void)
{
	mediump int value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump int extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump int value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump int extracted;
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
	int value = int(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump int value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump int extracted;
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
	int value = int(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump int extracted;
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
	int value = int(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	int extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp int vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp int extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp int vtx_out_extracted;
layout(location = 0) out highp int o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 0) flat out highp int vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp int geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp int extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp int geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp int extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp int geom_out_extracted;
layout(location = 0) out highp int o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp int vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp int o_extracted;

void main (void)
{
	highp int value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp int extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp int extracted;
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
	int value = int(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp int extracted;
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
	int value = int(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp int extracted;
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
	int value = int(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	int extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump ivec2 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec2 value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump ivec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_extracted;
layout(location = 0) out mediump ivec2 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_value;
layout(location = 0) flat out mediump ivec2 vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec2 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec2 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec2 geom_out_extracted;
layout(location = 0) out mediump ivec2 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump ivec2 o_extracted;

void main (void)
{
	mediump ivec2 value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump ivec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec2 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec2 extracted;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec2 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec2 extracted;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec2 extracted;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp ivec2 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp ivec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_extracted;
layout(location = 0) out highp ivec2 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_value;
layout(location = 0) flat out highp ivec2 vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec2 geom_out_extracted;
layout(location = 0) out highp ivec2 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec2 o_extracted;

void main (void)
{
	highp ivec2 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec2 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec2 extracted;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec2 extracted;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec2 extracted;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump ivec3 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec3 value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump ivec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_extracted;
layout(location = 0) out mediump ivec3 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 0) flat out mediump ivec3 vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec3 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec3 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec3 geom_out_extracted;
layout(location = 0) out mediump ivec3 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump ivec3 o_extracted;

void main (void)
{
	mediump ivec3 value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump ivec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec3 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec3 extracted;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec3 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec3 extracted;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec3 extracted;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp ivec3 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp ivec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_extracted;
layout(location = 0) out highp ivec3 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 0) flat out highp ivec3 vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec3 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec3 geom_out_extracted;
layout(location = 0) out highp ivec3 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec3 o_extracted;

void main (void)
{
	highp ivec3 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec3 extracted;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec3 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec3 extracted;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec3 extracted;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump ivec4 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec4 value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump ivec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_extracted;
layout(location = 0) out mediump ivec4 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 0) flat out mediump ivec4 vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec4 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec4 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec4 geom_out_extracted;
layout(location = 0) out mediump ivec4 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump ivec4 o_extracted;

void main (void)
{
	mediump ivec4 value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump ivec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec4 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec4 extracted;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec4 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec4 extracted;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec4 extracted;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp ivec4 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp ivec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_extracted;
layout(location = 0) out highp ivec4 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out highp ivec4 vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec4 geom_out_extracted;
layout(location = 0) out highp ivec4 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec4 o_extracted;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec4 extracted;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec4 extracted;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec4 extracted;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump vector<int, 5> extracted;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<int, 5> extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp vector<int, 5> extracted;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<int, 5> extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump uint vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uint extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_extracted;
layout(location = 0) out mediump uint o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out mediump uint vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uint geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uint extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uint geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uint extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint geom_out_extracted;
layout(location = 0) out mediump uint o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uint o_extracted;

void main (void)
{
	mediump uint value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uint extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uint value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uint extracted;
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
	uint value = uint(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uint extracted;
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
	uint value = uint(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uint extracted;
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
	uint value = uint(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uint extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp uint vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uint extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_extracted;
layout(location = 0) out highp uint o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 0) flat out highp uint vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uint geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uint extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uint geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uint extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint geom_out_extracted;
layout(location = 0) out highp uint o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp uint o_extracted;

void main (void)
{
	highp uint value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uint extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uint extracted;
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
	uint value = uint(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uint extracted;
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
	uint value = uint(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uint extracted;
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
	uint value = uint(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uint extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump uvec2 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uvec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_extracted;
layout(location = 0) out mediump uvec2 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 0) flat out mediump uvec2 vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 geom_out_extracted;
layout(location = 0) out mediump uvec2 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uvec2 o_extracted;

void main (void)
{
	mediump uvec2 value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uvec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec2 extracted;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec2 extracted;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec2 extracted;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp uvec2 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uvec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_extracted;
layout(location = 0) out highp uvec2 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_value;
layout(location = 0) flat out highp uvec2 vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec2 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 geom_out_extracted;
layout(location = 0) out highp uvec2 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp uvec2 o_extracted;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uvec2 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec2 extracted;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec2 extracted;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec2 extracted;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec2 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump uvec3 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uvec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_extracted;
layout(location = 0) out mediump uvec3 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_value;
layout(location = 0) flat out mediump uvec3 vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 geom_out_extracted;
layout(location = 0) out mediump uvec3 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uvec3 o_extracted;

void main (void)
{
	mediump uvec3 value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uvec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec3 extracted;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec3 extracted;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec3 extracted;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp uvec3 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uvec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_extracted;
layout(location = 0) out highp uvec3 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 0) flat out highp uvec3 vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 geom_out_extracted;
layout(location = 0) out highp uvec3 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp uvec3 o_extracted;

void main (void)
{
	highp uvec3 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uvec3 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec3 extracted;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec3 extracted;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec3 extracted;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump uvec4 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uvec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_extracted;
layout(location = 0) out mediump uvec4 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_value;
layout(location = 0) flat out mediump uvec4 vtx_out_value;
layout(location = 2) in mediump int a_offset;
layout(location = 1) flat out mediump int vtx_out_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 2) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 geom_out_extracted;
layout(location = 0) out mediump uvec4 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uvec4 o_extracted;

void main (void)
{
	mediump uvec4 value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uvec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec4 extracted;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec4 extracted;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec4 extracted;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp uvec4 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uvec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_extracted;
layout(location = 0) out highp uvec4 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_value;
layout(location = 0) flat out highp uvec4 vtx_out_value;
layout(location = 2) in highp int a_offset;
layout(location = 1) flat out highp int vtx_out_offset;
layout(location = 3) in highp int a_bits;
layout(location = 2) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec4 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 geom_out_extracted;
layout(location = 0) out highp uvec4 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp uvec4 o_extracted;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uvec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec4 extracted;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec4 extracted;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec4 extracted;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> value;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump vector<uint, 5> extracted;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<uint, 5> extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp vector<uint, 5> extracted;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<uint, 5> extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationNdx].extracted = extracted;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_base;
layout(location = 2) in mediump int a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump int vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump int base = a_base;
	mediump int insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump int result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_result;
layout(location = 0) out mediump int o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_base;
layout(location = 0) flat out mediump int vtx_out_base;
layout(location = 2) in mediump int a_insert;
layout(location = 1) flat out mediump int vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_base[];
layout(location = 1) flat in mediump int vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int base = vtx_out_base[0];
	mediump int insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump int result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_base[];
layout(location = 1) flat in mediump int vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump int base = vtx_out_base[0];
	mediump int insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump int result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump int geom_out_result;
layout(location = 0) out mediump int o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_base;
layout(location = 1) flat in mediump int vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump int o_result;

void main (void)
{
	mediump int base = vtx_out_base;
	mediump int insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump int result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump int base;
	mediump int insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump int result;
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
	int base = int(inputs[invocationId].base);
	int insert = int(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump int base;
	mediump int insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump int result;
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
	int base = int(inputs[invocationId].base);
	int insert = int(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int base;
	mediump int insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump int result;
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
	int base = int(inputs[invocationNdx].base);
	int insert = int(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	int result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_base;
layout(location = 2) in highp int a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp int vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int base = a_base;
	highp int insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp int result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp int vtx_out_result;
layout(location = 0) out highp int o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_base;
layout(location = 0) flat out highp int vtx_out_base;
layout(location = 2) in highp int a_insert;
layout(location = 1) flat out highp int vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_base[];
layout(location = 1) flat in highp int vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int base = vtx_out_base[0];
	highp int insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp int result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_base[];
layout(location = 1) flat in highp int vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int base = vtx_out_base[0];
	highp int insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp int result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp int geom_out_result;
layout(location = 0) out highp int o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp int vtx_out_base;
layout(location = 1) flat in highp int vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp int o_result;

void main (void)
{
	highp int base = vtx_out_base;
	highp int insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp int result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int base;
	highp int insert;
	highp int offset;
	highp int bits;
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
	int base = int(inputs[invocationId].base);
	int insert = int(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int base;
	highp int insert;
	highp int offset;
	highp int bits;
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
	int base = int(inputs[invocationId].base);
	int insert = int(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	int result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int base;
	highp int insert;
	highp int offset;
	highp int bits;
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
	int base = int(inputs[invocationNdx].base);
	int insert = int(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	int result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_base;
layout(location = 2) in mediump ivec2 a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump ivec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec2 base = a_base;
	mediump ivec2 insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump ivec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_result;
layout(location = 0) out mediump ivec2 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_base;
layout(location = 0) flat out mediump ivec2 vtx_out_base;
layout(location = 2) in mediump ivec2 a_insert;
layout(location = 1) flat out mediump ivec2 vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_base[];
layout(location = 1) flat in mediump ivec2 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec2 base = vtx_out_base[0];
	mediump ivec2 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_base[];
layout(location = 1) flat in mediump ivec2 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec2 base = vtx_out_base[0];
	mediump ivec2 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec2 geom_out_result;
layout(location = 0) out mediump ivec2 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_base;
layout(location = 1) flat in mediump ivec2 vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump ivec2 o_result;

void main (void)
{
	mediump ivec2 base = vtx_out_base;
	mediump ivec2 insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump ivec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec2 base;
	mediump ivec2 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec2 result;
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
	ivec2 base = ivec2(inputs[invocationId].base);
	ivec2 insert = ivec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec2 base;
	mediump ivec2 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec2 result;
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
	ivec2 base = ivec2(inputs[invocationId].base);
	ivec2 insert = ivec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 base;
	mediump ivec2 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec2 result;
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
	ivec2 base = ivec2(inputs[invocationNdx].base);
	ivec2 insert = ivec2(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_base;
layout(location = 2) in highp ivec2 a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp ivec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 base = a_base;
	highp ivec2 insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp ivec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_result;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_base;
layout(location = 0) flat out highp ivec2 vtx_out_base;
layout(location = 2) in highp ivec2 a_insert;
layout(location = 1) flat out highp ivec2 vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_base[];
layout(location = 1) flat in highp ivec2 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 base = vtx_out_base[0];
	highp ivec2 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_base[];
layout(location = 1) flat in highp ivec2 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 base = vtx_out_base[0];
	highp ivec2 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec2 geom_out_result;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_base;
layout(location = 1) flat in highp ivec2 vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	highp ivec2 base = vtx_out_base;
	highp ivec2 insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec2 base;
	highp ivec2 insert;
	highp int offset;
	highp int bits;
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
	ivec2 base = ivec2(inputs[invocationId].base);
	ivec2 insert = ivec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 base;
	highp ivec2 insert;
	highp int offset;
	highp int bits;
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
	ivec2 base = ivec2(inputs[invocationId].base);
	ivec2 insert = ivec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 base;
	highp ivec2 insert;
	highp int offset;
	highp int bits;
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
	ivec2 base = ivec2(inputs[invocationNdx].base);
	ivec2 insert = ivec2(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_base;
layout(location = 2) in mediump ivec3 a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump ivec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec3 base = a_base;
	mediump ivec3 insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump ivec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_result;
layout(location = 0) out mediump ivec3 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_base;
layout(location = 0) flat out mediump ivec3 vtx_out_base;
layout(location = 2) in mediump ivec3 a_insert;
layout(location = 1) flat out mediump ivec3 vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_base[];
layout(location = 1) flat in mediump ivec3 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec3 base = vtx_out_base[0];
	mediump ivec3 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_base[];
layout(location = 1) flat in mediump ivec3 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec3 base = vtx_out_base[0];
	mediump ivec3 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec3 geom_out_result;
layout(location = 0) out mediump ivec3 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_base;
layout(location = 1) flat in mediump ivec3 vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump ivec3 o_result;

void main (void)
{
	mediump ivec3 base = vtx_out_base;
	mediump ivec3 insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump ivec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec3 base;
	mediump ivec3 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec3 result;
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
	ivec3 base = ivec3(inputs[invocationId].base);
	ivec3 insert = ivec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec3 base;
	mediump ivec3 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec3 result;
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
	ivec3 base = ivec3(inputs[invocationId].base);
	ivec3 insert = ivec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 base;
	mediump ivec3 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec3 result;
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
	ivec3 base = ivec3(inputs[invocationNdx].base);
	ivec3 insert = ivec3(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_base;
layout(location = 2) in highp ivec3 a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp ivec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 base = a_base;
	highp ivec3 insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp ivec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_result;
layout(location = 0) out highp ivec3 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_base;
layout(location = 0) flat out highp ivec3 vtx_out_base;
layout(location = 2) in highp ivec3 a_insert;
layout(location = 1) flat out highp ivec3 vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_base[];
layout(location = 1) flat in highp ivec3 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 base = vtx_out_base[0];
	highp ivec3 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_base[];
layout(location = 1) flat in highp ivec3 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec3 base = vtx_out_base[0];
	highp ivec3 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec3 geom_out_result;
layout(location = 0) out highp ivec3 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_base;
layout(location = 1) flat in highp ivec3 vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec3 o_result;

void main (void)
{
	highp ivec3 base = vtx_out_base;
	highp ivec3 insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 base;
	highp ivec3 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 base = ivec3(inputs[invocationId].base);
	ivec3 insert = ivec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec3 base;
	highp ivec3 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 base = ivec3(inputs[invocationId].base);
	ivec3 insert = ivec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 base;
	highp ivec3 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 base = ivec3(inputs[invocationNdx].base);
	ivec3 insert = ivec3(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_base;
layout(location = 2) in mediump ivec4 a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump ivec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec4 base = a_base;
	mediump ivec4 insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump ivec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_result;
layout(location = 0) out mediump ivec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_base;
layout(location = 0) flat out mediump ivec4 vtx_out_base;
layout(location = 2) in mediump ivec4 a_insert;
layout(location = 1) flat out mediump ivec4 vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_base[];
layout(location = 1) flat in mediump ivec4 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec4 base = vtx_out_base[0];
	mediump ivec4 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_base[];
layout(location = 1) flat in mediump ivec4 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec4 base = vtx_out_base[0];
	mediump ivec4 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec4 geom_out_result;
layout(location = 0) out mediump ivec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_base;
layout(location = 1) flat in mediump ivec4 vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump ivec4 o_result;

void main (void)
{
	mediump ivec4 base = vtx_out_base;
	mediump ivec4 insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump ivec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec4 base;
	mediump ivec4 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec4 result;
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
	ivec4 base = ivec4(inputs[invocationId].base);
	ivec4 insert = ivec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec4 base;
	mediump ivec4 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec4 result;
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
	ivec4 base = ivec4(inputs[invocationId].base);
	ivec4 insert = ivec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 base;
	mediump ivec4 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump ivec4 result;
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
	ivec4 base = ivec4(inputs[invocationNdx].base);
	ivec4 insert = ivec4(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_base;
layout(location = 2) in highp ivec4 a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp ivec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 base = a_base;
	highp ivec4 insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp ivec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_result;
layout(location = 0) out highp ivec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_base;
layout(location = 0) flat out highp ivec4 vtx_out_base;
layout(location = 2) in highp ivec4 a_insert;
layout(location = 1) flat out highp ivec4 vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_base[];
layout(location = 1) flat in highp ivec4 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 base = vtx_out_base[0];
	highp ivec4 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_base[];
layout(location = 1) flat in highp ivec4 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 base = vtx_out_base[0];
	highp ivec4 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec4 geom_out_result;
layout(location = 0) out highp ivec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_base;
layout(location = 1) flat in highp ivec4 vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec4 o_result;

void main (void)
{
	highp ivec4 base = vtx_out_base;
	highp ivec4 insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 base;
	highp ivec4 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 base = ivec4(inputs[invocationId].base);
	ivec4 insert = ivec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 base;
	highp ivec4 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 base = ivec4(inputs[invocationId].base);
	ivec4 insert = ivec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 base;
	highp ivec4 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 base = ivec4(inputs[invocationNdx].base);
	ivec4 insert = ivec4(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> base;
	mediump vector<int, 5> insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump vector<int, 5> result;
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
	vector<int, 5> base = vector<int, 5>(inputs[invocationNdx].base);
	vector<int, 5> insert = vector<int, 5>(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<int, 5> result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> base;
	highp vector<int, 5> insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp vector<int, 5> result;
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
	vector<int, 5> base = vector<int, 5>(inputs[invocationNdx].base);
	vector<int, 5> insert = vector<int, 5>(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<int, 5> result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_base;
layout(location = 2) in mediump uint a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump uint vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint base = a_base;
	mediump uint insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uint result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_result;
layout(location = 0) out mediump uint o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_base;
layout(location = 0) flat out mediump uint vtx_out_base;
layout(location = 2) in mediump uint a_insert;
layout(location = 1) flat out mediump uint vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_base[];
layout(location = 1) flat in mediump uint vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint base = vtx_out_base[0];
	mediump uint insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uint result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_base[];
layout(location = 1) flat in mediump uint vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint base = vtx_out_base[0];
	mediump uint insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uint result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint geom_out_result;
layout(location = 0) out mediump uint o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_base;
layout(location = 1) flat in mediump uint vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uint o_result;

void main (void)
{
	mediump uint base = vtx_out_base;
	mediump uint insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uint result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uint base;
	mediump uint insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uint result;
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
	uint base = uint(inputs[invocationId].base);
	uint insert = uint(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint base;
	mediump uint insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uint result;
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
	uint base = uint(inputs[invocationId].base);
	uint insert = uint(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint base;
	mediump uint insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uint result;
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
	uint base = uint(inputs[invocationNdx].base);
	uint insert = uint(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uint result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_base;
layout(location = 2) in highp uint a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp uint vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint base = a_base;
	highp uint insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uint result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_result;
layout(location = 0) out highp uint o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_base;
layout(location = 0) flat out highp uint vtx_out_base;
layout(location = 2) in highp uint a_insert;
layout(location = 1) flat out highp uint vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_base[];
layout(location = 1) flat in highp uint vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint base = vtx_out_base[0];
	highp uint insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uint result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_base[];
layout(location = 1) flat in highp uint vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint base = vtx_out_base[0];
	highp uint insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uint result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint geom_out_result;
layout(location = 0) out highp uint o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp uint vtx_out_base;
layout(location = 1) flat in highp uint vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp uint o_result;

void main (void)
{
	highp uint base = vtx_out_base;
	highp uint insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uint result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint base;
	highp uint insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uint result;
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
	uint base = uint(inputs[invocationId].base);
	uint insert = uint(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint base;
	highp uint insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uint result;
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
	uint base = uint(inputs[invocationId].base);
	uint insert = uint(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint base;
	highp uint insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uint result;
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
	uint base = uint(inputs[invocationNdx].base);
	uint insert = uint(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uint result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_base;
layout(location = 2) in mediump uvec2 a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump uvec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 base = a_base;
	mediump uvec2 insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uvec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_result;
layout(location = 0) out mediump uvec2 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_base;
layout(location = 0) flat out mediump uvec2 vtx_out_base;
layout(location = 2) in mediump uvec2 a_insert;
layout(location = 1) flat out mediump uvec2 vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_base[];
layout(location = 1) flat in mediump uvec2 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 base = vtx_out_base[0];
	mediump uvec2 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_base[];
layout(location = 1) flat in mediump uvec2 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 base = vtx_out_base[0];
	mediump uvec2 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 geom_out_result;
layout(location = 0) out mediump uvec2 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_base;
layout(location = 1) flat in mediump uvec2 vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uvec2 o_result;

void main (void)
{
	mediump uvec2 base = vtx_out_base;
	mediump uvec2 insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uvec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 base;
	mediump uvec2 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec2 result;
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
	uvec2 base = uvec2(inputs[invocationId].base);
	uvec2 insert = uvec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 base;
	mediump uvec2 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec2 result;
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
	uvec2 base = uvec2(inputs[invocationId].base);
	uvec2 insert = uvec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 base;
	mediump uvec2 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec2 result;
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
	uvec2 base = uvec2(inputs[invocationNdx].base);
	uvec2 insert = uvec2(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_base;
layout(location = 2) in highp uvec2 a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp uvec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 base = a_base;
	highp uvec2 insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uvec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_result;
layout(location = 0) out highp uvec2 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_base;
layout(location = 0) flat out highp uvec2 vtx_out_base;
layout(location = 2) in highp uvec2 a_insert;
layout(location = 1) flat out highp uvec2 vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_base[];
layout(location = 1) flat in highp uvec2 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 base = vtx_out_base[0];
	highp uvec2 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_base[];
layout(location = 1) flat in highp uvec2 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 base = vtx_out_base[0];
	highp uvec2 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 geom_out_result;
layout(location = 0) out highp uvec2 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_base;
layout(location = 1) flat in highp uvec2 vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp uvec2 o_result;

void main (void)
{
	highp uvec2 base = vtx_out_base;
	highp uvec2 insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uvec2 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 base;
	highp uvec2 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 base = uvec2(inputs[invocationId].base);
	uvec2 insert = uvec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 base;
	highp uvec2 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 base = uvec2(inputs[invocationId].base);
	uvec2 insert = uvec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 base;
	highp uvec2 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 base = uvec2(inputs[invocationNdx].base);
	uvec2 insert = uvec2(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_base;
layout(location = 2) in mediump uvec3 a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump uvec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 base = a_base;
	mediump uvec3 insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uvec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_result;
layout(location = 0) out mediump uvec3 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_base;
layout(location = 0) flat out mediump uvec3 vtx_out_base;
layout(location = 2) in mediump uvec3 a_insert;
layout(location = 1) flat out mediump uvec3 vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_base[];
layout(location = 1) flat in mediump uvec3 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 base = vtx_out_base[0];
	mediump uvec3 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_base[];
layout(location = 1) flat in mediump uvec3 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 base = vtx_out_base[0];
	mediump uvec3 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 geom_out_result;
layout(location = 0) out mediump uvec3 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_base;
layout(location = 1) flat in mediump uvec3 vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uvec3 o_result;

void main (void)
{
	mediump uvec3 base = vtx_out_base;
	mediump uvec3 insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uvec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 base;
	mediump uvec3 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec3 result;
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
	uvec3 base = uvec3(inputs[invocationId].base);
	uvec3 insert = uvec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 base;
	mediump uvec3 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec3 result;
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
	uvec3 base = uvec3(inputs[invocationId].base);
	uvec3 insert = uvec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 base;
	mediump uvec3 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec3 result;
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
	uvec3 base = uvec3(inputs[invocationNdx].base);
	uvec3 insert = uvec3(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_base;
layout(location = 2) in highp uvec3 a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp uvec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 base = a_base;
	highp uvec3 insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uvec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_result;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_base;
layout(location = 0) flat out highp uvec3 vtx_out_base;
layout(location = 2) in highp uvec3 a_insert;
layout(location = 1) flat out highp uvec3 vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_base[];
layout(location = 1) flat in highp uvec3 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 base = vtx_out_base[0];
	highp uvec3 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_base[];
layout(location = 1) flat in highp uvec3 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 base = vtx_out_base[0];
	highp uvec3 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 geom_out_result;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_base;
layout(location = 1) flat in highp uvec3 vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	highp uvec3 base = vtx_out_base;
	highp uvec3 insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uvec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 base;
	highp uvec3 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 base = uvec3(inputs[invocationId].base);
	uvec3 insert = uvec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 base;
	highp uvec3 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 base = uvec3(inputs[invocationId].base);
	uvec3 insert = uvec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 base;
	highp uvec3 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 base = uvec3(inputs[invocationNdx].base);
	uvec3 insert = uvec3(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_base;
layout(location = 2) in mediump uvec4 a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump uvec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 base = a_base;
	mediump uvec4 insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uvec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_result;
layout(location = 0) out mediump uvec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_base;
layout(location = 0) flat out mediump uvec4 vtx_out_base;
layout(location = 2) in mediump uvec4 a_insert;
layout(location = 1) flat out mediump uvec4 vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_base[];
layout(location = 1) flat in mediump uvec4 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 base = vtx_out_base[0];
	mediump uvec4 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_base[];
layout(location = 1) flat in mediump uvec4 vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 base = vtx_out_base[0];
	mediump uvec4 insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 geom_out_result;
layout(location = 0) out mediump uvec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_base;
layout(location = 1) flat in mediump uvec4 vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uvec4 o_result;

void main (void)
{
	mediump uvec4 base = vtx_out_base;
	mediump uvec4 insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uvec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 base;
	mediump uvec4 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec4 result;
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
	uvec4 base = uvec4(inputs[invocationId].base);
	uvec4 insert = uvec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 base;
	mediump uvec4 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec4 result;
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
	uvec4 base = uvec4(inputs[invocationId].base);
	uvec4 insert = uvec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 base;
	mediump uvec4 insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uvec4 result;
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
	uvec4 base = uvec4(inputs[invocationNdx].base);
	uvec4 insert = uvec4(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_base;
layout(location = 2) in highp uvec4 a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp uvec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 base = a_base;
	highp uvec4 insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uvec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_result;
layout(location = 0) out highp uvec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_base;
layout(location = 0) flat out highp uvec4 vtx_out_base;
layout(location = 2) in highp uvec4 a_insert;
layout(location = 1) flat out highp uvec4 vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_base[];
layout(location = 1) flat in highp uvec4 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 base = vtx_out_base[0];
	highp uvec4 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_base[];
layout(location = 1) flat in highp uvec4 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 base = vtx_out_base[0];
	highp uvec4 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 geom_out_result;
layout(location = 0) out highp uvec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_base;
layout(location = 1) flat in highp uvec4 vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp uvec4 o_result;

void main (void)
{
	highp uvec4 base = vtx_out_base;
	highp uvec4 insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uvec4 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 base;
	highp uvec4 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 base = uvec4(inputs[invocationId].base);
	uvec4 insert = uvec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 base;
	highp uvec4 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 base = uvec4(inputs[invocationId].base);
	uvec4 insert = uvec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 base;
	highp uvec4 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 base = uvec4(inputs[invocationNdx].base);
	uvec4 insert = uvec4(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	uvec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> base;
	mediump vector<uint, 5> insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump vector<uint, 5> result;
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
	vector<uint, 5> base = vector<uint, 5>(inputs[invocationNdx].base);
	vector<uint, 5> insert = vector<uint, 5>(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<uint, 5> result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> base;
	highp vector<uint, 5> insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp vector<uint, 5> result;
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
	vector<uint, 5> base = vector<uint, 5>(inputs[invocationNdx].base);
	vector<uint, 5> insert = vector<uint, 5>(inputs[invocationNdx].insert);
	int offset = int(inputs[invocationNdx].offset);
	int bits = int(inputs[invocationNdx].bits);
	vector<uint, 5> result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 0) flat out highp int vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump int value = a_value;
	highp int result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 0) flat out mediump int vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int value = vtx_out_value[0];
	highp int result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump int value = vtx_out_value[0];
	highp int result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 0) out highp int o_result;

void main (void)
{
	mediump int value = vtx_out_value;
	highp int result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump int value;
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
	int value = int(inputs[invocationId].value);
	int result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump int value;
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
	int value = int(inputs[invocationId].value);
	int result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int value;
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
	int value = int(inputs[invocationNdx].value);
	int result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 0) flat out highp int vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int value = a_value;
	highp int result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 0) flat out highp int vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int value = vtx_out_value[0];
	highp int result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int value = vtx_out_value[0];
	highp int result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp int vtx_out_value;
layout(location = 0) out highp int o_result;

void main (void)
{
	highp int value = vtx_out_value;
	highp int result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int value;
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
	int value = int(inputs[invocationId].value);
	int result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int value;
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
	int value = int(inputs[invocationId].value);
	int result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int value;
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
	int value = int(inputs[invocationNdx].value);
	int result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_value;
layout(location = 0) flat out highp ivec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec2 value = a_value;
	highp ivec2 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_value;
layout(location = 0) flat out mediump ivec2 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec2 value = vtx_out_value[0];
	highp ivec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec2 value = vtx_out_value[0];
	highp ivec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_value;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	mediump ivec2 value = vtx_out_value;
	highp ivec2 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec2 value;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec2 value;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 value;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_value;
layout(location = 0) flat out highp ivec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 value = a_value;
	highp ivec2 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_value;
layout(location = 0) flat out highp ivec2 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 value = vtx_out_value[0];
	highp ivec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 value = vtx_out_value[0];
	highp ivec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_value;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	highp ivec2 value = vtx_out_value;
	highp ivec2 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec2 value;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 value;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 value;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 0) flat out highp ivec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec3 value = a_value;
	highp ivec3 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 0) flat out mediump ivec3 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec3 value = vtx_out_value[0];
	highp ivec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec3 value = vtx_out_value[0];
	highp ivec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_value;
layout(location = 0) out highp ivec3 o_result;

void main (void)
{
	mediump ivec3 value = vtx_out_value;
	highp ivec3 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 0) flat out highp ivec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 value = a_value;
	highp ivec3 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 0) flat out highp ivec3 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 value = vtx_out_value[0];
	highp ivec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec3 value = vtx_out_value[0];
	highp ivec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_value;
layout(location = 0) out highp ivec3 o_result;

void main (void)
{
	highp ivec3 value = vtx_out_value;
	highp ivec3 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	highp ivec3 result;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 0) flat out highp ivec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec4 value = a_value;
	highp ivec4 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 0) flat out mediump ivec4 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out highp ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec4 value = vtx_out_value[0];
	highp ivec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out highp ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec4 value = vtx_out_value[0];
	highp ivec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_value;
layout(location = 0) out highp ivec4 o_result;

void main (void)
{
	mediump ivec4 value = vtx_out_value;
	highp ivec4 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out highp ivec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 value = a_value;
	highp ivec4 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out highp ivec4 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out highp ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 value = vtx_out_value[0];
	highp ivec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out highp ivec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 value = vtx_out_value[0];
	highp ivec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 0) out highp ivec4 o_result;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	highp ivec4 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> value;
};
struct Outputs
{
	highp vector<int, 5> result;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> value;
};
struct Outputs
{
	highp vector<int, 5> result;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out highp uint vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint value = a_value;
	highp uint result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out mediump uint vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out highp uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint value = vtx_out_value[0];
	highp uint result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out highp uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint value = vtx_out_value[0];
	highp uint result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_value;
layout(location = 0) out highp uint o_result;

void main (void)
{
	mediump uint value = vtx_out_value;
	highp uint result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	highp uint result;
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
	uint value = uint(inputs[invocationId].value);
	uint result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	highp uint result;
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
	uint value = uint(inputs[invocationId].value);
	uint result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	highp uint result;
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
	uint value = uint(inputs[invocationNdx].value);
	uint result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 0) flat out highp uint vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint value = a_value;
	highp uint result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 0) flat out highp uint vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out highp uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint value = vtx_out_value[0];
	highp uint result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out highp uint geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint value = vtx_out_value[0];
	highp uint result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 0) out highp uint o_result;

void main (void)
{
	highp uint value = vtx_out_value;
	highp uint result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	highp uint result;
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
	uint value = uint(inputs[invocationId].value);
	uint result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	highp uint result;
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
	uint value = uint(inputs[invocationId].value);
	uint result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	highp uint result;
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
	uint value = uint(inputs[invocationNdx].value);
	uint result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 0) flat out highp uvec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 value = a_value;
	highp uvec2 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 0) flat out mediump uvec2 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out highp uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 value = vtx_out_value[0];
	highp uvec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out highp uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 value = vtx_out_value[0];
	highp uvec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_value;
layout(location = 0) out highp uvec2 o_result;

void main (void)
{
	mediump uvec2 value = vtx_out_value;
	highp uvec2 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	uvec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	uvec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	uvec2 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_value;
layout(location = 0) flat out highp uvec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 value = a_value;
	highp uvec2 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_value;
layout(location = 0) flat out highp uvec2 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out highp uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 value = vtx_out_value[0];
	highp uvec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out highp uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 value = vtx_out_value[0];
	highp uvec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 0) out highp uvec2 o_result;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	highp uvec2 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	uvec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	uvec2 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	highp uvec2 result;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	uvec2 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_value;
layout(location = 0) flat out highp uvec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 value = a_value;
	highp uvec3 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_value;
layout(location = 0) flat out mediump uvec3 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out highp uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 value = vtx_out_value[0];
	highp uvec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out highp uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 value = vtx_out_value[0];
	highp uvec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_value;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	mediump uvec3 value = vtx_out_value;
	highp uvec3 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	uvec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	uvec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	uvec3 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 0) flat out highp uvec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 value = a_value;
	highp uvec3 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 0) flat out highp uvec3 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out highp uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 value = vtx_out_value[0];
	highp uvec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out highp uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 value = vtx_out_value[0];
	highp uvec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_value;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	highp uvec3 value = vtx_out_value;
	highp uvec3 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	uvec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	uvec3 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	highp uvec3 result;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	uvec3 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_value;
layout(location = 0) flat out highp uvec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 value = a_value;
	highp uvec4 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_value;
layout(location = 0) flat out mediump uvec4 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out highp uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 value = vtx_out_value[0];
	highp uvec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out highp uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 value = vtx_out_value[0];
	highp uvec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_value;
layout(location = 0) out highp uvec4 o_result;

void main (void)
{
	mediump uvec4 value = vtx_out_value;
	highp uvec4 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	uvec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	uvec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	uvec4 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_value;
layout(location = 0) flat out highp uvec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 value = a_value;
	highp uvec4 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_value;
layout(location = 0) flat out highp uvec4 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out highp uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 value = vtx_out_value[0];
	highp uvec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out highp uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 value = vtx_out_value[0];
	highp uvec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 0) out highp uvec4 o_result;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	highp uvec4 result;
	result = bitfieldReverse(value);
	o_result = result;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	uvec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	uvec4 result;

	result = bitfieldReverse(value);

	outputs[invocationId].result = result;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	highp uvec4 result;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	uvec4 result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> value;
};
struct Outputs
{
	highp vector<uint, 5> result;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<uint, 5> result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> value;
};
struct Outputs
{
	highp vector<uint, 5> result;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<uint, 5> result;

	result = bitfieldReverse(value);

	outputs[invocationNdx].result = result;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 0) flat out mediump int vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump int value = a_value;
	mediump int count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_count;
layout(location = 0) out mediump int o_count;

void main (void)
{
	o_count = vtx_out_count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump int value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump int geom_out_count;
layout(location = 0) out mediump int o_count;

void main (void)
{
	o_count = geom_out_count;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 0) out mediump int o_count;

void main (void)
{
	mediump int value = vtx_out_value;
	mediump int count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	mediump int count;
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
	int value = int(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	mediump int count;
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
	int value = int(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	mediump int count;
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
	int value = int(inputs[invocationNdx].value);
	int count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 0) flat out mediump int vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int value = a_value;
	mediump int count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp int vtx_out_value;
layout(location = 0) out mediump int o_count;

void main (void)
{
	highp int value = vtx_out_value;
	mediump int count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	mediump int count;
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
	int value = int(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	mediump int count;
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
	int value = int(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	mediump int count;
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
	int value = int(inputs[invocationNdx].value);
	int count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_value;
layout(location = 0) flat out mediump ivec2 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec2 value = a_value;
	mediump ivec2 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_count;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	o_count = vtx_out_count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec2 geom_out_count;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	o_count = geom_out_count;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_value;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	mediump ivec2 value = vtx_out_value;
	mediump ivec2 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_value;
layout(location = 0) flat out mediump ivec2 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 value = a_value;
	mediump ivec2 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_value;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	highp ivec2 value = vtx_out_value;
	mediump ivec2 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 0) flat out mediump ivec3 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec3 value = a_value;
	mediump ivec3 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_count;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	o_count = vtx_out_count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec3 geom_out_count;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	o_count = geom_out_count;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_value;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	mediump ivec3 value = vtx_out_value;
	mediump ivec3 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 0) flat out mediump ivec3 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 value = a_value;
	mediump ivec3 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_value;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	highp ivec3 value = vtx_out_value;
	mediump ivec3 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 0) flat out mediump ivec4 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec4 value = a_value;
	mediump ivec4 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_count;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	o_count = vtx_out_count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump ivec4 geom_out_count;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	o_count = geom_out_count;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_value;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	mediump ivec4 value = vtx_out_value;
	mediump ivec4 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out mediump ivec4 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 value = a_value;
	mediump ivec4 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	mediump ivec4 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> value;
};
struct Outputs
{
	mediump vector<int, 5> count;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> value;
};
struct Outputs
{
	mediump vector<int, 5> count;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out mediump int vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint value = a_value;
	mediump int count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_value;
layout(location = 0) out mediump int o_count;

void main (void)
{
	mediump uint value = vtx_out_value;
	mediump int count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	mediump int count;
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
	uint value = uint(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	mediump int count;
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
	uint value = uint(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	mediump int count;
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
	uint value = uint(inputs[invocationNdx].value);
	int count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 0) flat out mediump int vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint value = a_value;
	mediump int count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out mediump int geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint value = vtx_out_value[0];
	mediump int count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 0) out mediump int o_count;

void main (void)
{
	highp uint value = vtx_out_value;
	mediump int count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	mediump int count;
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
	uint value = uint(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	mediump int count;
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
	uint value = uint(inputs[invocationId].value);
	int count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	mediump int count;
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
	uint value = uint(inputs[invocationNdx].value);
	int count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 0) flat out mediump ivec2 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 value = a_value;
	mediump ivec2 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_value;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	mediump uvec2 value = vtx_out_value;
	mediump ivec2 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_value;
layout(location = 0) flat out mediump ivec2 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 value = a_value;
	mediump ivec2 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	mediump ivec2 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	mediump ivec2 count;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	ivec2 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_value;
layout(location = 0) flat out mediump ivec3 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 value = a_value;
	mediump ivec3 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_value;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	mediump uvec3 value = vtx_out_value;
	mediump ivec3 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 0) flat out mediump ivec3 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 value = a_value;
	mediump ivec3 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_value;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	highp uvec3 value = vtx_out_value;
	mediump ivec3 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	mediump ivec3 count;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	ivec3 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_value;
layout(location = 0) flat out mediump ivec4 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 value = a_value;
	mediump ivec4 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_value;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	mediump uvec4 value = vtx_out_value;
	mediump ivec4 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_value;
layout(location = 0) flat out mediump ivec4 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 value = a_value;
	mediump ivec4 count;
	count = bitCount(value);
	vtx_out_count = count;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	mediump ivec4 count;
	count = bitCount(value);
	o_count = count;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationId].count = count;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	mediump ivec4 count;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	ivec4 count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> value;
};
struct Outputs
{
	mediump vector<int, 5> count;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<int, 5> count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> value;
};
struct Outputs
{
	mediump vector<int, 5> count;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<int, 5> count;

	count = bitCount(value);

	outputs[invocationNdx].count = count;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 0) flat out lowp int vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump int value = a_value;
	lowp int lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in lowp int vtx_out_lsb;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump int value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp int geom_out_lsb;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	mediump int value = vtx_out_value;
	lowp int lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	lowp int lsb;
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
	int value = int(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	lowp int lsb;
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
	int value = int(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	lowp int lsb;
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
	int value = int(inputs[invocationNdx].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 0) flat out lowp int vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int value = a_value;
	lowp int lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp int vtx_out_value;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	highp int value = vtx_out_value;
	lowp int lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	lowp int lsb;
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
	int value = int(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	lowp int lsb;
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
	int value = int(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	lowp int lsb;
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
	int value = int(inputs[invocationNdx].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec2 value = a_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in lowp ivec2 vtx_out_lsb;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp ivec2 geom_out_lsb;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	mediump ivec2 value = vtx_out_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 value = a_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	highp ivec2 value = vtx_out_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec3 value = a_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in lowp ivec3 vtx_out_lsb;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp ivec3 geom_out_lsb;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	mediump ivec3 value = vtx_out_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 value = a_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	highp ivec3 value = vtx_out_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec4 value = a_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(location = 0) flat in lowp ivec4 vtx_out_lsb;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	o_lsb = vtx_out_lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp ivec4 geom_out_lsb;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	o_lsb = geom_out_lsb;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	mediump ivec4 value = vtx_out_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 value = a_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> lsb;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> lsb;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out lowp int vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint value = a_value;
	lowp int lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_value;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	mediump uint value = vtx_out_value;
	lowp int lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	lowp int lsb;
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
	uint value = uint(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	lowp int lsb;
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
	uint value = uint(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	lowp int lsb;
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
	uint value = uint(inputs[invocationNdx].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 0) flat out lowp int vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint value = a_value;
	lowp int lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	highp uint value = vtx_out_value;
	lowp int lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	lowp int lsb;
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
	uint value = uint(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	lowp int lsb;
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
	uint value = uint(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	lowp int lsb;
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
	uint value = uint(inputs[invocationNdx].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 value = a_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	mediump uvec2 value = vtx_out_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 value = a_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 value = vtx_out_value[0];
	lowp ivec2 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	lowp ivec2 lsb;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	ivec2 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 value = a_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	mediump uvec3 value = vtx_out_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 value = a_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	highp uvec3 value = vtx_out_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	lowp ivec3 lsb;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	ivec3 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 value = a_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	mediump uvec4 value = vtx_out_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 value = a_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	lowp ivec4 lsb;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	ivec4 lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> lsb;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<int, 5> lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> lsb;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<int, 5> lsb;

	lsb = findLSB(value);

	outputs[invocationNdx].lsb = lsb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 0) flat out lowp int vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump int value = a_value;
	lowp int msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(location = 0) flat in lowp int vtx_out_msb;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	o_msb = vtx_out_msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump int value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp int geom_out_msb;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	o_msb = geom_out_msb;
}
#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	mediump int value = vtx_out_value;
	lowp int msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	lowp int msb;
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
	int value = int(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	lowp int msb;
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
	int value = int(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump int value;
};
struct Outputs
{
	lowp int msb;
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
	int value = int(inputs[invocationNdx].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 0) flat out lowp int vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int value = a_value;
	lowp int msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp int vtx_out_value;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	highp int value = vtx_out_value;
	lowp int msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	lowp int msb;
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
	int value = int(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	lowp int msb;
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
	int value = int(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	lowp int msb;
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
	int value = int(inputs[invocationNdx].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec2 value = a_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(location = 0) flat in lowp ivec2 vtx_out_msb;
layout(location = 0) out lowp ivec2 o_msb;

void main (void)
{
	o_msb = vtx_out_msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp ivec2 geom_out_msb;
layout(location = 0) out lowp ivec2 o_msb;

void main (void)
{
	o_msb = geom_out_msb;
}
#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_msb;

void main (void)
{
	mediump ivec2 value = vtx_out_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 value = a_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_msb;

void main (void)
{
	highp ivec2 value = vtx_out_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	ivec2 value = ivec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	ivec2 value = ivec2(inputs[invocationNdx].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec3 value = a_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(location = 0) flat in lowp ivec3 vtx_out_msb;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	o_msb = vtx_out_msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp ivec3 geom_out_msb;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	o_msb = geom_out_msb;
}
#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	mediump ivec3 value = vtx_out_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 value = a_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	highp ivec3 value = vtx_out_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	ivec3 value = ivec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	ivec3 value = ivec3(inputs[invocationNdx].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec4 value = a_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(location = 0) flat in lowp ivec4 vtx_out_msb;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	o_msb = vtx_out_msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in lowp ivec4 geom_out_msb;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	o_msb = geom_out_msb;
}
#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	mediump ivec4 value = vtx_out_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 value = a_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp ivec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	ivec4 value = ivec4(inputs[invocationNdx].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<int, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> msb;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<int, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> msb;
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
	vector<int, 5> value = vector<int, 5>(inputs[invocationNdx].value);
	vector<int, 5> msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out lowp int vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint value = a_value;
	lowp int msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uint value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uint vtx_out_value;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	mediump uint value = vtx_out_value;
	lowp int msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	lowp int msb;
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
	uint value = uint(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	lowp int msb;
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
	uint value = uint(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uint value;
};
struct Outputs
{
	lowp int msb;
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
	uint value = uint(inputs[invocationNdx].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 0) flat out lowp int vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint value = a_value;
	lowp int msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uint vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint value = vtx_out_value[0];
	lowp int msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	highp uint value = vtx_out_value;
	lowp int msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	lowp int msb;
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
	uint value = uint(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	lowp int msb;
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
	uint value = uint(inputs[invocationId].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint value;
};
struct Outputs
{
	lowp int msb;
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
	uint value = uint(inputs[invocationNdx].value);
	int msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 value = a_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_msb;

void main (void)
{
	mediump uvec2 value = vtx_out_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_value;
layout(location = 0) flat out lowp ivec2 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 value = a_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_msb;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	uvec2 value = uvec2(inputs[invocationId].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec2 value;
};
struct Outputs
{
	lowp ivec2 msb;
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
	uvec2 value = uvec2(inputs[invocationNdx].value);
	ivec2 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 value = a_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	mediump uvec3 value = vtx_out_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 value = a_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec3 value = vtx_out_value[0];
	lowp ivec3 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	highp uvec3 value = vtx_out_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	uvec3 value = uvec3(inputs[invocationId].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec3 value;
};
struct Outputs
{
	lowp ivec3 msb;
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
	uvec3 value = uvec3(inputs[invocationNdx].value);
	ivec3 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 value = a_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	mediump uvec4 value = vtx_out_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	mediump uvec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_value;
layout(location = 0) flat out lowp ivec4 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 value = a_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uvec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	o_msb = msb;
}
#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uvec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	uvec4 value = uvec4(inputs[invocationNdx].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	mediump vector<uint, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> msb;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<int, 5> msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
#extension GL_EXT_long_vector : enable
layout(local_size_x = 1) in;

struct Inputs
{
	highp vector<uint, 5> value;
};
struct Outputs
{
	lowp vector<int, 5> msb;
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
	vector<uint, 5> value = vector<uint, 5>(inputs[invocationNdx].value);
	vector<int, 5> msb;

	msb = findMSB(value);

	outputs[invocationNdx].msb = msb;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp int input1;
};
struct Outputs
{
	highp uint outVal;
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
	int input1 = int(inputs[invocationNdx].input1);
	uint outVal;

	// a.y evaluates to (2u | 1u) = 3u. On a buggy driver, the compiler
	// misoptimizes the negation and modulo operations
	uvec2 a = uvec2(input1, 2u) | 1u;
	uint b = ~a.y;
	outVal = b % 2u;

	outputs[invocationNdx].outVal = outVal;
}
#version 450
layout(local_size_x = 1) in;

struct Inputs
{
	highp uint highBitMaskPattern;
	highp int lowBitsPattern;
	highp int mixedBitsPattern;
	highp int negativeValue;
};
struct Outputs
{
	highp int signExtendEqualShift;
	highp int signExtendCompoundShift;
	highp int zeroExtendCompoundShift;
	highp int signExtendReducedShift;
	highp int logicalShiftCast;
	highp int logicalShiftCompound;
	highp int posIntLeftRightMask;
	highp int posIntRightLeftMask;
	highp int shiftLeftClearAll;
	highp int shiftRightClearAll;
	highp int negIntSignFlip;
	highp int negIntSignExtend;
	highp int maxArithmeticShiftRight;
	highp int maxShiftLeftOdd;
	highp int consecutiveRightShiftPos;
	highp int consecutiveRightShiftNeg;
	highp int identityRightShift;
	highp int identityLeftShift;
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
	uint highBitMaskPattern = uint(inputs[invocationNdx].highBitMaskPattern);
	int lowBitsPattern = int(inputs[invocationNdx].lowBitsPattern);
	int mixedBitsPattern = int(inputs[invocationNdx].mixedBitsPattern);
	int negativeValue = int(inputs[invocationNdx].negativeValue);
	int signExtendEqualShift;
	int signExtendCompoundShift;
	int zeroExtendCompoundShift;
	int signExtendReducedShift;
	int logicalShiftCast;
	int logicalShiftCompound;
	int posIntLeftRightMask;
	int posIntRightLeftMask;
	int shiftLeftClearAll;
	int shiftRightClearAll;
	int negIntSignFlip;
	int negIntSignExtend;
	int maxArithmeticShiftRight;
	int maxShiftLeftOdd;
	int consecutiveRightShiftPos;
	int consecutiveRightShiftNeg;
	int identityRightShift;
	int identityLeftShift;

	// Group 1: Unsigned-to-Signed Compound Shifts
	signExtendEqualShift     = int(highBitMaskPattern << 22u) >> 22;
	signExtendCompoundShift  = int(highBitMaskPattern << 12u) >> 22;
	zeroExtendCompoundShift  = int(highBitMaskPattern << 2u) >> 22;
	signExtendReducedShift   = int(highBitMaskPattern << 22u) >> 10;
	logicalShiftCast         = int(highBitMaskPattern >> 30u);
	
	// Group 2: Arithmetic vs. Logical Right Shift Distinction
	logicalShiftCompound     = int((highBitMaskPattern << 22u) >> 22u);
	
	// Group 3: Positive Integer Bitfield Extraction & Masking
	posIntLeftRightMask      = (mixedBitsPattern << 24) >> 14;
	posIntRightLeftMask      = (mixedBitsPattern >> 24) << 14;
	shiftLeftClearAll        = (lowBitsPattern << 30) >> 10;
	shiftRightClearAll       = lowBitsPattern >> 10;
	
	// Group 4: Negative Integer Compound Shifts & Sign Flipping
	negIntSignFlip           = (negativeValue << 22) >> 14;
	negIntSignExtend         = (negativeValue >> 22) << 14;
	
	// Group 5: Maximum Legal 32-bit Shift Boundary
	maxArithmeticShiftRight  = negativeValue >> 31;
	maxShiftLeftOdd          = mixedBitsPattern << 31;
	
	// Group 6: Consecutive Shift Folding & Identity Shifts
	consecutiveRightShiftPos = (mixedBitsPattern >> 8) >> 8;
	consecutiveRightShiftNeg = (negativeValue >> 10) >> 10;
	identityRightShift       = (negativeValue << 10) >> 0;
	identityLeftShift        = (mixedBitsPattern >> 0) << 14;

	outputs[invocationNdx].signExtendEqualShift = signExtendEqualShift;
	outputs[invocationNdx].signExtendCompoundShift = signExtendCompoundShift;
	outputs[invocationNdx].zeroExtendCompoundShift = zeroExtendCompoundShift;
	outputs[invocationNdx].signExtendReducedShift = signExtendReducedShift;
	outputs[invocationNdx].logicalShiftCast = logicalShiftCast;
	outputs[invocationNdx].logicalShiftCompound = logicalShiftCompound;
	outputs[invocationNdx].posIntLeftRightMask = posIntLeftRightMask;
	outputs[invocationNdx].posIntRightLeftMask = posIntRightLeftMask;
	outputs[invocationNdx].shiftLeftClearAll = shiftLeftClearAll;
	outputs[invocationNdx].shiftRightClearAll = shiftRightClearAll;
	outputs[invocationNdx].negIntSignFlip = negIntSignFlip;
	outputs[invocationNdx].negIntSignExtend = negIntSignExtend;
	outputs[invocationNdx].maxArithmeticShiftRight = maxArithmeticShiftRight;
	outputs[invocationNdx].maxShiftLeftOdd = maxShiftLeftOdd;
	outputs[invocationNdx].consecutiveRightShiftPos = consecutiveRightShiftPos;
	outputs[invocationNdx].consecutiveRightShiftNeg = consecutiveRightShiftNeg;
	outputs[invocationNdx].identityRightShift = identityRightShift;
	outputs[invocationNdx].identityLeftShift = identityLeftShift;
}
