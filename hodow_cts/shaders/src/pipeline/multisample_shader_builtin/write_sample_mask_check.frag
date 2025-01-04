#version 450

layout (location=0) out vec4 outColor;

vec4 wcolor = vec4(0, 0, 1, 1);
vec4 ccolor = vec4(0, 0, 0, 1);

layout(set=0, binding=0, input_attachment_index=0) uniform subpassInput${ms} inputAttachment;
layout(set=0, binding=1, std430) buffer StorageBuffer {
    int writeFlags[${buffer_elems}];
} sb;

void main()
{
    uvec2 ucoords          = uvec2(gl_FragCoord);
    ivec2 icoords          = ivec2(ucoords);
    uint  bufferp          = ((ucoords.y * ${width} + ucoords.x) * ${count}) + uint(gl_SampleID);
    vec4  storedc          = subpassLoad(inputAttachment${load_args});
    sb.writeFlags[bufferp] = ((storedc == wcolor) ? 1 : ((storedc == ccolor) ? 0 : 2));
    outColor               = storedc;
}
