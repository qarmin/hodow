#version 450
precision highp float;

layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;

layout(location = 0) out vec4 out_color;
out gl_PerVertex { vec4 gl_Position; };

void main() {
	gl_Position = in_position;
	out_color = in_color;
}
#version 310 es
precision highp float;

layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
  out_color = in_color;
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex { vec4 gl_Position; } gl_in[];
out gl_PerVertex { vec4 gl_Position; };
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;

void main() {
	for (int i=0; i<gl_in.length(); ++i) {
		gl_Position = gl_in[i].gl_Position;
		gl_ViewportIndex = int(round(gl_in[i].gl_Position.z * 3.0));
		out_color = in_color[i];
		EmitVertex();
	}
	EndPrimitive();
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct PositionColor {
    vec4 position;
    vec4 color;
};

layout(set=0, binding=0, std430) readonly buffer PositionColorBlock {
    PositionColor posColor[];
} vtxData;

layout(push_constant, std430) uniform PushConstantBlock {
    uint vertexOffset;
} pc;

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout(location = 0) out vec4 outColor[];

void main() {
    SetMeshOutputsEXT(3u, 1u);
    const uint firstVertex = uint(gl_WorkGroupID.x) + pc.vertexOffset;
    for (uint i = 0u; i < 3u; ++i)
    {
        const uint srcIdx = firstVertex + i;
        gl_MeshVerticesEXT[i].gl_Position = vtxData.posColor[srcIdx].position;
        outColor[i] = vtxData.posColor[srcIdx].color;
    }
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct PositionColor {
    vec4 position;
    vec4 color;
};

layout(set=0, binding=0, std430) readonly buffer PositionColorBlock {
    PositionColor posColor[];
} vtxData;

layout(push_constant, std430) uniform PushConstantBlock {
    uint vertexOffset;
} pc;

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout(location = 0) out vec4 outColor[];

void main() {
    SetMeshOutputsEXT(3u, 1u);
    const uint firstVertex = uint(gl_WorkGroupID.x) + pc.vertexOffset;
    for (uint i = 0u; i < 3u; ++i)
    {
        const uint srcIdx = firstVertex + i;
        gl_MeshVerticesEXT[i].gl_Position = vtxData.posColor[srcIdx].position;
        outColor[i] = vtxData.posColor[srcIdx].color;
    }
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_MeshPrimitivesEXT[0].gl_ViewportIndex = int(round(vtxData.posColor[firstVertex].position.z * 3.0));
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct PositionColor {
    vec4 position;
    vec4 color;
};

layout(set=0, binding=0, std430) readonly buffer PositionColorBlock {
    PositionColor posColor[];
} vtxData;

layout(push_constant, std430) uniform PushConstantBlock {
    uint vertexOffset;
} pc;

layout(local_size_x=1) in;
layout(lines) out;
layout(max_vertices=2, max_primitives=1) out;

layout(location = 0) out vec4 outColor[];

void main() {
    SetMeshOutputsEXT(2u, 1u);
    const uint firstVertex = uint(gl_WorkGroupID.x) + pc.vertexOffset;
    for (uint i = 0u; i < 2u; ++i)
    {
        const uint srcIdx = firstVertex + i;
        gl_MeshVerticesEXT[i].gl_Position = vtxData.posColor[srcIdx].position;
        outColor[i] = vtxData.posColor[srcIdx].color;
    }
    gl_PrimitiveLineIndicesEXT[0] = uvec2(0, 1);
}
