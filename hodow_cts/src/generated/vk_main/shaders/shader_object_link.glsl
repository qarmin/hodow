#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
}
#version 450

layout(vertices = 4) out;

void main (void)
{
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450

layout(quads, equal_spacing) in;

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f);
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
}
#version 450
layout (binding = 0) buffer Result { uint result[4]; };
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
    result[gl_VertexIndex] = gl_VertexIndex + 1;
}
#version 450

layout(quads, equal_spacing) in;
layout (binding = 0) buffer Result { uint result[4]; };

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
    if (gl_PrimitiveID == 0) {
        result[0] = 1;
        result[1] = 2;
        result[2] = 3;
        result[3] = 4;
    }
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout (binding = 0) buffer Result { uint result[4]; };

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    EndPrimitive();
    if (gl_InvocationID == 0) {
        result[0] = 1;
        result[1] = 2;
        result[2] = 3;
        result[3] = 4;
    }
}
#version 450
layout(local_size_x=16, local_size_x=16, local_size_x=1) in;
void main() {
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
void main ()
{
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 3) out;
layout(max_primitives = 1) out;
layout(triangles) out;
layout(set = 0, binding = 0) buffer Output {
    uint values[4];
} buffer_out;

void main() {
      SetMeshOutputsEXT(3, 1);
      gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0f, 1.0f);
      gl_MeshVerticesEXT[1].gl_Position = vec4( 3.0, -1.0, 0.0f, 1.0f);
      gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0,  3.0, 0.0f, 1.0f);
      gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
      buffer_out.values[0] = 0u;
      buffer_out.values[1] = 1u;
      buffer_out.values[2] = 2u;
      buffer_out.values[3] = 3u;
}
