#version 450
layout(location = 0) in highp vec4 position;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = position;
}
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
#version 450
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vec4(1, 0, 0, 1);
}
#version 450
layout(location = 0) in vec4 inPosition;
void main (void)
{
    gl_Position = inPosition;
}
#version 450
layout(location = 0) out vec4 outGBuffer;
layout(location = 1) out vec4 outResolvedColor;
void main (void)
{
    outGBuffer = vec4(0.0, 1.0, 0.0, 1.0);
    outResolvedColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(set = 0, input_attachment_index = 0, binding = 0) uniform subpassInput inGBuffer;
layout(location = 0) out vec4 outColor;
void main (void)
{
    outColor = subpassLoad(inGBuffer);
}
