#version 450

#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable

layout(location = 0) out uvec4 o_color;

void main(void)
{
    if (gl_ShadingRateEXT == 0)
        o_color = uvec4(128, 128, 128, 1);
    else
        o_color = uvec4(255, 0, 0, 1);

${'    if (gl_ShadingRateEXT == 0)\n       gl_FragDepth = 0.4;\n    else\n       gl_FragDepth = 0.2;\n\n' if frag_depth else ''}${'    if (gl_ShadingRateEXT == 0)\n       gl_FragStencilRefARB = 1;\n    else\n       gl_FragStencilRefARB = 2;\n' if frag_stencil else ''}}
