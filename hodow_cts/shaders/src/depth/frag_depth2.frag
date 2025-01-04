#version 430
layout(location = 0) out highp vec4 frag_out;
void main()
{
    gl_FragDepth = 2.0;
    frag_out = vec4(0, 1, 0, 1);
}
