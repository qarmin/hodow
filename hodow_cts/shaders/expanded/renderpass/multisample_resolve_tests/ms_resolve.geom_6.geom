#version 450
highp float;

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void) {
    for (int layerNdx = 0; layerNdx < 6; ++layerNdx) {
        for(int vertexNdx = 0; vertexNdx < gl_in.length(); vertexNdx++) {
            gl_Position = gl_in[vertexNdx].gl_Position;
            gl_Layer    = layerNdx;
            EmitVertex();
        };
        EndPrimitive();
    };
}
