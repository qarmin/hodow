#version 430
layout(early_fragment_tests) in;

layout (binding=0) buffer B {
    float d;
};

layout(location = 0) out highp vec4 frag_out;
void main()
{
    d = gl_FragCoord.z;
    frag_out = vec4(0, 1, 0, 1);
}
