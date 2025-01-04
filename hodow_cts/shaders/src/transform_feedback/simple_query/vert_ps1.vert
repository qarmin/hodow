#version 450

layout(location = 0) out vec4 out0;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = vec4(0.0, 0.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    float n = 4.0 * float(gl_VertexIndex);
    out0 = vec4(n + 0.0, n + 1.0, n + 2.0, n + 3.0);
}
