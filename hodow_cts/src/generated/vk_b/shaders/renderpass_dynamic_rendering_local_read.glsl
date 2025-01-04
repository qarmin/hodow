#version 450
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 1.0, 1.0);
}
#version 450
layout(location=0) out vec4 outColor0;
layout(location=1) out vec4 outColor1;
layout(location=2) out vec4 outColor2;
layout(location=3) out vec4 outColor3;

void main() {
    outColor0 = vec4(1.0f, 0.0f, 0.0f, 1.0f); // red
    outColor1 = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
    outColor2 = vec4(0.0f, 1.0f, 0.0f, 1.0f); // green
    outColor3 = vec4(0.5f, 0.5f, 0.5f, 1.0f); // gray
}
#version 450
layout(location=1) out vec4 outColor0;

void main() {
    outColor0 = vec4(0.0f, 1.0f, 0.0f, 1.0f);
}
#version 450
layout(location=2) out vec4 outColor0;

void main() {
    outColor0 = vec4(0.0f, 1.0f, 0.0f, 1.0f);
}
#version 450
layout(location=3) out vec4 outColor0;

void main() {
    outColor0 = vec4(0.0f, 1.0f, 0.0f, 1.0f);
}
#version 450
layout(location=2) out vec4 outColor0;
layout(location=3) out vec4 outColor1;

void main() {
    outColor0 = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    outColor1 = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
void main (void)
{
  outColor0 = vec4(0, 0, 1, 1);
  outColor1 = vec4(0, 1, 0, 1);
  outColor2 = vec4(0, 1, 1, 1);
  outColor3 = vec4(1, 0, 0, 1);
}
#version 450
layout(input_attachment_index=0, binding=0) uniform subpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform subpassInput inColor1;
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
void main (void)
{
  outColor0 = subpassLoad(inColor0);
  outColor1 = subpassLoad(inColor1);
  outColor2 = vec4(0, 1, 1, 1);
  outColor3 = vec4(1, 0, 0, 1);
}
#version 450
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
layout(location = 4) out vec4 outColor4;
layout(location = 5) out vec4 outColor5;
layout(location = 6) out vec4 outColor6;
layout(location = 7) out vec4 outColor7;
void main (void)
{
  outColor0 = vec4(0, 0, 1, 1);
  outColor1 = vec4(0, 1, 0, 1);
  outColor2 = vec4(0, 1, 1, 1);
  outColor3 = vec4(1, 0, 0, 1);
  outColor4 = vec4(1, 0, 1, 1);
  outColor5 = vec4(1, 1, 0, 1);
  outColor6 = vec4(1, 1, 1, 1);
  outColor7 = vec4(0.5, 0.5, 0.5, 1);
}
#version 450
layout(input_attachment_index=0, binding=0) uniform subpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform subpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform subpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform subpassInput inColor3;
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
layout(location = 4) out vec4 outColor4;
layout(location = 5) out vec4 outColor5;
layout(location = 6) out vec4 outColor6;
layout(location = 7) out vec4 outColor7;
void main (void)
{
  outColor0 = subpassLoad(inColor0);
  outColor1 = subpassLoad(inColor1);
  outColor2 = subpassLoad(inColor2);
  outColor3 = subpassLoad(inColor3);
  outColor4 = vec4(1, 0, 1, 1);
  outColor5 = vec4(1, 1, 0, 1);
  outColor6 = vec4(1, 1, 1, 1);
  outColor7 = vec4(0.5, 0.5, 0.5, 1);
}
#version 450
layout(input_attachment_index=0, binding=0) uniform subpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform subpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform subpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform subpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform subpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform subpassInput inColor5;
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
layout(location = 4) out vec4 outColor4;
layout(location = 5) out vec4 outColor5;
layout(location = 6) out vec4 outColor6;
layout(location = 7) out vec4 outColor7;
void main (void)
{
  outColor0 = subpassLoad(inColor0);
  outColor1 = subpassLoad(inColor1);
  outColor2 = subpassLoad(inColor2);
  outColor3 = subpassLoad(inColor3);
  outColor4 = subpassLoad(inColor4);
  outColor5 = subpassLoad(inColor5);
  outColor6 = vec4(1, 1, 1, 1);
  outColor7 = vec4(0.5, 0.5, 0.5, 1);
}
