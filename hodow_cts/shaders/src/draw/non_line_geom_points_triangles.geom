#version 460
layout(points) in;
layout(triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[1];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[1];
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = gl_in[0].gl_Position + vec4(0.0, -0.5, 0.0, 0.0);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = inColor[0];
    EmitVertex();
    gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.5, 0.0, 0.0);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = inColor[0];
    EmitVertex();
    gl_Position = gl_in[0].gl_Position + vec4(0.5, 0.0, 0.0, 0.0);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = inColor[0];
    EmitVertex();
    EndPrimitive();
}
