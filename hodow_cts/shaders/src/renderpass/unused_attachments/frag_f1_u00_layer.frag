#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
void main (void) {
    const uint layerIndex = uint(gl_Layer);
}
