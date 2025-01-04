#version 450
    layout(location = 0) in vec4 pos;
    void main() {
        gl_Position = vec4(pos.xy, 0.0, 1.0);
    }
#version 450
    layout(push_constant) uniform PC { vec4 color; };
    layout(location = 0) out vec4 attachment;
    void main() {
        attachment = vec4(color.rgb, 1.0);
    }
