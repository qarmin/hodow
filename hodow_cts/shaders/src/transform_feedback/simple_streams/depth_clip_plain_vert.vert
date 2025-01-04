#version 450

out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position = vec4(1.0, 1.0, float(gl_VertexIndex) / 3.0 - 1.0, 1.0);
}
