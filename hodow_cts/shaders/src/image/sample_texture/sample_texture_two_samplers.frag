#version 450
layout(location = 0) out vec4 outColor;
layout(location = 1) in vec2 fragTexCoord;
layout(binding = 0) uniform sampler2D compTexSampler;
layout(binding = 1) uniform usampler2D texSampler;
layout(push_constant) uniform constants {
    int pass;
} pc;
void main() {
    if (pc.pass == 1)
        outColor = texture(compTexSampler, fragTexCoord);
    else        outColor = texture(texSampler, fragTexCoord);
}
