#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = vec4(1.0, 0.5, 0.25, 1.0);
}
#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position = in_position;
    gl_PointSize = 1.0f;
}
#version 450

layout(binding = 0, rgba8) writeonly uniform image2D image;

void main(void)
{
    imageStore(image, ivec2(gl_PrimitiveID % 4, 0), vec4(1.0, 0.5, 0.25, 1.0));
}
#version 450

layout(binding = 0, rgba8) writeonly uniform image2D image;

void main(void)
{
    imageStore(image, ivec2(gl_PrimitiveID % 4, gl_SampleID % 4), vec4(1.0, 0.5, 0.25, 1.0));
}
#version 450

layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;

void main(void)
{
    o_color0 = vec4(1.0,  0.5, 0.25, 1.0);
    o_color1 = vec4(0.5,  1.0, 0.25, 1.0);
    o_color2 = vec4(0.25, 0.5, 1.0,  1.0);
}
#version 450

layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;

void main(void)
{
    o_color0 = vec4(1.0,  0.5, 0.25, 1.0);
    o_color2 = vec4(0.25, 0.5, 1.0,  1.0);
}
#version 450

layout (input_attachment_index = 0, set = 0, binding = 0) uniform subpassInput inputColor;
layout(location = 0) out vec4 o_color0;

void main(void)
{
    vec4 in_color = subpassLoad(inputColor);
    o_color0 = vec4(1.0, in_color.y, 0.25, 1.0);
}
