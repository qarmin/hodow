#version 450
layout(location = 0) out vec4 fragColor;
void main (void)
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const vec4 colors[4] = vec4[4](yellow, red, green, blue);
    fragColor = colors[gl_PrimitiveID % 4];
}
