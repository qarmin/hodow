#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec4 o_color;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
    o_color     = in_color;

    // We use instance index to draw the left shape (index = 0) or the right shape (index = 1).
    // Vertices are squished and moved to either half of the viewport.
    if (gl_InstanceIndex == 0)
        gl_Position.x = 0.5 * (gl_Position.x - 1.0);
    else if (gl_InstanceIndex == 1)
        gl_Position.x = 0.5 * (gl_Position.x + 1.0);
}
