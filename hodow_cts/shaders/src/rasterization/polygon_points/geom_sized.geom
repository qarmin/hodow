#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    for (uint i = 0u; i < 3u; ++i) {
        gl_Position  = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        EmitVertex();
    }
}
