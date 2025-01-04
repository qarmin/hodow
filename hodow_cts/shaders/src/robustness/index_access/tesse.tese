#version 450
layout(triangles, point_mode) in;
void main(void) {
   gl_Position = gl_in[0].gl_Position;
}
