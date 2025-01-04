#version 460
#extension GL_EXT_texture_offset_non_const : enable
layout (push_constant, std430) uniform PCBlock { vec4 coords; vec2 size; float lod; } pc;
layout (set=0, binding=0) uniform OffsetDataBlock { ivec4 offsets[9]; } offsetData;
layout (set=0, binding=1) uniform sampler2D inTex;
layout (location=0) out vec4 outColor;
layout (location=0) in vec4 inPos;
void main(void) {
    const uvec2 pixelId = uvec2((inPos.xy + vec2(1.0, 1.0)) / vec2(2.0, 2.0) * pc.size);    const uint offsetIndex = pixelId.y * uint(pc.size.x) + pixelId.x;
    const ivec2 offset = offsetData.offsets[offsetIndex].xy;
    const vec3 texCoords = pc.coords.xyz;
    const vec4 pixel = textureProjLodOffset(inTex, texCoords, pc.lod, offset);
    outColor = pixel;
    gl_Position = inPos;
    gl_PointSize = 1.0;
}
