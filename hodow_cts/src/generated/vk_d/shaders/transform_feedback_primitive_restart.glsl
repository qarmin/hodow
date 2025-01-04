#version 460
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex {
    vec4 gl_Position;
};
void main(void) {
    const int vid = gl_VertexIndex;
    const int max16 = 65535;
    gl_Position = ((vid == max16) ? vec4(-1.0, -1.0, -1.0, -1.0) : vec4(vid, vid, vid, vid));
}
