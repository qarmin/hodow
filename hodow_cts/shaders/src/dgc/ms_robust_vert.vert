#version 460
layout (location=0) in vec2 inXY;
layout (location=1) in float inZ;
void main(void) {
    gl_Position = vec4(inXY.xy, inZ, 1.0);
    gl_PointSize = 1.0;
}
