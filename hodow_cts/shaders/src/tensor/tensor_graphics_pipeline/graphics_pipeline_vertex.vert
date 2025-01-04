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
