#version 450
layout(location = 0) in vec4 inPos;
void main() {
    gl_Position = vec4((inPos.xy - 0.5f) * 1.5f, inPos.zw);
}
#version 450
layout(set=0, binding=0) readonly buffer inputBuf {
    vec4 color;
};
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
void main() {
    outColor0 = color;
    outColor1 = color;
}
#version 450
#if 1 == 1 && 0 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 1 == 1
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 1 == 2 && 0 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 1 == 2
#if 0 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 1 == 3 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 1 == 3
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 1 == 4 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 1 == 4
#if 0 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(1.0f);
}
#version 450
#if 1 == 1 && 1 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 1 == 1
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 1 == 2 && 1 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 1 == 2
#if 1 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 1 == 3 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 1 == 3
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 1 == 4 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 1 == 4
#if 1 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
#if 2 == 1 && 0 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 2 == 1
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 2 == 2 && 0 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 2 == 2
#if 0 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 2 == 3 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 2 == 3
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 2 == 4 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 2 == 4
#if 0 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
#if 2 == 1 && 1 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 2 == 1
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 2 == 2 && 1 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 2 == 2
#if 1 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 2 == 3 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 2 == 3
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 2 == 4 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 2 == 4
#if 1 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
#if 3 == 1 && 0 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 3 == 1
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 3 == 2 && 0 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 3 == 2
#if 0 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 3 == 3 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 3 == 3
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 3 == 4 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 3 == 4
#if 0 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
#if 3 == 1 && 1 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 3 == 1
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 3 == 2 && 1 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 3 == 2
#if 1 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 3 == 3 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 3 == 3
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 3 == 4 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 3 == 4
#if 1 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
#if 4 == 1 && 0 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 4 == 1
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 4 == 2 && 0 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 4 == 2
#if 0 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 4 == 3 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 4 == 3
#if 0 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 4 == 4 && 0 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 4 == 4
#if 0 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
#if 4 == 1 && 1 == 0
layout(location = 0) out vec4 unused;
#endif
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.0f, 1.0f);
#if 4 == 1
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450

layout(vertices = 4) out;
#if 4 == 2 && 1 == 0
layout(location = 0) out vec4 unused[];
#endif

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
#if 4 == 2
#if 1 == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
#version 450

layout(quads, equal_spacing) in;
#if 4 == 3 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if 4 == 3
#if 1 == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if 4 == 4 && 1 == 0
layout(location = 0) out vec4 unused;
#endif

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
#if 4 == 4
#if 1 == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
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
    float subdivision = float(1);
        gl_TessLevelInner[0] = subdivision;
        gl_TessLevelInner[1] = subdivision;
        gl_TessLevelOuter[0] = subdivision;
        gl_TessLevelOuter[1] = subdivision;
        gl_TessLevelOuter[2] = subdivision;
        gl_TessLevelOuter[3] = subdivision;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450

#if 0 == 0
layout(quads, equal_spacing) in;
#elif 0 == 1
layout(quads, fractional_even_spacing) in;
#else
layout(quads, fractional_odd_spacing) in;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
}
#version 450

#if 1 == 0
layout(quads, equal_spacing) in;
#elif 1 == 1
layout(quads, fractional_even_spacing) in;
#else
layout(quads, fractional_odd_spacing) in;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
}
#version 450

#if 2 == 0
layout(quads, equal_spacing) in;
#elif 2 == 1
layout(quads, fractional_even_spacing) in;
#else
layout(quads, fractional_odd_spacing) in;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
}
#version 450

layout(vertices = 4) out;

