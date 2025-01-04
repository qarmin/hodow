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

    // Draw grid cells, send each primitive to a separate layer
    int baseLayer = gl_InvocationID * 2 + ((isBottomTriangle) ? (1) : (0));
    for (int ndx = 0; ndx < 4; ++ndx)
    {
        ivec2 dstGridSize = ivec2(5 * 4, 5);
        ivec2 dstGridNdx = ivec2((gridPosition.x * 4 * 7 + ndx)*13, (gridPosition.y * 127 + ndx) * 19) % dstGridSize;
        vec4 dstArea;
        dstArea.x = float(dstGridNdx.x) / float(dstGridSize.x) * 2.0 - 1.0 - gapOffset;
        dstArea.y = float(dstGridNdx.y) / float(dstGridSize.y) * 2.0 - 1.0 - gapOffset;
        dstArea.z = float(dstGridNdx.x+1) / float(dstGridSize.x) * 2.0 - 1.0 + gapOffset;
        dstArea.w = float(dstGridNdx.y+1) / float(dstGridSize.y) * 2.0 - 1.0 + gapOffset;

        vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
        vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
        vec4 outputColor = (((dstGridNdx.y + dstGridNdx.x) % 2) == 0) ? (green) : (yellow);

        gl_Position = vec4(dstArea.x, dstArea.y, 0.0, 1.0);
        v_color = outputColor;
        gl_Layer = ((baseLayer + ndx) * 11) % 8;
        EmitVertex();

        gl_Position = vec4(dstArea.x, dstArea.w, 0.0, 1.0);
        v_color = outputColor;
        gl_Layer = ((baseLayer + ndx) * 11) % 8;
        EmitVertex();

        gl_Position = vec4(dstArea.z, dstArea.y, 0.0, 1.0);
        v_color = outputColor;
        gl_Layer = ((baseLayer + ndx) * 11) % 8;
        EmitVertex();

        gl_Position = vec4(dstArea.z, dstArea.w, 0.0, 1.0);
        v_color = outputColor;
        gl_Layer = ((baseLayer + ndx) * 11) % 8;
        EmitVertex();
        EndPrimitive();
    }
}
