#version 310 es
layout(set = 0, binding = 32766, std140) buffer BufferNameA
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instanceA;
layout(set = 0, binding = 65534, std140) buffer BufferNameB
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instanceB;
layout(location = 1) flat in highp int frag_quadrant_id;
layout(location = 0) out mediump vec4 o_color;
void main (void)
{
    highp int quadrant_id = frag_quadrant_id;
    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color += b_instanceA.colorA;
    else
        result_color += b_instanceB.colorB;
    o_color = result_color;
}
