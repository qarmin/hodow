#version 430
vec2 vdata[] = vec2[] (
vec2(-1.0, -1.0),
vec2(1.0, -1.0),
vec2(-1.0, 1.0),
vec2(1.0, 1.0));
void main (void)
{
    gl_Position = vec4(vdata[gl_VertexIndex], 0.0, 1.0);
}
