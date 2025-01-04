#version 450
precision mediump float;
layout(location = 0) in vec4 v_unrelated;
layout(binding = 0) uniform ColorUniform
{
    vec4 u_color;
} ucolor;
layout(location = 0) out vec4 fragColor;
void main ()
{
    float blue = dot(v_unrelated, vec4(1.0));
    fragColor = vec4(ucolor.u_color.r, ucolor.u_color.g, blue, ucolor.u_color.a);
}
