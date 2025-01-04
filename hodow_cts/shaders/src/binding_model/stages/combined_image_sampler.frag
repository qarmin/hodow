#version 450

layout(set = 0, binding = 0) uniform sampler2D readImage;
layout(location = 0) out vec4 color;
void main (void) {
    color = texture(readImage, vec2(0.5f));
}
