#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D img;
void main(void) {
    const vec2 extent = vec2(64, 64);
    const vec2 coords = gl_FragCoord.xy / extent;
    outColor = texture(img, coords);
}
