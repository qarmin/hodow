#version 440
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout(location = 0) in highp vec2 vs_in_position;
layout(location = 1) in highp vec2 vs_in_texCoord;

layout(location = 0) out highp vec3 vs_out_texCoord;

out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = vec4(vs_in_position, 0.0f, 1.0f);
    vs_out_texCoord = vec3(vs_in_texCoord, 0.0f);
}
