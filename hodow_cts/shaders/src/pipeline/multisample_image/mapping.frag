#version 450
layout(location = 0) out vec4 outColor;
void main(void) {
    outColor = vec4(gl_FragCoord.xy / 16.0, gl_SampleID / 64.0, 1.0);
}
