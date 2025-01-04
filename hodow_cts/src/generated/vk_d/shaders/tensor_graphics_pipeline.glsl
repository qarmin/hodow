#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(set=0, binding=1) uniform readonly tensorARM<int32_t, 2> tensor;

layout (constant_id = 0) const uint32_t imageShapeWidth  = 0;
layout (constant_id = 1) const uint32_t imageShapeHeight = 0;

vec2 imageShape = vec2(float(imageShapeWidth), float(imageShapeHeight));
vec2 imageShapeHalvedInv = 2.0 / imageShape;

void main() {
    int32_t pos_x, pos_y;
    tensorReadARM(tensor, uint[](gl_VertexIndex, 0), pos_x);
    tensorReadARM(tensor, uint[](gl_VertexIndex, 1), pos_y);
    const vec2 position = vec2(pos_x, pos_y);
    const vec2 clip_space_pos = position * imageShapeHalvedInv - 1.0;
    gl_Position = vec4(clip_space_pos, 0.0, 1.0);
}
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
