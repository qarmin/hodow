#version 430
layout(location = 0) in vec4 in_Position;
out gl_PerVertex { vec4 gl_Position; float gl_PointSize; };
void main() {
    gl_Position  = in_Position;
    gl_PointSize = 1.0;
}
