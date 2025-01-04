#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec2 dataA;
layout(location = 1) out uvec2 dataB;
void main()
{
    dataA       = uvec2(mod(gl_VertexIndex, 3));
    dataB       = uvec2(7);
    gl_Position = in_position;
}
