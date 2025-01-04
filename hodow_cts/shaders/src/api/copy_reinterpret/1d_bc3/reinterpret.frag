#version 450
layout(set=0, binding=0) uniform usampler1D tex;
layout(location=0) in float texCoord;
layout(location=0) out uvec4 outColor;

void main() {
    uvec4 texColor = texelFetch(tex, int(texCoord.x * 16), 0);
    outColor = uvec4(texColor.rgba);
}
