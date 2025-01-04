#version 450
#extension GL_EXT_fragment_shader_barycentric : require

${dataStruct}

layout(location = 0) in  vec4 in_position;
layout(location = 0) out ${typePrefix} data${typeSuffix};
${vertInterpOut}${vertFlatOut}
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ${value};
${vertInterpAssign}${vertFlatAssign}    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
