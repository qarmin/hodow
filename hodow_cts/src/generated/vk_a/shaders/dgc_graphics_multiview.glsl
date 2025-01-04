#version 460
layout (location=0) in vec4 inPos;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
}
#version 460
#extension GL_EXT_multiview : require
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PushConstantBlock { vec4 fbSize; } pc;
vec4 quadColors[4] = vec4[4](
    vec4(0.0, 0.0, 0.0, 1.0),
    vec4(0.0, 0.0, 1.0, 1.0),
    vec4(0.0, 1.0, 0.0, 1.0),
    vec4(0.0, 1.0, 1.0, 1.0)
);
void main(void) {
    vec2 normCoord = (gl_FragCoord.xy / pc.fbSize.xy) * 2.0 - 1.0;
    // Quad Index: top-left: 0, bottom-left: 1, top-right: 2, bottom-right: 3
    uint quadIndex = 0u;
    if (normCoord.x > 0.0)
        quadIndex |= 2u;
    if (normCoord.y > 0.0)
        quadIndex |= 1u;
    vec4 chosenColor = quadColors[quadIndex];
    chosenColor.r = float(gl_ViewIndex);
    outColor = chosenColor;
}