void main (void)
{
    if (gl_InvocationID == 0) {
    float subdivision = float(2);
        gl_TessLevelInner[0] = subdivision;
        gl_TessLevelInner[1] = subdivision;
        gl_TessLevelOuter[0] = subdivision;
        gl_TessLevelOuter[1] = subdivision;
        gl_TessLevelOuter[2] = subdivision;
        gl_TessLevelOuter[3] = subdivision;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
out gl_PerVertex {
    vec4 gl_Position;
};
void main(void) {
    const float xCoord = float((gl_VertexIndex >> 0) & 1) * 2.0 - 1.0;
    const float yCoord = float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0;
    gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = inColor;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(vertices=4) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
layout (push_constant, std430) uniform PCBlock { vec4 color; } pc;
layout (location=1) patch out vec4 patchColor;
void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    patchColor = pc.color;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(vertices=4) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
layout (push_constant, std430) uniform PCBlock { vec4 color; } pc;
layout (location=0) patch out vec4 foo;
layout (location=1) patch out vec4 patchColor;
layout (location=2) patch out vec4 bar;
void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    foo        = pc.color.bgra;
    patchColor = pc.color;
    bar        = pc.color.gbra;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(quads) in;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=1) patch in vec4 patchColor;
layout (location=0) out vec4 outColor;
void main() {
    outColor = patchColor;
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position +
                  u   * omv * gl_in[2].gl_Position +
                  u   * v   * gl_in[3].gl_Position +
                  omu * v   * gl_in[1].gl_Position;
}
#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    uint8_t r0;
    uint8_t g0;
    uint8_t b0;
    uint8_t a0;
    uint8_t r1;
    uint8_t g1;
    uint8_t b1;
    uint8_t a1;
    uint8_t r2;
    uint8_t g2;
    uint8_t b2;
    uint8_t a2;
    uint8_t r3;
    uint8_t g3;
    uint8_t b3;
    uint8_t a3;
    uint8_t r4;
    uint8_t g4;
    uint8_t b4;
    uint8_t a4;
    uint8_t r5;
    uint8_t g5;
    uint8_t b5;
    uint8_t a5;
    uint8_t r6;
    uint8_t g6;
    uint8_t b6;
    uint8_t a6;
    uint8_t r7;
    uint8_t g7;
    uint8_t b7;
    uint8_t a7;
    uint8_t r8;
    uint8_t g8;
    uint8_t b8;
    uint8_t a8;
    uint8_t r9;
    uint8_t g9;
    uint8_t b9;
    uint8_t a9;
    uint8_t r10;
    uint8_t g10;
    uint8_t b10;
    uint8_t a10;
    uint8_t r11;
    uint8_t g11;
    uint8_t b11;
    uint8_t a11;
    uint8_t r12;
    uint8_t g12;
    uint8_t b12;
    uint8_t a12;
    uint8_t r13;
    uint8_t g13;
    uint8_t b13;
    uint8_t a13;
    uint8_t r14;
    uint8_t g14;
    uint8_t b14;
    uint8_t a14;
    uint8_t r15;
    uint8_t g15;
    uint8_t b15;
    uint8_t a15;
    uint8_t r16;
    uint8_t g16;
    uint8_t b16;
    uint8_t a16;
    uint8_t r17;
    uint8_t g17;
    uint8_t b17;
    uint8_t a17;
    uint8_t r18;
    uint8_t g18;
    uint8_t b18;
    uint8_t a18;
    uint8_t r19;
    uint8_t g19;
    uint8_t b19;
    uint8_t a19;
    uint8_t r20;
    uint8_t g20;
    uint8_t b20;
    uint8_t a20;
    uint8_t r21;
    uint8_t g21;
    uint8_t b21;
    uint8_t a21;
    uint8_t r22;
    uint8_t g22;
    uint8_t b22;
    uint8_t a22;
    uint8_t r23;
    uint8_t g23;
    uint8_t b23;
    uint8_t a23;
    uint8_t r24;
    uint8_t g24;
    uint8_t b24;
    uint8_t a24;
    uint8_t r25;
    uint8_t g25;
    uint8_t b25;
    uint8_t a25;
    uint8_t r26;
    uint8_t g26;
    uint8_t b26;
    uint8_t a26;
    uint8_t r27;
    uint8_t g27;
    uint8_t b27;
    uint8_t a27;
    uint8_t r28;
    uint8_t g28;
    uint8_t b28;
    uint8_t a28;
    uint8_t r29;
    uint8_t g29;
    uint8_t b29;
    uint8_t a29;
    uint8_t r30;
    uint8_t g30;
    uint8_t b30;
    uint8_t a30;
    uint8_t r31;
    uint8_t g31;
    uint8_t b31;
    uint8_t a31;
    uint8_t r32;
    uint8_t g32;
    uint8_t b32;
    uint8_t a32;
    uint8_t r33;
    uint8_t g33;
    uint8_t b33;
    uint8_t a33;
    uint8_t r34;
    uint8_t g34;
    uint8_t b34;
    uint8_t a34;
    uint8_t r35;
    uint8_t g35;
    uint8_t b35;
    uint8_t a35;
    uint8_t r36;
    uint8_t g36;
    uint8_t b36;
    uint8_t a36;
    uint8_t r37;
    uint8_t g37;
    uint8_t b37;
    uint8_t a37;
    uint8_t r38;
    uint8_t g38;
    uint8_t b38;
    uint8_t a38;
    uint8_t r39;
    uint8_t g39;
    uint8_t b39;
    uint8_t a39;
    uint8_t r40;
    uint8_t g40;
    uint8_t b40;
    uint8_t a40;
    uint8_t r41;
    uint8_t g41;
    uint8_t b41;
    uint8_t a41;
    uint8_t r42;
    uint8_t g42;
    uint8_t b42;
    uint8_t a42;
    uint8_t r43;
    uint8_t g43;
    uint8_t b43;
    uint8_t a43;
    uint8_t r44;
    uint8_t g44;
    uint8_t b44;
    uint8_t a44;
    uint8_t r45;
    uint8_t g45;
    uint8_t b45;
    uint8_t a45;
    uint8_t r46;
    uint8_t g46;
    uint8_t b46;
    uint8_t a46;
    uint8_t r47;
    uint8_t g47;
    uint8_t b47;
    uint8_t a47;
    uint8_t r48;
    uint8_t g48;
    uint8_t b48;
    uint8_t a48;
    uint8_t r49;
    uint8_t g49;
    uint8_t b49;
    uint8_t a49;
    uint8_t r50;
    uint8_t g50;
    uint8_t b50;
    uint8_t a50;
    uint8_t r51;
    uint8_t g51;
    uint8_t b51;
    uint8_t a51;
    uint8_t r52;
    uint8_t g52;
    uint8_t b52;
    uint8_t a52;
    uint8_t r53;
    uint8_t g53;
    uint8_t b53;
    uint8_t a53;
    uint8_t r54;
    uint8_t g54;
    uint8_t b54;
    uint8_t a54;
    uint8_t r55;
    uint8_t g55;
    uint8_t b55;
    uint8_t a55;
    uint8_t r56;
    uint8_t g56;
    uint8_t b56;
    uint8_t a56;
    uint8_t r57;
    uint8_t g57;
    uint8_t b57;
    uint8_t a57;
    uint8_t r58;
    uint8_t g58;
    uint8_t b58;
    uint8_t a58;
    uint8_t r59;
    uint8_t g59;
    uint8_t b59;
    uint8_t a59;
    uint8_t r60;
    uint8_t g60;
    uint8_t b60;
    uint8_t a60;
    uint8_t r61;
    uint8_t g61;
    uint8_t b61;
    uint8_t a61;
    uint8_t r62;
    uint8_t g62;
    uint8_t b62;
    uint8_t a62;
    uint8_t r63;
    uint8_t g63;
    uint8_t b63;
    uint8_t a63;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
color += uvec4(pushConst.r0, pushConst.g0, pushConst.b0, pushConst.a0);
color += uvec4(pushConst.r1, pushConst.g1, pushConst.b1, pushConst.a1);
color += uvec4(pushConst.r2, pushConst.g2, pushConst.b2, pushConst.a2);
color += uvec4(pushConst.r3, pushConst.g3, pushConst.b3, pushConst.a3);
color += uvec4(pushConst.r4, pushConst.g4, pushConst.b4, pushConst.a4);
color += uvec4(pushConst.r5, pushConst.g5, pushConst.b5, pushConst.a5);
color += uvec4(pushConst.r6, pushConst.g6, pushConst.b6, pushConst.a6);
color += uvec4(pushConst.r7, pushConst.g7, pushConst.b7, pushConst.a7);
color += uvec4(pushConst.r8, pushConst.g8, pushConst.b8, pushConst.a8);
color += uvec4(pushConst.r9, pushConst.g9, pushConst.b9, pushConst.a9);
color += uvec4(pushConst.r10, pushConst.g10, pushConst.b10, pushConst.a10);
color += uvec4(pushConst.r11, pushConst.g11, pushConst.b11, pushConst.a11);
color += uvec4(pushConst.r12, pushConst.g12, pushConst.b12, pushConst.a12);
color += uvec4(pushConst.r13, pushConst.g13, pushConst.b13, pushConst.a13);
color += uvec4(pushConst.r14, pushConst.g14, pushConst.b14, pushConst.a14);
color += uvec4(pushConst.r15, pushConst.g15, pushConst.b15, pushConst.a15);
color += uvec4(pushConst.r16, pushConst.g16, pushConst.b16, pushConst.a16);
color += uvec4(pushConst.r17, pushConst.g17, pushConst.b17, pushConst.a17);
color += uvec4(pushConst.r18, pushConst.g18, pushConst.b18, pushConst.a18);
color += uvec4(pushConst.r19, pushConst.g19, pushConst.b19, pushConst.a19);
color += uvec4(pushConst.r20, pushConst.g20, pushConst.b20, pushConst.a20);
color += uvec4(pushConst.r21, pushConst.g21, pushConst.b21, pushConst.a21);
color += uvec4(pushConst.r22, pushConst.g22, pushConst.b22, pushConst.a22);
color += uvec4(pushConst.r23, pushConst.g23, pushConst.b23, pushConst.a23);
color += uvec4(pushConst.r24, pushConst.g24, pushConst.b24, pushConst.a24);
color += uvec4(pushConst.r25, pushConst.g25, pushConst.b25, pushConst.a25);
color += uvec4(pushConst.r26, pushConst.g26, pushConst.b26, pushConst.a26);
color += uvec4(pushConst.r27, pushConst.g27, pushConst.b27, pushConst.a27);
color += uvec4(pushConst.r28, pushConst.g28, pushConst.b28, pushConst.a28);
color += uvec4(pushConst.r29, pushConst.g29, pushConst.b29, pushConst.a29);
color += uvec4(pushConst.r30, pushConst.g30, pushConst.b30, pushConst.a30);
color += uvec4(pushConst.r31, pushConst.g31, pushConst.b31, pushConst.a31);
color += uvec4(pushConst.r32, pushConst.g32, pushConst.b32, pushConst.a32);
color += uvec4(pushConst.r33, pushConst.g33, pushConst.b33, pushConst.a33);
color += uvec4(pushConst.r34, pushConst.g34, pushConst.b34, pushConst.a34);
color += uvec4(pushConst.r35, pushConst.g35, pushConst.b35, pushConst.a35);
color += uvec4(pushConst.r36, pushConst.g36, pushConst.b36, pushConst.a36);
color += uvec4(pushConst.r37, pushConst.g37, pushConst.b37, pushConst.a37);
color += uvec4(pushConst.r38, pushConst.g38, pushConst.b38, pushConst.a38);
color += uvec4(pushConst.r39, pushConst.g39, pushConst.b39, pushConst.a39);
color += uvec4(pushConst.r40, pushConst.g40, pushConst.b40, pushConst.a40);
color += uvec4(pushConst.r41, pushConst.g41, pushConst.b41, pushConst.a41);
color += uvec4(pushConst.r42, pushConst.g42, pushConst.b42, pushConst.a42);
color += uvec4(pushConst.r43, pushConst.g43, pushConst.b43, pushConst.a43);
color += uvec4(pushConst.r44, pushConst.g44, pushConst.b44, pushConst.a44);
color += uvec4(pushConst.r45, pushConst.g45, pushConst.b45, pushConst.a45);
color += uvec4(pushConst.r46, pushConst.g46, pushConst.b46, pushConst.a46);
color += uvec4(pushConst.r47, pushConst.g47, pushConst.b47, pushConst.a47);
color += uvec4(pushConst.r48, pushConst.g48, pushConst.b48, pushConst.a48);
color += uvec4(pushConst.r49, pushConst.g49, pushConst.b49, pushConst.a49);
color += uvec4(pushConst.r50, pushConst.g50, pushConst.b50, pushConst.a50);
color += uvec4(pushConst.r51, pushConst.g51, pushConst.b51, pushConst.a51);
color += uvec4(pushConst.r52, pushConst.g52, pushConst.b52, pushConst.a52);
color += uvec4(pushConst.r53, pushConst.g53, pushConst.b53, pushConst.a53);
color += uvec4(pushConst.r54, pushConst.g54, pushConst.b54, pushConst.a54);
color += uvec4(pushConst.r55, pushConst.g55, pushConst.b55, pushConst.a55);
color += uvec4(pushConst.r56, pushConst.g56, pushConst.b56, pushConst.a56);
    color += uvec4(255, pushConst.b57, pushConst.g57, 17);
color += uvec4(pushConst.r58, pushConst.g58, pushConst.b58, pushConst.a58);
color += uvec4(pushConst.r59, pushConst.g59, pushConst.b59, pushConst.a59);
color += uvec4(pushConst.r60, pushConst.g60, pushConst.b60, pushConst.a60);
color += uvec4(pushConst.r61, pushConst.g61, pushConst.b61, pushConst.a61);
color += uvec4(pushConst.r62, pushConst.g62, pushConst.b62, pushConst.a62);
color += uvec4(pushConst.r63, pushConst.g63, pushConst.b63, pushConst.a63);
    outColor = color;
}
#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    uint8_t r0;
    uint8_t g0;
    uint8_t b0;
    uint8_t a0;
    uint8_t r1;
    uint8_t g1;
    uint8_t b1;
    uint8_t a1;
    uint8_t r2;
    uint8_t g2;
    uint8_t b2;
    uint8_t a2;
    uint8_t r3;
    uint8_t g3;
    uint8_t b3;
    uint8_t a3;
    uint8_t r4;
    uint8_t g4;
    uint8_t b4;
    uint8_t a4;
    uint8_t r5;
    uint8_t g5;
    uint8_t b5;
    uint8_t a5;
    uint8_t r6;
    uint8_t g6;
    uint8_t b6;
    uint8_t a6;
    uint8_t r7;
    uint8_t g7;
    uint8_t b7;
    uint8_t a7;
    uint8_t r8;
    uint8_t g8;
    uint8_t b8;
    uint8_t a8;
    uint8_t r9;
    uint8_t g9;
    uint8_t b9;
    uint8_t a9;
    uint8_t r10;
    uint8_t g10;
    uint8_t b10;
    uint8_t a10;
    uint8_t r11;
    uint8_t g11;
    uint8_t b11;
    uint8_t a11;
    uint8_t r12;
    uint8_t g12;
    uint8_t b12;
    uint8_t a12;
    uint8_t r13;
    uint8_t g13;
    uint8_t b13;
    uint8_t a13;
    uint8_t r14;
    uint8_t g14;
    uint8_t b14;
    uint8_t a14;
    uint8_t r15;
    uint8_t g15;
    uint8_t b15;
    uint8_t a15;
    uint8_t r16;
    uint8_t g16;
    uint8_t b16;
    uint8_t a16;
    uint8_t r17;
    uint8_t g17;
    uint8_t b17;
    uint8_t a17;
    uint8_t r18;
    uint8_t g18;
    uint8_t b18;
    uint8_t a18;
    uint8_t r19;
    uint8_t g19;
    uint8_t b19;
    uint8_t a19;
    uint8_t r20;
    uint8_t g20;
    uint8_t b20;
    uint8_t a20;
    uint8_t r21;
    uint8_t g21;
    uint8_t b21;
    uint8_t a21;
    uint8_t r22;
    uint8_t g22;
    uint8_t b22;
    uint8_t a22;
    uint8_t r23;
    uint8_t g23;
    uint8_t b23;
    uint8_t a23;
    uint8_t r24;
    uint8_t g24;
    uint8_t b24;
    uint8_t a24;
    uint8_t r25;
    uint8_t g25;
    uint8_t b25;
    uint8_t a25;
    uint8_t r26;
    uint8_t g26;
    uint8_t b26;
    uint8_t a26;
    uint8_t r27;
    uint8_t g27;
    uint8_t b27;
    uint8_t a27;
    uint8_t r28;
    uint8_t g28;
    uint8_t b28;
    uint8_t a28;
    uint8_t r29;
    uint8_t g29;
    uint8_t b29;
    uint8_t a29;
    uint8_t r30;
    uint8_t g30;
    uint8_t b30;
    uint8_t a30;
    uint8_t r31;
    uint8_t g31;
    uint8_t b31;
    uint8_t a31;
    uint8_t r32;
    uint8_t g32;
    uint8_t b32;
    uint8_t a32;
    uint8_t r33;
    uint8_t g33;
    uint8_t b33;
    uint8_t a33;
    uint8_t r34;
    uint8_t g34;
    uint8_t b34;
    uint8_t a34;
    uint8_t r35;
    uint8_t g35;
    uint8_t b35;
    uint8_t a35;
    uint8_t r36;
    uint8_t g36;
    uint8_t b36;
    uint8_t a36;
    uint8_t r37;
    uint8_t g37;
    uint8_t b37;
    uint8_t a37;
    uint8_t r38;
    uint8_t g38;
    uint8_t b38;
    uint8_t a38;
    uint8_t r39;
    uint8_t g39;
    uint8_t b39;
    uint8_t a39;
    uint8_t r40;
    uint8_t g40;
    uint8_t b40;
    uint8_t a40;
    uint8_t r41;
    uint8_t g41;
    uint8_t b41;
    uint8_t a41;
    uint8_t r42;
    uint8_t g42;
    uint8_t b42;
    uint8_t a42;
    uint8_t r43;
    uint8_t g43;
    uint8_t b43;
    uint8_t a43;
    uint8_t r44;
    uint8_t g44;
    uint8_t b44;
    uint8_t a44;
    uint8_t r45;
    uint8_t g45;
    uint8_t b45;
    uint8_t a45;
    uint8_t r46;
    uint8_t g46;
    uint8_t b46;
    uint8_t a46;
    uint8_t r47;
    uint8_t g47;
    uint8_t b47;
    uint8_t a47;
    uint8_t r48;
    uint8_t g48;
    uint8_t b48;
    uint8_t a48;
    uint8_t r49;
    uint8_t g49;
    uint8_t b49;
    uint8_t a49;
    uint8_t r50;
    uint8_t g50;
    uint8_t b50;
    uint8_t a50;
    uint8_t r51;
    uint8_t g51;
    uint8_t b51;
    uint8_t a51;
    uint8_t r52;
    uint8_t g52;
    uint8_t b52;
    uint8_t a52;
    uint8_t r53;
    uint8_t g53;
    uint8_t b53;
    uint8_t a53;
    uint8_t r54;
    uint8_t g54;
    uint8_t b54;
    uint8_t a54;
    uint8_t r55;
    uint8_t g55;
    uint8_t b55;
    uint8_t a55;
    uint8_t r56;
    uint8_t g56;
    uint8_t b56;
    uint8_t a56;
    uint8_t r57;
    uint8_t g57;
    uint8_t b57;
    uint8_t a57;
    uint8_t r58;
    uint8_t g58;
    uint8_t b58;
    uint8_t a58;
    uint8_t r59;
    uint8_t g59;
    uint8_t b59;
    uint8_t a59;
    uint8_t r60;
    uint8_t g60;
    uint8_t b60;
    uint8_t a60;
    uint8_t r61;
    uint8_t g61;
    uint8_t b61;
    uint8_t a61;
    uint8_t r62;
    uint8_t g62;
    uint8_t b62;
    uint8_t a62;
    uint8_t r63;
    uint8_t g63;
    uint8_t b63;
    uint8_t a63;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
color += uvec4(pushConst.r0, pushConst.g0, pushConst.b0, pushConst.a0);
color += uvec4(pushConst.r1, pushConst.g1, pushConst.b1, pushConst.a1);
color += uvec4(pushConst.r2, pushConst.g2, pushConst.b2, pushConst.a2);
color += uvec4(pushConst.r3, pushConst.g3, pushConst.b3, pushConst.a3);
color += uvec4(pushConst.r4, pushConst.g4, pushConst.b4, pushConst.a4);
color += uvec4(pushConst.r5, pushConst.g5, pushConst.b5, pushConst.a5);
color += uvec4(pushConst.r6, pushConst.g6, pushConst.b6, pushConst.a6);
color += uvec4(pushConst.r7, pushConst.g7, pushConst.b7, pushConst.a7);
color += uvec4(pushConst.r8, pushConst.g8, pushConst.b8, pushConst.a8);
color += uvec4(pushConst.r9, pushConst.g9, pushConst.b9, pushConst.a9);
color += uvec4(pushConst.r10, pushConst.g10, pushConst.b10, pushConst.a10);
color += uvec4(pushConst.r11, pushConst.g11, pushConst.b11, pushConst.a11);
color += uvec4(pushConst.r12, pushConst.g12, pushConst.b12, pushConst.a12);
color += uvec4(pushConst.r13, pushConst.g13, pushConst.b13, pushConst.a13);
color += uvec4(pushConst.r14, pushConst.g14, pushConst.b14, pushConst.a14);
color += uvec4(pushConst.r15, pushConst.g15, pushConst.b15, pushConst.a15);
color += uvec4(pushConst.r16, pushConst.g16, pushConst.b16, pushConst.a16);
color += uvec4(pushConst.r17, pushConst.g17, pushConst.b17, pushConst.a17);
color += uvec4(pushConst.r18, pushConst.g18, pushConst.b18, pushConst.a18);
color += uvec4(pushConst.r19, pushConst.g19, pushConst.b19, pushConst.a19);
color += uvec4(pushConst.r20, pushConst.g20, pushConst.b20, pushConst.a20);
color += uvec4(pushConst.r21, pushConst.g21, pushConst.b21, pushConst.a21);
color += uvec4(pushConst.r22, pushConst.g22, pushConst.b22, pushConst.a22);
color += uvec4(pushConst.r23, pushConst.g23, pushConst.b23, pushConst.a23);
color += uvec4(pushConst.r24, pushConst.g24, pushConst.b24, pushConst.a24);
color += uvec4(pushConst.r25, pushConst.g25, pushConst.b25, pushConst.a25);
color += uvec4(pushConst.r26, pushConst.g26, pushConst.b26, pushConst.a26);
color += uvec4(pushConst.r27, pushConst.g27, pushConst.b27, pushConst.a27);
color += uvec4(pushConst.r28, pushConst.g28, pushConst.b28, pushConst.a28);
color += uvec4(pushConst.r29, pushConst.g29, pushConst.b29, pushConst.a29);
color += uvec4(pushConst.r30, pushConst.g30, pushConst.b30, pushConst.a30);
color += uvec4(pushConst.r31, pushConst.g31, pushConst.b31, pushConst.a31);
color += uvec4(pushConst.r32, pushConst.g32, pushConst.b32, pushConst.a32);
color += uvec4(pushConst.r33, pushConst.g33, pushConst.b33, pushConst.a33);
color += uvec4(pushConst.r34, pushConst.g34, pushConst.b34, pushConst.a34);
color += uvec4(pushConst.r35, pushConst.g35, pushConst.b35, pushConst.a35);
color += uvec4(pushConst.r36, pushConst.g36, pushConst.b36, pushConst.a36);
color += uvec4(pushConst.r37, pushConst.g37, pushConst.b37, pushConst.a37);
color += uvec4(pushConst.r38, pushConst.g38, pushConst.b38, pushConst.a38);
color += uvec4(pushConst.r39, pushConst.g39, pushConst.b39, pushConst.a39);
color += uvec4(pushConst.r40, pushConst.g40, pushConst.b40, pushConst.a40);
color += uvec4(pushConst.r41, pushConst.g41, pushConst.b41, pushConst.a41);
color += uvec4(pushConst.r42, pushConst.g42, pushConst.b42, pushConst.a42);
color += uvec4(pushConst.r43, pushConst.g43, pushConst.b43, pushConst.a43);
color += uvec4(pushConst.r44, pushConst.g44, pushConst.b44, pushConst.a44);
color += uvec4(pushConst.r45, pushConst.g45, pushConst.b45, pushConst.a45);
color += uvec4(pushConst.r46, pushConst.g46, pushConst.b46, pushConst.a46);
color += uvec4(pushConst.r47, pushConst.g47, pushConst.b47, pushConst.a47);
color += uvec4(pushConst.r48, pushConst.g48, pushConst.b48, pushConst.a48);
color += uvec4(pushConst.r49, pushConst.g49, pushConst.b49, pushConst.a49);
color += uvec4(pushConst.r50, pushConst.g50, pushConst.b50, pushConst.a50);
color += uvec4(pushConst.r51, pushConst.g51, pushConst.b51, pushConst.a51);
color += uvec4(pushConst.r52, pushConst.g52, pushConst.b52, pushConst.a52);
color += uvec4(pushConst.r53, pushConst.g53, pushConst.b53, pushConst.a53);
color += uvec4(pushConst.r54, pushConst.g54, pushConst.b54, pushConst.a54);
color += uvec4(pushConst.r55, pushConst.g55, pushConst.b55, pushConst.a55);
color += uvec4(pushConst.r56, pushConst.g56, pushConst.b56, pushConst.a56);
color += uvec4(pushConst.r57, pushConst.g57, pushConst.b57, pushConst.a57);
color += uvec4(pushConst.r58, pushConst.g58, pushConst.b58, pushConst.a58);
color += uvec4(pushConst.r59, pushConst.g59, pushConst.b59, pushConst.a59);
color += uvec4(pushConst.r60, pushConst.g60, pushConst.b60, pushConst.a60);
color += uvec4(pushConst.r61, pushConst.g61, pushConst.b61, pushConst.a61);
color += uvec4(pushConst.r62, pushConst.g62, pushConst.b62, pushConst.a62);
    color += uvec4(255, pushConst.b63, pushConst.g63, 17);
    outColor = color;
}
#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    layout(offset = 69) uint8_t g17;
    uint8_t b17;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
    color += uvec4(255, pushConst.b17, pushConst.g17, 17);
    outColor = color;
}
#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    layout(offset = 253) uint8_t g63;
    uint8_t b63;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
    color += uvec4(255, pushConst.b63, pushConst.g63, 17);
    outColor = color;
}
#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    uint8_t r0;
    uint8_t g0;
    uint8_t b0;
    uint8_t a0;
    uint8_t r1;
    uint8_t g1;
    uint8_t b1;
    uint8_t a1;
    uint8_t r2;
    uint8_t g2;
    uint8_t b2;
    uint8_t a2;
    uint8_t r3;
    uint8_t g3;
    uint8_t b3;
    uint8_t a3;
    uint8_t r4;
    uint8_t g4;
    uint8_t b4;
    uint8_t a4;
    uint8_t r5;
    uint8_t g5;
    uint8_t b5;
    uint8_t a5;
    uint8_t r6;
    uint8_t g6;
    uint8_t b6;
    uint8_t a6;
    uint8_t r7;
    uint8_t g7;
    uint8_t b7;
    uint8_t a7;
    uint8_t r8;
    uint8_t g8;
    uint8_t b8;
    uint8_t a8;
    uint8_t r9;
    uint8_t g9;
    uint8_t b9;
    uint8_t a9;
    uint8_t r10;
    uint8_t g10;
    uint8_t b10;
    uint8_t a10;
    uint8_t r11;
    uint8_t g11;
    uint8_t b11;
    uint8_t a11;
    uint8_t r12;
    uint8_t g12;
    uint8_t b12;
    uint8_t a12;
    uint8_t r13;
    uint8_t g13;
    uint8_t b13;
    uint8_t a13;
    uint8_t r14;
    uint8_t g14;
    uint8_t b14;
    uint8_t a14;
    uint8_t r15;
    uint8_t g15;
    uint8_t b15;
    uint8_t a15;
    uint8_t r16;
    uint8_t g16;
    uint8_t b16;
    uint8_t a16;
    uint8_t r17;
    uint8_t g17;
    uint8_t b17;
    uint8_t a17;
    uint8_t r18;
    uint8_t g18;
    uint8_t b18;
    uint8_t a18;
    uint8_t r19;
    uint8_t g19;
    uint8_t b19;
    uint8_t a19;
    uint8_t r20;
    uint8_t g20;
    uint8_t b20;
    uint8_t a20;
    uint8_t r21;
    uint8_t g21;
    uint8_t b21;
    uint8_t a21;
    uint8_t r22;
    uint8_t g22;
    uint8_t b22;
    uint8_t a22;
    uint8_t r23;
    uint8_t g23;
    uint8_t b23;
    uint8_t a23;
    uint8_t r24;
    uint8_t g24;
    uint8_t b24;
    uint8_t a24;
    uint8_t r25;
    uint8_t g25;
    uint8_t b25;
    uint8_t a25;
    uint8_t r26;
    uint8_t g26;
    uint8_t b26;
    uint8_t a26;
    uint8_t r27;
    uint8_t g27;
    uint8_t b27;
    uint8_t a27;
    uint8_t r28;
    uint8_t g28;
    uint8_t b28;
    uint8_t a28;
    uint8_t r29;
    uint8_t g29;
    uint8_t b29;
    uint8_t a29;
    uint8_t r30;
    uint8_t g30;
    uint8_t b30;
    uint8_t a30;
    uint8_t r31;
    uint8_t g31;
    uint8_t b31;
    uint8_t a31;
    uint8_t r32;
    uint8_t g32;
    uint8_t b32;
    uint8_t a32;
    uint8_t r33;
    uint8_t g33;
    uint8_t b33;
    uint8_t a33;
    uint8_t r34;
    uint8_t g34;
    uint8_t b34;
    uint8_t a34;
    uint8_t r35;
    uint8_t g35;
    uint8_t b35;
    uint8_t a35;
    uint8_t r36;
    uint8_t g36;
    uint8_t b36;
    uint8_t a36;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
