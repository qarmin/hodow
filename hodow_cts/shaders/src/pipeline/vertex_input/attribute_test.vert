#version 460
${extensions}layout(constant_id = 0) const int numAttributes = ${max_attributes};
${inputs}layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
${check}}
