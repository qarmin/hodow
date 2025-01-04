#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[];
layout (location=0) out vec4 outColor;
void main() {
    for (uint i = 0; i < 3; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i].gbra;
        EmitVertex();
    }
}
