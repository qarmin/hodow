#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material {
    layout(offset = 0) int kind; 
} matInst;
void main (void)
{
    switch (matInst.kind) {
    case 0: fragColor = vec4(0, 1.0, 0, 1.0); break;
    case 1: fragColor = vec4(0, 0.0, 1.0, 1.0); break;
    case 2: fragColor = vtxColor; break;
    default: fragColor = vec4(1.0, 1.0, 1.0, 1.0); break;}
}
