#version 460
layout (quads, fractional_odd_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};

// This assumes 2D, calculates barycentrics for point p inside triangle (a, b, c)
vec3 calcBaryCoords(vec2 p, vec2 a, vec2 b, vec2 c)
{
    const vec2 v0 = b - a;
    const vec2 v1 = c - a;
    const vec2 v2 = p - a;

    const float den = v0.x * v1.y - v1.x * v0.y;
    const float v   = (v2.x * v1.y - v1.x * v2.y) / den;
    const float w   = (v0.x * v2.y - v2.x * v0.y) / den;
    const float u   = 1.0 - v - w;

    return vec3(u, v, w);
}

void main() {
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const float delta  = 0.75;
    const float width  = p2.x - p0.x;
    const float height = p1.y - p0.y;
    const vec4 p3 = vec4(p0.x + width * delta, p0.y + height * delta, p0.z, p0.w);
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3;
}
