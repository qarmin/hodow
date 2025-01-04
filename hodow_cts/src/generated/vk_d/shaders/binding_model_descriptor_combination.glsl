#version 460
layout(local_size_x = 4, local_size_y = 4) in;
layout(push_constant) uniform Params { int mulVal; } params;
layout(binding = 0, std430) buffer OutBuf { uint v[]; } outBuf;
void main()
{
  outBuf.v[gl_LocalInvocationIndex] = gl_LocalInvocationIndex * params.mulVal;
}
#version 460
layout(local_size_x = 4, local_size_y = 4) in;
layout(push_constant) uniform Params { int addVal; } params;
layout(binding = 0, std430) buffer InOutBuf { uint v[]; } inOutBuf;
void main()
{
  uint value = inOutBuf.v[gl_LocalInvocationIndex];  inOutBuf.v[gl_LocalInvocationIndex] = value + params.addVal;
}
#version 460
void main()
{
    const float x = (-1.0+4.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-4.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 1.0, 1.0);
}
#version 460
layout(binding = 0) uniform texture2D tex;
layout(binding = 1) uniform sampler samplerA;
layout(binding = 2) uniform sampler samplerB;
layout(binding = 3) uniform sampler samplerC;
layout(location = 0) out vec4 outColor;
void main()
{
    vec2 uv = vec2(2.0, 2.0);
    vec4 colorA = texture(sampler2D(tex, samplerA), uv);
    vec4 colorB = texture(sampler2D(tex, samplerB), uv);
    vec4 colorC = texture(sampler2D(tex, samplerC), uv);
    outColor = mix(mix(colorA, colorB, 0.25), colorC, 0.7);
}
