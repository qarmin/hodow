#version 450

#if ${spacing} == 0
layout(quads, equal_spacing) in;
#elif ${spacing} == 1
layout(quads, fractional_even_spacing) in;
#else
layout(quads, fractional_odd_spacing) in;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
}
