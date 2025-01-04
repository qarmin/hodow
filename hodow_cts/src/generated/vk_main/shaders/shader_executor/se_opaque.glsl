#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[3].value;
	result1 = block[0].value;
	result2 = block[2].value;
	result3 = block[2].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[0].value;
	result1 = block[2].value;
	result2 = block[2].value;
	result3 = block[3].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[2].value;
	result1 = block[3].value;
	result2 = block[3].value;
	result3 = block[1].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[2].value;
	result1 = block[3].value;
	result2 = block[3].value;
	result3 = block[1].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
void main (void)
{
    gl_Position = vec4(gl_VertexIndex/2, gl_VertexIndex%2, 0.0, 1.0);
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[0].value;
	result1 = block[1].value;
	result2 = block[2].value;
	result3 = block[3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
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
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[2].value;
	result1 = block[0].value;
	result2 = block[1].value;
	result3 = block[3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[2].value;
	result1 = block[1].value;
	result2 = block[1].value;
	result3 = block[3].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[indexBase + -1].value;
	result1 = block[indexBase + 1].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + 2].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[indexBase + 2].value;
	result1 = block[indexBase + -1].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + 1].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[indexBase + 0].value;
	result1 = block[indexBase + 0].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + -1].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[indexBase + 0].value;
	result1 = block[indexBase + 0].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + -1].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[indexBase + 2].value;
	result1 = block[indexBase + 0].value;
	result2 = block[indexBase + 0].value;
	result3 = block[indexBase + -1].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[indexBase + 0].value;
	result1 = block[indexBase + -1].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + -1].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[indexBase + 0].value;
	result1 = block[indexBase + -1].value;
	result2 = block[indexBase + -1].value;
	result3 = block[indexBase + 0].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_index0;
layout(location = 2) in highp int a_index1;
layout(location = 3) in highp int a_index2;
layout(location = 4) in highp int a_index3;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_index0;
layout(location = 0) flat out highp int vtx_out_index0;
layout(location = 2) in highp int a_index1;
layout(location = 1) flat out highp int vtx_out_index1;
layout(location = 3) in highp int a_index2;
layout(location = 2) flat out highp int vtx_out_index2;
layout(location = 4) in highp int a_index3;
layout(location = 3) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp int vtx_out_index0;
layout(location = 1) flat in highp int vtx_out_index1;
layout(location = 2) flat in highp int vtx_out_index2;
layout(location = 3) flat in highp int vtx_out_index3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_index0[];
layout(location = 1) flat in highp int vtx_out_index1[];
layout(location = 2) flat in highp int vtx_out_index2[];
layout(location = 3) flat in highp int vtx_out_index3[];
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int index0 = vtx_out_index0[0];
	highp int index1 = vtx_out_index1[0];
	highp int index2 = vtx_out_index2[0];
	highp int index3 = vtx_out_index3[0];
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_index0[];
layout(location = 1) flat in highp int vtx_out_index1[];
layout(location = 2) flat in highp int vtx_out_index2[];
layout(location = 3) flat in highp int vtx_out_index3[];
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int index0 = vtx_out_index0[0];
	highp int index1 = vtx_out_index1[0];
	highp int index2 = vtx_out_index2[0];
	highp int index3 = vtx_out_index3[0];
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];


layout(vertices = 1) out;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationId].index0);
	int index1 = int(inputs[invocationId].index1);
	int index2 = int(inputs[invocationId].index2);
	int index3 = int(inputs[invocationId].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationId].index0);
	int index1 = int(inputs[invocationId].index1);
	int index2 = int(inputs[invocationId].index2);
	int index3 = int(inputs[invocationId].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];

