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
