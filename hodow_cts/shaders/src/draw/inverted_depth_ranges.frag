#version 450

layout(location = 0) out highp vec4 out_color;

void main(void)
{
    out_color = vec4(gl_FragCoord.z, 0.5, 0.5, 1);
}
