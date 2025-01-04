#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in float in_data;
layout(location = 0) __explicitInterpAMD out float out_data_explicit;
layout(location = 1) ${auxqualifier} ${qualifier}        out float out_data_${qualifier};

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main() {
    gl_PointSize              = 1.0;
    gl_Position               = in_position;
    out_data_explicit         = in_data;
    out_data_${qualifier}     = in_data;
}
