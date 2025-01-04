#version 450
layout (location = 0) out vec2 texCoord;
void main()
{
    texCoord = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);
    gl_Position = vec4(texCoord * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
layout (location=0) out vec4 out_color;
layout (location=0) in vec2 texCoord;
layout (set=0, binding=0) uniform sampler2D combinedSampler;
void main()
{
    out_color = texture(combinedSampler, texCoord);
}
#version 450
layout (location = 0) in vec2 texCoord;
layout (binding = 0, r32f) uniform image2D storageImage;
void main()
{
    ivec2 coord = ivec2(texCoord * 128.0f);
    vec4 color = vec4(coord.x + coord.y);
    imageStore(storageImage, coord, color);
}
#version 450
layout (location=0) out vec4 out_color;
layout (location=0) in vec2 texCoord;
#if 1 == 1
layout (binding = 0, r32f) uniform image2D storageImage;
#else
layout (binding = 1) uniform sampler2D image;
#endif
void main()
{
    ivec2 coord = ivec2(texCoord * 128.0f);
#if 1 == 1
    vec4 color = imageLoad(storageImage, coord);
#else
    vec4 color = texture(image, texCoord);
#endif
    out_color = color;
}
#version 450
layout (local_size_x = 1, local_size_y = 1) in;
layout (binding = 0, r32f) uniform image2D storageImage;
void main()
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = vec4(coord.x + coord.y);
    imageStore(storageImage, coord, color);
}
#version 450
layout (local_size_x = 1, local_size_y = 1) in;
#if 1 == 1
layout (binding = 0, r32f) uniform image2D storageImage;
#else
layout (binding = 1) uniform sampler2D image;
#endif
layout (binding = 2) buffer OutputBuffer { float data[]; } outputBuffer;
void main()
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
#if 1 == 1
    vec4 color = imageLoad(storageImage, coord);
#else
    vec4 color = texture(image, vec2(coord) / vec2(128.0f));
