#version 450
layout(location = 0) out highp vec2 vtxTexCoords;
highp float;
void main (void)
{
    vec4 position;    position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
                    ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
    gl_Position = position;
    vtxTexCoords = position.xy / 2.0 + vec2(0.5);}
