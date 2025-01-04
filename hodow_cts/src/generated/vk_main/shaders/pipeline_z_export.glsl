#version 460
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0, 3.0),
    vec2(3.0, -1.0)
);
void main (void) {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 0.500000, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const float alphaValue = ((int(gl_FragCoord.x) < 2) ? 0.0 : 1.0);
    outColor = vec4(0.0, 0.0, 1.0, alphaValue);
    gl_FragDepth = 0.000000;
}
#version 460
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0, 3.0),
    vec2(3.0, -1.0)
);
void main (void) {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 0.000000, 1.0);
}
#version 460
#extension GL_ARB_shader_stencil_export: require
layout (location=0) out vec4 outColor;
void main (void) {
    const float alphaValue = ((int(gl_FragCoord.x) < 2) ? 0.0 : 1.0);
    outColor = vec4(0.0, 0.0, 1.0, alphaValue);
    gl_FragStencilRefARB = 255;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const float alphaValue = ((int(gl_FragCoord.x) < 2) ? 0.0 : 1.0);
    outColor = vec4(0.0, 0.0, 1.0, alphaValue);
    gl_SampleMask[0] = ((int(gl_FragCoord.y) >= 2) ? 0 : 0xFF);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const float alphaValue = ((int(gl_FragCoord.x) < 2) ? 0.0 : 1.0);
    outColor = vec4(0.0, 0.0, 1.0, alphaValue);
}
#version 460
#extension GL_ARB_shader_stencil_export: require
layout (location=0) out vec4 outColor;
void main (void) {
    const float alphaValue = ((int(gl_FragCoord.x) < 2) ? 0.0 : 1.0);
    outColor = vec4(0.0, 0.0, 1.0, alphaValue);
    gl_FragDepth = 0.000000;
    gl_FragStencilRefARB = 255;
}
#version 460
#extension GL_ARB_shader_stencil_export: require
layout (location=0) out vec4 outColor;
void main (void) {
    const float alphaValue = ((int(gl_FragCoord.x) < 2) ? 0.0 : 1.0);
    outColor = vec4(0.0, 0.0, 1.0, alphaValue);
    gl_FragDepth = 0.000000;
    gl_FragStencilRefARB = 255;
    gl_SampleMask[0] = ((int(gl_FragCoord.y) >= 2) ? 0 : 0xFF);
}
