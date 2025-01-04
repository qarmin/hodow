#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (set=0, binding=0, std430) buffer SSBO_Block {
    uint condition;
    uint value;
} ssbo;
void main() {
    ssbo.value = 777u;
    if (ssbo.condition != 0u) {
        for (uint i = 0; i < 3; ++i) {
            gl_Position = gl_in[i].gl_Position;
            EmitVertex();
        }
        EndPrimitive();
    }
}
