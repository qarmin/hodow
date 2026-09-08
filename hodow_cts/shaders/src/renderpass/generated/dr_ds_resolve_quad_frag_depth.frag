#version 450
precision highp float;
precision highp int;
void main (void)
{
  float sampleIndex = float(gl_SampleID);
  float valueIndex = round(mod(sampleIndex, 4.0));
  float value = valueIndex + 2.0;
  value = round(exp2(value));
  bool condition = (int(value) == 8);
  value = round(value - float(condition) * 6.0);
  gl_FragDepth = value / 100.0;
}
