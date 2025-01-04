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
