#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    gl_FragDepth = gradientValue;
    gl_FragStencilRefARB = int(gradientValue * 255.0);
}
