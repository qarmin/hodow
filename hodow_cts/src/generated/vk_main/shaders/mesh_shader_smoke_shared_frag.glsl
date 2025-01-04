#version 450
#extension GL_ARB_shader_viewport_layer_array : enable

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main ()
{
    gl_Position = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
    gl_Layer = 1;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_Layer;
} gl_MeshPrimitivesEXT[];

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);

void main ()
{
    SetMeshOutputsEXT(4u, 2u);
    for (uint i = 0; i < 4; ++i) {
        gl_MeshVerticesEXT[i].gl_Position = vec4(positions[i], 0.0, 1.0);
    }
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 1, 3);
    gl_MeshPrimitivesEXT[0].gl_Layer = 2;
    gl_MeshPrimitivesEXT[1].gl_Layer = 2;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 outColors[3] = vec4[](
    vec4(0, 0, 0, 1),
    vec4(1, 0, 1, 1),
    vec4(1, 1, 0, 1)
);

void main ()
{
    const vec4 baseColor = outColors[gl_Layer];
    outColor = baseColor;
}
#version 450
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out float multiplier;

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main ()
{
    gl_Position = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
    gl_Layer = 1;
    multiplier = (gl_VertexIndex < 1024 ? 1.0 : 0.0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_Layer;
} gl_MeshPrimitivesEXT[];

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);

    layout (location=0) out float multiplier[];
void main ()
{
    SetMeshOutputsEXT(4u, 2u);
    for (uint i = 0; i < 4; ++i) {
        gl_MeshVerticesEXT[i].gl_Position = vec4(positions[i], 0.0, 1.0);
        multiplier[i] = (gl_NumWorkGroups[0] < 1024 ? 1.0 : 0.0);
    }
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 1, 3);
    gl_MeshPrimitivesEXT[0].gl_Layer = 2;
    gl_MeshPrimitivesEXT[1].gl_Layer = 2;
}
#version 450

layout (location=0) in float multiplier;
layout (location=0) out vec4 outColor;

vec4 outColors[3] = vec4[](
    vec4(0, 0, 0, 1),
    vec4(1, 0, 1, 1),
    vec4(1, 1, 0, 1)
);

void main ()
{
    const vec4 baseColor = outColors[gl_Layer];
    outColor = baseColor * multiplier;
}
#version 450
#extension GL_ARB_shader_viewport_layer_array : enable

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main ()
{
    gl_Position = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);

void main ()
{
    SetMeshOutputsEXT(4u, 2u);
    for (uint i = 0; i < 4; ++i) {
        gl_MeshVerticesEXT[i].gl_Position = vec4(positions[i], 0.0, 1.0);
    }
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 1, 3);
    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = 0;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = 1;
}
#version 450

layout (location=0) out vec4 outColor;

vec4 outColors[3] = vec4[](
    vec4(0, 0, 0, 1),
    vec4(1, 0, 1, 1),
    vec4(1, 1, 0, 1)
);

void main ()
{
    const vec4 baseColor = vec4(outColors[2].xy, gl_PrimitiveID, 1.0);
    outColor = baseColor;
}
#version 450
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out float multiplier;

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main ()
{
    gl_Position = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
    multiplier = (gl_VertexIndex < 1024 ? 1.0 : 0.0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);

    layout (location=0) out float multiplier[];
void main ()
{
    SetMeshOutputsEXT(4u, 2u);
    for (uint i = 0; i < 4; ++i) {
        gl_MeshVerticesEXT[i].gl_Position = vec4(positions[i], 0.0, 1.0);
        multiplier[i] = (gl_NumWorkGroups[0] < 1024 ? 1.0 : 0.0);
    }
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 1, 3);
    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = 0;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = 1;
}
#version 450

layout (location=0) in float multiplier;
layout (location=0) out vec4 outColor;

vec4 outColors[3] = vec4[](
    vec4(0, 0, 0, 1),
    vec4(1, 0, 1, 1),
    vec4(1, 1, 0, 1)
);

void main ()
{
    const vec4 baseColor = vec4(outColors[2].xy, gl_PrimitiveID, 1.0);
    outColor = baseColor * multiplier;
}
