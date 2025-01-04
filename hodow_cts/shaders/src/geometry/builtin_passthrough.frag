#version 450
layout(location = 0) out vec4 fragColor;
layout(location = 0) in vec4 v_frag_FragColor;
void main (void)
{
    fragColor = v_frag_FragColor;
}
