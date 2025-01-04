#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 1.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(1.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
}
#version 460
layout (set=0, binding=0) uniform sampler2DMS resImage;
layout (set=0, binding=1) uniform sampler2DMS refImage;
layout (set=0, binding=2, std430) buffer OutputBlock { uint flags[16]; } outBuffer;
layout (local_size_x=4, local_size_y=1, local_size_z=1) in;
void main (void) {
    const ivec2 inCoords = ivec2(gl_WorkGroupID.xy);

    const uint sampleCount = gl_WorkGroupSize.x;
    const uint colCount = gl_NumWorkGroups.x;
    const uint rowCount = gl_NumWorkGroups.y;
    const uint col = gl_WorkGroupID.x;
    const uint row = gl_WorkGroupID.y;
    const uint sampleIdx = gl_LocalInvocationIndex;
    const uint outIndex = row * colCount * sampleCount + col * sampleCount + sampleIdx;

    const vec4 resColor = texelFetch(resImage, inCoords, int(sampleIdx));
    const vec4 refColor = texelFetch(refImage, inCoords, int(sampleIdx));
    const uint outValue = (resColor == refColor ? 1u : 0u);
    outBuffer.flags[outIndex] = outValue;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const bool isTopLeftPixel = (gl_FragCoord.x < 1.0 && gl_FragCoord.y < 1.0);
    gl_SampleMask[0] = (isTopLeftPixel ? 0 : 0xFF);
    outColor = vec4(0.0, 1.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const bool isTopLeftPixel = (gl_FragCoord.x < 1.0 && gl_FragCoord.y < 1.0);
    gl_SampleMask[0] = (isTopLeftPixel ? 0 : 0xFF);
    outColor = vec4(1.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const bool isTopLeftPixel = (gl_FragCoord.x < 1.0 && gl_FragCoord.y < 1.0);
    gl_SampleMask[0] = (isTopLeftPixel ? 0 : 0xFF);
    outColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    const bool isTopLeftPixel = (gl_FragCoord.x < 1.0 && gl_FragCoord.y < 1.0);
    gl_SampleMask[0] = (isTopLeftPixel ? 0 : 0xFF);
    outColor = vec4(1.0, 1.0, 1.0, 1.0);
}
#version 460
#extension GL_EXT_fragment_shading_rate : enable
layout (location=0) out vec4 outColor;
void main (void) {
    const float red = (((gl_ShadingRateEXT & gl_ShadingRateFlag2VerticalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float green = (((gl_ShadingRateEXT & gl_ShadingRateFlag2HorizontalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float blue = 0.0;
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
#extension GL_EXT_fragment_shading_rate : enable
layout (location=0) out vec4 outColor;
void main (void) {
    const float red = (((gl_ShadingRateEXT & gl_ShadingRateFlag2VerticalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float green = (((gl_ShadingRateEXT & gl_ShadingRateFlag2HorizontalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float blue = (gl_SampleID + 1) / 1.0;
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
layout (set=0, binding=0) uniform sampler2D srcImage;
layout (set=0, binding=1, rgba8) uniform image2D dstImage;
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
void main (void) {
    const ivec2 srcCoords = ivec2(gl_WorkGroupID.xy);

    const uint sampleCount = gl_WorkGroupSize.x;
    const uint srcCol = gl_WorkGroupID.x;
    const uint srcRow = gl_WorkGroupID.y;
    const uint sampleIdx = gl_LocalInvocationIndex;
    const uint dstCol = srcCol * sampleCount + sampleIdx;
    const uint dstRow = srcRow;

    const ivec2 dstCoords = ivec2(dstCol, dstRow);

    const vec4 srcColor = texelFetch(srcImage, srcCoords, 0);
    imageStore(dstImage, dstCoords, srcColor);
}
#version 460
#extension GL_EXT_fragment_shading_rate : enable
layout (location=0) out vec4 outColor;
void main (void) {
    const float red = (((gl_ShadingRateEXT & gl_ShadingRateFlag2VerticalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float green = (((gl_ShadingRateEXT & gl_ShadingRateFlag2HorizontalPixelsEXT) != 0) ? 1.0 : 0.5);
    const float blue = (gl_SampleID + 1) / 4.0;
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
layout (set=0, binding=0) uniform sampler2DMS srcImage;
layout (set=0, binding=1, rgba8) uniform image2D dstImage;
layout (local_size_x=4, local_size_y=1, local_size_z=1) in;
void main (void) {
    const ivec2 srcCoords = ivec2(gl_WorkGroupID.xy);

    const uint sampleCount = gl_WorkGroupSize.x;
    const uint srcCol = gl_WorkGroupID.x;
    const uint srcRow = gl_WorkGroupID.y;
    const uint sampleIdx = gl_LocalInvocationIndex;
    const uint dstCol = srcCol * sampleCount + sampleIdx;
    const uint dstRow = srcRow;

    const ivec2 dstCoords = ivec2(dstCol, dstRow);

    const vec4 srcColor = texelFetch(srcImage, srcCoords, int(sampleIdx));
    imageStore(dstImage, dstCoords, srcColor);
}
#version 460
layout (location=0) out vec4 outColor;
layout (rgba8, set=0, binding=0) uniform image2D img;
void main(){
    const vec4 geomColor = vec4(0.0, 0.0, 1.0, 1.0);
    const ivec2 iFragCoord = ivec2(gl_FragCoord.xy);
    const int yCoord = iFragCoord.x;
    imageStore(img, ivec2(iFragCoord.x, yCoord), geomColor);
    outColor = geomColor;
}
#version 460
layout (location=0) out vec4 outColor;
layout (rgba8, set=0, binding=0) uniform image2D img;
void main(){
    const vec4 geomColor = vec4(0.0, 0.0, 1.0, 1.0);
    const ivec2 iFragCoord = ivec2(gl_FragCoord.xy);
    const int yCoord = gl_SampleID;
    imageStore(img, ivec2(iFragCoord.x, yCoord), geomColor);
    outColor = geomColor;
}
#version 460
layout (location=0) in vec2 inXY;
layout (location=1) in float inZ;
void main(void) {
    gl_Position = vec4(inXY.xy, inZ, 1.0);
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_Position = inPos;
}
