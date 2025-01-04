#version 460
layout (location=0) in vec4 inPosition;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    gl_Position  = inPosition;
    gl_PointSize = 2.000000;
}
