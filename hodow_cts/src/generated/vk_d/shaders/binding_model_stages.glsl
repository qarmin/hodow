#version 450

layout(set = 0, binding = 0) buffer readBuffer{
    float readValues[];
};
layout(set = 1, binding = 0) buffer writeBuffer{
    float writeValues[];
};

void main (void) {
    writeValues[gl_GlobalInvocationID.x] = readValues[gl_GlobalInvocationID.x];
}
#version 450

void main (void) {
    gl_Position = vec4(float(gl_VertexIndex & 1) * 2.0f - 1.0f, float((gl_VertexIndex >> 1) & 1) * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450

layout(set = 0, binding = 0) buffer readBuffer{
    float readValues[];
};
layout(location = 0) out vec4 color;
void main (void) {
    color = vec4(readValues[0] / 4.0f, readValues[1] / 4.0f, readValues[2] / 4.0f, readValues[3] / 4.0f);
}
#version 450

layout(set = 0, binding = 0) uniform readBuffer{
    vec4 readValues;
};
layout(set = 1, binding = 0) buffer writeBuffer{
    float writeValues[];
};

void main (void) {
    writeValues[gl_GlobalInvocationID.x] = readValues[gl_GlobalInvocationID.x];
}
#version 450

layout(set = 0, binding = 0) uniform readBuffer{
    vec4 readValues;
};
layout(location = 0) out vec4 color;
void main (void) {
    color = vec4(readValues[0] / 4.0f, readValues[1] / 4.0f, readValues[2] / 4.0f, readValues[3] / 4.0f);
}
#version 450

layout(set = 0, binding = 0) uniform sampler2D readImage;
layout(set = 1, binding = 0) buffer writeBuffer{
    float writeValues[];
};

void main (void) {
    writeValues[gl_GlobalInvocationID.x] = texture(readImage, vec2(0.0f))[gl_GlobalInvocationID.x] * 4.0f;
}
#version 450

layout(set = 0, binding = 0) uniform sampler2D readImage;
layout(location = 0) out vec4 color;
void main (void) {
    color = texture(readImage, vec2(0.5f));
}
