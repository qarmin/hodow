#version 450
precision highp ${SCALAR_NAME};
precision highp ${SUBPASS_INPUT};
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform ${SUBPASS_INPUT} in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform ${SUBPASS_INPUT} in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform ${SUBPASS_INPUT} in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform ${SUBPASS_INPUT} in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform ${SUBPASS_INPUT} in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform ${SUBPASS_INPUT} in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform ${SUBPASS_INPUT} in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform ${SUBPASS_INPUT} in7;
layout( location = 0 ) out ${VEC_NAME}2 out0;
void main()
{
    uint primitiveNum = ${PRIMITIVE_NUM}u;
    uint instanceNum = ${INSTANCE_NUM}u;
    uint drawNum = ${DRAW_NUM}u;
    uint sampleNum = ${SAMPLE_NUM}u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    ${VEC_NAME}2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in1, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 1){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in2, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 2){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in3, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 3){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in4, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 4){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in5, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 5){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in6, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 6){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in7, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 7){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
