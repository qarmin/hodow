#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out float added;
layout (location=1) out float multiplied;
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;
    added        = inPos.x + 1000.0;
    multiplied   = inPos.y * 1000.0;
}
