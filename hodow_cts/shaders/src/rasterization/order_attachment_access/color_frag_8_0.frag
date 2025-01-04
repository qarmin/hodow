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
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform ${SUBPASS_INPUT} in4;
layout( location = 4 ) out ${VEC_NAME}2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform ${SUBPASS_INPUT} in5;
layout( location = 5 ) out ${VEC_NAME}2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform ${SUBPASS_INPUT} in6;
layout( location = 6 ) out ${VEC_NAME}2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform ${SUBPASS_INPUT} in7;
layout( location = 7 ) out ${VEC_NAME}2 out7;
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
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
    previous[4] = subpassLoad( in4).xy;
    previous[5] = subpassLoad( in5).xy;
    previous[6] = subpassLoad( in6).xy;
    previous[7] = subpassLoad( in7).xy;
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
    if (previous[4].y == 0 && curIndex == 0)
    {
        out4.y = previous[4].y + (1u + zero + gl_SampleID + 4u);
        out4.x = previous[4].x;
    }
    else if (previous[4].y == curIndex + gl_SampleID + 4)
    {
        out4.y = previous[4].y + 1 + zero;
        out4.x = previous[4].x;
    }
    else
    {
        out4.y = 0u;
        out4.x = 1u;
    }
    if (previous[5].y == 0 && curIndex == 0)
    {
        out5.y = previous[5].y + (1u + zero + gl_SampleID + 5u);
        out5.x = previous[5].x;
    }
    else if (previous[5].y == curIndex + gl_SampleID + 5)
    {
        out5.y = previous[5].y + 1 + zero;
        out5.x = previous[5].x;
    }
    else
    {
        out5.y = 0u;
        out5.x = 1u;
    }
    if (previous[6].y == 0 && curIndex == 0)
    {
        out6.y = previous[6].y + (1u + zero + gl_SampleID + 6u);
        out6.x = previous[6].x;
    }
    else if (previous[6].y == curIndex + gl_SampleID + 6)
    {
        out6.y = previous[6].y + 1 + zero;
        out6.x = previous[6].x;
    }
    else
    {
        out6.y = 0u;
        out6.x = 1u;
    }
    if (previous[7].y == 0 && curIndex == 0)
    {
        out7.y = previous[7].y + (1u + zero + gl_SampleID + 7u);
        out7.x = previous[7].x;
    }
    else if (previous[7].y == curIndex + gl_SampleID + 7)
    {
        out7.y = previous[7].y + 1 + zero;
        out7.x = previous[7].x;
    }
    else
    {
        out7.y = 0u;
        out7.x = 1u;
    }
}
