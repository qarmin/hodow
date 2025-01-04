#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;
const float expectedValue = 0.6;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0, 1.0, 0.0, 1.0);
  else
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}
