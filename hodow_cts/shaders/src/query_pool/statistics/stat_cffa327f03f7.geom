#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 16) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();

    out_color = in_color[0];
    gl_Position = vec4(1.0, 1.0, 1.0, 1.0);
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(-1.0, -1.0, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();


    out_color = in_color[0];
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    out_color = in_color[0];
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    out_color = in_color[0];
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
    out_color = in_color[0];
    gl_Position = vec4(gl_in[2].gl_Position.x, gl_in[1].gl_Position.y, 1.0, 1.0);
    EmitVertex();
    EndPrimitive();
}
