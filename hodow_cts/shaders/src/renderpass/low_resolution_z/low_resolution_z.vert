#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
void main(void)
{
    gl_Position.x = (gl_VertexIndex & 1) * 2.0 - 1.0;
    gl_Position.z = pc.depth;
    gl_Position.w = 1.0;

    if (pc.mode == 0) // full-screen quad
        gl_Position.y = (gl_VertexIndex & 2) - 1.0;
    else
    {
        // draw one 1-pixel-tall strip per instance;
        // even rows when mode is 1, odd rows when mode is 2

        int row       = gl_InstanceIndex * 2 + (pc.mode - 1);
        float pixelH  = 2.0 / pc.height;
        float top     = -1.0 + float(row) * pixelH;
        float bottom  = top + pixelH;
        gl_Position.y = ((gl_VertexIndex & 2) == 0) ? top : bottom;
    }
}
