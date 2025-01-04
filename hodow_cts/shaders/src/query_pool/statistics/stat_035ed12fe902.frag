#version 450
layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
layout (set=0, binding=0, std430) readonly buffer DepthsBlock { float depths[5]; } depthsBuffer;
void main()
{
    out_color = in_color;
    gl_FragDepth = depthsBuffer.depths[((int(gl_FragCoord.x) + int(gl_FragCoord.y)) % 5)];
}
