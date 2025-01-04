#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos - 0.5f, 0.5f, 1.0f);
}
#version 450
void main() {
}
#version 450
void main() {
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
void main() {
    outColor0 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
void main() {
    outColor0 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
void main() {
    outColor0 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
void main() {
    outColor0 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
void main() {
    outColor0 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
void main() {
    outColor0 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out vec4 outColor1;
void main() {
    outColor1 = vec4(1.0f);
}
#version 450
layout (location = 1) out vec4 outColor1;
void main() {
    outColor1 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out uvec4 outColor1;
void main() {
    outColor1 = uvec4(255);
}
#version 450
layout (location = 1) out uvec4 outColor1;
void main() {
    outColor1 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out ivec4 outColor1;
void main() {
    outColor1 = ivec4(255);
}
#version 450
layout (location = 1) out ivec4 outColor1;
void main() {
    outColor1 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
void main() {
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
void main() {
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
void main() {
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
void main() {
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 4) out uvec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor4 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 4) out uvec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor4 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 4) out ivec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor4 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 4) out ivec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor4 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor4 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 4) out vec4 outColor4;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
void main() {
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
void main() {
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout(location = 0) out vec4 outColor[6];
void main() {
    outColor[0] = vec4(1.0f);
    outColor[1] = vec4(1.0f);
    outColor[2] = vec4(1.0f);
    outColor[5] = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor5 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 5) out uvec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor5 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 5) out ivec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor5 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 5) out ivec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor5 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor5 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 5) out vec4 outColor5;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
layout (location = 9) out uvec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    outColor9 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
layout (location = 9) out uvec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    outColor9 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
layout (location = 9) out ivec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    outColor9 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
layout (location = 9) out ivec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    outColor9 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
void main() {
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
void main() {
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor1 = uvec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
void main() {
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
void main() {
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor1 = ivec4(255);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
layout (location = 9) out uvec4 outColor9;
void main() {
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    outColor9 = uvec4(255);
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 5) out uvec4 outColor5;
layout (location = 6) out uvec4 outColor6;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
layout (location = 9) out uvec4 outColor9;
void main() {
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor5 = uvec4(255);
    outColor6 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    outColor9 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor2 = uvec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
layout (location = 9) out ivec4 outColor9;
void main() {
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    outColor9 = ivec4(255);
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 5) out ivec4 outColor5;
layout (location = 6) out ivec4 outColor6;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
layout (location = 9) out ivec4 outColor9;
void main() {
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor5 = ivec4(255);
    outColor6 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    outColor9 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 5) out vec4 outColor5;
layout (location = 6) out vec4 outColor6;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor2 = ivec4(255);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor5 = vec4(1.0f);
    outColor6 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out vec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = vec4(1.0f);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
layout (location = 9) out uvec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    outColor9 = uvec4(255);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out uvec4 outColor1;
layout (location = 2) out uvec4 outColor2;
layout (location = 3) out uvec4 outColor3;
layout (location = 4) out uvec4 outColor4;
layout (location = 7) out uvec4 outColor7;
layout (location = 8) out uvec4 outColor8;
layout (location = 9) out uvec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = uvec4(255);
    outColor2 = uvec4(255);
    outColor3 = uvec4(255);
    outColor4 = uvec4(255);
    outColor7 = uvec4(255);
    outColor8 = uvec4(255);
    outColor9 = uvec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out uvec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = uvec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
layout (location = 9) out ivec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    outColor9 = ivec4(255);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out ivec4 outColor1;
layout (location = 2) out ivec4 outColor2;
layout (location = 3) out ivec4 outColor3;
layout (location = 4) out ivec4 outColor4;
layout (location = 7) out ivec4 outColor7;
layout (location = 8) out ivec4 outColor8;
layout (location = 9) out ivec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = ivec4(255);
    outColor2 = ivec4(255);
    outColor3 = ivec4(255);
    outColor4 = ivec4(255);
    outColor7 = ivec4(255);
    outColor8 = ivec4(255);
    outColor9 = ivec4(255);
    gl_FragDepth = 0.5f;
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
}
#version 450
layout (location = 0) out ivec4 outColor0;
layout (location = 1) out vec4 outColor1;
layout (location = 2) out vec4 outColor2;
layout (location = 3) out vec4 outColor3;
layout (location = 4) out vec4 outColor4;
layout (location = 7) out vec4 outColor7;
layout (location = 8) out vec4 outColor8;
layout (location = 9) out vec4 outColor9;
void main() {
    outColor0 = ivec4(255);
    outColor1 = vec4(1.0f);
    outColor2 = vec4(1.0f);
    outColor3 = vec4(1.0f);
    outColor4 = vec4(1.0f);
    outColor7 = vec4(1.0f);
    outColor8 = vec4(1.0f);
    outColor9 = vec4(1.0f);
    gl_FragDepth = 0.5f;
}
