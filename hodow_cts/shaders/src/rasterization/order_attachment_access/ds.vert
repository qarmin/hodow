#version 460
layout(location = 0) in highp vec2 v_position;
layout(location = 1) flat out uint instance_index;
layout(location = 2) flat out int prim_id;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
void main ()
{
    uint primitiveCur = uint(gl_VertexIndex) / 6u;
    prim_id = gl_VertexIndex / 3;
    uint instanceNum = ${INSTANCE_NUM};
    uint primitiveNum = ${PRIMITIVE_NUM};
    uint drawNum = ${DRAW_NUM};
    uint curIndex = drawCur * instanceNum * primitiveNum + gl_InstanceIndex * primitiveNum + primitiveCur;
    uint indexNum = drawNum * instanceNum * primitiveNum;
    instance_index = gl_InstanceIndex;
    gl_Position = vec4(v_position, 0.125 * float(curIndex) / float(indexNum), 1);
}
