#version 450
layout (location = 0) out vec4 outColor;
layout (location = 0) sample in float verify;
layout (std430, binding = 0) buffer Output {
    uint invocationCount;
} buf;
void main() {
    uint one   = uint(ceil(verify));
    uint index = atomicAdd(buf.invocationCount, one);
    outColor = vec4(float(one), 1.0, 0.0, 1.0);
}