color += uvec4(pushConst.r0, pushConst.g0, pushConst.b0, pushConst.a0);
color += uvec4(pushConst.r1, pushConst.g1, pushConst.b1, pushConst.a1);
color += uvec4(pushConst.r2, pushConst.g2, pushConst.b2, pushConst.a2);
color += uvec4(pushConst.r3, pushConst.g3, pushConst.b3, pushConst.a3);
color += uvec4(pushConst.r4, pushConst.g4, pushConst.b4, pushConst.a4);
color += uvec4(pushConst.r5, pushConst.g5, pushConst.b5, pushConst.a5);
color += uvec4(pushConst.r6, pushConst.g6, pushConst.b6, pushConst.a6);
color += uvec4(pushConst.r7, pushConst.g7, pushConst.b7, pushConst.a7);
color += uvec4(pushConst.r8, pushConst.g8, pushConst.b8, pushConst.a8);
color += uvec4(pushConst.r9, pushConst.g9, pushConst.b9, pushConst.a9);
color += uvec4(pushConst.r10, pushConst.g10, pushConst.b10, pushConst.a10);
color += uvec4(pushConst.r11, pushConst.g11, pushConst.b11, pushConst.a11);
color += uvec4(pushConst.r12, pushConst.g12, pushConst.b12, pushConst.a12);
color += uvec4(pushConst.r13, pushConst.g13, pushConst.b13, pushConst.a13);
color += uvec4(pushConst.r14, pushConst.g14, pushConst.b14, pushConst.a14);
color += uvec4(pushConst.r15, pushConst.g15, pushConst.b15, pushConst.a15);
color += uvec4(pushConst.r16, pushConst.g16, pushConst.b16, pushConst.a16);
    color += uvec4(255, pushConst.b17, pushConst.g17, 17);
