#version 450

layout(points, invocations = 32) in;
layout(triangle_strip, max_vertices = 4) out;

layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    const vec4  pos       = gl_in[0].gl_Position;
    const float modifier  = float(gl_InvocationID) / float(31);
    const vec4  color     = vec4(abs(pos.x), abs(pos.y), 0.2 + 0.8 * modifier, 1.0);
    const float size      = 0.05 + 0.03 * modifier;
    const float dx        = (sign(-pos.x) - pos.x) / float(32);
    const vec4  offsetPos = pos + vec4(float(gl_InvocationID) * dx,
                                       0.3 * sin(12.0 * modifier),
                                       0.0,
                                       0.0);

    gl_Position = offsetPos + vec4(-size, -size, 0.0, 0.0);
    out_color   = color;
    EmitVertex();

    gl_Position = offsetPos + vec4(-size,  size, 0.0, 0.0);
    out_color   = color;
    EmitVertex();

    gl_Position = offsetPos + vec4( size, -size, 0.0, 0.0);
    out_color   = color;
    EmitVertex();

    gl_Position = offsetPos + vec4( size,  size, 0.0, 0.0);
    out_color   = color;
    EmitVertex();
}
