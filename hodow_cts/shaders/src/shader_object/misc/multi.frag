#version 450
layout(set=0, binding=0) readonly buffer inputBuf {
    vec4 color;
};
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
void main() {
    outColor0 = color;
    outColor1 = color;
}
