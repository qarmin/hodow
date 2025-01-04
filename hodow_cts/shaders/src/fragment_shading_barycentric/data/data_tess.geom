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

struct InOutDataStruct {uint idx; ${typePrefix} data${typeSuffix};};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[${i0}];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[${i1}];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[${i2}];
    EmitVertex();
}
