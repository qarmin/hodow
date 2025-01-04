#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

    if (okCount == 3)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(3), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.000031 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

    if (okCount == 1)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(1), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec4 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - clamp(4.0 * float(gl_InstanceIndex) + 0.0, 0, 1023.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[1] - clamp(4.0 * float(gl_InstanceIndex) + 1.0, 0, 1023.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[2] - clamp(4.0 * float(gl_InstanceIndex) + 2.0, 0, 1023.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[3] - clamp(4.0 * float(gl_InstanceIndex) + 3.0, 0, 3.000000)) < 0.001000)
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in mat3 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr0[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr0[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr0[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr0[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr0[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in mat3 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] + (9.0 * float(gl_VertexIndex) + 0.0)) < 0.001000)
		okCount++;

	if (abs(attr0[0][1] + (9.0 * float(gl_VertexIndex) + 1.0)) < 0.001000)
		okCount++;

	if (abs(attr0[0][2] + (9.0 * float(gl_VertexIndex) + 2.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][0] + (9.0 * float(gl_VertexIndex) + 3.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][1] + (9.0 * float(gl_VertexIndex) + 4.0)) < 0.001000)
		okCount++;

	if (abs(attr0[1][2] + (9.0 * float(gl_VertexIndex) + 5.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][0] + (9.0 * float(gl_VertexIndex) + 6.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][1] + (9.0 * float(gl_VertexIndex) + 7.0)) < 0.001000)
		okCount++;

	if (abs(attr0[2][2] + (9.0 * float(gl_VertexIndex) + 8.0)) < 0.001000)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in mat4 attr0;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0][0] + clamp(16.0 * float(gl_InstanceIndex) + 0.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[0][1] + clamp(16.0 * float(gl_InstanceIndex) + 1.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[0][2] + clamp(16.0 * float(gl_InstanceIndex) + 2.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[0][3] + clamp(16.0 * float(gl_InstanceIndex) + 3.0, -2.000000, 1.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[1][0] + clamp(16.0 * float(gl_InstanceIndex) + 4.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[1][1] + clamp(16.0 * float(gl_InstanceIndex) + 5.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[1][2] + clamp(16.0 * float(gl_InstanceIndex) + 6.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[1][3] + clamp(16.0 * float(gl_InstanceIndex) + 7.0, -2.000000, 1.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[2][0] + clamp(16.0 * float(gl_InstanceIndex) + 8.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[2][1] + clamp(16.0 * float(gl_InstanceIndex) + 9.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[2][2] + clamp(16.0 * float(gl_InstanceIndex) + 10.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[2][3] + clamp(16.0 * float(gl_InstanceIndex) + 11.0, -2.000000, 1.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[3][0] + clamp(16.0 * float(gl_InstanceIndex) + 12.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[3][1] + clamp(16.0 * float(gl_InstanceIndex) + 13.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[3][2] + clamp(16.0 * float(gl_InstanceIndex) + 14.0, -512.000000, 511.000000)) < 0.001000)
		okCount++;

	if (abs(attr0[3][3] + clamp(16.0 * float(gl_InstanceIndex) + 15.0, -2.000000, 1.000000)) < 0.001000)
		okCount++;

    if (okCount == 16)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(16), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 1) in ivec3 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 20)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(20), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 1) in ivec4 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in ivec4 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 15)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(15), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 12)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(12), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0][0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 23)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(23), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 20)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(20), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in float attr1;
layout(location = 2) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 3)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(3), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in f16vec2 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.011811)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000010)
		okCount++;

    if (okCount == 15)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(15), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in f16vec3 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 22)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(22), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in mat3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 28)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(28), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in mat2 attr1;
layout(location = 3) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 17)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(17), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 1) in f16vec3 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float16_t attr0;
layout(location = 1) in f16vec2 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 1) in float attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in uint attr1;
layout(location = 2) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

    if (okCount == 16)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(16), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000023)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in float attr1;
layout(location = 2) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 20)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(20), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in f16vec2 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000010)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in uvec4 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.011811)
		okCount++;

    if (okCount == 23)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(23), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in float attr1;
