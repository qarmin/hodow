#version 450

layout (location = 0) out mediump vec4 color;
layout (location = 1) in vec2 texCoord;
layout (binding = 0, set = 0) uniform sampler2DMS u_depthTex;
layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;
void main (void)
{
    const int numSamples = 2;
    const int sampleNdx = int(gl_SampleID);
    ivec2 renderSize = ivec2(16,16);
    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));
    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);
    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
