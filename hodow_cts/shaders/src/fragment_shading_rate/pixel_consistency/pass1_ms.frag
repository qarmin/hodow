#version 450 core
layout(input_attachment_index=0, set=0, binding=0) uniform usubpassInputMS inputAttachment;
layout(location = 0) out uvec2 col0;
void main()
{
  col0 = subpassLoad(inputAttachment, 0).xy;
}
