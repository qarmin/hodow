#version 440
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 texCoords;
layout(location = 0) out highp vec4 vtxTexCoords;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = position;
    vtxTexCoords = texCoords;
}
