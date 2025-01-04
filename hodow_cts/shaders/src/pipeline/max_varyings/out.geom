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
