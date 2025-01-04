#version 450

layout(quads, equal_spacing) in;
layout (binding = 0) buffer Result { uint result[4]; };

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
    if (gl_PrimitiveID == 0) {
        result[0] = 1;
        result[1] = 2;
        result[2] = 3;
        result[3] = 4;
    }
}
