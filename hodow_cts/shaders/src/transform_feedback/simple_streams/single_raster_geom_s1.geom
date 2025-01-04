#version 460
layout (points) in;
layout (points, max_vertices=2) out;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[1];
layout (stream=1) out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0, stream=0, xfb_buffer=0, xfb_offset=0, xfb_stride=16) out vec4 pos0;
layout (location=1, stream=1, xfb_buffer=1, xfb_offset=0, xfb_stride=16) out vec4 pos1;
void main() {
    vec4 inPos0;
    vec4 inPos1;

    inPos0 = gl_in[0].gl_Position;
    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);
    gl_Position = inPos0;
    gl_PointSize = 1.0;
    pos0 = inPos0;
    EmitStreamVertex(0);

    inPos0 = gl_in[0].gl_Position;
    inPos1 = vec4(inPos0.x, -inPos0.y, inPos0.z, inPos0.w);
    gl_Position = inPos1;
    gl_PointSize = 1.0;
    pos1 = inPos1;
    EmitStreamVertex(1);
}
