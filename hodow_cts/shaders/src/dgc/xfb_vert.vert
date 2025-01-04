#version 460
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
void main(void) {
    gl_Position = inPos;
}
