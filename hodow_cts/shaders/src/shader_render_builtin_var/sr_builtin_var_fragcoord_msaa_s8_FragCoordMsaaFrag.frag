#version 450

layout(location = 0) out mediump vec4 color;
layout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;
void main()
{
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 8, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, gl_FragCoord);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
