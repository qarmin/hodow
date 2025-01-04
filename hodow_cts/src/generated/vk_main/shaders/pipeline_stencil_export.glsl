#version 450
vec2 positions[6] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0, +1.0),
    vec2(+1.0, -1.0),
    vec2(+1.0, +1.0),
    vec2(+1.0, -1.0),
    vec2(-1.0, +1.0)

);

void main(void)
{
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
#version 450
#extension GL_ARB_shader_stencil_export: enable

void main(void)
{
    int refX = (int(gl_FragCoord.x) >> 4) % 2;
    int refY = (int(gl_FragCoord.y) >> 4) % 2;
    gl_FragStencilRefARB = (refX + refY) % 2;
}
#version 450
layout(location = 0) out highp vec4 fragColor;

void main(void)
{
    fragColor = vec4(0, 0, 1, 1);
}
