#version 460
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_EXT_terminate_invocation : enable
#extension GL_EXT_maximal_reconvergence : enable
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
[[maximally_reconverges]]
{
    // The texture should only have non-zero variable red values and alpha 1.0.
    vec2 dim = vec2(pc.width, pc.height);
    vec2 sampleCoords = gl_FragCoord.xy / dim;
    vec4 inColor = texture(inTexture, sampleCoords);
    
    // Divisor and divisor copy are all both 0.
    bool should_terminate = (gl_HelperInvocation && pc.divisor == 0u); 
    bool should_terminate_2 = (gl_HelperInvocation && pc.divisorCopy == 0u);
    
    // Separate condition to prevent the compiler from being too smart.
    if (should_terminate_2)
        terminateInvocation;
    
    bool success = (subgroupAny(should_terminate) == false); 
    if (success)
        inColor.b = 1.0;
    
    // Output framebuffer:
    // * All terminated invocations would be helpers.
    // * All pixels should be (textureRed, 0.0, 1.0, 1.0).
    outColor = inColor;
}
