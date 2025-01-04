#version 460
vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main (void) {
    gl_Position = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) buffer InvocationCounterBlock { uint invocations; } counterBuffer;
void main (void) {
    uint sampleId = gl_SampleID;
    atomicAdd(counterBuffer.invocations, 1u);
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec2 inCoords;
layout (location=0) out vec2 outCoords;
void main (void) {
    gl_Position = inPos;
    outCoords   = inCoords;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in vec2 inCoords;
layout (set=0, binding=0) uniform sampler2D tex;
layout (set=0, binding=1, std430) buffer CounterBlock { uint counter; } atomicCounter;
void main (void) {
    outColor = texture(tex, inCoords);
    atomicAdd(atomicCounter.counter, 1u);
}
