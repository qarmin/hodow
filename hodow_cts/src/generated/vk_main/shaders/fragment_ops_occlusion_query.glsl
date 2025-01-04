#version 450

layout(location = 0) in highp vec4 position;

out gl_PerVertex
{
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450

layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vec4(gl_FragCoord.x / 32, gl_FragCoord.y / 32, 0.0, 1.0);
}
