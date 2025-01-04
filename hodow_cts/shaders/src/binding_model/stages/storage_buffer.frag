#version 450

layout(set = 0, binding = 0) buffer readBuffer{
    float readValues[];
};
layout(location = 0) out vec4 color;
void main (void) {
    color = vec4(readValues[0] / 4.0f, readValues[1] / 4.0f, readValues[2] / 4.0f, readValues[3] / 4.0f);
}
