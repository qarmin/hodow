#version 450
layout (location=0) out vec4 out_color;
layout (set=0, binding=0, rgba32f) uniform image2D tex;
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
void main()
{
    out_color = imageLoad(tex, ivec2(index, 0));
}
