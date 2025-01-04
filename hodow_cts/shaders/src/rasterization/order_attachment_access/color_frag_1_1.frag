#version 450
precision highp ${SCALAR_NAME};
precision highp ${SUBPASS_INPUT};
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform ${SUBPASS_INPUT} in0;
layout( location = 0 ) out ${VEC_NAME}2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
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
    ${VEC_NAME}2 previous[${ATT_NUM}];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (previous[0].y == 0 && curIndex == 0)
    {
        out0.y = previous[0].y + (1u + zero + gl_SampleID + 0u);
        out0.x = previous[0].x;
    }
    else if (previous[0].y == curIndex + gl_SampleID + 0)
    {
        out0.y = previous[0].y + 1 + zero;
        out0.x = previous[0].x;
    }
    else
    {
        out0.y = 0u;
        out0.x = 1u;
    }
}
