#version 450
layout(location=0) in vec4 position;
void main() { gl_Position = position; }
#version 450
#extension GL_EXT_samplerless_texture_functions : require
layout(set=0, binding=0) uniform texture2D img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = texelFetch(img, ivec2(0, 0), 0);
}
#version 450
layout(local_size_x = 1, local_size_y = 1) in;
#extension GL_EXT_samplerless_texture_functions : require
layout(set=0, binding=0) uniform texture2D img;
layout(set=0, binding=1, rgba8) uniform image2D color_out;
void main()
{
    ivec2 pixelCoords = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = texelFetch(img, ivec2(0, 0), 0);
    imageStore(color_out, pixelCoords, color);
}
#version 450
#extension GL_EXT_samplerless_texture_functions : require
layout(set=1, binding=0) uniform texture2D img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = texelFetch(img, ivec2(0, 0), 0);
}
#version 450
layout(local_size_x = 1, local_size_y = 1) in;
#extension GL_EXT_samplerless_texture_functions : require
layout(set=1, binding=0) uniform texture2D img;
layout(set=1, binding=1, rgba8) uniform image2D color_out;
void main()
{
    ivec2 pixelCoords = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = texelFetch(img, ivec2(0, 0), 0);
    imageStore(color_out, pixelCoords, color);
}
#version 450
layout(rgba8, set=0, binding=0) uniform image2D img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = imageLoad(img, ivec2(0, 0));
}
#version 450
layout(local_size_x = 1, local_size_y = 1) in;
layout(rgba8, set=0, binding=0) uniform image2D img;
layout(set=0, binding=1, rgba8) uniform image2D color_out;
void main()
{
    ivec2 pixelCoords = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = imageLoad(img, ivec2(0, 0));
    imageStore(color_out, pixelCoords, color);
}
#version 450
layout(rgba8, set=1, binding=0) uniform image2D img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = imageLoad(img, ivec2(0, 0));
}
#version 450
layout(local_size_x = 1, local_size_y = 1) in;
layout(rgba8, set=1, binding=0) uniform image2D img;
layout(set=1, binding=1, rgba8) uniform image2D color_out;
void main()
{
    ivec2 pixelCoords = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = imageLoad(img, ivec2(0, 0));
    imageStore(color_out, pixelCoords, color);
}
#version 450
layout(input_attachment_index=0, set=0, binding=0) uniform subpassInput img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = subpassLoad(img);
}
#version 450
layout(input_attachment_index=0, set=1, binding=0) uniform subpassInput img;
layout(location = 0) out vec4 color_out;
void main()
{
    color_out = subpassLoad(img);
}
