#version 460
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcDepth;
void main(void) {
    vec4 depth = subpassLoad(srcDepth, gl_SampleID) * modifiers.ones + modifiers.zeros;
    gl_FragDepth = 1.0 - depth.x;
}
