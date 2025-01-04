#version 440
layout(triangles) in;
layout(triangle_strip, max_vertices = ${max_vertices}) out;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex {
    vec4  gl_Position;
};
layout(location = 0) in  highp vec3 gs_in_texCoord[];

layout(location = 0) out highp vec3 gs_out_texCoord;

void main (void)
{
    for (int layerNdx = 0; layerNdx < ${layers}; ++layerNdx)
    {
        for (int vertexNdx = 0; vertexNdx < gl_in.length(); ++vertexNdx)
        {
            gl_Layer = layerNdx;
            gl_Position = gl_in[vertexNdx].gl_Position;
            gs_out_texCoord = vec3(gs_in_texCoord[vertexNdx].xy, float(layerNdx));
            EmitVertex();
        }
        EndPrimitive();
    }
}
