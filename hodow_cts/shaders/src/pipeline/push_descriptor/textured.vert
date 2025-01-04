#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 texcoordVtx;
layout(location = 0) out highp vec2 texcoordFrag;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    texcoordFrag = texcoordVtx.xy;
}
