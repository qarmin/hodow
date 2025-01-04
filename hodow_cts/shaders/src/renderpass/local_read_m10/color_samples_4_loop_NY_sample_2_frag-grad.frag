#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    vec4 imageSizeFloat = vec4(pc.imageSize);
    // All samples in a pixel will share color so as not to depend on standard sample locations
    vec2 normalizedCoords = vec2(ivec2(gl_FragCoord.xy)) / imageSizeFloat.xy;
    float gradientValue = (normalizedCoords.x + normalizedCoords.y) / 2.0;
    vec4 gradient0 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient0[0] = gradientValue;
    outColor0 = gradient0;
    vec4 gradient1 = vec4(0.0, 0.0, 0.0, 1.0);
    gradient1[1] = gradientValue;
    outColor1 = gradient1;
}
