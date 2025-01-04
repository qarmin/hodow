#version 450
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1)) - vec2(0.0001f);
    float z = 0.7f;
    if ((gl_VertexIndex & 1) > 0)
        z += 0.2f;
    if ((gl_InstanceIndex & 1) > 0)
        z -= 0.3f;
    gl_Position = vec4(pos - 0.5f, z, 1.0f);
    if (gl_VertexIndex == 0)
        buffer_out.values[0] = 1u;
}
#version 450
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1)) - vec2(0.0001f);
    float z = 0.9f;
    if ((gl_VertexIndex & 1) > 0)
        z += 0.2f;
    if ((gl_InstanceIndex & 1) > 0)
        z -= 0.3f;
    gl_Position = vec4(pos - 0.5f, z, 1.0f);
    if (gl_VertexIndex == 0)
        buffer_out.values[0] = 1u;
}
#version 450
layout(vertices = 4) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main (void)
{
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
        buffer_out.values[1] = 2u;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
layout(quads, equal_spacing) in;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
    if (gl_PrimitiveID == 0u)
        buffer_out.values[2] = 3u;
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    EndPrimitive();
    buffer_out.values[3] = 4u;
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(1.0f);
    EmitStreamVertex(0);
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(2.0f);
    EmitStreamVertex(0);
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(3.0f);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    buffer_out.values[3] = 4u;
}
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 4) out;
layout(max_primitives = 2) out;
layout(triangles) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main() {
    SetMeshOutputsEXT(4u, 2u);
    float z = 0.7f;
    if (gl_GlobalInvocationID.x == 1) z -= 0.3f;
    gl_MeshVerticesEXT[0].gl_Position = vec4(-0.5f, -0.5f, z, 1.0f);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-0.5f, 0.5f, z, 1.0f);
    gl_MeshVerticesEXT[2].gl_Position = vec4(0.5f, -0.5f, z + 0.2f, 1.0f);
    gl_MeshVerticesEXT[3].gl_Position = vec4(0.5f, 0.5f, z + 0.2f, 1.0f);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 3u, 2u);
    buffer_out.values[4] = 5u;
}
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 4) out;
layout(max_primitives = 2) out;
layout(triangles) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main() {
    SetMeshOutputsEXT(4u, 2u);
    float z = 0.9f;
    if (gl_GlobalInvocationID.x == 1) z -= 0.3f;
    gl_MeshVerticesEXT[0].gl_Position = vec4(-0.5f, -0.5f, z, 1.0f);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-0.5f, 0.5f, z, 1.0f);
    gl_MeshVerticesEXT[2].gl_Position = vec4(0.5f, -0.5f, z + 0.2f, 1.0f);
    gl_MeshVerticesEXT[3].gl_Position = vec4(0.5f, 0.5f, z + 0.2f, 1.0f);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 3u, 2u);
    buffer_out.values[4] = 5u;
}
#version 450
layout(isolines, equal_spacing) in;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
    if (gl_PrimitiveID == 0u)
        buffer_out.values[2] = 3u;
}
#version 450
layout(lines) in;
layout(line_strip, max_vertices = 4) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    EndPrimitive();
    buffer_out.values[3] = 4u;
}
#version 450
layout(lines) in;
layout(line_strip, max_vertices = 4) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(1.0f);
    EmitStreamVertex(0);
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(2.0f);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    buffer_out.values[3] = 4u;
}
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 4) out;
layout(max_primitives = 2) out;
layout(lines) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main() {
    SetMeshOutputsEXT(4u, 2u);
    float z = 0.7f;
    if (gl_GlobalInvocationID.x == 1) z -= 0.3f;
    gl_MeshVerticesEXT[0].gl_Position = vec4(-0.5f, -0.5f, z, 1.0f);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-0.5f, 0.5f, z, 1.0f);
    gl_MeshVerticesEXT[2].gl_Position = vec4(0.5f, -0.5f, z + 0.2f, 1.0f);
    gl_MeshVerticesEXT[3].gl_Position = vec4(0.5f, 0.5f, z + 0.2f, 1.0f);
    gl_PrimitiveLineIndicesEXT[0] = uvec2(0u, 2u);
    gl_PrimitiveLineIndicesEXT[1] = uvec2(1u, 3u);
    buffer_out.values[4] = 5u;
}
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 4) out;
layout(max_primitives = 2) out;
layout(lines) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main() {
    SetMeshOutputsEXT(4u, 2u);
    float z = 0.9f;
    if (gl_GlobalInvocationID.x == 1) z -= 0.3f;
    gl_MeshVerticesEXT[0].gl_Position = vec4(-0.5f, -0.5f, z, 1.0f);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-0.5f, 0.5f, z, 1.0f);
    gl_MeshVerticesEXT[2].gl_Position = vec4(0.5f, -0.5f, z + 0.2f, 1.0f);
    gl_MeshVerticesEXT[3].gl_Position = vec4(0.5f, 0.5f, z + 0.2f, 1.0f);
    gl_PrimitiveLineIndicesEXT[0] = uvec2(0u, 2u);
    gl_PrimitiveLineIndicesEXT[1] = uvec2(1u, 3u);
    buffer_out.values[4] = 5u;
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(0.75f);
}
