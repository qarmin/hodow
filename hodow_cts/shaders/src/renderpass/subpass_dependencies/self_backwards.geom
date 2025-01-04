#version 450
layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};
layout (binding = 0) buffer IndirectBuffer
{
    uint vertexCount;
    uint instanceCount;
    uint firstVertex;
    uint firstInstance;
} indirectBuffer;

void main (void) {
    vec4 p = gl_in[0].gl_Position;
    float offset = 0.03f;
    gl_Position = p + vec4(-offset, offset, 0, 0);
    EmitVertex();
    gl_Position = p + vec4(-offset, -offset, 0, 0);
    EmitVertex();
    gl_Position = p + vec4(offset, offset, 0, 0);
    EmitVertex();
    gl_Position = p + vec4(offset, -offset, 0, 0);
    EmitVertex();
    EndPrimitive();
    indirectBuffer.vertexCount = 64;
    indirectBuffer.instanceCount = 1;
    indirectBuffer.firstVertex = 64;
    indirectBuffer.firstInstance = 0;
}
