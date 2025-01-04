#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in float inData0;
layout (location=0) out flat float outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat float inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    float value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec2 inData0;
layout (location=0) out flat vec2 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat vec2 inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    vec2 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec3 inData0;
layout (location=0) out flat vec3 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
#extension GL_EXT_scalar_block_layout : require
layout (location=0) out vec4 outColor;
layout (location=0) in flat vec3 inData0;
layout (set=0, binding=0, scalar) buffer VerificationBlock0 {
    vec3 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inData0;
layout (location=0) out flat vec4 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat vec4 inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    vec4 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in int inData0;
layout (location=0) out flat int outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat int inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    int value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in ivec2 inData0;
layout (location=0) out flat ivec2 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat ivec2 inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    ivec2 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in ivec3 inData0;
layout (location=0) out flat ivec3 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
#extension GL_EXT_scalar_block_layout : require
layout (location=0) out vec4 outColor;
layout (location=0) in flat ivec3 inData0;
layout (set=0, binding=0, scalar) buffer VerificationBlock0 {
    ivec3 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in ivec4 inData0;
layout (location=0) out flat ivec4 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat ivec4 inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    ivec4 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in uint inData0;
layout (location=0) out flat uint outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat uint inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    uint value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in uvec2 inData0;
layout (location=0) out flat uvec2 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat uvec2 inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    uvec2 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in uvec3 inData0;
layout (location=0) out flat uvec3 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
#extension GL_EXT_scalar_block_layout : require
layout (location=0) out vec4 outColor;
layout (location=0) in flat uvec3 inData0;
layout (set=0, binding=0, scalar) buffer VerificationBlock0 {
    uvec3 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in uvec4 inData0;
layout (location=0) out flat uvec4 outData0;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat uvec4 inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    uvec4 value[];
} verificationBuffer0;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in uint inData0;
layout (location=0) out flat uint outData0;
layout (location=2) in ivec2 inData1;
layout (location=1) out flat ivec2 outData1;
layout (location=3) in vec4 inData2;
layout (location=2) out flat vec4 outData2;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
    outData1 = inData1;
    outData2 = inData2;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat uint inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    uint value[];
} verificationBuffer0;
layout (location=1) in flat ivec2 inData1;
layout (set=0, binding=1, std430) buffer VerificationBlock1 {
    ivec2 value[];
} verificationBuffer1;
layout (location=2) in flat vec4 inData2;
layout (set=0, binding=2, std430) buffer VerificationBlock2 {
    vec4 value[];
} verificationBuffer2;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
    verificationBuffer1.value[index] = inData1;
    verificationBuffer2.value[index] = inData2;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in int inData0;
layout (location=0) out flat int outData0;
layout (location=2) in uvec3 inData1;
layout (location=1) out flat uvec3 outData1;
layout (location=3) in ivec2 inData2;
layout (location=2) out flat ivec2 outData2;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
    outData1 = inData1;
    outData2 = inData2;
}
#version 460
#extension GL_EXT_scalar_block_layout : require
layout (location=0) out vec4 outColor;
layout (location=0) in flat int inData0;
layout (set=0, binding=0, scalar) buffer VerificationBlock0 {
    int value[];
} verificationBuffer0;
layout (location=1) in flat uvec3 inData1;
layout (set=0, binding=1, scalar) buffer VerificationBlock1 {
    uvec3 value[];
} verificationBuffer1;
layout (location=2) in flat ivec2 inData2;
layout (set=0, binding=2, scalar) buffer VerificationBlock2 {
    ivec2 value[];
} verificationBuffer2;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
    verificationBuffer1.value[index] = inData1;
    verificationBuffer2.value[index] = inData2;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in uvec4 inData0;
layout (location=0) out flat uvec4 outData0;
layout (location=2) in uint inData1;
layout (location=1) out flat uint outData1;
layout (location=3) in ivec2 inData2;
layout (location=2) out flat ivec2 outData2;
void main (void) {
    gl_Position = inPos;
    outData0 = inData0;
    outData1 = inData1;
    outData2 = inData2;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in flat uvec4 inData0;
layout (set=0, binding=0, std430) buffer VerificationBlock0 {
    uvec4 value[];
} verificationBuffer0;
layout (location=1) in flat uint inData1;
layout (set=0, binding=1, std430) buffer VerificationBlock1 {
    uint value[];
} verificationBuffer1;
layout (location=2) in flat ivec2 inData2;
layout (set=0, binding=2, std430) buffer VerificationBlock2 {
    ivec2 value[];
} verificationBuffer2;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
    verificationBuffer0.value[index] = inData0;
    verificationBuffer1.value[index] = inData1;
    verificationBuffer2.value[index] = inData2;
}
