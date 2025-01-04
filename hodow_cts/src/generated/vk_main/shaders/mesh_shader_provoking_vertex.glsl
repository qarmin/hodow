#version 460
layout (location=0) flat in uvec4 inColor;
layout (location=0) out vec4 outColor;
void main ()
{
    outColor = vec4(inColor);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2, local_size_y=1, local_size_z=1) in;
layout (lines) out;
layout (max_vertices=2, max_primitives=1) out;

layout (push_constant, std430) uniform PushConstantBlock {
    int layer;
} pc;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_Layer;
} gl_MeshPrimitivesEXT[];

uvec4 colors[] = uvec4[](
    uvec4(1, 1, 0, 1),
    uvec4(1, 0, 1, 1)
);

vec4 vertices[] = vec4[](
    vec4(-1.0, 0.0, 0.0, 1.0),
    vec4(1.0, 0.0, 0.0, 1.0)
);

layout (location=0) flat out uvec4 vtxColor[];

void main ()
{
    SetMeshOutputsEXT(2, 1);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vertices[gl_LocalInvocationIndex];
    vtxColor[gl_LocalInvocationIndex] = colors[gl_LocalInvocationIndex];

    if (gl_LocalInvocationIndex == 0u) {
        gl_PrimitiveLineIndicesEXT[0] = uvec2(0, 1);
        gl_MeshPrimitivesEXT[0].gl_Layer = pc.layer;
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=3, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

layout (push_constant, std430) uniform PushConstantBlock {
    int layer;
} pc;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_Layer;
} gl_MeshPrimitivesEXT[];

uvec4 colors[] = uvec4[](
    uvec4(1, 1, 0, 1),
    uvec4(0, 1, 1, 1),
    uvec4(1, 0, 1, 1)
);

vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(-1.0, 1.0, 0.0, 1.0),
    vec4(3.0, -1.0, 0.0, 1.0)
);

layout (location=0) flat out uvec4 vtxColor[];

void main ()
{
    SetMeshOutputsEXT(3, 1);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vertices[gl_LocalInvocationIndex];
    vtxColor[gl_LocalInvocationIndex] = colors[gl_LocalInvocationIndex];

    if (gl_LocalInvocationIndex == 0u) {
        gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
        gl_MeshPrimitivesEXT[0].gl_Layer = pc.layer;
    }
}
