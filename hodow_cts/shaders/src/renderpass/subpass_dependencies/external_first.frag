#version 450
layout(location = 0) in highp vec2 vtxTexCoords;
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    if (gl_FragCoord.x <= ${half_w} && gl_FragCoord.y <= ${half_h})
        o_color = vec4(1.0, 0.0, 0.0, 1.0);
    else if (gl_FragCoord.x > ${half_w} && gl_FragCoord.y <= ${half_h})
        o_color = vec4(0.0, 1.0, 0.0, 1.0);
    else if (gl_FragCoord.x <= ${half_w} && gl_FragCoord.y > ${half_h})
        o_color = vec4(0.0, 0.0, 1.0, 1.0);
    else
        o_color = vec4(0.0, 0.0, 0.0, 1.0);
}
