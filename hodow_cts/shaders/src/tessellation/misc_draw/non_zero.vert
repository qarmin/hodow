#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIdx;
out gl_PerVertex {
    vec4 gl_Position;
};
void main(void) {
    gl_Position = inPos;
    instanceIdx = gl_InstanceIndex;
}
