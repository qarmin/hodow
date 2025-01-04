#version 310 es
layout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };
layout(location = 0) out lowp vec4 o_color;
void main (void)
{
    o_color = vec4(gl_PointCoord, 0.0, 1.0) * vec4(u_scale, 1.0);
}
