#version 460
layout (location=0) out vec4 outColor0;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, 3) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
}
