#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) buffer InvocationCounterBlock { uint invocations; } counterBuffer;
void main (void) {
    uint sampleId = gl_SampleID;
    atomicAdd(counterBuffer.invocations, 1u);
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
