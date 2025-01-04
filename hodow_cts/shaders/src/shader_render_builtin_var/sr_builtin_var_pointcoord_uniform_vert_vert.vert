#version 310 es
layout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };
layout(location = 0) in highp vec3 a_position;
void main (void)
{
    gl_Position = vec4(a_position.xy, 0.0, 1.0) * vec4(u_scale, 1.0);
    gl_PointSize = a_position.z;
}
