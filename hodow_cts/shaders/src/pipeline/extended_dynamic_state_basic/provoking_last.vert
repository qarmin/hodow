#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in vec2 position;
layout(location=0) flat out uint colorMultiplier;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    vec2 vertexCoords = position;
    const bool provokingLast = true;
    colorMultiplier = (((!provokingLast && gl_VertexIndex == 0) || (provokingLast && gl_VertexIndex == 2)) ? 1 : 0);
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
