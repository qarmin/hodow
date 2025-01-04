#version 460
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out vec4 outColor;
void main(void) {
    gl_Position = inPos;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
