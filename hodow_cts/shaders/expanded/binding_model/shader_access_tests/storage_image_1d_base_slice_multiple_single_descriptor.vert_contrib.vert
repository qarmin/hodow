#version 440
layout(set = 0, binding = 0, rgba8) readonly uniform highp image1D u_image0;
layout(set = 1, binding = 0, rgba8) readonly uniform highp image1D u_image1;
layout(location = 0) out mediump vec4 frag_color;
layout(location = 1) flat out highp int frag_quadrant_id;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    highp vec4 result_position;
    highp int quadrant_id;
    highp int quadPhase = gl_VertexIndex % 6;
    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);
    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);
    highp int quadOriginX = (gl_VertexIndex / 6) % 2;
    highp int quadOriginY = (gl_VertexIndex / 6) / 2;
    quadrant_id = gl_VertexIndex / 6;
    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);
    gl_Position = result_position;
	frag_quadrant_id = quadrant_id;

    highp vec4 result_color;
    result_color = vec4(0.0);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image0, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image0, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image0, 42);
    else
        result_color += imageLoad(u_image0, 25);
    if (quadrant_id == 0)
        result_color += imageLoad(u_image1, 6);
    else if (quadrant_id == 1)
        result_color += imageLoad(u_image1, 51);
    else if (quadrant_id == 2)
        result_color += imageLoad(u_image1, 42);
    else
        result_color += imageLoad(u_image1, 25);
    result_color /= vec4(2.0);
    frag_color = result_color;
}