color += uvec4(pushConst.r18, pushConst.g18, pushConst.b18, pushConst.a18);
color += uvec4(pushConst.r19, pushConst.g19, pushConst.b19, pushConst.a19);
color += uvec4(pushConst.r20, pushConst.g20, pushConst.b20, pushConst.a20);
color += uvec4(pushConst.r21, pushConst.g21, pushConst.b21, pushConst.a21);
color += uvec4(pushConst.r22, pushConst.g22, pushConst.b22, pushConst.a22);
color += uvec4(pushConst.r23, pushConst.g23, pushConst.b23, pushConst.a23);
color += uvec4(pushConst.r24, pushConst.g24, pushConst.b24, pushConst.a24);
color += uvec4(pushConst.r25, pushConst.g25, pushConst.b25, pushConst.a25);
color += uvec4(pushConst.r26, pushConst.g26, pushConst.b26, pushConst.a26);
color += uvec4(pushConst.r27, pushConst.g27, pushConst.b27, pushConst.a27);
color += uvec4(pushConst.r28, pushConst.g28, pushConst.b28, pushConst.a28);
color += uvec4(pushConst.r29, pushConst.g29, pushConst.b29, pushConst.a29);
color += uvec4(pushConst.r30, pushConst.g30, pushConst.b30, pushConst.a30);
color += uvec4(pushConst.r31, pushConst.g31, pushConst.b31, pushConst.a31);
color += uvec4(pushConst.r32, pushConst.g32, pushConst.b32, pushConst.a32);
color += uvec4(pushConst.r33, pushConst.g33, pushConst.b33, pushConst.a33);
color += uvec4(pushConst.r34, pushConst.g34, pushConst.b34, pushConst.a34);
color += uvec4(pushConst.r35, pushConst.g35, pushConst.b35, pushConst.a35);
color += uvec4(pushConst.r36, pushConst.g36, pushConst.b36, pushConst.a36);
    outColor = color;
}
#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    uint8_t r0;
    uint8_t g0;
    uint8_t b0;
    uint8_t a0;
    uint8_t r1;
    uint8_t g1;
    uint8_t b1;
    uint8_t a1;
    uint8_t r2;
    uint8_t g2;
    uint8_t b2;
    uint8_t a2;
    uint8_t r3;
    uint8_t g3;
    uint8_t b3;
    uint8_t a3;
    uint8_t r4;
    uint8_t g4;
    uint8_t b4;
    uint8_t a4;
    uint8_t r5;
    uint8_t g5;
    uint8_t b5;
    uint8_t a5;
    uint8_t r6;
    uint8_t g6;
    uint8_t b6;
    uint8_t a6;
    uint8_t r7;
    uint8_t g7;
    uint8_t b7;
    uint8_t a7;
    uint8_t r8;
    uint8_t g8;
    uint8_t b8;
    uint8_t a8;
    uint8_t r9;
    uint8_t g9;
    uint8_t b9;
    uint8_t a9;
    uint8_t r10;
    uint8_t g10;
    uint8_t b10;
    uint8_t a10;
    uint8_t r11;
    uint8_t g11;
    uint8_t b11;
    uint8_t a11;
    uint8_t r12;
    uint8_t g12;
    uint8_t b12;
    uint8_t a12;
    uint8_t r13;
    uint8_t g13;
    uint8_t b13;
    uint8_t a13;
    uint8_t r14;
    uint8_t g14;
    uint8_t b14;
    uint8_t a14;
    uint8_t r15;
    uint8_t g15;
    uint8_t b15;
    uint8_t a15;
    uint8_t r16;
    uint8_t g16;
    uint8_t b16;
    uint8_t a16;
    uint8_t r17;
    uint8_t g17;
    uint8_t b17;
    uint8_t a17;
    uint8_t r18;
    uint8_t g18;
    uint8_t b18;
    uint8_t a18;
    uint8_t r19;
    uint8_t g19;
    uint8_t b19;
    uint8_t a19;
    uint8_t r20;
    uint8_t g20;
    uint8_t b20;
    uint8_t a20;
    uint8_t r21;
    uint8_t g21;
    uint8_t b21;
    uint8_t a21;
    uint8_t r22;
    uint8_t g22;
    uint8_t b22;
    uint8_t a22;
    uint8_t r23;
    uint8_t g23;
    uint8_t b23;
    uint8_t a23;
    uint8_t r24;
    uint8_t g24;
    uint8_t b24;
    uint8_t a24;
    uint8_t r25;
    uint8_t g25;
    uint8_t b25;
    uint8_t a25;
    uint8_t r26;
    uint8_t g26;
    uint8_t b26;
    uint8_t a26;
    uint8_t r27;
    uint8_t g27;
    uint8_t b27;
    uint8_t a27;
    uint8_t r28;
    uint8_t g28;
    uint8_t b28;
    uint8_t a28;
    uint8_t r29;
    uint8_t g29;
    uint8_t b29;
    uint8_t a29;
    uint8_t r30;
    uint8_t g30;
    uint8_t b30;
    uint8_t a30;
    uint8_t r31;
    uint8_t g31;
    uint8_t b31;
    uint8_t a31;
    uint8_t r32;
    uint8_t g32;
    uint8_t b32;
    uint8_t a32;
    uint8_t r33;
    uint8_t g33;
    uint8_t b33;
    uint8_t a33;
    uint8_t r34;
    uint8_t g34;
    uint8_t b34;
    uint8_t a34;
    uint8_t r35;
    uint8_t g35;
    uint8_t b35;
    uint8_t a35;
    uint8_t r36;
    uint8_t g36;
    uint8_t b36;
    uint8_t a36;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
