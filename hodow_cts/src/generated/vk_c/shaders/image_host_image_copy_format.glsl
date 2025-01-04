#version 450
layout (location=0) out vec2 texCoord;
void main()
{
    texCoord = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);    gl_Position = vec4(texCoord * 2.0f - 1.0f, 0.0f, 1.0f);
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
layout (location=0) out vec4 out_color;
layout (location=0) in vec2 texCoord;
layout (set=0, binding=0) uniform sampler2D combinedSampler;
void main()
{
    out_color = vec4(texture(combinedSampler, texCoord).r, 0, 0, 0);
}
#version 450
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D combinedSampler;
layout (set=0, binding=1) uniform writeonly image2D outImage;
void main()
{
    ivec2 pixelCoord = ivec2(gl_GlobalInvocationID.xy);
    imageStore(outImage, pixelCoord, texture(combinedSampler, vec2(pixelCoord) / (textureSize(combinedSampler, 0) - vec2(0.001f))));
}
#version 450
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D combinedSampler;
layout (set=0, binding=1) uniform writeonly uimage2D outImage;
void main()
{
    ivec2 pixelCoord = ivec2(gl_GlobalInvocationID.xy);
    imageStore(outImage, pixelCoord, uvec4(texture(combinedSampler, vec2(pixelCoord) / (textureSize(combinedSampler, 0) - vec2(0.001f))) * 255));
}
