#version 460
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2( 3.0, -1.0),
    vec2(-1.0,  3.0)
);
void main (void) {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 310 es
precision mediump float;
layout (location = 0) in vec4 vertexPosition;
void main()
{
    gl_Position = vertexPosition;
}
#version 310 es
precision mediump float;
layout (location = 0) out vec4 outputColor;
void main()
{
    outputColor = vec4(1.0, 0.0, 0.0, 1.0);
}
