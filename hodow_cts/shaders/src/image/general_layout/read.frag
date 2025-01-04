#version 450
layout (location=0) out vec4 out_color;
layout (location=0) in vec2 texCoord;
#if ${storage} == 1
layout (binding = 0, r32f) uniform image2D storageImage;
#else
layout (binding = 1) uniform sampler2D image;
#endif
void main()
{
    ivec2 coord = ivec2(texCoord * 128.0f);
#if ${storage} == 1
    vec4 color = imageLoad(storageImage, coord);
#else
    vec4 color = texture(image, texCoord);
#endif
    out_color = color;
}
