#version 450
precision highp ${SCALAR_NAME};
precision highp ${SUBPASS_INPUT};
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform ${SUBPASS_INPUT} in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform ${SUBPASS_INPUT} in_ds;
layout( location = 0 ) out ${VEC_NAME}2 out0;
layout( location = 1 ) flat in uint instance_index;
layout( location = 2 ) flat in int prim_id;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
void main()
{
    uint instanceCur = instance_index;
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = ${PRIMITIVE_NUM}u;
    uint instanceNum = ${INSTANCE_NUM}u;
    uint drawNum = ${DRAW_NUM}u;
    uint curIndex = drawCur * instanceNum * primitiveNum + instanceCur * primitiveNum + primitiveCur;
    uint total = drawNum * instanceNum * primitiveNum;
    uint zero = curIndex / total;
    uint index;
    uint pre_fetch_loop = uint(gl_FragCoord.x) * uint(gl_FragCoord.y) * (drawNum * primitiveNum - drawCur * primitiveNum - primitiveCur);
    uint post_fetch_loop = uint(gl_FragCoord.x) + uint(gl_FragCoord.y) + (drawNum * instanceNum - drawCur * instanceNum - instanceCur);
    for(index = 0u; index < pre_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    vec2 ds = subpassLoad( in_ds ).xy;
    ${VEC_NAME}2 color = subpassLoad( in_color ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (curIndex == 0 && ds.x == 0)
    {
        out0.x = color.x;
        out0.y = curIndex + 1 + gl_SampleID + zero;
    }
    else
    {
        const float expected = 0.125 * float(curIndex - 1) / float(total) + gl_SampleID / 128.0;
        const float threshold = 0.0000001;
        if (ds.x >= expected - threshold && ds.x <= expected + threshold)
        {
            out0.x = color.x;
            out0.y = curIndex + 1 + gl_SampleID + zero;
        }
        else
        {
            out0.y = 0;
            out0.x = 1u;
        }
    }
}
