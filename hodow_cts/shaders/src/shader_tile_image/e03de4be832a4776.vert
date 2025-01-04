#version 450 core
precision highp float;
precision highp int;
layout(location = 0) in highp vec2 v_position;
layout(location = 0) flat out uint patchIndex;layout( push_constant ) uniform ConstBlock
{
    highp uint drawIndex;
};
void main ()
{
    uint localPatchIndex = uint(gl_VertexIndex) / 3 + 1;
    uint patchCountPerDraw = 1;
    uint globalPatchIndex = drawIndex * patchCountPerDraw + localPatchIndex;
    patchIndex = globalPatchIndex;
    gl_Position = vec4(v_position, 1.000000 * globalPatchIndex, 1);
}
