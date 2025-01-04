#version 450
#extension GL_ARB_shader_stencil_export: enable

void main(void)
{
    int refX = (int(gl_FragCoord.x) >> 4) % 2;
    int refY = (int(gl_FragCoord.y) >> 4) % 2;
    gl_FragStencilRefARB = (refX + refY) % 2;
}
