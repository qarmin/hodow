#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles, invocations = 4) in;
layout(triangle_strip, max_vertices = 112) out;

layout(location = 0) in       mediump ivec2 v_tessellationGridPosition[];
layout(location = 0) flat out highp   vec4  v_color;

void main (void)
{
    const float equalThreshold = 0.001;
    const float gapOffset = 0.0001; // subdivision performed by the geometry shader might produce gaps. Fill potential gaps by enlarging the output slice a little.

    // Input triangle is generated from an axis-aligned rectangle by splitting it in half
    // Original rectangle can be found by finding the bounding AABB of the triangle
    vec4 aabb = vec4(min(gl_in[0].gl_Position.x, min(gl_in[1].gl_Position.x, gl_in[2].gl_Position.x)),
                     min(gl_in[0].gl_Position.y, min(gl_in[1].gl_Position.y, gl_in[2].gl_Position.y)),
                     max(gl_in[0].gl_Position.x, max(gl_in[1].gl_Position.x, gl_in[2].gl_Position.x)),
                     max(gl_in[0].gl_Position.y, max(gl_in[1].gl_Position.y, gl_in[2].gl_Position.y)));

    // Location in tessellation grid
    ivec2 gridPosition = ivec2(min(v_tessellationGridPosition[0], min(v_tessellationGridPosition[1], v_tessellationGridPosition[2])));

    // Which triangle of the two that split the grid cell
    int numVerticesOnBottomEdge = 0;
    for (int ndx = 0; ndx < 3; ++ndx)
        if (abs(gl_in[ndx].gl_Position.y - aabb.w) < equalThreshold)
            ++numVerticesOnBottomEdge;
    bool isBottomTriangle = numVerticesOnBottomEdge == 2;

    // Fill the input area with slices
    // Upper triangle produces slices only to the upper half of the quad and vice-versa
    float triangleOffset = (isBottomTriangle) ? ((aabb.w + aabb.y) / 2.0) : (aabb.y);
    // Each slice is a invocation
    float sliceHeight = (aabb.w - aabb.y) / float(2 * 4);
    float invocationOffset = float(gl_InvocationID) * sliceHeight;

    vec4 outputSliceArea;
    outputSliceArea.x = aabb.x - gapOffset;
    outputSliceArea.y = triangleOffset + invocationOffset - gapOffset;
    outputSliceArea.z = aabb.z + gapOffset;
    outputSliceArea.w = triangleOffset + invocationOffset + sliceHeight + gapOffset;

    // Draw slice
    for (int ndx = 0; ndx < 56; ++ndx)
    {
        vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
        vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
        vec4 outputColor = (((gl_InvocationID + ndx) % 2) == 0) ? (green) : (yellow);
        float xpos = mix(outputSliceArea.x, outputSliceArea.z, float(ndx) / float(55));

        gl_Position = vec4(xpos, outputSliceArea.y, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();

        gl_Position = vec4(xpos, outputSliceArea.w, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();
    }
}
