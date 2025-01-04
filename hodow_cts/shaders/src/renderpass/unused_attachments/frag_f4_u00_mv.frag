#version 460
#extension GL_EXT_multiview : enable
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
}
