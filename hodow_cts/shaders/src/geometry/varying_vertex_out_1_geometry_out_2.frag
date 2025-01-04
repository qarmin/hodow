#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) in highp vec4 v_frag_0;
layout(location = 1) in highp vec4 v_frag_1;
void main (void)
{
    fragColor = v_frag_0 + v_frag_1.yxzw;
}
