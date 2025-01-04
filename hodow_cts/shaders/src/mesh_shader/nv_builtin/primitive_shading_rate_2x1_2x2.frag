#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? gl_ShadingRateFlag2HorizontalPixelsEXT : (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT));
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
