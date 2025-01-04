#version 310 es

void main (void)
{
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
layout(location = 0) flat in highp   vec4 v_color;
layout(location = 0) out     mediump vec4 fragColor;

void main (void)
{
    fragColor = v_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices = 1) out;

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_TessLevelInner[0] = float(64);
    gl_TessLevelInner[1] = float(64);
    gl_TessLevelOuter[0] = float(64);
    gl_TessLevelOuter[1] = float(64);
    gl_TessLevelOuter[2] = float(64);
    gl_TessLevelOuter[3] = float(64);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(quads) in;

layout(location = 0) out mediump ivec2 v_tessellationGridPosition;

// note: No need to use precise gl_Position since position does not depend on order
void main (void)
{
    // Fill the whole viewport
    gl_Position = vec4(gl_TessCoord.x * 2.0 - 1.0, gl_TessCoord.y * 2.0 - 1.0, 0.0, 1.0);
    // Calculate position in tessellation grid
    v_tessellationGridPosition = ivec2(round(gl_TessCoord.xy * float(64)));
}
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
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(vertices = 1) out;

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_TessLevelInner[0] = float(5);
    gl_TessLevelInner[1] = float(5);
    gl_TessLevelOuter[0] = float(5);
    gl_TessLevelOuter[1] = float(5);
    gl_TessLevelOuter[2] = float(5);
    gl_TessLevelOuter[3] = float(5);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(quads) in;

layout(location = 0) out mediump ivec2 v_tessellationGridPosition;

// note: No need to use precise gl_Position since position does not depend on order
void main (void)
{
    // Fill the whole viewport
    gl_Position = vec4(gl_TessCoord.x * 2.0 - 1.0, gl_TessCoord.y * 2.0 - 1.0, 0.0, 1.0);
    // Calculate position in tessellation grid
    v_tessellationGridPosition = ivec2(round(gl_TessCoord.xy * float(5)));
}
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
#version 310 es
#extension GL_EXT_geometry_shader : require
layout(triangles, invocations = 32) in;
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

    // Fill the input area with slices
    // Upper triangle produces slices only to the upper half of the quad and vice-versa
    float triangleOffset = (isBottomTriangle) ? ((aabb.w + aabb.y) / 2.0) : (aabb.y);
    // Each slice is a invocation
    float sliceHeight = (aabb.w - aabb.y) / float(2 * 32);
    float invocationOffset = float(gl_InvocationID) * sliceHeight;

    vec4 outputSliceArea;
    outputSliceArea.x = aabb.x - gapOffset;
    outputSliceArea.y = triangleOffset + invocationOffset - gapOffset;
    outputSliceArea.z = aabb.z + gapOffset;
    outputSliceArea.w = triangleOffset + invocationOffset + sliceHeight + gapOffset;

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

    // Draw grid cells
    int inputTriangleNdx = gl_InvocationID * 2 + ((isBottomTriangle) ? (1) : (0));
    for (int ndx = 0; ndx < 4; ++ndx)
    {
        ivec2 dstGridSize = ivec2(5 * 4, 2 * 5 * 4);
        ivec2 dstGridNdx = ivec2(5 * ndx + gridPosition.x, 5 * inputTriangleNdx + 2 * gridPosition.y + ndx * 127) % dstGridSize;
        vec4 dstArea;
        dstArea.x = float(dstGridNdx.x)   / float(dstGridSize.x) * 2.0 - 1.0 - gapOffset;
        dstArea.y = float(dstGridNdx.y)   / float(dstGridSize.y) * 2.0 - 1.0 - gapOffset;
        dstArea.z = float(dstGridNdx.x+1) / float(dstGridSize.x) * 2.0 - 1.0 + gapOffset;
        dstArea.w = float(dstGridNdx.y+1) / float(dstGridSize.y) * 2.0 - 1.0 + gapOffset;

        vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
        vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);
        vec4 outputColor = (((dstGridNdx.y + dstGridNdx.x) % 2) == 0) ? (green) : (yellow);

        gl_Position = vec4(dstArea.x, dstArea.y, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();

        gl_Position = vec4(dstArea.x, dstArea.w, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();

        gl_Position = vec4(dstArea.z, dstArea.y, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();

        gl_Position = vec4(dstArea.z, dstArea.w, 0.0, 1.0);
        v_color = outputColor;
        EmitVertex();
        EndPrimitive();
    }
}
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
