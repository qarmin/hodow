#version 450
layout(location = 0) in vec2 uv;
layout(location = 0) out vec4 color;
layout(set = 0, binding = 1) uniform sampler2D tex[8];
void main() {
    color = texture(tex[0], uv) * texture(tex[1], uv);
}
