#version 440

layout(location = 0) out vec4 fs_out_color;

layout(set = 0, binding = 0, input_attachment_index = 0) uniform subpassInputMS imageMS;

layout(set = 0, binding = 1, std140) uniform SampleBlock {
    int sampleNdx;
};
void main (void)
{
    fs_out_color = subpassLoad(imageMS, sampleNdx);
}
