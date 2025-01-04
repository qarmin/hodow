#version 450
layout(location = 0) out vec4 outColor;
layout(location = 1) in vec2 fragTexCoord;
layout(binding = 0) uniform sampler2D compTexSampler;
void main() {
    outColor = texture(compTexSampler, fragTexCoord);
}
