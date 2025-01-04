#version 460
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PCBlock {
    uint width;
    uint height;
} pc;
void main(void) {
    const float green = gl_FragCoord.x / float(pc.width);
    const float blue  = gl_FragCoord.y / float(pc.height);
    outColor = vec4(0.0, green, blue, 1.0);
}
