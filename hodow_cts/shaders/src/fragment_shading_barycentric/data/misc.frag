#version 450
#extension GL_EXT_fragment_shader_barycentric : require
layout(location = 0) pervertexEXT in uvec2 dataA[];
layout(location = 1) flat in uvec2 dataB;
layout(location = 0) out uvec4 out_color;
void main()
{
    out_color = uvec4(dataA[0].y + dataA[1].x + dataA[2].y + dataB.x);
}
