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
