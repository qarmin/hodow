#version 450
precision highp ${SCALAR_NAME};
precision highp ${SUBPASS_INPUT};
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform ${SUBPASS_INPUT} in0;
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
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
