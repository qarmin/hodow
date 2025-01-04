#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;

layout (constant_id=0) const uint maxLocations = 1u;
struct LocationStruct {
    uvec4 location_var[maxLocations];
};
layout (location=0) perprimitiveEXT flat in LocationStruct ls;

void main (void) {
    bool success = true;
    for (uint i = 0u; i < maxLocations; ++i) {
        const uint baseVal = 10000u * (i + 1u);
        const uvec4 expectedValue = uvec4(baseVal + 1u, baseVal + 2u, baseVal + 3u, baseVal + 4u);
        success = success && (ls.location_var[i] == expectedValue);
    }
    outColor = (success ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
