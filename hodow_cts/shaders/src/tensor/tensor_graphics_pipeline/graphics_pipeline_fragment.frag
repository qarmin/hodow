#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(location = 0) out vec4 outColor;

layout(set=0, binding=0) uniform readonly tensorARM<uint8_t, 3> tensor;

void main() {
    const uint coord_x = uint(gl_FragCoord.x);
    const uint coord_y = uint(gl_FragCoord.y);

    uint8_t tensorValue = uint8_t(0);
    tensorReadARM(tensor, uint[](coord_y, coord_x, 0), tensorValue);
    outColor = vec4(0.0, tensorValue, 0.0, 255.0);
}
