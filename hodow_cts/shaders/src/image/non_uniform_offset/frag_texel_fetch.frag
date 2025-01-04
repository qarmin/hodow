#version 460
#extension GL_EXT_texture_offset_non_const : enable
layout (push_constant, std430) uniform PCBlock { vec4 coords; vec2 size; float lod; } pc;
layout (set=0, binding=0) uniform OffsetDataBlock { ivec4 offsets[9]; } offsetData;
layout (set=0, binding=1) uniform sampler2D inTex;
layout (location=0) out vec4 outColor;
void main(void) {
    const uint offsetIndex = uint(gl_FragCoord.y) * uint(pc.size.x) + uint(gl_FragCoord.x);
    const ivec2 offset = offsetData.offsets[offsetIndex].xy;
    const ivec2 texCoords = ivec2(pc.coords.xy);
    const vec4 pixel = texelFetchOffset(inTex, texCoords, int(pc.lod), offset);
    outColor = pixel;
}
