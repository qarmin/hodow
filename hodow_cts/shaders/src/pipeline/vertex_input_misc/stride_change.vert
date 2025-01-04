#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void) {
    gl_Position = inPos;
}
