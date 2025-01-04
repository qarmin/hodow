#version 450

layout(binding = 0) readonly uniform Input {
    int pass;
} uInput;

layout(points) in;
layout(triangle_strip, max_vertices = ${num_layers * 4}) out;

layout(location = 0) out vec4 vert_color;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const vec4 colors[6] = vec4[6](vec4(1.0, 1.0, 1.0, 1.0),
                                   vec4(1.0, 0.0, 0.0, 1.0),
                                   vec4(0.0, 1.0, 0.0, 1.0),
                                   vec4(0.0, 0.0, 1.0, 1.0),
                                   vec4(1.0, 1.0, 0.0, 1.0),
                                   vec4(1.0, 0.0, 1.0, 1.0));
    for (int layerNdx = 0; layerNdx < ${num_layers}; ++layerNdx) {
        const int   colorNdx   = layerNdx % 6;
        const vec3  passColor0 = (uInput.pass == 0 ? 0.5 :  1.0) * vec3(colors[colorNdx]);
        const vec4  passColor  = vec4(passColor0, 1.0);
        const float posX       = (uInput.pass == 0 ? 0.0 : -0.5);
        const float posZ       = float(layerNdx + 1 - uInput.pass) / float(${2 * num_layers});

        gl_Position = vec4(-1.0, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(-1.0,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX, -1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        gl_Position = vec4(posX,  1.0, posZ, 1.0);
        gl_Layer    = layerNdx;
        gl_PointSize = 1.0;
        vert_color  = passColor;
        EmitVertex();

        EndPrimitive();
    }
}
