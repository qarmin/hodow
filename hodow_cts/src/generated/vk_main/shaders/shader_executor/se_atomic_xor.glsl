#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450
void main (void)
{
    gl_Position = vec4(gl_VertexIndex/2, gl_VertexIndex%2, 0.0, 1.0);
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
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
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
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

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
}
#version 450

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
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

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

struct TaskData { AtomicStruct data; };
taskPayloadSharedEXT TaskData buf;

layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int inoutValues[32/2];
    int inputValues[32];
    int compareValues[32];
    int outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
}
#version 450

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

struct TaskData { AtomicStruct data; };
taskPayloadSharedEXT TaskData buf;

layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint inoutValues[32/2];
    uint inputValues[32];
    uint compareValues[32];
    uint outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

struct TaskData { AtomicStruct data; };
taskPayloadSharedEXT TaskData buf;

layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    int64_t inoutValues[32/2];
    int64_t inputValues[32];
    int64_t compareValues[32];
    int64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_outData;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint outData;
	int idx = gl_VertexIndex;
	if (atomicAdd(buf.data.invocationHitCount[idx], 1) == 0)
	{
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	vtx_out_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint vtx_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = vtx_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) out highp uint o_outData;

void main (void)
{
	highp uint outData;
	if (!gl_HelperInvocation) {
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	o_outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_outData;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	geom_out_outData = outData;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(location = 0) flat in highp uint geom_out_outData;
layout(location = 0) out highp uint o_outData;

void main (void)
{
	o_outData = geom_out_outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(vertices = 1) out;

struct Outputs
{
	highp uint outData;
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
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};



layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationId].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

struct TaskData { AtomicStruct data; };
taskPayloadSharedEXT TaskData buf;

layout(local_size_x = 32) in;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} buf;


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (set = 1, binding = 0) buffer AtomicBuffer {
    AtomicStruct data;
} result;

shared struct { AtomicStruct data; } buf;


layout(local_size_x = 32) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (gl_LocalInvocationIndex == 0u)
	{
	    buf.data = result.data;
	}
	barrier();
	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}
	barrier();
	if (gl_LocalInvocationIndex == 0u)
	{
	    result.data = buf.data;
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_atomic_int64 : enable
#extension GL_EXT_buffer_reference : require

struct AtomicStruct
{
    uint64_t inoutValues[32/2];
    uint64_t inputValues[32];
    uint64_t compareValues[32];
    uint64_t outputValues[32];
    int invocationHitCount[32];
    int index;
};

layout (buffer_reference) buffer AtomicBuffer {
    AtomicStruct data;
};

layout (set = 1, binding = 0) uniform References {
    AtomicBuffer buf;
};


layout(local_size_x = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives=1) out;

struct Outputs
{
	highp uint outData;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint outData;

	if (atomicAdd(buf.data.invocationHitCount[0], 1) < 32)
	{
	    int idx = atomicAdd(buf.data.index, 1);
	    buf.data.outputValues[idx] = atomicXor(buf.data.inoutValues[idx % (32/2)], buf.data.inputValues[idx]);
	}

	outputs[invocationNdx].outData = outData;
    SetMeshOutputsEXT(0u, 0u);
}
