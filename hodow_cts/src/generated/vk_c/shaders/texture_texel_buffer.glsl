#version 430
layout(location = 0) in vec4 position;
void main() {
  gl_Position = position;
}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) usamplerBuffer texels;

void main()
{
    color_out = texelFetch(texels, int(gl_FragCoord.x) % 4);
}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = texelFetch(texels, int(gl_FragCoord.x) % 4);
}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) isamplerBuffer texels;

void main()
{
    color_out = texelFetch(texels, int(gl_FragCoord.x) % 4);
}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 39) + vec4(1.0)) / vec4(2.0);
    color_out.a = 1;

}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 39) + vec4(1.0)) / vec4(2.0);

}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 35) + vec4(1.0)) / vec4(2.0);
    color_out.g = 0;
    color_out.b = 0;
    color_out.a = 1;

}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 35) + vec4(1.0)) / vec4(2.0);
    color_out.b = 0;
    color_out.a = 1;

}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 35) + vec4(1.0)) / vec4(2.0);
    color_out.a = 1;

}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 35) + vec4(1.0)) / vec4(2.0);

}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 39) + vec4(1.0)) / vec4(2.0);
    color_out.g = 0;
    color_out.b = 0;
    color_out.a = 1;

}
#version 430
layout(location = 0) out vec4 color_out;
uniform layout(set=0, binding=0) samplerBuffer texels;

void main()
{
    color_out = (texelFetch(texels, int(gl_FragCoord.x) % 39) + vec4(1.0)) / vec4(2.0);
    color_out.b = 0;
    color_out.a = 1;

}
#version 430
layout(location = 0) in vec4 position;
layout(location = 1) in vec2 texCoordsIn;
layout(location = 0) out vec2 texCoordsOut;
void main() {
  gl_Position = position;
  texCoordsOut = texCoordsIn;
}
#version 430
layout(location = 0) in vec2 texCoordsIn;
layout(location = 0) out vec4 colorOut;
layout(set=0, binding=0) uniform sampler2D referenceSampler;
layout(set=0, binding=1) uniform samplerBuffer bufferSampler;
void main() {

  vec4 referenceValue = texture(referenceSampler, texCoordsIn);
  vec4 bufferValue = texelFetch(bufferSampler, int((gl_FragCoord.y-0.5) * 8 + (gl_FragCoord.x-0.5)));

  if (bufferValue == referenceValue)
      colorOut = vec4(0., 1., 0., 1.);
  else
      colorOut = vec4(1., 0., 0., 1.);
}
#version 430
layout(location = 0) in vec2 texCoordsIn;
layout(location = 0) out vec4 colorOut;
layout(set=0, binding=0) uniform sampler2D referenceSampler;
layout(set=0, binding=1) uniform samplerBuffer bufferSampler;
void main() {

  vec4 referenceValue = texture(referenceSampler, texCoordsIn);
  vec4 bufferValue = texelFetch(bufferSampler, int((gl_FragCoord.y-0.5) * 8 + (gl_FragCoord.x-0.5)));

  if (bufferValue.r == referenceValue.r)
      colorOut = vec4(0., 1., 0., 1.);
  else
      colorOut = vec4(1., 0., 0., 1.);
}
