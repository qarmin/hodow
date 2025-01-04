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
