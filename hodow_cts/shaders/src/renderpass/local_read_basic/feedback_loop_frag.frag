#version 450
layout(input_attachment_index = 0, binding = 0) uniform subpassInput inColor;
layout(location = 0) out vec4 outColor;
void main()
{
  vec2 uvNormalized = gl_FragCoord.xy / vec2(1024);
  vec4 color = subpassLoad(inColor);
  vec4 select = step(vec4(0.5), color);
  color += mix(vec4(0.2), vec4(-0.2), select);
  outColor = color;
}
