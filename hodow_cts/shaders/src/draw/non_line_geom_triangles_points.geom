#version 460
layout(triangles) in;
layout(points, max_vertices=1) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[3];
layout (location=0) out vec4 outColor;
void main (void) {
    for (uint i = 0; i < 1; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i];
        EmitVertex(); EndPrimitive();
    }
}
