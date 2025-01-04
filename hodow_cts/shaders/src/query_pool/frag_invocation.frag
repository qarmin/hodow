#version 460
layout (location=0) out vec4 outColor;
${'layout (location=0) in vec4 vtxColor;' if vertex_color else ''}
${'layout (set=0, binding=0) buffer CounterBlock { uint counter; } cb;' if atomic else ''}
void main() {
${'    atomicAdd(cb.counter, 1u);' if atomic else ''}
    outColor = ${'vtxColor' if vertex_color else 'vec4(0.0, 0.0, 1.0, 1.0)'};
}
