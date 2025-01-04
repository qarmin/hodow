#version 450

layout(push_constant, std430) uniform PushConstants
{
    float texWidth;
    float texHeight;
} pushc;

layout(location = 0) in vec2 inPosition;
layout(location = 1) in vec2 inTexCoord;

layout(location = 0) out vec2 fragTexCoord;

void main() {
    gl_Position = vec4(inPosition, 0.0, 1.0);
    fragTexCoord = vec2(${tex_x}, ${tex_y});
}
