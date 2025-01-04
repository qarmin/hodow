#version 450

layout(points) in;
layout(triangle_strip, max_vertices = ${(num_layers + 1) * num_layers}) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    for (int layerNdx = 0; layerNdx < ${num_layers}; ++layerNdx) {
        for (int colNdx = 0; colNdx <= layerNdx; ++colNdx) {
            const float posX = float(colNdx) / float(${num_layers}) * 2.0 - 1.0;

            gl_Position = vec4(posX,  1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();

            gl_Position = vec4(posX, -1.0, 0.0, 1.0);
            gl_Layer    = layerNdx;
            gl_PointSize = 1.0;
            EmitVertex();
        }
        EndPrimitive();
    }
}
