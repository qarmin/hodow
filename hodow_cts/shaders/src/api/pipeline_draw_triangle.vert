#version 310 es
void main (void)
{
    gl_Position = vec4(float(1 - 2 * int(gl_VertexIndex != 1)),
                       float(1 - 2 * int(gl_VertexIndex > 0)), 0.0, 1.0);
}
