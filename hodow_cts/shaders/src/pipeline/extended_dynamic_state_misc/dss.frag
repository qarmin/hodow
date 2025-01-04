#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in vec2 inCoords;
layout (set=0, binding=0) uniform sampler2D tex;
layout (set=0, binding=1, std430) buffer CounterBlock { uint counter; } atomicCounter;
void main (void) {
    outColor = texture(tex, inCoords);
    atomicAdd(atomicCounter.counter, 1u);
}
