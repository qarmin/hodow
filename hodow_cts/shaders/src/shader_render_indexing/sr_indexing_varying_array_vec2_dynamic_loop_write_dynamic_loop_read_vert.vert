#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 4) uniform something { mediump int ui_four; };
layout(location = 0) out mediump vec2 var[4];

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    for (int i = 0; i < ui_four; i++)
    {
        var[i] = vec2(coords);
        coords = coords * 0.5;
    }
}
