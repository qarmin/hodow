#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450

layout (location=0) out vec4 outColor;
void main() {
    gl_SampleMask[0] = ~0;
    outColor = vec4(1.0f);
    if ((uint(gl_FragCoord.x) & 1u) == 0u) {
       discard;
    }
}
#version 450

layout (location=0) out vec4 outColor;
void main() {
    gl_SampleMask[0] = ~0;
    outColor = vec4(1.0f);
    if ((uint(gl_FragCoord.x) & 1u) == 0u) {
       gl_SampleMask[0] = 0;
    }
}
#version 450

layout (location=0) out vec4 outColor;
void main() {
    gl_SampleMask[0] = ~0;
    outColor = vec4(1.0f);
    if ((uint(gl_FragCoord.x) & 1u) == 0u) {
       outColor = vec4(1.0f, 1.0f, 1.0f, 0.0f);
    }
}
#version 450
layout(early_fragment_tests) in;
layout (location=0) out vec4 outColor;
void main() {
    gl_SampleMask[0] = ~0;
    outColor = vec4(1.0f);
    if ((uint(gl_FragCoord.x) & 1u) == 0u) {
       discard;
    }
}
#version 450
layout(early_fragment_tests) in;
layout (location=0) out vec4 outColor;
void main() {
    gl_SampleMask[0] = ~0;
    outColor = vec4(1.0f);
    if ((uint(gl_FragCoord.x) & 1u) == 0u) {
       gl_SampleMask[0] = 0;
    }
}
#version 450
layout(early_fragment_tests) in;
layout (location=0) out vec4 outColor;
void main() {
    gl_SampleMask[0] = ~0;
    outColor = vec4(1.0f);
    if ((uint(gl_FragCoord.x) & 1u) == 0u) {
       outColor = vec4(1.0f, 1.0f, 1.0f, 0.0f);
    }
}
