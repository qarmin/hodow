#version 460
const vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  3.0, 0.0, 1.0),
    vec4( 3.0, -1.0, 0.0, 1.0)
);
void main (void) {
    gl_Position = vertices[gl_VertexIndex % 3];
}
#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0, std430) readonly buffer CoverageBlock { float alpha[192]; } coverage;
void main(void) {
    const int cols = 3;
    const int rows = 16;
    const int sampleCount = 4;
    const int xIdx = int(gl_FragCoord.x);
    const int yIdx = int(gl_FragCoord.y);
    const int bufferIdx = yIdx * (sampleCount * cols) + xIdx * sampleCount + gl_SampleID;
    const float alpha = coverage.alpha[bufferIdx];
    outColor = vec4(0.0, 0.0, 1.0, alpha);
}
#version 460
layout (local_size_x=3, local_size_y=16, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2DMS resultSampler;
layout (rgba8, set=0, binding=1) uniform image2D expandedImg;
void main(void) {
    const int sampleCount = 4;
    const int shiftBits = 1;
    const int shiftMask = (1 << shiftBits) - 1;
    const ivec2 invID = ivec2(gl_LocalInvocationID.xy);
    for (int i = 0; i < sampleCount; ++i) {
        const int subCol = ((i >> shiftBits) & shiftMask);
        const int subRow = (i & shiftMask);
        const int xCoord = invID.x * 2 + subCol;
        const int yCoord = invID.y * 2 + subRow;
        const vec4 resultColor = texelFetch(resultSampler, invID, i);
        imageStore(expandedImg, ivec2(xCoord, yCoord), resultColor);
    }
}
