#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };
layout(location = 0) out mediump vec4 var[4];

void main()
{
    gl_Position = a_position;
    var[ui_zero]  = vec4(a_coords);
    var[ui_one]   = vec4(a_coords) * 0.5;
    var[ui_two]   = vec4(a_coords) * 0.25;
    var[ui_three] = vec4(a_coords) * 0.125;
}
