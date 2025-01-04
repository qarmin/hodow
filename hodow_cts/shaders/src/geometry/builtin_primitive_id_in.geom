#version 450
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};
layout(lines) in;
layout(triangle_strip, max_vertices = 10) out;
layout(location = 0) out vec4 v_frag_FragColor;
void main (void)
{
    const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    const vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
    const vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
    const vec4 colors[4] = vec4[4](red, green, blue, yellow);
    for (int counter = 0; counter < 3; ++counter)
    {
        float percent = 0.1 * counter;
        gl_Position = gl_in[0].gl_Position * vec4(1.0 + percent, 1.0 + percent, 1.0, 1.0);
        v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];
        EmitVertex();
        gl_Position = gl_in[1].gl_Position * vec4(1.0 + percent, 1.0 + percent, 1.0, 1.0);
        v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];
        EmitVertex();
    }
}
