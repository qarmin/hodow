#version 460
layout (push_constant, std430) uniform PCBlock { float red; float green; float blue; } pc;
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) out vec4 outColor;
void main() {
    for (uint i = 0; i < 3; ++i) {
        outColor = vec4(pc.red, pc.green, pc.blue, 1.0);
        gl_Position = gl_in[i].gl_Position;
        EmitVertex();
    }
}