layout(local_size_x = 1) in;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[0].value;
	result1 = block[2].value;
	result2 = block[2].value;
	result3 = block[3].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[3].value;
	result1 = block[0].value;
	result2 = block[2].value;
	result3 = block[2].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[1].value;
	result1 = block[1].value;
	result2 = block[2].value;
	result3 = block[0].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[1].value;
	result1 = block[1].value;
	result2 = block[2].value;
	result3 = block[0].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[3].value;
	result1 = block[1].value;
	result2 = block[1].value;
	result3 = block[0].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[1].value;
	result1 = block[0].value;
	result2 = block[2].value;
	result3 = block[0].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[1].value;
	result1 = block[0].value;
	result2 = block[0].value;
	result3 = block[1].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[indexBase + 2].value;
	result1 = block[indexBase + -1].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + 1].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[indexBase + -1].value;
	result1 = block[indexBase + 1].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + 2].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[indexBase + 1].value;
	result1 = block[indexBase + 2].value;
	result2 = block[indexBase + 2].value;
	result3 = block[indexBase + 0].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[indexBase + 1].value;
	result1 = block[indexBase + 2].value;
	result2 = block[indexBase + 2].value;
	result3 = block[indexBase + 0].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[indexBase + -1].value;
	result1 = block[indexBase + 0].value;
	result2 = block[indexBase + 1].value;
	result3 = block[indexBase + 2].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[indexBase + 1].value;
	result1 = block[indexBase + -1].value;
	result2 = block[indexBase + 0].value;
	result3 = block[indexBase + 2].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[indexBase + 1].value;
	result1 = block[indexBase + 0].value;
	result2 = block[indexBase + 0].value;
	result3 = block[indexBase + 2].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_index0;
layout(location = 2) in highp int a_index1;
layout(location = 3) in highp int a_index2;
layout(location = 4) in highp int a_index3;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_index0;
layout(location = 0) flat out highp int vtx_out_index0;
layout(location = 2) in highp int a_index1;
layout(location = 1) flat out highp int vtx_out_index1;
layout(location = 3) in highp int a_index2;
layout(location = 2) flat out highp int vtx_out_index2;
layout(location = 4) in highp int a_index3;
layout(location = 3) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp int vtx_out_index0;
layout(location = 1) flat in highp int vtx_out_index1;
layout(location = 2) flat in highp int vtx_out_index2;
layout(location = 3) flat in highp int vtx_out_index3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_index0[];
layout(location = 1) flat in highp int vtx_out_index1[];
layout(location = 2) flat in highp int vtx_out_index2[];
layout(location = 3) flat in highp int vtx_out_index3[];
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int index0 = vtx_out_index0[0];
	highp int index1 = vtx_out_index1[0];
	highp int index2 = vtx_out_index2[0];
	highp int index3 = vtx_out_index3[0];
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_index0[];
layout(location = 1) flat in highp int vtx_out_index1[];
layout(location = 2) flat in highp int vtx_out_index2[];
layout(location = 3) flat in highp int vtx_out_index3[];
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int index0 = vtx_out_index0[0];
	highp int index1 = vtx_out_index1[0];
	highp int index2 = vtx_out_index2[0];
	highp int index3 = vtx_out_index3[0];
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];


layout(vertices = 1) out;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationId].index0);
	int index1 = int(inputs[invocationId].index1);
	int index2 = int(inputs[invocationId].index2);
	int index3 = int(inputs[invocationId].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationId].index0);
	int index1 = int(inputs[invocationId].index1);
	int index2 = int(inputs[invocationId].index2);
	int index3 = int(inputs[invocationId].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];

