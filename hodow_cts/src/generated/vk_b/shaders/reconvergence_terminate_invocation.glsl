#version 460
const vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  3.0, 0.0, 1.0),
    vec4( 3.0, -1.0, 0.0, 1.0)
);
void main (void) {
    gl_Position = vertices[gl_VertexIndex % 3];
}
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
    
    bool should_terminate = (gl_SubgroupInvocationID % pc.divisor == 0u);
    bool should_terminate_2 = (gl_SubgroupInvocationID % pc.divisorCopy == 0u);
    
    uvec4 all_ballot = subgroupBallot(true);
    uint all_count = subgroupBallotBitCount(all_ballot);
    
    uvec4 terminated_ballot = subgroupBallot(should_terminate);
    uint terminated_count = subgroupBallotBitCount(terminated_ballot);
    
    // Separate condition to prevent the compiler from being too smart.
    if (should_terminate_2)
        terminateInvocation;
    
    uvec4 alive_ballot = subgroupBallot(true);
    uint alive_count = subgroupBallotBitCount(alive_ballot);
    
    bool success = (terminated_count + alive_count == all_count); 
    if (success)
        inColor.b = 1.0;
    
    // Output framebuffer:
    // * Half the pixels should be (textureRed, 0.0, 1.0, 1.0).
    // * The other half should have the clear color.
    outColor = inColor;
}
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