layout(location = 2) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 15)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(15), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 1) in f16vec2 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr0[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 1) in float attr1;
layout(location = 2) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 1) in f16vec4 attr1;
layout(location = 2) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 1) in uint attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000010)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in uvec3 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000023)
		okCount++;

    if (okCount == 20)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(20), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in float attr1;
layout(location = 2) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in float attr1;
layout(location = 2) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 1) in f16vec4 attr1;
layout(location = 2) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 1) in vec4 attr1;
layout(location = 2) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 1) in vec2 attr1;
layout(location = 2) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 1) in vec3 attr1;
layout(location = 2) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 1) in float16_t attr1;
layout(location = 2) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr0[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

    if (okCount == 12)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(12), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float16_t attr0;
layout(location = 1) in mat3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 26)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(26), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in ivec2 attr1;
layout(location = 1) in float attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in ivec4 attr1;
layout(location = 1) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in float attr1;
layout(location = 1) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 3)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(3), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in float attr1;
layout(location = 1) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in ivec3 attr1;
layout(location = 1) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 4) in ivec3 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 14)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(14), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 4) in float attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 12)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(12), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 3) in f16vec2 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in ivec4 attr1;
layout(location = 1) in uvec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr2[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uint attr1;
layout(location = 1) in uvec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr2[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uint attr1;
layout(location = 1) in uvec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr2[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr2[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 3) in vec2 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 4) in float16_t attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 16)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(16), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uint attr1;
layout(location = 1) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 5) in mat3 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 29)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(29), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 1) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0] - (0.000015 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in vec2 attr1;
layout(location = 1) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 3) in vec4 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 4) in float16_t attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 5) in float16_t attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.001000)
		okCount++;

    if (okCount == 20)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(20), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 1) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 5) in f16vec3 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000010)
		okCount++;

    if (okCount == 23)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(23), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 4) in f16vec4 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

    if (okCount == 17)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(17), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 3) in f16vec2 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.000031 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr0[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr0[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec4 attr0;
layout(location = 5) in mat3 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr0[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr0[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr0[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000023)
		okCount++;

    if (okCount == 29)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(29), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float16_t attr0;
layout(location = 5) in mat2 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.001000)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 1) in float attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 4) in vec3 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 1) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 1) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec2 attr1;
layout(location = 1) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 5) in uvec2 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 5) in f16vec4 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.001000)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 4) in mat2 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 16)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(16), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 4) in vec3 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000010)
		okCount++;

    if (okCount == 16)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(16), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 3) in f16vec3 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 5) in vec2 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec4 attr0;
layout(location = 5) in mat3 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr0[1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr0[2] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr0[3] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][0] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][1] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2][2] - (0.000015 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 29)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(29), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec2 attr0;
layout(location = 4) in f16vec4 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000010)
		okCount++;

    if (okCount == 15)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(15), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in ivec3 attr1;
layout(location = 1) in float attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2 - (0.003922 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 1) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 3) in f16vec3 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 5) in vec2 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.011811)
		okCount++;

    if (okCount == 20)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(20), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 4) in uvec2 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 14)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(14), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 4) in float attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in float attr1;
