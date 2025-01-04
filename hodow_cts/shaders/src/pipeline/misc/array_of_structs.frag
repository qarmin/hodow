#version 450
struct R { vec4 rgba; };
layout(location = 0) in R inColor[3];
layout(location = 0) out vec4 color;
void main() {
    color = inColor[2].rgba + inColor[1].rgba + inColor[0].rgba;
}
