#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[3];
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex {
    vec4 gl_Position;
};
void main() {
    for (uint i = 0; i < 3; ++i) {
        gl_Position = gl_in[i].gl_Position;
        EmitVertex();
    }
}
