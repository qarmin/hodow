#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material {
    layout(offset = 0)  vec4 index; 
    layout(offset = 16) vec4 vecType; 
    layout(offset = 32) mat2 matType; 
    layout(offset = 48) float[4] arrType; 
} matInst;
void main (void)
{
    fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    // Mix in gl_FragCoord to (hopefully) prevent optimizing our index away
    int vec_selector = int(gl_FragCoord.x * 0.0000001 + 0);
    int mat_selector = int(gl_FragCoord.x * 0.0000001 + 1);
    int arr_selector = int(gl_FragCoord.x * 0.0000001 + 2);
    if (matInst.vecType[int(matInst.index[vec_selector])] != 0.25)
        fragColor += vec4(0.0, 0.5, 0.0, 1.0);
    if (matInst.matType[int(matInst.index[mat_selector])][0] != 0.5)
        fragColor += vec4(0.0, 0.0, 0.5, 1.0);
    if (matInst.arrType[int(matInst.index[arr_selector])] != 0.75)
        fragColor = vec4(0.0, 0.5, 0.5, 1.0);
}