layout(location = 1) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 4) in uvec3 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 14)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(14), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 3) in vec2 attr1;
layout(location = 1) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 1) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 1) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in float attr1;
layout(location = 1) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.000031 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 4) in f16vec3 attr1;
layout(location = 1) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 5) in vec3 attr1;
layout(location = 1) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 1) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr0[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec4 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 1) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr0[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr0[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in ivec2 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000023)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in ivec4 attr1;
layout(location = 4) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in ivec4 attr1;
layout(location = 4) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 4) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 4) in vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] + (0.01 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uint attr1;
layout(location = 4) in uvec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr2[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uint attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in mat2 attr1;
layout(location = 5) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 15)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(15), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uint attr1;
layout(location = 4) in uvec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr2[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in f16vec4 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][0] - (0.000015 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][1] - (0.000015 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][2] - (0.000015 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3][3] - (0.000015 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000023)
		okCount++;

    if (okCount == 23)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(23), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uvec2 attr1;
layout(location = 4) in uvec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1[0] == uint(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_InstanceIndex + 1))
		okCount++;

	if (attr2[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr2[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr2[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr2[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in f16vec4 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 12)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(12), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 4) in vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 5)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(5), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.000031 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000010)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000010)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000010)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr0[1] - (-1.0 + 0.007874 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr0[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000010)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in mat3 attr1;
layout(location = 6) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr0[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.001000)
		okCount++;

    if (okCount == 27)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(27), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in mat3 attr1;
layout(location = 6) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.000015 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr0[1] - (0.000015 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr0[2] - (0.000015 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.001000)
		okCount++;

    if (okCount == 28)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(28), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float16_t attr0;
layout(location = 2) in f16vec4 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.011811)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec2 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in float attr1;
layout(location = 4) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in uint attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (attr1 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

    if (okCount == 12)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(12), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 - (-1.0 + 0.007874 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[2] - (0.000015 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.001000)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in f16vec4 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in mat3 attr1;
layout(location = 6) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.000031 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0][0] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0][1] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0][2] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1][0] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1][1] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1][2] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2][0] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2][1] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2][2] - (-1.0 + 0.000031 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 26)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(26), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.003922 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr0[1] - (0.003922 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr0[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in float16_t attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1] - (-1.0 + 0.000031 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float16_t attr0;
layout(location = 2) in f16vec2 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in f16vec2 attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr0[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 21)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(21), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in int attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec2 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.000046)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.000046)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.000031 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.000046)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1[0] + (0.01 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[3] + (0.01 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.011811)
		okCount++;

    if (okCount == 23)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(23), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in ivec4 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == -(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == -(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == -(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == -(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in uvec3 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.000031 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000046)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 4) in float attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

    if (okCount == 6)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(6), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0] - (0.000015 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1] - (0.000015 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2] - (0.000015 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[3] - (0.000015 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

    if (okCount == 8)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(8), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uint attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr1[0] + (0.01 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1] + (0.01 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2] + (0.01 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in uvec4 attr1;
layout(location = 4) in mat2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (attr1[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr1[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr1[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr1[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in f16vec2 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 7)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(7), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec2 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec3 attr0;
layout(location = 2) in float attr1;
layout(location = 4) in mat3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr1 - (0.003922 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2[0][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 4.0))) < 0.000023)
		okCount++;

	if (abs(attr2[1][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 5.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][0] - (0.000015 * (9.0 * float(gl_VertexIndex) + 6.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][1] - (0.000015 * (9.0 * float(gl_VertexIndex) + 7.0))) < 0.000023)
		okCount++;

	if (abs(attr2[2][2] - (0.000015 * (9.0 * float(gl_VertexIndex) + 8.0))) < 0.000023)
		okCount++;

    if (okCount == 13)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(13), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec3 attr1;
layout(location = 4) in vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr2[0] + (0.01 * (4.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1] + (0.01 * (4.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2] + (0.01 * (4.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3] + (0.01 * (4.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

    if (okCount == 11)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(11), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in uvec4 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (attr0[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr0[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr0[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr0[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr1[0] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[1] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr1[2] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr1[3] - (-1.0 + 0.007874 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr2[1][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.001000)
		okCount++;

	if (abs(attr2[2][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][0] + (0.01 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][1] + (0.01 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][2] + (0.01 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.001000)
		okCount++;

	if (abs(attr2[3][3] + (0.01 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.001000)
		okCount++;

    if (okCount == 24)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(24), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in float16_t attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr1[1] - (0.000015 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr2 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 4)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(4), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec2 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 + (0.01 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0] + (0.01 * (2.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr1[1] + (0.01 * (2.0 * float(gl_InstanceIndex) + 1.0))) < 0.000010)
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 19)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(19), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 9)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(9), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 2) in f16vec3 attr1;
layout(location = 4) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (-1.0 + 0.007874 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr1[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr1[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[0][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.005882)
		okCount++;

	if (abs(attr2[1][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.005882)
		okCount++;

	if (abs(attr2[2][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][0] - (0.003922 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][1] - (0.003922 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][2] - (0.003922 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.005882)
		okCount++;

	if (abs(attr2[3][3] - (0.003922 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.005882)
		okCount++;

    if (okCount == 20)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(20), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec2 attr0;
layout(location = 2) in mat3 attr1;
layout(location = 6) in mat4 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] + (0.01 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr0[1] + (0.01 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 0.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 1.0))) < 0.001000)
		okCount++;

	if (abs(attr1[0][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 2.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 3.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 4.0))) < 0.001000)
		okCount++;

	if (abs(attr1[1][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 5.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][0] + (0.01 * (9.0 * float(gl_InstanceIndex) + 6.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][1] + (0.01 * (9.0 * float(gl_InstanceIndex) + 7.0))) < 0.001000)
		okCount++;

	if (abs(attr1[2][2] + (0.01 * (9.0 * float(gl_InstanceIndex) + 8.0))) < 0.001000)
		okCount++;

	if (abs(attr2[0][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 0.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 1.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 2.0))) < 0.011811)
		okCount++;

	if (abs(attr2[0][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 3.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 4.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 5.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 6.0))) < 0.011811)
		okCount++;

	if (abs(attr2[1][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 7.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 8.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 9.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 10.0))) < 0.011811)
		okCount++;

	if (abs(attr2[2][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 11.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][0] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 12.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][1] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 13.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][2] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 14.0))) < 0.011811)
		okCount++;

	if (abs(attr2[3][3] - (-1.0 + 0.007874 * (16.0 * float(gl_VertexIndex) + 15.0))) < 0.011811)
		okCount++;

    if (okCount == 27)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(27), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in vec3 attr0;
layout(location = 2) in vec4 attr1;
layout(location = 4) in f16vec3 attr2;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0[0] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr0[1] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr0[2] - (-1.0 + 0.000031 * (3.0 * float(gl_VertexIndex) + 2.0))) < 0.000046)
		okCount++;

	if (abs(attr1[0] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.005882)
		okCount++;

	if (abs(attr1[1] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.005882)
		okCount++;

	if (abs(attr1[2] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.005882)
		okCount++;

	if (abs(attr1[3] - (0.003922 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.005882)
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

    if (okCount == 10)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(10), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(constant_id = 0) const int numAttributes = 16;
layout(location = 0) in float attr0;
layout(location = 1) in uvec2 attr1;
layout(location = 2) in f16vec3 attr2;
layout(location = 3) in ivec3 attr3;
layout(location = 4) in float16_t attr4;
layout(location = 5) in float16_t attr5;
layout(location = 6) in uvec4 attr6;
layout(location = 7) in uvec4 attr7;
layout(location = 8) in float16_t attr8;
layout(location = 9) in uint attr9;
layout(location = 10) in vec4 attr10;
layout(location = 11) in uvec3 attr11;
layout(location = 12) in uint attr12;
layout(location = 13) in f16vec2 attr13;
layout(location = 14) in f16vec2 attr14;
layout(location = 15) in f16vec4 attr15;
layout(location = 16) in float attr16;
layout(location = 17) in float16_t attr17;
layout(location = 18) in vec3 attr18;
layout(location = 19) in uint attr19;
layout(location = 20) in ivec2 attr20;
layout(location = 21) in float attr21;
layout(location = 22) in f16vec4 attr22;
layout(location = 23) in int attr23;
layout(location = 24) in ivec4 attr24;
layout(location = 25) in f16vec4 attr25;
layout(location = 26) in uint attr26;
layout(location = 27) in uvec2 attr27;
layout(location = 28) in vec4 attr28;
layout(location = 29) in vec2 attr29;
layout(location = 30) in uvec3 attr30;
layout(location = 31) in uint attr31;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex {
  vec4 gl_Position;
};
void main (void)
{
    int okCount = 0;
	if (abs(attr0 - (0.000015 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (attr1[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr1[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr2[0] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[1] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr2[2] + float16_t(0.01HF * (3.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr3[0] == -(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr3[1] == -(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr3[2] == -(3 * gl_VertexIndex + 2))
		okCount++;

	if (abs(attr4 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr5 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr6[0] == uint(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr6[1] == uint(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr6[2] == uint(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr6[3] == uint(4 * gl_InstanceIndex + 3))
		okCount++;

	if (attr7[0] == uint(4 * gl_VertexIndex + 0))
		okCount++;

	if (attr7[1] == uint(4 * gl_VertexIndex + 1))
		okCount++;

	if (attr7[2] == uint(4 * gl_VertexIndex + 2))
		okCount++;

	if (attr7[3] == uint(4 * gl_VertexIndex + 3))
		okCount++;

	if (abs(attr8 + float16_t(0.01HF * (1.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr9 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (abs(attr10[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr10[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr10[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr10[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (attr11[0] == uint(3 * gl_VertexIndex + 0))
		okCount++;

	if (attr11[1] == uint(3 * gl_VertexIndex + 1))
		okCount++;

	if (attr11[2] == uint(3 * gl_VertexIndex + 2))
		okCount++;

	if (attr12 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (abs(attr13[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr13[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr14[0] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr14[1] + float16_t(0.01HF * (2.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr15[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr16 + (0.01 * (1.0 * float(gl_InstanceIndex) + 0.0))) < 0.000010)
		okCount++;

	if (abs(attr17 + float16_t(0.01HF * (1.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr18[0] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 0.0))) < 0.000046)
		okCount++;

	if (abs(attr18[1] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 1.0))) < 0.000046)
		okCount++;

	if (abs(attr18[2] - (-1.0 + 0.000031 * (3.0 * float(gl_InstanceIndex) + 2.0))) < 0.000046)
		okCount++;

	if (attr19 == uint(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr20[0] == -(2 * gl_InstanceIndex + 0))
		okCount++;

	if (attr20[1] == -(2 * gl_InstanceIndex + 1))
		okCount++;

	if (abs(attr21 - (0.000015 * (1.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr22[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr22[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_InstanceIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr23 == -(1 * gl_VertexIndex + 0))
		okCount++;

	if (attr24[0] == -(4 * gl_InstanceIndex + 0))
		okCount++;

	if (attr24[1] == -(4 * gl_InstanceIndex + 1))
		okCount++;

	if (attr24[2] == -(4 * gl_InstanceIndex + 2))
		okCount++;

	if (attr24[3] == -(4 * gl_InstanceIndex + 3))
		okCount++;

	if (abs(attr25[0] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 0.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr25[1] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 1.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr25[2] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 2.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (abs(attr25[3] + float16_t(0.01HF * (4.0HF * float16_t(gl_VertexIndex) + 3.0HF))) < float16_t(0.001000HF))
		okCount++;

	if (attr26 == uint(1 * gl_InstanceIndex + 0))
		okCount++;

	if (attr27[0] == uint(2 * gl_VertexIndex + 0))
		okCount++;

	if (attr27[1] == uint(2 * gl_VertexIndex + 1))
		okCount++;

	if (abs(attr28[0] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr28[1] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 1.0))) < 0.000023)
		okCount++;

	if (abs(attr28[2] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 2.0))) < 0.000023)
		okCount++;

	if (abs(attr28[3] - (0.000015 * (4.0 * float(gl_InstanceIndex) + 3.0))) < 0.000023)
		okCount++;

	if (abs(attr29[0] - (0.000015 * (2.0 * float(gl_VertexIndex) + 0.0))) < 0.000023)
		okCount++;

	if (abs(attr29[1] - (0.000015 * (2.0 * float(gl_VertexIndex) + 1.0))) < 0.000023)
		okCount++;

	if (attr30[0] == uint(3 * gl_InstanceIndex + 0))
		okCount++;

	if (attr30[1] == uint(3 * gl_InstanceIndex + 1))
		okCount++;

	if (attr30[2] == uint(3 * gl_InstanceIndex + 2))
		okCount++;

	if (attr31 == uint(1 * gl_VertexIndex + 0))
		okCount++;

    if (okCount == 72)
    {
        if (gl_InstanceIndex == 0)
            vtxColor = vec4(1.0, 0.0, 0.0, 1.0);
        else
            vtxColor = vec4(0.0, 0.0, 1.0, 1.0);
    }
    else
    {
        vtxColor = vec4(okCount / float(72), 0.0f, 0.0f, 1.0);
    }

    if (gl_InstanceIndex == 0)
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
    else
    {
        if (gl_VertexIndex == 0) gl_Position = vec4(0.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 1) gl_Position = vec4(1.0, -1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 2) gl_Position = vec4(0.0, 1.0, 0.0, 1.0);
        else if (gl_VertexIndex == 3) gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
        else gl_Position = vec4(0.0);
    }
}
