#version 460

layout(points) in;
layout(triangle_strip, max_vertices=4) out;

layout(location=0) flat in int r8g8b8[];
layout(location=1) flat in vec2 widthHeight[];
layout(location=2) flat in int viewportIndex[];

layout(location=0) flat out vec4 o_color;

void main()
{
    int redBits   = (r8g8b8[0] >> 16) & 255;
    int greenBits = (r8g8b8[0] >> 8)  & 255;
    int blueBits  =  r8g8b8[0]        & 255;
    float n       = 1.0 / 255.0;
    vec4 color    = vec4(redBits * n, greenBits * n, blueBits * n, 1.0);

    gl_ViewportIndex = viewportIndex[0];
    gl_Position = gl_in[0].gl_Position;
    o_color     = color;
    EmitVertex();

    gl_ViewportIndex = viewportIndex[0];
    gl_Position = gl_in[0].gl_Position + vec4(0.0, widthHeight[0].y, 0.0, 0.0);
    o_color     = color;
    EmitVertex();

    gl_ViewportIndex = viewportIndex[0];
    gl_Position = gl_in[0].gl_Position + vec4(widthHeight[0].x, 0.0, 0.0, 0.0);
    o_color     = color;
    EmitVertex();

    gl_ViewportIndex = viewportIndex[0];
    gl_Position = gl_in[0].gl_Position + vec4(widthHeight[0].xy, 0.0, 0.0);
    o_color     = color;
    EmitVertex();

    EndPrimitive();
}
