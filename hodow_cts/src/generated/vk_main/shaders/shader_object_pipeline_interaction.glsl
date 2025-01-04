#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * 0.5f - vec2(0.5f, 0.5f), 0.0f, 1.0f);
}
#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * 0.5f - vec2(0.0f, 0.5f), 0.0f, 1.0f);
}
#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * 0.5f - vec2(0.5f, 0.0f), 0.0f, 1.0f);
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
    gl_Position.x *= 2.0f;
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 2.0f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 2.0f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 2.0f;
    EmitVertex();
    EndPrimitive();
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(0.0f, 0.0f, 1.0f, 1.0f);
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
layout(set = 0, binding = 0) buffer Output {
    uint values[4];
} buffer_out;

void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
    if (gl_VertexIndex == 0u)
        buffer_out.values[0] = 1u;
}
#version 450

layout(vertices = 4) out;
layout(set = 0, binding = 0) buffer Output {
    uint values[4];
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
layout(set = 0, binding = 0) buffer Output {
    uint values[4];
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
    if (gl_InvocationID == 0u)
        buffer_out.values[2] = 3u;
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f);
}
#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
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
    gl_Position.x *= 0.5f;
    gl_Position.y *= 0.5f;
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.x += 0.25f;
    gl_Position.y += 0.25f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.x += 0.25f;
    gl_Position.y += 0.25f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.x += 0.25f;
    gl_Position.y += 0.25f;
    EmitVertex();
    EndPrimitive();
}
