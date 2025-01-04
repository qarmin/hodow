#version 450

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, std430) readonly buffer SampleData {
    uvec2 renderSize;
    uvec2 gridSize;
    uint  samplesPerPixel;
          // padding 1-uint size;
    vec2  data[];
} sb_data;

void main(void)
{
    uvec2 fragCoord = uvec2(gl_FragCoord.xy);
    uint  index     = (fragCoord.y * sb_data.renderSize.x + fragCoord.x) * sb_data.samplesPerPixel + gl_SampleID;

    if (gl_PrimitiveID == index)
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
}
