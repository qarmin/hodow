#version 450
layout (location=0) out vec2 texCoord;
void main()
{
    texCoord = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);    gl_Position = vec4(texCoord * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
// Stand-in for upstream's hand-written SPIR-V assembly (a Skia-style shader): the same
// image sampled with OpImageSampleImplicitLod and OpImageSampleProjImplicitLod, every
// value RelaxedPrecision (mediump here), the two results multiplied.
layout (location=0) out mediump vec4 sk_FragColor;
layout (set=0, binding=0) uniform mediump sampler2D t;
void main()
{
    mediump vec4 c = texture(t, vec2(0.0));
    sk_FragColor = c * textureProj(t, vec3(1.0));
}
