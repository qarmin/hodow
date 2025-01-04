#version 460
#extension GL_EXT_fragment_shading_rate : enable
layout (location=0) out vec4 outColor;
void main (void) {
    const float red = (((gl_ShadingRateEXT & gl_ShadingRateFlag2VerticalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float green = (((gl_ShadingRateEXT & gl_ShadingRateFlag2HorizontalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float blue = (gl_SampleID + 1) / 4.0;
    outColor = vec4(red, green, blue, 1.0);
}
