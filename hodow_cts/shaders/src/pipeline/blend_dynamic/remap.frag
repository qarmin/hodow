#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
void main(void) {
    outColor0 = vec4(1.0, 0.0, 1.0, 1.0);
    outColor1 = vec4(0.0, 1.0, 1.0, 1.0);
}
