#version 310 es
layout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };
layout(location = 0) out highp vec4 o_color;
void main (void)
{
       o_color = vec4(gl_FragCoord.xyz * u_scale, 1.0);
}
