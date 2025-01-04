#version 460
void main()
{
    const float x = (-1.0+4.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-4.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 1.0, 1.0);
}
