#version 450
layout(location = 0) in highp vec4 pos;
layout(constant_id = 0) const int arraySize = 1;
layout(location = 0) out ivec4 outputData[arraySize];
out gl_PerVertex {
    vec4 gl_Position;
};

void main()
{
    gl_Position = pos;
    int i;
    for (i = 0; i < arraySize; i++)
    {
        outputData[i] = ivec4(i);
    }
}
