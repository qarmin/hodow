#version 450
layout(set=0, binding=0) uniform usampler2D tex;
layout(location=0) in vec2 texCoord;
layout(location=0) out uvec2 outColor;

void main() {
    uvec4 texColor = texelFetch(tex, ivec2(texCoord.x * 16, texCoord.y * 16), 0);
    outColor = uvec2(texColor.rg);
}
