#version 450
precision highp float;
precision highp int;
layout(push_constant) uniform PushConstant {
  highp int sampleID;
} pushConstants;
void main (void)
{
  if(gl_SampleID != pushConstants.sampleID)
    discard;
  gl_FragDepth = 0.5;
}
