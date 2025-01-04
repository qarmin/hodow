#version 450
vec2 positions[6] = vec2[](        vec2(-1.0, -1.0),        vec2(-1.0, 1.0),        vec2(1.0, -1.0),        vec2(1.0, -1.0),        vec2(-1.0, 1.0),        vec2(1.0, 1.0));
void main() {
        gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
#version 450
layout(location = 0) out vec4 outColor;
layout(location = 0) in vec3 fragColor;void main() {
    outColor = vec4(fragColor, 1.0);
}
#version 450
layout(vertices = 3) out;
void main (void)
{
    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 2.0;
    gl_TessLevelOuter[2] = 2.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
layout(triangles, ccw) in;
layout(location = 0) out vec3 fragColor;
void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
    fragColor = vec3(1.0, 0.0, 1.0); }
#version 450
layout(vertices = 4) out;
void main (void)
{
    gl_TessLevelInner[0] = 2;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 2.0;
    gl_TessLevelOuter[2] = 2.0;
if (gl_InvocationID < 3) {    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
} else {    gl_out[gl_InvocationID].gl_Position = vec4(1.0, 0.0, 1.0, 1.0);}}
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
#version 450
layout(triangles, cw) in;
layout(location = 0) out vec3 fragColor;
void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
    fragColor = vec3(1.0, 0.0, 1.0); }
#version 450
layout(triangles, ccw) in;
layout(location = 0) out vec3 fragColor;

void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
    fragColor = vec3(1.0, 0.0, 1.0);}
