#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = ${formula};
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
