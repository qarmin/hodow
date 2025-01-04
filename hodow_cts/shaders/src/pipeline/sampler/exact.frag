#version 450

layout(set = 0, binding = 0) uniform ${sampler_type} texSampler;

layout(location = 0) in vec2 fragTexCoord;

layout(location = 0) out ${color_type} outColor;

void main() {
    outColor = ${lookup};
}
