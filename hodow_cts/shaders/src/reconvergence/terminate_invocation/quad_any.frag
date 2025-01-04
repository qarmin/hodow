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
    vec4 inColor = vec4(0.0, 0.0, 1.0, 1.0);
    
    // pc.divisorCopy is 2, so this is an implicit gl_HelperInvocation
    bool started_as_helper = ((uint(gl_HelperInvocation) + 1u) == pc.divisorCopy);
    bool should_terminate = (gl_SubgroupInvocationID % pc.divisor == 0u || started_as_helper);

    if (should_terminate)
        terminateInvocation;

    if (subgroupQuadAny(gl_HelperInvocation)) {
      // This should always be false if terminateInvocation is implemented properly.
      vec2 dim = vec2(pc.width, pc.height);
      vec2 sampleCoords = gl_FragCoord.xy / dim;
      inColor = texture(inTexture, sampleCoords);
    }
    // Output framebuffer:
    // * Half the pixels should be (0.0, 0.0, 1.0, 1.0).
    // * The other half should have the clear color.
    outColor = inColor;
}
