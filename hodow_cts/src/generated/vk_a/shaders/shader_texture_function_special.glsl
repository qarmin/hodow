#version 450
layout(location = 0) out vec2 outUV;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    outUV = pos;
    gl_Position = vec4(pos * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
layout(location = 0) in vec2 outUV;
layout(binding = 0) uniform usampler2D srcTex;
layout(location = 0) out vec4 outColor;
void main() {
    uint v = texture(srcTex, outUV).r;
    uint t = v & 0xFFFFu; // intended 16-bit truncation.
    float ratio = float(t) / 65535.0;
    outColor = vec4(ratio, 1.0 - ratio, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec2 v_texCoord;
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    v_texCoord = pos;
    gl_Position = vec4(pos * 2.0f - 1.0f, 0.0f, 1.0f);
}
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
