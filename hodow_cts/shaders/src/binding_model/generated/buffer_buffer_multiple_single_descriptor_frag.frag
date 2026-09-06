#version 310 es
layout(set = 0, binding = 0, std140) buffer BufferName0
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instance0;
layout(set = 1, binding = 0, std140) buffer BufferName1
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instance1;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance0.colorA;
    else
        result_color += b_instance0.colorB;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instance1.colorA;
    else
        result_color += b_instance1.colorB;
    result_color /= vec4(2.0);
    o_color = result_color;
}
