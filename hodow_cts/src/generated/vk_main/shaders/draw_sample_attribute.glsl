#version 450
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(3.0, -1.0),
    vec2(-1.0, 3.0)
);
layout (location = 0) out float verify;
void main() {
    const uint triIdx     = gl_VertexIndex / 3u;
    const uint triVertIdx = gl_VertexIndex % 3u;
    gl_Position = vec4(positions[triVertIdx], 0.0, 1.0);
    verify = float(triIdx) + float(triVertIdx) / 16.0 + 0.75;
}
#version 450
layout (location = 0) out vec4 outColor;
layout (location = 0) sample in float verify;
layout (std430, binding = 0) buffer Output {
    uint invocationCount;
} buf;
void main() {
    uint one   = uint(ceil(verify));
    uint index = atomicAdd(buf.invocationCount, one);
    outColor = vec4(float(one), 1.0, 0.0, 1.0);
}
#version 450
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(3.0, -1.0),
    vec2(-1.0, 3.0)
);
void main() {
    const uint triIdx     = gl_VertexIndex / 3u;
    const uint triVertIdx = gl_VertexIndex % 3u;
    gl_Position = vec4(positions[triVertIdx], 0.0, 1.0);
}
#version 450
layout (location = 0) out vec4 outColor;
layout (std430, binding = 0) buffer Output {
    uint invocationCount;
} buf;
void main() {
    gl_SampleID;
    uint one   = 1;
    uint index = atomicAdd(buf.invocationCount, one);
    outColor = vec4(float(one), 1.0, 0.0, 1.0);
}
#version 450
layout (location = 0) out vec4 outColor;
layout (std430, binding = 0) buffer Output {
    uint invocationCount;
} buf;
void main() {
    gl_SamplePosition;
    uint one   = 1;
    uint index = atomicAdd(buf.invocationCount, one);
    outColor = vec4(float(one), 1.0, 0.0, 1.0);
}
