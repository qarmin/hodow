#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
} pushConstants;
layout(location=0) in vec2 position;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main() {
    vec2 vertexCoords = position;
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
}
