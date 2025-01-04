#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT float redColor;
layout (location=1) in flat float greenColor;
layout (location=0) out vec4 outColor;
void main(void) {
    const float blueColor = 0.5;
    outColor = vec4(redColor, greenColor, blueColor, 1.0);
}
