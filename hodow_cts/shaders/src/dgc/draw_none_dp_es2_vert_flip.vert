#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=3) out flat int drawIndex;
layout (location=4) out flat int baseVertex;
layout (location=5) out flat int baseInstance;
void main (void) {
    const bool passFlipFactorDown = false;
    const bool flippedTriangle = (gl_VertexIndex < 6);
    drawIndex = gl_DrawID;
    baseVertex = gl_BaseVertex;
    baseInstance = gl_BaseInstance;
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
