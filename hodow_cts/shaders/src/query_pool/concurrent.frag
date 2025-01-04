#version 400
layout(location = 0) out vec4 out_FragColor;
void main()
{
    out_FragColor = vec4(0.07, 0.48, 0.75, 1.0);
    if ((int(gl_FragCoord.x) % 2) == (int(gl_FragCoord.y) % 2))
        discard;
}
