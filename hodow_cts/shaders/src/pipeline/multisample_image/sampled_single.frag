#version 450

layout(location = 0) out uvec2 o_status;

layout(set = 0, binding = 0) uniform ${sampler_type} colorTexture;

void main(void)
{
    uint clearColorCount = 0;
    uint primitiveColorCount = 0;

    for (int sampleNdx = 0; sampleNdx < ${samples}; ++sampleNdx) {
        ${texel_type} color = texelFetch(colorTexture, ivec2(gl_FragCoord.xy), sampleNdx);
        if (color == ${ref_clear})
            ++clearColorCount;
        else if (color == ${ref_primitive})
            ++primitiveColorCount;
    }

    o_status = uvec2(clearColorCount, primitiveColorCount);
}