#endif
    outputBuffer.data[coord.y * 128 + coord.x] = color.r;
}
#version 450
layout (location=0) out vec4 out_color;
layout (location=0) in vec2 texCoord;
#if 0 == 1
layout (binding = 0, r32f) uniform image2D storageImage;
#else
layout (binding = 1) uniform sampler2D image;
#endif
void main()
{
    ivec2 coord = ivec2(texCoord * 128.0f);
#if 0 == 1
    vec4 color = imageLoad(storageImage, coord);
#else
    vec4 color = texture(image, texCoord);
#endif
    out_color = color;
}
#version 450
layout (local_size_x = 1, local_size_y = 1) in;
#if 0 == 1
layout (binding = 0, r32f) uniform image2D storageImage;
#else
layout (binding = 1) uniform sampler2D image;
#endif
layout (binding = 2) buffer OutputBuffer { float data[]; } outputBuffer;
void main()
{
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
#if 0 == 1
    vec4 color = imageLoad(storageImage, coord);
#else
    vec4 color = texture(image, vec2(coord) / vec2(128.0f));
#endif
    outputBuffer.data[coord.y * 128 + coord.x] = color.r;
}
#version 450
layout (location = 0) in vec2 texCoord;
#if 1 == 1
layout(input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput inputAttachment;
#else
layout(set = 0, binding = 0) uniform sampler2D image;
#endif
layout(location = 0) out vec4 out_color;
void main()
{
#if 1 == 1
    out_color = subpassLoad(inputAttachment) / 2.0f;
#else
    out_color = texture(image, texCoord) / 2.0f;
#endif
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 1) uniform subpassInput inputAttachment;
layout(location = 0) out vec4 out_color;
void main()
{
    out_color = vec4(1.0f) - subpassLoad(inputAttachment);
}
#version 450
layout (location = 0) in vec2 texCoord;
#if 0 == 1
layout(input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput inputAttachment;
#else
layout(set = 0, binding = 0) uniform sampler2D image;
#endif
layout(location = 0) out vec4 out_color;
void main()
{
#if 0 == 1
    out_color = subpassLoad(inputAttachment) / 2.0f;
#else
    out_color = texture(image, texCoord) / 2.0f;
#endif
}
#version 450
layout (location = 0) out vec2 texCoord;
void main()
{
    texCoord = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);
    gl_Position = vec4(texCoord * 4.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
layout (location = 0) in vec2 texCoord;
layout (location = 0) out vec4 out_color0;
void main()
{
    out_color0 = vec4(texCoord, 0.0f, 1.0f);
}
#version 450
layout (location = 0) in vec2 texCoord;
layout (location = 0) out vec4 out_color0;
layout (location = 1) out vec4 out_color1;
layout (location = 2) out vec4 out_color2;
layout (location = 3) out vec4 out_color3;
void main()
{
    out_color0 = vec4(texCoord, 0.0f, 1.0f);
    out_color1 = vec4(texCoord, 0.0f, 1.0f);
    out_color2 = vec4(texCoord, 0.0f, 1.0f);
    out_color3 = vec4(texCoord, 0.0f, 1.0f);
}
#version 450
layout (location = 0) in vec2 texCoord;
layout (location = 0) out vec4 out_color0;
layout (location = 1) out vec4 out_color1;
layout (location = 2) out vec4 out_color2;
layout (location = 3) out vec4 out_color3;
layout (location = 4) out vec4 out_color4;
layout (location = 5) out vec4 out_color5;
layout (location = 6) out vec4 out_color6;
layout (location = 7) out vec4 out_color7;
void main()
{
    out_color0 = vec4(texCoord, 0.0f, 1.0f);
    out_color1 = vec4(texCoord, 0.0f, 1.0f);
    out_color2 = vec4(texCoord, 0.0f, 1.0f);
    out_color3 = vec4(texCoord, 0.0f, 1.0f);
    out_color4 = vec4(texCoord, 0.0f, 1.0f);
    out_color5 = vec4(texCoord, 0.0f, 1.0f);
    out_color6 = vec4(texCoord, 0.0f, 1.0f);
    out_color7 = vec4(texCoord, 0.0f, 1.0f);
}
#version 450
layout (location = 0) in vec2 texCoord;
layout (location = 0) out vec4 out_color0;
layout (location = 1) out vec4 out_color1;
layout (location = 2) out vec4 out_color2;
layout (location = 3) out vec4 out_color3;
layout (location = 4) out vec4 out_color4;
layout (location = 5) out vec4 out_color5;
layout (location = 6) out vec4 out_color6;
layout (location = 7) out vec4 out_color7;
layout (location = 8) out vec4 out_color8;
layout (location = 9) out vec4 out_color9;
layout (location = 10) out vec4 out_color10;
layout (location = 11) out vec4 out_color11;
layout (location = 12) out vec4 out_color12;
layout (location = 13) out vec4 out_color13;
layout (location = 14) out vec4 out_color14;
layout (location = 15) out vec4 out_color15;
void main()
{
    out_color0 = vec4(texCoord, 0.0f, 1.0f);
    out_color1 = vec4(texCoord, 0.0f, 1.0f);
    out_color2 = vec4(texCoord, 0.0f, 1.0f);
    out_color3 = vec4(texCoord, 0.0f, 1.0f);
    out_color4 = vec4(texCoord, 0.0f, 1.0f);
    out_color5 = vec4(texCoord, 0.0f, 1.0f);
    out_color6 = vec4(texCoord, 0.0f, 1.0f);
    out_color7 = vec4(texCoord, 0.0f, 1.0f);
    out_color8 = vec4(texCoord, 0.0f, 1.0f);
    out_color9 = vec4(texCoord, 0.0f, 1.0f);
    out_color10 = vec4(texCoord, 0.0f, 1.0f);
    out_color11 = vec4(texCoord, 0.0f, 1.0f);
    out_color12 = vec4(texCoord, 0.0f, 1.0f);
    out_color13 = vec4(texCoord, 0.0f, 1.0f);
    out_color14 = vec4(texCoord, 0.0f, 1.0f);
    out_color15 = vec4(texCoord, 0.0f, 1.0f);
}
