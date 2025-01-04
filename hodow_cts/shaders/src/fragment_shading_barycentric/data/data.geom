#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

${dataStruct}

layout (location=0) in ${typePrefix} inData[]${typeSuffix};
layout (location=0) out ${typePrefix} outData${typeSuffix};

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[${i0}];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[${i1}];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[${i2}];
    EmitVertex();
}
