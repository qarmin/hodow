#version 450 core
layout(location = 0) in vec4 in_position;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main() {
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
