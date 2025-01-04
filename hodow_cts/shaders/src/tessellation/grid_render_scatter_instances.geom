#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles, invocations = 4) in;
layout(triangle_strip, max_vertices = 16) out;

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

    // Scatter slices
    int inputTriangleNdx = gl_InvocationID * 2 + ((isBottomTriangle) ? (1) : (0));
    ivec2 srcSliceNdx = ivec2(gridPosition.x, gridPosition.y * 8 + inputTriangleNdx);
    ivec2 dstSliceNdx = ivec2(7 * srcSliceNdx.x, 127 * srcSliceNdx.y) % ivec2(5, 5 * 8);

    // Draw slice to the dstSlice slot
    vec4 outputSliceArea;
    outputSliceArea.x = float(dstSliceNdx.x)   / float(5) * 2.0 - 1.0 - gapOffset;
    outputSliceArea.y = float(dstSliceNdx.y)   / float(40) * 2.0 - 1.0 - gapOffset;
    outputSliceArea.z = float(dstSliceNdx.x+1) / float(5) * 2.0 - 1.0 + gapOffset;
    outputSliceArea.w = float(dstSliceNdx.y+1) / float(40) * 2.0 - 1.0 + gapOffset;

    // Draw slice
    for (int ndx = 0; ndx < 8; ++ndx)
    {
        vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
        vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
        vec4 outputColor = (((gl_InvocationID + ndx) % 2) == 0) ? (green) : (yellow);
        float xpos = mix(outputSliceArea.x, outputSliceArea.z, float(ndx) / float(7));

        gl_Position = vec4(xpos, outputSliceArea.y, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();

        gl_Position = vec4(xpos, outputSliceArea.w, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();
    }
}
