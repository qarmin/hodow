#version 460
layout (location=2) out vec4 outColor0;
layout (location=1) out vec4 outColor1;
layout (set=0, binding=0) readonly buffer BufferBlock { vec4 zeros; vec4 ones; } modifiers;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInputMS srcImage0;
layout (set=0, binding=2, input_attachment_index=1) uniform subpassInputMS srcImage1;
void main(void) {
    vec4 color0 = subpassLoad(srcImage0, gl_SampleID) * modifiers.ones + modifiers.zeros;
    vec4 color1 = subpassLoad(srcImage1, gl_SampleID) * modifiers.ones + modifiers.zeros;
    outColor0 = color0.gbra;
    outColor1 = color1.gbra;
}
