#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
void main (void) {
    gl_Position = inPos;
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.125;
}
