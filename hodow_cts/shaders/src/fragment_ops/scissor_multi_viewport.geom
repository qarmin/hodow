#version 450

layout(points) in;
layout(triangle_strip, max_vertices=4) out;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

void main(void)
{
    gl_ViewportIndex = gl_PrimitiveIDIn;
    gl_Position      = vec4(-1.0, -1.0, 0.0, 1.0);
    out_color        = in_color[0];
    EmitVertex();
    gl_ViewportIndex = gl_PrimitiveIDIn;
    gl_Position      = vec4(-1.0, 1.0, 0.0, 1.0);
    out_color        = in_color[0];
    EmitVertex();
    gl_ViewportIndex = gl_PrimitiveIDIn;
    gl_Position      = vec4(1.0, -1.0, 0.0, 1.0);
    out_color        = in_color[0];
    EmitVertex();
    gl_ViewportIndex = gl_PrimitiveIDIn;
    gl_Position      = vec4(1.0, 1.0, 0.0, 1.0);
    out_color        = in_color[0];
    EmitVertex();
}
