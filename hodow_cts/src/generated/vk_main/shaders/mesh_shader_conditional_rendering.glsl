#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

void main (void) {
    SetMeshOutputsEXT(3u, 1u);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
}
#version 460

layout (location=0) out vec4 outColor;

void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

void main (void) {
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_multiview : enable

layout (location=0) out vec4 outColor;

void main (void) {
    outColor = vec4(gl_ViewIndex, 0.0, 1.0, 1.0);
}