layout(local_size_x = 1) in;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[2], uint(1));
	result1 = atomicAdd(counter[2], uint(1));
	result2 = atomicAdd(counter[0], uint(1));
	result3 = atomicAdd(counter[0], uint(1));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[2], uint(1));
	result1 = atomicAdd(counter[3], uint(1));
	result2 = atomicAdd(counter[2], uint(1));
	result3 = atomicAdd(counter[2], uint(1));
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[0], uint(1));
	result1 = atomicAdd(counter[3], uint(1));
	result2 = atomicAdd(counter[1], uint(1));
	result3 = atomicAdd(counter[1], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[0], uint(1));
	result1 = atomicAdd(counter[3], uint(1));
	result2 = atomicAdd(counter[1], uint(1));
	result3 = atomicAdd(counter[1], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[2], uint(1));
	result1 = atomicAdd(counter[0], uint(1));
	result2 = atomicAdd(counter[3], uint(1));
	result3 = atomicAdd(counter[2], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[0], uint(1));
	result1 = atomicAdd(counter[1], uint(1));
	result2 = atomicAdd(counter[0], uint(1));
	result3 = atomicAdd(counter[2], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[0], uint(1));
	result1 = atomicAdd(counter[0], uint(1));
	result2 = atomicAdd(counter[3], uint(1));
	result3 = atomicAdd(counter[2], uint(1));

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[indexBase + 1], uint(1));
	result1 = atomicAdd(counter[indexBase + 2], uint(1));
	result2 = atomicAdd(counter[indexBase + 1], uint(1));
	result3 = atomicAdd(counter[indexBase + 1], uint(1));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[indexBase + 1], uint(1));
	result1 = atomicAdd(counter[indexBase + 1], uint(1));
	result2 = atomicAdd(counter[indexBase + -1], uint(1));
	result3 = atomicAdd(counter[indexBase + -1], uint(1));
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[indexBase + 2], uint(1));
	result1 = atomicAdd(counter[indexBase + 2], uint(1));
	result2 = atomicAdd(counter[indexBase + 2], uint(1));
	result3 = atomicAdd(counter[indexBase + 1], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[indexBase + 2], uint(1));
	result1 = atomicAdd(counter[indexBase + 2], uint(1));
	result2 = atomicAdd(counter[indexBase + 2], uint(1));
	result3 = atomicAdd(counter[indexBase + 1], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[indexBase + 0], uint(1));
	result1 = atomicAdd(counter[indexBase + -1], uint(1));
	result2 = atomicAdd(counter[indexBase + -1], uint(1));
	result3 = atomicAdd(counter[indexBase + 0], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[indexBase + 2], uint(1));
	result1 = atomicAdd(counter[indexBase + 0], uint(1));
	result2 = atomicAdd(counter[indexBase + 0], uint(1));
	result3 = atomicAdd(counter[indexBase + 0], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[indexBase + 2], uint(1));
	result1 = atomicAdd(counter[indexBase + 1], uint(1));
	result2 = atomicAdd(counter[indexBase + -1], uint(1));
	result3 = atomicAdd(counter[indexBase + 2], uint(1));

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
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
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};


layout(isolines, equal_spacing) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z
                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_index0;
layout(location = 2) in highp int a_index1;
layout(location = 3) in highp int a_index2;
layout(location = 4) in highp int a_index3;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) flat in highp uint vtx_out_result0;
layout(location = 1) flat in highp uint vtx_out_result1;
layout(location = 2) flat in highp uint vtx_out_result2;
layout(location = 3) flat in highp uint vtx_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_index0;
layout(location = 0) flat out highp int vtx_out_index0;
layout(location = 2) in highp int a_index1;
layout(location = 1) flat out highp int vtx_out_index1;
layout(location = 3) in highp int a_index2;
layout(location = 2) flat out highp int vtx_out_index2;
layout(location = 4) in highp int a_index3;
layout(location = 3) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) flat in highp int vtx_out_index0;
layout(location = 1) flat in highp int vtx_out_index1;
layout(location = 2) flat in highp int vtx_out_index2;
layout(location = 3) flat in highp int vtx_out_index3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_index0[];
layout(location = 1) flat in highp int vtx_out_index1[];
layout(location = 2) flat in highp int vtx_out_index2[];
layout(location = 3) flat in highp int vtx_out_index3[];
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int index0 = vtx_out_index0[0];
	highp int index1 = vtx_out_index1[0];
	highp int index2 = vtx_out_index2[0];
	highp int index3 = vtx_out_index3[0];
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_index0[];
layout(location = 1) flat in highp int vtx_out_index1[];
layout(location = 2) flat in highp int vtx_out_index2[];
layout(location = 3) flat in highp int vtx_out_index3[];
layout(location = 0) flat out highp uint geom_out_result0;
layout(location = 1) flat out highp uint geom_out_result1;
layout(location = 2) flat out highp uint geom_out_result2;
layout(location = 3) flat out highp uint geom_out_result3;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp int index0 = vtx_out_index0[0];
	highp int index1 = vtx_out_index1[0];
	highp int index2 = vtx_out_index2[0];
	highp int index3 = vtx_out_index3[0];
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	geom_out_result0 = result0;
	geom_out_result1 = result1;
	geom_out_result2 = result2;
	geom_out_result3 = result3;
    EmitVertex();
    EndPrimitive();
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) flat in highp uint geom_out_result0;
layout(location = 1) flat in highp uint geom_out_result1;
layout(location = 2) flat in highp uint geom_out_result2;
layout(location = 3) flat in highp uint geom_out_result3;
layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
	o_result2 = geom_out_result2;
	o_result3 = geom_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };


