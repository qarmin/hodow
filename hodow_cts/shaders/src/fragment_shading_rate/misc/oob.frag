#version 460
#extension GL_EXT_fragment_shading_rate : enable
layout (location=0) out vec4 outColor;
layout (std430, binding = 0) readonly buffer Dimensions {
    uint minW;
    uint minH;
} dimensions;
void main (void) {
    if (gl_FragCoord.x < dimensions.minW && gl_FragCoord.y < dimensions.minH) {
        outColor = (gl_ShadingRateEXT == (gl_ShadingRateFlag2VerticalPixelsEXT | gl_ShadingRateFlag2HorizontalPixelsEXT))
                                ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    } else {
        outColor = (gl_ShadingRateEXT == 0) ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
    }
}
