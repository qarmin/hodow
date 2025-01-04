#version 450
layout(location = 0) out vec4 outGBuffer;
layout(location = 1) out vec4 outResolvedColor;
void main (void)
{
    outGBuffer = vec4(0.0, 1.0, 0.0, 1.0);
    outResolvedColor = vec4(1.0, 1.0, 0.0, 1.0);
}
