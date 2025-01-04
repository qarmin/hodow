#version 430
layout(location = 0) out vec4 frag_out;
void main()
{
    if (((int(gl_FragCoord.x) / 5) % 2) == ((int(gl_FragCoord.y) / 5) % 2))
        frag_out = vec4(0, 1, 0, 1);
    else
        frag_out = vec4(1, 0, 0, 1);
}
