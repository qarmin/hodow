#version 310 es
layout(location = 0) in highp vec2 v_position;
layout(location = 1) flat out int prim_id;
void main ()
{
    prim_id = gl_VertexIndex / 3;
    gl_Position = vec4(v_position, float(gl_InstanceIndex)/256.0, 1);
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 previous[1];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 previous[1];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 previous[1];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 previous[1];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 previous[4];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 previous[4];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 previous[4];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 previous[4];
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 previous[8];
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 previous[8];
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 previous[8];
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 previous[8];
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
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInput in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( location = 0 ) out vec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( location = 1 ) out vec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( location = 2 ) out vec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( location = 3 ) out vec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( location = 4 ) out vec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( location = 5 ) out vec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( location = 6 ) out vec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 7 ) out vec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform subpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform subpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform subpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform subpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform subpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform subpassInputMS in7;
layout( location = 0 ) out vec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    vec2 val;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 previous[1];
    previous[0] = subpassLoad( in0).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 previous[1];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 previous[1];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 previous[1];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 previous[1];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    for (i = 0; i < sampleNum; i++) {
        val = subpassLoad(in0, i).xy;
        if (val.x != 0u || val.y != totalNum + i + 0){
            out0.y = val.y;
            out0.x = val.x;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 previous[4];
    previous[0] = subpassLoad( in0).xy;
    previous[1] = subpassLoad( in1).xy;
    previous[2] = subpassLoad( in2).xy;
    previous[3] = subpassLoad( in3).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 previous[4];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 previous[4];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 previous[4];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 previous[4];
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 previous[8];
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 previous[8];
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 previous[8];
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 previous[8];
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInput in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInput in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInput in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInput in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInput in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInput in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 1u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
    int i;
    val = subpassLoad(in0).xy;
    if (val.x != 0u || val.y != totalNum + 0){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in1).xy;
    if (val.x != 0u || val.y != totalNum + 1){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in2).xy;
    if (val.x != 0u || val.y != totalNum + 2){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in3).xy;
    if (val.x != 0u || val.y != totalNum + 3){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in4).xy;
    if (val.x != 0u || val.y != totalNum + 4){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in5).xy;
    if (val.x != 0u || val.y != totalNum + 5){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in6).xy;
    if (val.x != 0u || val.y != totalNum + 6){
        out0.y = val.y;
        out0.x = val.x;
    }
    val = subpassLoad(in7).xy;
    if (val.x != 0u || val.y != totalNum + 7){
        out0.y = val.y;
        out0.x = val.x;
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( location = 0 ) out uvec2 out0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( location = 1 ) out uvec2 out1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( location = 2 ) out uvec2 out2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( location = 3 ) out uvec2 out3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( location = 4 ) out uvec2 out4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( location = 5 ) out uvec2 out5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( location = 6 ) out uvec2 out6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 7 ) out uvec2 out7;
layout( push_constant ) uniform ConstBlock
{
    uint drawCur;
};
layout(location = 1) flat in int prim_id;
void main()
{
    uint instanceCur = uint(round(gl_FragCoord.z * 256.0));
    uint primitiveCur = uint(prim_id) / 2u;
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 previous[8];
    previous[0] = subpassLoad( in0, gl_SampleID).xy;
    previous[1] = subpassLoad( in1, gl_SampleID).xy;
    previous[2] = subpassLoad( in2, gl_SampleID).xy;
    previous[3] = subpassLoad( in3, gl_SampleID).xy;
    previous[4] = subpassLoad( in4, gl_SampleID).xy;
    previous[5] = subpassLoad( in5, gl_SampleID).xy;
    previous[6] = subpassLoad( in6, gl_SampleID).xy;
    previous[7] = subpassLoad( in7, gl_SampleID).xy;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 2u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 4u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 8u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 16u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 32u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in0;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in1;
layout( set = 0, binding = 2, input_attachment_index = 2 ) uniform usubpassInputMS in2;
layout( set = 0, binding = 3, input_attachment_index = 3 ) uniform usubpassInputMS in3;
layout( set = 0, binding = 4, input_attachment_index = 4 ) uniform usubpassInputMS in4;
layout( set = 0, binding = 5, input_attachment_index = 5 ) uniform usubpassInputMS in5;
layout( set = 0, binding = 6, input_attachment_index = 6 ) uniform usubpassInputMS in6;
layout( set = 0, binding = 7, input_attachment_index = 7 ) uniform usubpassInputMS in7;
layout( location = 0 ) out uvec2 out0;
void main()
{
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
    uint sampleNum = 64u;
    uint totalNum = primitiveNum * instanceNum * drawNum;
    out0.y = totalNum;
    out0.x = 0u;
    uvec2 val;
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
    uint instanceNum = 1;
    uint primitiveNum = 1;
    uint drawNum = 6;
    uint curIndex = drawCur * instanceNum * primitiveNum + gl_InstanceIndex * primitiveNum + primitiveCur;
    uint indexNum = drawNum * instanceNum * primitiveNum;
    instance_index = gl_InstanceIndex;
    gl_Position = vec4(v_position, 0.125 * float(curIndex) / float(indexNum), 1);
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 color = subpassLoad( in_color ).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 ds = subpassLoad( in_ds ).xy;
    uvec2 color = subpassLoad( in_color ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
    uint instanceNum = 1;
    uint primitiveNum = 6;
    uint drawNum = 1;
    uint curIndex = drawCur * instanceNum * primitiveNum + gl_InstanceIndex * primitiveNum + primitiveCur;
    uint indexNum = drawNum * instanceNum * primitiveNum;
    instance_index = gl_InstanceIndex;
    gl_Position = vec4(v_position, 0.125 * float(curIndex) / float(indexNum), 1);
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 color = subpassLoad( in_color ).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 ds = subpassLoad( in_ds ).xy;
    uvec2 color = subpassLoad( in_color ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
    uint instanceNum = 6;
    uint primitiveNum = 1;
    uint drawNum = 1;
    uint curIndex = drawCur * instanceNum * primitiveNum + gl_InstanceIndex * primitiveNum + primitiveCur;
    uint indexNum = drawNum * instanceNum * primitiveNum;
    instance_index = gl_InstanceIndex;
    gl_Position = vec4(v_position, 0.125 * float(curIndex) / float(indexNum), 1);
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 color = subpassLoad( in_color ).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 ds = subpassLoad( in_ds ).xy;
    uvec2 color = subpassLoad( in_color ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
    uint instanceNum = 6;
    uint primitiveNum = 6;
    uint drawNum = 6;
    uint curIndex = drawCur * instanceNum * primitiveNum + gl_InstanceIndex * primitiveNum + primitiveCur;
    uint indexNum = drawNum * instanceNum * primitiveNum;
    instance_index = gl_InstanceIndex;
    gl_Position = vec4(v_position, 0.125 * float(curIndex) / float(indexNum), 1);
}
#version 450
precision highp float;
precision highp subpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInput in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 color = subpassLoad( in_color ).xy;
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
#version 450
precision highp int;
precision highp usubpassInput;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInput in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInput in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 ds = subpassLoad( in_ds ).xy;
    uvec2 color = subpassLoad( in_color ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    vec2 ds = subpassLoad( in_ds, gl_SampleID ).xy;
    vec2 color = subpassLoad( in_color, gl_SampleID ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (curIndex == 0 && ds.x == 0)
    {
        out0.x = color.x;
        out0.y = curIndex + 1 + gl_SampleID + zero;
        gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
    }
    else
    {
        const float expected = 0.125 * float(curIndex - 1) / float(total) + gl_SampleID / 128.0;
        const float threshold = 0.0000001;
        if (ds.x >= expected - threshold && ds.x <= expected + threshold)
        {
            out0.x = color.x;
            out0.y = curIndex + 1 + gl_SampleID + zero;
            gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
        }
        else
        {
            out0.y = 0;
            out0.x = 1u;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 1u;
    uint drawNum = 6u;
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
    uvec2 ds = subpassLoad( in_ds, gl_SampleID).xy;
    uvec2 color = subpassLoad( in_color, gl_SampleID).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    vec2 ds = subpassLoad( in_ds, gl_SampleID ).xy;
    vec2 color = subpassLoad( in_color, gl_SampleID ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (curIndex == 0 && ds.x == 0)
    {
        out0.x = color.x;
        out0.y = curIndex + 1 + gl_SampleID + zero;
        gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
    }
    else
    {
        const float expected = 0.125 * float(curIndex - 1) / float(total) + gl_SampleID / 128.0;
        const float threshold = 0.0000001;
        if (ds.x >= expected - threshold && ds.x <= expected + threshold)
        {
            out0.x = color.x;
            out0.y = curIndex + 1 + gl_SampleID + zero;
            gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
        }
        else
        {
            out0.y = 0;
            out0.x = 1u;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 1u;
    uint drawNum = 1u;
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
    uvec2 ds = subpassLoad( in_ds, gl_SampleID).xy;
    uvec2 color = subpassLoad( in_color, gl_SampleID).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    vec2 ds = subpassLoad( in_ds, gl_SampleID ).xy;
    vec2 color = subpassLoad( in_color, gl_SampleID ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (curIndex == 0 && ds.x == 0)
    {
        out0.x = color.x;
        out0.y = curIndex + 1 + gl_SampleID + zero;
        gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
    }
    else
    {
        const float expected = 0.125 * float(curIndex - 1) / float(total) + gl_SampleID / 128.0;
        const float threshold = 0.0000001;
        if (ds.x >= expected - threshold && ds.x <= expected + threshold)
        {
            out0.x = color.x;
            out0.y = curIndex + 1 + gl_SampleID + zero;
            gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
        }
        else
        {
            out0.y = 0;
            out0.x = 1u;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 1u;
    uint instanceNum = 6u;
    uint drawNum = 1u;
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
    uvec2 ds = subpassLoad( in_ds, gl_SampleID).xy;
    uvec2 color = subpassLoad( in_color, gl_SampleID).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
#version 450
precision highp float;
precision highp subpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform subpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform subpassInputMS in_ds;
layout( location = 0 ) out vec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    vec2 ds = subpassLoad( in_ds, gl_SampleID ).xy;
    vec2 color = subpassLoad( in_color, gl_SampleID ).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (curIndex == 0 && ds.x == 0)
    {
        out0.x = color.x;
        out0.y = curIndex + 1 + gl_SampleID + zero;
        gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
    }
    else
    {
        const float expected = 0.125 * float(curIndex - 1) / float(total) + gl_SampleID / 128.0;
        const float threshold = 0.0000001;
        if (ds.x >= expected - threshold && ds.x <= expected + threshold)
        {
            out0.x = color.x;
            out0.y = curIndex + 1 + gl_SampleID + zero;
            gl_FragDepth = 0.125 * (float(curIndex) / float(total)) + gl_SampleID / 128.0;
        }
        else
        {
            out0.y = 0;
            out0.x = 1u;
        }
    }
}
#version 450
precision highp int;
precision highp usubpassInputMS;
layout( set = 0, binding = 0, input_attachment_index = 0 ) uniform usubpassInputMS in_color;
layout( set = 0, binding = 1, input_attachment_index = 1 ) uniform usubpassInputMS in_ds;
layout( location = 0 ) out uvec2 out0;
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
    uint primitiveNum = 6u;
    uint instanceNum = 6u;
    uint drawNum = 6u;
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
    uvec2 ds = subpassLoad( in_ds, gl_SampleID).xy;
    uvec2 color = subpassLoad( in_color, gl_SampleID).xy;
    for(index = 0u; index < post_fetch_loop; index++)
    {
        zero = uint(sin(float(zero)));
    }
    if (ds.x == curIndex)
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
