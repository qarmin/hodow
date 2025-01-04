#version 450

layout(location = 0) out mediump vec4 color;
layout (std140, set = 0, binding = 0) uniform control_buffer_t
{
    float data[256];
} control_buffer;
layout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;
float controlDepthValue;
void recheck(float controlDepthValue)
{
    if (gl_FragDepth != controlDepthValue)
        gl_FragDepth = 1.0;
}
void main()
{
    const int numSamples = 64;
    if (int(gl_FragCoord.x) == 4)
        discard;
    highp int index =int(gl_FragCoord.y) * 16 + int(gl_FragCoord.x);
    controlDepthValue = control_buffer.data[index];
    gl_FragDepth = controlDepthValue;
    const int sampleNdx = int(gl_SampleID);
    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * 64, int(gl_FragCoord.y));
    imageStore(storageImage, imageCoord, uvec4(1));
    recheck(controlDepthValue);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
