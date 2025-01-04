#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) in flat perprimitiveEXT LocationBlock loc;

void main (void) {
    bool pointOK = true;
    const uint pointIdx = uint(gl_FragCoord.x);
    const uint expectedPayloadOffset = 10u;
    const uint compOffset = 0u;
    for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
        const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + expectedPayloadOffset;
        const uvec4 expectedVal = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        if (loc.elements[elemIdx] != expectedVal) {
            pointOK = false;
            break;
        }
    }
    const vec4 okColor = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 failColor = vec4(0.0, 0.0, 0.0, 1.0);
    outColor = (pointOK ? okColor : failColor);
}
