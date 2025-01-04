#version 460
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
void main() {
    gl_Position  = in_position;
}
