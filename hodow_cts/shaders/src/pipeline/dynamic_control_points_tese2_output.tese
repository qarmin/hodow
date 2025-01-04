#version 450
layout(triangles, ccw) in;
layout(location = 0) out vec3 fragColor;

void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
    fragColor = vec3(gl_in[3].gl_Position.xyz);}
