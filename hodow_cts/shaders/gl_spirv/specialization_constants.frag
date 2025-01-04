#version 450

layout (constant_id = 10) const int red = 255;

layout (location = 0) out vec4 fragColor;

void main()
{
    fragColor = vec4(float(red) / 255, 0.0, 1.0, 1.0);
}
