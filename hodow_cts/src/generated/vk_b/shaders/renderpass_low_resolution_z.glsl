#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
void main(void)
{
    gl_Position.x = (gl_VertexIndex & 1) * 2.0 - 1.0;
    gl_Position.z = pc.depth;
    gl_Position.w = 1.0;

    if (pc.mode == 0) // full-screen quad
        gl_Position.y = (gl_VertexIndex & 2) - 1.0;
    else
    {
        // draw one 1-pixel-tall strip per instance;
        // even rows when mode is 1, odd rows when mode is 2

        int row       = gl_InstanceIndex * 2 + (pc.mode - 1);
        float pixelH  = 2.0 / pc.height;
        float top     = -1.0 + float(row) * pixelH;
        float bottom  = top + pixelH;
        gl_Position.y = ((gl_VertexIndex & 2) == 0) ? top : bottom;
    }
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
void main(void)
{
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(depth_greater) out float gl_FragDepth;
void main(void)
{
    gl_FragDepth = pc.depth;
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(depth_less) out float gl_FragDepth;
void main(void)
{
    gl_FragDepth = pc.depth;
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(depth_unchanged) out float gl_FragDepth;
void main(void)
{
    gl_FragDepth = pc.depth;
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(depth_greater) out float gl_FragDepth;
void main(void)
{
    gl_FragDepth = 1.0 - pc.depth;
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(depth_less) out float gl_FragDepth;
void main(void)
{
    gl_FragDepth = 1.0 - pc.depth;
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
void main(void)
{
    gl_FragDepth = 1.0 - pc.depth;
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(early_fragment_tests) in;
void main(void)
{
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
void main(void)
{
    if (pc.color.a < 0.01)
        discard;
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(binding = 0) buffer Buf
{
    vec4 expectedEven;  // in, used for verification
    vec4 expectedOdd;   // in, used for verification
    uint isDifferent;   // out, verification expects this to be at index 8
    uint atomicValue;   // out, used only by atomic-frag
};
void main(void)
{
    atomicAdd(atomicValue, 1u);
    fragColor = pc.color;
}
#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout (binding = 0, rgba8) uniform writeonly image2D outImage;
void main(void)
{
    imageStore(outImage, ivec2(mod(gl_FragCoord.xy, 4.0)), vec4(2.0));
    fragColor = pc.color;
}
#version 450
layout(binding = 0, rgba8) readonly uniform image2D frame;
layout(binding = 1) buffer Buf
{
    vec4 expectedEven;  // in
    vec4 expectedOdd;   // in
    uint isDifferent;   // out, verification expects this to be at index 8
    uint atomicValue;   // out, used only by atomic-frag
};
void main()
{
    vec4 expectedColor = mix(expectedEven, expectedOdd, float(gl_GlobalInvocationID.y % 2));
    if (length(imageLoad(frame, ivec2(gl_GlobalInvocationID.xy)) - expectedColor) > 0.01)
        atomicExchange(isDifferent, 1);
}
