#version 460
layout (location=0) in vec4 inPos;


void main() {
    gl_Position = inPos;

}
#version 460
layout (location=0) out vec4 outColor;


void main() {

    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main() {
    gl_Position = inPos;
    outColor = inColor;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in vec4 vtxColor;

void main() {

    outColor = vtxColor;
}
#version 460
layout (location=0) out vec4 outColor;

layout (set=0, binding=0) buffer CounterBlock { uint counter; } cb;
void main() {
    atomicAdd(cb.counter, 1u);
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
