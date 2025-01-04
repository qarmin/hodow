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
