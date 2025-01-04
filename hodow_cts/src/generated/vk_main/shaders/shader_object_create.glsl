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
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos, 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0;
    gl_TessLevelInner[1] = 5.0;

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x*2.0 - 1.0;
    highp float y = gl_TessCoord.y*2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();
}
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 3) out;
layout(max_primitives = 1) out;
layout(triangles) out;
void main() {
      SetMeshOutputsEXT(3,1);
      gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0, 1);
      gl_MeshVerticesEXT[1].gl_Position = vec4( 1.0, -1.0, 0, 1);
      gl_MeshVerticesEXT[2].gl_Position = vec4( 0.0,  1.0, 0, 1);
      gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0,1,2);
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
struct TaskData {
    int t;
};
taskPayloadSharedEXT TaskData td;
void main ()
{
    td.t = 1;
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(0), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(0);
    gl_TessLevelInner[1] = 5.0 + float(0);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(0) - 1.0;
    highp float y = gl_TessCoord.y * float(0) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(0));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(0)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 0;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(1), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(1);
    gl_TessLevelInner[1] = 5.0 + float(1);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(1) - 1.0;
    highp float y = gl_TessCoord.y * float(1) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(1));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(1)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 1;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(2), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(2);
    gl_TessLevelInner[1] = 5.0 + float(2);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(2) - 1.0;
    highp float y = gl_TessCoord.y * float(2) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(2));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(2)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 2;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(3), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(3);
    gl_TessLevelInner[1] = 5.0 + float(3);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(3) - 1.0;
    highp float y = gl_TessCoord.y * float(3) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(3));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(3)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 3;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(4), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(4);
    gl_TessLevelInner[1] = 5.0 + float(4);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(4) - 1.0;
    highp float y = gl_TessCoord.y * float(4) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(4));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(4)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 4;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(5), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(5);
    gl_TessLevelInner[1] = 5.0 + float(5);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(5) - 1.0;
    highp float y = gl_TessCoord.y * float(5) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(5));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(5)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 5;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(6), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(6);
    gl_TessLevelInner[1] = 5.0 + float(6);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(6) - 1.0;
    highp float y = gl_TessCoord.y * float(6) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(6));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(6)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 6;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(7), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(7);
    gl_TessLevelInner[1] = 5.0 + float(7);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(7) - 1.0;
    highp float y = gl_TessCoord.y * float(7) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(7));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(7)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 7;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(8), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(8);
    gl_TessLevelInner[1] = 5.0 + float(8);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(8) - 1.0;
    highp float y = gl_TessCoord.y * float(8) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(8));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(8)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 8;
}
#version 450
layout (location=0) in vec2 inPos;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * float(9), 0.0f, 1.0f);
}
#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(9);
    gl_TessLevelInner[1] = 5.0 + float(9);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(9) - 1.0;
    highp float y = gl_TessCoord.y * float(9) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(9));
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f / (1.0f + float(9)));
}
#version 450
layout(local_size_x=16, local_size_x=1, local_size_x=1) in;
layout(binding = 0) buffer Output {
    uint values[16];
} buffer_out;

void main() {
    buffer_out.values[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 9;
}
