#version 460
layout (location=0) in vec4 inPos;
void main (void) { gl_Position = vec4(inPos); }
#version 460
layout (location=0) out vec4 outColor;
void main (void) { outColor = vec4(0.000000, 0.000000, 1.000000, 1.000000); }
#version 460
layout (location=0) in vec2 inPos;
void main (void) { gl_Position = vec4(inPos, 0.0, 1.0); }
#version 460
layout (location=0) in vec4 inPos;
void main (void) { gl_Position = vec4(inPos.xy, floor(abs(inPos.z) / 1000.0), (floor(abs(inPos.w) / 2500.0) + 1.0)); }
#version 460
layout (location=0) in vec4 inPos0;
layout (location=1) in vec4 inPos1;
void main (void) {
    gl_Position = (gl_VertexIndex < 24) ? inPos0 : inPos1;
}
