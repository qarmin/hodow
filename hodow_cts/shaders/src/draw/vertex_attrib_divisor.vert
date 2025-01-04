#version 430
layout(location = 0) in vec4 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 2) in vec4 in_color_2;
layout(push_constant) uniform TestParams {
    float firstInstance;
    float instanceCount;
} params;
layout(location = 0) out vec4 out_color;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main() {
    gl_PointSize = 1.0;
    gl_Position  = in_position + vec4(float(gl_InstanceIndex - params.firstInstance) * 2.0 / params.instanceCount, 0.0, 0.0, 0.0);
    out_color    = in_color + vec4(float(gl_InstanceIndex) / params.instanceCount, 0.0, 0.0, 1.0) + in_color_2;
}
