#version 450
layout (location = 0) out vec4 outColor;
layout (std430, binding = 0) buffer Output {
    uint invocationCount;
} buf;
void main() {
    gl_SamplePosition;
    uint one   = 1;
    uint index = atomicAdd(buf.invocationCount, one);
    outColor = vec4(float(one), 1.0, 0.0, 1.0);
}
