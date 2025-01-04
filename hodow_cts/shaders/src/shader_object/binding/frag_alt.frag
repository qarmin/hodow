#version 450
layout (location=0) out vec4 outColor;
#if ${unused} == 5
layout (location = 1) out vec4 color;
#endif
void main() {
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
#if ${unused} == 5
    color = vec4(1.0f);
#endif
}
