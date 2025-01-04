#version 450

layout (location = 1) in vec4 vColor;
layout (location = 0) out vec4 fColor;

void main()
{
    vec4 color = vColor;
    if (gl_SampleID == 0)
{
   vec2 sampPos = gl_SamplePosition;
    color = vec4(1.0, sampPos.x, sampPos.y, 1.0);
}
else
{
    color = vec4(0.0, 1.0, 0.0, 1.0);
}
gl_SampleMask[0] = 0x02;
    fColor = color;
}
