#version 450
void main ()
{
    const uint width = 64;
    const uint height = 64;
    const uint uVertexIndex = uint(gl_VertexIndex);
    const uint triangleId = uVertexIndex / 3u;
    const uint vertId = uVertexIndex % 3u;
    const uint rowId = triangleId / width;
    const uint colId = triangleId % width;
    const float fWidth = float(width);
    const float fHeight = float(height);
    const float xPixelCoord = (float(colId) + 0.5) / fWidth * 2.0 - 1.0;
    const float yPixelCoord = (float(rowId) + 0.5) / fHeight * 2.0 - 1.0;
    const float quarterPixelWidth = (2.0 / fWidth) / 4.0;
    const float quarterPixelHeight = (2.0 / fHeight) / 4.0;
    const vec2 bottomLeft = vec2(xPixelCoord - quarterPixelWidth, yPixelCoord + quarterPixelHeight);
    const vec2 bottomRight = vec2(xPixelCoord + quarterPixelWidth, yPixelCoord + quarterPixelHeight);
    const vec2 topCenter = vec2(xPixelCoord, yPixelCoord - quarterPixelHeight);
    const vec2 cwCoords[3] = vec2[](bottomLeft, topCenter, bottomRight);
    const vec2 ccwCoords[3] = vec2[](bottomLeft, bottomRight, topCenter);
    // Half the triangles will be culled.
    const bool counterClockWise = ((triangleId % 2u) == 0u);
    vec2 pointCoords;
    if (counterClockWise) { pointCoords = ccwCoords[vertId]; }
    else                  { pointCoords = cwCoords[vertId]; }
    gl_Position = vec4(pointCoords, 0.0, 1.0);
}
