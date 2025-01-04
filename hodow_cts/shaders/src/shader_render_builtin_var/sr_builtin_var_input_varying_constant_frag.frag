#version 450
layout(location = 0) in highp vec4 a_color;
layout(push_constant) uniform PCBlock {
  vec4 color;
} pc;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
        o_color += vec4(a_color.xyz, 0.0);
    o_color += pc.color;
}
