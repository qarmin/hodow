#version 430
layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 0) noperspective out vec4 out_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main() {
    gl_PointSize = 1.0;
    gl_Position  = in_position;
    out_color    = in_color;
}
