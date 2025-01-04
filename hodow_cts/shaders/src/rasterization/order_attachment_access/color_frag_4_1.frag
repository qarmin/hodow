#version 450
precision highp ${SCALAR_NAME};
precision highp ${SUBPASS_INPUT};
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform ${SUBPASS_INPUT} in0;
layout( location = 0 ) out ${VEC_NAME}2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform ${SUBPASS_INPUT} in1;
layout( location = 1 ) out ${VEC_NAME}2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform ${SUBPASS_INPUT} in2;
layout( location = 2 ) out ${VEC_NAME}2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform ${SUBPASS_INPUT} in3;
layout( location = 3 ) out ${VEC_NAME}2 out3;
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
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
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
    if (previous[1].y == 0 && curIndex == 0)
    {
        out1.y = previous[1].y + (1u + zero + gl_SampleID + 1u);
        out1.x = previous[1].x;
    }
    else if (previous[1].y == curIndex + gl_SampleID + 1)
    {
        out1.y = previous[1].y + 1 + zero;
        out1.x = previous[1].x;
    }
    else
    {
        out1.y = 0u;
        out1.x = 1u;
    }
    if (previous[2].y == 0 && curIndex == 0)
    {
        out2.y = previous[2].y + (1u + zero + gl_SampleID + 2u);
        out2.x = previous[2].x;
    }
    else if (previous[2].y == curIndex + gl_SampleID + 2)
    {
        out2.y = previous[2].y + 1 + zero;
        out2.x = previous[2].x;
    }
    else
    {
        out2.y = 0u;
        out2.x = 1u;
    }
    if (previous[3].y == 0 && curIndex == 0)
    {
        out3.y = previous[3].y + (1u + zero + gl_SampleID + 3u);
        out3.x = previous[3].x;
    }
    else if (previous[3].y == curIndex + gl_SampleID + 3)
    {
        out3.y = previous[3].y + 1 + zero;
        out3.x = previous[3].x;
    }
    else
    {
        out3.y = 0u;
        out3.x = 1u;
    }
}