layout(vertices = 1) out;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationId].index0);
	int index1 = int(inputs[invocationId].index1);
	int index2 = int(inputs[invocationId].index2);
	int index3 = int(inputs[invocationId].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationId].index0);
	int index1 = int(inputs[invocationId].index1);
	int index2 = int(inputs[invocationId].index2);
	int index3 = int(inputs[invocationId].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(local_size_x = 1) in;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[5], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[4], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[6], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[0], coords);
	result3 = texture(texSampler[3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[0], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[5], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[0], coords);
	result3 = texture(texSampler[0], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[3], coords);
	result1 = texture(texSampler[2], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[2], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[7], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[2], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[6], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[2], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[2], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[0], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[4], coords);
	result1 = texture(texSampler[2], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[7], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[6], coords);
	result1 = texture(texSampler[5], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[5], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[6], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[0], coords);
	result3 = texture(texSampler[1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[3], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[4], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[0], coords);
	result3 = texture(texSampler[5], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[7], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[6], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[5], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[2], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[6], coords);
	result1 = texture(texSampler[5], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[6], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[6], coords);
	result3 = texture(texSampler[7], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[5], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[6], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[5], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[5], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[7], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[2], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[0], coords);
	result3 = texture(texSampler[1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[5], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[0], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[6], coords);
	result3 = texture(texSampler[6], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[2], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[5], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[5], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[3], coords);
	result1 = texture(texSampler[0], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[4], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[6], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[0], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[4], coords);
	result1 = texture(texSampler[5], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[2], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[4], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[2], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[3], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[6], coords);
	result3 = texture(texSampler[7], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[0], coords);
	result3 = texture(texSampler[7], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[5], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[6], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[5], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[2], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[7], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[6], coords);
	result3 = texture(texSampler[2], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[5], coords);
	result1 = texture(texSampler[5], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[3], coords);
	result1 = texture(texSampler[5], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[1], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[7], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[3], coords);
	result2 = texture(texSampler[1], coords);
	result3 = texture(texSampler[7], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[0], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[2], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[5], coords);
	result1 = texture(texSampler[1], coords);
	result2 = texture(texSampler[6], coords);
	result3 = texture(texSampler[0], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[0], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[4], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[1], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[1], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[6], coords);
	result3 = texture(texSampler[4], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[6], coords);
	result1 = texture(texSampler[0], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[7], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[2], coords);
	result1 = texture(texSampler[7], coords);
	result2 = texture(texSampler[7], coords);
	result3 = texture(texSampler[0], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 6], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 6], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 5], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 0], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 6], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + 1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 5], coords);
	result1 = texture(texSampler[indexBase + 4], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 5], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + 5], coords);
	result3 = texture(texSampler[indexBase + 6], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 2], coords);
	result3 = texture(texSampler[indexBase + 5], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 4], coords);
	result2 = texture(texSampler[indexBase + 2], coords);
	result3 = texture(texSampler[indexBase + 4], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 6], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + 3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + 0], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 6], coords);
	result3 = texture(texSampler[indexBase + 4], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 2], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 5], coords);
	result3 = texture(texSampler[indexBase + 5], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 1], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + 6], coords);
	result3 = texture(texSampler[indexBase + 3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 4], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 3], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 5], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 6], coords);
	result2 = texture(texSampler[indexBase + 2], coords);
	result3 = texture(texSampler[indexBase + 3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 6], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + 0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + 2], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 5], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + 2], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 6], coords);
	result3 = texture(texSampler[indexBase + 2], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + 1], coords);
	result2 = texture(texSampler[indexBase + 6], coords);
	result3 = texture(texSampler[indexBase + 1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 6], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 5], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 1], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 3], coords);
	result1 = texture(texSampler[indexBase + 1], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 6], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 5], coords);
	result1 = texture(texSampler[indexBase + 4], coords);
	result2 = texture(texSampler[indexBase + 2], coords);
	result3 = texture(texSampler[indexBase + 4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 6], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 5], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + 0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + 6], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + 4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 2], coords);
	result3 = texture(texSampler[indexBase + 3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 6], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 2], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 0], coords);
	result3 = texture(texSampler[indexBase + 1], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 5], coords);
	result3 = texture(texSampler[indexBase + 5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 6], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 6], coords);
	result3 = texture(texSampler[indexBase + 3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + 5], coords);
	result3 = texture(texSampler[indexBase + 5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 1], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 6], coords);
	result3 = texture(texSampler[indexBase + 4], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + 1], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + 0], coords);
	result2 = texture(texSampler[indexBase + 5], coords);
	result3 = texture(texSampler[indexBase + 5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + 4], coords);
	result2 = texture(texSampler[indexBase + 6], coords);
	result3 = texture(texSampler[indexBase + 1], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 0], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[indexBase + 6], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + 6], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[indexBase + 5], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + 5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[indexBase + 3], coords);
	result1 = texture(texSampler[indexBase + 5], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 0], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 4], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[indexBase + 2], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + 5], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[indexBase + 1], coords);
	result1 = texture(texSampler[indexBase + 4], coords);
	result2 = texture(texSampler[indexBase + 4], coords);
	result3 = texture(texSampler[indexBase + 4], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 3], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + -1], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 4], coords);
	result2 = texture(texSampler[indexBase + 2], coords);
	result3 = texture(texSampler[indexBase + 0], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp vec4 vtx_out_result1;
layout(location = 2) flat out highp vec4 vtx_out_result2;
layout(location = 3) flat out highp vec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp vec4 vtx_out_result1;
layout(location = 2) flat in highp vec4 vtx_out_result2;
layout(location = 3) flat in highp vec4 vtx_out_result3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) flat in highp ivec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 2) flat in highp ivec4 vtx_out_result2;
layout(location = 3) flat in highp ivec4 vtx_out_result3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) flat in highp uvec4 vtx_out_result0;
layout(location = 1) flat in highp uvec4 vtx_out_result1;
layout(location = 2) flat in highp uvec4 vtx_out_result2;
layout(location = 3) flat in highp uvec4 vtx_out_result3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) flat out highp vec4 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp float vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(location = 0) flat in highp float vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp float coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 0) flat out highp vec2 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp vec3 vtx_out_coords;
layout(location = 2) in highp int a_index0;
layout(location = 1) flat out highp int vtx_out_index0;
layout(location = 3) in highp int a_index1;
layout(location = 2) flat out highp int vtx_out_index1;
layout(location = 4) in highp int a_index2;
layout(location = 3) flat out highp int vtx_out_index2;
layout(location = 5) in highp int a_index3;
layout(location = 4) flat out highp int vtx_out_index3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_coords = a_coords;
	vtx_out_index0 = a_index0;
	vtx_out_index1 = a_index1;
	vtx_out_index2 = a_index2;
	vtx_out_index3 = a_index3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DArrayShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	vec4 result0;
	vec4 result1;
	vec4 result2;
	vec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DArrayShadow texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec4 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec4 coords = vec4(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	float result0;
	float result1;
	float result2;
	float result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isamplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	ivec4 result0;
	ivec4 result1;
	ivec4 result2;
	ivec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp float coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	float coords = float(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler1DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec2 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec2 coords = vec2(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usamplerCube texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler2DArray texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(local_size_x = 1) in;

struct Inputs
{
	highp vec3 coords;
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
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
	vec3 coords = vec3(inputs[invocationNdx].coords);
	int index0 = int(inputs[invocationNdx].index0);
	int index1 = int(inputs[invocationNdx].index1);
	int index2 = int(inputs[invocationNdx].index2);
	int index3 = int(inputs[invocationNdx].index3);
	uvec4 result0;
	uvec4 result1;
	uvec4 result2;
	uvec4 result3;

	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);

	outputs[invocationNdx].result0 = result0;
	outputs[invocationNdx].result1 = result1;
	outputs[invocationNdx].result2 = result2;
	outputs[invocationNdx].result3 = result3;
}
