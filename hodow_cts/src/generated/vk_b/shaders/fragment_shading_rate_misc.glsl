#version 460
#extension GL_EXT_fragment_shading_rate : enable
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = inColor;
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = inColor;
}
#version 460
vec2 positions[3] = vec2[](
        vec2(-1.0, -1.0),
        vec2(3.0, -1.0),
        vec2(-1.0, 3.0)
);
void main() {
        gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
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
