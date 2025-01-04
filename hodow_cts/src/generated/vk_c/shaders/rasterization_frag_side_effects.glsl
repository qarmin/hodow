#version 450

layout (location=0) in vec2 inPos;

void main() {
    gl_Position = vec4(inPos, 0.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    
    outBuffer.val[bufferIndex] = 1;
    discard;
    
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;
#extension GL_EXT_demote_to_helper_invocation : enable

void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    
    outBuffer.val[bufferIndex] = 1;
    demote;
    
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;
#extension GL_EXT_terminate_invocation : enable

void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    
    outBuffer.val[bufferIndex] = 1;
    terminateInvocation;
    
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    gl_SampleMask[0] = 0;
    outBuffer.val[bufferIndex] = 1;
    
    
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    
    outBuffer.val[bufferIndex] = 1;
    gl_SampleMask[0] = 0;
    
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    
    outBuffer.val[bufferIndex] = 1;
    
    
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor.rgb = vec3(0.0, 0.0, 1.0);
    outColor.a = float(0.0);
    outBuffer.val[bufferIndex] = 1;
    
    
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    outColor.rgb = vec3(0.0, 0.0, 1.0);
    
    outBuffer.val[bufferIndex] = 1;
    outColor.a = float(0.0);
    
}
#version 450

layout (location=0) in vec2 inPos;

void main() {
    gl_Position = vec4(inPos, 0.75, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    
    outBuffer.val[bufferIndex] = 1;
    discard;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;
#extension GL_EXT_demote_to_helper_invocation : enable

void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    
    outBuffer.val[bufferIndex] = 1;
    demote;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;
#extension GL_EXT_terminate_invocation : enable

void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    
    outBuffer.val[bufferIndex] = 1;
    terminateInvocation;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    gl_SampleMask[0] = 0;
    outBuffer.val[bufferIndex] = 1;
    
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    
    outBuffer.val[bufferIndex] = 1;
    gl_SampleMask[0] = 0;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    
    outBuffer.val[bufferIndex] = 1;
    
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    outColor.a = float(0.0);
    outBuffer.val[bufferIndex] = 1;
    
    outColor.rgb = vec3(0.0, 0.0, 1.0);
}
#version 450
layout(set=0, binding=0, std430) buffer OutputBuffer {
    int val[1024];
} outBuffer;
layout (location=0) out vec4 outColor;


void main() {
    const ivec2 fragCoord = ivec2(gl_FragCoord);
    const int bufferIndex = (fragCoord.y * 32) + fragCoord.x;
    
    
    outBuffer.val[bufferIndex] = 1;
    outColor.a = float(0.0);
    outColor.rgb = vec3(0.0, 0.0, 1.0);
}
