#version 430
layout(location = 0) in vec2 position_in;

void main()
{
    gl_Position = vec4(position_in, 2, 1);
}
#version 430
layout (binding=0) buffer B {
    float d;
};

layout(location = 0) out highp vec4 frag_out;
void main()
{
    d = gl_FragCoord.z;
    frag_out = vec4(0, 1, 0, 1);
}
#version 430
layout(location = 0) in vec2 position_in;

void main()
{
    gl_Position = vec4(position_in, 1, 1);
}
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
#version 430
layout(location = 0) in vec2 position_in;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
}
#version 430
layout(location = 0) out highp vec4 frag_out;
void main()
{
    gl_FragDepth = 2.0;
    frag_out = vec4(0, 1, 0, 1);
}
