#version 450
layout(input_attachment_index = 0, binding = 0) uniform usubpassInput inColor0;
layout(input_attachment_index = 1, binding = 1) uniform usubpassInput inColor1;
layout(input_attachment_index = 2, binding = 2) uniform usubpassInput inColor2;
layout(location = 0) out uint outColor;
void main()
{
  outColor = 1u * subpassLoad(inColor0).x +
             2u * subpassLoad(inColor1).x +
             3u * subpassLoad(inColor2).x;
}
