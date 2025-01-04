#version 450
layout(set=0, binding=0) uniform sampler2D tex;
layout(location=0) in vec2 texCoord;
layout(location=0) out vec2 outColor;

void main() {
    vec4 texColor = texelFetch(tex, ivec2(texCoord.x * 64, texCoord.y * 64), 0);
    outColor = vec2(texColor.rg);
}
