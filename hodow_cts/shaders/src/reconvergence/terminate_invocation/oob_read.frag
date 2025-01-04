#version 460
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_EXT_terminate_invocation : enable
#extension GL_EXT_shader_quad_control : enable

layout (full_quads) in;

layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D inTexture;
layout (set=0, binding=1, std430) readonly buffer InValuesBlock {
    vec4 values[];
} inValues;

layout (push_constant, std430) uniform PCBlock {
    uint divisor;
    uint divisorCopy;
    uint indexZero;
    uint indexLarge;
    float width;
    float height;
} pc;

void main()
{
    // The texture should only have non-zero variable red values and alpha 1.0.
    vec2 dim = vec2(pc.width, pc.height);
    vec2 sampleCoords = gl_FragCoord.xy / dim;
    vec4 inColor = texture(inTexture, sampleCoords);
    
    bool should_terminate = (gl_SubgroupInvocationID % pc.divisor == 0u);
    bool should_terminate_2 = (gl_SubgroupInvocationID % pc.divisorCopy == 0u);

    // Separate condition to prevent the compiler from being too smart.
    if (should_terminate_2)
        terminateInvocation;

    // Attempt to trigger an invalid read. The buffer will contain (0, 0, 1, 0) at index zero.
    uint index = (should_terminate ? pc.indexLarge : pc.indexZero);
    inColor = inColor + inValues.values[index];

    // Output framebuffer:
    // * Half the pixels should be (textureRed, 0.0, 1.0, 1.0).
    // * The other half should have the clear color.
    // * No crashes, obviously.
    outColor = inColor;
}
