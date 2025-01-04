#version 450
layout (location=0) out vec4 outColor;

void main ()
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    outColor = (gl_PrimitiveID % 2 == 0) ? red : green;
}
