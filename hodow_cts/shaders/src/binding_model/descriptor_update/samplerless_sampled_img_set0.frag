#version 450
#extension GL_EXT_samplerless_texture_functions : require
layout(set=0, binding=0) uniform texture2D img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = texelFetch(img, ivec2(0, 0), 0);
}
