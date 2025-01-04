#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
void main (void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    outColor = inColor;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in vec4 inColor;
void main (void) {
    outColor = inColor;
}
#version 460
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
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
layout (location=0) in vec4 inColor[3];
layout (location=0) out vec4 outColor;
void main (void) {
    for (uint i = 0; i < 3; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i];
        EmitVertex();
    }
    EndPrimitive();
}
#version 460
layout(triangles) in;
layout(points, max_vertices=1) out;
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
layout (location=0) in vec4 inColor[3];
layout (location=0) out vec4 outColor;
void main (void) {
    for (uint i = 0; i < 1; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i];
        EmitVertex(); EndPrimitive();
    }
}
#version 460
layout(lines) in;
layout(triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[2];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[2];
layout (location=0) out vec4 outColor;
void main (void) {
    for (uint i = 0; i < 2; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i];
        EmitVertex();
    }
    gl_Position = gl_in[0].gl_Position + vec4(0.0, -0.5, 0.0, 0.0);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = inColor[0];
    EmitVertex();
    EndPrimitive();
}
#version 460
layout(lines) in;
layout(points, max_vertices=1) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[2];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[2];
layout (location=0) out vec4 outColor;
void main (void) {
    for (uint i = 0; i < 1; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i];
        EmitVertex(); EndPrimitive();
    }
}
#version 460
layout(points) in;
layout(triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[1];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[1];
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = gl_in[0].gl_Position + vec4(0.0, -0.5, 0.0, 0.0);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = inColor[0];
    EmitVertex();
    gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.5, 0.0, 0.0);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = inColor[0];
    EmitVertex();
    gl_Position = gl_in[0].gl_Position + vec4(0.5, 0.0, 0.0, 0.0);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = inColor[0];
    EmitVertex();
    EndPrimitive();
}
#version 460
layout(points) in;
layout(points, max_vertices=1) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[1];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[1];
layout (location=0) out vec4 outColor;
void main (void) {
    for (uint i = 0; i < 1; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i];
        EmitVertex(); EndPrimitive();
    }
}
