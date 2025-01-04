#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_FragColor;
void main (void)
{
    fragColor = v_frag_FragColor;
}
