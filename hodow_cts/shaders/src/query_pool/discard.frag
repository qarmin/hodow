#version 450
${'layout(early_fragment_tests) in;' if early else ''}
layout (location=0) out vec4 outColor;
void main() {
    gl_SampleMask[0] = ~0;
    outColor = vec4(1.0f);
    if ((uint(gl_FragCoord.x) & 1u) == 0u) {
${'       discard;' if kind == 0 else ('       gl_SampleMask[0] = 0;' if kind == 1 else '       outColor = vec4(1.0f, 1.0f, 1.0f, 0.0f);')}
    }
}
