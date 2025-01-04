#version 460
layout (triangles, fractional_odd_spacing, ccw) in;
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
    const vec4 p3 = gl_in[3].gl_Position;
    // We have a patch with 4 corners (v0,v1,v2,v3), but triangle-based tessellation.
    // Lets suppose the triangle covers half the patch (triangle v0,v2,v1).
    // Expand the triangle by virtually grabbing it from the midpoint between v1 and v2 (which should fall in the middle of the patch) and stretching that point to the fourth corner (v3).
    const vec4 origpoint = (gl_TessCoord.x * p0) +
                           (gl_TessCoord.y * p2) +
                           (gl_TessCoord.z * p1);
    const vec4 midpoint = 0.5 * p1 + 0.5 * p2;

    // Find out if it falls on left or right side of the triangle.
    vec4 halfTriangle[3];
    vec4 stretchedHalf[3];

    if (gl_TessCoord.z >= gl_TessCoord.y)
    {
        halfTriangle[0] = p0;
        halfTriangle[1] = midpoint;
        halfTriangle[2] = p1;

        stretchedHalf[0] = p0;
        stretchedHalf[1] = p3;
        stretchedHalf[2] = p1;
    }
    else
    {
        halfTriangle[0] = p0;
        halfTriangle[1] = p2;
        halfTriangle[2] = midpoint;

        stretchedHalf[0] = p0;
        stretchedHalf[1] = p2;
        stretchedHalf[2] = p3;
    }

    // Calculate the barycentric coordinates for the left or right sides.
    vec3 sideBaryCoord = calcBaryCoords(origpoint.xy, halfTriangle[0].xy, halfTriangle[1].xy, halfTriangle[2].xy);

    // Move the point by stretching the half triangle and dragging the midpoint vertex to v3.
    gl_Position = sideBaryCoord.x * stretchedHalf[0] + sideBaryCoord.y * stretchedHalf[1] + sideBaryCoord.z * stretchedHalf[2];
}
