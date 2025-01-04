#version 460
#extension GL_ARB_shader_stencil_export : enable
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform usubpassInputMS srcStencil;
void main(void) {
    vec4 stencil = vec4(subpassLoad(srcStencil, 0)) * modifiers.ones + modifiers.zeros;
    gl_FragStencilRefARB = 255 - int(stencil.x);
}
