#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
void main()
{
    vec4 out_color_y = mix(vec4(0.0, 1.0, 0.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), gl_FragCoord.y / 16 + 0);
    vec4 out_color_x = mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(0.0, 1.0, 0.0, 1.0), gl_FragCoord.x / 16 + 0);
    out_color = 0.5 * (out_color_y + out_color_x);
}
