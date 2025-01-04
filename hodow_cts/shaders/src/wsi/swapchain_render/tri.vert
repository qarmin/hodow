#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(push_constant) uniform FrameData
{
    highp uint frameNdx;
} frameData;
void main (void)
{
    highp float angle = float(frameData.frameNdx) / 100.0;
    highp float c     = cos(angle);
    highp float s     = sin(angle);
    highp mat4  t     = mat4( c, -s,  0,  0,
                              s,  c,  0,  0,
                              0,  0,  1,  0,
                              0,  0,  0,  1);
    gl_Position = t * a_position;
}
