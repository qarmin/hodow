#version 450
layout(rgba8, set=1, binding=0) uniform image2D img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = imageLoad(img, ivec2(0, 0));
}
