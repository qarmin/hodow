#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

layout(points, invocations = 1) in;
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
    const float modifier  = 0.0;
    const vec4  color     = vec4(abs(pos.x), abs(pos.y), 0.2 + 0.8 * modifier, 1.0);
    const float size      = 0.05 + 0.03 * modifier;
    const float dx        = (sign(-pos.x) - pos.x) / float(1);
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
#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

void main(void)
{
    o_color = in_color;
}
#version 450

layout(points, invocations = 2) in;
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
    const float modifier  = float(gl_InvocationID) / float(1);
    const vec4  color     = vec4(abs(pos.x), abs(pos.y), 0.2 + 0.8 * modifier, 1.0);
    const float size      = 0.05 + 0.03 * modifier;
    const float dx        = (sign(-pos.x) - pos.x) / float(2);
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
#version 450

layout(points, invocations = 8) in;
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
    const float modifier  = float(gl_InvocationID) / float(7);
    const vec4  color     = vec4(abs(pos.x), abs(pos.y), 0.2 + 0.8 * modifier, 1.0);
    const float size      = 0.05 + 0.03 * modifier;
    const float dx        = (sign(-pos.x) - pos.x) / float(8);
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
#version 450

layout(points, invocations = 64) in;
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
    const float modifier  = float(gl_InvocationID) / float(63);
    const vec4  color     = vec4(abs(pos.x), abs(pos.y), 0.2 + 0.8 * modifier, 1.0);
    const float size      = 0.05 + 0.03 * modifier;
    const float dx        = (sign(-pos.x) - pos.x) / float(64);
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
#version 450

layout(points, invocations = 127) in;
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
    const float modifier  = float(gl_InvocationID) / float(126);
    const vec4  color     = vec4(abs(pos.x), abs(pos.y), 0.2 + 0.8 * modifier, 1.0);
    const float size      = 0.05 + 0.03 * modifier;
    const float dx        = (sign(-pos.x) - pos.x) / float(127);
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
