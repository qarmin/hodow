#version 310 es
layout(set = 0, binding = 0, std140) buffer BufferName
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instance;
layout(location = 0) in mediump vec4 frag_color;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance.colorA;
    else
        result_color += b_instance.colorB;
    if (frag_quadrant_id < 2)
        o_color = result_color;
    else
        o_color = frag_color;
}
