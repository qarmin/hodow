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
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
} pushConstants;
layout(location=0) out vec4 color0;
layout(location=1) out vec4 color1;
layout(location=2) out vec4 color2;
void main() {
    color0 = pushConstants.triangleColor * 1;
    color1 = pushConstants.triangleColor * 0.5;
    color2 = pushConstants.triangleColor * 0.25;
}
#version 450
layout(location = 0) in vec4 position;
layout(location = 0) out flat int instance;
void main() {
    gl_Position = vec4(position.xy, 0.0, 1.0);
    instance = gl_InstanceIndex;
}
#version 450
layout(location = 0) in flat int attachments;
layout(location = 0) out vec4 colors[3];
void main() {
    for (int a = 0; a < attachments; ++a) {
        float c = float(attachments - a);
        colors[a] = vec4(pow(0.5, c));
}}
#version 450
layout(location = 0) in flat int attachments;
layout(location = 0) out vec4 colors[4];
void main() {
    for (int a = 0; a < attachments; ++a) {
        float c = float(attachments - a);
        colors[a] = vec4(pow(0.5, c));
}}
#version 450
layout(location = 0) in flat int attachments;
layout(location = 0) out vec4 colors[5];
void main() {
    for (int a = 0; a < attachments; ++a) {
        float c = float(attachments - a);
        colors[a] = vec4(pow(0.5, c));
}}