color += uvec4(pushConst.r0, pushConst.g0, pushConst.b0, pushConst.a0);
color += uvec4(pushConst.r1, pushConst.g1, pushConst.b1, pushConst.a1);
color += uvec4(pushConst.r2, pushConst.g2, pushConst.b2, pushConst.a2);
color += uvec4(pushConst.r3, pushConst.g3, pushConst.b3, pushConst.a3);
color += uvec4(pushConst.r4, pushConst.g4, pushConst.b4, pushConst.a4);
color += uvec4(pushConst.r5, pushConst.g5, pushConst.b5, pushConst.a5);
color += uvec4(pushConst.r6, pushConst.g6, pushConst.b6, pushConst.a6);
color += uvec4(pushConst.r7, pushConst.g7, pushConst.b7, pushConst.a7);
color += uvec4(pushConst.r8, pushConst.g8, pushConst.b8, pushConst.a8);
color += uvec4(pushConst.r9, pushConst.g9, pushConst.b9, pushConst.a9);
color += uvec4(pushConst.r10, pushConst.g10, pushConst.b10, pushConst.a10);
color += uvec4(pushConst.r11, pushConst.g11, pushConst.b11, pushConst.a11);
color += uvec4(pushConst.r12, pushConst.g12, pushConst.b12, pushConst.a12);
color += uvec4(pushConst.r13, pushConst.g13, pushConst.b13, pushConst.a13);
color += uvec4(pushConst.r14, pushConst.g14, pushConst.b14, pushConst.a14);
color += uvec4(pushConst.r15, pushConst.g15, pushConst.b15, pushConst.a15);
color += uvec4(pushConst.r16, pushConst.g16, pushConst.b16, pushConst.a16);
color += uvec4(pushConst.r17, pushConst.g17, pushConst.b17, pushConst.a17);
color += uvec4(pushConst.r18, pushConst.g18, pushConst.b18, pushConst.a18);
color += uvec4(pushConst.r19, pushConst.g19, pushConst.b19, pushConst.a19);
color += uvec4(pushConst.r20, pushConst.g20, pushConst.b20, pushConst.a20);
color += uvec4(pushConst.r21, pushConst.g21, pushConst.b21, pushConst.a21);
color += uvec4(pushConst.r22, pushConst.g22, pushConst.b22, pushConst.a22);
color += uvec4(pushConst.r23, pushConst.g23, pushConst.b23, pushConst.a23);
color += uvec4(pushConst.r24, pushConst.g24, pushConst.b24, pushConst.a24);
color += uvec4(pushConst.r25, pushConst.g25, pushConst.b25, pushConst.a25);
color += uvec4(pushConst.r26, pushConst.g26, pushConst.b26, pushConst.a26);
color += uvec4(pushConst.r27, pushConst.g27, pushConst.b27, pushConst.a27);
color += uvec4(pushConst.r28, pushConst.g28, pushConst.b28, pushConst.a28);
color += uvec4(pushConst.r29, pushConst.g29, pushConst.b29, pushConst.a29);
color += uvec4(pushConst.r30, pushConst.g30, pushConst.b30, pushConst.a30);
color += uvec4(pushConst.r31, pushConst.g31, pushConst.b31, pushConst.a31);
color += uvec4(pushConst.r32, pushConst.g32, pushConst.b32, pushConst.a32);
color += uvec4(pushConst.r33, pushConst.g33, pushConst.b33, pushConst.a33);
color += uvec4(pushConst.r34, pushConst.g34, pushConst.b34, pushConst.a34);
color += uvec4(pushConst.r35, pushConst.g35, pushConst.b35, pushConst.a35);
    color += uvec4(255, pushConst.b36, pushConst.g36, 17);
    outColor = color;
}
#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    layout(offset = 145) uint8_t g36;
    uint8_t b36;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
    color += uvec4(255, pushConst.b36, pushConst.g36, 17);
    outColor = color;
}
