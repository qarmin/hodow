#version 450

layout(quads, equal_spacing) in;
#if ${stage} == 3 && ${builtin} == 0
layout(location = 0) out vec4 unused;
#endif

void main (void)
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position + u * omv * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position + omu * v * gl_in[1].gl_Position;
    gl_Position.x *= 1.5f;
#if ${stage} == 3
#if ${builtin} == 1
    gl_PointSize = 16.0f;
    gl_ClipDistance[0] = 2.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
