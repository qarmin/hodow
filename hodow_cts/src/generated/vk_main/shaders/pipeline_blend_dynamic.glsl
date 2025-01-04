#version 460
void main(void) {
    // Full-screen clockwise triangle strip with 4 vertices.
    const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor0;
void main(void) {
    outColor0 = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
void main(void) {
    outColor0 = vec4(0.0, 0.0, 1.0, 1.0);
    outColor1 = vec4(0.0, 1.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (location=2) out vec4 outColor2;
void main(void) {
    outColor0 = vec4(0.0, 0.0, 1.0, 1.0);
    outColor1 = vec4(0.0, 1.0, 1.0, 1.0);
    outColor2 = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (location=2) out vec4 outColor2;
layout (location=3) out vec4 outColor3;
layout (location=4) out vec4 outColor4;
layout (location=5) out vec4 outColor5;
layout (location=6) out vec4 outColor6;
layout (location=7) out vec4 outColor7;
void main(void) {
    outColor0 = vec4(0.0, 0.0, 1.0, 1.0);
    outColor1 = vec4(0.0, 1.0, 1.0, 1.0);
    outColor2 = vec4(1.0, 1.0, 0.0, 1.0);
    outColor3 = vec4(1.0, 1.0, 1.0, 1.0);
    outColor4 = vec4(0.0, 0.0, 1.0, 1.0);
    outColor5 = vec4(0.0, 1.0, 1.0, 1.0);
    outColor6 = vec4(1.0, 1.0, 0.0, 1.0);
    outColor7 = vec4(1.0, 1.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (location=2) out vec4 outColor2;
layout (location=3) out vec4 outColor3;
layout (location=4) out vec4 outColor4;
layout (location=5) out vec4 outColor5;
layout (location=6) out vec4 outColor6;
layout (location=7) out vec4 outColor7;
layout (location=8) out vec4 outColor8;
void main(void) {
    outColor0 = vec4(0.0, 0.0, 1.0, 1.0);
    outColor1 = vec4(0.0, 1.0, 1.0, 1.0);
    outColor2 = vec4(1.0, 1.0, 0.0, 1.0);
    outColor3 = vec4(1.0, 1.0, 1.0, 1.0);
    outColor4 = vec4(0.0, 0.0, 1.0, 1.0);
    outColor5 = vec4(0.0, 1.0, 1.0, 1.0);
    outColor6 = vec4(1.0, 1.0, 0.0, 1.0);
    outColor7 = vec4(1.0, 1.0, 1.0, 1.0);
    outColor8 = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
void main(void) {
    const float x = float((gl_VertexIndex >> 1) & 1) * 2.0 - 1.0;
    const float y = float((gl_VertexIndex >> 0) & 1) * 2.0 - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
void main(void) {
    outColor0 = vec4(1.0, 0.0, 1.0, 1.0);
    outColor1 = vec4(0.0, 1.0, 1.0, 1.0);
}
