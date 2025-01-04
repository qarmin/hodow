#version 450

layout(points, invocations = ${num_layers}) in;
layout(triangle_strip, max_vertices = 6) out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};

void main(void)
{
    const int   layerA = gl_InvocationID;
    const int   layerB = (gl_InvocationID + 1) % ${num_layers};
    const float aEnd   = float(layerA) / float(${num_layers}) * 2.0 - 1.0;
    const float bEnd   = float(layerB) / float(${num_layers}) * 2.0 - 1.0;

    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(aEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerA;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();

    gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd,  1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();

    gl_Position = vec4(bEnd, -1.0, 0.0, 1.0);
    gl_Layer    = layerB;
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
