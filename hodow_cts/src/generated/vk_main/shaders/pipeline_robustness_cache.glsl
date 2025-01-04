#version 450
layout(location = 0) in float in_values[16];
layout(location = 0) out float out_value;
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
void main()
{
    vec2 vertex = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);
    gl_Position = vec4(vertex * 2.0f - 1.0f, 0.0f, 1.0f);
    out_value = in_values[index];
}
#version 450
layout (location=0) in float in_value;
layout (location=0) out vec4 out_color;
void main()
{
    out_color = vec4(in_value);
}
#version 450
void main()
{
    vec2 vertex = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);
    gl_Position = vec4(vertex * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
layout (location=0) out vec4 out_color;
layout (set=0, binding=0) restrict readonly buffer StorageBuffer { float values[]; };
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
void main()
{
    out_color = vec4(values[index]);
}
#version 450
layout(local_size_x = 8, local_size_y = 8) in;
layout (set=0, binding=0) restrict readonly buffer StorageBuffer { float values[]; };
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
layout (set=0, binding=2, rgba32f) uniform writeonly image2D outImage;
void main()
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = vec4(values[index]);
    imageStore(outImage, pos, color);
}
#version 450
layout (location=0) out vec4 out_color;
layout (std140, set=0, binding=0) restrict uniform UniformBuffer { float values[1000]; };
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
void main()
{
    out_color = vec4(values[index]);
}
#version 450
layout(local_size_x = 8, local_size_y = 8) in;
layout (std140, set=0, binding=0) restrict uniform UniformBuffer { float values[1000]; };
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
layout (set=0, binding=2, rgba32f) uniform writeonly image2D outImage;
void main()
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = vec4(values[index]);
    imageStore(outImage, pos, color);
}
#version 450
layout (location=0) out vec4 out_color;
layout (set=0, binding=0, rgba32f) uniform image2D tex;
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
void main()
{
    out_color = imageLoad(tex, ivec2(index, 0));
}
#version 450
layout(local_size_x = 8, local_size_y = 8) in;
layout (set=0, binding=0, rgba32f) uniform image2D tex;
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
layout (set=0, binding=2, rgba32f) uniform writeonly image2D outImage;
void main()
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = imageLoad(tex, ivec2(index, 0));
    imageStore(outImage, pos, color);
}
