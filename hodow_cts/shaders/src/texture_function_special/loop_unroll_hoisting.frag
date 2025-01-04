#version 450
#extension GL_EXT_control_flow_attributes : enable
layout(set = 0, binding = 1, std140) uniform UniformBlock
{
    mediump ivec2 loopBounds;
} ub;
layout(set = 1, binding = 0) uniform mediump sampler2D texSampler;
layout(location = 0) in mediump vec2 v_texCoord;
layout(location = 0) out mediump vec4 outColor;
void main()
{
    mediump vec4 acc = vec4(0.0);
    [[unroll]]
    for (mediump int i = 0; i < ub.loopBounds.x; )
    {
        acc += texture(texSampler, v_texCoord + float(i) * 0.01);
        i++;
        continue;
    }
    outColor = vec4(acc.rgb, 1.0);
}
