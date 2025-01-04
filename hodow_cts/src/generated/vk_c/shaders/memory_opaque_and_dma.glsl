#version 460
vec2 positions[3] = vec2[](        vec2(-1.0, -1.0),        vec2(3.0, -1.0),        vec2(-1.0, 3.0));
void main() {
        gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D img;
void main(void) {
    const vec2 extent = vec2(64, 64);
    const vec2 coords = gl_FragCoord.xy / extent;
    outColor = texture(img, coords);
}
