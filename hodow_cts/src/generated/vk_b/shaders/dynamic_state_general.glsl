#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = inColor;
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    if (inColor == vec4(0.0, 0.0, 1.0, 1.0)) {
        discard;
    }
    outColor = inColor;
}
#version 460
const vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  3.0, 0.0, 1.0),
    vec4( 3.0, -1.0, 0.0, 1.0)
);
void main (void) {
    gl_Position = vertices[gl_VertexIndex % 3];
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0f, 0.0f, 1.0f, 1.0f);
}
