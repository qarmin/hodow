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
#version 450
layout(constant_id = 0) const int arraySize = 1;
layout(location = 0) flat in ivec4 inputData[arraySize];
layout(location = 0) out vec4 color;
void main()
{
    color = vec4(1.0, 0.0, 0.0, 1.0);
    int i;
    bool result = true;
    for (i = 0; i < arraySize; i++)
    {
        if (result && inputData[i] != ivec4(i))
            result = false;
    }
    if (result)
        color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 pos;
out gl_PerVertex {
    vec4 gl_Position;
};
void main()
{
    gl_Position = pos;
}
#version 450
layout(vertices = 3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
void main(void)
{
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
layout(triangles, equal_spacing, cw) in;
layout(constant_id = 0) const int arraySize = 1;
layout(location = 0) out ivec4 outputData[arraySize];
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];
out gl_PerVertex {
    vec4 gl_Position;
};
void main(void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position +
                   gl_TessCoord.y * gl_in[1].gl_Position +
                   gl_TessCoord.z * gl_in[2].gl_Position);
    int j;
    for (j = 0; j < arraySize; j++)
    {
        outputData[j] = ivec4(j);
    }
}
#version 450
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;
layout(constant_id = 0) const int arraySize = 1;
layout(location = 0) out ivec4 outputData[arraySize];
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];
void main()
{
    int i;
    int j;
    for(i = 0; i < gl_in.length(); i++)
    {
        gl_Position = gl_in[i].gl_Position;
        for (j = 0; j < arraySize; j++)
        {
            outputData[j] = ivec4(j);
        }
        EmitVertex();
    }
    EndPrimitive();
}
