#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in vec2 inTexCoord;
layout(location = 1) out vec2 fragTexCoord;
void main (void) {
    gl_Position = a_position;
    fragTexCoord = inTexCoord;
}
