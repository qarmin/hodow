#version 450

layout(location = 0) in vec4 position;

out gl_PerVertex
{
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450

layout(input_attachment_index = 0, binding = 0) uniform subpassInput inputValue;

layout(location = 0) out vec4 fragColor;

void main (void)
{
    fragColor = subpassLoad(inputValue);
}
#version 450

layout(input_attachment_index = 0, binding = 0) uniform subpassInput inputValue;

layout(location = 0) out vec4 fragColor;

void main (void)
{
    fragColor = vec4(subpassLoad(inputValue).r, 0.0, 0.0, 1.0);
}
#version 450

layout(input_attachment_index = 0, binding = 0) uniform usubpassInput inputValue;

layout(location = 0) out vec4 fragColor;

void main (void)
{
    fragColor = vec4(0.0, 0.0, float(subpassLoad(inputValue).r) / 256.0, 1.0);
}
