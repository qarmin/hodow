#version 310 es
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
        result_color = vec4(1.0, 1.0, 0.0, 1.0);
    o_color = result_color;
}
