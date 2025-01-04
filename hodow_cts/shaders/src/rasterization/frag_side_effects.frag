#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;
${headers}

void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    ${color_begin}
    ${before}
    outBuffer.val[bufferIndex] = 1;
    ${after}
    ${color_end}
}
