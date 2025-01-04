#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat int instanceIdx;
void main(void) {
    outColor = vec4(0.0, 0.0, float(instanceIdx), 1.0);
}
