#version 450
layout(location=0) out vec4 outColor0;
layout(location=1) out vec4 outColor1;
layout(location=2) out vec4 outColor2;
layout(location=3) out vec4 outColor3;

void main() {
    outColor0 = vec4(1.0f, 0.0f, 0.0f, 1.0f); // red
    outColor1 = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
    outColor2 = vec4(0.0f, 1.0f, 0.0f, 1.0f); // green
    outColor3 = vec4(0.5f, 0.5f, 0.5f, 1.0f); // gray
}
