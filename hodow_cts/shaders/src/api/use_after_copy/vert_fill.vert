#version 460
${ext}layout (location=0) out flat uint layerIndex;
void main(void) {
    const float x = float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0;
    const float y = float((gl_VertexIndex >> 0) & 1) * 2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
    gl_PointSize = 1.0;
    layerIndex = uint(gl_InstanceIndex);
${layer}}
