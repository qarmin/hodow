#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(quads) in;

layout(location = 0) out mediump ivec2 v_tessellationGridPosition;

// note: No need to use precise gl_Position since position does not depend on order
void main (void)
{
    // Cover only a small area in a corner. The area will be expanded in geometry shader to cover whole viewport
    gl_Position = vec4(gl_TessCoord.x * 0.3 - 1.0, gl_TessCoord.y * 0.3 - 1.0, 0.0, 1.0);
    // Calculate position in tessellation grid
    v_tessellationGridPosition = ivec2(round(gl_TessCoord.xy * float(5)));
}
