#version 450

layout(points) in;
layout(triangle_strip, max_vertices = ${num_layers * 4}) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < ${num_layers}; ++layerNdx) {
        gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();

        gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        EmitVertex();
        EndPrimitive();
    };
}
